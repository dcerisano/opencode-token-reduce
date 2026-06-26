---
name: mandatory-workflow
description: Session startup procedure. Load this skill immediately after activating the project. Governs serena setup, README priming, and doc-skill loading.
---

# Mandatory Workflow

## Procedure

1. `serena_initial_instructions` — read Serena manual (call once per session)
2. `serena_activate_project` — activate current project
3. **Context7 setup** — Verify `CONTEXT7_API_KEY` is set. If missing, prompt the user to set it; do not proceed until confirmed. Context7 is the **mandatory documentation source** for this project, replacing `webfetch` as the primary lookup tool.
4. **Use serena tools for all code operations** — native tools are fallback only. See AGENTS.md for the full tool mapping.
5. **Context7 is mandatory for all documentation lookups.** Before using `webfetch` for any library, framework, API, SDK, tool, or service, use Context7 first (`resolve-library-id` → `query-docs`). If Context7 fails or has no relevant results, only then fall back to `webfetch`.
6. Read README.md via `serena_read_file` (once per session).
7. **Compliance check** — Never repeat, paraphrase, or summarize tool output. Let results speak for themselves. Say nothing when there is nothing to add.

Steps 5-7 may be skipped for non-coding questions.
