#!/usr/bin/env node
// Annotate a PNG screenshot: crop it, draw highlight boxes and bold arrows.
// Zero dependencies (Node >= 18, built-in zlib), so it runs the same on Windows, macOS and Linux.
//
// All coordinates are in SOURCE image pixels (before --crop); the crop is applied last.
//
//   node annotate.mjs <in.png> <out.png> [options]
//
//   --crop x,y,w,h              Keep only this region of the image.
//   --box x,y,w,h               Rounded highlight box (repeatable). The stroke is centred on this rectangle.
//   --arrow x1,y1,x2,y2         Bold arrow from tail (x1,y1) to tip (x2,y2) (repeatable).
//   --arrow-to-box side[:len[:offset]]
//                               Bold arrow pointing at the middle of the last --box's side
//                               (left|right|top|bottom). len defaults to 30% of the image width/height;
//                               offset slides the tip along that side (+ is down/right) to dodge content.
//   --color #RRGGBB             Annotation colour (default #06C4FF, Intent "Azure Blue").
//   --stroke n                  Box stroke width (default 3).   --radius n   Box corner radius (default 8).
//   --shaft n                   Arrow shaft thickness (default 14).
//   --head-width n              Arrow head width (default 44).  --head-length n   (default 38).
//   --gap n                     Space between an --arrow-to-box tip and the box (default 10).
//   --grid [step]               Write a coordinate grid over the image instead (default step 50),
//                               labelled every 100 px. Use it to read off coordinates; never publish it.

import { readFileSync, writeFileSync } from "node:fs";
import { inflateSync, deflateSync } from "node:zlib";

// ---------- PNG ----------

const CRC_TABLE = new Int32Array(256).map((_, n) => {
  let c = n;
  for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
  return c;
});
const crc32 = (buf) => {
  let c = -1;
  for (const b of buf) c = CRC_TABLE[(c ^ b) & 0xff] ^ (c >>> 8);
  return (c ^ -1) >>> 0;
};
const paeth = (a, b, c) => {
  const p = a + b - c, pa = Math.abs(p - a), pb = Math.abs(p - b), pc = Math.abs(p - c);
  return pa <= pb && pa <= pc ? a : pb <= pc ? b : c;
};

function decodePng(buf) {
  if (buf.readUInt32BE(0) !== 0x89504e47) throw new Error("Not a PNG file.");
  let pos = 8, width, height, depth, type, interlace, palette, trns;
  const idat = [];
  while (pos < buf.length) {
    const len = buf.readUInt32BE(pos), name = buf.toString("ascii", pos + 4, pos + 8);
    const data = buf.subarray(pos + 8, pos + 8 + len);
    if (name === "IHDR") {
      width = data.readUInt32BE(0); height = data.readUInt32BE(4);
      depth = data[8]; type = data[9]; interlace = data[12];
    } else if (name === "PLTE") palette = data;
    else if (name === "tRNS") trns = data;
    else if (name === "IDAT") idat.push(data);
    else if (name === "IEND") break;
    pos += 12 + len;
  }
  if (depth !== 8 || interlace !== 0 || ![0, 2, 3, 4, 6].includes(type))
    throw new Error(`Unsupported PNG (bit depth ${depth}, colour type ${type}, interlace ${interlace}). Re-save it as an 8-bit, non-interlaced PNG.`);
  const channels = { 0: 1, 2: 3, 3: 1, 4: 2, 6: 4 }[type];
  const stride = width * channels;
  const raw = inflateSync(Buffer.concat(idat));
  const px = new Uint8Array(stride * height);
  for (let y = 0; y < height; y++) {
    const f = raw[y * (stride + 1)], src = y * (stride + 1) + 1, row = y * stride, prev = row - stride;
    for (let i = 0; i < stride; i++) {
      const a = i >= channels ? px[row + i - channels] : 0;
      const b = y > 0 ? px[prev + i] : 0;
      const c = y > 0 && i >= channels ? px[prev + i - channels] : 0;
      const v = raw[src + i];
      px[row + i] = f === 0 ? v : f === 1 ? v + a : f === 2 ? v + b : f === 3 ? v + ((a + b) >> 1) : v + paeth(a, b, c);
    }
  }
  const out = new Uint8Array(width * height * 4);
  for (let p = 0; p < width * height; p++) {
    const s = p * channels, d = p * 4;
    if (type === 6) out.set(px.subarray(s, s + 4), d);
    else if (type === 2) { out.set(px.subarray(s, s + 3), d); out[d + 3] = 255; }
    else if (type === 0 || type === 4) { out[d] = out[d + 1] = out[d + 2] = px[s]; out[d + 3] = type === 4 ? px[s + 1] : 255; }
    else { const i = px[s]; out.set(palette.subarray(i * 3, i * 3 + 3), d); out[d + 3] = trns && i < trns.length ? trns[i] : 255; }
  }
  return { width, height, data: out };
}

