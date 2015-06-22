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

`Prev <quotingvar.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 5. Quoting

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <exit-status.html>`__

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

  5.2. Escaping
==============

 *Escaping* is a method of quoting single characters. The escape ( \\ )
preceding a character tells the shell to interpret that character
literally.

.. raw:: html

   <div class="CAUTION">

+--------------------------------------+--------------------------------------+
| |Caution|                            |
| With certain commands and utilities, |
| such as                              |
| `echo <internal.html#ECHOREF>`__ and |
| `sed <sedawk.html#SEDREF>`__ ,       |
| escaping a character may have the    |
| opposite effect - it can toggle on a |
| special meaning for that character.  |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Special meanings of certain escaped characters**

 used with **echo** and **sed**
 \\n
    means newline

 \\r
    means return

 \\t
    means tab

 \\v
    means vertical tab

 \\b
    means backspace

 \\a
    means *alert* (beep or flash)

 \\0xx
     translates to the octal `ASCII <special-chars.html#ASCIIDEF>`__
    equivalent of ``                   0nn                 `` , where
    ``                   nn                 `` is a string of digits

    .. raw:: html

       <div class="IMPORTANT">

    +--------------------------+--------------------------+--------------------------+
    | |Important|              |
    |                          |
    | The                      |
    | ``                       |
    |      $' ... '            |
    |               ``         |
    | `quoted <quoting.html#QU |
    | OTINGREF>`__             |
    | string-expansion         |
    | construct is a mechanism |
    | that uses escaped octal  |
    | or hex values to assign  |
    | ASCII characters to      |
    | variables, e.g.,         |
    | **quote=$'\\042'** .     |
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 5-2. Escaped Characters**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # escaped.sh: escape |
    | d characters             |
    |                          |
    |     #################### |
    | ######################## |
    | #################        |
    |     ### First, let's sho |
    | w some basic escaped-cha |
    | racter usage. ###        |
    |     #################### |
    | ######################## |
    | #################        |
    |                          |
    |     # Escaping a newline |
    | .                        |
    |     # ------------------ |
    |                          |
    |     echo ""              |
    |                          |
    |     echo "This will prin |
    | t                        |
    |     as two lines."       |
    |     # This will print    |
    |     # as two lines.      |
    |                          |
    |     echo "This will prin |
    | t \                      |
    |     as one line."        |
    |     # This will print as |
    |  one line.               |
    |                          |
    |     echo; echo           |
    |                          |
    |     echo "=============" |
    |                          |
    |                          |
    |     echo "\v\v\v\v"      |
    |  # Prints \v\v\v\v liter |
    | ally.                    |
    |     # Use the -e option  |
    | with 'echo' to print esc |
    | aped characters.         |
    |     echo "=============" |
    |     echo "VERTICAL TABS" |
    |     echo -e "\v\v\v\v"   |
    |  # Prints 4 vertical tab |
    | s.                       |
    |     echo "============== |
    | "                        |
    |                          |
    |     echo "QUOTATION MARK |
    | "                        |
    |     echo -e "\042"       |
    |  # Prints " (quote, octa |
    | l ASCII character 42).   |
    |     echo "============== |
    | "                        |
    |                          |
    |                          |
    |                          |
    |     # The $'\X' construc |
    | t makes the -e option un |
    | necessary.               |
    |                          |
    |     echo; echo "NEWLINE  |
    | and (maybe) BEEP"        |
    |     echo $'\n'           |
    |  # Newline.              |
    |     echo $'\a'           |
    |  # Alert (beep).         |
    |                          |
    |  # May only flash, not b |
    | eep, depending on termin |
    | al.                      |
    |                          |
    |     # We have seen $'\nn |
    | n" string expansion, and |
    |  now . . .               |
    |                          |
    |     # ================== |
    | ======================== |
    | ======================== |
    | = #                      |
    |     # Version 2 of Bash  |
    | introduced the $'\nnn' s |
    | tring expansion construc |
    | t.                       |
    |     # ================== |
    | ======================== |
    | ======================== |
    | = #                      |
    |                          |
    |     echo "Introducing th |
    | e \$\' ... \' string-exp |
    | ansion construct . . . " |
    |     echo ". . . featurin |
    | g more quotation marks." |
    |                          |
    |     echo $'\t \042 \t'   |
    |  # Quote (") framed by t |
    | abs.                     |
    |     # Note that  '\nnn'  |
    | is an octal value.       |
    |                          |
    |     # It also works with |
    |  hexadecimal values, in  |
    | an $'\xhhh' construct.   |
    |     echo $'\t \x22 \t'   |
    | # Quote (") framed by ta |
    | bs.                      |
    |     # Thank you, Greg Ke |
    | raunen, for pointing thi |
    | s out.                   |
    |     # Earlier Bash versi |
    | ons allowed '\x022'.     |
    |                          |
    |     echo                 |
    |                          |
    |                          |
    |     # Assigning ASCII ch |
    | aracters to a variable.  |
    |     # ------------------ |
    | ----------------------   |
    |     quote=$'\042'        |
    |  # " assigned to a varia |
    | ble.                     |
    |     echo "$quote Quoted  |
    | string $quote and this l |
    | ies outside the quotes." |
    |                          |
    |     echo                 |
    |                          |
    |     # Concatenating ASCI |
    | I chars in a variable.   |
    |     triple_underline=$'\ |
    | 137\137\137'  # 137 is o |
    | ctal ASCII code for '_'. |
    |     echo "$triple_underl |
    | ine UNDERLINE $triple_un |
    | derline"                 |
    |                          |
    |     echo                 |
    |                          |
    |     ABC=$'\101\102\103\0 |
    | 10'           # 101, 102 |
    | , 103 are octal A, B, C. |
    |     echo $ABC            |
    |                          |
    |     echo                 |
    |                          |
    |     escape=$'\033'       |
    |               # 033 is o |
    | ctal for escape.         |
    |     echo "\"escape\" ech |
    | oes as $escape"          |
    |     #                    |
    |                 no visib |
    | le output.               |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    A more elaborate example:

    .. raw:: html

       <div class="EXAMPLE">

    **Example 5-3. Detecting key-presses**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Author: Sigurd Sol |
    | aas, 20 Apr 2011         |
    |     # Used in ABS Guide  |
    | with permission.         |
    |     # Requires version 4 |
    | .2+ of Bash.             |
    |                          |
    |     key="no value yet"   |
    |     while true; do       |
    |       clear              |
    |       echo "Bash Extra K |
    | eys Demo. Keys to try:"  |
    |       echo               |
    |       echo "* Insert, De |
    | lete, Home, End, Page_Up |
    |  and Page_Down"          |
    |       echo "* The four a |
    | rrow keys"               |
    |       echo "* Tab, enter |
    | , escape, and space key" |
    |       echo "* The letter |
    |  and number keys, etc."  |
    |       echo               |
    |       echo "    d = show |
    |  date/time"              |
    |       echo "    q = quit |
    | "                        |
    |       echo "============ |
    | ===================="    |
    |       echo               |
    |                          |
    |      # Convert the separ |
    | ate home-key to home-key |
    | _num_7:                  |
    |      if [ "$key" = $'\x1 |
    | b\x4f\x48' ]; then       |
    |       key=$'\x1b\x5b\x31 |
    | \x7e'                    |
    |       #   Quoted string- |
    | expansion construct.     |
    |      fi                  |
    |                          |
    |      # Convert the separ |
    | ate end-key to end-key_n |
    | um_1.                    |
    |      if [ "$key" = $'\x1 |
    | b\x4f\x46' ]; then       |
    |       key=$'\x1b\x5b\x34 |
    | \x7e'                    |
    |      fi                  |
    |                          |
    |      case "$key" in      |
    |       $'\x1b\x5b\x32\x7e |
    | ')  # Insert             |
    |        echo Insert Key   |
    |       ;;                 |
    |       $'\x1b\x5b\x33\x7e |
    | ')  # Delete             |
    |        echo Delete Key   |
    |       ;;                 |
    |       $'\x1b\x5b\x31\x7e |
    | ')  # Home_key_num_7     |
    |        echo Home Key     |
    |       ;;                 |
    |       $'\x1b\x5b\x34\x7e |
    | ')  # End_key_num_1      |
    |        echo End Key      |
    |       ;;                 |
    |       $'\x1b\x5b\x35\x7e |
    | ')  # Page_Up            |
    |        echo Page_Up      |
    |       ;;                 |
    |       $'\x1b\x5b\x36\x7e |
    | ')  # Page_Down          |
    |        echo Page_Down    |
    |       ;;                 |
    |       $'\x1b\x5b\x41')   |
    | # Up_arrow               |
    |        echo Up arrow     |
    |       ;;                 |
    |       $'\x1b\x5b\x42')   |
    | # Down_arrow             |
    |        echo Down arrow   |
    |       ;;                 |
    |       $'\x1b\x5b\x43')   |
    | # Right_arrow            |
    |        echo Right arrow  |
    |       ;;                 |
    |       $'\x1b\x5b\x44')   |
    | # Left_arrow             |
    |        echo Left arrow   |
    |       ;;                 |
    |       $'\x09')  # Tab    |
    |        echo Tab Key      |
    |       ;;                 |
    |       $'\x0a')  # Enter  |
    |        echo Enter Key    |
    |       ;;                 |
    |       $'\x1b')  # Escape |
    |        echo Escape Key   |
    |       ;;                 |
    |       $'\x20')  # Space  |
    |        echo Space Key    |
    |       ;;                 |
    |       d)                 |
    |        date              |
    |       ;;                 |
    |       q)                 |
    |       echo Time to quit. |
    | ..                       |
    |       echo               |
    |       exit 0             |
    |       ;;                 |
    |       *)                 |
    |        echo You pressed: |
    |  \'"$key"\'              |
    |       ;;                 |
    |      esac                |
    |                          |
    |      echo                |
    |      echo "============= |
    | ==================="     |
    |                          |
    |      unset K1 K2 K3      |
    |      read -s -N1 -p "Pre |
    | ss a key: "              |
    |      K1="$REPLY"         |
    |      read -s -N2 -t 0.00 |
    | 1                        |
    |      K2="$REPLY"         |
    |      read -s -N1 -t 0.00 |
    | 1                        |
    |      K3="$REPLY"         |
    |      key="$K1$K2$K3"     |
    |                          |
    |     done                 |
    |                          |
    |     exit $?              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example 37-1 <bashver2.html#EX77>`__ .

 \\"
    gives the quote its literal meaning

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo "Hello"         |
    |              # Hello     |
    |     echo "\"Hello\" ...  |
    | he said."    # "Hello" . |
    | .. he said.              |
                              
    +--------------------------+--------------------------+--------------------------+

 \\$
    gives the dollar sign its literal meaning (variable name following
    \\$ will not be referenced)

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo "\$variable01"  |
    |           # $variable01  |
    |     echo "The book cost  |
    | \$7.98."  # The book cos |
    | t $7.98.                 |
                              
    +--------------------------+--------------------------+--------------------------+

 \\\\
    gives the backslash its literal meaning

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo "\\"  # Results |
    |  in \                    |
    |                          |
    |     # Whereas . . .      |
    |                          |
    |     echo "\"   # Invokes |
    |  secondary prompt from t |
    | he command-line.         |
    |                # In a sc |
    | ript, gives an error mes |
    | sage.                    |
    |                          |
    |     # However . . .      |
    |                          |
    |     echo '\'   # Results |
    |  in \                    |
                              
    +--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="NOTE">

