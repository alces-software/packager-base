#!/bin/bash
n=$(basename $0)
if [ ! -x "${HICUPDIST}/$n" ]; then
  echo "$0: no such hicup command"
  exit 1
fi
exec "${HICUPDIST}/$n" "$@"
