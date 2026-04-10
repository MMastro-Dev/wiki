# Network & Firewall

## Docker Networks

| Network | Type | Members |
|---|---|---|
| `homenet` | External, shared | All services that need to communicate (Gitea, Pocket ID, oauth2-proxy, etc.) |
| `paperless-internal` | Internal (isolated) | paperless-ngx, paperless-db, paperless-broker, paperless-gotenberg, paperless-tika |

`paperless-internal` is isolated: the PostgreSQL database, Redis broker, and document processing containers are not exposed on `homenet`. Only `paperless-ngx` itself is routable to Caddy via loopback (`127.0.0.1:8010`).

## Firewall (ufw)

Default policy: **deny incoming, allow outgoing**.

| Rule | Port/Protocol | Source | Purpose |
|---|---|---|---|
| Allow | 22/tcp | Any | SSH access |
| Allow | 80/tcp | Any | HTTP (Caddy ACME redirect) |
| Allow | 443/tcp | Any | HTTPS |
| Allow | 443/udp | Any | HTTP/3 (QUIC) |
| Allow | 222/tcp | Any | Gitea SSH (git push) |
| Allow | 53/tcp+udp | LAN | AdGuard DNS (LAN clients only) |

> **VERIFY ON SERVER** — Run `ufw status verbose` on the server to confirm the exact ruleset. The above is based on the migration scripts; manual changes may have been made.

## Port Binding Security

All containers bind to `127.0.0.1` (loopback) unless there is an explicit requirement to bind to all interfaces. Exceptions:

| Port | Bound to | Reason |
|---|---|---|
| 53 (AdGuard DNS) | `0.0.0.0` | DNS must be reachable from LAN clients |
| 222 (Gitea SSH) | `0.0.0.0` | Git push over SSH from the internet |

## Cloudflare Origin Protection

For grey-cloud (DNS-only) services, the server IP is exposed in DNS. Caddy handles all
TLS validation — no Cloudflare origin certificates are used after the migration (old
Cloudflare Origin CA certs can be deleted after 30 days from migration date).

For orange-cloud services, the server IP is hidden behind Cloudflare. Cloudflare forwards
requests with the real client IP in `CF-Connecting-IP`. Caddy restores this via
`trusted_proxies cloudflare` in the global server block.

## Split DNS (AdGuard Home)

AdGuard Home runs on the server at `192.168.178.[SERVER_IP]` and is set as the DNS
server for all Fritz!Box DHCP clients.

DNS rewrites configured: `*.mmastro.dev → [SERVER_LAN_IP]`

This ensures LAN clients bypass Cloudflare and connect directly to the server.
Without split DNS, LAN requests to admin-tier services go out through the router (NAT),
and Caddy sees the router's public IP instead of the LAN client IP — breaking the Admin
tier IP check.

## fail2ban

fail2ban is active for the following jails:

| Jail | Target | Applies to |
|---|---|---|
| `sshd` | `/var/log/auth.log` | SSH brute-force protection |
| `oauth2-proxy` | Caddy access log for `mail.mmastro.dev` | Failed authentication attempts |

> **Grey-cloud only:** fail2ban is only deployed for grey-cloud services where `remote_addr`
> is the real client IP. For orange-cloud services (proxied), `remote_addr` is a Cloudflare
> edge IP — banning it would ban all users. Use Cloudflare WAF rate limiting for
> orange-cloud services instead.
