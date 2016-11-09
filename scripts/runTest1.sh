#!/bin/bash

wget "https://drive.google.com/uc?export=download&id=0B2e3YmwhK4fkeW1ORld3ZVZ2ZDQ" -O midcor_outin_input.csv
runMidcor.R -i midcor_outin_input.csv -o output.csv
