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

`Prev <x23170.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Appendix C. A Sed and Awk Micro-Primer

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <pathmanagement.html>`__

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

  C.2. Awk
=========

*Awk* ` [1]  <awk.html#FTN.AEN23443>`__ is a full-featured text
processing language with a syntax reminiscent of *C* . While it
possesses an extensive set of operators and capabilities, we will cover
only a few of these here - the ones most useful in shell scripts.

Awk breaks each line of input passed to it into
`fields <special-chars.html#FIELDREF>`__ . By default, a field is a
string of consecutive characters delimited by
`whitespace <special-chars.html#WHITESPACEREF>`__ , though there are
options for changing this. Awk parses and operates on each separate
field. This makes it ideal for handling structured text files --
especially tables -- data organized into consistent chunks, such as rows
and columns.

`Strong quoting <varsubn.html#SNGLQUO>`__ and `curly
brackets <special-chars.html#CODEBLOCKREF>`__ enclose blocks of awk code
within a shell script.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # $1 is field #1, $2 |
|  is field #2, etc.       |
|                          |
|     echo one two | awk ' |
| {print $1}'              |
|     # one                |
|                          |
|     echo one two | awk ' |
| {print $2}'              |
|     # two                |
|                          |
|     # But what is field  |
| #0 ($0)?                 |
|     echo one two | awk ' |
| {print $0}'              |
|     # one two            |
|     # All the fields!    |
|                          |
|                          |
|     awk '{print $3}' $fi |
| lename                   |
|     # Prints field #3 of |
|  file $filename to stdou |
| t.                       |
|                          |
|     awk '{print $1 $5 $6 |
| }' $filename             |
|     # Prints fields #1,  |
| #5, and #6 of file $file |
| name.                    |
|                          |
|     awk '{print $0}' $fi |
| lename                   |
|     # Prints the entire  |
| file!                    |
|     # Same effect as:    |
| cat $filename . . . or . |
|  . . sed '' $filename    |
                          
+--------------------------+--------------------------+--------------------------+

We have just seen the awk *print* command in action. The only other
feature of awk we need to deal with here is variables. Awk handles
variables similarly to shell scripts, though a bit more flexibly.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     { total += ${column_ |
| number} }                |
                          
+--------------------------+--------------------------+--------------------------+

This adds the value of ``           column_number         `` to the
running total of ``           total         `` >. Finally, to print
"total" , there is an **END** command block, executed after the script
has processed all its input.
+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     END { print total }  |
                          
+--------------------------+--------------------------+--------------------------+

Corresponding to the **END** , there is a **BEGIN** , for a code block
to be performed before awk starts processing its input.

The following example illustrates how **awk** can add text-parsing tools
to a shell script.

.. raw:: html

   <div class="EXAMPLE">

