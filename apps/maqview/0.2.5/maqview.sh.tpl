#!/bin/bash -l
#@      cw_TEMPLATE[name]="M.A.Q Viewer v0.2.5 (GridScheduler)"
#@      cw_TEMPLATE[desc]="M.A.Q Viewer example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/maqview/maqview.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="maqview"
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
#$ -o $HOME/maqview_out.$JOB_ID
#$ -N maqview
#$ -l h_vmem=3G
#$ -pe smp-verbose 1


#############################################
# APPLICATION COMMANDS - change as required
#############################################
# For more M.A.Q Viewer usage information see:
#   http://maq.sourceforge.net/maqview-man.shtml
#
# The example data provided for use in this script was created by
# running the following commands.
#
#    wget http://tophat.cbcb.umd.edu/downloads/test_data.tar.gz
#    tar -xzf test_data.tar.gz
#    cd test_data
#    maq.pl easyrun test_ref.fa reads_1.fq reads_2.fq
#    mv easyrun example_data
#    tar -czf example_data.tar.gz example_data

if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading M.A.Q Viewer module
module load apps/maqview/0.2.5

# Output directory
OUTPUT_DIR="${HOME}/maqview/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Change to the output directory to ensure that any files will be
# created there.
cd $OUTPUT_DIR

# Copy in the input files
cp -rv "${DATA_DIR}/example_data/." .

# Index the example data.
maqindex -i "${OUTPUT_DIR}/all.map"

# Checks if a desktop/display view is available
if [ ! -z $DISPLAY ]; then
  # Launch maqview to visualize the data.
  # This requires a desktop/display view to function.
  maqview "${OUTPUT_DIR}/all.map"
fi

echo ""
echo "------------------------"
echo " M.A.Q Viewer completed"
echo "------------------------"
echo " Output is available in: $OUTPUT_DIR"