function encodePng({ width, height, data }) {
  const stride = width * 4, raw = Buffer.alloc((stride + 1) * height);
  const cand = Array.from({ length: 5 }, () => Buffer.alloc(stride));
  for (let y = 0; y < height; y++) {
    const row = y * stride, prev = row - stride;
    let best = 0, bestSum = Infinity;
    for (let f = 0; f < 5; f++) {
      let sum = 0;
      for (let i = 0; i < stride; i++) {
        const a = i >= 4 ? data[row + i - 4] : 0, b = y > 0 ? data[prev + i] : 0, c = y > 0 && i >= 4 ? data[prev + i - 4] : 0;
        const v = (data[row + i] - (f === 0 ? 0 : f === 1 ? a : f === 2 ? b : f === 3 ? (a + b) >> 1 : paeth(a, b, c))) & 0xff;
        cand[f][i] = v; sum += v < 128 ? v : 256 - v;
      }
      if (sum < bestSum) { bestSum = sum; best = f; }
    }
    raw[y * (stride + 1)] = best;
    cand[best].copy(raw, y * (stride + 1) + 1);
  }
  const chunk = (name, body) => {
    const head = Buffer.alloc(8); head.writeUInt32BE(body.length, 0); head.write(name, 4, "ascii");
    const crc = Buffer.alloc(4); crc.writeUInt32BE(crc32(Buffer.concat([head.subarray(4), body])), 0);
    return Buffer.concat([head, body, crc]);
  };
  const ihdr = Buffer.alloc(13);
  ihdr.writeUInt32BE(width, 0); ihdr.writeUInt32BE(height, 4); ihdr[8] = 8; ihdr[9] = 6;
  return Buffer.concat([
    Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]),
    chunk("IHDR", ihdr), chunk("IDAT", deflateSync(raw, { level: 9 })), chunk("IEND", Buffer.alloc(0)),
  ]);
}

// ---------- drawing (signed-distance shapes, anti-aliased) ----------

const clamp01 = (v) => (v < 0 ? 0 : v > 1 ? 1 : v);

function blend(img, x, y, [r, g, b], a) {
  if (a <= 0 || x < 0 || y < 0 || x >= img.width || y >= img.height) return;
  const i = (y * img.width + x) * 4, d = img.data, da = d[i + 3] / 255, oa = a + da * (1 - a);
  d[i] = (r * a + d[i] * da * (1 - a)) / oa;
  d[i + 1] = (g * a + d[i + 1] * da * (1 - a)) / oa;
  d[i + 2] = (b * a + d[i + 2] * da * (1 - a)) / oa;
  d[i + 3] = oa * 255;
}

// Paint every pixel in a bounding box with alphaAt(px, py), sampled at the pixel centre.
function paint(img, [x0, y0, x1, y1], color, alphaAt) {
  for (let y = Math.max(0, Math.floor(y0)); y <= Math.min(img.height - 1, Math.ceil(y1)); y++)
    for (let x = Math.max(0, Math.floor(x0)); x <= Math.min(img.width - 1, Math.ceil(x1)); x++)
      blend(img, x, y, color, alphaAt(x + 0.5, y + 0.5));
}

