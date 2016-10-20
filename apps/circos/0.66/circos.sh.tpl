#!/bin/bash -l
#@      cw_TEMPLATE[name]="Circos v0.66 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Circos example script."
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
#$ -o $HOME/circos_out.$JOB_ID
#$ -N circos
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Circos usage information see:
#   http://circos.ca/documentation/

# Loading Circos module
module load apps/circos/0.66

# Output directory
OUTPUT_DIR="${HOME}/circos/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Path to configuration file
CONF_FILE=etc/circos.conf

# Additional command-line options (circos -help for a list)
CIRCOS_OPTIONS=

# Create output directory if it doesn't already exist
mkdir -p $OUTPUT_DIR

# Copy example configuration and data
cd $OUTPUT_DIR
cp -r $CIRCOSEXAMPLES/* .

# Launch Circos
circos -conf $CONF_FILE $CIRCOS_OPTIONS

echo ""
echo "-----------------"
echo " Circos completed"
echo "-----------------"
echo " Output is available in: $OUTPUT_DIR"
