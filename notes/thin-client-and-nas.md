# Thin Client and NAS Plan

## Architecture: Balanced Split

The infrastructure is split across three machines, each with a clear role:

| Machine | Role | Key constraint |
|---|---|---|
| **Thin client** (Dell Wyse 5070) | Ingress, auth, DNS, light apps, Gitea, monitoring | Must stay responsive for reverse proxy and DNS |
| **NAS** (mini-ITX N100 build) | Storage pools, Immich, Paperless-ngx | Native SATA for HDDs, enough RAM for storage cache + two heavy apps |
| **AI server** (Ryzen 3600X + RTX 3090) | LLM inference, Immich ML, optional CI runner | GPU compute, not storage or ingress |

This balanced split keeps the two most storage-hungry and burst-heavy apps (Immich and Paperless) on the NAS alongside the disks they use, while the thin client handles everything else. The AI server stays focused on GPU work and optionally runs heavy CI jobs.

### Why Split at All?

The Wyse 5070's USB 3.0 dock is the problem. All HDDs share a single USB-SATA bridge with ~300-350 MB/s total bus bandwidth and +1-3ms latency per I/O. ZFS over USB is unsafe (silent corruption risk). USB reset errors and enclosure power issues make it unreliable for always-on storage.

With native SATA on a dedicated NAS, per-drive bandwidth is full, ZFS or mdadm become safe, and the flaky USB enclosure is eliminated.

### Why Not Buy a Separate Thin Client?

The Wyse 5070 is already owned and running. It has a 1TB SSD and more CPU than needed for this role. Buying another device adds cost and setup work for no gain.

---

## The Thin Client: Dell Wyse 5070

| Property | Value |
|---|---|
| CPU | Celeron J4105 (4C/4T, 10W) |
| RAM | 8GB DDR4 (2x4GB spare kit, swapped from original 16GB) |
| Storage | 1TB M.2 SATA SSD |
| Idle power | ~12W |
| Annual electricity | ~€37 |

### Services

**Gateway / Infrastructure:**
- Caddy (reverse proxy, TLS via DNS-01 + Cloudflare)
- AdGuard Home (DNS, split-DNS rewrites for `*.mmastro.dev`)
- oauth2-proxy (OIDC session validation)
- Pocket ID (passkey-only OIDC provider)

**Monitoring / Logging:**
- Netdata (system + container metrics)
- Uptime Kuma (status checks)
- Loki + Promtail (log aggregation; Loki data stored on NAS via NFS)

**Applications (light):**
- Gitea (Git hosting; CI coordination only, heavy jobs run elsewhere)
- Memos
- Actual Budget
- MailHog
- Hugo Blog (static)
- CV site (static Hugo)
- CV Forms
- Wiki (mdBook, static)
- Static site

### RAM Budget (8GB baseline)

| Service group | Steady | Burst |
|---|---:|---:|
| Caddy + AdGuard + oauth2-proxy + Pocket ID | 0.3-0.8 GB | 1.0 GB |
| Netdata + Uptime Kuma + Loki + Promtail | 0.6-1.3 GB | 2.0 GB |
| Gitea (no heavy runner) | 0.3-0.5 GB | 0.8 GB |
| Memos + Actual Budget + MailHog + CV Forms | 0.4-0.8 GB | 1.2 GB |
| Static sites (served by Caddy) | ~0 | ~0 |
| OS + Docker overhead | 0.5-0.8 GB | 1.0 GB |
| **Total** | **2.1-4.2 GB** | **6.0 GB** |

8GB provides headroom above steady-state usage with room for typical bursts. This is a monitored baseline, not a permanent sizing guarantee.

### Software

- OS: Debian 12 Bookworm (minimal, headless)
- Runtime: Docker + Docker Compose
- `unattended-upgrades` for security patches
- `docker system prune` weekly via cron
- Docker restart policy: `unless-stopped`

### Reliability

The thin client is critical infrastructure: if it goes down, nothing is reachable from outside. It must stay simple and responsive.

All config is in Gitea. Recovery = fresh Debian + `docker compose up`.

