# Server Infrastructure Costs

Cost breakdown charts for the 3-server homelab. Data sourced from [notes/shopping-list.md](../shopping-list.md).

> Linked from: [notes/shopping-list.md](../shopping-list.md), [notes/infrastructure.md](../infrastructure.md)

---

## Total Cost by Server

Compares total build cost (spent + to-buy) across all three servers. Thin client uses existing hardware only (€0 new spend), so system value (€155) is shown for proportion.

```mermaid
pie title Total Build Cost by Server
    "AI Server (€1,350)" : 1350
    "NAS (€424)" : 424
    "Thin Client (€155)" : 155
```

---

## AI Server Component Breakdown

Total build cost: ~€1,350. Dominated by the RTX 3090.

```mermaid
pie title AI Server — Component Cost
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

## NAS Component Breakdown

Estimated total build cost: ~€424 (midpoint of €312–536 range). All components are to-buy.

```mermaid
pie title NAS — Component Cost (Estimated)
    "N100 Mini-ITX Board" : 105
    "Jonsbo N3 Case" : 105
    "picoPSU + AC Adapter" : 50
    "Boot NVMe (1TB)" : 100
    "Noctua Fans (2x)" : 34
```

> Owned components (16GB DDR4 from Wyse, 3x WD Red 4TB, 2x WD Black 2TB) not shown — zero new spend.

---

## Thin Client Component Breakdown

Zero new spend. All components are pre-owned. Shown by projected value.

```mermaid
pie title Thin Client — Component Value
    "Dell Wyse 5070" : 80
    "1TB M.2 SATA SSD" : 60
    "8GB DDR4 SODIMM" : 15
```

---

## Spend Timeline

Cumulative new spend as hardware is acquired.

```mermaid
pie title Spend: Already vs Remaining
    "Already Spent" : 1198
    "Still To Buy (all servers)" : 608
```
