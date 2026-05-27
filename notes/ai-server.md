# AI Server Plan

## Hardware

### Core Components

| Component | Source | Cost |
|---|---|---|
| Ryzen 5 3600X | Already owned | €0 |
| B450M-A PRO MAX | Already owned | €0 |
| RTX 3090 24GB (Zotac Trinity, stock air cooler) | ✅ Acquired | €765 |
| GPU thermal mod (Gelid pads ✅, Arctic MX-7 ✅, backplate fan, bracket) | Acquired | €130 |
| 32GB DDR4 3200MHz S3+ DragonHeart XMP (2x16GB DIMM) | ✅ Acquired | €130 |
| Samsung PM981 500GB NVMe Gen3 | ✅ Acquired | €43 |
| Corsair HX1000i 1000W (used, 80+ Platinum) | ✅ Acquired | €110 |
| Case | TBD — see Case Selection section below | €50-160 |
| **Total** | | **€1,268-1,288** |

### GPU: Why the RTX 3090

The 3090 was chosen over 16GB alternatives (4070 Ti Super at €750, 4060 Ti 16GB at €400):

| GPU | VRAM | Bandwidth | Concurrent models |
|---|---|---|---|
| 4060 Ti 16GB | 16 GB | 288 GB/s | 2 (tight) |
| 4070 Ti Super 16GB | 16 GB | 672 GB/s | 2 (tight) |
| **3090 24GB** | **24 GB** | **936 GB/s** | **3 concurrent** |

1. **VRAM headroom.** Two always-loaded models use ~14 GB weights. At 8K context the KV cache adds ~2 GB, totaling ~16 GB — which completely fills a 16GB card. On 24GB there is 8 GB free at 8K context.
2. **No model swapping.** A 14B coding model fits alongside both always-loaded models (~23GB total). On 16GB, any coding model forces a full swap.
3. **40% faster inference** than 4070 Ti Super (936 vs 672 GB/s — LLM generation is memory-bandwidth bound).
4. **Fine-tuning capability.** 24GB fits QLoRA on 7B-14B models. 16GB is marginal.
5. **Small cost delta.** 3090 total (~€895 with thermal mod) vs 4070 Ti Super (€750). +€145 for +8GB VRAM and +40% bandwidth.

Tradeoff: the 3090 runs hot under sustained GDDR6X inference loads. Mitigated via thermal pad replacement and backplate fan — see Cooling section below.

### Cooling

The Zotac RTX 3090 Trinity uses a stock triple-fan air cooler (IceStorm 2.0). Under sustained LLM inference the primary thermal concern is GDDR6X memory — memory-bandwidth-bound workloads run the rear VRAM chips hot for hours, and the stock backplate is passive.

**Thermal pad replacement**
Replace factory pads on the rear PCB with Gelid Solutions Ultimate pads (90×50×2.0mm, already owned). Verify thickness against the Trinity's actual component gaps using a teardown guide before applying — rear VRAM chips typically need 1.0–1.5mm, so the 2.0mm pads may need to be shimmed or swapped for thinner ones in those spots. Use Arctic MX-7 (already owned) for the die.

**Backplate fan**
Mount an Arctic P12 Slim PWM (120mm, 15mm thick) on the backplate via a Phanteks Universal Fan Bracket. Connect to a chassis fan header and set a temperature curve in BIOS. Even low sustained airflow across the rear pads drops memory junction temps noticeably.

**Chassis fans (Tower 300 chimney setup)**

| Position | Fan | Qty | Direction | Purpose |
|---|---|---|---|---|
| Bottom | Arctic P14 PWM (140mm) | 2 | Intake ↑ | Feed cool air directly into GPU fans |
| Top | Arctic P14 PWM (140mm) | 2 | Exhaust ↑ | Pull hot GPU/CPU air out through mesh |
| Rear | — | 0 | — | Leave empty — rear intake disrupts vertical chimney flow |
| Backplate | Arctic P12 Slim PWM (120mm, 15mm) | 1 | Up ↑ | Aimed at rear VRAM pads via Phanteks bracket |

Total: 5 fans. Buy the Arctic P14 PWM 5-pack (~€30-35, use 4) + 1× P12 Slim (~€8-10).

No rear fan: several Tower 300 builds report +3-5°C worse GPU temps with a rear intake because it creates crossflow that breaks the chimney column. The vertical path (bottom → GPU → CPU → top) works best sealed.

