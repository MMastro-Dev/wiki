# 10GbE LAN Networking Upgrade

**Goal:** Upgrade the home LAN to 10GbE for NAS, AI server, and Desktop PC over OM4 multimode fiber structured cabling, enabling the NAS as centralized workspace storage at ~1 GB/s.
**Created:** 2026-05-28
**Updated:** 2026-06-04 — switched from Cat6A + 10GBASE-T to OM4 fiber + SFP+ direct. See decision log 2026-06-04 for rationale and research sources.
**Status:** not-started

> Depends on Phase 2 (NAS build) being operational. Purchasing can begin independently.
> See [notes/shopping-list.md](../shopping-list.md) for full component specs and cost analysis.
> Charts: [Network topology](../charts/network-topology.md) · [Cost breakdown](../charts/networking-costs-pie.md) · [Timeline](../charts/homelab-gantt.md)

---

## Steps

### Purchasing

- [ ] **NET.1** Acquire MikroTik CRS305-1G-4S+IN switch (~€140)
- [ ] **NET.2** Acquire 3× Mellanox ConnectX-3 MCX311A-XCAT SFP+ NICs (~€20 each used, eBay) — one each for NAS, AI server, Desktop PC. `mlx4` driver, mainline Linux kernel.
- [ ] **NET.3** Acquire 6× 10G-SR OM4 SFP+ transceivers (~€8 each used, eBay) — 2 per NIC (one at NIC end, one at switch end for wall runs). NAS DAC path skips these; see NET.5.
- [ ] **NET.4** Acquire pre-terminated OM4 LC-LC duplex fiber cables to measured lengths (order from FS.com after NET.12 route survey). Budget ~€15 per run × 4 wall runs = ~€60. Add 1-2m slack per run.
- [ ] **NET.5** Acquire 1× DAC (Direct Attach Copper, SFP+ twinax) 1m cable (~€10) for NAS ↔ switch direct connection if NAS is co-located with switch. Skip if NAS requires a wall run.
- [ ] **NET.6** Acquire 12× LC duplex fiber keystone adapters (~€3 each = ~€36) for wall plates and patch panel.
- [ ] **NET.7** Acquire wall plates (2-port) × 5, 12-port fiber patch panel, conduit/trunking (~€60-100). LC-LC duplex patch cables (0.5m) × 6 for switch-side panel connections (~€20).
- [ ] **NET.8** Acquire Cat6 patch cable × 1 short (~€3) for Fritz!Box → switch 1GbE management port.

### Pre-Cabling (before opening walls)

- [ ] **NET.9** Verify AI server PCIe clearance: confirm a PCIe x4 or x8/x16 slot is accessible alongside the RTX 3090. ConnectX-3 is a half-height dual-slot card (x8 physical, x8 electrical). If slot 2 is blocked by the GPU, plan a riser cable or use the remaining x16 slot at reduced lanes.
- [ ] **NET.10** Plan fiber routes: measure each run (NAS shelf/switch → AI server room, Desktop room, spare location). Record lengths. Order OM4 cables per NET.4 only after measuring.
- [ ] **NET.11** Confirm NAS placement relative to switch. If within ~1m: DAC cable (NET.5), no wall run needed, save one fiber cable. If further: order a fiber run to length.
- [ ] **NET.12** Confirm power outlet availability at switch/NAS shelf location.
- [ ] **NET.13** Confirm ALL materials on-hand before opening walls. Do not start cabling until NET.1-NET.8 are all acquired.

### Cabling (open walls once — all runs in single session)

- [ ] **NET.14** Cut wall channels / open existing conduit for all 6 fiber runs (4 active + 2 spare).
- [ ] **NET.15** Pull OM4 LC-LC pre-terminated fiber cables through walls (6 runs: 2× AI server room, 2× Desktop room, 2× spare location). Fiber is 2-3mm and light — no shielding, no grounding, no minimum bend radius issues at these diameters in normal conduit.
- [ ] **NET.16** Seat LC connectors into fiber keystone adapters at wall plate ends (12 total). Click-in, no tool needed.
- [ ] **NET.17** Mount wall plates at each location.
- [ ] **NET.18** Seat LC connectors into fiber keystone adapters at patch panel end (12 total).
- [ ] **NET.19** Mount fiber patch panel in network cabinet area.

### Hardware Installation

