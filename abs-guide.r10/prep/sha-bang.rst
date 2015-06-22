.. raw:: html

   <div class="NAVHEADER">

.. raw:: html

   <table border="0" cellpadding="0" cellspacing="0" summary="Header navigation table" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <th align="center" colspan="3">

Advanced Bash-Scripting Guide:

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="bottom" width="10%">

`Prev <why-shell.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <invoking.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

--------------

.. raw:: html

   </div>

.. raw:: html

   <div class="CHAPTER">

  Chapter 2. Starting Off With a Sha-Bang
========================================

+--------------------------+--------------------------+--------------------------+
| **                       |
| *Shell programming is a  |
| 1950s juke box . . .*    |
|                          |
| *--Larry Wall*           |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="TOC">

.. raw:: html

   <dl>

.. raw:: html

   <dt>

**Table of Contents**

.. raw:: html

   </dt>

.. raw:: html

   <dt>

2.1. `Invoking the script <invoking.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

2.2. `Preliminary Exercises <prelimexer.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </div>

In the simplest case, a script is nothing more than a list of system
commands stored in a file. At the very least, this saves the effort of
retyping that particular sequence of commands each time it is invoked.

.. raw:: html

   <div class="EXAMPLE">

**Example 2-1. *cleanup* : A script to clean up log files in /var/log**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # Cleanup            |
|     # Run as root, of co |
| urse.                    |
|                          |
|     cd /var/log          |
|     cat /dev/null > mess |
| ages                     |
|     cat /dev/null > wtmp |
|     echo "Log files clea |
| ned up."                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

There is nothing unusual here, only a set of commands that could just as
easily have been invoked one by one from the command-line on the console
or in a terminal window. The advantages of placing the commands in a
script go far beyond not having to retype them time and again. The
script becomes a *program* -- a *tool* -- and it can easily be modified
or customized for a particular application.

.. raw:: html

   <div class="EXAMPLE">

**Example 2-2. *cleanup* : An improved clean-up script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # Proper header for  |
| a Bash script.           |
|                          |
|     # Cleanup, version 2 |
|                          |
|     # Run as root, of co |
| urse.                    |
|     # Insert code here t |
| o print error message an |
| d exit if not root.      |
|                          |
|     LOG_DIR=/var/log     |
|     # Variables are bett |
| er than hard-coded value |
| s.                       |
|     cd $LOG_DIR          |
|                          |
|     cat /dev/null > mess |
| ages                     |
|     cat /dev/null > wtmp |
|                          |
|                          |
|     echo "Logs cleaned u |
| p."                      |
|                          |
|     exit #  The right an |
| d proper method of "exit |
| ing" from a script.      |
|          #  A bare "exit |
| " (no parameter) returns |
|  the exit status         |
|          #+ of the prece |
| ding command.            |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Now *that's* beginning to look like a real script. But we can go even
farther . . .

.. raw:: html

   <div class="EXAMPLE">

**Example 2-3. *cleanup* : An enhanced and generalized version of above
scripts.**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # Cleanup, version 3 |
|                          |
|     #  Warning:          |
|     #  -------           |
|     #  This script uses  |
| quite a number of featur |
| es that will be explaine |
| d                        |
|     #+ later on.         |
|     #  By the time you'v |
| e finished the first hal |
| f of the book,           |
|     #+ there should be n |
| othing mysterious about  |
| it.                      |
|                          |
|                          |
|                          |
|     LOG_DIR=/var/log     |
|     ROOT_UID=0     # Onl |
| y users with $UID 0 have |
|  root privileges.        |
|     LINES=50       # Def |
| ault number of lines sav |
| ed.                      |
|     E_XCD=86       # Can |
| 't change directory?     |
|     E_NOTROOT=87   # Non |
| -root exit error.        |
|                          |
|                          |
|     # Run as root, of co |
| urse.                    |
|     if [ "$UID" -ne "$RO |
| OT_UID" ]                |
|     then                 |
|       echo "Must be root |
|  to run this script."    |
|       exit $E_NOTROOT    |
|     fi                   |
|                          |
|     if [ -n "$1" ]       |
|     # Test whether comma |
| nd-line argument is pres |
| ent (non-empty).         |
|     then                 |
|       lines=$1           |
|     else                 |
|       lines=$LINES # Def |
| ault, if not specified o |
| n command-line.          |
|     fi                   |
|                          |
|                          |
|     #  Stephane Chazelas |
|  suggests the following, |
|     #+ as a better way o |
| f checking command-line  |
| arguments,               |
|     #+ but this is still |
|  a bit advanced for this |
|  stage of the tutorial.  |
|     #                    |
|     #    E_WRONGARGS=85  |
|  # Non-numerical argumen |
| t (bad argument format). |
|     #                    |
|     #    case "$1" in    |
|     #    ""      ) lines |
| =50;;                    |
|     #    *[!0-9]*) echo  |
| "Usage: `basename $0` li |
| nes-to-cleanup";         |
|     #     exit $E_WRONGA |
| RGS;;                    |
|     #    *       ) lines |
| =$1;;                    |
|     #    esac            |
|     #                    |
|     #* Skip ahead to "Lo |
| ops" chapter to decipher |
|  all this.               |
|                          |
|                          |
|     cd $LOG_DIR          |
|                          |
|     if [ `pwd` != "$LOG_ |
| DIR" ]  # or   if [ "$PW |
| D" != "$LOG_DIR" ]       |
|                          |
|         # Not in /var/lo |
| g?                       |
|     then                 |
|       echo "Can't change |
|  to $LOG_DIR."           |
|       exit $E_XCD        |
|     fi  # Doublecheck if |
|  in right directory befo |
| re messing with log file |
| .                        |
|                          |
|     # Far more efficient |
|  is:                     |
|     #                    |
|     # cd /var/log || {   |
|     #   echo "Cannot cha |
| nge to necessary directo |
| ry." >&2                 |
|     #   exit $E_XCD;     |
|     # }                  |
|                          |
|                          |
|                          |
|                          |
|     tail -n $lines messa |
| ges > mesg.temp # Save l |
| ast section of message l |
| og file.                 |
|     mv mesg.temp message |
| s               # Rename |
|  it as system log file.  |
|                          |
|                          |
|     #  cat /dev/null > m |
| essages                  |
|     #* No longer needed, |
|  as the above method is  |
| safer.                   |
|                          |
|     cat /dev/null > wtmp |
|   #  ': > wtmp' and '> w |
| tmp'  have the same effe |
| ct.                      |
|     echo "Log files clea |
| ned up."                 |
|     #  Note that there a |
| re other log files in /v |
| ar/log not affected      |
|     #+ by this script.   |
|                          |
|     exit 0               |
|     #  A zero return val |
| ue from the script upon  |
| exit indicates success   |
|     #+ to the shell.     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Since you may not wish to wipe out the entire system log, this version
of the script keeps the last section of the message log intact. You will
constantly discover ways of fine-tuning previously written scripts for
increased effectiveness.

 \* \* \*

 The *sha-bang* ( #! ) ` [1]  <sha-bang.html#FTN.AEN205>`__ at the head