**Fan curves:**
- Bottom + top (same curve, matched RPM for neutral pressure): 600-800 RPM idle (inaudible), ramp to 1100-1300 RPM under sustained inference.
- Backplate fan: tie to GPU temp if motherboard supports it, otherwise fixed ~800 RPM (~18 dBA, inaudible outside case).
- GPU fans (IceStorm 2.0 stock curve): with good bottom intake, they stay at ~1200-1400 RPM under load vs ~1800 RPM without — significant noise reduction.

**Expected thermals (sustained 320W inference, ambient 25°C):**
- GPU die: ~72-78°C (vs ~82-88°C in a standard tower)
- VRAM junction: ~86-94°C (vs ~100-108°C without thermal mod + backplate fan)
- CPU: ~55-60°C (65W Ryzen 3600X barely notices)
- Noise at 1m: ~28-32 dBA (quiet conversation level)

### Case Selection

**Hard constraints:**
- Motherboard: mATX (B450M-A PRO MAX, 244 × 244mm)
- GPU clearance: ≥ 318mm (Zotac RTX 3090 Trinity = 317.8 × 131 × 57.3mm, 3 expansion slots)
- PSU: Corsair HX1000i = ATX, 200mm deep. This eliminates most compact mATX cases (typically 150-180mm max).

**Preferences:** smallest desk footprint, vertical or cube shape, quiet under sustained load, colored or modifiable (paintable/panelled), modular panels welcome.

**Critical trade-off:** the HX1000i at 200mm is the primary limiting factor for compact builds. Swapping to SFX (e.g., Corsair SF1000, ~€180-200) would open several smaller cases at the cost of selling the HX1000i (~€80-90 resale) — net delta ~€100-120. Cases below are split accordingly.

---

#### Group A — fits HX1000i as-is (ATX PSU ≥ 200mm)

| # | Case | Volume | Footprint (W×D) | GPU max | PSU max | Shape | Colors / Materials | Price (EU) |
|---|---|---|---|---|---|---|---|---|
| 1 | **Thermaltake Tower 300** | ~39.5L | 250 × 285mm | 380mm | ATX (generous) | Vertical chimney | Turquoise, Snow, Black, White | €90-110 |
| 2 | **SSUPD Meshroom S** | ~33.7L | 227 × 380mm | 336mm | ATX ≤ 200mm | Vertical chimney | Black, White (mesh panels) | €130-160 |
| 3 | **Fractal Design Meshify 2 Mini** | 33.0L | 204 × 415mm | 331mm | ATX ≤ 250mm | Compact tower | Black, White (mesh front) | €90-110 |
| 4 | **Fractal Design Node 804** | 40.3L | 344 × 389mm | 320mm | ATX ≤ 260mm | Dual-chamber cube | Black (brushed aluminum front) | €90-110 |
| 5 | **Thermaltake Core V21** | 45.5L | 321 × 424mm | 350mm | ATX (generous) | Modular cube (stackable) | Black — all-steel, easy to paint | €60-75 |
| 6 | **Montech Heritage PRO** | 41.5L | 225 × 415mm | 365mm | ATX ≤ 200mm | Compact tower (retro) | Black, White (textured front panel) | €70-85 |

**Notes — Group A:**
- **Tower 300** (current plan): chimney airflow is ideal for GPU thermals — heat rises through top mesh directly. Turquoise and Snow variants stand out visually. Small desk footprint (250mm wide). Down side: tall at 554mm.
- **Meshroom S**: the most compact option that still accepts a 200mm ATX PSU. Vertical airflow like the Tower 300 but ~15% less volume. All-mesh construction means top-tier thermals. Tight on the 3-slot GPU (336mm clearance vs 318mm card = 18mm margin, fine). Check official ATX PSU depth spec before buying.
- **Meshify 2 Mini**: narrowest footprint of the group (204mm wide). Conventional tower, not cube/vertical. Excellent airflow and build quality. Not colorful — all black or black/white mesh.
- **Node 804**: true cube form factor. Dual-chamber design isolates PSU heat from GPU. RISK: only 2.2mm GPU clearance (320mm max vs 317.8mm card). Power cables at the end of the GPU might interfere. Measure twice.
- **Core V21**: largest volume, but truly modular — every panel is interchangeable, rotatable I/O. Steel panels are trivial to powder-coat or spray paint any color. Cheapest option. Thermals are decent with 200mm front fan. Stackable if you ever add a second unit.
- **Heritage PRO**: retro-styled front panel (textured material, not standard mesh). Compact for a tower. Verify 200mm PSU clearance at purchase (spec says ATX but depth tolerance is tight).

