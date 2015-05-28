Advanced Bash-Scripting Guide:

`Prev <scrstyle.html>`__

Chapter 35. Scripting With Style

`Next <miscellany.html>`__

--------------

35.1. Unofficial Shell Scripting Stylesheet
===========================================

-  Comment your code. This makes it easier for others to understand (and
   appreciate), and easier for you to maintain.

   +--------------------------------------------------------------------------+
   | .. code:: PROGRAMLISTING                                                 |
   |                                                                          |
   |     PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"                      |
   |     #  It made perfect sense when you wrote it last year,                |
   |     #+ but now it's a complete mystery.                                  |
   |     #  (From Antek Sawicki's "pw.sh" script.)                            |
                                                                             
   +--------------------------------------------------------------------------+

   Add descriptive headers to your scripts and functions.

   +--------------------------------------------------------------------------+
   | .. code:: PROGRAMLISTING                                                 |
   |                                                                          |
   |     #!/bin/bash                                                          |
   |                                                                          |
   |     #************************************************#                   |
   |     #                   xyz.sh                       #                   |
   |     #           written by Bozo Bozeman              #                   |
   |     #                July 05, 2001                   #                   |
   |     #                                                #                   |
   |     #           Clean up project files.              #                   |
   |     #************************************************#                   |
   |                                                                          |
   |     E_BADDIR=85                       # No such directory.               |
   |     projectdir=/home/bozo/projects    # Directory to clean up.           |
   |                                                                          |
   |     # --------------------------------------------------------- #        |
   |     # cleanup_pfiles ()                                         #        |
   |     # Removes all files in designated directory.                #        |
   |     # Parameter: $target_directory                              #        |
   |     # Returns: 0 on success, $E_BADDIR if something went wrong. #        |
   |     # --------------------------------------------------------- #        |
   |     cleanup_pfiles ()                                                    |
   |     {                                                                    |
   |       if [ ! -d "$1" ]  # Test if target directory exists.               |
   |       then                                                               |
   |         echo "$1 is not a directory."                                    |
   |         return $E_BADDIR                                                 |
   |       fi                                                                 |
   |                                                                          |
   |       rm -f "$1"/*                                                       |
   |       return 0   # Success.                                              |
   |     }                                                                    |
   |                                                                          |
   |     cleanup_pfiles $projectdir                                           |
   |                                                                          |
   |     exit $?                                                              |
                                                                             
   +--------------------------------------------------------------------------+

-  Avoid using "magic numbers," `[1] <unofficialst.html#FTN.AEN20041>`__
   that is, "hard-wired" literal constants. Use meaningful variable
   names instead. This makes the script easier to understand and permits
   making changes and updates without breaking the application.

   +--------------------------------------------------------------------------+
   | .. code:: PROGRAMLISTING                                                 |
   |                                                                          |
   |     if [ -f /var/log/messages ]                                          |
   |     then                                                                 |
   |       ...                                                                |
   |     fi                                                                   |
   |     #  A year later, you decide to change the script to check /var/log/s |
   | yslog.                                                                   |
   |     #  It is now necessary to manually change the script, instance by in |
   | stance,                                                                  |
   |     #+ and hope nothing breaks.                                          |
   |                                                                          |
   |     # A better way:                                                      |
   |     LOGFILE=/var/log/messages  # Only line that needs to be changed.     |
   |     if [ -f "$LOGFILE" ]                                                 |
   |     then                                                                 |
   |       ...                                                                |
   |     fi                                                                   |
                                                                             
   +--------------------------------------------------------------------------+

-  Choose descriptive names for variables and functions.

   +--------------------------------------------------------------------------+
   | .. code:: PROGRAMLISTING                                                 |
   |                                                                          |
   |     fl=`ls -al $dirname`                 # Cryptic.                      |
   |     file_listing=`ls -al $dirname`       # Better.                       |
   |                                                                          |
   |                                                                          |
   |     MAXVAL=10   # All caps used for a script constant.                   |
   |     while [ "$index" -le "$MAXVAL" ]                                     |
   |     ...                                                                  |
   |                                                                          |
   |                                                                          |
   |     E_NOTFOUND=95                        #  Uppercase for an errorcode,  |
   |                                          #+ and name prefixed with E_.   |
   |     if [ ! -e "$filename" ]                                              |
   |     then                                                                 |
   |       echo "File $filename not found."                                   |
   |       exit $E_NOTFOUND                                                   |
   |     fi                                                                   |
   |                                                                          |
   |                                                                          |
   |     MAIL_DIRECTORY=/var/spool/mail/bozo  #  Uppercase for an environment |
   | al                                                                       |
   |     export MAIL_DIRECTORY                #+ variable.                    |
   |                                                                          |
   |                                                                          |
   |     GetAnswer ()                         #  Mixed case works well for a  |
   |     {                                    #+ function name, especially    |
   |       prompt=$1                          #+ when it improves legibility. |
   |       echo -n $prompt                                                    |
   |       read answer                                                        |
   |       return $answer                                                     |
   |     }                                                                    |
   |                                                                          |
   |     GetAnswer "What is your favorite number? "                           |
   |     favorite_number=$?                                                   |
   |     echo $favorite_number                                                |
   |                                                                          |
   |                                                                          |
   |     _uservariable=23                     # Permissible, but not recommen |
   | ded.                                                                     |
   |     # It's better for user-defined variables not to start with an unders |
   | core.                                                                    |
   |     # Leave that for system variables.                                   |
                                                                             
   +--------------------------------------------------------------------------+

-  Use `exit codes <exit-status.html#EXITCOMMANDREF>`__ in a systematic
   and meaningful way.

   +--------------------------------------------------------------------------+
   | .. code:: PROGRAMLISTING                                                 |
   |                                                                          |
   |     E_WRONG_ARGS=95                                                      |
   |     ...                                                                  |
   |     ...                                                                  |
   |     exit $E_WRONG_ARGS                                                   |
                                                                             
   +--------------------------------------------------------------------------+

   See also `Appendix E <exitcodes.html>`__.

   *Ender* suggests using the `exit codes in
   ``/usr/include/sysexits.h`` <exitcodes.html#SYSEXITSREF>`__ in shell
   scripts, though these are primarily intended for C and C++
   programming.

-  Use standardized parameter flags for script invocation. *Ender*
   proposes the following set of flags.

   +--------------------------------------------------------------------------+
   | .. code:: PROGRAMLISTING                                                 |
   |                                                                          |
   |     -a      All: Return all information (including hidden file info).    |
   |     -b      Brief: Short version, usually for other scripts.             |
   |     -c      Copy, concatenate, etc.                                      |
   |     -d      Daily: Use information from the whole day, and not merely    |
   |             information for a specific instance/user.                    |
   |     -e      Extended/Elaborate: (often does not include hidden file info |
   | ).                                                                       |
   |     -h      Help: Verbose usage w/descs, aux info, discussion, help.     |
   |             See also -V.                                                 |
   |     -l      Log output of script.                                        |
   |     -m      Manual: Launch man-page for base command.                    |
   |     -n      Numbers: Numerical data only.                                |
   |     -r      Recursive: All files in a directory (and/or all sub-dirs).   |
   |     -s      Setup & File Maintenance: Config files for this script.      |
   |     -u      Usage: List of invocation flags for the script.              |
   |     -v      Verbose: Human readable output, more or less formatted.      |
   |     -V      Version / License / Copy(right|left) / Contribs (email too). |
                                                                             
   +--------------------------------------------------------------------------+

   See also `Section G.1 <standard-options.html>`__.

-  Break complex scripts into simpler modules. Use functions where
   appropriate. See `Example 37-4 <bashver2.html#CARDS>`__.

-  Don't use a complex construct where a simpler one will do.

   +--------------------------------------------------------------------------+
   | .. code:: PROGRAMLISTING                                                 |
   |                                                                          |
   |     COMMAND                                                              |
   |     if [ $? -eq 0 ]                                                      |
   |     ...                                                                  |
   |     # Redundant and non-intuitive.                                       |
   |                                                                          |
   |     if COMMAND                                                           |
   |     ...                                                                  |
   |     # More concise (if perhaps not quite as legible).                    |
                                                                             
   +--------------------------------------------------------------------------+

+--------------------+--------------------+--------------------+--------------------+
|                    |
| **                 |
| *... reading the   |
| UNIX source code   |
| to the Bourne      |
| shell (/bin/sh). I |
| was shocked at how |
| much simple        |
| algorithms could   |
| be made cryptic,   |
| and therefore      |
| useless, by a poor |
| choice of code     |
| style. I asked     |
| myself, "Could     |
| someone be proud   |
| of this code?"*    |
|                    |
| *--Landon Noll*    |
+--------------------+--------------------+--------------------+--------------------+

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <unofficialst.html#AEN20041>`__ |
| In this context, "magic numbers"     |
| have an entirely different meaning   |
| than the `magic                      |
| numbers <sha-bang.html#MAGNUMREF>`__ |
| used to designate file types.        |
+--------------------------------------+--------------------------------------+

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <scrstyle.html>`__ | Scripting With Style     |
| `Home <index.html>`__    | `Up <scrstyle.html>`__   |
| `Next <miscellany.html>` | Miscellany               |
| __                       |                          |
+--------------------------+--------------------------+--------------------------+

