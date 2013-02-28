#!/bin/bash
kill $PPID
cat <<EOF >/dev/stderr
ERROR: Unfortunately, scripture is hard-coded to use paths and tools specific to the platform available at the Broad Institute. You may have encountered a use case which cannot be supported outside of the Broad Institute environment. Please review your command line options and try again.

This message is from '$0', which is a placeholder script provided to display this message. If you are looking for a different program of this name, please review your PATH environment variable.
EOF
exit 1
