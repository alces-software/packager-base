#!/bin/bash -l
#@      cw_TEMPLATE[name]="Cufflinks v2.2.2.20150701 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Cufflinks example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/cufflinks/cufflinks.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="cufflinks"
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
#$ -o $HOME/cufflinks_out.$JOB_ID
#$ -N cufflinks
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Cufflinks usage information see:
#   http://cole-trapnell-lab.github.io/cufflinks/manual/
# Test data may be downloaded from:
#   http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/test_data.sam

# Checking for example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading
module load apps/cufflinks/2.2.2.20150701

#Input directory
INPUT_DIR="${HOME}/cufflinks/input"
mkdir -p $INPUT_DIR

# Output directory (default is '.')
OUTPUT_DIR="${HOME}/cufflinks/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Getting test data
cp "${DATA_DIR}/test_data.sam" $INPUT_DIR

# Input file of RNA-Seq read alignments in the SAM format
ALIGNED_READS="${INPUT_DIR}/test_data.sam"

# Additional command-line options (cufflinks -h for list)
CUFFLINKS_OPTIONS=

cufflinks -o $OUTPUT_DIR $CUFFLINKS_OPTIONS $ALIGNED_READS
