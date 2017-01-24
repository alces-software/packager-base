#!/bin/bash -l
#@      cw_TEMPLATE[name]="Scythe v0.994.20141017 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Run scythe with minimal options using supplied test data."
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
#$ -o $HOME/scythe_out.$JOB_ID
#$ -N scythe
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Scythe usage information see:
#   https://github.com/vsbuffalo/scythe

# Loading Scythe module
module load apps/scythe

# Input directory
INPUT_DIR="${HOME}/scythe/input"
mkdir -p $INPUT_DIR

# Output directory
OUTPUT_DIR="${HOME}/scythe/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Adapter file
ADAPTER_FILE="${INPUT_DIR}/illumina_adapters.fa"

# Sequence file
SEQUENCE_FILE="${INPUT_DIR}/reads.fastq"

# Output file
OUTPUT_FILE="${OUTPUT_DIR}/trimmed_sequences.fasta"

# Additional command-line options
SCYTHE_OPTIONS=""

# Get up input data
cp -Rv "${SCYTHEEXAMPLE}/." "${INPUT_DIR}"

# Run Scythe command line
scythe -a "$ADAPTER_FILE" -o "$OUTPUT_FILE" "$SEQUENCE_FILE"


echo ""
echo "-------------------"
echo " Scythe completed "
echo "-------------------"
echo " Output is available in: $OUTPUT_DIR"
