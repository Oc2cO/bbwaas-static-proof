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

## GREEN / YELLOW — BBWAAS Sidecar

**Status:** V1 prototype created locally and Chrome extension loaded, but functional actions depend on local MCP server on port `8787`.

**Local path:**

```text
C:\Users\Sagou\Documents\BrainHub\bbwaas_sidecar_panel
```

**Observed files:**

```text
manifest.json
README.md
sidepanel.html
background.js may have been added manually if manifest references it
```

**Purpose:**

- Original local-first BBWAAS browser side panel.
- Not Sider-branded, not proprietary-cloned.
- Intended to route actions through local MCP and BrainHub/AGENT_WORKSPACE.

**V1 functions:**

- Gate In
- Lane Status
- Sync Status
- Iris Dashboard / Command Room links
- Compose Packet

**Current blocker:**

Sidecar buttons are nonfunctional unless the local MCP server is running:

```powershell
Test-NetConnection localhost -Port 8787
```

If false, start MCP from canonical path:

```powershell
cd C:\Users\Sagou\Documents\BrainHub\bbwaas_mcp_server
node server.js
```

If `server.js` is not found:

```powershell
Get-ChildItem C:\Users\Sagou\Documents\BrainHub -Recurse -Filter server.js | Select-Object FullName
```

## Current Priority Stack

1. **Preserve and stabilize public site** — done/green.
2. **Use Cloudflare as DNS control plane** — done/green.
3. **Avoid Namecheap hosting lock-in** — done operationally; cPanel backup still worth checking.
4. **Finish Sidecar MCP functionality** — next local step.
5. **Pin/organize current state across BBWAAS system** — this file is the GitHub proof/pin update.

## Next Recommended Work Packet

```text
BBWAAS WORK ORDER — SIDECAR MCP VERIFY 01

MODE:
LOCAL ONLY. NO SECRETS. NO API SPEND.

GOAL:
Make BBWAAS Sidecar buttons functional by confirming the local MCP server is running on localhost:8787 and that sidepanel.html calls the correct endpoints.

CHECKS:
1. Test-NetConnection localhost -Port 8787
2. Invoke-WebRequest http://localhost:8787/healthz
3. Start server from canonical BrainHub path if needed
4. Click GATE IN in Sidecar
5. Write one test packet through composer
6. Confirm packet lands in AGENT_WORKSPACE/PACKETS

DO NOT:
- Change DNS
- Buy hosting
- Use API credits
- Expose secrets
- Add broad Chrome permissions
```

## Closeout Note

The public website/domain lane is green. The remaining issue is local tooling, not DNS, not hosting, and not paid credits.