Moving Immich and Paperless off this box removes the two biggest sources of background CPU/RAM spikes (OCR, thumbnail generation, database churn) and keeps the ingress path clean.

---

## The NAS: Mini-ITX Build

### Why Build Instead of Buy?

Prebuilt NAS devices (Synology, QNAP) cost €300-500 for 4-bay models, run proprietary software, and limit Docker flexibility. A mini-ITX N100 build runs standard Debian, connects HDDs via native SATA, and costs less while offering more control.

### Hardware

| Component | Choice | Cost |
|---|---|---|
| Mini-ITX board (4+ SATA, M.2 slot) | ASRock N100M, Topton/CWWK N100, used J5040-ITX | €80-130 |
| Case (5-bay 3.5") | Jonsbo N2 (aluminum, premium) | €70-90 |
| PSU | Corsair SF750 Platinum 2024 (SFX, 750W, 80+ Platinum) | €150-180 |
| RAM | 16GB DDR4 SODIMM (reused from Wyse 5070, no purchase) | €0 |
| Boot NVMe | 1TB (€100) or 2TB (€200) | €100-200 |
| HDDs (main pool) | 3x WD Red 4TB (owned) | €0 |
| HDDs (AI workspace) | 2x WD Black 2TB (owned) | €0 |
| **Total** | | **€400-600** |

The Jonsbo N2 and Corsair SF750 are premium aesthetic choices. Cheaper alternatives exist but these give the NAS a clean, solid build quality that matches the rest of the setup.

### RAM Strategy

The Wyse 5070's original 16GB (2x8GB) kit moves into the NAS. The spare 2x4GB kit goes into the Wyse. No RAM purchase is needed now.

**Why 16GB on the NAS:** Paperless-ngx and Immich each carry Postgres, Redis, and their own app processes. Combined with filesystem cache (or ZFS ARC if adopted later), 16GB is a comfortable working target. A future upgrade to 32GB is only justified if monitoring shows sustained memory pressure or ZFS ARC contention.

**Why 8GB on the thin client:** the services there are individually small and collectively stay well under 6GB even during bursts. If monitoring later shows swap activity or responsiveness drops, the upgrade path is buying a 2x8GB SODIMM kit (~€25-30).

### Boot NVMe

NAS workloads are IOPS-bound (database random reads), not sequential-bandwidth-bound. A SATA SSD is indistinguishable from NVMe at this scale, but NVMe Gen3 drives in the 1-2TB range offer good value and leave room for Postgres, Docker images, and thumbnails without tight space management.

- **1TB NVMe (~€100):** comfortable for Immich thumbnails + Paperless DB + Docker layers with room to spare
- **2TB NVMe (~€200):** future-proof if Immich thumbnail cache or Postgres WAL grows significantly

Gen4/Gen5 is wasted money at this scale. A cheap Gen3 drive is the right choice.

### DDR5: Not Worth It

DDR5 boards cost €20-40 more, DDR5 SODIMMs are pricier, and the bandwidth gain is irrelevant when the bottleneck is disk I/O and services use <8GB actively. Reuse DDR4.

### Services

**Storage-heavy applications:**
- Immich (server, database, Redis; ML offloaded to AI server)
- Paperless-ngx (app, database, Redis)
- Promtail (ships logs to thin client Loki)

**Storage services:**
- NFS/SMB exports for thin client and AI server
- HDD pool management (mergerfs or ZFS)
- SnapRAID sync (if using mergerfs + SnapRAID)
- Backup targets

### RAM Budget (16GB baseline)

| Service group | Steady | Burst |
|---|---:|---:|
| Immich stack (app + Postgres + Redis) | 1.0-1.8 GB | 2.5-4.0 GB |
| Paperless-ngx stack (app + Postgres + Redis) | 0.8-1.5 GB | 2.0-3.0 GB |
| Promtail | 0.03-0.08 GB | 0.12 GB |
| OS + Docker overhead | 0.5-0.8 GB | 1.0 GB |
| Filesystem cache / ZFS ARC | 2.0-8.0 GB | flexible |
| **Total (apps + OS)** | **2.3-4.2 GB** | **5.6-8.1 GB** |

The remaining RAM (8-12 GB steady) is available for filesystem cache or ZFS ARC, which directly improves read performance for photo libraries and document searches.

---

## Storage Architecture

### Data Placement

| Data type | Location | Reason |
|---|---|---|
| PostgreSQL DBs (Immich, Paperless) | NAS boot SSD | Random I/O, IOPS-critical |
| Immich thumbnails + previews | NAS boot SSD | Served on every page load |
| Docker images + container volumes | NAS boot SSD | Random access |
| NAS OS + configs | NAS boot SSD | Standard |
| Immich originals (`upload/`) | NAS HDDs | Large files, written once |
| Paperless documents (`media/`) | NAS HDDs | Same pattern |
| Backups | NAS HDDs | Sequential write |
| AI datasets, model archive, dev workspaces | NAS HDDs (AI pool) | Large, idle between sessions |
| Log storage (Loki data via NFS) | NAS HDDs | Sequential append |
| Thin client Docker images + app data | Thin client SSD | Local, fast |
| Gitea repos + CI artifacts | Thin client SSD | Local, moderate I/O |

### HDD Pool: Main Storage (3x WD Red 4TB)

**Recommendation:** start with mergerfs + SnapRAID. mergerfs pools the drives into a single mountpoint (`/mnt/pool`), SnapRAID adds parity protection. This is simple, low-RAM, and reliable over native SATA.

Evaluate ZFS later if monitoring shows the 16GB RAM budget can accommodate ARC for 12TB (~12GB ARC ideal, which leaves little for apps). ZFS adds checksums, compression, and snapshots but is RAM-hungry at this pool size.

### HDD Pool: AI Workspace (2x WD Black 2TB)

ZFS mirror, separate from the main pool:
- 2TB usable with single-drive redundancy
- ZFS ARC for 2TB is ~2GB, fits within the RAM budget alongside apps
- Drives are idle between AI sessions; spin-down keeps power near zero

**WD Black TLER fix** — desktop drives lack TLER by default. Without it, slow sector recovery can stall long enough for ZFS to drop a drive:

```bash
hdparm -J 7 --please-destroy-my-drive /dev/sdX
```

Persist in `/etc/hdparm.conf`:

```
/dev/sdX {
    write_read_sector_timeouts = 7 7
}
```

**Spin-down** (10-minute idle timeout):

```bash
hdparm -S 120 /dev/sdX   # 120 x 5s = 10 minutes
```

Persist spin-down in `/etc/hdparm.conf`. Reduce ZFS txg commit interval via `/etc/modprobe.d/zfs.conf`:

```
options zfs zfs_txg_timeout=30
```

Monthly scrubs will spin drives up regardless.

### Free Bay

| Option | Cost | Verdict |
|---|---|---|
| SnapRAID parity drive (4TB+ WD Red) | ~€80-100 | Protects originals from single drive failure |
| 4th data drive | ~€80-100 | More capacity, no redundancy |
| Leave empty | €0 | Acceptable if cloud backup exists |

---

## CI/CD Placement

Gitea stays on the thin client. It is a lightweight Git server for personal use and coordinates CI workflows without executing heavy jobs locally.

**Runner strategy:**
- A lightweight `act-runner` on the thin client handles basic jobs (Hugo builds, static site deploys, container pushes). These are short, low-memory tasks.
- A separate `act-runner` on the AI server handles heavy or AI-related jobs (model evaluation, dataset processing, GPU-assisted pipelines). Register this runner with specific tags so only selected workflows execute there.

This keeps the Wyse responsive during builds. The AI server is already sized for compute-heavy work and carries the load without affecting ingress or DNS.

---

## Scheduled Jobs and Burst Optimization

Background and scheduled work is the main source of burst impact on both machines. Spreading jobs across time windows and prioritizing them correctly prevents temporary resource exhaustion.

### Thin Client Scheduled Jobs

| Job | Schedule | Impact | Strategy |
|---|---|---|---|
| `docker system prune` | Weekly, Sunday 04:00 | Low CPU, brief I/O | Run during lowest-traffic window |
| `unattended-upgrades` | Daily, 06:00 (default) | Moderate CPU during install | Keep default; brief and infrequent |
| Loki compaction | Configurable (default: on write) | Moderate I/O, brief CPU | Set `compaction_interval: 24h`, schedule at 03:00 |
| Uptime Kuma checks | Every 60s (per monitor) | Negligible per-check | Keep default; no scheduling concern |
| Netdata collection | Continuous (1s interval) | ~2-5% CPU baseline | Reduce collection frequency to 5s if CPU is tight |
| Gitea mirror sync | Per-mirror schedule | Brief CPU + network | Stagger mirrors, avoid overlap with CI runs |
| `certbot` / Caddy OCSP | Automatic | Negligible | No action needed |

### NAS Scheduled Jobs

| Job | Schedule | Impact | Strategy |
|---|---|---|---|
| SnapRAID sync | Daily, 02:00 | Heavy I/O for 10-30 min | Run at night; `ionice -c3` to yield to interactive I/O |
| SnapRAID scrub | Weekly, Sunday 03:00 | Heavy sustained I/O | Night only; limit to 5-10% of data per run (`-p 5`) |
| ZFS scrub (AI pool) | Monthly, 1st Sunday 04:00 | Moderate I/O | Night; only 2TB so it completes quickly |
| Paperless consumer | On file arrival or every 10 min | High CPU (OCR), moderate RAM | Use `inotifywait` for on-demand rather than polling; limit concurrency to 1 task |
| Immich background jobs | Continuous (thumbnail gen, metadata) | Moderate CPU + RAM spikes | Configure `IMMICH_WORKERS_INCLUDE` to cap concurrent jobs; avoid overlap with SnapRAID |
| PostgreSQL vacuum | Nightly, autovacuum + manual VACUUM ANALYZE weekly | Moderate I/O | Let autovacuum handle daily; run full VACUUM ANALYZE at 05:00 Sunday |
| `docker system prune` | Weekly, Sunday 04:30 | Low CPU, brief I/O | After SnapRAID scrub completes |
| Backup (rsync/restic to external) | Daily, 01:00 | Heavy I/O | Run before SnapRAID sync; `ionice -c3` + `nice -n 19` |
| HDD spin-down | After 10 min idle | None (passive) | Align job schedules into a single nightly window so drives spin up once |

### Scheduling Principles

1. **Batch nightly work into one window.** If multiple jobs spin up the HDDs, run them consecutively (not concurrently) in a single 01:00-05:00 window. This avoids repeated spin-up/spin-down cycles and keeps the rest of the day quiet.

2. **Use `ionice -c3` and `nice -n 19` for background I/O.** SnapRAID sync, backups, and scrubs should yield to interactive requests (Immich browsing, Paperless searches). The idle I/O class ensures these jobs only use disk bandwidth that is not needed by foreground work.

3. **Limit Paperless OCR concurrency.** Set `PAPERLESS_TASK_WORKERS=1` (or 2 max). OCR is CPU-intensive and memory-hungry; on an N100 with 4 cores, more than 2 concurrent OCR tasks will starve everything else.

4. **Cap Immich background workers.** Use Immich's worker configuration to limit concurrent thumbnail generation and metadata extraction. Two workers is a safe default for the N100.

5. **Stagger thin client and NAS jobs.** If the thin client's Loki compaction, the NAS SnapRAID sync, and a backup all run at 02:00, the NFS link between them will contend. Offset each by 30-60 minutes.

6. **Never overlap SnapRAID sync with Paperless/Immich imports.** SnapRAID sync reads the full data set; concurrent writes during sync produce false mismatches that require re-syncing. Use a pre-sync check: if Paperless or Immich are actively importing (check queue length), delay SnapRAID sync by 30 minutes.

7. **Use systemd timers over cron where possible.** Timers support `OnBootSec`, randomized delay (`RandomizedDelaySec`), and dependency ordering, which prevents job pile-ups after a reboot.

### Example NAS Nightly Window

```
01:00  Backup (rsync to external, ionice -c3, nice -n 19)
02:00  SnapRAID sync (ionice -c3; skipped if active imports detected)
03:00  SnapRAID scrub (weekly only, -p 5)
04:00  ZFS scrub AI pool (monthly only)
04:30  docker system prune
05:00  PostgreSQL VACUUM ANALYZE (weekly only)
05:30  All jobs complete, HDDs spin down after 10 min idle
```

### Example Thin Client Nightly Window

```
03:00  Loki compaction
04:00  docker system prune (weekly)
06:00  unattended-upgrades (daily, system default)
```

No overlap with NAS backup or SnapRAID, and Loki compaction runs before prune so compacted data is cleaned up in the same maintenance window.

---

## Role Split Summary

| Concern | Thin client (Wyse 5070) | NAS (N100 build) | AI server (3090) |
|---|---|---|---|
| Reverse proxy + TLS | Caddy | - | - |
| DNS | AdGuard Home | - | - |
| Auth | oauth2-proxy + Pocket ID | - | - |
| Git hosting | Gitea | - | - |
| CI (light) | act-runner (basic builds) | - | - |
| CI (heavy/AI) | - | - | act-runner (tagged jobs) |
| Photo library | - | Immich (app + DB) | Immich ML |
| Documents | - | Paperless-ngx (app + DB) | - |
| Notes / Budget / Mail | Memos, Actual Budget, MailHog | - | - |
| Static sites | Blog, CV, Wiki, Static site | - | - |
| LLM inference | - | - | Ollama, CV-AI |
| Monitoring | Netdata, Uptime Kuma, Loki | Promtail | Netdata |
| Storage (bulk) | - | HDD pools, NFS/SMB exports | - |
| Storage (local) | 1TB SSD (Git, Docker, logs) | Boot SSD + HDDs | NVMe (models, OS) |

**Failure modes:**
- Thin client down: nothing reachable from outside. All services offline.
- NAS down: photos and documents unavailable. Gateway still serves 502s. Git, notes, budget, auth all remain functional on the thin client.
- AI server down: CV-AI offline, Immich smart search pauses, heavy CI jobs fail. All other services unaffected.

---

## Measurement-First Upgrade Plan

Deploy the balanced split and collect 1-2 weeks of real usage before buying anything.

### What to Measure

- `docker stats` during normal daily use on both machines
- `free -h` and `vmstat 1` during Paperless OCR imports and Immich photo indexing
- Netdata: memory pressure, swap activity, disk I/O wait, load average
- Postgres memory usage on the NAS (shared_buffers, effective_cache_size vs actual RSS)
- Gitea and thin-client responsiveness while a typical CI deploy runs
- Caddy/DNS latency during peak thin-client memory usage

### Upgrade Triggers

| Machine | Trigger | Action |
|---|---|---|
| Thin client | Swap used repeatedly, or Caddy/DNS latency increases during bursts | Buy 2x8GB SODIMM (~€25-30), restore to 16GB |
| Thin client | CI jobs cause responsiveness issues | Move act-runner to AI server exclusively |
| NAS | Swap activity during Immich indexing or Paperless OCR, or ZFS ARC hit ratio drops below 80% | Upgrade to 2x16GB SODIMM (32GB) |
| NAS | N100 CPU saturated during concurrent OCR + thumbnail generation | Reduce worker concurrency further; accept slower background processing |

Do not pre-buy RAM on speculation. The swap-now baseline (8GB thin client, 16GB NAS) is the starting point; upgrades are justified only by observed data.

---

## Phasing

1. **AI server first** — GPU thermal mod and remaining parts are already committed. This unblocks CV-AI and Immich ML offload.
2. **NAS build second** — when a good deal on an N100 board appears. Move HDDs from USB dock to native SATA.
3. **Migrate Immich and Paperless to the NAS** — set up storage tiering (DBs on SSD, originals on HDDs), configure NFS exports.
4. **Reconfigure the Wyse as thin client** — swap RAM (16GB out, 8GB in), remove Immich/Paperless containers, keep gateway + light apps + Gitea.
5. **Add AI-server act-runner** — only when workflows justify it. Tag heavy/AI jobs to route there.
6. **Burn-in monitoring** — collect 1-2 weeks of data, check upgrade triggers, buy RAM only if needed.
