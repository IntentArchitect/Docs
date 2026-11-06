# Driving the dev Intent Architect instance

Screenshots and behaviour checks come from a **dev build** of Intent Architect, built from the product repository and driven over Chrome DevTools Protocol (CDP). You never drive the instance hosting your own session: the installed app is a separate process.

The product repository has the authoritative guide, `.agents/skills/drive-intent-with-playwright/SKILL.md`, with its `references/`, plus `AUTOMATION-API-TODO.md` ("Orientation for a fresh session") in the Electron project. Read them as the reference for the `window.__intentAutomation` API. Their Playwright MCP only loads in sessions rooted in the product repo. In a docs session, use `scripts/ia.cjs` instead.

## Build and launch

`<electron>` below is `<product repo>\Intent.IntentArchitect\IntentArchitect.ElectronClient\Intent.IArchitect.Electron`.

1. **Build from the latest stable release branch.** Use `npm run build` after a pull; otherwise `npm run build:dotnet && npm run build:ts`. Check the exit code: if the build failed, don't launch.
2. **Ports:** `node scripts/ia.cjs --ports`, with `IA_ELECTRON_DIR=<electron>`, prints the CDP port. The CDP port is derived per checkout by `<electron>\scripts\worktree-cdp.js`; the inspector port is CDP + 1 by default.
3. **Launch** with PowerShell, in the background, from `<electron>`: `npm run start:mcp -- --docs-mode --inspect=<inspector port>`. The sandboxed Bash tool can't launch Electron. Then wait until the CDP port answers.
4. **Presentation mode** hides the user's name and update banners. Run the snippet from `guidelines.md` in each renderer (`/shell/`, `/ai-chat`). `scripts/presentation-mode-and-shot.js` shows how.

## Using `scripts/ia.cjs`

```
set IA_ELECTRON_DIR=<electron>
node .claude/skills/create-how-to-doc/scripts/ia.cjs <step.js>
```

`<step.js>` exports `async (h) => { … }`. Whatever it returns is printed as JSON. The helpers on `h`:

- `find(urlPart)` returns the page whose URL contains `urlPart`, e.g. `'/shell/'`, `'/ai-chat'`, `'/home'`.
- `evalIn(part, fn, arg)` evaluates `fn` in that page.
- `ia(part, fn, arg)` calls `fn(window.__intentAutomation, arg)` in that page.
- `main(expr)` evaluates an expression in the main process.
- `shot(outPath, windowId)` saves a composited screenshot, 1280×720 in docs mode, via `captureAppScreenshot()`.
- `sleep(ms)` and `urls()`.

`scripts/lib.js` has small DOM helpers for surfaces with no automation facade, such as expanding a Codebase tree row.

## Gotchas

- **Reach every state the way a user would.** Use the facades, or click the real controls. Don't publish events or call services to fake a state; the presentation-mode snippet is the one documented exception. Evidence from a state no user can reach proves nothing.
- **OS folder and file pickers:** pre-answer them with `NonInteractiveScope.answerNextPicker(paths)`, then click the real button.
- **Native OS menus** can't be captured. That includes the Source Control repository menu and some context menus. Make them human-capture items.
- **The dev instance shares the developer's profile.** Recent solutions, the Agents board, chats and settings are all real. Filter before every capture, never change a setting, and name sample chats `Acme · …`.
- **Read each screenshot once.** Check it, then move on. Save raw captures to the working folder, never to the repo.
- **If a call reports "Target closed",** the instance died. Relaunch rather than retrying.
- **Process cleanup:** only stop the `electron.exe` under the product repo's `node_modules`, and only if a restart is unavoidable. Never touch the installed `Intent Architect*.exe`.
