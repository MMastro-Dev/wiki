# mmastro.dev Homeserver — Copilot Instructions

## Infrastructure

- **Domain:** `mmastro.dev` — Debian bookworm host
- **Reverse proxy:** Caddy 2.9+ with `caddy-dns/cloudflare` plugin
- **Auth:** oauth2-proxy v7.6.0 (`localhost:4180`) → Pocket ID v2 (`login.mmastro.dev`, passkey-only)
- **TLS:** All via Caddy, DNS-01 challenge through Cloudflare API. No containers expose HTTPS.
- **Docker compose root:** `/srv/<service-name>/docker-compose.yml`
- **Docker network:** `homenet` (external, shared across all stacks)
- **Storage:** ZFS at `/tank`, documents at `/tank/docs/paperless/`
- **Static site:** `/var/www/html/mastrosite/`
- **DNS (split):** AdGuard Home rewrites `*.mmastro.dev` → server LAN IP for local clients

## Immutable Rules

1. **Never use caddy-security plugin** — 10+ unpatched CVEs. Auth is `forward_auth` → oauth2-proxy only.
2. **Caddy admin API is disabled** (`admin off`). Manage via `systemctl reload caddy` and file edits.
3. **All container ports bind to `127.0.0.1`** — never `0.0.0.0` unless explicitly justified (exceptions: DNS port 53, Gitea SSH port 222).
4. **`login.mmastro.dev` and `auth.mmastro.dev` must never have an auth wrapper** — they ARE the auth system.
5. **No secrets in code or docs** — use `[PLACEHOLDER — NOT SET]` or env var references. Never hardcode tokens.

## Auth Tiers

| Tier | Caddy snippet | Requirement |
|---|---|---|
| None | — | Public or self-authenticated |
| Standard | `import require_auth` | oauth2-proxy OIDC session |
| Admin | `import require_auth_admin` | OIDC session + LAN/VPN IP (`192.168.178.0/24`) |

Admin tier: IP check runs first → 403 for untrusted IPs before showing login.

## Services and Ports

| Subdomain | Service | Port | Auth |
|---|---|---|---|
| `login.mmastro.dev` | Pocket ID | 1411 | None |
| `auth.mmastro.dev` | oauth2-proxy | 4180 | None |
| `mmastro.dev` | Static site | files | None |
| `blog.mmastro.dev` | Hugo blog | 8000 | None |
| `cv.mmastro.dev` | CV (Hugo) | 8001 | None |
| `git.mmastro.dev` | Gitea | 3000 | Admin |
| `photos.mmastro.dev` | Immich | 2283 | Standard |
| `budget.mmastro.dev` | Actual Budget | 5006 | Standard |
| `mail.mmastro.dev` | MailHog | 8025 | Admin |
| `memos.mmastro.dev` | Memos | 5230 | Standard |
| `drive.mmastro.dev` | Paperless-ngx | 8010 | Standard |
| `wiki.mmastro.dev` | mdBook wiki | 1240 | Admin |
| `dns.mmastro.dev` | AdGuard Home | 8088 | Admin |

## When Adding a New Service

1. Docker compose at `/srv/<name>/docker-compose.yml` — bind to `127.0.0.1`, join `homenet`, set `restart: unless-stopped`
2. Caddyfile site block — `import security_headers_no_CSP` + `import require_auth` (or `require_auth_admin`)
3. Cloudflare DNS A record — orange cloud for most, grey cloud for Admin tier IP check or large uploads
4. Pocket ID OIDC client (if service has native OIDC)
5. Validate: `caddy validate --config /etc/caddy/Caddyfile && systemctl reload caddy`
6. Update `src/constitution.md` service inventory table

## Conventions

- Caddy uses `security_headers_no_CSP` for most services (they set their own CSP or use inline scripts)
- fail2ban: grey-cloud services only. Cloudflare WAF for orange-cloud rate limiting.
- Gitea login redirect: slug `pocket-id` is case-sensitive in both Caddyfile and Gitea auth source
- Native OIDC services (Gitea, Actual Budget, Paperless-ngx) share Pocket ID session — no double login
- Hugo sites (blog, cv) use Gitea CI/CD: build → push to `git.mmastro.dev` registry → deploy via SSH

## Documentation

The authoritative reference is `src/constitution.md` in this repository. Keep it updated when infrastructure changes.

## Handling Contradictions and Doubts

Before implementing any change, check it against the constitution and these instructions for contradictions. If a contradiction or ambiguity is found:

1. **Point it out explicitly** — state what conflicts with what.
2. **Ask the user to resolve it** before proceeding.
3. **Never silently pick a side** — do not assume the newer instruction overrides the older one without confirmation.

Examples that warrant a question: a new service assigned to Admin tier but orange cloud; a port already in use; a rule that would require wrapping `login.mmastro.dev` or `auth.mmastro.dev`.

## Writing Style — Avoiding LLM Tells

When writing or editing any prose (wiki pages, README files, CV content, commit messages), avoid patterns that make output read as AI-generated. The goal is natural, specific, concrete writing — not sterilised prose. Keep flagged words when they are accurate and unavoidable; cut them when they dress up a claim that could be stated more directly.

**High-density vocabulary to replace:**
`delve` → "explore"; `leverage` → "use"; `showcase/showcasing` → "show" or "demonstrate"; `pivotal` → "key" or drop; `underscore` (verb) → "show" or "confirm"; `tapestry`, `landscape` (figurative), `testament`, `realm`, `garner`, `bolster`, `meticulous/meticulously`, `foster/fostering`, `enhance`, `seamlessly`, `unlock`, `empower`, `elevate`, `vibrant`, `nestled`, `crucial`, `align with`, `highlight` (verb), `enduring`.

**Puffery to cut:** "commitment to", "dedication to", "passion for", "deep understanding", "proven track record" — prefer concrete evidence over these claims.

**Formulaic structures to avoid:**
- Negative parallelism: "not just X, but Y" / "not X, it's Y"
- Unpaid rule of three: three-adjective or three-phrase piles where not all three earn their place
- Flourishes: "…not an afterthought", "from X to Y", "…and beyond"
- Copula substitutes: "serves as / stands as / marks / represents / boasts / features / offers" where "is" or "has" works
- Cliché openers: "In today's fast-paced…", "In the evolving landscape of…"

**Punctuation:**
- Em dashes for genuine punctuation need only — replace lazy emphasis dashes with commas, parentheses, or a full stop
- Use straight quotes (`"` `'`) not curly quotes (`"` `"` `'` `'`)

**Filler to drop:** "ongoing initiatives", "despite challenges", "positioned to…"

After every suggestion, confirm it remains truthful.
