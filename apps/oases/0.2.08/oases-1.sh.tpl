#!/bin/bash -l
#@      cw_TEMPLATE[name]="Oases v0.2.08 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Execute oases tool on a directory containing existing output from a velvet run"
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/oases/oases.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="oases"
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
#$ -o $HOME/oases_out.$JOB_ID
#$ -N oases
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Oases usage information see:
#   http://www.ebi.ac.uk/~zerbino/oases/OasesManual.pdf
#   or: $OASESDIR/doc/OasesManual.pdf
# For more information about Oases, please refer to the website:
#   http://www.ebi.ac.uk/~zerbino/oases/

# Ensuring example data is available
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

#Loading Oases module
module load apps/oases

# Output data directory
OUTPUT_DIR="${HOME}/oases/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Input directory
INPUT_DIR="${HOME}/oases/input"
mkdir -p "$INPUT_DIR"

# Copying input files generated earlier from a previous velvet run
echo ""
echo "-------------------------"
echo " Gathering example files "
echo "-------------------------"
echo ""
cp -rpv "${DATA_DIR}/." "${INPUT_DIR}/."

# Command-line options (run oases with no options for a list).
OASES_OPTIONS=""

echo ""
echo "-------------------------"
echo "      Running Oases      "
echo "-------------------------"
echo ""

# Execute oases
oases "$INPUT_DIR" $OASES_OPTIONS

echo ""
echo "-------------------------"
echo "     Oases completed     "
echo "-------------------------"
echo " Output is available in: $OUTPUT_DIR"
