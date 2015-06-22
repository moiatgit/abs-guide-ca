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

`Prev <restricted-sh.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <functions.html>`__

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

  Chapter 23. Process Substitution
=================================

 `Piping <special-chars.html#PIPEREF>`__ the ``      stdout     `` of a
command into the ``      stdin     `` of another is a powerful
technique. But, what if you need to pipe the ``      stdout     `` of
*multiple* commands? This is where
``             process     substitution           `` comes in.

*Process substitution* feeds the output of a
`process <special-chars.html#PROCESSREF>`__ (or processes) into the
``      stdin     `` of another process.

.. raw:: html

   <div class="VARIABLELIST">

** Template**

 Command list enclosed within parentheses
    **>(command\_list)**

    **<(command\_list)**

    Process substitution uses ``         /dev/fd/<n>        `` files to
    send the results of the process(es) within parentheses to another
    process. ` [1]  <process-sub.html#FTN.AEN18244>`__

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | There is *no* space between the the  |
    | "<" or ">" and the parentheses.      |
    | Space there would give an error      |
    | message.                             |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ echo >(true)   |
|     /dev/fd/63           |
|                          |
|     bash$ echo <(true)   |
|     /dev/fd/63           |
|                          |
|     bash$ echo >(true) < |
| (true)                   |
|     /dev/fd/63 /dev/fd/6 |
| 2                        |
|                          |
|                          |
|                          |
|     bash$ wc <(cat /usr/ |
| share/dict/linux.words)  |
|      483523  483523 4992 |
| 010 /dev/fd/63           |
|                          |
|     bash$ grep script /u |
| sr/share/dict/linux.word |
| s | wc                   |
|         262     262    3 |
| 601                      |
|                          |
|     bash$ wc <(grep scri |
| pt /usr/share/dict/linux |
| .words)                  |
|         262     262    3 |
| 601 /dev/fd/63           |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| Bash creates a pipe with two `file   |
| descriptors <io-redirection.html#FDR |
| EF>`__                               |
| , ``          --fIn         `` and   |
| ``          fOut--         `` . The  |
| ``          stdin         `` of      |
| `true <internal.html#TRUEREF>`__     |
| connects to                          |
| ``          fOut         ``          |
| (dup2(fOut, 0)), then Bash passes a  |
| ``          /dev/fd/fIn         ``   |
| argument to **echo** . On systems    |
| lacking                              |
| ``          /dev/fd/<n>         ``   |
| files, Bash may use temporary files. |
| (Thanks, S.C.)                       |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

Process substitution can compare the output of two different commands,
or even the output of different options to the same command.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ comm <(ls -l)  |
| <(ls -al)                |
|     total 12             |
|     -rw-rw-r--    1 bozo |
|  bozo       78 Mar 10 12 |
| :58 File0                |
|     -rw-rw-r--    1 bozo |
|  bozo       42 Mar 10 12 |
| :58 File2                |
|     -rw-rw-r--    1 bozo |
|  bozo      103 Mar 10 12 |
| :58 t2.sh                |
|             total 20     |
|             drwxrwxrwx   |
|   2 bozo bozo     4096 M |
| ar 10 18:10 .            |
|             drwx------   |
|  72 bozo bozo     4096 M |
| ar 10 17:58 ..           |
|             -rw-rw-r--   |
|   1 bozo bozo       78 M |
| ar 10 12:58 File0        |
|             -rw-rw-r--   |
|   1 bozo bozo       42 M |
| ar 10 12:58 File2        |
|             -rw-rw-r--   |
|   1 bozo bozo      103 M |
| ar 10 12:58 t2.sh        |
                          
+--------------------------+--------------------------+--------------------------+

Process substitution can compare the contents of two directories -- to
see which filenames are in one, but not the other.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     diff <(ls $first_dir |
| ectory) <(ls $second_dir |
| ectory)                  |
                          
+--------------------------+--------------------------+--------------------------+

Some other usages and uses of process substitution:

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     read -a list < <( od |
|  -Ad -w24 -t u2 /dev/ura |
| ndom )                   |
|     #  Read a list of ra |
| ndom numbers from /dev/u |
| random,                  |
|     #+ process with "od" |
|     #+ and feed into std |
| in of "read" . . .       |
|                          |
|     #  From "insertion-s |
| ort.bash" example script |
| .                        |
|     #  Courtesy of JuanJ |
| o Ciarlante.             |
                          
