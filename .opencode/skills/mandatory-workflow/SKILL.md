---
name: mandatory-workflow
description: Session startup procedure. Load this skill immediately after activating the project. Governs serena setup, README priming, and doc-skill loading.
---

# Mandatory Workflow

## Procedure

1. `serena_initial_instructions` — read Serena manual (call once per session)
2. `serena_activate_project` — activate current project
3. **Ensure required dependencies are available.**
   - If `uvx` is not on `PATH`, install it automatically: run `curl -LsSf https://astral.sh/uv/install.sh | sh` (works on Linux/macOS). If that fails, fall back to `brew install uv` on macOS or `pip install --user uv` on Linux.
   - If `CONTEXT7_API_KEY` is unset, ask the user to provide one (register at context7.com for a free key) and set it in the environment. Do not proceed until the user confirms it is set.
4. **Use serena tools for all code operations** — native tools are fallback only. See AGENTS.md for the full tool mapping.
5. Load the `context7-mcp` skill when library/syntax questions arise. Scope to unfamiliar or fast-moving technologies only (skip stable stdlib APIs like Python/Java builtins).
6. Read README.md via `serena_read_file` (once per session).

7. **Compliance check** — Never repeat, paraphrase, or summarize tool output. Let results speak for themselves. Say nothing when there is nothing to add.

Steps 4-7 may be skipped for non-coding questions.
