#!/bin/bash -l
#@      cw_TEMPLATE[name]="IMB v4.0 - 4 processes (GridScheduler)"
#@      cw_TEMPLATE[desc]="4 process IMB example script."
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
#$ -j y
#$ -o $HOME/imb_out.$JOB_ID
#$ -V
#$ -N imb
#$ -pe mpislots-verbose 4


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For more information about IMB options see:
#   http://www.intel.com/software/imb

module load apps/imb/4.0

# Output directory
OUTPUT_DIR="${HOME}/imb/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Additional command-line options ('IMB-MPI1 -help' for a list)
IMB_OPTIONS=

mpirun IMB-MPI1 $IMB_OPTIONS > $OUTPUT_DIR/IMB-MPI1.report 2>&1
