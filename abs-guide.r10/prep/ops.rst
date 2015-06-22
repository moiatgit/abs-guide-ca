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

`Prev <operations.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 8. Operations and Related Topics

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <numerical-constants.html>`__

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

  8.1. Operators
===============

.. raw:: html

   <div class="VARIABLELIST">

** assignment**

 ``                 variable assignment               ``
    Initializing or changing the value of a variable

 =
    All-purpose assignment operator, which works for both arithmetic and
    string assignments.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     var=27               |
    |     category=minerals  # |
    |  No spaces allowed after |
    |  the "=".                |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="CAUTION">

    +--------------------+--------------------+--------------------+--------------------+
    | |Caution|          |
    | Do not confuse the |
    | "=" assignment     |
    | operator with the  |
    | `= test            |
    | operator <comparis |
    | on-ops.html#EQUALS |
    | IGNREF>`__         |
    | .                  |
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
    | |     #   =  as a  |
    | test ope |         |
    | | rator            |
    |          |         |
    | |                  |
    |          |         |
    | |     if [ "$strin |
    | g1" = "$ |         |
    | | string2" ]       |
    |          |         |
    | |     then         |
    |          |         |
    | |        command   |
    |          |         |
    | |     fi           |
    |          |         |
    | |                  |
    |          |         |
    | |     #  if [ "X$s |
    | tring1"  |         |
    | | = "X$string2" ]  |
    | is safer |         |
    | | ,                |
    |          |         |
    | |     #+ to preven |
    | t an err |         |
    | | or message shoul |
    | d one of |         |
    | |  the variables b |
    | e empty. |         |
    | |     #  (The prep |
    | ended "X |         |
    | | " characters can |
    | cel out. |         |
    | | )                |
    |          |         |
    |                    |
    |                    |
    | +----------------- |
    | ---------+-------- |
    | ------------------ |
    | +----------------- |
    | ---------+         |
                        
    +--------------------+--------------------+--------------------+--------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** arithmetic operators**

 +
    plus

 -
    minus

 \*
    multiplication

 /
    division

 \*\*
    exponentiation

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Bash, version 2.02 |
    | , introduced the "**" ex |
    | ponentiation operator.   |
    |                          |
    |     let "z=5**3"    # 5  |
    | * 5 * 5                  |
    |     echo "z = $z"   # z  |
    | = 125                    |
                              
    +--------------------------+--------------------------+--------------------------+

 %
    modulo, or mod (returns the *remainder* of an integer division
    operation)

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ expr 5 % 3     |
    |     2                    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    *5/3 = 1, with remainder 2*

    This operator finds use in, among other things, generating numbers
    within a specific range (see `Example 9-11 <randomvar.html#EX21>`__
    and `Example 9-15 <randomvar.html#RANDOMTEST>`__ ) and formatting
    program output (see `Example 27-16 <arrays.html#QFUNCTION>`__ and
    `Example A-6 <contributed-scripts.html#COLLATZ>`__ ). It can even be
    used to generate prime numbers, (see `Example
    A-15 <contributed-scripts.html#PRIMES>`__ ). Modulo turns up
    surprisingly often in numerical recipes.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 8-1. Greatest common divisor**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # gcd.sh: greatest c |
    | ommon divisor            |
    |     #         Uses Eucli |
    | d's algorithm            |
    |                          |
    |     #  The "greatest com |
    | mon divisor" (gcd) of tw |
    | o integers               |
    |     #+ is the largest in |
    | teger that will divide b |
    | oth, leaving no remainde |
    | r.                       |
    |                          |
    |     #  Euclid's algorith |
    | m uses successive divisi |
    | on.                      |
    |     #    In each pass,   |
    |     #+      dividend <-- |
    | -  divisor               |
    |     #+      divisor  <-- |
    | -  remainder             |
    |     #+   until remainder |
    |  = 0.                    |
    |     #    The gcd = divid |
    | end, on the final pass.  |
    |     #                    |
    |     #  For an excellent  |
    | discussion of Euclid's a |
    | lgorithm, see            |
    |     #+ Jim Loy's site, h |
    | ttp://www.jimloy.com/num |
    | ber/euclids.htm.         |
    |                          |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | ------------             |
    |     # Argument check     |
    |     ARGS=2               |
    |     E_BADARGS=85         |
    |                          |
    |     if [ $# -ne "$ARGS"  |
    | ]                        |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` first-number se |
    | cond-number"             |
    |       exit $E_BADARGS    |
    |     fi                   |
    |     # ------------------ |
    | ------------------------ |
    | ------------             |
    |                          |
    |                          |
    |     gcd ()               |
    |     {                    |
    |                          |
    |       dividend=$1        |
    |       #  Arbitrary assig |
    | nment.                   |
    |       divisor=$2         |
    |       #! It doesn't matt |
    | er which of the two is l |
    | arger.                   |
    |                          |
    |       #  Why not?        |
    |                          |
    |       remainder=1        |
    |       #  If an uninitial |
    | ized variable is used in |
    | side                     |
    |                          |
    |       #+ test brackets,  |
    | an error message results |
    | .                        |
    |                          |
    |       until [ "$remainde |
    | r" -eq 0 ]               |
    |       do    #  ^^^^^^^^^ |
    | ^  Must be previously in |
    | itialized!               |
    |         let "remainder = |
    |  $dividend % $divisor"   |
    |         dividend=$diviso |
    | r     # Now repeat with  |
    | 2 smallest numbers.      |
    |         divisor=$remaind |
    | er                       |
    |       done               |
    |       # Euclid's algorit |
    | hm                       |
    |                          |
    |     }                    |
    |       # Last $dividend i |
    | s the gcd.               |
    |                          |
    |                          |
    |     gcd $1 $2            |
    |                          |
    |     echo; echo "GCD of $ |
    | 1 and $2 = $dividend"; e |
    | cho                      |
    |                          |
    |                          |
    |     # Exercises :        |
    |     # ---------          |
    |     # 1) Check command-l |
    | ine arguments to make su |
    | re they are integers,    |
    |     #+   and exit the sc |
    | ript with an appropriate |
    |  error message if not.   |
    |     # 2) Rewrite the gcd |
    |  () function to use loca |
    | l variables.             |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 +=
    *plus-equal* (increment variable by a constant) ` [1]
     <ops.html#FTN.AEN3907>`__

    ``                   let "var += 5"                 `` results in
    ``                   var                 `` being incremented by
    ``         5        `` .

 -=
    *minus-equal* (decrement variable by a constant)

 \*=
    *times-equal* (multiply variable by a constant)

    ``                   let "var *= 4"                 `` results in
    ``                   var                 `` being multiplied by
    ``         4        `` .

 /=
    *slash-equal* (divide variable by a constant)

 %=
    *mod-equal* ( *remainder* of dividing variable by a constant)

    *Arithmetic operators often occur in an
    `expr <moreadv.html#EXPRREF>`__ or `let <internal.html#LETREF>`__
    expression.*

    .. raw:: html

       <div class="EXAMPLE">

    **Example 8-2. Using Arithmetic Operations**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Counting to 11 in  |
    | 10 different ways.       |
    |                          |
    |     n=1; echo -n "$n "   |
    |                          |
    |     let "n = $n + 1"   # |
    |  let "n = n + 1"  also w |
    | orks.                    |
    |     echo -n "$n "        |
    |                          |
    |                          |
    |     : $((n = $n + 1))    |
    |     #  ":" necessary bec |
    | ause otherwise Bash atte |
    | mpts                     |
    |     #+ to interpret "$(( |
    | n = $n + 1))" as a comma |
    | nd.                      |
    |     echo -n "$n "        |
    |                          |
    |     (( n = n + 1 ))      |
    |     #  A simpler alterna |
    | tive to the method above |
    | .                        |
    |     #  Thanks, David Lom |
    | bard, for pointing this  |
    | out.                     |
    |     echo -n "$n "        |
    |                          |
    |     n=$(($n + 1))        |
    |     echo -n "$n "        |
    |                          |
    |     : $[ n = $n + 1 ]    |
    |     #  ":" necessary bec |
    | ause otherwise Bash atte |
    | mpts                     |
    |     #+ to interpret "$[  |
    | n = $n + 1 ]" as a comma |
    | nd.                      |
    |     #  Works even if "n" |
    |  was initialized as a st |
    | ring.                    |
    |     echo -n "$n "        |
    |                          |
    |     n=$[ $n + 1 ]        |
    |     #  Works even if "n" |
    |  was initialized as a st |
    | ring.                    |
    |     #* Avoid this type o |
    | f construct, since it is |
    |  obsolete and nonportabl |
    | e.                       |
    |     #  Thanks, Stephane  |
    | Chazelas.                |
    |     echo -n "$n "        |
    |                          |
    |     # Now for C-style in |
    | crement operators.       |
    |     # Thanks, Frank Wang |
    | , for pointing this out. |
    |                          |
    |     let "n++"          # |
    |  let "++n"  also works.  |
    |     echo -n "$n "        |
    |                          |
    |     (( n++ ))          # |
    |  (( ++n ))  also works.  |
    |     echo -n "$n "        |
    |                          |
    |     : $(( n++ ))       # |
    |  : $(( ++n )) also works |
    | .                        |
    |     echo -n "$n "        |
    |                          |
    |     : $[ n++ ]         # |
    |  : $[ ++n ] also works   |
    |     echo -n "$n "        |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NOTE">

