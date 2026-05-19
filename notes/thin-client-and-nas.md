# Thin Client and NAS Plan

## Architecture Change

Previously the Wyse 5070 served as both NAS and application server, with HDDs attached via a USB 3.0 dock. The new plan splits this into two machines:

- **Thin client:** Wyse 5070 (already owned) runs gateway services only
- **Dedicated NAS:** new mini-ITX build with native SATA for the HDDs

This eliminates the USB storage bottleneck (the main reliability and performance concern) and isolates the critical gateway path from application workloads.

### Why Not Keep the Wyse as NAS?

The USB 3.0 dock is the problem. All three HDDs share a single USB-SATA bridge with ~300-350 MB/s total bus bandwidth and +1-3ms latency per I/O operation. ZFS over USB is not safe (silent corruption risk). The storage tiering workaround (DBs on SSD, bulk on USB HDDs) was workable but left stability risks: USB reset errors, enclosure power issues, and no path to ZFS or proper RAID.

With native SATA the HDDs run at full speed per-drive, ZFS or mdadm become safe options, and the enclosure + its flaky power brick are eliminated.

### Why Not Buy a Lenovo M715q-2 as Thin Client?

The Wyse 5070 is already owned, already running, and has 16GB RAM + a 1TB SSD. It is massively overpowered for gateway services (Caddy, AdGuard, oauth2-proxy, Pocket ID use <2GB RAM total). Buying a separate thin client saves €60-70 but adds another device to set up. Using the Wyse means the thin client costs €0.

---

## The Thin Client: Dell Wyse 5070

| Property | Value |
|---|---|
| CPU | Celeron J4105 (4C/4T, 10W) |
| RAM | 16GB DDR4 (far more than needed) |
| Storage | 1TB M.2 SATA SSD (far more than needed) |
| Idle power | ~12W |
| Annual electricity | ~€37 |

### Services

- **Caddy** (reverse proxy, TLS via DNS-01 + Cloudflare)
- **AdGuard Home** (DNS, split-DNS rewrites for `*.mmastro.dev`)
- **oauth2-proxy** (OIDC session validation)
- **Pocket ID** (passkey-only OIDC provider)
- **Netdata** (monitoring)
- **Uptime Kuma** (status checks)
- **Loki + Promtail** (log aggregation — Loki stores on NAS via NFS, never locally)

All services combined use <2GB RAM. The 1TB SSD is vast overkill but already installed; no reason to swap it out. The remaining capacity can store Loki data locally if NFS to the NAS is not yet configured.

### Software

- OS: Debian 12 Bookworm (minimal, headless) — already installed
- Runtime: Docker + Docker Compose
- `unattended-upgrades` for security patches
- `docker system prune` weekly via cron
- Docker restart policy: `unless-stopped`

### Reliability

The thin client is stateless. All config is in Gitea. Recovery = fresh Debian + `docker compose up`.

**Gitea does NOT run here.** Repo data grows unboundedly and CI/CD builds spike CPU/memory, which risks latency on Caddy/DNS responses. Gitea stays on the NAS.

---

## The NAS: Mini-ITX Build

### Why Build Instead of Buy a Prebuilt NAS?

Prebuilt NAS devices (Synology, QNAP) cost €300-500 for 4-bay models, run proprietary software, and limit Docker flexibility. A mini-ITX build with an Intel N100 costs €160-280, runs standard Debian, and connects HDDs via native SATA — the single requirement the Wyse 5070 couldn't meet.

### Hardware

