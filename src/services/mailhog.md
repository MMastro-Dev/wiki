# MailHog & Postfix

## Purpose

Internal email stack. Postfix receives outgoing mail from other services (Gitea notifications, etc.)
and relays it to MailHog. MailHog provides a web UI to view captured emails.
No mail is sent to the internet — this is a dev/internal capture setup.

## Details

### MailHog

| Property | Value |
|---|---|
| Image | `mailhog/mailhog:latest` |
| Web UI port | `8025` (bound to `127.0.0.1`) |
| SMTP port | `1025` (internal, bound to `127.0.0.1`) |
| External URL | `https://mail.mmastro.dev` |
| Compose path | `/srv/mail/docker-compose.yml` |
| CF mode | Grey (DNS only) |
| Auth tier | Admin (✅ OIDC + IP check enforced) |

### Postfix

| Property | Value |
|---|---|
| SMTP port | `587` (internal relay) |
| Compose path | Same stack as MailHog: `/srv/mail/docker-compose.yml` |

MailHog has no built-in authentication. Access is protected entirely by Caddy's Admin tier
(`require_auth_admin`). Do not expose MailHog without this gate.

## Restart

```bash
docker compose -f /srv/mail/docker-compose.yml up -d
```

## Log Location

```bash
tail -f /var/log/caddy/mail-access.log
```

Used as the fail2ban source for oauth2-proxy authentication failures.
