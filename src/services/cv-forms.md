# CV Forms

## Purpose

A UI for editing and creating CV content. It lets you modify the structured data that drives
`cv.mmastro.dev` — and in future will export files that the CV site can serve directly.

## Details

| Property | Value |
|---|---|
| Internal port | `8008` |
| External URL | `https://cv-forms.mmastro.dev` |
| Compose path | `/srv/cv-forms/docker-compose.yml` |
| CF mode | Orange (proxied) |
| Auth tier | None |

## Relationship to cv.mmastro.dev

Currently a standalone editing tool. The planned output format is a YAML file compatible with
`cv.mmastro.dev`'s `assets/data/cv.yaml`, so edited CVs can be dropped straight into the Hugo build.

## Restart

```bash
docker compose -f /srv/cv-forms/docker-compose.yml up -d
```
