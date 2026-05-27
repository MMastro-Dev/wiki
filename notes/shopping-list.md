# Hardware Shopping List

Full bill of materials across all four machines. "Projected value" is approximate resale/replacement value for owned components.

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
| GPU thermal mod (Gelid pads, Arctic MX-7, fan, bracket) | Acquired | €130 | ~€130 |
| Corsair HX1000i 1000W (used, 80+ Platinum) | Acquired | €110 | ~€110 |
| 32GB DDR4 3200MHz S3+ DragonHeart XMP (2x16GB DIMM) | ✅ Acquired | €130 | ~€130 |
| Samsung PM981 500GB NVMe Gen3 | ✅ Acquired | €43 | ~€43 |
| Thermaltake Tower 300 (mATX) | **To buy** | €90-110 | ~€100 |
| Arctic P14 PWM 5-pack (use 4: 2 bottom intake, 2 top exhaust) | **To buy** | €30-35 | - |
| Arctic P12 Slim PWM (backplate fan) | **To buy** | €8-10 | - |
| Phanteks Universal Fan Bracket (backplate mount) | **To buy** | €8-12 | - |
| **Subtotal (to buy)** | | **€136-167** | |
| **Already spent** | | **€1,178** | |
| **Total build cost** | | **€1,314-1,345** | |
| **Total system value** | | | **~€1,395** |


---

## NAS (Storage + Immich + Paperless)

| Component | Status | Cost to Buy | Projected Value |
|---|---|---:|---:|
| Mini-ITX N100 board (4+ SATA, M.2) | **To buy** | €80-130 | ~€100 |
| Jonsbo N3 (8-bay 3.5", aluminum, ITX) | **To buy** | €90-120 | ~€100 |
| PSU — see analysis below | **To buy** | €30-80 | - |
| 16GB DDR4 SODIMM (2x8GB, from Wyse) | Owned (swapped) | - | ~€40 |
| Boot NVMe: 1TB (€100) or 2TB (€200) | **To buy** | €100-200 | ~€100-200 |
| Noctua NF-A10x25 PWM (100mm, HDD airflow) | **To buy** | €32-36 (2×) | - |
| 3x WD Red 4TB HDD | Owned | - | ~€240 (€80 each) |
| 2x WD Black 2TB HDD (AI workspace pool) | Owned | - | ~€100 (€50 each) |
| **Subtotal (to buy)** | | **€312-536** | |
| **Total system value** | | | **~€950-1,056** |

### NAS PSU Analysis

**NAS real power draw (6 drives, N3):**
- Intel N100: ~8-12W at load
- 6× HDDs at spin-up: ~30-36W peak, ~10-15W idle each
- NVMe boot: ~3-5W
- **Total sustained:** ~70-100W · **Spin-up peak:** ~115-130W

**Why the CX600 is wrong for NAS use:**
- CX600 at 70W = ~12% load. 80+ Bronze minimum efficiency kicks in at 20% load (~120W) — below that the curve drops sharply, real-world efficiency at NAS loads is ~75-78%. You'd be paying to heat the PSU.
- CX600 uses group regulation (not LLC+DC-DC). At very low 12V loads rail voltages drift — minor risk but real for 24/7 storage duty.
- 600W ATX in a mini-ITX NAS case (Jonsbo N2) is physically too large anyway — N2 uses SFX format.
- Verdict: **sell the CX600** (~€25-30).

**Why the SF750 is overkill:**
- 750W Platinum reaches peak efficiency (~92%) at 375W. At 70W it's running at 9% load — in the 80-83% efficiency range. You pay €150-180 for a curve that never matters.
- SFX 750W also costs a premium because high-wattage SFX is harder to build. You're paying for headroom you will never use.

**What the NAS actually needs:**
A PSU whose 50% load point lands near 40-80W — meaning a **100-200W unit**. At that rating, 70W = 35-70% load, right in the Platinum/Gold efficiency sweet spot.

**Recommended options (SFX or Flex ATX — both fit Jonsbo N2):**

| **Option** | **Wattage** | **Rating** | **Type** | **Price (EU)** | **Notes** |
|---|---|---|---|---|---|
| **Corsair SF450 Platinum** | 450W | 80+ Platinum | SFX (100mm) | €90-110 | Fits N3 (≤105mm), trusted, overkill but safe |
| **Seasonic SSP-300SFX** | 300W | 80+ Platinum | SFX (100mm) | €65-80 | Fits N3, 100W = 33% load, good efficiency |
| **picoPSU-160-XT + 200W AC adapter** | 160W | ~87% efficiency | DC-DC | €40-60 | Fanless, no depth constraint, peaks at NAS loads; use 200W adapter (not 150W) for 6-drive spin-up margin |
| **Silverstone SX500-G** | 500W | 80+ Gold | SFX (100mm) | €70-90 | Fits N3, cheaper than Platinum options |

⚠️ **N3 PSU constraint: SFX ≤105mm.** Standard SFX (100mm deep) fits. SFX-L (125mm) does NOT fit.

**Recommendation: picoPSU-160-XT + 200W AC adapter (~€45-60 total)**
- Fanless — zero noise contribution from PSU
- DC-DC conversion efficiency peaks at low loads (~85-88% at 40-80W), matching actual NAS draw
- Tiny (plugs directly into 24-pin ATX header, no cables)
- 150W brick handles all NAS load including HDD spin-up (HDDs stagger-spin under OS control)
- Saves ~€100-125 vs the SF750, spends it better on NVMe storage

If you want a "real" PSU with more margin: **Seasonic SSP-300SFX** (~€65-80). 300W Platinum, SFX, fits the N2 natively. 70W = 23% load is still well within the Platinum efficiency window.

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

## Summary: Total Spend Required

| Machine | Already Spent | Still To Buy | Total New Spend |
|---|---:|---:|---:|
| Main PC | €0 | €160-180 | €160-180 |
| AI Server | €1,178 | €136-167 | €1,314-1,345 |
| NAS | €0 | €312-536 | €312-536 |
| Thin Client | €0 | €0 | €0 |
| **Grand Total** | **€1,178** | **€608-883** | **€1,786-2,061** |

**Offset from sales:** CX600 PSU (~€25-30 resale) reduces net spend slightly.

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
3. **NAS build** — N100 board, Jonsbo N2, SF750 Platinum 2024, 1-2TB NVMe (~€400-600)

Steps 1 and 2 are independent (AI server gets its own PSU). Step 3 can wait for deals on the N100 board.
