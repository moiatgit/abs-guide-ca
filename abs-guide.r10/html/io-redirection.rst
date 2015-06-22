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

`Prev <x17837.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <x17974.html>`__

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

Chapter 20. I/O Redirection
===========================

.. raw:: html

   <div class="TOC">

.. raw:: html

   <dl>

.. raw:: html

   <dt>

**Table of Contents**

.. raw:: html

   </dt>

.. raw:: html

   <dt>

20.1. `Using *exec* <x17974.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

20.2. `Redirecting Code Blocks <redircb.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

20.3. `Applications <redirapps.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </div>

There are always three default *files*
`[1] <io-redirection.html#FTN.AEN17884>`__ open, ``stdin`` (the
keyboard), ``stdout`` (the screen), and ``stderr`` (error messages
output to the screen). These, and any other open files, can be
redirected. Redirection simply means capturing output from a file,
command, program, script, or even code block within a script (see
`Example 3-1 <special-chars.html#EX8>`__ and `Example
3-2 <special-chars.html#RPMCHECK>`__) and sending it as input to another
file, command, program, or script.

Each open file gets assigned a file descriptor.
`[2] <io-redirection.html#FTN.AEN17894>`__ The file descriptors for
``stdin``, ``stdout``, and ``stderr`` are 0, 1, and 2, respectively. For
opening additional files, there remain descriptors 3 to 9. It is
sometimes useful to assign one of these additional file descriptors to
``stdin``, ``stdout``, or ``stderr`` as a temporary duplicate link.
`[3] <io-redirection.html#FTN.AEN17906>`__ This simplifies restoration
to normal after complex redirection and reshuffling (see `Example
20-1 <x17974.html#REDIR1>`__).

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|        COMMAND_OUTPUT >  |
|           # Redirect std |
| out to a file.           |
|           # Creates the  |
| file if not present, oth |
| erwise overwrites it.    |
|                          |
|           ls -lR > dir-t |
| ree.list                 |
|           # Creates a fi |
| le containing a listing  |
| of the directory tree.   |
|                          |
|        : > filename      |
|           # The > trunca |
| tes file "filename" to z |
| ero length.              |
|           # If file not  |
| present, creates zero-le |
| ngth file (same effect a |
| s 'touch').              |
|           # The : serves |
|  as a dummy placeholder, |
|  producing no output.    |
|                          |
|        > filename        |
|           # The > trunca |
| tes file "filename" to z |
| ero length.              |
|           # If file not  |
| present, creates zero-le |
| ngth file (same effect a |
| s 'touch').              |
|           # (Same result |
|  as ": >", above, but th |
| is does not work with so |
| me shells.)              |
|                          |
|        COMMAND_OUTPUT >> |
|           # Redirect std |
| out to a file.           |
|           # Creates the  |
| file if not present, oth |
| erwise appends to it.    |
|                          |
|                          |
|           # Single-line  |
| redirection commands (af |
| fect only the line they  |
| are on):                 |
|           # ------------ |
| ------------------------ |
| ------------------------ |
| --------                 |
|                          |
|        1>filename        |
|           # Redirect std |
| out to file "filename."  |
|        1>>filename       |
|           # Redirect and |
|  append stdout to file " |
| filename."               |
|        2>filename        |
|           # Redirect std |
| err to file "filename."  |
|        2>>filename       |
|           # Redirect and |
|  append stderr to file " |
| filename."               |
|        &>filename        |
|           # Redirect bot |
| h stdout and stderr to f |
| ile "filename."          |
|           # This operato |
| r is now functional, as  |
| of Bash 4, final release |
| .                        |
|                          |
|        M>N               |
|          # "M" is a file |
|  descriptor, which defau |
| lts to 1, if not explici |
| tly set.                 |
|          # "N" is a file |
| name.                    |
|          # File descript |
| or "M" is redirect to fi |
| le "N."                  |
|        M>&N              |
|          # "M" is a file |
|  descriptor, which defau |
| lts to 1, if not set.    |
|          # "N" is anothe |
| r file descriptor.       |
|                          |
|           #============= |
| ======================== |
| ======================== |
| =================        |
|                          |
|           # Redirecting  |
| stdout, one line at a ti |
| me.                      |
|           LOGFILE=script |
| .log                     |
|                          |
|           echo "This sta |
| tement is sent to the lo |
| g file, \"$LOGFILE\"." 1 |
| >$LOGFILE                |
|           echo "This sta |
| tement is appended to \" |
| $LOGFILE\"." 1>>$LOGFILE |
|           echo "This sta |
| tement is also appended  |
| to \"$LOGFILE\"." 1>>$LO |
| GFILE                    |
|           echo "This sta |
| tement is echoed to stdo |
| ut, and will not appear  |
| in \"$LOGFILE\"."        |
|           # These redire |
| ction commands automatic |
| ally "reset" after each  |
| line.                    |
|                          |
|                          |
|                          |
|           # Redirecting  |
| stderr, one line at a ti |
| me.                      |
|           ERRORFILE=scri |
| pt.errors                |
|                          |
|           bad_command1 2 |
| >$ERRORFILE       #  Err |
| or message sent to $ERRO |
| RFILE.                   |
|           bad_command2 2 |
| >>$ERRORFILE      #  Err |
| or message appended to $ |
| ERRORFILE.               |
|           bad_command3   |
|                   #  Err |
| or message echoed to std |
| err,                     |
|                          |
|                   #+ and |
|  does not appear in $ERR |
| ORFILE.                  |
|           # These redire |
| ction commands also auto |
| matically "reset" after  |
| each line.               |
|           #============= |
| ======================== |
| ======================== |
| ==========               |
                          
