#!/bin/bash -l
#@      cw_TEMPLATE[name]="MIRA v4.0.2 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Execute MIRA using specified manifest file (not included)"
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/mira/mira.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="mira"
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
#$ -o $HOME/mira_out.$JOB_ID
#$ -N mira
#$ -pe smp-verbose 1
#$ -l h_vmem=3G


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# Note that to use MIRA requires both sequence data and one or more
# appropriately configured manifest files (not included)
#
# For full MIRA usage information see:
#   http://mira-assembler.sourceforge.net/docs/DefinitiveGuideToMIRA.html

# Checking for availability of example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading hapflk module
module load apps/mira/4.0.2

# Input directory
INPUT_DIR="${HOME}/mira/input"
mkdir -p "${INPUT_DIR}"

# Output directory
OUTPUT_DIR="${HOME}/mira/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Copying example files to input directory
cp -pv "${DATA_DIR}/manifest.conf" "${INPUT_DIR}/manifest.conf"
cp -pv "${DATA_DIR}/reads1.fastq" "${INPUT_DIR}/reads1.fastq"
cp -pv "${DATA_DIR}/reads2.fastq" "${INPUT_DIR}/reads2.fastq"

# File to read assembly configuration details from
MANIFEST_FILE="${INPUT_DIR}/manifest.conf"

# Additional command-line options (mira -h for a list)
#MIRA_OPTIONS=""

# Moving to output directory
cd $OUTPUT_DIR

# Running MIRA
mira -c "$OUTPUT_DIR" "$MANIFEST_FILE"

echo ""
echo "----------------"
echo " MIRA completed "
echo "----------------"
echo " Output is available in: $OUTPUT_DIR"
