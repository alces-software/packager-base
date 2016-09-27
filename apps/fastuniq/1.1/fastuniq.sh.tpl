#!/bin/bash -l
#@      cw_TEMPLATE[name]="FastUniq v1.1 (GridScheduler)"
#@      cw_TEMPLATE[desc]="FastUniq example script."
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
#$ -o $HOME/fastuniq_out.$JOB_ID
#$ -N fastuniq
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################

# Loading FastUniq module
module load apps/fastuniq/1.1

# Input directory
INPUT_DIR="${HOME}/fastuniq/input"
mkdir -p $INPUT_DIR

# Output directory (default is '.')
OUTPUT_DIR="${HOME}/fastuniq/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Acquiring default data
cp "$FASTUNIQEXAMPLES/input_list.txt" "${INPUT_DIR}/."

# The input file list of paired FSATQ sequence files.
INPUT_LIST="${INPUT_DIR}/input_list.txt"

# Additional command-line options (fastuniq for list)
FASTUNIQ_OPTIONS="-t q -o ${OUTPUT_DIR}/output_1.fastq -p ${OUTPUT_DIR}/output_2.fastq -c 1"

fastuniq -i $INPUT_LIST $FASTUNIQ_OPTIONS

echo ""
echo "------------------"
echo " fastuniq completed"
echo "------------------"
echo " Output is available in: $OUTPUT_DIR"
