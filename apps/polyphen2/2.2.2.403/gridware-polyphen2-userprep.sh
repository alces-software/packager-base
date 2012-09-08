#!/bin/bash
if [ ! -d "~/polyphen2" ]; then
  SRCDIR=$1
  echo ""
  echo " > Preparing home directory ($HOME) for polyphen2 execution."
  echo ""
  cp -av "$SRCDIR/skel" ~/polyphen2
  echo ""
  echo " > Home directory ($HOME) has been prepared for polyphen2 execution."
  echo ""
else
  echo ""
  echo " > Home directory ($HOME) is already prepared for polyphen2 execution."
  echo ""
fi
