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

`Prev <othertypesv.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <quotingvar.html>`__

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

  Chapter 5. Quoting
===================

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

5.1. `Quoting Variables <quotingvar.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

5.2. `Escaping <escapingsection.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </div>

Quoting means just that, bracketing a string in quotes. This has the
effect of protecting `special
characters <special-chars.html#SCHARLIST1>`__ in the string from
reinterpretation or expansion by the shell or shell script. (A character
is "special" if it has an interpretation other than its literal meaning.
For example, the `asterisk \* <special-chars.html#ASTERISKREF>`__
represents a *wild card* character in `globbing <globbingref.html>`__
and `Regular Expressions <regexp.html#REGEXREF>`__ ).

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ ls -l [Vv]*    |
|     -rw-rw-r--    1 bozo |
|   bozo       324 Apr  2  |
| 15:05 VIEWDATA.BAT       |
|      -rw-rw-r--    1 boz |
| o  bozo       507 May  4 |
|  14:25 vartrace.sh       |
|      -rw-rw-r--    1 boz |
| o  bozo       539 Apr 14 |
|  17:11 viewdata.sh       |
|                          |
|     bash$ ls -l '[Vv]*'  |
|     ls: [Vv]*: No such f |
| ile or directory         |
                          
+--------------------------+--------------------------+--------------------------+

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| In everyday speech or writing, when we "quote" a phrase, we set it apart |
| and give it special meaning. In a Bash script, when we *quote* a string, |
| we set it apart and protect its *literal* meaning.                       |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

Certain programs and utilities reinterpret or expand special characters
in a quoted string. An important use of quoting is protecting a
command-line parameter from the shell, but still letting the calling
program expand it.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ grep '[Ff]irst |
| ' *.txt                  |
|     file1.txt:This is th |
| e first line of file1.tx |
| t.                       |
|      file2.txt:This is t |
| he First line of file2.t |
| xt.                      |
                          
+--------------------------+--------------------------+--------------------------+

Note that the unquoted ``             grep [Ff]irst *.txt           ``
works under the Bash shell. ` [1]  <quoting.html#FTN.AEN2609>`__

Quoting can also suppress `echo's <internal.html#ECHOREF>`__ "appetite"
for newlines.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ echo $(ls -l)  |
|     total 8 -rw-rw-r-- 1 |
|  bo bo 13 Aug 21 12:57 t |
| .sh -rw-rw-r-- 1 bo bo 7 |
| 8 Aug 21 12:57 u.sh      |
|                          |
|                          |
|     bash$ echo "$(ls -l) |
| "                        |
|     total 8              |
|      -rw-rw-r--  1 bo bo |
|   13 Aug 21 12:57 t.sh   |
|      -rw-rw-r--  1 bo bo |
|   78 Aug 21 12:57 u.sh   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <quoting.html#AEN2609>`__     |
| Unless there is a file named         |
| ``        first       `` in the      |
| current working directory. Yet       |
| another reason to *quote* . (Thank   |
| you, Harald Koenig, for pointing     |
| this out.                            |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <othertypesv.html> | Special Variable Types   |
| `__                      | `Up <part2.html>`__      |
| `Home <index.html>`__    | Quoting Variables        |
| `Next <quotingvar.html>` |                          |
| __                       |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

