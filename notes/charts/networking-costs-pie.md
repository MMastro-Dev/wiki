# 10GbE Networking Costs

Cost breakdown for the 10GbE LAN upgrade. Data sourced from [notes/shopping-list.md](../shopping-list.md).

> Linked from: [notes/shopping-list.md](../shopping-list.md), [notes/checklists/homelab-phase-7-10gbe-networking.md](../checklists/homelab-phase-7-10gbe-networking.md)

---

## Total Networking Cost by Category

Total estimated: ~€620-845. Midpoint used for chart (~€730).

```mermaid
pie title 10GbE Networking — Cost by Category
    "Switch (MikroTik CRS305)" : 140
    "SFP+ Transceivers (3×)" : 90
    "NICs (2× Intel X540-T1)" : 80
    "NAS Board Uplift (10GbE vs 2.5GbE)" : 95
    "Cat6A Cable (100m reel)" : 95
    "Keystones + Wall Plates + Panel" : 80
    "Conduit + Trunking" : 45
    "Tools (crimper + tester)" : 40
    "Patch Cables" : 45
```

---

## Networking vs Other Homelab Spend

Shows the 10GbE upgrade in context of total homelab spending.

```mermaid
pie title Total Homelab Spend (All Phases)
    "AI Server" : 1350
    "NAS (hardware)" : 475
    "10GbE Networking" : 730
    "Main PC" : 160
    "Thin Client" : 0
```

---

## Power Consumption Comparison (24/7 Operation)

Annual electricity cost at €0.25/kWh for two switch options considered.

```mermaid
pie title Switch Annual Electricity Cost
    "MikroTik CRS305 + transceivers (~20W) = €44/yr" : 44
    "TP-Link TL-SX105 (~35W) = €77/yr" : 77
```

MikroTik saves ~€33/year in electricity. Transceivers (~€90) pay for themselves in ~3 years vs the TP-Link's higher power draw. Combined with fanless silence, MikroTik is the clear choice for 24/7 homelab.
