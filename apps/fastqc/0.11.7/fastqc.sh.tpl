#!/bin/bash -l
#@      cw_TEMPLATE[name]="FastQC v0.11.3 (GridScheduler)"
#@      cw_TEMPLATE[desc]="FastQC example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/fastqc/fastqc.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="fastqc"
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
#$ -o $HOME/fastqc_out.$JOB_ID
#$ -N fastqc
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full FastQC usage information see:
#   http://www.bioinformatics.babraham.ac.uk/projects/fastqc/
#
# For command-line options, run: fastqc --help

# Checking for example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading FastQC module
module load apps/fastqc/0.11.3

# Configure input directory
INPUT_DIR="${HOME}/fastqc/input"
mkdir -p $INPUT_DIR

# Configure output directory
OUTPUT_DIR="${HOME}/fastqc/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Getting example input data files
cp "${DATA_DIR}/ilmn_example.fq" "${INPUT_DIR}/."

# Specify the number of files which can be processed
# simultaneously.  Each thread will be allocated 250MB of
# memory.
#   (For GridScheduler tasks, you should update the amount of
#   memory per core requested in the "-l h_vmem" scheduler
#   directive above to 250M.)
THREADS=2

# Specify the length of Kmer to look for in the Kmer content
# module. Specified Kmer length must be between 2 and 10. Default
# length is 5 if -k parameter is not specified.
KMER_LENGTH=5

# Input file (or files)
INPUT_FILES=("${INPUT_DIR}/ilmn_example.fq")

# Command-line options (run `fastqc --help` for a list).
FASTQC_OPTIONS=""

# Execute fastqc
fastqc -o "$OUTPUT_DIR" \
  -t $THREADS \
  -k $KMER_LENGTH \
  $FASTQC_OPTIONS \
  "${INPUT_FILES[@]}"

echo ""
echo "------------------"
echo " fastqc completed"
echo "------------------"
echo " Output is available in: $OUTPUT_DIR"
