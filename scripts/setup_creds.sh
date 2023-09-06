#!/bin/bash

CREDS=creds.json

if [ -f "$CREDS" ]; then
  echo "✓ $CREDS already present."
elif [ -n "${SCHEMATIC_SERVICE_ACCT_CREDS}" ]; then
  echo "${SCHEMATIC_SERVICE_ACCT_CREDS}" | base64 -d > $CREDS
  echo "✓ Created $CREDS"
else
  echo "✗ Failed to access stored creds."
  exit 1
fi

