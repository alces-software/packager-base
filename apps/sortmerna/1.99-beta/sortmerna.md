# sortmerna(7) -- SortMeRNA v1.99-beta (GridScheduler)

## DESCRIPTION

SortMeRNA is a software designed to rapidly filter ribosomal RNA fragments
from metatranscriptomic data produced by next-generation sequencers. It is
capable of handling large RNA databases and sorting out all fragments
matching to the database with high accuracy and specificity.

SortMeRNA takes as input a file of reads (fasta or fastq format) and an rRNA
database (constructed using indexdb_rna (and buildtrie in versions <1.99
beta), and sorts apart the matching and non-matching reads into two files
specified by the user. Please refer to the user manual below for examples.

If you use SortMeRNA, please cite: Kopylova E., Noé L. and Touzet H.,
"SortMeRNA: Fast and accurate filtering of ribosomal RNAs in
metatranscriptomic data", Bioinformatics (2012), doi:
10.1093/bioinformatics/bts611.

For more information on running SortMeRNA, please visit:
  * <http://bioinfo.lifl.fr/RNA/sortmerna/index.php>

## FILES

### sortmerna

Index one of the rRNA databases provided with SortMeRNA and filter rRNA reads against it.

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.
