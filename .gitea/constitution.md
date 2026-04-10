# Homeserver Constitution
## mmastro.dev — Global Rules and Architecture Reference

This document is the authoritative reference for the mmastro.dev homeserver.
All configuration decisions, service additions, and operational changes must be consistent with the rules defined here.

---

## 1. Infrastructure Identity

| Property | Value |
|---|---|
| Domain | `mmastro.dev` |
| OS | Debian bookworm |
| Storage pool | ZFS at `/tank` |
| Docker compose root | `/srv/` |
| Static site root | `/var/www/html/mastrosite` |
| Reverse proxy | Caddy 2.9+ with `caddy-dns/cloudflare` plugin |
| Auth sidecar | oauth2-proxy v7.6.0 (Docker, `localhost:4180`) |
| OIDC provider | Pocket ID v2 (self-hosted, passkey-only, `login.mmastro.dev`) |
| DNS / CDN | Cloudflare (mixed orange/grey per service) |
| TLS | Let's Encrypt via DNS-01 (`caddy-dns/cloudflare` plugin) |
| Container runtime | Docker + Docker Compose |
| Internal Docker network | `homenet` (external, shared across all stacks) |

---

## 2. Immutable Rules

These rules must never be broken. They exist to prevent security incidents.

**R1 — caddy-security is banned.**
The `caddy-security` plugin has 10+ unpatched CVEs. Authentication is handled exclusively via `forward_auth` → oauth2-proxy. Do not install or reference this plugin.

**R2 — Caddy admin API is disabled.**
`admin off` is set in the global Caddyfile block. Caddy is managed via file edits and `systemctl reload caddy` only. Never enable the admin API.

**R3 — All TLS is handled by Caddy.**
No upstream container exposes HTTPS. All containers receive plain HTTP on loopback. Caddy terminates TLS for all subdomains using DNS-01 challenges via the Cloudflare API.

**R4 — All container ports bind to loopback only.**
Every `ports:` entry in a docker-compose file must use `127.0.0.1:HOST_PORT:CONTAINER_PORT`. Binding to `0.0.0.0` bypasses both Caddy and the firewall — it is never acceptable unless explicitly documented with a security justification.

**R5 — `login.mmastro.dev` and `auth.mmastro.dev` must never have an auth wrapper.**
Wrapping them would cause infinite redirect loops. They are the auth system itself.

**R6 — Admin tier IP check runs before OIDC.**
Untrusted IPs receive a `403` immediately and never see the Pocket ID login page. This prevents login page enumeration and brute-force attempts from outside trusted networks.

**R7 — No secrets in documentation or config files committed to Git.**
Use `[PLACEHOLDER — NOT SET]` in documentation and environment variable references in compose files. Never hardcode API tokens, client secrets, or cookie secrets.

---

## 3. Network Trust Tiers

Every service must be assigned to exactly one trust tier. The tier determines what authentication is required to access the service.

| Tier | Label | Auth requirement | Who can access |
|---|---|---|---|
| 0 | **None** | No gate — service handles its own auth or is public | Anyone on the internet |
| 1 | **Standard** | oauth2-proxy OIDC session (Pocket ID) | Any authenticated Pocket ID user |
| 2 | **Admin** | oauth2-proxy OIDC session **+ LAN/VPN IP check** | Authenticated user on trusted network only |

### Trusted IP Ranges (Admin Tier)

| Network | Range | Status |
|---|---|---|
| Home LAN (Fritz!Box) | `192.168.178.0/24` | ✅ Active |
| Fritz!Box WireGuard VPN | `10.0.0.0/8` | ⚠️ Placeholder — update to actual subnet when WireGuard is configured |

> **Important:** The WireGuard range is a broad placeholder. Once Fritz!Box WireGuard is configured, replace `10.0.0.0/8` with the actual assigned subnet (typically `10.0.0.0/24` or similar) in both the Caddyfile `require_auth_admin` snippet and this document.

---

## 4. Service Inventory

| Subdomain | Service | Port | CF mode | Auth tier | Status |
|---|---|---|---|---|---|
| `login.mmastro.dev` | Pocket ID v2 | 1411 | Orange | None | ✅ ACTIVE |
| `auth.mmastro.dev` | oauth2-proxy v7.6.0 | 4180 | Orange | None | ✅ ACTIVE |
| `mmastro.dev` / `www` | Static site | static files | Orange | None | ✅ ACTIVE |
| `blog.mmastro.dev` | Hugo blog | 8000 | Orange | None | ✅ ACTIVE |
| `cv.mmastro.dev` | CV site | 8001 | Orange | None | ✅ ACTIVE |
| `git.mmastro.dev` | Gitea | 3000 | Grey | Admin | ✅ ACTIVE — OIDC redirect active, network gate not yet enforced |
| `photos.mmastro.dev` | Immich | 2283 | Grey | Standard | ⚠️ PARTIAL — auth gate not yet active |
| `budget.mmastro.dev` | Actual Budget | 5006 | Orange | Standard | ✅ ACTIVE — native OIDC via Pocket ID |
| `mail.mmastro.dev` | MailHog | 8025 | Grey | Admin | ✅ ACTIVE — OIDC + IP check enforced |
| `memos.mmastro.dev` | Memos | 5230 | Orange | Standard | ⚠️ PARTIAL — auth gate not yet active |
| `drive.mmastro.dev` | Paperless-ngx | 8010 | Orange | Standard | ✅ ACTIVE — native OIDC via Pocket ID, oauth2-proxy gate active |
| `wiki.mmastro.dev` | This wiki (mdBook) | 1240 | Grey | Admin | ✅ ACTIVE |
| `dns.mmastro.dev` | AdGuard Home | 8088 | Grey | Admin | ✅ ACTIVE |
| N/A | Postfix | 587 (internal) | N/A | N/A | ✅ ACTIVE — sends to MailHog |
| N/A | Gitea act-runner | — | N/A | N/A | ✅ ACTIVE |
| `matrix.mmastro.dev` | Matrix | TBC | — | Standard | 🔲 PLANNED — do not implement until requested |
| `logseq.mmastro.dev` | Logseq | TBC | — | Standard | 🔲 PLANNED — do not implement until requested |
| `vw.mmastro.dev` | Vaultwarden | 11001 | — | — | ❌ REMOVED — data backed up |

