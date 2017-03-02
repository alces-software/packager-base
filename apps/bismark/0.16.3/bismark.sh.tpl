#!/bin/bash -l
#@      cw_TEMPLATE[name]="Bismark v0.16.3 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Bismark example script."
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
#$ -o $HOME/bismark_out.$JOB_ID
#$ -N bismark
#$ -l h_vmem=768M
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# Documentation for usage of VCFtools can be found at the following link.
# https://vcftools.github.io/examples.html
#
# A manual page is also available at $VCFTOOLSDIR/share/man/man1/vcftools.1
#


# Loading Bismark module
module load apps/bismark

# Output/working data directory
OUTPUT_DIR="${HOME}/bismark/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Input directory
INPUT_DIR="${HOME}/bismark/input"
mkdir -p "${INPUT_DIR}"

# Genome directory
GENOME_DIR="${INPUT_DIR}/genome"
mkdir -p "${GENOME_DIR}"

# Fetching test data
wget "https://raw.githubusercontent.com/FelixKrueger/Bismark/master/test_data.fastq" -P "${INPUT_DIR}"

# Fetching example genome and extracting data
wget "ftp://ftp.ensembl.org/pub/release-87/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_sm.chromosome.MT.fa.gz" -P "${GENOME_DIR}"
gunzip "${GENOME_DIR}/Homo_sapiens.GRCh38.dna_sm.chromosome.MT.fa.gz"

# Indexing the downloaded genome data/database
echo ""
echo ""
echo "--------------------------------------------------------------------------------"
echo "   Preparing genome database "
echo "--------------------------------------------------------------------------------"
bismark_genome_preparation "${GENOME_DIR}"

# Filtering for variants and writing them to another file
echo ""
echo ""
echo "--------------------------------------------------------------------------------"
echo "   Running Bismark "
echo "--------------------------------------------------------------------------------"
bismark "${GENOME_DIR}" "${INPUT_DIR}/test_data.fastq" -o "${OUTPUT_DIR}"

# Extracting methylation data
echo ""
echo ""
echo "--------------------------------------------------------------------------------"
echo "   Extracting context-dependent (CpG/CHG/CHH) methylation data "
echo "--------------------------------------------------------------------------------"
bismark_methylation_extractor -s --comprehensive "${OUTPUT_DIR}/test_data_bismark_bt2.sam.gz" -o "${OUTPUT_DIR}"

echo ""
echo "--------------------------------------------------------------------------------"
echo "   Bismark completed "
echo "--------------------------------------------------------------------------------"
echo " Output is available in: ${OUTPUT_DIR}"
