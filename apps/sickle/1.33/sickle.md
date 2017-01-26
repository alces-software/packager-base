# sickle(7) -- Sickle v1.33 (GridScheduler)

## DESCRIPTION

Most modern sequencing technologies produce reads that have
deteriorating quality towards the 3'-end and some towards the 5'-end
as well. Incorrectly called bases in both regions negatively impact
assembles, mapping, and downstream bioinformatics analyses.

Sickle is a tool that uses sliding windows along with quality and
length thresholds to determine when quality is sufficiently low to
trim the 3'-end of reads and also determines when the quality is
sufficiently high enough to trim the 5'-end of reads. It will also
discard reads based upon the length threshold. It takes the quality
values and slides a window across them whose length is 0.1 times the
length of the read. If this length is less than 1, then the window
is set to be equal to the length of the read. Otherwise, the window
slides along the quality values until the average quality in the
window rises above the threshold, at which point the algorithm
determines where within the window the rise occurs and cuts the read
and quality there for the 5'-end cut. Then when the average quality
in the window drops below the threshold, the algorithm determines
where in the window the drop occurs and cuts both the read and
quality strings there for the 3'-end cut. However, if the length of
the remaining sequence is less than the minimum length threshold,
then the read is discarded entirely. 5'-end trimming can be
disabled.

For more information on running Sickle, please visit:
  * <https://github.com/najoshi/sickle>

## FILES

### sickle-se.sh.tpl

`sickle se` takes an input fastq file and outputs a trimmed
version of that file. It also has options to change the length
and quality thresholds for trimming, as well as disabling
5'-trimming and enabling truncation of sequences with Ns.

### sickle-pe-1.sh.tpl

`sickle pe` can operate with two types of input - separated
reads or interleaved reads.

This script handles separated reads, taking two paired-end files
as input and providing two trimmed paired-end files as well as a
"singles" file as output.

The "singles" file contains reads that passed filter in either
the forward or reverse direction, but not the other.

You can also change the length and quality thresholds for
trimming, as well as disable 5'-trimming and enable truncation
of sequences with Ns.

### sickle-pe-2.sh.tpl

`sickle pe` can operate with two types of input - separated
reads or interleaved reads.

This script handles interleaved reads, taking a single combined
input file of reads where you have already interleaved the reads
from the sequencer. In this form, you also supply a single
output file name as well as a "singles" file.

The "singles" file contains reads that passed filter in either
the forward or reverse direction, but not the other.

You can also change the length and quality thresholds for
trimming, as well as disable 5'-trimming and enable truncation
of sequences with Ns.

### sickle-pe-3.sh.tpl

`sickle pe` can operate with two types of input - separated
reads or interleaved reads.

This script handles interleaved reads, taking a single combined
input file of reads where you have already interleaved the reads
from the sequencer and uses an option (-M) to only produce one
interleaved output file where any reads that did not pass filter
will be output as a FastQ record with a single "N" (whose
quality value is the lowest possible based upon the quality
type), thus preserving the paired nature of the data.

You can also change the length and quality thresholds for
trimming, as well as disable 5'-trimming and enable truncation
of sequences with Ns.

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.
