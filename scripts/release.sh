#!/usr/bin/env bash
set -euo pipefail

# ==================================================
# Settings
# ==================================================

REPO_FULL=$(git config --get remote.origin.url | sed -E 's#.*github.com[:/](.+)/(.+)\.git#\1/\2#')

OWNER="${REPO_FULL%/*}"
REPO="${REPO_FULL#*/}"

GITHUB_TOKEN="${GITHUB_TOKEN_CI:-}"

# ==================================================
# Safety checks
# ==================================================

BRANCH=$(git branch --show-current)
HEAD=$(git rev-parse HEAD)

echo "🔐 Rama actual: $BRANCH"

[ "$BRANCH" = "main" ] || { echo "❌ Debe ejecutarse desde main"; exit 1; }
[ -n "$TOKEN" ] || { echo "❌ GITHUB_TOKEN_CI no definido"; exit 1; }

command -v jq >/dev/null || { echo "❌ Falta jq"; exit 1; }

echo "🔎 Verificando CheckRuns CI para:"
echo "    $HEAD"

RAW=$(curl -s \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$OWNER/$REPO/commits/$HEAD/check-runs")

echo "Respuesta CI:"
echo "$RAW" | jq '.check_runs[].name, .check_runs[].conclusion'

TOTAL=$(echo "$RAW" | jq '.total_count')

[ "$TOTAL" -gt 0 ] || {
  echo "❌ No hay checks reportados aún"
  exit 1
}

FAILED=$(echo "$RAW" | jq '[.check_runs[] | select(.conclusion != "success")] | length')

[ "$FAILED" -eq 0 ] || {
  echo "❌ Hay checks fallidos o pendientes"
  exit 1
}

if ! git diff-index --quiet HEAD --; then
  echo "❌ Working tree sucio"
  exit 1
fi

if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ Variable GITHUB_TOKEN_CI no definida"
  exit 1
fi

echo "✅ Todos los checks CI están SUCCESS"

# ==================================================
# Check CI status
# ==================================================

STATUS=$(curl -sf \
  -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$OWNER/$REPO/commits/$HEAD/status" \
  | jq -r '.state')

if [ "$STATUS" != "success" ]; then
  echo "❌ CI NO verde ($STATUS). No se puede liberar."
  exit 1
fi

echo "✅ CI verificado OK"

# ==================================================
# Version calculation
# ==================================================

MODE="${1:-patch}"
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

# ==================================================
# Create tag
# ==================================================

git tag "$TAG"
git push origin "$TAG"

echo "🚀 Release creada y publicada: $TAG"
