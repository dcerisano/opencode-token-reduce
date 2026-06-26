# core — opencode-token-reduce

## Purpose
Drop-in OpenCode configuration template that reduces token usage by pairing Serena (efficient code analysis/editing) with Context7 (live documentation lookup) and strict efficiency rules (AGENTS.md). Not an application — it is a config kit for other projects.

## Source Map
```
opencode.json           # Model, MCP servers, skills paths, commands
AGENTS.md               # Agent rules (tone, tool discipline, workflow)
README.md               # Project docs
.gitignore              # Ignores node_modules, OS/IDE files, Python artifacts
.opencode/
  agent/
    enforce.md           # Default agent — runs mandatory workflow, then enforces AGENTS.md
  skills/
    context7-mcp/       # SKILL.md — Context7 docs via MCP tools (resolve-library-id, query-docs)
    find-docs/          # SKILL.md — Context7 docs via CLI (ctx7 library/docs commands)
    mandatory-workflow/ # SKILL.md — session startup (serena setup, README priming)
.serena/
  project.yml           # Serena project config (empty languages, utf-8 encoding)
  project.local.yml     # Local overrides (gitignored)
```

## Key Invariants
- No application source code. All files are OpenCode configuration.
- The `enforce` agent is the default entry point (set in `opencode.json`).
- AGENTS.md is injected into every prompt via `instructions`.
- Two doc-lookup paths exist: MCP tools (`context7-mcp` skill) and CLI (`find-docs` skill). MCP is the primary path.
- The mandatory workflow skill is loaded once per session at startup.
- No tests, no build system, no package manager dependencies at project root.

## References
- Agent behavior rules: `mem:tech_stack`
- Available commands: `mem:suggested_commands`
- Styling conventions: `mem:conventions`
- Verification steps: `mem:task_completion`
