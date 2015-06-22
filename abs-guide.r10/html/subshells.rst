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

`Prev <redirapps.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <restricted-sh.html>`__

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

Chapter 21. Subshells
=====================

Running a shell script launches a new process, a *subshell*.

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| ``Definition:`` A *subshell* is a `child                                 |
| process <othertypesv.html#CHILDREF2>`__ launched by a shell (or *shell   |
| script*).                                                                |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

A subshell is a separate instance of the command processor -- the
*shell* that gives you the prompt at the console or in an *xterm*
window. Just as your commands are interpreted at the command-line
prompt, similarly does a script
`batch-process <timedate.html#BATCHPROCREF>`__ a list of commands. Each
shell script running is, in effect, a subprocess (*child process*) of
the `parent <internal.html#FORKREF>`__ shell.

A shell script can itself launch subprocesses. These *subshells* let the
script do parallel processing, in effect executing multiple subtasks
simultaneously.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # subshell-test.sh   |
|                          |
|     (                    |
|     # Inside parentheses |
| , and therefore a subshe |
| ll . . .                 |
|     while [ 1 ]   # Endl |
| ess loop.                |
|     do                   |
|       echo "Subshell run |
| ning . . ."              |
|     done                 |
|     )                    |
|                          |
|     #  Script will run f |
| orever,                  |
|     #+ or at least until |
|  terminated by a Ctl-C.  |
|                          |
|     exit $?  # End of sc |
| ript (but will never get |
|  here).                  |
|                          |
|                          |
|                          |
|     Now, run the script: |
|     sh subshell-test.sh  |
|                          |
|     And, while the scrip |
| t is running, from a dif |
| ferent xterm:            |
|     ps -ef | grep subshe |
| ll-test.sh               |
|                          |
|     UID       PID   PPID |
|   C STIME TTY      TIME  |
|     CMD                  |
|     500       2698  2502 |
|   0 14:26 pts/4    00:00 |
| :00 sh subshell-test.sh  |
|     500       2699  2698 |
|  21 14:26 pts/4    00:00 |
| :24 sh subshell-test.sh  |
|                          |
|               ^^^^       |
|                          |
|     Analysis:            |
|     PID 2698, the script |
| , launched PID 2699, the |
|  subshell.               |
|                          |
|     Note: The "UID ..."  |
| line would be filtered o |
| ut by the "grep" command |
| ,                        |
|     but is shown here fo |
| r illustrative purposes. |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

In general, an `external command <external.html#EXTERNALREF>`__ in a
script `forks off <internal.html#FORKREF>`__ a subprocess,
`[1] <subshells.html#FTN.AEN18102>`__ whereas a Bash
`builtin <internal.html#BUILTINREF>`__ does not. For this reason,
builtins execute more quickly and use fewer system resources than their
external command equivalents.

.. raw:: html

   <div class="VARIABLELIST">

**Command List within Parentheses**

( command1; command2; command3; ... )
    A command list embedded between ``parentheses`` runs as a subshell.

.. raw:: html

   </div>

Variables in a subshell are *not* visible outside the block of code in
the subshell. They are not accessible to the `parent
process <internal.html#FORKREF>`__, to the shell that launched the
subshell. These are, in effect, variables
`local <localvar.html#LOCALREF>`__ to the *child process*.

.. raw:: html

   <div class="EXAMPLE">

