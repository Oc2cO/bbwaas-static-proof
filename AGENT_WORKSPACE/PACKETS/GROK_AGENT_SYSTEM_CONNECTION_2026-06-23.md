# GROK AGENT SYSTEM CONNECTION — Master Packet (2026-06-23)

**For:** Steven, GPT (ChatGPT), Grok 0.2.60, Hermes, Codex  
**Status:** LIVE AUDIT + UPGRADE SYNC  
**Local truth:** `C:\Users\Sagou\Documents\BrainHub\`

---

## What Hermes built (verified live now)

| Component | Status | Detail |
|-----------|--------|--------|
| BBWAAS MCP Server | ✅ RUNNING | `localhost:8787` — PID check via `pgrep -f "node server.js"` |
| OpenAI Tunnel | ✅ RUNNING | Profile `iris-oracle-tunnel`, tunnel `Oc2cOverse` → `http://localhost:8787/mcp` |
| AGENT_WORKSPACE | ✅ READY | `00_MASTER_FRONT_DOOR/AGENT_WORKSPACE/` |
| Iris Oracle PWA | ✅ LIVE | `https://www.oc2co.com/iris_oracle/` |
| oc2co.com | ✅ LIVE | GitHub Pages brand site |
| ngrok | ⚙️ CONFIGURED | Not running — start with `ngrok http 8787` when needed |

---

## Grok 0.2.60 upgrade (this session)

| Setting | Value |
|---------|-------|
| Version | **0.2.60** (2026-06-21) |
| Agent profile | **universe-build** |
| Model | **grok-build** |
| Mode | always-approve / yolo |
| GitHub MCP | ✅ Active in workspace (`grok_com_github`) |
| BBWAAS MCP | ✅ Wired in `~/.grok/config.toml` → `http://127.0.0.1:8787/mcp` |

**Restart Grok CLI** after config change so `bbwaas` MCP tools load.

---

## MCP tools (all agents)

| Tool | What it does |
|------|----------------|
| `gate_in` | Pin board + active lane + workspace listing |
| `lane_status` | ACTIVE_PROJECTS / COMPLETED / PR_QUEUE |
| `create_packet` | Write to `AGENT_WORKSPACE/PACKETS/` only |
| `proof_index` | Proof files in sellthis_v2, iris_oracle, COMPLETED |
| `sync_status` | Tunnel, Grok, website, BrainHub paths |

**Protocol:** JSON-RPC at `POST http://localhost:8787/mcp` (ChatGPT tunnel compatible)  
**Legacy REST:** `GET /api/gate-in`, `POST /mcp/call`

---

## Agent connection map

| Agent | How to connect | Primary role |
|-------|----------------|--------------|
| **Grok 0.2.60** | Local BrainHub + BBWAAS MCP + GitHub MCP | Front man, visual, local exec, audits |
| **GPT** | OpenAI Secure Tunnel `Oc2cOverse` + GitHub connector | Scope, packets, gate-in via MCP tools |
| **Hermes** | Local WSL + same MCP server | File worker, tunnel ops, proofs |
| **Codex** | GitHub PRs on `oc2co_website` / `iris_oracle` | Code review, backend routes |
| **MemTool** | `oc2co.com` + Polsia backend (separate) | Product app — not the agent bus |

---

## GPT setup (you do this in ChatGPT)

1. **Settings → Apps & Connectors → Advanced → Developer mode** → ON  
2. **Connectors → Create** (or refresh existing `Oc2cOverse`)  
3. Connection type: **Tunnel** (not raw URL unless using ngrok)  
4. Tunnel ID: `tunnel_6a399dded38c8191a7b32f6809821e93`  
5. Ensure tunnel-client is running:
   ```bash
   cd /mnt/c/Users/Sagou/Documents/BrainHub/tunnel_client
   ./tunnel-client run --profile iris-oracle-tunnel
   ```
6. Ensure MCP server is running:
   ```bash
   cd /mnt/c/Users/Sagou/Documents/BrainHub/bbwaas_mcp_server
   npm start
   ```
7. Test in ChatGPT: *"Call gate_in on BBWAAS and tell me the active lane"*

**Permissions:** Set connector to **Always ask** for `create_packet` writes.

---

## Grok setup (done — verify after restart)

`~/.grok/config.toml` now includes:

```toml
[mcp_servers.bbwaas]
url = "http://127.0.0.1:8787/mcp"
enabled = true
```

Test in Grok: *"Use bbwaas gate_in and sync_status"*

---

## Active lane note (drift fix)

Hermes hardcoded `IRIS-ORACLE-VISUAL-DIRECTION-01` in MCP v1.  
**MCP v1.1** now reads pin board dynamically. Current pin board (2026-06-15) still lists **SellThis V2F** as authoritative SOT lane; Iris Oracle is parallel workspace work. **Steven decides** which lane is active — update pin board when switching.

---

## Still offline / optional

| Item | Action needed |
|------|---------------|
| ngrok public URL | `ngrok http 8787` — for agents outside OpenAI tunnel |
| Mattermost | Docker WSL integration off — parked |
| Command Center :8080 | Down — separate from MCP bus |
| `bbwaas-core` private repo | Planned, not created yet |
| Iris oracle git | Rebase in progress in local repo — resolve before push |

---

## Startup script (run after reboot)

```bash
# Terminal 1 — MCP bus
cd /mnt/c/Users/Sagou/Documents/BrainHub/bbwaas_mcp_server && npm start

# Terminal 2 — OpenAI tunnel (for GPT)
cd /mnt/c/Users/Sagou/Documents/BrainHub/tunnel_client
./tunnel-client run --profile iris-oracle-tunnel

# Terminal 3 — optional ngrok (for external agents)
ngrok http 8787
```

---

## Copy-paste for GPT

> BBWAAS agent bus is live. OpenAI tunnel `Oc2cOverse` points to `http://localhost:8787/mcp`. Tools: gate_in, lane_status, create_packet, proof_index, sync_status. AGENT_WORKSPACE at BrainHub/00_MASTER_FRONT_DOOR/AGENT_WORKSPACE/. Grok 0.2.60 universe-build is the local executor. Run gate_in first every session.

---

*Saved by Grok 0.2.60 — system audit 2026-06-23*