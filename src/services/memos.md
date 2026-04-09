# Memos

## Purpose

Self-hosted note-taking and memo service.

## Details

| Property | Value |
|---|---|
| Image | `neosmemo/memos:stable` |
| Internal port | `5230` |
| External URL | `https://memos.mmastro.dev` |
| Compose path | `/srv/memos/docker-compose.yml` |
| Data volume | `/srv/memos/data/memos` → `/var/opt/memos` |
| CF mode | Orange (proxied) |
| Auth tier | Standard (⚠️ auth gate not yet active) |

## Auth Status

⚠️ `import require_auth` is **commented out** in the Caddyfile. Memos is currently accessible without the Caddy auth gate.

To activate: uncomment `import require_auth` in the `memos.mmastro.dev` site block and reload Caddy.

## Restart

```bash
docker compose -f /srv/memos/docker-compose.yml up -d
```
