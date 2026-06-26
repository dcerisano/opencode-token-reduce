# opencode-token-reduce

A drop-in [OpenCode](https://opencode.ai) configuration template that reduces AI token usage by pairing **Serena** (efficient code analysis and editing) with **Context7** (live documentation lookup) under strict efficiency rules.

Clone it, open it with OpenCode, and every session starts with a pre-configured token-reducing environment.

## Quick Start

```bash
git clone https://github.com/dcerisano/opencode-token-reduce.git
cd opencode-token-reduce
opencode
```

To bootstrap a **new project** from this template into a separate directory, run the installer manually:

```bash
./install.sh
```

The `enforce` agent loads automatically, runs the mandatory workflow (Context7 setup, README priming, compliance validation), and enforces all token-reduction rules for the rest of the session.

### Startup sequence (automatic)

1. Read Serena instructions manual
2. Activate the project in Serena
3. **Context7 setup** — Verify `CONTEXT7_API_KEY` is set. If missing, ask you to provide one.
4. Read this README to prime session context
5. Run compliance checklist (no-echo rule enforcement)

---

## Tech Stack

### OpenCode

[OpenCode](https://opencode.ai) is the editor-adjacent terminal application that loads this configuration (opencode.json) and manages the AI agent lifecycle. It handles:

- Model selection and provider configuration (temperature, reasoning effort, thinking mode)
- MCP server orchestration (starting, stopping, routing tool calls)
- Agent definitions with granular permission scopes (`read`, `edit`, `bash`, `ask`, etc.)
- Skill loading — on-demand instruction sets injected via the `skill` tool
- Command templates (`test`, `fix`, `status`) accessible via `/commands`

### Serena

[Serena](https://oraios.github.io/serena/) is an MCP server that provides semantic code analysis and editing tools. It replaces native read/write/grep/glob with higher-level operations:

- Symbol search and declaration lookup instead of full-file reads
- Targeted symbol body replacement instead of regex search-and-replace
- Diagnostics retrieval before suggesting fixes
- Batch reads across multiple files in a single call

This reduces context transmitted per tool call and avoids loading irrelevant code.

### Context7

[Context7](https://context7.com) is an MCP server that fetches current library and framework documentation on demand. It resolves library names to IDs and returns up-to-date API references and code examples. This eliminates reliance on stale training data for library syntax and configuration questions.

---

## Prerequisites

- **OpenCode** — the editor-adjacent app that loads this config. Install from [opencode.ai](https://opencode.ai).
- **uvx** — required by Serena. Installed automatically if missing (`curl -LsSf https://astral.sh/uv/install.sh | sh`).
- **Context7 API key** — set `CONTEXT7_API_KEY` in your environment. Get a free key at [context7.com](https://context7.com).

---

## File Layout

```
opencode-token-reduce/
├── opencode.json              # Main config: model, MCP servers, skills, commands
├── AGENTS.md                  # Agent rules: efficiency, tone, tool discipline
├── RULES_STRICT.md            # Hard behavioral rules (no-echo, commit & push)
├── install.sh                    # Manual installer — dependencies, project bootstrap, GitHub remote
├── .opencode/
│   ├── agent/
│   │   └── enforce.md         # Default agent: mandatory workflow entry point
│   └── skills/
│       ├── context7-mcp/      # Context7 via MCP tools (resolve-library-id, query-docs)
│       └── mandatory-workflow/ # Session startup: Context7 setup, README priming, compliance
├── .serena/
│   ├── project.yml            # Serena project configuration
│   └── memories/              # Persistent agent memories
└── .gitignore
```

