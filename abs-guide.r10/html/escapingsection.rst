Advanced Bash-Scripting Guide:

`Prev <quotingvar.html>`__

Chapter 5. Quoting

`Next <exit-status.html>`__

--------------

5.2. Escaping
=============

*Escaping* is a method of quoting single characters. The escape (\\)
preceding a character tells the shell to interpret that character
literally.

+--------------------------------------+--------------------------------------+
| |Caution|                            |
| With certain commands and utilities, |
| such as                              |
| `echo <internal.html#ECHOREF>`__ and |
| `sed <sedawk.html#SEDREF>`__,        |
| escaping a character may have the    |
| opposite effect - it can toggle on a |
| special meaning for that character.  |
+--------------------------------------+--------------------------------------+

**Special meanings of certain escaped characters**

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
    equivalent of ``0nn``, where ``nn`` is a string of digits

    +--------------------------+--------------------------+--------------------------+
    | |Important|              |
    |                          |
    | The ``$' ... '``         |
    | `quoted <quoting.html#QU |
    | OTINGREF>`__             |
    | string-expansion         |
    | construct is a mechanism |
    | that uses escaped octal  |
    | or hex values to assign  |
    | ASCII characters to      |
    | variables, e.g.,         |
    | **quote=$'\\042'**.      |
    +--------------------------+--------------------------+--------------------------+

    **Example 5-2. Escaped Characters**

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     #!/bin/bash                                                          |
    |     # escaped.sh: escaped characters                                     |
    |                                                                          |
    |     #############################################################        |
    |     ### First, let's show some basic escaped-character usage. ###        |
    |     #############################################################        |
    |                                                                          |
    |     # Escaping a newline.                                                |
    |     # ------------------                                                 |
    |                                                                          |
    |     echo ""                                                              |
    |                                                                          |
    |     echo "This will print                                                |
    |     as two lines."                                                       |
    |     # This will print                                                    |
    |     # as two lines.                                                      |
    |                                                                          |
    |     echo "This will print \                                              |
    |     as one line."                                                        |
    |     # This will print as one line.                                       |
    |                                                                          |
    |     echo; echo                                                           |
    |                                                                          |
    |     echo "============="                                                 |
    |                                                                          |
    |                                                                          |
    |     echo "\v\v\v\v"      # Prints \v\v\v\v literally.                    |
    |     # Use the -e option with 'echo' to print escaped characters.         |
    |     echo "============="                                                 |
    |     echo "VERTICAL TABS"                                                 |
    |     echo -e "\v\v\v\v"   # Prints 4 vertical tabs.                       |
    |     echo "=============="                                                |
    |                                                                          |
    |     echo "QUOTATION MARK"                                                |
    |     echo -e "\042"       # Prints " (quote, octal ASCII character 42).   |
    |     echo "=============="                                                |
    |                                                                          |
    |                                                                          |
    |                                                                          |
    |     # The $'\X' construct makes the -e option unnecessary.               |
    |                                                                          |
    |     echo; echo "NEWLINE and (maybe) BEEP"                                |
    |     echo $'\n'           # Newline.                                      |
    |     echo $'\a'           # Alert (beep).                                 |
    |                          # May only flash, not beep, depending on termin |
    | al.                                                                      |
    |                                                                          |
    |     # We have seen $'\nnn" string expansion, and now . . .               |
    |                                                                          |
    |     # ================================================================== |
    | = #                                                                      |
    |     # Version 2 of Bash introduced the $'\nnn' string expansion construc |
    | t.                                                                       |
    |     # ================================================================== |
    | = #                                                                      |
    |                                                                          |
    |     echo "Introducing the \$\' ... \' string-expansion construct . . . " |
    |     echo ". . . featuring more quotation marks."                         |
    |                                                                          |
    |     echo $'\t \042 \t'   # Quote (") framed by tabs.                     |
    |     # Note that  '\nnn' is an octal value.                               |
    |                                                                          |
    |     # It also works with hexadecimal values, in an $'\xhhh' construct.   |
    |     echo $'\t \x22 \t'  # Quote (") framed by tabs.                      |
    |     # Thank you, Greg Keraunen, for pointing this out.                   |
    |     # Earlier Bash versions allowed '\x022'.                             |
    |                                                                          |
    |     echo                                                                 |
    |                                                                          |
    |                                                                          |
    |     # Assigning ASCII characters to a variable.                          |
    |     # ----------------------------------------                           |
    |     quote=$'\042'        # " assigned to a variable.                     |
    |     echo "$quote Quoted string $quote and this lies outside the quotes." |
    |                                                                          |
    |     echo                                                                 |
    |                                                                          |
    |     # Concatenating ASCII chars in a variable.                           |
    |     triple_underline=$'\137\137\137'  # 137 is octal ASCII code for '_'. |
    |     echo "$triple_underline UNDERLINE $triple_underline"                 |
    |                                                                          |
    |     echo                                                                 |
    |                                                                          |
    |     ABC=$'\101\102\103\010'           # 101, 102, 103 are octal A, B, C. |
    |     echo $ABC                                                            |
    |                                                                          |
    |     echo                                                                 |
    |                                                                          |
    |     escape=$'\033'                    # 033 is octal for escape.         |
    |     echo "\"escape\" echoes as $escape"                                  |
    |     #                                   no visible output.               |
    |                                                                          |
    |     echo                                                                 |
    |                                                                          |
    |     exit 0                                                               |
                                                                              
    +--------------------------------------------------------------------------+

    A more elaborate example:

    **Example 5-3. Detecting key-presses**

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     #!/bin/bash                                                          |
    |     # Author: Sigurd Solaas, 20 Apr 2011                                 |
    |     # Used in ABS Guide with permission.                                 |
    |     # Requires version 4.2+ of Bash.                                     |
    |                                                                          |
    |     key="no value yet"                                                   |
    |     while true; do                                                       |
    |       clear                                                              |
    |       echo "Bash Extra Keys Demo. Keys to try:"                          |
    |       echo                                                               |
    |       echo "* Insert, Delete, Home, End, Page_Up and Page_Down"          |
    |       echo "* The four arrow keys"                                       |
    |       echo "* Tab, enter, escape, and space key"                         |
    |       echo "* The letter and number keys, etc."                          |
    |       echo                                                               |
    |       echo "    d = show date/time"                                      |
    |       echo "    q = quit"                                                |
    |       echo "================================"                            |
    |       echo                                                               |
    |                                                                          |
    |      # Convert the separate home-key to home-key_num_7:                  |
    |      if [ "$key" = $'\x1b\x4f\x48' ]; then                               |
    |       key=$'\x1b\x5b\x31\x7e'                                            |
    |       #   Quoted string-expansion construct.                             |
    |      fi                                                                  |
    |                                                                          |
    |      # Convert the separate end-key to end-key_num_1.                    |
    |      if [ "$key" = $'\x1b\x4f\x46' ]; then                               |
    |       key=$'\x1b\x5b\x34\x7e'                                            |
    |      fi                                                                  |
    |                                                                          |
    |      case "$key" in                                                      |
    |       $'\x1b\x5b\x32\x7e')  # Insert                                     |
    |        echo Insert Key                                                   |
    |       ;;                                                                 |
    |       $'\x1b\x5b\x33\x7e')  # Delete                                     |
    |        echo Delete Key                                                   |
    |       ;;                                                                 |
    |       $'\x1b\x5b\x31\x7e')  # Home_key_num_7                             |
    |        echo Home Key                                                     |
    |       ;;                                                                 |
    |       $'\x1b\x5b\x34\x7e')  # End_key_num_1                              |
    |        echo End Key                                                      |
    |       ;;                                                                 |
    |       $'\x1b\x5b\x35\x7e')  # Page_Up                                    |
    |        echo Page_Up                                                      |
    |       ;;                                                                 |
    |       $'\x1b\x5b\x36\x7e')  # Page_Down                                  |
    |        echo Page_Down                                                    |
    |       ;;                                                                 |
    |       $'\x1b\x5b\x41')  # Up_arrow                                       |
    |        echo Up arrow                                                     |
    |       ;;                                                                 |
    |       $'\x1b\x5b\x42')  # Down_arrow                                     |
    |        echo Down arrow                                                   |
    |       ;;                                                                 |
    |       $'\x1b\x5b\x43')  # Right_arrow                                    |
    |        echo Right arrow                                                  |
    |       ;;                                                                 |
    |       $'\x1b\x5b\x44')  # Left_arrow                                     |
    |        echo Left arrow                                                   |
    |       ;;                                                                 |
    |       $'\x09')  # Tab                                                    |
    |        echo Tab Key                                                      |
    |       ;;                                                                 |
    |       $'\x0a')  # Enter                                                  |
    |        echo Enter Key                                                    |
    |       ;;                                                                 |
    |       $'\x1b')  # Escape                                                 |
    |        echo Escape Key                                                   |
    |       ;;                                                                 |
    |       $'\x20')  # Space                                                  |
    |        echo Space Key                                                    |
    |       ;;                                                                 |
    |       d)                                                                 |
    |        date                                                              |
    |       ;;                                                                 |
    |       q)                                                                 |
    |       echo Time to quit...                                               |
    |       echo                                                               |
    |       exit 0                                                             |
    |       ;;                                                                 |
    |       *)                                                                 |
    |        echo You pressed: \'"$key"\'                                      |
    |       ;;                                                                 |
    |      esac                                                                |
    |                                                                          |
    |      echo                                                                |
    |      echo "================================"                             |
    |                                                                          |
    |      unset K1 K2 K3                                                      |
    |      read -s -N1 -p "Press a key: "                                      |
    |      K1="$REPLY"                                                         |
    |      read -s -N2 -t 0.001                                                |
    |      K2="$REPLY"                                                         |
    |      read -s -N1 -t 0.001                                                |
    |      K3="$REPLY"                                                         |
    |      key="$K1$K2$K3"                                                     |
    |                                                                          |
    |     done                                                                 |
    |                                                                          |
    |     exit $?                                                              |
                                                                              
    +--------------------------------------------------------------------------+

    See also `Example 37-1 <bashver2.html#EX77>`__.

