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

`Prev <bashver3.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 37. Bash, versions 2, 3, and 4

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <endnotes.html>`__

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

37.3. Bash, version 4
=====================

Chet Ramey announced Version 4 of Bash on the 20th of February, 2009.
This release has a number of significant new features, as well as some
important bugfixes.

Among the new goodies:

-  Associative arrays. `[1] <bashver4.html#FTN.AEN21025>`__

   +--------------------------------------------------------------------------+
   | .. raw:: html                                                            |
   |                                                                          |
   |    <div class="SIDEBAR">                                                 |
   |                                                                          |
   | An *associative* array can be thought of as a set of two linked arrays   |
   | -- one holding the *data*, and the other the *keys* that index the       |
   | individual elements of the *data* array.                                 |
   |                                                                          |
   | .. raw:: html                                                            |
   |                                                                          |
   |    </div>                                                                |
                                                                             
   +--------------------------------------------------------------------------+

   .. raw:: html

      <div class="EXAMPLE">

   **Example 37-5. A simple address database**

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |     # fetch_address.sh   |
   |                          |
   |     declare -A address   |
   |     #       -A option de |
   | clares associative array |
   | .                        |
   |                          |
   |     address[Charles]="41 |
   | 4 W. 10th Ave., Baltimor |
   | e, MD 21236"             |
   |     address[John]="202 E |
   | . 3rd St., New York, NY  |
   | 10009"                   |
   |     address[Wilma]="1854 |
   |  Vermont Ave, Los Angele |
   | s, CA 90023"             |
   |                          |
   |                          |
   |     echo "Charles's addr |
   | ess is ${address[Charles |
   | ]}."                     |
   |     # Charles's address  |
   | is 414 W. 10th Ave., Bal |
   | timore, MD 21236.        |
   |     echo "Wilma's addres |
   | s is ${address[Wilma]}." |
   |     # Wilma's address is |
   |  1854 Vermont Ave, Los A |
   | ngeles, CA 90023.        |
   |     echo "John's address |
   |  is ${address[John]}."   |
   |     # John's address is  |
   | 202 E. 3rd St., New York |
   | , NY 10009.              |
   |                          |
   |     echo                 |
   |                          |
   |     echo "${!address[*]} |
   | "   # The array indices  |
   | ...                      |
   |     # Charles John Wilma |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

   .. raw:: html

      <div class="EXAMPLE">

   **Example 37-6. A somewhat more elaborate address database**

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |     # fetch_address-2.sh |
   |     # A more elaborate v |
   | ersion of fetch_address. |
   | sh.                      |
   |                          |
   |     SUCCESS=0            |
   |     E_DB=99    # Error c |
   | ode for missing entry.   |
   |                          |
   |     declare -A address   |
   |     #       -A option de |
   | clares associative array |
   | .                        |
   |                          |
   |                          |
   |     store_address ()     |
   |     {                    |
   |       address[$1]="$2"   |
   |       return $?          |
   |     }                    |
   |                          |
   |                          |
   |     fetch_address ()     |
   |     {                    |
   |       if [[ -z "${addres |
   | s[$1]}" ]]               |
   |       then               |
   |         echo "$1's addre |
   | ss is not in database."  |
   |         return $E_DB     |
   |       fi                 |
   |                          |
   |       echo "$1's address |
   |  is ${address[$1]}."     |
   |       return $?          |
   |     }                    |
   |                          |
   |                          |
   |     store_address "Lucas |
   |  Fayne" "414 W. 13th Ave |
   | ., Baltimore, MD 21236"  |
   |     store_address "Arvid |
   |  Boyce" "202 E. 3rd St., |
   |  New York, NY 10009"     |
   |     store_address "Velma |
   |  Winston" "1854 Vermont  |
   | Ave, Los Angeles, CA 900 |
   | 23"                      |
   |     #  Exercise:         |
   |     #  Rewrite the above |
   |  store_address calls to  |
   | read data from a file,   |
   |     #+ then assign field |
   |  1 to name, field 2 to a |
   | ddress in the array.     |
   |     #  Each line in the  |
   | file would have a format |
   |  corresponding to the ab |
   | ove.                     |
   |     #  Use a while-read  |
   | loop to read from file,  |
   | sed or awk to parse the  |
   | fields.                  |
   |                          |
   |     fetch_address "Lucas |
   |  Fayne"                  |
   |     # Lucas Fayne's addr |
   | ess is 414 W. 13th Ave., |
   |  Baltimore, MD 21236.    |
   |     fetch_address "Velma |
   |  Winston"                |
   |     # Velma Winston's ad |
   | dress is 1854 Vermont Av |
   | e, Los Angeles, CA 90023 |
   | .                        |
   |     fetch_address "Arvid |
   |  Boyce"                  |
   |     # Arvid Boyce's addr |
   | ess is 202 E. 3rd St., N |
   | ew York, NY 10009.       |
   |     fetch_address "Bozo  |
   | Bozeman"                 |
   |     # Bozo Bozeman's add |
   | ress is not in database. |
   |                          |
   |     exit $?   # In this  |
   | case, exit code = 99, si |
   | nce that is function ret |
   | urn.                     |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

   See `Example A-53 <contributed-scripts.html#SAMORSE>`__ for an
   interesting usage of an *associative array*.

   .. raw:: html

      <div class="CAUTION">

   +----------------+----------------+----------------+----------------+----------------+
   | |Caution|      |
   | Elements of    |
   | the *index*    |
   | array may      |
   | include        |
   | embedded       |
   | `space         |
   | characters <sp |
   | ecial-chars.ht |
   | ml#WHITESPACER |
   | EF>`__,        |
   | or even        |
   | leading and/or |
   | trailing space |
   | characters.    |
   | However, index |
   | array elements |
   | containing     |
   | *only*         |
   | *whitespace*   |
   | are *not*      |
   | permitted.     |
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
   | |     address[ |
   |    ]="Blank" | |
   | |    # Error!  |
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

-  Enhancements to the `case <testbranch.html#CASEESAC1>`__ construct:
   the ``;;&`` and ``;&`` terminators.

   .. raw:: html

      <div class="EXAMPLE">

   **Example 37-7. Testing characters**

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |                          |
   |     test_char ()         |
   |     {                    |
   |       case "$1" in       |
   |         [[:print:]] )  e |
   | cho "$1 is a printable c |
   | haracter.";;&       # |  |
   |         # The ;;& termin |
   | ator continues to the ne |
   | xt pattern test.      |  |
   |         [[:alnum:]] )  e |
   | cho "$1 is an alpha/nume |
   | ric character.";;&  # v  |
   |         [[:alpha:]] )  e |
   | cho "$1 is an alphabetic |
   |  character.";;&     # v  |
   |         [[:lower:]] )  e |
   | cho "$1 is a lowercase a |
   | lphabetic character.";;& |
   |         [[:digit:]] )  e |
   | cho "$1 is an numeric ch |
   | aracter.";&         # |  |
   |         # The ;& termina |
   | tor executes the next st |
   | atement ...         # |  |
   |         %%%@@@@@    )  e |
   | cho "******************* |
   | *************";;    # v  |
   |     #   ^^^^^^^^  ... ev |
   | en with a dummy pattern. |
   |       esac               |
   |     }                    |
   |                          |
   |     echo                 |
   |                          |
   |     test_char 3          |
   |     # 3 is a printable c |
   | haracter.                |
   |     # 3 is an alpha/nume |
   | ric character.           |
   |     # 3 is an numeric ch |
   | aracter.                 |
   |     # ****************** |
   | **************           |
   |     echo                 |
   |                          |
   |     test_char m          |
   |     # m is a printable c |
   | haracter.                |
   |     # m is an alpha/nume |
   | ric character.           |
   |     # m is an alphabetic |
   |  character.              |
   |     # m is a lowercase a |
   | lphabetic character.     |
   |     echo                 |
   |                          |
   |     test_char /          |
   |     # / is a printable c |
   | haracter.                |
   |                          |
   |     echo                 |
   |                          |
   |     # The ;;& terminator |
   |  can save complex if/the |
   | n conditions.            |
   |     # The ;& is somewhat |
   |  less useful.            |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

