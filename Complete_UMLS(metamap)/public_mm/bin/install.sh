#! /bin/bash
# install.sh - Public MetaMap Install Program
#
# public_mm/bin/install.sh, Wed Jul 16 10:21:21 2008, edit by Will Rogers
#
# This script reads environment variables BASEDIR and JAVA_HOME from
# parent process.
# 
if [ -x ./bin/date ]; then
  echo "$0 started `./bin/date`"  > ./install.log
else
  echo "$0 started `date`"  > ./install.log
fi
if [ -z $OS ]; then
    if [ -x ./bin/uname ]; then
	OS=`./bin/uname`
    else
	OS=`uname`
    fi
fi
case $OS in
    "Linux")
        # GNU libc version test
	REQ_MAJOR_VERSION=2
	REQ_MINOR_VERSION=12
	echo "glib minimun required version: $REQ_MAJOR_VERSION.$REQ_MINOR_VERSION"   >> ./install.log
	echo "glib minimun required version: $REQ_MAJOR_VERSION.$REQ_MINOR_VERSION" 
	;;
    "Windows_NT" | "MINGW32_NT-5.1" | "CYGWIN_NT-6.1")
	PATH=$PATH:./bin
	;;
esac

# load installrc if present.
if [ -r .installrc ]; then
    source .installrc
fi
if [ "$BASEDIR" = "" ]; then
  BASEDIR=$PWD
fi
echo "Enter basedir of installation [$PWD] " 
read BASEDIR
if [ "$BASEDIR" = "" ]; then
  BASEDIR=$PWD
fi
BINDIR=$BASEDIR/bin

echo "Basedir is set to $BASEDIR."
echo "Basedir is set to $BASEDIR." >> ./install.log
echo ""
if [ ! $OS = "MINGW32_NT-5.1" ]; then
  echo The WSD Server requires Sun\'s Java Runtime Environment \(JRE\)\;
  echo Sun\'s Java Developer Kit \(JDK\) will work as well.  if the
  echo command: \"which\" java returns /usr/local/jre1.4.2/bin/java, then the
  echo JRE resides in /usr/local/jre1.4.2/.
fi
echo ""
echo "Where does your distribution of Sun\'s JRE reside?"
if [ "$JAVA_HOME" = "" ]; then
  javaprog=`which java`
  if [ $? -eq 0 ]; then
    javabindir=`dirname $javaprog`
    RC_JAVA_HOME=`dirname $javabindir`
  else
    RC_JAVA_HOME=""
  fi
else
  RC_JAVA_HOME=$JAVA_HOME
fi
echo  "Enter home path of JRE (JDK) [$RC_JAVA_HOME]: " 
read JAVA_HOME
if [ "$JAVA_HOME" = "" ]; then
   JAVA_HOME=$RC_JAVA_HOME
fi     

echo Using $JAVA_HOME for JAVA_HOME.
echo Using $JAVA_HOME for JAVA_HOME. >> ./install.log
echo ""

# setup WSD main and logging configuration files
if [ $OS = "MINGW32_NT-5.1" ]; then
    sed -e "s:@@basedir@@:\.\.:g" $BASEDIR/WSD_Server/config/disambServer.cfg.in > $BASEDIR/WSD_Server/config/disambServer.cfg
else 
    sed -e "s:@@basedir@@:$BASEDIR:g" $BASEDIR/WSD_Server/config/disambServer.cfg.in > $BASEDIR/WSD_Server/config/disambServer.cfg
fi
if [ -r $BASEDIR/WSD_Server/config/disambServer.cfg ]; then
  echo $BASEDIR/WSD_Server/config/disambServer.cfg generated
fi
if [ $OS = "MINGW32_NT-5.1" ]; then
sed -e "s:@@basedir@@:\.\.:g" $BASEDIR/WSD_Server/config/log4j.properties.in > $BASEDIR/WSD_Server/config/log4j.properties
else 
sed -e "s:@@basedir@@:$BASEDIR:g" $BASEDIR/WSD_Server/config/log4j.properties.in > $BASEDIR/WSD_Server/config/log4j.properties
fi
if [ -r $BASEDIR/WSD_Server/config/log4j.properties ]; then
  echo $BASEDIR/WSD_Server/config/log4j.properties generated
fi

