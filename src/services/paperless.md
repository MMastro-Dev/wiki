# Paperless-ngx

## Purpose

Self-hosted document management system. Stores, indexes, and OCRs documents.
Documents are stored on the ZFS pool at `/tank/docs/paperless`.

## Details

| Property | Value |
|---|---|
| Image | `ghcr.io/paperless-ngx/paperless-ngx:latest` |
| Internal port | `8010` (mapped from container port `8000`) |
| External URL | `https://drive.mmastro.dev` |
| Compose path | `/srv/paperless/docker-compose.yml` |
| CF mode | Orange (proxied) |
| Auth tier | Standard (✅ oauth2-proxy gate active) |

## Stack Components

| Container | Image | Role |
|---|---|---|
| `paperless-ngx` | `ghcr.io/paperless-ngx/paperless-ngx:latest` | Main application |
| `paperless-db` | `postgres:16-alpine` | PostgreSQL database |
| `paperless-broker` | `redis:7-alpine` | Task queue (Redis) |
| `paperless-gotenberg` | `gotenberg/gotenberg:8` | Office/HTML → PDF conversion |
| `paperless-tika` | `apache/tika:latest` | Text extraction from images |

All supporting containers are on the isolated `paperless-internal` network and are not accessible from `homenet`.

## Storage

| Path | Contents |
|---|---|
| `/tank/docs/paperless/data` | Application data |
| `/tank/docs/paperless/media` | Document files |
| `/tank/docs/paperless/export` | Export output |
| `/tank/docs/paperless/consume` | Incoming document inbox |

## Auth Model

| Setting | Value |
|---|---|
| OIDC provider | Pocket ID |
| Client name | `paperless` |
| Callback URL | `https://drive.mmastro.dev/accounts/oidc/pocket-id/login/callback/` *(trailing slash required)* |
| `PAPERLESS_REDIRECT_LOGIN_TO_SSO` | `true` — auto-redirects to OIDC on login page |
| `PAPERLESS_SECRET_KEY` | `[PLACEHOLDER — NOT SET]` |
| `PAPERLESS_CLIENT_ID` | `[PLACEHOLDER — NOT SET]` |
| `PAPERLESS_CLIENT_SECRET` | `[PLACEHOLDER — NOT SET]` |

## Restart

```bash
docker compose -f /srv/paperless/docker-compose.yml up -d
```

## First-Run Admin User

```bash
docker exec -it paperless-ngx python3 manage.py createsuperuser
```

## ⚠️ Port Conflict Note

The live Caddyfile previously had `drive.mmastro.dev → localhost:8002`.
The correct port per the Paperless compose file is `8010` (maps container port 8000).
If you see Caddy 502 errors, verify the Caddyfile routes to `localhost:8010`.
