# opencode-token-reduce

- **Purpose**: Drop-in OpenCode configuration template that reduces AI token usage by pairing Serena (semantic code analysis/editing) with Context7 (live documentation lookup) under strict efficiency rules.
- **Type**: Configuration-only template repo (no application code). Use as GitHub template for new projects.
- **Key invariants**:
  - Native `edit`/`write` tools are **denied** (`opencode.json` permission: `edit: deny, write: deny`)
  - All code modifications must use Serena symbolic tools (`serena_replace_symbol_body`, `serena_replace_content`, `serena_insert_after_symbol`, `serena_insert_before_symbol`)
  - Mandatory startup sequence: `serena_initial_instructions` + `context7_query-docs` (library `/websites/context7`, query `initialization`), then `serena_list_memories` — if empty, load `memory-management` skill and delegate to subagent
  - Memory references use `mem:` prefix (e.g. `mem:core`)
  - "No-echo rule": never repeat/paraphrase/summarize tool output
  - Answer concisely (<4 lines) unless user asks for detail
- **Structure**: see `mem:tech_stack` for file layout
