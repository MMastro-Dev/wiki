# AI Server Build

**Goal:** Build and configure the AI server (Ryzen 3600X + RTX 3090) with Ollama, CV-AI, and Immich ML offload.
**Created:** 2026-05-27
**Status:** in-progress

---

## Steps

### Hardware Assembly

- [ ] **H1.1** Install Corsair HX1000i in AI server case (Thermaltake Tower 300).
- [ ] **H1.2** Install Ryzen 5 3600X into B450M-A PRO MAX.
- [ ] **H1.3** Install 32GB DDR4 (2x16GB DIMM, slots A2+B2 for dual-channel).
- [ ] **H1.4** Install 512GB NVMe into M.2 slot.
- [x] **H1.5** GPU thermal mod applied — heatsink (€100), thermal pads (€40), thermal paste (€10). Video output confirmed and stress test passed. *(2026-05-28)*
- [ ] **H1.6** Mount modded GPU in case (PCIe 3.0 x16). Connect 2x 8-pin PCIe power.
- [ ] **H1.7** Connect PSU (24-pin ATX + 8-pin CPU), case fans, front panel.
- [ ] **H1.8** Boot test: BIOS, confirm CPU/RAM/NVMe detected, set XMP, set boot order.

### OS and Base Configuration

- [ ] **S1.1** Install Ubuntu Server 24.04 LTS (or Debian 12) to NVMe.
- [ ] **S1.2** Set static IP, hostname, non-root admin user, disable root SSH.
- [ ] **S1.3** Install Nvidia drivers (`nvidia-driver-550` or latest). Reboot.
- [ ] **S1.4** Verify: `nvidia-smi` shows RTX 3090, 24GB VRAM.
- [ ] **S1.5** Set power limit and persist via systemd service (`nvidia-smi -pl 320`).
- [ ] **S1.6** Install Docker + Docker Compose + nvidia-container-toolkit.
- [ ] **S1.7** Verify GPU Docker: `docker run --rm --gpus all nvidia/cuda:12.4.0-base-ubuntu22.04 nvidia-smi`

### Ollama and Models

- [ ] **S1.8** Deploy Ollama container with GPU passthrough (port `127.0.0.1:11434`).
- [ ] **S1.9** Pull models:
  - `qwen2.5:14b-instruct-q4_K_M` — CV-AI
  - `qwen2.5:7b-instruct-q4_K_M` — general assistant
- [ ] **S1.10** Create Modelfiles with `num_ctx` and system prompts.
- [ ] **S1.11** Set `OLLAMA_KEEP_ALIVE=-1`. Create boot script to pre-load models.
- [ ] **S1.12** Verify: `curl http://localhost:11434/api/generate` responds.
- [ ] **S1.13** Check VRAM: `nvidia-smi` — expect ~14GB weights + KV cache.

### Application Services

- [ ] **S1.14** Deploy Open WebUI (port `127.0.0.1:3080`).
- [ ] **S1.15** Deploy CV-AI FastAPI container (port `127.0.0.1:8007`). Point to local Ollama.
- [ ] **S1.16** Deploy immich-machine-learning (port `0.0.0.0:3003`, `MACHINE_LEARNING_DEVICE=cuda`). Firewall: NAS IP only.
- [ ] **S1.17** Update NAS Immich compose: `IMMICH_MACHINE_LEARNING_URL=http://<ai-server-ip>:3003`. Restart Immich. Verify smart search.
- [ ] **S1.18** Deploy Netdata with nvidia-smi plugin.
- [ ] **S1.19** Deploy Promtail (ships logs to thin client Loki — configure after Phase 3).

### Integration (after thin client is live)

- [ ] **S1.20** Update Caddyfile on thin client: `cv-ai.mmastro.dev` → `http://<ai-server-ip>:8007`.
- [ ] **S1.21** Optionally add `ai.mmastro.dev` for Open WebUI with `import require_auth_admin`.
- [ ] **S1.22** Configure Continue.dev: Ollama endpoint → `http://<ai-server-ip>:11434`.

---

## Notes

- Parts acquired: RTX 3090 (€765), GPU thermal mod (€150 — heatsink, thermal pads, thermal paste), Corsair HX1000i (€110), 32GB DDR4 (€130), Samsung PM981 500GB NVMe (€43).
- GPU thermal mod complete and tested (video output + stress test, 2026-05-28).
- Still to buy: Thermaltake Tower 300 case (~€90-110), Arctic P14 PWM 5-pack (~€30-35), Arctic P12 Slim PWM (~€8-10), Phanteks Universal Fan Bracket (~€8-12).
- H1.1 is blocked until the Tower 300 is purchased.
- See [notes/ai-server.md](../ai-server.md) for full GPU choice rationale and thermal mod plan.
- See [notes/deployment-checklist.md](../deployment-checklist.md) for the purchases ledger.
