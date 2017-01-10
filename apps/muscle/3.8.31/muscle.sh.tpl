#!/bin/bash -l
#@      cw_TEMPLATE[name]="MUSCLE v3.8.31 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Execute muscle with FASTA input file (not included) to make a multiple sequence alignment (MSA)."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/muscle/muscle.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="muscle"
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
#$ -o $HOME/muscle_out.$JOB_ID
#$ -N muscle
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full MUSCLE usage information see:
#   http://www.drive5.com/muscle/manual/
# NB no sample input data is supplied with MUSCLE. The file seqs.fa (or
# equivalent) must be supplied by the user

# Ensuring example data is available
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading MUSCLE module
module load apps/muscle/3.8.31

# Output directory
OUTPUT_DIR="${HOME}/muscle/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Output directory
INPUT_DIR="${HOME}/muscle/input"
mkdir -p $INPUT_DIR

# Copying example files to working directory
cp -pv "${DATA_DIR}/example_in.faa" "${INPUT_DIR}/example_in.faa"

# Input file in FASTA format
INPUT_FILE="${INPUT_DIR}/example_in.faa"

# Output alignment in FASTA format
OUTPUT_FILE="${OUTPUT_DIR}/example_out.afa"

# Additional command-line options ('muscle' for list)
#MUSCLE_OPTIONS=

# Running MUSCLE
muscle -in $INPUT_FILE -out $OUTPUT_FILE


echo ""
echo "------------------"
echo " MUSCLE completed "
echo "------------------"
echo " Output is available in: $OUTPUT_DIR"
