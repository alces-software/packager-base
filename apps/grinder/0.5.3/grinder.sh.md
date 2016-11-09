# grinder(7) -- Grinder v0.5.3 (GridScheduler)

## DESCRIPTION

Grinder is a versatile program to create random shotgun and amplicon
sequence libraries based on DNA, RNA or proteic reference sequences
provided in a FASTA file.

Grinder can produce genomic, metagenomic, transcriptomic,
metatranscriptomic, proteomic, metaproteomic shotgun and amplicon
datasets from current sequencing technologies such as Sanger, 454,
Illumina. These simulated datasets can be used to test the accuracy of
bioinformatic tools under specific hypothesis, e.g. with or without
sequencing errors, or with low or high community diversity. Grinder may
also be used to help decide between alternative sequencing methods for a
sequence-based project, e.g. should the library be paired-end or not,
how many reads should be sequenced.

Grinder features include:

 * shotgun or amplicon read libraries

 * omics support to generate genomic, transcriptomic, proteomic,
   metagenomic, metatranscriptomic or metaproteomic datasets

 * arbitrary read length distribution and number of reads

 * simulation of PCR and sequencing errors (chimeras, point mutations,
   homopolymers)

 * support for paired-end (mate pair) datasets

 * specific rank-abundance settings or manually given abundance for
   each genome, gene or protein

 * creation of datasets with a given richness (alpha diversity)

 * independent datasets can share a variable number of genomes (beta
   diversity)

 * modeling of the bias created by varying genome lengths or gene copy
   number

 * profile mechanism to store preferred options

 * available to biologists or power users through multiple interfaces:
   GUI, CLI and API

For more information on running Grinder, please visit:
  * <http://biogrinder.sourceforge.net/>

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.

