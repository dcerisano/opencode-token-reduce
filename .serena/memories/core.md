# opencode-token-reduce — Core

A drop-in [OpenCode](https://opencode.ai) configuration template that reduces AI token usage by pairing Serena (semantic code analysis/editing) with Context7 (live documentation lookup).

## Source Map

```
opencode-token-reduce/
├── opencode.json       # Main config: agent, MCP servers (Serena + Context7), LSP, command templates
├── AGENTS.md           # Agent rules: startup sequence, no-echo, efficiency, tone, commit discipline
├── .serena/project.yml # Serena project config: languages = auto-installed LSPs only
└── .gitignore          # Ignores .opencode/node_modules/, .serena/cache, OS/IDE/Python artifacts
```

## Invariants

- **Template, not app** — no application source code. All files are OpenCode configuration.
- **Startup mandatory** — every session begins with `serena_initial_instructions` + `context7_query-docs /websites/context7 initialization`.
- **No-echo rule** — tool output is never repeated, paraphrased, or summarized in agent responses.
- **No first person, no emoji, no casual language** — tone rule enforced via AGENTS.md.
- **Editing discipline** — >1 file edit requires upfront 1-3 sentence summary. Never edit generated files. Never run git status/diff/log before committing.
- **Git discipline** — stage all (`git add -A`), commit, push in one sequence. No intermediate inspection.

## References

- `mem:tech_stack` — OpenCode, Serena, Context7, uvx
- `mem:suggested_commands` — opencode commands: test, fix, status
- `mem:conventions` — code style and AGENTS.md conventions
- `mem:task_completion` — verification commands
