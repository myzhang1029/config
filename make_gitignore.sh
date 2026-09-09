#!/bin/bash

GLOBAL="https://github.com/github/gitignore/raw/main/Global"
GLOBAL_FILES=("macOS" "Windows" "Patch" "Vim" "VisualStudioCode" "Xcode")
ADDITIONAL=("*.profraw" "*.profdata")

BASE="$(dirname "$0")"
OUT="$BASE/config/git/ignore"

echo "# My own" > "$OUT"
for item in "${ADDITIONAL[@]}"; do
    echo "$item" >> "$OUT"
done

for file in "${GLOBAL_FILES[@]}"; do
    echo "$file.gitignore" >> "$OUT"
    curl -fsSL "$GLOBAL/$file.gitignore" >> "$OUT"
done
