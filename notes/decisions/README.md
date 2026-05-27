# Decision Log

One file per date: `YYYY-MM-DD.md`. Each entry records a discrete decision or significant thought captured during a session.

## Entry format

```
## HH:MM — <short title>

**Files:** `path/to/file`, `path/to/other`  
**Decision:** One or two sentences. What was decided and why, or what the key insight was.
```

Rules:
- Timestamp is local time (24 h), no seconds.
- "Files" lists only files actually created or modified; omit if none.
- "Decision" must be short enough to scan at a glance but specific enough to reconstruct context.
- AI agents must append an entry to the current date's file after every task that modifies files or records a decision. See copilot-instructions.md § Decision Log.
