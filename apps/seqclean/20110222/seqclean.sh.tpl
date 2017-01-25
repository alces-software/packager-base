#!/bin/bash -l
#@      cw_TEMPLATE[name]="SeqClean v20110222 (GridScheduler)"
#@      cw_TEMPLATE[desc]="The Gene Indices Sequence Cleaning and Validation script (SeqClean)."
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
#$ -o $HOME/seqclean_out.$JOB_ID
#$ -N seqclean
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
# For more SeqClean usage information see:
#   http://sourceforge.net/projects/seqclean/files/

# Loading POV-Ray module
module load apps/seqclean

# Output directory
OUTPUT_DIR="${HOME}/seqclean/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "${OUTPUT_DIR}"

# Input directory
INPUT_DIR="${HOME}/seqclean/input"
mkdir -p "${INPUT_DIR}"

# Fetching and setting the EST file to clean.
cp -p "${SEQCLEANEXAMPLE}/sample.fasta" "${INPUT_DIR}/sample.fasta"
EST_FILE="${INPUT_DIR}/sample.fasta"

# Additional command-line options (seqclean -h for a list).
SEQCLEAN_OPTIONS=""

# Moving to the working/output directory
cd "$OUTPUT_DIR"

seqclean "$EST_FILE" $SEQCLEAN_OPTIONS


echo ""
echo "--------------------"
echo " SeqClean completed "
echo "--------------------"
echo " Output is available in: $OUTPUT_DIR"
