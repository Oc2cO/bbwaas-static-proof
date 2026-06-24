# BBWAAS SHARED WORKSPACE AND CREATIVE STUDIO RESEARCH 01

**Date:** 2026-06-24
**Status:** OPEN
**Mode:** Research / architecture / phased build plan
**Risk:** Medium
**Public-safe:** Yes

## Gate-in statement
Steven wants the Sidecar / Command Room to become more than a status dashboard. He wants a shared work page where Steven and agents can talk, research, bounce ideas, create visuals, sketch, upload images, explain work, and route tasks through BBWAAS.

## User direction
- Create a UI page / workspace where Steven and agents can work together.
- It should support conversation, research, brainstorming, and packet work.
- It should include workshop-style pages, such as:
  - Animation workshop
  - Visual/image workshop
  - Coding / inner workings workshop
  - Drawing/sketching with mouse or pencil-style tools
  - Upload images and annotate/explain what needs to be done
  - Static image to animated direction/workflow
- Agents should be able to see shared work, add reports, explain steps, and continue tasks through the BBWAAS packet system.

## Initial difficulty assessment
This is very achievable if phased correctly.

### Easy V1
- Add pages/tabs in Sidecar.
- Add shared notes, packet thread, upload references, simple sketch pad, activity log.
- Save everything to AGENT_WORKSPACE.

### Medium V2
- Add real visual workspace features: canvas drawing, image annotation, asset boards, prompt-to-task routing, static-to-animation planning.
- Add clear agent assignment and proof output.

### Hard V3
- True multi-user realtime collaboration with simultaneous cursors, auth, permissions, cloud sync, live agent presence, and external generation tools.

## Recommended architecture
Do not build this as random chat first. Build it as a packet-centered workroom.

Core objects:
- Workspace
- Project
- Packet
- Thread
- Asset
- Sketch
- Task
- Agent Report
- Checker Report
- Closeout

## Proposed modules
1. Command Room Home
2. Research Room
3. Visual Studio
4. Animation Workshop
5. Code Workshop
6. Asset Board
7. Packet Thread
8. Agent Board
9. Proof / Closeout panel

## Safety guardrails
- No TRADE / SWARM / ROUTER execution from creative workspace.
- No wallet, token, .env, private key, or credential access.
- No paid API call execution without explicit approval.
- Visual generation may create prompts/specs first; actual generation should require approval.
- Uploads must be treated as workspace assets, not automatically published.

## First build target
Create a Sidecar tab called `Studio` with:
- New Project
- New Research Packet
- New Visual Task
- Upload Reference
- Sketch Pad
- Asset Board
- Agent Thread
- Create Work Packet
- Save to AGENT_WORKSPACE/VISUAL_ASSETS and AGENT_WORKSPACE/PACKETS

## Next action
Prepare a Hermes/Grok patch packet for `BBWAAS_SIDECAR_STUDIO_WORKSPACE_04`, scoped to local files only, no public deploy, no secrets, no external paid APIs.
