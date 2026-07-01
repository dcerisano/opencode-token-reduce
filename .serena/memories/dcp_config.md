# DCP Config Rationale

- **Config location**: `.opencode/dcp.jsonc` (project-level, overrides global)
- **No hot-swap** — config read once at plugin init (`lib/config.ts:getConfig`). Restart to apply changes.

## Limits (percentage-based)

- `maxContextLimit` — trigger compression nudges at configured percentage of model window
- `minContextLimit` — start reminders at configured percentage
- Percentage strings (`"X%"`) auto-scale per model; any percentage can be configured.
- OpenCode's built-in `compaction` auto-triggers near 100% of the model window. DCP reacts to accumulated token bloat at the configured threshold — it cleans up waste that has already burned tokens; unlike Serena/Context7 which prevent bloat a priori.

## Nudge strategy

- `nudgeForce: "soft"` — avoids injecting wasted nudge messages when context is well under maxLimit
- `nudgeFrequency: 8` — less frequent nudges than default (5) to reduce overhead
- `iterationNudgeThreshold: 15` — wait 15 messages after user message before reminders
- `"strong"` tested: injected 30+ turn nudges without triggering compression when context was below 100k; wasted tokens on nudge overhead

## Protected tools

- `deduplication.protectedTools: ["serena_*", "context7_*"]` — prevent dedup of MCP calls
- `purgeErrors.protectedTools: ["serena_*", "context7_*"]` — keep failed MCP outputs for debugging
- `compress.protectedTools: ["serena_*", "context7_*"]` — preserve MCP outputs in compression summaries

## Compaction (OpenCode built-in)

- Configured in `opencode.json`, NOT in DCP config
- `auto: true` — auto-triggers when context is nearly full (model window - reserved)
- `reserved` — configurable token buffer before compaction fires (auto-scales with model window)
- Compaction is last-resort. DCP compression is also purely reactive — it only prunes bloat after tokens have already been spent

## Primary tools

- `experimental.primary_tools: ["compress"]` in `opencode.json`
- Makes DCP's compress tool a first-class tool the model reaches for readily

## Other settings

- `turnProtection.enabled: true` — protect recent 4 turns from pruning (critical for MCP-heavy workflows)
- `purgeErrors.turns: 10` — longer window than default (4) for MCP debugging
- `pruneNotification: "minimal"` — less notification noise
- `experimental.allowSubAgents: true` — DCP processes subagent sessions