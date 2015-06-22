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

`Prev <zeros.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <options.html>`__

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

  Chapter 32. Debugging
======================

+--------------------------+--------------------------+--------------------------+
| **                       |
| *Debugging is twice as   |
| hard as writing the code |
| in the first place.      |
| Therefore, if you write  |
| the code as cleverly as  |
| possible, you are, by    |
| definition, not smart    |
| enough to debug it.*     |
|                          |
| *--Brian Kernighan*      |
+--------------------------+--------------------------+--------------------------+

The Bash shell contains no built-in debugger, and only bare-bones
debugging-specific commands and constructs. Syntax errors or outright
typos in the script generate cryptic error messages that are often of no
help in debugging a non-functional script.

.. raw:: html

   <div class="EXAMPLE">

**Example 32-1. A buggy script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ex74.sh            |
|                          |
|     # This is a buggy sc |
| ript.                    |
|     # Where, oh where is |
|  the error?              |
|                          |
|     a=37                 |
|                          |
|     if [$a -gt 27 ]      |
|     then                 |
|       echo $a            |
|     fi                   |
|                          |
|     exit $?   # 0! Why?  |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Output from script:

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     ./ex74.sh: [37: comm |
| and not found            |
                          
+--------------------------+--------------------------+--------------------------+

What's wrong with the above script? Hint: after the *if* .

.. raw:: html

   <div class="EXAMPLE">

**Example 32-2. Missing `keyword <internal.html#KEYWORDREF>`__**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # missing-keyword.sh |
|     # What error message |
|  will this script genera |
| te? And why?             |
|                          |
|     for a in 1 2 3       |
|     do                   |
|       echo "$a"          |
|     # done     # Require |
| d keyword 'done' comment |
| ed out in line 8.        |
|                          |
|     exit 0     # Will no |
| t exit here!             |
|                          |
|     # === #              |
|                          |
|     # From command line, |
|  after script terminates |
| :                        |
|       echo $?    # 2     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Output from script:

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     missing-keyword.sh:  |
| line 10: syntax error: u |
| nexpected end of file    |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

Note that the error message does *not* necessarily reference the line in
which the error occurs, but the line where the Bash interpreter finally
becomes aware of the error.
Error messages may disregard comment lines in a script when reporting
the line number of a syntax error.

What if the script executes, but does not work as expected? This is the
all too familiar logic error.

.. raw:: html

   <div class="EXAMPLE">

**Example 32-3. *test24* : another buggy script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #  This script is su |
| pposed to delete all fil |
| enames in current direct |
| ory                      |
|     #+ containing embedd |
| ed spaces.               |
|     #  It doesn't work.  |
|     #  Why not?          |
|                          |
|                          |
|     badname=`ls | grep ' |
|  '`                      |
|                          |
|     # Try this:          |
|     # echo "$badname"    |
|                          |
|     rm "$badname"        |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Try to find out what's wrong with `Example 32-3 <debugging.html#EX75>`__
by uncommenting the ``             echo "$badname"           `` line.
Echo statements are useful for seeing whether what you expect is
actually what you get.

In this particular case, ``             rm "$badname"           `` will
not give the desired results because ``      $badname     `` should not
be quoted. Placing it in quotes ensures that **rm** has only one
argument (it will match only one filename). A partial fix is to remove
to quotes from ``      $badname     `` and to reset ``      $IFS     ``
to contain only a newline, ``             IFS=$'\n'           `` .
However, there are simpler ways of going about it.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # Correct methods of |
|  deleting filenames cont |
| aining spaces.           |
|     rm *\ *              |
|     rm *" "*             |
|     rm *' '*             |
|     # Thank you. S.C.    |
                          
+--------------------------+--------------------------+--------------------------+

Summarizing the symptoms of a buggy script,

#. It bombs with a " syntax error " message, or

#. It runs, but does not work as expected ( logic error ).

#. It runs, works as expected, but has nasty side effects ( logic bomb
   ).

Tools for debugging non-working scripts include

