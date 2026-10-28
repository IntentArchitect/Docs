---
name: annotate-screenshot
description: "Use when a docs screenshot needs a highlight: cropping it and drawing an Azure Blue (#06C4FF) box around a panel or control, with an optional bold arrow pointing at it. Works on Windows, macOS and Linux with only Node."
---

# Annotate Screenshot Skill

Crop a PNG screenshot and draw a highlight box and a bold arrow on it, in the brand annotation colour from `guidelines.md` (Azure Blue, `#06C4FF`).

The script is `scripts/annotate.mjs` in this skill's folder. It has no dependencies (Node 18 or later), so it behaves the same on every OS. The commands below run from the repository root. All coordinates are pixels in the **source** image; the crop is applied last.

## Workflow

1. **Look at the screenshot** (open the image) and decide what to highlight and what to crop away.
2. **Read off coordinates with a grid.** Don't guess pixel positions from the image alone:

   ```bash
   node .agents/skills/annotate-screenshot/scripts/annotate.mjs <in.png> <scratch>/grid.png --grid
   ```

   This draws magenta lines every 50 px, labelled every 100 px. Open `grid.png`, find the target's edges and note `x,y,w,h`. Use `--grid 25` if you need more precision. The grid image is for you only; never publish it.

3. **Render the annotation** to a scratch path. Don't write over the original yet:

   ```bash
   node .agents/skills/annotate-screenshot/scripts/annotate.mjs <in.png> <scratch>/annotated.png \
     --box <x,y,w,h> --arrow-to-box left:<len> --crop <x,y,w,h>
   ```

   The arrow aims at the middle of the box's side by default. If that line crosses content you're showing, slide it with an offset (`left:330:110` moves the tip 110 px down), or use `--arrow` for full control.

4. **Open the result and check it** against the rules below. Adjust the numbers and re-run until it's right.
5. **Show it to the user.** Copy it over the image in `src/.../images/` only once they approve.

## Options

| Option | Meaning |
| --- | --- |
| `--box x,y,w,h` | Rounded highlight box. The stroke is centred on this rectangle. Repeatable. |
| `--arrow-to-box side[:len[:offset]]` | Bold arrow pointing at the middle of the previous box's `left`, `right`, `top` or `bottom` side. `len` defaults to 30% of the image width or height; `offset` slides the tip along that side (+ is down/right). |
| `--arrow x1,y1,x2,y2` | Bold arrow from tail to tip, for anything `--arrow-to-box` can't express. Repeatable. |
| `--crop x,y,w,h` | Keep only this region. |
| `--color #RRGGBB` | Defaults to `#06C4FF`. Only change it if the user asks. |
| `--stroke`, `--radius` | Box stroke width (3) and corner radius (8). |
| `--shaft`, `--head-width`, `--head-length` | Arrow thickness (14), head width (44) and head length (38). |
| `--gap` | Space between an `--arrow-to-box` tip and the box (10). |
| `--grid [step]` | Draw a coordinate grid instead of annotating. |

## House style

- **The box hugs the content.** Wrap the populated part of the panel a few pixels outside its content, not the empty space below it.
- **The arrow is there to grab attention.** It should be the first thing a reader notices: bold (keep the default shaft and head), straight, and long enough to stand out (about a quarter to a third of the image). Point it at the box from whichever side has room. It doesn't need to start in the middle of the image or sit at the box's midline. Avoid thin, short or curved arrows; they get lost.
- **Don't cover what matters.** Run the arrow through empty space or low-value content, not across the text the screenshot exists to show.
- **Crop away dead space,** but end the crop between lines of text, never through the middle of one.
- **One highlight per screenshot.** If you need several, consider separate screenshots instead.

## Limits

- 8-bit, non-interlaced PNG only (what Intent Architect and browser screenshots produce). For anything else, the script stops with a message saying how to re-save the file.
- No text labels. Put the explanation in the caption under the image.
