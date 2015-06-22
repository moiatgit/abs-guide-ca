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

`Prev <quoting.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 5. Quoting

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <escapingsection.html>`__

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

5.1. Quoting Variables
======================

When referencing a variable, it is generally advisable to enclose its
name in double quotes. This prevents reinterpretation of all special
characters within the quoted string -- except $, \` (backquote), and \\
(escape). `[1] <quotingvar.html#FTN.AEN2630>`__ Keeping $ as a special
character within double quotes permits referencing a quoted variable
(``"$variable"``), that is, replacing the variable with its value (see
`Example 4-1 <varsubn.html#EX9>`__, above).

Use double quotes to prevent word splitting.
`[2] <quotingvar.html#FTN.AEN2688>`__ An argument enclosed in double
quotes presents itself as a single word, even if it contains
`whitespace <special-chars.html#WHITESPACEREF>`__ separators.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     List="one two three" |
|                          |
|     for a in $List     # |
|  Splits the variable in  |
| parts at whitespace.     |
|     do                   |
|       echo "$a"          |
|     done                 |
|     # one                |
|     # two                |
|     # three              |
|                          |
|     echo "---"           |
|                          |
|     for a in "$List"   # |
|  Preserves whitespace in |
|  a single variable.      |
|     do #     ^     ^     |
|       echo "$a"          |
|     done                 |
|     # one two three      |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

A more elaborate example:

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     variable1="a variabl |
| e containing five words" |
|     COMMAND This is $var |
| iable1    # Executes COM |
| MAND with 7 arguments:   |
|     # "This" "is" "a" "v |
| ariable" "containing" "f |
| ive" "words"             |
|                          |
|     COMMAND "This is $va |
| riable1"  # Executes COM |
| MAND with 1 argument:    |
|     # "This is a variabl |
| e containing five words" |
|                          |
|                          |
|     variable2=""    # Em |
| pty.                     |
|                          |
|     COMMAND $variable2 $ |
| variable2 $variable2     |
|                     # Ex |
| ecutes COMMAND with no a |
| rguments.                |
|     COMMAND "$variable2" |
|  "$variable2" "$variable |
| 2"                       |
|                     # Ex |
| ecutes COMMAND with 3 em |
| pty arguments.           |
|     COMMAND "$variable2  |
| $variable2 $variable2"   |
|                     # Ex |
| ecutes COMMAND with 1 ar |
| gument (2 spaces).       |
|                          |
|     # Thanks, Stéphane C |
| hazelas.                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="TIP">

+--------------------------------------+--------------------------------------+
| |Tip|                                |
| Enclosing the arguments to an        |
| **echo** statement in double quotes  |
| is necessary only when word          |
| splitting or preservation of         |
| `whitespace <special-chars.html#WHIT |
| ESPACEREF>`__                        |
| is an issue.                         |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 5-1. Echoing Weird Variables**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # weirdvars.sh: Echo |
| ing weird variables.     |
|                          |
|     echo                 |
|                          |
|     var="'(]\\{}\$\""    |
|     echo $var        # ' |
| (]\{}$"                  |
|     echo "$var"      # ' |
| (]\{}$"     Doesn't make |
|  a difference.           |
|                          |
|     echo                 |
|                          |
|     IFS='\'              |
|     echo $var        # ' |
| (] {}$"     \ converted  |
| to space. Why?           |
|     echo "$var"      # ' |
| (]\{}$"                  |
|                          |
|     # Examples above sup |
| plied by Stephane Chazel |
| as.                      |
|                          |
|     echo                 |
|                          |
|     var2="\\\\\""        |
|     echo $var2       #   |
|  "                       |
|     echo "$var2"     # \ |
| \"                       |
|     echo                 |
|     # But ... var2="\\\\ |
| "" is illegal. Why?      |
|     var3='\\\\'          |
|     echo "$var3"     # \ |
| \\\                      |
|     # Strong quoting wor |
| ks, though.              |
|                          |
|                          |
|     # ****************** |
| ************************ |
| ****************** #     |
|     # As the first examp |
| le above shows, nesting  |
| quotes is permitted.     |
|                          |
|     echo "$(echo '"')"   |
|          # "             |
|     #    ^           ^   |
|                          |
|                          |
|     # At times this come |
| s in useful.             |
|                          |
|     var1="Two bits"      |
|     echo "\$var1 = "$var |
| 1""      # $var1 = Two b |
| its                      |
|     #    ^               |
|   ^                      |
|                          |
|     # Or, as Chris Hiest |
| and points out ...       |
|                          |
|     if [[ "$(du "$My_Fil |
| e1")" -gt "$(du "$My_Fil |
| e2")" ]]                 |
|     #     ^     ^        |
|   ^ ^     ^     ^        |
|   ^ ^                    |
|     then                 |
|       ...                |
|     fi                   |
|     # ****************** |
| ************************ |
| ****************** #     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Single quotes (' ') operate similarly to double quotes, but do not
permit referencing variables, since the special meaning of $ is turned
off. Within single quotes, *every* special character except ' gets
interpreted literally. Consider single quotes ("full quoting") to be a
stricter method of quoting than double quotes ("partial quoting").

