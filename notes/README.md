# Notes — mmastro.dev Homelab

**Start here if you're an AI agent.** Read this file first for orientation.

This directory contains planning documents for the homelab expansion. The wiki itself (authoritative service documentation, architecture, runbooks) lives in `src/`.

## File Index

| File | Contents |
|---|---|
| [infrastructure.md](infrastructure.md) | Current state, 3-server architecture, hardware inventory, budget, open decisions |
| [thin-client-and-nas.md](thin-client-and-nas.md) | Plan for Wyse 5070 as thin client + dedicated mini-ITX NAS build |
| [ai-server.md](ai-server.md) | AI server hardware, GPU choice, model strategy, VRAM budget, fine-tuning analysis |
| [deployment-checklist.md](deployment-checklist.md) | Step-by-step deployment tasks across all phases |
| [wiki-guide.md](wiki-guide.md) | Map of the wiki in `src/` — what each file covers, how services are documented |
| [cv-ai-benchmark.md](cv-ai-benchmark.md) | Reference output for CV-AI agent quality benchmarking |
| [career-plan.md](career-plan.md) | Career plan: target role, phases, certifications, priority actions, success criteria |
| [career-changelog.md](career-changelog.md) | Evolution log tracking changes between career roadmap versions |

## Folders

| Folder | Contents |
|---|---|
| [decisions/](decisions/) | Append-only decision log, one file per date |
| [checklists/](checklists/) | Step-by-step actionable checklists for plans in progress |
| [charts/](charts/) | Mermaid diagrams (pie, gantt, flowchart) for visual planning; merged into wiki by the Wiki Editor |

## How Notes Relate to the Wiki

- `notes/` = plans, decisions, rationale for changes not yet implemented
- `src/` = authoritative documentation of the live infrastructure
- When a plan in `notes/` is fully deployed, update the relevant `src/` files and remove the plan

## Key Constraints (from `.github/copilot-instructions.md`)

1. Never use caddy-security plugin. Auth is `forward_auth` → oauth2-proxy only.
2. Caddy admin API is disabled (`admin off`).
3. All container ports bind to `127.0.0.1` (exceptions: DNS port 53, Gitea SSH 222).
4. `login.mmastro.dev` and `auth.mmastro.dev` must never have an auth wrapper.
5. No secrets in code or docs.
