# BBWAAS HANDSHAKE TOOLS 01 CLEANUP AND SIDECAR UI 02

**Status:** ACTIVE PATCH PACKET
**Date:** 2026-06-23
**Owner:** Steven / BBWAAS
**Primary worker:** Hermes
**Checker:** GPT/Codex after patch

## Purpose

Clean up the first working multi-agent handshake layer and expose the verified endpoints inside the BBWAAS Sidecar UI.

Handshake Tools 01 is already GREEN for the core loop:

- GET /api/packets/open works.
- GET /api/git/status works.
- POST /api/packets/claim works.
- POST /api/agent-note works.
- POST /api/checker-report works.
- POST /api/packet-close works.

This patch should not expand permissions. It should clean up paths, field names, user feedback, and Sidecar access.

## Current verified proof

Local files were created by the handshake test:

- Claim: `AGENT_WORKSPACE/PACKETS/CLAIM_BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01_BY_Steven-Sidecar-Test.md`
- Agent note: `AGENT_WORKSPACE/AGENT_REPORTS/NOTE_BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01_Steven-Sidecar-Test_1782255903261.md`
- Checker report: `AGENT_WORKSPACE/CHECKER_REPORTS/CHECK_BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01_Steven-Test_1782255911745.md`
- Closeout: `AGENT_WORKSPACE/COMPLETED/CLOSED_BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01_1782256393133.md`

## Active paths

MCP server:

`C:\Users\Sagou\Documents\BrainHub\bbwaas_mcp_server\server.js`

Sidecar extension:

`C:\Users\Sagou\Documents\BrainHub\bbwaas_sidecar_panel`

Agent workspace:

`C:\Users\Sagou\Documents\BrainHub\00_MASTER_FRONT_DOOR\AGENT_WORKSPACE`

Public proof repo:

`C:\Users\Sagou\Documents\BrainHub\bbwaas-static-proof`

## Patch requirements

### 1. Move claims to ACTIVE_PROJECTS

Current behavior writes claim files into `AGENT_WORKSPACE/PACKETS`.

Preferred behavior:

`AGENT_WORKSPACE/ACTIVE_PROJECTS/CLAIM_<packet>_BY_<agent>.md`

Keep backward compatibility if existing claim files are in PACKETS. Do not delete old test claim files automatically.

### 2. Standardize request field names

Support these names consistently:

- Claim endpoint: `filename`, `agent`
- Agent note endpoint: `packetId`, `agent`, `body`
- Checker report endpoint: `packetId`, `checker`, `body`
- Packet close endpoint: `packetId`, `summary`, `proof_paths`

Optional compatibility aliases may be accepted, but the Sidecar UI must use the standardized names above.

### 3. Add or update Sidecar UI controls

Add visible controls for:

- Open Packets
- Claim Packet
- Post Agent Note
- Post Checker Report
- Close Packet
- Git Status
- Pull Public Proof
- Push Public Proof

Each action must show visible success/error feedback in the activity log.

### 4. Add packet selector/list

Open Packets should populate a packet list or dropdown using:

`GET /api/packets/open`

User should be able to select a packet and use it for claim/note/check/close actions.

### 5. Keep safety boundary unchanged

No arbitrary shell endpoint.
No read-any-file endpoint.
No write-any-file endpoint.
No .env access.
No token/key/wallet/private-key access.
No Cloudflare/DNS/xAI/ngrok/OpenAI provider calls.
No paid API calls.
No public deployment.
No broad Chrome extension permissions.

### 6. Git actions remain narrow

Git endpoints may only operate in:

`C:\Users\Sagou\Documents\BrainHub\bbwaas-static-proof`

Do not run `git add .`.
Do not stage ignored/private files.
Do not push TRADE, SWARM, ROUTER, secrets, .env, wallet, token, private-key, or LOCAL_TOOLS files.

## Verification commands

After patch and restart, run:

```powershell
Invoke-RestMethod -Uri "http://localhost:8787/api/packets/open" -Method Get | ConvertTo-Json -Depth 5
Invoke-RestMethod -Uri "http://localhost:8787/api/git/status" -Method Get | ConvertTo-Json -Depth 5
```

Claim test:

```powershell
$body = @{
  filename = "BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01.md"
  agent = "Steven-Sidecar-Test-02"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8787/api/packets/claim" -Method Post -ContentType "application/json" -Body $body | ConvertTo-Json -Depth 5
```

Agent note test:

```powershell
$body = @{
  packetId = "BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01"
  agent = "Steven-Sidecar-Test-02"
  body = "Testing Sidecar UI cleanup and standardized handshake fields."
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8787/api/agent-note" -Method Post -ContentType "application/json" -Body $body | ConvertTo-Json -Depth 5
```

Checker report test:

```powershell
$body = @{
  packetId = "BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01"
  checker = "Steven-Test-02"
  body = "Testing checker report after Sidecar cleanup patch."
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8787/api/checker-report" -Method Post -ContentType "application/json" -Body $body | ConvertTo-Json -Depth 5
```

Closeout test:

```powershell
$body = @{
  packetId = "BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01"
  summary = "Handshake Tools UI cleanup test complete."
  proof_paths = @(
    "AGENT_WORKSPACE/ACTIVE_PROJECTS/CLAIM_BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01_BY_Steven-Sidecar-Test-02.md",
    "AGENT_WORKSPACE/AGENT_REPORTS/NOTE_BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01_Steven-Sidecar-Test-02.md",
    "AGENT_WORKSPACE/CHECKER_REPORTS/CHECK_BBWAAS_AGENT_HANDSHAKE_PROTOCOL_01_Steven-Test-02.md"
  )
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8787/api/packet-close" -Method Post -ContentType "application/json" -Body $body | ConvertTo-Json -Depth 5
```

Verify paths:

```powershell
dir C:\Users\Sagou\Documents\BrainHub\00_MASTER_FRONT_DOOR\AGENT_WORKSPACE\ACTIVE_PROJECTS
dir C:\Users\Sagou\Documents\BrainHub\00_MASTER_FRONT_DOOR\AGENT_WORKSPACE\AGENT_REPORTS
dir C:\Users\Sagou\Documents\BrainHub\00_MASTER_FRONT_DOOR\AGENT_WORKSPACE\CHECKER_REPORTS
dir C:\Users\Sagou\Documents\BrainHub\00_MASTER_FRONT_DOOR\AGENT_WORKSPACE\COMPLETED
```

## Final output required from Hermes

- Exact files changed.
- Confirm server restarted.
- Confirm claims now write to ACTIVE_PROJECTS.
- Confirm Sidecar UI buttons added/working.
- Paste endpoint test results.
- Paste created proof paths.
- State PASS/WARN/FAIL.
