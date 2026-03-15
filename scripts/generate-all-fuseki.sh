#!/bin/bash
# Generate Widoco documentation for every dataset in Fuseki.
#
# Usage: ./scripts/generate-all-fuseki.sh
#
# Requires: docker compose, curl, jq
# Expects:  widoco-web service running (docker compose up -d widoco-web)

set -euo pipefail
source "$(dirname "$0")/generate-common.sh"

datasets=$(docker compose run --rm --entrypoint "" widoco \
  sh -c "curl -sf ${FUSEKI_PROXY}/\$/datasets" \
  | jq -r '.datasets[].["ds.name"]')

if [ -z "$datasets" ]; then
  echo "No datasets found in Fuseki" >&2
  exit 1
fi

echo "Found datasets:$(echo "$datasets" | tr '\n' ' ')"

for ds in $datasets; do
  generate_docs "${ds#/}"
done

print_done
