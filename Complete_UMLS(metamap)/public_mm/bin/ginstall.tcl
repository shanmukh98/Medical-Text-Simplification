#!/bin/sh
#  -*-tcl-*-
#
# ginstall.tcl --  a GUI-based install program for Public MetaMap
#
# Graphical Layout:
# Page1:
#  Location of Public MetaMap Directory:  ___________________ [browse]
# Page2:
#  Location of Java Installation  Directory: ________________________ [known javadirs] [browse]
# Java must be previously installed.
#
# the next line restarts using wish \
    exec wish "$0" "$@"

if [info exists env(OS)] {
  # load registry package if os is Windows
  if { $env(OS) == "Windows_NT" } { 
    package require registry 1.1
  }
} else {
  set env(OS) [exec uname]
}

proc build_dialog { panel proglabel msgtext entryinfo prevcmd nextcmd  { browsecmd doBrowseDirectory } } {
  wm title . $proglabel
  message $panel.msg -text $msgtext -width 350
  set i 0
  foreach entry $entryinfo {
    build_input $panel $i  [lindex $entry 0] [lindex $entry 1] $browsecmd
    incr i
  }
  pack $panel.msg -fill both -expand y
  frame ${panel}.baseframe -relief raised
  label ${panel}.proglabel -text $proglabel -font {Courier 14 bold}
  button ${panel}.prev -text "Previous" -command $prevcmd
  button ${panel}.next -text "Next" -command $nextcmd
  pack ${panel}.proglabel -in ${panel}.baseframe -side left
  pack ${panel}.next -in ${panel}.baseframe -side right
  pack ${panel}.prev -in ${panel}.baseframe -side right
  pack ${panel}.baseframe  -in ${panel} -side bottom -fill x -expand y
  pack $panel -fill both -expand y
  return ${panel}
}

proc build_input { panel i labeltext inputvarname { browsecmd doBrowseDirectory } } {
  frame ${panel}.inputframe${i} 
  label ${panel}.label${i} -text $labeltext
  entry ${panel}.entry${i} -textvariable $inputvarname -width 25
  button ${panel}.browse${i} -text "Browse" -command [list $browsecmd $inputvarname]
  pack ${panel}.label${i} -in ${panel}.inputframe${i} -side left
  pack ${panel}.entry${i} -in ${panel}.inputframe${i} -side left -fill x -expand y
  pack ${panel}.browse${i} -in ${panel}.inputframe${i} -side left
  pack ${panel}.inputframe${i} -in ${panel} -fill x -expand y
  return ${panel}.inputframe${i}
}

proc build_log_widget { panel proglabel prevcmd nextcmd } {
  wm title . $proglabel
  frame ${panel}.logframe
  text ${panel}.text -yscrollcommand "${panel}.scroll set" -background lightgrey -width 72 -height 18 -font {fixed 10}
  scrollbar ${panel}.scroll -command "${panel}.text yview"
  ${panel}.text config -yscrollcommand "${panel}.scroll set" -relief sunken

  frame ${panel}.baseframe
  label ${panel}.proglabel -text $proglabel -font {Courier 14 bold}
  button ${panel}.prev -text "Previous" -command $prevcmd
  button ${panel}.next -text "Next" -command $nextcmd

  pack ${panel}.text -in ${panel}.logframe -fill both -expand y -side left
  pack ${panel}.scroll -in ${panel}.logframe -side left -fill y
  pack ${panel}.logframe -in ${panel} -side top -fill both -expand y

  pack ${panel}.next -in ${panel}.baseframe -side right -pady .25c -padx .25c
  pack ${panel}.prev -in ${panel}.baseframe -side right -pady .25c -padx .25c
  pack ${panel}.proglabel -in ${panel}.baseframe -side left 
  pack ${panel}.baseframe -in ${panel} -side bottom -fill x
  pack $panel -fill both -expand y
  update idletasks
  return ${panel}
}

# rename tcl puts to fputs
rename puts fputs

