#!/bin/bash -l
#@      cw_TEMPLATE[name]="ABySS 1.5.2 (GridScheduler)"
#@      cw_TEMPLATE[desc]="ABySS example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/abyss/test-data.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="abyss"
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
#$ -o $HOME/abyss_out.$JOB_ID
#$ -N abyss


#=========
#  ABySS
#---------
# For full ABySS usage information see:
#   https://github.com/bcgsc/abyss/blob/1.5.2/README.md
#   or: $ABYSSDOC/README.md
# For more information about ABySS, please refer to the website:
#   http://www.bcgsc.ca/platform/bioinfo/software/abyss

# Loading ABySS module
module load apps/abyss/1.5.2

if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Output/working data directory
OUTPUT_DIR="${HOME}/abyss/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Create the output/working data directory
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

# Copy in the input files
cp -r "${DATA_DIR}/." .

# Input file (or files)
INPUT_FILES="reads1.fastq reads2.fastq"

# Command-line options
KMER_LENGTH=25
MIN_JOIN_PAIRS=10
ANALYSIS_NAME=test

ABYSS_OPTIONS="k=$KMER_LENGTH n=$MIN_JOIN_PAIRS name=$ANALYSIS_NAME"

# Execute abyss-pe
abyss-pe $ABYSS_OPTIONS \
  in="${INPUT_FILES}"

echo ""
echo "-----------------"
echo " abyss completed"
echo "-----------------"
echo " Output is available in: $DATA_DIR"