\\"
    gives the quote its literal meaning

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     echo "Hello"                     # Hello                             |
    |     echo "\"Hello\" ... he said."    # "Hello" ... he said.              |
                                                                              
    +--------------------------------------------------------------------------+

\\$
    gives the dollar sign its literal meaning (variable name following
    \\$ will not be referenced)

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     echo "\$variable01"           # $variable01                          |
    |     echo "The book cost \$7.98."  # The book cost $7.98.                 |
                                                                              
    +--------------------------------------------------------------------------+

\\\\
    gives the backslash its literal meaning

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     echo "\\"  # Results in \                                            |
    |                                                                          |
    |     # Whereas . . .                                                      |
    |                                                                          |
    |     echo "\"   # Invokes secondary prompt from the command-line.         |
    |                # In a script, gives an error message.                    |
    |                                                                          |
    |     # However . . .                                                      |
    |                                                                          |
    |     echo '\'   # Results in \                                            |
                                                                              
    +--------------------------------------------------------------------------+

+----------------+----------------+----------------+----------------+----------------+
| |Note|         |
| The behavior   |
| of \\ depends  |
| on whether it  |
| is escaped,    |
| `strong-quoted |
|  <varsubn.html |
| #SNGLQUO>`__,  |
| `weak-quoted < |
| varsubn.html#D |
| BLQUO>`__,     |
| or appearing   |
| within         |
| `command       |
| substitution < |
| commandsub.htm |
| l#COMMANDSUBRE |
| F>`__          |
| or a `here     |
| document <here |
| -docs.html#HER |
| EDOCREF>`__.   |
|                |
| +------------- |
| -------------- |
| -------------- |
| -------------- |
| -------------- |
| -----+         |
| | .. code:: PR |
| OGRAMLISTING   |
|                |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |              |
|                |
| #  Simple esca |
| ping and quoti |
| ng             |
|      |         |
| |     echo \z  |
|                |
| #  z           |
|                |
|                |
|      |         |
| |     echo \\z |
|                |
| # \z           |
|                |
|                |
|      |         |
| |     echo '\z |
| '              |
| # \z           |
|                |
|                |
|      |         |
| |     echo '\\ |
| z'             |
| # \\z          |
|                |
|                |
|      |         |
| |     echo "\z |
| "              |
| # \z           |
|                |
|                |
|      |         |
| |     echo "\\ |
| z"             |
| # \z           |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |              |
|                |
| #  Command sub |
| stitution      |
|                |
|      |         |
| |     echo `ec |
| ho \z`         |
| #  z           |
|                |
|                |
|      |         |
| |     echo `ec |
| ho \\z`        |
| #  z           |
|                |
|                |
|      |         |
| |     echo `ec |
| ho \\\z`       |
| # \z           |
|                |
|                |
|      |         |
| |     echo `ec |
| ho \\\\z`      |
| # \z           |
|                |
|                |
|      |         |
| |     echo `ec |
| ho \\\\\\z`    |
| # \z           |
|                |
|                |
|      |         |
| |     echo `ec |
| ho \\\\\\\z`   |
| # \\z          |
|                |
|                |
|      |         |
| |     echo `ec |
| ho "\z"`       |
| # \z           |
|                |
|                |
|      |         |
| |     echo `ec |
| ho "\\z"`      |
| # \z           |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |              |
|                |
| # Here documen |
| t              |
|                |
|      |         |
| |     cat <<EO |
| F              |
|                |
|                |
|                |
|      |         |
| |     \z       |
|                |
|                |
|                |
|                |
|      |         |
| |     EOF      |
|                |
| # \z           |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     cat <<EO |
| F              |
|                |
|                |
|                |
|      |         |
| |     \\z      |
|                |
|                |
|                |
|                |
|      |         |
| |     EOF      |
|                |
| # \z           |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     # These  |
| examples suppl |
| ied by Stéphan |
| e Chazelas.    |
|                |
|      |         |
|                |
|                |
|                |
|                |
|                |
|                |
| +------------- |
| -------------- |
| -------------- |
| -------------- |
| -------------- |
| -----+         |
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
| -------------- |
| -------------- |
| -------------- |
| -------------- |
| -----+         |
| | .. code:: PR |
| OGRAMLISTING   |
|                |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     variable |
| =\             |
|                |
|                |
|                |
|      |         |
| |     echo "$v |
| ariable"       |
|                |
|                |
|                |
|      |         |
| |     # Will n |
| ot work - give |
| s an error mes |
| sage:          |
|                |
|      |         |
| |     # test.s |
| h: : command n |
| ot found       |
|                |
|                |
|      |         |
| |     # A "nak |
| ed" escape can |
| not safely be  |
| assigned to a  |
| variable.      |
|      |         |
| |     #        |
|                |
|                |
|                |
|                |
|      |         |
| |     #  What  |
| actually happe |
| ns here is tha |
| t the "\" esca |
| pes the newlin |
| e an |         |
| | d            |
|                |
|                |
|                |
|                |
|      |         |
| |     #+ the e |
| ffect is       |
|   variable=ech |
| o "$variable"  |
|                |
|      |         |
| |     #+       |
|                |
|   invalid vari |
| able assignmen |
| t              |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     variable |
| =\             |
|                |
|                |
|                |
|      |         |
| |     23skidoo |
|                |
|                |
|                |
|                |
|      |         |
| |     echo "$v |
| ariable"       |
|   #  23skidoo  |
|                |
|                |
|      |         |
| |              |
|                |
|   #  This work |
| s, since the s |
| econd line     |
|      |         |
| |              |
|                |
|   #+ is a vali |
| d variable ass |
| ignment.       |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     variable |
| =\             |
|                |
|                |
|                |
|      |         |
| |     #        |
|  \^    escape  |
| followed by sp |
| ace            |
|                |
|      |         |
| |     echo "$v |
| ariable"       |
|   # space      |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     variable |
| =\\            |
|                |
|                |
|                |
|      |         |
| |     echo "$v |
| ariable"       |
|   # \          |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     variable |
| =\\\           |
|                |
|                |
|                |
|      |         |
| |     echo "$v |
| ariable"       |
|                |
|                |
|                |
|      |         |
| |     # Will n |
| ot work - give |
| s an error mes |
| sage:          |
|                |
|      |         |
| |     # test.s |
| h: \: command  |
| not found      |
|                |
|                |
|      |         |
| |     #        |
|                |
|                |
|                |
|                |
|      |         |
| |     #  First |
|  escape escape |
| s second one,  |
| but the third  |
| one is left "n |
| aked |         |
| | ",           |
|                |
|                |
|                |
|                |
|      |         |
| |     #+ with  |
| same result as |
|  first instanc |
| e, above.      |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     variable |
| =\\\\          |
|                |
|                |
|                |
|      |         |
| |     echo "$v |
| ariable"       |
|   # \\         |
|                |
|                |
|      |         |
| |              |
|                |
|   # Second and |
|  fourth escape |
| s escaped.     |
|      |         |
| |              |
|                |
|   # This is o. |
| k.             |
|                |
|      |         |
|                |
|                |
|                |
|                |
|                |
|                |
| +------------- |
| -------------- |
| -------------- |
| -------------- |
| -------------- |
| -----+         |
                
