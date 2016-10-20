# cegma(7) -- CEGMA v2.5.0 (GridScheduler)

## DESCRIPTION

CEGMA (Core Eukaryotic Genes Mapping Approach) is a pipeline for
building a set of high reliable set of gene annotations in
virtually any eukaryotic genome. The strategy relies on a simple
fact: some highly conserved proteins are encoded in essentially
all eukaryotic genomes. We use the KOGs database to build a set of
these highly conserved ubiquitous proteins. We define a set of 458
core proteins, and the protocol, CEGMA, to find orthologs of the
core proteins in new genomes and to determine their exon-intron
structures.

A local version of CEGMA can be installed on UNIX platforms and it
requires pre-installation of PERL, NCBI BLAST+, HMMER, GeneWise
and geneid. The procedure uses information from the core genes of
six model organisms by first using TBLASTN to identify candidate
regions in a new genome. It then proposes and redefines gene
structures using a combination of GeneWise, HMMER and geneid. The
system includes the use of a profile for each core protein to
ensure the reliability of the gene structure.

For more information on running CEGMA, please visit:
  * <http://korflab.ucdavis.edu/datasets/cegma/>

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.
