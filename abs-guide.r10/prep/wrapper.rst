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

`Prev <intandnonint.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 36. Miscellany

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <testsandcomparisons.html>`__

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

   <div class="SECT1">

  36.2. Shell Wrappers
=====================

A *wrapper* is a shell script that embeds a system command or utility,
that accepts and passes a set of parameters to that command. ` [1]
 <wrapper.html#FTN.AEN20130>`__ Wrapping a script around a complex
command-line simplifies invoking it. This is expecially useful with
`sed <sedawk.html#SEDREF>`__ and `awk <awk.html#AWKREF>`__ .

A **sed** or **awk** script would normally be invoked from the
command-line by a
``             sed -e                        'commands'               ``
or ``             awk                        'commands'               ``
. Embedding such a script in a Bash script permits calling it more
simply, and makes it *reusable* . This also enables combining the
functionality of *sed* and *awk* , for example
`piping <special-chars.html#PIPEREF>`__ the output of a set of *sed*
commands to *awk* . As a saved executable file, you can then repeatedly
invoke it in its original form or modified, without the inconvenience of
retyping it on the command-line.

.. raw:: html

   <div class="EXAMPLE">

**Example 36-1. *shell wrapper***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # This simple script |
|  removes blank lines fro |
| m a file.                |
|     # No argument checki |
| ng.                      |
|     #                    |
|     # You might wish to  |
| add something like:      |
|     #                    |
|     # E_NOARGS=85        |
|     # if [ -z "$1" ]     |
|     # then               |
|     #  echo "Usage: `bas |
| ename $0` target-file"   |
|     #  exit $E_NOARGS    |
|     # fi                 |
|                          |
|                          |
|                          |
|     sed -e /^$/d "$1"    |
|     # Same as            |
|     #    sed -e '/^$/d'  |
| filename                 |
|     # invoked from the c |
| ommand-line.             |
|                          |
|     #  The '-e' means an |
|  "editing" command follo |
| ws (optional here).      |
|     #  '^' indicates the |
|  beginning of line, '$'  |
| the end.                 |
|     #  This matches line |
| s with nothing between t |
| he beginning and the end |
|  --                      |
|     #+ blank lines.      |
|     #  The 'd' is the de |
| lete command.            |
|                          |
|     #  Quoting the comma |
| nd-line arg permits      |
|     #+ whitespace and sp |
| ecial characters in the  |
| filename.                |
|                          |
|     #  Note that this sc |
| ript doesn't actually ch |
| ange the target file.    |
|     #  If you need to do |
|  that, redirect its outp |
| ut.                      |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 36-2. A slightly more complex *shell wrapper***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #  subst.sh: a scrip |
| t that substitutes one p |
| attern for               |
|     #+ another in a file |
| ,                        |
|     #+ i.e., "sh subst.s |
| h Smith Jones letter.txt |
| ".                       |
|     #                    |
|   Jones replaces Smith.  |
|                          |
|     ARGS=3         # Scr |
| ipt requires 3 arguments |
| .                        |
|     E_BADARGS=85   # Wro |
| ng number of arguments p |
| assed to script.         |
|                          |
|     if [ $# -ne "$ARGS"  |
| ]                        |
|     then                 |
|       echo "Usage: `base |
| name $0` old-pattern new |
| -pattern filename"       |
|       exit $E_BADARGS    |
|     fi                   |
|                          |
|     old_pattern=$1       |
|     new_pattern=$2       |
|                          |
|     if [ -f "$3" ]       |
|     then                 |
|         file_name=$3     |
|     else                 |
|         echo "File \"$3\ |
| " does not exist."       |
|         exit $E_BADARGS  |
|     fi                   |
|                          |
|                          |
|     # ------------------ |
| ------------------------ |
| -----                    |
|     #  Here is where the |
|  heavy work gets done.   |
|     sed -e "s/$old_patte |
| rn/$new_pattern/g" $file |
| _name                    |
|     # ------------------ |
| ------------------------ |
| -----                    |
|                          |
|     #  's' is, of course |
| , the substitute command |
|  in sed,                 |
|     #+ and /pattern/ inv |
| okes address matching.   |
|     #  The 'g,' or globa |
| l flag causes substituti |
| on for EVERY             |
|     #+ occurence of $old |
| _pattern on each line, n |
| ot just the first.       |
|     #  Read the 'sed' do |
| cs for an in-depth expla |
| nation.                  |
|                          |
|     exit $?  # Redirect  |
| the output of this scrip |
| t to write to a file.    |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 36-3. A generic *shell wrapper* that writes to a logfile**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     #  logging-wrapper.s |
| h                        |
|     #  Generic shell wra |
| pper that performs an op |
| eration                  |
|     #+ and logs it.      |
|                          |
|     DEFAULT_LOGFILE=logf |
| ile.txt                  |
|                          |
|     # Set the following  |
| two variables.           |
|     OPERATION=           |
|     #         Can be a c |
| omplex chain of commands |
| ,                        |
|     #+        for exampl |
| e an awk script or a pip |
| e . . .                  |
|                          |
|     LOGFILE=             |
|     if [ -z "$LOGFILE" ] |
|     then     # If not se |
| t, default to ...        |
|       LOGFILE="$DEFAULT_ |
| LOGFILE"                 |
|     fi                   |
|                          |
|     #         Command-li |
| ne arguments, if any, fo |
| r the operation.         |
|     OPTIONS="$@"         |
|                          |
|                          |
|     # Log it.            |
|     echo "`date` + `whoa |
| mi` + $OPERATION "$@"" > |
| > $LOGFILE               |
|     # Now, do it.        |
|     exec $OPERATION "$@" |
|                          |
|     # It's necessary to  |
| do the logging before th |
| e operation.             |
|     # Why?               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 36-4. A *shell wrapper* around an awk script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # pr-ascii.sh: Print |
| s a table of ASCII chara |
| cters.                   |
|                          |
|     START=33   # Range o |
| f printable ASCII charac |
| ters (decimal).          |
|     END=127    # Will no |
| t work for unprintable c |
| haracters (> 127).       |
|                          |
|     echo " Decimal   Hex |
|      Character"   # Head |
| er.                      |
|     echo " -------   --- |
|      ---------"          |
|                          |
|     for ((i=START; i<=EN |
| D; i++))                 |
|     do                   |
|       echo $i | awk '{pr |
| intf("  %3d       %2x    |
|       %c\n", $1, $1, $1) |
| }'                       |
|     # The Bash printf bu |
| iltin will not work in t |
| his context:             |
|     #     printf "%c" "$ |
| i"                       |
|     done                 |
|                          |
|     exit 0               |
|                          |
|                          |
|     #  Decimal   Hex     |
|  Character               |
|     #  -------   ---     |
|  ---------               |
|     #    33       21     |
|      !                   |
|     #    34       22     |
|      "                   |
|     #    35       23     |
|      #                   |
|     #    36       24     |
|      $                   |
|     #                    |
|     #    . . .           |
|     #                    |
|     #   122       7a     |
|      z                   |
|     #   123       7b     |
|      {                   |
|     #   124       7c     |
|      |                   |
|     #   125       7d     |
|      }                   |
|                          |
|                          |
|     #  Redirect the outp |
| ut of this script to a f |
| ile                      |
|     #+ or pipe it to "mo |
| re":  sh pr-asc.sh | mor |
| e                        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 36-5. A *shell wrapper* around another awk script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # Adds up a specifie |
| d column (of numbers) in |
|  the target file.        |
|     # Floating-point (de |
| cimal) numbers okay, bec |
| ause awk can handle them |
| .                        |
|                          |
|     ARGS=2               |
|     E_WRONGARGS=85       |
|                          |
|     if [ $# -ne "$ARGS"  |
| ] # Check for proper num |
| ber of command-line args |
| .                        |
|     then                 |
|        echo "Usage: `bas |
| ename $0` filename colum |
| n-number"                |
|        exit $E_WRONGARGS |
|     fi                   |
|                          |
|     filename=$1          |
|     column_number=$2     |
|                          |
|     #  Passing shell var |
| iables to the awk part o |
| f the script is a bit tr |
| icky.                    |
|     #  One method is to  |
| strong-quote the Bash-sc |
| ript variable            |
|     #+ within the awk sc |
| ript.                    |
|     #     $'$BASH_SCRIPT |
| _VAR'                    |
|     #      ^             |
|     ^                    |
|     #  This is done in t |
| he embedded awk script b |
| elow.                    |
|     #  See the awk docum |
| entation for more detail |
| s.                       |
|                          |
|     # A multi-line awk s |
| cript is here invoked by |
|     #   awk '            |
|     #   ...              |
|     #   ...              |
|     #   ...              |
|     #   '                |
|                          |
|                          |
|     # Begin awk script.  |
|     # ------------------ |
| -----------              |
|     awk '                |
|                          |
|     { total += $'"${colu |
| mn_number}"'             |
|     }                    |
|     END {                |
|          print total     |
|     }                    |
|                          |
|     ' "$filename"        |
|     # ------------------ |
| -----------              |
|     # End awk script.    |
|                          |
|                          |
|     #   It may not be sa |
| fe to pass shell variabl |
| es to an embedded awk sc |
| ript,                    |
|     #+  so Stephane Chaz |
| elas proposes the follow |
| ing alternative:         |
|     #   ---------------- |
| -----------------------  |
|     #   awk -v column_nu |
| mber="$column_number" '  |
|     #   { total += $colu |
| mn_number                |
|     #   }                |
|     #   END {            |
|     #       print total  |
|     #   }' "$filename"   |
|     #   ---------------- |
| -----------------------  |
|                          |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

 For those scripts needing a single do-it-all tool, a Swiss army knife,
there is *Perl* . Perl combines the capabilities of
`sed <sedawk.html#SEDREF>`__ and `awk <awk.html#AWKREF>`__ , and throws
in a large subset of **C** , to boot. It is modular and contains support
for everything ranging from object-oriented programming up to and
including the kitchen sink. Short Perl scripts lend themselves to
embedding within shell scripts, and there may be some substance to the
claim that Perl can totally replace shell scripting (though the author
of the *ABS Guide* remains skeptical).

