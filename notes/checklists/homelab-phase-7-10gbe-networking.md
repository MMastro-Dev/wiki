# 10GbE LAN Networking Upgrade

**Goal:** Upgrade the home LAN to 10GbE for NAS, AI server, and Desktop PC over Cat6A structured cabling, enabling the NAS as centralized workspace storage at ~1 GB/s.
**Created:** 2026-05-28
**Status:** not-started

> Depends on Phase 2 (NAS build) being operational. Purchasing can begin independently.
> See [notes/shopping-list.md](../shopping-list.md) for full component specs and cost analysis.
> Charts: [Network topology](../charts/network-topology.md) · [Cost breakdown](../charts/networking-costs-pie.md) · [Timeline](../charts/homelab-gantt.md)

---

## Steps

### Purchasing

- [ ] **NET.1** Acquire MikroTik CRS305-1G-4S+IN switch (~€140)
- [ ] **NET.2** Acquire 3× SFP+ 10GBASE-T transceiver modules (MikroTik S+RJ10 or compatible, ~€30 each)
- [ ] **NET.3** Acquire Intel X540-T1 10GbE RJ45 NIC for AI server (~€30-50, used eBay)
- [ ] **NET.4** Acquire Intel X540-T1 10GbE RJ45 NIC for Desktop PC (~€30-50, used eBay)
- [ ] **NET.5** Acquire Cat6A S/FTP solid copper cable, 100m reel (~€80-110)
- [ ] **NET.6** Acquire Cat6A shielded keystone jacks × 12 (~€36-60)
- [ ] **NET.7** Acquire wall plates (2-port) × 5, 12-port patch panel, conduit/trunking (~€75-125)
- [ ] **NET.8** Acquire Cat6A patch cables (0.5m + 1m assortment) × 10 (~€40-50)
- [ ] **NET.9** Acquire tools: RJ45 crimper, punchdown tool, cable tester (~€30-50)

### Pre-Cabling (before opening walls)

- [ ] **NET.10** Verify AI server PCIe clearance: confirm slot 2 (PCIe x16 @ x4) is physically accessible with RTX 3090 installed. If blocked, plan riser or alternative slot.
- [ ] **NET.11** Plan cable routes: measure each run, mark wall entry/exit points, identify stud/conduit locations.
- [ ] **NET.12** Decide switch + NAS placement location (network cabinet / shelf). Confirm power outlet availability.
- [ ] **NET.13** Confirm all materials on-hand before opening walls. Do not start cabling until NET.1-NET.9 are complete.

### Cabling (open walls once — all runs in single session)

- [ ] **NET.14** Cut wall channels / open existing conduit for all 6 cable runs.
- [ ] **NET.15** Pull Cat6A cables through walls (6 runs: 2× AI server room, 2× Desktop room, 2× spare location).
- [ ] **NET.16** Terminate keystone jacks at wall plate ends (12 terminations total).
- [ ] **NET.17** Mount wall plates at each location.
- [ ] **NET.18** Terminate keystone jacks at patch panel end (12 terminations).
- [ ] **NET.19** Mount patch panel in network cabinet area.

### Hardware Installation

- [ ] **NET.20** Install Intel X540-T1 in AI server (PCIe slot 2). Verify detection in BIOS/dmesg.
- [ ] **NET.21** Install Intel X540-T1 in Desktop PC. Verify detection.
- [ ] **NET.22** Mount MikroTik CRS305 in network cabinet. Insert 3× 10GBASE-T transceivers.
- [ ] **NET.23** Connect Fritz!Box → switch 1GbE port (short Cat6A patch cable).
- [ ] **NET.24** Connect NAS → patch panel port 1 (or direct to transceiver if co-located).
- [ ] **NET.25** Connect AI server wall plate → patch panel → switch SFP+ port 2.
- [ ] **NET.26** Connect Desktop wall plate → patch panel → switch SFP+ port 3.

### Testing & Commissioning

- [ ] **NET.27** Test each link with `iperf3 -s` / `iperf3 -c <ip>` — verify 9+ Gbps between NAS and each client.
- [ ] **NET.28** Test Fritz!Box internet connectivity through switch (speed test, DNS resolution).
- [ ] **NET.29** Configure NAS SMB3 shares (`tank/workspaces/`) — verify mount from Desktop at 10GbE speed.
- [ ] **NET.30** Configure NAS NFS export for AI server (model storage) — verify mount.
- [ ] **NET.31** Test WireGuard VPN remote access to NAS SMB share (functional test, not speed — limited by internet).

### Finish

- [ ] **NET.32** Close walls: patch/plaster/paint over cable channels.
- [ ] **NET.33** Label all patch panel ports and wall plates.
- [ ] **NET.34** Document final network topology in wiki (`src/architecture/network.md`).

---

## Notes

- **"Open walls once" rule:** All 6 cable runs (including spares) must be pulled in a single session (NET.14-NET.19). Do not start until ALL materials are confirmed on-hand (NET.13).
- **Double runs:** Each location gets 2× Cat6A (active + spare) for future link aggregation, VLAN separation, or new devices. Extra cable cost: ~€50.
- **Spare location:** One additional wall plate (runs 5-6) for a future device. If no obvious location now, run to the nearest room without a plate.
- **NAS co-location:** If NAS is on the same shelf as the switch, it can use a short patch cable directly to a transceiver — no wall run needed. Adjust runs accordingly.
- **AI server slot 2 clearance:** The RTX 3090 occupies 2.5 slots. If slot 2 is physically blocked, options: low-profile NIC in a PCIe x1 slot (caps at ~2.5 Gbps) or a riser cable extension.
- **Fritz!Box WireGuard → NAS:** Remote workspace access speed is limited by internet upload (typically 50-100 Mbps for Italian FTTH). For heavy remote work, use Syncthing to sync critical files locally.
