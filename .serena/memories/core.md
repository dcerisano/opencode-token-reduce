# Core

This is a **configuration template** — not a codebase. It has no application source code. It provides a drop-in OpenCode configuration that pairs Serena (semantic code analysis/editing) with Context7 (live docs) to reduce LLM token usage.

## Structure

- `opencode.json` — MCP servers (serena, context7), agent settings, permissions, LSP toggle
- `.opencode/commands/` — `/migrate` command: copies template into an existing project
- `.opencode/skills/memory-management/` — skill for updating Serena memories after changes
- `.serena/` — Serena project config (`project.yml`), memories directory, cache
- `.githooks/pre-push` — auto-stages `.serena/memories/*.md` before push

## Project purpose

Provides pre-configured `opencode.json`, `.opencode/`, `.serena/` files that can be:
1. Used as a GitHub template (`gh repo create --template`) to bootstrap new projects
2. Migrated into existing projects via the `/migrate` command

## Invariants

- No application code lives here; only OpenCode/Serena configuration
- The template is model-agnostic — works with any LLM backend OpenCode supports
- Serena operates via `uvx` (Python 3.13), launched as local MCP server
- Context7 requires `CONTEXT7_API_KEY` env var

For tech stack details, see `mem:tech_stack`.
For conventions, see `mem:conventions`.
For project-specific commands, see `mem:suggested_commands`.