| Component | Options | Cost |
|---|---|---|
| Mini-ITX board (4+ SATA, M.2 slot) | ASRock N100M, Topton/CWWK N100, used J5040-ITX | €80-130 |
| Case (4-bay 3.5") | Jonsbo N2/N3, Inter-Tech SC-4100 | €50-100 |
| PSU | PicoPSU-160-XT + 120W DC brick (or SFX) | €30-50 |
| RAM | 8GB DDR4 SODIMM (owned: 4GB PC4-2400T + 4GB PC4-2666V) | €0 |
| Boot SSD | Cheap NVMe or M.2 SATA (see below) | €0-45 |
| HDDs | 3x WD Red 4TB (owned, moved from USB dock) | €0 |
| **Total** | | **€160-280** |

### Boot SSD: NVMe vs SATA

Fast PCIe NVMe is not necessary for a NAS. NAS workloads are IOPS-bound (database random reads), not sequential-bandwidth-bound. A SATA SSD (~80K IOPS, ~500 MB/s) is indistinguishable from NVMe (~500K IOPS, ~3500 MB/s) at this scale.

Options:
- **If the N100 board has an M.2 SATA slot (key B+M):** use a cheap M.2 SATA drive or buy one (~€25-35 for 256GB)
- **If the N100 board only has M.2 NVMe (key M):** buy a cheap Gen3 NVMe (~€35-45 for 512GB). Gen4/Gen5 is wasted money.
- **Alternative:** boot from a 2.5" SATA SSD (the owned 60GB drive) via SATA. Saves the M.2 slot but 60GB may be tight with Docker images + databases.

The 1TB SSD stays in the Wyse 5070 (thin client). It is M.2 SATA keyed for the Wyse's slot and likely won't fit an NVMe-only board.

### DDR5: Not Worth It

DDR5 boards cost €20-40 more and DDR5 SODIMMs are more expensive than DDR4. The bandwidth difference (DDR4 3200: ~25 GB/s vs DDR5 4800: ~38 GB/s) is irrelevant when the bottleneck is disk I/O and services use <4GB RAM actively. DDR4 SODIMMs are already owned. Use them.

### Services

Everything that currently runs on the Wyse 5070 except the gateway services:

- Immich (server, database, Redis — ML offloaded to AI server)
- Paperless-ngx
- Actual Budget
- Memos
- Hugo Blog
- CV site (static Hugo)
- CV Forms
- MailHog
- Gitea + act-runner
- Wiki (mdBook)
- Static site
- Promtail (ships logs to thin client Loki)

### Storage Architecture

With native SATA, the USB bottleneck is gone. The storage tiering strategy becomes simpler and more reliable:

| Data type | Location | Reason |
|---|---|---|
| PostgreSQL DBs (Immich, Paperless) | Boot SSD | Random I/O (IOPS-critical) |
| Immich thumbnails + previews | Boot SSD | Served on every page load |
| Docker images + container volumes | Boot SSD | Random access |
| OS + configs | Boot SSD | Standard |
| Immich originals (`upload/`) | HDDs | Large files, written once |
| Paperless documents (`media/`) | HDDs | Same pattern |
| Log storage (Loki via NFS from thin client) | HDDs | Sequential append |
| Backups | HDDs | Sequential write |

### HDD Pool

**mergerfs** pools the WD Reds into a single mountpoint (`/mnt/pool`). Spreads files by policy, no RAID overhead, individual drives remain readable without the pool.

With native SATA, **ZFS** or **mdadm** also become safe options. ZFS adds data integrity (checksums), compression, and snapshots but uses more RAM (~1GB per TB of storage for ARC cache — ~12GB for 12TB, which is more than the 8GB available). mdadm RAID5 is lighter on RAM.

**Recommendation:** start with mergerfs + SnapRAID (same approach as the USB plan, but now reliable). Evaluate ZFS or mdadm later when the NAS has more RAM (16GB+ via a SODIMM upgrade).

### Free Bay

| Option | Cost | Verdict |
|---|---|---|
| SnapRAID parity drive (4TB+ WD Red) | ~€80-100 | Protects originals from single drive failure |
| 4th data drive | ~€80-100 | More capacity, no redundancy |
| Leave empty | €0 | Acceptable if cloud backup exists |

---

## Thin Client vs NAS: What Goes Where

The split is clean:

**Thin client (Wyse 5070) = gateway.** Every external request passes through it. If it goes down, nothing is reachable from outside. It must be simple and stable. No application data, no growing databases, no CI/CD builds.

**NAS = applications + storage.** All user-facing services, all persistent data. If it goes down, services are unavailable but the gateway is fine (Caddy returns 502s). Recovery from backup is straightforward.

**AI server = GPU compute.** Ollama, CV-AI, Immich ML. If it goes down, the degradation is limited: CV-AI is offline, Immich smart search pauses, but photos and all other services remain accessible.

---

## Phasing

The NAS build is the main new investment. It can be deferred if budget is tight — the Wyse 5070 + USB dock continues to work. The most impactful sequence:

1. **AI server first** (GPU cooling + remaining parts) — this is where most of the budget is already committed
2. **NAS build second** (when a good deal on an N100 board + case appears) — move HDDs from USB dock to native SATA, migrate services
3. **Repurpose Wyse 5070 as thin client last** — move gateway services off the NAS, strip down to Caddy/AdGuard/auth

Steps 2 and 3 happen together in practice: you build the NAS, migrate everything, then reconfigure the Wyse as gateway-only.
