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

`Prev <ops.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 8. Operations and Related Topics

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <dblparens.html>`__

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

8.2. Numerical Constants
========================

A shell script interprets a number as decimal (base 10), unless that
number has a special prefix or notation. A number preceded by a ``0`` is
``octal`` (base 8). A number preceded by ``0x`` is ``hexadecimal`` (base
16). A number with an embedded ``#`` evaluates as ``BASE#NUMBER`` (with
range and notational restrictions).

.. raw:: html

   <div class="EXAMPLE">

**Example 8-4. Representation of numerical constants**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # numbers.sh: Repres |
| entation of numbers in d |
| ifferent bases.          |
|                          |
|     # Decimal: the defau |
| lt                       |
|     let "dec = 32"       |
|     echo "decimal number |
|  = $dec"             # 3 |
| 2                        |
|     # Nothing out of the |
|  ordinary here.          |
|                          |
|                          |
|     # Octal: numbers pre |
| ceded by '0' (zero)      |
|     let "oct = 032"      |
|     echo "octal number = |
|  $oct"               # 2 |
| 6                        |
|     # Expresses result i |
| n decimal.               |
|     # --------- ------ - |
| - -------                |
|                          |
|                          |
|     # Hexadecimal: numbe |
| rs preceded by '0x' or ' |
| 0X'                      |
|     let "hex = 0x32"     |
|     echo "hexadecimal nu |
| mber = $hex"         # 5 |
| 0                        |
|                          |
|     echo $((0x9abc))     |
|                      # 3 |
| 9612                     |
|     #     ^^      ^^   d |
| ouble-parentheses arithm |
| etic expansion/evaluatio |
| n                        |
|     # Expresses result i |
| n decimal.               |
|                          |
|                          |
|                          |
|     # Other bases: BASE# |
| NUMBER                   |
|     # BASE between 2 and |
|  64.                     |
|     # NUMBER must use sy |
| mbols within the BASE ra |
| nge, see below.          |
|                          |
|                          |
|     let "bin = 2#1111001 |
| 11001101"                |
|     echo "binary number  |
| = $bin"              # 3 |
| 1181                     |
|                          |
|     let "b32 = 32#77"    |
|     echo "base-32 number |
|  = $b32"             # 2 |
| 31                       |
|                          |
|     let "b64 = 64#@_"    |
|     echo "base-64 number |
|  = $b64"             # 4 |
| 031                      |
|     # This notation only |
|  works for a limited ran |
| ge (2 - 64) of ASCII cha |
| racters.                 |
|     # 10 digits + 26 low |
| ercase characters + 26 u |
| ppercase characters + @  |
| + _                      |
|                          |
|                          |
|     echo                 |
|                          |
|     echo $((36#zz)) $((2 |
| #10101010)) $((16#AF16)) |
|  $((53#1aA))             |
|                          |
|                      # 1 |
| 295 170 44822 3375       |
|                          |
|                          |
|     #  Important note:   |
|     #  --------------    |
|     #  Using a digit out |
|  of range of the specifi |
| ed base notation         |
|     #+ gives an error me |
| ssage.                   |
|                          |
|     let "bad_oct = 081"  |
|     # (Partial) error me |
| ssage output:            |
|     #  bad_oct = 081: va |
| lue too great for base ( |
| error token is "081")    |
|     #              Octal |
|  numbers use only digits |
|  in the range 0 - 7.     |
|                          |
|     exit $?   # Exit val |
| ue = 1 (error)           |
|                          |
|     # Thanks, Rich Barte |
| ll and Stephane Chazelas |
| , for clarification.     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <ops.html>`__      | Operators                |
| `Home <index.html>`__    | `Up <operations.html>`__ |
| `Next <dblparens.html>`_ | The Double-Parentheses   |
| _                        | Construct                |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

