#!/bin/bash -l
#@      cw_TEMPLATE[name]="VCFtools v0.1.14 (GridScheduler)"
#@      cw_TEMPLATE[desc]="VCFtools example script."
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
#$ -o $HOME/vcftools_out.$JOB_ID
#$ -N vcftools


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# Documentation for usage of VCFtools can be found at the following link.
# https://vcftools.github.io/examples.html
#
# A manual page is also available at $VCFTOOLSDIR/share/man/man1/vcftools.1
#

# Loading VCFtools module
module load apps/vcftools

# Output/working data directory
OUTPUT_DIR="${HOME}/vcftools/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Input directory
INPUT_DIR="${HOME}/vcftools/input"
mkdir -p "$INPUT_DIR"

# Copy in the input files
cp -pv "${VCFTOOLSDIR}/examples/contrast.vcf" "${INPUT_DIR}/"

# Displaying basic file statistics
echo ""
echo ""
echo "--------------------------------------------------------------------------------"
echo "   Basic file statistics "
echo "--------------------------------------------------------------------------------"
vcftools --vcf "${INPUT_DIR}/contrast.vcf" --out "${OUTPUT_DIR}/"

# Filtering for variants and writing them to another file
echo ""
echo ""
echo "--------------------------------------------------------------------------------"
echo "   Filtering for variants "
echo "--------------------------------------------------------------------------------"
vcftools --vcf "${INPUT_DIR}/contrast.vcf" --chr 1 --from-bp 1000000 --to-bp 2000000 --recode --recode-INFO-all --out "${OUTPUT_DIR}/filtered_data"

# Comparing the original file against the generated filtered file
echo ""
echo ""
echo "--------------------------------------------------------------------------------"
echo "   Comparing original data to filtered data "
echo "--------------------------------------------------------------------------------"
vcftools --vcf "${INPUT_DIR}/contrast.vcf" --diff "${OUTPUT_DIR}/filtered_data.recode.vcf" --diff-indv --out "${OUTPUT_DIR}/compare"


echo ""
echo "--------------------------------------------------------------------------------"
echo "   VCFtools completed "
echo "--------------------------------------------------------------------------------"
echo " Output is available in: ${OUTPUT_DIR}"
