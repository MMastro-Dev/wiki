# CV-AI Fine-Tuning

**Goal:** Fine-tune the Qwen 14B model on CV+JD examples to improve CV analysis quality above the baseline.
**Created:** 2026-05-27
**Status:** not-started

> Optional. Only begin if Phase 4 benchmark (O4.1) shows the untuned 14B model falls short of the quality bar in [notes/cv-ai-benchmark.md](../cv-ai-benchmark.md).

---

## Steps

- [ ] **F5.1** Build training dataset: 50–100 CV+JD pairs with gold-standard analyses.
- [ ] **F5.2** Format as JSONL (system/user/assistant turns matching the CV-AI prompt template).
- [ ] **F5.3** Install Unsloth on AI server.
- [ ] **F5.4** QLoRA fine-tune: rank 16–32, ~2–4 hours on 3090. Export GGUF at Q4_K_M.
- [ ] **F5.5** Load in Ollama. Re-run O4.1 benchmark with fine-tuned model.
- [ ] **F5.6** If quality passes: deploy as production CV-AI model. Keep base 14B as fallback.
- [ ] **F5.7** *(Optional)* If VRAM pressure is a concern: distill to 7B using the fine-tuned 14B's outputs as training data for a 7B LoRA. Re-benchmark.

---

## Notes

- Do not start this until the Phase 4 benchmark result (O4.1) is known.
- F5.7 is only worth attempting if concurrent model loading causes VRAM pressure in practice.
- See [notes/cv-ai-benchmark.md](../cv-ai-benchmark.md) for reference outputs and quality criteria.
