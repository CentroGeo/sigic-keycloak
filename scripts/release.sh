#!/usr/bin/env bash
set -euo pipefail

BRANCH=$(git branch --show-current)

if [ "$BRANCH" != "main" ]; then
  echo "❌ Debes correr release.sh desde la rama main. Estás en: $BRANCH"
  exit 1
fi

MODE="${1:-patch}"   # patch | minor
YM="$(date +%Y.%m)"

LAST=$(git tag --list "v$YM.*" --sort=-v:refname | head -n1)

if [ -z "$LAST" ]; then
  MINOR=0
  PATCH=0
else
  VERSION="${LAST#v$YM.}"
  MINOR="${VERSION%-*}"
  PATCH="${VERSION#*-}"

  if [ "$MODE" = "minor" ]; then
    MINOR=$((MINOR+1))
    PATCH=0
  else
    PATCH=$((PATCH+1))
  fi
fi

TAG="v$YM.$MINOR-$PATCH"

git tag "$TAG"
git push origin "$TAG"

echo "✅ Release creada => $TAG"
