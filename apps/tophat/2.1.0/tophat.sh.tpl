#!/bin/bash -l
#@      cw_TEMPLATE[name]="Tophat v2.1.0 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Tophat example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/tophat/test_data.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="tophat"
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
#$ -o $HOME/tophat_out.$JOB_ID
#$ -N tophat


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full TopHat usage information see:
#   http://tophat.cbcb.umd.edu/manual.html
# Test data may be downloaded from:
#   http://tophat.cbcb.umd.edu/downloads/test_data.tar.gz

# Checking for example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading Tophat module
module load apps/tophat/2.1.0

# Setting input directory
INPUT_DIR="${HOME}/tophat/input"

# Output directory (default is 'tophat_out')
OUTPUT_DIR="${HOME}/tophat/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Creating working directories
mkdir -p $INPUT_DIR
mkdir -p $OUTPUT_DIR

# Copying example data to working directory
cp -vr "${DATA_DIR}/." "${INPUT_DIR}/"

# Base name of genome index to be searched (i.e. up to first period)
GENOME_INDEX_BASE="${INPUT_DIR}/test_ref"

# Comma-separated list of FASTQ/FASTA files of reads ('left')
READS_1="${INPUT_DIR}/reads_1.fq"

# Optional: comma-sep list of FASTQ/FASTA files of reads ('right')
READS_2="${INPUT_DIR}/reads_2.fq"

# Additional command-line options (tophat -h for a list)
TOPHAT_OPTIONS="-r 20"

# Execute Tophat:wq
tophat -o $OUTPUT_DIR $TOPHAT_OPTIONS $GENOME_INDEX_BASE $READS_1 $READS_2
