#!/bin/sh

CLASSES=./classes
if [ -d ./build/classes ] ; then 
    CLASSES=./build/classes
elif [ -d ./target/classes ] ; then 
    CLASSES=./target/classes
elif [ -d ./dist/MetaMapApi.jar ] ; then 
    CLASSES=./dist/MetaMapApi.jar
elif [ -d ./target/metamap-api-2.0.jar ] ; then 
    CLASSES=./target/metamap-api-2.0.jar
fi


#PBJAR=$QUINTUS/java3.5/prologbeans.jar 
PBJAR=$SICSTUS_HOME/bin/sp-$SICSTUS_VERSION/sicstus-$SICSTUS_VERSION/bin/prologbeans.jar 
# java -classpath $PBJAR:./build/classes gov.nih.nlm.nls.metamap.MetaMapApiTest $*
# java -classpath $PBJAR:./dist/MetaMapApi.jar gov.nih.nlm.nls.metamap.MetaMapApiTest $*
# java -classpath $PBJAR:./target/classes gov.nih.nlm.nls.metamap.MetaMapApiTest $*
case $OS in
    Windows_NT)
	java -classpath $PBJAR;$CLASSES gov.nih.nlm.nls.metamap.MetaMapApiTest $*
	;;
	*)
	java -classpath $PBJAR:$CLASSES gov.nih.nlm.nls.metamap.MetaMapApiTest $*
	;;
esac



