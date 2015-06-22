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

`Prev <localization.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <sample-bashrc.html>`__

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

  Appendix L. History Commands
=============================

The Bash shell provides command-line tools for editing and manipulating
a user's *command history* . This is primarily a convenience, a means of
saving keystrokes.

Bash history commands:

#. **history**

#. **fc**

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ history        |
|        1  mount /mnt/cdr |
| om                       |
|         2  cd /mnt/cdrom |
|         3  ls            |
|          ...             |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

Internal variables associated with Bash history commands:

#. $HISTCMD

#. $HISTCONTROL

#. $HISTIGNORE

#. $HISTFILE

#. $HISTFILESIZE

#. $HISTSIZE

#. $HISTTIMEFORMAT (Bash, ver. 3.0 or later)

#. !!

#. !$

#. !#

#. !N

#. !-N

#. !STRING

#. !?STRING?

#. ^STRING^string^

Unfortunately, the Bash history tools find no use in scripting.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # history.sh         |
|     # A (vain) attempt t |
| o use the 'history' comm |
| and in a script.         |
|                          |
|     history              |
|          # No output.    |
|                          |
|     var=$(history); echo |
|  "$var"  # $var is empty |
| .                        |
|                          |
|     #  History commands  |
| are, by default, disable |
| d within a script.       |
|     #  However, as dhw p |
| oints out,               |
|     #+ set -o history    |
|     #+ enables the histo |
| ry mechanism.            |
|                          |
|     set -o history       |
|     var=$(history); echo |
|  "$var"   # 1  var=$(his |
| tory)                    |
                          
+--------------------------+--------------------------+--------------------------+

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ ./history.sh   |
|     (no output)          |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

The `Advancing in the Bash
Shell <http://samrowe.com/wordpress/advancing-in-the-bash-shell/>`__
site gives a good introduction to the use of history commands in Bash.

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

`Prev <localization.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

`Home <index.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

`Next <sample-bashrc.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

Localization

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

Sample ``        .bashrc       `` and ``        .bash_profile       ``
Files

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   </div>

