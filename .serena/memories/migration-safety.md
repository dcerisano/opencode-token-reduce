# Migration / File-Copy Safety Protocol

When copying files between repos, always:

1. Count files in the SOURCE, not the target: `git ls-files | grep -v -E '...' | wc -l`
2. Report the count BEFORE executing the copy, and let the user confirm
3. After copy, verify the count matches expected

Never count files in the target directory — that inflates the number with pre-existing files.

Never use `git ls-files` on the target repo to measure how many were copied; always use the source repo's filtered file list for the count.