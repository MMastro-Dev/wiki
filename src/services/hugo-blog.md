# Hugo Blog

## Purpose

Public-facing blog at `blog.mmastro.dev`. Built via Gitea CI and deployed as a Docker container.
No authentication — publicly accessible.

## Details

| Property | Value |
|---|---|
| Internal port | `8000` |
| External URL | `https://blog.mmastro.dev` |
| Compose path | `/srv/hugo-blog/docker-compose.yml` |
| Source mount | `/srv/hugo-blog` (used by Gitea act-runner during CI builds) |
| CF mode | Orange (proxied) |
| Auth tier | None |

## Deployment

The blog is built and deployed automatically by the Gitea act-runner pipeline on push to `main`.
The pipeline builds the Docker image, pushes to `git.mmastro.dev` registry, and restarts the container via SSH.

## Restart

```bash
docker compose -f /srv/hugo-blog/docker-compose.yml up -d
```
