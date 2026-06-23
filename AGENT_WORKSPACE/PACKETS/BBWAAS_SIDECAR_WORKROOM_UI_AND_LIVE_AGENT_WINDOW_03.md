# BBWAAS SIDECAR WORKROOM UI AND LIVE AGENT WINDOW 03

**Status:** ACTIVE PACKET
**Date:** 2026-06-23
**Owner:** Steven / BBWAAS
**Mode:** Local patch only

## Purpose

Upgrade the BBWAAS Sidecar from a functional test panel into the actual operator workroom Steven wants: a visible window where he can watch work being done, see which agents are active, see packets move through claim/report/check/close, and coordinate communication through the shared AGENT_WORKSPACE.

This is a UI/coordination patch, not a secrets/deploy/provider patch.

## Current verified foundation

- Local MCP server responds on localhost:8787.
- Sidecar opens in Chrome and buttons work.
- Packet list endpoint works.
- Git status endpoint works.
- Claim endpoint writes to ACTIVE_PROJECTS.
- Agent note endpoint writes to AGENT_REPORTS.
- Checker report endpoint writes to CHECKER_REPORTS.
- Close endpoint writes to COMPLETED.
- Public proof repo exists with safety ignores.
- xAI/Grok domain verification is active.
- Grok Role Check and Readonly Inventory passed with guardrails.

## Design objective

Create a live-feeling command room interface with these major zones:

1. **Top Command Bar**
   - System status lights: MCP, Sidecar, Git, Public Proof, xAI/Grok, Website.
   - Current active lane.
   - Last sync time.
   - Safe mode indicator.

2. **Live Work Feed**
   - Scrollable activity stream.
   - Shows packet opened, claimed, note posted, checker report posted, packet closed, git status checked, push/pull result.
   - Include timestamp, actor, action, result, and proof path.
   - This is Steven's "watch actual work being done" window.

3. **Agent Board**
   - Cards for Steven, GPT, Grok, Hermes, Codex, Claude.
   - Each card shows role, status, current claimed packet, last report, and allowed permissions.
   - Status states: idle, reading, claimed, working, waiting-check, blocked, complete.

4. **Packet Board**
   - Open packets list from `/api/packets/open`.
   - Filters: Open, Claimed, Needs Check, Completed, Warnings.
   - Selecting a packet shows filename, modified time, quick preview/summary if available, and action buttons.

5. **Packet Workroom**
   - Claim Packet.
   - Post Agent Note.
   - Post Checker Report.
   - Close Packet.
   - Proof path list.
   - Activity history for selected packet.

6. **Agent Communication Thread**
   - Not an uncontrolled chatroom.
   - Packet-scoped thread made from AGENT_REPORTS and CHECKER_REPORTS.
   - Every message must attach to a packetId and agent/checker name.
   - This lets agents communicate while preserving source-of-truth structure.

7. **Git / Sync Panel**
   - Git Status.
   - Pull Public Proof.
   - Push Public Proof.
   - Must clearly show safe/public mirror only.
   - No broad push, no `git add .`, no private ignored files.

8. **Permission / Guardrail Panel**
   - Show what each agent can and cannot do.
   - Grok: read-only planning/reporting until approved.
   - GPT: packet/checker/proof routing.
   - Hermes: local patch worker under explicit packet.
   - Codex: checker/review lane.
   - Claude: architecture/deep reasoning/coworker lane.
   - Steven: approval and command owner.

## Required MCP/backend support

If not already present, add or refine read-only endpoints:

- GET `/api/activity/recent`
  - Return recent claim, note, checker, closeout, and packet files sorted by modified time.

- GET `/api/agents/status`
  - Return known agent cards and any current claim files.

- GET `/api/packet/thread/:packetId`
  - Return claim, agent notes, checker reports, and closeouts matching a packetId.

- GET `/api/system/status`
  - Return MCP health, repo clean flag, current active lane, timestamp.

Do not add arbitrary shell, broad file read/write, or secrets access.

## Sidecar UI implementation requirements

- Keep Manifest V3 safe structure: no inline onclick handlers and no inline script blocks.
- Continue using `sidepanel.js` for event binding.
- Add clear loading, success, and error states for every action.
- Keep the interface readable in a narrow Chrome side panel, but design it so it can later become a full dashboard page.
- Use visible proof paths after every write.
- Do not hide failures.
- Do not fake execution. If a button is not wired, mark it as disabled or coming soon.

## Safety rules

- No secrets.
- No tokens.
- No .env access.
- No wallets or private keys.
- No Cloudflare/DNS changes.
- No xAI/ngrok/OpenAI paid calls.
- No public deploys.
- No arbitrary shell endpoint.
- No read-any-file endpoint.
- No write-any-file endpoint.
- No broad Chrome permissions.

## Verification

After patch and server restart, verify:

1. Sidecar opens without console errors.
2. Open Packets populates packet board.
3. Claim Packet writes to ACTIVE_PROJECTS.
4. Agent Note writes to AGENT_REPORTS.
5. Checker Report writes to CHECKER_REPORTS.
6. Close Packet writes to COMPLETED.
7. Live Work Feed updates after each action.
8. Agent Board shows at least Steven, GPT, Grok, Hermes, Codex, Claude.
9. Packet-scoped thread shows claim + agent note + checker report + closeout for the selected packet.
10. Git Status shows clean/dirty and untracked warnings without staging or pushing anything.

## Expected output

Hermes should return:

- Files changed.
- Routes added or reused.
- UI sections added.
- Whether server restarted.
- Screens/test descriptions.
- PASS/WARN/FAIL.
- Any endpoints still stubbed or needing next patch.

## Success definition

Steven can open Sidecar and watch the system operate through a visible workroom:

Packet -> claim -> live feed update -> agent note -> checker report -> closeout -> proof path.

This becomes BBWAAS Sidecar Workroom V1.
