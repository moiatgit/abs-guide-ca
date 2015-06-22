.. raw:: html

   <div class="NAVHEADER">

.. raw:: html

   <table summary="Header navigation table" width="100%" border="0" cellpadding="0" cellspacing="0">

.. raw:: html

   <tr>

.. raw:: html

   <th colspan="3" align="center">

Advanced Bash-Scripting Guide:

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="10%" align="left" valign="bottom">

`Prev <globbingref.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <x17837.html>`__

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

Chapter 19. Here Documents
==========================

+----------------+----------------+----------------+----------------+----------------+
|                |
| **             |
| *Here and now, |
| boys.*         |
|                |
| *--Aldous      |
| Huxley,        |
| *Island**      |
+----------------+----------------+----------------+----------------+----------------+

A *here document* is a special-purpose code block. It uses a form of
`I/O redirection <io-redirection.html#IOREDIRREF>`__ to feed a command
list to an interactive program or a command, such as
`ftp <communications.html#FTPREF>`__, `cat <basic.html#CATREF>`__, or
the *ex* text editor.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     COMMAND <<InputComes |
| FromHERE                 |
|     ...                  |
|     ...                  |
|     ...                  |
|     InputComesFromHERE   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

A *limit string* delineates (frames) the command list. The special
symbol << precedes the limit string. This has the effect of redirecting
the output of a command block into the ``stdin`` of the program or
command. It is similar to ``interactive-program <     command-file``,
where ``command-file`` contains

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     command #1           |
|     command #2           |
|     ...                  |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

The *here document* equivalent looks like this:

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     interactive-program  |
| <<LimitString            |
|     command #1           |
|     command #2           |
|     ...                  |
|     LimitString          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

Choose a *limit string* sufficiently unusual that it will not occur
anywhere in the command list and confuse matters.

