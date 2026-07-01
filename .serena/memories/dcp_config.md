# DCP Config Rationale

- **Config location**: `.opencode/dcp.jsonc` (project-level, overrides global)
- **No hot-swap** — config read once at plugin init (`lib/config.ts:getConfig`). Restart to apply changes.

## Limits (percentage-based)

- `maxContextLimit: "70%"` — trigger compression nudges at 70% of model window
- `minContextLimit: "30%"` — start reminders at 30%
- Percentage strings (`"X%"`) auto-scale per model. Template targets 1M-window models.
- OpenCode's built-in `compaction` auto-triggers near 100% — DCP is proactive before that.

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
- `reserved: 50000` — 50k token buffer before compaction fires (~95% of 1M window)
- Default would be 10k (too tight for 1M models)
- Compaction is last-resort; DCP compression is the proactive layer

## Primary tools

- `experimental.primary_tools: ["compress"]` in `opencode.json`
- Makes DCP's compress tool a first-class tool the model reaches for readily

## Other settings

- `turnProtection.enabled: true` — protect recent 4 turns from pruning (critical for MCP-heavy workflows)
- `purgeErrors.turns: 10` — longer window than default (4) for MCP debugging
- `pruneNotification: "minimal"` — less notification noise
- `experimental.allowSubAgents: true` — DCP processes subagent sessions