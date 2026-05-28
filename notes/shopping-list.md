# Hardware Shopping List

Full bill of materials across all four machines. "Projected value" is approximate resale/replacement value for owned components.

**Charts:** [Cost & power breakdown](charts/project-costs.md)

---

## Main PC (Gaming / Desktop)

| Component | Status | Cost to Buy | Projected Value |
|---|---|---:|---:|
| AMD Ryzen 7 7800X3D | Owned | - | ~€350 |
| Gigabyte B650 AORUS ELITE AX (ATX) | Owned | - | ~€200 |
| NZXT Kraken 360 AIO | Owned | - | ~€150 |
| AMD RX 6800 XT | Owned | - | ~€300 |
| 2TB NVMe M.2 SSD | Owned | - | ~€120 |
| DDR5 RAM (assumed, B650 board) | Owned | - | ~€80-120 |
| Thermaltake Core P3 TG (glass removed) | Owned | - | ~€70 |
| Corsair HX850i 850W 80+ Platinum (used, 4yr) | ✅ Acquired | €60 | ~€80 |
| PCIe riser cable (vertical GPU mount) | **To buy** | €30-50 | - |
| **Subtotal (to buy)** | | **€30-50** | |
| **Total system value** | | | **~€1,430-1,470** |

CX600 replaced by Corsair HX850i (€60, used). HX850i is Platinum, fully modular, semi-passive, iCUE monitoring — better spec than the planned SP12 at less cost. CX600 goes to resale (~€25-30) or NAS evaluation — see NAS section. Saved €70 vs original plan.

### Case Assessment: Thermaltake Core P3 TG

**Hard constraints (any replacement must meet):**
- ATX motherboard (Gigabyte B650 AORUS ELITE AX, 305 × 244mm)
- GPU clearance: ≥ 340mm (XFX RX 6800 XT Merc 319 = ~340 × 135 × 53mm, 2.9 slots)
- PSU: Corsair HX850i 850W — ATX, 160mm deep (no constraint problem)
- Radiator: 360mm (NZXT Kraken 360)

**Core P3 vs your preferences:**

| Preference | Core P3 | Verdict |
|---|---|---|
| Small footprint | 470 × 233mm on desk (or wall-mount) | OK if wall-mounted, large if on desk |
| Vertical / cube | Flat open frame | ❌ No |
| Quiet | Completely open — zero noise isolation | ❌ No |
| Colored / unique materials | Black steel frame only | ❌ No |
| Modular | Panels removable (but already removed) | Partially |
| Dust protection | None (glass removed) | ❌ No |
| Directed airflow | None — open air relies on ambient | ❌ No |

**Conclusion:** the Core P3 is a showcase/test-bench case that conflicts with every stated preference except "unlimited clearance." Resale value ~€70. A replacement case (€90-160) gains dust protection, noise isolation, directed airflow, better aesthetics, and a smaller desk footprint. The riser cable purchase (€30-50) also becomes unnecessary — many cases below include vertical GPU mount or make it trivial.

**Vapor chamber note:** the XFX Merc 319 uses heatpipes (not vapor chamber). Vertical mounting has zero meaningful thermal penalty on this card, and gaming loads are bursty — orientation effects measured at <1°C vs sustained inference workloads.

---

#### Best replacement cases (ATX + 360mm rad + ≥340mm GPU)

| # | Case | Volume | Footprint (W×D) | 360mm Rad | Shape | Colors / Materials | Price (EU) |
|---|---|---|---|---|---|---|---|
| 1 | **Thermaltake Tower 500** | ~50.5L | 290 × 290mm | Top + side | Chimney vertical (ATX Tower 300) | Black, Snow | €130-160 |
| 2 | **Fractal Design North** | ~44.6L | 215 × 440mm | Top (360mm) | Compact tower | Charcoal + Walnut, White + Walnut (real wood panel) | €110-140 |
| 3 | **HYTE Y60** | ~60L | 285 × 456mm | Rear chamber | Dual-chamber panoramic | Black, White, Red | €150-180 |
| 4 | **Fractal Design Torrent Compact** | ~49L | 222 × 450mm | Bottom (360mm) | Open-top tower | Black, White (hex mesh) | €130-150 |
| 5 | **Lian Li O11D EVO** | ~60.8L | 285 × 465mm | Top/Side/Bottom | Dual-chamber (vertical GPU optional) | Black, White, Gray | €140-170 |

