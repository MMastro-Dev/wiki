# Architecture Overview

## System Diagram

```mermaid
flowchart TD
    INTERNET([Internet])
    CF["Cloudflare\nOrange cloud: proxied services\nGrey cloud: DNS-only passthrough"]
    CADDY["Caddy 2.9+\nTLS termination · DNS-01/CF plugin\nSubdomain routing · Security headers\ntrusted_proxies cloudflare"]
    FA["forward_auth\noauth2-proxy\nlocalhost:4180"]
    DIRECT["Direct reverse_proxy\n(no-auth services)"]
    PID["Pocket ID (OIDC)\nlogin.mmastro.dev\nlocalhost:1411"]
    STANDARD["Standard tier\nphotos :2283\nbudget :5006\nmemos  :5230\ndrive  :8010"]
    ADMIN["Admin tier\nmail :8025\ngit  :3000\nwiki :1240\ndns  :8088"]

    INTERNET -->|HTTPS| CF
    CF -->|"HTTPS (443)"| CADDY
    CADDY --> FA
    CADDY --> DIRECT
    FA -->|"401 — no session"| PID
    FA -->|"202 — session valid"| STANDARD
    FA -->|"202 — session valid"| ADMIN
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

```mermaid
flowchart TD
    REQ([Request arrives at Caddy])
    NOAUTH{No-auth service?}
    PASSTHROUGH([Pass through to backend])
    STANDARD{Standard tier?}
    FA_STD["forward_auth\noauth2-proxy /oauth2/auth"]
    OK_STD([Pass through to backend])
    REDIR_STD([Redirect to Pocket ID])
    ADMIN{Admin tier?}
    IPCHECK{IP in trusted range?}
    F403([403 Forbidden])
    FA_ADM["forward_auth\noauth2-proxy /oauth2/auth"]
    OK_ADM([Pass through to backend])
    REDIR_ADM([Redirect to Pocket ID])

    REQ --> NOAUTH
    NOAUTH -->|Yes| PASSTHROUGH
    NOAUTH -->|No| STANDARD
    STANDARD -->|Yes| FA_STD
    FA_STD -->|"202 valid session"| OK_STD
    FA_STD -->|"401 no session"| REDIR_STD
    STANDARD -->|No| ADMIN
    ADMIN -->|Yes| IPCHECK
    IPCHECK -->|Not trusted| F403
    IPCHECK -->|Trusted| FA_ADM
    FA_ADM -->|"202 valid session"| OK_ADM
    FA_ADM -->|"401 no session"| REDIR_ADM
```

## Data Flow for Native OIDC Services

Some services (Gitea, Actual Budget, Paperless-ngx) maintain their own OIDC sessions with Pocket ID. When a valid oauth2-proxy session exists, Pocket ID recognises it and silently returns a token — the user sees a single login, not two.

```mermaid
sequenceDiagram
    actor User
    participant Caddy
    participant oauth2-proxy
    participant Backend as Backend Service<br/>(Gitea / Budget / Paperless)
    participant PocketID as Pocket ID

    User->>Caddy: Request
    Caddy->>oauth2-proxy: forward_auth check
    oauth2-proxy-->>Caddy: 202 session valid
    Caddy->>Backend: Proxied request
    Backend->>PocketID: Initiates own OIDC flow
    PocketID-->>Backend: Session exists → silent token
    Backend-->>User: Signed in
```
