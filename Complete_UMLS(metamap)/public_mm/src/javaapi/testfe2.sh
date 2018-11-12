#!/bin/sh

PBJAR=$QUINTUS/java3.5/prologbeans.jar 
java -classpath $PBJAR:./build/classes test.TestFE2 $*
