# BBWAAS SIDECAR UX DESIGN — 01 (GROK RESEARCH / UI PACKET)

**Date:** 2026-06-23  
**For:** All agents (Grok, GPT via tunnel, Hermes, Codex, Claude)  
**Context:** Local-first browser side panel for command-center workflows. Original Oc2cO/BBWAAS. Not a Sider clone or any proprietary layout.  
**Source of truth:** local BrainHub + AGENT_WORKSPACE  
**MCP:** localhost:8787 (gate_in, lane_status, create_packet, sync_status, proof_index)  
**Status:** V1 design + prototype ready for local use / unpacked extension

---

## RULES (non-negotiable)
- No proprietary Sider assets, names, icons, copy, or layout copying.
- Local-first and clean. Everything references BrainHub / AGENT_WORKSPACE.
- Minimal visual style: dark command center aesthetic consistent with existing (Iris, hosted workspace, dashboards).
- All writes go through MCP create_packet → AGENT_WORKSPACE/PACKETS/ only.
- Safety labels prominent. Never suggest secret exfil or external hosting edits.
- Narrow: side panel for quick coordination while in browser or during dev.

---

## MINIMAL VISUAL STYLE

Palette (shared with bbwaas_hosted_workspace + iris coordination dashboard):
- bg: #06080f
- surface: #111827
- surface-2: #1a1d2e
- text: #f1f5f9
- text-dim: #94a3b8
- accent / cyan: #67e8f9
- success: #4ade80
- warning: #f59e0b
- border: #334155

Typography: system-ui / Inter, 11-13px base for compactness. Monospace for paths + timestamps.

Spacing: tight 8-12px. Rounded 4-6px. Thin 1px borders. No heavy gradients or glows in V1. Subtle hover lift on interactive.

Panel width target: ~320px (Chrome side panel default range).

Header: compact logo row + connection indicator.

All sections use `.section` or direct cards with consistent padding.

Footer always shows: LOCAL-FIRST • BRAINHUB SOURCE • PACKETS ONLY • MCP:8787

---

## LAYOUT SECTIONS (top to bottom in narrow panel)

### 1. HEADER
- Left: BBWAAS (bold cyan) + small "SIDECAR" badge
- Right: connection pill (● LIVE or ○ OFFLINE) + "v1"
- Sub: "local operator panel"

### 2. STATUS CARD LAYOUT (prominent, first real content)
Single card, high visual weight:

```
┌─────────────────────────────────┐
│ ACTIVE LANE                     │
│ IRIS-ORACLE-VISUAL-DIRECTION-01 │
│                                 │
│ MCP 8787     ● connected        │
│ Last gate: 14:33                │
│ BrainHub: .../BrainHub          │
│ Credits: low (monitor)          │
└─────────────────────────────────┘
```

- Lane name from gate_in result (truncate smartly)
- Dot + "connected" / "simulated"
- Timestamp
- Subtle "source of truth" line
- Warning line if needed

Refresh on "GATE IN" action.

### 3. BUTTON LAYOUT (quick actions)
Tight grid or stacked for vertical flow.

V1 primary (full width):
- **GATE IN**  (largest, cyan accent border or fill, calls gate_in + refreshes status + agents)

Secondary 2-col row:
- [ LANE STATUS ]   [ SYNC STATUS ]
- [ OPEN DASHBOARD ] [ PROOFS ]

Tertiary / utility row or footer actions:
- [ COMPOSE PACKET ] (scrolls or expands composer)
- Copy current state (for handoff)

Style: `.btn { padding: 8px 12px; font-size:12px; border:1px solid #334155; background:#1a1d2e; color:#f1f5f9; border-radius:4px; }`
`.btn.primary { border-color:#67e8f9; color:#67e8f9; }`
Hover: border stronger or bg slight shift. No fancy.

Command-center inspiration: mission control buttons — large label, minimal icon (text symbols or unicode), instant feedback (loading text).

### 4. AGENT MAP MINI-VIEW
Compact registry list (not graph in V1).

```
AGENTS
Grok     ● local + MCP + GitHub
GPT      ● tunnel (Oc2cOverse)
Hermes   ● WSL / file ops
Codex    ○ GitHub PRs
Claude   ○ manual via Steven
```

- Vertical flex or grid of rows
- Bold name + short role line
- Colored dot (green=known live, amber=partial, gray=manual)
- Clickable: highlights and prefills "To:" in composer for that agent
- "5 agents registered" count at top

Keeps command-center feel: always-visible who is on duty.

Parked: interactive node-link SVG map, real-time ping, avatars.

### 5. PACKET COMPOSER FLOW (core interaction)
Always visible or one-tap expandable card at bottom half.

**Flow (linear, no wizard needed):**
1. Packet Type segmented or <select>: Handoff | Report | Status | Visual Proof | Other
2. Title: short input (pre-filled suggestion e.g. "Sidecar UX handoff")
3. To (targets): row of toggle chips (Grok, GPT, Hermes, Codex). Click to add/remove. Default: relevant based on active lane.
4. Body: textarea (3-5 lines visible, monospace). Markdown friendly.
5. Safety row: 3 inline labels + checkboxes (all pre-checked):
   - [x] LOCAL BRAINHUB ONLY
   - [x] NO SECRETS / CREDENTIALS
   - [x] REFERENCE FRONT DOOR + PIN BOARD
