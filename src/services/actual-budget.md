# Actual Budget

## Purpose

Self-hosted personal finance and budgeting tool. Native OIDC integration with Pocket ID.
Password login is disabled — OIDC is the only authentication method.

## Details

| Property | Value |
|---|---|
| Image | `docker.io/actualbudget/actual-server:latest` |
| Internal port | `5006` |
| External URL | `https://budget.mmastro.dev` |
| Compose path | `/srv/actual-budget/docker-compose.yml` |
| Data volume | `/srv/actual-budget/actual-data` → `/data` |
| CF mode | Orange (proxied) |
| Auth tier | Standard (✅ oauth2-proxy gate active) |

## Auth Model

Two-layer auth:
1. Caddy `forward_auth` → oauth2-proxy gate (outer)
2. Actual Budget native OIDC → Pocket ID (inner, silent — reuses existing session)

| OIDC setting | Value |
|---|---|
| Discovery URL | `https://login.mmastro.dev/.well-known/openid-configuration` |
| Client ID | `[PLACEHOLDER — NOT SET]` |
| Client Secret | `[PLACEHOLDER — NOT SET]` |
| Redirect base URL | `https://budget.mmastro.dev` |
| `ACTUAL_OPENID_ENFORCE` | `true` — password login disabled |

> **Note:** TLS was removed from the container after migration to Caddy.
> The container runs plain HTTP on port 5006. Do not re-add `ACTUAL_HTTPS_KEY` / `ACTUAL_HTTPS_CERT`.

## Restart

```bash
docker compose -f /srv/actual-budget/docker-compose.yml up -d
```
