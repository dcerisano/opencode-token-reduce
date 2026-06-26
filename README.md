# opencode-token-reduce

A drop-in OpenCode configuration template that reduces token usage by pairing **Serena** (efficient code analysis/editing) with **Context7** (live documentation lookup) and strict efficiency rules.

Clone it, open it with OpenCode, and get a pre-configured environment that uses fewer tokens on every session.

## What It Does

| Feature | Token Savings |
|---------|---------------|
| `reasoning_effort: "low"` | Reduces chain-of-thought length |
| `temperature: 0` | Deterministic output, no wasted exploration tokens |
| Flash-tier model (`deepseek-v4-flash-free`) | Cheaper per-token inference |
| Serena MCP server | Semantic code ops instead of full-file reads/writes |
| Context7 MCP server | Fetches current docs instead of relying on stale training data |
| `AGENTS.md` rules | No repeating tool output, no preamble, no first-person, targeted reads |
| Skills system | On-demand instruction loading (not every prompt) |

## Quick Start

```bash
git clone <repo-url> opencode-token-reduce
cd opencode-token-reduce
opencode
```

That's it. The `enforce` agent loads automatically, runs the mandatory workflow (Serena setup, README priming), and enforces all token-reduction rules for the rest of the session.

## Prerequisites

- **OpenCode** — the editor/terminal app that loads this config
- **uvx** — for Serena (`pip install uv` or `brew install uv`)
- **Context7 API key** — set `CONTEXT7_API_KEY` in your environment (free at [context7.com](https://context7.com))

## File Layout

```
opencode-token-reduce/
  opencode.json           # Main config: model, MCP servers, skills, commands
  AGENTS.md               # Agent rules: efficiency, tone, tool discipline
  .opencode/
    agent/
      enforce.md          # Default agent: mandatory workflow entry point
    skills/
      context7-mcp/       # Context7 via MCP tools (resolve-library-id, query-docs)
      find-docs/          # Context7 via CLI (ctx7 library/docs commands)
      mandatory-workflow/ # Session startup: serena setup + README priming
  .gitignore
```

## Customizing for Your Project

Drop this repo's files into an existing project to add token-reducing behavior:

```bash
cp -r opencode-token-reduce/.opencode opencode-token-reduce/opencode.json opencode-token-reduce/AGENTS.md your-project/
cd your-project
opencode
```

Or edit `opencode.json` to point `instructions` at your own rules file instead of `AGENTS.md`.

## How the Token Reduction Works

1. **`AGENTS.md`** is injected into every prompt — it commands no repeated tool output, no echo of results, no first-person chatter, and batch reads over single-file reads.

2. **Serena** replaces native read/write/grep/glob with semantic operations (symbol search, declaration lookup, diagnostics) that transmit less context per call.

3. **Context7** replaces stale training-data answers with live documentation — one focused query instead of generating speculative examples.

4. **Low reasoning effort** and **temperature 0** eliminate wasteful chain-of-thought branching.

5. **Skills** are loaded on demand via the `skill` tool, not baked into every prompt.
