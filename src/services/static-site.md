# Static Site (mmastro.dev)

**GitHub:** [MMastro-Dev/website](https://github.com/MMastro-Dev/website)

## Purpose

Mobile-first landing page / portfolio SPA at `mmastro.dev`. No container — Caddy serves the static build output directly from the host filesystem.

## Features

- **Responsive SPA** — horizontal scroll on desktop (>1024px), vertical scroll on mobile
- **Four full-screen sections** — Hero, Projects, About, Connect
- **Project cards** — status badges, stack tags, links; modals for detail on mobile

## Tech Stack

| Layer | Technology | Notes |
|---|---|---|
| UI | React 18 | Functional components |
| Language | TypeScript 6 | Inline interfaces, strict types |
| Build | Vite 5 | Dev server with HMR + optimised `dist/` bundle |
| Styling | Tailwind CSS 4 | Mobile-first utility classes |

## Details

| Property | Value |
|---|---|
| External URL | `https://mmastro.dev`, `https://www.mmastro.dev` |
| Files location | `/var/www/html/mastrosite` |
| CF mode | Orange (proxied) |
| Auth tier | None |

## Caddy Config

```caddy
mmastro.dev, www.mmastro.dev {
    import security_headers_no_CSP
    root * /var/www/html/mastrosite
    file_server
    handle_errors {
        rewrite * /404.html
        file_server
    }
}
```

## Deployment

CI/CD via Gitea Actions: push to `main` → Node 20 `npm ci` → `npm run build` (Vite → `dist/`) →
`rsync --delete` over SSH syncs `dist/` to `/var/www/html/mastrosite/` on the host.

Auth uses the `SSH_PRIVATE_KEY_MASTROSITE` Gitea repository secret.

## Update

```bash
git -C /var/www/html/mastrosite pull --rebase
```
