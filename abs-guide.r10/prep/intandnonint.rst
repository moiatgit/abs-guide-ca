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

`Prev <miscellany.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 36. Miscellany

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <wrapper.html>`__

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

  36.1. Interactive and non-interactive shells and scripts
=========================================================

An *interactive* shell reads commands from user input on a
``      tty     `` . Among other things, such a shell reads startup
files on activation, displays a prompt, and enables job control by
default. The user can *interact* with the shell.

A shell running a script is always a non-interactive shell. All the
same, the script can still access its ``      tty     `` . It is even
possible to emulate an interactive shell in a script.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     MY_PROMPT='$ '       |
|     while :              |
|     do                   |
|       echo -n "$MY_PROMP |
| T"                       |
|       read line          |
|       eval "$line"       |
|       done               |
|                          |
|     exit 0               |
|                          |
|     # This example scrip |
| t, and much of the above |
|  explanation supplied by |
|     # StĂŠphane Chazelas |
|  (thanks again).         |
                          
+--------------------------+--------------------------+--------------------------+

Let us consider an *interactive* script to be one that requires input
from the user, usually with `read <internal.html#READREF>`__ statements
(see `Example 15-3 <internal.html#EX36>`__ ). "Real life" is actually a
bit messier than that. For now, assume an interactive script is bound to
a tty, a script that a user has invoked from the console or an *xterm* .

Init and startup scripts are necessarily non-interactive, since they
must run without human intervention. Many administrative and system
maintenance scripts are likewise non-interactive. Unvarying repetitive
tasks cry out for automation by non-interactive scripts.

Non-interactive scripts can run in the background, but interactive ones
hang, waiting for input that never comes. Handle that difficulty by
having an **expect** script or embedded `here
document <here-docs.html#HEREDOCREF>`__ feed input to an interactive
script running as a background job. In the simplest case, redirect a
file to supply input to a **read** statement ( **read variable <file**
). These particular workarounds make possible general purpose scripts
that run in either interactive or non-interactive modes.

If a script needs to test whether it is running in an interactive shell,
it is simply a matter of finding whether the *prompt* variable,
`$PS1 <internalvariables.html#PS1REF>`__ is set. (If the user is being
prompted for input, then the script needs to display a prompt.)

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     if [ -z $PS1 ] # no  |
| prompt?                  |
|     ### if [ -v PS1 ]    |
| # On Bash 4.2+ ...       |
|     then                 |
|       # non-interactive  |
|       ...                |
|     else                 |
|       # interactive      |
|       ...                |
|     fi                   |
                          
+--------------------------+--------------------------+--------------------------+

 Alternatively, the script can test for the presence of option "i" in
the `$- <internalvariables.html#FLPREF>`__ flag.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     case $- in           |
|     *i*)    # interactiv |
| e shell                  |
|     ;;                   |
|     *)      # non-intera |
| ctive shell              |
|     ;;                   |
|     # (Courtesy of "UNIX |
|  F.A.Q.," 1993)          |
                          
+--------------------------+--------------------------+--------------------------+

 However, John Lange describes an alternative method, using the ` -t
*test* operator <fto.html#TERMTEST>`__ .

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # Test for a termina |
| l!                       |
|                          |
|     fd=0   # stdin       |
|                          |
|     #  As we recall, the |
|  -t test option checks w |
| hether the stdin, [ -t 0 |
|  ],                      |
|     #+ or stdout, [ -t 1 |
|  ], in a given script is |
|  running in a terminal.  |
|     if [ -t "$fd" ]      |
|     then                 |
|       echo interactive   |
|     else                 |
|       echo non-interacti |
| ve                       |
|     fi                   |
|                          |
|                          |
|     #  But, as John poin |
| ts out:                  |
|     #    if [ -t 0 ] wor |
| ks ... when you're logge |
| d in locally             |
|     #    but fails when  |
| you invoke the command r |
| emotely via ssh.         |
|     #    So for a true t |
| est you also have to tes |
| t for a socket.          |
|                          |
|     if [[ -t "$fd" || -p |
|  /dev/stdin ]]           |
|     then                 |
|       echo interactive   |
|     else                 |
|       echo non-interacti |
| ve                       |
|     fi                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| Scripts may be forced to run in      |
| interactive mode with the -i option  |
| or with a                            |
| ``                     #!/bin/bash - |
| i                   ``               |
| header. Be aware that this can cause |
| erratic script behavior or show      |
| error messages even when no error is |
| present.                             |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <miscellany.html>` | Miscellany               |
| __                       | `Up <miscellany.html>`__ |
| `Home <index.html>`__    | Shell Wrappers           |
| `Next <wrapper.html>`__  |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
