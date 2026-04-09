# Architecture Overview

## System Diagram

```
                         ┌─────────────────────────────────────┐
                         │           INTERNET                  │
                         └─────────────┬───────────────────────┘
                                       │
                         ┌─────────────▼───────────────────────┐
                         │         CLOUDFLARE                  │
                         │  Orange cloud: proxied services     │
                         │  Grey cloud:  DNS-only passthrough  │
                         └─────────────┬───────────────────────┘
                                       │ HTTPS (443)
                         ┌─────────────▼───────────────────────┐
                         │           CADDY 2.9+                │
                         │  TLS termination (DNS-01/CF plugin) │
                         │  Subdomain routing                  │
                         │  Security headers                   │
                         │  trusted_proxies cloudflare         │
                         └──────┬──────────────┬───────────────┘
                                │              │
              ┌─────────────────▼──┐    ┌──────▼─────────────────┐
              │   forward_auth     │    │   Direct reverse_proxy  │
              │   oauth2-proxy     │    │   (no-auth services)    │
              │   localhost:4180   │    └────────────────────────-┘
              └─────────┬──────────┘
                        │ session valid?
               ┌────────┴──────────┐
               │ YES               │ NO
               │                  ▼
               │      ┌───────────────────────┐
               │      │  Pocket ID (OIDC)     │
               │      │  login.mmastro.dev    │
               │      │  localhost:1411        │
               │      └───────────────────────┘
               │
    ┌──────────▼───────────────────────────────────────┐
    │              BACKEND SERVICES                    │
    │                                                  │
    │  Standard tier      │  Admin tier               │
    │  ─────────────      │  ──────────               │
    │  photos  :2283      │  mail   :8025             │
    │  budget  :5006      │  git    :3000             │
    │  memos   :5230      │  wiki   :1240             │
    │  drive   :8010      │  dns    :8088             │
    └──────────────────────────────────────────────────┘
```

## Component Roles

| Component | Role |
|---|---|
| **Cloudflare** | DNS, CDN, edge TLS (orange cloud), DDoS protection |
| **Caddy** | Reverse proxy, TLS termination, auth gate via `forward_auth`, security headers |
| **oauth2-proxy** | OIDC session management, cookie issuance, auth check endpoint (`/oauth2/auth`) |
| **Pocket ID** | OIDC identity provider (passkey-only), issues tokens to oauth2-proxy and native OIDC services |
| **AdGuard Home** | Local DNS resolver with split-DNS rewrites, forces LAN clients to resolve `*.mmastro.dev` to the server's LAN IP |

## Auth Gate Flow

```
Request arrives at Caddy
        │
        ├─ No-auth service? ──────────────────────────► Pass through to backend
        │
        ├─ Standard tier?
        │       │
        │       └─ forward_auth → oauth2-proxy /oauth2/auth
        │               │
        │               ├─ 202 (valid session) ──────► Pass through to backend
        │               └─ 401 (no session) ─────────► Redirect to Pocket ID
        │
        └─ Admin tier?
                │
                ├─ IP not in trusted range? ─────────► 403 (no login page shown)
                │
                └─ forward_auth → oauth2-proxy /oauth2/auth
                        │
                        ├─ 202 (valid session) ──────► Pass through to backend
                        └─ 401 (no session) ─────────► Redirect to Pocket ID
```

## Data Flow for Native OIDC Services

Some services (Gitea, Actual Budget, Paperless-ngx) maintain their own OIDC sessions with Pocket ID. When a valid oauth2-proxy session exists, Pocket ID recognises it and silently returns a token — the user sees a single login, not two.

```
User (LAN / authenticated) → Caddy → oauth2-proxy gate passes
                                           │
                                           ▼
                                    Backend service
                                    (Gitea / Budget / Paperless)
                                           │ initiates own OIDC flow
                                           ▼
                                    Pocket ID: session exists → silent token
                                           │
                                           ▼
                                    User is signed in to backend
```
