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

**Status:** V1 prototype is loaded as a Chrome extension and the first button click has been verified by the user.

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

## Current Priority Stack

1. **Preserve and stabilize public site** — done/green.
2. **Use Cloudflare as DNS control plane** — done/green.
3. **Avoid Namecheap hosting lock-in** — done operationally; cPanel backup still worth checking.
4. **Finish Sidecar packet-write verification** — active next local step.
5. **Update local BrainHub pin/source files** — needed because local MCP gate-in is still reading older 2026-06-15 pin content.

## Next Recommended Work Packet

```text
BBWAAS WORK ORDER — SIDECAR PACKET VERIFY 01

MODE:
LOCAL ONLY. NO SECRETS. NO API SPEND.

GOAL:
Verify that BBWAAS Sidecar can write a real packet into AGENT_WORKSPACE/PACKETS through the local MCP create_packet flow.

CHECKS:
1. Open BBWAAS Sidecar in Chrome.
2. Click GATE IN and confirm visible status updates.
3. Use composer with title: SIDECAR_USER_VERIFY_20260623.
4. Body: Sidecar button patch complete. Gate-in works from Chrome extension and MCP is reachable on localhost:8787. Cloudflare DNS migration is complete. Public site is live on GitHub Pages.
5. Click WRITE PACKET.
6. Confirm packet lands in AGENT_WORKSPACE/PACKETS.

DO NOT:
- Change DNS
- Buy hosting
- Use API credits
- Expose secrets
- Add broad Chrome permissions
```

## Closeout Note

The public website/domain lane is green. Cloudflare DNS control is green. The local MCP backend is green. Sidecar UI click behavior is now green. Next objective is packet-write verification and then syncing the local BrainHub pin board forward from the older 2026-06-15 state.
