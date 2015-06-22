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

`Prev <exitcodes.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <command-line-options.html>`__

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

  Appendix F. A Detailed Introduction to I/O and I/O Redirection
===============================================================

*written by Stéphane Chazelas, and revised by the document author*

A command expects the first three `file
descriptors <io-redirection.html#FDREF>`__ to be available. The first,
*fd 0* (standard input, ``      stdin     `` ), is for reading. The
other two ( *fd 1* , ``      stdout     `` and *fd 2* ,
``      stderr     `` ) are for writing.

There is a ``      stdin     `` , ``      stdout     `` , and a
``      stderr     `` associated with each command.
``             ls 2>&1           `` means temporarily connecting the
``      stderr     `` of the **ls** command to the same "resource" as
the shell's ``      stdout     `` .

By convention, a command reads its input from fd 0 (
``      stdin     `` ), prints normal output to fd 1 (
``      stdout     `` ), and error ouput to fd 2 ( ``      stderr     ``
). If one of those three fd's is not open, you may encounter problems:

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ cat /etc/passw |
| d >&-                    |
|     cat: standard output |
| : Bad file descriptor    |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

For example, when **xterm** runs, it first initializes itself. Before
running the user's shell, **xterm** opens the terminal device
(/dev/pts/<n> or something similar) three times.

At this point, Bash inherits these three file descriptors, and each
command (child process) run by Bash inherits them in turn, except when
you redirect the command.
`Redirection <io-redirection.html#IOREDIRREF>`__ means reassigning one
of the file descriptors to another file (or a pipe, or anything
permissible). File descriptors may be reassigned locally (for a command,
a command group, a `subshell <subshells.html#SUBSHELLSREF>`__ , a `while
or if or case or for loop <redircb.html#REDIRREF>`__ ...), or globally,
for the remainder of the shell (using `exec <internal.html#EXECREF>`__
).

``             ls > /dev/null           `` means running **ls** with its
fd 1 connected to ``      /dev/null     `` .

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ lsof -a -p $$  |
| -d0,1,2                  |
|     COMMAND PID     USER |
|    FD   TYPE DEVICE SIZE |
|  NODE NAME               |
|      bash    363 bozo    |
|      0u   CHR  136,1     |
|      3 /dev/pts/1        |
|      bash    363 bozo    |
|      1u   CHR  136,1     |
|      3 /dev/pts/1        |
|      bash    363 bozo    |
|      2u   CHR  136,1     |
|      3 /dev/pts/1        |
|                          |
|                          |
|     bash$ exec 2> /dev/n |
| ull                      |
|     bash$ lsof -a -p $$  |
| -d0,1,2                  |
|     COMMAND PID     USER |
|    FD   TYPE DEVICE SIZE |
|  NODE NAME               |
|      bash    371 bozo    |
|      0u   CHR  136,1     |
|      3 /dev/pts/1        |
|      bash    371 bozo    |
|      1u   CHR  136,1     |
|      3 /dev/pts/1        |
|      bash    371 bozo    |
|      2w   CHR    1,3     |
|    120 /dev/null         |
|                          |
|                          |
|     bash$ bash -c 'lsof  |
| -a -p $$ -d0,1,2' | cat  |
|     COMMAND PID USER   F |
| D   TYPE DEVICE SIZE NOD |
| E NAME                   |
|      lsof    379 root    |
|  0u   CHR  136,1         |
|  3 /dev/pts/1            |
|      lsof    379 root    |
|  1w  FIFO    0,0      71 |
| 18 pipe                  |
|      lsof    379 root    |
|  2u   CHR  136,1         |
|  3 /dev/pts/1            |
|                          |
|                          |
|     bash$ echo "$(bash - |
| c 'lsof -a -p $$ -d0,1,2 |
| ' 2>&1)"                 |
|     COMMAND PID USER   F |
| D   TYPE DEVICE SIZE NOD |
| E NAME                   |
|      lsof    426 root    |
|  0u   CHR  136,1         |
|  3 /dev/pts/1            |
|      lsof    426 root    |
|  1w  FIFO    0,0      75 |
| 20 pipe                  |
|      lsof    426 root    |
|  2w  FIFO    0,0      75 |
| 20 pipe                  |
                          
+--------------------------+--------------------------+--------------------------+

This works for different types of redirection.

``             Exercise:           `` Analyze the following script.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /usr/bin/env bash |
|                          |
|     mkfifo /tmp/fifo1 /t |
| mp/fifo2                 |
|     while read a; do ech |
| o "FIFO1: $a"; done < /t |
| mp/fifo1 & exec 7> /tmp/ |
| fifo1                    |
|     exec 8> >(while read |
|  a; do echo "FD8: $a, to |
|  fd7"; done >&7)         |
|                          |
|     exec 3>&1            |
|     (                    |
|      (                   |
|       (                  |
|        while read a; do  |
| echo "FIFO2: $a"; done < |
|  /tmp/fifo2 | tee /dev/s |
| tderr \                  |
|        | tee /dev/fd/4 | |
|  tee /dev/fd/5 | tee /de |
| v/fd/6 >&7 & exec 3> /tm |
| p/fifo2                  |
|                          |
|        echo 1st, to stdo |
| ut                       |
|        sleep 1           |
|        echo 2nd, to stde |
| rr >&2                   |
|        sleep 1           |
|        echo 3rd, to fd 3 |
|  >&3                     |
|        sleep 1           |
|        echo 4th, to fd 4 |
|  >&4                     |
|        sleep 1           |
|        echo 5th, to fd 5 |
|  >&5                     |
|        sleep 1           |
|        echo 6th, through |
|  a pipe | sed 's/.*/PIPE |
| : &, to fd 5/' >&5       |
|        sleep 1           |
|        echo 7th, to fd 6 |
|  >&6                     |
|        sleep 1           |
|        echo 8th, to fd 7 |
|  >&7                     |
|        sleep 1           |
|        echo 9th, to fd 8 |
|  >&8                     |
|                          |
|       ) 4>&1 >&3 3>&- |  |
| while read a; do echo "F |
| D4: $a"; done 1>&3 5>&-  |
| 6>&-                     |
|      ) 5>&1 >&3 | while  |
| read a; do echo "FD5: $a |
| "; done 1>&3 6>&-        |
|     ) 6>&1 >&3 | while r |
| ead a; do echo "FD6: $a" |
| ; done 3>&-              |
|                          |
|     rm -f /tmp/fifo1 /tm |
| p/fifo2                  |
|                          |
|                          |
|     # For each command a |
| nd subshell, figure out  |
| which fd points to what. |
|     # Good luck!         |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

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

`Prev <exitcodes.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

`Home <index.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

`Next <command-line-options.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

Exit Codes With Special Meanings

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

Command-Line Options

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   </div>

