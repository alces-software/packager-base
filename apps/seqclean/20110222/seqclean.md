# seqclean(7) -- SeqClean v20110222 (GridScheduler)

## DESCRIPTION

SeqClean is a tool for validation and trimming of DNA sequences from a flat
file database (FASTA format). SeqClean was designed primarily for "cleaning"
of EST databases, when specific vector and splice site data are not
available, or when screening for various contaminating sequences is desired.
The program works by processing the input sequence file and filtering its
content according to a few criteria: 

 * percentage of undetermined bases
 * polyA tail removal 
 * overall low complexity analysis
 * short terminal matches with various sequences used 
   during the sequencing process (vectors, adapters)
 * strong matches with other contaminants or unwanted sequences
   (mitochondrial, ribosomal, bacterial, other species than the 
   target organism etc.)

The user is expected to provide the contaminant databases, they are not
included in this package.

For more information on running SeqClean, please visit:
  * <http://seqclean.sourceforge.net/>

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.
