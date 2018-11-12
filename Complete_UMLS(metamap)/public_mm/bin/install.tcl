#!/bin/sh
#  -*-tcl-*-
#
# Main install program for Public MetaMap - Tcl version
#
# Java must be previously installed.
#
# the next line restarts using tclsh \
    exec tclsh "$0" "$@"
#
if [info exists env(OS)] {
  # load registry package if os is Windows
  if { $env(OS) == "Windows_NT" } { 
    package require registry 1.1
  }
} else {
  set env(OS) [exec uname]
}
set os $env(OS)

# Procedure: win2unix_path
# Tranform Windows path to MINGW UNIX path.
# Drive:\path\ becomes /Drive/path/
# E.G.:
#  G:\test\public_mm becomes /g/test/public_mm
# PARAMS:
#  winpath: Windows path
# RETURNS:
#  MINGW UNIX path
proc win2unix_path { winpath } {
  regsub ":" $winpath "" tmp0
  regsub -all "\\\\" $tmp0 "/" tmp1
  set fields [split $tmp1 "/"]
  set tmp [join [linsert  [lrange $fields 1 end] 0 [string tolower [lindex $fields 0]]] "/"]
  return [format "/%s" $tmp]
}

# Procedure: bslash2fslash
# Convert back slashs to forward slashes
# PARAMS:
#  path: path with back slashes
# RETURNS:
#  path with forward slashs
proc bslash2fslash { path } {
  regsub -all "\\\\" $path "/" tmp
  return $tmp
}

# Procedure: fslash2bslash
# Convert forward slashes to back slashs
# PARAMS:
#  path: path with forward slashs
# RETURNS:
#  path with back slashes
proc fslash2bslash { path } {
  regsub -all "/" $path "\\\\" tmp
  return $tmp
}

# Procedure: fslash2bslash_win32
# Convert forward slashes to back slashs
# PARAMS:
#  path: path with forward slashs
# RETURNS:
#  path with back slashes
proc fslash2bslash_win32 { path } {
  regsub -all "/" $path "\\" tmp
  return $tmp
}

# Procedure: bslash2fslash_unix
# Convert forward slashes to back slashs and 
# convert device name to MINGW device path.
# PARAMS:
#  path: path with forward slashs
# RETURNS:
#  path with back slashes
proc bslash2fslash_unix { path } {
  regsub -all "\\\\" $path "/" tmp0
  regsub -all ":" $tmp0 "" tmp1
  regsub -all " " $tmp1 "\\ " tmp2
  set tmp [format "/%s" $tmp2]
  return $tmp
}

# Procedure: bslash2fslash
# Convert forward slashes to back slashs
# PARAMS:
#  path: path with forward slashs
# RETURNS:
#  path with back slashes
proc bslash2fslash { path } {
  regsub -all "\\\\" $path "/" tmp0
  regsub -all " " $tmp0 "\\ " tmp1
  return $tmp1
}

# Procedure: genfile
# Replace pattern macros in template with associated value
# PARAMS:
#  template: template to generate file using.
#  destfilename: destination of generated file.
proc genfile { template destfilename } {
  global macro

  set ext [file extension [file rootname $template]]
  switch $ext {
    ".bat" {
      set index 1
    }
    ".cfg" -
    ".properties" {
      set index 2
    }
    default {
      set index 0
    }
  }
  set tempfp [open $template]
  set destfp [open $destfilename w]
  while { [gets $tempfp line] >= 0} {
    set updatedline $line
    foreach pattern [array names macro] {
      set sourceline $updatedline
      regsub -all $pattern $sourceline [lindex $macro($pattern) $index] updatedline
    }
    fputs $destfp $updatedline
  }
  close $destfp
  close $tempfp
  puts [format "%s generated" $destfilename]
}

# Procedure: getresidentdir
#
# Get the full pathname of directory in which the supplied program
# name is resident.
#
# PARAMS: programname - name of program
# RETURNS: full directory pathname or empty string if path cannot 
#          be determined.
#
proc getresidentdir { programname } {
  if {[catch {exec which $programname} programpath]} {
    return ""
  } else {
  return [join [lrange [split [file dirname $programpath] "/"] 0 end-1] "/"]
  }
}

if [string equal $os "Windows_NT"] {
  if [info exists env(BASEDIR)] {
    set rc_basedir [bslash2fslash $env(BASEDIR)]
  } else {
    set rc_basedir [bslash2fslash [pwd]]
  }
} else {
  if [info exists env(BASEDIR)] {
    set rc_basedir $env(BASEDIR)
  } else {
    set rc_basedir [pwd]
  }
}

