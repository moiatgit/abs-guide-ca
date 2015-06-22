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

`Prev <system.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 17. System and Administrative Commands

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <part5.html>`__

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

  17.1. Analyzing a System Script
================================

Using our knowledge of administrative commands, let us examine a system
script. One of the shortest and simplest to understand scripts is
"killall," ` [1]  <sysscripts.html#FTN.AEN17079>`__ used to suspend
running processes at system shutdown.

.. raw:: html

   <div class="EXAMPLE">

**Example 17-12. *killall* , from ``        /etc/rc.d/init.d       ``**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/sh            |
|                          |
|     # --> Comments added |
|  by the author of this d |
| ocument marked by "# --> |
| ".                       |
|                          |
|     # --> This is part o |
| f the 'rc' script packag |
| e                        |
|     # --> by Miquel van  |
| Smoorenburg, <miquels@dr |
| inkel.nl.mugnet.org>.    |
|                          |
|     # --> This particula |
| r script seems to be Red |
|  Hat / FC specific       |
|     # --> (may not be pr |
| esent in other distribut |
| ions).                   |
|                          |
|     #  Bring down all un |
| needed services that are |
|  still running           |
|     #+ (there shouldn't  |
| be any, so this is just  |
| a sanity check)          |
|                          |
|     for i in /var/lock/s |
| ubsys/*; do              |
|             # --> Standa |
| rd for/in loop, but sinc |
| e "do" is on same line,  |
|             # --> it is  |
| necessary to add ";".    |
|             # Check if t |
| he script is there.      |
|             [ ! -f $i ]  |
| && continue              |
|             # --> This i |
| s a clever use of an "an |
| d list", equivalent to:  |
|             # --> if [ ! |
|  -f "$i" ]; then continu |
| e                        |
|                          |
|             # Get the su |
| bsystem name.            |
|             subsys=${i#/ |
| var/lock/subsys/}        |
|             # --> Match  |
| variable name, which, in |
|  this case, is the file  |
| name.                    |
|             # --> This i |
| s the exact equivalent o |
| f subsys=`basename $i`.  |
|                          |
|             # -->  It ge |
| ts it from the lock file |
|  name                    |
|             # -->+ (if t |
| here is a lock file,     |
|             # -->+ that' |
| s proof the process has  |
| been running).           |
|             # -->  See t |
| he "lockfile" entry, abo |
| ve.                      |
|                          |
|                          |
|             # Bring the  |
| subsystem down.          |
|             if [ -f /etc |
| /rc.d/init.d/$subsys.ini |
| t ]; then                |
|                /etc/rc.d |
| /init.d/$subsys.init sto |
| p                        |
|             else         |
|                /etc/rc.d |
| /init.d/$subsys stop     |
|             # -->  Suspe |
| nd running jobs and daem |
| ons.                     |
|             # -->  Note  |
| that "stop" is a positio |
| nal parameter,           |
|             # -->+ not a |
|  shell builtin.          |
|             fi           |
|     done                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

That wasn't so bad. Aside from a little fancy footwork with variable
matching, there is no new material there.

.. raw:: html

   <div class="FORMALPARA">

**Exercise 1.** In ``       /etc/rc.d/init.d      `` , analyze the
**halt** script. It is a bit longer than **killall** , but similar in
concept. Make a copy of this script somewhere in your home directory and
experiment with it (do *not* run it as *root* ). Do a simulated run with
the ``       -vn      `` flags (
``               sh       -vn scriptname             `` ). Add extensive
comments. Change the commands to `echos <internal.html#ECHOREF>`__ .

.. raw:: html

   </div>

.. raw:: html

   <div class="FORMALPARA">

**Exercise 2.** Look at some of the more complex scripts in
``       /etc/rc.d/init.d      `` . Try to understand at least portions
of them. Follow the above procedure to analyze them. For some additional
insight, you might also examine the file ``       sysvinitfiles      ``
in ``       /usr/share/doc/initscripts-?.??      `` , which is part of
the "initscripts" documentation.

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <sysscripts.html#AEN17079>`__ |
| The *killall* system script should   |
| not be confused with the             |
| `killall <x9644.html#KILLALLREF>`__  |
| command in                           |
| ``        /usr/bin       `` .        |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <system.html>`__   | System and               |
| `Home <index.html>`__    | Administrative Commands  |
| `Next <part5.html>`__    | `Up <system.html>`__     |
|                          | Advanced Topics          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

