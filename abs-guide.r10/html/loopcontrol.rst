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

`Prev <nestedloops.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 11. Loops and Branches

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <testbranch.html>`__

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

11.3. Loop Control
==================

+--------------+--------------+--------------+--------------+--------------+--------------+
|              |
| **           |
| *Tournez     |
| cent tours,  |
| tournez      |
| mille        |
| tours,*      |
|              |
| *Tournez     |
| souvent et   |
| tournez      |
| toujours . . |
| .*           |
|              |
| *--Verlaine, |
| "Chevaux de  |
| bois"*       |
+--------------+--------------+--------------+--------------+--------------+--------------+

.. raw:: html

   <div class="VARIABLELIST">

**Commands affecting loop behavior**

**break**, **continue**
    The **break** and **continue** loop control commands
    `[1] <loopcontrol.html#FTN.AEN6981>`__ correspond exactly to their
    counterparts in other programming languages. The **break** command
    terminates the loop (*breaks* out of it), while **continue** causes
    a jump to the next `iteration <loops1.html#ITERATIONREF>`__ of the
    loop, skipping all the remaining commands in that particular loop
    cycle.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-21. Effects of *break* and **continue** in a loop**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     LIMIT=19  # Upper li |
    | mit                      |
    |                          |
    |     echo                 |
    |     echo "Printing Numbe |
    | rs 1 through 20 (but not |
    |  3 and 11)."             |
    |                          |
    |     a=0                  |
    |                          |
    |     while [ $a -le "$LIM |
    | IT" ]                    |
    |     do                   |
    |      a=$(($a+1))         |
    |                          |
    |      if [ "$a" -eq 3 ] | |
    | | [ "$a" -eq 11 ]  # Exc |
    | ludes 3 and 11.          |
    |      then                |
    |        continue      # S |
    | kip rest of this particu |
    | lar loop iteration.      |
    |      fi                  |
    |                          |
    |      echo -n "$a "   # T |
    | his will not execute for |
    |  3 and 11.               |
    |     done                 |
    |                          |
    |     # Exercise:          |
    |     # Why does the loop  |
    | print up to 20?          |
    |                          |
    |     echo; echo           |
    |                          |
    |     echo Printing Number |
    | s 1 through 20, but some |
    | thing happens after 2.   |
    |                          |
    |     #################### |
    | ######################## |
    | ######################   |
    |                          |
    |     # Same loop, but sub |
    | stituting 'break' for 'c |
    | ontinue'.                |
    |                          |
    |     a=0                  |
    |                          |
    |     while [ "$a" -le "$L |
    | IMIT" ]                  |
    |     do                   |
    |      a=$(($a+1))         |
    |                          |
    |      if [ "$a" -gt 2 ]   |
    |      then                |
    |        break  # Skip ent |
    | ire rest of loop.        |
    |      fi                  |
    |                          |
    |      echo -n "$a "       |
    |     done                 |
    |                          |
    |     echo; echo; echo     |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The **break** command may optionally take a parameter. A plain
    **break** terminates only the innermost loop in which it is
    embedded, but a **break N** breaks out of ``N`` levels of loop.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-22. Breaking out of multiple loop levels**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # break-levels.sh: B |
    | reaking out of loops.    |
    |                          |
    |     # "break N" breaks o |
    | ut of N level loops.     |
    |                          |
    |     for outerloop in 1 2 |
    |  3 4 5                   |
    |     do                   |
    |       echo -n "Group $ou |
    | terloop:   "             |
    |                          |
    |       # ---------------- |
    | ------------------------ |
    | ----------------         |
    |       for innerloop in 1 |
    |  2 3 4 5                 |
    |       do                 |
    |         echo -n "$innerl |
    | oop "                    |
    |                          |
    |         if [ "$innerloop |
    | " -eq 3 ]                |
    |         then             |
    |           break  # Try   |
    |  break 2   to see what h |
    | appens.                  |
    |                  # ("Bre |
    | aks" out of both inner a |
    | nd outer loops.)         |
    |         fi               |
    |       done               |
    |       # ---------------- |
    | ------------------------ |
    | ----------------         |
    |                          |
    |       echo               |
    |     done                 |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The **continue** command, similar to **break**, optionally takes a
    parameter. A plain **continue** cuts short the current iteration
    within its loop and begins the next. A **continue N** terminates all
    remaining iterations at its loop level and continues with the next
    iteration at the loop, ``N`` levels above.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-23. Continuing at a higher loop level**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # The "continue N" c |
    | ommand, continuing at th |
    | e Nth level loop.        |
    |                          |
    |     for outer in I II II |
    | I IV V           # outer |
    |  loop                    |
    |     do                   |
    |       echo; echo -n "Gro |
    | up $outer: "             |
    |                          |
    |       # ---------------- |
    | ------------------------ |
    | ------------------------ |
    | ----                     |
    |       for inner in 1 2 3 |
    |  4 5 6 7 8 9 10  # inner |
    |  loop                    |
    |       do                 |
    |                          |
    |         if [[ "$inner" - |
    | eq 7 && "$outer" = "III" |
    |  ]]                      |
    |         then             |
    |           continue 2  #  |
    | Continue at loop on 2nd  |
    | level, that is "outer lo |
    | op".                     |
    |                       #  |
    | Replace above line with  |
    | a simple "continue"      |
    |                       #  |
    | to see normal loop behav |
    | ior.                     |
    |         fi               |
    |                          |
    |         echo -n "$inner  |
    | "  # 7 8 9 10 will not e |
    | cho on "Group III."      |
    |       done               |
    |       # ---------------- |
    | ------------------------ |
    | ------------------------ |
    | ----                     |
    |                          |
    |     done                 |
    |                          |
    |     echo; echo           |
    |                          |
    |     # Exercise:          |
    |     # Come up with a mea |
    | ningful use for "continu |
    | e N" in a script.        |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-24. Using *continue N* in an actual task**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Albert Reiner give |
    | s an example of how to u |
    | se "continue N":         |
    |     # ------------------ |
    | ------------------------ |
    | ---------------          |
    |                          |
    |     #  Suppose I have a  |
    | large number of jobs tha |
    | t need to be run, with   |
    |     #+ any data that is  |
    | to be treated in files o |
    | f a given name pattern   |
    |     #+ in a directory. T |
    | here are several machine |
    | s that access            |
    |     #+ this directory, a |
    | nd I want to distribute  |
    | the work over these      |
    |     #+ different boxen.  |
    |     #  Then I usually no |
    | hup something like the f |
    | ollowing on every box:   |
    |                          |
    |     while true           |
    |     do                   |
    |       for n in .iso.*    |
    |       do                 |
    |         [ "$n" = ".iso.o |
    | pts" ] && continue       |
    |         beta=${n#.iso.}  |
    |         [ -r .Iso.$beta  |
    | ] && continue            |
    |         [ -r .lock.$beta |
    |  ] && sleep 10 && contin |
    | ue                       |
    |         lockfile -r0 .lo |
    | ck.$beta || continue     |
    |         echo -n "$beta:  |
    | " `date`                 |
    |         run-isotherm $be |
    | ta                       |
    |         date             |
    |         ls -alF .Iso.$be |
    | ta                       |
    |         [ -r .Iso.$beta  |
    | ] && rm -f .lock.$beta   |
    |         continue 2       |
    |       done               |
    |       break              |
    |     done                 |
    |                          |
    |     exit 0               |
    |                          |
    |     #  The details, in p |
    | articular the sleep N, a |
    | re particular to my      |
    |     #+ application, but  |
    | the general pattern is:  |
    |                          |
    |     while true           |
    |     do                   |
    |       for job in {patter |
    | n}                       |
    |       do                 |
    |         {job already don |
    | e or running} && continu |
    | e                        |
    |         {mark job as run |
    | ning, do job, mark job a |
    | s done}                  |
    |         continue 2       |
    |       done               |
    |       break        # Or  |
    | something like `sleep 60 |
    | 0' to avoid termination. |
    |     done                 |
    |                          |
    |     #  This way the scri |
    | pt will stop only when t |
    | here are no more jobs to |
    |  do                      |
    |     #+ (including jobs t |
    | hat were added during ru |
    | ntime). Through the use  |
    |     #+ of appropriate lo |
    | ckfiles it can be run on |
    |  several machines        |
    |     #+ concurrently with |
    | out duplication of calcu |
    | lations [which run a cou |
    | ple                      |
    |     #+ of hours in my ca |
    | se, so I really want to  |
    | avoid this]. Also, as se |
    | arch                     |
    |     #+ always starts aga |
    | in from the beginning, o |
    | ne can encode priorities |
    |  in                      |
    |     #+ the file names. O |
    | f course, one could also |
    |  do this without `contin |
    | ue 2',                   |
    |     #+ but then one woul |
    | d have to actually check |
    |  whether or not some job |
    |     #+ was done (so that |
    |  we should immediately l |
    | ook for the next job) or |
    |  not                     |
    |     #+ (in which case we |
    |  terminate or sleep for  |
    | a long time before check |
    | ing                      |
    |     #+ for a new job).   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | The **continue N** construct is      |
    | difficult to understand and tricky   |
    | to use in any meaningful context. It |
    | is probably best avoided.            |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <loopcontrol.html#AEN6981>`__   |
| These are shell                      |
| `builtins <internal.html#BUILTINREF> |
| `__,                                 |
| whereas other loop commands, such as |
| `while <loops1.html#WHILELOOPREF>`__ |
| and                                  |
| `case <testbranch.html#CASEESAC1>`__ |
| ,                                    |
| are                                  |
| `keywords <internal.html#KEYWORDREF> |
| `__.                                 |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <nestedloops.html> | Nested Loops             |
| `__                      | `Up <loops.html>`__      |
| `Home <index.html>`__    | Testing and Branching    |
| `Next <testbranch.html>` |                          |
| __                       |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
