#!/bin/bash
# Generate Widoco documentation for specific Fuseki datasets.
#
# Usage: ./scripts/generate-fuseki.sh --name bfo_cco --name cco
#
# Requires: docker compose
# Expects:  widoco-web service running (docker compose up -d widoco-web)

set -euo pipefail
source "$(dirname "$0")/generate-common.sh"

names=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --name)
      names+=("$2")
      shift 2
      ;;
    *)
      echo "Unknown option: $1" >&2
      echo "Usage: $0 --name DATASET [--name DATASET ...]" >&2
      exit 1
      ;;
  esac
done

if [ ${#names[@]} -eq 0 ]; then
  echo "No datasets specified. Usage: $0 --name DATASET [--name DATASET ...]" >&2
  exit 1
fi

for name in "${names[@]}"; do
  generate_docs "$name"
done

print_done
