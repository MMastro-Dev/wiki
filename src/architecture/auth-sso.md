# Authentication & SSO

## Components

| Component | Version | Role |
|---|---|---|
| Pocket ID | v2 | OIDC provider (passkey-only). Issues tokens. Hosted at `login.mmastro.dev` |
| oauth2-proxy | v7.6.0 | Auth sidecar. Manages sessions, cookies, and the `/oauth2/auth` check endpoint |
| Caddy `forward_auth` | — | Inline auth gate. Calls oauth2-proxy before forwarding any request |

## Auth Cookie

oauth2-proxy issues a cookie named `__Secure-oauth2-proxy` scoped to `.mmastro.dev`.
This cookie is shared across all subdomains — a user who authenticates on `mail.mmastro.dev`
is automatically authenticated on `budget.mmastro.dev` without a second login.

| Property | Value |
|---|---|
| Cookie name | `__Secure-oauth2-proxy` |
| Domain scope | `.mmastro.dev` |
| Expiry | 8 hours |
| Secure flag | Yes (HTTPS only) |
| HttpOnly | Yes |

## Two Auth Tiers

### Standard Tier (`require_auth`)

Calls `forward_auth localhost:4180 { uri /oauth2/auth }`.
- Valid session → `202` → Caddy forwards the request
- No session → `401` → Caddy redirects to `https://auth.mmastro.dev/oauth2/sign_in?rd=...`

### Admin Tier (`require_auth_admin`)

IP check runs **before** the OIDC gate:
1. If `remote_ip` is not in a trusted range → immediate `403` (the login page is never shown)
2. If `remote_ip` is trusted → same OIDC gate as Standard tier

Trusted ranges are defined in the Caddyfile `require_auth_admin` snippet.
See the `require_auth_admin` snippet in the Caddyfile for current values and the WireGuard placeholder note.

## Native OIDC Services

Three services maintain their own OIDC sessions with Pocket ID independently of oauth2-proxy.
Pocket ID's shared session means no second login prompt.

| Service | Pocket ID client name | Callback URL |
|---|---|---|
| Gitea | `pocket-id` | `https://git.mmastro.dev/user/oauth2/pocket-id/callback` |
| Actual Budget | `actual-budget` | `https://budget.mmastro.dev/oauth/callback` |
| Paperless-ngx | `paperless` | `https://drive.mmastro.dev/accounts/oidc/pocket-id/login/callback/` |

> **Note on Gitea slug case-sensitivity:** The Pocket ID OIDC client in Gitea must be named exactly `pocket-id` (lowercase). The Caddyfile login redirect uses `/user/oauth2/pocket-id` — this slug must match the name set in Gitea's Authentication Sources. If you recreate the source with a different capitalisation, update both.

## Adding OIDC Protection to a New Service

1. Add `import require_auth` (Standard) or `import require_auth_admin` (Admin) to the service's Caddy site block.
2. If the service also needs a native OIDC session:
   - Create a new OIDC client in Pocket ID (`login.mmastro.dev/admin`)
   - Set the callback URL to `https://SUBDOMAIN/your-service-callback-path`
   - Add the `client_id` and `client_secret` to the service's docker-compose env
3. Validate and reload Caddy: `caddy validate --config /etc/caddy/Caddyfile && systemctl reload caddy`

## Adding a New Pocket ID OIDC Client

1. Go to `https://login.mmastro.dev/admin` → OIDC Clients → New Client
2. Set name and callback URL
3. Copy the generated `client_id` and `client_secret` — store securely (not in documentation)
4. Set `[PLACEHOLDER — NOT SET]` in compose files until secrets are injected
