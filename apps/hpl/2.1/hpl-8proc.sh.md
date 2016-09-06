# hpl-8proc(7) -- HPL v2.1 - 8 processes (GridScheduler)

## DESCRIPTION

HPL is a software package that solves a (random) dense linear system
in double precision (64 bits) arithmetic on distributed-memory
computers. It can thus be regarded as a portable as well as freely
available implementation of the High Performance Computing Linpack
Benchmark.

The algorithm used by HPL can be summarized by the following keywords:
  * Two-dimensional block-cyclic data distribution
  * Right-looking variant of the LU factorization with row partial
    pivoting featuring multiple look-ahead depths
  * Recursive panel factorization with pivot search and column
    broadcast combined
  * Various virtual panel broadcast topologies
  * Bandwidth reducing swap-broadcast algorithm
  * Backward substitution with look-ahead of depth 1

For more information on running the HPL benchmark and tuning this 
file, please visit:
  * <http://www.netlib.org/benchmark/hpl/>
  * <http://hpl-calculator.sourceforge.net/>

## FILES

### $HPLEXAMPLES/hpl-8proc.alces.dat
This is the HPL configuration file that adjusts the paramaters 
that the HPL benchmark will be run with. The PxQ variables within 
this file are configured currently to start an 8 process job. 
The size of N is currently set to use 90% of with NB = 192.

## LICENSE

This work is licensed under a Creative Commons Attribution-ShareAlike
4.0 International License.

See <http://creativecommons.org/licenses/by-sa/4.0/> for more
information.

## COPYRIGHT

Copyright (C) 2016 Alces Software Ltd.
