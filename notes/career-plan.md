# Career Plan

**Subject:** Maximilian Mastrogiacomo
**Last updated:** April 22, 2026
**Target:** AI / automation / platform engineering with a Solution Architect trajectory, remote-first, leveraging 5+ years of production frontend experience as a foundation.

**Charts:** [Career timeline gantt](charts/career-gantt.md)

---

## 1. Pivot summary

The original roadmap (12-month career upgrade, April 2026) optimised for Senior Frontend Remote. That target reflected AlmavivA's assignment history more than personal direction. The actual target:

**AI / automation / platform engineering, Solution Architect trajectory, remote-first.**

Consequences:

- The homelab moves from "portfolio trap" to **primary asset**. A 13-service self-hosted platform with OIDC, loopback binding, CI/CD, and written architecture docs is strong signal for platform/architect roles.
- **Projects C+D** (FastAPI AI service + CV-matching tool) become the single highest-leverage work. They prove the AI/backend identity with reviewable code and dogfood the output during the job hunt.
- The **certification path** reorients around Azure (employer-sponsored, locally relevant) with a self-funded GCP ML branch.
- Frontend remains present but is no longer the headline. The CV should read as "frontend developer who now ships AI and infrastructure."
- Remote is near-non-negotiable. Hybrid tolerable only with strong compensating conditions.

---

## 2. Current state (as of April 22, 2026)

### Portfolio usefulness for new target

| Asset | AI Engineer | Platform / DevOps | Solution Architect | Full-stack-with-AI |
|---|---|---|---|---|
| Homelab (wiki, Docker stacks, CI/CD, OIDC) | 6/10 | 8/10 | 8/10 | 6/10 |
| `mmastro.dev` (React + TS hub) | 4/10 | 4/10 | 5/10 | 7/10 |
| `cv.mmastro.dev` (Hugo + CI/CD) | 3/10 | 4/10 | 4/10 | 3/10 |
| `blog.mmastro.dev` (empty at present) | 1/10 | 1/10 | 1/10 | 1/10 |
| Projects C+D (not started) | 9/10 projected | 6/10 projected | 8/10 projected | 9/10 projected |

### Phase progress (April 22)

| Phase | % | Primary remaining work |
|---|---|---|
| Visibility | ~50% | CV rewrite, GitHub pins, blog post #1, LinkedIn headline/About |
| Skills | ~35% | FastAPI depth, LLM integration, TS advanced patterns in public repo |
| Signal | ~20% | Publish blog #1 + #2 (AI service), one ADR, one OSS PR |
| Job hunt | 0% | Starts month 6 |
| Lead signals | ~35% | Projects C+D as the professional-scale initiative |
| **Weighted** | **~35-40%** | |

---

## 3. Azure Solution Architect path

AlmavivA sponsors AI-200 (guaranteed). Follow-on Azure certs toward Solutions Architect Expert are verbal commitment only.

**Why it is aligned:**

- AI-200 is the correct Azure cert for AI/LLM integration (AZ-204 retires July 31, 2026).
- Pairs with existing AI-900.
- AlmavivA's client base (INPS, Sogei, Agenzia delle Entrate) is Azure/Microsoft-heavy.
- Solution Architect is a plausible medium-term identity; Azure is defensible domestically.
- Certs are free. Declining free market-relevant certs is a mistake.

**Where scepticism is warranted:**

- Sponsorship optimises for AlmavivA's billing, not a remote-international move.
- AZ-305 without hands-on Azure work is paper. Interviewers can expose it in 10 minutes.
- For remote international hiring, AWS SAA is recognised more widely than AZ-305 outside continental Europe.
- Generic GCP Associate Cloud Engineer is low differentiation. GCP Professional ML Engineer genuinely differentiates because GCP's AI/ML tooling (Vertex, Gemini) is strong and fewer candidates hold it.

**Verdict:** take the sponsored path, but refuse to let it consume discretionary project time. Study on company time; defend evenings and weekends for Projects C+D. Certs open doors; shipped AI/automation projects close offers.

### Plan B seed

