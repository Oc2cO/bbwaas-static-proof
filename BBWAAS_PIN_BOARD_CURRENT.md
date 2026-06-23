# BBWAAS Pin Board Current

_Last updated: 2026-06-23_

## GREEN — Public Website / Domain / DNS

**Domain:** `oc2co.com`

**Current confirmed setup:**

- Registrar/address holder: Namecheap
- DNS control: Cloudflare Free
- Cloudflare nameservers:
  - `brenna.ns.cloudflare.com`
  - `paul.ns.cloudflare.com`
- Website hosting: GitHub Pages / free static hosting
- Root domain behavior: `https://oc2co.com` redirects to `https://www.oc2co.com/`
- `www` behavior: `https://www.oc2co.com` returns `HTTP/1.1 200 OK`
- Server observed: `GitHub.com`
- Namecheap Stellar hosting: not required for current live site
- API credits: not used by website hosting or DNS

**Verified PowerShell proof:**

```powershell
nslookup -type=ns oc2co.com 1.1.1.1
# oc2co.com nameserver = brenna.ns.cloudflare.com
# oc2co.com nameserver = paul.ns.cloudflare.com

curl.exe -I https://www.oc2co.com
# HTTP/1.1 200 OK
# Server: GitHub.com

curl.exe -I https://oc2co.com
# HTTP/1.1 301 Moved Permanently
# Location: https://www.oc2co.com/
# Server: GitHub.com
```

**Operating rule going forward:**

- DNS changes now happen in Cloudflare, not Namecheap Advanced DNS.
- Namecheap should be treated as registrar/address holder only.
- Do not buy or renew Namecheap Stellar hosting for the live site unless a backup/recovery need is found.
- Before letting Stellar fully expire, check whether any cPanel files, databases, backups, or old assets need to be exported.

## Cloudflare DNS Record Baseline

Cloudflare imported/kept the working records from Namecheap. Initial migration uses **DNS-only / gray cloud** mode for safety.

Expected baseline records:

```text
A      oc2co.com      185.199.108.153
A      oc2co.com      185.199.109.153
A      oc2co.com      185.199.110.153
A      oc2co.com      185.199.111.153
CNAME  www            oc2co.github.io
CNAME  mail           privateemail.com
CNAME  autoconfig     privateemail.com
CNAME  autodiscover   privateemail.com
MX     oc2co.com      mx1.privateemail.com
MX     oc2co.com      mx2.privateemail.com
SRV    _autodiscover._tcp 0 0 443 privateemail.com
TXT    oc2co.com      domain-verification=68cfae805d303213b279e2d7796d28afaa37055c042235260f6198350fba405a
TXT    oc2co.com      v=spf1 include:spf.privateemail.com ~all
```

**Proxy policy:**

- Keep all records DNS-only during initial stabilization.
- Never proxy email-related records: `mail`, `autoconfig`, `autodiscover`, `MX`, `TXT`, `SRV`.
- Later optional review: decide whether to proxy only web records after GitHub Pages/custom domain behavior is checked.

## GREEN — BBWAAS Sidecar / MCP

**Status:** V1 is now installed, clickable, connected to local MCP, and verified writing packets into `AGENT_WORKSPACE/PACKETS`.

**Local path:**

```text
C:\Users\Sagou\Documents\BrainHub\bbwaas_sidecar_panel
```

**Verified files:**

```text
manifest.json
background.js
README.md
sidepanel.html
sidepanel.js
sidepanel.backup.inline-js-20260623-163951.html
```

**Patch completed:**

- Removed inline `onclick=` handlers from `sidepanel.html`.
- Moved inline JavaScript into `sidepanel.js`.
- `sidepanel.html` now loads `sidepanel.js` with `<script src="sidepanel.js"></script>`.
- Chrome extension was reloaded.
- User confirmed a button worked after reload.

**Backend verification:**

```powershell
curl.exe http://localhost:8787/api/gate-in
# Returned JSON with active_lane, pin_board, source_of_truth, agent_workspace, grok_version, timestamp.
```

**Packet-write verification:**

User confirmed `AGENT_WORKSPACE/PACKETS` contains new Sidecar verification packets:

```text
SIDECAR_SIDECAR_USER_VERIFY_20260623_1782247510211.md
SIDECAR_SIDECAR_USER_VERIFY_20260623_1782247557523.md
SIDECAR_TEST_VERIFY_1782230525930.md
```

**Purpose:**

- Original local-first BBWAAS browser side panel.
- Not Sider-branded, not proprietary-cloned.
- Routes actions through local MCP and BrainHub/AGENT_WORKSPACE.

**V1 functions:**

- Gate In
- Lane Status
- Sync Status
- Iris Dashboard / Command Room links
- Compose Packet
- Write Packet

## Current Priority Stack

1. **Preserve and stabilize public site** — done/green.
2. **Use Cloudflare as DNS control plane** — done/green.
3. **Avoid Namecheap hosting lock-in** — done operationally; cPanel backup still worth checking.
4. **Sidecar packet-write verification** — done/green.
5. **Update local BrainHub pin/source files** — next, because local MCP gate-in is still reading older 2026-06-15 pin content.

## Next Recommended Work Packet

```text
BBWAAS WORK ORDER — LOCAL PIN SYNC 01

MODE:
LOCAL ONLY. NO SECRETS. NO API SPEND. NO DNS CHANGES.

GOAL:
Update the local BrainHub front-door / pin-board source files so MCP gate-in reflects the 2026-06-23 green state.

KNOWN GREEN STATE TO SAVE LOCALLY:
- Cloudflare DNS migration complete.
- Namecheap is registrar/address holder only.
- GitHub Pages free hosting confirmed live.
- oc2co.com redirects to www.oc2co.com.
- www.oc2co.com returns HTTP 200 from GitHub Pages.
- OpenAI/ChatGPT MCP tunnel connected in dev mode.
- Local MCP server on localhost:8787 responds to /api/gate-in.
- BBWAAS Sidecar Chrome extension loads, buttons click, and packet-write into AGENT_WORKSPACE/PACKETS is verified.

CHECKS:
1. Read the current local pin/front-door files.
2. Back them up before edits.
3. Add a dated 2026-06-23 green status section.
4. Do not delete old history unless explicitly instructed.
5. Run curl.exe http://localhost:8787/api/gate-in after update and confirm the new state appears.

DO NOT:
- Change DNS.
- Buy hosting.
- Use API credits.
- Expose secrets.
- Add broad Chrome permissions.
- Touch trading/wallet execution.
```

## Closeout Note

The public website/domain lane is green. Cloudflare DNS control is green. The local MCP backend is green. Sidecar UI click behavior is green. Sidecar packet-write is green. Next objective is syncing local BrainHub pin/source files forward from the older 2026-06-15 state.