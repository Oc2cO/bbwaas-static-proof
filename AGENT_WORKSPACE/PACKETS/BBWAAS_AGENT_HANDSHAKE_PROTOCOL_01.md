# BBWAAS AGENT HANDSHAKE PROTOCOL 01

**Status:** ACTIVE DRAFT
**Date:** 2026-06-23
**Purpose:** Define the first shared coordination protocol for GPT, Grok, Hermes, Codex, Claude, and Steven.

## Core rule

BBWAAS agents do not coordinate through loose chat as the source of truth. They coordinate through `AGENT_WORKSPACE` packets, reports, checks, and closeouts.

## Required lifecycle

Every meaningful work item follows this flow:

1. **GATE-IN**
   - Read current state first.
   - Use Sidecar/MCP, local BrainHub, or safe GitHub proof mirror depending on agent access.

2. **PACKET CREATED**
   - A scoped work packet is created in `AGENT_WORKSPACE/PACKETS`.
   - Packet must include mode, goal, boundaries, target paths, allowed actions, verification, and output requirements.

3. **AGENT CLAIMS PACKET**
   - Agent writes or returns a claim note with:
     - Agent name
     - Packet ID
     - Mode
     - Time
     - What it will do
     - What it will not do

4. **AGENT REPORT**
   - Agent output is saved as an `AGENT_REPORT`.
   - Reports must use:
     - STATUS
     - WHAT WAS DONE
     - FILES / PATHS / SOURCES
     - RISKS
     - NEXT ACTION

5. **CHECKER REVIEW**
   - GPT, Codex, Hermes, or another checker reviews the report.
   - Checker output must say PASS / WARN / FAIL.

6. **PROOF SAVED**
   - Proof goes to `COMPLETED`, `CHECKER_REPORTS`, or safe public GitHub if sanitized.

7. **PIN BOARD UPDATE**
   - The current state is updated only after proof exists.

8. **SYNC**
   - Public-safe summaries go to `bbwaas-static-proof`.
   - Private/full state goes to the future private core repo.

## Packet required fields

Each packet should include:

- Packet title / ID
- Status
- Owner
- Agent target
- Mode
- Goal
- Current known state
- Target paths
- Allowed actions
- Forbidden actions
- Verification steps
- Expected output
- Closeout criteria

## Agent roles

### Steven

- Human operator and approval authority.
- Uses Sidecar and chat to create, approve, and close lanes.
- Can override priority but should preserve one active lane where possible.

### GPT / ChatGPT

- Scopekeeper, packet writer, synthesis/checker, drift detector, GitHub proof writer.
- Can save public-safe proof into GitHub when connected.
- Must be honest when it cannot access local BrainHub directly.

### Grok / xAI

- Live research, alternate-view checker, strategy/audit lane, Grok Build planner.
- Starts read-only/planning-only.
- May produce `AGENT_REPORT` drafts.
- No secrets, deploys, paid calls, writes, or public actions without explicit approval.

### Hermes

- Local worker for file ops, Sidecar/MCP patches, local BrainHub updates, and implementation.
- Must obey packet boundaries.
- Must produce proof paths and avoid hidden broad actions.

### Codex

- Code checker, diff reviewer, exact patch verifier, PR/repo checker.
- Should provide PASS/WARN/FAIL with exact file/path issues.

### Claude

- Architecture/manual checker/coworker lane.
- Should work from packets and return structured reports.

## Communication rules

- No agent writes directly to final truth without a packet or proof.
- No agent receives secrets through chat.
- No agent gets arbitrary shell by default.
- No hidden deployment.
- No wallet/API/payment actions without explicit fuse approval.
- All agents should cite or name their source path/report when making claims.

## Public vs private sync

### Public proof repo

`Oc2cO/bbwaas-static-proof`

Allowed:

- Sanitized packets
- Public status
- DNS/website proof
- Safe Sidecar/MCP proof
- Redacted reports
- Static dashboards intended for public/safe visibility

Forbidden:

- Secrets
- Tokens
- Wallets
- `.env`
- Raw trade/swarm/router files
- Personal/private logs
- Full BrainHub mirrors

### Private core repo

Future repo.

Purpose:

- Full BrainHub sync
- Private reports
- Agent internals
- Local tools
- Network stack notes
- Non-public packets

Must still exclude secrets and credentials.

## Closeout rule

A lane is not green until:

1. Work completed.
2. Proof exists.
3. Checker reviewed.
4. Pin board updated.
5. Sync status known.

## Next implementation packet

`BBWAAS_AGENT_HANDSHAKE_TOOLS_01`

Goal: Add MCP/Sidecar endpoints for open packets, claim packet, post agent note, checker report, close packet, and Git status.
