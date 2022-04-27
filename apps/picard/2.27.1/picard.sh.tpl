#!/bin/bash -l
#@      cw_TEMPLATE[name]="Picard v2.27.1 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Sorting and removal of duplicate entries in BAM file"
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/picard/picard.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="picard"
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
#$ -o $HOME/picard_out.$JOB_ID
#$ -N picard
#$ -l h_vmem=3G
#$ -pe smp-verbose 1


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Picard usage information see:
#   https://github.com/broadinstitute/picard

# Checking for availability of example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading Picard module
module load apps/picard

# Input directory
INPUT_DIR="${HOME}/picard/input"
mkdir -p "${INPUT_DIR}"

# Output directory
OUTPUT_DIR="${HOME}/picard/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Fetching example data
cp -p "${DATA_DIR}/picard.bam" "${INPUT_DIR}/picard.bam"

# Setting Compressed Class Space Size so that the Java VM can start on Grid Engine.
export PICARD_JAVA_EXTRA_OPTS="${PICARD_JAVA_EXTRA_OPTS} -XX:CompressedClassSpaceSize=64m"

echo ""
echo "-----------------"
echo " Sorting entries "
echo "-----------------"
echo ""

# Sorting of entries ready for duplicate removal
java -Xmx2g -XX:-UseCompressedClassPointers -XX:CompressedClassSpaceSize=64m \
  -jar "${PICARDJAVA}/picard.jar" \
  SortSam \
  I="${INPUT_DIR}/picard.bam" \
  O="${OUTPUT_DIR}/picard.sorted.bam" \
  SORT_ORDER=coordinate

echo ""
echo "------------------"
echo " Sorting complete "
echo "------------------"

echo ""
echo "---------------------"
echo " Removing duplicates "
echo "---------------------"
echo ""

# Marking and removal of duplicate entries
java -Xmx2g -XX:-UseCompressedClassPointers -XX:CompressedClassSpaceSize=64m \
  -jar "${PICARDJAVA}/picard.jar" \
  MarkDuplicates \
  REMOVE_DUPLICATES=true \
  I="${OUTPUT_DIR}/picard.sorted.bam" \
  O="${OUTPUT_DIR}/marked_duplicates.bam" \
  M="${OUTPUT_DIR}/marked_dup_metrics.txt"

echo ""
echo "-------------------"
echo " Removing complete "
echo "-------------------"
echo ""

echo ""
echo "------------------"
echo " Picard completed "
echo "------------------"
echo " Output is available in: ${OUTPUT_DIR}"
