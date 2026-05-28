# Homelab Optimisation and Hardening

**Goal:** Optimise and harden all three servers once the full migration is complete; update the wiki.
**Created:** 2026-05-27
**Status:** not-started

> Depends on Phase 3 (thin client conversion) being complete.

---

## Steps

### AI Quality Benchmarking

- [ ] **O4.1** Run CV-AI benchmark: 5–10 CV+JD pairs vs `cv-ai-benchmark.md`. If quality is low, consider fine-tuning (see [homelab-phase-5-cv-ai-tuning.md](homelab-phase-5-cv-ai-tuning.md)).
- [ ] **O4.2** Run assistant benchmark: multi-turn sessions at 8K and 16K context. Check `nvidia-smi` for VRAM spill.
- [ ] **O4.3** Tune `num_ctx`: CV-AI → 4096, assistant → 16384 or 32768 depending on VRAM headroom.

### Monitoring

- [ ] **O4.4** Add Uptime Kuma checks: Ollama API health, CV-AI `/health` endpoint.
- [ ] **O4.6** Build monitoring dashboards: GPU temp, VRAM usage, inference latency, power draw.

### Security Hardening

- [ ] **O4.5** Set firewall rules on AI server:
  - SSH: LAN only
  - Port 3003 (immich-machine-learning): NAS IP only
  - Port 11434 (Ollama): LAN only

### Wiki Update

- [ ] **O4.9** Update `src/constitution.md` service inventory table with new server assignments.
- [ ] **O4.10** Update `src/architecture/overview.md` diagram to reflect 3-server topology.

### Optional

- [ ] **O4.7** *(Optional)* WoL proxy on thin client for nighttime AI server shutdown.
- [ ] **O4.8** *(Optional)* Pull and test coding model (`qwen2.5-coder:14b-instruct-q4_K_M`).

---

## Notes

- O4.9 and O4.10 are the handoff point to the Wiki Editor agent. When ready, ask it to document: AI server services (Ollama, Open WebUI, CV-AI, immich-machine-learning), updated architecture overview with 3-server topology, and service inventory table.
- See [notes/infrastructure.md](../infrastructure.md) for open hardware and AI/model decisions that may need revisiting at this phase.