.. raw:: html

   <div class="EXAMPLE">

**Example 36-6. Perl embedded in a *Bash* script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # Shell commands may |
|  precede the Perl script |
| .                        |
|     echo "This precedes  |
| the embedded Perl script |
|  within \"$0\"."         |
|     echo "============== |
| ======================== |
| ======================== |
| ="                       |
|                          |
|     perl -e 'print "This |
|  line prints from an emb |
| edded Perl script.\n";'  |
|     # Like sed, Perl als |
| o uses the "-e" option.  |
|                          |
|     echo "============== |
| ======================== |
| ======================== |
| ="                       |
|     echo "However, the s |
| cript may also contain s |
| hell and system commands |
| ."                       |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

It is even possible to combine a Bash script and Perl script within the
same file. Depending on how the script is invoked, either the Bash part
or the Perl part will execute.

.. raw:: html

   <div class="EXAMPLE">

**Example 36-7. Bash and Perl scripts combined**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # bashandperl.sh     |
|                          |
|     echo "Greetings from |
|  the Bash part of the sc |
| ript, $0."               |
|     # More Bash commands |
|  may follow here.        |
|                          |
|     exit                 |
|     # End of Bash part o |
| f the script.            |
|                          |
|     # ================== |
| ======================== |
| =============            |
|                          |
|     #!/usr/bin/perl      |
|     # This part of the s |
| cript must be invoked wi |
| th                       |
|     #    perl -x bashand |
| perl.sh                  |
|                          |
|     print "Greetings fro |
| m the Perl part of the s |
| cript, $0.\n";           |
|     #      Perl doesn't  |
| seem to like "echo" ...  |
|     # More Perl commands |
|  may follow here.        |
|                          |
|     # End of Perl part o |
| f the script.            |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ bash bashandpe |
| rl.sh                    |
|     Greetings from the B |
| ash part of the script.  |
|                          |
|                          |
|     bash$ perl -x bashan |
| dperl.sh                 |
|     Greetings from the P |
| erl part of the script.  |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