+----------------+----------------+----------------+----------------+----------------+
| |Note|         |
| The behavior   |
| of \\ depends  |
| on whether it  |
| is escaped,    |
| `strong-quoted |
|  <varsubn.html |
| #SNGLQUO>`__   |
| ,              |
| `weak-quoted < |
| varsubn.html#D |
| BLQUO>`__      |
| , or appearing |
| within         |
| `command       |
| substitution < |
| commandsub.htm |
| l#COMMANDSUBRE |
| F>`__          |
| or a `here     |
| document <here |
| -docs.html#HER |
| EDOCREF>`__    |
| .              |
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
| |              |
|              | |
| |   #  Simple  |
| escaping and | |
| |  quoting     |
|              | |
| |     echo \z  |
|              | |
| |   #  z       |
|              | |
| |     echo \\z |
|              | |
| |   # \z       |
|              | |
| |     echo '\z |
| '            | |
| |   # \z       |
|              | |
| |     echo '\\ |
| z'           | |
| |   # \\z      |
|              | |
| |     echo "\z |
| "            | |
| |   # \z       |
|              | |
| |     echo "\\ |
| z"           | |
| |   # \z       |
|              | |
| |              |
|              | |
| |              |
|              | |
| |   #  Command |
|  substitutio | |
| | n            |
|              | |
| |     echo `ec |
| ho \z`       | |
| |   #  z       |
|              | |
| |     echo `ec |
| ho \\z`      | |
| |   #  z       |
|              | |
| |     echo `ec |
| ho \\\z`     | |
| |   # \z       |
|              | |
| |     echo `ec |
| ho \\\\z`    | |
| |   # \z       |
|              | |
| |     echo `ec |
| ho \\\\\\z`  | |
| |   # \z       |
|              | |
| |     echo `ec |
| ho \\\\\\\z` | |
| |   # \\z      |
|              | |
| |     echo `ec |
| ho "\z"`     | |
| |   # \z       |
|              | |
| |     echo `ec |
| ho "\\z"`    | |
| |   # \z       |
|              | |
| |              |
|              | |
| |              |
|              | |
| |   # Here doc |
| ument        | |
| |     cat <<EO |
| F            | |
| |              |
|              | |
| |     \z       |
|              | |
| |              |
|              | |
| |     EOF      |
|              | |
| |   # \z       |
|              | |
| |              |
|              | |
| |     cat <<EO |
| F            | |
| |              |
|              | |
| |     \\z      |
|              | |
| |              |
|              | |
| |     EOF      |
|              | |
| |   # \z       |
|              | |
| |              |
|              | |
| |     # These  |
| examples sup | |
| | plied by Sté |
| phane Chazel | |
| | as.          |
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
| Elements of a  |
| string         |
| assigned to a  |
| variable may   |
| be escaped,    |
| but the escape |
| character      |
| alone may not  |
| be assigned to |
| a variable.    |
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
| |     variable |
| =\           | |
| |     echo "$v |
| ariable"     | |
| |     # Will n |
| ot work - gi | |
| | ves an error |
|  message:    | |
| |     # test.s |
| h: : command | |
| |  not found   |
|              | |
| |     # A "nak |
| ed" escape c | |
| | annot safely |
|  be assigned | |
| |  to a variab |
| le.          | |
| |     #        |
|              | |
| |     #  What  |
| actually hap | |
| | pens here is |
|  that the "\ | |
| | " escapes th |
| e newline an | |
| | d            |
|              | |
| |     #+ the e |
| ffect is     | |
| |     variable |
| =echo "$vari | |
| | able"        |
|              | |
| |     #+       |
|              | |
| |     invalid  |
| variable ass | |
| | ignment      |
|              | |
| |              |
|              | |
| |     variable |
| =\           | |
| |     23skidoo |
|              | |
| |     echo "$v |
| ariable"     | |
| |     #  23ski |
| doo          | |
| |              |
|              | |
| |     #  This  |
| works, since | |
| |  the second  |
| line         | |
| |              |
|              | |
| |     #+ is a  |
| valid variab | |
| | le assignmen |
| t.           | |
| |              |
|              | |
| |     variable |
| =\           | |
| |     #        |
|  \^    escap | |
| | e followed b |
| y space      | |
| |     echo "$v |
| ariable"     | |
| |     # space  |
|              | |
| |              |
|              | |
| |     variable |
| =\\          | |
| |     echo "$v |
| ariable"     | |
| |     # \      |
|              | |
| |              |
|              | |
| |     variable |
| =\\\         | |
| |     echo "$v |
| ariable"     | |
| |     # Will n |
| ot work - gi | |
| | ves an error |
|  message:    | |
| |     # test.s |
| h: \: comman | |
| | d not found  |
|              | |
| |     #        |
|              | |
| |     #  First |
|  escape esca | |
| | pes second o |
| ne, but the  | |
| | third one is |
|  left "naked | |
| | ",           |
|              | |
| |     #+ with  |
| same result  | |
| | as first ins |
| tance, above | |
| | .            |
|              | |
| |              |
|              | |
| |     variable |
| =\\\\        | |
| |     echo "$v |
| ariable"     | |
| |     # \\     |
|              | |
| |              |
|              | |
| |     # Second |
|  and fourth  | |
| | escapes esca |
| ped.         | |
| |              |
|              | |
| |     # This i |
| s o.k.       | |
|                |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
                
