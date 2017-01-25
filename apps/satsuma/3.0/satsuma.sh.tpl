#!/bin/bash -l
#@      cw_TEMPLATE[name]="Satsuma v3.0 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Execute Satsuma to perform exhaustive alignment using bundled sample query and target sequence."
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
#$ -o $HOME/satsuma_out.$JOB_ID
#$ -N satsuma
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Satsuma usage information see:
#   http://www.broadinstitute.org/ftp/distribution/software/spines/SpinesManual.pdf

# Loading Satsuma module
module load apps/satsuma

# Output directory
OUTPUT_DIR="${HOME}/satsuma/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Input directory
INPUT_DIR="${HOME}/satsuma/input"
mkdir -p $INPUT_DIR

# Query FASTA sequence
cp -pv "${SATSUMASAMPLES}/human.X.part.short.fasta" "${INPUT_DIR}/human.X.part.short.fasta"
QUERY_SEQUENCE=${INPUT_DIR}/human.X.part.short.fasta 

# Target FASTA sequence
cp -pv "${SATSUMASAMPLES}/dog.X.part.short.fasta" "${INPUT_DIR}/dog.X.part.short.fasta"
TARGET_SEQUENCE=${INPUT_DIR}/dog.X.part.short.fasta

# Additional command-line options (Satsuma -h for list)
SATSUMA_OPTIONS=""

$SATSUMABIN/Satsuma -q $QUERY_SEQUENCE -t $TARGET_SEQUENCE -o $OUTPUT_DIR $SATSUMA_OPTIONS


echo ""
echo "-------------------"
echo " Satsuma completed "
echo "-------------------"
echo " Output is available in: $OUTPUT_DIR"
