#!/bin/bash -l
#@      cw_TEMPLATE[name]="hapflk 1.4 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Execute hapflk to perform an example of analysis on a small portion of HapMap phase III data around the LCT gene."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/hapflk/hapflk.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="hapflk"
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
#$ -o $HOME/hapflk_out.$JOB_ID
#$ -N hapflk
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full hapflk usage information see:
#   https://forge-dga.jouy.inra.fr/projects/hapflk/wiki/Options
#
# This example script is based on the tutorial at:
#   https://forge-dga.jouy.inra.fr/projects/hapflk/wiki/Tutorial
# It requires the tutorial genome data which be downloaded from:
#   https://forge-dga.jouy.inra.fr/documents/222
# Download, extract it and set TUTORIAL_DATA_DIR below

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
module load apps/hapflk/1.4

# Output directory
OUTPUT_DIR="${HOME}/hapflk/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Additional command-line options (hapflk -h for list)
HAPFLK_OPTIONS="-K 15 --nfit=1 --ncpu=2"

# Copy tutorial data
cd $OUTPUT_DIR
cp -v $DATA_DIR/* .

hapflk --file hapmap3-lct --kinship kinship.txt $HAPFLK_OPTIONS

echo ""
echo "------------------"
echo " hapflk completed "
echo "------------------"
echo " Output is available in: $OUTPUT_DIR"
