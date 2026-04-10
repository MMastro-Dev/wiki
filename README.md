# MMastro.dev's Wiki

Personal wiki and documentation site for [MMastro.dev](https://mmastro.dev), built with [mdBook](https://rust-lang.github.io/mdBook/). Serves as a self-hosted reference for the infrastructure, services, and configurations powering the site.

Live at: **[https://wiki.mmastro.dev](https://wiki.mmastro.dev)** (Admin auth — LAN/VPN access only)

## Purpose

A living reference for future me — covering setup guides, self-hosted service configs, and any other notes worth keeping around.

## Deployment

The wiki runs as a Docker container on the homeserver (`wiki.mmastro.dev`, port `1240`).
Pushing to `main` triggers the Gitea act-runner which:
1. Builds the image from this `Dockerfile`
2. Pushes it to `git.mmastro.dev/mmastro/mastrodocs:latest`
3. SSHes into the server and runs `docker compose pull && docker compose up -d`

To manually redeploy:

```bash
docker compose -f /srv/wiki/docker-compose.yml pull
docker compose -f /srv/wiki/docker-compose.yml up -d
```

## Local Development

### With Docker

```bash
docker build -t mastrodocs .
docker run --rm -p 3000:3000 mastrodocs
```

Then open http://localhost:3000 in your browser.

### Without Docker

```bash
mdbook serve --port 3000 --open
```

Or build only (outputs to `book/`):

```bash
mdbook build
```

## Plugins

| Plugin | Version | Purpose |
|---|---|---|
| `mdbook-admonish` | 1.20.0 | Info/warning/tip callout blocks |
| `mdbook-mermaid` | 0.17.0 | Mermaid diagram rendering |
| `mdbook-linkcheck` | 0.7.7 | Broken link detection at build time |

## Project Structure

```
.
├── book.toml       # mdBook configuration
├── Dockerfile      # Container build & serve setup
└── src/            # Book source files (Markdown)
    └── SUMMARY.md  # Table of contents
```
