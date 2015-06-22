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

`Prev <bashver2.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 37. Bash, versions 2, 3, and 4

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <bashver4.html>`__

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

  37.2. Bash, version 3
======================

On July 27, 2004, Chet Ramey released version 3 of Bash. This update
fixed quite a number of bugs and added new features.

Some of the more important added features:

-  

   A new, more generalized **{a..z}** `brace
   expansion <special-chars.html#BRACEEXPREF>`__ operator.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |                          |
   |     for i in {1..10}     |
   |     #  Simpler and more  |
   | straightforward than     |
   |     #+ for i in $(seq 10 |
   | )                        |
   |     do                   |
   |       echo -n "$i "      |
   |     done                 |
   |                          |
   |     echo                 |
   |                          |
   |     # 1 2 3 4 5 6 7 8 9  |
   | 10                       |
   |                          |
   |                          |
   |                          |
   |     # Or just . . .      |
   |                          |
   |     echo {a..z}    #  a  |
   | b c d e f g h i j k l m  |
   | n o p q r s t u v w x y  |
   | z                        |
   |     echo {e..m}    #  e  |
   | f g h i j k l m          |
   |     echo {z..a}    #  z  |
   | y x w v u t s r q p o n  |
   | m l k j i h g f e d c b  |
   | a                        |
   |                    #  Wo |
   | rks backwards, too.      |
   |     echo {25..30}  #  25 |
   |  26 27 28 29 30          |
   |     echo {3..-2}   #  3  |
   | 2 1 0 -1 -2              |
   |     echo {X..d}    #  X  |
   | Y Z [  ] ^ _ ` a b c d   |
   |                    #  Sh |
   | ows (some of) the ASCII  |
   | characters between Z and |
   |  a,                      |
   |                    #+ bu |
   | t don't rely on this typ |
   | e of behavior because .  |
   | . .                      |
   |     echo {]..a}    #  {] |
   | ..a}                     |
   |                    #  Wh |
   | y?                       |
   |                          |
   |                          |
   |     # You can tack on pr |
   | efixes and suffixes.     |
   |     echo "Number #"{1..4 |
   | }, "..."                 |
   |          # Number #1, Nu |
   | mber #2, Number #3, Numb |
   | er #4, ...               |
   |                          |
   |                          |
   |     # You can concatenat |
   | e brace-expansion sets.  |
   |     echo {1..3}{x..z}" + |
   | " "..."                  |
   |          # 1x + 1y + 1z  |
   | + 2x + 2y + 2z + 3x + 3y |
   |  + 3z + ...              |
   |          # Generates an  |
   | algebraic expression.    |
   |          # This could be |
   |  used to find permutatio |
   | ns.                      |
   |                          |
   |     # You can nest brace |
   | -expansion sets.         |
   |     echo {{a..c},{1..3}} |
   |          # a b c 1 2 3   |
   |          # The "comma op |
   | erator" splices together |
   |  strings.                |
   |                          |
   |     # ########## ####### |
   | ## ############ ######## |
   | ### ######### ########## |
   | #####                    |
   |     # Unfortunately, bra |
   | ce expansion does not le |
   | nd itself to parameteriz |
   | ation.                   |
   |     var1=1               |
   |     var2=5               |
   |     echo {$var1..$var2}  |
   |   # {1..5}               |
   |                          |
   |                          |
   |     # Yet, as Emiliano G |
   | . points out, using "eva |
   | l" overcomes this limita |
   | tion.                    |
   |                          |
   |     start=0              |
   |     end=10               |
   |     for index in $(eval  |
   | echo {$start..$end})     |
   |     do                   |
   |       echo -n "$index "  |
   |   # 0 1 2 3 4 5 6 7 8 9  |
   | 10                       |
   |     done                 |
   |                          |
   |     echo                 |
                             
   +--------------------------+--------------------------+--------------------------+

-  The **${!array[@]}** operator, which expands to all the indices of a
   given `array <arrays.html#ARRAYREF>`__ .

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |                          |
   |     Array=(element-zero  |
   | element-one element-two  |
   | element-three)           |
   |                          |
   |     echo ${Array[0]}   # |
   |  element-zero            |
   |                        # |
   |  First element of array. |
   |                          |
   |     echo ${!Array[@]}  # |
   |  0 1 2 3                 |
   |                        # |
   |  All the indices of Arra |
   | y.                       |
   |                          |
   |     for i in ${!Array[@] |
   | }                        |
   |     do                   |
   |       echo ${Array[i]} # |
   |  element-zero            |
   |                        # |
   |  element-one             |
   |                        # |
   |  element-two             |
   |                        # |
   |  element-three           |
   |                        # |
   |                        # |
   |  All the elements in Arr |
   | ay.                      |
   |     done                 |
                             
   +--------------------------+--------------------------+--------------------------+