+----------------+----------------+----------------+----------------+----------------+

Escaping a space can prevent word splitting in a command's argument
list.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     file_list="/bin/cat /bin/gzip /bin/more /usr/bin/less /usr/bin/emacs |
| -20.7"                                                                   |
|     # List of files as argument(s) to a command.                         |
|                                                                          |
|     # Add two files to the list, and list all.                           |
|     ls -l /usr/X11R6/bin/xsetroot /sbin/dump $file_list                  |
|                                                                          |
|     echo "-------------------------------------------------------------- |
| -----------"                                                             |
|                                                                          |
|     # What happens if we escape a couple of spaces?                      |
|     ls -l /usr/X11R6/bin/xsetroot\ /sbin/dump\ $file_list                |
|     # Error: the first three files concatenated into a single argument t |
| o 'ls -l'                                                                |
|     #        because the two escaped spaces prevent argument (word) spli |
| tting.                                                                   |
                                                                          
+--------------------------------------------------------------------------+

The escape also provides a means of writing a multi-line command.
Normally, each separate line constitutes a different command, but an
escape at the end of a line *escapes the newline character*, and the
command sequence continues on to the next line.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     (cd /source/directory && tar cf - . ) | \                            |
|     (cd /dest/directory && tar xpvf -)                                   |
|     # Repeating Alan Cox's directory tree copy command,                  |
|     # but split into two lines for increased legibility.                 |
|                                                                          |
|     # As an alternative:                                                 |
|     tar cf - -C /source/directory . |                                    |
|     tar xpvf - -C /dest/directory                                        |
|     # See note below.                                                    |
|     # (Thanks, Stéphane Chazelas.)                                       |
                                                                          
