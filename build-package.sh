#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST="$SCRIPT_DIR/dist"
ZIP_PATH="$DIST/project-continuity-kit.zip"

mkdir -p "$DIST"

python3 - "$SCRIPT_DIR" "$ZIP_PATH" <<'PY'
from pathlib import Path
import shutil
import tempfile
import zipfile
import hashlib
import sys

root = Path(sys.argv[1])
zip_path = Path(sys.argv[2])

with tempfile.TemporaryDirectory(prefix="project-continuity-kit-") as temp_dir:
    package_root = Path(temp_dir) / "project-continuity-kit"
    package_root.mkdir(parents=True)

    shutil.copytree(root / "kit", package_root / "kit")
    for name in ["INSTALL_PROMPT.md", "LESSONS.md", "README.md", "VERSION", "install.ps1", "install.sh"]:
        shutil.copy2(root / name, package_root / name)

    if zip_path.exists():
        zip_path.unlink()

    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as archive:
        for path in sorted(package_root.rglob("*")):
            if path.is_file():
                archive.write(path, Path("project-continuity-kit") / path.relative_to(package_root))

sha256 = hashlib.sha256(zip_path.read_bytes()).hexdigest()
version = (root / "VERSION").read_text(encoding="utf-8").strip()
print(f"Package created: {zip_path}")
print(f"Version: {version}")
print(f"SHA256: {sha256}")
PY
