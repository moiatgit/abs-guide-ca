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

`Prev <subshells.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <process-sub.html>`__

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

  Chapter 22. Restricted Shells
==============================

.. raw:: html

   <div class="VARIABLELIST">

** Disabled commands in restricted shells**

    .. raw:: html

       <div class="FORMALPARA">

    **.** Running a script or portion of a script in *restricted mode*
    disables certain commands that would otherwise be available. This is
    a security measure intended to limit the privileges of the script
    user and to minimize possible damage from running the script.

    .. raw:: html

       </div>

.. raw:: html

   </div>

The following commands and actions are disabled:

-  Using ``                 cd               `` to change the working
   directory.

-  Changing the values of the ``                 $PATH               ``
   , ``                 $SHELL               `` ,
   ``                 $BASH_ENV               `` , or
   ``                 $ENV               `` `environmental
   variables <othertypesv.html#ENVREF>`__ .

-  Reading or changing the
   ``                 $SHELLOPTS               `` , shell environmental
   options.

-  Output redirection.

-  Invoking commands containing one or more / 's.

-  Invoking `exec <internal.html#EXECREF>`__ to substitute a different
   process for the shell.

-  Various other commands that would enable monkeying with or attempting
   to subvert the script for an unintended purpose.

-  Getting out of restricted mode within the script.

.. raw:: html

   <div class="EXAMPLE">

**Example 22-1. Running a script in restricted mode**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #  Starting the scri |
| pt with "#!/bin/bash -r" |
|     #+ runs entire scrip |
| t in restricted mode.    |
|                          |
|     echo                 |
|                          |
|     echo "Changing direc |
| tory."                   |
|     cd /usr/local        |
|     echo "Now in `pwd`"  |
|     echo "Coming back ho |
| me."                     |
|     cd                   |
|     echo "Now in `pwd`"  |
|     echo                 |
|                          |
|     # Everything up to h |
| ere in normal, unrestric |
| ted mode.                |
|                          |
|     set -r               |
|     # set --restricted   |
|   has same effect.       |
|     echo "==> Now in res |
| tricted mode. <=="       |
|                          |
|     echo                 |
|     echo                 |
|                          |
|     echo "Attempting dir |
| ectory change in restric |
| ted mode."               |
|     cd ..                |
|     echo "Still in `pwd` |
| "                        |
|                          |
|     echo                 |
|     echo                 |
|                          |
|     echo "\$SHELL = $SHE |
| LL"                      |
|     echo "Attempting to  |
| change shell in restrict |
| ed mode."                |
|     SHELL="/bin/ash"     |
|     echo                 |
|     echo "\$SHELL= $SHEL |
| L"                       |
|                          |
|     echo                 |
|     echo                 |
|                          |
|     echo "Attempting to  |
| redirect output in restr |
| icted mode."             |
|     ls -l /usr/bin > bin |
| .files                   |
|     ls -l bin.files    # |
|  Try to list attempted f |
| ile creation effort.     |
|                          |
|     echo                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <subshells.html>`_ | Subshells                |
| _                        | `Up <part5.html>`__      |
| `Home <index.html>`__    | Process Substitution     |
| `Next <process-sub.html> |                          |
| `__                      |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

