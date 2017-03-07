#!/bin/bash -l
#@      cw_TEMPLATE[name]="Bowtie 2 v2.3.0 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Bowtie 2 example script."
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
#$ -o $HOME/bowtie2_out.$JOB_ID
#$ -N bowtie2
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Bowtie 2 usage information see:
#   http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml

# Loading Bowtie 2 module
module load apps/bowtie2/2.3.0

# Input directory
INPUT_DIR="${HOME}/bowtie2/input"

# Output directory
OUTPUT_DIR="${HOME}/bowtie2/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Base name of index for reference genome (up to final .1.bt2 etc.)
INDEX_BASE=$OUTPUT_DIR/lambda_virus

# Comma-separated list of files containing unpaired reads to be aligned
UNPAIRED_READS="${INPUT_DIR}/reads_1.fq"

# File to write SAM alignments to (default is stdout)
OUTPUT_FILE="${OUTPUT_DIR}/eg1.sam"

# Additional command-line options (bowtie2 -h for a list)
BOWTIE2_OPTIONS=

# Create input directory if it doesn't already exist
mkdir -p $INPUT_DIR

# Create output directory if it doesn't already exist
mkdir -p $OUTPUT_DIR

# Getting input data
cp "$BOWTIE2DIR/example/reference/lambda_virus.fa" "$INPUT_DIR/."
cp "$BOWTIE2DIR/example/reads/reads_1.fq" "$INPUT_DIR/."

# Index reference genome
bowtie2-build "$INPUT_DIR/lambda_virus.fa" "$INDEX_BASE"

# Align example reads
bowtie2 -x $INDEX_BASE -U $UNPAIRED_READS -S $OUTPUT_FILE $BOWTIE2_OPTIONS