**Notes:**
- **Tower 500**: same chimney DNA as the AI server's Tower 300 — matching pair. Smallest desk footprint (290×290mm = less than the Core P3). GPU vertical by default. 360mm rad on top or side. Down side: tall (600mm), only Black and Snow.
- **Fractal Design North**: real walnut wood veneer front panel — genuinely unique material. Narrowest case (215mm). Very quiet (mesh + dampened panels). Top-mount 360mm rad. Traditional tower orientation but the wood makes it a furniture piece, not a "PC case." Best if you want it to blend into a room.
- **HYTE Y60**: comes in RED. Panoramic glass wrap shows everything. Vertical GPU mount is native (included riser on some models). Modern, aggressive aesthetic. Dual-chamber isolates PSU noise. Large volume though.
- **Fractal Torrent Compact**: top-tier airflow (open top + massive bottom fans). GPU clearance is generous (355mm+). Hex-mesh panels look distinctive. Not vertical/cube but excellent thermals + noise balance.
- **Lian Li O11D EVO**: the most flexible option — supports every possible layout (normal, inverted, vertical GPU with riser). 360mm rad in 3 positions. Premium aluminum+glass build. Large though.

#### Recommendation

**If consistency with the AI server matters:** Tower 500. Matching chimney pair (Tower 300 + 500), same visual language, smallest desk footprint of the bunch.

**If unique materials matter most:** Fractal North. The walnut panel is a genuine differentiator — no other case looks like this. Also the quietest option.

**If color matters most:** HYTE Y60 in Red. Nothing else on the market offers that.

**If you want to keep the Core P3:** wall-mount it (saves all desk space, eliminates footprint argument). But you still lose noise isolation and dust protection. The €30-50 riser cable buy becomes justified only if you keep the case.

---

## AI Server

| Component | Status | Cost to Buy | Projected Value |
|---|---|---:|---:|
| Ryzen 5 3600X | Owned | - | ~€80 |
| MSI B450M-A PRO MAX (mATX) | Owned | - | ~€50 |
| RTX 3090 24GB (Zotac Trinity, stock cooler) | Acquired | €765 | ~€765 |
| GPU thermal mod (heatsink, thermal pads, thermal paste) | ✅ Done | €150 | ~€150 |
| Corsair HX1000i 1000W (used, 80+ Platinum) | Acquired | €110 | ~€110 |
| 32GB DDR4 3200MHz S3+ DragonHeart XMP (2x16GB DIMM) | ✅ Acquired | €130 | ~€130 |
| Samsung PM981 500GB NVMe Gen3 | ✅ Acquired | €43 | ~€43 |
| Thermaltake Tower 300 (mATX) | **To buy** | €90-110 | ~€100 |
| Arctic P14 PWM 5-pack (use 4: 2 bottom intake, 2 top exhaust) | **To buy** | €30-35 | - |
| Arctic P12 Slim PWM (backplate fan) | **To buy** | €8-10 | - |
| Phanteks Universal Fan Bracket (backplate mount) | **To buy** | €8-12 | - |
| **Subtotal (to buy)** | | **€136-167** | |
| **Already spent** | | **€1,198** | |
| **Total build cost** | | **€1,334-1,365** | |
| **Total system value** | | | **~€1,415** |


---

## NAS (Storage + Immich + Paperless)

