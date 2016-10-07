#!/bin/bash -l
#@      cw_TEMPLATE[name]="memtester 4.3.0 (GridScheduler)"
#@      cw_TEMPLATE[desc]="memtester example script."
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
#$ -o $HOME/memtester_out.$JOB_ID
#$ -N memtester
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For more information about memtester see:
#   http://pyropus.ca/software/memtester/

# Loading memtester module
module load apps/memtester/4.3.0

# Amount of memory to test, with suffix B, K, M or G
MEMORY=1M

# Limit to number of runs (default: none)
RUNS=5

# Additional command-line options ('memtester' for list)
#MEMTESTER_OPTIONS=

memtester $MEMTESTER_OPTIONS $MEMORY $RUNS
