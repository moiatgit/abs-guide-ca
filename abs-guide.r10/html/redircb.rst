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

`Prev <x17974.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 20. I/O Redirection

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <redirapps.html>`__

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

20.2. Redirecting Code Blocks
=============================

Blocks of code, such as `while <loops1.html#WHILELOOPREF>`__,
`until <loops1.html#UNTILLOOPREF>`__, and
`for <loops1.html#FORLOOPREF1>`__ loops, even
`if/then <tests.html#IFTHEN>`__ test blocks can also incorporate
redirection of ``stdin``. Even a function may use this form of
redirection (see `Example 24-11 <complexfunct.html#REALNAME>`__). The <
operator at the end of the code block accomplishes this.

.. raw:: html

   <div class="EXAMPLE">

**Example 20-5. Redirected *while* loop**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # redir2.sh          |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       Filename=names.dat |
| a       # Default, if no |
|  filename specified.     |
|     else                 |
|       Filename=$1        |
|     fi                   |
|     #+ Filename=${1:-nam |
| es.data}                 |
|     #  can replace the a |
| bove test (parameter sub |
| stitution).              |
|                          |
|     count=0              |
|                          |
|     echo                 |
|                          |
|     while [ "$name" != S |
| mith ]  # Why is variabl |
| e $name in quotes?       |
|     do                   |
|       read name          |
|         # Reads from $Fi |
| lename, rather than stdi |
| n.                       |
|       echo $name         |
|       let "count += 1"   |
|     done <"$Filename"    |
|         # Redirects stdi |
| n to file $Filename.     |
|     #    ^^^^^^^^^^^^    |
|                          |
|     echo; echo "$count n |
| ames read"; echo         |
|                          |
|     exit 0               |
|                          |
|     #  Note that in some |
|  older shell scripting l |
| anguages,                |
|     #+ the redirected lo |
| op would run as a subshe |
| ll.                      |
|     #  Therefore, $count |
|  would return 0, the ini |
| tialized value outside t |
| he loop.                 |
|     #  Bash and ksh avoi |
| d starting a subshell *w |
| henever possible*,       |
|     #+ so that this scri |
| pt, for example, runs co |
| rrectly.                 |
|     #  (Thanks to Heiner |
|  Steven for pointing thi |
| s out.)                  |
|                          |
|     #  However . . .     |
|     #  Bash *can* someti |
| mes start a subshell in  |
| a PIPED "while-read" loo |
| p,                       |
|     #+ as distinct from  |
| a REDIRECTED "while" loo |
| p.                       |
|                          |
|     abc=hi               |
|     echo -e "1\n2\n3" |  |
| while read l             |
|          do abc="$l"     |
|             echo $abc    |
|          done            |
|     echo $abc            |
|                          |
|     #  Thanks, Bruno de  |
| Oliveira Schneider, for  |
| demonstrating this       |
|     #+ with the above sn |
| ippet of code.           |
|     #  And, thanks, Bria |
| n Onn, for correcting an |
|  annotation error.       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 20-6. Alternate form of redirected *while* loop**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # This is an alterna |
| te form of the preceding |
|  script.                 |
|                          |
|     #  Suggested by Hein |
| er Steven                |
|     #+ as a workaround i |
| n those situations when  |
| a redirect loop          |
|     #+ runs as a subshel |
| l, and therefore variabl |
| es inside the loop       |
|     # +do not keep their |
|  values upon loop termin |
| ation.                   |
|                          |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       Filename=names.dat |
| a     # Default, if no f |
| ilename specified.       |
|     else                 |
|       Filename=$1        |
|     fi                   |
|                          |
|                          |
|     exec 3<&0            |
|       # Save stdin to fi |
| le descriptor 3.         |
|     exec 0<"$Filename"   |
|       # Redirect standar |
| d input.                 |
|                          |
|     count=0              |
|     echo                 |
|                          |
|                          |
|     while [ "$name" != S |
| mith ]                   |
|     do                   |
|       read name          |
|       # Reads from redir |
| ected stdin ($Filename). |
|       echo $name         |
|       let "count += 1"   |
|     done                 |
|       #  Loop reads from |
|  file $Filename          |
|                          |
|       #+ because of line |
|  20.                     |
|                          |
|     #  The original vers |
| ion of this script termi |
| nated the "while" loop w |
| ith                      |
|     #+      done <"$File |
| name"                    |
|     #  Exercise:         |
|     #  Why is this unnec |
| essary?                  |
|                          |
|                          |
|     exec 0<&3            |
|       # Restore old stdi |
| n.                       |
|     exec 3<&-            |
|       # Close temporary  |
| fd 3.                    |
|                          |
|     echo; echo "$count n |
| ames read"; echo         |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 20-7. Redirected *until* loop**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # Same as previous e |
| xample, but with "until" |
|  loop.                   |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       Filename=names.dat |
| a         # Default, if  |
| no filename specified.   |
|     else                 |
|       Filename=$1        |
|     fi                   |
|                          |
|     # while [ "$name" != |
|  Smith ]                 |
|     until [ "$name" = Sm |
| ith ]     # Change  !=   |
| to =.                    |
|     do                   |
|       read name          |
|           # Reads from $ |
| Filename, rather than st |
| din.                     |
|       echo $name         |
|     done <"$Filename"    |
|           # Redirects st |
| din to file $Filename.   |
|     #    ^^^^^^^^^^^^    |
|                          |
|     # Same results as wi |
| th "while" loop in previ |
| ous example.             |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 20-8. Redirected *for* loop**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       Filename=names.dat |
| a          # Default, if |
|  no filename specified.  |
|     else                 |
|       Filename=$1        |
|     fi                   |
|                          |
|     line_count=`wc $File |
| name | awk '{ print $1 } |
| '`                       |
|     #           Number o |
| f lines in target file.  |
|     #                    |
|     #  Very contrived an |
| d kludgy, nevertheless s |
| hows that                |
|     #+ it's possible to  |
| redirect stdin within a  |
| "for" loop...            |
|     #+ if you're clever  |
| enough.                  |
|     #                    |
|     # More concise is    |
|   line_count=$(wc -l < " |
| $Filename")              |
|                          |
|                          |
|     for name in `seq $li |
| ne_count`  # Recall that |
|  "seq" prints sequence o |
| f numbers.               |
|     # while [ "$name" != |
|  Smith ]   --   more com |
| plicated than a "while"  |
| loop   --                |
|     do                   |
|       read name          |
|            # Reads from  |
| $Filename, rather than s |
| tdin.                    |
|       echo $name         |
|       if [ "$name" = Smi |
| th ]       # Need all th |
| is extra baggage here.   |
|       then               |
|         break            |
|       fi                 |
|     done <"$Filename"    |
|            # Redirects s |
| tdin to file $Filename.  |
|     #    ^^^^^^^^^^^^    |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

