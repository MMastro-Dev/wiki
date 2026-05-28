# Parts Shopping List

**Goal:** Track and complete all pending hardware purchases across all machines.
**Created:** 2026-05-28
**Status:** in-progress

> Source of truth: [notes/shopping-list.md](../shopping-list.md). Update status there when items arrive.

---

## AI Server

Priority: these unlock Phase 1 assembly (H1.1 is blocked until the Tower 300 is purchased).

- [ ] **A1** Thermaltake Tower 300 (mATX) — €90-110
- [ ] **A2** Arctic P14 PWM 5-pack (4 used: 2× bottom intake, 2× top exhaust) — €30-35
- [ ] **A3** Arctic P12 Slim PWM (backplate fan) — €8-10
- [ ] **A4** Phanteks Universal Fan Bracket (backplate mount) — €8-12

**Subtotal:** €136-167

---

## NAS

All items required before NAS build can begin. PSU and NVMe have options — see notes.

- [ ] **N1** Mini-ITX N100/N305 board (10GbE onboard, 6+ SATA, 2× M.2) — €150-250. Must have 24-pin ATX (picoPSU compatible). Marvell AQC113 RJ45 or SFP+ for 10GbE. Search: CWWK, Topton, Kingnovy on AliExpress.
- [ ] **N2** Jonsbo N3 case (8-bay 3.5", aluminium, ITX) — €90-120
- [ ] **N3** PSU — recommended: picoPSU-160-XT + 150W AC adapter (~€40-55 total). If expanding to 8 drives later, use 200W adapter. SFX alternative: Corsair SF450 Platinum (~€90-110, SFX ≤105mm only — SFX-L does NOT fit).
- [ ] **N4** Boot NVMe (M.2 slot 1, PCIe x4) — 1TB (~€100) or 2TB (~€200)
- [ ] **N5a** ZFS cache NVMe (M.2 slot 2, PCIe x1/x2) — ~500GB, ~€40-60. Acts as SLOG (sync write cache) — dramatically improves Immich uploads and Paperless ingestion.
- [ ] **N5b** Noctua NF-A10x25 PWM 100mm — ×2 (HDD airflow) — €32-36

**Subtotal:** €352-596

---

## Main PC

One decision pending before purchasing. See notes.

- [ ] **PC1** Decide: replace Core P3 case or keep it
  - **Keep Core P3** → buy PCIe riser cable (vertical GPU mount, €30-50)
  - **Replace case** → choose from shortlist in shopping-list.md (€90-160); riser cable not needed

- [ ] **PC2** Purchase the item selected in PC1

**Subtotal (keep case):** €30-50  
**Subtotal (replace case):** €90-160

---

## Notes

- GPU thermal mod is complete (€150 spent 2026-05-28, video output confirmed, stress test passed).
- All other AI server parts already acquired; only the case and fans remain.
- NAS build depends on Phase 1 (AI server) being live first — see [homelab-phase-2-nas-build.md](homelab-phase-2-nas-build.md).
- Thin client (Wyse 5070) requires no new purchases.
- 16GB DDR4 SODIMM currently in the Wyse 5070 will move to the NAS once the NAS is built — do not buy separate NAS RAM.
- 10GbE networking purchases are independent (can buy anytime). Cabling waits until ALL materials are on-hand — "open walls once."

---

## 10GbE Networking

Priority: after NAS build. Purchases can begin independently. Do NOT start cabling until all items arrive ("open walls once" rule).

- [ ] **NET1** MikroTik CRS305-1G-4S+IN (fanless, 8W, 4× SFP+ + 1× 1GbE) — ~€140
- [ ] **NET2** SFP+ 10GBASE-T transceiver modules × 3 (MikroTik S+RJ10 or compatible) — ~€90 (€30 each)
- [ ] **NET3** Intel X540-T1 10GbE RJ45 NIC (AI server, PCIe x4) — ~€30-50 used
- [ ] **NET4** Intel X540-T1 10GbE RJ45 NIC (Desktop PC, PCIe x4) — ~€30-50 used
- [ ] **NET5** Cat6A S/FTP solid copper cable, 100m reel — ~€80-110
- [ ] **NET6** Cat6A shielded keystone jacks × 12 — ~€36-60
- [ ] **NET7** 2-port wall plates × 5 + 12-port patch panel — ~€45-65
- [ ] **NET8** Cat6A patch cables (0.5m + 1m) × 10 — ~€40-50
- [ ] **NET9** Cable conduit / trunking ~30m — ~€30-60
- [ ] **NET10** Tools: RJ45 crimper + punchdown tool + cable tester — ~€30-50

**Subtotal (networking):** €550-765