#. Inserting `echo <internal.html#ECHOREF>`__ statements at critical
   points in the script to trace the variables, and otherwise give a
   snapshot of what is going on.

   .. raw:: html

      <div class="TIP">

   +--------------------+--------------------+--------------------+--------------------+
   | |Tip|              |
   | Even better is an  |
   | **echo** that      |
   | echoes only when   |
   | *debug* is on.     |
   |                    |
   | +----------------- |
   | ---------+-------- |
   | ------------------ |
   | +----------------- |
   | ---------+         |
   | | .. code:: PROGRA |
   | MLISTING |         |
   | |                  |
   |          |         |
   | |     ### debecho  |
   | (debug-e |         |
   | | cho), by Stefano |
   |  Falsett |         |
   | | o ###            |
   |          |         |
   | |     ### Will ech |
   | o passed |         |
   | |  parameters only |
   |  if DEBU |         |
   | | G is set to a va |
   | lue. ### |         |
   | |     debecho () { |
   |          |         |
   | |       if [ ! -z  |
   | "$DEBUG" |         |
   | |  ]; then         |
   |          |         |
   | |          echo "$ |
   | 1" >&2   |         |
   | |          #       |
   |    ^^^ t |         |
   | | o stderr         |
   |          |         |
   | |       fi         |
   |          |         |
   | |     }            |
   |          |         |
   | |                  |
   |          |         |
   | |     DEBUG=on     |
   |          |         |
   | |     Whatever=wha |
   | tnot     |         |
   | |     debecho $Wha |
   | tever    |         |
   | | # whatnot        |
   |          |         |
   | |                  |
   |          |         |
   | |     DEBUG=       |
   |          |         |
   | |     Whatever=not |
   | what     |         |
   | |     debecho $Wha |
   | tever    |         |
   | | # (Will not echo |
   | .)       |         |
   |                    |
   |                    |
   | +----------------- |
   | ---------+-------- |
   | ------------------ |
   | +----------------- |
   | ---------+         |
                       
   +--------------------+--------------------+--------------------+--------------------+

   .. raw:: html

      </div>

#. Using the `tee <extmisc.html#TEEREF>`__ filter to check processes or
   data flows at critical points.

#. Setting option flags ``        -n -v -x       ``

   ``                 sh -n scriptname               `` checks for
   syntax errors without actually running the script. This is the
   equivalent of inserting ``                 set -n               `` or
   ``                 set -o noexec               `` into the script.
   Note that certain types of syntax errors can slip past this check.

   ``                 sh -v scriptname               `` echoes each
   command before executing it. This is the equivalent of inserting
   ``                 set -v               `` or
   ``                 set           -o verbose               `` in the
   script.

   The ``        -n       `` and ``        -v       `` flags work well
   together.
   ``                 sh -nv           scriptname               `` gives
   a verbose syntax check.

   ``                 sh -x scriptname               `` echoes the
   result each command, but in an abbreviated manner. This is the
   equivalent of inserting ``                 set -x               `` or
   ``                 set -o xtrace               `` in the script.

   Inserting ``                 set -u               `` or
   ``                 set -o nounset               `` in the script runs
   it, but gives an unbound variable error message and aborts the
   script.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     set -u   # Or   set  |
   | -o nounset               |
   |                          |
   |     # Setting a variable |
   |  to null will not trigge |
   | r the error/abort.       |
   |     # unset_var=         |
   |                          |
   |     echo $unset_var   #  |
   | Unset (and undeclared) v |
   | ariable.                 |
   |                          |
   |     echo "Should not ech |
   | o!"                      |
   |                          |
   |     # sh t2.sh           |
   |     # t2.sh: line 6: uns |
   | et_var: unbound variable |
                             
   +--------------------------+--------------------------+--------------------------+