# Procedure: read_response
#
# PARAMS:
#   prompt
#   varname : name of variable to be set
#   vardefault : default value to set 
proc read_response { prompt varname vardefault } {
  upvar $varname localVar

  puts -nonewline [format "%s \[%s]\]: " $prompt $vardefault]
  flush stdout
  set resp [gets stdin]
  if { [string length [string trim $resp]] == 0} {
    set localVar $vardefault
  } else {
    set localVar $resp
  }
  puts [format "%s <- %s" $varname $localVar]
}

read_response "Enter basedir of installation" basedirpath $rc_basedir

set bindir ${basedirpath}/bin
puts "bindir: $bindir"

puts "Basedir is set to $basedirpath."
# putmsg "Basedir is set to $BASEDIR." 
puts ""
puts "Where does your distribution of Sun\'s JRE reside?"
if [info exists env(JAVA_HOME)] {
  set rc_java_home $env(JAVA_HOME)
} elseif { [string equal -length 7 $os "Windows_NT"] } {
  # get java path from the registry
  set java_reg_path "HKEY_LOCAL_MACHINE\\Software\\JavaSoft\\Java Runtime Environment"
  set versionlist [registry keys $java_reg_path]
  puts "versionliat: $versionlist"
  foreach fv $versionlist {
    lappend javapathlist [registry get "${java_reg_path}\\$fv" JavaHome]
  }
  puts "javapathliat: $javapathlist"
  set rc_java_home [lindex $javapathlist 0]
} else {
  set rc_java_home ""
}
set java_home ""
while { $java_home == "" } {
  puts ""
  puts "The install program found an installation of Java"
  puts "at $rc_java_home. To use this as the "
  puts "installation just press return.  Otherwise, enter" 
  puts "desired location of Java at prompt."
  puts ""
  puts -nonewline "Enter home path of JRE (JDK) \[$rc_java_home\]: " 
  flush stdout
  set resp [gets stdin]
  if { [string length [string trim $resp]] > 0} {
    set java_home $resp
    set env(JAVA_HOME) $resp
  } elseif { [string length [string trim $resp]] == 0 && \
		 [string length $rc_java_home] > 0 } {
    set java_home $rc_java_home
  }
}
set javadirpath $java_home

# Procedure: genfile
# Replace pattern macros in template with associated value
# PARAMS:
#  template: template to generate file using.
#  destfilename: destination of generated file.
proc genfile { template destfilename } {
  global macro
  if { [string equal ".bat" [file extension [file rootname $template]]] } {
    set index 1
  } else {
    set index 0
  }
  set tempfp [open $template]
  set destfp [open $destfilename w]
  while { [gets $tempfp line] >= 0} {
    set updatedline $line
    foreach pattern [array names macro] {
      set sourceline $updatedline
      regsub -all $pattern $sourceline [lindex $macro($pattern) $index] updatedline
    }
    puts $destfp $updatedline
  }
  close $destfp
  close $tempfp
  puts [format "%s generated" $destfilename]
}

# associative array of replacement patterns and their replacements
#                             unixpath        win32path                          javapath
set macro(@@basedir@@) [list ${basedirpath} [fslash2bslash_win32 ${basedirpath}] ${basedirpath}]

puts ""

# set WSD main and logging configuration files
genfile ${basedirpath}/WSD_Server/config/disambServer.cfg.in ${basedirpath}/WSD_Server/config/disambServer.cfg
genfile ${basedirpath}/WSD_Server/config/log4j.properties.in ${basedirpath}/WSD_Server/config/log4j.properties

file mkdir ${basedirpath}/WSD_Server/log
# create tagger server directory
file mkdir ${basedirpath}/MedPost-SKR/Tagger_server/log

puts "Setting up bin directory scripts:"
set macro(@@java_home@@) ${java_home}
foreach template [glob -directory ${bindir} *.in] {
  regsub {\.in} $template {} binscript
  genfile $template $binscript
}

puts "Setting up test suite:"
# Setup test script (runTest_<year>.sh runTest_<year>.sh)
foreach template [glob -directory ${basedirpath}/TestSuite runTest_*.sh.in] {
  regsub {\.in} $template {} binscript
  genfile $template $binscript
}

set env(BASEDIR) $basedirpath

# check for presence of lexicon, databases, tagger, and optional WSD.
puts "Checking for required datafiles"
set missingfiles 0

# Procedure: checkforfiles
# Check for file in specified directory
#
# PARAMS
#  checkdir       directory to check
#  checkfilelist  list of files to check for
proc checkforfiles { checkdir checkfilelist } {
  foreach checkfile $checkfilelist {
    if {[llength [glob -nocomplain -directory $checkdir $checkfile]] == 0} {
      puts "Warning: the $checkfile file is missing from $checkdir, \
cannot ensure correct operation of MetaMap without them!"
      incr missingfiles
    }
  }
}

