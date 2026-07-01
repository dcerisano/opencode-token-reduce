# Conventions

## Config Style
- JSON configs use `$schema` references for schema validation
- DCP: percentage-based context limits, protected tools for `serena_*` and `context7_*`
- Serena: no LSP languages enabled, `.gitignore`-based file exclusion, `read_only: false`

## Agent Instructions (AGENTS.md)
- Be concise, no repetition, answer with minimal text
- Prefer serena tools over grep/glob/read for code analysis; grep is denied, use `serena_search_for_pattern`
- Prefer context7 over webfetch for documentation; webfetch only after context7 fails or for non-API URLs
- Startup ritual: `context7_resolve-library-id("serena")` + read all serena memories
- After `git push`: prompt user to press Tab to return to Plan mode

## Permissions Model
- `edit`: ask
- `grep`: deny (use `serena_search_for_pattern` instead)
- `bash`: ask all (`*`: ask)
- glob: no constraint, no serena replacement

## Experimental
- `primary_tools: ["compress"]` — compress is the primary context management tool
