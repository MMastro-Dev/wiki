# Homelab Project Costs

Consolidated cost and power charts for the full homelab infrastructure. Data sourced from [notes/shopping-list.md](../shopping-list.md).

> Replaces: `server-costs-pie.md` (server-only) and `networking-costs-pie.md` (networking-only).
> Linked from: [notes/shopping-list.md](../shopping-list.md), [notes/deployment-checklist.md](../deployment-checklist.md)

---

## Grand Total Overview

Total homelab investment: **~€2,700** (midpoint of €2,436–2,966 range).

```mermaid
pie title Total Homelab Investment (~€2,700)
    "Already Spent (€1,198)" : 1198
    "Still To Buy (~€1,500)" : 1500
```

---

## Cost Share by Project

How the total budget divides across the four build projects.

```mermaid
pie title Cost Share by Project
    "AI Server (€1,350)" : 1350
    "NAS Build (€525)" : 525
    "10GbE Networking (€660)" : 660
    "Main PC (€170)" : 170
```

> Thin Client omitted (€0 new spend). NAS includes 10GbE board cost; networking covers switch, NICs, cabling only (no double-counting).

---

## AI Server — Component Breakdown

Total build: ~€1,350. Already spent: €1,198. Remaining: ~€150.

```mermaid
pie title AI Server — Component Cost (€1,350)
    "RTX 3090 24GB" : 765
    "GPU Thermal Mod" : 150
    "Corsair HX1000i PSU" : 110
    "32GB DDR4 RAM" : 130
    "Samsung PM981 NVMe" : 43
    "Thermaltake Tower 300" : 100
    "Case Fans + Bracket" : 47
```

> Owned components (Ryzen 3600X ~€80, B450M-A PRO MAX ~€50) not shown — zero new spend.

---

## NAS — Component Breakdown

Total build: ~€525 (midpoint). All to buy.

```mermaid
pie title NAS — Component Cost (~€525)
    "N100/N305 10GbE Board" : 200
    "Jonsbo N3 Case" : 105
    "picoPSU + AC Adapter" : 48
    "Boot NVMe (1-2TB)" : 100
    "ZFS Cache NVMe" : 50
    "Noctua Fans (2×)" : 34
```

> Owned components (16GB DDR4 from Wyse, 3× WD Red 4TB, 2× WD Black 2TB) not shown — zero new spend.

---

## 10GbE Networking — Component Breakdown

Total: ~€660 (midpoint of €550–765).

```mermaid
pie title 10GbE Networking — Cost Breakdown (~€660)
    "MikroTik CRS305 Switch" : 140
    "SFP+ Transceivers (3×)" : 90
    "NICs — 2× Intel X540-T1" : 80
    "Cat6A Cable (100m)" : 95
    "Keystones + Plates + Panel" : 80
    "Conduit + Trunking" : 45
    "Patch Cables" : 45
    "Tools (crimper + tester)" : 40
```

---

## Main PC — Remaining Spend

Minimal investment. Only case decision pending.

```mermaid
pie title Main PC — Remaining Cost (~€170)
    "Replacement Case" : 130
    "PCIe Riser (if keeping Core P3)" : 40
```

> One of these is purchased, not both — depends on case decision. Shown for proportion.

---

## Power Consumption — Sustained Load (All 24/7 Devices)

Total 24/7 draw at typical sustained load: ~**165W**.

```mermaid
pie title Power Draw — Sustained (165W total)
    "AI Server (idle, no inference)" : 80
    "NAS (drives active)" : 52
    "MikroTik Switch + Transceivers" : 20
    "Wyse 5070 (gateway)" : 15
```

> AI Server at idle (no inference running). During inference bursts the 3090 adds 150–320W (total system 230–400W), but these are intermittent. Main PC not shown (not 24/7).

---

## Power Consumption — Full Load (Peak)

Maximum draw when all systems are active simultaneously: ~**485W**.

```mermaid
pie title Power Draw — Peak (485W total)
    "AI Server (inference)" : 400
    "NAS (all drives + spin-up)" : 52
    "MikroTik Switch + Transceivers" : 20
    "Wyse 5070 (gateway)" : 15
```

---

## Annual Electricity Cost (24/7, €0.25/kWh)

Based on typical average load profiles (NAS ~35W avg with drive spindown, AI server ~100W avg with periodic inference, others constant).

| System | Avg Draw | Annual kWh | Annual Cost |
|---|---:|---:|---:|
| AI Server (avg with inference) | ~100W | 876 kWh | ~€219 |
| NAS (avg with spindown) | ~35W | 307 kWh | ~€77 |
| MikroTik + transceivers | ~20W | 175 kWh | ~€44 |
| Wyse 5070 | ~15W | 131 kWh | ~€33 |
| **Total** | **~170W** | **1,489 kWh** | **~€373/year** |

```mermaid
pie title Annual Electricity Cost (~€373/year)
    "AI Server (€219)" : 219
    "NAS (€77)" : 77
    "Switch + Transceivers (€44)" : 44
    "Wyse 5070 (€33)" : 33
```

---

## Switch Power Comparison (Decision Context)

Why MikroTik CRS305 was chosen over TP-Link TL-SX105.

```mermaid
pie title Switch — Annual Electricity
    "MikroTik CRS305 + transceivers (20W) = €44/yr" : 44
    "TP-Link TL-SX105 (35W) = €77/yr" : 77
```

MikroTik saves €33/year. Transceiver cost (€90) pays back in ~3 years. Plus: fanless = silent 24/7 operation.
