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

`Prev <exercises.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Appendix O. Exercises

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <writingscripts.html>`__

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

O.1. Analyzing Scripts
======================

Examine the following script. Run it, then explain what it does.
Annotate the script and rewrite it in a more compact and elegant manner.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     MAX=10000            |
|                          |
|                          |
|       for((nr=1; nr<$MAX |
| ; nr++))                 |
|       do                 |
|                          |
|         let "t1 = nr % 5 |
| "                        |
|         if [ "$t1" -ne 3 |
|  ]                       |
|         then             |
|           continue       |
|         fi               |
|                          |
|         let "t2 = nr % 7 |
| "                        |
|         if [ "$t2" -ne 4 |
|  ]                       |
|         then             |
|           continue       |
|         fi               |
|                          |
|         let "t3 = nr % 9 |
| "                        |
|         if [ "$t3" -ne 5 |
|  ]                       |
|         then             |
|           continue       |
|         fi               |
|                          |
|       break   # What hap |
| pens when you comment ou |
| t this line? Why?        |
|                          |
|       done               |
|                          |
|       echo "Number = $nr |
| "                        |
|                          |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

---

Explain what the following script does. It is really just a
parameterized command-line pipe.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     DIRNAME=/usr/bin     |
|     FILETYPE="shell scri |
| pt"                      |
|     LOGFILE=logfile      |
|                          |
|     file "$DIRNAME"/* |  |
| fgrep "$FILETYPE" | tee  |
| $LOGFILE | wc -l         |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

---

Examine and explain the following script. For hints, you might refer to
the listings for `find <moreadv.html#FINDREF>`__ and
`stat <system.html#STATREF>`__.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # Author:  Nathan Co |
| ulter                    |
|     # This code is relea |
| sed to the public domain |
| .                        |
|     # The author gave pe |
| rmission to use this cod |
| e snippet in the ABS Gui |
| de.                      |
|                          |
|     find -maxdepth 1 -ty |
| pe f -printf '%f\000'  | |
|  {                       |
|        while read -d $'\ |
| 000'; do                 |
|           mv "$REPLY" "$ |
| (date -d "$(stat -c '%y' |
|  "$REPLY") " '+%Y%m%d%H% |
| M%S'                     |
|           )-$REPLY"      |
|        done              |
|     }                    |
|                          |
|     # Warning: Test-driv |
| e this script in a "scra |
| tch" directory.          |
|     # It will somehow af |
| fect all the files there |
| .                        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

---

A reader sent in the following code snippet.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     while read LINE      |
|     do                   |
|       echo $LINE         |
|     done < `tail -f /var |
| /log/messages`           |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

He wished to write a script tracking changes to the system log file,
``/var/log/messages``. Unfortunately, the above code block hangs and
does nothing useful. Why? Fix this so it does work. (Hint: rather than
`redirecting the ``stdin`` of the loop <redircb.html#REDIRREF>`__, try a
`pipe <special-chars.html#PIPEREF>`__.)

---

Analyze the following "one-liner" (here split into two lines for
clarity) contributed by Rory Winston:

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     export SUM=0; for f  |
| in $(find src -name "*.j |
| ava");                   |
|     do export SUM=$(($SU |
| M + $(wc -l $f | awk '{  |
| print $1 }'))); done; ec |
| ho $SUM                  |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

Hint: First, break the script up into bite-sized sections. Then,
carefully examine its use of `double-parentheses <dblparens.html>`__
arithmetic, the `export <internal.html#EXPORTREF>`__ command, the
`find <moreadv.html#FINDREF>`__ command, the
`wc <textproc.html#WCREF>`__ command, and `awk <awk.html#AWKREF>`__.

---

Analyze `Example A-10 <contributed-scripts.html#LIFESLOW>`__, and
reorganize it in a simplified and more logical style. See how many of
the variables can be eliminated, and try to optimize the script to speed
up its execution time.

Alter the script so that it accepts any ordinary ASCII text file as
input for its initial "generation". The script will read the first
``$ROW*$COL`` characters, and set the occurrences of vowels as "living"
cells. Hint: be sure to translate the spaces in the input file to
underscore characters.

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <exercises.html>`_ | Exercises                |
| _                        | `Up <exercises.html>`__  |
| `Home <index.html>`__    | Writing Scripts          |
| `Next <writingscripts.ht |                          |
| ml>`__                   |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

