---
description: OpenCode token-reduce template into an existing project
agent: build
---

Check if a target directory path was already provided as an argument in the user's message (e.g. `/migrate /some/path`). If so, use that path directly. Otherwise, ask the user for a target directory path using the `question` tool.

**NEVER accept a blank or empty path.** The path MUST be non-empty after trimming whitespace. If the user provides a blank/empty path (or you get an empty response from the `question` tool), reject it immediately with an error message and keep asking until a valid non-empty path is given.

In either case, validate the path exists as a directory using `bash` with `test -d "$path"`. Keep asking (or reject the provided arg) until a valid existing directory is confirmed.

Also validate the target is a **separate** git repository by checking that `"$path/.git"` exists as a directory using `bash` with `test -d "$path/.git"`. **Reject with an error message "Target must be a separate git repository (no .git directory found)." if it is not a git repo.** Do NOT proceed with the migration if the target is not a git repository.

Once confirmed, delegate the full workflow to a `task` subagent (type `general`) so output is collapsed. Pass the confirmed path as the target.

The subagent receives:

You are migrating the opencode-token-reduce template into the existing target project at `{confirmed_path}`.

1. Copy all files from the current remote template repo into target project (EXCEPT DO NOT COPY the README.md or .serena/memory/*.md or .serena/project*.yaml)
2. Merge (don't just replace) any target files already present in the target project giving the migrating file content predecence in the merge
3. Abort and report if any merges had conflicts you could not resolve.
4. After all files are copied/merged, stage only the template files in the target repo — not everything in the target. Run `git -C "{confirmed_path}" add` on each copied file/directory individually (or compute the file list from the template repo excluding the exceptions and add those paths). Do NOT commit or push.
