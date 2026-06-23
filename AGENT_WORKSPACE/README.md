# AGENT WORKSPACE — Shared Multi-Agent Registry

Every agent writes here first. Not into random folders.

## Structure

| Folder | Purpose |
|--------|---------|
| ACTIVE_PROJECTS | Current lane build sheets, status docs |
| AGENT_REPORTS | Agent status updates, completed work logs |
| PR_QUEUE | Pull requests awaiting human review |
| VISUAL_ASSETS | Images, designs, moodboards from Grok/GPT |
| PACKETS | Handoff packets between agents (GPT→Hermes, etc.) |
| CHECKER_REPORTS | Codex/security/regression review results |
| COMPLETED | Closed lanes, archived proofs |

## Rules

- No file = No commit = No artifact = No proof = Work not verified
- Always write to AGENT_WORKSPACE before using files elsewhere
- Reference paths, don't copy content
- PR_QUEUE items must include: agent name, branch name, what changed, what to review