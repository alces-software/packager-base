#!/bin/bash -l
#@      cw_TEMPLATE[name]="fREEDA v2.0 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Execute the fREEDA simulator using one of the sample netlists provided."
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
#$ -o $HOME/freeda_out.$JOB_ID
#$ -N freeda
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################

# Loading fREEDA module
module load apps/freeda/2.0

# Output directory.
OUTPUT_DIR="${HOME}/freeda/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# The netlist to use; change this to use a different netlist
INPUT_FILE="${FREEDATEST}/testcir.net"

# The file under OUTPUT_DIR where command output should be written
OUTPUT_FILE="testcir.out"

cd "$OUTPUT_DIR"
freeda "$INPUT_FILE" "$OUTPUT_FILE"

echo ""
echo "-----------------"
echo " fREEDA completed"
echo "-----------------"
echo " Output is available in: $OUTPUT_DIR"
