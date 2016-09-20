#!/bin/bash -l
#@      cw_TEMPLATE[name]="IOzone 3.420 (GridScheduler)"
#@      cw_TEMPLATE[desc]="IOzone example script."
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
#$ -o $HOME/iozone_out.$JOB_ID
#$ -N iozone
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For detailed IOzone usage information see:
#   http://www.iozone.org/docs/IOzone_msword_98.pdf

# Loading iozone module
module load apps/iozone/3.420

# Command-line options ('iozone -h' for a list)
IOZONE_OPTIONS="-s 16m -t 2"

iozone $IOZONE_OPTIONS
