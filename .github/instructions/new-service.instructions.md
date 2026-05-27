---
description: 'Use when adding a new service to the homelab, scaffolding a docker-compose stack, registering a new subdomain, or onboarding a new app behind Caddy'
---

# Adding a New Service

Follow these six steps in order:

1. **Docker compose** at `/srv/<name>/docker-compose.yml`:
   - Bind ports to `127.0.0.1`
   - Join the `homenet` external network
   - Set `restart: unless-stopped`

2. **Caddyfile site block:**
   - `import security_headers_no_CSP`
   - `import require_auth` for Standard tier, or `import require_auth_admin` for Admin tier
   - Reference auth tiers in `infrastructure.instructions.md` if uncertain

3. **Cloudflare DNS A record:**
   - Orange cloud for most services
   - Grey cloud for Admin-tier services with IP check, or large-upload services (Immich, Paperless)

4. **Pocket ID OIDC client** if the service has native OIDC support (Gitea, Actual Budget, Paperless-ngx pattern).

5. **Validate and reload:**
   ```
   caddy validate --config /etc/caddy/Caddyfile && systemctl reload caddy
   ```

6. **Update `src/constitution.md`** service inventory table.

## Notes

- Native OIDC services share the Pocket ID session — no double login
- Gitea login redirect slug `pocket-id` is case-sensitive in both Caddyfile and Gitea auth source
