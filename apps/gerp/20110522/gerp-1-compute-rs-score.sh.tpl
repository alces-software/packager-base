#!/bin/bash -l
#@      cw_TEMPLATE[name]="GERP++ v20110522 (GridScheduler)"
#@      cw_TEMPLATE[desc]="GERP++ example script. Analyze multiple alignments and computes RS scores"
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/gerp/gerp.1.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="gerp-1"
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
#$ -o $HOME/gerp_out.$JOB_ID
#$ -N gerp
#$ -pe smp-verbose 1


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For further GERP usage information see:
#   $GERPDOC/README.txt
# For more information about GERP, please refer to the website:
#   http://mendel.stanford.edu/SidowLab/downloads/gerp/

# Loading GERP++ module
module load apps/gerp/20110522

# Ensuring example data is available
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Output/working data directory
OUTPUT_DIR="${HOME}/gerp/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Setting input files
INPUT_FILE="${OUTPUT_DIR}/ENr111.aln"
TREE_FILE="${OUTPUT_DIR}/ENr111.tree"

# Gathering input files
cp -v "${DATA_DIR}/ENr111.aln" "${OUTPUT_DIR}/ENr111.aln"
cp -v "${DATA_DIR}/ENr111.tree" "${OUTPUT_DIR}/ENr111.tree"

# Moxing to working directory
cd "$OUTPUT_DIR"

# Specify options to use for gerpcol:
#
# -v   verbose mode
# -a   alignment in mfa format [default = false]
# -e <reference seq>
#      name of reference sequence
# -j   project out reference sequence
# -r <ratio>
#      Tr/Tv ratio [default = 2.0]
# -p <precision>
#      tolerance for rate estimation [default = 0.001]
# -z   force start at position 0 [default = false]
# -n <rate>
#      tree neutral rate [default = compute from tree]
# -s <factor>
#      tree scaling factor [default = 1.0]
GERPCOL_OPTIONS="-a -j human -e rfbat"

# Modify the output suffix if desired
# -x <suffix>
#      suffix for naming output files [default = ".rates"]
#OUTPUT_SUFFIX=".out"
if [ "$OUTPUT_SUFFIX" ]; then
  GERPCOL_OPTIONS="$GERPCOL_OPTIONS -x $OUTPUT_SUFFIX"
fi

# Execute gerpcol
gerpcol -t "$TREE_FILE" -f "$INPUT_FILE" \
  $GERPCOL_OPTIONS

echo ""
echo "-------------------"
echo " gerpcol completed"
echo "-------------------"
echo " Output is available in: $OUTPUT_DIR"
