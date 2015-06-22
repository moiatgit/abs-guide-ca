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

`Prev <command-line-options.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Appendix G. Command-Line Options

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <bash-options.html>`__

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

G.1. Standard Command-Line Options
==================================

Over time, there has evolved a loose standard for the meanings of
command-line option flags. The GNU utilities conform more closely to
this "standard" than older UNIX utilities.

Traditionally, UNIX command-line options consist of a dash, followed by
one or more lowercase letters. The GNU utilities added a double-dash,
followed by a complete word or compound word.

The two most widely-accepted options are:

-  ``-h``

   ``--help``

   *Help*: Give usage message and exit.

-  ``-v``

   ``--version``

   *Version*: Show program version and exit.

Other common options are:

-  ``-a``

   ``--all``

   *All*: show *all* information or operate on *all* arguments.

-  ``-l``

   ``--list``

   *List*: list files or arguments without taking other action.

-  ``-o``

   *Output* filename

-  ``-q``

   ``--quiet``

   *Quiet*: suppress ``stdout``.

-  ``-r``

   ``-R``

   ``--recursive``

   *Recursive*: Operate recursively (down directory tree).

-  ``-v``

   ``--verbose``

   *Verbose*: output additional information to ``stdout`` or ``stderr``.

-  ``-z``

   ``--compress``

   *Compress*: apply compression (usually
   `gzip <filearchiv.html#GZIPREF>`__).

However:

-  In **tar** and **gawk**:

   ``-f``

   ``--file``

   *File*: filename follows.

-  In **cp**, **mv**, **rm**:

   ``-f``

   ``--force``

   *Force*: force overwrite of target file(s).

.. raw:: html

   <div class="CAUTION">

+--------------------------------------+--------------------------------------+
| |Caution|                            |
| Many UNIX and Linux utilities        |
| deviate from this "standard," so it  |
| is dangerous to *assume* that a      |
| given option will behave in a        |
| standard way. Always check the man   |
| page for the command in question     |
| when in doubt.                       |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

A complete table of recommended options for the GNU utilities is
available at `the GNU standards
page <http://www.gnu.org/prep/standards/>`__.

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <command-line-opti | Command-Line Options     |
| ons.html>`__             | `Up <command-line-option |
| `Home <index.html>`__    | s.html>`__               |
| `Next <bash-options.html | Bash Command-Line        |
| >`__                     | Options                  |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