if [ ! -d $BASEDIR/WSD_Server/log ]; then
  mkdir $BASEDIR/WSD_Server/log
  if [ -d $BASEDIR/WSD_Server/log ]; then
    echo Created directory $BASEDIR/WSD_Server/log
    echo Created directory $BASEDIR/WSD_Server/log >> ./install.log
  fi
fi

if [ ! -d $BASEDIR/MedPost-SKR/Tagger_server/log ]; then
  mkdir $BASEDIR/MedPost-SKR/Tagger_server/log
  if [ -d $BASEDIR/MedPost-SKR/Tagger_server/log ]; then
    echo Created directory $BASEDIR/Tagger_server/log
    echo Created directory $BASEDIR/Tagger_server/log >> ./install.log
  fi
fi

wsd_method_value="['AEC_METHOD']"

echo "Setting up bin directory scripts:"
echo "Setting up bin directory scripts:" >> ./install.log
# Setup all scripts generated from templates
for binscriptbase in $BASEDIR/bin/*.in
do
  binscript=`basename $binscriptbase .in`
  binscripttmp1=${binscript}.tmp1
  binscripttmp0=${binscript}.tmp0
  sed -e "s:@@basedir@@:$BASEDIR:g" $binscriptbase > $BINDIR/$binscripttmp1
  sed -e "s:@@java_home@@:$JAVA_HOME:g" $BINDIR/$binscripttmp1 > $BINDIR/$binscripttmp0
  sed -e "s:@@wsd_methods@@:$wsd_method_value:g" $BINDIR/$binscripttmp0 > $BINDIR/$binscript
  chmod +x $BINDIR/$binscript
  if [ -x $BINDIR/$binscript ]; then
    rm $BINDIR/$binscripttmp0
    rm $BINDIR/$binscripttmp1
    echo $BINDIR/$binscript generated.
    echo $BINDIR/$binscript generated. >> ./install.log
  fi
done

echo "Setting up test suite:"
echo "Setting up test suite:" >> ./install.log 2>&1

# Setup test script (runTest_<year>.sh runTest_<year>.sh)
for rtscripttmp in $BASEDIR/TestSuite/runTest_*.in
do
  rtscript=`basename $rtscripttmp .in`

  sed -e "s:@@basedir@@:$BASEDIR:g" $rtscripttmp > $BASEDIR/TestSuite/$rtscript
  chmod +x $BASEDIR/TestSuite/$rtscript
  if [ -x $BASEDIR/TestSuite/$rtscript ]; then
    echo $BASEDIR/TestSuite/$rtscript generated.
    echo $BASEDIR/TestSuite/$rtscript generated. >> ./install.log
  fi
done

# check for presence of lexicon, databases, tagger, and optional WSD.
echo "Checking for required datafiles"
echo "Checking for required datafiles" >> ./install.log
MISSINGFILES=0


checkforfile ()
{
    FLIST=`find $CHKDIR -name $CHKFILE -print | wc -l`
    if [ $FLIST == 0 ]; then
	echo "Warning: the $CHKFILE file is missing in $CHKDIR, cannot ensure correct operation of MetaMap without file!"
	echo "Warning: the $CHKFILE file is missing in $CHKDIR, cannot ensure correct operation of MetaMap without file!" >> ./install.log
	echo ""
	MISSINGFILES=`expr $MISSINGFILES + 1`
    fi
}

cd $BASEDIR

# DB Lexicon files
case $OS in
    "Windows_NT" | "MINGW32_NT-5.1" | "CYGWIN_NT-6.1")
	CHKDIR=./DB/\*.strict
	;;
    *)
	CHKDIR=./lexicon/data
	;;
esac
CHKFILE=dm_vars
checkforfile
CHKFILE=im_vars
checkforfile
CHKFILE=lex_form
checkforfile
CHKFILE=lex_rec
checkforfile
CHKFILE=norm_prefix
checkforfile

# MetaMap DB files
CHKDIR=./DB
CHKFILE=DB.\*.base
checkforfile
CHKFILE=DB.\*.[smr]\* 
checkforfile


# MedPost SKR tagger directory
TAGDIR=`find . -name MedPost-SKR -print | wc -l`
if [ $TAGDIR -eq 0 ]; then
  echo "Warning: Tagger directory is missing, cannot ensure correct operation of MetaMap without it!"
  echo "Warning: Tagger directory is missing, cannot ensure correct operation of MetaMap without it!" >> ./install.log
  echo ""
  MISSINGFILES=`expr $MISSINGFILES + 1`
else
  # MedPost SKR tagger files
  TAGFILES=`find ./MedPost-SKR/data -name \*.cur -print | wc -l`
  if [ $TAGFILES -eq 0 ]; then
    echo "Warning: Tagger index files are missing, cannot ensure correct operation of MetaMap without them!"
    echo "Warning: Tagger index files are missing, cannot ensure correct operation of MetaMap without them!" >> ./install.log
    echo ""
    MISSINGFILES=`expr $MISSINGFILES + 1`
  fi
fi

echo "Checking for optional datafiles (WSD)"
echo "Checking for optional datafiles (WSD)" >> ./install.log 2>&1 2>&1
MISSINGOPTIONS=0

# WSD Server directory
WSDDIR=`find . -name WSD_Server -print | wc -l`
if [ $WSDDIR -eq 0 ]; then
  echo "Warning: WSD Server directory is missing, MetaMap will not have WSD support without it!"
  echo "Warning: WSD Server directory is missing, MetaMap will not have WSD support without it!" >> ./install.log
  echo ""
  MISSINGOPTIONS=`expr $MISSINGOPTIONS + 1`
else 
  # WSD Server files
  # WSDFILES=`find ./WSD_Server -name wstv\* -print | wc -l`
  # if [ $WSDFILES == 0 ]; then
  #   echo "Warning: WSD Server index files are missing, MetaMap will not have WSD support without it!"
  #   echo "Warning: WSD Server index files are missing, MetaMap will not have WSD support without it!" >> ./install.log
  #   echo ""
  #   MISSINGOPTIONS=`expr $MISSINGOPTIONS + 1`
  # fi
  echo ""
fi

# echo BASEDIR=$BASEDIR > .installrc
# echo JAVA_HOME=$JAVA_HOME >> .installrc
echo "MISSINGOPTIONS=$MISSINGOPTIONS" >> ./install.log
if [ $MISSINGOPTIONS -ge 1 ]; then
  echo "!! WARNING: Some optional datafiles are missing, see install.log for more information. !!"
  echo "!! WARNING: Some optional datafiles are missing, see install.log for more information. !!" >> ./install.log
fi

echo "MISSINGFILES=$MISSINGFILES" >> ./install.log
if [ $MISSINGFILES -ge 1 ]; then
  echo "!! WARNING: Some necessary datafiles are missing, see install.log for more information. !!"
  echo "!! WARNING: Some necessary datafiles are missing, see install.log for more information. !!" >> ./install.log
else
  echo Public MetaMap Install complete.
  echo Public MetaMap Install complete. >> ./install.log
fi
echo "$0 ended `date`"  >> ./install.log

export BASEDIR

if [ -f $BASEDIR/bin/install_dfb.sh ]; then 
  echo  "Would like to use a custom data set with MetaMap (use data file builder)? [yN]:"
  read RESPONSE
  if [ "$RESPONSE" = "y" ]; then
     echo "running Data File Builder Install..."
     . $BASEDIR/bin/install_dfb.sh
  fi
fi

if [ -f $BASEDIR/bin/install_src.sh ]; then 
    echo "Running MetaMap source development environment setup..."
    . $BASEDIR/bin/install_src.sh
fi

if [ -f $BASEDIR/bin/install_javaapi.sh ]; then 
    echo "Running MetaMap Java API development environment setup..."
    . $BASEDIR/bin/install_javaapi.sh
fi

if [ -f $BASEDIR/bin/install_uima.sh ]; then 
    echo "Running MetaMap UIMA API development environment setup..."
    . $BASEDIR/bin/install_uima.sh
fi

echo ""
echo "Public MetaMap Install Settings:"
echo ""
echo "Public MetaMap basedir: $BASEDIR"
echo "Public MetaMap Program Dir: $BINDIR"
echo "Java Home dir: $JAVA_HOME"

echo "Public MetaMap basedir: $BASEDIR" >> ./install.log
echo "Public MetaMap Program Dir: $BINDIR" >> ./install.log
echo "Java Home dir: $JAVA_HOME" >> ./install.log
echo ""

exit 0
