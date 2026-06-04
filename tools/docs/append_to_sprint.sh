#!/usr/bin/env bash
set -euo pipefail

HEADING="${1:-}"

if [ -z "$HEADING" ]; then
  echo "Usage: tools/docs/append_to_sprint.sh \"Heading\" <<'EOF'"
  echo "Body text"
  echo "EOF"
  exit 1
fi

SPRINT_DOC="docs/sprints/current_sprint.md"

if [ ! -f "$SPRINT_DOC" ]; then
  echo "Missing sprint doc: $SPRINT_DOC"
  exit 1
fi

cat <<BLOCK >> "$SPRINT_DOC"

## $HEADING

$(cat)
BLOCK

echo "Appended to $SPRINT_DOC under heading: $HEADING"
