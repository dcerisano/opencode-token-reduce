# core — opencode-token-reduce

## Purpose
Drop-in OpenCode configuration template that reduces token usage by pairing Serena (efficient code analysis/editing) with Context7 (live documentation lookup) and strict efficiency rules (AGENTS.md). Not an application — it is a config kit for other projects.

## Source Map
```
opencode.json           # Model, MCP servers, agent definition, permissions, commands
AGENTS.md               # All rules: startup procedure, tool discipline, Context7 docs, tone
README.md               # Project docs
.gitignore              # Ignores node_modules, OS/IDE files, Python artifacts
.opencode/
  skills/
    context7-mcp/       # SKILL.md — Context7 docs via MCP tools (resolve-library-id, query-docs)
.serena/
  project.yml           # Serena project config (no language server, utf-8)
```

## Key Invariants
- No application source code. All files are OpenCode configuration.
- No custom agent — uses OpenCode built-in defaults.
- AGENTS.md is the single source of truth — injected into every prompt via `instructions`.
- Context7 MCP is the sole documentation lookup path.
- No tests, no build system, no package manager dependencies at project root.
- AGENTS.md rules take precedence: no tool-output echo, serena tools mandatory, no first-person, no preamble, batch reads preferred.

## OpenCode Configuration
- **Model**: `deepseek-v4-flash-free` via `opencode` provider — `temperature: 0`, `top_p: 1`, `reasoning_effort: low`, `thinking: enabled`
- **MCP servers**: `serena` (local, `uvx`), `context7` (remote, requires `CONTEXT7_API_KEY`)
- **Skills paths**: `.opencode/skills` (loaded on demand via `skill` tool)
- **Commands**: `test`, `fix`, `status` templates for downstream projects
- **Language backend**: LSP, but `languages: []` — no language server started (config-only repo)
- **Serena encoding**: utf-8

## File Conventions
- `opencode.json` — JSON with `$schema`, not JSONC (no comments).
- Skill files — YAML frontmatter (`---` delimited) + Markdown body. `name` and `description` in frontmatter required.
- Agent files — YAML frontmatter with `description`, `mode: primary`, `permission` block, then body.
- Memory files — Markdown with `# title` heading, dense terse bullets, `mem:` backtick references.
- Skills are loaded on demand via the `skill` tool, not baked into prompts.

## External Dependencies
- `uvx` — required for Serena (installed by `install.sh` via `curl -LsSf https://astral.sh/uv/install.sh | sh`)
- `CONTEXT7_API_KEY` — required for Context7 MCP (free at context7.com)

## References
- Available commands: `mem:suggested_commands`
- Verification steps: `mem:task_completion`
