# BBWAAS SIDECAR PAGE LINK MAP AND DEAD ROUTE FIX 06 — PUBLIC SAFE PROOF

**Date:** 2026-06-24
**Status:** PASS by Grok local operator report, pending Steven Chrome reload/click verification.
**Mode:** Local Sidecar patch only.

## Summary
Grok mapped Sidecar browser-launch buttons and patched dead route behavior after 2 of 3 browser-open attempts could not be reached.

## Files changed
- `bbwaas_sidecar_panel/sidepanel.js`
- `bbwaas_sidecar_panel/sidepanel.html`
- `bbwaas_sidecar_panel/manifest.json`

No server, DNS, deploy, wallet, token, .env, trade, swarm, router, or git push actions were reported.

## Root cause found
Some Sidecar browser-open buttons used WSL-style `/mnt/c/...` paths, which are invalid for Windows Chrome. Grok replaced them with Windows `file:///C:/Users/Sagou/Documents/BrainHub/...` URLs.

## Reported button targets
- `GATE IN` -> MCP `GET /api/gate-in`
- `LANE STATUS` -> MCP `GET /api/lane-status`
- `SYNC STATUS` -> MCP `GET /api/sync-status`
- `IRIS DASH` -> local `file:///C:/Users/Sagou/Documents/BrainHub/iris_oracle/agent_coordination_dashboard.html`
- `COMMAND ROOM` -> local `file:///C:/Users/Sagou/Documents/BrainHub/00_MASTER_FRONT_DOOR/BRAINHUB_COMMAND_ROOM.html`
- `COMPOSE PACKET` -> in-panel scroll
- `STUDIO`, `AGENTS`, `BOTLAB` -> parked future hosts, no dead tab opening
- Handshake buttons -> MCP `/api/*`

## Patches reported
1. Added central `PAGE_LINK_MAP` and `openMappedPage()` logic.
2. Replaced dead `/mnt/c/...` opens with `file:///C:/...` Windows Chrome paths.
3. Added `tabs` permission in `manifest.json` and bumped Sidecar to version `1.0.6`.
4. Added Future Hosts panel and parked buttons for future subdomains.
5. Future/parked buttons log `WARN` in Live Work Feed instead of opening dead tabs.
6. Tooltips show local proof paths for Iris and Command Room.

## Verification reported by Grok
- No `/mnt/c/` remains in active `sidepanel.js`.
- No `onclick=` remains in `sidepanel.html`.
- Target local HTML files exist on disk.
- In-browser click test remains for Steven after extension reload.

## Steven verification steps
1. Reload BBWAAS Sidecar extension from `chrome://extensions`.
2. Confirm version `1.0.6`.
3. Click `IRIS DASH` and `COMMAND ROOM`.
4. If local file tabs fail, enable `Allow access to file URLs` for the extension.
5. Click `STUDIO`, `AGENTS`, and `BOTLAB`; these should warn in feed and not open dead pages.

## Verdict
PASS pending final Chrome-side verification.

## Guardrails maintained
- No arbitrary shell.
- No raw machine exposure.
- No DNS/deploy changes.
- No secrets or `.env` access.
- No wallet/private-key/token access.
- No TRADE/SWARM/ROUTER execution.
