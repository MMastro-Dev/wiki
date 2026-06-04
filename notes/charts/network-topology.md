# 10GbE LAN Network Topology

Planned network structure after the 10GbE upgrade. Data sourced from [notes/shopping-list.md](../shopping-list.md).

> Linked from: [notes/shopping-list.md](../shopping-list.md), [notes/checklists/homelab-phase-7-10gbe-networking.md](../checklists/homelab-phase-7-10gbe-networking.md)

---

## Network Topology (Planned)

```mermaid
flowchart TD
    ONT["CIG G-97CP ONT\n(external, 1-2W)"]
    FritzBox["Fritz!Box 5530\n(Gateway / Firewall / WireGuard VPN)"]
    Switch["MikroTik CRS305-1G-4S+IN\n(4× SFP+ / 1× 1GbE / fanless 8W)"]
    NAS["NAS\n(CWWK i5-8265UES, ConnectX-3 SFP+)\nCentralized Storage"]
    AI["AI Server\n(Ryzen 3600X + RTX 3090)\nConnectX-3 SFP+ 10GbE"]
    Desktop["Desktop PC\n(Ryzen 7800X3D)\nConnectX-3 SFP+ 10GbE"]
    Wyse["Wyse 5070 Thin\n(Caddy / AdGuard / oauth2-proxy)\n1GbE onboard"]
    Mesh["Fritz!Mesh Repeaters\n(WiFi devices)"]
    VPN["WireGuard VPN Clients\n(remote access)"]

    Internet["Internet (1 Gbps fibre GPON)"]
    Internet -->|"GPON"| ONT
    ONT -->|"1GbE"| FritzBox
    VPN -->|"WireGuard tunnel"| FritzBox
    FritzBox -->|"1GbE"| Switch
    FritzBox -->|"1GbE"| Wyse
    FritzBox -->|"WiFi mesh"| Mesh

    Switch -->|"SFP+ 1\n1m DAC or OM4 fiber"| NAS
    Switch -->|"SFP+ 2\nOM4 fiber → wall → 10G-SR transceiver"| AI
    Switch -->|"SFP+ 3\nOM4 fiber → wall → 10G-SR transceiver"| Desktop

    NAS -.->|"NFS (models, datasets)"| AI
    NAS -.->|"SMB3 (workspace storage)"| Desktop
    NAS -.->|"SMB3 over VPN"| VPN
```

---

## Layer Breakdown

```mermaid
flowchart LR
    subgraph "Internet Perimeter"
        ONT["CIG G-97CP ONT"]
        FW["Fritz!Box 5530\nNAT + Firewall + WireGuard"]
    end

    subgraph "10GbE LAN (Layer 2 — SFP+ fiber)"
        SW["MikroTik CRS305\n(direct fiber, 8W)"]
        NAS["NAS — ConnectX-3 SFP+"]
        AI["AI Server — ConnectX-3 SFP+"]
        PC["Desktop — ConnectX-3 SFP+"]
    end

    subgraph "1GbE Segment"
        Wyse["Wyse 5070 — 1GbE\n(Caddy reverse proxy)"]
        WiFi["Fritz!Mesh — WiFi"]
    end

    ONT -->|"1GbE"| FW
    FW -->|"1GbE"| SW
    FW -->|"1GbE"| Wyse
    FW -->|"WiFi"| WiFi
    SW --- NAS
    SW --- AI
    SW --- PC
```

---

## Cabling Plan (OM4 Fiber — "Open Walls Once")

```mermaid
flowchart TD
    subgraph "Network Cabinet (Fritz!Box + Switch + NAS)"
        PP["12-port Fiber Patch Panel"]
        SW["MikroTik CRS305"]
        NAS["NAS (DAC 1m direct to SW)"]
    end

    subgraph "AI Server Room"
        WP1["Wall Plate (2-port LC)"]
        AI["AI Server\n10G-SR transceiver + ConnectX-3"]
    end

    subgraph "Desktop Room"
        WP2["Wall Plate (2-port LC)"]
        PC["Desktop PC\n10G-SR transceiver + ConnectX-3"]
    end

    subgraph "Spare Location"
        WP3["Wall Plate (2-port LC)\n(future device)"]
    end

    PP -->|"OM4 run 1 (measured length)"| WP1
    PP -->|"OM4 run 2 (spare)"| WP1
    PP -->|"OM4 run 3 (measured length)"| WP2
    PP -->|"OM4 run 4 (spare)"| WP2
    PP -->|"OM4 run 5 (measured length)"| WP3
    PP -->|"OM4 run 6 (spare)"| WP3
    SW -->|"0.5m LC patch cables"| PP
    NAS -->|"1m DAC direct"| SW
    WP1 -->|"0.5m LC patch"| AI
    WP2 -->|"0.5m LC patch"| PC
```