Note that *here documents* may sometimes be used to good effect with
non-interactive utilities and commands, such as, for example,
`wall <system.html#WALLREF>`__.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-1. *broadcast*: Sends message to everyone logged in**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     wall <<zzz23EndOfMes |
| sagezzz23                |
|     E-mail your noontime |
|  orders for pizza to the |
|  system administrator.   |
|         (Add an extra do |
| llar for anchovy or mush |
| room topping.)           |
|     # Additional message |
|  text goes here.         |
|     # Note: 'wall' print |
| s comment lines.         |
|     zzz23EndOfMessagezzz |
| 23                       |
|                          |
|     # Could have been do |
| ne more efficiently by   |
|     #         wall <mess |
| age-file                 |
|     #  However, embeddin |
| g the message template i |
| n a script               |
|     #+ is a quick-and-di |
| rty one-off solution.    |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Even such unlikely candidates as the *vi* text editor lend themselves to
*here documents*.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-2. *dummyfile*: Creates a 2-line dummy file**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # Noninteractive use |
|  of 'vi' to edit a file. |
|     # Emulates 'sed'.    |
|                          |
|     E_BADARGS=85         |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       echo "Usage: `base |
| name $0` filename"       |
|       exit $E_BADARGS    |
|     fi                   |
|                          |
|     TARGETFILE=$1        |
|                          |
|     # Insert 2 lines in  |
| file, then save.         |
|     #--------Begin here  |
| document-----------#     |
|     vi $TARGETFILE <<x23 |
| LimitStringx23           |
|     i                    |
|     This is line 1 of th |
| e example file.          |
|     This is line 2 of th |
| e example file.          |
|     ^[                   |
|     ZZ                   |
|     x23LimitStringx23    |
|     #----------End here  |
| document-----------#     |
|                          |
|     #  Note that ^[ abov |
| e is a literal escape    |
|     #+ typed by Control- |
| V <Esc>.                 |
|                          |
|     #  Bram Moolenaar po |
| ints out that this may n |
| ot work with 'vim'       |
|     #+ because of possib |
| le problems with termina |
| l interaction.           |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

The above script could just as effectively have been implemented with
**ex**, rather than **vi**. \ *Here documents* containing a list of
**ex** commands are common enough to form their own category, known as
*ex scripts*.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     #  Replace all insta |
| nces of "Smith" with "Jo |
| nes"                     |
|     #+ in files with a " |
| .txt" filename suffix.   |
|                          |
|     ORIGINAL=Smith       |
|     REPLACEMENT=Jones    |
|                          |
|     for word in $(fgrep  |
| -l $ORIGINAL *.txt)      |
|     do                   |
|       # ---------------- |
| ---------------------    |
|       ex $word <<EOF     |
|       :%s/$ORIGINAL/$REP |
| LACEMENT/g               |
|       :wq                |
|     EOF                  |
|       # :%s is the "ex"  |
| substitution command.    |
|       # :wq is write-and |
| -quit.                   |
|       # ---------------- |
| ---------------------    |
|     done                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

Analogous to "ex scripts" are *cat scripts*.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-3. Multi-line message using *cat***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #  'echo' is fine fo |
| r printing single line m |
| essages,                 |
|     #+  but somewhat pro |
| blematic for for message |
|  blocks.                 |
|     #   A 'cat' here doc |
| ument overcomes this lim |
| itation.                 |
|                          |
|     cat <<End-of-message |
|     -------------------- |
| -----------------        |
|     This is line 1 of th |
| e message.               |
|     This is line 2 of th |
| e message.               |
|     This is line 3 of th |
| e message.               |
|     This is line 4 of th |
| e message.               |
|     This is the last lin |
| e of the message.        |
|     -------------------- |
| -----------------        |
|     End-of-message       |
|                          |
|     #  Replacing line 7, |
|  above, with             |
|     #+   cat > $Newfile  |
| <<End-of-message         |
|     #+       ^^^^^^^^^^  |
|     #+ writes the output |
|  to the file $Newfile, r |
| ather than to stdout.    |
|                          |
|     exit 0               |
|                          |
|                          |
|     #------------------- |
| ------------------------ |
| -                        |
|     # Code below disable |
| d, due to "exit 0" above |
| .                        |
|                          |
|     # S.C. points out th |
| at the following also wo |
| rks.                     |
|     echo "-------------- |
| -----------------------  |
|     This is line 1 of th |
| e message.               |
|     This is line 2 of th |
| e message.               |
|     This is line 3 of th |
| e message.               |
|     This is line 4 of th |
| e message.               |
|     This is the last lin |
| e of the message.        |
|     -------------------- |
| -----------------"       |
|     # However, text may  |
| not include double quote |
| s unless they are escape |
| d.                       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

The ``-`` option to mark a here document limit string
(``<<-LimitString``) suppresses leading tabs (but not spaces) in the
output. This may be useful in making a script more readable.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-4. Multi-line message, with tabs suppressed**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # Same as previous e |
| xample, but...           |
|                          |
|     #  The - option to a |
|  here document <<-       |
|     #+ suppresses leadin |
| g tabs in the body of th |
| e document,              |
|     #+ but *not* spaces. |
|                          |
|     cat <<-ENDOFMESSAGE  |
|         This is line 1 o |
| f the message.           |
|         This is line 2 o |
| f the message.           |
|         This is line 3 o |
| f the message.           |
|         This is line 4 o |
| f the message.           |
|         This is the last |
|  line of the message.    |
|     ENDOFMESSAGE         |
|     # The output of the  |
| script will be flush lef |
| t.                       |
|     # Leading tab in eac |
| h line will not show.    |
|                          |
|     # Above 5 lines of " |
| message" prefaced by a t |
| ab, not spaces.          |
|     # Spaces not affecte |
| d by   <<-  .            |
|                          |
|     # Note that this opt |
| ion has no effect on *em |
| bedded* tabs.            |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

A *here document* supports parameter and command substitution. It is
therefore possible to pass different parameters to the body of the here
document, changing its output accordingly.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-5. Here document with replaceable parameters**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # Another 'cat' here |
|  document, using paramet |
| er substitution.         |
|                          |
|     # Try it with no com |
| mand-line parameters,    |
| ./scriptname             |
|     # Try it with one co |
| mmand-line parameter,    |
| ./scriptname Mortimer    |
|     # Try it with one tw |
| o-word quoted command-li |
| ne parameter,            |
|     #                    |
|         ./scriptname "Mo |
| rtimer Jones"            |
|                          |
|     CMDLINEPARAM=1     # |
|   Expect at least comman |
| d-line parameter.        |
|                          |
|     if [ $# -ge $CMDLINE |
| PARAM ]                  |
|     then                 |
|       NAME=$1          # |
|   If more than one comma |
| nd-line param,           |
|                        # |
| + then just take the fir |
| st.                      |
|     else                 |
|       NAME="John Doe"  # |
|   Default, if no command |
| -line parameter.         |
|     fi                   |
|                          |
|     RESPONDENT="the auth |
| or of this fine script"  |
|                          |
|                          |
|                          |
|     cat <<Endofmessage   |
|                          |
|     Hello, there, $NAME. |
|     Greetings to you, $N |
| AME, from $RESPONDENT.   |
|                          |
|     # This comment shows |
|  up in the output (why?) |
| .                        |
|                          |
|     Endofmessage         |
|                          |
|     # Note that the blan |
| k lines show up in the o |
| utput.                   |
|     # So does the commen |
| t.                       |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

This is a useful script containing a *here document* with parameter
substitution.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-6. Upload a file pair to *Sunsite* incoming directory**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # upload.sh          |
|                          |
|     #  Upload file pair  |
| (Filename.lsm, Filename. |
| tar.gz)                  |
|     #+ to incoming direc |
| tory at Sunsite/UNC (ibi |
| blio.org).               |
|     #  Filename.tar.gz i |
| s the tarball itself.    |
|     #  Filename.lsm is t |
| he descriptor file.      |
|     #  Sunsite requires  |
| "lsm" file, otherwise wi |
| ll bounce contributions. |
|                          |
|                          |
|     E_ARGERROR=85        |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       echo "Usage: `base |
| name $0` Filename-to-upl |
| oad"                     |
|       exit $E_ARGERROR   |
|     fi                   |
|                          |
|                          |
|     Filename=`basename $ |
| 1`           # Strips pa |
| thname out of file name. |
|                          |
|     Server="ibiblio.org" |
|     Directory="/incoming |
| /Linux"                  |
|     #  These need not be |
|  hard-coded into script, |
|     #+ but may instead b |
| e changed to command-lin |
| e argument.              |
|                          |
|     Password="your.e-mai |
| l.address"   # Change ab |
| ove to suit.             |
|                          |
|     ftp -n $Server <<End |
| -Of-Session              |
|     # -n option disables |
|  auto-logon              |
|                          |
|     user anonymous "$Pas |
| sword"       #  If this  |
| doesn't work, then try:  |
|                          |
|              #  quote us |
| er anonymous "$Password" |
|     binary               |
|     bell                 |
|              # Ring 'bel |
| l' after each file trans |
| fer.                     |
|     cd $Directory        |
|     put "$Filename.lsm"  |
|     put "$Filename.tar.g |
| z"                       |
|     bye                  |
|     End-Of-Session       |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Quoting or escaping the "limit string" at the head of a here document
disables parameter substitution within its body. The reason for this is
that *quoting/escaping the limit string* effectively
`escapes <escapingsection.html#ESCP>`__ the $, \`, and \\ `special
characters <special-chars.html#SCHARLIST>`__, and causes them to be
interpreted literally. (Thank you, Allen Halsey, for pointing this out.)

