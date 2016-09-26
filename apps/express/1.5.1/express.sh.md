# express(7) -- eXpress v1.5.1 (GridScheduler)

## DESCRIPTION

eXpress is a streaming tool for quantifying the abundances of a set
of target sequences from sampled subsequences. Example applications
include transcript-level RNA-Seq quantification,
allele-specific/haplotype expression analysis (from RNA-Seq),
transcription factor binding quantification in ChIP-Seq, and
analysis of metagenomic data. It is based on an online-EM algorithm
that results in space (memory) requirements proportional to the
total size of the target sequences and time requirements that are
proportional to the number of sampled fragments. Thus, in
applications such as RNA-Seq, eXpress can accurately quantify much
larger samples than other currently available tools greatly reducing
computing infrastructure requirements. eXpress can be used to build
lightweight high-throughput sequencing processing pipelines when
coupled with a streaming aligner (such as Bowtie), as output can be
piped directly into eXpress, effectively eliminating the need to
store read alignments in memory or on disk.

For more information on running eXpress, please visit:
  * <http://bio.math.berkeley.edu/eXpress/overview.html>

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.
