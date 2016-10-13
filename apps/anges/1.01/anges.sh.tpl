#!/bin/bash -l
#@      cw_TEMPLATE[name]="ANGES v1.01 (GridScheduler)"
#@      cw_TEMPLATE[desc]="ANGES example script."
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
#$ -o $HOME/anges_out.$JOB_ID
#$ -N anges
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full ANGES usage information see:
#   $ANGESDOC/anges_1_01.pdf
#
# This example script is based on the example scripts which ship with
# ANGES.

# Loading ANGES module
module load apps/anges/1.01

# Output directory
OUTPUT_DIR="${HOME}/anges/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Directory where tutorial data has been extracted (see above)
EXAMPLE_DATA_DIR="${ANGESEXAMPLES}/fungal_genomes/"

# Create output directory and copy tutorial data
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"
cp -vr "${EXAMPLE_DATA_DIR}." .

anges_CAR PARAMETERS_TEL_BAB
anges_CAR PARAMETERS_TEL_HEUR
anges_CAR PARAMETERS_SERIATION
