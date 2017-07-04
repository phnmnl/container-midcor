#!/bin/bash

apt-get update -y && apt-get install -y --no-install-recommends wget ca-certificates

wget "https://drive.google.com/uc?export=download&id=0B1lAg6jyw6lvSUlxd0Y2TVY0eWM" -O midcor_outin_input.csv
runMidcor.R -i midcor_outin_input.csv -o output.csv
rc=$?; 
if [[ $rc != 0 ]]; then 
	echo "R process failed with error $rc"
	exit $rc; 
fi

if [ ! -f output.csv ]; then
   	echo "File output.csv does not exist, failing test."
   	exit 1
fi

echo "midcor runs with test data without error codes, all expected files created."
