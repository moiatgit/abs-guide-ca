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

`Prev <comparison-ops.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 7. Tests

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <testtest.html>`__

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

  7.4. Nested ``             if/then           `` Condition Tests
================================================================

Condition tests using the ``             if/then           `` construct
may be nested. The net result is equivalent to using the
`*&&* <ops.html#LOGOPS1>`__ compound comparison operator.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     a=3                  |
|                          |
|     if [ "$a" -gt 0 ]    |
|     then                 |
|       if [ "$a" -lt 5 ]  |
|       then               |
|         echo "The value  |
| of \"a\" lies somewhere  |
| between 0 and 5."        |
|       fi                 |
|     fi                   |
|                          |
|     # Same result as:    |
|                          |
|     if [ "$a" -gt 0 ] && |
|  [ "$a" -lt 5 ]          |
|     then                 |
|       echo "The value of |
|  \"a\" lies somewhere be |
| tween 0 and 5."          |
|     fi                   |
                          
+--------------------------+--------------------------+--------------------------+

`Example 37-4 <bashver2.html#CARDS>`__ and `Example
17-11 <system.html#BACKLIGHT>`__ demonstrate nested
``             if/then           `` condition tests.

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <comparison-ops.ht | Other Comparison         |
| ml>`__                   | Operators                |
| `Home <index.html>`__    | `Up <tests.html>`__      |
| `Next <testtest.html>`__ | Testing Your Knowledge   |
|                          | of Tests                 |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