**Example 21-1. Variable scope in a subshell**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # subshell.sh        |
|                          |
|     echo                 |
|                          |
|     echo "We are outside |
|  the subshell."          |
|     echo "Subshell level |
|  OUTSIDE subshell = $BAS |
| H_SUBSHELL"              |
|     # Bash, version 3, a |
| dds the new         $BAS |
| H_SUBSHELL variable.     |
|     echo; echo           |
|                          |
|     outer_variable=Outer |
|     global_variable=     |
|     #  Define global var |
| iable for "storage" of   |
|     #+ value of subshell |
|  variable.               |
|                          |
|     (                    |
|     echo "We are inside  |
| the subshell."           |
|     echo "Subshell level |
|  INSIDE subshell = $BASH |
| _SUBSHELL"               |
|     inner_variable=Inner |
|                          |
|     echo "From inside su |
| bshell, \"inner_variable |
| \" = $inner_variable"    |
|     echo "From inside su |
| bshell, \"outer\" = $out |
| er_variable"             |
|                          |
|     global_variable="$in |
| ner_variable"   #  Will  |
| this allow "exporting"   |
|                          |
|                 #+ a sub |
| shell variable?          |
|     )                    |
|                          |
|     echo; echo           |
|     echo "We are outside |
|  the subshell."          |
|     echo "Subshell level |
|  OUTSIDE subshell = $BAS |
| H_SUBSHELL"              |
|     echo                 |
|                          |
|     if [ -z "$inner_vari |
| able" ]                  |
|     then                 |
|       echo "inner_variab |
| le undefined in main bod |
| y of shell"              |
|     else                 |
|       echo "inner_variab |
| le defined in main body  |
| of shell"                |
|     fi                   |
|                          |
|     echo "From main body |
|  of shell, \"inner_varia |
| ble\" = $inner_variable" |
|     #  $inner_variable w |
| ill show as blank (unini |
| tialized)                |
|     #+ because variables |
|  defined in a subshell a |
| re "local variables".    |
|     #  Is there a remedy |
|  for this?               |
|     echo "global_variabl |
| e = "$global_variable""  |
|  # Why doesn't this work |
| ?                        |
|                          |
|     echo                 |
|                          |
|     # ================== |
| ======================== |
| ======================== |
| =====                    |
|                          |
|     # Additionally ...   |
|                          |
|     echo "-------------- |
| ---"; echo               |
|                          |
|     var=41               |
|                          |
|            # Global vari |
| able.                    |
|                          |
|     ( let "var+=1"; echo |
|  "\$var INSIDE subshell  |
| = $var" )  # 42          |
|                          |
|     echo "\$var OUTSIDE  |
| subshell = $var"         |
|            # 41          |
|     #  Variable operatio |
| ns inside a subshell, ev |
| en to a GLOBAL variable  |
|     #+ do not affect the |
|  value of the variable o |
| utside the subshell!     |
|                          |
|                          |
|     exit 0               |
|                          |
|     #  Question:         |
|     #  --------          |
|     #  Once having exite |
| d a subshell,            |
|     #+ is there any way  |
| to reenter that very sam |
| e subshell               |
|     #+ to modify or acce |
| ss the subshell variable |
| s?                       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

See also `$BASHPID <internalvariables.html#BASHPIDREF>`__ and `Example
34-2 <gotchas.html#SUBPIT>`__.

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| ``Definition:`` The *scope* of a variable is the context in which it has |
| meaning, in which it has a *value* that can be referenced. For example,  |
| the scope of a `local variable <localvar.html#LOCALREF1>`__ lies only    |
| within the function, block of code, or subshell within which it is       |
| defined, while the scope of a *global* variable is the entire script in  |
| which it appears.                                                        |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

.. raw:: html

   <div class="NOTE">

+----------------+----------------+----------------+----------------+----------------+
| |Note|         |
| While the      |
| `$BASH\_SUBSHE |
| LL <internalva |
| riables.html#B |
| ASHSUBSHELLREF |
| >`__           |
| internal       |
| variable       |
| indicates the  |
| nesting level  |
| of a subshell, |
| the            |
| `$SHLVL <inter |
| nalvariables.h |
| tml#SHLVLREF>` |
| __             |
| variable       |
| *shows no      |
| change* within |
| a subshell.    |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
| | .. code:: PR |
| OGRAMLISTING | |
| |              |
|              | |
| |     echo " \ |
| $BASH_SUBSHE | |
| | LL outside s |
| ubshell      | |
| |   = $BASH_SU |
| BSHELL"      | |
| |       # 0    |
|              | |
| |       ( echo |
|  " \$BASH_SU | |
| | BSHELL insid |
| e subshell   | |
| |       = $BAS |
| H_SUBSHELL"  | |
| | )     # 1    |
|              | |
| |       ( ( ec |
| ho " \$BASH_ | |
| | SUBSHELL ins |
| ide nested s | |
| | ubshell = $B |
| ASH_SUBSHELL | |
| | " ) ) # 2    |
|              | |
| |     # ^ ^    |
|              | |
| |              |
| *** nested * | |
| | **           |
|              | |
| |   ^ ^        |
|              | |
| |              |
|              | |
| |     echo     |
|              | |
| |              |
|              | |
| |     echo " \ |
| $SHLVL outsi | |
| | de subshell  |
| = $SHLVL"    | |
| |     # 3      |
|              | |
| |     ( echo " |
|  \$SHLVL ins | |
| | ide subshell |
|   = $SHLVL"  | |
| | )   # 3 (No  |
| change!)     | |
|                |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
|                |
| .. raw:: html  |
|                |
|    </p>        |
                
+----------------+----------------+----------------+----------------+----------------+

.. raw:: html

   </div>

Directory changes made in a subshell do not carry over to the parent
shell.

.. raw:: html

   <div class="EXAMPLE">

**Example 21-2. List User Profiles**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # allprofs.sh: Print |
|  all user profiles.      |
|                          |
|     # This script writte |
| n by Heiner Steven, and  |
| modified by the document |
|  author.                 |
|                          |
|     FILE=.bashrc  #  Fil |
| e containing user profil |
| e,                       |
|                   #+ was |
|  ".profile" in original  |
| script.                  |
|                          |
|     for home in `awk -F: |
|  '{print $6}' /etc/passw |
| d`                       |
|     do                   |
|       [ -d "$home" ] ||  |
| continue    # If no home |
|  directory, go to next.  |
|       [ -r "$home" ] ||  |
| continue    # If not rea |
| dable, go to next.       |
|       (cd $home; [ -e $F |
| ILE ] && less $FILE)     |
|     done                 |
|                          |
|     #  When script termi |
| nates, there is no need  |
| to 'cd' back to original |
|  directory,              |
|     #+ because 'cd $home |
| ' takes place in a subsh |
| ell.                     |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

A subshell may be used to set up a "dedicated environment" for a command
group.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     COMMAND1             |
|     COMMAND2             |
|     COMMAND3             |
|     (                    |
|       IFS=:              |
|       PATH=/bin          |
|       unset TERMINFO     |
|       set -C             |
|       shift 5            |
|       COMMAND4           |
|       COMMAND5           |
|       exit 3 # Only exit |
| s the subshell!          |
|     )                    |
|     # The parent shell h |
| as not been affected, an |
| d the environment is pre |
| served.                  |
|     COMMAND6             |
|     COMMAND7             |
                          
+--------------------------+--------------------------+--------------------------+

As seen here, the `exit <internal.html#EXITREF>`__ command only
terminates the subshell in which it is running, *not* the parent shell
or script.

.. raw:: html

   </p>

One application of such a "dedicated environment" is testing whether a
variable is defined.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     if (set -u; : $varia |
| ble) 2> /dev/null        |
|     then                 |
|       echo "Variable is  |
| set."                    |
|     fi     #  Variable h |
| as been set in current s |
| cript,                   |
|            #+ or is an a |
| n internal Bash variable |
| ,                        |
|            #+ or is pres |
| ent in environment (has  |
| been exported).          |
|                          |
|     # Could also be writ |
| ten [[ ${variable-x} !=  |
| x || ${variable-y} != y  |
| ]]                       |
|     # or                 |
|     [[ ${variable-x} !=  |
| x$variable ]]            |
|     # or                 |
|     [[ ${variable+x} = x |
|  ]]                      |
|     # or                 |
|     [[ ${variable-x} !=  |
| x ]]                     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

Another application is checking for a lock file:

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     if (set -C; : > lock |
| _file) 2> /dev/null      |
|     then                 |
|       :   # lock_file di |
| dn't exist: no user runn |
| ing the script           |
|     else                 |
|       echo "Another user |
|  is already running that |
|  script."                |
|     exit 65              |
|     fi                   |
|                          |
|     #  Code snippet by S |
| téphane Chazelas,        |
|     #+ with modification |
| s by Paulo Marcel Coelho |
|  Aragao.                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

+

Processes may execute in parallel within different subshells. This
permits breaking a complex task into subcomponents processed
concurrently.

.. raw:: html

   <div class="EXAMPLE">

**Example 21-3. Running parallel processes in subshells**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|        (cat list1 list2  |
| list3 | sort | uniq > li |
| st123) &                 |
|         (cat list4 list5 |
|  list6 | sort | uniq > l |
| ist456) &                |
|         # Merges and sor |
| ts both sets of lists si |
| multaneously.            |
|         # Running in bac |
| kground ensures parallel |
|  execution.              |
|         #                |
|         # Same effect as |
|         #   cat list1 li |
| st2 list3 | sort | uniq  |
| > list123 &              |
|         #   cat list4 li |
| st5 list6 | sort | uniq  |
| > list456 &              |
|                          |
|         wait   # Don't e |
| xecute the next command  |
| until subshells finish.  |
|                          |
|         diff list123 lis |
| t456                     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Redirecting I/O to a subshell uses the "\|" pipe operator, as in
``ls -al | (command)``.

.. raw:: html

   <div class="NOTE">

+--------------+--------------+--------------+--------------+--------------+--------------+
| |Note|       |
| A code block |
| between      |
| `curly       |
| brackets <sp |
| ecial-chars. |
| html#CODEBLO |
| CKREF>`__    |
| does *not*   |
| launch a     |
| subshell.    |
|              |
| { command1;  |
| command2;    |
| command3; .  |
| . .          |
| commandN; }  |
|              |
| +----------- |
| ------------ |
| ---+-------- |
| ------------ |
| ------+----- |
| ------------ |
| ---------+   |
| | .. code::  |
| PROGRAMLISTI |
| NG |         |
| |            |
|              |
|    |         |
| |     var1=2 |
| 3            |
|    |         |
| |     echo " |
| $var1"   # 2 |
| 3  |         |
| |            |
|              |
|    |         |
| |     { var1 |
| =76; }       |
|    |         |
| |     echo " |
| $var1"   # 7 |
| 6  |         |
|              |
|              |
|              |
| +----------- |
| ------------ |
| ---+-------- |
| ------------ |
| ------+----- |
| ------------ |
| ---------+   |
|              |
| .. raw:: htm |
| l            |
|              |
|    </p>      |
              
+--------------+--------------+--------------+--------------+--------------+--------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <subshells.html#AEN18102>`__    |
| An external command invoked with an  |
| `exec <internal.html#EXECREF>`__     |
| does *not* (usually) fork off a      |
| subprocess / subshell.               |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <redirapps.html>`_ | Applications             |
| _                        | `Up <part5.html>`__      |
| `Home <index.html>`__    | Restricted Shells        |
| `Next <restricted-sh.htm |                          |
| l>`__                    |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
