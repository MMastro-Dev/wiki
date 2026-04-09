# oauth2-proxy

## Purpose

oauth2-proxy is the OIDC session sidecar. It manages authentication cookies, validates sessions,
and exposes the `/oauth2/auth` endpoint that Caddy's `forward_auth` calls for every protected request.

## Details

| Property | Value |
|---|---|
| Image | `quay.io/oauth2-proxy/oauth2-proxy:v7.6.0` |
| Internal port | `4180` |
| External URL | `https://auth.mmastro.dev` |
| Compose path | `/srv/oauth2-proxy/docker-compose.yml` |
| CF mode | Orange (proxied) |
| Auth tier | **None** — must never have an auth wrapper |

## Configuration

oauth2-proxy is configured via `oauth2-proxy.cfg` (mounted into the container).
Key settings:

| Setting | Value |
|---|---|
| `provider` | `oidc` |
| `oidc_issuer_url` | `https://login.mmastro.dev` |
| `client_id` | `[PLACEHOLDER — NOT SET]` (from Pocket ID OIDC client `caddy-oauth2-proxy`) |
| `client_secret` | `[PLACEHOLDER — NOT SET]` |
| `cookie_secret` | `[PLACEHOLDER — NOT SET]` (generate: `openssl rand -base64 32 \| tr -- '+/' '-_'`) |
| `cookie_name` | `__Secure-oauth2-proxy` |
| `cookie_domain` | `.mmastro.dev` |
| `cookie_expire` | `8h` |
| `redirect_url` | `https://auth.mmastro.dev/oauth2/callback` |

## Restart

```bash
docker compose -f /srv/oauth2-proxy/docker-compose.yml up -d
```

## Health Check

```bash
curl -sf http://localhost:4180/ping && echo "OK"
```

## Caveats

- Must never be wrapped with `import require_auth`
- The `auth.mmastro.dev` Caddy site block proxies all `/oauth2/*` paths to this service
- Cookie is scoped to `.mmastro.dev` — single sign-on across all subdomains
- Rotate `cookie_secret` and `client_secret` annually — see [Secret Rotation](../operations/secret-rotation.md)
