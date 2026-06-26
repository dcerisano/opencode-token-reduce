---
name: mandatory-workflow
description: Session startup procedure. Load this skill immediately after activating the project. Governs serena setup, README priming, and doc-skill loading.
---

# Mandatory Workflow

## Procedure

1. `serena_initial_instructions` — read Serena manual (call once per session)
2. `serena_activate_project` — activate current project
3. **Use serena tools for all code operations** — native tools are fallback only. See AGENTS.md for the full tool mapping.
4. Load the `context7-mcp` skill when library/syntax questions arise. Scope to unfamiliar or fast-moving technologies only (skip stable stdlib APIs like Python/Java builtins).
5. Read README.md via `serena_read_file` (once per session).

Steps 3-5 may be skipped for non-coding questions.
