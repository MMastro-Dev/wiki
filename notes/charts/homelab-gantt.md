# Homelab Build Timeline

Gantt chart for the full homelab build across all phases. Data sourced from [notes/deployment-checklist.md](../deployment-checklist.md).

> Linked from: [notes/deployment-checklist.md](../deployment-checklist.md), [notes/checklists/shopping-parts.md](../checklists/shopping-parts.md)

---

## Full Build Roadmap

```mermaid
gantt
    title Homelab Build — All Phases
    dateFormat YYYY-MM-DD
    axisFormat %b %Y

    section Phase 1 — AI Server
    GPU thermal mod               :done, 2026-05-01, 2026-05-28
    Acquire case + fans           :crit, 2026-06-01, 14d
    Assemble AI server            :2026-06-15, 7d
    Stress test + validate        :2026-06-22, 3d

    section Phase 2 — NAS Build
    Select + acquire NAS board (10GbE)  :crit, 2026-06-01, 45d
    Acquire Jonsbo N3 + picoPSU         :2026-06-15, 30d
    Acquire boot NVMe                   :2026-06-15, 30d
    Assemble NAS hardware               :2026-07-15, 7d
    Install Debian + ZFS                :2026-07-22, 3d
    Migrate services from Wyse          :2026-07-25, 7d
    Configure SMB3 workspace shares     :2026-08-01, 3d

    section Phase 3 — Thin Client
    RAM swap (16GB → NAS, 8GB → Wyse)  :2026-07-15, 1d
    Strip Wyse to gateway-only          :2026-08-04, 3d

    section Phase 7 — 10GbE Networking
    Acquire MikroTik CRS305 + transceivers  :2026-08-01, 30d
    Acquire Intel X540-T1 NICs (×2)         :2026-08-01, 30d
    Plan cable routes + buy materials       :2026-08-15, 21d
    Open walls + run Cat6A (all runs)       :crit, 2026-09-15, 14d
    Terminate keystones + patch panel       :2026-09-29, 3d
    Install switch + connect devices        :2026-10-02, 2d
    Test all links at 10GbE                 :2026-10-04, 2d
    Close walls + finish                    :2026-10-06, 7d

    section Phase 4 — Hardening
    Firewall audit + fail2ban tuning  :2026-10-15, 14d
    Backup strategy (ZFS snapshots)   :2026-10-15, 7d
```

---

## 10GbE Networking Phase — Detailed

```mermaid
gantt
    title Phase 7 — 10GbE Networking (Detail)
    dateFormat YYYY-MM-DD
    axisFormat %d %b

    section Purchasing
    MikroTik CRS305-1G-4S+IN           :2026-08-01, 14d
    3× SFP+ 10GBASE-T transceivers     :2026-08-01, 14d
    2× Intel X540-T1 (used, eBay)      :2026-08-01, 21d
    Cat6A 100m reel + keystones         :2026-08-15, 14d
    Wall plates + patch panel + tools   :2026-08-15, 14d
    Conduit + trunking                  :2026-09-01, 7d

    section Cabling (open walls once)
    Plan routes + mark walls            :2026-09-08, 3d
    Cut channels / open conduit         :crit, 2026-09-15, 5d
    Pull Cat6A cables (6 runs)          :crit, 2026-09-20, 5d
    Terminate keystones (12 ends)       :2026-09-25, 2d
    Mount wall plates                   :2026-09-27, 1d
    Patch panel termination             :2026-09-28, 1d

    section Commissioning
    Mount switch + NAS rack area        :2026-09-29, 1d
    Install NICs (AI server + Desktop)  :2026-09-30, 1d
    Connect all patch cables            :2026-10-01, 1d
    Test each link (iperf3, 10G)        :2026-10-02, 1d
    Configure SMB3 + NFS mounts         :2026-10-03, 1d
    Close walls + cosmetic finish       :2026-10-04, 7d
```
