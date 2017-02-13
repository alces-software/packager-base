#!/bin/bash -l
#@      cw_TEMPLATE[name]="InterProScan v5.21.60.0 (GridScheduler)"
#@      cw_TEMPLATE[desc]="InterProScan example script."
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
#$ -o $HOME/iprscan_out.$JOB_ID
#$ -N iprscan
#$ -l h_vmem=2G
#$ -pe smp-verbose 4


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For InterProScan usage information see:
#   https://github.com/ebi-pf-team/interproscan/wiki/HowToRun

# Loading InterProScan module
module load apps/iprscan/5.21.60.0

# Input directory
INPUT_DIR="${HOME}/iprscan/input"
mkdir -p $INPUT_DIR

# Output directory
OUTPUT_DIR="${HOME}/iprscan/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Path to FASTA file that should be loaded on Master startup
# NB location must be writeable
INPUT_FILE="${INPUT_DIR}/test_proteins.fasta"
cp -pv "${IPRSCANDIR}/test/test_proteins.fasta" $INPUT_FILE

# Comma separated list of output formats
OUTPUT_FORMATS=TSV

echo ""
echo "-----------------------"
echo " Starting InterProScan "
echo "-----------------------"
echo ""

# Running InterProScan
interproscan.sh -i $INPUT_FILE -f $OUTPUT_FORMATS -d $OUTPUT_DIR


echo ""
echo "------------------------"
echo " InterProScan completed "
echo "------------------------"
echo " Output is available in: $OUTPUT_DIR"