function strokeRoundedRect(img, [x, y, w, h], color, stroke, radius) {
  const cx = x + w / 2, cy = y + h / 2, hx = w / 2, hy = h / 2, r = Math.min(radius, hx, hy);
  const sdf = (px, py) => {
    const qx = Math.abs(px - cx) - (hx - r), qy = Math.abs(py - cy) - (hy - r);
    return Math.hypot(Math.max(qx, 0), Math.max(qy, 0)) + Math.min(Math.max(qx, qy), 0) - r;
  };
  const m = stroke + 2;
  paint(img, [x - m, y - m, x + w + m, y + h + m], color, (px, py) => clamp01(stroke / 2 - Math.abs(sdf(px, py)) + 0.5));
}

function polygonSdf(pts) {
  return (px, py) => {
    let min = Infinity, inside = false;
    for (let i = 0, j = pts.length - 1; i < pts.length; j = i++) {
      const [ax, ay] = pts[j], [bx, by] = pts[i], ex = bx - ax, ey = by - ay;
      const t = clamp01(((px - ax) * ex + (py - ay) * ey) / (ex * ex + ey * ey));
      min = Math.min(min, Math.hypot(px - ax - ex * t, py - ay - ey * t));
      if ((ay > py) !== (by > py) && px < ax + ((py - ay) * ex) / ey) inside = !inside;
    }
    return inside ? -min : min;
  };
}

function drawArrow(img, [x1, y1, x2, y2], color, o) {
  const len = Math.hypot(x2 - x1, y2 - y1);
  if (len <= o.headLength) throw new Error(`Arrow is ${len.toFixed(0)} px long; it must be longer than --head-length (${o.headLength}).`);
  const ux = (x2 - x1) / len, uy = (y2 - y1) / len, nx = -uy, ny = ux;
  const s = o.shaft / 2, hw = o.headWidth / 2, bx = x2 - ux * o.headLength, by = y2 - uy * o.headLength;
  const pts = [
    [x1 + nx * s, y1 + ny * s], [bx + nx * s, by + ny * s], [bx + nx * hw, by + ny * hw], [x2, y2],
    [bx - nx * hw, by - ny * hw], [bx - nx * s, by - ny * s], [x1 - nx * s, y1 - ny * s],
  ];
  const sdf = polygonSdf(pts), m = o.outline + 2;
  const bounds = [Math.min(...pts.map((p) => p[0])) - m, Math.min(...pts.map((p) => p[1])) - m,
                  Math.max(...pts.map((p) => p[0])) + m, Math.max(...pts.map((p) => p[1])) + m];
  // A thin dark outline first, so the arrow stays crisp over busy content.
  paint(img, bounds, [10, 12, 16], (px, py) => clamp01(o.outline + 0.5 - sdf(px, py)));
  paint(img, bounds, color, (px, py) => clamp01(0.5 - sdf(px, py)));
}

// ---------- grid (for reading coordinates) ----------

const DIGITS = ["111101101101111", "010110010010111", "111001111100111", "111001111001111", "101101111001001",
                "111100111001111", "111100111101111", "111001001001001", "111101111101111", "111101111001111"];

function drawLabel(img, text, x, y) {
  const sc = 2, w = text.length * 4 * sc + sc, h = 5 * sc + 2 * sc;
  paint(img, [x, y, x + w - 1, y + h - 1], [0, 0, 0], () => 0.8);
  [...text].forEach((ch, k) => {
    const glyph = DIGITS[+ch];
    for (let gy = 0; gy < 5; gy++) for (let gx = 0; gx < 3; gx++)
      if (glyph[gy * 3 + gx] === "1")
        paint(img, [x + sc + (k * 4 + gx) * sc, y + sc + gy * sc, x + sc + (k * 4 + gx) * sc + sc - 1, y + sc + gy * sc + sc - 1], [255, 235, 0], () => 1);
  });
}

function drawGrid(img, step) {
  for (let x = 0; x < img.width; x += step)
    paint(img, [x, 0, x, img.height - 1], [255, 0, 255], () => (x % 100 === 0 ? 0.6 : 0.3));
  for (let y = 0; y < img.height; y += step)
    paint(img, [0, y, img.width - 1, y], [255, 0, 255], () => (y % 100 === 0 ? 0.6 : 0.3));
  for (let x = 100; x < img.width; x += 100) drawLabel(img, String(x), x + 2, 2);
  for (let y = 100; y < img.height; y += 100) drawLabel(img, String(y), 2, y + 2);
}

// ---------- CLI ----------

