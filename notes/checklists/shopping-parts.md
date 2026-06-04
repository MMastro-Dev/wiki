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

- [ ] **N1** CWWK i5-8265UES 8-Bay NAS board (~$155 / €145 DDP from cwwk.net). Intel i5-8265U, 8× native SATA, 2× M.2 PCIe x4, 2× DDR4 SODIMM, 24-pin ATX, 2.5GbE onboard.
- [ ] **N1b** Mellanox ConnectX-3 MCX311A-XCAT SFP+ NIC (~€20 used, eBay). `mlx4` mainline Linux driver. For 10GbE SFP+ connection to CRS305 in Phase 7.
- [ ] **N2** Jonsbo N3 case (8-bay 3.5", aluminium, ITX) — €90-120
- [ ] **N3** PSU — recommended: picoPSU-160-XT + 150W AC adapter (~€40-55 total). If expanding to 8 drives later, use 200W adapter. SFX alternative: Corsair SF450 Platinum (~€90-110, SFX ≤105mm only — SFX-L does NOT fit).
- [ ] **N4** Boot NVMe (M.2 slot 1, PCIe x4) — 1TB (~€100) or 2TB (~€200)
- [ ] **N5a** ZFS cache NVMe (M.2 slot 2, PCIe x1/x2) — ~500GB, ~€40-60. Acts as SLOG (sync write cache) — dramatically improves Immich uploads and Paperless ingestion.
- [ ] **N5b** Noctua NF-A10x25 PWM 100mm — ×2 (HDD airflow) — €32-36

**Subtotal:** €457-636

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

- NAS board decided: CWWK i5-8265UES 8-Bay (~€145). 8 native SATA + 2× M.2 PCIe x4, DDR4 SODIMM. Reuses 16GB DDR4 from Wyse at zero cost.
- NAS NIC: Mellanox ConnectX-3 SFP+ (~€20 used) for 10GbE fiber connection to CRS305 in Phase 7.
- All other AI server parts already acquired; only the case and fans remain.
- NAS build depends on Phase 1 (AI server) being live first — see [homelab-phase-2-nas-build.md](homelab-phase-2-nas-build.md).
- Thin client (Wyse 5070) requires no new purchases.
- 16GB DDR4 SODIMM currently in the Wyse 5070 will move to the NAS once the NAS is built — do not buy separate NAS RAM.
- 10GbE networking uses OM4 fiber + SFP+ direct (no Cat6A, no 10GBASE-T transceivers). Measure wall runs before ordering fiber. "Open walls once" rule applies.

---

## 10GbE Networking

Priority: after NAS build. Purchases can begin independently. Do NOT start cabling until all items arrive ("open walls once" rule).

- [ ] **NET1** MikroTik CRS305-1G-4S+IN (fanless, 8W, 4× SFP+ + 1× 1GbE) — ~€140
- [ ] **NET2** Mellanox ConnectX-3 MCX311A-XCAT SFP+ NIC × 2 (AI server + Desktop, used eBay) — ~€40 (€20 each)
- [ ] **NET3** 10G-SR OM4 SFP+ transceiver × 4 (NIC ends: 2× AI server + Desktop, 1× NAS if wall run, used eBay) — ~€32 (€8 each)
- [ ] **NET4** DAC 1m SFP+ twinax cable (NAS ↔ CRS305 if co-located) — ~€10
- [ ] **NET5** Pre-terminated OM4 LC-LC duplex fiber, 4-6 runs — **measure wall runs first**, then order from FS.com to exact length + 1-2m slack (~€15/run = ~€60-90)
- [ ] **NET6** LC duplex fiber keystone adapters × 12 — ~€36 (€3 each)
- [ ] **NET7** Wall plates (2-port) × 5 + 12-port fiber patch panel — ~€60-80
- [ ] **NET8** LC-LC duplex patch cables (0.5m) × 6 (switch-side panel connections) — ~€20
- [ ] **NET9** Cable conduit / trunking ~30m — ~€30-60
- [ ] **NET10** Cat6 patch cable × 1 short (Fritz!Box → switch 1GbE) — ~€3

**Subtotal (networking):** €431-521

> No crimping tools, no Cat6A reel, no 10GBASE-T transceivers — fiber plugs directly into SFP+ ports. NET5 must be last purchase after measuring runs.
