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

`Prev <varassignment.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 4. Introduction to Variables and Parameters

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <othertypesv.html>`__

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

4.3. Bash Variables Are Untyped
===============================

Unlike many other programming languages, Bash does not segregate its
variables by "type." Essentially, *Bash variables are character
strings*, but, depending on context, Bash permits arithmetic operations
and comparisons on variables. The determining factor is whether the
value of a variable contains only digits.

.. raw:: html

   <div class="EXAMPLE">

**Example 4-4. Integer or string?**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # int-or-string.sh   |
|                          |
|     a=2334               |
|      # Integer.          |
|     let "a += 1"         |
|     echo "a = $a "       |
|      # a = 2335          |
|     echo                 |
|      # Integer, still.   |
|                          |
|                          |
|     b=${a/23/BB}         |
|      # Substitute "BB" f |
| or "23".                 |
|                          |
|      # This transforms $ |
| b into a string.         |
|     echo "b = $b"        |
|      # b = BB35          |
|     declare -i b         |
|      # Declaring it an i |
| nteger doesn't help.     |
|     echo "b = $b"        |
|      # b = BB35          |
|                          |
|     let "b += 1"         |
|      # BB35 + 1          |
|     echo "b = $b"        |
|      # b = 1             |
|     echo                 |
|      # Bash sets the "in |
| teger value" of a string |
|  to 0.                   |
|                          |
|     c=BB34               |
|     echo "c = $c"        |
|      # c = BB34          |
|     d=${c/BB/23}         |
|      # Substitute "23" f |
| or "BB".                 |
|                          |
|      # This makes $d an  |
| integer.                 |
|     echo "d = $d"        |
|      # d = 2334          |
|     let "d += 1"         |
|      # 2334 + 1          |
|     echo "d = $d"        |
|      # d = 2335          |
|     echo                 |
|                          |
|                          |
|     # What about null va |
| riables?                 |
|     e=''                 |
|      # ... Or e="" ... O |
| r e=                     |
|     echo "e = $e"        |
|      # e =               |
|     let "e += 1"         |
|      # Arithmetic operat |
| ions allowed on a null v |
| ariable?                 |
|     echo "e = $e"        |
|      # e = 1             |
|     echo                 |
|      # Null variable tra |
| nsformed into an integer |
| .                        |
|                          |
|     # What about undecla |
| red variables?           |
|     echo "f = $f"        |
|      # f =               |
|     let "f += 1"         |
|      # Arithmetic operat |
| ions allowed?            |
|     echo "f = $f"        |
|      # f = 1             |
|     echo                 |
|      # Undeclared variab |
| le transformed into an i |
| nteger.                  |
|     #                    |
|     # However ...        |
|     let "f /= $undecl_va |
| r"   # Divide by zero?   |
|     #   let: f /= : synt |
| ax error: operand expect |
| ed (error token is " ")  |
|     # Syntax error! Vari |
| able $undecl_var is not  |
| set to zero here!        |
|     #                    |
|     # But still ...      |
|     let "f /= 0"         |
|     #   let: f /= 0: div |
| ision by 0 (error token  |
| is "0")                  |
|     # Expected behavior. |
|                          |
|                          |
|     #  Bash (usually) se |
| ts the "integer value" o |
| f null to zero           |
|     #+ when performing a |
| n arithmetic operation.  |
|     #  But, don't try th |
| is at home, folks!       |
|     #  It's undocumented |
|  and probably non-portab |
| le behavior.             |
|                          |
|                          |
|     # Conclusion: Variab |
| les in Bash are untyped, |
|     #+ with all attendan |
| t consequences.          |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Untyped variables are both a blessing and a curse. They permit more
flexibility in scripting and make it easier to grind out lines of code
(and give you enough rope to hang yourself!). However, they likewise
permit subtle errors to creep in and encourage sloppy programming
habits.

To lighten the burden of keeping track of variable types in a script,
Bash *does* permit `declaring <declareref.html>`__ variables.

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <varassignment.htm | Variable Assignment      |
| l>`__                    | `Up <variables.html>`__  |
| `Home <index.html>`__    | Special Variable Types   |
| `Next <othertypesv.html> |                          |
| `__                      |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

