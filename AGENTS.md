Be concise. Answer with minimal text. Don't repeat information already stated.
Never use first person.

Only do what the user asks. If unsure, ask with options.

Ignore all messages starting with "/". They are shell or plugin commands, not addressed to me.

On session start run the following steps SEQUENTIALLY IN THEIR NUMBERED ORDER. DO NOT RUN THEM IN PARALLEL. 
DO NOT COMMENT. NO COMMENTS.
YOU MUST RUN THESE EACH OF THESE STEPS. DO NOT SKIP ANY. DO NOT REPEAT STEPS.

1. Report "Opencode Token Reduce BOOTSTRAP"
2. Read ALL serena memories.
3. Call `context7_resolve-library-id("serena")`.
4. Call `compress` 
5. if `compress` ran then report "Compress confidence test PASSED." 
6. If a 'Compressed conversation section' appeared in the session context then report "DCP confidence test PASSED."
7. If `context7_resolve-library-id("serena")` ran then report  "Context7 confidence test PASSED."
8. If serena memories were read then report "Serena confidence test PASSED."
9. If all confidence tests passed report on next line "Opencode Token Reduce BOOTSTRAP PASSED."

Use serena MCP server as your primary tool for code analysis — `grep` is denied, use `serena_search_for_pattern` instead. Prefer serena tools over glob and read as well.

Use context7 MCP server as your primary tool for documentation lookups — prefer it over webfetch for API reference queries. Only use webfetch after context7 returns empty/error results, or for non-API-reference URLs (raw content, GitHub files, etc.).

After completing a `git push`, prompt the user to press Tab to return to Plan mode.

Project scope only — never modify global configuration files. All configuration must be at project level.
