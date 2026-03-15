#!/bin/bash
# Shared functions for Fuseki doc generation scripts.
# Source this file; do not execute directly.

FUSEKI_PROXY="${FUSEKI_PROXY:-http://widoco-web/fuseki}"
WIDOCO_FLAGS="${WIDOCO_FLAGS:--webVowl -rewriteAll}"

generate_docs() {
  local name="$1"
  echo "--- Generating docs for: ${name} ---"
  docker compose run --rm widoco \
    -ontURI "${FUSEKI_PROXY}/${name}/data" \
    -outFolder "/output/${name}" \
    ${WIDOCO_FLAGS}
}

print_done() {
  echo "--- Done. Documentation available at http://localhost:${PORT:-8484}/ ---"
}
