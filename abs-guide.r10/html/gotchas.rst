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

`Prev <options.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <scrstyle.html>`__

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

Chapter 34. Gotchas
===================

+--------------+--------------+--------------+--------------+--------------+--------------+
|              |
| **           |
| *Turandot:   |
| *Gli enigmi  |
| sono tre, la |
| morte una!** |
|              |
| *Caleph:     |
| *No, no! Gli |
| enigmi sono  |
| tre, una la  |
| vita!**      |
|              |
| *--Puccini*  |
+--------------+--------------+--------------+--------------+--------------+--------------+

Here are some (non-recommended!) scripting practices that will bring
excitement into an otherwise dull life.

-  

   Assigning reserved words or characters to variable names.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     case=value0       #  |
   | Causes problems.         |
   |     23skidoo=value1   #  |
   | Also problems.           |
   |     # Variable names sta |
   | rting with a digit are r |
   | eserved by the shell.    |
   |     # Try _23skidoo=valu |
   | e1. Starting variables w |
   | ith an underscore is oka |
   | y.                       |
   |                          |
   |     # However . . .   us |
   | ing just an underscore w |
   | ill not work.            |
   |     _=25                 |
   |     echo $_           #  |
   | $_ is a special variable |
   |  set to last arg of last |
   |  command.                |
   |     # But . . .       _  |
   | is a valid function name |
   | !                        |
   |                          |
   |     xyz((!*=value2    #  |
   | Causes severe problems.  |
   |     # As of version 3 of |
   |  Bash, periods are not a |
   | llowed within variable n |
   | ames.                    |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  Using a hyphen or other reserved characters in a variable name (or
   function name).

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     var-1=23             |
   |     # Use 'var_1' instea |
   | d.                       |
   |                          |
   |     function-whatever () |
   |    # Error               |
   |     # Use 'function_what |
   | ever ()' instead.        |
   |                          |
   |                          |
   |     # As of version 3 of |
   |  Bash, periods are not a |
   | llowed within function n |
   | ames.                    |
   |     function.whatever () |
   |    # Error               |
   |     # Use 'functionWhate |
   | ver ()' instead.         |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  Using the same name for a variable and a function. This can make a
   script difficult to understand.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     do_something ()      |
   |     {                    |
   |       echo "This functio |
   | n does something with \" |
   | $1\"."                   |
   |     }                    |
   |                          |
   |     do_something=do_some |
   | thing                    |
   |                          |
   |     do_something do_some |
   | thing                    |
   |                          |
   |     # All this is legal, |
   |  but highly confusing.   |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  Using `whitespace <special-chars.html#WHITESPACEREF>`__
   inappropriately. In contrast to other programming languages, Bash can
   be quite finicky about whitespace.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     var1 = 23   # 'var1= |
   | 23' is correct.          |
   |     # On line above, Bas |
   | h attempts to execute co |
   | mmand "var1"             |
   |     # with the arguments |
   |  "=" and "23".           |
   |                          |
   |     let c = $a - $b   #  |
   | Instead:   let c=$a-$b   |
   |  or   let "c = $a - $b"  |
   |                          |
   |     if [ $a -le 5]    #  |
   | if [ $a -le 5 ]   is cor |
   | rect.                    |
   |     #           ^^       |
   | if [ "$a" -le 5 ]   is e |
   | ven better.              |
   |                       #  |
   | [[ $a -le 5 ]] also work |
   | s.                       |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  

   Not terminating with a
   `semicolon <special-chars.html#SEMICOLONREF>`__ the final command in
   a `code block within curly
   brackets <special-chars.html#CODEBLOCKREF>`__.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     { ls -l; df; echo "D |
   | one." }                  |
   |     # bash: syntax error |
   | : unexpected end of file |
   |                          |
   |     { ls -l; df; echo "D |
   | one."; }                 |
   |     #                    |
   |      ^     ### Final com |
   | mand needs semicolon.    |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  

   Assuming uninitialized variables (variables before a value is
   assigned to them) are "zeroed out". An uninitialized variable has a
   value of *null*, *not* zero.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |                          |
   |     echo "uninitialized_ |
   | var = $uninitialized_var |
   | "                        |
   |     # uninitialized_var  |
   | =                        |
   |                          |
   |     # However . . .      |
   |     # if $BASH_VERSION ≥ |
   |  4.2; then               |
   |                          |
   |     if [[ ! -v uninitial |
   | ized_var ]]              |
   |     then                 |
   |       uninitialized_var= |
   | 0   # Initialize it to z |
   | ero!                     |
   |     fi                   |
   |                         |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  

   Mixing up *=* and *-eq* in a test. Remember, *=* is for comparing
   literal variables and *-eq* for integers.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     if [ "$a" = 273 ]    |
   |    # Is $a an integer or |
   |  string?                 |
   |     if [ "$a" -eq 273 ]  |
   |    # If $a is an integer |
   | .                        |
   |                          |
   |     # Sometimes you can  |
   | interchange -eq and = wi |
   | thout adverse consequenc |
   | es.                      |
   |     # However . . .      |
   |                          |
   |                          |
   |     a=273.0   # Not an i |
   | nteger.                  |
   |                          |
   |     if [ "$a" = 273 ]    |
   |     then                 |
   |       echo "Comparison w |
   | orks."                   |
   |     else                 |
   |       echo "Comparison d |
   | oes not work."           |
   |     fi    # Comparison d |
   | oes not work.            |
   |                          |
   |     # Same with   a=" 27 |
   | 3"  and a="0273".        |
   |                          |
   |                          |
   |     # Likewise, problems |
   |  trying to use "-eq" wit |
   | h non-integer values.    |
   |                          |
   |     if [ "$a" -eq 273.0  |
   | ]                        |
   |     then                 |
   |       echo "a = $a"      |
   |     fi  # Aborts with an |
   |  error message.          |
   |     # test.sh: [: 273.0: |
   |  integer expression expe |
   | cted                     |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  

   Misusing `string comparison <comparison-ops.html#SCOMPARISON1>`__
   operators.

   .. raw:: html

      <div class="EXAMPLE">

   **Example 34-1. Numerical and string comparison are not equivalent**

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |     # bad-op.sh: Trying  |
   | to use a string comparis |
   | on on integers.          |
   |                          |
   |     echo                 |
   |     number=1             |
   |                          |
   |     #  The following whi |
   | le-loop has two errors:  |
   |     #+ one blatant, and  |
   | the other subtle.        |
   |                          |
   |     while [ "$number" <  |
   | 5 ]    # Wrong! Should b |
   | e:  while [ "$number" -l |
   | t 5 ]                    |
   |     do                   |
   |       echo -n "$number " |
   |       let "number += 1"  |
   |     done                 |
   |     #  Attempt to run th |
   | is bombs with the error  |
   | message:                 |
   |     #+ bad-op.sh: line 1 |
   | 0: 5: No such file or di |
   | rectory                  |
   |     #  Within single bra |
   | ckets, "<" must be escap |
   | ed,                      |
   |     #+ and even then, it |
   | 's still wrong for compa |
   | ring integers.           |
   |                          |
   |     echo "-------------- |
   | -------"                 |
   |                          |
   |     while [ "$number" \< |
   |  5 ]    #  1 2 3 4       |
   |     do                   |
   |         #                |
   |       echo -n "$number " |
   |         #  It *seems* to |
   |  work, but . . .         |
   |       let "number += 1"  |
   |         #+ it actually d |
   | oes an ASCII comparison, |
   |     done                 |
   |         #+ rather than a |
   |  numerical one.          |
   |                          |
   |     echo; echo "-------- |
   | -------------"           |
   |                          |
   |     # This can cause pro |
   | blems. For example:      |
   |                          |
   |     lesser=5             |
   |     greater=105          |
   |                          |
   |     if [ "$greater" \< " |
   | $lesser" ]               |
   |     then                 |
   |       echo "$greater is  |
   | less than $lesser"       |
   |     fi                   |
   |         # 105 is less th |
   | an 5                     |
   |     #  In fact, "105" ac |
   | tually is less than "5"  |
   |     #+ in a string compa |
   | rison (ASCII sort order) |
   | .                        |
   |                          |
   |     echo                 |
   |                          |
   |     exit 0               |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

-  

   Attempting to use `let <internal.html#LETREF>`__ to set string
   variables.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     let "a = hello, you" |
   |     echo "$a"   # 0      |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  

   Sometimes variables within "test" brackets ([ ]) need to be quoted
   (double quotes). Failure to do so may cause unexpected behavior. See
   `Example 7-6 <comparison-ops.html#STRTEST>`__, `Example
   20-5 <redircb.html#REDIR2>`__, and `Example
   9-6 <internalvariables.html#ARGLIST>`__.

-  

   Quoting a variable containing whitespace `prevents
   splitting <quotingvar.html#WSQUO>`__. Sometimes this produces
   `unintended consequences <quotingvar.html#VARSPLITTING>`__.

-  

   Commands issued from a script may fail to execute because the script
   owner lacks execute permission for them. If a user cannot invoke a
   command from the command-line, then putting it into a script will
   likewise fail. Try changing the attributes of the command in
   question, perhaps even setting the suid bit (as *root*, of course).

-  

   Attempting to use **-** as a redirection operator (which it is not)
   will usually result in an unpleasant surprise.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     command1 2> - | comm |
   | and2                     |
   |     # Trying to redirect |
   |  error output of command |
   | 1 into a pipe . . .      |
   |     # . . . will not wor |
   | k.                       |
   |                          |
   |     command1 2>& - | com |
   | mand2  # Also futile.    |
   |                          |
   |     Thanks, S.C.         |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  

   Using Bash `version 2+ <bashver2.html#BASH2REF>`__ functionality may
   cause a bailout with error messages. Older Linux machines may have
   version 1.XX of Bash as the default installation.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |                          |
   |     minimum_version=2    |
   |     # Since Chet Ramey i |
   | s constantly adding feat |
   | ures to Bash,            |
   |     # you may set $minim |
   | um_version to 2.XX, 3.XX |
   | , or whatever is appropr |
   | iate.                    |
   |     E_BAD_VERSION=80     |
   |                          |
   |     if [ "$BASH_VERSION" |
   |  \< "$minimum_version" ] |
   |     then                 |
   |       echo "This script  |
   | works only with Bash, ve |
   | rsion $minimum or greate |
   | r."                      |
   |       echo "Upgrade stro |
   | ngly recommended."       |
   |       exit $E_BAD_VERSIO |
   | N                        |
   |     fi                   |
   |                          |
   |     ...                  |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  Using Bash-specific functionality in a `Bourne
   shell <why-shell.html#BASHDEF>`__ script (``#!/bin/sh``) on a
   non-Linux machine `may cause unexpected
   behavior <gotchas.html#BINSH>`__. A Linux system usually aliases
   **sh** to **bash**, but this does not necessarily hold true for a
   generic UNIX machine.

-  

   Using undocumented features in Bash turns out to be a dangerous
   practice. In previous releases of this book there were several
   scripts that depended on the "feature" that, although the maximum
   value of an `exit <exit-status.html#EXITSTATUSREF>`__ or
   `return <complexfunct.html#RETURNREF>`__ value was 255, that limit
   did not apply to *negative* integers. Unfortunately, in version 2.05b
   and later, that loophole disappeared. See `Example
   24-9 <complexfunct.html#RETURNTEST>`__.

-  

   In certain contexts, a misleading `exit
   status <exit-status.html#EXITSTATUSREF>`__ may be returned. This may
   occur when `setting a local variable within a
   function <localvar.html#EXITVALANOMALY01>`__ or when `assigning an
   arithmetic value to a variable <internal.html#EXITVALANOMALY02>`__.

-  The `exit status of an arithmetic
   expression <testconstructs.html#ARXS>`__ is *not* equivalent to an
   *error code*.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     var=1 && ((--var)) & |
   | & echo $var              |
   |     #        ^^^^^^^^^ H |
   | ere the and-list termina |
   | tes with exit status 1.  |
   |     #                    |
   |   $var doesn't echo!     |
   |     echo $?   # 1        |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  

   A script with DOS-type newlines (``\r\n``) will fail to execute,
   since ``#!/bin/bash\r\n`` is *not* recognized, *not* the same as the
   expected ``#!/bin/bash\n``. The fix is to convert the script to
   UNIX-style newlines.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |                          |
   |     echo "Here"          |
   |                          |
   |     unix2dos $0    # Scr |
   | ipt changes itself to DO |
   | S format.                |
   |     chmod 755 $0   # Cha |
   | nge back to execute perm |
   | ission.                  |
   |                    # The |
   |  'unix2dos' command remo |
   | ves execute permission.  |
   |                          |
   |     ./$0           # Scr |
   | ipt tries to run itself  |
   | again.                   |
   |                    # But |
   |  it won't work as a DOS  |
   | file.                    |
   |                          |
   |     echo "There"         |
   |                          |
   |     exit 0               |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  

   A shell script headed by ``#!/bin/sh`` will not run in full
   Bash-compatibility mode. Some Bash-specific functions might be
   disabled. Scripts that need complete access to all the Bash-specific
   extensions should start with ``#!/bin/bash``.

-  `Putting whitespace in front of the terminating limit
   string <here-docs.html#INDENTEDLS>`__ of a `here
   document <here-docs.html#HEREDOCREF>`__ will cause unexpected
   behavior in a script.

-  Putting more than one *echo* statement in a function `whose output is
   captured <assortedtips.html#RVT>`__.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     add2 ()              |
   |     {                    |
   |       echo "Whatever ... |
   |  "   # Delete this line! |
   |       let "retval = $1 + |
   |  $2"                     |
   |         echo $retval     |
   |         }                |
   |                          |
   |         num1=12          |
   |         num2=43          |
   |         echo "Sum of $nu |
   | m1 and $num2 = $(add2 $n |
   | um1 $num2)"              |
   |                          |
   |     #   Sum of 12 and 43 |
   |  = Whatever ...          |
   |     #   55               |
   |                          |
   |     #        The "echoes |
   | " concatenate.           |
                             
   +--------------------------+--------------------------+--------------------------+

   This `will not work <assortedtips.html#RVTCAUTION>`__.

   .. raw:: html

      </p>

-  

   A script may not **export** variables back to its `parent
   process <internal.html#FORKREF>`__, the shell, or to the environment.
   Just as we learned in biology, a child process can inherit from a
   parent, but not vice versa.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     WHATEVER=/home/bozo  |
   |     export WHATEVER      |
   |     exit 0               |
                             
   +--------------------------+--------------------------+--------------------------+

   +--------------------------+--------------------------+--------------------------+
   | .. code:: SCREEN         |
   |                          |
   |     bash$ echo $WHATEVER |
   |                          |
   |     bash$                |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

   Sure enough, back at the command prompt, $WHATEVER remains unset.

-  

   Setting and manipulating variables in a
   `subshell <subshells.html#SUBSHELLSREF>`__, then attempting to use
   those same variables outside the scope of the subshell will result an
   unpleasant surprise.

   .. raw:: html

      <div class="EXAMPLE">

   **Example 34-2. Subshell Pitfalls**

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |     # Pitfalls of variab |
   | les in a subshell.       |
   |                          |
   |     outer_variable=outer |
   |     echo                 |
   |     echo "outer_variable |
   |  = $outer_variable"      |
   |     echo                 |
   |                          |
   |     (                    |
   |     # Begin subshell     |
   |                          |
   |     echo "outer_variable |
   |  inside subshell = $oute |
   | r_variable"              |
   |     inner_variable=inner |
   |   # Set                  |
   |     echo "inner_variable |
   |  inside subshell = $inne |
   | r_variable"              |
   |     outer_variable=inner |
   |   # Will value change gl |
   | obally?                  |
   |     echo "outer_variable |
   |  inside subshell = $oute |
   | r_variable"              |
   |                          |
   |     # Will 'exporting' m |
   | ake a difference?        |
   |     #    export inner_va |
   | riable                   |
   |     #    export outer_va |
   | riable                   |
   |     # Try it and see.    |
   |                          |
   |     # End subshell       |
   |     )                    |
   |                          |
   |     echo                 |
   |     echo "inner_variable |
   |  outside subshell = $inn |
   | er_variable"  # Unset.   |
   |     echo "outer_variable |
   |  outside subshell = $out |
   | er_variable"  # Unchange |
   | d.                       |
   |     echo                 |
   |                          |
   |     exit 0               |
   |                          |
   |     # What happens if yo |
   | u uncomment lines 19 and |
   |  20?                     |
   |     # Does it make a dif |
   | ference?                 |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

-  

   `Piping <special-chars.html#PIPEREF>`__ **echo** output to a
   `read <internal.html#READREF>`__ may produce unexpected results. In
   this scenario, the **read** acts as if it were running in a subshell.
   Instead, use the `set <internal.html#SETREF>`__ command (as in
   `Example 15-18 <internal.html#SETPOS>`__).

   .. raw:: html

      <div class="EXAMPLE">

   **Example 34-3. Piping the output of *echo* to a *read***

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |     #  badread.sh:       |
   |     #  Attempting to use |
   |  'echo and 'read'        |
   |     #+ to assign variabl |
   | es non-interactively.    |
   |                          |
   |     #   shopt -s lastpip |
   | e                        |
   |                          |
   |     a=aaa                |
   |     b=bbb                |
   |     c=ccc                |
   |                          |
   |     echo "one two three" |
   |  | read a b c            |
   |     # Try to reassign a, |
   |  b, and c.               |
   |                          |
   |     echo                 |
   |     echo "a = $a"  # a = |
   |  aaa                     |
   |     echo "b = $b"  # b = |
   |  bbb                     |
   |     echo "c = $c"  # c = |
   |  ccc                     |
   |     # Reassignment faile |
   | d.                       |
   |                          |
   |     ### However . . .    |
   |     ##  Uncommenting lin |
   | e 6:                     |
   |     #   shopt -s lastpip |
   | e                        |
   |     ##+ fixes the proble |
   | m!                       |
   |     ### This is a new fe |
   | ature in Bash, version 4 |
   | .2.                      |
   |                          |
   |     # ------------------ |
   | ------------             |
   |                          |
   |     # Try the following  |
   | alternative.             |
   |                          |
   |     var=`echo "one two t |
   | hree"`                   |
   |     set -- $var          |
   |     a=$1; b=$2; c=$3     |
   |                          |
   |     echo "-------"       |
   |     echo "a = $a"  # a = |
   |  one                     |
   |     echo "b = $b"  # b = |
   |  two                     |
   |     echo "c = $c"  # c = |
   |  three                   |
   |     # Reassignment succe |
   | eded.                    |
   |                          |
   |     # ------------------ |
   | ------------             |
   |                          |
   |     #  Note also that an |
   |  echo to a 'read' works  |
   | within a subshell.       |
   |     #  However, the valu |
   | e of the variable change |
   | s *only* within the subs |
   | hell.                    |
   |                          |
   |     a=aaa          # Sta |
   | rting all over again.    |
   |     b=bbb                |
   |     c=ccc                |
   |                          |
   |     echo; echo           |
   |     echo "one two three" |
   |  | ( read a b c;         |
   |     echo "Inside subshel |
   | l: "; echo "a = $a"; ech |
   | o "b = $b"; echo "c = $c |
   | " )                      |
   |     # a = one            |
   |     # b = two            |
   |     # c = three          |
   |     echo "-------------- |
   | ---"                     |
   |     echo "Outside subshe |
   | ll: "                    |
   |     echo "a = $a"  # a = |
   |  aaa                     |
   |     echo "b = $b"  # b = |
   |  bbb                     |
   |     echo "c = $c"  # c = |
   |  ccc                     |
   |     echo                 |
   |                          |
   |     exit 0               |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

   In fact, as Anthony Richardson points out, piping to *any* loop can
   cause a similar problem.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     # Loop piping troubl |
   | es.                      |
   |     #  This example by A |
   | nthony Richardson,       |
   |     #+ with addendum by  |
   | Wilbert Berendsen.       |
   |                          |
   |                          |
   |     foundone=false       |
   |     find $HOME -type f - |
   | atime +30 -size 100k |   |
   |     while true           |
   |     do                   |
   |        read f            |
   |        echo "$f is over  |
   | 100KB and has not been a |
   | ccessed in over 30 days" |
   |        echo "Consider mo |
   | ving the file to archive |
   | s."                      |
   |        foundone=true     |
   |        # --------------- |
   | ---------------------    |
   |          echo "Subshell  |
   | level = $BASH_SUBSHELL"  |
   |        # Subshell level  |
   | = 1                      |
   |        # Yes, we're insi |
   | de a subshell.           |
   |        # --------------- |
   | ---------------------    |
   |     done                 |
   |                          |
   |     #  foundone will alw |
   | ays be false here since  |
   | it is                    |
   |     #+ set to true insid |
   | e a subshell             |
   |     if [ $foundone = fal |
   | se ]                     |
   |     then                 |
   |        echo "No files ne |
   | ed archiving."           |
   |     fi                   |
   |                          |
   |     # ================== |
   | ===Now, here is the corr |
   | ect way:================ |
   | =                        |
   |                          |
   |     foundone=false       |
   |     for f in $(find $HOM |
   | E -type f -atime +30 -si |
   | ze 100k)  # No pipe here |
   | .                        |
   |     do                   |
   |        echo "$f is over  |
   | 100KB and has not been a |
   | ccessed in over 30 days" |
   |        echo "Consider mo |
   | ving the file to archive |
   | s."                      |
   |        foundone=true     |
   |     done                 |
   |                          |
   |     if [ $foundone = fal |
   | se ]                     |
   |     then                 |
   |        echo "No files ne |
   | ed archiving."           |
   |     fi                   |
   |                          |
   |     # ================== |
   | And here is another alte |
   | rnative================= |
   | =                        |
   |                          |
   |     #  Places the part o |
   | f the script that reads  |
   | the variables            |
   |     #+ within a code blo |
   | ck, so they share the sa |
   | me subshell.             |
   |     #  Thank you, W.B.   |
   |                          |
   |     find $HOME -type f - |
   | atime +30 -size 100k | { |
   |          foundone=false  |
   |          while read f    |
   |          do              |
   |            echo "$f is o |
   | ver 100KB and has not be |
   | en accessed in over 30 d |
   | ays"                     |
   |            echo "Conside |
   | r moving the file to arc |
   | hives."                  |
   |            foundone=true |
   |          done            |
   |                          |
   |          if ! $foundone  |
   |          then            |
   |            echo "No file |
   | s need archiving."       |
   |          fi              |
   |     }                    |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

   A lookalike problem occurs when trying to write the ``stdout`` of a
   **tail -f** piped to `grep <textproc.html#GREPREF>`__.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     tail -f /var/log/mes |
   | sages | grep "$ERROR_MSG |
   | " >> error.log           |
   |     #  The "error.log" f |
   | ile will not have anythi |
   | ng written to it.        |
   |     #  As Samuli Kaipiai |
   | nen points out, this res |
   | ults from grep           |
   |     #+ buffering its out |
   | put.                     |
   |     #  The fix is to add |
   |  the "--line-buffered" p |
   | arameter to grep.        |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  

   Using "suid" commands within scripts is risky, as it may compromise
   system security. `[1] <gotchas.html#FTN.AEN19993>`__

-  

   Using shell scripts for CGI programming may be problematic. Shell
   script variables are not "typesafe," and this can cause undesirable
   behavior as far as CGI is concerned. Moreover, it is difficult to
   "cracker-proof" shell scripts.

-  Bash does not handle the `double slash (//)
   string <internal.html#DOUBLESLASHREF>`__ correctly.

-  

   Bash scripts written for Linux or BSD systems may need fixups to run
   on a commercial UNIX machine. Such scripts often employ the GNU set
   of commands and filters, which have greater functionality than their
   generic UNIX counterparts. This is particularly true of such text
   processing utilites as `tr <textproc.html#TRREF>`__.

-  

   Sadly, updates to Bash itself have broken older scripts that `used to
   work perfectly fine <string-manipulation.html#PARAGRAPHSPACE>`__. Let
   us recall `how risky it is to use undocumented Bash
   features <gotchas.html#UNDOCF>`__.

+----------+----------+----------+----------+----------+----------+----------+----------+----------+
|          |
| **       |
| *Danger  |
| is near  |
| thee --* |
|          |
| *Beware, |
| beware,  |
| beware,  |
| beware.* |
|          |
| *Many    |
| brave    |
| hearts   |
| are      |
| asleep   |
| in the   |
| deep.*   |
|          |
| *So      |
| beware   |
| --*      |
|          |
| *Beware. |
| *        |
|          |
| *--A.J.  |
| Lamb and |
| H.W.     |
| Petrie*  |
+----------+----------+----------+----------+----------+----------+----------+----------+----------+

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <gotchas.html#AEN19993>`__      |
| Setting the                          |
| `suid <fto.html#SUIDREF>`__          |
| permission on the script itself has  |
| no effect in Linux and most other    |
| UNIX flavors.                        |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <options.html>`__  | Options                  |
| `Home <index.html>`__    | `Up <part5.html>`__      |
| `Next <scrstyle.html>`__ | Scripting With Style     |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

