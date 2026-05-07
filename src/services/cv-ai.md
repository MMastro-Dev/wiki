# CV AI

**Repo:** [maxim/mastrocurriculum-ai](https://git.mmastro.dev/maxim/mastrocurriculum-ai/src/branch/main)

## Purpose

A Python/FastAPI service that acts as the AI backend for the CV site. It accepts a CV and a job offer
and returns a structured report scoring how well the CV matches the role.

The service is a REST API — it has no frontend of its own. The CV site (`cv.mmastro.dev`) and any
other client call it directly.

## Stack

| Layer | Technology |
|---|---|
| Language | Python |
| Framework | FastAPI |
| Serving | Uvicorn (inside container) |

## Details

| Property | Value |
|---|---|
| Internal port | `8007` |
| External URL | `https://cv-ai.mmastro.dev` |
| Compose path | `/srv/cv-ai/docker-compose.yml` |
| CF mode | Orange (proxied) |
| Auth tier | None |

## API

The service exposes an endpoint that receives a CV document and a job offer description, then returns
a match report. See the repo README for the full request/response schema.

## Relationship to cv.mmastro.dev

`cv-ai` is the backend behind `cv.mmastro.dev`. The Hugo site itself is static; this service handles
all AI analysis requests that the site (or any other client) triggers.

## Restart

```bash
docker compose -f /srv/cv-ai/docker-compose.yml up -d
```
