---
name: annotate-screenshot
description: "Use when a docs screenshot needs a highlight: cropping it and drawing an Azure Blue (#06C4FF) box around a panel or control, with an optional bold arrow pointing at it. Works on Windows, macOS and Linux with only Node."
---

# Annotate Screenshot Skill

Crop a PNG screenshot and draw a highlight box and a bold arrow on it, in the brand annotation colour from `guidelines.md` (Azure Blue, `#06C4FF`).

The scripts are in this skill's `scripts/` folder: `annotate.mjs` draws, and `compare.mjs` builds a before/after review page. Neither has dependencies (Node 18 or later), so they behave the same on every OS. The commands below run from the repository root. All coordinates are pixels in the **source** image; the crop is applied last.

## Choosing what to annotate

When asked which screenshots would benefit, read the article text around each image (not just its caption) and open the image. Recommend the ones where **something the text describes is small, unmarked or lost in a busy screenshot**, and say for each one what you'd box and why.

- **The text decides, not the caption.** If the text names a specific control the reader has to find (a `+` button, a `Send 2 comments` button, a badge), highlight the one most central to what's new, even when the caption describes the whole view. If that control appears more than once, ring the most prominent one. A named control that isn't in the shot isn't a reason to recapture on its own.
- **Skip screenshots where the UI already highlights the feature,** such as diff colours.
- **Skip screenshots where the whole image is the feature and the text names no smaller control,** such as an overview tab described as a whole.
- **Recapture flawed screenshots instead.** That covers images with an error state ("Failed to fetch"), empty or placeholder fields, raw ids, or staff names, and images that don't show what the text claims. An arrow can't fix any of those. If you annotate one anyway, say which flaws are still visible.
- **Internal content** (Intent's own repositories or specs) is a judgement call. Crop away what you can, mention what's left in the page note, and let the user decide.

List the screenshots you skipped, and why, in your reply. Leave them off the before/after page.

## Workflow

`<scratch>` below means a working folder **outside the repository**: the user's evidence folder if they keep one, otherwise a temp folder. Grids, attempts and samples never go in the repo. `<reports>` is where the user keeps reports, or `<scratch>` if they don't say.

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
5. **Present the samples.** By default, give each sample's path and, in a line or two, say what's boxed, what was cropped, and any flaws still visible.

   **Only when the user asks for a comparison** (a before/after page, or "show me side by side"), build one with `compare.mjs` and open it in their browser:

   ```bash
   node .agents/skills/annotate-screenshot/scripts/compare.mjs <reports>/<date>-<name>-samples.html --title "<what these are>" \
     --pair <original.png> <scratch>/annotated.png --note "<what you boxed, cropped and why>" \
     --pair ...
   ```

   Open it with `start` (Windows), `open` (macOS) or `xdg-open` (Linux). Put every sample in the batch on one page. To add later samples, re-run it with all the pairs.

6. **Apply only what the user approves.** Copy each approved sample over its image in `src/.../images/`. Rebuild with `_build.ps1`, check that the image in `_site/` matches, and look at its section on the local docs page (`http://localhost:8080/...#<section-anchor>`). The local build reports missing `modules-*` TOC files; that's expected, because only CI merges those in.
7. **Commit and push only when the user asks.**

## Options

| Option | Meaning |
| --- | --- |
| `--box x,y,w,h` | Rounded highlight box. The stroke is centred on this rectangle. Repeatable. |
| `--arrow-to-box side[:len[:offset]]` | Bold arrow pointing at the middle of the previous box's `left`, `right`, `top` or `bottom` side. `len` defaults to 30% of the image width or height; `offset` slides the tip along that side (+ is down/right). |
| `--arrow x1,y1,x2,y2` | Bold arrow from tail to tip, for anything `--arrow-to-box` can't express (diagonals, mainly). Repeatable. There's no automatic gap, so stop the tip about 10 px outside the box yourself. |
| `--crop x,y,w,h` | Keep only this region. |
| `--color #RRGGBB` | Defaults to `#06C4FF`. Only change it if the user asks. |
| `--stroke`, `--radius` | Box stroke width (3) and corner radius (8). |
| `--shaft`, `--head-width`, `--head-length` | Arrow thickness (14), head width (44) and head length (38). |
| `--gap` | Space between an `--arrow-to-box` tip and the box (10). |
| `--grid [step]` | Draw a coordinate grid instead of annotating. |

## House style

- **The box hugs the content.** Wrap the populated part of the panel a few pixels outside its content, not the empty space below it.
- **The arrow is there to grab attention.** It should be the first thing a reader notices: bold (keep the default shaft and head), straight, and long enough to stand out (about a quarter to a third of the image). Point it at the box from whichever side has room. It doesn't need to start in the middle of the image or sit at the box's midline. Avoid thin, short or curved arrows; they get lost.
- **Find a clear run for the arrow.** Use a horizontal arrow when there's an empty band beside the target. If not, use a diagonal `--arrow` through empty margin, or come up from below through empty space under a side panel. When the box spans most of the crop, a diagonal from an empty corner is usually the only run long enough.
- **Don't cover what matters.** Run the arrow through empty space or low-value content, not across the text the screenshot exists to show.
- **Ring round controls.** For a round button, use a square `--box` and set `--radius` to half its size so it draws as a circle.
- **Crop for the page, not the screen.** The docs content column is only about 514 px wide, so a 1600–1900 px screenshot shrinks to a third or a quarter of its size and becomes unreadable. Crop wide shots down to the area the text is about (roughly 1000–1250 px wide).
- **Crop away dead space,** but end the crop between lines of text, never through the middle of one. Leave room for the whole arrow head (half of `--head-width`) inside the crop.
- **One highlight per screenshot.** If you need several, consider separate screenshots instead.

## Limits

- 8-bit, non-interlaced PNG only (what Intent Architect and browser screenshots produce). For anything else, the script stops with a message saying how to re-save the file.
- No text labels. Put the explanation in the caption under the image.
