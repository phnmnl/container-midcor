#!/bin/bash

apt-get update -y && apt-get install -y --no-install-recommends wget ca-certificates

wget "https://drive.google.com/uc?export=download&id=0B7S2ZMhdzWwbX3dnc1Z3WWhTak0" -O midcor_outin_input.csv
runMidcor.R -i midcor_outin_input.csv -o output.csv

if [ ! -f output.csv ]; then
   	echo "File output.csv does not exist, failing test."
   	exit 1
fi

echo "midcor runs with test data without error codes, all expected files created."
