#!/bin/bash -l
#@      cw_TEMPLATE[name]="MODELLER v4.6.5 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Execute model-default.py using bundled example Protein Data Bank (PDB) files and alignment/script file."
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
#$ -o $HOME/modeller_out.$JOB_ID
#$ -N modeller
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For detailed MODELLER usage information see:
#  http://salilab.org/modeller/9.14/manual/

# Loading MODELLER module
module load apps/modeller/9.14

# Output directory
OUTPUT_DIR="${HOME}/modeller/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Copying input files
cd $OUTPUT_DIR
cp -v $MODELLEREXAMPLES/automodel/model-default.py \
  $MODELLEREXAMPLES/automodel/alignment.ali \
  $MODELLEREXAMPLES/atom_files/* .

# Running MODELLER
mod9.14 model-default.py > model-default.log

echo ""
echo "--------------------"
echo " MODELLER completed "
echo "--------------------"
echo " Output is available in: $OUTPUT_DIR"