function crop(img, [x, y, w, h]) {
  x = Math.max(0, x); y = Math.max(0, y);
  w = Math.min(w, img.width - x); h = Math.min(h, img.height - y);
  const data = new Uint8Array(w * h * 4);
  for (let r = 0; r < h; r++) data.set(img.data.subarray(((y + r) * img.width + x) * 4, ((y + r) * img.width + x + w) * 4), r * w * 4);
  return { width: w, height: h, data };
}

const usage = () => { console.error("Usage: node annotate.mjs <in.png> <out.png> [--crop x,y,w,h] [--box x,y,w,h] [--arrow x1,y1,x2,y2] [--arrow-to-box left|right|top|bottom[:len[:offset]]] [--grid [step]] (see the header of this file)"); process.exit(2); };
const nums = (s, n, flag) => {
  const v = String(s).split(",").map(Number);
  if (v.length !== n || v.some(Number.isNaN)) throw new Error(`${flag} expects ${n} comma-separated numbers, got "${s}".`);
  return v;
};
const hex = (s) => {
  const m = /^#?([0-9a-f]{6})$/i.exec(s);
  if (!m) throw new Error(`--color expects #RRGGBB, got "${s}".`);
  return [0, 2, 4].map((i) => parseInt(m[1].slice(i, i + 2), 16));
};

try {
  const args = process.argv.slice(2);
  if (args.length < 2 || args[0].startsWith("--") || args[1].startsWith("--")) usage();
  const [input, output] = args;
  const o = { color: hex("#06C4FF"), stroke: 3, radius: 8, shaft: 14, headWidth: 44, headLength: 38, gap: 10, outline: 2 };
  const ops = [];
  let cropRect = null, grid = 0;
  for (let i = 2; i < args.length; i++) {
    const a = args[i], next = () => { if (i + 1 >= args.length) throw new Error(`${a} needs a value.`); return args[++i]; };
    if (a === "--crop") cropRect = nums(next(), 4, a);
    else if (a === "--box") ops.push({ box: nums(next(), 4, a) });
    else if (a === "--arrow") ops.push({ arrow: nums(next(), 4, a) });
    else if (a === "--arrow-to-box") ops.push({ toBox: next() });
    else if (a === "--color") o.color = hex(next());
    else if (a === "--grid") grid = args[i + 1] && !args[i + 1].startsWith("--") ? +args[++i] : 50;
    else if (["--stroke", "--radius", "--shaft", "--gap"].includes(a)) o[a.slice(2)] = +next();
    else if (a === "--head-width") o.headWidth = +next();
    else if (a === "--head-length") o.headLength = +next();
    else throw new Error(`Unknown option ${a}.`);
  }

  let img = decodePng(readFileSync(input));
  if (grid) {
    drawGrid(img, grid);
  } else {
    let lastBox = null;
    for (const op of ops) {
      if (op.box) { strokeRoundedRect(img, op.box, o.color, o.stroke, o.radius); lastBox = op.box; }
      else if (op.arrow) drawArrow(img, op.arrow, o.color, o);
      else {
        if (!lastBox) throw new Error("--arrow-to-box needs a --box before it.");
        const [side, l, off] = op.toBox.split(":"), [x, y, w, h] = lastBox, g = o.gap + o.stroke / 2, s = off ? +off : 0;
        const tips = { left: [x - g, y + h / 2 + s, -1, 0], right: [x + w + g, y + h / 2 + s, 1, 0], top: [x + w / 2 + s, y - g, 0, -1], bottom: [x + w / 2 + s, y + h + g, 0, 1] };
        if (!tips[side]) throw new Error(`--arrow-to-box side must be left, right, top or bottom, got "${side}".`);
        const [tx, ty, dx, dy] = tips[side], len = l ? +l : 0.3 * (dx ? img.width : img.height);
        drawArrow(img, [tx + dx * len, ty + dy * len, tx, ty], o.color, o);
      }
    }
    if (cropRect) img = crop(img, cropRect);
  }
  writeFileSync(output, encodePng(img));
  console.log(`Wrote ${output} (${img.width}x${img.height})`);
} catch (e) {
  console.error(`annotate: ${e.message}`);
  process.exit(1);
}
