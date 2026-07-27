#!/usr/bin/env bash
# Dummy test workload that randomly fails or succeeds.

set -euo pipefail

echo "==> Starting dummy test workload..."

# Randomly decide whether to fail (50% chance)
if (( RANDOM % 2 == 0 )); then
  # Print error log and fail
  if [[ -f "logs/maas.error" ]]; then
    echo ""
    echo "==> Dumping logs/maas.error:"
    cat logs/maas.error
    echo ""
  fi
  echo "==> Workload FAILED"
  exit 1
fi

echo "==> All checks passed. Workload completed successfully."
exit 0