#. Using an "assert" function to test a variable or condition at
   critical points in a script. (This is an idea borrowed from C.)

   .. raw:: html

      <div class="EXAMPLE">

   **Example 32-4. Testing a condition with an *assert***

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |     # assert.sh          |
   |                          |
   |     #################### |
   | ######################## |
   | ######################## |
   | ###                      |
   |     assert ()            |
   |       #  If condition fa |
   | lse,                     |
   |     {                    |
   |       #+ exit from scrip |
   | t                        |
   |                          |
   |       #+ with appropriat |
   | e error message.         |
   |       E_PARAM_ERR=98     |
   |       E_ASSERT_FAILED=99 |
   |                          |
   |                          |
   |       if [ -z "$2" ]     |
   |       #  Not enough para |
   | meters passed            |
   |       then               |
   |       #+ to assert() fun |
   | ction.                   |
   |         return $E_PARAM_ |
   | ERR   #  No damage done. |
   |       fi                 |
   |                          |
   |       lineno=$2          |
   |                          |
   |       if [ ! $1 ]        |
   |       then               |
   |         echo "Assertion  |
   | failed:  \"$1\""         |
   |         echo "File \"$0\ |
   | ", line $lineno"    # Gi |
   | ve name of file and line |
   |  number.                 |
   |         exit $E_ASSERT_F |
   | AILED                    |
   |       # else             |
   |       #   return         |
   |       #   and continue e |
   | xecuting the script.     |
   |       fi                 |
   |     } # Insert a similar |
   |  assert() function into  |
   | a script you need to deb |
   | ug.                      |
   |     #################### |
   | ######################## |
   | ######################## |
   | ###                      |
   |                          |
   |                          |
   |     a=5                  |
   |     b=4                  |
   |     condition="$a -lt $b |
   | "     #  Error message a |
   | nd exit from script.     |
   |                          |
   |       #  Try setting "co |
   | ndition" to something el |
   | se                       |
   |                          |
   |       #+ and see what ha |
   | ppens.                   |
   |                          |
   |     assert "$condition"  |
   | $LINENO                  |
   |     # The remainder of t |
   | he script executes only  |
   | if the "assert" does not |
   |  fail.                   |
   |                          |
   |                          |
   |     # Some commands.     |
   |     # Some more commands |
   |  . . .                   |
   |     echo "This statement |
   |  echoes only if the \"as |
   | sert\" does not fail."   |
   |     # . . .              |
   |     # More commands . .  |
   | .                        |
   |                          |
   |     exit $?              |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

#. Using the `$LINENO <internalvariables.html#LINENOREF>`__ variable and
   the `caller <internal.html#CALLERREF>`__ builtin.

#.  Trapping at exit.

   The `exit <internal.html#EXITREF>`__ command in a script triggers a
   signal 0 , terminating the process, that is, the script itself. ` [1]
    <debugging.html#FTN.AEN19460>`__ It is often useful to trap the
   *exit* , forcing a "printout" of variables, for example. The *trap*
   must be the first command in the script.

.. raw:: html

   <div class="VARIABLELIST">

** Trapping signals**

 **trap**
    Specifies an action on receipt of a signal; also useful for
    debugging.

    +--------------------------------------------------------------------------+
    | .. raw:: html                                                            |
    |                                                                          |
    |    <div class="SIDEBAR">                                                 |
    |                                                                          |
    | A *signal* is a message sent to a process, either by the kernel or       |
    | another process, telling it to take some specified action (usually to    |
    | terminate). For example, hitting a                                       |
    | `Control-C <special-chars.html#CTLCREF>`__ sends a user interrupt, an    |
    | INT signal, to a running program.                                        |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </div>                                                                |
                                                                              
    +--------------------------------------------------------------------------+

    *A simple instance:*

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     trap '' 2            |
    |     # Ignore interrupt 2 |
    |  (Control-C), with no ac |
    | tion specified.          |
    |                          |
    |     trap 'echo "Control- |
    | C disabled."' 2          |
    |     # Message when Contr |
    | ol-C pressed.            |
                              
    +--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 32-5. Trapping at exit**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # Hunting variables  |
