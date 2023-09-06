#!/bin/bash


schematic manifest --config config.yml get -dt $1 --title "Template" --output_csv templates/$1.csv --output_xlsx templates/$1.xlsx
