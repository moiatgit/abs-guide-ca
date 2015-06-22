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

`Prev <sha-bang.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 2. Starting Off With a Sha-Bang

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <prelimexer.html>`__

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

2.1. Invoking the script
========================

Having written the script, you can invoke it by ``sh     scriptname``,
`[1] <invoking.html#FTN.AEN300>`__ or alternatively ``bash scriptname``.
(Not recommended is using ``sh <scriptname``, since this effectively
disables reading from ```stdin`` <ioredirintro.html#STDINOUTDEF>`__
within the script.) Much more convenient is to make the script itself
directly executable with a `chmod <basic.html#CHMODREF>`__.

.. raw:: html

   <div class="VARIABLELIST">

Either:
    ``chmod 555 scriptname`` (gives everyone read/execute permission)
    `[2] <invoking.html#FTN.AEN315>`__

or
    ``chmod +rx scriptname`` (gives everyone read/execute permission)

    ``chmod           u+rx scriptname`` (gives only the script owner
    read/execute permission)

.. raw:: html

   </div>

.. raw:: html

   </p>

Having made the script executable, you may now test it by
``./scriptname``. `[3] <invoking.html#FTN.AEN327>`__ If it begins with a
"sha-bang" line, invoking the script calls the correct command
interpreter to run it.

As a final step, after testing and debugging, you would likely want to
move it to ``/usr/local/bin`` (as *root*, of course), to make the script
available to yourself and all other users as a systemwide executable.
The script could then be invoked by simply typing **scriptname**
**[ENTER]** from the command-line.

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <invoking.html#AEN300>`__       | `[2] <invoking.html#AEN315>`__       |
| Caution: invoking a *Bash* script by | A script needs *read*, as well as    |
| ``sh scriptname`` turns off          | execute permission for it to run,    |
| Bash-specific extensions, and the    | since the shell needs to be able to  |
| script may therefore fail to         | read it.                             |
| execute.                             |                                      |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <sha-bang.html>`__ | Starting Off With a      |
| `Home <index.html>`__    | Sha-Bang                 |
| `Next <prelimexer.html>` | `Up <sha-bang.html>`__   |
| __                       | Preliminary Exercises    |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

