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

`Prev <localvar.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 24. Functions

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <aliases.html>`__

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

24.3. Recursion Without Local Variables
=======================================

A function may recursively call itself even without use of local
variables.

.. raw:: html

   <div class="EXAMPLE">

**Example 24-16. *The Fibonacci Sequence***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # fibo.sh : Fibonacc |
| i sequence (recursive)   |
|     # Author: M. Cooper  |
|     # License: GPL3      |
|                          |
|     # ----------algorith |
| m--------------          |
|     # Fibo(0) = 0        |
|     # Fibo(1) = 1        |
|     # else               |
|     #   Fibo(j) = Fibo(j |
| -1) + Fibo(j-2)          |
|     # ------------------ |
| ---------------          |
|                          |
|     MAXTERM=15       # N |
| umber of terms (+1) to g |
| enerate.                 |
|     MINIDX=2         # I |
| f idx is less than 2, th |
| en Fibo(idx) = idx.      |
|                          |
|     Fibonacci ()         |
|     {                    |
|       idx=$1   # Doesn't |
|  need to be local. Why n |
| ot?                      |
|       if [ "$idx" -lt "$ |
| MINIDX" ]                |
|       then               |
|         echo "$idx"  # F |
| irst two terms are 0 1 . |
| .. see above.            |
|       else               |
|         (( --idx ))  # j |
| -1                       |
|         term1=$( Fibonac |
| ci $idx )   #  Fibo(j-1) |
|                          |
|         (( --idx ))  # j |
| -2                       |
|         term2=$( Fibonac |
| ci $idx )   #  Fibo(j-2) |
|                          |
|         echo $(( term1 + |
|  term2 ))                |
|       fi                 |
|       #  An ugly, ugly k |
| ludge.                   |
|       #  The more elegan |
| t implementation of recu |
| rsive fibo in C          |
|       #+ is a straightfo |
| rward translation of the |
|  algorithm in lines 7 -  |
| 10.                      |
|     }                    |
|                          |
|     for i in $(seq 0 $MA |
| XTERM)                   |
|     do  # Calculate $MAX |
| TERM+1 terms.            |
|       FIBO=$(Fibonacci $ |
| i)                       |
|       echo -n "$FIBO "   |
|     done                 |
|     # 0 1 1 2 3 5 8 13 2 |
| 1 34 55 89 144 233 377 6 |
| 10                       |
|     # Takes a while, doe |
| sn't it? Recursion in a  |
| script is slow.          |
|                          |
|     echo                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 24-17. *The Towers of Hanoi***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     #                    |
|     # The Towers Of Hano |
| i                        |
|     # Bash script        |
|     # Copyright (C) 2000 |
|  Amit Singh. All Rights  |
| Reserved.                |
|     # http://hanoi.kerne |
| lthread.com              |
|     #                    |
|     # Tested under Bash  |
| version 2.05b.0(13)-rele |
| ase.                     |
|     # Also works under B |
| ash version 3.x.         |
|     #                    |
|     #  Used in "Advanced |
|  Bash Scripting Guide"   |
|     #+ with permission o |
| f script author.         |
|     #  Slightly modified |
|  and commented by ABS au |
| thor.                    |
|                          |
|     #=================== |
| ======================== |
| ======================#  |
|     #  The Tower of Hano |
| i is a mathematical puzz |
| le attributed to         |
|     #+ Edouard Lucas, a  |
| nineteenth-century Frenc |
| h mathematician.         |
|     #                    |
|     #  There are three v |
| ertical posts set in a b |
| ase.                     |
|     #  The first post ha |
| s a set of annular rings |
|  stacked on it.          |
|     #  These rings are d |
| isks with a hole drilled |
|  out of the center,      |
|     #+ so they can slip  |
| over the posts and rest  |
| flat.                    |
|     #  The rings have di |
| fferent diameters, and t |
| hey stack in ascending   |
|     #+ order, according  |
| to size.                 |
|     #  The smallest ring |
|  is on top, and the larg |
| est on the bottom.       |
|     #                    |
|     #  The task is to tr |
| ansfer the stack of ring |
| s                        |
|     #+ to one of the oth |
| er posts.                |
|     #  You can move only |
|  one ring at a time to a |
| nother post.             |
|     #  You are permitted |
|  to move rings back to t |
| he original post.        |
|     #  You may place a s |
| maller ring atop a large |
| r one,                   |
|     #+ but *not* vice ve |
| rsa.                     |
|     #  Again, it is forb |
| idden to place a larger  |
| ring atop a smaller one. |
|     #                    |
|     #  For a small numbe |
| r of rings, only a few m |
| oves are required.       |
|     #+ For each addition |
| al ring,                 |
|     #+ the required numb |
| er of moves approximatel |
| y doubles,               |
|     #+ and the "strategy |
| " becomes increasingly c |
| omplicated.              |
|     #                    |
|     #  For more informat |
| ion, see http://hanoi.ke |
| rnelthread.com           |
|     #+ or pp. 186-92 of  |
| _The Armchair Universe_  |
| by A.K. Dewdney.         |
|     #                    |
|     #                    |
|     #         ...        |
|             ...          |
|            ...           |
|     #         | |        |
|             | |          |
|            | |           |
|     #        _|_|_       |
|             | |          |
|            | |           |
|     #       |_____|      |
|             | |          |
|            | |           |
|     #      |_______|     |
|             | |          |
|            | |           |
|     #     |_________|    |
|             | |          |
|            | |           |
|     #    |___________|   |
|             | |          |
|            | |           |
|     #   |             |  |
|             | |          |
|            | |           |
|     # .----------------- |
| ------------------------ |
| ---------------------.   |
|     # |***************** |
| ************************ |
| *********************|   |
|     #          #1        |
|             #2           |
|             #3           |
|     #                    |
|     #=================== |
| ======================== |
| ======================#  |
|                          |
|                          |
|     E_NOPARAM=66  # No p |
| arameter passed to scrip |
| t.                       |
|     E_BADPARAM=67 # Ille |
| gal number of disks pass |
| ed to script.            |
|     Moves=        # Glob |
| al variable holding numb |
| er of moves.             |
|                   # Modi |
| fication to original scr |
| ipt.                     |
|                          |
|     dohanoi() {   # Recu |
| rsive function.          |
|         case $1 in       |
|         0)               |
|             ;;           |
|         *)               |
|             dohanoi "$(( |
| $1-1))" $2 $4 $3         |
|             echo move $2 |
|  "-->" $3                |
|             ((Moves++))  |
|          # Modification  |
| to original script.      |
|             dohanoi "$(( |
| $1-1))" $4 $3 $2         |
|             ;;           |
|         esac             |
|     }                    |
|                          |
|     case $# in           |
|         1) case $(($1>0) |
| ) in     # Must have at  |
| least one disk.          |
|            1)  # Nested  |
| case statement.          |
|                dohanoi $ |
| 1 1 3 2                  |
|                echo "Tot |
| al moves = $Moves"   # 2 |
| ^n - 1, where n = # of d |
| isks.                    |
|                exit 0;   |
|                ;;        |
|            *)            |
|                echo "$0: |
|  illegal value for numbe |
| r of disks";             |
|                exit $E_B |
| ADPARAM;                 |
|                ;;        |
|            esac          |
|         ;;               |
|         *)               |
|            echo "usage:  |
| $0 N"                    |
|            echo "        |
| Where \"N\" is the numbe |
| r of disks."             |
|            exit $E_NOPAR |
| AM;                      |
|            ;;            |
|     esac                 |
|                          |
|     # Exercises:         |
|     # ---------          |
|     # 1) Would commands  |
| beyond this point ever b |
| e executed?              |
|     #    Why not? (Easy) |
|     # 2) Explain the wor |
| kings of the workings of |
|  the "dohanoi" function. |
|     #    (Difficult -- s |
| ee the Dewdney reference |
| , above.)                |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <localvar.html>`__ | Local Variables          |
| `Home <index.html>`__    | `Up <functions.html>`__  |
| `Next <aliases.html>`__  | Aliases                  |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

