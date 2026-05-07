# CV Site

**GitHub:** [MMastro-Dev/cv](https://github.com/MMastro-Dev/cv)

## Purpose

A minimalist, data-driven Hugo CV/portfolio site at `cv.mmastro.dev`. All content lives in a single
`assets/data/cv.yaml` file. Publicly accessible, no authentication.

## Features

- **Single source of truth** — all content in `assets/data/cv.yaml`; separate YAML files for job-tailored variants
- **PDF auto-generation** — CI/CD builds a print-ready `cv.pdf` via headless Chromium on every deploy
- **No JavaScript** — pure HTML + CSS, zero client-side dependencies
- **WCAG 2.1 AA compliant** — skip-link, `aria-labelledby`, focus styles, 4.5:1 contrast, greyscale-safe
- **CV variant library** — company-specific CV pages at separate slugs, each from its own YAML file
- **AI Copilot skills** — `job-fitness-review` (ATS scoring, tailored variant generation) and `cv-variant-sync` (propagate base CV changes to all variants)

## Stack

| Layer | Technology |
|---|---|
| Site generator | Hugo Extended ≥ 0.156 |
| Serving | nginx:alpine (inside container) |
| PDF | Headless Chromium (build-time only) |
| Build image | `debian:bookworm-slim` (multi-stage) |

## Details

| Property | Value |
|---|---|
| Internal port | `8001` |
| External URL | `https://cv.mmastro.dev` |
| Compose path | `/srv/cv/docker-compose.yml` |
| CF mode | Orange (proxied) |
| Auth tier | None |

## Deployment

CI/CD via Gitea Actions (`.gitea/workflows/deploy.yml`): push to `main` → Hugo build + PDF generation →
Docker image pushed to `git.mmastro.dev` registry → SSH deploy (`docker pull` + `docker run --restart unless-stopped`).

Required Gitea secrets: `REGISTRY_URL`, `REGISTRY_USER`, `REGISTRY_TOKEN`, `SITE_URL`, `DEPLOY_HOST`, `DEPLOY_USER`, `DEPLOY_KEY`.

## Restart

```bash
docker compose -f /srv/cv/docker-compose.yml up -d
```