---

#### Group B — requires SFX/SFX-L PSU (unlocks smaller builds)

If you sell the HX1000i (~€80-90) and buy a Corsair SF1000 Platinum (~€190) or Silverstone SX1000 SFX-L (~€200), these open up:

| # | Case | Volume | Footprint (W×D) | GPU max | Shape | Colors / Materials | Price (EU) |
|---|---|---|---|---|---|---|---|
| 7 | **Jonsbo D31 Mesh SC** | ~29L | 375 × 360mm | 325mm | Low-profile cube w/ LCD panel | Black, White (aluminum+mesh) | €100-130 |
| 8 | **Mechanic Master C28** | ~25L | 245 × 370mm | 330mm | Compact vertical | Black, White, Blue, Pink, Silver, custom panels | €50-80 |
| 9 | **Geometric Future Model 2** | ~27L | 250 × 350mm | 330mm | Modular aluminum cube | Silver natural aluminum — mods by design | €120-150 |
| 10 | **Raijintek Thetis** | ~33L | 210 × 376mm | 340mm | Compact tower (full aluminum) | Natural silver, Black anodized | €90-110 |
| 11 | **Jonsbo D41 Mesh** | ~35L | 220 × 430mm | 355mm | Compact tower w/ LCD | Black, White (aluminum frame) | €100-140 |
| 12 | **Sama IM01** | ~20L | 170 × 360mm | 325mm | Ultra-compact vertical | Black, White, Mint Green | €40-60 |

**Notes — Group B:**
- **Jonsbo D31 Mesh SC**: the LCD status panel on the side is a unique visual feature (shows temps/usage). True cube shape. 7mm GPU clearance margin is acceptable. Aluminum + mesh combo looks premium.
- **Mechanic Master C28**: most color options of any mATX case on the market. Interchangeable panels (mesh, tempered glass, solid) in different colors — mix and match. Extremely modifiable. Excellent value. Community has done wild paint jobs.
- **Geometric Future Model 2**: designed for modding — segments bolt together, panels swap freely. Raw aluminum finish. Designed to be customized, anodized, wrapped. Closest to "Lego for PC cases."
- **Raijintek Thetis**: full aluminum construction (not steel with aluminum trim). Feels different in hand — premium, quiet (damped panels). Brushed finish takes paint/vinyl well. 340mm GPU clearance gives the most margin in Group B.
- **Jonsbo D41 Mesh**: if the D31 is too tight (325mm), the D41 gives 355mm clearance at ~6L more volume. Still has the LCD panel option and aluminum frame aesthetic. Conventional tower proportions but narrower than most.
- **Sama IM01**: the absolute smallest mATX case available (~20L). Mint Green variant is unique. Budget-friendly. Trade-off: airflow is adequate but not exceptional for sustained 350W — you'll hear the GPU fans ramp. Best if you power-limit to 280W.

---

#### Decision

**Chosen case: Thermaltake Tower 300** (Turquoise or Snow variant)

Shortlisted alternatives for future reference: Geometric Future Model 2, Mechanic Master C28, Montech Heritage PRO, SSUPD Meshroom S.

#### Vertical GPU & Vapor Chamber Analysis

The Tower 300 mounts the GPU vertically (I/O bracket at top, card end pointing down). This raised a concern about vapor chamber cooling effectiveness in vertical orientation.

**Why it could be a problem (general):**
- Vapor chambers use a flat sealed plate with internal working fluid. The fluid evaporates at the die (hot spot), vapor travels to the fin stack, condenses, and must return to the die.
- When the evaporator (die) is physically above the condenser, gravity fights the return flow. The internal wick must do all the work via capillary action alone.
- In extreme cases (high TDP, sustained load, evaporator-on-top): +5-10°C penalty vs horizontal. Some cheap vapor chambers with thin wicks can even partially dry out under sustained load, causing thermal throttling.

**Why it is NOT an issue for this build:**
1. The Zotac RTX 3090 Trinity uses **copper heatpipes** (6x direct-touch), not a vapor chamber. Vapor chambers are on the AMP Extreme/Holo line.
2. Heatpipes have internal sintered wicks designed for multi-orientation operation. Vertical penalty: +1-3°C, well within margin.
3. The Tower 300's chimney airflow (bottom intake → top exhaust) works WITH the backplate fan setup — heat from VRAM pads rises naturally into the exhaust.
4. The power limit cap (`nvidia-smi -pl 320`) keeps sustained die power well below the card's 350W ceiling.
5. Gaming loads (bursty) would show zero measurable difference. Sustained inference (the actual workload) is memory-bandwidth-bound — die temperature isn't the limiting factor, VRAM junction temp is. The vertical + chimney + backplate fan setup actually optimizes for VRAM cooling.

