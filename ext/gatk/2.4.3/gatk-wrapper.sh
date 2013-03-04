#!/bin/bash
n=$(basename $0)
if [ "$n" == 'gatk' -o "$n" == 'GenomeAnalysisTK' ]; then
  n=""
elif [[ "$n" == gatk_* ]]; then
  n=$(echo "$n" | cut -c6-)
  t="-T"
else
  echo "$0: unable to determine GATK task to execute."
  exit 1
fi
exec java `eval echo $GATK_JAVA_OPTS` -jar "$GATKDIR/GenomeAnalysisTK.jar" $t $n "$@"
