#!/bin/bash -l
#@      cw_TEMPLATE[name]="MACS 2.1.0.20150731 (GridScheduler)"
#@      cw_TEMPLATE[desc]="MACS example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/macs/macs.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="macs"
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
#$ -o $HOME/macs_out.$JOB_ID
#$ -N macs
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full `MACS callpeak` usage information see:
#   https://github.com/taoliu/MACS#call-peaks

# Checking for example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading MACS module
module load apps/macs/2.1.0.20150731

# Input directory
INPUT_DIR="${HOME}/macs/input"

# Output directory
OUTPUT_DIR="${HOME}/macs/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Additional command-line options
MACS_OPTIONS=""

# Format of tag file, can be "ELAND", "BED", "ELANDMULTI",
# "ELANDEXPORT", "ELANDMULTIPET" (for pair-end tags), "SAM",
# "BAM", "BOWTIE" or "BAMPE". Default is "AUTO" which will allow
# MACS to decide the format automatically. "AUTO" is also
# usefule when you combine different formats of files.
FORMAT="AUTO"

# The name string of the experiment. MACS will use this string
# NAME to create output files like 'NAME_peaks.xls',
# 'NAME_negative_peaks.xls', 'NAME_peaks.bed' ,
# 'NAME_summits.bed', 'NAME_model.r' and so on. So please avoid
# any confliction between these filenames and your existing
# files.
NAME="run_callpeak_narrow"

# Variables governing input
IN_CHIP="$INPUT_DIR/CTCF_ChIP_200K.bed.gz"
IN_CTRL="$INPUT_DIR/CTCF_Control_200K.bed.gz"

# Set up input data
if [ ! -d "$INPUT_DIR" ]; then
    mkdir -p "$INPUT_DIR"
    cp -v "$DATA_DIR"/* "$INPUT_DIR"
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Execute MACS
macs2 callpeak \
  -f $FORMAT \
  -t "$IN_CHIP" \
  -c "$IN_CTRL" \
  --outdir "$OUTPUT_DIR" \
  -n "$NAME" \
  -B --call-summits $MACS_OPTIONS 2>&1 | tee -a "$OUTPUT_DIR/$NAME.log"
