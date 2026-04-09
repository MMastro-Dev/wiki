# CV Site

## Purpose

Hugo-based CV/portfolio site at `cv.mmastro.dev`. Publicly accessible, no authentication.
Follows the same CI/CD structure as the Hugo blog — built via Gitea CI and deployed as a Docker container.

## Details

| Property | Value |
|---|---|
| Internal port | `8001` |
| External URL | `https://cv.mmastro.dev` |
| Compose path | `/srv/cv/docker-compose.yml` |
| CF mode | Orange (proxied) |
| Auth tier | None |

## Deployment

Same CI/CD pipeline pattern as the Hugo blog:
built by the Gitea act-runner on push to `main`, pushed to the `git.mmastro.dev` container registry,
and deployed via SSH to the server.

## Restart

```bash
docker compose -f /srv/cv/docker-compose.yml up -d
```
