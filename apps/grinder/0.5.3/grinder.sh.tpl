#!/bin/bash -l
#@      cw_TEMPLATE[name]="Grinder v0.5.3 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Grinder example script. Run Grinder on a FASTA database with a specified coverage"
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/grinder/human.1.rna.fna.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="grinder"
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
#$ -o $HOME/grinder_out.$JOB_ID
#$ -N grinder
#$ -pe smp-verbose 1


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Grinder usage information see:
#   http://sourceforge.net/projects/biogrinder/files/?source=navbar

# Loading Grinder module
module load apps/grinder/0.5.3

# Ensuring example data is available
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Input directory
INPUT_DIR="${HOME}/grinder/input"
mkdir -p "${INPUT_DIR}"

# Output directory
OUTPUT_DIR="${HOME}/grinder/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Collecting test data
cp "${DATA_DIR}/human.1.rna.fna" "${INPUT_DIR}/human.1.rna.fna"

# FASTA file that contains the input reference sequences
INPUT_SEQS="${INPUT_DIR}/human.1.rna.fna"

# Desired fold coverage of the input reference sequences
COVERAGE_FOLD="0.1"

# Additional command-line options
GRINDER_OPTIONS=""

# Run Grinder command line
grinder "$GRINDER_OPTIONS" \
  -reference_file "$INPUT_SEQS" \
  -coverage_fold "$COVERAGE_FOLD" \
  -output_dir "$OUTPUT_DIR" 

echo ""
echo "-------------------"
echo " Grinder completed"
echo "-------------------"
echo " Output is available in: $OUTPUT_DIR"
