Advanced Bash-Scripting Guide:

`Prev <dblparens.html>`__

Chapter 8. Operations and Related Topics

`Next <part3.html>`__

--------------

8.4. Operator Precedence
========================

In a script, operations execute in order of *precedence*: the higher
precedence operations execute *before* the lower precedence ones.
`[1] <opprecedence.html#FTN.AEN4290>`__

**Table 8-1. Operator Precedence**

+--------------------------+--------------------------+--------------------------+
| Operator                 |
| Meaning                  |
| Comments                 |
+==========================+==========================+==========================+
| ````                     | ``var++ var--``          | ``++var --var``          |
|                          | post-increment,          | pre-increment,           |
| **HIGHEST PRECEDENCE**   | post-decrement           | pre-decrement            |
|                          | `C-style <assortedtips.h |                          |
|                          | tml#CSTYLE>`__           |                          |
|                          | operators                |                          |
+--------------------------+--------------------------+--------------------------+

In practice, all you really need to remember is the following:

-  The "My Dear Aunt Sally" mantra (*multiply, divide, add, subtract*)
   for the familiar `arithmetic operations <ops.html#AROPS1>`__.

-  The *compound* logical operators, **&&**, **\|\|**, **-a**, and
   **-o** have low precedence.

-  The order of evaluation of equal-precedence operators is usually
   *left-to-right*.

Now, let's utilize our knowledge of operator precedence to analyze a
couple of lines from the ``/etc/init.d/functions file``, as found in the
*Fedora Core* Linux distro.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     while [ -n "$remaining" -a "$retry" -gt 0 ]; do                      |
|                                                                          |
|     # This looks rather daunting at first glance.                        |
|                                                                          |
|                                                                          |
|     # Separate the conditions:                                           |
|     while [ -n "$remaining" -a "$retry" -gt 0 ]; do                      |
|     #       --condition 1-- ^^ --condition 2-                            |
|                                                                          |
|     #  If variable "$remaining" is not zero length                       |
|     #+      AND (-a)                                                     |
|     #+ variable "$retry" is greater-than zero                            |
|     #+ then                                                              |
|     #+ the [ expresion-within-condition-brackets ] returns success (0)   |
|     #+ and the while-loop executes an iteration.                         |
|     #  ==============================================================    |
|     #  Evaluate "condition 1" and "condition 2" ***before***             |
|     #+ ANDing them. Why? Because the AND (-a) has a lower precedence     |
|     #+ than the -n and -gt operators,                                    |
|     #+ and therefore gets evaluated *last*.                              |
|                                                                          |
|     #################################################################    |
|                                                                          |
|     if [ -f /etc/sysconfig/i18n -a -z "${NOLOCALE:-}" ] ; then           |
|                                                                          |
|                                                                          |
|     # Again, separate the conditions:                                    |
|     if [ -f /etc/sysconfig/i18n -a -z "${NOLOCALE:-}" ] ; then           |
|     #    --condition 1--------- ^^ --condition 2-----                    |
|                                                                          |
|     #  If file "/etc/sysconfig/i18n" exists                              |
|     #+      AND (-a)                                                     |
|     #+ variable $NOLOCALE is zero length                                 |
|     #+ then                                                              |
|     #+ the [ test-expresion-within-condition-brackets ] returns success  |
| (0)                                                                      |
|     #+ and the commands following execute.                               |
|     #                                                                    |
|     #  As before, the AND (-a) gets evaluated *last*                     |
|     #+ because it has the lowest precedence of the operators within      |
|     #+ the test brackets.                                                |
|     #  ==============================================================    |
|     #  Note:                                                             |
|     #  ${NOLOCALE:-} is a parameter expansion that seems redundant.      |
|     #  But, if $NOLOCALE has not been declared, it gets set to *null*,   |
|     #+ in effect declaring it.                                           |
|     #  This makes a difference in some contexts.                         |
                                                                          
+--------------------------------------------------------------------------+

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
| ------------------------ |
| ------------------------ |
| ---+                     |
| | .. code:: PROGRAMLISTI |
| NG                       |
|                          |
|    |                     |
| |                        |
|                          |
|                          |
|    |                     |
| |     if [ "$v1" -gt "$v |
| 2"  -o  "$v1" -lt "$v2"  |
|  -a  -e "$filename" ]    |
|    |                     |
| |     # Unclear what's g |
| oing on here...          |
|                          |
|    |                     |
| |                        |
|                          |
|                          |
|    |                     |
| |     if [[ "$v1" -gt "$ |
| v2" ]] || [[ "$v1" -lt " |
| $v2" ]] && [[ -e "$filen |
| am |                     |
| | e" ]]                  |
|                          |
|                          |
|    |                     |
| |     # Much better -- t |
| he condition tests are g |
| rouped in logical sectio |
| ns |                     |
| | .                      |
|                          |
|                          |
|    |                     |
|                          |
|                          |
|                          |
|                          |
| +----------------------- |
| ------------------------ |
| ------------------------ |
| ---+                     |
                          
+--------------------------+--------------------------+--------------------------+

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <opprecedence.html#AEN4290>`__  |
| *Precedence*, in this context, has   |
| approximately the same meaning as    |
| *priority*                           |
+--------------------------------------+--------------------------------------+

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <dblparens.html>`_ | The Double-Parentheses   |
| _                        | Construct                |
| `Home <index.html>`__    | `Up <operations.html>`__ |
| `Next <part3.html>`__    | Beyond the Basics        |
+--------------------------+--------------------------+--------------------------+

.. |Tip| image:: ../images/tip.gif
