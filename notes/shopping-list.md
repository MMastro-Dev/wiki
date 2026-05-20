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
| be quiet! Straight Power 12 750W (80+ Gold, silent) | **To buy** | €130 | - |
| PCIe riser cable (vertical GPU mount) | **To buy** | €30-50 | - |
| **Subtotal (to buy)** | | **€160-180** | |
| **Total system value** | | | **~€1,430-1,470** |

The existing CX600 PSU will be sold (~€25-30 resale). The be quiet! Straight Power 12 is semi-passive (fan off at low loads), fully modular, and sized for a future GPU upgrade.

---

## AI Server

| Component | Status | Cost to Buy | Projected Value |
|---|---|---:|---:|
| Ryzen 5 3600X | Owned | - | ~€80 |
| MSI B450M-A PRO MAX (mATX) | Owned | - | ~€50 |
| RTX 3090 24GB (Zotac Trinity, stock cooler) | Acquired | €765 | ~€765 |
| GPU thermal mod (Gelid pads, Arctic MX-7, fan, bracket) | Acquired | €130 | ~€130 |
| 32GB DDR4 3200MHz (2x16GB DIMM) | **To buy** | €150 | ~€150 |
| 512GB NVMe Gen3 M.2 2280 | **To buy** | €40-45 | ~€40 |
| Seasonic PRIME PX-1000 (1000W, 80+ Platinum, 24/7) | **To buy** | €220-240 | ~€230 |
| Thermaltake Tower 300 (mATX) | **To buy** | €90-110 | ~€100 |
| **Subtotal (to buy)** | | **€500-545** | |
| **Already spent** | | **€895** | |
| **Total build cost** | | **€1,395-1,440** | |
| **Total system value** | | | **~€1,545** |

**AI Server PSU alternatives (for reference):**

| PSU | Wattage | Efficiency | Price | Notes |
|---|---:|---|---:|---|
| Corsair HX1000i (2023) | 1000W | 80+ Platinum | ~€200-220 | iCUE power monitoring, zero-RPM mode |
| be quiet! Dark Power 13 | 1000W | 80+ Titanium | ~€230-260 | Frameless fan, highest efficiency tier |
| Corsair HX1200 | 1200W | 80+ Platinum | ~€230-250 | More headroom if second GPU is higher-end |
| Seasonic PRIME TX-1000 | 1000W | 80+ Titanium | ~€270-300 | Best efficiency available, 12-year warranty |

---

## NAS (Storage + Immich + Paperless)

| Component | Status | Cost to Buy | Projected Value |
|---|---|---:|---:|
| Mini-ITX N100 board (4+ SATA, M.2) | **To buy** | €80-130 | ~€100 |
| Jonsbo N2 (5-bay 3.5", aluminum) | **To buy** | €70-90 | ~€80 |
| Corsair SF750 Platinum 2024 (SFX, 750W, 80+ Platinum) | **To buy** | €150-180 | ~€160 |
| 16GB DDR4 SODIMM (2x8GB, from Wyse) | Owned (swapped) | - | ~€40 |
| Boot NVMe: 1TB (€100) or 2TB (€200) | **To buy** | €100-200 | ~€100-200 |
| 3x WD Red 4TB HDD | Owned | - | ~€240 (€80 each) |
| 2x WD Black 2TB HDD (AI workspace pool) | Owned | - | ~€100 (€50 each) |
| **Subtotal (to buy)** | | **€400-600** | |
| **Total system value** | | | **~€920-1,020** |

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
| AI Server | €895 | €500-545 | €1,395-1,440 |
| NAS | €0 | €400-600 | €400-600 |
| Thin Client | €0 | €0 | €0 |
| **Grand Total** | **€895** | **€1,060-1,325** | **€1,955-2,220** |

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

1. **AI Server remaining parts** — 32GB DDR4 DIMM, NVMe, Seasonic PRIME PX-1000, Thermaltake Tower 300 (~€500-545)
2. **Main PC PSU + riser** — be quiet! Straight Power 12 750W + PCIe riser cable (~€160-180); sell CX600
3. **NAS build** — N100 board, Jonsbo N2, SF750 Platinum 2024, 1-2TB NVMe (~€400-600)

Steps 1 and 2 are independent (AI server gets its own PSU). Step 3 can wait for deals on the N100 board.