**Conclusion:** no action needed. The Tower 300 vertical orientation is net-positive for this workload's thermal profile.

### PSU

Corsair HX1000i (used, 80+ Platinum): 1000W, zero-RPM mode (fan off at low loads), iCUE power monitoring. At sustained inference draw of 310-390W (~31-39% load), the fan stays off. The 1000W capacity leaves headroom for a future second GPU (2x 3090 at 320W each = ~760W system total).

Set power limit on first boot: `nvidia-smi -pl 320` (persist via systemd). No throughput loss, caps worst-case system draw at ~420W.

### Storage

512GB local NVMe is sufficient because bulk storage sits on the NAS over NFS:

| Location | Contents |
|---|---|
| Local NVMe | OS, Docker images, active Ollama models (~50-60 GB for 3-4 Q4_K_M models) |
| NAS (NFS mount) | Fine-tuning datasets, training adapters, model archive, dev workspaces |

Keep Ollama's model directory (`~/.ollama/models`) on local NVMe. Loading a 9 GB model over 1GbE takes ~90s; from NVMe it takes ~3s. Only archive models not in active rotation to the NAS. A 1TB NVMe would add headroom for experimentation without the NAS dependency, at ~€15-25 extra — worth it if 10GbE between the two machines is not available.

### Always-On

The CV-AI service is a portfolio piece — visitors won't wait 60s for a cold start. Always-on with models pre-loaded (~0.5s to first token). Ollama drops GPU to low P-state between requests (~30-60W idle vs 280-350W during inference).

The server sleeps during a fixed low-traffic window (e.g., 1am–8am via systemd timer; thin client sends WoL magic packet at scheduled wake time). This preserves the CV-AI always-on guarantee during all reasonable visitor hours. Annual electricity: ~€70 (€0.19/kWh, 70% uptime).

### Software Stack

| Layer | Technology |
|---|---|
| OS | Ubuntu Server 24.04 LTS (or Debian 12) |
| Runtime | Docker + Docker Compose + nvidia-container-toolkit |
| LLM engine | Ollama |
| UI | Open WebUI |
| IDE | Continue.dev (VS Code) → local Ollama endpoint |
| Monitoring | Netdata (GPU metrics) |

---

## Model Strategy

### Always-Loaded Models

| Task | Model class | Quant | VRAM (weights) | Speed (3090) |
|---|---|---|---|---|
| CV-AI agent | 13-14B instruction | Q4_K_M | ~9-10 GB | ~45-55 tok/s |
| Agentic assistant | 7-8B instruction | Q4_K_M | ~4-5 GB | ~70-90 tok/s |
| **Total** | | | **~14 GB** | |

**CV-AI agent:** accepts CV + job description, returns structured match report with scoring, keyword analysis, rewrite suggestions, salary estimate — primarily in Italian. Requires domain knowledge (CCNL, ATS) and multi-step structured output.

**Agentic assistant:** follows structured instructions from a cloud model (Claude/GPT). Merges notes, prepares files, executes plans. Daily driver to save premium tokens.

Candidates at build time: Qwen2.5 14B-Instruct + Qwen2.5 7B-Instruct (strong Italian, good instruction following).

### On-Demand Model

| Task | Model class | VRAM |
|---|---|---|
| Coding assistant | 14-32B code-specialized | 9-20 GB |

14B coder fits alongside always-loaded models (~23GB total). 32B coder requires swapping (~5-8s reload after).

### VRAM Budget

| Configuration | VRAM | Headroom |
|---|---|---|
| Task 1 + Task 2 (weights only) | ~14 GB | 10 GB |
| + KV cache at 8K ctx | ~16 GB | 8 GB |
| + KV cache at 32K ctx | ~22 GB | 2 GB |
| + 14B coder alongside at 8K | ~23 GB | 1 GB |

### KV Cache

Ollama pre-allocates the full KV cache on model load. At fp16:

| Model | 4K ctx | 8K ctx | 16K ctx | 32K ctx |
|---|---|---|---|---|
| 14B | ~750 MB | ~1.5 GB | ~3 GB | ~6 GB |
| 7B | ~220 MB | ~450 MB | ~900 MB | ~1.75 GB |
| **Both** | **~970 MB** | **~2 GB** | **~4 GB** | **~7.75 GB** |

