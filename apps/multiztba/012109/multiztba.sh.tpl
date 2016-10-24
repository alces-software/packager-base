#!/bin/bash -l
#@      cw_TEMPLATE[name]="Multiz/TBA 012109 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Multiz/TBA example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/multiztba/multiztba.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="multiztba"
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
#$ -o $HOME/multiztba_out.$JOB_ID
#$ -N multiztba
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Multiz/TBA usage information see:
#   http://www.bx.psu.edu/miller_lab/dist/tba_howto.pdf
# NB this example requires sequence data to run

# Checking for example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading Multiz/TBA module
module load apps/multiztba/012109

# Output directory
OUTPUT_DIR="multiztba/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Create output directory if it doesn't already exist
mkdir -p $OUTPUT_DIR

# Gathering example data
cp -vr "${DATA_DIR}/." "${OUTPUT_DIR}/."

# Run all pairwise alignments, with default parameters:
cd $OUTPUT_DIR
all_bz + F=HUMAN "((((HUMAN (MOUSE RAT)) COW) OPOSSUM) CHICKEN)"

# To see the list of all pairwise MAF files
ls -ltr

# Build the multiple alignments
tba "((((HUMAN (MOUSE RAT)) COW) OPOSSUM) CHICKEN)" *.sing.maf tba_all.maf

# Project them on human
maf_project tba_all.maf HUMAN > tba_human.maf

# The output will be a maf file with a fairly large amount of comment lines at the beginning.
# All the blocks should have a HUMAN entry. Check that by comparing the result of (148 in my test):
grep -c "a score" tba_human.maf
grep -c "s HUMAN" tba_human.maf

echo ""
echo "-----------------"
echo " Multiz/TBA completed"
echo "-----------------"
echo " Output is available in: $OUTPUT_DIR"
