# Prompts

Stored prompts for use with GitHub Copilot Chat. Files here are **never automatically read** — they are only active when directly referenced in a request.

## Convention

- Use the `.prompt.md` extension for all prompts in this folder.
- `.prompt.md` files are a VS Code native format: they appear in the Copilot prompt picker and can be invoked with `#<filename>` in chat. They are never included in context automatically.
- Plain `.md` files also work; the folder-level instruction file enforces read-only treatment for those too.

## How to use a prompt

Reference it directly in a chat message:

```
#my-prompt Use this to ...
```

Or open the prompt picker (`>` → **Chat: Use Prompt**) and select it by name.

## What not to do

- Do not add prompts to `notes/` — that folder is for planning documents.
- Do not add a front-matter `applyTo:` field to prompts — that is for instruction files in `.github/instructions/`, not prompts.
