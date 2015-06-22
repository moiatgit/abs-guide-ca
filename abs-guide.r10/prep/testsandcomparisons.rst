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

`Prev <wrapper.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 36. Miscellany

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <recursionsct.html>`__

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

  36.3. Tests and Comparisons: Alternatives
==========================================

For tests, the `[[ ]] <testconstructs.html#DBLBRACKETS>`__ construct may
be more appropriate than ``             [       ]           `` .
Likewise, `arithmetic comparisons <comparison-ops.html#ICOMPARISON1>`__
might benefit from the `(( )) <dblparens.html>`__ construct.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     a=8                  |
|                          |
|     # All of the compari |
| sons below are equivalen |
| t.                       |
|     test "$a" -lt 16 &&  |
| echo "yes, $a < 16"      |
|     # "and list"         |
|     /bin/test "$a" -lt 1 |
| 6 && echo "yes, $a < 16" |
|                          |
|     [ "$a" -lt 16 ] && e |
| cho "yes, $a < 16"       |
|     [[ $a -lt 16 ]] && e |
| cho "yes, $a < 16"       |
|     # Quoting variables  |
| within                   |
|     (( a < 16 )) && echo |
|  "yes, $a < 16"          |
|     # [[ ]] and (( )) no |
| t necessary.             |
|                          |
|     city="New York"      |
|     # Again, all of the  |
| comparisons below are eq |
| uivalent.                |
|     test "$city" \< Pari |
| s && echo "Yes, Paris is |
|  greater than $city"     |
|                          |
|               # Greater  |
| ASCII order.             |
|     /bin/test "$city" \< |
|  Paris && echo "Yes, Par |
| is is greater than $city |
| "                        |
|     [ "$city" \< Paris ] |
|  && echo "Yes, Paris is  |
| greater than $city"      |
|     [[ $city < Paris ]]  |
| && echo "Yes, Paris is g |
| reater than $city"       |
|                          |
|               # Need not |
|  quote $city.            |
|                          |
|     # Thank you, S.C.    |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <wrapper.html>`__  | Shell Wrappers           |
| `Home <index.html>`__    | `Up <miscellany.html>`__ |
| `Next <recursionsct.html | Recursion: a script      |
| >`__                     | calling itself           |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

