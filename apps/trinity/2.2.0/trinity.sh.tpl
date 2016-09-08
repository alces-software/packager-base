#!/bin/bash -l
#@      cw_TEMPLATE[name]="Trinity 2.2.0 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Trinity example script."
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
#$ -o $HOME/trinity_out.$JOB_ID
#$ -N trinity
#$ -l h_vmem=3G
#$ -pe smp-verbose 1

#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Trinity usage information see:
#   http://trinityrnaseq.sourceforge.net/#running_trinity

# Loading TRinity module
module load apps/trinity/2.2.0

# Change the following to match the number of cores you want to
# run on.
#   (For GridScheduler tasks, this should match the number of
#   slots you request for use in the -pe scheduler directive
#   above.)
CORES=1

# Change the following to match the amount of memory required
# per core. (ie. the total memory the Trinity job will require /
# the number of cores being requested.)
#   (For GridScheduler tasks, this should match the amount of
#   memory per core requested in the "-l h_vmem" scheduler
#   directive above.)
MEM_GB_PER_CORE=2

# This calculation is performed as Trinity requires the total
# amount of RAM available, which is calculated using the values
# specified for CORES and MEM_GB_PER_CORE above.
# Usually, you would not need to change this.
MEM_GB_TOTAL=$(($MEM_GB_PER_CORE * $CORES))

# Java has an overhead of around 1GB that needs to be accounted
# for, so we reduce the amount of memory that will be provided
# to Trinity by 1G per core (so that Parafly is able to
# parallelize correctly) and 1G in total (so that single
# processes are able to make use of all the RAM available to
# this task).
JAVA_MEM_GB_PER_CORE=$(($MEM_GB_PER_CORE - 1))
JAVA_MEM_GB_TOTAL=$(($MEM_GB_TOTAL - 1))

# Output directory
OUTPUT_DIR="${HOME}/trinity/output.${JOB_ID-${PORTAL_TASK_ID-$$}}/trinity"
mkdir -p $OUTPUT_DIR

# Type of reads ('fa' or 'fq')
SEQ_TYPE=fq

# Input directory
INPUT_DIR="${HOME}/trinity/input"

# Left reads
LEFT_READS="$INPUT_DIR/reads.left.fq"

# Right reads
RIGHT_READS="$INPUT_DIR/reads.right.fq"

# Additional command-line options (run Trinity with no options for a list)
#TRINITY_OPTIONS=

# Prepare input data.
# This example retrieves test data bundles with the Trinity
# application, and places it in the INPUT_DIR directory.
if [ ! -f $LEFT_READS -o ! -f $RIGHT_READS ]; then
  mkdir -p "$INPUT_DIR"
  cp "$TRINITYDIR"/sample_data/test_Trinity_Assembly/reads.{left,right}.fq.gz "$INPUT_DIR"
  for a in "$INPUT_DIR"/*.fq.gz; do
    gunzip $a
  done
fi

Trinity $TRINITY_OPTIONS \
  --seqType $SEQ_TYPE \
  --left "$LEFT_READS" --right "$RIGHT_READS" \
  --output "${OUTPUT_DIR}" \
  --max_memory ${JAVA_MEM_GB_TOTAL}G \
  --bflyHeapSpaceMax ${JAVA_MEM_GB_PER_CORE}G \
  --CPU $CORES

echo ""
echo "-------------------"
echo " Trinity completed"
echo "-------------------"
echo " Output is available in: $OUTPUT_DIR"
