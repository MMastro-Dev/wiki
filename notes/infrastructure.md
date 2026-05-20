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
| Corsair CX600 PSU | On personal PC | **Sold** (personal PC + AI server each get new PSU) |
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
| GPU thermal mod (Gelid pads, MX-7, fan, bracket) | -€130 |
| 4GB DDR4 SODIMM | -€10 |
| DDR3 sale | +€20 |
| VS550 PSU sale | +€20 |
| **Net spent** | **-€865** |

### Remaining Purchases

| Item | Estimated cost |
|---|---|
| Mini-ITX NAS board (Intel N100, 4+ SATA) | €80-130 |
| NAS case (Jonsbo N2) | €70-90 |
| NAS PSU (Corsair SF750 Platinum 2024) | €150-180 |
| NAS boot NVMe (1-2TB) | €100-200 |
| 32GB DDR4 3200MHz 2x16GB DIMM (AI server) | €150 |
| 512GB NVMe Gen3 M.2 2280 (AI server) | €40-45 |
| AI server PSU (Seasonic PRIME PX-1000, 1000W Platinum) | €220-240 |
| AI server case (Thermaltake Tower 300) | €90-110 |
| Main PC PSU (be quiet! Straight Power 12 750W) | €130 |
| Main PC PCIe riser cable | €30-50 |
| **Remaining to spend** | **~€1,060-1,325** |

### 5-Year TCO

| Component | Cost |
|---|---|
| Hardware (total spend) | ~€1,925-2,190 |
| Sales offset (DDR3, VS550, CX600) | ~+€65 |
| Electricity — thin client (5yr, ~12W) | ~€184 |
| Electricity — NAS (5yr, ~18W) | ~€276 |
| Electricity — AI server (5yr, ~60W avg) | ~€920 |
| **5-year total** | **~€3,240-3,505** |

---

## Open Decisions

### Hardware
- [x] RTX 3090 acquired at €765
- [x] PSU: Seasonic PRIME PX-1000 (1000W Platinum, 24/7, future 2-GPU headroom; set `nvidia-smi -pl 320` on first boot)
- [x] GPU cooling: Zotac Trinity stock air cooler + Gelid Ultimate pads + Arctic MX-7 + backplate fan
- [ ] Select NAS mini-ITX board (N100 with 4+ SATA, M.2 slot)
- [ ] AI server case: Thermaltake Tower 300

### NAS Storage
- [ ] Move HDDs from USB dock to native SATA on new NAS board
- [ ] Decide free bay: SnapRAID parity (recommended) vs 4th data drive vs leave empty
- [ ] Plan storage tiering: DBs + thumbs on SSD, originals on HDDs via mergerfs

### AI / Models
- [ ] Benchmark untuned 14B against cv-ai-benchmark.md (Phase 4)
- [ ] If quality insufficient: fine-tune with 50-100 examples (QLoRA, Unsloth)
- [ ] Set `IMMICH_MACHINE_LEARNING_URL` in NAS Immich compose after AI server is live
