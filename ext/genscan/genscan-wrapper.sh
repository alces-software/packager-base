#!/bin/bash
n=$(basename $0)
case $n in
    genmaiz)
	SMAT=Maize
	;;
    genvert)
	SMAT=HumanIso
	;;
    genarab)
	SMAT=Arabidopsis
	;;
    *)
	echo "$0: unable to determine genscan parameter file to use."
	exit 1
	;;
esac
exec genscan "$GENSCANSHARE/$SMAT.smat" "$@"
