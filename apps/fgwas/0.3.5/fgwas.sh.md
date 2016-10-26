# fgwas(7) -- fgwas v0.3.5 (GridScheduler)

## DESCRIPTION

fgwas is a command line tool for integrating functional genomic
information into a genome-wide association study (GWAS). The basic
setup is as follows: you have performed a GWAS or a meta-analysis of
many GWAS, and have identified tens of loci that influence the
disease or trait (our approach works best if there are at least ~20
independent loci with p-values less than 5e-8). We set out to
address the following questions:

  1. Are these associations enriched in particular types of regions
     of the genome (coding exons, DNAse hypersensitive sites, etc.)?
  2. Can we use these enrichments (if they exist) to identify novel
     loci influencing the trait?

The underlying model is described in: [Pickrell JK (2014) Joint
analysis of functional genomic data and genome-wide association
studies of 18 human traits]
(http://biorxiv.org/content/early/2014/01/22/000752).
bioRxiv 10.1101/000752

For more information on running fgwas, please visit:
  * <https://github.com/joepickrell/fgwas>

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.
