# Copyright D. E. Shaw Research, 2004-2012.
import sys
import os

if EXTRA_C_FLAGS == None: EXTRA_C_FLAGS = ''
if EXTRA_CC_FLAGS == None: EXTRA_CC_FLAGS = ''
if EXTRA_LINK_FLAGS == None: EXTRA_LINK_FLAGS = ''
if EXTRA_LIBS == None: EXTRA_LIBS = ''

if EXTRA_INCLUDE_PATH == None: EXTRA_INCLUDE_PATH = ''
if EXTRA_LIBRARY_PATH == None: EXTRA_LIBRARY_PATH = ''

USE_BFD = False

if USE_BFD:
    EXTRA_INCLUDE_PATH += ' /proj/desres/root/Linux/x86_64/binutils/2.20-09A/include'
    EXTRA_LIBRARY_PATH += ' /proj/desres/root/Linux/x86_64/binutils/2.20-09A/lib'
    EXTRA_LINK_FLAGS += ' -L/proj/desres/root/Linux/x86_64/binutils/2.20-09A/lib'
    EXTRA_LINK_FLAGS += ' -Wl,-rpath=/proj/desres/root/Linux/x86_64/binutils/2.20-09A/lib'

# Boost;
boost_prefix = os.environ['BOOSTDIR']
EXTRA_INCLUDE_PATH += ' %s/include' % boost_prefix
EXTRA_LIBRARY_PATH += ' %s/lib' % boost_prefix
EXTRA_LINK_FLAGS += ' -Wl,-rpath,%s/lib' % boost_prefix
EXTRA_LIBS += ' -lboost_iostreams -lboost_thread'

# ANTLR, used in MSYS
antlr_prefix = os.environ['ANTLRDIR']
EXTRA_INCLUDE_PATH += ' %s/include' % antlr_prefix
EXTRA_LIBRARY_PATH += ' %s/lib' % antlr_prefix
EXTRA_LINK_FLAGS   += ' -Wl,-rpath,%s/lib' % antlr_prefix
EXTRA_LIBS += ' -lantlr3c'

# PCRE, used in MSYS
EXTRA_LIBS += ' -lpcre'

# LPSOLVE *can* be used in MSYS
# MSYS_WITHOUT_LPSOLVE = False
# EXTRA_INCLUDE_PATH += ' /proj/desres/root/Linux/x86_64/lp_solve/5.5.2.0-03A/include'
# EXTRA_LIBRARY_PATH += ' /proj/desres/root/Linux/x86_64/lp_solve/5.5.2.0-03A/lib'
# EXTRA_LINK_FLAGS   += ' -Wl,-rpath,/proj/desres/root/Linux/x86_64/lp_solve/5.5.2.0-03A/lib'
# EXTRA_LIBS += ' -llpsolve55'

# SQLITE - used in MSYS
EXTRA_LIBS += ' -lsqlite3'

# MPI
WITH_MPI = 1
mpi_prefix = os.environ['MPI_HOME']
MPI_CPPFLAGS = "-I%s/include -pthread -DOMPI_SKIP_MPICXX" % mpi_prefix
MPI_LDFLAGS = "-L%s/lib -Wl,-rpath,%s/lib" % (mpi_prefix,mpi_prefix)

# If you want to use the DESRES RDMA library, enable WITH_INFINIBAND
# and give the location of the ofed 1.4.1 libraries.
WITH_INFINIBAND = 0
ofed_prefix = '/proj/desres/root/Linux/x86_64/ofed-lib/1.4.1-03'
IB_CPPFLAGS = "-I%s/include" % ofed_prefix
IB_LDFLAGS = "-L%s/lib64 -Wl,-rpath,%s/lib64 -libverbs" %(ofed_prefix, ofed_prefix)

# Python
# DESRES installs Python and numpy in separate path locations; your installation
# will likely install numpy somewhere in the Python path hierarchy
python_prefix = os.environ['PYTHONDIR']
numpy_prefix = os.environ['NUMPYDIR'] + '/python/lib/python2.7/site-packages'

EXTRA_INCLUDE_PATH += ' %s/include/python2.7' % python_prefix
EXTRA_LIBRARY_PATH += ' %s/lib' % python_prefix
EXTRA_LINK_FLAGS   += ' -Wl,-rpath,%s/lib' % python_prefix

EXTRA_INCLUDE_PATH += ' %s/numpy/core/include' % numpy_prefix
EXTRA_LIBRARY_PATH += ' %s/numpy/core' % numpy_prefix
EXTRA_LINK_FLAGS   += ' -Wl,-rpath,%s/numpy/core' % numpy_prefix
EXTRA_LIBS += ' -lboost_python -lpython2.7'