+--------------------------+--------------------------+--------------------------+

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     PORT=6881   # bittor |
| rent                     |
|                          |
|     # Scan the port to m |
| ake sure nothing nefario |
| us is going on.          |
|     netcat -l $PORT | te |
| e>(md5sum ->mydata-orig. |
| md5) |                   |
|     gzip | tee>(md5sum - |
|  | sed 's/-$/mydata.lz2/ |
| '>mydata-gz.md5)>mydata. |
| gz                       |
|                          |
|     # Check the decompre |
| ssion:                   |
|       gzip -d<mydata.gz  |
| | md5sum -c mydata-orig. |
| md5)                     |
|     # The MD5sum of the  |
| original checks stdin an |
| d detects compression is |
| sues.                    |
|                          |
|     #  Bill Davidsen con |
| tributed this example    |
|     #+ (with light edits |
|  by the ABS Guide author |
| ).                       |
                          
+--------------------------+--------------------------+--------------------------+

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     cat <(ls -l)         |
|     # Same as     ls -l  |
| | cat                    |
|                          |
|     sort -k 9 <(ls -l /b |
| in) <(ls -l /usr/bin) <( |
| ls -l /usr/X11R6/bin)    |
|     # Lists all the file |
| s in the 3 main 'bin' di |
| rectories, and sorts by  |
| filename.                |
|     # Note that three (c |
| ount 'em) distinct comma |
| nds are fed to 'sort'.   |
|                          |
|                          |
|     diff <(command1) <(c |
| ommand2)    # Gives diff |
| erence in command output |
| .                        |
|                          |
|     tar cf >(bzip2 -c >  |
| file.tar.bz2) $directory |
| _name                    |
|     # Calls "tar cf /dev |
| /fd/?? $directory_name", |
|  and "bzip2 -c > file.ta |
| r.bz2".                  |
|     #                    |
|     # Because of the /de |
| v/fd/<n> system feature, |
|     # the pipe between b |
| oth commands does not ne |
| ed to be named.          |
|     #                    |
|     # This can be emulat |
| ed.                      |
|     #                    |
|     bzip2 -c < pipe > fi |
| le.tar.bz2&              |
|     tar cf pipe $directo |
| ry_name                  |
|     rm pipe              |
|     #        or          |
|     exec 3>&1            |
|     tar cf /dev/fd/4 $di |
| rectory_name 4>&1 >&3 3> |
| &- | bzip2 -c > file.tar |
| .bz2 3>&-                |
|     exec 3>&-            |
|                          |
|                          |
|     # Thanks, Stéphane C |
| hazelas                  |
                          
+--------------------------+--------------------------+--------------------------+

 Here is a method of circumventing the problem of an `*echo* piped to a
*while-read loop* <gotchas.html#BADREAD0>`__ running in a subshell.

.. raw:: html

   <div class="EXAMPLE">

**Example 23-1. Code block redirection without forking**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # wr-ps.bash: while- |
| read loop with process s |
| ubstitution.             |
|                          |
|     # This example contr |
| ibuted by Tomas Pospisek |
| .                        |
|     # (Heavily edited by |
|  the ABS Guide author.)  |
|                          |
|     echo                 |
|                          |
|     echo "random input"  |
| | while read i           |
|     do                   |
|       global=3D": Not av |
| ailable outside the loop |
| ."                       |
|       # ... because it r |
| uns in a subshell.       |
|     done                 |
|                          |
|     echo "\$global (from |
|  outside the subprocess) |
|  = $global"              |
|     # $global (from outs |
| ide the subprocess) =    |
|                          |
|     echo; echo "--"; ech |
| o                        |
|                          |
|     while read i         |
|     do                   |
|       echo $i            |
|       global=3D": Availa |
| ble outside the loop."   |
|       # ... because it d |
| oes NOT run in a subshel |
| l.                       |
|     done < <( echo "rand |
| om input" )              |
|     #    ^ ^             |
|                          |
|     echo "\$global (usin |
| g process substitution)  |
| = $global"               |
|     # Random input       |
|     # $global (using pro |
| cess substitution) = 3D: |
|  Available outside the l |
| oop.                     |
|                          |
|                          |
|     echo; echo "######## |
| ##"; echo                |
|                          |
|                          |
|                          |
|     # And likewise . . . |
|                          |
|     declare -a inloop    |
|     index=0              |
|     cat $0 | while read  |
| line                     |
|     do                   |
|       inloop[$index]="$l |
| ine"                     |
|       ((index++))        |
|       # It runs in a sub |
| shell, so ...            |
|     done                 |
|     echo "OUTPUT = "     |
|     echo ${inloop[*]}    |
|         # ... nothing ec |
| hoes.                    |
|                          |
|                          |
|     echo; echo "--"; ech |
| o                        |
|                          |
|                          |
|     declare -a outloop   |
|     index=0              |
|     while read line      |
|     do                   |
|       outloop[$index]="$ |
| line"                    |
|       ((index++))        |
|       # It does NOT run  |
| in a subshell, so ...    |
|     done < <( cat $0 )   |
|     echo "OUTPUT = "     |
|     echo ${outloop[*]}   |
|         # ... the entire |
|  script echoes.          |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

 This is a similar example.