---

## 5. Cloudflare Mode Rules

| Mode | What Caddy sees as `remote_addr` | Real-IP source | Use for |
|---|---|---|---|
| Orange (proxied) | Cloudflare edge IP | `CF-Connecting-IP` header (restored by `trusted_proxies cloudflare`) | Services where CF edge caching/WAF is acceptable; hides server IP |
| Grey (DNS only) | Real client IP directly | `remote_addr` | Services needing Admin tier IP check; large uploads (no CF size limits); Gitea SSH |

**Rule:** Any service using `require_auth_admin` (IP check) **must** be on grey cloud (DNS only) **or** behind split DNS resolving to the LAN IP. Proxied services route through Cloudflare, which replaces the client IP with a Cloudflare edge IP — making the LAN IP check impossible.

**Split DNS:** AdGuard Home is deployed at `192.168.178.[SERVER_IP]` and handles DNS rewrites for all `*.mmastro.dev` subdomains, returning the server's LAN IP. This ensures LAN clients connect directly to the server for admin-tier services, bypassing Cloudflare.

---

## 6. Port Assignments

| Port | Service | Bound to |
|---|---|---|
| 53 TCP/UDP | AdGuard Home (DNS) | `0.0.0.0` (must be, for DNS) |
| 587 | Postfix (internal relay) | `127.0.0.1` |
| 1240 | Wiki (mdBook) | `127.0.0.1` |
| 1411 | Pocket ID | `127.0.0.1` |
| 2283 | Immich | `127.0.0.1` |
| 3000 | Gitea web | `127.0.0.1` |
| 222 | Gitea SSH | `0.0.0.0` (required for git push over SSH) |
| 4180 | oauth2-proxy | `127.0.0.1` |
| 5006 | Actual Budget | `127.0.0.1` |
| 5230 | Memos | `127.0.0.1` |
| 8000 | Hugo blog | `127.0.0.1` |
| 8001 | CV site | `127.0.0.1` |
| 8010 | Paperless-ngx | `127.0.0.1` |
| 8025 | MailHog web | `127.0.0.1` |
| 8088 | AdGuard Home admin UI | `127.0.0.1` |

---

## 7. Storage Layout

| Path | Contents | Service |
|---|---|---|
| `/tank/` | ZFS pool root | — |
| `/tank/docs/paperless/` | Paperless-ngx documents (data, media, export, consume) | Paperless-ngx |
| `/var/www/html/mastrosite/` | Static main site files | mmastro.dev |
| `/srv/` | All Docker Compose stacks | All containerised services |

---

## 8. Key Architectural Decisions

**D1 — oauth2-proxy as the auth gate, not caddy-security.**
All OIDC protection is implemented via Caddy's `forward_auth` directive pointing to oauth2-proxy. This is the only supported approach. See Rule R1.

**D2 — Pocket ID is passkey-only.**
No passwords. All authentication is through passkeys. This applies to both the oauth2-proxy gate and native OIDC integrations.

**D3 — Services with native OIDC do not prompt twice.**
Gitea, Actual Budget, and Paperless-ngx maintain their own native OIDC sessions with Pocket ID. When a user has already authenticated through oauth2-proxy, Pocket ID recognises the active session and returns the token silently — no second login prompt.

**D4 — Gitea auth model: OIDC redirect, no header injection.**
Caddy intercepts `GET /user/login` and redirects to `/user/oauth2/pocket-id`. Gitea completes the OIDC handshake natively. Header injection (`X-Webauth-User`) was considered and abandoned — Gitea's native OIDC is more robust and doesn't require trusting forwarded headers.

**D5 — Actual Budget TLS removed.**
The upstream container was originally configured with Cloudflare Origin CA certs. After migration to Caddy, TLS is handled entirely by Caddy. The container runs plain HTTP on port 5006.

**D6 — fail2ban applies to grey-cloud services only.**
On orange-cloud (proxied) services, `remote_addr` is a Cloudflare edge IP — banning it would ban all users. fail2ban targets grey-cloud services only (`mail.mmastro.dev`, `git.mmastro.dev`). Use Cloudflare WAF rate limiting for orange-cloud services instead.

**D7 — DNS-01 is used for all TLS certificates.**
This allows cert issuance for both orange-cloud and grey-cloud subdomains without HTTP-01 challenges. Requires a Cloudflare API token with Zone → DNS → Edit permissions.
