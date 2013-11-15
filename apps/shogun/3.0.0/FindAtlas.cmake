find_file(ATLAS_LIB libtatlas.so PATHS $ENV{ATLASLIB} PATH_SUFFIXES atlas atlas-base)
find_library(ATLAS_LIB atlas PATHS $ENV{ATLASDIR})
set(ATLAS_LIBRARIES ${ATLAS_LIB})
set(ATLAS_INCLUDES $ENV{ATLASINCLUDE})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ATLAS DEFAULT_MSG ATLAS_LIBRARIES ATLAS_INCLUDES)

mark_as_advanced(ATLAS_LIBRARIES ATLAS_INCLUDES)