.. raw:: html

   <div class="EXAMPLE">

**Example 19-7. Parameter substitution turned off**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     #  A 'cat' here-docu |
| ment, but with parameter |
|  substitution disabled.  |
|                          |
|     NAME="John Doe"      |
|     RESPONDENT="the auth |
| or of this fine script"  |
|                          |
|                          |
|     cat <<'Endofmessage' |
|                          |
|     Hello, there, $NAME. |
|     Greetings to you, $N |
| AME, from $RESPONDENT.   |
|                          |
|     Endofmessage         |
|                          |
|     #   No parameter sub |
| stitution when the "limi |
| t string" is quoted or e |
| scaped.                  |
|     #   Either of the fo |
| llowing at the head of t |
| he here document would h |
| ave                      |
|     #+  the same effect. |
|     #   cat <<"Endofmess |
| age"                     |
|     #   cat <<\Endofmess |
| age                      |
|                          |
|                          |
|                          |
|     #   And, likewise:   |
|                          |
|     cat <<"SpecialCharTe |
| st"                      |
|                          |
|     Directory listing wo |
| uld follow               |
|     if limit string were |
|  not quoted.             |
|     `ls -l`              |
|                          |
|     Arithmetic expansion |
|  would take place        |
|     if limit string were |
|  not quoted.             |
|     $((5 + 3))           |
|                          |
|     A a single backslash |
|  would echo              |
|     if limit string were |
|  not quoted.             |
|     \\                   |
|                          |
|     SpecialCharTest      |
|                          |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Disabling parameter substitution permits outputting literal text.
Generating scripts or even program code is one use for this.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-8. A script that generates another script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # generate-script.sh |
|     # Based on an idea b |
| y Albert Reiner.         |
|                          |
|     OUTFILE=generated.sh |
|          # Name of the f |
| ile to generate.         |
|                          |
|                          |
|     # ------------------ |
| ------------------------ |
| -----------------        |
|     # 'Here document con |
| taining the body of the  |
| generated script.        |
|     (                    |
|     cat <<'EOF'          |
|     #!/bin/bash          |
|                          |
|     echo "This is a gene |
| rated shell script."     |
|     #  Note that since w |
| e are inside a subshell, |
|     #+ we can't access v |
| ariables in the "outside |
| " script.                |
|                          |
|     echo "Generated file |
|  will be named: $OUTFILE |
| "                        |
|     #  Above line will n |
| ot work as normally expe |
| cted                     |
|     #+ because parameter |
|  expansion has been disa |
| bled.                    |
|     #  Instead, the resu |
| lt is literal output.    |
|                          |
|     a=7                  |
|     b=3                  |
|                          |
|     let "c = $a * $b"    |
|     echo "c = $c"        |
|                          |
|     exit 0               |
|     EOF                  |
|     ) > $OUTFILE         |
|     # ------------------ |
| ------------------------ |
| -----------------        |
|                          |
|     #  Quoting the 'limi |
| t string' prevents varia |
| ble expansion            |
|     #+ within the body o |
| f the above 'here docume |
| nt.'                     |
|     #  This permits outp |
| utting literal strings i |
| n the output file.       |
|                          |
|     if [ -f "$OUTFILE" ] |
|     then                 |
|       chmod 755 $OUTFILE |
|       # Make the generat |
| ed file executable.      |
|     else                 |
|       echo "Problem in c |
| reating file: \"$OUTFILE |
| \""                      |
|     fi                   |
|                          |
|     #  This method also  |
| works for generating     |
|     #+ C programs, Perl  |
| programs, Python program |
| s, Makefiles,            |
|     #+ and the like.     |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

