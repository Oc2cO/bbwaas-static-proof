# BBWAAS Hosting Pivot Check — 2026-06-27

Status: sanitized public proof note. No secrets, login links, payment links, API keys, card data, or private billing details included.

## Scope
Steven asked GPT to review a Yahoo email from ZipWP and help reduce confusion caused by too many Oc2cO website copies, hosts, repos, and DNS targets.

## User-provided ZipWP email
Steven pasted a ZipWP email from Vijay at ZipWP. The email says:
- AI tools like Claude, ChatGPT, and other agents can create websites quickly.
- ZipWP now lets users host HTML, PHP, and AI-generated websites without setting up WordPress.
- Users can upload website files directly to ZipWP and get a live link in seconds.
- AI tools such as Claude or Cursor can connect to ZipWP and publish sites through MCP.
- The guide covers file upload, MCP connection, supported website types, hosting limits, pricing, and common questions.

## Live web verification
Official ZipWP documentation confirms:
- ZipWP can upload and host static HTML/CSS/JavaScript sites, self-contained PHP, images, fonts, audio, video, PDFs, and common file types.
- Zip uploads accept `.zip` archives with site files and single `.html` files.
- Limits shown in the doc: 20 MB compressed / 80 MB uncompressed for zip archives, and 10 MB for a single HTML file.
- `index.html` or `index.php` should be at the top level of the archive, though common build folders like `dist`, `build`, `out`, or `public` may be detected automatically.
- ZipWP can replace files while keeping the same URL, download current files as a `.tar.gz`, clone a site, and connect a custom domain with SSL.
- ZipWP documents MCP static-site tools: `create-static-site` and `replace-static-site-files`.
- ZipWP says MCP tools can accept a file map, base64 archive, or public URL pointing to a `.zip` file.
- ZipWP says unsupported items include Node.js SSR/server frameworks and database connections; static exports are acceptable.
- ZipWP official site also confirms AI Agent with MCP, WordPress managed hosting, site portability, blueprints, and agency hosting tools.

## Current Oc2cO hosting/DNS picture from Gmail and prior memory
- Cloudflare email dated 2026-06-23 says `oc2co.com` is active on Cloudflare Free plan.
- Current Cloudflare nameservers listed in the email: `brenna.ns.cloudflare.com` and `paul.ns.cloudflare.com`.
- Previous nameservers listed: Namecheap registrar nameservers `dns1.registrar-servers.com` and `dns2.registrar-servers.com`.
- This suggests Namecheap is likely registrar while Cloudflare is DNS control.
- Prior saved context says `oc2co.com` uses Namecheap as registrar, Cloudflare DNS, and GitHub Pages serving the site as of 2026-06-23.
- Polsia emails show `oc2coos-2.polsia.app` was used for the OC2CO landing page and app/backend work.
- Polsia payment/subscription failure emails show the Polsia subscription ended on 2026-06-07 and scheduled tasks were paused.
- Bubble emails from March 2026 show there was prior `www.oc2co.com` DNS confusion for a Bubble app.

## Operational interpretation
- ZipWP is useful as a fast publishing/testing lane for static HTML/PHP/AI-generated landing pages.
- ZipWP should not become the main BrainHub source of truth.
- ZipWP should not replace GitHub as code/version control.
- ZipWP should not replace Cloudflare as DNS control unless deliberately chosen.
- Polsia should be treated as inactive/paused until dashboard status is verified.
- GitHub Pages still appears to be the cleanest public static-site source if the current Oc2cO website is already connected there.
- Cloudflare should remain the DNS control layer unless there is a specific reason to move it.
- Namecheap should remain registrar unless the domain is transferred deliberately.

## Proposed one-source-of-truth model
- Registrar: Namecheap
- DNS/CDN/security: Cloudflare
- Code source: GitHub repo only
- Public company site host: GitHub Pages first, or ZipWP static host only if chosen after audit
- WordPress/client-site demos: ZipWP
- Backend/app/runtime: separate backend host only when needed
- Private agent brain: local BrainHub / bbwaas-core / Sidecar
- Public sanitized proof: bbwaas-static-proof

## Immediate decision rule
No more new hosts should be attached to `oc2co.com` until the website inventory is complete.

## Next read-only audit
1. Identify every current Oc2cO website copy and URL.
2. Identify which repo/folder/source generates each site.
3. Identify Cloudflare DNS records for apex and `www`.
4. Identify which host currently serves `oc2co.com` and `www.oc2co.com`.
5. Identify stale Polsia/Bubble/ZipWP/GitHub links.
6. Choose one live public site and one staging lane.
7. Park or delete old references only after proof.