+--------------------------+--------------------------+--------------------------+

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|        2>&1              |
|           # Redirects st |
| derr to stdout.          |
|           # Error messag |
| es get sent to same plac |
| e as standard output.    |
|             >>filename 2 |
| >&1                      |
|                 bad_comm |
| and >>filename 2>&1      |
|                 # Append |
| s both stdout and stderr |
|  to the file "filename"  |
| ...                      |
|             2>&1 | [comm |
| and(s)]                  |
|                 bad_comm |
| and 2>&1 | awk '{print $ |
| 5}'   # found            |
|                 # Sends  |
| stderr through a pipe.   |
|                 # |& was |
|  added to Bash 4 as an a |
| bbreviation for 2>&1 |.  |
|                          |
|        i>&j              |
|           # Redirects fi |
| le descriptor i to j.    |
|           # All output o |
| f file pointed to by i g |
| ets sent to file pointed |
|  to by j.                |
|                          |
|        >&j               |
|           # Redirects, b |
| y default, file descript |
| or 1 (stdout) to j.      |
|           # All stdout g |
| ets sent to file pointed |
|  to by j.                |
                          
+--------------------------+--------------------------+--------------------------+

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|        0< FILENAME       |
|         < FILENAME       |
|           # Accept input |
|  from a file.            |
|           # Companion co |
| mmand to ">", and often  |
| used in combination with |
|  it.                     |
|           #              |
|           # grep search- |
| word <filename           |
|                          |
|                          |
|        [j]<>filename     |
|           #  Open file " |
| filename" for reading an |
| d writing,               |
|           #+ and assign  |
| file descriptor "j" to i |
| t.                       |
|           #  If "filenam |
| e" does not exist, creat |
| e it.                    |
|           #  If file des |
| criptor "j" is not speci |
| fied, default to fd 0, s |
| tdin.                    |
|           #              |
|           #  An applicat |
| ion of this is writing a |
| t a specified place in a |
|  file.                   |
|           echo 123456789 |
| 0 > File    # Write stri |
| ng to "File".            |
|           exec 3<> File  |
|             # Open "File |
| " and assign fd 3 to it. |
|           read -n 4 <&3  |
|             # Read only  |
| 4 characters.            |
|           echo -n . >&3  |
|             # Write a de |
| cimal point there.       |
|           exec 3>&-      |
|             # Close fd 3 |
| .                        |
|           cat File       |
|             # ==> 1234.6 |
| 7890                     |
|           #  Random acce |
| ss, by golly.            |
|                          |
|                          |
|                          |
|        |                 |
|           # Pipe.        |
|           # General purp |
| ose process and command  |
| chaining tool.           |
|           # Similar to " |
| >", but more general in  |
| effect.                  |
|           # Useful for c |
| haining commands, script |
| s, files, and programs t |
| ogether.                 |
|           cat *.txt | so |
| rt | uniq > result-file  |
|           # Sorts the ou |
| tput of all the .txt fil |
| es and deletes duplicate |
|  lines,                  |
|           # finally save |
| s results to "result-fil |
| e".                      |
                          
