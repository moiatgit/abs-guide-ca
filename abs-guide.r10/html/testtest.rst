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

`Prev <nestedifthen.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 7. Tests

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <operations.html>`__

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

7.5. Testing Your Knowledge of Tests
====================================

The systemwide ``xinitrc`` file can be used to launch the X server. This
file contains quite a number of *if/then* tests. The following is
excerpted from an "ancient" version of ``xinitrc`` (*Red Hat 7.1*, or
thereabouts).

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     if [ -f $HOME/.Xclie |
| nts ]; then              |
|       exec $HOME/.Xclien |
| ts                       |
|     elif [ -f /etc/X11/x |
| init/Xclients ]; then    |
|       exec /etc/X11/xini |
| t/Xclients               |
|     else                 |
|          # failsafe sett |
| ings.  Although we shoul |
| d never get here         |
|          # (we provide f |
| allbacks in Xclients as  |
| well) it can't hurt.     |
|          xclock -geometr |
| y 100x100-5+5 &          |
|          xterm -geometry |
|  80x50-50+150 &          |
|          if [ -f /usr/bi |
| n/netscape -a -f /usr/sh |
| are/doc/HTML/index.html  |
| ]; then                  |
|                  netscap |
| e /usr/share/doc/HTML/in |
| dex.html &               |
|          fi              |
|     fi                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

Explain the *test* constructs in the above snippet, then examine an
updated version of the file, ``/etc/X11/xinit/xinitrc``, and analyze the
*if/then* test constructs there. You may need to refer ahead to the
discussions of `grep <textproc.html#GREPREF>`__,
`sed <sedawk.html#SEDREF>`__, and `regular
expressions <regexp.html#REGEXREF>`__.

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <nestedifthen.html | Nested ``if/then``       |
| >`__                     | Condition Tests          |
| `Home <index.html>`__    | `Up <tests.html>`__      |
| `Next <operations.html>` | Operations and Related   |
| __                       | Topics                   |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

