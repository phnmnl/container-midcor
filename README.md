![Logo](text4217.png)

# MIDcor

Version: 1.0

## Short Description

“R”-program that corrects 13C mass isotopomers spectra of metabolites for natural occurring isotopes and peaks overlapping

## Description

“midcor.R” is an “R”-program that performs a primary analysis of isotopic isomers (isotopomers) distribution obtained by Gas Cromatography coupled with Mass Spectrometry (GCMS). The aim of this analysis is to have a correct distribution of isotopes originated from substrates that are artificially enriched with specific isotopes (usually 13C). To this end the program performs a correction for natural occurring isotopes and also correction for “impurities” of the assay media that give peaks overlapping with the spectra of analyzed labeled metabolites. This program offers two ways of corrections of “impurities” resulted from overlapping the assayed mass isotopomer distribution with peaks produced either by unknown metabolites in the media, or by different fragments produced by the assayed metabolite. 

## Key features

- primary processing of 13C mass isotopomer data obtained with GCMS

## Functionality

- Preprocessing
- Statistical Analysis
- Workflows

## Approaches

- Isotopic Labelling Analysis / 13C
    
## Instrument Data Types

- MS

## Data Analysis

- correction for H+ loss produced by electron impact, natural occurring isotopes, and peaks overlapping

## Screenshots

- screenshot of input data (format Metabolights), output is the same format with one more column added: corrected mass spectrum

![screenshot](Screenshot.png)

## Tool Authors

- [Vitaly Selivanov (Universitat de Barcelona)](https://github.com/seliv55)

## Container Contributors

- [Pablo Moreno (EMBL-EBI)](https://github.com/pcm32)

## Website

- N/A

## Git Repository

- https://github.com/seliv55/midcor

## Installation  
  
To create the Docker container: 
  - go to the directory where the dockerfile is;
  - create container from dockerfile:

```
docker build -t midcor:0.1 .
```

Alternatively, pull directly from the repo 

```
docker pull container-registry.phenomenal-h2020.eu/phnmnl/midcor
```


## Usage Instructions

To run MIDcor as a docker image, execute
 
```
docker run -it -v $PWD:/data container-registry.phenomenal-h2020.eu/phnmnl/midcor -i /data/input.csv -o /data/output.csv
```

An example of input file is provided as "outin.csv"

## Publications

- “MIDcor”, an R-program for deciphering mass interferences in mass spectra of metabolites enriched in stable isotopes. Submitted to BMC bioinformatics.
