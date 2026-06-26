---
name: mandatory-workflow
description: Session startup procedure. Load this skill immediately after activating the project. Governs serena setup, README priming, and doc-skill loading.
---

# Mandatory Workflow

## Procedure

1. `serena_initial_instructions` — read Serena manual (call once per session)
2. `serena_activate_project` — activate current project
3. **Context7 setup** — Verify `CONTEXT7_API_KEY` is set. If missing, prompt the user to set it; do not proceed until confirmed. Context7 is the **mandatory documentation source** for this project, replacing `webfetch` as the primary lookup tool.
4. **Git remote setup** — Check if a git remote (`origin`) exists. If not, prompt the user to create a GitHub remote:
   - Check if `gh` (GitHub CLI) is installed. If missing, guide install via `gh` docs or system package manager.
   - If `gh` is installed but not authenticated, run `gh auth login` interactively.
   - Once authenticated, prompt for a repository name (`owner/repo`) and visibility (`public`/`private`), then run `gh repo create <name> --<visibility> --push --source=.`
   - If `gh` unavailable or user declines, fall back to manual instructions: `git remote add origin <url>` then `git push -u origin main`.
5. **Use serena tools for all code operations** — native tools are fallback only. See AGENTS.md for the full tool mapping.
6. **Context7 is mandatory for all documentation lookups.** Before using `webfetch` for any library, framework, API, SDK, tool, or service, use Context7 first (`resolve-library-id` → `query-docs`). If Context7 fails or has no relevant results, only then fall back to `webfetch`.
7. Read README.md via `serena_read_file` (once per session).
8. **Compliance check** — Never repeat, paraphrase, or summarize tool output. Let results speak for themselves. Say nothing when there is nothing to add.

Steps 6-9 may be skipped for non-coding questions.
