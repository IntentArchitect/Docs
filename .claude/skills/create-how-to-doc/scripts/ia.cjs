// Drive a dev Intent Architect instance over CDP (renderers) and the Node inspector (main process).
//
//   set IA_ELECTRON_DIR=<product repo>\Intent.IntentArchitect\IntentArchitect.ElectronClient\Intent.IArchitect.Electron
//   node ia.cjs --ports        prints the CDP and inspector ports to launch with
//   node ia.cjs <step.js>      runs step.js (`module.exports = async (h) => {...}`) and prints its return value as JSON
//
// Ports: IA_CDP_PORT / IA_INSPECT_PORT if set; otherwise the CDP port comes from the checkout's
// scripts/worktree-cdp.js (as `npm run start:mcp` uses) and the inspector port is CDP + 1.
// Launch the instance with `npm run start:mcp -- --docs-mode --inspect=<inspector port>`.
// Needs Node 22+ (global fetch and WebSocket).
const path = require('path');
const fs = require('fs');

const ELECTRON_DIR = process.env.IA_ELECTRON_DIR;
if (!ELECTRON_DIR || !fs.existsSync(ELECTRON_DIR)) {
  console.log('ERROR: set IA_ELECTRON_DIR to the product repo\'s Intent.IArchitect.Electron folder');
  process.exit(1);
}

function ports() {
  let cdp = parseInt(process.env.IA_CDP_PORT, 10);
  if (!Number.isInteger(cdp)) {
    const { cdpPort } = require(path.join(ELECTRON_DIR, 'scripts', 'worktree-cdp'));
    cdp = cdpPort(path.join(ELECTRON_DIR, 'scripts'));
  }
  let inspect = parseInt(process.env.IA_INSPECT_PORT, 10);
  if (!Number.isInteger(inspect)) inspect = cdp + 1;
  return { cdp, inspect };
}

async function main() {
  const { cdp, inspect } = ports();
  if (process.argv[2] === '--ports') {
    console.log(JSON.stringify({ cdp, inspect }));
    return;
  }

  const { chromium } = require(path.join(ELECTRON_DIR, 'node_modules', 'playwright'));
  const userFn = require(path.resolve(process.argv[2]));
  const browser = await chromium.connectOverCDP(`http://127.0.0.1:${cdp}`, { timeout: 15000 });
  const pages = () => browser.contexts().flatMap(c => c.pages());
  const find = (part) => {
    const p = pages().find(pg => pg.url().includes(part));
    if (!p) throw new Error(`no page matching ${part}; have ${pages().map(x => x.url()).join(' | ')}`);
    return p;
  };
  // Evaluate a function with an argument inside the page whose URL contains `part`.
  const evalIn = async (part, fn, arg) => find(part).evaluate(fn, arg);
  // Call fn(window.__intentAutomation, arg) inside that page.
  const ia = async (part, fn, arg) => find(part).evaluate(
    ([src, a]) => (new Function('return ' + src)())(window.__intentAutomation, a), [fn.toString(), arg]);

  // Evaluate an expression in the main process through the Node inspector.
  let msgId = 0;
  const mainEval = async (expr) => {
    const list = await (await fetch(`http://127.0.0.1:${inspect}/json/list`)).json();
    const ws = new WebSocket(list[0].webSocketDebuggerUrl);
    await new Promise((res, rej) => { ws.onopen = res; ws.onerror = rej; });
    const id = ++msgId;
    const result = await new Promise((res) => {
      ws.onmessage = (ev) => { const m = JSON.parse(ev.data); if (m.id === id) res(m); };
      ws.send(JSON.stringify({ id, method: 'Runtime.evaluate', params: { expression: expr, awaitPromise: true, returnByValue: true, includeCommandLineAPI: true } }));
    });
    ws.close();
    if (result.result?.exceptionDetails) throw new Error(JSON.stringify(result.result.exceptionDetails).slice(0, 2000));
    return result.result?.result?.value;
  };

  // Composited screenshot of a window (1280x720 in --docs-mode).
  const shot = async (outPath, windowId) => {
    const dataUrl = await mainEval(`global.__intentAutomation.captureAppScreenshot(${windowId ?? ''})`);
    if (!dataUrl) throw new Error('captureAppScreenshot returned null');
    fs.mkdirSync(path.dirname(outPath), { recursive: true });
    fs.writeFileSync(outPath, Buffer.from(dataUrl.replace(/^data:image\/png;base64,/, ''), 'base64'));
    return outPath;
  };

  const sleep = (ms) => new Promise(r => setTimeout(r, ms));
  const h = { browser, pages, find, evalIn, ia, main: mainEval, shot, sleep, urls: () => pages().map(p => p.url()) };
  try {
    console.log(JSON.stringify(await userFn(h), null, 2));
  } catch (e) {
    console.log('ERROR: ' + (e && e.stack || e));
    process.exitCode = 1;
  }
  process.exit();
}

main();
