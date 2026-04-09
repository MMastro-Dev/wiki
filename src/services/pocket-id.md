# Pocket ID

## Purpose

Pocket ID is the OIDC identity provider for the entire homeserver.
It issues tokens to oauth2-proxy (for the Caddy auth gate) and to services with native OIDC integration.
Authentication is **passkey-only** — no passwords.

## Details

| Property | Value |
|---|---|
| Image | `ghcr.io/pocket-id/pocket-id:v2` |
| Internal port | `1411` |
| External URL | `https://login.mmastro.dev` |
| Compose path | `/srv/pocket-id/docker-compose.yml` |
| Data volume | `/srv/pocket-id/data` → `/app/data` |
| CF mode | Orange (proxied) |
| Auth tier | **None** — must never have an auth wrapper |
| OIDC discovery | `https://login.mmastro.dev/.well-known/openid-configuration` |

## OIDC Clients Registered

| Client name | Used by | Callback URL |
|---|---|---|
| `caddy-oauth2-proxy` | oauth2-proxy | `https://auth.mmastro.dev/oauth2/callback` |
| `pocket-id` | Gitea | `https://git.mmastro.dev/user/oauth2/pocket-id/callback` |
| `actual-budget` | Actual Budget | `https://budget.mmastro.dev/oauth/callback` |
| `paperless` | Paperless-ngx | `https://drive.mmastro.dev/accounts/oidc/pocket-id/login/callback/` |

> Manage clients at `https://login.mmastro.dev/admin`

## Restart

```bash
docker compose -f /srv/pocket-id/docker-compose.yml up -d
```

## Health Check

```bash
docker inspect --format='{{.State.Health.Status}}' pocket-id
```

## Caveats

- Must never be wrapped with `import require_auth` or `import require_auth_admin`
- The Caddyfile site block uses `security_headers_no_CSP` (Pocket ID sets its own headers)
- Port binds to `127.0.0.1:1411` only — Caddy proxies all traffic
