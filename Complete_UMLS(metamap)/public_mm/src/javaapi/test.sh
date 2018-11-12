#!/bin/sh

PBJAR=$QUINTUS/java3.5/prologbeans.jar 
# java -classpath $PBJAR:./classes TestGUI

java -classpath $PBJAR:./classes gov.nih.nlm.nls.metamap.AutoGen $*
