#!/bin/bash
n=$(basename $0)
v="4.0.1.1"
if [ "$n" == 'gatk' -o "$n" == 'GenomeAnalysisTK' ]; then
  args=()
  for a in "$@"; do
    if [ "$a" == "--java-options" ]; then
      java_opts_found=true
    fi
    args+=("$a")
  done
  if [ -n "$1" -a "$1" != "--list" -a -z "$java_opts_found" ]; then
    java_opts=(--java-options "`eval echo $GATK_JAVA_OPTS`")
  fi
  exec "${GATKDIR}/gatk-${v}/gatk" "${java_opts[@]}" "${args[@]}"
elif [[ "$n" == gatk_* ]]; then
  n=$(echo "$n" | cut -c6-)
else
  echo "$0: unable to determine GATK task to execute."
  exit 1
fi
exec java `eval echo $GATK_JAVA_OPTS` -jar "${GATKDIR}/gatk-${v}/gatk-package-${v}-local.jar" $n "$@"