It is possible to set a variable from the output of a here document.
This is actually a devious form of `command
substitution <commandsub.html#COMMANDSUBREF>`__.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     variable=$(cat <<SET |
| VAR                      |
|     This variable        |
|     runs over multiple l |
| ines.                    |
|     SETVAR               |
|     )                    |
|                          |
|     echo "$variable"     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

A here document can supply input to a function in the same script.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-9. Here documents and functions**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # here-function.sh   |
|                          |
|     GetPersonalData ()   |
|     {                    |
|       read firstname     |
|       read lastname      |
|       read address       |
|       read city          |
|       read state         |
|       read zipcode       |
|     } # This certainly a |
| ppears to be an interact |
| ive function, but . . .  |
|                          |
|                          |
|     # Supply input to th |
| e above function.        |
|     GetPersonalData <<RE |
| CORD001                  |
|     Bozo                 |
|     Bozeman              |
|     2726 Nondescript Dr. |
|     Bozeman              |
|     MT                   |
|     21226                |
|     RECORD001            |
|                          |
|                          |
|     echo                 |
|     echo "$firstname $la |
| stname"                  |
|     echo "$address"      |
|     echo "$city, $state  |
| $zipcode"                |
|     echo                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

It is possible to use : as a dummy command accepting output from a here
document. This, in effect, creates an "anonymous" here document.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-10. "Anonymous" Here Document**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     : <<TESTVARIABLES    |
|     ${HOSTNAME?}${USER?} |
| ${MAIL?}  # Print error  |
| message if one of the va |
| riables not set.         |
|     TESTVARIABLES        |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="TIP">