| with a trap.             |
|                          |
|     trap 'echo Variable  |
| Listing --- a = $a  b =  |
| $b' EXIT                 |
|     #  EXIT is the name  |
| of the signal generated  |
| upon exit from a script. |
|     #                    |
|     #  The command speci |
| fied by the "trap" doesn |
| 't execute until         |
|     #+ the appropriate s |
| ignal is sent.           |
|                          |
|     echo "This prints be |
| fore the \"trap\" --"    |
|     echo "even though th |
| e script sees the \"trap |
| \" first."               |
|     echo                 |
|                          |
|     a=39                 |
|                          |
|     b=36                 |
|                          |
|     exit 0               |
|     #  Note that comment |
| ing out the 'exit' comma |
| nd makes no difference,  |
|     #+ since the script  |
| exits in any case after  |
| running out of commands. |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 32-6. Cleaning up after **Control-C****

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # logon.sh: A quick  |
| 'n dirty script to check |
|  whether you are on-line |
|  yet.                    |
|                          |
|     umask 177  # Make su |
| re temp files are not wo |
| rld readable.            |
|                          |
|                          |
|     TRUE=1               |
|     LOGFILE=/var/log/mes |
| sages                    |
|     #  Note that $LOGFIL |
| E must be readable       |
|     #+ (as root, chmod 6 |
| 44 /var/log/messages).   |
|     TEMPFILE=temp.$$     |
|     #  Create a "unique" |
|  temp file name, using p |
| rocess id of the script. |
|     #     Using 'mktemp' |
|  is an alternative.      |
|     #     For example:   |
|     #     TEMPFILE=`mkte |
| mp temp.XXXXXX`          |
|     KEYWORD=address      |
|     #  At logon, the lin |
| e "remote IP address xxx |
| .xxx.xxx.xxx"            |
|     #                    |
|    appended to /var/log/ |
| messages.                |
|     ONLINE=22            |
|     USER_INTERRUPT=13    |
|     CHECK_LINES=100      |
|     #  How many lines in |
|  log file to check.      |
|                          |
|     trap 'rm -f $TEMPFIL |
| E; exit $USER_INTERRUPT' |
|  TERM INT                |
|     #  Cleans up the tem |
| p file if script interru |
| pted by control-c.       |
|                          |
|     echo                 |
|                          |
|     while [ $TRUE ]  #En |
| dless loop.              |
|     do                   |
|       tail -n $CHECK_LIN |
| ES $LOGFILE> $TEMPFILE   |
|       #  Saves last 100  |
| lines of system log file |
|  as temp file.           |
|       #  Necessary, sinc |
| e newer kernels generate |
|  many log messages at lo |
| g on.                    |
|       search=`grep $KEYW |
| ORD $TEMPFILE`           |
|       #  Checks for pres |
| ence of the "IP address" |
|  phrase,                 |
|       #+ indicating a su |
| ccessful logon.          |
|                          |
|       if [ ! -z "$search |
| " ] #  Quotes necessary  |
| because of possible spac |
| es.                      |
|       then               |
|          echo "On-line"  |
|          rm -f $TEMPFILE |
|     #  Clean up temp fil |
| e.                       |
|          exit $ONLINE    |
|       else               |
|          echo -n "."     |
|     #  The -n option to  |
| echo suppresses newline, |
|                          |
|     #+ so you get contin |
| uous rows of dots.       |
|       fi                 |
|                          |
|       sleep 1            |
|     done                 |
|                          |
|                          |
|     #  Note: if you chan |
| ge the KEYWORD variable  |
| to "Exit",               |
|     #+ this script can b |
| e used while on-line     |
|     #+ to check for an u |
| nexpected logoff.        |
|                          |
|     # Exercise: Change t |
| he script, per the above |
|  note,                   |
|     #           and pret |
| tify it.                 |
|                          |
|     exit 0               |
|                          |
|                          |
|     # Nick Drage suggest |
| s an alternate method:   |
|                          |
|     while true           |
|       do ifconfig ppp0 | |
|  grep UP 1> /dev/null && |
|  echo "connected" && exi |
| t 0                      |
|       echo -n "."   # Pr |
| ints dots (.....) until  |
| connected.               |
|       sleep 2            |
|     done                 |
|                          |
|     # Problem: Hitting C |
| ontrol-C to terminate th |
| is process may be insuff |
| icient.                  |
|     #+         (Dots may |
|  keep on echoing.)       |
|     # Exercise: Fix this |
| .                        |
|                          |
|                          |
|                          |
|     # Stephane Chazelas  |
| has yet another alternat |
| ive:                     |
|                          |
|     CHECK_INTERVAL=1     |
|                          |
|     while ! tail -n 1 "$ |
| LOGFILE" | grep -q "$KEY |
| WORD"                    |
|     do echo -n .         |
|        sleep $CHECK_INTE |
| RVAL                     |
|     done                 |
|     echo "On-line"       |
|                          |
|     # Exercise: Discuss  |
| the relative strengths a |
| nd weaknesses            |
|     #           of each  |
| of these various approac |
| hes.                     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 32-7. A Simple Implementation of a Progress Bar**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # progress-bar2.sh   |
|     # Author: Graham Ewa |
| rt (with reformatting by |
|  ABS Guide author).      |
|     # Used in ABS Guide  |
| with permission (thanks! |
| ).                       |
|                          |
|     # Invoke this script |
|  with bash. It doesn't w |
| ork with sh.             |
|                          |
|     interval=1           |
|     long_interval=10     |
|                          |
|     {                    |
|          trap "exit" SIG |
| USR1                     |
|          sleep $interval |
| ; sleep $interval        |
|          while true      |
|          do              |
|            echo -n '.'   |
|    # Use dots.           |
|            sleep $interv |
| al                       |
|          done; } &       |
|    # Start a progress ba |
| r as a background proces |
| s.                       |
|                          |
|     pid=$!               |
|     trap "echo !; kill - |
| USR1 $pid; wait $pid"  E |
| XIT        # To handle ^ |
| C.                       |
|                          |
|     echo -n 'Long-runnin |
| g process '              |
|     sleep $long_interval |
|     echo ' Finished!'    |
|                          |
|     kill -USR1 $pid      |
|     wait $pid            |
|    # Stop the progress b |
| ar.                      |
|     trap EXIT            |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="NOTE">

+--------------------------+--------------------------+--------------------------+
| |Note|                   |
| The                      |
| ``          DEBUG        |
|   ``                     |
| argument to **trap**     |
| causes a specified       |
| action to execute after  |
| every command in a       |
| script. This permits     |
| tracing variables, for   |
| example.                 |
|                          |
| .. raw:: html            |
|                          |
|    <div class="EXAMPLE"> |
|                          |
| **Example 32-8. Tracing  |
| a variable**             |
|                          |
| +----------------------- |
| ---+-------------------- |
| ------+----------------- |
| ---------+               |
| | .. code:: PROGRAMLISTI |
| NG |                     |
| |                        |
|    |                     |
| |     #!/bin/bash        |
|    |                     |
| |                        |
|    |                     |
| |     trap 'echo "VARIAB |
| LE |                     |
| | -TRACE> \$variable = \ |
| "$ |                     |
| | variable\""' DEBUG     |
|    |                     |
| |     # Echoes the value |
|  o |                     |
| | f $variable after ever |
| y  |                     |
| | command.               |
|    |                     |
| |                        |
|    |                     |
| |     variable=29; line= |
| $L |                     |
| | INENO                  |
|    |                     |
| |                        |
|    |                     |
| |     echo "  Just initi |
| al |                     |
| | ized \$variable to $va |
| ri |                     |
| | able in line number $l |
| in |                     |
| | e."                    |
|    |                     |
| |                        |
|    |                     |
| |     let "variable *= 3 |
| "; |                     |
| |  line=$LINENO          |
|    |                     |
| |     echo "  Just multi |
| pl |                     |
| | ied \$variable by 3 in |
|  l |                     |
| | ine number $line."     |
|    |                     |
| |                        |
|    |                     |
| |     exit 0             |
|    |                     |
| |                        |
|    |                     |
| |     #  The "trap 'comm |
| an |                     |
| | d1 . . . command2 . .  |
| .' |                     |
| |  DEBUG" construct is   |
|    |                     |
| |     #+ more appropriat |
| e  |                     |
| | in the context of a co |
| mp |                     |
| | lex script,            |
|    |                     |
| |     #+ where inserting |
|  m |                     |
| | ultiple "echo $variabl |
| e" |                     |
| |  statements might be   |
|    |                     |
| |     #+ awkward and tim |
| e- |                     |
| | consuming.             |
|    |                     |
| |                        |
|    |                     |
| |     # Thanks, Stephane |
|  C |                     |
| | hazelas for the pointe |
| r. |                     |
| |                        |
|    |                     |
| |                        |
|    |                     |
| |     Output of script:  |
|    |                     |
| |                        |
|    |                     |
| |     VARIABLE-TRACE> $v |
| ar |                     |
| | iable = ""             |
|    |                     |
| |     VARIABLE-TRACE> $v |
| ar |                     |
| | iable = "29"           |
|    |                     |
| |       Just initialized |
|  $ |                     |
| | variable to 29.        |
|    |                     |
| |     VARIABLE-TRACE> $v |
| ar |                     |
| | iable = "29"           |
|    |                     |
| |     VARIABLE-TRACE> $v |
| ar |                     |
| | iable = "87"           |
|    |                     |
| |       Just multiplied  |
| $v |                     |
| | ariable by 3.          |
|    |                     |
| |     VARIABLE-TRACE> $v |
| ar |                     |
| | iable = "87"           |
|    |                     |
|                          |
|                          |
| +----------------------- |
| ---+-------------------- |
| ------+----------------- |
| ---------+               |
|                          |
| .. raw:: html            |
|                          |
|    </div>                |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Of course, the **trap** command has other uses aside from debugging,
such as disabling certain keystrokes within a script (see `Example
A-43 <contributed-scripts.html#STOPWATCH>`__ ).

