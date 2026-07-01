Be concise. Answer with minimal text. Don't repeat information already stated.
Never use first person.

Only do what the user asks. If unsure, ask with options.

On session start:
1. Call `context7_resolve-library-id("serena")`.
2. Read ALL serena memories.

Use serena MCP server as your primary tool for code analysis — `grep` is denied, use `serena_search_for_pattern` instead. Prefer serena tools over glob and read as well.

Use context7 MCP server as your primary tool for documentation lookups — prefer it over webfetch for API reference queries. Only use webfetch after context7 returns empty/error results, or for non-API-reference URLs (raw content, GitHub files, etc.).

After completing a `git push`, prompt the user to press Tab to return to Plan mode.

Project scope only — never modify global configuration files. All configuration must be at project level.
