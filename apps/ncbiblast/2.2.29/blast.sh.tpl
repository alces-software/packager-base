#!/bin/bash -l
#@      cw_TEMPLATE[name]="BLAST v2.2.29 (GridScheduler)"
#@      cw_TEMPLATE[desc]="BLAST example script."
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
#$ -o $HOME/blast_out.$JOB_ID
#$ -N blast
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For detailed usage information for BLAST commands see:
#   http://www.ncbi.nlm.nih.gov/books/NBK1763/
#
# Example script for 'blastn' use case based on:
#   http://www.ncbi.nlm.nih.gov/books/NBK52640/#chapter1._Basic_use_1
# Requires test BLAST database (~1.9GB) downloaded and extracted from:
#   ftp://ftp.ncbi.nlm.nih.gov/blast/db/refseq_rna.00.tar.gz
#   ftp://ftp.ncbi.nlm.nih.gov/blast/db/refseq_rna.01.tar.gz
#   ftp://ftp.ncbi.nlm.nih.gov/blast/db/refseq_rna.02.tar.gz

# Loading BLAST module
module load apps/ncbiblast/2.2.29

# Input directory
INPUT_DIR="${HOME}/blast/input"
mkdir -p $INPUT_DIR

# Output directory
OUTPUT_DIR="${HOME}/blast/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# BLAST database name
DB_NAME="${INPUT_DIR}/refseq_rna"

# Comma-delimited search string(s) of sequence identifiers
DB_SEQ_IDS=nm_000249

# Query file name
QUERY_FILE=test_query.fa

# Alignment view option (7 = tabular with comment lines)
OUTPUT_FORMAT=7

# Show alignments for this number of database sequences
NUM_ALIGNS=2

# Additional command-line options (blastn -h for a list)
BLASTN_OPTIONS="-task blastn -dust no -num_alignments $NUM_ALIGNS"

# Getting database
wget -qO- ftp://ftp.ncbi.nlm.nih.gov/blast/db/refseq_rna.00.tar.gz | tar xvz -C "${INPUT_DIR}/"
wget -qO- ftp://ftp.ncbi.nlm.nih.gov/blast/db/refseq_rna.01.tar.gz | tar xvz -C "${INPUT_DIR}/"
wget -qO- ftp://ftp.ncbi.nlm.nih.gov/blast/db/refseq_rna.02.tar.gz | tar xvz -C "${INPUT_DIR}/"

# Correcting database list to only list downloaded files
printf "TITLE NCBI Transcript Reference Sequences\nDBLIST refseq_rna.00 refseq_rna.01 refseq_rna.02" > "${INPUT_DIR}/refseq_rna.nal"

blastdbcmd -db $DB_NAME -entry $DB_SEQ_IDS -out $OUTPUT_DIR/$QUERY_FILE \
  && blastn -query $OUTPUT_DIR/$QUERY_FILE -db $DB_NAME -outfmt $OUTPUT_FORMAT $BLASTN_OPTIONS

echo ""
echo "----------------------"
echo " NCBI BLAST completed"
echo "----------------------"
echo " Output is available in: $OUTPUT_DIR"
