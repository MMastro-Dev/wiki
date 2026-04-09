# Caddy Configuration

## Global Block

```caddy
{
    email cert-renewal@mail.mmastro.dev
    admin off
    acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}

    servers {
        trusted_proxies cloudflare
        protocols h1 h2 h3
    }
}
```

| Setting | Purpose |
|---|---|
| `admin off` | Disables the Caddy admin API. Manage via file + `systemctl reload caddy` only |
| `acme_dns cloudflare` | DNS-01 ACME challenge. Works for both orange and grey cloud. Requires `CLOUDFLARE_API_TOKEN` env var (Zone → DNS → Edit) |
| `trusted_proxies cloudflare` | Restores real client IP from `CF-Connecting-IP` on orange-cloud requests |
| `protocols h1 h2 h3` | Enables HTTP/3 (QUIC) in addition to HTTP/1.1 and HTTP/2 |

The `CLOUDFLARE_API_TOKEN` is injected via the systemd service override at
`/etc/systemd/system/caddy.service.d/override.conf`.

## Snippets

### `security_headers`

Applied to services that can use a strict `Content-Security-Policy: default-src 'self'`.

```caddy
(security_headers) {
    header {
        X-Content-Type-Options          "nosniff"
        X-Frame-Options                 "SAMEORIGIN"
        Strict-Transport-Security       "max-age=31536000; includeSubDomains; preload"
        Content-Security-Policy         "default-src 'self'; frame-ancestors 'self'"
        Referrer-Policy                 "strict-origin-when-cross-origin"
        Permissions-Policy              "geolocation=(), camera=(), microphone=()"
        -Server
        -X-Powered-By
    }
}
```

### `security_headers_no_CSP`

Applied to services that set their own CSP, use inline scripts/styles, or load external
resources. Using `default-src 'self'` on these would break the UI.

```caddy
(security_headers_no_CSP) {
    header {
        X-Content-Type-Options          "nosniff"
        X-Frame-Options                 "SAMEORIGIN"
        Strict-Transport-Security       "max-age=31536000; includeSubDomains; preload"
        Referrer-Policy                 "strict-origin-when-cross-origin"
        Permissions-Policy              "geolocation=(), camera=(), microphone=()"
        -Server
        -X-Powered-By
    }
}
```

> **Note:** Disable Cloudflare "Managed Transforms" in the CF dashboard to prevent
> duplicate security headers: Rules → Transform Rules → Managed Transforms → off.

### `require_auth`

Standard tier: OIDC session check via oauth2-proxy.

```caddy
(require_auth) {
    forward_auth localhost:4180 {
        uri /oauth2/auth
        copy_headers X-Auth-Request-User X-Auth-Request-Email X-Auth-Request-Groups
        header_up X-Real-IP {remote_host}

        @unauthorized status 401
        handle_response @unauthorized {
            redir * https://auth.mmastro.dev/oauth2/sign_in?rd=https://{http.request.host}{http.request.uri} 302
        }
    }
}
```

### `require_auth_admin`

Admin tier: LAN/VPN IP check first, then OIDC session check.

```caddy
(require_auth_admin) {
    @untrusted {
        not remote_ip 192.168.178.0/24
        not remote_ip 10.0.0.0/8      # ← update to actual WireGuard subnet
    }
    handle @untrusted {
        respond 403  # (with HTML body — see Caddyfile)
    }
    forward_auth localhost:4180 {
        uri /oauth2/auth
        copy_headers X-Auth-Request-User X-Auth-Request-Email X-Auth-Request-Groups
        header_up X-Real-IP {remote_host}

        @unauthorized status 401
        handle_response @unauthorized {
            redir * https://auth.mmastro.dev/oauth2/sign_in?rd=https://{http.request.host}{http.request.uri} 302
        }
    }
}
```

## Adding a New Site Block

```caddy
subdomain.mmastro.dev {
    import security_headers_no_CSP
    import require_auth          # or require_auth_admin for Admin tier

    reverse_proxy localhost:PORT {
        header_up X-Forwarded-User {http.request.header.X-Auth-Request-User}
    }
}
```

Steps:
1. Add the DNS A record in Cloudflare
2. Add the site block to `/etc/caddy/Caddyfile`
3. Validate: `caddy validate --config /etc/caddy/Caddyfile`
4. Reload: `systemctl reload caddy`

## Validate and Reload

```bash
# Validate without reloading
caddy validate --config /etc/caddy/Caddyfile

# Validate and reload (only reloads if valid)
caddy validate --config /etc/caddy/Caddyfile && systemctl reload caddy
```

## Systemd Override

`/etc/systemd/system/caddy.service.d/override.conf`

```ini
[Service]
Environment="CLOUDFLARE_API_TOKEN=[PLACEHOLDER — NOT SET]"
AmbientCapabilities=CAP_NET_BIND_SERVICE
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ReadWritePaths=/var/lib/caddy /var/log/caddy /etc/caddy
```

After editing: `systemctl daemon-reload && systemctl restart caddy`
