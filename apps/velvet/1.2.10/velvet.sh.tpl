#!/bin/bash -l
#@      cw_TEMPLATE[name]="Velvet 1.2.10 (GridScheduler)"
#@      cw_TEMPLATE[desc]="Velvet example script."
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
#$ -o $HOME/velvet_out.$JOB_ID
#$ -V
#$ -N velvet


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full Velvet usage information see:
#   http://www.ebi.ac.uk/~zerbino/velvet/Manual.pdf
#   or: $VELVETDIR/doc/Manual.pdf
# For more information about Velvet, please refer to the website:
#   http://www.ebi.ac.uk/~zerbino/velvet/

# Loading Velvet module
module load apps/velvet/1.2.10

# Output/working data directory
DATA_DIR="${HOME}/velvet/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

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
VELVETH_OPTIONS=""

# Input file (or files)
INPUT_FILES="$VELVETEXAMPLES/test_reads.fa"

# Command-line options (run velvetg with no options for a list).
# Some common options are:
#   -cov_cutoff <floating-point|auto>
#     removal of low coverage nodes AFTER tour bus or allow the system to infer it (default: no removal)
#   -ins_length <integer>
#     expected distance between two paired end reads (default: no read pairing)
#   -read_trkg <yes|no>
#     tracking of short read positions in assembly (default: no tracking)
#   -min_contig_lgth <integer>
#     minimum contig length exported to contigs.fa file (default: hash length * 2)
#   -amos_file <yes|no>
#     export assembly to AMOS file (default: no export)
#   -exp_cov <floating point|auto>
#     expected coverage of unique regions or allow the system to infer it 
#     (default: no long or paired-end read resolution)
#   -long_cov_cutoff <floating-point>
#     removal of nodes with low long-read coverage AFTER tour bus (default: no removal)
VELVETG_OPTIONS=""

# Create the directory to contain the output files
mkdir -p "$DATA_DIR"

# Execute velveth
velveth "$DATA_DIR" \
  "$HASH_LENGTH" \
  "$FILE_FORMAT" "$READ_TYPE" $FILE_OPTIONS "${INPUT_FILES[@]}" \
  $VELVETH_OPTIONS

# Execute velvetg
velvetg "$DATA_DIR" \
  $VELVETG_OPTIONS

echo ""
echo "---------------------------"
echo " velvet pipeline completed"
echo "---------------------------"
echo " Output is available in: $DATA_DIR"