+--------------------------------------+--------------------------------------+
| |Tip|                                |
| A variation of the above technique   |
| permits "commenting out" blocks of   |
| code.                                |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 19-11. Commenting out a block of code**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # commentblock.sh    |
|                          |
|     : <<COMMENTBLOCK     |
|     echo "This line will |
|  not echo."              |
|     This is a comment li |
| ne missing the "#" prefi |
| x.                       |
|     This is another comm |
| ent line missing the "#" |
|  prefix.                 |
|                          |
|     &*@!!++=             |
|     The above line will  |
| cause no error message,  |
|     because the Bash int |
| erpreter will ignore it. |
|     COMMENTBLOCK         |
|                          |
|     echo "Exit value of  |
| above \"COMMENTBLOCK\" i |
| s $?."   # 0             |
|     # No error shown.    |
|     echo                 |
|                          |
|                          |
|     #  The above techniq |
| ue also comes in useful  |
| for commenting out       |
|     #+ a block of workin |
| g code for debugging pur |
| poses.                   |
|     #  This saves having |
|  to put a "#" at the beg |
| inning of each line,     |
|     #+ then having to go |
|  back and delete each "# |
| " later.                 |
|     #  Note that the use |
|  of of colon, above, is  |
| optional.                |
|                          |
|     echo "Just before co |
| mmented-out code block." |
|     #  The lines of code |
|  between the double-dash |
| ed lines will not execut |
| e.                       |
|     #  ================= |
| ======================== |
| ======================== |
| ==                       |
|     : <<DEBUGXXX         |
|     for file in *        |
|     do                   |
|      cat "$file"         |
|     done                 |
|     DEBUGXXX             |
|     #  ================= |
| ======================== |
| ======================== |
| ==                       |
|     echo "Just after com |
| mented-out code block."  |
|                          |
|     exit 0               |
|                          |
|                          |
|                          |
|     #################### |
| ######################## |
| ######################## |
| ##                       |
|     #  Note, however, th |
| at if a bracketed variab |
| le is contained within   |
|     #+ the commented-out |
|  code block,             |
|     #+ then this could c |
| ause problems.           |
|     #  for example:      |
|                          |
|                          |
|     #/!/bin/bash         |
|                          |
|       : <<COMMENTBLOCK   |
|       echo "This line wi |
| ll not echo."            |
|       &*@!!++=           |
|       ${foo_bar_bazz?}   |
|       $(rm -rf /tmp/foob |
| ar/)                     |
|       $(touch my_build_d |
| irectory/cups/Makefile)  |
|     COMMENTBLOCK         |
|                          |
|                          |
|     $ sh commented-bad.s |
| h                        |
|     commented-bad.sh: li |
| ne 3: foo_bar_bazz: para |
| meter null or not set    |
|                          |
|     # The remedy for thi |
| s is to strong-quote the |
|  'COMMENTBLOCK' in line  |
| 49, above.               |
|                          |
|       : <<'COMMENTBLOCK' |
|                          |
|     # Thank you, Kurt Pf |
| eifle, for pointing this |
|  out.                    |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="TIP">

