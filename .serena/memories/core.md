# opencode-token-reduce

GitHub template for a drop-in OpenCode config that reduces AI token usage 50-70%.

## Purpose
Pre-configure two MCP servers — **Serena** (semantic code analysis/editing) and **Context7** (live docs lookup) — under strict efficiency rules, replacing expensive full-file read/write/grep with targeted symbol-level operations. Model-agnostic; works with any LLM backend OpenCode supports.

## Key invariants
- No application source code lives here — this is purely a tooling/config template.
- Native `edit`/`write` tools are **denied** in `opencode.json:permission`. All code modifications use Serena's symbol-level tools (`replace_symbol_body`, `insert_after_symbol`, `replace_content`, `insert_before_symbol`).
- `AGENTS.md` enforces a NO-ECHO rule (never repeat tool output), SUBAGENT RULE (all tool calls delegated to `task` subagents), and a STARTUP sequence that must run on every first message.
- `memory-management` skill governs creation/update/staleness-checking of Serena memories.

## Structure
```
opencode-token-reduce/
├── opencode.json          # agent config, MCP servers, edit/write deny, LSP on
├── AGENTS.md              # agent rules (overrides all)
├── .gitignore
├── .opencode/             # OpenCode plugins, commands, skills
│   ├── package.json       # depends on @opencode-ai/plugin v1.17.11
│   ├── commands/
│   │   └── migrate.md     # /migrate command — clones template into existing project
│   └── skills/
│       └── memory-management/SKILL.md
└── .serena/               # Serena config + memories
    ├── .gitignore
    ├── project.yml        # languages (python, typescript, java, cpp, bash, json), utf-8, LSP backend
    └── memories/
```

## References
- `mem:tech_stack` — languages, dependencies, tooling
- `mem:conventions` — code & agent conventions
- `mem:suggested_commands` — build/test/lint commands (N/A for this template)
- `mem:migration` — `/migrate` command workflow
