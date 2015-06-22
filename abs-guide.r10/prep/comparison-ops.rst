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

`Prev <fto.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 7. Tests

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <nestedifthen.html>`__

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

  7.3. Other Comparison Operators
================================

A *binary* comparison operator compares two variables or quantities.
*Note that integer and string comparison use a different set of
operators.*

.. raw:: html

   <div class="VARIABLELIST">

** integer comparison**

 -eq
    is equal to

    ``                   if [ "$a" -eq "$b" ]                 ``

 -ne
    is not equal to

    ``                   if [ "$a" -ne "$b" ]                 ``

 -gt
    is greater than

    ``                   if [ "$a" -gt "$b" ]                 ``

 -ge
    is greater than or equal to

    ``                   if [ "$a" -ge "$b" ]                 ``

 -lt
    is less than

    ``                   if [ "$a" -lt "$b" ]                 ``

 -le
    is less than or equal to

    ``                   if [ "$a" -le "$b" ]                 ``

 <
    is less than (within `double parentheses <dblparens.html>`__ )

    ``                   (("$a" < "$b"))                 ``

 <=
    is less than or equal to (within double parentheses)

    ``                   (("$a" <= "$b"))                 ``

 >
    is greater than (within double parentheses)

    ``                   (("$a" > "$b"))                 ``

 >=
    is greater than or equal to (within double parentheses)

    ``                   (("$a" >= "$b"))                 ``

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** string comparison**

 =

    is equal to

    ``                   if [ "$a" = "$b" ]                 ``

    .. raw:: html

       <div class="CAUTION">

    +--------------------------+--------------------------+--------------------------+
    | |Caution|                |
    | Note the                 |
    | `whitespace <special-cha |
    | rs.html#WHITESPACEREF>`_ |
    | _                        |
    | framing the **=** .      |
    |                          |
    | ``                       |
    |      if [ "$a"="$b" ]    |
    |                       `` |
    | is *not* equivalent to   |
    | the above.               |
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 ==
    is equal to

    ``                   if [ "$a" == "$b" ]                 ``

    This is a synonym for = .

    .. raw:: html

       <div class="NOTE">

    +--------------------------+--------------------------+--------------------------+
    | |Note|                   |
    | The == comparison        |
    | operator behaves         |
    | differently within a     |
    | `double-brackets <testco |
    | nstructs.html#DBLBRACKET |
    | S>`__                    |
    | test than within single  |
    | brackets.                |
    |                          |
    | +----------------------- |
    | ---+-------------------- |
    | ------+----------------- |
    | ---------+               |
    | | .. code:: PROGRAMLISTI |
    | NG |                     |
    | |                        |
    |    |                     |
    | |     [[ $a == z* ]]   # |
    |  T |                     |
    | | rue if $a starts with  |
    | an |                     |
    | |  "z" (pattern matching |
    | ). |                     |
    | |     [[ $a == "z*" ]] # |
    |  T |                     |
    | | rue if $a is equal to  |
    | z* |                     |
    | |  (literal matching).   |
    |    |                     |
    | |                        |
    |    |                     |
    | |     [ $a == z* ]     # |
    |  F |                     |
    | | ile globbing and word  |
    | sp |                     |
    | | litting take place.    |
    |    |                     |
    | |     [ "$a" == "z*" ] # |
    |  T |                     |
    | | rue if $a is equal to  |
    | z* |                     |
    | |  (literal matching).   |
    |    |                     |
    | |                        |
    |    |                     |
    | |     # Thanks, StĂŠphan |
    | e  |                     |
    | | Chazelas               |
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

 !=
    is not equal to

    ``                   if [ "$a" != "$b" ]                 ``

    This operator uses pattern matching within a `[[ ...
    ]] <testconstructs.html#DBLBRACKETS>`__ construct.

 <
    is less than, in `ASCII <special-chars.html#ASCIIDEF>`__
    alphabetical order

    ``                   if [[ "$a" < "$b" ]]                 ``

    ``                   if [ "$a" \< "$b" ]                 ``

    Note that the "<" needs to be
    `escaped <escapingsection.html#ESCP>`__ within a
    ``                   [  ]                 `` construct.

 >
    is greater than, in ASCII alphabetical order

    ``                   if [[ "$a" > "$b" ]]                 ``

    ``                   if [ "$a" \> "$b" ]                 ``

    Note that the ">" needs to be escaped within a
    ``                   [  ]                 `` construct.

    See `Example 27-11 <arrays.html#BUBBLE>`__ for an application of
    this comparison operator.

 -z
    string is *null* , that is, has zero length

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |      String=''   # Zero- |
    | length ("null") string v |
    | ariable.                 |
    |                          |
    |     if [ -z "$String" ]  |
    |     then                 |
    |       echo "\$String is  |
    | null."                   |
    |     else                 |
    |       echo "\$String is  |
    | NOT null."               |
    |     fi     # $String is  |
    | null.                    |
                              
    +--------------------------+--------------------------+--------------------------+

 -n
    string is not *null.*

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | The                                  |
    | ``                           -n      |
    |                     ``               |
    | test requires that the string be     |
    | quoted within the test brackets.     |
    | Using an unquoted string with *! -z* |
    | , or even just the unquoted string   |
    | alone within test brackets (see      |
    | `Example                             |
    | 7-6 <comparison-ops.html#STRTEST>`__ |
    | ) normally works, however, this is   |
    | an unsafe practice. *Always* quote a |
    | tested string. ` [1]                 |
    |  <comparison-ops.html#FTN.AEN3669>`_ |
    | _                                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 7-5. Arithmetic and string comparisons**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     a=4                  |
