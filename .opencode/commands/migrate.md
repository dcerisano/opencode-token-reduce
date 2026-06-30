---
description: OpenCode token-reduce template into an existing project
agent: build
---

Extract the path from the prompt (the argument after `/migrate`) and expand `~`. If the path is non-blank and `test -d "$path/.git"` succeeds, skip asking and proceed. Otherwise, ask the user for the target path using the `question` tool. Keep asking until a non-blank path pointing to a separate git repo is confirmed.

Once a valid path is obtained, copy only the remote template repo's files:

```
TEMPLATE_DIR="$(git rev-parse --show-toplevel)"
git -C "$TEMPLATE_DIR" ls-files \
  | grep -vE '(^README.md$|\.serena/project.*\.yaml$|\.serena/memories/.*\.md$)' \
  | rsync -aR --files-from=- "$TEMPLATE_DIR/" "$confirmed_path/"
```

Only files from the remote template repo are ever copied. Do not delegate to a subagent — run the rsync directly.

Report the list of copied/changed files based on the rsync output.
