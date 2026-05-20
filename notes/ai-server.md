# AI Server Plan

## Hardware

### Core Components

| Component | Source | Cost |
|---|---|---|
| Ryzen 5 3600X | Already owned | €0 |
| B450M-A PRO MAX | Already owned | €0 |
| RTX 3090 24GB (Zotac Trinity, stock air cooler) | ✅ Acquired | €765 |
| GPU thermal mod (Gelid pads ✅, Arctic MX-7 ✅, backplate fan, bracket) | Acquired | €130 |
| 32GB DDR4 3200MHz (2x16GB DIMM) | New | €150 |
| 512GB NVMe Gen3 M.2 2280 | New | €40-45 |
| Seasonic PRIME PX-1000 (1000W, 80+ Platinum, hybrid fan) | New | €220-240 |
| Case | Thermaltake Tower 300 (mATX) | €90-110 |
| **Total** | | **€1,395-1,440** |

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

**Thermal performance**
With these modifications, the 3090 stays stable under sustained inference loads. The Thermaltake Tower 300 case has a chimney-style airflow design (bottom-to-top convection) that naturally pulls heat away from the GPU, supporting the backplate cooling approach.

### PSU

Seasonic PRIME PX-1000: 1000W, 80+ Platinum, 12-year warranty, hybrid fan mode (fan off at low loads). Designed for continuous 24/7 operation. At sustained inference draw of 310-390W (~31-39% load), the fan stays off or runs near-silent. The 1000W capacity leaves headroom for a future second GPU (2x 3090 at 320W each = ~760W system total).

Set power limit on first boot: `nvidia-smi -pl 320` (persist via systemd). No throughput loss, caps worst-case system draw at ~420W.

### Storage

512GB local NVMe is sufficient because bulk storage sits on the NAS over NFS:

| Location | Contents |
|---|---|
| Local NVMe | OS, Docker images, active Ollama models (~50-60 GB for 3-4 Q4_K_M models) |
| NAS (NFS mount) | Fine-tuning datasets, training adapters, model archive, dev workspaces |

Keep Ollama's model directory (`~/.ollama/models`) on local NVMe. Loading a 9 GB model over 1GbE takes ~90s; from NVMe it takes ~3s. Only archive models not in active rotation to the NAS. A 1TB NVMe would add headroom for experimentation without the NAS dependency, at ~€15-25 extra — worth it if 10GbE between the two machines is not available.

### Always-On

The CV-AI service is a portfolio piece — visitors won't wait 60s for a cold start. Always-on with models pre-loaded (~0.5s to first token). Ollama drops GPU to low P-state between requests (~30-60W idle vs 280-350W during inference). Annual electricity: ~€180-210.

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
- Self-hosted 5-year TCO (AI server hardware + electricity): ~€1,965-2,015

Breakeven vs Claude-tier: ~2-3 years. Plus: no rate limits, full privacy, portfolio value, fine-tuning platform.
