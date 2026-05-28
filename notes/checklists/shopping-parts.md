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

- [ ] **N1** Mini-ITX N100 board (4+ SATA ports, M.2 slot) — €80-130
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