| Component | Status | Cost to Buy | Projected Value |
|---|---|---:|---:|
| Mini-ITX N100/N305 board (10GbE, 6+ SATA, 2× M.2) | **To buy** | €150-250 | ~€150 |
| Jonsbo N3 (8-bay 3.5", aluminum, ITX) | **To buy** | €90-120 | ~€100 |
| PSU — see analysis below | **To buy** | €30-80 | - |
| 16GB DDR4 SODIMM (2x8GB, from Wyse) | Owned (swapped) | - | ~€40 |
| Boot NVMe (M.2 slot 1, PCIe x4): 1TB (€100) or 2TB (€200) | **To buy** | €100-200 | ~€100-200 |
| ZFS cache NVMe (M.2 slot 2, PCIe x1/x2): ~500GB | **To buy** | €40-60 | ~€40-60 |
| Noctua NF-A10x25 PWM (100mm, HDD airflow) | **To buy** | €32-36 (2×) | - |
| 3x WD Red 4TB HDD | Owned | - | ~€240 (€80 each) |
| 2x WD Black 2TB HDD (AI workspace pool) | Owned | - | ~€100 (€50 each) |
| **Subtotal (to buy)** | | **€352-596** | |
| **Total system value** | | | **~€990-1,116** |

### NAS Storage Layout

The N100 board has **2× M.2 slots + 6× native SATA**. Two options for the N3's 8 HDD bays:

**Option A — 2× NVMe + 6× SATA (recommended)**
- M.2 slot 1 (PCIe 3.0 x4): boot NVMe (1–2TB)
- M.2 slot 2 (PCIe 3.0 x1 or x2): ZFS SLOG/L2ARC NVMe (~500GB)
- 6× SATA: 3× WD Red 4TB + 2× WD Black 2TB (5 drives, 1 spare bay)
- ZFS SLOG makes Immich uploads and Paperless ingestion near-instant (sync write latency goes from ~10ms HDD to ~0.1ms NVMe)

**Option B — 1× NVMe + M.2→SATA adapter + 8× SATA**
- M.2 slot 1 (PCIe 3.0 x4): boot NVMe only
- M.2 slot 2: ASM1166 PCIe→SATA adapter card (adds 2–6 more SATA)
- All 8 N3 bays populated

**Why Option B has a lane problem:**

The Intel N100 has **9× PCIe 3.0 lanes** total. Typical N100 NAS board allocation:

| Interface | Lanes | Bandwidth |
|---|---|---|
| M.2 slot 1 (NVMe) | PCIe 3.0 x4 | ~3.5 GB/s |
| 2.5GbE NIC | PCIe 3.0 x1 | ~1 GB/s |
| Native SATA bridge (ASM1166) | PCIe 3.0 x1 | ~900 MB/s |
| M.2 slot 2 | PCIe 3.0 x1–x2 | ~900 MB/s–1.8 GB/s |

On most budget N100 boards, **M.2 slot 2 shares the same PCIe x1 lane as the native SATA bridge** (board designers run them off a PCIe switch or share the lane). Adding an M.2→SATA adapter (another PCIe x1 device) on that shared lane means both SATA chips compete for ~900 MB/s total. With 8 HDDs theoretically capable of ~1.4 GB/s aggregate sequential, you'd cap at ~900 MB/s and cause contention during ZFS resilvering. For home NAS workloads (rarely >200 MB/s actual) this rarely shows, but it's architectural debt.

**Verdict: Option A.** More NVMe = better ZFS performance. 5 drives of owned storage is already substantial (20TB raw, ~13TB usable in RAIDZ1). Spare bay available for future expansion.

---

### NAS Power Draw (Corrected)

Planned config: 5 HDDs, 2 NVMe, 2× 100mm fans.

| Component | Sustained | Idle (spinning) |
|---|---:|---:|
| Intel N100 | ~10W | ~5W |
| 3× WD Red 4TB (5.4W active / 0.4W idle each) | ~16W | ~1W |
| 2× WD Black 2TB (6.8W active / 0.7W idle each) | ~14W | ~1.5W |
| Boot NVMe M.2 | ~4W | ~1W |
| ZFS cache NVMe M.2 | ~3W | ~0.5W |
| 2× Noctua NF-A10x25 fans | ~2W | ~2W |
| Board VRMs, RAM, I/O | ~3W | ~2W |
| **Total** | **~52W** | **~13W** |

**Spin-up peak (OS stagger-spin, max 2 drives simultaneously):**
Each 3.5" HDD draws ~2A @ 12V (~24W) briefly at spin-up. With staggered spin-up: 2 drives peak + rest at sustained = 48W + 20W = **~68–75W peak**, then settles to ~52W sustained.

Full 8-drive hypothetical: ~70W sustained, ~100W staggered spin-up peak.

---

### NAS PSU Analysis

**PSU sizing target:** handle 75W spin-up, 52W sustained. Efficiency peaks at 50% load, so ideal rated wattage is ~100–160W. No SFX PSU ships under 300W — all SFX options run at 10–16% load on this NAS.

⚠️ **N3 PSU constraint: SFX ≤105mm depth only.** SFX-L (125mm) does NOT fit. No adapter exists that makes SFX-L fit a ≤105mm bay.

**SFX options (fit N3 natively):**

| Option | Wattage | Rating | Eff. at 52W | Eff. at 75W | Price |
|---|---|---|---|---|---|
| **Corsair SF450 Platinum** | 450W | 80+ Platinum | ~83% (11% load) | ~85% (16% load) | €90-110 |
| **Montech Century Mini** | 550W | 80+ Gold | ~80% (9% load) | ~82% (13% load) | €70-85 |
| **Silverstone SX500-G** | 500W | 80+ Gold | ~80% (10% load) | ~82% (14% load) | €65-85 |

None hit their efficiency sweet spot. Platinum helps at the margin, but the load ratio is the primary limiter.

---

#### picoPSU-160-XT + AC adapter — full analysis

A DC-DC module that plugs directly into the 24-pin ATX header. The board provides 12V DC; the module converts to all ATX rails on-board. No AC conversion stage.

**Electrical specs:**

| Rail | Max continuous | Max peak |
|---|---|---|
| Total output | 160W | — |
| 12V | 120W (10A) | — |
| 5V | 40W (8A) | — |
| 3.3V | 20W (6A) | — |

**Efficiency:** DC-DC conversion at 40–80W output = ~87–91%. Peaks exactly at typical NAS operating range — the opposite of SFX PSUs which are most efficient at 5–10× this load.

**AC adapter sizing:**

| Drive count | Sustained | Spin-up peak | Adapter needed |
|---|---|---|---|
| 5 drives (planned) | 52W | ~75W | **150W adapter** — safe with margin |
| 8 drives (full N3) | ~70W | ~100W | **200W adapter** — 150W too marginal for spin-up |

Use a 12V DC barrel adapter (not 19V laptop style — wrong voltage). The module and a 150W adapter are typically sold together or separately for ~€40–55 total.

**SATA power connectors:**
picoPSU-160-XT ships with 3–4× SATA power connectors, 2× Molex, 4-pin CPU EPS.
- 5 HDDs need 5× SATA power — add one passive Y-splitter cable (~€3–5). No power load concern, these are just wire splits.
- NVMe drives are powered via M.2 slot on the board (no SATA connector needed).

**Pros:**
- ✅ **Best efficiency at actual NAS load** (~89% at 52W vs ~83% for SF450 Platinum)
- ✅ **Fanless** — PSU contributes zero noise. N3's two Noctua fans cover all HDD airflow.
- ✅ **No depth constraint** — fits any NAS case layout regardless of PSU bay size
- ✅ **Cheapest** option at ~€40–55 total
- ✅ **Simpler cabling** — module sits on the mainboard header; no PSU bay, no ATX cable run

**Cons / risks:**
- ⚠️ **AC adapter is a single point of failure.** Replaceable generics cost ~€15–20. Keep a spare or note the barrel spec (typically 5.5mm OD / 2.5mm ID, 12V).
- ⚠️ **Weaker short-circuit protection** than a full PSU. Drive controller faults could cascade before protections trigger. Low probability, but relevant for 24/7 NAS duty.
- ⚠️ **150W ceiling is real** — if you ever populate all 8 N3 bays, swap to a 200W adapter before expanding.

**Verdict: picoPSU + 150W adapter is the best choice for the planned 5-drive build.** Cheapest, most efficient at real load, fanless, no case constraints. Only consider the SF450 if you want a conventional PSU with stronger protection guarantees and plan to eventually go to 8 drives.

---

## Thin Client (Wyse 5070 — Gateway + Light Apps)

| Component | Status | Cost to Buy | Projected Value |
|---|---|---:|---:|
| Dell Wyse 5070 (Celeron J4105, 4C/4T) | Owned | - | ~€80 |
| 8GB DDR4 SODIMM (2x4GB spare kit) | Owned | - | ~€15 |
| 1TB M.2 SATA SSD | Owned | - | ~€60 |
| **Subtotal (to buy)** | | **€0** | |
| **Total system value** | | | **~€155** |

---

## 10GbE Networking Upgrade

Centralized LAN upgrade: Cat6A structured cabling in walls, 10GbE switch, NIC upgrades. NAS becomes centralized workspace storage accessible at ~1 GB/s locally and remotely via Fritz!Box WireGuard VPN.

**Charts:** [Network topology](charts/network-topology.md) · [Cost breakdown](charts/networking-costs-pie.md) · [Timeline](charts/homelab-gantt.md)

**Priority:** After NAS build (Phase 2). Cabling is labour-intensive and independent — NAS works on 2.5GbE (i226-V) in the interim.

### Design Decisions

- **Switch:** MikroTik CRS305-1G-4S+IN (fanless, 8W, managed) — silence and low power over convenience
- **Transceivers:** 3× SFP+ to 10GBASE-T modules at switch end (one per Cat6A wall run)
- **Cabling:** Cat6A S/FTP in wall channels to RJ45 keystone wall plates. Double runs per location ("open walls once")
- **NAS board:** must have 10GbE onboard (Marvell AQC113 RJ45 or SFP+ direct)
- **Fritz!Box stays as gateway:** layer-2 switch handles LAN-to-LAN; Fritz!Box remains firewall + WireGuard VPN terminator
- **Wyse excluded:** thin variant (no PCIe slot), tasks don't need >1GbE

### Topology

```
Internet → Fritz!Box (gateway/firewall/WireGuard) → 2.5GbE → MikroTik CRS305
                                                                 ├─ SFP+ port 1 → NAS (10GbE)
                                                                 ├─ SFP+ port 2 → AI Server (10GbE)
                                                                 ├─ SFP+ port 3 → Desktop PC (10GbE)
                                                                 └─ SFP+ port 4 → spare
Fritz!Box 1GbE → Wyse 5070 (Caddy/AdGuard) + Fritz!Mesh (WiFi)
```

### NAS Board — Updated Requirements (10GbE)

The NAS board requirement changes from 2.5GbE (€80-130) to 10GbE onboard (€150-250):

| Spec | Requirement |
|---|---|
| Form factor | Mini-ITX (170×170mm) — fits Jonsbo N3 |
| 10GbE | 1× RJ45 (Marvell AQC113) or SFP+ |
| 2.5GbE | 1× (Intel i226-V) — management / fallback |
| SATA | 6 minimum, 8 ideal |
| M.2 | 2× NVMe (Key M, PCIe) |
| RAM | 2× DDR4 SODIMM |
| Power | 24-pin ATX (picoPSU compatible) — NOT 19V DC barrel |
| CPU | Intel N100 or N305 |

**PCIe lane budget (9 lanes, AQC113 on x1):**

| Device | Lanes | Effective bandwidth |
|---|---|---|
| M.2 slot 1 — boot NVMe | x4 | 3.5 GB/s |
| 10GbE NIC (AQC113) | x1 | 985 MB/s (≈7.9 Gbps) |
| ASM1166 SATA 6-port | x2 | 1.97 GB/s |
| M.2 slot 2 — ZFS SLOG | x1 | 985 MB/s |
| 2.5GbE (i226-V) | x1 | 985 MB/s |
| **Total** | **9** | ✓ fits exactly |

AQC113 on PCIe 3.0 x1 caps at ~7.9 Gbps (not full 10). The 5-HDD RAIDZ1 peaks at ~400 MB/s (3.2 Gbps); NVMe L2ARC cache can serve ~985 MB/s. Acceptable trade-off — still 6× faster than 1GbE.

### Component List

| Component | Status | Cost |
|---|---|---:|
| MikroTik CRS305-1G-4S+IN (fanless, 8W) | **To buy** | ~€140 |
| SFP+ 10GBASE-T transceiver × 3 (MikroTik S+RJ10 or compatible) | **To buy** | ~€90 (€30 each) |
| Intel X540-T1 10GbE RJ45 NIC (AI server) | **To buy** | ~€30-50 |
| Intel X540-T1 10GbE RJ45 NIC (Desktop PC) | **To buy** | ~€30-50 |
| Cat6A S/FTP solid 23AWG, 100m reel | **To buy** | ~€80-110 |
| Cat6A shielded keystone jacks × 12 | **To buy** | ~€36-60 |
| 2-port wall plates × 5 | **To buy** | ~€15-25 |
| 12-port Cat6A patch panel | **To buy** | ~€30-40 |
| Cat6A patch cables (0.5m + 1m) × 10 | **To buy** | ~€40-50 |
| Cable conduit / trunking ~30m | **To buy** | ~€30-60 |
| RJ45 crimping tool + cable tester | **To buy** | ~€30-50 |
| **Subtotal (networking)** | | **€550-765** |

NAS board price increase (€150-250 vs €80-130 for 2.5GbE) adds ~€70-120 net. Already accounted in the NAS section above.

### Power Analysis (24/7 operation)

| Option | Total draw | Annual cost (€0.25/kWh) |
|---|---|---|
| MikroTik CRS305 + 3× transceiver (~20W) | 20W | ~€44/year |
| TP-Link TL-SX105 (~35W, has fan) | 35W | ~€77/year |

MikroTik saves ~€33/year. Transceivers (€90) pay back in ~3 years. Plus: fanless = silent.

### Cabling Plan ("Open Walls Once")

6 cable runs total (3 locations × 2 runs each for future-proofing):

| Run | From | To | Length | Purpose |
|---|---|---|---|---|
| 1-2 | Patch panel | AI server room wall plate | ~15m each | Active + spare |
| 3-4 | Patch panel | Desktop room wall plate | ~15m each | Active + spare |
| 5-6 | Patch panel | Spare location wall plate | ~10m each | Future device |

Double runs cost ~€50 extra in cable but avoid re-opening walls for link aggregation, VLAN separation, or new devices.

---

## Summary: Total Spend Required

| Machine | Already Spent | Still To Buy | Total New Spend |
|---|---:|---:|---:|
| Main PC | €0 | €160-180 | €160-180 |
| AI Server | €1,198 | €136-167 | €1,334-1,365 |
| NAS | €0 | €392-656 | €392-656 |
| 10GbE Networking | €0 | €550-765 | €550-765 |
| Thin Client | €0 | €0 | €0 |
| **Grand Total** | **€1,198** | **€1,238-1,768** | **€2,436-2,966** |

**Offset from sales:** CX600 PSU (~€25-30 resale) reduces net spend slightly.

**NAS board note:** the NAS "Still To Buy" now reflects the 10GbE board price (€150-250). The networking section's €550-765 covers switch, transceivers, NICs, and cabling — it does NOT double-count the board.

---

## Owned Hardware Being Reallocated

| Item | From | To |
|---|---|---|
| 16GB DDR4 SODIMM (2x8GB) | Wyse 5070 | NAS |
| 8GB DDR4 SODIMM (2x4GB) | Spare | Wyse 5070 (thin client) |
| Corsair CX600 PSU | Main PC | **Sold** (~€25-30) |
| 3x WD Red 4TB | USB dock (Wyse) | NAS (native SATA) |
| 2x WD Black 2TB | Unused / external | NAS (ZFS mirror, AI workspace) |

---

## Priority Order (Buy Sequence)

1. **AI Server remaining parts** — Thermaltake Tower 300 (~€90-110)
2. **Main PC PSU + riser** — be quiet! Straight Power 12 750W + PCIe riser cable (~€160-180); sell CX600
3. **NAS build** — N100/N305 10GbE board, Jonsbo N3, picoPSU, 1-2TB NVMe (~€392-656)
4. **10GbE Networking** — MikroTik switch, transceivers, NICs, Cat6A cabling (~€550-765). Independent of step 3 for purchasing; cabling scheduled after NAS is operational.

Steps 1 and 2 are independent (AI server gets its own PSU). Step 3 can wait for deals on the N100/N305 board. Step 4 is a year-long project — purchases spread over months, walls opened once when all materials are ready.
