# Infrastructure Overview

## Operator Profile

Software developer working toward AI/ML integration expertise. Manages the homelab alone. Prefers reliability and low maintenance over features. Location: Italy. Electricity: €0.35/kWh.

Uses a GitHub Copilot work license (Claude Sonnet) as primary AI — wants to offload routine tasks to self-hosted models to reduce token spend.

---

## 3-Server Architecture

| Server | Hardware | Role | Idle power |
|---|---|---|---|
| **Thin Client** | Dell Wyse 5070 (Celeron J4105, 16GB, 1TB SSD) | Gateway: Caddy, AdGuard, oauth2-proxy, Pocket ID | ~12W |
| **NAS** | Mini-ITX build (Intel N100, 8GB DDR4, native SATA) | Storage + all application services | ~15-20W |
| **AI Server** | Ryzen 3600X + RTX 3090 24GB + 32GB DDR4 | Ollama, Open WebUI, CV-AI, Immich ML | ~60-75W |

### Service Distribution

| Server | Services |
|---|---|
| **Thin Client** | Caddy, AdGuard Home, oauth2-proxy, Pocket ID, Netdata, Uptime Kuma, Loki+Promtail |
| **NAS** | Immich (server+DB+data), Paperless-ngx, Actual Budget, Memos, Hugo Blog, CV site, CV Forms, MailHog, Gitea, Wiki, Static Site |
| **AI Server** | Ollama, Open WebUI, CV-AI (FastAPI), immich-machine-learning (GPU) |

The thin client handles the gateway layer (proxy, DNS, auth). The NAS handles all application services and storage with native SATA for the HDDs. The AI server handles GPU compute. If the AI server goes down, only CV-AI and Immich smart search are affected.

---

## Hardware Inventory

| Component | Status | Destination |
|---|---|---|
| Dell Wyse 5070 (Celeron J4105, 16GB, 1TB M.2 SATA SSD) | In use | Thin client (repurposed) |
| AMD Ryzen 5 3600X | Owned, idle | AI server |
| MSI B450M-A PRO MAX | Owned, idle | AI server |
| Corsair CX600 PSU | On personal PC | AI server (personal PC gets new PSU) |
| RTX 3090 24GB (no cooler) | ✅ Acquired, €765 | AI server |
| 4GB DDR4 SODIMM PC4-2400T | Owned | NAS (part of 8GB kit) |
| 4GB DDR4 SODIMM PC4-2666V | ✅ Acquired, €10 | NAS (part of 8GB kit) |
| 8GB DDR4 SODIMM | Owned | NAS |
| 2.5" SATA SSD (60GB) | Owned | Spare |
| 2.5" HDD (320GB) | Owned | Spare / sell |
| 3x WD Red 4TB HDD | In use (USB dock) | NAS (native SATA) |
| 1TB M.2 SATA SSD | In Wyse 5070 | Stays in thin client |
| USB 4-bay dock | In use | Retired (HDDs move to NAS case) |

### Already Sold

- 2x 8GB DDR3 SODIMM — €20
- Corsair VS550 PSU — €20

---

## Service Map

| Subdomain | Service | Port | Auth | Server |
|---|---|---|---|---|
| `login.mmastro.dev` | Pocket ID | 1411 | None | Thin client |
| `auth.mmastro.dev` | oauth2-proxy | 4180 | None | Thin client |
| `dns.mmastro.dev` | AdGuard Home | 8088 | Admin | Thin client |
| `mmastro.dev` | Static site | files | None | NAS |
| `blog.mmastro.dev` | Hugo blog | 8000 | None | NAS |
| `cv.mmastro.dev` | CV (Hugo) | 8001 | None | NAS |
| `cv-ai.mmastro.dev` | CV AI (FastAPI) | 8007 | None | AI server |
| `cv-forms.mmastro.dev` | CV Forms | 8008 | None | NAS |
| `git.mmastro.dev` | Gitea | 3000 | Admin | NAS |
| `photos.mmastro.dev` | Immich | 2283 | Standard | NAS (app) + AI server (ML) |
| `budget.mmastro.dev` | Actual Budget | 5006 | Standard | NAS |
| `mail.mmastro.dev` | MailHog | 8025 | Admin | NAS |
| `memos.mmastro.dev` | Memos | 5230 | Standard | NAS |
| `drive.mmastro.dev` | Paperless-ngx | 8010 | Standard | NAS |
| `wiki.mmastro.dev` | mdBook wiki | 1240 | Admin | NAS |

### Auth Tiers

| Tier | Caddy snippet | Requirement |
|---|---|---|
| None | — | Public or self-authenticated |
| Standard | `import require_auth` | oauth2-proxy OIDC session |
| Admin | `import require_auth_admin` | OIDC session + LAN/VPN IP (192.168.178.0/24) |

---

## Budget Summary

### Spent

| Item | Amount |
|---|---|
| RTX 3090 24GB | -€765 |
| 4GB DDR4 SODIMM | -€10 |
| DDR3 sale | +€20 |
| VS550 PSU sale | +€20 |
| **Net spent** | **-€735** |

### Remaining Purchases

| Item | Estimated cost |
|---|---|
| GPU AIO cooling kit (used) | €80-120 |
| Mini-ITX NAS board (Intel N100, 4+ SATA) | €80-130 |
| NAS case (4-bay, Jonsbo N2/N3 or similar) | €50-100 |
| NAS PSU (PicoPSU + DC brick or SFX) | €30-50 |
| 32GB DDR4 3200MHz 2x16GB (AI server) | €60-65 |
| 512GB NVMe Gen3 M.2 2280 (AI server) | €40-45 |
| PSU for personal PC (frees CX600) | €50-60 |
| AI server case (if needed) | €30-40 |
| **Remaining to spend** | **~€420-610** |

### 5-Year TCO

| Component | Cost |
|---|---|
| Hardware (total) | ~€1,155-1,345 |
| Electricity — thin client (5yr, ~12W) | ~€184 |
| Electricity — NAS (5yr, ~18W) | ~€276 |
| Electricity — AI server (5yr, ~60W avg) | ~€920 |
| **5-year total** | **~€2,535-2,725** |

---

## Open Decisions

### Hardware
- [x] RTX 3090 acquired at €765
- [x] PSU: CX600 on AI server (set `nvidia-smi -pl 320` on first boot)
- [ ] Find GPU AIO cooling (Alphacool Eiswolf 3090 / Bykski AIO kit, €80-120)
- [ ] Select NAS mini-ITX board (N100 with 4+ SATA, M.2 slot)
- [ ] Select NAS case (4-bay, space for 3x 3.5" + 1x 2.5")
- [ ] AI server case with 240mm radiator support (or use existing)

### NAS Storage
- [ ] Move HDDs from USB dock to native SATA on new NAS board
- [ ] Decide free bay: SnapRAID parity (recommended) vs 4th data drive vs leave empty
- [ ] Plan storage tiering: DBs + thumbs on SSD, originals on HDDs via mergerfs

### AI / Models
- [ ] Benchmark untuned 14B against cv-ai-benchmark.md (Phase 4)
- [ ] If quality insufficient: fine-tune with 50-100 examples (QLoRA, Unsloth)
- [ ] Set `IMMICH_MACHINE_LEARNING_URL` in NAS Immich compose after AI server is live
