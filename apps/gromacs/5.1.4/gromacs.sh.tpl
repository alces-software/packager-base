#!/bin/bash -l
#@      cw_TEMPLATE[name]="GROMACS v4.6.5 (GridScheduler)"
#@      cw_TEMPLATE[desc]="GROMACS example script."
#@ cw_TEMPLATE[copyright]="Copyright (C) 2016 Alces Software Ltd."
#@   cw_TEMPLATE[license]="Creative Commons Attribution-ShareAlike 4.0 International"
#@     cw_TEMPLATE[files]="bio/gromacs/gromacs.al.gr.tar.gz"
#@   cw_TEMPLATE[datadir]="gromacs"
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
#$ -o $HOME/gromacs_out.$JOB_ID
#$ -N gromacs
#$ -pe smp-verbose 2


#############################################
# APPLICATION COMMANDS - change as required
#############################################
#
# GROMACS offers many different commands; this example batch script uses
# pdb2gmx to generate a topology file from a sample PDB
#
# For full GROMACS documentation see:
#   http://www.gromacs.org/Documentation

# Checking for example data
if [ -d "_GRIDWARE_/data/_DATADIR_" ]; then
  DATA_DIR="_GRIDWARE_/data/_DATADIR_"
elif [ -d "$HOME/gridware/data/_DATADIR_" ]; then
  DATA_DIR="$HOME/gridware/data/_DATADIR_"
else
  echo "Prepare your data first with 'alces template prepare _TEMPLATE_'."
  exit 1
fi

# Loading GROMACS module
module load apps/gromacs/4.6.5

# Output directory
OUTPUT_DIR="${HOME}/gromacs/output.${JOB_ID-${PORTAL_TASK_ID-$$}}"
mkdir -p $OUTPUT_DIR

# Input directory
INPUT_DIR="${HOME}/gromacs/input"
mkdir -p $INPUT_DIR

# Demo molecule
MOL=cpeptide

# Input structure file: gro g96 pdb tpr etc.
INPUT_FILE="${INPUT_DIR}/${MOL}.pdb"
cp -v "${DATA_DIR}/${MOL}.pdb" $INPUT_FILE

# Output structure file
OUTPUT_STRUCTURE=$OUTPUT_DIR/$MOL.gro

# Output topology file
OUTPUT_TOPOLOGY=$OUTPUT_DIR/$MOL.top

# Output include file
OUTPUT_INCLUDE=$OUTPUT_DIR/posre.itp

pdb2gmx -f $INPUT_FILE -o $OUTPUT_STRUCTURE -p $OUTPUT_TOPOLOGY -i $OUTPUT_INCLUDE &> $OUTPUT_DIR/output.pdb2gmx <<EOT
1
1
EOT

echo ""
echo "-----------------"
echo " GROMACS completed"
echo "-----------------"
echo " Output is available in: $OUTPUT_DIR"
