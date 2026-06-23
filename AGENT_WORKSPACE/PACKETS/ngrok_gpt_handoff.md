# GPT HANDOFF — BBWAAS AGENT BUS (UPDATED 2026-06-23)

**From:** Steven (Oc2cO) via Grok system audit  
**Supersedes:** 2026-06-22 ngrok-only draft

---

## STATUS (current)

| Component | Status |
|-----------|--------|
| BBWAAS MCP Server | ✅ **LIVE** — `localhost:8787`, MCP JSON-RPC at `/mcp` |
| OpenAI Tunnel | ✅ **RUNNING** — `iris-oracle-tunnel` → `Oc2cOverse` |
| Ngrok | ⚙️ Configured, not running |
| Iris Oracle PWA | ✅ `www.oc2co.com/iris_oracle/` |
| Grok | ✅ **0.2.60** universe-build + BBWAAS MCP wired |

---

## GPT connector steps

1. Developer mode ON  
2. Connector type: **Tunnel** → tunnel `tunnel_6a399dded38c8191a7b32f6809821e93`  
3. Refresh tools — should see: `gate_in`, `lane_status`, `create_packet`, `proof_index`, `sync_status`  
4. First command: **"BBWAAS gate-in"**

## Architecture

```
ChatGPT (Tunnel: Oc2cOverse)
    → tunnel-client (outbound only)
        → localhost:8787/mcp (JSON-RPC)
            → BrainHub read + AGENT_WORKSPACE/PACKETS write
```

## Master packet

Full agent map: `AGENT_WORKSPACE/PACKETS/GROK_AGENT_SYSTEM_CONNECTION_2026-06-23.md`