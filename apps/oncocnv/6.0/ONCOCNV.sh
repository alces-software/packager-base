#!/bin/bash
# This file is part of ONCOCNV - a tool to detect copy number alterations in amplicon sequencing data
# Copyright (C) 2014 OncoDNA

# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#Author: Valentina BOEVA

VERSION=6.0

###############################################################################################################

# intput: .bam files 

#---------------------------------------------------------------------------------------------------------------
#  you may want to create .bai indexes to visualize .bam files in the IGV:
#     files="Control.1.bam,Control.2.bam,Control.3.bam,Sample.1.bam,Sample.2.bam,Sample.3.bam,Sample.4.bam"
#     for file in $files
#     do
#       samtools index $file
#     done
#---------------------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------------------
#                              Set paths and arguments
#---------------------------------------------------------------------------------------------------------------

TOOLDIR=${ONCOCNVSHARE}/scripts
n=$(basename "$0")

CONFIGFILE="$1"
if [ ! -r "$CONFIGFILE" ]; then
  echo "$n: unable to read config file"
  echo ""
  echo "Usage: $0 <config file>"
  echo ""
  echo "For an example config file, see ${ONCOCNVETC}/example.cfg"
  exit 1
fi
. $CONFIGFILE

if [ -z "$OUTDIR" -o -z "$DATADIR" -o -z "$GENOME" -o -z "$targetBed" -o -z "$controls" -o -z "$tests" ]; then
  echo "$n: bad config file"
  echo ""
  echo "For an example config file, see ${ONCOCNVETC}/example.cfg"
fi

mkdir -p "$OUTDIR"

#---------------------------------------------------------------------------------------------------------------
#                                   Run commands
#---------------------------------------------------------------------------------------------------------------

echo "ONCOCNV $VERSION - a package to detect copy number changes in Deep Sequencing data"

cd $DATADIR

echo "$DATADIR contains the following files:"
ls -l $DATADIR 

#get normalized read counts for the control samples
perl $TOOLDIR/ONCOCNV_getCounts.v$VERSION.pl getControlStats -m Ampli -b $targetBed -c $controls -o $OUTDIR/Control.stats.txt 

#get normalized read counts for the tumor samples
perl $TOOLDIR/ONCOCNV_getCounts.v$VERSION.pl getSampleStats -m Ampli -c $OUTDIR/Control.stats.txt -s $tests -o $OUTDIR/Test.stats.txt 

#create .bed file with targeted regions
cat $OUTDIR/Control.stats.txt | grep -v start | awk '{print $1,$2,$3}' | sed "s/ /\t/g" >$OUTDIR/target.bed
 
#get GC-content per targeted region 
bedtools getfasta -bed $OUTDIR/target.bed -fi $GENOME -fo $OUTDIR/target.fasta
perl $TOOLDIR/getGCfromFasta.pl -f $OUTDIR/target.fasta > $OUTDIR/target.GC.txt
rm $OUTDIR/target.fasta

#process control samples
cat $TOOLDIR/processControl.v$VERSION.R | R --slave --args $OUTDIR/Control.stats.txt $OUTDIR/Control.stats.Processed.txt $OUTDIR/target.GC.txt

#process test samples and predict CNA and CNVs:

#to use cghseg segmentation instead of circular binary segmentation (defaut) please add "chgseg" at the end of the command line:
cat $TOOLDIR/processSamples.v$VERSION.R | R --slave --args $OUTDIR/Test.stats.txt $OUTDIR/Control.stats.Processed.txt $OUTDIR/Test.output.txt cghseg

######################## default (but often cghseg performs better than the default circular binary segmentation): ########################################
#using DNAcopy circular binary segmentation (defaut) :
#cat $TOOLDIR/processSamples.v$VERSION.R | R --slave --args $OUTDIR/Test.stats.txt $OUTDIR/Control.stats.Processed.txt $OUTDIR/Test.output.txt
###########################################################################################################################################################