+--------------------------+--------------------------+--------------------------+

Multiple instances of input and output redirection and/or pipes can be
combined in a single command line.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     command < input-file |
|  > output-file           |
|     # Or the equivalent: |
|     < input-file command |
|  > output-file   # Altho |
| ugh this is non-standard |
| .                        |
|                          |
|     command1 | command2  |
| | command3 > output-file |
                          
+--------------------------+--------------------------+--------------------------+

See `Example 16-31 <filearchiv.html#DERPM>`__ and `Example
A-14 <contributed-scripts.html#FIFO>`__.

.. raw:: html

   </p>

Multiple output streams may be redirected to one file.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     ls -yz >> command.lo |
| g 2>&1                   |
|     #  Capture result of |
|  illegal options "yz" in |
|  file "command.log."     |
|     #  Because stderr is |
|  redirected to the file, |
|     #+ any error message |
| s will also be there.    |
|                          |
|     #  Note, however, th |
| at the following does *n |
| ot* give the same result |
| .                        |
|     ls -yz 2>&1 >> comma |
| nd.log                   |
|     #  Outputs an error  |
| message, but does not wr |
| ite to file.             |
|     #  More precisely, t |
| he command output (in th |
| is case, null)           |
|     #+ writes to the fil |
| e, but the error message |
|  goes only to stdout.    |
|                          |
|     #  If redirecting bo |
| th stdout and stderr,    |
|     #+ the order of the  |
| commands makes a differe |
| nce.                     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="VARIABLELIST">

**Closing File Descriptors**

n<&-
    Close input file descriptor ``n``.

0<&-, <&-
    Close ``stdin``.

n>&-
    Close output file descriptor ``n``.

1>&-, >&-
    Close ``stdout``.

.. raw:: html

   </div>

Child processes inherit open file descriptors. This is why pipes work.
To prevent an fd from being inherited, close it.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # Redirecting only s |
| tderr to a pipe.         |
|                          |
|     exec 3>&1            |
|                    # Sav |
| e current "value" of std |
| out.                     |
|     ls -l 2>&1 >&3 3>&-  |
| | grep bad 3>&-    # Clo |
| se fd 3 for 'grep' (but  |
| not 'ls').               |
|     #              ^^^^  |
|   ^^^^                   |
|     exec 3>&-            |
|                    # Now |
|  close it for the remain |
| der of the script.       |
|                          |
|     # Thanks, S.C.       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

For a more detailed introduction to I/O redirection see `Appendix
F <ioredirintro.html>`__.

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <io-redirection.html#AEN17884>` | `[2] <io-redirection.html#AEN17894>` |
| __                                   | __                                   |
| By convention in UNIX and Linux,     | A *file descriptor* is simply a      |
| data streams and peripherals         | number that the operating system     |
| (`device                             | assigns to an open file to keep      |
| files <devref1.html#DEVFILEREF>`__)  | track of it. Consider it a           |
| are treated as files, in a fashion   | simplified type of file pointer. It  |
| analogous to ordinary files.         | is analogous to a *file handle* in   |
|                                      | **C**.                               |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <x17837.html>`__   | Here Strings             |
| `Home <index.html>`__    | `Up <part5.html>`__      |
| `Next <x17974.html>`__   | Using *exec*             |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