6. Big action: **WRITE PACKET** (cyan)

**Behavior on submit:**
- Validate title + body
- Assemble standard header: `# Title\n\n**Agent:** sidecar\n**Created:** ...\n**Targets:** ...\n\nBody...`
- POST to MCP `/mcp/call` or legacy create_packet path
- On success: banner "✓ Packet written: FILENAME.md  (in AGENT_WORKSPACE/PACKETS/)" + "View in workspace"
- Fallback (no MCP): copy full markdown to clipboard + instruction "Paste into AGENT_WORKSPACE/PACKETS/ manually"
- Log the action to mini activity feed

Command center flow: fast "file a packet" like logging a flight plan. No friction.

### 6. SAFETY LABELS (ubiquitous)
- Inline on every card and composer: small caps or uppercase tags `LOCAL-FIRST` `PACKETS→WORKSPACE` `MCP ONLY`
- Footer persistent: `BBWAAS • LOCAL BROWSER PANEL • BRAINHUB IS TRUTH • NO EXTERNAL WRITES`
- On any write action: confirmation text "Writes only via MCP to PACKETS/"
- Gate/Status responses always carry "source: BrainHub" note

### 7. MINI ACTIVITY / LOG (bottom)
3-5 latest lines:
14:33 gate_in → IRIS lane
14:28 packet written
...

Simple ul with time + short desc. Updates from actions.

---

## BUTTON LAYOUT (detailed)

Primary stack:
1. GATE IN (top, full width, accent)
2. Two-col:
   - LANE STATUS
   - SYNC STATUS
3. Two-col:
   - OPEN IRIS DASH
   - OPEN COMMAND ROOM
4. COMPOSE (full width, secondary)

All buttons trigger MCP where possible and update UI live.

No "Settings" or "More" in V1 — keep dead simple.

---

## STATUS CARD LAYOUT (detailed)

Fields (from MCP gate_in + sync):
- Active Lane (large)
- MCP connection state + port
- Timestamp of last successful gate
- Workspace item counts (active projects, packets today)
- Subtle path or "local BrainHub"
- Optional warning row (credits, DNS note if surfaced)

Refresh button inside card or via main GATE IN.

---

## AGENT MAP MINI-VIEW (detailed)

Hardcoded in V1 from known map (GROK packet):
- Grok (local BrainHub + MCP + GitHub) — ●
- GPT (tunnel) — ●
- Hermes (WSL) — ●
- Codex (GitHub) — ○
- Claude (Steven) — ○

Each row: `NAME  role  ●`
Click → "To: NAME" added to composer + flash.

Later: status per lane participation.

---

## WHAT IS V1 vs PARKED

**V1 (implement now, narrow, local-first):**
- Self-contained single-file sidepanel.html (works opened directly or as extension side panel)
- Live fetch to MCP (http://localhost:8787) with graceful fallback
- Status card populated from gate_in + sync
- Agent map static + interactive for composer
- Composer fully functional (type + write via MCP or clipboard)
- Button actions wired to real MCP calls where possible
- Safety labels everywhere
- Minimal consistent styling
- No extension background polling yet
- One static prototype + this design packet

**PARKED (explicitly not V1):**
- Full Chrome extension packaging + icons + background service worker polling + notifications
- Real-time agent graph (SVG nodes + edges, drag, zoom)
- Embedded previews (Iris or SellThis iframe)
- Packet reply threads / history viewer
- Theme customization or "command center" skin switch
- Direct file writes outside MCP (never)
- Cloud or remote panel versions
- Integration with phone bridge deep links
- Visual effects, motion, heavy glassmorphism
- Any DNS / hosting / secret touches
- Broad feature expansion

---

## IMPLEMENTATION NOTES FOR BUILD

- Prototype location: bbwaas_sidecar_panel/sidepanel.html
- Standalone demo: can be referenced from iris_oracle/agent_coordination_dashboard.html
- To use as real side panel: complete extension (add background.js, icons later)
- To test locally: open sidepanel.html in browser; click buttons (MCP must be running)
- MCP endpoints used: GET /healthz, /api/gate-in, /api/sync-status, POST /mcp/call for create_packet
- All packet names: prefix "SIDECAR_" or agent-chosen
- Keep in sync with AGENT_WORKSPACE rules: write here first

---

## NEXT RECOMMENDED (after this packet)

1. Load / test sidepanel.html locally while MCP running.
2. Add link from coordination dashboard + BRAINHUB_COMMAND_ROOM.
3. Write Grok report on this design into AGENT_REPORTS/.
4. (Later narrow) Add minimal background.js + load as unpacked ext.
5. Reference this packet in all future handoffs.
6. Keep SellThis / Iris lanes protected.

**Local BrainHub is the single source of truth. All coordination through packets.**

End of design packet.
