# NAS Build and Service Migration

**Goal:** Build the NAS (N100 mini-ITX) and migrate all application services from the Wyse 5070.
**Created:** 2026-05-27
**Status:** not-started

> Depends on Phase 1 (AI server) being live.

---

## Steps

### Hardware Assembly

- [ ] **N2.1** Acquire mini-ITX N100/N305 board (10GbE onboard, 6+ SATA, 2× M.2), 8-bay case (Jonsbo N3), and PSU (picoPSU-160-XT + 150W AC adapter).
- [ ] **N2.2** Install DDR4 SODIMMs (16GB from Wyse 5070 after RAM swap).
- [ ] **N2.3** Install boot NVMe (1–2TB depending on deal).
- [ ] **N2.4** Mount WD Red HDDs (3× 4TB) in case SATA bays.
- [ ] **N2.5** Boot test: BIOS, confirm RAM/NVMe/HDDs detected.

### OS and Storage

- [ ] **N2.6** Install Debian 12 Bookworm to boot NVMe.
- [ ] **N2.7** Set static IP, hostname, non-root admin user, disable root SSH.
- [ ] **N2.8** Install Docker + Docker Compose.
- [ ] **N2.9** Mount each HDD individually: `/mnt/hdd1`, `/mnt/hdd2`, `/mnt/hdd3`.
- [ ] **N2.10** Install mergerfs. Create pool: `/mnt/pool`. Add to `/etc/fstab`.
- [ ] **N2.11** Set up storage tiering:
  - Boot NVMe: PostgreSQL DBs, Immich thumbnails, Docker volumes
  - HDD pool: Immich originals, Paperless media, Loki logs, backups
- [ ] **N2.12** Set up NFS export for Loki log storage (thin client writes here).

### Service Migration (from Wyse 5070)

- [ ] **M2.1** On Wyse: export all application service configs (`docker compose config`).
- [ ] **M2.2** Transfer data: `rsync -avP` all persistent volumes from Wyse to NAS.
- [ ] **M2.3** Deploy on NAS in order: Gitea → Immich → Paperless → Actual Budget → Memos → Hugo Blog → CV → CV Forms → MailHog → Wiki → Static Site.
- [ ] **M2.4** Verify each service is functional on NAS.
- [ ] **M2.5** Update Wyse Caddyfile: all `reverse_proxy` upstreams → NAS IP.
- [ ] **M2.6** Test all services end-to-end through Caddy.
- [ ] **M2.7** Remove application containers from Wyse. It now runs gateway services only.

---

## Notes

- Items to buy: N100/N305 10GbE board (~€150-250), Jonsbo N3 (~€90-120), picoPSU-160-XT + adapter (~€40-55), boot NVMe (~€100-200).
- NAS board must have 10GbE onboard (Marvell AQC113 or SFP+) for the Phase 7 networking upgrade. The 2.5GbE port (i226-V) serves as management/fallback during interim before 10GbE cabling is complete.
- Phase 3 (thin client conversion) follows immediately after M2.7 is complete.
- Phase 7 (10GbE networking) follows after NAS is operational — NAS uses 2.5GbE in the interim.
- See [notes/thin-client-and-nas.md](../thin-client-and-nas.md) for architecture rationale and measurement plan.
- See [notes/deployment-checklist.md](../deployment-checklist.md) for the purchases ledger.