If AZ-104/AZ-305 sponsorship stalls, or if project assignments remain frontend-only with no architecture exposure: treat AI-200 as standalone, bring GCP Professional ML Engineer forward to 2027 H1, consider AWS SAA earlier as remote-international broadener. Revisit after AI-200 passes and after three months of C+D work clarify direction.

---

## 4. Certification roadmap

Ordering: free > employer-sponsored > self-funded. Within each band, most aligned with target first.

| When | Cert | Funding | Purpose |
|---|---|---|---|
| 2026 Q2-Q3 | LFD121 -- Developing Secure Software | free | Secure-coding signal |
| 2026 Q2-Q3 | AI-200 -- Azure AI Cloud Developer Associate | employer | Core AI direction; pairs with AI-900 |
| 2026 Q3-Q4 | AZ-104 -- Azure Administrator | employer | Prereq for AZ-305; broad-use Azure foundation |
| 2026 Q3-Q4 | NCA-GENL -- NVIDIA Certified Associate: Generative AI and LLMs | self-fund (~$135) | Vendor-neutral LLM/RAG/prompt-engineering signal; recognised beyond continental Europe |
| 2027 H1 | AZ-305 -- Solutions Architect Expert | employer | SA title, only if Azure hands-on practice is real |
| 2027 H1 | Databricks Generative AI Engineer Associate | self-fund | Alternative/complement to AZ-305; pick if Azure practice stalls; overlaps with C+D RAG work |
| 2027 H2 | GCP Professional ML Engineer | self-fund | Differentiated niche; AI/ML passion; strong international signal |
| 2028 | Terraform Associate or CKAD | self-fund | Automation/infra depth |
| Optional 2028+ | AWS SAA | self-fund | Only if targeting US/UK remote markets |

Full step-by-step tracking: [notes/checklists/career-certifications.md](checklists/career-certifications.md)

### Dropped

- **AZ-204** -- retires July 31 2026
- **GCP Associate Cloud Engineer** -- weak signal for this target
- **GitHub Actions cert** -- Gitea Actions pipelines in public wiki demonstrate this better
- **AWS Developer Associate** -- marginal on top of SAA
- **PMP / PRINCE2 / part-time bachelor's** -- no technical-role signal
- **Vendor framework certs** -- better demonstrated by shipping
- **CCNA1** (2019) -- archived, removed from active CV
- **Applied Robotics Course** (2015) -- archived, removed from active CV

---

## 5. Roadmap phases

### Phase 1 -- Foundation (Months 1-3, Apr-Jun 2026)

- ~~Advanced React course (Schmedtmann)~~ done
- ~~React Testing Library + Jest course~~ done
- ~~Deploy mmastro.dev React site~~ done
- TypeScript depth: conditional types, mapped types, template literals, strict mode, zero-any
- Node.js performance and observability: event loop, streams, pino/OpenTelemetry
- Italy tax/legal setup (deferred until concrete offer appears)

### Phase 2 -- Build & Ship (Months 2-5, May-Aug 2026)

- **Projects C+D** -- FastAPI codebase (`/api/agents`, `/api/cv-match`), PostgreSQL, SQLAlchemy, one working LLM-backed endpoint
- Phase 1 scope: single job post comparison -> JSON output
- System design study: micro-frontends, state at scale, CDN/caching, API design
- Write one technical post per month (600-1200 words)

### Phase 3 -- Visibility (Months 4-8, Jul-Nov 2026)

- GitHub polish: pin 3-4 repos (AI project, React/TS showcase, OSS contribution)
- Open-source contribution: test coverage PRs to established React libraries
- LinkedIn optimisation: headline, About, Featured section
- English-language CV rewrite with new positioning

### Phase 4 -- Job Search (Months 6-9, Sep-Dec 2026)

- Target companies: Bending Spoons, Satispay, international remote (Otta, Wellfound, LinkedIn remote filter)
- Interview prep: system design, STAR behavioural, coding (LeetCode easy/medium)
- Salary benchmarking: Levels.fyi, Talent.io, LinkedIn Salary

