#!/bin/bash -l
#@      cw_TEMPLATE[name]="fgwas v0.3.5 (GridScheduler)"
#@      cw_TEMPLATE[desc]="fgwas example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#==============================================================================
# Copyright (C) 2016 Alces Software Ltd.
#
# This work is licensed under a Creative Commons Attribution-ShareAlike
# 4.0 International License.
#
# See http://creativecommons.org/licenses/by-sa/4.0/ for details.
#==============================================================================

#############################################
# SGE Directives - Change as required
#############################################

#$ -cwd
#$ -V
#$ -j y
#$ -o $HOME/fgwas_out.$JOB_ID
#$ -N fgwas
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full `fgwas` usage information see:
#   https://github.com/joepickrell/fgwas/blob/master/man/fgwas_manual.pdf

# Loading fgwas module
module load apps/fgwas/0.3.5

# Input directory
INPUT_DIR="${HOME}/fgwas/input"

# Output directory
OUTPUT_DIR="${HOME}/fgwas/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Additional command-line options
#
# Other options include:
#
#   -dists [string:string] the name of the distance annotation(s)
#     and the file(s) containing the distance model(s)
#   -k [integer] block size in number of SNPs (5000)
#   -v [float] variance of prior on normalized effect size
#     (0.1 [0.5 for case-control])
#   -p [float] penalty on sum of squared lambdas, only relevant
#     for -print (0.2)
#   -print print the per-SNP output
#   -xv do 10-fold cross-validation
#   -dens [string float float] model segment probability according
#     to quantiles of an annotation
#   -cc this is a case-control study, which implies a different input
#     file format
#   -fine this is a fine mapping study, which implies a different input
#     file format
#   -onlyp only do optimization under penalized likelihood
#   -cond [string] estimate the effect size of an annotation conditional
#     on the others in the model
FGWAS_OPTIONS=""

# Set up example input data
if [ ! -d "$INPUT_DIR" ]; then
    mkdir -p "$INPUT_DIR"
    cp -v "$FGWASEXAMPLE"/* "$INPUT_DIR"
fi

# Set up input file name
INPUT_FILE="${INPUT_DIR}/test_LDL.fgwas_in.gz"

# Set up output file stem (file name prefix)
OUTPUT_STEM="example"

# Set up list of annotations to use (space-separated)
ANNOTATION_LIST=(ens_coding_exon)

# Convert annotations from list to '+' delimited parameter
function join { local IFS="$1"; shift; echo "$*"; }
ANNOTATIONS=$(join "+" "${ANNOTATION_LIST[@]}")

# Create and change to output directory
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

# Execute fgwas
fgwas -i $INPUT_FILE \
  -o $OUTPUT_STEM \
  -w "$ANNOTATIONS" $FGWAS_OPTIONS

echo ""
echo "-----------------"
echo " fgwas completed"
echo "-----------------"
echo " Output is available in: $OUTPUT_DIR"