The assistant regularly reaches 8K-16K context (multi-turn planning). CV-AI uses short prompts, rarely exceeds 4K.

When KV cache overflows VRAM, Ollama spills to DDR4 over PCIe (~30-40 GB/s vs 936 GB/s VRAM). At >50% spill, a 10s response takes 20-30s. This is why 24GB was chosen over 16GB.

### Ollama Configuration

```
# Always loaded (boot via systemd)
ollama run qwen2.5:14b-instruct-q4_K_M --keepalive -1    # CV-AI
ollama run qwen2.5:7b-instruct-q4_K_M --keepalive -1     # Assistant

# On-demand (auto-unloads after 5min idle)
ollama run qwen2.5-coder:14b-instruct-q4_K_M             # Coding (fits alongside)
ollama run qwen2.5-coder:32b-instruct-q4_K_M             # Coding (swaps others)
```

---

## Fine-Tuning and Distillation

The CV-AI task requires structured Italian-language analysis with CCNL/ATS domain knowledge. The question: is the base 14B model enough, or does it need task-specific training?

### Definitions

- **Fine-tuning:** train on 50-200 curated examples (hand-corrected model outputs). Teaches exact output format and domain vocab.
- **Distillation:** train on outputs from a teacher model (Claude, GPT-4o). Compresses teacher quality into a smaller student. In practice the two overlap: using Claude to generate training data and fine-tuning on it is distillation.

### Scenario Comparison

| Scenario | VRAM (4K ctx) | tok/s | Quality* | Format reliability | Training effort |
|---|---|---|---|---|---|
| **14B untuned** | ~10.8 GB | 45-55 | 7/10 | Moderate | None |
| **14B fine-tuned** | ~10.8 GB | 45-55 | 8.5/10 | High | Medium (50-200 examples) |
| 14B fine-tuned + distilled | ~10.8 GB | 45-55 | 9/10 | High | High |
| 7B untuned | ~5.2 GB | 75-90 | 4.5/10 | Low | None |
| 7B fine-tuned | ~5.2 GB | 75-90 | 6.5/10 | High | Medium |
| **7B fine-tuned + distilled** | ~5.2 GB | 75-90 | 8/10 | High | High |
| 3B fine-tuned + distilled | ~2.1 GB | 150-200 | 5/10 | High | Very high |

*Quality scored for the CV-AI task specifically.

The reasoning ceiling is a real constraint at 3B (non-standard roles, salary edge cases break). At 7B, task-adapted models can match untuned 14B on common cases. At 14B, fine-tuning mostly fixes format consistency and domain gaps.

### Recommendation

Start with **14B untuned**. Benchmark against `cv-ai-benchmark.md`. Qwen2.5 14B has strong Italian and instruction following out of the box — it will likely clear the quality bar.

If it falls short: **fine-tune on 50-100 examples** (QLoRA with Unsloth on the 3090, 2-4 hours per run, a weekend of work).

Full distillation (large Claude-generated dataset) is only worth pursuing to squeeze into 7B — which 24GB VRAM does not require.

---

## Immich ML Offloading

Immich's ML container (CLIP + FaceNet) uses ~700MB-1GB VRAM — negligible on 24GB. Run it on the AI server GPU with `MACHINE_LEARNING_DEVICE=cuda`.

```
NAS:       immich-server, immich-database, immich-redis
           IMMICH_MACHINE_LEARNING_URL=http://<ai-server>:3003
AI Server: immich-machine-learning (GPU, port 3003)
```

| Scenario | NAS CPU (J4105) | GPU (3090) |
|---|---|---|
| CLIP per photo | ~800ms-2s | ~5-20ms |
| 10K photo scan | ~2-5 hours | ~1-3 minutes |

The NAS J4105 has no AVX2 (required by ONNX Runtime). GPU is ~100x faster for batch work.

If the AI server goes down, Immich smart search and face grouping pause. Photos remain accessible on the NAS.

---

## ROI vs Cloud

3,000 requests/month, ~9M tokens/month:
- Claude Sonnet tier: ~€30-60/month = €1,800-3,600 over 5 years
- GPT-4o tier: ~€15-30/month = €900-1,800 over 5 years
- Self-hosted 5-year TCO (AI server hardware + electricity): ~€1,635-1,660

Breakeven vs Claude-tier: ~2-3 years. Plus: no rate limits, full privacy, portfolio value, fine-tuning platform.
