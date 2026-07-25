#!/usr/bin/env bash
# Dummy test workload that randomly simulates infrastructure failures.
# Exit codes:
#   0 - success
#   1 - infrastructure failure (500 / timeout)

set -euo pipefail

ERRORS=(
  "Internal 500 server error: upstream service unavailable"
  "Timeout provisioning runner: deadline exceeded after 300s"
  "Internal 500 server error: failed to allocate container"
  "Timeout provisioning: could not reach artifact registry"
  "Internal 500 server error: dependency resolution service returned 500"
)

# Roll a die: 0-3 = infra failure, 3-9 = success
ROLL=$(( RANDOM % 10 ))

echo "==> Starting dummy test workload..."
echo "==> Random roll: ${ROLL}"

if [[ ${ROLL} -le 5 ]]; then
  # Pick a random error message
  INDEX=$(( RANDOM % ${#ERRORS[@]} ))
  echo ""
  echo "ERROR: ${ERRORS[${INDEX}]}"
  echo ""
  echo "==> Workload FAILED (simulated infrastructure error)"
  exit 1
fi

echo ""
echo "==> All checks passed. Workload completed successfully."
exit 0
