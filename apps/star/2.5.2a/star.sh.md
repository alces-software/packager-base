# star(7) -- Star v2.5.2a (GridScheduler)

## DESCRIPTION

Accurate alignment of high-throughput RNA-seq data is a challenging
and yet unsolved problem because of the non-contiguous transcript
structure, relatively short read lengths and constantly increasing
throughput of the sequencing technologies. Currently available
RNA-seq aligners suffer from high mapping error rates, low mapping
speed, read length limitation and mapping biases.

To align our large (>80 billon reads) ENCODE Transcriptome RNA-seq
dataset, we developed the Spliced Transcripts Alignment to a
Reference (STAR) software based on a previously undescribed RNA-seq
alignment algorithm that uses sequential maximum mappable seed
search in uncompressed suffix arrays followed by seed clustering and
stitching procedure. STAR outperforms other aligners by a factor of
>50 in mapping speed, aligning to the human genome 550 million 2 ×
76 bp paired-end reads per hour on a modest 12-core server, while at
the same time improving alignment sensitivity and precision. In
addition to unbiased de novo detection of canonical junctions, STAR
can discover non-canonical splices and chimeric (fusion)
transcripts, and is also capable of mapping full-length RNA
sequences. Using Roche 454 sequencing of reverse transcription
polymerase chain reaction amplicons, we experimentally validated
1960 novel intergenic splice junctions with an 80–90% success rate,
corroborating the high precision of the STAR mapping strategy.

For more information on running Star, please visit:
  * <https://github.com/alexdobin/STAR>
  * <https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf>

## FILES

### star.ref.fa

FASTA file used for generation of genome index.

### star.1.fq

FASTQ file for first RNA-Seq read of genome.

### star.2.fq

FASTQ file for optional second RNA-Seq read of genome.

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.

