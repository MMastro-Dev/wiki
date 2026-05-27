---
description: 'Use when configuring or troubleshooting Caddy snippets, Cloudflare cloud modes, fail2ban, CI/CD pipelines, or Gitea/Hugo deployment workflows'
---

# Conventions

## Caddy

- Use `security_headers_no_CSP` for most services — they set their own CSP or use inline scripts that break a global policy
- Admin API is disabled (`admin off`); reload with `systemctl reload caddy`
- Auth is `forward_auth` → oauth2-proxy. **Never** use the caddy-security plugin

## Cloudflare

- **Orange cloud:** WAF and rate limiting at the edge — use for public services
- **Grey cloud:** Required for Admin-tier IP checks (otherwise Caddy sees Cloudflare's IP) and for large upload services (Immich, Paperless) that exceed Cloudflare's 100 MB free-tier limit

## fail2ban

- Applies to grey-cloud services only (orange-cloud is covered by Cloudflare WAF)
- Caddy log path is the source; jail names match the subdomain

## Native OIDC

- Gitea, Actual Budget, Paperless-ngx use Pocket ID directly
- They share the oauth2-proxy session — no double login when chaining through Caddy
- Gitea auth source slug `pocket-id` is case-sensitive in both the Caddyfile and Gitea's admin UI

## Hugo CI/CD (blog, cv)

1. Push to `git.mmastro.dev`
2. Gitea Actions build → push image to Gitea registry
3. Deploy via SSH from a runner with the deploy key
