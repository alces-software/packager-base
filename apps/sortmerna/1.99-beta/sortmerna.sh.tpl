#!/bin/bash -l
#@      cw_TEMPLATE[name]="SortMeRNA v1.99-beta (GridScheduler)"
#@      cw_TEMPLATE[desc]="Index one of the rRNA databases provided with SortMeRNA and filter rRNA reads against it."
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
#$ -o $HOME/sortmerna_out.$JOB_ID
#$ -N sortmerna
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################

# Loading SortMeRNA module
module load apps/sortmerna

# Input directory
INPUT_DIR="${HOME}/sortmerna/input"
mkdir -p "${INPUT_DIR}"

# Output directory.
OUTPUT_DIR="${HOME}/sortmerna/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p "${OUTPUT_DIR}"

# Fetching example data
cp -p "${SORTMERNAEXAMPLE}/silva-bac-16s-database-id85.fasta" "${INPUT_DIR}/silva-bac-16s-database-id85.fasta"
cp -p "${SORTMERNAEXAMPLE}/rfam-5.8s-database-id98.fasta" "${INPUT_DIR}/rfam-5.8s-database-id98.fasta"

# The database to index and the output file for the indexed database.
# Change these as desired.
SOURCE_DB="${INPUT_DIR}/silva-bac-16s-database-id85.fasta"
INDEXED_DB="silva-bac-16s"

INDEX_REF="${SOURCE_DB},${OUTPUT_DIR}/${INDEXED_DB}" 

# Other options to pass to the indexdb_rna command. Change as desired.
INDEXDB_RNA_OPTIONS="-v"

indexdb_rna --ref "$INDEX_REF" $INDEXDB_RNA_OPTIONS

# The database which is to be filtered against the indexed database.
# Change this as desired.
READS_DB="${INPUT_DIR}/rfam-5.8s-database-id98.fasta"

# Other options to pass to sortmerna. Change as desired.
SORTMERNA_OPTIONS="--feeling-lucky --sam  --fastx --aligned ${OUTPUT_DIR}/accept --other ${OUTPUT_DIR}/other --log -v"

sortmerna --ref "$INDEX_REF" --reads "$READS_DB" $SORTMERNA_OPTIONS


echo ""
echo "---------------------"
echo " SortMeRNA completed "
echo "---------------------"
echo " Output is available in: ${OUTPUT_DIR}"
