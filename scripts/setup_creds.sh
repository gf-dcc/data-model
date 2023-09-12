#!/bin/bash

CREDS=creds.json
SYNAPSE_CONFIG=.synapseConfig

if [ -f "$CREDS" ]; then
  echo "✓ $CREDS already present."
elif [ -n "${SCHEMATIC_SERVICE_ACCT_CREDS}" ]; then
  echo "${SCHEMATIC_SERVICE_ACCT_CREDS}" | base64 -d > $CREDS
  echo "✓ Created $CREDS"
else
  echo "✗ Failed to access stored creds."
  exit 1
fi

if [ -f "$SYNAPSE_CONFIG" ]; then
  echo "✓ $SYNAPSE_CONFIG already present."
elif [ -n "${SYNAPSE_AUTH_TOKEN}" ]; then
  echo "[authentication]" > $SYNAPSE_CONFIG
  echo "authtoken = ${SYNAPSE_AUTH_TOKEN}" >> $SYNAPSE_CONFIG
  echo "✓ Created $SYNAPSE_CONFIG"
else
  echo "✗ Failed to access stored creds."
  exit 1
fi


