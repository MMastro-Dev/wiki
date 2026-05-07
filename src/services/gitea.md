# Gitea

## Purpose

Self-hosted Git service. Hosts all code repositories and CI/CD pipelines via Gitea Actions.
Uses Pocket ID for OIDC authentication — local password login is disabled.

## Details

| Property | Value |
|---|---|
| Image | `gitea/gitea:latest` |
| Web port | `3000` (bound to `127.0.0.1`) |
| SSH port | `222` (bound to `0.0.0.0` — required for git push) |
| External URL | `https://git.mmastro.dev` |
| Compose path | `/srv/gitea/docker-compose.yml` |
| CF mode | Grey (DNS only) |
| Auth tier | Admin (⚠️ network gate not yet enforced — OIDC redirect active only) |

## Auth Model

Caddy intercepts `GET /user/login` and redirects to `/user/oauth2/pocket-id`.
Gitea completes the OIDC handshake with Pocket ID natively.
Local password login is disabled via environment variables.

> The Pocket ID OAuth2 source in Gitea must be named exactly `pocket-id` (lowercase).
> The Caddyfile redirect uses this slug: `/user/oauth2/pocket-id`.
> Case mismatch will break the login flow.

| Gitea auth setting | Value |
|---|---|
| `ENABLE_BASIC_AUTHENTICATION` | `false` |
| `DISABLE_REGISTRATION` | `true` |
| `ALLOW_ONLY_EXTERNAL_REGISTRATION` | `true` |

## act-runner

The Gitea CI runner is a separate container.

| Property | Value |
|---|---|
| Compose path | `/srv/gitea-runner/docker-compose.yml` |
| Hugo blog source mount | `/srv/hugo-blog` |

## Restart

```bash
docker compose -f /srv/gitea/docker-compose.yml up -d
docker compose -f /srv/gitea-runner/docker-compose.yml up -d
```

## Health Check

```bash
curl -sf https://git.mmastro.dev/api/healthz && echo "OK"
```

## Caveats

- `require_auth_admin` is currently commented out in the Caddyfile — the OIDC redirect is active but the IP gate is not enforced
- Before applying the full Admin gate, confirm your Gitea admin account email matches your Pocket ID account: `docker exec gitea gitea admin user list`
- SSH git push (port 222) is unaffected by auth changes