|     b=5                  |
|                          |
|     #  Here "a" and "b"  |
| can be treated either as |
|  integers or strings.    |
|     #  There is some blu |
| rring between the arithm |
| etic and string comparis |
| ons,                     |
|     #+ since Bash variab |
| les are not strongly typ |
| ed.                      |
|                          |
|     #  Bash permits inte |
| ger operations and compa |
| risons on variables      |
|     #+ whose value consi |
| sts of all-integer chara |
| cters.                   |
|     #  Caution advised,  |
| however.                 |
|                          |
|     echo                 |
|                          |
|     if [ "$a" -ne "$b" ] |
|     then                 |
|       echo "$a is not eq |
| ual to $b"               |
|       echo "(arithmetic  |
| comparison)"             |
|     fi                   |
|                          |
|     echo                 |
|                          |
|     if [ "$a" != "$b" ]  |
|     then                 |
|       echo "$a is not eq |
| ual to $b."              |
|       echo "(string comp |
| arison)"                 |
|       #     "4"  != "5"  |
|       # ASCII 52 != ASCI |
| I 53                     |
|     fi                   |
|                          |
|     # In this particular |
|  instance, both "-ne" an |
| d "!=" work.             |
|                          |
|     echo                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 7-6. Testing whether a string is *null***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     #  str-test.sh: Test |
| ing null strings and unq |
| uoted strings,           |
|     #+ but not strings a |
| nd sealing wax, not to m |
| ention cabbages and king |
| s . . .                  |
|                          |
|     # Using   if [ ... ] |
|                          |
|     # If a string has no |
| t been initialized, it h |
| as no defined value.     |
|     # This state is call |
| ed "null" (not the same  |
| as zero!).               |
|                          |
|     if [ -n $string1 ]   |
|   # string1 has not been |
|  declared or initialized |
| .                        |
|     then                 |
|       echo "String \"str |
| ing1\" is not null."     |
|     else                 |
|       echo "String \"str |
| ing1\" is null."         |
|     fi                   |
|   # Wrong result.        |
|     # Shows $string1 as  |
| not null, although it wa |
| s not initialized.       |
|                          |
|     echo                 |
|                          |
|     # Let's try it again |
| .                        |
|                          |
|     if [ -n "$string1" ] |
|   # This time, $string1  |
| is quoted.               |
|     then                 |
|       echo "String \"str |
| ing1\" is not null."     |
|     else                 |
|       echo "String \"str |
| ing1\" is null."         |
|     fi                   |
|   # Quote strings within |
|  test brackets!          |
|                          |
|     echo                 |
|                          |
|     if [ $string1 ]      |
|   # This time, $string1  |
| stands naked.            |
|     then                 |
|       echo "String \"str |
| ing1\" is not null."     |
|     else                 |
|       echo "String \"str |
| ing1\" is null."         |
|     fi                   |
|   # This works fine.     |
|     # The [ ... ] test o |
| perator alone detects wh |
| ether the string is null |
| .                        |
|     # However it is good |
|  practice to quote it (i |
| f [ "$string1" ]).       |
|     #                    |
|     # As Stephane Chazel |
| as points out,           |
|     #    if [ $string1 ] |
|     has one argument, "] |
| "                        |
|     #    if [ "$string1" |
|  ]  has two arguments, t |
| he empty "$string1" and  |
| "]"                      |
|                          |
|                          |
|     echo                 |
|                          |
|                          |
|     string1=initialized  |
|                          |
|     if [ $string1 ]      |
|   # Again, $string1 stan |
| ds unquoted.             |
|     then                 |
|       echo "String \"str |
| ing1\" is not null."     |
|     else                 |
|       echo "String \"str |
| ing1\" is null."         |
|     fi                   |
|   # Again, gives correct |
|  result.                 |
|     # Still, it is bette |
| r to quote it ("$string1 |
| "), because . . .        |
|                          |
|                          |
|     string1="a = b"      |
|                          |
|     if [ $string1 ]      |
|   # Again, $string1 stan |
| ds unquoted.             |
|     then                 |
|       echo "String \"str |
| ing1\" is not null."     |
|     else                 |
|       echo "String \"str |
| ing1\" is null."         |
|     fi                   |
|   # Not quoting "$string |
| 1" now gives wrong resul |
| t!                       |
|                          |
|     exit 0   # Thank you |
| , also, Florian Wisser,  |
| for the "heads-up".      |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 7-7. *zmore***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # zmore              |
|                          |
|     # View gzipped files |
|  with 'more' filter.     |
|                          |
|     E_NOARGS=85          |
|     E_NOTFOUND=86        |
|     E_NOTGZIP=87         |
|                          |
|     if [ $# -eq 0 ] # sa |
| me effect as:  if [ -z " |
| $1" ]                    |
|     # $1 can exist, but  |
| be empty:  zmore "" arg2 |
|  arg3                    |
|     then                 |
|       echo "Usage: `base |
| name $0` filename" >&2   |
|       # Error message to |
|  stderr.                 |
|       exit $E_NOARGS     |
|       # Returns 85 as ex |
| it status of script (err |
| or code).                |
|     fi                   |
|                          |
|     filename=$1          |
|                          |
|     if [ ! -f "$filename |
| " ]   # Quoting $filenam |
| e allows for possible sp |
| aces.                    |
|     then                 |
|       echo "File $filena |
| me not found!" >&2   # E |
| rror message to stderr.  |
|       exit $E_NOTFOUND   |
|     fi                   |
|                          |
|     if [ ${filename##*.} |
|  != "gz" ]               |
|     # Using bracket in v |
| ariable substitution.    |
|     then                 |
|       echo "File $1 is n |
| ot a gzipped file!"      |
|       exit $E_NOTGZIP    |
|     fi                   |
|                          |
|     zcat $1 | more       |
|                          |
|     # Uses the 'more' fi |
| lter.                    |
|     # May substitute 'le |
| ss' if desired.          |
|                          |
|     exit $?   # Script r |
| eturns exit status of pi |
| pe.                      |
|     #  Actually "exit $? |
| " is unnecessary, as the |
|  script will, in any cas |
| e,                       |
|     #+ return the exit s |
| tatus of the last comman |
| d executed.              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** compound comparison**

 -a
    logical and

    ``                   exp1 -a exp2                 `` returns true if
    *both* exp1 and exp2 are true.

 -o
    logical or

    ``                   exp1 -o exp2                 `` returns true if
    either exp1 *or* exp2 is true.

.. raw:: html

   </div>

These are similar to the Bash comparison operators **&&** and **\|\|** ,
used within `double brackets <testconstructs.html#DBLBRACKETS>`__ .

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     [[ condition1 && con |
| dition2 ]]               |
                          
+--------------------------+--------------------------+--------------------------+

The **-o** and **-a** operators work with the
`test <testconstructs.html#TTESTREF>`__ command or occur within single
test brackets.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     if [ "$expr1" -a "$e |
| xpr2" ]                  |
|     then                 |
|       echo "Both expr1 a |
| nd expr2 are true."      |
|     else                 |
|       echo "Either expr1 |
|  or expr2 is false."     |
|     fi                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="CAUTION">

+--------------------------+--------------------------+--------------------------+
| |Caution|                |
| But, as *rihad* points   |
| out:                     |
|                          |
| +----------------------- |
| ---+-------------------- |
| ------+----------------- |
| ---------+               |
| | .. code:: PROGRAMLISTI |
| NG |                     |
| |                        |
|    |                     |
| |     [ 1 -eq 1 ] && [ - |
| n  |                     |
| | "`echo true 1>&2`" ]   |
|  # |                     |
| |  true                  |
|    |                     |
| |     [ 1 -eq 2 ] && [ - |
| n  |                     |
| | "`echo true 1>&2`" ]   |
|  # |                     |
| |  (no output)           |
|    |                     |
| |     # ^^^^^^^ False co |
| nd |                     |
| | ition. So far, everyth |
| in |                     |
| | g as expected.         |
|    |                     |
| |                        |
|    |                     |
| |     # However ...      |
|    |                     |
| |     [ 1 -eq 2 -a -n "` |
| ec |                     |
| | ho true 1>&2`" ]       |
|  # |                     |
| |  true                  |
|    |                     |
| |     # ^^^^^^^ False co |
| nd |                     |
| | ition. So, why "true"  |
| ou |                     |
| | tput?                  |
|    |                     |
| |                        |
|    |                     |
| |     # Is it because bo |
| th |                     |
| |  condition clauses wit |
| hi |                     |
| | n brackets evaluate?   |
|    |                     |
| |     [[ 1 -eq 2 && -n " |
| `e |                     |
| | cho true 1>&2`" ]]     |
|  # |                     |
| |  (no output)           |
|    |                     |
| |     # No, that's not i |
| t. |                     |
| |                        |
|    |                     |
| |     # Apparently && an |
| d  |                     |
| | || "short-circuit" whi |
| le |                     |
| |  -a and -o do not.     |
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

Refer to `Example 8-3 <ops.html#ANDOR>`__ , `Example
27-17 <arrays.html#TWODIM>`__ , and `Example
A-29 <contributed-scripts.html#WHX>`__ to see compound comparison
operators in action.

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]                                |
|  <comparison-ops.html#AEN3669>`__    |
| As S.C. points out, in a compound    |
| test, even quoting the string        |
| variable might not suffice.          |
| ``                 [ -n "$string" -o |
|  "$a" = "$b" ]               ``      |
| may cause an error with some         |
| versions of Bash if                  |
| ``        $string       `` is empty. |
| The safe way is to append an extra   |
| character to possibly empty          |
| variables,                           |
| ``                 [ "x$string" != x |
|  -o "x$a" = "x$b" ]               `` |
| (the "x's" cancel out).              |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <fto.html>`__      | File test operators      |
| `Home <index.html>`__    | `Up <tests.html>`__      |
| `Next <nestedifthen.html | Nested                   |
| >`__                     | ``                 if/th |
|                          | en               ``      |
|                          | Condition Tests          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Note| image:: ../images/note.gif
