#!/bin/bash -l
#@      cw_TEMPLATE[name]="PAML v4.7a (GridScheduler)"
#@      cw_TEMPLATE[desc]="Execute codeml and then baseml using the sample control files supplied with PAML."
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
#$ -o $HOME/paml_out.$JOB_ID
#$ -N paml
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For detailed PAML usage information see:
#   http://abacus.gene.ucl.ac.uk/software/pamlDOC.pdf
# This example script uses the sample control files supplied with PAML

# Output directory
OUTPUT_DIR="${HOME}/paml/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Copying example data
cp -r $PAMLDATA/* $OUTPUT_DIR

# Moving to output directory ready to process
cd $OUTPUT_DIR

# Running 'codeml' and 'baseml' on example data
codeml
baseml

echo ""
echo "----------------"
echo " PAML completed "
echo "----------------"
echo " Output is available in: $OUTPUT_DIR"
