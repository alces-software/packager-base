# macs(7) -- MACS v2.1.0.20150731 (GridScheduler)

## DESCRIPTION

Model-based Analysis of ChIP-Seq (MACS), a novel algorithm for short
reads sequencers such as Genome Analyzer (Illumina / Solexa).

Next generation parallel sequencing technologies made chromatin
immunoprecipitation followed by sequencing (ChIP-Seq) a popular
strategy to study genome-wide protein-DNA interactions, while
creating challenges for analysis algorithms. 

MACS empirically models the length of the sequenced ChIP fragments,
which tends to be shorter than sonication or library construction
size estimates, and uses it to improve the spatial resolution of
predicted binding sites. MACS also uses a dynamic Poisson
distribution to effectively capture local biases in the genome
sequence, allowing for more sensitive and robust prediction. MACS
compares favorably to existing ChIP-Seq peak-finding algorithms, is
publicly available open source, and can be used for ChIP-Seq with or
without control samples.

For more information on running MACS, please visit:
  * <https://github.com/taoliu/MACS/>
  * <http://liulab.dfci.harvard.edu/MACS/>

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.

