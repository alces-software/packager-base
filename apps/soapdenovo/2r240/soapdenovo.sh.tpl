#!/bin/bash -l
#@      cw_TEMPLATE[name]="SOAPdenovo v2r240 (GridScheduler)"
#@      cw_TEMPLATE[desc]="SOAPdenovo example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/soapdenovo/soapdenovo.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="soapdenovo"
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
#$ -o $HOME/soapdenovo_out.$JOB_ID
#$ -N soapdenovo
#$ -l h_vmem=5G
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# Note that to use SOAPdenovo requires both data files and a configuration
# file that tells the assembler where to find these files (not included)
#
# For full SOAPdenovo usage information see:
#   http://soap.genomics.org.cn/soapdenovo.html

# Checking for example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading SOAPdenovo module
module load apps/soapdenovo/2r240

# Input directory
INPUT_DIR="${HOME}/soapdenovo/input"

# Output directory
OUTPUT_DIR="${HOME}/soapdenovo/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Create input and output directories if they do not already exist
mkdir -p "$INPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Populating input directory with example configuration and data
cp -vr "${DATA_DIR}/." "${INPUT_DIR}/."

# SOAPdenovo executable to use (SOAPdenovo-63mer or SOAPdenovo-127mer)
SOAPDENOVO=SOAPdenovo-63mer

# SOAPdenovo command to run
COMMAND=all

# Path to configuration file
CONFIG_FILE="${INPUT_DIR}/example.config"

# Additional command-line options ('SOAPdenovo-63mer all' for a list)
SOAPDENOVO_OPTIONS="-p 2"

# Running SOAPdenovo job
$SOAPDENOVO $COMMAND -s "${CONFIG_FILE}" -o "${OUTPUT_DIR}/graph" $SOAPDENOVO_OPTIONS

echo ""
echo "----------------------"
echo " SOAPdenovo completed"
echo "----------------------"
echo " Output is available in: $OUTPUT_DIR"