of a script tells your system that this file is a set of commands to be
fed to the command interpreter indicated. The #! is actually a two-byte
` [2]  <sha-bang.html#FTN.AEN214>`__ *magic number* , a special marker
that designates a file type, or in this case an executable shell script
(type ``             man magic           `` for more details on this
fascinating topic). Immediately following the *sha-bang* is a *path
name* . This is the path to the program that interprets the commands in
the script, whether it be a shell, a programming language, or a utility.
This command interpreter then executes the commands in the script,
starting at the top (the line following the *sha-bang* line), and
ignoring comments. ` [3]  <sha-bang.html#FTN.AEN226>`__

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/sh            |
|     #!/bin/bash          |
|     #!/usr/bin/perl      |
|     #!/usr/bin/tcl       |
|     #!/bin/sed -f        |
|     #!/bin/awk -f        |
                          
+--------------------------+--------------------------+--------------------------+

Each of the above script header lines calls a different command
interpreter, be it ``      /bin/sh     `` , the default shell ( **bash**
in a Linux system) or otherwise. ` [4]  <sha-bang.html#FTN.AEN242>`__
Using ``             #!/bin/sh           `` , the default Bourne shell
in most commercial variants of UNIX, makes the script
`portable <portabilityissues.html>`__ to non-Linux machines, though you
`sacrifice Bash-specific features <gotchas.html#BINSH>`__ . The script
will, however, conform to the POSIX ` [5]  <sha-bang.html#FTN.AEN256>`__
**sh** standard.

Note that the path given at the "sha-bang" must be correct, otherwise an
error message -- usually "Command not found." -- will be the only result
of running the script. ` [6]  <sha-bang.html#FTN.AEN269>`__

 #! can be omitted if the script consists only of a set of generic
system commands, using no internal shell directives. The second example,
above, requires the initial #! , since the variable assignment line,
``             lines=50           `` , uses a shell-specific construct.
` [7]  <sha-bang.html#FTN.AEN279>`__ Note again that
``             #!/bin/sh           `` invokes the default shell
interpreter, which defaults to ``      /bin/bash     `` on a Linux
machine.

.. raw:: html

   <div class="TIP">