+--------------------------------------------------------------------------+

+--------------------------------------+--------------------------------------+
| |Note|                               |
| If a script line ends with a \|, a   |
| pipe character, then a \\, an        |
| escape, is not strictly necessary.   |
| It is, however, good programming     |
| practice to always escape the end of |
| a line of code that continues to the |
| following line.                      |
+--------------------------------------+--------------------------------------+

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     echo "foo                                                            |
|     bar"                                                                 |
|     #foo                                                                 |
|     #bar                                                                 |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo 'foo                                                            |
|     bar'    # No difference yet.                                         |
|     #foo                                                                 |
|     #bar                                                                 |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo foo\                                                            |
|     bar     # Newline escaped.                                           |
|     #foobar                                                              |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo "foo\                                                           |
|     bar"     # Same here, as \ still interpreted as escape within weak q |
| uotes.                                                                   |
|     #foobar                                                              |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo 'foo\                                                           |
|     bar'     # Escape character \ taken literally because of strong quot |
| ing.                                                                     |
|     #foo\                                                                |
|     #bar                                                                 |
|                                                                          |
|     # Examples suggested by Stéphane Chazelas.                           |
                                                                          
+--------------------------------------------------------------------------+

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <quotingvar.html>` | Quoting Variables        |
| __                       | `Up <quoting.html>`__    |
| `Home <index.html>`__    | Exit and Exit Status     |
| `Next <exit-status.html> |                          |
| `__                      |                          |
+--------------------------+--------------------------+--------------------------+

.. |Caution| image:: ../images/caution.gif
.. |Important| image:: ../images/important.gif
.. |Note| image:: ../images/note.gif
