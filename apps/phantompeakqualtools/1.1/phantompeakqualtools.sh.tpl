#!/bin/bash -l
#@      cw_TEMPLATE[name]="phantompeakqualtools 1.1 (GridScheduler)"
#@      cw_TEMPLATE[desc]="phantompeakqualtools example script."
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
#$ -o $HOME/phantompeakqualtools_out.$JOB_ID
#$ -N phantompeakqualtools
#$ -pe smp-verbose 2

#========================
#  phantompeakqualtools
#------------------------
# For more usage information see:
#   https://code.google.com/p/phantompeakqualtools/

# Loading module
module load apps/phantompeakqualtools/1.1 

# Output directory
OUTPUT_DIR="${HOME}/phantompeakqualtools/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -pv $OUTPUT_DIR

# Input directory
INPUT_DIR="${HOME}/phantompeakqualtools/input.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -pv $INPUT_DIR

# Gathering and setting input data
cp -v "${PHANTOMPEAKQUALTOOLSEXAMPLES}/example.tagAlign.gz" "${INPUT_DIR}/example.tagAlign.gz"
INPUT_FILE="example.tagAlign.gz"

# Additional command-line options (execute `run_spp` for list)
RUNSPP_OPTIONS="-savp"

run_spp -c="${INPUT_DIR}/${INPUT_FILE}" \
  -out="${OUTPUT_DIR}/example.out.tsv" \
  $RUNSPP_OPTIONS

echo ""
echo "--------------------------------"
echo " phantompeakqualtools completed"
echo "--------------------------------"
echo " Output is available in: $OUTPUT_DIR"
