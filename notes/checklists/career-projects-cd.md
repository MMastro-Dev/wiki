# Career — Projects C+D (FastAPI AI Service + CV Matching)

**Goal:** Ship a working AI-backed service that proves the AI/backend identity with reviewable code.
**Created:** 2026-05-28
**Status:** not-started

---

## Steps

### FastAPI backend (Project C core)

- [ ] Scaffold FastAPI service — `src/api/agents` and `src/api/cv-match`, PostgreSQL + SQLAlchemy + Alembic migrations
- [ ] Add background task structure (Celery or FastAPI BackgroundTasks)
- [ ] Add a typed API client from the frontend (discriminated unions for response states)

### AI / LLM integration

- [ ] Integrate Anthropic or OpenAI API — one working LLM-backed endpoint
- [ ] **Phase 1 gate: single job post + CV → JSON comparison output** — ship this before adding anything else
- [ ] Build RAG pipeline or structured prompt workflow (Phase 2+)
- [ ] Phase 2: ranking across multiple job posts

### CV matching feature (Project D)

- [ ] Build a React form on `mmastro.dev` to submit a job posting
- [ ] Wire to FastAPI `/cv-match` endpoint (async polling, loading/error states)
- [ ] Generate a tailored CV committed as a Hugo markdown file to Gitea
- [ ] Trigger Gitea CI/CD to publish result at `cv.mmastro.dev/[identifier]`

### Writing (tied to project milestones)

- [ ] Publish blog post #2 — AI service architecture (after Phase 1 gate is live)

---

## Notes

- **Primary focus for the entire roadmap.** Nothing else moves the AI/automation identity as fast.
- Phase 1 scope: single job post → JSON output. Ship in four weeks or cut scope further.
- Blog post #2 comes only after Phase 1 ships — writing about what you've actually built.
- See [notes/career-plan.md](../career-plan.md) for full context on why this is #1 priority.