.. raw:: html

   <div class="EXAMPLE">

**Example 32-9. Running multiple processes (on an SMP box)**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # parent.sh          |
|     # Running multiple p |
| rocesses on an SMP box.  |
|     # Author: Tedman Eng |
|                          |
|     #  This is the first |
|  of two scripts,         |
|     #+ both of which mus |
| t be present in the curr |
| ent working directory.   |
|                          |
|                          |
|                          |
|                          |
|     LIMIT=$1         # T |
| otal number of process t |
| o start                  |
|     NUMPROC=4        # N |
| umber of concurrent thre |
| ads (forks?)             |
|     PROCID=1         # S |
| tarting Process ID       |
|     echo "My PID is $$"  |
|                          |
|     function start_threa |
| d() {                    |
|             if [ $PROCID |
|  -le $LIMIT ] ; then     |
|                     ./ch |
| ild.sh $PROCID&          |
|                     let  |
| "PROCID++"               |
|             else         |
|                echo "Lim |
| it reached."             |
|                wait      |
|                exit      |
|             fi           |
|     }                    |
|                          |
|     while [ "$NUMPROC" - |
| gt 0 ]; do               |
|             start_thread |
| ;                        |
|             let "NUMPROC |
| --"                      |
|     done                 |
|                          |
|                          |
|     while true           |
|     do                   |
|                          |
|     trap "start_thread"  |
| SIGRTMIN                 |
|                          |
|     done                 |
|                          |
|     exit 0               |
|                          |
|                          |
|                          |
|     # ======== Second sc |
| ript follows ========    |
|                          |
|                          |
|     #!/bin/bash          |
|     # child.sh           |
|     # Running multiple p |
| rocesses on an SMP box.  |
|     # This script is cal |
| led by parent.sh.        |
|     # Author: Tedman Eng |
|                          |
|     temp=$RANDOM         |
|     index=$1             |
|     shift                |
|     let "temp %= 5"      |
|     let "temp += 4"      |
|     echo "Starting $inde |
| x  Time:$temp" "$@"      |
|     sleep ${temp}        |
|     echo "Ending $index" |
|     kill -s SIGRTMIN $PP |
| ID                       |
|                          |
|     exit 0               |
|                          |
|                          |
|     # ================== |
| ===== SCRIPT AUTHOR'S NO |
| TES ==================== |
| === #                    |
|     #  It's not complete |
| ly bug free.             |
|     #  I ran it with lim |
| it = 500 and after the f |
| irst few hundred iterati |
| ons,                     |
|     #+ one of the concur |
| rent threads disappeared |
| !                        |
|     #  Not sure if this  |
| is collisions from trap  |
| signals or something els |
| e.                       |
|     #  Once the trap is  |
| received, there's a brie |
| f moment while executing |
|  the                     |
|     #+ trap handler but  |
| before the next trap is  |
| set.  During this time,  |
| it may                   |
|     #+ be possible to mi |
| ss a trap signal, thus m |
| iss spawning a child pro |
| cess.                    |
|                          |
|     #  No doubt someone  |
| may spot the bug and wil |
| l be writing             |
|     #+ . . . in the futu |
| re.                      |
|                          |
|                          |
|                          |
|     # ================== |
| ======================== |
| ======================== |
| === #                    |
|                          |
|                          |
|                          |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| ----#                    |
|                          |
|                          |
|                          |
|     #################### |
| ######################## |
| #####################    |
|     # The following is t |
| he original script writt |
| en by Vernia Damiano.    |
|     # Unfortunately, it  |
| doesn't work properly.   |
|     #################### |
| ######################## |
| #####################    |
|                          |
|     #!/bin/bash          |
|                          |
|     #  Must call script  |
| with at least one intege |
| r parameter              |
|     #+ (number of concur |
| rent processes).         |
|     #  All other paramet |
| ers are passed through t |
| o the processes started. |
|                          |
|                          |
|     INDICE=8        # To |
| tal number of process to |
|  start                   |
|     TEMPO=5         # Ma |
| ximum sleep time per pro |
| cess                     |
|     E_BADARGS=65    # No |
|  arg(s) passed to script |
| .                        |
|                          |
|     if [ $# -eq 0 ] # Ch |
| eck for at least one arg |
| ument passed to script.  |
|     then                 |
|       echo "Usage: `base |
| name $0` number_of_proce |
| sses [passed params]"    |
|       exit $E_BADARGS    |
|     fi                   |
|                          |
|     NUMPROC=$1           |
|     # Number of concurre |
| nt process               |
|     shift                |
|     PARAMETRI=( "$@" )   |
|     # Parameters of each |
|  process                 |
|                          |
|     function avvia() {   |
|              local temp  |
|              local index |
|              temp=$RANDO |
| M                        |
|              index=$1    |
|              shift       |
|              let "temp % |
| = $TEMPO"                |
|              let "temp + |
| = 1"                     |
|              echo "Start |
| ing $index Time:$temp" " |
| $@"                      |
|              sleep ${tem |
| p}                       |
|              echo "Endin |
| g $index"                |
|              kill -s SIG |
| RTMIN $$                 |
|     }                    |
|                          |
|     function parti() {   |
|              if [ $INDIC |
| E -gt 0 ] ; then         |
|                   avvia  |
| $INDICE "${PARAMETRI[@]} |
| " &                      |
|                     let  |
| "INDICE--"               |
|              else        |
|                     trap |
|  : SIGRTMIN              |
|              fi          |
|     }                    |
|                          |
|     trap parti SIGRTMIN  |
|                          |
|     while [ "$NUMPROC" - |
| gt 0 ]; do               |
|              parti;      |
|              let "NUMPRO |
| C--"                     |
|     done                 |
|                          |
|     wait                 |
|     trap - SIGRTMIN      |
|                          |
|     exit $?              |
|                          |
|     : <<SCRIPT_AUTHOR_CO |
| MMENTS                   |
|     I had the need to ru |
| n a program, with specif |
| ied options, on a number |
|  of                      |
|     different files, usi |
| ng a SMP machine. So I t |
| hought [I'd] keep runnin |
| g                        |
|     a specified number o |
| f processes and start a  |
| new one each time . . .  |
| one                      |
|     of these terminates. |
|                          |
|     The "wait" instructi |
| on does not help, since  |
| it waits for a given pro |
| cess                     |
|     or *all* process sta |
| rted in background. So I |
|  wrote [this] bash scrip |
| t                        |
|     that can do the job, |
|  using the "trap" instru |
| ction.                   |
|       --Vernia Damiano   |
|     SCRIPT_AUTHOR_COMMEN |
| TS                       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| ``                     trap '' SIGNA |
| L                   ``               |
| (two adjacent apostrophes) disables  |
| SIGNAL for the remainder of the      |
| script.                              |
| ``                     trap SIGNAL   |
|                  ``                  |
| restores the functioning of SIGNAL   |
| once more. This is useful to protect |
| a critical portion of a script from  |
| an undesirable interrupt.            |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|      trap '' 2  # Signal |
|  2 is Control-C, now dis |
| abled.                   |
|         command          |
|         command          |
|         command          |
|         trap 2     # Ree |
| nables Control-C         |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| `Version 3 <bashver3.html#BASH3REF>`__ of Bash adds the following        |
| `internal variables <internalvariables.html#INTERNALVARIABLES1>`__ for   |
| use by the debugger.                                                     |
|                                                                          |
| #. ``            $BASH_ARGC           ``                                 |
|                                                                          |
|    Number of command-line arguments passed to script, similar to         |
|    ```             $#            `` <internalvariables.html#CLACOUNTREF> |
| `__                                                                      |
|    .                                                                     |
|                                                                          |
| #. ``            $BASH_ARGV           ``                                 |
|                                                                          |
|    Final command-line parameter passed to script, equivalent             |
|    ```             ${!#}            `` <othertypesv.html#LASTARGREF>`__  |
|    .                                                                     |
|                                                                          |
| #. ``            $BASH_COMMAND           ``                              |
|                                                                          |
|    Command currently executing.                                          |
|                                                                          |
| #. ``            $BASH_EXECUTION_STRING           ``                     |
|                                                                          |
|    The *option string* following the ``            -c           ``       |
|    `option <bash-options.html#CLOPTS>`__ to Bash.                        |
|                                                                          |
| #. ``            $BASH_LINENO           ``                               |
|                                                                          |
|    In a `function <functions.html#FUNCTIONREF>`__ , indicates the line   |
|    number of the function call.                                          |
|                                                                          |
| #. ``            $BASH_REMATCH           ``                              |
|                                                                          |
|    Array variable associated with **=~** `conditional regex              |
|    matching <bashver3.html#REGEXMATCHREF>`__ .                           |
|                                                                          |
| #.                                                                       |
|                                                                          |
|    ``            $BASH_SOURCE           ``                               |
|                                                                          |
|    This is the name of the script, usually the same as                   |
|    `$0 <othertypesv.html#ARG0>`__ .                                      |
|                                                                          |
| #. ```             $BASH_SUBSHELL            `` <internalvariables.html# |
| BASHSUBSHELLREF>`__                                                      |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <debugging.html#AEN19460>`__  |
| By convention,                       |
| ``                 signal         0  |
|               ``                     |
| is assigned to                       |
| `exit <exit-status.html#EXITCOMMANDR |
| EF>`__                               |
| .                                    |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <zeros.html>`__    | Of Zeros and Nulls       |
| `Home <index.html>`__    | `Up <part5.html>`__      |
| `Next <options.html>`__  | Options                  |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Tip| image:: ../images/tip.gif
.. |Note| image:: ../images/note.gif
