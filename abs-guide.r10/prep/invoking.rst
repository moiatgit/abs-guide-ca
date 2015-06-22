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

`Prev <sha-bang.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 2. Starting Off With a Sha-Bang

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

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
=========================

Having written the script, you can invoke it by
``             sh     scriptname           `` , ` [1]
 <invoking.html#FTN.AEN300>`__ or alternatively
``             bash scriptname           `` . (Not recommended is using
``             sh <scriptname           `` , since this effectively
disables reading from
```       stdin      `` <ioredirintro.html#STDINOUTDEF>`__ within the
script.) Much more convenient is to make the script itself directly
executable with a `chmod <basic.html#CHMODREF>`__ .

.. raw:: html

   <div class="VARIABLELIST">

 Either:
    ``                   chmod 555 scriptname                 `` (gives
    everyone read/execute permission) ` [2]
     <invoking.html#FTN.AEN315>`__

 or
    ``                   chmod +rx scriptname                 `` (gives
    everyone read/execute permission)

    ``                   chmod           u+rx scriptname                 ``
    (gives only the script owner read/execute permission)

.. raw:: html

   </div>

Having made the script executable, you may now test it by
``             ./scriptname           `` . ` [3]
 <invoking.html#FTN.AEN327>`__ If it begins with a "sha-bang" line,
invoking the script calls the correct command interpreter to run it.

As a final step, after testing and debugging, you would likely want to
move it to ``      /usr/local/bin     `` (as *root* , of course), to
make the script available to yourself and all other users as a
systemwide executable. The script could then be invoked by simply typing
**scriptname** **[ENTER]** from the command-line.

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <invoking.html#AEN300>`__     | ` [2]  <invoking.html#AEN315>`__     |
| Caution: invoking a *Bash* script by | A script needs *read* , as well as   |
| ``                 sh scriptname     | execute permission for it to run,    |
|            ``                        | since the shell needs to be able to  |
| turns off Bash-specific extensions,  | read it.                             |
| and the script may therefore fail to |                                      |
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