+----------------+----------------+----------------+----------------+----------------+
| |Note|         |
| Integer        |
| variables in   |
| older versions |
| of Bash were   |
| signed *long*  |
| (32-bit)       |
| integers, in   |
| the range of   |
| -2147483648 to |
| 2147483647. An |
| operation that |
| took a         |
| variable       |
| outside these  |
| limits gave an |
| erroneous      |
| result.        |
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
| |     echo $BA |
| SH_VERSION   | |
| |  # 1.14      |
|              | |
| |              |
|              | |
| |     a=214748 |
| 3646         | |
| |     echo "a  |
| = $a"        | |
| |  # a = 21474 |
| 83646        | |
| |     let "a+= |
| 1"           | |
| |  # Increment |
|  "a".        | |
| |     echo "a  |
| = $a"        | |
| |  # a = 21474 |
| 83647        | |
| |     let "a+= |
| 1"           | |
| |  # increment |
|  "a" again,  | |
| | past the lim |
| it.          | |
| |     echo "a  |
| = $a"        | |
| |  # a = -2147 |
| 483648       | |
| |              |
|              | |
| |  #      ERRO |
| R: out of ra | |
| | nge,         |
|              | |
| |              |
|              | |
| |  # +    and  |
| the leftmost | |
| |  bit, the si |
| gn bit,      | |
| |              |
|              | |
| |  # +    has  |
| been set, ma | |
| | king the res |
| ult negative | |
| | .            |
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
| As of version  |
| >= 2.05b, Bash |
| supports       |
| 64-bit         |
| integers.      |
+----------------+----------------+----------------+----------------+----------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+--------------+--------------+--------------+--------------+--------------+--------------+
| |Caution|    |
|              |
| Bash does    |
| not          |
| understand   |
| floating     |
| point        |
| arithmetic.  |
| It treats    |
| numbers      |
| containing a |
| decimal      |
| point as     |
| strings.     |
|              |
| +----------- |
| ------------ |
| ---+-------- |
| ------------ |
| ------+----- |
| ------------ |
| ---------+   |
| | .. code::  |
| PROGRAMLISTI |
| NG |         |
| |            |
|              |
|    |         |
| |     a=1.5  |
|              |
|    |         |
| |            |
|              |
|    |         |
| |     let "b |
|  = $a + 1.3" |
|    |         |
| | # Error.   |
|              |
|    |         |
| |     # t2.s |
| h: let: b =  |
| 1. |         |
| | 5 + 1.3: s |
| yntax error  |
| in |         |
| |  expressio |
| n            |
|    |         |
| |     #      |
|              |
|    |         |
| |          ( |
| error token  |
| is |         |
| |  ".5 + 1.3 |
| ")           |
|    |         |
| |            |
|              |
|    |         |
| |     echo " |
| b = $b"      |
|    |         |
| | # b=1      |
|              |
|    |         |
|              |
|              |
|              |
| +----------- |
| ------------ |
| ---+-------- |
| ------------ |
| ------+----- |
| ------------ |
| ---------+   |
|              |
| Use          |
| `bc <mathc.h |
| tml#BCREF>`_ |
| _            |
| in scripts   |
| that that    |
| need         |
| floating     |
| point        |
| calculations |
| or math      |
| library      |
| functions.   |
+--------------+--------------+--------------+--------------+--------------+--------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="FORMALPARA">

**bitwise operators.** The bitwise operators seldom make an appearance
in shell scripts. Their chief use seems to be manipulating and testing
values read from ports or `sockets <devref1.html#SOCKETREF>`__ . "Bit
flipping" is more relevant to compiled languages, such as C and C++,
which provide direct access to system hardware. However, see *vladz's*
ingenious use of bitwise operators in his *base64.sh* ( `Example
A-54 <contributed-scripts.html#BASE64>`__ ) script.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** bitwise operators**

 <<
    bitwise left shift (multiplies by ``         2        `` for each
    shift position)

 <<=
    *left-shift-equal*

    ``                   let "var <<= 2"                 `` results in
    ``                   var                 `` left-shifted
    ``         2        `` bits (multiplied by ``         4        `` )

 >>
    bitwise right shift (divides by ``         2        `` for each
    shift position)

 >>=
    *right-shift-equal* (inverse of <<= )

 &
    bitwise AND

 &=
    bitwise *AND-equal*

 \|
    bitwise OR

 \|=
    bitwise *OR-equal*

 ~
    bitwise NOT

 ^
    bitwise XOR

 ^=
    bitwise *XOR-equal*

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** logical (boolean) operators**

 !
    NOT

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     if [ ! -f $FILENAME  |
    | ]                        |
    |     then                 |
    |       ...                |
                              
    +--------------------------+--------------------------+--------------------------+

 &&
    AND

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     if [ $condition1 ] & |
    | & [ $condition2 ]        |
    |     #  Same as:  if [ $c |
    | ondition1 -a $condition2 |
    |  ]                       |
    |     #  Returns true if b |
    | oth condition1 and condi |
    | tion2 hold true...       |
    |                          |
    |     if [[ $condition1 && |
    |  $condition2 ]]    # Als |
    | o works.                 |
    |     #  Note that && oper |
    | ator not permitted insid |
    | e brackets               |
    |     #+ of [ ... ] constr |
    | uct.                     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    |  && may also be used, depending on   |
    | context, in an `and                  |
    | list <list-cons.html#LISTCONSREF>`__ |
    | to concatenate commands.             |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 \|\|
    OR

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     if [ $condition1 ] | |
    | | [ $condition2 ]        |
    |     # Same as:  if [ $co |
    | ndition1 -o $condition2  |
    | ]                        |
    |     # Returns true if ei |
    | ther condition1 or condi |
    | tion2 holds true...      |
    |                          |
    |     if [[ $condition1 || |
    |  $condition2 ]]    # Als |
    | o works.                 |
    |     #  Note that || oper |
    | ator not permitted insid |
    | e brackets               |
    |     #+ of a [ ... ] cons |
    | truct.                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Bash tests the `exit                 |
    | status <exit-status.html#EXITSTATUSR |
    | EF>`__                               |
    | of each statement linked with a      |
    | logical operator.                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 8-3. Compound Condition Tests Using && and \|\|**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     a=24                 |
    |     b=47                 |
    |                          |
    |     if [ "$a" -eq 24 ] & |
    | & [ "$b" -eq 47 ]        |
    |     then                 |
    |       echo "Test #1 succ |
    | eeds."                   |
    |     else                 |
    |       echo "Test #1 fail |
    | s."                      |
    |     fi                   |
    |                          |
    |     # ERROR:   if [ "$a" |
    |  -eq 24 && "$b" -eq 47 ] |
    |     #+         attempts  |
    | to execute  ' [ "$a" -eq |
    |  24 '                    |
    |     #+         and fails |
    |  to finding matching ']' |
    | .                        |
    |     #                    |
    |     #  Note:  if [[ $a - |
    | eq 24 && $b -eq 24 ]]  w |
    | orks.                    |
    |     #  The double-bracke |
    | t if-test is more flexib |
    | le                       |
    |     #+ than the single-b |
    | racket version.          |
    |     #    (The "&&" has a |
    |  different meaning in li |
    | ne 17 than in line 6.)   |
    |     #    Thanks, Stephan |
    | e Chazelas, for pointing |
    |  this out.               |
    |                          |
    |                          |
    |     if [ "$a" -eq 98 ] | |
    | | [ "$b" -eq 47 ]        |
    |     then                 |
    |       echo "Test #2 succ |
    | eeds."                   |
    |     else                 |
    |       echo "Test #2 fail |
    | s."                      |
    |     fi                   |
    |                          |
    |                          |
    |     #  The -a and -o opt |
    | ions provide             |
    |     #+ an alternative co |
    | mpound condition test.   |
    |     #  Thanks to Patrick |
    |  Callahan for pointing t |
    | his out.                 |
    |                          |
    |                          |
    |     if [ "$a" -eq 24 -a  |
    | "$b" -eq 47 ]            |
    |     then                 |
    |       echo "Test #3 succ |
    | eeds."                   |
    |     else                 |
    |       echo "Test #3 fail |
    | s."                      |
    |     fi                   |
    |                          |
    |                          |
    |     if [ "$a" -eq 98 -o  |
    | "$b" -eq 47 ]            |
    |     then                 |
    |       echo "Test #4 succ |
    | eeds."                   |
    |     else                 |
    |       echo "Test #4 fail |
    | s."                      |
    |     fi                   |
    |                          |
    |                          |
    |     a=rhino              |
    |     b=crocodile          |
    |     if [ "$a" = rhino ]  |
    | && [ "$b" = crocodile ]  |
    |     then                 |
    |       echo "Test #5 succ |
    | eeds."                   |
    |     else                 |
    |       echo "Test #5 fail |
    | s."                      |
    |     fi                   |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The && and \|\| operators also find use in an arithmetic context.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo $(( 1 &&  |
    | 2 )) $((3 && 0)) $((4 || |
    |  0)) $((0 || 0))         |
    |     1 0 1 0              |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** miscellaneous operators**

 ,
    Comma operator

    The **comma operator** chains together two or more arithmetic
    operations. All the operations are evaluated (with possible *side
    effects* . ` [2]  <ops.html#FTN.AEN4242>`__

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     let "t1 = ((5 + 3, 7 |
    |  - 1, 15 - 4))"          |
    |     echo "t1 = $t1"      |
    |       ^^^^^^  # t1 = 11  |
    |     # Here t1 is set to  |
    | the result of the last o |
    | peration. Why?           |
    |                          |
    |     let "t2 = ((a = 9, 1 |
    | 5 / 3))"      # Set "a"  |
    | and calculate "t2".      |
    |     echo "t2 = $t2    a  |
    | = $a"         # t2 = 5   |
    |   a = 9                  |
                              
    +--------------------------+--------------------------+--------------------------+

    The comma operator finds use mainly in `for
    loops <loops1.html#FORLOOPREF1>`__ . See `Example
    11-13 <loops1.html#FORLOOPC>`__ .

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <ops.html#AEN3907>`__         | ` [2]  <ops.html#AEN4242>`__         |
| In a different context, **+=** can   | *Side effects* are, of course,       |
| serve as a *string concatenation*    | unintended -- and usually            |
| operator. This can be useful for     | undesirable -- consequences.         |
| `modifying *environmental            |                                      |
| variables* <bashver3.html#PATHAPPEND |                                      |
| >`__                                 |                                      |
| .                                    |                                      |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <operations.html>` | Operations and Related   |
| __                       | Topics                   |
| `Home <index.html>`__    | `Up <operations.html>`__ |
| `Next <numerical-constan | Numerical Constants      |
| ts.html>`__              |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Note| image:: ../images/note.gif
