#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./install.sh <target-path> [project-name] [--force]

Default behavior copies only missing files. Existing AGENTS.md, PROJECT.md,
or skills are skipped unless --force is explicitly supplied.
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

TARGET_PATH="$1"
shift

PROJECT_NAME=""
FORCE="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      FORCE="true"
      ;;
    *)
      if [[ -z "$PROJECT_NAME" ]]; then
        PROJECT_NAME="$1"
      else
        echo "Unexpected argument: $1" >&2
        usage
        exit 1
      fi
      ;;
  esac
  shift
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT="$SCRIPT_DIR/kit"

if [[ ! -d "$SOURCE_ROOT" ]]; then
  echo "Kit directory not found: $SOURCE_ROOT" >&2
  exit 1
fi

mkdir -p "$TARGET_PATH"
TARGET_ROOT="$(cd "$TARGET_PATH" && pwd)"

if [[ -z "$PROJECT_NAME" ]]; then
  PROJECT_NAME="$(basename "$TARGET_ROOT")"
fi

TODAY="$(date +%F)"
created=()
overwritten=()
skipped=()

while IFS= read -r -d '' source_file; do
  relative="${source_file#"$SOURCE_ROOT"/}"
  destination="$TARGET_ROOT/$relative"
  mkdir -p "$(dirname "$destination")"

  existed="false"
  if [[ -e "$destination" ]]; then
    existed="true"
    if [[ "$FORCE" != "true" ]]; then
      skipped+=("$relative")
      continue
    fi
  fi

  python3 - "$source_file" "$destination" "$PROJECT_NAME" "$TODAY" <<'PY'
import pathlib
import sys

source = pathlib.Path(sys.argv[1])
destination = pathlib.Path(sys.argv[2])
project_name = sys.argv[3]
today = sys.argv[4]

content = source.read_text(encoding="utf-8")
content = content.replace("{{PROJECT_NAME}}", project_name)
content = content.replace("{{DATE}}", today)
destination.write_text(content, encoding="utf-8")
PY

  if [[ "$existed" == "true" ]]; then
    overwritten+=("$relative")
  else
    created+=("$relative")
  fi
done < <(find "$SOURCE_ROOT" -type f -print0)

echo
echo "Project continuity kit installed."
echo "Target: $TARGET_ROOT"
echo "Project name: $PROJECT_NAME"

if [[ ${#created[@]} -gt 0 ]]; then
  echo "Created:"
  printf '  + %s\n' "${created[@]}"
fi

if [[ ${#overwritten[@]} -gt 0 ]]; then
  echo "Overwritten because --force was used:"
  printf '  ! %s\n' "${overwritten[@]}"
fi

if [[ ${#skipped[@]} -gt 0 ]]; then
  echo "Skipped existing files (merge them with AI; nothing was overwritten):"
  printf '  = %s\n' "${skipped[@]}"
fi

echo
echo "Next prompt:"
echo "先读根目录 AGENTS.md，执行 project-bootstrap；只建立当前项目事实，不修改业务代码。"