# DB Lexicon files
switch $env(OS) {
  Windows_NT -
  MINGW32_NT-5.1 -
  CYGWIN_NT-6.1 {
    set checkdir [glob ./DB/\*.strict]
  }
  default {
    set checkdir $basedirpath/lexicon/data
  }
}
checkforfiles  $checkdir { 
  dm_vars im_vars lex_form lex_rec norm_prefix
}



# # lexicon morphology rules
# if {[llength [glob -directory $basedirpath/lexicon/morph *rules]] == 0} {
#   puts "Warning: lexicon rules files are missing, cannot ensure correct operation of MetaMap without them!"
#   incr missingfiles
# }
# # lexicon morphology facts
# if {[llength [glob -directory $basedirpath/lexicon/morph *facts]] == 0} {
#   puts "Warning: lexicon facts files are missing, cannot ensure correct operation of MetaMap without them!"
#   incr missingfiles
# }

# # lexicon lookup filrs
# if {[llength [glob -directory $basedirpath/lexicon/data lexicon*]] < 3} {
#   puts "Warning: lexicon lookup files are missing, cannot ensure correct operation of MetaMap without them!"
#   incr missingfiles
# }
# puts "Trying to fix any lexicon text files that may have been converted from lf to crlf..."
# foreach lexicon_text [glob -directory $basedirpath/lexicon/data {lexiconStatic????}] {
#   puts [format "Converting: %s" $lexicon_text]
#   exec dos2unix -U $lexicon_text
# }

# MetaMap DB files
if {[llength [glob -directory $basedirpath/DB *.base]] == 0} {
  puts "Warning: UMLS index files are missing, cannot ensure correct operation of MetaMap without them!"
  incr missingfiles
}
if {[llength [glob -directory $basedirpath/DB *.\[sr\]*]] == 0} {
  puts "Warning: UMLS index files are missing, cannot ensure correct operation of MetaMap without them!"
  incr missingfiles
}

# MedPost SKR tagger files
if {[llength [glob -directory $basedirpath MedPost-SKR]] == 0} {
  puts "Warning: Tagger directory is missing, cannot ensure correct operation of MetaMap without it!"
  incr missingfiles
} elseif {[llength [glob -directory $basedirpath/MedPost-SKR/data *.cur]] == 0} {
  puts "Warning: UMLS index files are missing, cannot ensure correct operation of MetaMap without them!"
  incr missingfiles
}
if { $missingfiles != 0 } {
  puts "!! WARNING: Some necessary datafiles are missing, see install.log for more information. !!"
} else {
  puts "required files ok."
}

set missingoptions 0
puts "Checking for optional datafiles (WSD)"
if {[llength [glob -directory $basedirpath WSD_Server]] == 0} {
  puts "Warning: WSD Server directory is missing, MetaMap will not have WSD support without it!"
  incr missingoptions
}

# if {[llength [glob -directory $basedirpath/WSD_Server/wstv-dc *.ser]] == 0} {
#   puts "Warning: WSD Server index files are missing, MetaMap will not have WSD support without it!"
#   incr missingoptions
# }

if { $missingoptions != 0 } {
  puts "!! WARNING: Some optional datafiles are missing, see install.log for more information. !!"
} else {
  puts "optional files ok."
}
puts "Main Public MetaMap Install complete."

# run install file for auxillary packages

if [file exists $basedirpath/bin/install_dfb.tcl ] {
  puts -nonewline  "Would like to use a custom data set with MetaMap (use data file builder)? \[yN\]:"
  flush stdout
  set response [gets stdin]
  if [string equal -nocase -length 1 $response "y"] {
    puts "running Data File Builder Install..."
    source ${basedirpath}/bin/install_dfb.tcl
  }
}

if [file exists $basedirpath/bin/install_src.tcl] {
  puts "Running MetaMap source development environment setup..."
  source ${basedirpath}/bin/install_src.tcl
}

if  [file exists ${basedirpath}/bin/install_javaapi.tcl] {
  puts "Running MetaMap Java API development environment setup..."
  source ${basedirpath}/bin/install_javaapi.tcl
}

if  [file exists ${basedirpath}/bin/install_uima.tcl] {
  puts "Running MetaMap UIMA API development environment setup..."
  source ${basedirpath}/bin/install_uima.tcl
}

puts ""
puts "Public MetaMap Install Settings:"
puts ""
puts "Public MetaMap basedir: $basedirpath"
puts "Public MetaMap Program Dir: $bindir"
puts "Java Home dir: $java_home"

puts ""
puts "$argv0 ended [exec date]" 

exit 0
