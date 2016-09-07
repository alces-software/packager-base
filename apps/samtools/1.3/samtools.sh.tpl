#!/bin/bash -l
#@      cw_TEMPLATE[name]="SAM Tools v1.3 (GridScheduler)"
#@      cw_TEMPLATE[desc]="SAM Tools example script."
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
#$ -j y
#$ -o $HOME/samtools_out.$JOB_ID
#$ -V
#$ -N samtools


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# samtools offers many different commands; this example script
# demonstrates using the 'mpileup' command to create a VCF file of
# variants from a FASTA file and a BAM file.
#
# For full samtools usage information see:
#   http://www.htslib.org/doc/

# File $SAMTOOLSEXAMPLES/ex1.fa contains two sequences cut from the
# human genome build36.  They were exatracted with command:
#
#     samtools faidx human_b36.fa 2:2043966-2045540 20:67967-69550
#
# Sequence names were changed manually for simplicity. File
# $SAMTOOLSEXAMPLES/ex1.sam.gz contains MAQ alignments extracted with:
#
#    (samtools view NA18507_maq.bam 2:2044001-2045500;
#     samtools view NA18507_maq.bam 20:68001-69500)
#
# and processed with `samtools fixmate' to make it self-consistent as a
# standalone alignment.


# Loading module
module load apps/samtools/1.3

# Output directory
OUTPUT_DIR="${HOME}/samtools/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Create the output/working data directory
mkdir -p "$OUTPUT_DIR"

# Copy in the example input files
cp "$SAMTOOLSEXAMPLES"/ex1.* "$OUTPUT_DIR"

# Navigating to working directory
cd "$OUTPUT_DIR"

# Setting filename variables
FASTA_FILE=ex1.fa
SAM_FILE=ex1.sam.gz
INDEXED_FASTA=ex1.fa.fai
BAM_FILE=ex1.bam
UNCOMPRESSED_VCF=ex1.vcf

# Index the reference FASTA.
samtools faidx "$FASTA_FILE"

# Convert the (headerless) SAM file to BAM.  Note if we had used
# "samtools view -h" above to create the ex1.sam.gz then we could omit
# the "-t ex1.fa.fai" option here.
samtools view -S -b -t "$INDEXED_FASTA" -o "$BAM_FILE" "$SAM_FILE"

# Build an index for the BAM file:
samtools index "$BAM_FILE"

# Generate an uncompressed VCF file of variants:
samtools mpileup -vu -f "$FASTA_FILE" "$BAM_FILE" > "$UNCOMPRESSED_VCF"

echo ""
echo "-----------------"
echo " samtools completed"
echo "-----------------"
echo " Output is available in: $OUTPUT_DIR"
