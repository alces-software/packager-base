#!/bin/bash -l
#@      cw_TEMPLATE[name]="GERP++ v20110522 (GridScheduler)"
#@      cw_TEMPLATE[desc]="GERP++ example script. Find constrained elements given RS scores produced by gerpcol"
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/gerp/gerp.2.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="gerp-2"
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
INPUT_FILE="${OUTPUT_DIR}/ENr111.aln.rates"

# Gathering input files
cp -v "${DATA_DIR}/ENr111.aln.rates" "${OUTPUT_DIR}/ENr111.aln.rates"

# Moving to working directory
cd "$OUTPUT_DIR"

# Specify options to use for gerpelem:
#
# -v   verbose mode
# -c <chromosome> [default = none]
# -s <start offset> [default = 0]
# -w <suffix>
#      suffix for naming exclusion region file [default = no output]
# -l <length>
#      minimum element length [default = 4]
# -L <length>
#      maximum element length [default = 2000]
# -t <inverse tolerance>
#      inverse of the rounding tolerance [default = 10]
# -d <threshold>
#      depth threshold for shallow columns, in substitutions per site [default = 0.5]
# -p <penalty>
#      penalty coefficient for shallow columns, as fraction of the median neutral rate [default = 0.5]
# -b <number>
#      number of border nucleotides for shallow regions [default = 2]
# -a <number>
#     total number of allowed non-border shallow nucleotides per element [default = 10]
# -e <ratio>
#     acceptable false positive rate [default = 0.05]
# -q <value>
#     denominator for minimum candidate element score formula [default = 10.0]
# -r <value>
#     exponent for minimum candidate element score formula [default = 1.15]
GERPELEM_OPTIONS=""

# Modify the output suffix if desired (defaults to '.elems')
# -x <suffix>
#      suffix for naming output files [default = ".elems"]
#OUTPUT_SUFFIX=".out"
if [ "$OUTPUT_SUFFIX" ]; then
  GERPELEM_OPTIONS="$GERPELEM_OPTIONS -x $OUTPUT_SUFFIX"
fi

# Execute gerpelem
gerpelem -f $INPUT_FILE \
  $GERPELEM_OPTIONS

echo ""
echo "-------------------"
echo " gerpelem completed"
echo "-------------------"
echo " Output is available in: $OUTPUT_DIR"
