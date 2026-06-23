# BBWAAS BIDIRECTIONAL GITHUB SYNC AND AGENT HANDSHAKE 01

**Date:** 2026-06-23
**Status:** ACTIVE WORK PACKET
**Owner:** Steven / BBWAAS
**Mode:** Build the real shared operating system, not scattered chat lanes.

---

## Goal

Make BBWAAS work flow both ways between local BrainHub and GitHub so every agent can see the same source-of-truth, write scoped work packets, handshake on ownership, and push proof back into the system.

This is the next system layer after today’s green milestones:

- Cloudflare DNS is now active for `oc2co.com`.
- GitHub Pages is serving the public website.
- ChatGPT MCP tunnel is connected in development mode.
- Local MCP server on port `8787` is responding.
- BBWAAS Sidecar loads in Chrome and the GATE IN button works.
- Sidecar packet write has been verified into local `AGENT_WORKSPACE/PACKETS`.

---

## Canonical truth rule

There are two mirrors, but only one lane decision at a time.

### Local truth

`C:\Users\Sagou\Documents\BrainHub\00_MASTER_FRONT_DOOR\AGENT_WORKSPACE`

Local BrainHub is the working truth for live machine operations, agent packets, proof files, and command-room state.

### GitHub truth mirror

`Oc2cO/bbwaas-static-proof`

GitHub is the cloud mirror, proof layer, public/static-safe sync target, and cross-agent readable source.

### Never sync secrets

Do not sync `.env`, private keys, wallet keys, API keys, tokens, cookies, credentials, raw browser sessions, or private personal notes.

---

## Required synced folders

Mirror these local folders into GitHub-safe equivalents:

- `AGENT_WORKSPACE/PACKETS/`
- `AGENT_WORKSPACE/AGENT_REPORTS/`
- `AGENT_WORKSPACE/CHECKER_REPORTS/`
- `AGENT_WORKSPACE/PR_QUEUE/`
- `AGENT_WORKSPACE/NETWORK_STACK/`
- `AGENT_WORKSPACE/COMPLETED/`
- `AGENT_WORKSPACE/README.md`
- `BBWAAS_PIN_BOARD_CURRENT.md`
- command-room status files that are safe for static hosting

Park or exclude anything sensitive.

---

## Agent handshake model

Every agent work item should follow this handshake:

1. **Packet created** in `PACKETS/`.
2. **Agent claims** work by creating or updating a report in `AGENT_REPORTS/`.
3. **Agent writes proof** into `CHECKER_REPORTS/`, `PR_QUEUE/`, or `COMPLETED/`.
4. **Checker verifies** the proof.
5. **Pin board updates** with final status.
6. **GitHub mirror syncs** the safe result.

No hidden drift. No unsaved chat-only decisions.

---

## Agent roles

### GPT / ChatGPT

- Scopekeeper
- Packet writer
- Status synthesizer
- Drift detector
- Connector/GitHub updater
- Gate-in narrator

### Grok

- Research scout
- Live/current context scout
- UI/design critic
- Trend scan lane
- Local BrainHub/GitHub aware worker when connected

### Hermes

- Local builder
- WSL/PowerShell/file operations
- MCP/server runner
- Sidecar/local app patcher
- Proof collector

### Codex

- Code reviewer
- Exact patch verifier
- PR checker
- Build/test report reviewer

### Claude

- Architecture reviewer
- Larger reasoning/checker packets
- Manual coworker when routed by Steven

---

## Immediate implementation path

### Step 1 — Local git sync lane

Create or verify a local git working copy that maps the GitHub repo:

`C:\Users\Sagou\Documents\BrainHub\bbwaas-static-proof`

Then create a sync script that copies safe BrainHub files into that repo and commits/pushes.

### Step 2 — Pull lane

Create a pull/sync-back script that pulls GitHub changes down and copies safe updated files back into local BrainHub.

### Step 3 — Sidecar buttons

Add Sidecar buttons later:

- `PUSH SAFE MIRROR`
- `PULL SAFE MIRROR`
- `AGENT HANDSHAKE`
- `CLAIM PACKET`
- `CLOSE PACKET`

These must call MCP tools, not broad shell access.

### Step 4 — Agent dashboard

Update the command room to show:

- Current packet queue
- Claimed by which agent
- Last report
- Last proof
- GitHub sync status
- Local sync status
- Green/yellow/red lane state

---

## Guardrails

- No broad machine control through public website.
- No public MCP endpoint without auth.
- No hidden GitHub Pages admin backend.
- Use OpenAI MCP tunnel for ChatGPT-to-local private tools.
- Use Cloudflare Access only if creating protected web admin surfaces later.
- All writes need packet/proof trail.
- Sidecar/MCP tools stay narrow.

---

## Next packet

`BBWAAS_LOCAL_GITHUB_SAFE_SYNC_SCRIPT_01`

Goal: build the local PowerShell/Node safe sync scripts that push and pull only approved folders between BrainHub and GitHub.

