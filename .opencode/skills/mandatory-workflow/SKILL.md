---
name: mandatory-workflow
description: Session startup procedure. Load this skill immediately after activating the project. Governs serena setup, README priming, and doc-skill loading.
---

# Mandatory Workflow

## Procedure

1. `serena_initial_instructions` — read Serena manual (call once per session)
2. `serena_activate_project` — activate current project
3. **Run the installer** — Ask the user if they want to run `install.sh`. This installs any missing system dependencies (git, curl, uvx), checks `CONTEXT7_API_KEY`, and optionally creates a new OpenCode project from this template.
   - If the user agrees, run `install.sh` with bash. It is interactive — the user will respond to prompts directly.
   - If the user declines, check dependencies manually: ensure `uvx` is on PATH (auto-install if missing) and `CONTEXT7_API_KEY` is set (ask the user to provide one if not, do not proceed until confirmed).
4. **Use serena tools for all code operations** — native tools are fallback only. See AGENTS.md for the full tool mapping.
5. **Context7 is mandatory for all documentation lookups.** Before using `webfetch` for any library, framework, API, SDK, tool, or service, use Context7 first (`resolve-library-id` → `query-docs`). If Context7 fails or has no relevant results, only then fall back to `webfetch`.
6. Read README.md via `serena_read_file` (once per session).

7. **Compliance check** — Never repeat, paraphrase, or summarize tool output. Let results speak for themselves. Say nothing when there is nothing to add.

Steps 4-7 may be skipped for non-coding questions.