-  

   The **=~** `Regular Expression <regexp.html#REGEXREF>`__ matching
   operator within a `double
   brackets <testconstructs.html#DBLBRACKETS>`__ test expression. (Perl
   has a similar operator.)

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |                          |
   |     variable="This is a  |
   | fine mess."              |
   |                          |
   |     echo "$variable"     |
   |                          |
   |     # Regex matching wit |
   | h =~ operator within [[  |
   | double brackets ]].      |
   |     if [[ "$variable" =~ |
   |  T.........fin*es* ]]    |
   |     # NOTE: As of versio |
   | n 3.2 of Bash, expressio |
   | n to match no longer quo |
   | ted.                     |
   |     then                 |
   |       echo "match found" |
   |           # match found  |
   |     fi                   |
                             
   +--------------------------+--------------------------+--------------------------+

   Or, more usefully:

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |                          |
   |     input=$1             |
   |                          |
   |                          |
   |     if [[ "$input" =~ "[ |
   | 0-9][0-9][0-9]-[0-9][0-9 |
   | ]-[0-9][0-9][0-9][0-9]"  |
   | ]]                       |
   |     #                 ^  |
   | NOTE: Quoting not necess |
   | ary, as of version 3.2 o |
   | f Bash.                  |
   |     # NNN-NN-NNNN (where |
   |  each N is a digit).     |
   |     then                 |
   |       echo "Social Secur |
   | ity number."             |
   |       # Process SSN.     |
   |     else                 |
   |       echo "Not a Social |
   |  Security number!"       |
   |       # Or, ask for corr |
   | ected input.             |
   |     fi                   |
                             
   +--------------------------+--------------------------+--------------------------+

   For additional examples of using the **=~** operator, see `Example
   A-29 <contributed-scripts.html#WHX>`__ , `Example
   19-14 <x17837.html#MAILBOXGREP>`__ , `Example
   A-35 <contributed-scripts.html#FINDSPLIT>`__ , and `Example
   A-24 <contributed-scripts.html#TOHTML>`__ .

-  

   The new ``        set -o pipefail       `` option is useful for
   debugging `pipes <special-chars.html#PIPEREF>`__ . If this option is
   set, then the `exit status <exit-status.html#EXITSTATUSREF>`__ of a
   pipe is the exit status of the last command in the pipe to *fail*
   (return a non-zero value), rather than the actual final command in
   the pipe.

   See `Example 16-43 <communications.html#FC4UPD>`__ .

.. raw:: html

   <div class="CAUTION">

+--------------------------+--------------------------+--------------------------+
| |Caution|                |
| The update to version 3  |
| of Bash breaks a few     |
| scripts that worked      |
| under earlier versions.  |
| *Test critical legacy    |
| scripts to make sure     |
| they still work!*        |
|                          |
| As it happens, a couple  |
| of the scripts in the    |
| *Advanced Bash Scripting |
| Guide* had to be fixed   |
| up (see `Example         |
| 9-4 <internalvariables.h |
| tml#TOUT>`__             |
| , for instance).         |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="SECT2">

  37.2.1. Bash, version 3.1