.. raw:: html

   <div class="EXAMPLE">

**Example 23-2. Redirecting the output of *process substitution* into a
loop.**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # psub.bash          |
|                          |
|     # As inspired by Die |
| go Molina (thanks!).     |
|                          |
|     declare -a array0    |
|     while read           |
|     do                   |
|       array0[${#array0[@ |
| ]}]="$REPLY"             |
|     done < <( sed -e 's/ |
| bash/CRASH-BANG!/' $0 |  |
| grep bin | awk '{print $ |
| 1}' )                    |
|     #  Sets the default  |
| 'read' variable, $REPLY, |
|  by process substitution |
| ,                        |
|     #+ then copies it in |
| to an array.             |
|                          |
|     echo "${array0[@]}"  |
|                          |
|     exit $?              |
|                          |
|     # ================== |
| ==================== #   |
|                          |
|     bash psub.bash       |
|                          |
|     #!/bin/CRASH-BANG! d |
| one #!/bin/CRASH-BANG!   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

A reader sent in the following interesting example of process
substitution.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # Script fragment ta |
| ken from SuSE distributi |
| on:                      |
|                          |
|     # ------------------ |
| ------------------------ |
| --------------------#    |
|     while read  des what |
|  mask iface; do          |
|     # Some commands ...  |
|     done < <(route -n)   |
|     #    ^ ^  First < is |
|  redirection, second is  |
| process substitution.    |
|                          |
|     # To test it, let's  |
| make it do something.    |
|     while read  des what |
|  mask iface; do          |
|       echo $des $what $m |
| ask $iface               |
|     done < <(route -n)   |
|                          |
|     # Output:            |
|     # Kernel IP routing  |
| table                    |
|     # Destination Gatewa |
| y Genmask Flags Metric R |
| ef Use Iface             |
|     # 127.0.0.0 0.0.0.0  |
| 255.0.0.0 U 0 0 0 lo     |
|     # ------------------ |
| ------------------------ |
| --------------------#    |
|                          |
|     #  As Stéphane Chaze |
| las points out,          |
|     #+ an easier-to-unde |
| rstand equivalent is:    |
|     route -n |           |
|       while read des wha |
| t mask iface; do   # Var |
| iables set from output o |
| f pipe.                  |
|         echo $des $what  |
| $mask $iface             |
|       done  #  This yiel |
| ds the same output as ab |
| ove.                     |
|             #  However,  |
| as Ulrich Gayer points o |
| ut . . .                 |
|             #+ this simp |
| lified equivalent uses a |
|  subshell for the while  |
| loop,                    |
|             #+ and there |
| fore the variables disap |
| pear when the pipe termi |
| nates.                   |
|                          |
|     # ------------------ |
| ------------------------ |
| --------------------#    |
|                          |
|     #  However, Filip Mo |
| ritz comments that there |
|  is a subtle difference  |
|     #+ between the above |
|  two examples, as the fo |
| llowing shows.           |
|                          |
|     (                    |
|     route -n | while rea |
| d x; do ((y++)); done    |
|     echo $y # $y is stil |
| l unset                  |
|                          |
|     while read x; do ((y |
| ++)); done < <(route -n) |
|     echo $y # $y has the |
|  number of lines of outp |
| ut of route -n           |
|     )                    |
|                          |
|     More generally spoke |
| n                        |
|     (                    |
|     : | x=x              |
|     # seems to start a s |
| ubshell like             |
|     : | ( x=x )          |
|     # while              |
|     x=x < <(:)           |
|     # does not           |
|     )                    |
|                          |
|     # This is useful, wh |
| en parsing csv and the l |
| ike.                     |
|     # That is, in effect |
| , what the original SuSE |
|  code fragment does.     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]                                |
|  <process-sub.html#AEN18244>`__      |
| This has the same effect as a `named |
| pipe <extmisc.html#NAMEDPIPEREF>`__  |
| (temp file), and, in fact, named     |
| pipes were at one time used in       |
| process substitution.                |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <restricted-sh.htm | Restricted Shells        |
| l>`__                    | `Up <part5.html>`__      |
| `Home <index.html>`__    | Functions                |
| `Next <functions.html>`_ |                          |
| _                        |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Note| image:: ../images/note.gif
