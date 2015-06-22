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

`Prev <refcards.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <x23170.html>`__

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

   <div class="APPENDIX">

  Appendix C. A Sed and Awk Micro-Primer
=======================================

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

C.1. `Sed <x23170.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

C.2. `Awk <awk.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </div>

This is a very brief introduction to the **sed** and **awk** text
processing utilities. We will deal with only a few basic commands here,
but that will suffice for understanding simple sed and awk constructs
within shell scripts.

**sed** : a non-interactive text file editor

**awk** : a field-oriented pattern processing language with a **C**
-style syntax

For all their differences, the two utilities share a similar invocation
syntax, use `regular expressions <regexp.html#REGEXREF>`__ , read input
by default from ``      stdin     `` , and output to
``      stdout     `` . These are well-behaved UNIX tools, and they work
together well. The output from one can be piped to the other, and their
combined capabilities give shell scripts some of the power of
`Perl <wrapper.html#PERLREF>`__ .

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| One important difference between the |
| utilities is that while shell        |
| scripts can easily pass arguments to |
| sed, it is more cumbersome for awk   |
| (see `Example                        |
| 36-5 <wrapper.html#COLTOTALER>`__    |
| and `Example                         |
| 28-2 <ivr.html#COLTOTALER2>`__ ).    |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

.. raw:: html

   <table border="0" cellpadding="0" cellspacing="0" summary="Footer navigation table" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

`Prev <refcards.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

`Home <index.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

`Next <x23170.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

Reference Cards

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

Sed

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
