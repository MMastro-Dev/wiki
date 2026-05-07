# Immich

## Purpose

Self-hosted photo and video server with mobile backup support.
Large file uploads require direct connection (grey cloud, no Cloudflare size limits).

## Details

| Property | Value |
|---|---|
| Image | `ghcr.io/immich-app/immich-server:latest` |
| Internal port | `2283` |
| External URL | `https://photos.mmastro.dev` |
| Compose path | `/srv/immich/docker-compose.yml` |
| CF mode | Grey (DNS only) — required for large upload support |
| Auth tier | Standard (⚠️ auth gate not yet active) |

## Auth Status

⚠️ `import require_auth` is **commented out** in the Caddyfile. Immich is currently accessible without Caddy-level authentication. Immich has its own built-in auth system.

To activate the Caddy auth gate: uncomment `import require_auth` in the `photos.mmastro.dev` site block and reload Caddy.

> **Decision pending:** Whether to layer oauth2-proxy on top of Immich's native auth, or rely solely on Immich's own auth system. Decide before activating `require_auth`.

## Special Caddy Config

Immich requires extended timeouts and no body size limit for uploads:

```caddy
reverse_proxy localhost:2283 {
    flush_interval -1
    transport http {
        read_timeout  0
        write_timeout 0
        dial_timeout  10s
    }
}
```

## Restart

```bash
docker compose -f /srv/immich/docker-compose.yml up -d
```
