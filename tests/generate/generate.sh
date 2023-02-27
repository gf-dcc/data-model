#!/bin/bash

# Generate .csv/Excel templates, to be provided:
# 2) as fallback for contribs who can't access GoogleSheets / DCA (maybe they're blocked by their institution, DCA is down, or just prefer being handed a .csv directly)
# 1) for documentation, i.e. read-only templates are embedded in user docs

# A config file is expected as the first arg.
# Locally, run test from the root of the repo with `./tests/generate/generate.sh ./tests/generate/config.json`.
# However, most runs use GitHub Actions.

OUTPUT_DIR=templates
LOG_DIR=logs
TEMPLATES=($(jq -r '.[].template' $1 | tr -d '"'))
TITLES=($(jq -r '.[].title' $1 | tr -d '"'))

mkdir -p $OUTPUT_DIR
mkdir -p $LOG_DIR

for i in ${!TEMPLATES[@]}
do
  echo ">>>>>>> Getting ${TEMPLATES[$i]}"
  schematic manifest --config config.yml get -dt ${TEMPLATES[$i]} --title ${TITLES[$i]} -o $OUTPUT_DIR/${TEMPLATES[$i]}.csv | tee $LOG_DIR/${TEMPLATES[$i]%.*}_log.txt
  sleep 0.5
done

# Clean up all the intermediates
rm *.schema.json

echo "Done!"