-  The new **coproc** builtin enables two parallel
   `processes <special-chars.html#PROCESSREF>`__ to communicate and
   interact. As Chet Ramey states in the `Bash
   FAQ <biblio.html#BASHFAQ>`__ `[2] <bashver4.html#FTN.AEN21068>`__ ,
   ver. 4.01:

       |     There is a new 'coproc' reserved word that specifies a coprocess:
       | 
           an asynchronous command run with two pipes connected to the creating
       | 
           shell. Coprocs can be named. The input and output file descriptors
       | 
           and the PID of the coprocess are available to the calling shell in
       |      variables with coproc-specific names.
       |      George Dimitriu explains,
       | 
           "... coproc ... is a feature used in Bash process substitution,
       |      which now is made publicly available."
       | 
           This means it can be explicitly invoked in a script, rather than
       |      just being a behind-the-scenes mechanism used by Bash.
       |        

   Coprocesses use *file descriptors*. `File descriptors enable
   processes and pipes to communicate <io-redirection.html#FDREF2>`__.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |     # A coprocess commun |
   | icates with a while-read |
   |  loop.                   |
   |                          |
   |                          |
   |     coproc { cat mx_data |
   | .txt; sleep 2; }         |
   |     #                    |
   |       ^^^^^^^            |
   |     # Try running this w |
   | ithout "sleep 2" and see |
   |  what happens.           |
   |                          |
   |     while read -u ${COPR |
   | OC[0]} line    #  ${COPR |
   | OC[0]} is the            |
   |     do                   |
   |                #+ file d |
   | escriptor of the coproce |
   | ss.                      |
   |       echo "$line" | sed |
   |  -e 's/line/NOT-ORIGINAL |
   | -TEXT/'                  |
   |     done                 |
   |                          |
   |     kill $COPROC_PID     |
   |                #  No lon |
   | ger need the coprocess,  |
   |                          |
   |                #+ so kil |
   | l its PID.               |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

   But, be careful!

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |                          |
   |     echo; echo           |
   |     a=aaa                |
   |     b=bbb                |
   |     c=ccc                |
   |                          |
   |     coproc echo "one two |
   |  three"                  |
   |     while read -u ${COPR |
   | OC[0]} a b c;  #  Note t |
   | hat this loop            |
   |     do                   |
   |                #+ runs i |
   | n a subshell.            |
   |       echo "Inside while |
   | -read loop: ";           |
   |       echo "a = $a"; ech |
   | o "b = $b"; echo "c = $c |
   | "                        |
   |       echo "coproc file  |
   | descriptor: ${COPROC[0]} |
   | "                        |
   |     done                 |
   |                          |
   |     # a = one            |
   |     # b = two            |
   |     # c = three          |
   |     # So far, so good, b |
   | ut ...                   |
   |                          |
   |     echo "-------------- |
   | ---"                     |
   |     echo "Outside while- |
   | read loop: "             |
   |     echo "a = $a"  # a = |
   |     echo "b = $b"  # b = |
   |     echo "c = $c"  # c = |
   |     echo "coproc file de |
   | scriptor: ${COPROC[0]}"  |
   |     echo                 |
   |     #  The coproc is sti |
   | ll running, but ...      |
   |     #+ it still doesn't  |
   | enable the parent proces |
   | s                        |
   |     #+ to "inherit" vari |
   | ables from the child pro |
   | cess, the while-read loo |
   | p.                       |
   |                          |
   |     #  Compare this to t |
   | he "badread.sh" script.  |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

   .. raw:: html

      <div class="CAUTION">

   +--------------------------+--------------------------+--------------------------+
   | |Caution|                |
   | The coprocess is         |
   | *asynchronous*, and this |
   | might cause a problem.   |
   | It may terminate before  |
   | another process has      |
   | finished communicating   |
   | with it.                 |
   |                          |
   | +----------------------- |
   | ---+-------------------- |
   | ------+----------------- |
   | ---------+               |
   | | .. code:: PROGRAMLISTI |
   | NG |                     |
   | |                        |
   |    |                     |
   | |     #!/bin/bash4       |
   |    |                     |
   | |                        |
   |    |                     |
   | |     coproc cpname { fo |
   | r  |                     |
   | | i in {0..10}; do echo  |
   | "i |                     |
   | | ndex = $i"; done; }    |
   |    |                     |
   | |     #      ^^^^^^ This |
   |  i |                     |
   | | s a *named* coprocess. |
   |    |                     |
   | |     read -u ${cpname[0 |
   | ]} |                     |
   | |     echo $REPLY        |
   |    |                     |
   | | #  index = 0           |
   |    |                     |
   | |     echo ${COPROC[0]}  |
   |    |                     |
   | | #+ No output ... the c |
   | op |                     |
   | | rocess timed out       |
   |    |                     |
   | |     #  after the first |
   |  l |                     |
   | | oop iteration.         |
   |    |                     |
   | |                        |
   |    |                     |
   | |                        |
   |    |                     |
   | |                        |
   |    |                     |
   | |     # However, George  |
   | Di |                     |
   | | mitriu has a partial f |
   | ix |                     |
   | | .                      |
   |    |                     |
   | |                        |
   |    |                     |
   | |     coproc cpname { fo |
   | r  |                     |
   | | i in {0..10}; do echo  |
   | "i |                     |
   | | ndex = $i"; done; slee |
   | p  |                     |
   | | 1;                     |
   |    |                     |
   | |     echo hi > myo; cat |
   |  - |                     |
   | |  >> myo; }             |
   |    |                     |
   | |     #       ^^^^^ This |
   |  i |                     |
   | | s a *named* coprocess. |
   |    |                     |
   | |                        |
   |    |                     |
   | |     echo "I am main"$' |
   | \0 |                     |
   | | 4' >&${cpname[1]}      |
   |    |                     |
   | |     myfd=${cpname[0]}  |
   |    |                     |
   | |     echo myfd=$myfd    |
   |    |                     |
   | |                        |
   |    |                     |
   | |     ### while read -u  |
   | $m |                     |
   | | yfd                    |
   |    |                     |
   | |     ### do             |
   |    |                     |
   | |     ###   echo $REPLY; |
   |    |                     |
   | |     ### done           |
   |    |                     |
   | |                        |
   |    |                     |
   | |     echo $cpname_PID   |
   |    |                     |
   | |                        |
   |    |                     |
   | |     #  Run this with a |
   | nd |                     |
   | |  without the commented |
   | -o |                     |
   | | ut while-loop, and it  |
   | is |                     |
   | |     #+ apparent that e |
   | ac |                     |
   | | h process, the executi |
   | ng |                     |
   | |  shell and the coproce |
   | ss |                     |
   | | ,                      |
   |    |                     |
   | |     #+ waits for the o |
   | th |                     |
   | | er to finish writing i |
   | n  |                     |
   | | its own write-enabled  |
   | pi |                     |
   | | pe.                    |
   |    |                     |
   |                          |
   |                          |
   | +----------------------- |
   | ---+-------------------- |
   | ------+----------------- |
   | ---------+               |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

-  The new **mapfile** builtin makes it possible to load an array with
   the contents of a text file without using a loop or `command
   substitution <arrays.html#ARRAYINITCS>`__.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |                          |
   |     mapfile Arr1 < $0    |
   |     # Same result as     |
   |  Arr1=( $(cat $0) )      |
   |     echo "${Arr1[@]}"  # |
   |  Copies this entire scri |
   | pt out to stdout.        |
   |                          |
   |     echo "--"; echo      |
   |                          |
   |     # But, not the same  |
   | as   read -a   !!!       |
   |     read -a Arr2 < $0    |
   |     echo "${Arr2[@]}"  # |
   |  Reads only first line o |
   | f script into the array. |
   |                          |
   |     exit                 |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  The `read <internal.html#READREF>`__ builtin got a minor facelift.
   The ``-t`` `timeout <internal.html#READTIMED>`__ option now accepts
   (decimal) fractional values `[3] <bashver4.html#FTN.AEN21096>`__ and
   the ``-i`` option permits preloading the edit buffer.
   `[4] <bashver4.html#FTN.AEN21101>`__ Unfortunately, these
   enhancements are still a work in progress and not (yet) usable in
   scripts.

-   `Parameter substitution <parameter-substitution.html#PARAMSUBREF>`__
   gets *case-modification* operators.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |                          |
   |     var=veryMixedUpVaria |
   | ble                      |
   |     echo ${var}          |
   |    # veryMixedUpVariable |
   |     echo ${var^}         |
   |    # VeryMixedUpVariable |
   |     #         *          |
   |      First char --> uppe |
   | rcase.                   |
   |     echo ${var^^}        |
   |    # VERYMIXEDUPVARIABLE |
   |     #         **         |
   |      All chars  --> uppe |
   | rcase.                   |
   |     echo ${var,}         |
   |    # veryMixedUpVariable |
   |     #         *          |
   |      First char --> lowe |
   | rcase.                   |
   |     echo ${var,,}        |
   |    # verymixedupvariable |
   |     #         **         |
   |      All chars  --> lowe |
   | rcase.                   |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  

   The `declare <declareref.html>`__ builtin now accepts the ``-l``
   *lowercase* and ``-c`` *capitalize* options.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |                          |
   |     declare -l var1      |
   |        # Will change to  |
   | lowercase                |
   |     var1=MixedCaseVARIAB |
   | LE                       |
   |     echo "$var1"         |
   |        # mixedcasevariab |
   | le                       |
   |     # Same effect as     |
   |          echo $var1 | tr |
   |  A-Z a-z                 |
   |                          |
   |     declare -c var2      |
   |        # Changes only in |
   | itial char to uppercase. |
   |     var2=originally_lowe |
   | rcase                    |
   |     echo "$var2"         |
   |        # Originally_lowe |
   | rcase                    |
   |     # NOT the same effec |
   | t as     echo $var2 | tr |
   |  a-z A-Z                 |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-   `Brace expansion <special-chars.html#BRACEEXPREF>`__ has more
   options.

   *Increment/decrement*, specified in the final term within braces.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |                          |
   |     echo {40..60..2}     |
   |     # 40 42 44 46 48 50  |
   | 52 54 56 58 60           |
   |     # All the even numbe |
   | rs, between 40 and 60.   |
   |                          |
   |     echo {60..40..2}     |
   |     # 60 58 56 54 52 50  |
   | 48 46 44 42 40           |
   |     # All the even numbe |
   | rs, between 40 and 60, c |
   | ounting backwards.       |
   |     # In effect, a decre |
   | ment.                    |
   |     echo {60..40..-2}    |
   |     # The same output. T |
   | he minus sign is not nec |
   | essary.                  |
   |                          |
   |     # But, what about le |
   | tters and symbols?       |
   |     echo {X..d}          |
   |     # X Y Z [  ] ^ _ ` a |
   |  b c d                   |
   |     # Does not echo the  |
   | \ which escapes a space. |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

   *Zero-padding*, specified in the first term within braces, prefixes
   each term in the output with the *same number* of zeroes.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: SCREEN         |
   |                          |
   |     bash4$ echo {010..15 |
   | }                        |
   |     010 011 012 013 014  |
   | 015                      |
   |                          |
   |                          |
   |     bash4$ echo {000..10 |
   | }                        |
   |     000 001 002 003 004  |
   | 005 006 007 008 009 010  |
   |                          |
                             
   +--------------------------+--------------------------+--------------------------+

-  

   `*Substring extraction* on *positional
   parameters* <bashver4.html#SUBSTREXTREF4>`__ now starts with
   `$0 <othertypesv.html#SCRNAMEPARAM>`__ as the *zero-index*. (This
   corrects an inconsistency in the treatment of positional parameters.)

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |     # show-params.bash   |
   |     # Requires version 4 |
   | + of Bash.               |
   |                          |
   |     # Invoke this script |
   | s with at least one posi |
   | tional parameter.        |
   |                          |
   |     E_BADPARAMS=99       |
   |                          |
   |     if [ -z "$1" ]       |
   |     then                 |
   |       echo "Usage $0 par |
   | am1 ..."                 |
   |       exit $E_BADPARAMS  |
   |     fi                   |
   |                          |
   |     echo ${@:0}          |
   |                          |
   |     # bash3 show-params. |
   | bash4 one two three      |
   |     # one two three      |
   |                          |
   |     # bash4 show-params. |
   | bash4 one two three      |
   |     # show-params.bash4  |
   | one two three            |
   |                          |
   |     # $0                 |
   | $1  $2  $3               |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  The new \*\* `globbing <globbingref.html>`__ operator matches
   filenames and directories
   `recursively <localvar.html#RECURSIONREF0>`__.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |     # filelist.bash4     |
   |                          |
   |     shopt -s globstar  # |
   |  Must enable globstar, o |
   | therwise ** doesn't work |
   | .                        |
   |                        # |
   |  The globstar shell opti |
   | on is new to version 4 o |
   | f Bash.                  |
   |                          |
   |     echo "Using *"; echo |
   |     for filename in *    |
   |     do                   |
   |       echo "$filename"   |
   |     done   # Lists only  |
   | files in current directo |
   | ry ($PWD).               |
   |                          |
   |     echo; echo "-------- |
   | ------"; echo            |
   |                          |
   |     echo "Using **"      |
   |     for filename in **   |
   |     do                   |
   |       echo "$filename"   |
   |     done   # Lists compl |
   | ete file tree, recursive |
   | ly.                      |
   |                          |
   |     exit                 |
   |                          |
   |     Using *              |
   |                          |
   |     allmyfiles           |
   |     filelist.bash4       |
   |                          |
   |     --------------       |
   |                          |
   |     Using **             |
   |                          |
   |     allmyfiles           |
   |     allmyfiles/file.inde |
   | x.txt                    |
   |     allmyfiles/my_music  |
   |     allmyfiles/my_music/ |
   | me-singing-60s-folksongs |
   | .ogg                     |
   |     allmyfiles/my_music/ |
   | me-singing-opera.ogg     |
   |     allmyfiles/my_music/ |
   | piano-lesson.1.ogg       |
   |     allmyfiles/my_pictur |
   | es                       |
   |     allmyfiles/my_pictur |
   | es/at-beach-with-Jade.pn |
   | g                        |
   |     allmyfiles/my_pictur |
   | es/picnic-with-Melissa.p |
   | ng                       |
   |     filelist.bash4       |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  The new `$BASHPID <internalvariables.html#BASHPIDREF>`__ internal
   variable.

-  

   There is a new `builtin <internal.html#BUILTINREF>`__ error-handling
   function named **command\_not\_found\_handle**.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash4         |
   |                          |
   |     command_not_found_ha |
   | ndle ()                  |
   |     { # Accepts implicit |
   |  parameters.             |
   |       echo "The followin |
   | g command is not valid:  |
   | \""$1\"""                |
   |       echo "With the fol |
   | lowing argument(s): \""$ |
   | 2\"" \""$3\"""   # $4, $ |
   | 5 ...                    |
   |     } # $1, $2, etc. are |
   |  not explicitly passed t |
   | o the function.          |
   |                          |
   |     bad_command arg1 arg |
   | 2                        |
   |                          |
   |     # The following comm |
   | and is not valid: "bad_c |
   | ommand"                  |
   |     # With the following |
   |  argument(s): "arg1" "ar |
   | g2"                      |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| *Editorial comment*                                                      |
|                                                                          |
| Associative arrays? Coprocesses? Whatever happened to the lean and mean  |
| Bash we have come to know and love? Could it be suffering from           |
| (horrors!) "feature creep"? Or perhaps even Korn shell envy?             |
|                                                                          |
| *Note to Chet Ramey:* Please add only *essential* features in future     |
| Bash releases -- perhaps *for-each* loops and support for                |
| multi-dimensional arrays. `[5] <bashver4.html#FTN.AEN21179>`__ Most Bash |
| users won't need, won't use, and likely won't greatly appreciate complex |
| "features" like built-in debuggers, Perl interfaces, and bolt-on rocket  |
| boosters.                                                                |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

.. raw:: html

   <div class="SECT2">

37.3.1. Bash, version 4.1
-------------------------

Version 4.1 of Bash, released in May, 2010, was primarily a bugfix
update.

-  The `printf <internal.html#PRINTFREF>`__ command now accepts a ``-v``
   option for setting `array <arrays.html#ARRAYREF>`__ indices.

-  Within `double brackets <testconstructs.html#DBLBRACKETS>`__, the
   **>** and **<** string comparison operators now conform to the
   `locale <localization.html#LOCALEREF>`__. Since the locale setting
   may affect the sorting order of string expressions, this has
   side-effects on comparison tests within *[[ ... ]]* expressions.

-  The `read <internal.html#READREF>`__ builtin now takes a ``-N``
   option (*read -N chars*), which causes the *read* to terminate after
   *chars* characters.

   .. raw:: html

      <div class="EXAMPLE">

   **Example 37-8. Reading N characters**

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |     # Requires Bash vers |
   | ion -ge 4.1 ...          |
   |                          |
   |     num_chars=61         |
   |                          |
   |     read -N $num_chars v |
   | ar < $0   # Read first 6 |
   | 1 characters of script!  |
   |     echo "$var"          |
   |     exit                 |
   |                          |
   |     ####### Output of Sc |
   | ript #######             |
   |                          |
   |     #!/bin/bash          |
   |     # Requires Bash vers |
   | ion -ge 4.1 ...          |
   |                          |
   |     num_chars=61         |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

-  `Here documents <here-docs.html#HEREDOCREF>`__ embedded in
   ```$( ... )`` command
   substitution <varassignment.html#COMMANDSUBREF0>`__ constructs may
   terminate with a simple **)**.

   .. raw:: html

      <div class="EXAMPLE">

   **Example 37-9. Using a *here document* to set a variable**

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |     # here-commsub.sh    |
   |     # Requires Bash vers |
   | ion -ge 4.1 ...          |
   |                          |
   |     multi_line_var=$( ca |
   | t <<ENDxxx               |
   |     -------------------- |
   | ----------               |
   |     This is line 1 of th |
   | e variable               |
   |     This is line 2 of th |
   | e variable               |
   |     This is line 3 of th |
   | e variable               |
   |     -------------------- |
   | ----------               |
   |     ENDxxx)              |
   |                          |
   |     #  Rather than what  |
   | Bash 4.0 requires:       |
   |     #+ that the terminat |
   | ing limit string and     |
   |     #+ the terminating c |
   | lose-parenthesis be on s |
   | eparate lines.           |
   |                          |
   |     # ENDxxx             |
   |     # )                  |
   |                          |
   |                          |
   |     echo "$multi_line_va |
   | r"                       |
   |                          |
   |     #  Bash still emits  |
   | a warning, though.       |
   |     #  warning: here-doc |
   | ument at line 10 delimit |
   | ed                       |
   |     #+ by end-of-file (w |
   | anted `ENDxxx')          |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="SECT2">

37.3.2. Bash, version 4.2
-------------------------

Version 4.2 of Bash, released in February, 2011, contains a number of
new features and enhancements, in addition to bugfixes.

-  Bash now supports the the ``\u`` and ``\U`` *Unicode* escape.

   +--------------------------------------------------------------------------+
   | .. raw:: html                                                            |
   |                                                                          |
   |    <div class="SIDEBAR">                                                 |
   |                                                                          |
   | Unicode is a cross-platform standard for encoding into numerical values  |
   | letters and graphic symbols. This permits representing and displaying    |
   | characters in foreign alphabets and unusual fonts.                       |
   |                                                                          |
   | .. raw:: html                                                            |
   |                                                                          |
   |    </div>                                                                |
                                                                             
   +--------------------------------------------------------------------------+

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     echo -e '\u2630'   # |
   |  Horizontal triple bar c |
   | haracter.                |
   |     # Equivalent to the  |
   | more roundabout:         |
   |     echo -e "\xE2\x98\xB |
   | 0"                       |
   |                        # |
   |  Recognized by earlier B |
   | ash versions.            |
   |                          |
   |     echo -e '\u220F'   # |
   |  PI (Greek letter and ma |
   | thematical symbol)       |
   |     echo -e '\u0416'   # |
   |  Capital "ZHE" (Cyrillic |
   |  letter)                 |
   |     echo -e '\u2708'   # |
   |  Airplane (Dingbat font) |
   |  symbol                  |
   |     echo -e '\u2622'   # |
   |  Radioactivity trefoil   |
   |                          |
   |     echo -e "The amplifi |
   | er circuit requires a 10 |
   | 0 \u2126 pull-up resisto |
   | r."                      |
   |                          |
   |                          |
   |     unicode_var='\u2640' |
   |     echo -e $unicode_var |
   |       # Female symbol    |
   |     printf "$unicode_var |
   |  \n"  # Female symbol, w |
   | ith newline              |
   |                          |
   |                          |
   |     #  And for something |
   |  a bit more elaborate .  |
   | . .                      |
   |                          |
   |     #  We can store Unic |
   | ode symbols in an associ |
   | ative array,             |
   |     #+ then retrieve the |
   | m by name.               |
   |     #  Run this in a gno |
   | me-terminal or a termina |
   | l with a large, bold fon |
   | t                        |
   |     #+ for better legibi |
   | lity.                    |
   |                          |
   |     declare -A symbol  # |
   |  Associative array.      |
   |                          |
   |     symbol[script_E]='\u |
   | 2130'                    |
   |     symbol[script_F]='\u |
   | 2131'                    |
   |     symbol[script_J]='\u |
   | 2110'                    |
   |     symbol[script_M]='\u |
   | 2133'                    |
   |     symbol[Rx]='\u211E'  |
   |     symbol[TEL]='\u2121' |
   |     symbol[FAX]='\u213B' |
   |     symbol[care_of]='\u2 |
   | 105'                     |
   |     symbol[account]='\u2 |
   | 100'                     |
   |     symbol[trademark]='\ |
   | u2122'                   |
   |                          |
   |                          |
   |     echo -ne "${symbol[s |
   | cript_E]}   "            |
   |     echo -ne "${symbol[s |
   | cript_F]}   "            |
   |     echo -ne "${symbol[s |
   | cript_J]}   "            |
   |     echo -ne "${symbol[s |
   | cript_M]}   "            |
   |     echo -ne "${symbol[R |
   | x]}   "                  |
   |     echo -ne "${symbol[T |
   | EL]}   "                 |
   |     echo -ne "${symbol[F |
   | AX]}   "                 |
   |     echo -ne "${symbol[c |
   | are_of]}   "             |
   |     echo -ne "${symbol[a |
   | ccount]}   "             |
   |     echo -ne "${symbol[t |
   | rademark]}   "           |
   |     echo                 |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

   .. raw:: html

      <div class="NOTE">

   +--------------------------------------+--------------------------------------+
   | |Note|                               |
   | The above example uses the `**$' ... |
   | '** <escapingsection.html#STRQ>`__   |
   | *string-expansion* construct.        |
   +--------------------------------------+--------------------------------------+

   .. raw:: html

      </div>

-  

   When the ``lastpipe`` shell option is set, the last command in a
   `pipe <special-chars.html#PIPEREF>`__ *doesn't run in a subshell*.

   .. raw:: html

      <div class="EXAMPLE">

   **Example 37-10. Piping input to a `read <internal.html#READREF>`__**

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |     # lastpipe-option.sh |
   |                          |
   |     line=''              |
   |       # Null value.      |
   |     echo "\$line = "$lin |
   | e""   # $line =          |
   |                          |
   |     echo                 |
   |                          |
   |     shopt -s lastpipe    |
   |       # Error on Bash ve |
   | rsion -lt 4.2.           |
   |     echo "Exit status of |
   |  attempting to set \"las |
   | tpipe\" option is $?"    |
   |     #     1 if Bash vers |
   | ion -lt 4.2, 0 otherwise |
   | .                        |
   |                          |
   |     echo                 |
   |                          |
   |     head -1 $0 | read li |
   | ne    # Pipe the first l |
   | ine of the script to rea |
   | d.                       |
   |     #            ^^^^^^^ |
   | ^^      Not in a subshel |
   | l!!!                     |
   |                          |
   |     echo "\$line = "$lin |
   | e""                      |
   |     # Older Bash release |
   | s       $line =          |
   |     # Bash version 4.2   |
   |         $line = #!/bin/b |
   | ash                      |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

   This option offers possible "fixups" for these example scripts:
   `Example 34-3 <gotchas.html#BADREAD>`__ and `Example
   15-8 <internal.html#READPIPE>`__.

-  Negative `array <arrays.html#ARRAYREF>`__ indices permit counting
   backwards from the end of an array.

   .. raw:: html

      <div class="EXAMPLE">

   **Example 37-11. Negative array indices**

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |     # neg-array.sh       |
   |     # Requires Bash, ver |
   | sion -ge 4.2.            |
   |                          |
   |     array=( zero one two |
   |  three four five )   # S |
   | ix-element array.        |
   |     #         0    1   2 |
   |     3    4    5          |
   |     #        -6   -5  -4 |
   |    -3   -2   -1          |
   |                          |
   |     # Negative array ind |
   | ices now permitted.      |
   |     echo ${array[-1]}    |
   | # five                   |
   |     echo ${array[-2]}    |
   | # four                   |
   |     # ...                |
   |     echo ${array[-6]}    |
   | # zero                   |
   |     # Negative array ind |
   | ices count backward from |
   |  the last element+1.     |
   |                          |
   |     # But, you cannot in |
   | dex past the beginning o |
   | f the array.             |
   |     echo ${array[-7]}    |
   | # array: bad array subsc |
   | ript                     |
   |                          |
   |                          |
   |     # So, what is this n |
   | ew feature good for?     |
   |                          |
   |     echo "The last eleme |
   | nt in the array is "${ar |
   | ray[-1]}""               |
   |     # Which is quite a b |
   | it more straightforward  |
   | than:                    |
   |     echo "The last eleme |
   | nt in the array is "${ar |
   | ray[${#array[*]}-1]}""   |
   |     echo                 |
   |                          |
   |     # And ...            |
   |                          |
   |     index=0              |
   |     let "neg_element_cou |
   | nt = 0 - ${#array[*]}"   |
   |     # Number of elements |
   | , converted to a negativ |
   | e number.                |
   |                          |
   |     while [ $index -gt $ |
   | neg_element_count ]; do  |
   |       ((index--)); echo  |
   | -n "${array[index]} "    |
   |     done  # Lists the el |
   | ements in the array, bac |
   | kwards.                  |
   |           # We have just |
   |  simulated the "tac" com |
   | mand on this array.      |
   |                          |
   |     echo                 |
   |                          |
   |     # See also neg-offse |
   | t.sh.                    |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

-  `Substring extraction <string-manipulation.html#SUBSTREXTR01>`__ uses
   a negative *length* parameter to specify an offset from the *end* of
   the target string.

   .. raw:: html

      <div class="EXAMPLE">

   **Example 37-12. Negative parameter in string-extraction construct**

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     #!/bin/bash          |
   |     # Bash, version -ge  |
   | 4.2                      |
   |     # Negative length-in |
   | dex in substring extract |
   | ion.                     |
   |     # Important: It chan |
   | ges the interpretation o |
   | f this construct!        |
   |                          |
   |     stringZ=abcABC123ABC |
   | abc                      |
   |                          |
   |     echo ${stringZ}      |
   |                          |
   |  # abcABC123ABCabc       |
   |     #                    |
   | Position within string:  |
   |    0123456789.....       |
   |     echo ${stringZ:2:3}  |
   |                          |
   |  #   cAB                 |
   |     #  Count 2 chars for |
   | ward from string beginni |
   | ng, and extract 3 chars. |
   |     #  ${string:position |
   | :length}                 |
   |                          |
   |     #  So far, nothing n |
   | ew, but now ...          |
   |                          |
   |                          |
   |                          |
   |  # abcABC123ABCabc       |
   |     #                    |
   | Position within string:  |
   |    0123....6543210       |
   |     echo ${stringZ:3:-6} |
   |                          |
   |  #    ABC123             |
   |     #                ^   |
   |     #  Index 3 chars for |
   | ward from beginning and  |
   | 6 chars backward from en |
   | d,                       |
   |     #+ and extract every |
   | thing in between.        |
   |     #  ${string:offset-f |
   | rom-front:offset-from-en |
   | d}                       |
   |     #  When the "length" |
   |  parameter is negative,  |
   |     #+ it serves as an o |
   | ffset-from-end parameter |
   | .                        |
   |                          |
   |     #  See also neg-arra |
   | y.sh.                    |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </div>

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <bashver4.html#AEN21025>`__     | `[2] <bashver4.html#AEN21068>`__     |
| To be more specific, Bash 4+ has     | Copyright 1995-2009 by Chester       |
| *limited* support for associative    | Ramey.                               |
| arrays. It's a bare-bones            |                                      |
| implementation, and it lacks the     |                                      |
| much of the functionality of such    |                                      |
| arrays in other programming          |                                      |
| languages. Note, however, that       |                                      |
| `associative arrays in Bash seem to  |                                      |
| execute faster and more efficiently  |                                      |
| than numerically-indexed             |                                      |
| arrays <optimizations.html#ASSOCARRT |                                      |
| ST>`__.                              |                                      |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <bashver3.html>`__ | Bash, version 3          |
| `Home <index.html>`__    | `Up <bash2.html>`__      |
| `Next <endnotes.html>`__ | Endnotes                 |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Note| image:: ../images/note.gif
