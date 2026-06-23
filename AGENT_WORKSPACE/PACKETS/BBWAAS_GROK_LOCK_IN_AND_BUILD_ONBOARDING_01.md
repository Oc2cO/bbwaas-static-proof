# BBWAAS GROK LOCK-IN AND BUILD ONBOARDING 01

**Status:** ACTIVE PACKET
**Date:** 2026-06-23
**Owner:** Steven / BBWAAS
**Primary agent target:** Grok / xAI
**Supporting agents:** ChatGPT, Hermes, Codex, Claude

## Purpose

Bring Grok/xAI into BBWAAS as a controlled agent lane with clear handshakes, saved work packets, and no secret leakage.

This is not a broad-permission install lane. The first objective is to map what Grok currently has access to, verify the safe paths, and define how Grok Build and any xAI/AI Gateway tools will participate in BBWAAS without bypassing Sidecar, MCP, GitHub, or Steven approval.

## Current BBWAAS foundation

- Public website/DNS lane: GREEN.
- Cloudflare DNS control: GREEN.
- GitHub Pages public proof hosting: GREEN.
- Local MCP server on localhost:8787: GREEN.
- BBWAAS Sidecar button behavior and packet writing: GREEN.
- Local Git authentication as Oc2cO: GREEN.
- Public proof repo has safety ignores for secrets, trade/swarm/router artifacts, and private folders.

## Grok lane goals

1. Identify every Grok/xAI surface Steven currently has:
   - Grok chat / X interface.
   - xAI Console.
   - API keys.
   - Domain verification.
   - Grok Build early-access tools.
   - ngrok AI Gateway or endpoint experiments.

2. Decide which surfaces are useful for BBWAAS:
   - Research scout.
   - Alternate-view checker.
   - UI/build idea generator.
   - Code/build worker only inside approved repo/folder lanes.
   - Agent report writer into AGENT_WORKSPACE.

3. Define the handshake pattern:
   - Packet created in Sidecar or GitHub.
   - Grok receives packet text.
   - Grok returns report, patch plan, or build output.
   - Report is saved to AGENT_WORKSPACE/AGENT_REPORTS.
   - Codex/GPT/Hermes checks before merge/deploy.
   - Public-safe proof goes to bbwaas-static-proof.
   - Private core work goes to private repo once created.

## Immediate safety rules

- Do not paste xAI API keys, ngrok authtokens, GitHub tokens, wallet keys, or private credentials into chat.
- Do not store secrets in BrainHub packets, public GitHub, screenshots, or docs.
- Do not let Grok Build deploy, bill, message, trade, or post publicly without explicit approval.
- Do not expose local MCP publicly without auth.
- Do not connect ngrok AI Gateway to paid/provider calls until billing and limits are confirmed.
- Keep Grok lane packet-based, not chaotic group-chat based.

## First verification checklist

- [ ] Confirm xAI console domain verification status for www.oc2co.com.
- [ ] Confirm whether xAI API key exists, without revealing it.
- [ ] Confirm whether Grok Build has repo/file access or only chat/build UI.
- [ ] Confirm whether ngrok endpoint is required or optional for this lane.
- [ ] Confirm current ngrok billing warning before relying on ngrok for persistent routing.
- [ ] Confirm Grok can read a packet and return a structured AGENT_REPORT.
- [ ] Save first Grok report under AGENT_WORKSPACE/AGENT_REPORTS.

## First Grok prompt

Use this as the first packet prompt inside Grok/Grok Build:

```text
BBWAAS GROK ROLE CHECK 01

You are being onboarded as the Grok/xAI lane inside BBWAAS.

Mode: READ ONLY / PLANNING ONLY.
No secrets. No tokens. No wallets. No public posting. No deploys. No paid API calls. No file edits unless explicitly approved later.

Current BBWAAS foundation:
- Cloudflare DNS and GitHub Pages public site are green.
- Local MCP server responds on localhost:8787.
- BBWAAS Sidecar works and writes packets.
- GitHub public proof repo exists with safety ignores.

Your task:
1. State what role Grok should play in BBWAAS.
2. List what you need from Steven to connect safely.
3. List what you should not be allowed to do yet.
4. Propose the first three safe Grok tasks.
5. Return your answer as AGENT_REPORT format with:
   - STATUS
   - ROLE
   - NEEDED ACCESS
   - BOUNDARIES
   - FIRST TASKS
   - RISKS
   - NEXT ACTION
```

## Next BBWAAS action

Run Grok Role Check 01, then save Grok's reply as:

`AGENT_WORKSPACE/AGENT_REPORTS/GROK_BBWAAS_GROK_ROLE_CHECK_01_REPORT.md`

Then run checker review before giving Grok write/deploy permissions.
