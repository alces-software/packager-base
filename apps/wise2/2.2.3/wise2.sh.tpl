#!/bin/bash -l
#@      cw_TEMPLATE[name]="Wise2 v2.2.3 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Wise2 example script."
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
#$ -o $HOME/wise2_out.$JOB_ID
#$ -N wise2
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
#  For full Wise2 usage information see:
#  http://dendrome.ucdavis.edu/resources/tooldocs/wise2/doc_wise2.html
#

# Loading Wise2 module
module load apps/wise2/2.2.3

# Output data directory
OUTPUT_DIR="${HOME}/wise2/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -pv ${OUTPUT_DIR}

# Copying example files to working directory
cp -pv ${WISE2TESTDATA}/jason.* ${OUTPUT_DIR}/

# Running GeneWise
genewise "${OUTPUT_DIR}/jason.pep" "${OUTPUT_DIR}/jason.dna"

echo ""
echo "-----------------"
echo " Wise2 completed "
echo "-----------------"
echo " Output is available in: $OUTPUT_DIR"
