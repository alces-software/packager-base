#!/bin/bash -l
#@      cw_TEMPLATE[name]="LibMCrypt v2.5.8 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Basic encryption and decryption of a string"
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="lib/libmcrypt/libmcrypt.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="libmcrypt"
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
#$ -o $HOME/libmcrypt_out.$JOB_ID
#$ -N libmcrypt
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

# Loading MCrypt module
module load libs/libmcrypt

# Input directory
INPUT_DIR="${HOME}/libmcrypt/input"
mkdir -p "${INPUT_DIR}"

# Output directory
OUTPUT_DIR="${HOME}/libmcrypt/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Fetching example 
cp -p "${DATA_DIR}/libmcrypt-example.c" "${INPUT_DIR}/libmcrypt-example.c"

# Compiling example of libmcrypt
gcc -I$LIBMCRYPTINCLUDE ${INPUT_DIR}/libmcrypt-example.c -L$LIBMCRYPTLIB -lmcrypt -o ${OUTPUT_DIR}/libmcrypt-example

echo "---------------------------"
echo " Running LibMCrypt example "
echo "---------------------------"

# Running generated example file
${OUTPUT_DIR}/libmcrypt-example


echo ""
echo "---------------------"
echo " LibMCrypt completed "
echo "---------------------"
