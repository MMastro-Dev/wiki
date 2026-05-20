# Deployment Checklist

See [infrastructure.md](infrastructure.md) for architecture context, [thin-client-and-nas.md](thin-client-and-nas.md) and [ai-server.md](ai-server.md) for detailed rationale.

---

## Purchases Ledger

| Item | Amount | Status |
|---|---|---|
| RTX 3090 24GB (no cooler) | -€765 | ✅ Acquired |
| 4GB DDR4 SODIMM PC4-2666V | -€10 | ✅ Acquired |
| 2x 8GB DDR3 SODIMM (sold) | +€20 | ✅ Done |
| Corsair VS550 PSU (sold) | +€20 | ✅ Done |
| GPU thermal mod (Gelid pads, MX-7, fan, bracket) | -€130 | ✅ Acquired |
| NAS mini-ITX board (N100) | -€80-130 | ⬜ Pending |
| NAS case (Jonsbo N2) | -€70-90 | ⬜ Pending |
| NAS PSU (Corsair SF750 Platinum 2024) | -€150-180 | ⬜ Pending |
| NAS boot NVMe (1-2TB) | -€100-200 | ⬜ Pending |
| 32GB DDR4 3200MHz 2x16GB DIMM | -€150 | ⬜ Pending |
| 512GB NVMe Gen3 M.2 | -€40-45 | ⬜ Pending |
| AI server PSU (Seasonic PRIME PX-1000, 1000W Platinum) | -€220-240 | ⬜ Pending |
| AI server case (Thermaltake Tower 300) | -€90-110 | ⬜ Pending |
| Main PC PSU (be quiet! Straight Power 12 750W) | -€130 | ⬜ Pending |
| Main PC PCIe riser cable | -€30-50 | ⬜ Pending |

---

## Phase 1: AI Server Build

Priority: highest. Most of the budget is already committed (GPU acquired).

### Hardware Assembly

- [ ] **H1.1** Install Seasonic PRIME PX-1000 in AI server case (Thermaltake Tower 300).
- [ ] **H1.2** Install Ryzen 5 3600X into B450M-A PRO MAX.
- [ ] **H1.3** Install 32GB DDR4 (2x16GB DIMM, slots A2+B2 for dual-channel).
- [ ] **H1.4** Install 512GB NVMe into M.2 slot.
- [ ] **H1.5** Mount GPU with stock Zotac Trinity cooler. Apply new thermal paste (Arctic MX-7). Replace rear VRAM pads (Gelid Ultimate). Attach backplate fan (Arctic P12 Slim PWM + Phanteks bracket).
- [ ] **H1.6** Install GPU (PCIe 3.0 x16). Connect 2x 8-pin PCIe power from Seasonic PSU.
- [ ] **H1.7** Connect PSU (24-pin ATX + 8-pin CPU), case fans, front panel.
- [ ] **H1.8** Boot test: BIOS, confirm CPU/RAM/NVMe detected, set XMP, set boot order.

### OS and Base Configuration

- [ ] **S1.1** Install Ubuntu Server 24.04 LTS (or Debian 12) to NVMe.
- [ ] **S1.2** Set static IP, hostname, non-root admin user, disable root SSH.
- [ ] **S1.3** Install Nvidia drivers (`nvidia-driver-550` or latest). Reboot.
- [ ] **S1.4** Verify: `nvidia-smi` shows RTX 3090, 24GB VRAM.
- [ ] **S1.5** Set power limit and persist:
    ```bash
    sudo nvidia-smi -pl 320
    # Create /etc/systemd/system/nvidia-powerlimit.service
    sudo systemctl enable nvidia-powerlimit.service
    ```
- [ ] **S1.6** Install Docker + Docker Compose + nvidia-container-toolkit.
- [ ] **S1.7** Verify GPU Docker: `docker run --rm --gpus all nvidia/cuda:12.4.0-base-ubuntu22.04 nvidia-smi`

### Ollama and Models

- [ ] **S1.8** Deploy Ollama container with GPU passthrough (port 127.0.0.1:11434).
- [ ] **S1.9** Pull models:
    ```bash
    docker exec ollama ollama pull qwen2.5:14b-instruct-q4_K_M    # CV-AI
    docker exec ollama ollama pull qwen2.5:7b-instruct-q4_K_M     # Assistant
    ```
- [ ] **S1.10** Create Modelfiles with `num_ctx` and system prompts.
- [ ] **S1.11** Set `OLLAMA_KEEP_ALIVE=-1`. Create boot script to pre-load models.
- [ ] **S1.12** Verify: `curl http://localhost:11434/api/generate -d '{"model":"...","prompt":"Hello"}'`
- [ ] **S1.13** Check VRAM: `nvidia-smi` — ~14GB weights + KV cache.

### Application Services

- [ ] **S1.14** Deploy Open WebUI (port 127.0.0.1:3080).
- [ ] **S1.15** Deploy CV-AI FastAPI container (port 127.0.0.1:8007). Point to local Ollama.
- [ ] **S1.16** Deploy immich-machine-learning (port 0.0.0.0:3003, `MACHINE_LEARNING_DEVICE=cuda`). Firewall: NAS IP only.
- [ ] **S1.17** Update NAS Immich compose: `IMMICH_MACHINE_LEARNING_URL=http://<ai-server-ip>:3003`. Restart Immich. Verify smart search.
- [ ] **S1.18** Deploy Netdata with nvidia-smi plugin.
- [ ] **S1.19** Deploy Promtail (ships logs to thin client Loki — configure later when thin client is ready).

### Integration (after thin client is live)

