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

`Prev <dblparens.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 8. Operations and Related Topics

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

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
========================

In a script, operations execute in order of *precedence*: the higher
precedence operations execute *before* the lower precedence ones.
`[1] <opprecedence.html#FTN.AEN4290>`__

.. raw:: html

   <div class="TABLE">

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

.. raw:: html

   </div>

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

   </p>

.. raw:: html

   <div class="TIP">

+--------------------+--------------------+--------------------+--------------------+
| |Tip|              |
| To avoid confusion |
| or error in a      |
| complex sequence   |
| of test operators, |
| break up the       |
| sequence into      |
| bracketed          |
| sections.          |
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
| |     if [ "$v1" - |
| gt "$v2" |         |
| |   -o  "$v1" -lt  |
| "$v2"  - |         |
| | a  -e "$filename |
| " ]      |         |
| |     # Unclear wh |
| at's goi |         |
| | ng on here...    |
|          |         |
| |                  |
|          |         |
| |     if [[ "$v1"  |
| -gt "$v2 |         |
| | " ]] || [[ "$v1" |
|  -lt "$v |         |
| | 2" ]] && [[ -e " |
| $filenam |         |
| | e" ]]            |
|          |         |
| |     # Much bette |
| r -- the |         |
| |  condition tests |
|  are gro |         |
| | uped in logical  |
| sections |         |
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

+--------------------------------------+--------------------------------------+
| `[1] <opprecedence.html#AEN4290>`__  |
| *Precedence*, in this context, has   |
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
