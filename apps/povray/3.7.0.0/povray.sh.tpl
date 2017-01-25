#!/bin/bash -l
#@      cw_TEMPLATE[name]="POV-Ray v3.7.0.0 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Execute povray to render the bundled test biscuit scene."
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
#$ -o $HOME/povray_out.$JOB_ID
#$ -N povray
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Velvet usage information see:
#   http://www.povray.org/documentation/

# Loading POV-Ray module
module load apps/povray

# Output directory (trailing slash required)
OUTPUT_DIR="${HOME}/povray/output.${JOB_ID-${PORTAL_TASK_ID-$$}}/"
mkdir -p "$OUTPUT_DIR"

# Input directory
INPUT_DIR="${HOME}/povray/input"
mkdir -p "$INPUT_DIR"

# Setting and retreiving example input file
INPUT_FILE="${INPUT_DIR}/biscuit.pov"
cp "${POVRAYSHARE}/scenes/advanced/biscuit.pov" "${INPUT_DIR}/biscuit.pov"

# Additional command-line options
POVRAY_OPTIONS="+d +p +v +w320 +h240 +a0.3 +L${POVRAYSHARE}/include"

# Running POV-Ray
povray $INPUT_FILE +O$OUTPUT_DIR $POVRAY_OPTIONS

echo ""
echo "-------------------"
echo " POV-Ray completed "
echo "-------------------"
echo " Output is available in: $OUTPUT_DIR"
