# Career Path Timeline

Gantt chart visualizing the career roadmap phases. Data sourced from [notes/career-plan.md](../career-plan.md).

> Linked from: [notes/career-plan.md](../career-plan.md), [notes/checklists/career-immediate-actions.md](../checklists/career-immediate-actions.md)

---

## Full Roadmap (April 2026 – March 2027)

```mermaid
gantt
    title Career Upgrade Roadmap
    dateFormat YYYY-MM-DD
    axisFormat %b %Y

    section Foundation
    Advanced React Course           :done, 2026-04-01, 2026-04-15
    RTL + Jest Course               :done, 2026-04-01, 2026-04-15
    Deploy mmastro.dev              :done, 2026-04-10, 2026-04-20
    TypeScript Depth                :active, 2026-04-22, 60d
    Node.js Observability           :2026-05-15, 45d

    section Build & Ship
    Scaffold Projects C+D           :crit, 2026-05-01, 30d
    C+D Phase 1 (JSON comparison)   :crit, 2026-05-15, 45d
    C+D Phase 2 (ranking + RAG)     :2026-07-01, 60d
    Blog Post #1 (auth stack)       :active, 2026-05-01, 30d
    Blog Post #2 (AI architecture)  :2026-07-01, 30d

    section Certifications
    LFD121 (Secure Software)        :2026-05-01, 60d
    AI-200 (Azure AI Developer)     :crit, 2026-06-01, 60d
    NCA-GENL (NVIDIA GenAI)         :2026-09-01, 45d
    AZ-104 (Azure Admin)            :2026-09-15, 60d
    AZ-305 (Solutions Architect)    :2027-01-01, 60d
    Databricks GenAI Engineer       :2027-02-01, 60d
    GCP Professional ML Engineer    :2027-07-01, 60d

    section Visibility
    GitHub Pins + Profile           :2026-05-01, 7d
    CV Rewrite                      :2026-05-15, 14d
    LinkedIn Optimisation           :2026-05-15, 14d
    OSS PR                          :2026-06-15, 30d
    Project A (mmastro.dev polish)  :2026-06-01, 30d

    section Job Hunt
    Target List (20 companies)      :2026-09-01, 14d
    Networking Outreach             :2026-10-01, 30d
    Interview Prep                  :2026-10-01, 60d
    Active Applications             :2026-09-15, 90d

    section Negotiate & Land
    Offer Negotiation               :2026-12-01, 60d
    Accept + Start                  :2027-01-15, 45d
```

---

## Certification Sequence

```mermaid
gantt
    title Certification Timeline
    dateFormat YYYY-MM-DD
    axisFormat %b %Y

    section Free
    LFD121 Secure Software          :2026-05-01, 60d

    section Employer-Sponsored
    AI-200 Azure AI Developer       :crit, 2026-06-01, 60d
    AZ-104 Azure Admin              :2026-09-15, 60d
    AZ-305 Solutions Architect      :2027-01-01, 60d

    section Self-Funded
    NCA-GENL NVIDIA GenAI           :2026-09-01, 45d
    Databricks GenAI Engineer       :2027-02-01, 60d
    GCP Professional ML Engineer    :2027-07-01, 60d
    Terraform or CKAD               :2028-01-01, 60d
```