+--------------------------------------+--------------------------------------+
| |Tip|                                |
| Yet another twist of this nifty      |
| trick makes "self-documenting"       |
| scripts possible.                    |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 19-12. A self-documenting script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # self-document.sh:  |
| self-documenting script  |
|     # Modification of "c |
| olm.sh".                 |
|                          |
|     DOC_REQUEST=70       |
|                          |
|     if [ "$1" = "-h"  -o |
|  "$1" = "--help" ]     # |
|  Request help.           |
|     then                 |
|       echo; echo "Usage: |
|  $0 [directory-name]"; e |
| cho                      |
|       sed --silent -e '/ |
| DOCUMENTATIONXX$/,/^DOCU |
| MENTATIONXX$/p' "$0" |   |
|       sed -e '/DOCUMENTA |
| TIONXX$/d'; exit $DOC_RE |
| QUEST; fi                |
|                          |
|                          |
|     : <<DOCUMENTATIONXX  |
|     List the statistics  |
| of a specified directory |
|  in tabular format.      |
|     -------------------- |
| ------------------------ |
| -------------------      |
|     The command-line par |
| ameter gives the directo |
| ry to be listed.         |
|     If no directory spec |
| ified or directory speci |
| fied cannot be read,     |
|     then list the curren |
| t working directory.     |
|                          |
|     DOCUMENTATIONXX      |
|                          |
|     if [ -z "$1" -o ! -r |
|  "$1" ]                  |
|     then                 |
|       directory=.        |
|     else                 |
|       directory="$1"     |
|     fi                   |
|                          |
|     echo "Listing of "$d |
| irectory":"; echo        |
|     (printf "PERMISSIONS |
|  LINKS OWNER GROUP SIZE  |
| MONTH DAY HH:MM PROG-NAM |
| E\n" \                   |
|     ; ls -l "$directory" |
|  | sed 1d) | column -t   |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Using a `cat script <here-docs.html#CATSCRIPTREF>`__ is an alternate way
of accomplishing this.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     DOC_REQUEST=70       |
|                          |
|     if [ "$1" = "-h"  -o |
|  "$1" = "--help" ]     # |
|  Request help.           |
|     then                 |
|                        # |
|  Use a "cat script" . .  |
| .                        |
|       cat <<DOCUMENTATIO |
| NXX                      |
|     List the statistics  |
| of a specified directory |
|  in tabular format.      |
|     -------------------- |
| ------------------------ |
| -------------------      |
|     The command-line par |
| ameter gives the directo |
| ry to be listed.         |
|     If no directory spec |
| ified or directory speci |
| fied cannot be read,     |
|     then list the curren |
| t working directory.     |
|                          |
|     DOCUMENTATIONXX      |
|     exit $DOC_REQUEST    |
|     fi                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

See also `Example A-28 <contributed-scripts.html#ISSPAMMER2>`__,
`Example A-40 <contributed-scripts.html#PETALS>`__, `Example
A-41 <contributed-scripts.html#QKY>`__, and `Example
A-42 <contributed-scripts.html#NIM>`__ for more examples of
self-documenting scripts.

.. raw:: html

   <div class="NOTE">

+----------------+----------------+----------------+----------------+----------------+
| |Note|         |
| Here documents |
| create         |
| temporary      |
| files, but     |
| these files    |
| are deleted    |
| after opening  |
| and are not    |
| accessible to  |
| any other      |
| process.       |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
| | .. code:: SC |
| REEN         | |
| |              |
|              | |
| |     bash$ ba |
| sh -c 'lsof  | |
| | -a -p $$ -d0 |
| ' << EOF     | |
| |     > EOF    |
|              | |
| |     lsof     |
| 1213 bozo    | |
| |  0r   REG    |
|  3,5    0 30 | |
| | 386 /tmp/t12 |
| 13-0-sh (del | |
| | eted)        |
|              | |
| |              |
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
| .. raw:: html  |
|                |
|    </p>        |
                
+----------------+----------------+----------------+----------------+----------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+--------------------------------------+--------------------------------------+
| |Caution|                            |
| Some utilities will not work inside  |
| a *here document*.                   |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="WARNING">

