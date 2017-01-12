#!/bin/bash -l
#@      cw_TEMPLATE[name]="Oases v0.2.08 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Execute velveth for a single input file and velvetg and oases on the results"
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
#$ -o $HOME/oases_out.$JOB_ID
#$ -N oases
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Velvet usage information see:
#   http://www.ebi.ac.uk/~zerbino/velvet/Manual.pdf
#   or: $VELVETDIR/doc/Manual.pdf
# For more information about Velvet, please refer to the website:
#   http://www.ebi.ac.uk/~zerbino/velvet/
#
# For full Oases usage information see:
#   http://www.ebi.ac.uk/~zerbino/oases/OasesManual.pdf
#   or: $OASESDIR/doc/OasesManual.pdf
# For more information about Oases, please refer to the website:
#   http://www.ebi.ac.uk/~zerbino/oases/

#Loading Oases and Velvet modules
module load apps/oases
module load apps/velvet

# Output data directory
OUTPUT_DIR="${HOME}/oases/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "$OUTPUT_DIR"

# Hash length.
# Either: an odd integer <= the max kmer length
#     Or: m,M,s where m and M are odd integers with m < M <= the max kmer
#         length
#
# If an odd integer is provided it will be decremented, and if a value
# higher than the max kmer length is specified (usually 31), it will
# be reduced to the max.
HASH_LENGTH=31

# One of: -fasta, -fastq, -raw, -fasta.gz, -fastq.gz, -raw.gz, -sam,
#   -bam, -fmtAuto.
# The default of `-fmtAuto` detects fasta or fastq (and will try the
#   following programs for decompression : gunzip, pbunzip2, bunzip2)
FILE_FORMAT="-fmtAuto"

# One of: -short, -shortPaired, -short2, -shortPaired2, -long,
#   -longPaired, -reference
READ_TYPE="-short"

# File layout options for paired reads (only for fasta and fastq formats)
# One or of -interleaved or -separate.
FILE_OPTIONS="-interleaved"

# Additional command-line options (run velveth with no options for a
# list)
#VELVETH_OPTIONS=""

# Input file (or files)
INPUT_FILES=("${VELVETEXAMPLES}/test_reads.fa")

# Command-line options (run velvetg with no options for a list).
# This pipeline requires the -read_trkg option.
VELVETG_OPTIONS="-read_trkg yes"

# Command-line options (run oases with no options for a list).
#OASES_OPTIONS=""

echo ""
echo "-----------------"
echo " Running velveth "
echo "-----------------"
echo ""

# Execute velveth
velveth "$OUTPUT_DIR" \
  "$HASH_LENGTH" \
  "$FILE_FORMAT" "$READ_TYPE" $FILE_OPTIONS "${INPUT_FILES[@]}" \
  $VELVETH_OPTIONS

echo ""
echo "-------------------"
echo " velveth completed "
echo "-------------------"
echo ""
echo ""
echo "-----------------"
echo " Running velvetg "
echo "-----------------"
echo ""

# Execute velvetg
velvetg "$OUTPUT_DIR" \
  $VELVETG_OPTIONS

echo ""
echo "-------------------"
echo " velvetg completed "
echo "-------------------"
echo ""
echo ""
echo "---------------"
echo " Running Oases "
echo "---------------"
echo ""

# Execute oases
oases "$OUTPUT_DIR" \
  $OASES_OPTIONS

echo ""
echo "-----------------"
echo " Oases completed "
echo "-----------------"
echo " Output is available in: $OUTPUT_DIR"
