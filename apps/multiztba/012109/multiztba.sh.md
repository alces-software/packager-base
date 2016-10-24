# multiztba(7) -- Multiz/TBA v012109 (GridScheduler)

## DESCRIPTION

We define a "threaded blockset", which is a novel generalization of
the classic notion of a multiple alignment. A new computer program
called TBA (for “threaded blockset aligner”) builds a threaded
blockset under the assumption that all matching segments occur in
the same order and orientation in the given sequences; inversions
and duplications are not addressed. TBA is designed to be
appropriate for aligning many, but by no means all, megabase-sized
regions of multiple mammalian genomes. The output of TBA can be
projected onto any genome chosen as a reference, thus guaranteeing
that different projections present consistent predictions of which
genomic positions are orthologous. This capability is illustrated
using a new visualization tool to view TBA-generated alignments of
vertebrate Hox clusters from both the mammalian and fish
perspectives. Experimental evaluation of alignment quality, using a
program that simulates evolutionary change in genomic sequences,
indicates that TBA is more accurate than earlier programs. To
perform the dynamic-programming alignment step, TBA runs a
stand-alone program called MULTIZ, which can be used to align highly
rearranged or incompletely sequenced genomes. We describe our use of
MULTIZ to produce the whole-genome multiple alignments at the Santa
Cruz Genome Browser.

For more information on running Multiz/TBA, please visit:
  * <http://www.bx.psu.edu/miller_lab/>
  * <http://www.bx.psu.edu/miller_lab/dist/tba_howto.pdf>

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.