.. raw:: html

   <div class="NOTE">

+--------------------+--------------------+--------------------+--------------------+
| |Note|             |
| Since even the     |
| escape character   |
| (\\) gets a        |
| literal            |
| interpretation     |
| within single      |
| quotes, trying to  |
| enclose a single   |
| quote within       |
| single quotes will |
| not yield the      |
| expected result.   |
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
| |     echo "Why ca |
| n't I wr |         |
| | ite 's between s |
| ingle qu |         |
| | otes"            |
|          |         |
| |                  |
|          |         |
| |     echo         |
|          |         |
| |                  |
|          |         |
| |     # The rounda |
| bout met |         |
| | hod.             |
|          |         |
| |     echo 'Why ca |
| n'\''t I |         |
| |  write '"'"'s be |
| tween si |         |
| | ngle quotes'     |
|          |         |
| |     #    |------ |
| -|  |--- |         |
| | -------|   |---- |
| -------- |         |
| | -----------|     |
|          |         |
| |     # Three sing |
| le-quote |         |
| | d strings, with  |
| escaped  |         |
| | and quoted singl |
| e quotes |         |
| |  between.        |
|          |         |
| |                  |
|          |         |
| |     # This examp |
| le court |         |
| | esy of Stéphane  |
| Chazelas |         |
| | .                |
|          |         |
|                    |
|                    |
| +----------------- |
| ---------+-------- |
| ------------------ |
| +----------------- |
| ---------+         |
|                    |
| .. raw:: html      |
|                    |
|    </p>            |
                    
+--------------------+--------------------+--------------------+--------------------+

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

`[1] <quotingvar.html#AEN2630>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Encapsulating "!" within double quotes gives an error when used *from
the command line*. This is interpreted as a `history
command <histcommands.html>`__. Within a script, though, this problem
does not occur, since the Bash history mechanism is disabled then.

Of more concern is the *apparently* inconsistent behavior of ``\``
within double quotes, and especially following an **echo -e** command.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ echo hello\!   |
|     hello!               |
|     bash$ echo "hello\!" |
|     hello\!              |
|                          |
|                          |
|     bash$ echo \         |
|     >                    |
|     bash$ echo "\"       |
|     >                    |
|     bash$ echo \a        |
|     a                    |
|     bash$ echo "\a"      |
|     \a                   |
|                          |
|                          |
|     bash$ echo x\ty      |
|     xty                  |
|     bash$ echo "x\ty"    |
|     x\ty                 |
|                          |
|     bash$ echo -e x\ty   |
|     xty                  |
|     bash$ echo -e "x\ty" |
|     x       y            |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

Double quotes following an *echo* *sometimes* escape ``\``. Moreover,
the ``-e`` option to *echo* causes the "\\t" to be interpreted as a
*tab*.

(Thank you, Wayne Pollock, for pointing this out, and Geoff Lee and
Daniel Barclay for explaining it.)

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[2] <quotingvar.html#AEN2688>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

"Word splitting," in this context, means dividing a character string
into separate and discrete arguments.

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
| `Prev <quoting.html>`__  | Quoting                  |
| `Home <index.html>`__    | `Up <quoting.html>`__    |
| `Next <escapingsection.h | Escaping                 |
| tml>`__                  |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Tip| image:: ../images/tip.gif
.. |Note| image:: ../images/note.gif
