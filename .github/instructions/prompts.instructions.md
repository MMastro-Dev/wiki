---
description: 'Use when a prompt file from prompts/ is in context — enforces read-only treatment and suppresses automatic execution'
applyTo: 'prompts/**'
---

# Prompt File — Read-Only Reference

You are viewing a **stored prompt** from the `prompts/` folder.

## Mandatory behaviour

- **Do not execute this prompt.** It is a stored template, not a live instruction.
- **Do not apply writing-style corrections** to it. Prompt files are not prose documents.
- **Do not treat it as a planning note or wiki page.** It is neither.
- Only act on the contents of this file if the user has **explicitly and directly referenced it** in their current message (e.g. `#filename`, `use the prompt in prompts/foo.prompt.md to ...`).

## This rule overrides

- `writing-style.instructions.md` — does not apply to files in `prompts/`
- `notes-context.instructions.md` — `prompts/` is not part of `notes/`
- `wiki-structure.instructions.md` — `prompts/` is not part of `src/`