+----------------+----------------+----------------+----------------+----------------+
| |Tip|          |
| This tutorial  |
| encourages a   |
| modular        |
| approach to    |
| constructing a |
| script. Make   |
| note of and    |
| collect        |
| "boilerplate"  |
| code snippets  |
| that might be  |
| useful in      |
| future         |
| scripts.       |
| Eventually you |
| will build     |
| quite an       |
| extensive      |
| library of     |
| nifty          |
| routines. As   |
| an example,    |
| the following  |
| script prolog  |
| tests whether  |
| the script has |
| been invoked   |
| with the       |
| correct number |
| of parameters. |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
| | .. code:: PR |
| OGRAMLISTING | |
| |              |
|              | |
| |     E_WRONG_ |
| ARGS=85      | |
| |     script_p |
| arameters="- | |
| | a -h -m -z"  |
|              | |
| |     #        |
|            - | |
| | a = all, -h  |
| = help, etc. | |
| |              |
|              | |
| |     if [ $#  |
| -ne $Number_ | |
| | of_expected_ |
| args ]       | |
| |     then     |
|              | |
| |       echo " |
| Usage: `base | |
| | name $0` $sc |
| ript_paramet | |
| | ers"         |
|              | |
| |       # `bas |
| ename $0` is | |
| |  the script' |
| s filename.  | |
| |       exit $ |
| E_WRONG_ARGS | |
| |     fi       |
|              | |
|                |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
|                |
| Many times,    |
| you will write |
| a script that  |
| carries out    |
| one particular |
| task. The      |
| first script   |
| in this        |
| chapter is an  |
| example.       |
| Later, it      |
| might occur to |
| you to         |
| generalize the |
| script to do   |
| other, similar |
| tasks.         |
| Replacing the  |
| literal (      |
| "hard-wired" ) |
| constants by   |
| variables is a |
| step in that   |
| direction, as  |
| is replacing   |
| repetitive     |
| code blocks by |
| `functions <fu |
| nctions.html#F |
| UNCTIONREF>`__ |
| .              |
+----------------+----------------+----------------+----------------+----------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

.. raw:: html

   <table border="0" class="FOOTNOTES" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [1]  <sha-bang.html#AEN205>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

More commonly seen in the literature as *she-bang* or *sh-bang* . This
derives from the concatenation of the tokens *sharp* ( # ) and *bang* (
! ).

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [2]  <sha-bang.html#AEN214>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Some flavors of UNIX (those based on 4.2 BSD) allegedly take a four-byte
magic number, requiring a blank after the ! --
``                 #! /bin/sh               `` . `According to Sven
Mascheck <http://www.in-ulm.de/~mascheck/various/shebang/#details>`__
this is probably a myth.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [3]  <sha-bang.html#AEN226>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

The #! line in a shell script will be the first thing the command
interpreter ( **sh** or **bash** ) sees. Since this line begins with a #
, it will be correctly interpreted as a comment when the command
interpreter finally executes the script. The line has already served its
purpose - calling the command interpreter.

If, in fact, the script includes an *extra* #! line, then **bash** will
interpret it as a comment.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     echo "Part 1 of scri |
| pt."                     |
|     a=1                  |
|                          |
|     #!/bin/bash          |
|     # This does *not* la |
| unch a new script.       |
|                          |
|     echo "Part 2 of scri |
| pt."                     |
|     echo $a  # Value of  |
| $a stays at 1.           |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [4]  <sha-bang.html#AEN242>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

This allows some cute tricks.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/rm            |
|     # Self-deleting scri |
| pt.                      |
|                          |
|     # Nothing much seems |
|  to happen when you run  |
| this... except that the  |
| file disappears.         |
|                          |
|     WHATEVER=85          |
|                          |
|     echo "This line will |
|  never print (betcha!)." |
|                          |
|     exit $WHATEVER  # Do |
| esn't matter. The script |
|  will not exit here.     |
|                     # Tr |
| y an echo $? after scrip |
| t termination.           |
|                     # Yo |
| u'll get a 0, not a 85.  |
                          
+--------------------------+--------------------------+--------------------------+

Also, try starting a ``        README       `` file with a
``                 #!/bin/more               `` , and making it
executable. The result is a self-listing documentation file. (A `here
document <here-docs.html#HEREDOCREF>`__ using
`cat <basic.html#CATREF>`__ is possibly a better alternative -- see
`Example 19-3 <here-docs.html#EX71>`__ ).

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [5]  <sha-bang.html#AEN256>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

 **P** ortable **O** perating **S** ystem *I* nterface, an attempt to
standardize UNI **X** -like OSes. The POSIX specifications are listed on
the `Open Group
site <http://www.opengroup.org/onlinepubs/007904975/toc.htm>`__ .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [6]  <sha-bang.html#AEN269>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

To avoid this possibility, a script may begin with a `#!/bin/env
bash <system.html#ENVV2REF>`__ *sha-bang* line. This may be useful on
UNIX machines where *bash* is not located in ``        /bin       ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [7]  <sha-bang.html#AEN279>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

If *Bash* is your default shell, then the #! isn't necessary at the
beginning of a script. However, if launching a script from a different
shell, such as *tcsh* , then you *will* need the #! .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <why-shell.html>`_ | Shell Programming!       |
| _                        | `Up <part1.html>`__      |
| `Home <index.html>`__    | Invoking the script      |
| `Next <invoking.html>`__ |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Tip| image:: ../images/tip.gif
