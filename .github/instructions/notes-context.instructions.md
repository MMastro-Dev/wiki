---
description: 'Use when working with planning notes, hardware specs, deployment checklists, shopping lists, or any in-progress thinking not yet promoted to the wiki'
applyTo: 'notes/**'
---

# Notes Context

`notes/` holds planning documents, decisions, and in-progress thinking. It is **not** user-facing documentation — that lives in `src/` (the wiki). When a plan becomes implemented reality, promote the relevant content to the wiki and keep the note as historical context.

## File Index

- `README.md` — orientation and index for AI agents
- `infrastructure.md` — current homelab state, 3-server architecture rationale, operator context
- `ai-server.md` — AI server hardware spec, GPU justification, model strategy, thermal mod plan
- `thin-client-and-nas.md` — rationale for the 3-server split (ingress / storage / GPU)
- `deployment-checklist.md` — phase-by-phase tasks and purchases ledger
- `shopping-list.md` — full bill of materials across all machines
- `cv-ai-benchmark.md` — CV/AI experiments and analysis
- `career-plan.md` — career plan: target role (AI/platform/architect), phases, certs, priority actions, success criteria
- `career-changelog.md` — evolution log tracking changes between career roadmap versions
- `wiki-guide.md` — map of the `src/` wiki structure
- `decisions/` — append-only decision log (see `decisions/README.md`)
- `checklists/` — step-by-step actionable checklists for plans (see planner agent for format)
- `charts/` — Mermaid diagrams (pie, gantt, flowchart) for visual planning; merged into wiki pages by the Wiki Editor during promotion

> **Not part of `notes/`:** `prompts/` (workspace root) is a separate stored-prompt library. Never scan or auto-read it as planning context.

## Conventions

- Notes can be exploratory, opinionated, and incomplete
- Wiki pages must be settled and accurate
- When in doubt about whether content belongs in notes or wiki: if it describes *what is*, it's wiki; if it describes *what we're considering*, it's notes
