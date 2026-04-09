# Maintenance

## Automated Schedule

| Frequency | Script | Cron |
|---|---|---|
| Weekly (Sunday 03:00) | `/srv/maintenance/weekly-maintenance.sh` | `0 3 * * 0` |
| Monthly (1st of month, 04:00) | `/srv/maintenance/monthly-check.sh` | `0 4 1 * *` |

Log output: `/var/log/homeserver-maintenance.log`

> **⚠️ Path discrepancy:** The maintenance scripts reference `/opt/` paths for docker-compose files. These should be updated to `/srv/` to match the actual deployment structure. Verify before relying on automated pulls.

## Weekly Tasks (automated)

1. Validate Caddyfile (`caddy validate`)
2. `docker compose pull` for all service stacks
3. Restart containers if images were updated
4. Prune unused Docker images
5. Check TLS certificate expiry for all subdomains

## Monthly Tasks (automated + manual)

- Version check for Caddy, oauth2-proxy, Pocket ID
- TLS cert expiry check
- Reminder to review security advisories

Security advisory URLs to review monthly:
- Caddy: `https://github.com/caddyserver/caddy/security/advisories`
- oauth2-proxy: `https://github.com/oauth2-proxy/oauth2-proxy/security/advisories`
- Pocket ID: `https://github.com/pocket-id/pocket-id/security/advisories`

## Manual Periodic Tasks

- **Mozilla Observatory:** `https://observatory.mozilla.org/` — check `mmastro.dev`
- **SSL Labs:** `https://www.ssllabs.com/ssltest/analyze.html?d=mmastro.dev`
- **Secret rotation** — see [Secret Rotation](secret-rotation.md)

## Caddy Management

```bash
# Validate config
caddy validate --config /etc/caddy/Caddyfile

# Reload after a change
systemctl reload caddy

# Full restart (only if reload fails)
systemctl restart caddy

# Check status
systemctl status caddy
journalctl -u caddy -n 50
```

## Docker Operations

```bash
# Restart a specific service
docker compose -f /srv/SERVICE/docker-compose.yml up -d

# View logs
docker compose -f /srv/SERVICE/docker-compose.yml logs -f

# Check all running containers
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

# Prune unused images
docker image prune -f
```

## fail2ban

```bash
# Check active bans
fail2ban-client status sshd
fail2ban-client status oauth2-proxy

# Unban an IP
fail2ban-client set sshd unbanip IP_ADDRESS
```

## Rollback After a Bad Caddyfile

If Caddy fails to reload after a config change:

```bash
# Restore the last known-good Caddyfile from git
git -C /etc/caddy checkout Caddyfile

# Validate and reload
caddy validate --config /etc/caddy/Caddyfile && systemctl reload caddy
```