- [ ] **NET.20** Install Mellanox ConnectX-3 in AI server (PCIe slot per NET.9 survey). Verify detection: `lspci | grep Mellanox` and driver load `dmesg | grep mlx4`. No proprietary firmware needed — `mlx4_core` and `mlx4_en` are in-kernel.
- [ ] **NET.21** Install Mellanox ConnectX-3 in Desktop PC. Verify detection (Windows: Device Manager; Linux: same dmesg check).
- [ ] **NET.22** Mount MikroTik CRS305 in network cabinet. No transceiver pre-insertion needed — fiber directly uses the SFP+ cages.
- [ ] **NET.23** Connect Fritz!Box LAN port → CRS305 1GbE RJ45 port (short Cat6 patch cable).
- [ ] **NET.24** Connect NAS → CRS305 SFP+ port 1. If co-located: DAC cable direct. If wall run: 10G-SR transceiver in NAS NIC + fiber to patch panel + 0.5m LC patch to switch SFP+ port.
- [ ] **NET.25** Insert 10G-SR transceiver in AI server NIC. Connect wall plate → patch panel → 0.5m LC patch → CRS305 SFP+ port 2. Verify link LED on switch.
- [ ] **NET.26** Insert 10G-SR transceiver in Desktop PC NIC. Connect wall plate → patch panel → 0.5m LC patch → CRS305 SFP+ port 3. Verify link LED.
- [ ] **NET.27** Insert 10G-SR transceivers in CRS305 SFP+ ports for each fiber-connected device (ports 1-3). Switch side of each link needs a transceiver too unless using DAC.

### Testing & Commissioning

- [ ] **NET.28** Test each link with `iperf3 -s` / `iperf3 -c <ip>` — verify 9+ Gbps between NAS and each client.
- [ ] **NET.29** Test Fritz!Box internet connectivity through switch (speed test, DNS resolution).
- [ ] **NET.30** Configure NAS SMB3 shares (`tank/workspaces/`) — verify mount from Desktop at 10GbE speed.
- [ ] **NET.31** Configure NAS NFS export for AI server (model storage) — verify mount.
- [ ] **NET.32** Test WireGuard VPN remote access to NAS SMB share (functional test, not speed — limited by internet).

### Finish

- [ ] **NET.33** Close walls: patch/plaster/paint over cable channels.
- [ ] **NET.34** Label all patch panel ports and wall plates.
- [ ] **NET.35** Document final network topology in wiki (`src/architecture/network.md`).

---

## Notes

- **Why fiber instead of Cat6A:** SFP+ direct over OM4 is cheaper (saves ~€150-200 vs Cat6A + 10GBASE-T transceivers), runs cooler (no hot transceivers in the CRS305 fanless body), is easier to pull through conduit (2-3mm vs 7-8mm), needs no shielded termination tools, and supports 25G/100G in future with a transceiver swap on the same fiber. See decision log 2026-06-04.
- **Why no 10GBASE-T transceivers:** S+RJ10 and equivalents draw 2-4W each in the CRS305's fanless chassis. Three of them in a small sealed case creates a thermal problem. They also add conversion latency and have documented link stability issues. Direct SFP+ + fiber has zero conversion.
- **NIC choice — Mellanox ConnectX-3 MCX311A-XCAT:** €15-20 used, PCIe x8 electrical (x8 physical), 1× SFP+ port. The `mlx4` driver is in mainline Linux since kernel 3.x — zero driver installation needed on Debian. Intel X520-DA1 is an equivalent alternative (`ixgbe` driver, also mainline).
- **"Open walls once" rule:** All 6 fiber runs (including spares) must be pulled in a single session (NET.14-NET.19). Do not start until ALL materials are confirmed on-hand (NET.13).
- **Double runs:** Each location gets 2× OM4 fiber (active + spare) for future link aggregation, VLAN separation, or new devices. Extra fiber cable cost: negligible vs copper.
- **Spare location:** One additional wall plate (runs 5-6) for a future device. If no obvious location, run to the nearest room without a plate.
- **NAS co-location shortcut:** If NAS sits on the same shelf as the switch, use a 1m DAC cable — no fiber, no transceivers on that link at all. Cheapest and simplest possible 10G connection.
- **AI server slot 2 clearance:** The RTX 3090 occupies 2.5 slots. ConnectX-3 is half-height (fits in x8/x16 slot below the GPU if clearance allows). If slot is blocked, use a PCIe x4 riser cable to extend to an accessible slot.
- **ONT not consolidated into Fritz!Box:** Unidata provides a CIG G-97CP external ONT. The Fritz!Box 5530's SFP cage uses a proprietary AVM module (not a standard GPON SFP stick); the OMCI stack runs on the Fritz!Box mainboard, so third-party sticks cannot authenticate. Consolidation requires replacing the Fritz!Box entirely (MikroTik RB5009 + GPON SFP stick path) at ~€250 additional cost. Not worth it while the ONT is a tiny silent box drawing 1-2W. Revisit if upgrading to XGS-PON (10G) service from Unidata — that's when a RouterOS device with 10G SFP+ cage earns its cost.
- **Fritz!Box WireGuard → NAS:** Remote workspace access speed is limited by internet upload (typically 50-100 Mbps for Italian FTTH). For heavy remote work, use Syncthing to sync critical files locally.
