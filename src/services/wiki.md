# Wiki (mdBook)

## Purpose

This documentation site. Built with [mdBook](https://rust-lang.github.io/mdBook/) and served from a Docker container. Source lives in the `mastrodocs` Gitea repository.

## Details

| Property | Value |
|---|---|
| Image | Built from `mastrodocs` repo — `Dockerfile` in repo root |
| Port | `1240` (bound to `127.0.0.1`) |
| External URL | `https://wiki.mmastro.dev` |
| Compose path | `/srv/wiki/docker-compose.yml` |
| Source repo | `git.mmastro.dev/mmastro/mastrodocs` |
| CF mode | Grey (DNS-only — not proxied) |
| Auth tier | Admin (OIDC session + LAN IP check) |

## Docker Compose

```yaml
services:
  wiki:
    image: git.mmastro.dev/mmastro/mastrodocs:latest
    container_name: wiki
    restart: unless-stopped
    ports:
      - "127.0.0.1:1240:3000"
    networks:
      - homenet

networks:
  homenet:
    external: true
```

## Caddy Config

```caddy
wiki.mmastro.dev {
    import security_headers_no_CSP
    import require_auth_admin
    reverse_proxy localhost:1240
}
```

## mdBook Plugins

| Plugin | Version | Purpose |
|---|---|---|
| `mdbook-admonish` | 1.20.0 | Info/warning/tip callout blocks |
| `mdbook-mermaid` | 0.14.0 | Mermaid diagram rendering |
| `mdbook-linkcheck` | 0.7.7 | Broken link detection at build time |

## CI/CD

The image is built and published automatically by the Gitea act-runner on push to `main` in the `mastrodocs` repository:

1. Runner builds the Docker image using the repo `Dockerfile`
2. Image is pushed to `git.mmastro.dev/mmastro/mastrodocs:latest`
3. Runner SSHes into the server and runs `docker compose pull && docker compose up -d`

## Update

To manually pull and redeploy the latest image:

```bash
docker compose -f /srv/wiki/docker-compose.yml pull
docker compose -f /srv/wiki/docker-compose.yml up -d
```

## Rebuild from Source

To rebuild the image locally (e.g. after editing content without CI):

```bash
cd /srv/wiki
docker build -t git.mmastro.dev/mmastro/mastrodocs:latest .
docker compose up -d
```
