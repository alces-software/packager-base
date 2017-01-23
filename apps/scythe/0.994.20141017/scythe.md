# Scythe(7) -- Scythe v0.994.20141017 (GridScheduler)

## DESCRIPTION

Scythe uses a Naive Bayesian approach to classify contaminant
substrings in sequence reads. It considers quality information,
which can make it robust in picking out 3'-end adapters, which often
include poor quality bases.

Most next generation sequencing reads have deteriorating quality
towards the 3'-end. It's common for a quality-based trimmer to be
employed before mapping, assemblies, and analysis to remove these
poor quality bases. However, quality-based trimming could remove
bases that are helpful in identifying (and removing) 3'-end adapter
contaminants. Thus, it is recommended you run Scythe before
quality-based trimming, as part of a read quality control pipeline.

The Bayesian approach Scythe uses compares two likelihood models:
the probability of seeing the matches in a sequence given
contamination, and not given contamination. Given that the read is
contaminated, the probability of seeing a certain number of matches
and mistmatches is a function of the quality of the sequence. Given
the read is not contaminated (and is thus assumed to be random
sequence), the probability of seeing a certain number of matches and
mismatches is chance. The posterior is calculated across both these
likelihood models, and the class (contaminated or not contaminated)
with the maximum posterior probability is the class selected.

For more information on running Scythe, please visit:
  * <https://github.com/vsbuffalo/scythe>

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.
