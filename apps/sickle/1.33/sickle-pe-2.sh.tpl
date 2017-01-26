#!/bin/bash -l
#@      cw_TEMPLATE[name]="Sickle v1.33 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Sickle Paired End (sickle pe) - Interleaved Reads"
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
#$ -o $HOME/sickle_out.$JOB_ID
#$ -N sickle
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Sickle usage information see:
#   https://github.com/najoshi/sickle

# Loading Sickle module
module load apps/sickle

# Input directory
INPUT_DIR="${HOME}/sickle/input"
mkdir -p "${INPUT_DIR}"

# Output directory
OUTPUT_DIR="${HOME}/sickle/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "${OUTPUT_DIR}"

# Additional command-line options:
#   -q, --qual-threshold, Threshold for trimming based on average quality in a window. Default 20.
#   -l, --length-threshold, Threshold to keep a read based on length after trimming. Default 20.
#   -x, --no-fiveprime, Don't do five prime trimming.
#   -n, --truncate-n, Truncate sequences at position of first N.
#   -g, --gzip-output, Output gzipped files.
SICKLE_OPTIONS=""

# Variables governing input
IN_COMBO_FQ="${INPUT_DIR}/test.fastq"

# Variables governing output
OUT_TRIMMED_FQ="${OUTPUT_DIR}/combo_trimmed.fastq"
OUT_SINGLES_FQ="${OUTPUT_DIR}/trimmed_singles_file.fastq"

# Type of quality values:
#   solexa (CASAVA < 1.3)
#   illumina (CASAVA 1.3 to 1.7)
#   sanger (which is CASAVA >= 1.8))
QUAL_TYPE=illumina

# Fetch input data
cp -v "${SICKLEEXAMPLE}"/* "${INPUT_DIR}"

# Execute sickle
sickle pe -c "$IN_COMBO_FQ" \
  -t $QUAL_TYPE \
  -m "$OUT_TRIMMED_FQ" \
  -s "$OUT_SINGLES_FQ" \
  $SICKLE_OPTIONS


echo ""
echo "------------------"
echo " Sickle completed "
echo "------------------"
echo " Output is available in: $OUTPUT_DIR"
