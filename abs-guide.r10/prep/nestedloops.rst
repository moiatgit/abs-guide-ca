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

`Prev <loops1.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 11. Loops and Branches

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <loopcontrol.html>`__

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

  11.2. Nested Loops
===================

A *nested loop* is a loop within a loop, an inner loop within the body
of an outer one. How this works is that the first pass of the outer loop
triggers the inner loop, which executes to completion. Then the second
pass of the outer loop triggers the inner loop again. This repeats until
the outer loop finishes. Of course, a *break* within either the inner or
outer loop would interrupt this process.

.. raw:: html

   <div class="EXAMPLE">

**Example 11-20. Nested Loop**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # nested-loop.sh: Ne |
| sted "for" loops.        |
|                          |
|     outer=1              |
| # Set outer loop counter |
| .                        |
|                          |
|     # Beginning of outer |
|  loop.                   |
|     for a in 1 2 3 4 5   |
|     do                   |
|       echo "Pass $outer  |
| in outer loop."          |
|       echo "------------ |
| ---------"               |
|       inner=1            |
| # Reset inner loop count |
| er.                      |
|                          |
|       # ================ |
| ======================== |
| =======                  |
|       # Beginning of inn |
| er loop.                 |
|       for b in 1 2 3 4 5 |
|       do                 |
|         echo "Pass $inne |
| r in inner loop."        |
|         let "inner+=1"   |
| # Increment inner loop c |
| ounter.                  |
|       done               |
|       # End of inner loo |
| p.                       |
|       # ================ |
| ======================== |
| =======                  |
|                          |
|       let "outer+=1"     |
| # Increment outer loop c |
| ounter.                  |
|       echo               |
| # Space between output b |
| locks in pass of outer l |
| oop.                     |
|     done                 |
|     # End of outer loop. |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

See `Example 27-11 <arrays.html#BUBBLE>`__ for an illustration of nested
`while loops <loops1.html#WHILELOOPREF>`__ , and `Example
27-13 <arrays.html#EX68>`__ to see a while loop nested inside an `until
loop <loops1.html#UNTILLOOPREF>`__ .

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <loops1.html>`__   | Loops                    |
| `Home <index.html>`__    | `Up <loops.html>`__      |
| `Next <loopcontrol.html> | Loop Control             |
| `__                      |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

