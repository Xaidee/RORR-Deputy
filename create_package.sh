#!/usr/bin/env bash

OUTPUT_ZIP=${1:-"Xaidee-Deputy.zip"}

EXCLUDE_PATTERNS=("$OUTPUT_ZIP")

if [ -f .gitignore ]; then
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        EXCLUDE_PATTERNS+=("$line")
    done < .gitignore
fi

# Use a custom .pkgignore for files that should be on the git repo but not in the package.
if [ -f .pkgignore ]; then
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        EXCLUDE_PATTERNS+=("$line")
    done < .pkgignore
fi

zip -r "$OUTPUT_ZIP" . -x "${EXCLUDE_PATTERNS[@]}"
