# 10GbE LAN Network Topology

Planned network structure after the 10GbE upgrade. Data sourced from [notes/shopping-list.md](../shopping-list.md).

> Linked from: [notes/shopping-list.md](../shopping-list.md), [notes/checklists/homelab-phase-7-10gbe-networking.md](../checklists/homelab-phase-7-10gbe-networking.md)

---

## Network Topology (Planned)

```mermaid
flowchart TD
    Internet["Internet (1 Gbps fibre)"]
    FritzBox["Fritz!Box\n(Gateway / Firewall / WireGuard VPN)"]
    Switch["MikroTik CRS305-1G-4S+IN\n(4× SFP+ / 1× 1GbE / fanless 8W)"]
    NAS["NAS\n(N100/N305, 10GbE onboard)\nCentralized Storage"]
    AI["AI Server\n(Ryzen 3600X + RTX 3090)\nIntel X540-T1 10GbE"]
    Desktop["Desktop PC\n(Ryzen 7800X3D)\nIntel X540-T1 10GbE"]
    Wyse["Wyse 5070 Thin\n(Caddy / AdGuard / oauth2-proxy)\n1GbE onboard"]
    Mesh["Fritz!Mesh Repeaters\n(WiFi devices)"]
    VPN["WireGuard VPN Clients\n(remote access)"]

    Internet -->|"fibre ONT"| FritzBox
    VPN -->|"WireGuard tunnel"| FritzBox
    FritzBox -->|"2.5GbE auto-neg\n(1GbE port)"| Switch
    FritzBox -->|"1GbE"| Wyse
    FritzBox -->|"WiFi mesh"| Mesh

    Switch -->|"SFP+ port 1\n+ 10GBASE-T transceiver\n→ Cat6A in wall"| NAS
    Switch -->|"SFP+ port 2\n+ 10GBASE-T transceiver\n→ Cat6A in wall"| AI
    Switch -->|"SFP+ port 3\n+ 10GBASE-T transceiver\n→ Cat6A in wall"| Desktop

    NAS -.->|"NFS (models, datasets)"| AI
    NAS -.->|"SMB3 (workspace storage)"| Desktop
    NAS -.->|"SMB3 over VPN"| VPN
```

---

## Layer Breakdown

```mermaid
flowchart LR
    subgraph "Internet Perimeter"
        FW["Fritz!Box\nNAT + Firewall + WireGuard"]
    end

    subgraph "10GbE LAN (Layer 2)"
        SW["MikroTik CRS305\n(unmanaged switching)"]
        NAS["NAS — 10GbE"]
        AI["AI Server — 10GbE"]
        PC["Desktop — 10GbE"]
    end

    subgraph "1GbE Segment"
        Wyse["Wyse 5070 — 1GbE\n(Caddy reverse proxy)"]
        WiFi["Fritz!Mesh — WiFi"]
    end

    FW -->|"2.5G uplink"| SW
    FW -->|"1GbE"| Wyse
    FW -->|"WiFi"| WiFi
    SW --- NAS
    SW --- AI
    SW --- PC
```

---

## Cabling Plan (Cat6A Structured — "Open Walls Once")

```mermaid
flowchart TD
    subgraph "Network Cabinet (Fritz!Box + Switch + NAS)"
        PP["12-port Patch Panel"]
        SW["MikroTik CRS305"]
        NAS["NAS (short patch)"]
    end

    subgraph "AI Server Room"
        WP1["Wall Plate (2-port)"]
        AI["AI Server"]
    end

    subgraph "Desktop Room"
        WP2["Wall Plate (2-port)"]
        PC["Desktop PC"]
    end

    subgraph "Spare Locations"
        WP3["Wall Plate (2-port)\n(future device)"]
    end

    PP -->|"Cat6A run 1 (~15m)"| WP1
    PP -->|"Cat6A run 2 (spare)"| WP1
    PP -->|"Cat6A run 3 (~15m)"| WP2
    PP -->|"Cat6A run 4 (spare)"| WP2
    PP -->|"Cat6A run 5 (~10m)"| WP3
    PP -->|"Cat6A run 6 (spare)"| WP3
    SW -->|"patch cables"| PP
    NAS -->|"1m patch"| PP
    WP1 -->|"patch"| AI
    WP2 -->|"patch"| PC
```
