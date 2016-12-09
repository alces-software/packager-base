#!/bin/bash -l
#@      cw_TEMPLATE[name]="HPL v2.1 - 8 processes (GridScheduler)"
#@      cw_TEMPLATE[desc]="8 process MPI example script."
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
#$ -o $HOME/hpl_out.$JOB_ID
#$ -N hpl
#$ -l h_vmem=1536M
#$ -pe mpislots-verbose 8


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For more information about configuring HPL see:
#   http://www.netlib.org/benchmark/hpl/

# Loading HPL module
module load apps/hpl/2.1

# Output directory
OUTPUT_DIR="${HOME}/hpl/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Copying the example HPL.dat input data file, tuned as required
# (An example is supplied in the HPLEXAMPLES directory)
cp "$HPLEXAMPLES/hpl-8proc.alces.dat" "$OUTPUT_DIR/HPL.dat"

# Change the working directory and run the job
cd "$OUTPUT_DIR" && mpirun xhpl

echo ""
echo "---------------"
echo " hpl completed "
echo "---------------"
echo " Output is available in: $OUTPUT_DIR"