We can modify the previous example to also redirect the output of the
loop.

.. raw:: html

   <div class="EXAMPLE">

**Example 20-9. Redirected *for* loop (both ``stdin`` and ``stdout``
redirected)**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       Filename=names.dat |
| a          # Default, if |
|  no filename specified.  |
|     else                 |
|       Filename=$1        |
|     fi                   |
|                          |
|     Savefile=$Filename.n |
| ew         # Filename to |
|  save results in.        |
|     FinalName=Jonah      |
|            # Name to ter |
| minate "read" on.        |
|                          |
|     line_count=`wc $File |
| name | awk '{ print $1 } |
| '`  # Number of lines in |
|  target file.            |
|                          |
|                          |
|     for name in `seq $li |
| ne_count`                |
|     do                   |
|       read name          |
|       echo "$name"       |
|       if [ "$name" = "$F |
| inalName" ]              |
|       then               |
|         break            |
|       fi                 |
|     done < "$Filename" > |
|  "$Savefile"     # Redir |
| ects stdin to file $File |
| name,                    |
|     #    ^^^^^^^^^^^^^^^ |
| ^^^^^^^^^^^^       and s |
| aves it to backup file.  |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 20-10. Redirected *if/then* test**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       Filename=names.dat |
| a   # Default, if no fil |
| ename specified.         |
|     else                 |
|       Filename=$1        |
|     fi                   |
|                          |
|     TRUE=1               |
|                          |
|     if [ "$TRUE" ]       |
|     # if true    and   i |
| f :   also work.         |
|     then                 |
|      read name           |
|      echo $name          |
|     fi <"$Filename"      |
|     #  ^^^^^^^^^^^^      |
|                          |
|     # Reads only first l |
| ine of file.             |
|     # An "if/then" test  |
| has no way of iterating  |
| unless embedded in a loo |
| p.                       |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 20-11. Data file *names.data* for above examples**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     Aristotle            |
|     Arrhenius            |
|     Belisarius           |
|     Capablanca           |
|     Dickens              |
|     Euler                |
|     Goethe               |
|     Hegel                |
|     Jonah                |
|     Laplace              |
|     Maroczy              |
|     Purcell              |
|     Schmidt              |
|     Schopenhauer         |
|     Semmelweiss          |
|     Smith                |
|     Steinmetz            |
|     Tukhashevsky         |
|     Turing               |
|     Venn                 |
|     Warshawski           |
|     Znosko-Borowski      |
|                          |
|     #  This is a data fi |
| le for                   |
|     #+ "redir2.sh", "red |
| ir3.sh", "redir4.sh", "r |
| edir4a.sh", "redir5.sh". |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Redirecting the ``stdout`` of a code block has the effect of saving its
output to a file. See `Example 3-2 <special-chars.html#RPMCHECK>`__.

`Here documents <here-docs.html#HEREDOCREF>`__ are a special case of
redirected code blocks. That being the case, it should be possible to
feed the output of a *here document* into the ``stdin`` for a *while
loop*.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # This example by Al |
| bert Siersema            |
|     # Used with permissi |
| on (thanks!).            |
|                          |
|     function doesOutput( |
| )                        |
|      # Could be an exter |
| nal command too, of cour |
| se.                      |
|      # Here we show you  |
| can use a function as we |
| ll.                      |
|     {                    |
|       ls -al *.jpg | awk |
|  '{print $5,$9}'         |
|     }                    |
|                          |
|                          |
|     nr=0          #  We  |
| want the while loop to b |
| e able to manipulate the |
| se and                   |
|     totalSize=0   #+ to  |
| be able to see the chang |
| es after the 'while' fin |
| ished.                   |
|                          |
|     while read fileSize  |
| fileName ; do            |
|       echo "$fileName is |
|  $fileSize bytes"        |
|       let nr++           |
|       totalSize=$((total |
| Size+fileSize))   # Or:  |
| "let totalSize+=fileSize |
| "                        |
|     done<<EOF            |
|     $(doesOutput)        |
|     EOF                  |
|                          |
|     echo "$nr files tota |
| ling $totalSize bytes"   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <x17974.html>`__   | Using *exec*             |
| `Home <index.html>`__    | `Up <io-redirection.html |
| `Next <redirapps.html>`_ | >`__                     |
| _                        | Applications             |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

