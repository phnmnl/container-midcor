#!/usr/bin/env Rscript

suppressPackageStartupMessages(library(optparse))

options_list<-list(
  make_option(c("--input","-i"),help="Input path"),
  make_option(c("--output","-o"),help="ouput full path name, directories and files will be created here"),
  make_option(c("--convert","-c"),help="convert to the format convenient for editting"),
  make_option(c("--statistics","-s"),help="calculation of mean and SD for analogous samples"),
  make_option(c("--outdir","-d"),help="directory to write files prepared for Isodyn")
)

parser = OptionParser(option_list = options_list)
opt<-parse_args(parser,positional_arguments = FALSE)

library(midcor)

if("output" %in% names(opt)) {
     run_midcor(infile=opt$input, outfile=opt$output)
             print("correction of raw MID finished")} else if("convert" %in% names(opt)) {
     run_convert(infile=opt$input,outfile=opt$convert)
             print("MID converted as rows")}       else if("statistics" %in% names(opt)) {
     isoform(isofi=opt$statistics,outdir=opt$outdir)
             print(" MID prepared for simulation")} else {
  print("no argument given!")
  print_help(parser)
  q(status = 1,save = "no")
                      }

