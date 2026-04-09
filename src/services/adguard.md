# AdGuard Home

## Purpose

Local DNS resolver. Provides split-DNS rewrites so LAN clients resolve `*.mmastro.dev`
to the server's LAN IP instead of the public IP or Cloudflare edge IP.
This is required for the Admin tier IP check to work correctly from the LAN.

## Details

| Property | Value |
|---|---|
| Image | `adguard/adguardhome:latest` |
| DNS port | `53` TCP/UDP (bound to `0.0.0.0` — required for LAN use) |
| Admin UI port | `8088` (bound to `127.0.0.1`) |
| External URL | `https://dns.mmastro.dev` |
| Compose path | `/srv/adguard/docker-compose.yml` |
| Config volume | `/srv/adguard/conf` → `/opt/adguardhome/conf` |
| CF mode | Orange (proxied) |
| Auth tier | Admin (✅ OIDC + IP check enforced) |

## DNS Rewrites

Navigate to **Filters → DNS Rewrites** in the AdGuard Home admin UI.

| Rule | Resolves to |
|---|---|
| `*.mmastro.dev` | `[SERVER_LAN_IP]` |

This single wildcard rule ensures all subdomains resolve to the server's LAN IP for clients using AdGuard Home as their DNS server.

## Fritz!Box Integration

Set AdGuard Home as the DNS server in Fritz!Box:
- **Home Network → Network → DNS Server** → set to `[SERVER_LAN_IP]`
- **Home Network → Network → DNS Rebind Protection** → add `mmastro.dev` as exception

## Upstream DNS (configured in AdGuard Home settings)

| Type | Server |
|---|---|
| Upstream | `https://1.1.1.1/dns-query` |
| Upstream | `https://8.8.8.8/dns-query` |
| Bootstrap | `1.1.1.1` |
| Bootstrap | `8.8.8.8` |

## Restart

```bash
docker compose -f /srv/adguard/docker-compose.yml up -d
```

## Note on systemd-resolved

On Debian, `systemd-resolved` may occupy port 53. Disable it before starting AdGuard:

```bash
systemctl disable --now systemd-resolved
rm /etc/resolv.conf
echo "nameserver 1.1.1.1" > /etc/resolv.conf
```
