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

`Prev <localization.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

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
============================

The Bash shell provides command-line tools for editing and manipulating
a user's *command history*. This is primarily a convenience, a means of
saving keystrokes.

Bash history commands:

#. **history**

#. **fc**

.. raw:: html

   </p>

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

.. raw:: html

   </p>

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

.. raw:: html

   </p>

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

.. raw:: html

   </p>

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ ./history.sh   |
|     (no output)          |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

The `Advancing in the Bash
Shell <http://samrowe.com/wordpress/advancing-in-the-bash-shell/>`__
site gives a good introduction to the use of history commands in Bash.

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <localization.html | Localization             |
| >`__                     |                          |
| `Home <index.html>`__    | Sample ``.bashrc`` and   |
| `Next <sample-bashrc.htm | ``.bash_profile`` Files  |
| l>`__                    |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