It is, of course, possible to embed even more exotic scripting languages
within shell wrappers. *Python* , for example ...

.. raw:: html

   <div class="EXAMPLE">

**Example 36-8. Python embedded in a *Bash* script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ex56py.sh          |
|                          |
|     # Shell commands may |
|  precede the Python scri |
| pt.                      |
|     echo "This precedes  |
| the embedded Python scri |
| pt within \"$0.\""       |
|     echo "============== |
| ======================== |
| ======================== |
| ="                       |
|                          |
|     python -c 'print "Th |
| is line prints from an e |
| mbedded Python script.\n |
| ";'                      |
|     # Unlike sed and per |
| l, Python uses the "-c"  |
| option.                  |
|     python -c 'k = raw_i |
| nput( "Hit a key to exit |
|  to outer script. " )'   |
|                          |
|     echo "============== |
| ======================== |
| ======================== |
| ="                       |
|     echo "However, the s |
| cript may also contain s |
| hell and system commands |
| ."                       |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Wrapping a script around *mplayer* and the Google's translation server,
you can create something that talks back to you.

.. raw:: html

   <div class="EXAMPLE">

**Example 36-9. A script that speaks**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     #   Courtesy of:     |
|     #   http://elinux.or |
| g/RPi_Text_to_Speech_(Sp |
| eech_Synthesis)          |
|                          |
|     #  You must be on-li |
| ne for this script to wo |
| rk,                      |
|     #+ so you can access |
|  the Google translation  |
| server.                  |
|     #  Of course, mplaye |
| r must be present on you |
| r computer.              |
|                          |
|     speak()              |
|       {                  |
|       local IFS=+        |
|       # Invoke mplayer,  |
| then connect to Google t |
| ranslation server.       |
|       /usr/bin/mplayer - |
| ao alsa -really-quiet -n |
| oconsolecontrols \       |
|      "http://translate.g |
| oogle.com/translate_tts? |
| tl=en&q="$*""            |
|       # Google translate |
| s, but can also speak.   |
|       }                  |
|                          |
|     LINES=4              |
|                          |
|     spk=$(tail -$LINES $ |
| 0) # Tail end of same sc |
| ript!                    |
|     speak "$spk"         |
|     exit                 |
|     # Browns. Nice talki |
| ng to you.               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

One interesting example of a complex shell wrapper is Martin Matusiak's
`*undvd* script <http://sourceforge.net/projects/undvd/>`__ , which
provides an easy-to-use command-line interface to the complex
`mencoder <http://www.mplayerhq.hu/DOCS/HTML/en/mencoder.html>`__
utility. Another example is Itzchak Rehberg's
`Ext3Undel <http://projects.izzysoft.de/trac/ext3undel>`__ , a set of
scripts to recover deleted file on an *ext3* filesystem.

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <wrapper.html#AEN20130>`__    |
| Quite a number of Linux utilities    |
| are, in fact, shell wrappers. Some   |
| examples are                         |
| ``        /usr/bin/pdf2ps       `` , |
| ``        /usr/bin/batch       `` ,  |
| and                                  |
| ``        /usr/bin/xmkmf       `` .  |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <intandnonint.html | Interactive and          |
| >`__                     | non-interactive shells   |
| `Home <index.html>`__    | and scripts              |
| `Next <testsandcompariso | `Up <miscellany.html>`__ |
| ns.html>`__              | Tests and Comparisons:   |
|                          | Alternatives             |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

