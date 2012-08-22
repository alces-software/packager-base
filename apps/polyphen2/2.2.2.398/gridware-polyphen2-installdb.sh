#!/bin/bash
# fail fast!
set -o errexit
set -o pipefail

# This script will download around ~28.9GiB of compressed data.  Once
# uncompressed, this data will consume ~61.8GiB.

# dssp, nrdb, pdb2fasta, uscs, uniprot, wwpdb

cd $POLYPHEN2_DATADIR

# Preparation
if [ -d polyphen2 ]; then
  echo "$(pwd)/polyphen2 directory already exists - data already installed?"
  exit 1
fi

mkdir polyphen-2.2.2
for a in precomputed dssp nrdb pdb2fasta uscs uniprot wwpdb; do
    if [ ! -d $a ]; then
	cp -r $POLYPHEN2DIR/$a polyphen-2.2.2
    fi
done

DATADIR="$(pwd)"
cd polyphen-2.2.2
mkdir -p download
DLDIR="$(pwd)/download"

# REQUIRED SEQUENCE & ANNOTATION DATABASES
# 3.7GiB >> 9.9GiB
cd "$DLDIR"
wget ftp://genetics.bwh.harvard.edu/pph2/bundled/polyphen-2.2.2-databases-2011_12.tar.bz2
cd "$DATADIR"
tar xjf "$DLDIR/polyphen-2.2.2-databases-2011_12.tar.bz2"

# PRECOMPUTED ALIGNMENTS (precomputed)
# 2.4 GiB >> 19GiB
cd "$DLDIR"
wget ftp://genetics.bwh.harvard.edu/pph2/bundled/polyphen-2.2.2-alignments-mlc-2011_12.tar.bz2
cd "$DATADIR"
tar xjf "$DLDIR/polyphen-2.2.2-alignments-mlc-2011_12.tar.bz2"

# PRECOMPUTED ALIGNMENTS (ucsc)
cd "$DLDIR"
# 1.7GiB (895MiB ??) >> 5.8GiB
wget ftp://genetics.bwh.harvard.edu/pph2/bundled/polyphen-2.2.2-alignments-multiz-2009_10.tar.bz2
cd "$DATADIR"
tar xjf "$DLDIR/polyphen-2.2.2-alignments-multiz-2009_10.tar.bz2"

# STRUCTURAL DATABASES (wwpdb, pdb2fasta, dssp)
# PDB (Structural Database) >> 12GiB
cd "$DATADIR/polyphen-2.2.2"
rsync -rlt --delete-after --port=33444 rsync.wwpdb.org::ftp/data/structures/divided/pdb/ wwpdb/divided/pdb/
rsync -rlt --delete-after --port=33444 rsync.wwpdb.org::ftp/data/structures/all/pdb/ wwpdb/all/pdb/
# DSSP (Structural Database) [pref 00:00 -> 08:00] >> 6GiB
rsync -rltz --delete-after rsync://rsync.cmbi.ru.nl/dssp/ dssp/

# NON-REDUNDANT SEQUENCE DATABASE (nrdb)
# UniRef100: <-- 3.1GiB >> 8.1GiB
cd "$DLDIR"
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/uniref/uniref100/uniref100.fasta.gz
cd "$DATADIR/polyphen-2.2.2/nrdb"
gunzip "$DLDIR/uniref100.fasta.gz"
"$POLYPHEN2DIR/update/format_defline.pl" uniref100.fasta >uniref100-formatted.fasta
"$NCBIBLASTBIN/makeblastdb" -in uniref100-formatted.fasta -dbtype prot -out uniref100 -parse_seqids
rm -f uniref100.fasta uniref100-formatted.fasta

cd "$DATADIR"
mv polyphen-2.2.2 polyphen2
for a in dssp nrdb pdb2fasta uscs uniprot wwpdb; do
    mv polyphen2/$a .
done
