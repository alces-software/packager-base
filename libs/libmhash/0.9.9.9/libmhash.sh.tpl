#!/bin/bash -l
#@      cw_TEMPLATE[name]="Libmhash v0.9.9.9 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Basic hashing of a string"
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="lib/libmhash/libmhash.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="libmhash"
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
#$ -o $HOME/libmhash_out.$JOB_ID
#$ -N libmhash
#$ -pe smp-verbose 1


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full MCrypt usage information see:
#   http://mcrypt.sourceforge.net/

# Checking for availability of example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading Libmhash module
module load libs/libmhash

# Input directory
INPUT_DIR="${HOME}/libmhash/input"
mkdir -p "${INPUT_DIR}"

# Output directory
OUTPUT_DIR="${HOME}/libmhash/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Fetching example 
cp -p "${DATA_DIR}/libmhash-example.c" "${INPUT_DIR}/libmhash-example.c"

# Compiling example of libmhash
gcc -I$LIBMHASHINCLUDE ${INPUT_DIR}/libmhash-example.c -L$LIBMHASHLIB -lmhash -o ${OUTPUT_DIR}/libmhash-example

echo "---------------------------"
echo " Running Libmhash example "
echo "---------------------------"
echo ""

# Running generated example file
${OUTPUT_DIR}/libmhash-example <<< "Text to hash" EOF


echo ""
echo "--------------------"
echo " Libmhash completed "
echo "--------------------"
