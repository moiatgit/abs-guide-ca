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

`Prev <part5.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <x17129.html>`__

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

   <div class="CHAPTER">

  Chapter 18. Regular Expressions
================================

+--------------------------+--------------------------+--------------------------+
| **                       |
| *. . . the intellectual  |
| activity associated with |
| software development is  |
| largely one of gaining   |
| insight.*                |
|                          |
| *--Stowe Boyd*           |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="TOC">

.. raw:: html

   <dl>

.. raw:: html

   <dt>

**Table of Contents**

.. raw:: html

   </dt>

.. raw:: html

   <dt>

18.1. `A Brief Introduction to Regular Expressions <x17129.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

18.2. `Globbing <globbingref.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </div>

To fully utilize the power of shell scripting, you need to master
Regular Expressions. Certain commands and utilities commonly used in
scripts, such as `grep <textproc.html#GREPREF>`__ ,
`expr <moreadv.html#EXPRREF>`__ , `sed <sedawk.html#SEDREF>`__ and
`awk <awk.html#AWKREF>`__ , interpret and use REs. As of `version
3 <bashver3.html#BASH3REF>`__ , Bash has acquired its own `RE-match
operator <bashver3.html#REGEXMATCHREF>`__ : **=~** .

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <part5.html>`__    | Advanced Topics          |
| `Home <index.html>`__    | `Up <part5.html>`__      |
| `Next <x17129.html>`__   | A Brief Introduction to  |
|                          | Regular Expressions      |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

