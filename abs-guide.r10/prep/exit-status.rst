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

`Prev <escapingsection.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <tests.html>`__

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

  Chapter 6. Exit and Exit Status
================================

+--------------------------+--------------------------+--------------------------+
| **                       |
| *... there are dark      |
| corners in the Bourne    |
| shell, and people use    |
| all of them.*            |
|                          |
| *--Chet Ramey*           |
+--------------------------+--------------------------+--------------------------+

 The **exit** command terminates a script, just as in a **C** program.
It can also return a value, which is available to the script's parent
process.

 Every command returns an *exit status* (sometimes referred to as a
*return status* or *exit code* ). A successful command returns a 0 ,
while an unsuccessful one returns a non-zero value that usually can be
interpreted as an *error code* . Well-behaved UNIX commands, programs,
and utilities return a 0 exit code upon successful completion, though
there are some exceptions.

Likewise, `functions <functions.html#FUNCTIONREF>`__ within a script and
the script itself return an exit status. The last command executed in
the function or script determines the exit status. Within a script, an
``             exit                        nnn               `` command
may be used to deliver an ``               nnn             `` exit
status to the shell ( ``               nnn             `` must be an
integer in the 0 - 255 range).

.. raw:: html

   <div class="NOTE">

+----------+----------+----------+----------+----------+----------+----------+----------+----------+
| |Note|   |
| When a   |
| script   |
| ends     |
| with an  |
| **exit** |
| that has |
| no       |
| paramete |
| r,       |
| the exit |
| status   |
| of the   |
| script   |
| is the   |
| exit     |
| status   |
| of the   |
| last     |
| command  |
| executed |
| in the   |
| script   |
| (previou |
| s        |
| to the   |
| **exit** |
| ).       |
|          |
| +------- |
| -------- |
| -------- |
| ---+---- |
| -------- |
| -------- |
| ------+- |
| -------- |
| -------- |
| -------- |
| -+       |
| | .. cod |
| e:: PROG |
| RAMLISTI |
| NG |     |
| |        |
|          |
|          |
|    |     |
| |     #! |
| /bin/bas |
| h        |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     CO |
| MMAND_1  |
|          |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     .  |
| . .      |
|          |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     CO |
| MMAND_LA |
| ST       |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     #  |
| Will exi |
| t with s |
| ta |     |
| | tus of |
|  last co |
| mmand.   |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     ex |
| it       |
|          |
|    |     |
|          |
|          |
|          |
|          |
| +------- |
| -------- |
| -------- |
| ---+---- |
| -------- |
| -------- |
| ------+- |
| -------- |
| -------- |
| -------- |
| -+       |
|          |
| The      |
| equivale |
| nt       |
| of a     |
| bare     |
| **exit** |
| is       |
| **exit   |
| $?** or  |
| even     |
| just     |
| omitting |
| the      |
| **exit** |
| .        |
|          |
| +------- |
| -------- |
| -------- |
| ---+---- |
| -------- |
| -------- |
| ------+- |
| -------- |
| -------- |
| -------- |
| -+       |
| | .. cod |
| e:: PROG |
| RAMLISTI |
| NG |     |
| |        |
|          |
|          |
|    |     |
| |     #! |
| /bin/bas |
| h        |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     CO |
| MMAND_1  |
|          |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     .  |
| . .      |
|          |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     CO |
| MMAND_LA |
| ST       |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     #  |
| Will exi |
| t with s |
| ta |     |
| | tus of |
|  last co |
| mmand.   |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     ex |
| it $?    |
|          |
|    |     |
|          |
|          |
|          |
|          |
| +------- |
| -------- |
| -------- |
| ---+---- |
| -------- |
| -------- |
| ------+- |
| -------- |
| -------- |
| -------- |
| -+       |
|          |
| +------- |
| -------- |
| -------- |
| ---+---- |
| -------- |
| -------- |
| ------+- |
| -------- |
| -------- |
| -------- |
| -+       |
| | .. cod |
| e:: PROG |
| RAMLISTI |
| NG |     |
| |        |
|          |
|          |
|    |     |
| |     #! |
| /bin/bas |
| h        |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     CO |
| MMAND1   |
|          |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     .  |
| . .      |
|          |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     CO |
| MMAND_LA |
| ST       |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     #  |
| Will exi |
| t with s |
| ta |     |
| | tus of |
|  last co |
| mmand.   |
|    |     |
|          |
|          |
|          |
|          |
| +------- |
| -------- |
| -------- |
| ---+---- |
| -------- |
| -------- |
| ------+- |
| -------- |
| -------- |
| -------- |
| -+       |
          
+----------+----------+----------+----------+----------+----------+----------+----------+----------+

.. raw:: html

   </div>

``      $?     `` reads the exit status of the last command executed.
After a function returns, ``      $?     `` gives the exit status of the
last command executed in the function. This is Bash's way of giving
functions a "return value." ` [1]  <exit-status.html#FTN.AEN2981>`__

 Following the execution of a `pipe <special-chars.html#PIPEREF>`__ , a
``      $?     `` gives the exit status of the last command executed.

After a script terminates, a ``      $?     `` from the command-line
gives the exit status of the script, that is, the last command executed
in the script, which is, by convention, ``             0           `` on
success or an integer in the range 1 - 255 on error.

.. raw:: html

   <div class="EXAMPLE">