**Example C-1. Counting Letter Occurrences**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/sh           |
|     # letter-count2.sh:  |
| Counting letter occurren |
| ces in a text file.      |
|     #                    |
|     # Script by nyal [ny |
| al@voila.fr].            |
|     # Used in ABS Guide  |
| with permission.         |
|     # Recommented and re |
| formatted by ABS Guide a |
| uthor.                   |
|     # Version 1.1: Modif |
| ied to work with gawk 3. |
| 1.3.                     |
|     #              (Will |
|  still work with earlier |
|  versions.)              |
|                          |
|                          |
|     INIT_TAB_AWK=""      |
|     # Parameter to initi |
| alize awk script.        |
|     count_case=0         |
|     FILE_PARSE=$1        |
|                          |
|     E_PARAMERR=85        |
|                          |
|     usage()              |
|     {                    |
|         echo "Usage: let |
| ter-count.sh file letter |
| s" 2>&1                  |
|         # For example:   |
|  ./letter-count2.sh file |
| name.txt a b c           |
|         exit $E_PARAMERR |
|   # Too few arguments pa |
| ssed to script.          |
|     }                    |
|                          |
|     if [ ! -f "$1" ] ; t |
| hen                      |
|         echo "$1: No suc |
| h file." 2>&1            |
|         usage            |
|       # Print usage mess |
| age and exit.            |
|     fi                   |
|                          |
|     if [ -z "$2" ] ; the |
| n                        |
|         echo "$2: No let |
| ters specified." 2>&1    |
|         usage            |
|     fi                   |
|                          |
|     shift                |
|        # Letters specifi |
| ed.                      |
|     for letter in `echo  |
| $@`    # For each one .  |
| . .                      |
|       do                 |
|       INIT_TAB_AWK="$INI |
| T_TAB_AWK tab_search[${c |
| ount_case}] = \          |
|       \"$letter\"; final |
| _tab[${count_case}] = 0; |
|  "                       |
|       # Pass as paramete |
| r to awk script below.   |
|       count_case=`expr $ |
| count_case + 1`          |
|     done                 |
|                          |
|     # DEBUG:             |
|     # echo $INIT_TAB_AWK |
| ;                        |
|                          |
|     cat $FILE_PARSE |    |
|     # Pipe the target fi |
| le to the following awk  |
| script.                  |
|                          |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| ---                      |
|     # Earlier version of |
|  script:                 |
|     # awk -v tab_search= |
| 0 -v final_tab=0 -v tab= |
| 0 -v \                   |
|     # nb_letter=0 -v cha |
| ra=0 -v chara2=0 \       |
|                          |
|     awk \                |
|     "BEGIN { $INIT_TAB_A |
| WK } \                   |
|     { split(\$0, tab, \" |
| \"); \                   |
|     for (chara in tab) \ |
|     { for (chara2 in tab |
| _search) \               |
|     { if (tab_search[cha |
| ra2] == tab[chara]) { fi |
| nal_tab[chara2]++ } } }  |
| } \                      |
|     END { for (chara in  |
| final_tab) \             |
|     { print tab_search[c |
| hara] \" => \" final_tab |
| [chara] } }"             |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| ---                      |
|     #  Nothing all that  |
| complicated, just . . .  |
|     #+ for-loops, if-tes |
| ts, and a couple of spec |
| ialized functions.       |
|                          |
|     exit $?              |
|                          |
|     # Compare this scrip |
| t to letter-count.sh.    |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

For simpler examples of awk within shell scripts, see:

#. `Example 15-14 <internal.html#EX44>`__

#. `Example 20-8 <redircb.html#REDIR4>`__

#. `Example 16-32 <filearchiv.html#STRIPC>`__

#. `Example 36-5 <wrapper.html#COLTOTALER>`__

#. `Example 28-2 <ivr.html#COLTOTALER2>`__

#. `Example 15-20 <internal.html#COLTOTALER3>`__

#. `Example 29-3 <procref1.html#PIDID>`__

#. `Example 29-4 <procref1.html#CONSTAT>`__

#. `Example 11-3 <loops1.html#FILEINFO>`__

#. `Example 16-61 <extmisc.html#BLOTOUT>`__

#. `Example 9-16 <randomvar.html#SEEDINGRANDOM>`__

#. `Example 16-4 <moreadv.html#IDELETE>`__

#. `Example 10-6 <string-manipulation.html#SUBSTRINGEX>`__

#. `Example 36-19 <assortedtips.html#SUMPRODUCT>`__

#. `Example 11-9 <loops1.html#USERLIST>`__

#. `Example 36-4 <wrapper.html#PRASC>`__

#. `Example 16-53 <mathc.html#HYPOT>`__

#. `Example T-3 <asciitable.html#ASCII3SH>`__

That's all the awk we'll cover here, folks, but there's lots more to
learn. See the appropriate references in the
`*Bibliography* <biblio.html>`__ .

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <awk.html#AEN23443>`__        |
| Its name derives from the initials   |
| of its authors, **A** ho, **W**      |
| einberg, and **K** ernighan.         |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <x23170.html>`__   | Sed                      |
| `Home <index.html>`__    | `Up <sedawk.html>`__     |
| `Next <pathmanagement.ht | Parsing and Managing     |
| ml>`__                   | Pathnames                |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

