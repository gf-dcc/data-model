SHELL:=/bin/bash -O globstar
CSV := GF.csv

all: collate convert

collate:
	@echo "Collating module components..."
	ls modules/**/*.csv
	head -1 modules/schema.csv > ${CSV}
	tail -n +2 -q modules/**/*.csv >> ${CSV}

convert:
	schematic schema convert ${CSV}

