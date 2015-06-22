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

`Prev <dblparens.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 8. Operations and Related Topics

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <part3.html>`__

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

  8.4. Operator Precedence
=========================

In a script, operations execute in order of *precedence* : the higher
precedence operations execute *before* the lower precedence ones. ` [1]
 <opprecedence.html#FTN.AEN4290>`__

.. raw:: html

   <div class="TABLE">

**Table 8-1. Operator Precedence**

.. raw:: html

   <table border="1" class="CALSTABLE">

.. raw:: html

   <thead>

.. raw:: html

   <tr>

.. raw:: html

   <th align="LEFT" valign="TOP">

Operator

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Meaning

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Comments

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   </thead>

.. raw:: html

   <tbody>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

**HIGHEST PRECEDENCE**

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          var++ var--         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

post-increment, post-decrement

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`C-style <assortedtips.html#CSTYLE>`__ operators

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ++var --var         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

pre-increment, pre-decrement

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ! ~         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`negation <special-chars.html#NOTREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

logical / bitwise, inverts sense of following operator

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          **         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`exponentiation <ops.html#EXPONENTIATIONREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`arithmetic operation <ops.html#AROPS1>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          * / %         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

multiplication, division, modulo

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

arithmetic operation

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          + -         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

addition, subtraction

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

arithmetic operation

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          << >>         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

left, right shift

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`bitwise <ops.html#BITWSOPS1>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -z -n         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*unary* comparison

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

string is/is-not `null <comparison-ops.html#STRINGNULL>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -e -f -t -x, etc.         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*unary* comparison

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`file-test <fto.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          < -lt > -gt <= -le >= -ge         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*compound* comparison

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

string and integer

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -nt -ot -ef         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*compound* comparison

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

file-test

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          == -eq                     !=                    -ne         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

equality / inequality

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

test operators, string and integer

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          &         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

AND

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

bitwise

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ^         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

XOR

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*exclusive* OR, bitwise

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          |         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

OR

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

bitwise

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          && -a         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

AND

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`logical <ops.html#LOGOPS1>`__ , *compound* comparison

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          || -o         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

OR

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

logical, *compound* comparison

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ?:         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`trinary operator <special-chars.html#CSTRINARY>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

C-style

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          =         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`assignment <varassignment.html#EQREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

(do not confuse with equality *test* )

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          *= /= %= += -= <<= >>= &=         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`combination assignment <ops.html#ARITHOPSCOMB>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

times-equal, divide-equal, mod-equal, etc.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ,         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`comma <ops.html#COMMAOP>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

links a sequence of operations

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

**LOWEST PRECEDENCE**

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </tbody>

.. raw:: html

   </table>

.. raw:: html

   </div>

In practice, all you really need to remember is the following:

-  The "My Dear Aunt Sally" mantra ( *multiply, divide, add, subtract* )
   for the familiar `arithmetic operations <ops.html#AROPS1>`__ .

-  The *compound* logical operators, **&&** , **\|\|** , **-a** , and
   **-o** have low precedence.

-  The order of evaluation of equal-precedence operators is usually
   *left-to-right* .

Now, let's utilize our knowledge of operator precedence to analyze a
couple of lines from the ``      /etc/init.d/functions file     `` , as
found in the *Fedora Core* Linux distro.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     while [ -n "$remaini |
| ng" -a "$retry" -gt 0 ]; |
|  do                      |
|                          |
|     # This looks rather  |
| daunting at first glance |
| .                        |
|                          |
|                          |
|     # Separate the condi |
| tions:                   |
|     while [ -n "$remaini |
| ng" -a "$retry" -gt 0 ]; |
|  do                      |
|     #       --condition  |
| 1-- ^^ --condition 2-    |
|                          |
|     #  If variable "$rem |
| aining" is not zero leng |
| th                       |
|     #+      AND (-a)     |
|     #+ variable "$retry" |
|  is greater-than zero    |
|     #+ then              |
|     #+ the [ expresion-w |
| ithin-condition-brackets |
|  ] returns success (0)   |
|     #+ and the while-loo |
| p executes an iteration. |
|     #  ================= |
| ======================== |
| =====================    |
|     #  Evaluate "conditi |
| on 1" and "condition 2"  |
| ***before***             |
|     #+ ANDing them. Why? |
|  Because the AND (-a) ha |
| s a lower precedence     |
|     #+ than the -n and - |
| gt operators,            |
|     #+ and therefore get |
| s evaluated *last*.      |
|                          |
|     #################### |
| ######################## |
| #####################    |
|                          |
|     if [ -f /etc/sysconf |
| ig/i18n -a -z "${NOLOCAL |
| E:-}" ] ; then           |
|                          |
|                          |
|     # Again, separate th |
| e conditions:            |
|     if [ -f /etc/sysconf |
| ig/i18n -a -z "${NOLOCAL |
| E:-}" ] ; then           |
|     #    --condition 1-- |
| ------- ^^ --condition 2 |
| -----                    |
|                          |
|     #  If file "/etc/sys |
| config/i18n" exists      |
|     #+      AND (-a)     |
|     #+ variable $NOLOCAL |
| E is zero length         |
|     #+ then              |
|     #+ the [ test-expres |
| ion-within-condition-bra |
| ckets ] returns success  |
| (0)                      |
|     #+ and the commands  |
| following execute.       |
|     #                    |
|     #  As before, the AN |
| D (-a) gets evaluated *l |
| ast*                     |
|     #+ because it has th |
| e lowest precedence of t |
| he operators within      |
|     #+ the test brackets |
| .                        |
|     #  ================= |
| ======================== |
| =====================    |
|     #  Note:             |
|     #  ${NOLOCALE:-} is  |
| a parameter expansion th |
| at seems redundant.      |
|     #  But, if $NOLOCALE |
|  has not been declared,  |
| it gets set to *null*,   |
|     #+ in effect declari |
| ng it.                   |
|     #  This makes a diff |
| erence in some contexts. |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="TIP">

+--------------------------+--------------------------+--------------------------+
| |Tip|                    |
| To avoid confusion or    |
| error in a complex       |
| sequence of test         |
| operators, break up the  |
| sequence into bracketed  |
| sections.                |
|                          |
| +----------------------- |
| ---+-------------------- |
| ------+----------------- |
| ---------+               |
| | .. code:: PROGRAMLISTI |
| NG |                     |
| |                        |
|    |                     |
| |     if [ "$v1" -gt "$v |
| 2" |                     |
| |   -o  "$v1" -lt "$v2"  |
|  - |                     |
| | a  -e "$filename" ]    |
|    |                     |
| |     # Unclear what's g |
| oi |                     |
| | ng on here...          |
|    |                     |
| |                        |
|    |                     |
| |     if [[ "$v1" -gt "$ |
| v2 |                     |
| | " ]] || [[ "$v1" -lt " |
| $v |                     |
| | 2" ]] && [[ -e "$filen |
| am |                     |
| | e" ]]                  |
|    |                     |
| |     # Much better -- t |
| he |                     |
| |  condition tests are g |
| ro |                     |
| | uped in logical sectio |
| ns |                     |
| | .                      |
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

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]                                |
|  <opprecedence.html#AEN4290>`__      |
| *Precedence* , in this context, has  |
| approximately the same meaning as    |
| *priority*                           |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <dblparens.html>`_ | The Double-Parentheses   |
| _                        | Construct                |
| `Home <index.html>`__    | `Up <operations.html>`__ |
| `Next <part3.html>`__    | Beyond the Basics        |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Tip| image:: ../images/tip.gif
