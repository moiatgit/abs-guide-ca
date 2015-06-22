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

`Prev <redircb.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 20. I/O Redirection

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <subshells.html>`__

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

  20.3. Applications
===================

Clever use of I/O redirection permits parsing and stitching together
snippets of command output (see `Example
15-7 <internal.html#READREDIR>`__ ). This permits generating report and
log files.

.. raw:: html

   <div class="EXAMPLE">

**Example 20-12. Logging events**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # logevents.sh       |
|     # Author: Stephane C |
| hazelas.                 |
|     # Used in ABS Guide  |
| with permission.         |
|                          |
|     # Event logging to a |
|  file.                   |
|     # Must be run as roo |
| t (for write access in / |
| var/log).                |
|                          |
|     ROOT_UID=0     # Onl |
| y users with $UID 0 have |
|  root privileges.        |
|     E_NOTROOT=67   # Non |
| -root exit error.        |
|                          |
|                          |
|     if [ "$UID" -ne "$RO |
| OT_UID" ]                |
|     then                 |
|       echo "Must be root |
|  to run this script."    |
|       exit $E_NOTROOT    |
|     fi                   |
|                          |
|                          |
|     FD_DEBUG1=3          |
|     FD_DEBUG2=4          |
|     FD_DEBUG3=5          |
|                          |
|     # === Uncomment one  |
| of the two lines below t |
| o activate script. ===   |
|     # LOG_EVENTS=1       |
|     # LOG_VARS=1         |
|                          |
|                          |
|     log()  # Writes time |
|  and date to log file.   |
|     {                    |
|     echo "$(date)  $*" > |
| &7     # This *appends*  |
| the date to the file.    |
|     #     ^^^^^^^  comma |
| nd substitution          |
|                          |
|        # See below.      |
|     }                    |
|                          |
|                          |
|                          |
|     case $LOG_LEVEL in   |
|      1) exec 3>&2        |
|   4> /dev/null 5> /dev/n |
| ull;;                    |
|      2) exec 3>&2        |
|   4>&2         5> /dev/n |
| ull;;                    |
|      3) exec 3>&2        |
|   4>&2         5>&2;;    |
|      *) exec 3> /dev/nul |
| l 4> /dev/null 5> /dev/n |
| ull;;                    |
|     esac                 |
|                          |
|     FD_LOGVARS=6         |
|     if [[ $LOG_VARS ]]   |
|     then exec 6>> /var/l |
| og/vars.log              |
|     else exec 6> /dev/nu |
| ll                     # |
|  Bury output.            |
|     fi                   |
|                          |
|     FD_LOGEVENTS=7       |
|     if [[ $LOG_EVENTS ]] |
|     then                 |
|       # exec 7 >(exec ga |
| wk '{print strftime(), $ |
| 0}' >> /var/log/event.lo |
| g)                       |
|       # Above line fails |
|  in versions of Bash mor |
| e recent than 2.04. Why? |
|       exec 7>> /var/log/ |
| event.log              # |
|  Append to "event.log".  |
|       log                |
|                        # |
|  Write time and date.    |
|     else exec 7> /dev/nu |
| ll                     # |
|  Bury output.            |
|     fi                   |
|                          |
|     echo "DEBUG3: beginn |
| ing" >&${FD_DEBUG3}      |
|                          |
|     ls -l >&5 2>&4       |
|                        # |
|  command1 >&5 2>&4       |
|                          |
|     echo "Done"          |
|                        # |
|  command2                |
|                          |
|     echo "sending mail"  |
| >&${FD_LOGEVENTS}        |
|     # Writes "sending ma |
| il" to file descriptor # |
| 7.                       |
|                          |
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
| `Prev <redircb.html>`__  | Redirecting Code Blocks  |
| `Home <index.html>`__    | `Up <io-redirection.html |
| `Next <subshells.html>`_ | >`__                     |
| _                        | Subshells                |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

