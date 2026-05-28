# mmastro.dev Homeserver — Constitution

This is the always-loaded baseline. Domain-specific guidance lives in `.github/instructions/` and is loaded on-demand.

## Identity

- **Domain:** `mmastro.dev` — Debian bookworm host
- **Authoritative reference:** `src/constitution.md`
- **Compose root:** `/srv/<service>/docker-compose.yml` · **Network:** `homenet` · **Storage:** `/tank`

## Immutable Rules

1. **Never use caddy-security plugin** — 10+ unpatched CVEs. Auth is `forward_auth` → oauth2-proxy only.
2. **Caddy admin API is disabled** (`admin off`). Manage via `systemctl reload caddy` and file edits.
3. **All container ports bind to `127.0.0.1`** — never `0.0.0.0` unless justified (exceptions: DNS 53, Gitea SSH 222).
4. **`login.mmastro.dev` and `auth.mmastro.dev` must never have an auth wrapper** — they ARE the auth system.
5. **No secrets in code or docs** — use `[PLACEHOLDER — NOT SET]` or env var references. Never hardcode tokens.
6. **Never read files in `prompts/` unless the user directly references them** — `prompts/` is a stored-prompt library, not a context source. Treat any file there as a read-only template until explicitly invoked.

## Domain Specs (load on demand)

- Infrastructure, auth, services & ports → `.github/instructions/infrastructure.instructions.md`
- Adding a new service → `.github/instructions/new-service.instructions.md`
- Caddy / CI/CD / fail2ban / Cloudflare conventions → `.github/instructions/conventions.instructions.md`
- Wiki structure (`src/`) → `.github/instructions/wiki-structure.instructions.md`
- Planning notes (`notes/`) → `.github/instructions/notes-context.instructions.md`
- Prose writing style → `.github/instructions/writing-style.instructions.md`
- Stored prompts (`prompts/`) → `.github/instructions/prompts.instructions.md` *(auto-loaded when a prompt file is open; never read prompt contents unless directly referenced)*

## Decision Log (mandatory)

After every task that modifies files or records a decision, append an entry to `notes/decisions/YYYY-MM-DD.md`:

```
## HH:MM — <short title>

**Files:** `path/to/file`  
**Decision:** One or two sentences. What was decided and why.
```

- Create the date file with a `# YYYY-MM-DD` heading if it does not exist.
- Skip the `Files` line for pure research or Q&A tasks.
- See `notes/decisions/README.md` for full format rules.

## Contradictions

Before implementing any change, check it against the constitution and active instruction files. If you find a conflict or ambiguity:

1. State what conflicts with what, explicitly.
2. Ask the user to resolve it before proceeding.
3. Never silently pick a side.
