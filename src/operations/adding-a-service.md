# Adding a New Service

## Checklist

### 1. Add DNS Record

In Cloudflare, add an A record for the new subdomain pointing to the server IP.
- Orange cloud (proxied): for most services
- Grey cloud (DNS only): required for Admin tier IP check or large uploads

### 2. Add to AdGuard Home DNS Rewrites

If not already covered by the `*.mmastro.dev` wildcard, add a specific entry pointing to the server's LAN IP.

### 3. Create docker-compose.yml

- Place under `/srv/SERVICE-NAME/docker-compose.yml`
- Bind port to `127.0.0.1:HOST_PORT:CONTAINER_PORT` — never `0.0.0.0`
- Add to `homenet` network
- Set `restart: unless-stopped`

```yaml
services:
  myservice:
    image: example/myservice:latest
    container_name: myservice
    restart: unless-stopped
    ports:
      - "127.0.0.1:PORT:PORT"
    networks:
      - homenet

networks:
  homenet:
    external: true
```

### 4. Add Caddyfile Site Block

```caddy
subdomain.mmastro.dev {
    import security_headers_no_CSP
    import require_auth          # Standard tier
    # import require_auth_admin  # Admin tier (OIDC + IP check)

    reverse_proxy localhost:PORT {
        header_up X-Forwarded-User {http.request.header.X-Auth-Request-User}
    }
}
```

### 5. (Optional) Register a Pocket ID OIDC Client

If the service has native OIDC support:
1. Go to `https://login.mmastro.dev/admin` → OIDC Clients → New
2. Name: use a lowercase slug matching the service name
3. Callback URL: `https://SUBDOMAIN/your-callback-path`
4. Add `client_id` and `client_secret` to the service's docker-compose env

### 6. Start the Container

```bash
docker compose -f /srv/SERVICE-NAME/docker-compose.yml up -d
```

### 7. Validate and Reload Caddy

```bash
caddy validate --config /etc/caddy/Caddyfile && systemctl reload caddy
```

### 8. Update the Constitution

Add the new service to the [Service Inventory](../constitution.md) table.

### 9. Update the Weekly Maintenance Script

Add the new compose directory to the `COMPOSE_DIRS` array in
`/srv/maintenance/weekly-maintenance.sh`. Remember to use `/srv/` paths.