### Phase 5 -- Negotiate & Land (Months 8-12, Nov 2026-Mar 2027)

- Salary negotiation: anchor at top of range, total comp evaluation
- Promotion conversation at AlmavivA if staying: frame as scope expansion, bring market data
- Accept offer at target comp with remote flexibility

---

## 6. Priority actions

Step-by-step checklist: [notes/checklists/career-immediate-actions.md](checklists/career-immediate-actions.md)

The checklist covers: GitHub pins, wiki homepage fix, CV rewrite, blog post #1, ADR, Projects C+D scaffold, AI-200 registration, LFD121 enrolment, and LinkedIn updates.

---

## 7. Risks

- **Cert study cannibalising project time.** If AI-200 prep crowds out C+D, slow the certs.
- **AlmavivA assignment drift.** If next project is pure-frontend with no Azure/architecture exposure, AZ-305 path loses practice layer.
- **Scope creep on Projects C+D.** Ship Phase 1 (single job post -> JSON comparison) in four weeks or cut scope.
- **Homelab fatigue.** Every hour on Caddy config is an hour not on C+D.

---

## 8. Success criteria by end of 2026

- AI-200 passed, LFD121 passed
- Projects C+D live: public FastAPI repo, working LLM comparison endpoint, React form on mmastro.dev, at least one tailored CV generated
- Two published blog posts (auth stack, AI service architecture)
- One OSS PR merged
- CV rewritten with positioning, Projects, and impact bullets
- GitHub profile surfaces AI/backend work first, homelab second
- Active recruiter inbound on LinkedIn (2-3/week baseline)
- AZ-104 either passed or scheduled
- Decision made on AZ-305 vs GCP-first pivot based on concrete evidence

---

## 9. System design topics (Senior -> Lead)

### Architecture
- Micro-frontends: Module Federation, when to split vs not, cost of over-engineering
- Design systems: component libraries, API design, versioning, documentation
- State management at scale: Redux vs Zustand/Context, server-state vs client-state (React Query)
- Monorepo structure: Nx or Turborepo, shared code without coupling

### Performance
- Virtualisation: react-window, react-virtual
- Memoisation: useMemo/useCallback tradeoffs, React DevTools profiling
- Bundle splitting: route-level code splitting, dynamic imports
- CDN + HTTP caching: Cache-Control, stale-while-revalidate, Edge caching

### Reliability
- Error boundaries: granular placement, meaningful fallbacks, logging context
- Web Vitals: LCP, CLS, INP -- measurement and regression fixes
- Testing pyramid: unit (RTL) -> integration -> E2E (Playwright)
- Error tracking: Sentry integration, source maps, release tagging

### Backend fluency
- REST design: resource naming, idempotency, versioning, pagination
- GraphQL tradeoffs: flexibility vs complexity, N+1, DataLoader
- Auth patterns: OAuth2/OIDC flows, JWT storage, token refresh
- WebSockets vs SSE: selection criteria, reconnection handling

### Lead skills
- ADRs (Architecture Decision Records)
- Code reviews that teach (explain the why, not just what to change)
- Technical communication (tradeoffs for PMs in time/risk/user-impact terms)
- RFC process (propose in writing before implementing)
- Mentoring (pairing, annotated PR reviews, unblocking without doing)

---

## 10. Italy-specific considerations

### Market benchmarks (2025-2026)

| Role | Italy on-site | Remote EU/UK/US |
|---|---|---|
| Mid Frontend (3-5 yrs) | 35-50k | 55-75k |
| Senior Frontend (5-8 yrs) | 45-65k | 75-110k |
| Full-stack Senior (React + Python) | 50-70k | 80-120k |
| Tech Lead / Engineering Lead | 65-85k | 100-140k+ |

### Work arrangements

**Partita IVA (freelance):** invoice foreign company, regime forfettario (15% flat, 5% first 5 years if new). Need: partita IVA + INPS + invoicing software.

**Employer of Record (EOR):** Deel, Remote.com, Omnipresent act as legal employer in Italy. Less admin, slightly lower take-home due to EOR fees.

Decision deferred until a concrete offer is in hand.
