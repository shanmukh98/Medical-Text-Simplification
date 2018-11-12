#!/bin/sh

BASEDIR=/home/rallaakhil/IRE/project/complete_umls/public_mm
PBJAR=$BASEDIR/src/javaapi/dist/prologbeans.jar
MMAJAR=$BASEDIR/src/javaapi/dist/MetaMapApi.jar
case $OS in
    Windows_NT)
	java -classpath $PBJAR\;$MMAJAR gov.nih.nlm.nls.metamap.MetaMapApiTest $*
	;;
    *)
	java  -classpath $PBJAR:$MMAJAR gov.nih.nlm.nls.metamap.MetaMapApiTest $*
	;;
esac
