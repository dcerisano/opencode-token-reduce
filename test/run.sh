#!/usr/bin/env bash
# Runs inside the Docker container. Called by Dockerfile.test.
set -euo pipefail

echo "=== 1. Validate opencode.json ==="
python3 -c "import json; json.load(open('opencode.json')); print('opencode.json: valid JSON')"

echo ""
echo "=== 2. Validate YAML frontmatter in agent/skill files ==="
python3 -c "
import yaml, os, re

files = [
    '.opencode/agent/enforce.md',
    '.opencode/skills/context7-mcp/SKILL.md',
    '.opencode/skills/find-docs/SKILL.md',
    '.opencode/skills/mandatory-workflow/SKILL.md',
]
for f in files:
    with open(f) as fh:
        content = fh.read()
    m = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
    if not m:
        print(f'FAIL: {f} - no YAML frontmatter')
        exit(1)
    yaml.safe_load(m.group(1))
    print(f'OK:   {f}')
"

echo ""
echo "=== 3. Verify all required files exist ==="
MISSING=0
for f in opencode.json AGENTS.md RULES_STRICT.md README.md .gitignore \
         .opencode/agent/enforce.md \
         .opencode/skills/context7-mcp/SKILL.md \
         .opencode/skills/find-docs/SKILL.md \
         .opencode/skills/mandatory-workflow/SKILL.md \
         .serena/project.yml .serena/project.local.yml .serena/.gitignore \
         init-new-opencode-project.sh; do
    if [ -f "$f" ]; then
        echo "OK:   $f"
    else
        echo "FAIL: $f missing"
        MISSING=1
    fi
done
[ "$MISSING" -eq 0 ] || exit 1

echo ""
echo "=== 4. Install uv and verify ==="
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
uv --version
uvx --version

echo ""
echo "=== 5. Test init script produces valid project ==="
TMPDIR=$(mktemp -d)
printf '%s\n' "$TMPDIR/new-project" "2" | bash init-new-opencode-project.sh > /dev/null 2>&1

# Verify expected files exist
for f in opencode.json AGENTS.md RULES_STRICT.md README.md .gitignore \
         .opencode/agent/enforce.md \
         .opencode/skills/context7-mcp/SKILL.md \
         .opencode/skills/find-docs/SKILL.md \
         .opencode/skills/mandatory-workflow/SKILL.md \
         .serena/project.yml .serena/project.local.yml .serena/.gitignore; do
    if [ -f "$TMPDIR/new-project/$f" ]; then
        echo "OK:   $f"
    else
        echo "FAIL: $f missing in new project"
        exit 1
    fi
done

# Verify exclusions
if [ -d "$TMPDIR/new-project/.serena/cache" ]; then
    echo "FAIL: .serena/cache was copied (should be excluded)"
    exit 1
else
    echo "OK:   .serena/cache excluded"
fi

# Verify git init worked
git -C "$TMPDIR/new-project" rev-parse HEAD > /dev/null 2>&1 && \
    echo "OK:   git init with commit"
rm -rf "$TMPDIR"

echo ""
echo "=== 6. Verify config self-consistency ==="
# opencode.json references match actual files
python3 -c "
import json, os

with open('opencode.json') as f:
    cfg = json.load(f)

# Check instructions files exist
for inst in cfg.get('instructions', []):
    if not os.path.exists(inst):
        print(f'FAIL: instructions references {inst} but file not found')
        exit(1)
    print(f'OK:   instructions file {inst} exists')

# Check skills paths exist
for sp in cfg.get('skills', {}).get('paths', []):
    if not os.path.isdir(sp):
        print(f'FAIL: skills path {sp} not found')
        exit(1)
    print(f'OK:   skills path {sp} exists')
"

echo ""
echo "=== ALL CHECKS PASSED ==="