+----------------+----------------+----------------+----------------+----------------+
| |Warning|      |
| The closing    |
| *limit         |
| string*, on    |
| the final line |
| of a here      |
| document, must |
| start in the   |
| *first*        |
| character      |
| position.      |
| There can be   |
| *no leading    |
| whitespace*.   |
| Trailing       |
| whitespace     |
| after the      |
| limit string   |
| likewise       |
| causes         |
| unexpected     |
| behavior. The  |
| whitespace     |
| prevents the   |
| limit string   |
| from being     |
| recognized.    |
| `[1] <here-doc |
| s.html#FTN.AEN |
| 17822>`__      |
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
| |     #!/bin/b |
| ash          | |
| |              |
|              | |
| |     echo "-- |
| ------------ | |
| | ------------ |
| ------------ | |
| | ------------ |
| ------------ | |
| | --------"    |
|              | |
| |              |
|              | |
| |     cat <<Li |
| mitString    | |
| |     echo "Th |
| is is line 1 | |
| |  of the mess |
| age inside t | |
| | he here docu |
| ment."       | |
| |     echo "Th |
| is is line 2 | |
| |  of the mess |
| age inside t | |
| | he here docu |
| ment."       | |
| |     echo "Th |
| is is the fi | |
| | nal line of  |
| the message  | |
| | inside the h |
| ere document | |
| | ."           |
|              | |
| |          Lim |
| itString     | |
| |     #^^^^Ind |
| ented limit  | |
| | string. Erro |
| r! This scri | |
| | pt will not  |
| behave as ex | |
| | pected.      |
|              | |
| |              |
|              | |
| |     echo "-- |
| ------------ | |
| | ------------ |
| ------------ | |
| | ------------ |
| ------------ | |
| | --------"    |
|              | |
| |              |
|              | |
| |     #  These |
|  comments ar | |
| | e outside th |
| e 'here docu | |
| | ment',       |
|              | |
| |     #+ and s |
| hould not ec | |
| | ho.          |
|              | |
| |              |
|              | |
| |     echo "Ou |
| tside the he | |
| | re document. |
| "            | |
| |              |
|              | |
| |     exit 0   |
|              | |
| |              |
|              | |
| |     echo "Th |
| is line had  | |
| | better not e |
| cho."  # Fol | |
| | lows an 'exi |
| t' command.  | |
|                |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
|                |
| .. raw:: html  |
|                |
|    </p>        |
                
+----------------+----------------+----------------+----------------+----------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+----------------+----------------+----------------+----------------+----------------+
| |Caution|      |
| Some people    |
| very cleverly  |
| use a single ! |
| as a limit     |
| string. But,   |
| that's not     |
| necessarily a  |
| good idea.     |
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
| |     # This w |
| orks.        | |
| |     cat <<!  |
|              | |
| |     Hello!   |
|              | |
| |     ! Three  |
| more exclama | |
| | tions !!!    |
|              | |
| |     !        |
|              | |
| |              |
|              | |
| |              |
|              | |
| |     # But .  |
| . .          | |
| |     cat <<!  |
|              | |
| |     Hello!   |
|              | |
| |     Single e |
| xclamation p | |
| | oint follows |
| !            | |
| |     !        |
|              | |
| |     !        |
|              | |
| |     # Crashe |
| s with an er | |
| | ror message. |
|              | |
| |              |
|              | |
| |              |
|              | |
| |     # Howeve |
| r, the follo | |
| | wing will wo |
| rk.          | |
| |     cat <<EO |
| F            | |
| |     Hello!   |
|              | |
| |     Single e |
| xclamation p | |
| | oint follows |
| !            | |
| |     !        |
|              | |
| |     EOF      |
|              | |
| |     # It's s |
| afer to use  | |
| | a multi-char |
| acter limit  | |
| | string.      |
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
| .. raw:: html  |
|                |
|    </p>        |
                
+----------------+----------------+----------------+----------------+----------------+

.. raw:: html

   </div>

For those tasks too complex for a *here document*, consider using the
``expect`` scripting language, which was specifically designed for
feeding input into interactive programs.

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <here-docs.html#AEN17822>`__    |
| Except, as Dennis Benzinger points   |
| out, if `using **<<-** to suppress   |
| tabs <here-docs.html#LIMITSTRDASH>`_ |
| _.                                   |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <globbingref.html> | Globbing                 |
| `__                      | `Up <part5.html>`__      |
| `Home <index.html>`__    | Here Strings             |
| `Next <x17837.html>`__   |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Tip| image:: ../images/tip.gif
.. |Note| image:: ../images/note.gif
.. |Caution| image:: ../images/caution.gif
.. |Warning| image:: ../images/warning.gif
