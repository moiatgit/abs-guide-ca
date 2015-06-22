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

`Prev <numerical-constants.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 8. Operations and Related Topics

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <opprecedence.html>`__

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

8.3. The Double-Parentheses Construct
=====================================

Similar to the `let <internal.html#LETREF>`__ command, the **(( ... ))**
construct permits arithmetic expansion and evaluation. In its simplest
form, ``a=$(( 5 + 3 ))`` would set ``a`` to ``5 + 3``, or ``8``.
However, this double-parentheses construct is also a mechanism for
allowing C-style manipulation of variables in Bash, for example,
``(( var++ ))``.

.. raw:: html

   <div class="EXAMPLE">

**Example 8-5. C-style manipulation of variables**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # c-vars.sh          |
|     # Manipulating a var |
| iable, C-style, using th |
| e (( ... )) construct.   |
|                          |
|                          |
|     echo                 |
|                          |
|     (( a = 23 ))  #  Set |
| ting a value, C-style,   |
|                   #+ wit |
| h spaces on both sides o |
| f the "=".               |
|     echo "a (initial val |
| ue) = $a"   # 23         |
|                          |
|     (( a++ ))     #  Pos |
| t-increment 'a', C-style |
| .                        |
|     echo "a (after a++)  |
| = $a"       # 24         |
|                          |
|     (( a-- ))     #  Pos |
| t-decrement 'a', C-style |
| .                        |
|     echo "a (after a--)  |
| = $a"       # 23         |
|                          |
|                          |
|     (( ++a ))     #  Pre |
| -increment 'a', C-style. |
|     echo "a (after ++a)  |
| = $a"       # 24         |
|                          |
|     (( --a ))     #  Pre |
| -decrement 'a', C-style. |
|     echo "a (after --a)  |
| = $a"       # 23         |
|                          |
|     echo                 |
|                          |
|     #################### |
| ######################## |
| ############             |
|     #  Note that, as in  |
| C, pre- and post-decreme |
| nt operators             |
|     #+ have different si |
| de-effects.              |
|                          |
|     n=1; let --n && echo |
|  "True" || echo "False"  |
|  # False                 |
|     n=1; let n-- && echo |
|  "True" || echo "False"  |
|  # True                  |
|                          |
|     #  Thanks, Jeroen Do |
| mburg.                   |
|     #################### |
| ######################## |
| ############             |
|                          |
|     echo                 |
|                          |
|     (( t = a<45?7:11 ))  |
|   # C-style trinary oper |
| ator.                    |
|     #       ^  ^ ^       |
|     echo "If a < 45, the |
| n t = 7, else t = 11."   |
| # a = 23                 |
|     echo "t = $t "       |
|                          |
| # t = 7                  |
|                          |
|     echo                 |
|                          |
|                          |
|     # -----------------  |
|     # Easter Egg alert!  |
|     # -----------------  |
|     #  Chet Ramey seems  |
| to have snuck a bunch of |
|  undocumented C-style    |
|     #+ constructs into B |
| ash (actually adapted fr |
| om ksh, pretty much).    |
|     #  In the Bash docs, |
|  Ramey calls (( ... )) s |
| hell arithmetic,         |
|     #+ but it goes far b |
| eyond that.              |
|     #  Sorry, Chet, the  |
| secret is out.           |
|                          |
|     # See also "for" and |
|  "while" loops using the |
|  (( ... )) construct.    |
|                          |
|     # These work only wi |
| th version 2.04 or later |
|  of Bash.                |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

See also `Example 11-13 <loops1.html#FORLOOPC>`__ and `Example
8-4 <numerical-constants.html#NUMBERS>`__.

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <numerical-constan | Numerical Constants      |
| ts.html>`__              | `Up <operations.html>`__ |
| `Home <index.html>`__    | Operator Precedence      |
| `Next <opprecedence.html |                          |
| >`__                     |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

