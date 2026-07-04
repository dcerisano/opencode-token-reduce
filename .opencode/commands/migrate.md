---
description: OpenCode token-reduce template into an existing project
agent: build
---

Extract the path from the prompt (the argument after `/migrate`) and expand `~`. 
If the path is non-blank and `test -d "$path/.git"` succeeds, skip asking and proceed. 
Otherwise, ask the user for the target path using the `question` tool. Keep asking until a non-blank path pointing to a separate git repo is confirmed.
Once confirmed run this bash command as a subagent task:

```bash
cd /home/praxis/git/opencode-token-reduce && \
  git ls-files | \
  grep -v -E '^(README\.md|\.serena/memories/.*|\.serena/project.*\.yml)' | \
  xargs -I{} cp --parents {} "$confirmed_path"
```

Report: "Migrated N files to <path>."

Do not track, stage, commit, or push the copied files.
