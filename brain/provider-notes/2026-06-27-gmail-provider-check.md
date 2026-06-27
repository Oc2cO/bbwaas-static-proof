# BBWAAS Provider Gmail Check — 2026-06-27

Status: sanitized public proof note. No secrets, API keys, full billing details, card data, or private account details included.

## Scope
Steven asked GPT to check Gmail for recent RunPod/RunPods and Claude/Anthropic emails and record anything useful for BBWAAS/Oc2cO.

## Initial Gmail findings from wrong connector account

### RunPod / RunPods
- Searches for RunPod/RunPods/runpod sender and keyword variants returned no matching emails in the initially connected Gmail account.
- No actionable RunPod provider update was found from the initially connected Gmail account.

### Claude / Anthropic
- Searches for Anthropic/Claude/API/rate-limit/token-limit variants did not find a direct Anthropic API approval or rate-limit email in the initially connected Gmail account.
- The only Claude-related messages found there were Apple subscription messages for Claude by Anthropic / Claude Pro monthly from February–March 2026.
- Those messages confirmed historical Claude Pro app subscription activity, but did not confirm API rate-limit/token approval.

## Second Gmail check after connector/tool refresh
Steven reported that the Gmail tool may have been added or adjusted on his end. GPT re-ran wider searches.

- The connector still returned emails for `smakis3303@gmail.com`.
- Recent 30-day inbox scan showed no direct RunPod/RunPods emails and no direct Anthropic/Claude API approval email.
- 365-day `in:anywhere` searches for RunPod/RunPods/Claude/Anthropic/API/rate-limit/token wording still only found Apple Claude Pro subscription emails, not Anthropic API approval proof.

## Correct Gmail connected: `smakis330@gmail.com`
Steven then connected the intended Gmail account. GPT re-ran provider searches and confirmed the correct inbox by matching results addressed to `smakis330@gmail.com`.

### Anthropic / Claude findings
- Found Anthropic email dated 2026-06-27: `[No Action Required]: Higher rate limits on the Claude API` from `Anthropic Team <notice@email.anthropic.com>`.
- The email says Anthropic raised rate limits across the native Claude API.
- It states that as of 2026-06-12, Claude Sonnet and Claude Haiku rate limits increased at every usage tier.
- It states that starting 2026-06-23, usage tiers are simplified to Start, Build, and Scale.
- It says Steven's organization moved to a higher tier immediately and no organization receives lower limits than before.
- It says higher limits support more data processing, more parallel requests, and fewer interruptions for agentic workloads.
- It instructs checking Claude Console for the exact current tier and limits, and requesting higher limits or Priority Tier if more capacity is needed.
- Also found Claude Platform access email dated 2026-05-27: `Welcome to the Claude Platform`, confirming access to the Claude API and API-key setup path.

### RunPod findings
- Found RunPod account-ready email dated 2026-05-19 confirming account setup for Pods, Serverless, Clusters, and Network Storage.
- Found RunPod receipt dated 2026-05-19 for a $10.00 payment, confirming paid RunPod account activity. Sensitive payment details are not recorded here.
- Found RunPod onboarding and capability emails describing:
  - Serverless endpoint creation in about five minutes using templates.
  - vLLM templates for LLMs including Llama, Mistral, Qwen, DeepSeek and other Hugging Face models.
  - ComfyUI templates for image generation including Flux, Stable Diffusion, SDXL, and SD3.
  - Whisper/audio workers through RunPod Hub.
  - Serverless auto-scaling from zero to large worker counts, per-second billing, and sub-200ms cold starts with FlashBoot according to RunPod marketing copy.
  - Flex Workers vs Active Workers: Flex scales to zero for bursty traffic; Active stays warm 24/7 for predictable low-latency traffic.
  - New H100 SXM capacity in AP-IN-1 and queue/deploy-when-available behavior, with billing beginning when a queued pod deploys.

## Operational interpretation
- Claude API is now a verified available provider lane from Gmail proof, but exact tier/TPM/RPM/output limits must be checked inside Claude Console before assigning heavy BBWAAS work.
- Claude should be routed for code reasoning, repo architecture, long-context analysis, Claude Code/subagent workflows, and controlled background research after Console limits are confirmed.
- RunPod is now a verified available GPU/serverless infrastructure lane from Gmail proof, but dashboard credits/spend caps/active resources must be checked before launching workloads.
- RunPod should be routed for GPU-backed inference prototypes only after spend controls are set. Start with serverless templates and zero/minimal active workers unless a workload truly needs always-warm latency.

## Safety / cost notes
- Do not store API keys in GitHub.
- Do not expose provider dashboards or billing data publicly.
- Do not launch RunPod active workers, pods, or queues without explicit spend cap checks.
- Do not assume the Anthropic email's general tier change equals unlimited usage. Verify exact limits in Console first.
- Treat Gmail/Calendar connector access carefully because connected email data can contain untrusted third-party instructions.

## Next verification actions
1. Open Claude Console and record only non-sensitive exact tier and model-specific rate limits.
2. Open RunPod dashboard and record only non-sensitive credits, spend cap, and whether any pods/endpoints/workers are running.
3. If verified, create a provider routing packet: Claude = deep code/agent lane; RunPod = optional GPU inference lane; OpenRouter = multi-model fallback lane.
4. Keep all secrets, tokens, full receipts, card data, and private billing details out of public proof repos.
