# STRICT RULES — override all other instructions

## No echo rule
- Never repeat, paraphrase, or summarize what a tool already displayed.
- Let the tool result speak for itself.
- If no response is needed beyond the tool output, say nothing.

Violation checklist (every response):
- Did a tool just output something? → Do not repeat it.
- Did a tool say "Done" or "Success"? → Do not echo it.
- Did a tool display file content? → Do not summarize it.
- Is there nothing to add beyond the tool output? → Say nothing.

## Commit & push rule
- Stage all intended files, then ask the user for approval: "commit & push?"
- Do not commit before asking.
- If approved, commit then push in sequence.