**Example 6-1. exit / exit status**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     echo hello           |
|     echo $?    # Exit st |
| atus 0 returned because  |
| command executed success |
| fully.                   |
|                          |
|     lskdf      # Unrecog |
| nized command.           |
|     echo $?    # Non-zer |
| o exit status returned - |
| - command failed to exec |
| ute.                     |
|                          |
|     echo                 |
|                          |
|     exit 113   # Will re |
| turn 113 to shell.       |
|                # To veri |
| fy this, type "echo $?"  |
| after script terminates. |
|                          |
|     #  By convention, an |
|  'exit 0' indicates succ |
| ess,                     |
|     #+ while a non-zero  |
| exit value means an erro |
| r or anomalous condition |
| .                        |
|     #  See the "Exit Cod |
| es With Special Meanings |
| " appendix.              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

`$? <internalvariables.html#XSTATVARREF>`__ is especially useful for
testing the result of a command in a script (see `Example
16-35 <filearchiv.html#FILECOMP>`__ and `Example
16-20 <textproc.html#LOOKUP>`__ ).

.. raw:: html

   <div class="NOTE">

+--------------------------+--------------------------+--------------------------+
| |Note|                   |
| The                      |
| `! <special-chars.html#N |
| OTREF>`__                |
| , the *logical not*      |
| qualifier, reverses the  |
| outcome of a test or     |
| command, and this        |
| affects its `exit        |
| status <exit-status.html |
| #EXITSTATUSREF>`__       |
| .                        |
|                          |
| .. raw:: html            |
|                          |
|    <div class="EXAMPLE"> |
|                          |
| **Example 6-2. Negating  |
| a condition using ! **   |
|                          |
| +----------------------- |
| ---+-------------------- |
| ------+----------------- |
| ---------+               |
| | .. code:: PROGRAMLISTI |
| NG |                     |
| |                        |
|    |                     |
| |     true    # The "tru |
| e" |                     |
| |  builtin.              |
|    |                     |
| |     echo "exit status  |
| of |                     |
| |  \"true\" = $?"     #  |
| 0  |                     |
| |                        |
|    |                     |
| |     ! true             |
|    |                     |
| |     echo "exit status  |
| of |                     |
| |  \"! true\" = $?"   #  |
| 1  |                     |
| |     # Note that the "! |
| "  |                     |
| | needs a space between  |
| it |                     |
| |  and the command.      |
|    |                     |
| |     #    !true   leads |
|  t |                     |
| | o a "command not found |
| "  |                     |
| | error                  |
|    |                     |
| |     #                  |
|    |                     |
| |     # The '!' operator |
|  p |                     |
| | refixing a command inv |
| ok |                     |
| | es the Bash history me |
| ch |                     |
| | anism.                 |
|    |                     |
| |                        |
|    |                     |
| |     true               |
|    |                     |
| |     !true              |
|    |                     |
| |     # No error this ti |
| me |                     |
| | , but no negation eith |
| er |                     |
| | .                      |
|    |                     |
| |     # It just repeats  |
| th |                     |
| | e previous command (tr |
| ue |                     |
| | ).                     |
|    |                     |
| |                        |
|    |                     |
| |                        |
|    |                     |
| |     # ================ |
| == |                     |
| | ====================== |
| == |                     |
| | ================= #    |
|    |                     |
| |     # Preceding a _pip |
| e_ |                     |
| |  with ! inverts the ex |
| it |                     |
| |  status returned.      |
|    |                     |
| |     ls | bogus_command |
|    |                     |
| |    # bash: bogus_comma |
| nd |                     |
| | : command not found    |
|    |                     |
| |     echo $?            |
|    |                     |
| |    # 127               |
|    |                     |
| |                        |
|    |                     |
| |     ! ls | bogus_comma |
| nd |                     |
| |    # bash: bogus_comma |
| nd |                     |
| | : command not found    |
|    |                     |
| |     echo $?            |
|    |                     |
| |    # 0                 |
|    |                     |
| |     # Note that the !  |
| do |                     |
| | es not change the exec |
| ut |                     |
| | ion of the pipe.       |
|    |                     |
| |     # Only the exit st |
| at |                     |
| | us changes.            |
|    |                     |
| |     # ================ |
| == |                     |
| | ====================== |
| == |                     |
| | ================= #    |
|    |                     |
| |                        |
|    |                     |
| |     # Thanks, Stéphane |
|  C |                     |
| | hazelas and Kristopher |
|  N |                     |
| | ewsome.                |
|    |                     |
|                          |
|                          |
| +----------------------- |
| ---+-------------------- |
| ------+----------------- |
| ---------+               |
|                          |
| .. raw:: html            |
|                          |
|    </div>                |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+--------------------------------------+--------------------------------------+
| |Caution|                            |
| Certain exit status codes have       |
| `reserved                            |
| meanings <exitcodes.html#EXITCODESRE |
| F>`__                                |
| and should not be user-specified in  |
| a script.                            |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <exit-status.html#AEN2981>`__ |
| In those instances when there is no  |
| `return <complexfunct.html#RETURNREF |
| >`__                                 |
| terminating the function.            |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <escapingsection.h | Escaping                 |
| tml>`__                  | `Up <part2.html>`__      |
| `Home <index.html>`__    | Tests                    |
| `Next <tests.html>`__    |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Caution| image:: ../images/caution.gif
