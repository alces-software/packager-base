#!/bin/bash -l
#@      cw_TEMPLATE[name]="PLINK v1.90.150618 (GridScheduler)"
#@      cw_TEMPLATE[desc]="2 slot PLINK example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/plink/plink.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="plink-2proc"
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
#$ -pe smp-verbose 2


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

# Change the following to match the number of cores you want to
# run on.
#   (For GridScheduler tasks, this should match the number of
#   slots you request for use in the -pe scheduler directive
#   above.)
CORES=2

# Change the following to match the amount of memory required
# per core. (ie. the total memory the PLINK job will require /
# the number of cores being requested.)
#   (For GridScheduler tasks, this should match the amount of
#   memory per core requested in the "-l h_vmem" scheduler
#   directive above.)
MEM_MB_PER_CORE=1536

# Calculate how much RAM we should make available for a PLINK
# process, given the number of slots allocated and the default
# of {{ fact.hardMemoryLimitPerSlot | replace: 'G', '' }}GiB per slot (allowing 128MiB overhead).
PLINK_MEM_MB=$(($CORES * $MEM_MB_PER_CORE - 128))

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
# 1. each of the plink invocations below is set to use multiple threads
#    thread (`--threads $NSLOTS`).  If you only need a single thread
#    threads, you should use the single-core template
#    (available by selecting the alternative, single-core version of this
#    script).
# 2. the memory specified, `$PLINK_MEM_MB` MiB (`--memory
#    $PLINK_MEM_MB`) is calculated above based on the default
#    value of 4GiB per slot, allowing for 128MiB of overhead for
#    the binary process (4096 * $NSLOTS - 128).  If you need
#    more RAM, you should increase the amount you request per
#    slot and modify this number.
#=================================================================

# Verify that the file is intact and get some basic summary statistics.
plink --threads $CORES --memory $PLINK_MEM_MB \
  --file hapmap1

# Create a binary PED file. This more compact representation of the data
# saves space and speeds up subsequent analysis.
plink --threads $CORES --memory $PLINK_MEM_MB \
  --file hapmap1 --make-bed --out hapmap1

# Generate some simple summary statistics on rates of missing data in
# the file, using the --missing option. Note that we use the option
# --bfile to specify the binary file created in the previous step.
plink --threads $CORES --memory $PLINK_MEM_MB \
  --bfile hapmap1 --missing --out miss_stat

echo ""
echo "--------------------------"
echo "PLINK processing completed"
echo "--------------------------"
echo "Output is available in: $OUTPUT_DIR"
