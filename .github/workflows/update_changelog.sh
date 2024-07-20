#!/bin/bash

NEW_VERSION="$1"
CHANGELOG="$2"


  CURRENT_DATE=$(TZ='America/Denver' date +%Y-%m-%d)
  REPO_URL="https://github.com/joshuadanpeterson/typewriter.nvim"

  format_entry() {
    local version=$1
    local date=$2
    local content=$3
    local prev_version=$4
    echo "## [$version]($REPO_URL/tree/$version) ($date)"
    echo "$content"
    echo
    echo "[Full Changelog]($REPO_URL/compare/$prev_version...$version)"
    echo
  }

  remove_duplicates() {
    echo "$1" | awk '!seen[$0]++'
  }

  echo "# Changelog" > temp_changelog.md
  echo >> temp_changelog.md

  # Add new version
  NEW_CHANGELOG=$(remove_duplicates "$CHANGELOG")
  format_entry "$NEW_VERSION" "$CURRENT_DATE" "$NEW_CHANGELOG" "${{ steps.determine_version.outputs.LATEST_TAG }}" >> temp_changelog.md

  prev_version="$NEW_VERSION"
  declare -A processed_versions

  while IFS= read -r line; do
    if [[ $line =~ ^##[[:space:]]+(\[v[0-9]+\.[0-9]+\.[0-9]+\])(.*)$ ]]; then
      version="${BASH_REMATCH[1]}"
      version="${version:1:-1}"
      if [[ -n "${processed_versions[$version]}" ]] || [[ "$version" == "$NEW_VERSION" ]]; then
	continue
      fi
      processed_versions[$version]=1

      date_part="${BASH_REMATCH[2]}"
      date=$(echo "$date_part" | grep -oP '\(\K[0-9]{4}-[0-9]{2}-[0-9]{2}(?=\))' || echo "Unknown Date")
      
      if [ "$date" != "Unknown Date" ]; then
	date=$(TZ='America/Denver' date -d "$date" +%Y-%m-%d)
      fi
      
      content=$(sed -n "/^## \[$version\]/,/^## \[v[0-9]/{ /^## \[v[0-9]/d; p; }" CHANGELOG.md)
      content=$(echo "$content" | sed '/^\[Full Changelog\]/d' | sed '/^$/N;/^\n$/D')
      content=$(remove_duplicates "$content")
      
      format_entry "$version" "$date" "$content" "$prev_version" >> temp_changelog.md
      
      prev_version="$version"
    fi
  done < CHANGELOG.md

  mv temp_changelog.md CHANGELOG.md

  if ! grep -q "^# Changelog" CHANGELOG.md || ! grep -q "^## \[v[0-9]\+\.[0-9]\+\.[0-9]\+\]" CHANGELOG.md; then
    echo "Error: CHANGELOG.md formatting verification failed"
    exit 1
  fi

  git config --local user.email "action@github.com"
  git config --local user.name "GitHub Action"
  git add CHANGELOG.md
  git commit -m "docs: update CHANGELOG.md for ${NEW_VERSION} and remove duplicate entries"
  git push
