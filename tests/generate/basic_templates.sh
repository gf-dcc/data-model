#!/bin/bash
# Test generate 1) Googleheets or 2) Excel templates
# Generally for 1) this is run in test directory with other tests

OUTPUT=${1:-google_sheet}   
TEST_CONFIG=../../dca-template-config.json
CREDS=creds.json
DATA_MODEL_PATH=../../GF.jsonld
DATA_MODEL=GF.jsonld
LOG_DIR=logs
TEMPLATE_DIR=../../templates
SLEEP_THROTTLE=17 # API rate-limiting, need to better figure out dynamically based on # of templates

# Setup for creds
# If testing locally, it might already be in folder; 
# Else, especially if in Actions or Codespace, we need to create it from env var
# See https://github.com/nf-osi/nf-metadata-dictionary/settings/secrets/codespaces
if [ -f "$CREDS" ]; then
  echo "✓ $CREDS -- running tests locally"
elif [ -n "${SCHEMATIC_SERVICE_ACCT_CREDS}" ]; then
  echo "${SCHEMATIC_SERVICE_ACCT_CREDS}" | base64 -d > $CREDS
  echo "✓ Created temp $CREDS for test"
else
  echo "✗ Failed to access stored creds. Aborting test."
  exit 1
fi


TEMPLATES=($(jq '.manifest_schemas[] | .schema_name' $TEST_CONFIG | tr -d '"'))
#TITLES=($(jq '.manifest_schemas[] | .display_name' $TEST_CONFIG | tr -d '"'))
echo "✓ Retrieved config with ${#TEMPLATES[@]} templates..."

# Setup data model
cp $DATA_MODEL_PATH $DATA_MODEL
echo "✓ Set up $DATA_MODEL for test"

# Setup logs
mkdir -p $LOG_DIR

for i in ${!TEMPLATES[@]}
do
  echo ">>>>>>> Generating ${TEMPLATES[$i]}" 
  [[ $OUTPUT == "google_sheet" ]] && schematic manifest --config config.yml get -dt ${TEMPLATES[$i]} --title ${TEMPLATES[$i]} -s | tee $LOG_DIR/${TEMPLATES[$i]%.*}_log.txt
  [[ $OUTPUT == "excel" ]] && schematic manifest --config config.yml get -dt ${TEMPLATES[$i]} --title ${TEMPLATES[$i]} --output_csv $TEMPLATE_DIR/${TEMPLATES[$i]}.csv --output_xlsx $TEMPLATE_DIR/${TEMPLATES[$i]}.xlsx | tee $LOG_DIR/${TEMPLATES[$i]%.*}_log.txt
  sleep $SLEEP_THROTTLE
done

echo "Cleaning up test fixtures and intermediates..."
rm -f $CREDS $TEST_CONFIG $DATA_MODEL *.schema.json *.manifest.csv

echo "✓ Done!"