# Procedure: puts
# redirect puts into log window
#  PARAMETERS
#   end_of_line: "-nonewline" if newline should not be added.
#   string:      string to be printed.
proc puts { args } {
    if { [llength $args] > 1 } {
	set end_of_line [lindex $args 0]
	set arg [lindex $args 1]
    } else {
	set end_of_line "-newline"
	set arg [lindex $args 0]
    }
    
    if {$end_of_line == "-nonewline"} {
      .panel.text insert end "${arg}"
    } else {
      .panel.text insert end "${arg}\n"
    }
  .panel.text yview end
  update
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
# NOTE: only works on UNIX or UNIX-like systems.
#
proc getresidentdir { programname } {
  if {[catch {exec which $programname} programpath]} {
    return ""
  } else {
  return [join [lrange [split [file dirname $programpath] "/"] 0 end-1] "/"]
  }
}

# Procedure: doBrowseDirectory
# PARAMS:
#   varname - reference to global directory variable to be 
#             modified by tk_chooseDirectory.
proc doBrowseDirectory { varname } {
  global $varname
  set $varname [tk_chooseDirectory -mustexist 1]
}

# Procedure: bye
#  Exit program.
proc bye { } {
  exit 0
}

# Procedure: doNext
# invoke next dialog
# GLOBALS:
#    dialog_index - where program is in dialog list
#    dialog_list  - list of user dialogs
#
proc doNext { } {
  global dialog_index
  global dialog_list

  destroy .panel
  frame .panel
  incr dialog_index
  eval [lindex $dialog_list $dialog_index]  
}

# Procedure: doPrevious
# invoke previous dialog
# GLOBALS:
#    dialog_index - where program is in dialog list
#    dialog_list  - list of user dialogs
#
proc doPrevious { } {
  global dialog_index
  global dialog_list

  destroy .panel
  frame .panel
  incr dialog_index -1
  eval [lindex $dialog_list $dialog_index]
}

# Procedure: baseDirDialog
# Configure primary top-level window as Initial Dialog Box.
# GLOBALS:
#   basedirpath            - public_mm basedir, usually "public_mm"
#
proc baseDirDialog { } {
  set proglabel "Base Directory"
  set labeltext "Location of Public MetaMap Directory: "
  set msgtext \
      "Enter location where you extracted the Public MetaMap archive (including the public_mm directory).\n"

  lappend entryinfo [list $labeltext basedirpath]
  build_dialog .panel $proglabel $msgtext $entryinfo doPrevious doNext 
  pack forget .panel.prev
}

# Procedure: javaDirDialog
# Re-configure primary top-level window as Java Location Dialog Box.
#
# GLOBALS:
#   basedirpath            - public_mm basedir, usually "public_mm"
#   javadirpath            - Java JRE or SDK install directory
#
proc javaDirDialog { } {
  global basedirpath
  global javadirpath

  if { $basedirpath != "" } {
    wm geometry . 640x200
    set proglabel "Java Directory"
    set labeltext "Location of Java Installation Directory: "
    set msgtext "The install program found an installation of Java \
at $javadirpath. To use this as the \
installation just press the \"Next\" button.  Otherwise, enter the\
desired location of Java at prompt."

  lappend entryinfo [list $labeltext javadirpath]
  build_dialog .panel $proglabel $msgtext $entryinfo doPrevious doNext
  }
}

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

# Procedure: completeInstall
# Complete Installation (this must run last)
#
# GLOBALS:
#   basedirpath            - public_mm basedir, usually "public_mm"
#   javadirpath            - Java JRE or SDK install directory
#   macro                  - array of substitution macros
#   additional_module_list - list of addition subsystems to install
#
proc completeInstall { } {
  global basedirpath
  global javadirpath
  global macro
  global additional_module_list
  global env

  wm geometry . 800x480
  set proglabel "Performing Main MetaMap Install"
  set lpanel [build_log_widget .panel $proglabel doPrevious doNext ]
  pack forget ${lpanel}.prev
  pack forget ${lpanel}.next

  puts "basedir: $basedirpath"
  puts "javadir: $javadirpath"
  set basedir $basedirpath
  set java_home $javadirpath
  set bindir ${basedir}/bin
  puts "bindir: $bindir"
  
  if { [info exists env(OS)] && $env(OS) == "Windows_NT" } {
    # associative array of replacement patterns and their replacements
    #                               unixpath                       win32path                        javapath
    set macro(@@basedir@@)   [list [bslash2fslash_unix ${basedir}] [bslash2fslash ${basedir}] [bslash2fslash ${basedir}]]
    set macro(@@java_home@@) [list $java_home [fslash2bslash_win32 ${java_home}] $java_home]
  } else {
    # associative array of replacement patterns and their replacements
    #                               unixpath  ospath       javapath
    set macro(@@basedir@@)   [list ${basedir} ${basedir}   ${basedir}]
    set macro(@@java_home@@) [list $java_home ${java_home} ${java_home}]
  }
  # parray macro
  foreach name [array names macro] {
    puts [format "%s -> %s" $name $macro($name)]
  }

  # set WSD main and logging configuration files
  genfile ${basedir}/WSD_Server/config/disambServer.cfg.in ${basedir}/WSD_Server/config/disambServer.cfg
  genfile ${basedir}/WSD_Server/config/log4j.properties.in ${basedir}/WSD_Server/config/log4j.properties

  file mkdir ${basedir}/WSD_Server/log
  # create tagger server directory
  file mkdir ${basedir}/MedPost-SKR/Tagger_server/log

  puts "Setting up bin directory scripts:"
  foreach template [glob -nocomplain -nocomplain -directory ${bindir} *.in] {
    regsub {\.in} $template {} binscript
    genfile $template $binscript
    if { $env(OS) != "Windows_NT" } {
      file attributes $binscript -permissions ugo+rx
    }
  }

  puts "Setting up test suite:"
  # Setup test script (runTest_<year>.sh runTest_<year>.bat)
  foreach template [glob -nocomplain -directory ${basedir}/TestSuite runTest_*.in] {
    regsub {\.in} $template {} binscript
    genfile $template $binscript
  }

  set env(BASEDIR) $basedir

  # check for presence of lexicon, databases, tagger, and optional WSD.
  puts "Checking for required datafiles"
  set missingfiles 0

  # DB Lexicon files
  switch $env(OS) {
    Windows_NT -
    MINGW32_NT-5.1 -
    CYGWIN_NT-6.1 {
      set checkdirlist [glob ./DB/DB.\*.strict]
    }
    default {
      set checkdirlist [glob $basedirpath/lexicon/data/*]
    }
  }
  foreach checkdir $checkdirlist {
    checkforfiles  $checkdir { 
      dm_vars im_vars lex_form lex_rec norm_prefix
    }
  }

  # # lexicon morphology rules
  # if {[llength [glob -nocomplain -directory $basedir/lexicon/morph *rules]] == 0} {
  #   puts "Warning: lexicon rules files are missing, cannot ensure correct operation of MetaMap without them!"
  #   incr missingfiles
  # }
  # # lexicon morphology facts
  # if {[llength [glob -nocomplain -directory $basedir/lexicon/morph *facts]] == 0} {
  #   puts "Warning: lexicon facts files are missing, cannot ensure correct operation of MetaMap without them!"
  #   incr missingfiles
  # }

  # # lexicon lookup filrs
  # if {[llength [glob -nocomplain -directory $basedir/lexicon/data lexicon*]] < 3} {
  #   puts "Warning: lexicon lookup files are missing, cannot ensure correct operation of MetaMap without them!"
  #   incr missingfiles
  # }
  # if [info exists env(OS)] {
  #   if { $env(OS) == "Windows_NT" } {
  #     puts "Trying to fix any lexicon text files that may have been converted from lf to crlf..."
  #     foreach lexicon_text [glob -nocomplain -directory $basedir/lexicon/data {lexiconStatic????}] {
  # 	puts [format "Converting: %s" $lexicon_text]
  # 	exec dos2unix -U $lexicon_text
  #     }
  #   }
  # }

  # MetaMap DB files
  if {[llength [glob -nocomplain -directory $basedir/DB *.base]] == 0} {
    puts "Warning: UMLS index files are missing, cannot ensure correct operation of MetaMap without them!"
    incr missingfiles
  }
  if {[llength [glob -nocomplain -directory $basedir/DB *.\[sr\]*]] == 0} {
    puts "Warning: UMLS index files are missing, cannot ensure correct operation of MetaMap without them!"
    incr missingfiles
  }

  # MedPost SKR tagger files
  if {[llength [glob -nocomplain -directory $basedir MedPost-SKR]] == 0} {
    puts "Warning: Tagger directory is missing, cannot ensure correct operation of MetaMap without it!"
    incr missingfiles
  } elseif {[llength [glob -nocomplain -directory $basedir/MedPost-SKR/data *.cur]] == 0} {
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
  if {[llength [glob -nocomplain -directory $basedir WSD_Server]] == 0} {
    puts "Warning: WSD Server directory is missing, MetaMap will not have WSD support without it!"
    incr missingoptions
  }

  # if {[llength [glob -nocomplain -directory $basedir/WSD_Server/wstv-dc *.ser]] == 0} {
  #   puts "Warning: WSD Server index files are missing, MetaMap will not have WSD support without it!"
  #   incr missingoptions
  # }

  if { $missingoptions != 0 } {
    puts "!! WARNING: Some optional datafiles are missing, see install.log for more information. !!"
  } else {
    puts "optional files ok."
  }

  puts ""
  puts "Public MetaMap Install Settings:"
  puts "  Public MetaMap Basedir: $basedir"
  puts "  Public MetaMap Program Dir: $bindir"
  puts "  Java Home dir: $java_home"
  puts ""
  puts "Main Public MetaMap Install complete."
  ${lpanel}.proglabel config -text "Main MetaMap Install complete." -font {Courier 14 bold}

  # ----------------------------------------------
  # install any additional modules if necessary
  # ----------------------------------------------
  foreach module_script $additional_module_list {
    fputs "evaluating $module_script"
    eval $module_script $lpanel
  }

  ${lpanel}.proglabel config -text "Public MetaMap Install complete." -font {Courier 14 bold}
  wm title . "Public MetaMap Install Complete."
  ${lpanel}.next config -text Finish -command bye
  pack ${lpanel}.next -in ${lpanel}.baseframe -side right -pady .25c -padx .25c
}

# the Tcl/Tk starts here... (main)

wm deiconify .
wm geometry . 650x180
wm title . "Public MetaMap Install Initializing..."
label .waitmsg -text "Public MetaMap Install Initializing..."
pack .waitmsg
update idletasks

# what os are we running?
if [info exists env(OS)] {
  set os $env(OS)
} else {
  set os [exec uname]
}

# assume basedir is current directory
if [info exists env(BASEDIR)] {
  set basedir $env(BASEDIR)
} else {
  set basedir [pwd]
}
set basedirpath $basedir

# If environment variable JAVA_HOME is defined then use it, otherwise
# try to get java install directory from the registry.
#
if [info exists env(JAVA_HOME)] {
  set javadirpath $env(JAVA_HOME)
} else {
  switch -glob $os {
    "Windows_NT*" {
      # get java path from the registry
      set java_reg_path "HKEY_LOCAL_MACHINE\\Software\\JavaSoft\\Java Runtime Environment"
      # was: set versionlist [registry keys $java_reg_path]
      if [catch { registry keys $java_reg_path } result] {
	fputs stderr "couldn't find java path in registry."
	set javadirpath ""
      } else {
	set versionlist $result
	foreach fv $versionlist {
	  lappend javapathlist [registry get "${java_reg_path}\\$fv" JavaHome]
	}
	set javadirpath [lindex $javapathlist 0]
      }
    }
    Linux -
    Darwin {
      set javadirpath [getresidentdir java]
    }
    default {
      set javadirpath ""
    }
  }
}

# build main window
# change window title
wm title . "Public MetaMap Install"
frame .panel

# Create the command entry window at the bottom of the window, along
# with the update button.

# frame .baseframe -relief raised -borderwidth 2


# frame .panel2
# message .msg -text "MetaMap Install" 
# message .msg2 -text "MetaMap Install" 
# text .text -font Courier12 -yscrollcommand ".scroll set" -background lightgrey
# scrollbar .scroll -command ".text yview"

# frame .pathpanel
# label .pathlabel -text "Location of Public MetaMap Directory: "
# entry .pathentry -width 40 -insertwidth 100 -textvariable basedirpath
# button .browsebutton -text Browse -command { doBrowseDirectory basedirpath }

# frame .path2panel
# label .path2label -text "Location of Public MetaMap Directory: "
# entry .path2entry -width 40 -insertwidth 100 -textvariable basedirpath
# button .browse2button -text Browse -command { doBrowseDirectory basedirpath }

# button .next -text Next -command doNext
# button .prev -text Previous -command doPrevious
# label .proglabel -text "MetaMap Install" -font {Courier 14 bold}

# pack .baseframe -side bottom -fill x
pack forget .waitmsg

set dialog_list { baseDirDialog javaDirDialog }
set additional_module_list {}

foreach install_file [glob -nocomplain -directory ./bin ginstall_*.tcl] {
  source $install_file
}

lappend dialog_list completeInstall

set dialog_index 0
eval [lindex $dialog_list $dialog_index]
