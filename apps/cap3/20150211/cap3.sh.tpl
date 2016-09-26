#!/bin/bash -l
#@      cw_TEMPLATE[name]="CAP3 v20150211 (GridScheduler)"
#@      cw_TEMPLATE[desc]="CAP3 example script."
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
#$ -o $HOME/cap3_out.$JOB_ID
#$ -N cap3
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full CAP3 usage information see:
#   $CAP3DOC/doc.txt
#
# This example script is based on the example script which ship with
# CAP3.

# Output directory
OUTPUT_DIR="${HOME}/cap3/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Directory where tutorial data has been extracted (see above)
EXAMPLE_DATA_DIR="$CAP3EXAMPLES"

# Create output directory and copy tutorial data
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"
cp -v "$EXAMPLE_DATA_DIR"/* .

# Run cap3 without any paramaters to get a list of all options.
CAP3_OPTIONS=""

cap3 xyz $CAP3_OPTIONS > xyz.out