- [ ] **S1.20** Update Caddyfile on thin client: `cv-ai.mmastro.dev` → `http://<ai-server-ip>:8007`.
- [ ] **S1.21** Optionally add `ai.mmastro.dev` for Open WebUI with `import require_auth_admin`.
- [ ] **S1.22** Configure Continue.dev: Ollama endpoint → `http://<ai-server-ip>:11434`.

---

## Phase 2: NAS Build + Service Migration

### Hardware Assembly

- [ ] **N2.1** Acquire mini-ITX N100 board + 4-bay case + PicoPSU.
- [ ] **N2.2** Install DDR4 SODIMMs (PC4-2400T + PC4-2666V = 8GB).
- [ ] **N2.3** Install boot SSD (NVMe or M.2 SATA depending on board).
- [ ] **N2.4** Mount WD Red HDDs (3x 4TB) in case SATA bays.
- [ ] **N2.5** Boot test: BIOS, confirm RAM/SSD/HDDs detected.

### OS and Storage

- [ ] **N2.6** Install Debian 12 Bookworm to boot SSD.
- [ ] **N2.7** Set static IP, hostname, non-root admin user, disable root SSH.
- [ ] **N2.8** Install Docker + Docker Compose.
- [ ] **N2.9** Mount each HDD individually: `/mnt/hdd1`, `/mnt/hdd2`, `/mnt/hdd3`.
- [ ] **N2.10** Install mergerfs. Create pool: `/mnt/pool`. Add to `/etc/fstab`.
- [ ] **N2.11** Set up storage tiering:
    - Boot SSD: PostgreSQL DBs, Immich thumbnails, Docker volumes
    - HDD pool: Immich originals, Paperless media, Loki logs, backups
- [ ] **N2.12** Set up NFS export for Loki log storage (thin client writes here).

### Service Migration (from Wyse 5070)

- [ ] **M2.1** On Wyse 5070: `docker compose` export configs for all application services.
- [ ] **M2.2** Transfer data: `rsync -avP` all persistent volumes from Wyse to NAS.
- [ ] **M2.3** Deploy on NAS in order: Gitea → Immich → Paperless → Actual Budget → Memos → Hugo Blog → CV → CV Forms → MailHog → Wiki → Static Site.
- [ ] **M2.4** Verify each service is functional on NAS.
- [ ] **M2.5** Update Wyse 5070 Caddy reverse_proxy upstreams to point at NAS IP.
- [ ] **M2.6** Test all services end-to-end through Caddy.
- [ ] **M2.7** Remove application containers from Wyse 5070. It now runs only gateway services.

---

## Phase 3: Wyse 5070 Thin Client Conversion

The Wyse is already running Caddy/AdGuard/auth. This phase strips it down to gateway-only.

- [ ] **T3.1** Verify gateway services (Caddy, AdGuard, oauth2-proxy, Pocket ID) are working after NAS migration.
- [ ] **T3.2** Deploy Netdata on thin client.
- [ ] **T3.3** Deploy Uptime Kuma on thin client.
- [ ] **T3.4** Deploy Loki on thin client. Configure storage to NAS via NFS.
- [ ] **T3.5** Deploy Promtail on thin client.
- [ ] **T3.6** Reclaim SSD space: remove old application data, Docker images. Run `docker system prune`.
- [ ] **T3.7** Set up weekly cron: `docker system prune -af --filter "until=168h"`.
- [ ] **T3.8** Remove USB dock from Wyse 5070 (HDDs are now in NAS). Retire the dock.

---

## Phase 4: Optimization and Hardening

- [ ] **O4.1** Run CV-AI benchmark: 5-10 CV+JD pairs vs `cv-ai-benchmark.md`. If quality is low, try different model or fine-tune.
- [ ] **O4.2** Run assistant benchmark: multi-turn sessions at 8K and 16K context. Check `nvidia-smi` for spill.
- [ ] **O4.3** Tune `num_ctx`: CV-AI → 4096, Assistant → 16384 or 32768.
- [ ] **O4.4** Uptime Kuma checks for AI server (Ollama API, CV-AI health).
- [ ] **O4.5** Firewall rules on AI server: SSH from LAN, port 3003 from NAS IP, port 11434 from LAN.
- [ ] **O4.6** Monitoring dashboards: GPU temp, VRAM, inference latency, power draw.
- [ ] **O4.7** *(Optional)* WoL proxy on thin client for nighttime AI server shutdown.
- [ ] **O4.8** *(Optional)* Pull and test coding model (`qwen2.5-coder:14b-instruct-q4_K_M`).
- [ ] **O4.9** Update `src/` wiki: service inventory, architecture diagram, any new service pages.

---

## Phase 5: CV-AI Fine-Tuning (Optional)

Only if Phase 4 benchmarks show the untuned 14B model falls short.

- [ ] **F5.1** Build training dataset: 50-100 CV+JD pairs with gold-standard analyses.
- [ ] **F5.2** Format as JSONL (system/user/assistant turns matching CV-AI prompt template).
- [ ] **F5.3** Install Unsloth on AI server.
- [ ] **F5.4** QLoRA fine-tune: rank 16-32, ~2-4 hours on 3090. Export GGUF at Q4_K_M.
- [ ] **F5.5** Load in Ollama. Re-run O4.1 benchmark.
- [ ] **F5.6** If good: deploy as production CV-AI model. Keep base 14B as fallback.

---

## Phase 6: NAS Storage Expansion (Optional, Deferred)

- [ ] **E6.1** Purchase 4TB+ parity drive for free bay.
- [ ] **E6.2** Install SnapRAID. Configure parity schedule (nightly or weekly).
- [ ] **E6.3** *(Future)* Upgrade NAS RAM to 16GB+ for ZFS evaluation.
