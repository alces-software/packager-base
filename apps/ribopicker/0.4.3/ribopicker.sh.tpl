#!/bin/bash -l
#@      cw_TEMPLATE[name]="riboPicker v0.4.3 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Run riboPicker using test database according to examples in documentation."
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
#$ -o $HOME/ribopicker_out.$JOB_ID
#$ -N ribopicker
#$ -l h_vmem=3G
#$ -pe smp-verbose 1


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For more riboPicker usage information see:
#   http://sourceforge.net/projects/ribopicker/files/?source=navbar

# Loading riboPicker module
module load apps/ribopicker

# Input directory
INPUT_DIR="${HOME}/ribopicker/input"
mkdir -p "${INPUT_DIR}"

# Output directory
OUTPUT_DIR="${HOME}/ribopicker/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "${OUTPUT_DIR}"

# FASTA file containing input sequences
INPUT_FILE="${INPUT_DIR}/test_input.fasta"
cp -v "${RIBOPICKERDOC}/test_input.fasta" "$INPUT_DIR"

# Alignment coverage threshold in percentage
COVERAGE_THRESHOLD="80"

# Alignment identity threshold in percentage
IDENTITY_THRESHOLD="90"

# Name of database to use
DATABASE_NAME="test"

# Output file prefix
OUTPUT_PREFIX="test_input"

# Run riboPicker command line
ribopicker.pl \
  -c "$COVERAGE_THRESHOLD" \
  -i "$IDENTITY_THRESHOLD" \
  -f "$INPUT_FILE" \
  -dbs "$DATABASE_NAME" \
  -out_dir "$OUTPUT_DIR" \
  -id "$OUTPUT_PREFIX"

echo ""
echo "-------------------"
echo " riboPicker completed "
echo "-------------------"
echo " Output is available in: $OUTPUT_DIR"
