#!/bin/bash -l
#@      cw_TEMPLATE[name]="CEGMA v2.5.0 (GridScheduler)"
#@      cw_TEMPLATE[desc]="CEGMA example script."
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
#$ -o $HOME/cegma_out.$JOB_ID
#$ -N cegma
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# For further CEGMA usage information see:
#   $CEGMADOC/README.md
# For more information about CEGMA, please refer to the website:
#   http://korflab.ucdavis.edu/datasets/cegma/

# Loading CEGMA module
module load apps/cegma/2.5.0

# Output/working data directory
OUTPUT_DIR="${HOME}/cegma/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"

# Specify input file names and the directory in which they are located.
INPUT_DIR=$CEGMASAMPLE
INPUT_GENOME=sample.dna
INPUT_PROTEIN=sample.prot

# Create the output/working data directory
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

# Customize CEGMATMP if required
#CEGMATMP=/tmp

# Specify options to use for cegma:
# -d, --blastdb     blast database for the genome sequence.
# -t, --tblastn_gff gff file containing the tblastn results
#                    (this option skips the blast step).
# -s, --genewise    gff file with the genewise alignment coordinates
#                    (this options skips the blast step).
# -a, --annotation  gff file with gene annotations
#                    (computes the coordinates for the annotations).
# --vrt             Optimization for vertebrate genomes
#                    (intron size 20,000 bp).
# --mam             Optimization for mamalian genomes
#                    (intron size 40,000 bp).
# --max_intron      Max intron size.
# -v, --verbose     Verbose mode, shows progress of each KOG as it is processed
# -q, --quiet       Quiet mode, do not show any message/warning
# --ext             Extended output which keeps all intermediate files.
# --tmp             Keep temporary files.
#
# These variables can be used to run other than default HMM profiles:
# --prot_num        Number of proteins in the fasta file
#                         They have to be in consecutive order in the fasta file
#                            (default: 6)
# --cutoff_file     File with the cutoff for the HMMER alignments
#                            (default: $CEGMA/data/profiles_cutoff.tbl)
# --hmm_prefix      Each protein ID must have "___" followed by the hmmprefix
#                         and a number (ex. At3g02190___KOG1762)
#                             (default: KOG)
# --hmm_directory   Directory that contains the hmm files. The files must be
#                         named hmm_prefix(number).hmm  ex. KOG1762.hmm
#                            (default: $CEGMA/data/hmm_profiles)
CEGMA_OPTIONS=""

# Change the following to match the number of cores you want to
# run on.
#   (For GridScheduler tasks, this should match the number of
#   slots you requested for use in the parallel environment.)
CORES=2

# Modify the output prefix if desired (defaults to 'output')
# -o, --output      ouput file prefix.
#      suffix for naming output files [default = ".elems"]
#OUTPUT_PREFIX="output"
if [ "$OUTPUT_PREFIX" ]; then
  CEGMA_OPTIONS="$GERPELEM_OPTIONS --output $OUTPUT_PREFIX"
fi

cat <<EOF
Executing: \
cegma --genome "$INPUT_DIR/$INPUT_GENOME" \
  --protein "$INPUT_DIR/$INPUT_PROTEIN" \
  -T $CORES \
  $CEGMA_OPTIONS
EOF

# Execute cegma
cegma --genome "$INPUT_DIR/$INPUT_GENOME" \
  --protein "$INPUT_DIR/$INPUT_PROTEIN" \
  -T $CORES \
  $CEGMA_OPTIONS

echo ""
echo "-----------------"
echo " cegma completed"
echo "-----------------"
echo " Output is available in: $OUTPUT_DIR"