--------------------------

The version 3.1 update of Bash introduces a number of bugfixes and a few
minor changes.

-  The += operator is now permitted in in places where previously only
   the = assignment operator was recognized.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     a=1                  |
   |     echo $a        # 1   |
   |                          |
   |     a+=5           # Won |
   | 't work under versions o |
   | f Bash earlier than 3.1. |
   |     echo $a        # 15  |
   |                          |
   |     a+=Hello             |
   |     echo $a        # 15H |
   | ello                     |
                             
   +--------------------------+--------------------------+--------------------------+

   Here, += functions as a *string concatenation* operator. Note that
   its behavior in this particular context is different than within a
   `let <internal.html#LETREF>`__ construct.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     a=1                  |
   |     echo $a        # 1   |
   |                          |
   |     let a+=5       # Int |
   | eger arithmetic, rather  |
   | than string concatenatio |
   | n.                       |
   |     echo $a        # 6   |
   |                          |
   |     let a+=Hello   # Doe |
   | sn't "add" anything to a |
   | .                        |
   |     echo $a        # 6   |
                             
   +--------------------------+--------------------------+--------------------------+

    Jeffrey Haemer points out that this concatenation operator can be
   quite useful. In this instance, we append a directory to the
   ``         $PATH        `` .

   +--------------------------+--------------------------+--------------------------+
   | .. code:: SCREEN         |
   |                          |
   |     bash$ echo $PATH     |
   |     /usr/bin:/bin:/usr/l |
   | ocal/bin:/usr/X11R6/bin/ |
   | :/usr/games              |
   |                          |
   |                          |
   |     bash$ PATH+=:/opt/bi |
   | n                        |
   |                          |
   |     bash$ echo $PATH     |
   |     /usr/bin:/bin:/usr/l |
   | ocal/bin:/usr/X11R6/bin/ |
   | :/usr/games:/opt/bin     |
   |                          |
                             
   +--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="SECT2">

  37.2.2. Bash, version 3.2
--------------------------

This is pretty much a bugfix update.

-  In `*global* parameter
   substitutions <parameter-substitution.html#PSGLOB>`__ , the pattern
   no longer anchors at the start of the string.

-  The ``         --wordexp        `` option disables `process
   substitution <process-sub.html#PROCESSSUBREF>`__ .

-  The **=~** `Regular Expression match
   operator <bashver3.html#REGEXMATCHREF>`__ no longer requires
   `quoting <quoting.html#QUOTINGREF>`__ of the *pattern* within `[[ ...
   ]] <testconstructs.html#DBLBRACKETS>`__ .

   .. raw:: html

      <div class="CAUTION">

   +--------------------------+--------------------------+--------------------------+
   | |Caution|                |
   | In fact, quoting in this |
   | context is *not*         |
   | advisable as it may      |
   | cause *regex* evaluation |
   | to fail. Chet Ramey      |
   | states in the `Bash      |
   | FAQ <biblio.html#BASHFAQ |
   | >`__                     |
   | that quoting explicitly  |
   | disables regex           |
   | evaluation. See also the |
   | `Ubuntu Bug              |
   | List <https://bugs.launc |
   | hpad.net/ubuntu-website/ |
   | +bug/109931>`__          |
   | and `Wikinerds on Bash   |
   | syntax <http://en.wikine |
   | rds.org/index.php/Bash_s |
   | yntax_and_semantics>`__  |
   | .                        |
   |                          |
   | Setting *shopt -s        |
   | compat31* in a script    |
   | causes reversion to the  |
   | original behavior.       |
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <bashver2.html>`__ | Bash, version 2          |
| `Home <index.html>`__    | `Up <bash2.html>`__      |
| `Next <bashver4.html>`__ | Bash, version 4          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
