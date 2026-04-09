# Static Site (mmastro.dev)

## Purpose

Main personal site served as static files. No container involved — Caddy serves the files directly.

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

Files are deployed by the Gitea act-runner on push to `main` via SSH pull:
`git -C /var/www/html/mastrosite pull --rebase`

This command is allowed by the gitea-runner SSH command filter.

## Update

```bash
git -C /var/www/html/mastrosite pull --rebase
```
