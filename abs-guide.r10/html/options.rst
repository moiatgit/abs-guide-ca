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

`Prev <debugging.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <gotchas.html>`__

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

Chapter 33. Options
===================

Options are settings that change shell and/or script behavior.

The `set <internal.html#SETREF>`__ command enables options within a
script. At the point in the script where you want the options to take
effect, use **set -o option-name** or, in short form, **set
-option-abbrev**. These two forms are equivalent.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|           #!/bin/bash    |
|                          |
|           set -o verbose |
|           # Echoes all c |
| ommands before executing |
| .                        |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|           #!/bin/bash    |
|                          |
|           set -v         |
|           # Exact same e |
| ffect as above.          |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| To *disable* an option within a      |
| script, use **set +o option-name**   |
| or **set +option-abbrev**.           |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|           #!/bin/bash    |
|                          |
|           set -o verbose |
|           # Command echo |
| ing on.                  |
|           command        |
|           ...            |
|           command        |
|                          |
|           set +o verbose |
|           # Command echo |
| ing off.                 |
|           command        |
|           # Not echoed.  |
|                          |
|                          |
|           set -v         |
|           # Command echo |
| ing on.                  |
|           command        |
|           ...            |
|           command        |
|                          |
|           set +v         |
|           # Command echo |
| ing off.                 |
|           command        |
|                          |
|           exit 0         |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

An alternate method of enabling options in a script is to specify them
immediately following the ``#!`` script header.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|           #!/bin/bash -x |
|           #              |
|           # Body of scri |
| pt follows.              |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

It is also possible to enable script options from the command line. Some
options that will not work with **set** are available this way. Among
these are ``-i``, force script to run interactive.

``bash -v script-name``

``bash -o verbose script-name``

The following is a listing of some useful options. They may be specified
in either abbreviated form (preceded by a single dash) or by complete
name (preceded by a *double* dash or by ``-o``).

.. raw:: html

   <div class="TABLE">

**Table 33-1. Bash options**

+--------------------------+--------------------------+--------------------------+
| Abbreviation             |
| Name                     |
| Effect                   |
+==========================+==========================+==========================+
| ``-B``                   | ``+B``                   | \ ``-C``                 |
| brace expansion          | brace expansion          | noclobber                |
| *Enable* `brace          | *Disable* brace          | Prevent overwriting of   |
| expansion <special-chars | expansion                | files by redirection     |
| .html#BRACEEXPREF>`__    |                          | (may be overridden by    |
| (default setting = *on*) |                          | >\|)                     |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <debugging.html>`_ | Debugging                |
| _                        | `Up <part5.html>`__      |
| `Home <index.html>`__    | Gotchas                  |
| `Next <gotchas.html>`__  |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