+----------------+----------------+----------------+----------------+----------------+

.. raw:: html

   </div>

Escaping a space can prevent word splitting in a command's argument
list.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     file_list="/bin/cat  |
| /bin/gzip /bin/more /usr |
| /bin/less /usr/bin/emacs |
| -20.7"                   |
|     # List of files as a |
| rgument(s) to a command. |
|                          |
|     # Add two files to t |
| he list, and list all.   |
|     ls -l /usr/X11R6/bin |
| /xsetroot /sbin/dump $fi |
| le_list                  |
|                          |
|     echo "-------------- |
| ------------------------ |
| ------------------------ |
| -----------"             |
|                          |
|     # What happens if we |
|  escape a couple of spac |
| es?                      |
|     ls -l /usr/X11R6/bin |
| /xsetroot\ /sbin/dump\ $ |
| file_list                |
|     # Error: the first t |
| hree files concatenated  |
| into a single argument t |
| o 'ls -l'                |
|     #        because the |
|  two escaped spaces prev |
| ent argument (word) spli |
| tting.                   |
                          
+--------------------------+--------------------------+--------------------------+

The escape also provides a means of writing a multi-line command.
Normally, each separate line constitutes a different command, but an
escape at the end of a line *escapes the newline character* , and the
command sequence continues on to the next line.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     (cd /source/director |
| y && tar cf - . ) | \    |
|     (cd /dest/directory  |
| && tar xpvf -)           |
|     # Repeating Alan Cox |
| 's directory tree copy c |
| ommand,                  |
|     # but split into two |
|  lines for increased leg |
| ibility.                 |
|                          |
|     # As an alternative: |
|     tar cf - -C /source/ |
| directory . |            |
|     tar xpvf - -C /dest/ |
| directory                |
|     # See note below.    |
|     # (Thanks, Stéphane  |
| Chazelas.)               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| If a script line ends with a \| , a  |
| pipe character, then a \\ , an       |
| escape, is not strictly necessary.   |
| It is, however, good programming     |
| practice to always escape the end of |
| a line of code that continues to the |
| following line.                      |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     echo "foo            |
|     bar"                 |
|     #foo                 |
|     #bar                 |
|                          |
|     echo                 |
|                          |
|     echo 'foo            |
|     bar'    # No differe |
| nce yet.                 |
|     #foo                 |
|     #bar                 |
|                          |
|     echo                 |
|                          |
|     echo foo\            |
|     bar     # Newline es |
| caped.                   |
|     #foobar              |
|                          |
|     echo                 |
|                          |
|     echo "foo\           |
|     bar"     # Same here |
| , as \ still interpreted |
|  as escape within weak q |
| uotes.                   |
|     #foobar              |
|                          |
|     echo                 |
|                          |
|     echo 'foo\           |
|     bar'     # Escape ch |
| aracter \ taken literall |
| y because of strong quot |
| ing.                     |
|     #foo\                |
|     #bar                 |
|                          |
|     # Examples suggested |
|  by Stéphane Chazelas.   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <quotingvar.html>` | Quoting Variables        |
| __                       | `Up <quoting.html>`__    |
| `Home <index.html>`__    | Exit and Exit Status     |
| `Next <exit-status.html> |                          |
| `__                      |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Important| image:: ../images/important.gif
.. |Note| image:: ../images/note.gif
