# Deployment Checklist

See [infrastructure.md](infrastructure.md) for architecture context, [thin-client-and-nas.md](thin-client-and-nas.md) and [ai-server.md](ai-server.md) for detailed rationale.

---

## Purchases Ledger

| Item | Amount | Status |
|---|---|---|
| RTX 3090 24GB (no cooler) | -€765 | ✅ Acquired |
| 4GB DDR4 SODIMM PC4-2666V | -€10 | ✅ Acquired |
| 2x 8GB DDR3 SODIMM (sold) | +€20 | ✅ Done |
| Corsair VS550 PSU (sold) | +€20 | ✅ Done |
| GPU thermal mod (heatsink, thermal pads, thermal paste) | -€150 | ✅ Done |
| AI server PSU (Corsair HX1000i 1000W, used) | -€110 | ✅ Acquired |
| NAS mini-ITX board (N100/N305, 10GbE) | -€150-250 | ⬜ Pending |
| NAS case (Jonsbo N3) | -€90-120 | ⬜ Pending |
| NAS PSU (picoPSU-160-XT + 150W adapter) | -€40-55 | ⬜ Pending |
| NAS boot NVMe (1-2TB) | -€100-200 | ⬜ Pending |
| 32GB DDR4 3200MHz 2x16GB DIMM | -€150 | ⬜ Pending |
| 512GB NVMe Gen3 M.2 | -€40-45 | ⬜ Pending |
| AI server case (Thermaltake Tower 300) | -€90-110 | ⬜ Pending |
| Main PC PSU (be quiet! Straight Power 12 750W) | -€130 | ⬜ Pending |
| Main PC PCIe riser cable | -€30-50 | ⬜ Pending |
| MikroTik CRS305-1G-4S+IN switch | -€140 | ⬜ Pending |
| SFP+ 10GBASE-T transceivers × 3 | -€90 | ⬜ Pending |
| Intel X540-T1 10GbE NIC (AI server) | -€30-50 | ⬜ Pending |
| Intel X540-T1 10GbE NIC (Desktop) | -€30-50 | ⬜ Pending |
| Cat6A cabling materials (100m + keystones + panel + plates) | -€160-235 | ⬜ Pending |
| Cable conduit + trunking | -€30-60 | ⬜ Pending |
| Networking tools (crimper + tester) | -€30-50 | ⬜ Pending |

---

## Phases

Step-by-step checklists are in `notes/checklists/`. This file tracks the purchases ledger only.

| — | Shopping: Parts To Buy | [shopping-parts.md](checklists/shopping-parts.md) | in-progress |

| Phase | Checklist | Status |
|---|---|---|
| 1 — AI Server Build | [homelab-phase-1-ai-server.md](checklists/homelab-phase-1-ai-server.md) | in-progress |
| 2 — NAS Build + Service Migration | [homelab-phase-2-nas-build.md](checklists/homelab-phase-2-nas-build.md) | not-started |
| 3 — Wyse 5070 Thin Client Conversion | [homelab-phase-3-thin-client.md](checklists/homelab-phase-3-thin-client.md) | not-started |
| 4 — Optimisation and Hardening | [homelab-phase-4-hardening.md](checklists/homelab-phase-4-hardening.md) | not-started |
| 5 — CV-AI Fine-Tuning *(optional)* | [homelab-phase-5-cv-ai-tuning.md](checklists/homelab-phase-5-cv-ai-tuning.md) | not-started |
| 6 — NAS Storage Expansion *(optional)* | [homelab-phase-6-nas-expansion.md](checklists/homelab-phase-6-nas-expansion.md) | not-started |
| 7 — 10GbE LAN Networking | [homelab-phase-7-10gbe-networking.md](checklists/homelab-phase-7-10gbe-networking.md) | not-started |
