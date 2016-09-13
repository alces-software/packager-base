#!/bin/bash -l
#@      cw_TEMPLATE[name]="Staer 2.5.2a (GridScheduler)"
#@      cw_TEMPLATE[desc]="Star example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/star/star.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="star"
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
#$ -o $HOME/star_out.$JOB_ID
#$ -N star
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full STAR usage information see:
#   https://github.com/alexdobin/STAR/blob/STAR_2.4.0j/doc/STARmanual.pdf?raw=true

# Checking for example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading Star module
module load apps/star/2.5.2a

# Change the following to match the number of cores you want to
# run on.
#   (For GridScheduler tasks, this should match the number of
#   slots you request for use in the -pe scheduler directive
#   above.)
CORES=2

# Input directory
INPUT_DIR="${HOME}/star/input"

# Output directory
OUTPUT_DIR="${HOME}/star/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Genome directory
GENOME_DIR="${HOME}/star/input/genome"

# Creating working directories
mkdir -p $INPUT_DIR
mkdir -p $OUTPUT_DIR
mkdir -p $GENOME_DIR

# Copying example files to working directory
cp "$DATA_DIR/star.ref.fa" $INPUT_DIR
cp "$DATA_DIR/star.1.fq" $INPUT_DIR
cp "$DATA_DIR/star.2.fq" $INPUT_DIR

# Building a genome index
STAR --runMode genomeGenerate --runThreadN $CORES --genomeDir $GENOME_DIR --genomeFastaFiles $INPUT_DIR/star.ref.fa --genomeSAindexNbases 6

# FASTQ/FASTA file for Read1
READ_1="star.1.fq"

# Optional: FASTQ/FASTA file for Read2
#READ_2="star.2.fq"

READS=("$READ_1" "$READ_2")

# Additional command-line options
STAR_OPTIONS=""

# Moving to output directory for following line
cd $OUTPUT_DIR

# Aligning RNA-Seq Reads to the genome
STAR --genomeDir "$GENOME_DIR" \
  --readFilesIn "${INPUT_DIR}/${READS[@]}" \
  --runThreadN $CORES \
  $STAR_OPTIONS \
  -outFileNamePrefix "$OUTPUT_DIR/"
