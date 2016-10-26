#!/bin/bash -l
#@      cw_TEMPLATE[name]="eXpress v1.5.1 (GridScheduler)"
#@      cw_TEMPLATE[desc]="eXpress example script."
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
#$ -o $HOME/express_out.$JOB_ID
#$ -N express
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For full eXpress usage information see:
#   http://bio.math.berkeley.edu/eXpress/manual.html

# Loading eXpress module
module load apps/express/1.5.1

# Input directory
INPUT_DIR="${HOME}/express/input"
mkdir -p $INPUT_DIR

# Output directory
OUTPUT_DIR="${HOME}/express/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Set up input data
cp -Rv "$EXPRESSSHARE/sample_data/." "$INPUT_DIR"

# Additional command-line options
EXPRESS_OPTIONS=""

# Variables governing input
IN_TRANSCRIPTS_FA="$INPUT_DIR/transcripts.fasta"
IN_READS_1_FQ="$INPUT_DIR/reads_1.fastq"
IN_READS_2_FQ="$INPUT_DIR/reads_2.fastq"

# Variables governing output
OUT_HITS_BAM="$OUTPUT_DIR/hits.bam"
OUT_TRANSCRIPTS_BASE="$OUTPUT_DIR/transcripts"

# Step 1: Prepare the Bowtie index
bowtie-build --offrate 1 "$IN_TRANSCRIPTS_FA" "$OUT_TRANSCRIPTS_BASE"

# Step 2: SAM output from Bowtie is piped into SAMtools in order
# to compress it to BAM format (optional, but will greatly
# reduce the size of the alignment file).
bowtie -aS -X 800 --offrate 1 "$OUT_TRANSCRIPTS_BASE" \
    -1 "$IN_READS_1_FQ" \
    -2 "$IN_READS_2_FQ" | samtools view -Sb - \
    > "$OUT_HITS_BAM"

# Step 3: Run eXpress
express $EXPRESS_OPTIONS \
    -o "$OUTPUT_DIR" \
    "$IN_TRANSCRIPTS_FA" "$OUT_HITS_BAM"
