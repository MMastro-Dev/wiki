# Secret Rotation

## Secrets That Must Be Rotated

| Secret | Location | Rotation frequency |
|---|---|---|
| `CLOUDFLARE_API_TOKEN` | `/etc/systemd/system/caddy.service.d/override.conf` | Annual or on compromise |
| oauth2-proxy `cookie_secret` | `/srv/oauth2-proxy/oauth2-proxy.cfg` | Annual |
| oauth2-proxy `client_secret` (Pocket ID) | `/srv/oauth2-proxy/oauth2-proxy.cfg` | Annual |
| Actual Budget `ACTUAL_OPENID_CLIENT_SECRET` | `/srv/actual-budget/docker-compose.yml` env | Annual |
| Paperless-ngx `PAPERLESS_CLIENT_SECRET` | `/srv/paperless/docker-compose.yml` env | Annual |
| Paperless-ngx `PAPERLESS_SECRET_KEY` | `/srv/paperless/docker-compose.yml` env | Annual |
| Gitea Pocket ID `client_secret` | Gitea Admin → Authentication Sources | Annual |

## Rotating the oauth2-proxy Cookie Secret

Rotating the cookie secret invalidates all active sessions — all users will be logged out.

```bash
# Generate new secret
openssl rand -base64 32 | tr -- '+/' '-_'

# Update oauth2-proxy.cfg, then restart
docker compose -f /srv/oauth2-proxy/docker-compose.yml up -d
```

## Rotating Cloudflare API Token

1. Go to `https://dash.cloudflare.com/profile/api-tokens`
2. Create a new token with Zone → DNS → Edit
3. Update `/etc/systemd/system/caddy.service.d/override.conf`
4. Run: `systemctl daemon-reload && systemctl restart caddy`
5. Revoke the old token in Cloudflare

## Rotating a Pocket ID Client Secret

1. Go to `https://login.mmastro.dev/admin` → OIDC Clients → edit the client
2. Regenerate the secret
3. Update the corresponding service's docker-compose env
4. Restart the affected container
