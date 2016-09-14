#!/bin/bash -l
#@      cw_TEMPLATE[name]="PLINK v1.90.150618 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Single process PLINK example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/plink/plink.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="plink-1proc"
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
#$ -o $HOME/plink_out.$JOB_ID
#$ -N plink
#$ -l h_vmem=3G
#$ -pe smp-verbose 1


#=========
#  PLINK
#---------
# For more plink usage information see:
#   https://www.cog-genomics.org/plink2/general_usage

# The example data used in this script is available from
# http://pngu.mgh.harvard.edu/~purcell/plink/hapmap1.zip

# Cheching for default example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading PLINK module
module load apps/plink/1.90.150618

# Create the output/working data directory and change to the directory
# to ensure that any files will be created there.
OUTPUT_DIR="${HOME}/plink/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

# Copy the example data to the output directory.
cp -r "${DATA_DIR}/." .

#=================================================================
# PLEASE NOTE
#-----------------------------------------------------------------
# 1. each of the plink invocations below is set to use a single
#    thread (`--threads 1`).  If you want to use multiple
#    threads, you should use the SMP multi-slot template
#    (available by selecting the alternative, SMP version of this
#    script).
# 2. the memory specified, 3968MiB (`--memory 3968`) allows for
#    128MiB of overhead for the binary process given a 4GiB
#    request for this job.  If you need more RAM, you should
#    increase the amout you request and modify this number.
#=================================================================

# Verify that the file is intact and get some basic summary statistics.
plink --threads 1 --memory 3072 \
  --file hapmap1

# Create a binary PED file. This more compact representation of the data
# saves space and speeds up subsequent analysis.
plink --threads 1 --memory 3072 \
  --file hapmap1 --make-bed --out hapmap1

# Generate some simple summary statistics on rates of missing data in
# the file, using the --missing option. Note that we use the option
# --bfile to specify the binary file created in the previous step.
plink --threads 1 --memory 3072 \
  --bfile hapmap1 --missing --out miss_stat

echo ""
echo "--------------------------"
echo "PLINK processing completed"
echo "--------------------------"
echo "Output is available in: $OUTPUT_DIR"
