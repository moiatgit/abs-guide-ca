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

`Prev <mathc.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 16. External Filters, Programs and Commands

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <system.html>`__

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

  16.9. Miscellaneous Commands
=============================

.. raw:: html

   <div class="VARIABLELIST">

** Command that fit in no special category**

 **jot** , **seq**
    These utilities emit a sequence of integers, with a user-selectable
    increment.

    The default separator character between each integer is a newline,
    but this can be changed with the ``         -s        `` option.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ seq 5          |
    |     1                    |
    |      2                   |
    |      3                   |
    |      4                   |
    |      5                   |
    |                          |
    |                          |
    |                          |
    |     bash$ seq -s : 5     |
    |     1:2:3:4:5            |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    Both **jot** and **seq** come in handy in a `for
    loop <loops1.html#FORLOOPREF1>`__ .

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-54. Using *seq* to generate loop arguments**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Using "seq"        |
    |                          |
    |     echo                 |
    |                          |
    |     for a in `seq 80`  # |
    |  or   for a in $( seq 80 |
    |  )                       |
    |     # Same as   for a in |
    |  1 2 3 4 5 ... 80   (sav |
    | es much typing!).        |
    |     # May also use 'jot' |
    |  (if present on system). |
    |     do                   |
    |       echo -n "$a "      |
    |     done      # 1 2 3 4  |
    | 5 ... 80                 |
    |     # Example of using t |
    | he output of a command t |
    | o generate               |
    |     # the [list] in a "f |
    | or" loop.                |
    |                          |
    |     echo; echo           |
    |                          |
    |                          |
    |     COUNT=80  # Yes, 'se |
    | q' also accepts a replac |
    | eable parameter.         |
    |                          |
    |     for a in `seq $COUNT |
    | `  # or   for a in $( se |
    | q $COUNT )               |
    |     do                   |
    |       echo -n "$a "      |
    |     done      # 1 2 3 4  |
    | 5 ... 80                 |
    |                          |
    |     echo; echo           |
    |                          |
    |     BEGIN=75             |
    |     END=80               |
    |                          |
    |     for a in `seq $BEGIN |
    |  $END`                   |
    |     #  Giving "seq" two  |
    | arguments starts the cou |
    | nt at the first one,     |
    |     #+ and continues unt |
    | il it reaches the second |
    | .                        |
    |     do                   |
    |       echo -n "$a "      |
    |     done      # 75 76 77 |
    |  78 79 80                |
    |                          |
    |     echo; echo           |
    |                          |
    |     BEGIN=45             |
    |     INTERVAL=5           |
    |     END=80               |
    |                          |
    |     for a in `seq $BEGIN |
    |  $INTERVAL $END`         |
    |     #  Giving "seq" thre |
    | e arguments starts the c |
    | ount at the first one,   |
    |     #+ uses the second f |
    | or a step interval,      |
    |     #+ and continues unt |
    | il it reaches the third. |
    |     do                   |
    |       echo -n "$a "      |
    |     done      # 45 50 55 |
    |  60 65 70 75 80          |
    |                          |
    |     echo; echo           |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    A simpler example:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #  Create a set of 1 |
    | 0 files,                 |
    |     #+ named file.1, fil |
    | e.2 . . . file.10.       |
    |     COUNT=10             |
    |     PREFIX=file          |
    |                          |
    |     for filename in `seq |
    |  $COUNT`                 |
    |     do                   |
    |       touch $PREFIX.$fil |
    | ename                    |
    |       #  Or, can do othe |
    | r operations,            |
    |       #+ such as rm, gre |
    | p, etc.                  |
    |     done                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-55. Letter Count"**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # letter-count.sh: C |
    | ounting letter occurrenc |
    | es in a text file.       |
    |     # Written by Stefano |
    |  Palmeri.                |
    |     # Used in ABS Guide  |
    | with permission.         |
    |     # Slightly modified  |
    | by document author.      |
    |                          |
    |     MINARGS=2          # |
    |  Script requires at leas |
    | t two arguments.         |
    |     E_BADARGS=65         |
    |     FILE=$1              |
    |                          |
    |     let LETTERS=$#-1   # |
    |  How many letters specif |
    | ied (as command-line arg |
    | s).                      |
    |                        # |
    |  (Subtract 1 from number |
    |  of command-line args.)  |
    |                          |
    |                          |
    |     show_help(){         |
    |            echo          |
    |                echo Usag |
    | e: `basename $0` file le |
    | tters                    |
    |                echo Note |
    | : `basename $0` argument |
    | s are case sensitive.    |
    |                echo Exam |
    | ple: `basename $0` fooba |
    | r.txt G n U L i N U x.   |
    |            echo          |
    |     }                    |
    |                          |
    |     # Checks number of a |
    | rguments.                |
    |     if [ $# -lt $MINARGS |
    |  ]; then                 |
    |        echo              |
    |        echo "Not enough  |
    | arguments."              |
    |        echo              |
    |        show_help         |
    |        exit $E_BADARGS   |
    |     fi                   |
    |                          |
    |                          |
    |     # Checks if file exi |
    | sts.                     |
    |     if [ ! -f $FILE ]; t |
    | hen                      |
    |         echo "File \"$FI |
    | LE\" does not exist."    |
    |         exit $E_BADARGS  |
    |     fi                   |
    |                          |
    |                          |
    |                          |
    |     # Counts letter occu |
    | rrences .                |
    |     for n in `seq $LETTE |
    | RS`; do                  |
    |           shift          |
    |           if [[ `echo -n |
    |  "$1" | wc -c` -eq 1 ]]; |
    |  then             #  Che |
    | cks arg.                 |
    |                  echo "$ |
    | 1" -\> `cat $FILE | tr - |
    | cd  "$1" | wc -c` #  Cou |
    | nting.                   |
    |           else           |
    |                  echo "$ |
    | 1 is not a  single char. |
    | "                        |
    |           fi             |
    |     done                 |
    |                          |
    |     exit $?              |
    |                          |
    |     #  This script has e |
    | xactly the same function |
    | ality as letter-count2.s |
    | h,                       |
    |     #+ but executes fast |
    | er.                      |
    |     #  Why?              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------+--------------+--------------+--------------+--------------+--------------+
    | |Note|       |
    | Somewhat     |
    | more capable |
    | than *seq* , |
    | **jot** is a |
    | classic UNIX |
    | utility that |
    | is not       |
    | normally     |
    | included in  |
    | a standard   |
    | Linux        |
    | distro.      |
    | However, the |
    | source *rpm* |
    | is available |
    | for download |
    | from the     |
    | `MIT         |
    | repository < |
    | http://www.m |
    | it.edu/afs/a |
    | thena/system |
    | /rhlinux/ath |
    | ena-9.0/free |
    | /SRPMS/athen |
    | a-jot-9.0-3. |
    | src.rpm>`__  |
    | .            |
    |              |
    | Unlike *seq* |
    | , **jot**    |
    | can generate |
    | a sequence   |
    | of random    |
    | numbers,     |
    | using the    |
    | ``           |
    |    -r        |
    |      ``      |
    | option.      |
    |              |
    | +----------- |
    | ------------ |
    | ---+-------- |
    | ------------ |
    | ------+----- |
    | ------------ |
    | ---------+   |
    | | .. code::  |
    | SCREEN       |
    |    |         |
    | |            |
    |              |
    |    |         |
    | |     bash$  |
    | jot -r 3 999 |
    |    |         |
    | |     1069   |
    |              |
    |    |         |
    | |      1272  |
    |              |
    |    |         |
    | |      1428  |
    |              |
    |    |         |
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
                  
    +--------------+--------------+--------------+--------------+--------------+--------------+

    .. raw:: html

       </div>

 **getopt**
    The **getopt** command parses command-line options preceded by a
    `dash <special-chars.html#DASHREF>`__ . This external command
    corresponds to the `getopts <internal.html#GETOPTSX>`__ Bash
    builtin. Using **getopt** permits handling long options by means of
    the ``         -l        `` flag, and this also allows parameter
    reshuffling.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-56. Using *getopt* to parse command-line options**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Using getopt       |
    |                          |
    |     # Try the following  |
    | when invoking this scrip |
    | t:                       |
    |     #   sh ex33a.sh -a   |
    |     #   sh ex33a.sh -abc |
    |     #   sh ex33a.sh -a - |
    | b -c                     |
    |     #   sh ex33a.sh -d   |
    |     #   sh ex33a.sh -dXY |
    | Z                        |
    |     #   sh ex33a.sh -d X |
    | YZ                       |
    |     #   sh ex33a.sh -abc |
    | d                        |
    |     #   sh ex33a.sh -abc |
    | dZ                       |
    |     #   sh ex33a.sh -z   |
    |     #   sh ex33a.sh a    |
    |     # Explain the result |
    | s of each of the above.  |
    |                          |
    |     E_OPTERR=65          |
    |                          |
    |     if [ "$#" -eq 0 ]    |
    |     then   # Script need |
    | s at least one command-l |
    | ine argument.            |
    |       echo "Usage $0 -[o |
    | ptions a,b,c]"           |
    |       exit $E_OPTERR     |
    |     fi                   |
    |                          |
    |     set -- `getopt "abcd |
    | :" "$@"`                 |
    |     # Sets positional pa |
    | rameters to command-line |
    |  arguments.              |
    |     # What happens if yo |
    | u use "$*" instead of "$ |
    | @"?                      |
    |                          |
    |     while [ ! -z "$1" ]  |
    |     do                   |
    |       case "$1" in       |
    |         -a) echo "Option |
    |  \"a\"";;                |
    |         -b) echo "Option |
    |  \"b\"";;                |
    |         -c) echo "Option |
    |  \"c\"";;                |
    |         -d) echo "Option |
    |  \"d\" $2";;             |
    |          *) break;;      |
    |       esac               |
    |                          |
    |       shift              |
    |     done                 |
    |                          |
    |     #  It is usually bet |
    | ter to use the 'getopts' |
    |  builtin in a script.    |
    |     #  See "ex33.sh."    |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------------+--------------------+--------------------+--------------------+
    | |Note|             |
    | As *Peggy Russell* |
    | points out:        |
    |                    |
    | It is often        |
    | necessary to       |
    | include an         |
    | `eval <internal.ht |
    | ml#EVALREF>`__     |
    | to correctly       |
    | process            |
    | `whitespace <speci |
    | al-chars.html#WHIT |
    | ESPACEREF>`__      |
    | and *quotes* .     |
    |                    |
    | +----------------- |
    | ---------+-------- |
    | ------------------ |
    | +----------------- |
    | ---------+         |
    | | .. code:: PROGRA |
    | MLISTING |         |
    | |                  |
    |          |         |
    | |     args=$(getop |
    | t -o a:b |         |
    | | c:d -- "$@")     |
    |          |         |
    | |     eval set --  |
    | "$args"  |         |
    |                    |
    |                    |
    | +----------------- |
    | ---------+-------- |
    | ------------------ |
    | +----------------- |
    | ---------+         |
                        
    +--------------------+--------------------+--------------------+--------------------+

    .. raw:: html

       </div>

    See `Example 10-5 <string-manipulation.html#GETOPTSIMPLE>`__ for a
    simplified emulation of **getopt** .

 **run-parts**
    The **run-parts** command ` [1]  <extmisc.html#FTN.AEN14105>`__
    executes all the scripts in a target directory, sequentially in
    ASCII-sorted filename order. Of course, the scripts need to have
    execute permission.

    The `cron <system.html#CRONREF>`__
    `daemon <communications.html#DAEMONREF>`__ invokes **run-parts** to
    run the scripts in the ``         /etc/cron.*        `` directories.

 **yes**
    In its default behavior the **yes** command feeds a continuous
    string of the character ``         y        `` followed by a line
    feed to ``         stdout        `` . A **control** - **C**
    terminates the run. A different output string may be specified, as
    in
    ``                   yes different           string                 ``
    , which would continually output
    ``         different string        `` to ``         stdout        ``
    .

    One might well ask the purpose of this. From the command-line or in
    a script, the output of **yes** can be redirected or piped into a
    program expecting user input. In effect, this becomes a sort of poor
    man's version of *expect* .

    ``                   yes | fsck /dev/hda1                 `` runs
    **fsck** non-interactively (careful!).

    ``                   yes | rm -r dirname                 `` has same
    effect as ``                   rm -rf dirname                 ``
    (careful!).

    .. raw:: html

       <div class="WARNING">

    +--------------------------------------+--------------------------------------+
    | |Warning|                            |
    | Caution advised when piping *yes* to |
    | a potentially dangerous system       |
    | command, such as                     |
    | `fsck <system.html#FSCKREF>`__ or    |
    | `fdisk <system.html#FDISKREF>`__ .   |
    | It might have unintended             |
    | consequences.                        |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +------------+------------+------------+------------+------------+------------+------------+
    | |Note|     |
    | The *yes*  |
    | command    |
    | parses     |
    | variables, |
    | or more    |
    | accurately |
    | ,          |
    | it echoes  |
    | parsed     |
    | variables. |
    | For        |
    | example:   |
    |            |
    | +--------- |
    | ---------- |
    | -------+-- |
    | ---------- |
    | ---------- |
    | ----+----- |
    | ---------- |
    | ---------- |
    | -+         |
    | | .. code: |
    | : SCREEN   |
    |        |   |
    | |          |
    |            |
    |        |   |
    | |     bash |
    | $ yes $BAS |
    | H_VERS |   |
    | | ION      |
    |            |
    |        |   |
    | |     3.1. |
    | 17(1)-rele |
    | ase    |   |
    | |      3.1 |
    | .17(1)-rel |
    | ease   |   |
    | |      3.1 |
    | .17(1)-rel |
    | ease   |   |
    | |      3.1 |
    | .17(1)-rel |
    | ease   |   |
    | |      3.1 |
    | .17(1)-rel |
    | ease   |   |
    | |      . . |
    |  .         |
    |        |   |
    | |          |
    |            |
    |        |   |
    |            |
    |            |
    |            |
    | +--------- |
    | ---------- |
    | -------+-- |
    | ---------- |
    | ---------- |
    | ----+----- |
    | ---------- |
    | ---------- |
    | -+         |
    |            |
    | This       |
    | particular |
    | "feature"  |
    | may be     |
    | used to    |
    | create a   |
    | *very      |
    | large*     |
    | ASCII file |
    | on the     |
    | fly:       |
    |            |
    | +--------- |
    | ---------- |
    | -------+-- |
    | ---------- |
    | ---------- |
    | ----+----- |
    | ---------- |
    | ---------- |
    | -+         |
    | | .. code: |
    | : SCREEN   |
    |        |   |
    | |          |
    |            |
    |        |   |
    | |     bash |
    | $ yes $PAT |
    | H > hu |   |
    | | ge_file. |
    | txt        |
    |        |   |
    | |     Ctl- |
    | C          |
    |        |   |
    | |          |
    |            |
    |        |   |
    |            |
    |            |
    |            |
    | +--------- |
    | ---------- |
    | -------+-- |
    | ---------- |
    | ---------- |
    | ----+----- |
    | ---------- |
    | ---------- |
    | -+         |
    |            |
    | Hit        |
    | ``         |
    |            |
    |        Ctl |
    | -C         |
    |            |
    |      ``    |
    | *very      |
    | quickly* , |
    | or you     |
    | just might |
    | get more   |
    | than you   |
    | bargained  |
    | for. . . . |
    +------------+------------+------------+------------+------------+------------+------------+

    .. raw:: html

       </div>

     The *yes* command may be emulated in a very simple script
    `function <functions.html#FUNCTIONREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     yes ()               |
    |     { # Trivial emulatio |
    | n of "yes" ...           |
    |       local DEFAULT_TEXT |
    | ="y"                     |
    |       while [ true ]   # |
    |  Endless loop.           |
    |       do                 |
    |         if [ -z "$1" ]   |
    |         then             |
    |           echo "$DEFAULT |
    | _TEXT"                   |
    |         else           # |
    |  If argument ...         |
    |           echo "$1"    # |
    |  ... expand and echo it. |
    |         fi               |
    |       done             # |
    |   The only things missin |
    | g are the                |
    |     }                  # |
    | + --help and --version o |
    | ptions.                  |
                              
    +--------------------------+--------------------------+--------------------------+

 **banner**
    Prints arguments as a large vertical banner to
    ``         stdout        `` , using an
    `ASCII <special-chars.html#ASCIIDEF>`__ character (default '#').
    This may be redirected to a printer for hardcopy.

    Note that *banner* has been dropped from many Linux distros,
    presumably because it is no longer considered useful.

 **printenv**
    Show all the `environmental variables <othertypesv.html#ENVREF>`__
    set for a particular user.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ printenv | gre |
    | p HOME                   |
    |     HOME=/home/bozo      |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **lp**
    The **lp** and **lpr** commands send file(s) to the print queue, to
    be printed as hard copy. ` [2]  <extmisc.html#FTN.AEN14214>`__ These
    commands trace the origin of their names to the line printers of
    another era. ` [3]  <extmisc.html#FTN.AEN14218>`__

    ``         bash$        ``
    ``                   lp file1.txt                 `` or
    ``         bash        ``
    ``                   lp         <file1.txt                 ``

    It is often useful to pipe the formatted output from **pr** to
    **lp** .

    ``         bash$        ``
    ``                   pr -options file1.txt | lp                 ``

    Formatting packages, such as `groff <textproc.html#GROFFREF>`__ and
    *Ghostscript* may send their output directly to **lp** .

    ``         bash$        ``
    ``                   groff -Tascii file.tr | lp                 ``

    ``         bash$        ``
    ``                   gs -options | lp file.ps                 ``

    Related commands are **lpq** , for viewing the print queue, and
    **lprm** , for removing jobs from the print queue.

 **tee**
    [UNIX borrows an idea from the plumbing trade.]

    This is a redirection operator, but with a difference. Like the
    plumber's *tee,* it permits "siphoning off" *to a file* the output
    of a command or commands within a pipe, but without affecting the
    result. This is useful for printing an ongoing process to a file or
    paper, perhaps to keep track of it for debugging purposes.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |                          |
    |          (redirection)   |
    |                          |
    |         |----> to file   |
    |                          |
    |         |                |
    |       ================== |
    | ========|=============== |
    | =====                    |
    |       command ---> comma |
    | nd ---> |tee ---> comman |
    | d ---> ---> output of pi |
    | pe                       |
    |       ================== |
    | ======================== |
    | =====                    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     cat listfile* | sort |
    |  | tee check.file | uniq |
    |  > result.file           |
    |     #                    |
    |    ^^^^^^^^^^^^^^   ^^^^ |
    |                          |
    |                          |
    |     #  The file "check.f |
    | ile" contains the concat |
    | enated sorted "listfiles |
    | ,"                       |
    |     #+ before the duplic |
    | ate lines are removed by |
    |  'uniq.'                 |
                              
    +--------------------------+--------------------------+--------------------------+

 **mkfifo**
     This obscure command creates a *named pipe* , a temporary
    *first-in-first-out buffer* for transferring data between processes.
    ` [4]  <extmisc.html#FTN.AEN14280>`__ Typically, one process writes
    to the FIFO, and the other reads from it. See `Example
    A-14 <contributed-scripts.html#FIFO>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # This short script  |
    | by Omair Eshkenazi.      |
    |     # Used in ABS Guide  |
    | with permission (thanks! |
    | ).                       |
    |                          |
    |     mkfifo pipe1   # Yes |
    | , pipes can be given nam |
    | es.                      |
    |     mkfifo pipe2   # Hen |
    | ce the designation "name |
    | d pipe."                 |
    |                          |
    |     (cut -d' ' -f1 | tr  |
    | "a-z" "A-Z") >pipe2 <pip |
    | e1 &                     |
    |     ls -l | tr -s ' ' |  |
    | cut -d' ' -f3,9- | tee p |
    | ipe1 |                   |
    |     cut -d' ' -f2 | past |
    | e - pipe2                |
    |                          |
    |     rm -f pipe1          |
    |     rm -f pipe2          |
    |                          |
    |     # No need to kill ba |
    | ckground processes when  |
    | script terminates (why n |
    | ot?).                    |
    |                          |
    |     exit $?              |
    |                          |
    |     Now, invoke the scri |
    | pt and explain the outpu |
    | t:                       |
    |     sh mkfifo-example.sh |
    |                          |
    |     4830.tar.gz          |
    |  BOZO                    |
    |     pipe1   BOZO         |
    |     pipe2   BOZO         |
    |     mkfifo-example.sh    |
    |  BOZO                    |
    |     Mixed.msg BOZO       |
                              
    +--------------------------+--------------------------+--------------------------+

 **pathchk**
    This command checks the validity of a filename. If the filename
    exceeds the maximum allowable length (255 characters) or one or more
    of the directories in its path is not searchable, then an error
    message results.

    Unfortunately, **pathchk** does not return a recognizable error
    code, and it is therefore pretty much useless in a script. Consider
    instead the `file test operators <fto.html#RTIF>`__ .

 **dd**
    Though this somewhat obscure and much feared **d** ata **d**
    uplicator command originated as a utility for exchanging data on
    magnetic tapes between UNIX minicomputers and IBM mainframes, it
    still has its uses. The **dd** command simply copies a file (or
    ``         stdin/stdout        `` ), but with conversions. Possible
    conversions include ASCII/EBCDIC, ` [5]
     <extmisc.html#FTN.AEN14318>`__ upper/lower case, swapping of byte
    pairs between input and output, and skipping and/or truncating the
    head or tail of the input file.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Converting a file  |
    | to all uppercase:        |
    |                          |
    |     dd if=$filename conv |
    | =ucase > $filename.upper |
    | case                     |
    |     #                    |
    |  lcase   # For lower cas |
    | e conversion             |
                              
    +--------------------------+--------------------------+--------------------------+

    Some basic options to **dd** are:

    -  if=INFILE

       INFILE is the *source* file.

    -  of=OUTFILE

       OUTFILE is the *target* file, the file that will have the data
       written to it.

    -  bs=BLOCKSIZE

       This is the size of each block of data being read and written,
       usually a power of 2.

    -  skip=BLOCKS

       How many blocks of data to skip in INFILE before starting to
       copy. This is useful when the INFILE has "garbage" or garbled
       data in its header or when it is desirable to copy only a portion
       of the INFILE.

    -  seek=BLOCKS

       How many blocks of data to skip in OUTFILE before starting to
       copy, leaving blank data at beginning of OUTFILE.

    -  count=BLOCKS

       Copy only this many blocks of data, rather than the entire
       INFILE.

    -  conv=CONVERSION

       Type of conversion to be applied to INFILE data before copying
       operation.

    A ``                   dd --help                 `` lists all the
    options this powerful utility takes.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-57. A script that copies itself**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # self-copy.sh       |
    |                          |
    |     # This script copies |
    |  itself.                 |
    |                          |
    |     file_subscript=copy  |
    |                          |
    |     dd if=$0 of=$0.$file |
    | _subscript 2>/dev/null   |
    |     # Suppress messages  |
    | from dd:   ^^^^^^^^^^^   |
    |                          |
    |     exit $?              |
    |                          |
    |     #  A program whose o |
    | nly output is its own so |
    | urce code                |
    |     #+ is called a "quin |
    | e" per Willard Quine.    |
    |     #  Does this script  |
    | qualify as a quine?      |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-58. Exercising *dd***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # exercising-dd.sh   |
    |                          |
    |     # Script by Stephane |
    |  Chazelas.               |
    |     # Somewhat modified  |
    | by ABS Guide author.     |
    |                          |
    |     infile=$0            |
    | # This script.           |
    |     outfile=log.txt      |
    | # Output file left behin |
    | d.                       |
    |     n=8                  |
    |     p=11                 |
    |                          |
    |     dd if=$infile of=$ou |
    | tfile bs=1 skip=$((n-1)) |
    |  count=$((p-n+1)) 2> /de |
    | v/null                   |
    |     # Extracts character |
    | s n to p (8 to 11) from  |
    | this script ("bash").    |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | ----------------------   |
    |                          |
    |     echo -n "hello verti |
    | cal world" | dd cbs=1 co |
    | nv=unblock 2> /dev/null  |
    |     # Echoes "hello vert |
    | ical world" vertically d |
    | ownward.                 |
    |     # Why? A newline fol |
    | lows each character dd e |
    | mits.                    |
    |                          |
    |     exit $?              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    To demonstrate just how versatile **dd** is, let's use it to capture
    keystrokes.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-59. Capturing Keystrokes**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # dd-keypress.sh: Ca |
    | pture keystrokes without |
    |  needing to press ENTER. |
    |                          |
    |                          |
    |     keypresses=4         |
    |               # Number o |
    | f keypresses to capture. |
    |                          |
    |                          |
    |     old_tty_setting=$(st |
    | ty -g)        # Save old |
    |  terminal settings.      |
    |                          |
    |     echo "Press $keypres |
    | ses keys."               |
    |     stty -icanon -echo   |
    |               # Disable  |
    | canonical mode.          |
    |                          |
    |               # Disable  |
    | local echo.              |
    |     keys=$(dd bs=1 count |
    | =$keypresses 2> /dev/nul |
    | l)                       |
    |     # 'dd' uses stdin, i |
    | f "if" (input file) not  |
    | specified.               |
    |                          |
    |     stty "$old_tty_setti |
    | ng"           # Restore  |
    | old terminal settings.   |
    |                          |
    |     echo "You pressed th |
    | e \"$keys\" keys."       |
    |                          |
    |     # Thanks, Stephane C |
    | hazelas, for showing the |
    |  way.                    |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The **dd** command can do random access on a data stream.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo -n . | dd bs=1  |
    | seek=4 of=file conv=notr |
    | unc                      |
    |     #  The "conv=notrunc |
    | " option means that the  |
    | output file              |
    |     #+ will not be trunc |
    | ated.                    |
    |                          |
    |     # Thanks, S.C.       |
                              
    +--------------------------+--------------------------+--------------------------+

    The **dd** command can copy raw data and disk images to and from
    devices, such as floppies and tape drives ( `Example
    A-5 <contributed-scripts.html#COPYCD>`__ ). A common use is creating
    boot floppies.

    ``                   dd if=kernel-image of=/dev/fd0H1440                 ``

    Similarly, **dd** can copy the entire contents of a floppy, even one
    formatted with a "foreign" OS, to the hard drive as an image file.

    ``                   dd if=/dev/fd0 of=/home/bozo/projects/floppy.img                 ``

     Likewise, **dd** can create bootable flash drives and SD cards.

    ``                   dd if=image.iso of=/dev/sdb                 ``

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-60. Preparing a bootable SD card for the *Raspberry
    Pi***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # rp.sdcard.sh       |
    |     # Preparing an SD ca |
    | rd with a bootable image |
    |  for the Raspberry Pi.   |
    |                          |
    |     # $1 = imagefile nam |
    | e                        |
    |     # $2 = sdcard (devic |
    | e file)                  |
    |     # Otherwise defaults |
    |  to the defaults, see be |
    | low.                     |
    |                          |
    |     DEFAULTbs=4M         |
    |                          |
    |  # Block size, 4 mb defa |
    | ult.                     |
    |     DEFAULTif="2013-07-2 |
    | 6-wheezy-raspbian.img"   |
    |  # Commonly used distro. |
    |     DEFAULTsdcard="/dev/ |
    | mmcblk0"                 |
    |  # May be different. Che |
    | ck!                      |
    |     ROOTUSER_NAME=root   |
    |                          |
    |  # Must run as root!     |
    |     E_NOTROOT=81         |
    |     E_NOIMAGE=82         |
    |                          |
    |     username=$(id -nu)   |
    |                          |
    |  # Who is running this s |
    | cript?                   |
    |     if [ "$username" !=  |
    | "$ROOTUSER_NAME" ]       |
    |     then                 |
    |       echo "This script  |
    | must run as root or with |
    |  root privileges."       |
    |       exit $E_NOTROOT    |
    |     fi                   |
    |                          |
    |     if [ -n "$1" ]       |
    |     then                 |
    |       imagefile="$1"     |
    |     else                 |
    |       imagefile="$DEFAUL |
    | Tif"                     |
    |     fi                   |
    |                          |
    |     if [ -n "$2" ]       |
    |     then                 |
    |       sdcard="$2"        |
    |     else                 |
    |       sdcard="$DEFAULTsd |
    | card"                    |
    |     fi                   |
    |                          |
    |     if [ ! -e $imagefile |
    |  ]                       |
    |     then                 |
    |       echo "Image file \ |
    | "$imagefile\" not found! |
    | "                        |
    |       exit $E_NOIMAGE    |
    |     fi                   |
    |                          |
    |     echo "Last chance to |
    |  change your mind!"; ech |
    | o                        |
    |     read -s -n1 -p "Hit  |
    | a key to write $imagefil |
    | e to $sdcard [Ctl-c to e |
    | xit]."                   |
    |     echo; echo           |
    |                          |
    |     echo "Writing $image |
    | file to $sdcard ..."     |
    |     dd bs=$DEFAULTbs if= |
    | $imagefile of=$sdcard    |
    |                          |
    |     exit $?              |
    |                          |
    |     # Exercises:         |
    |     # ---------          |
    |     # 1) Provide additio |
    | nal error checking.      |
    |     # 2) Have script aut |
    | odetect device file for  |
    | SD card (difficult!).    |
    |     # 3) Have script sut |
    | odetect image file (*img |
    | ) in $PWD.               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Other applications of **dd** include initializing temporary swap
    files ( `Example 31-2 <zeros.html#EX73>`__ ) and ramdisks ( `Example
    31-3 <zeros.html#RAMDISK>`__ ). It can even do a low-level copy of
    an entire hard drive partition, although this is not necessarily
    recommended.

    People (with presumably nothing better to do with their time) are
    constantly thinking of interesting applications of **dd** .

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-61. Securely deleting a file**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # blot-out.sh: Erase |
    |  "all" traces of a file. |
    |                          |
    |     #  This script overw |
    | rites a target file alte |
    | rnately                  |
    |     #+ with random bytes |
    | , then zeros before fina |
    | lly deleting it.         |
    |     #  After that, even  |
    | examining the raw disk s |
    | ectors by conventional m |
    | ethods                   |
    |     #+ will not reveal t |
    | he original file data.   |
    |                          |
    |     PASSES=7         #   |
    | Number of file-shredding |
    |  passes.                 |
    |                      #   |
    | Increasing this slows sc |
    | ript execution,          |
    |                      #+  |
    | especially on large targ |
    | et files.                |
    |     BLOCKSIZE=1      #   |
    | I/O with /dev/urandom re |
    | quires unit block size,  |
    |                      #+  |
    | otherwise you get weird  |
    | results.                 |
    |     E_BADARGS=70     #   |
    | Various error exit codes |
    | .                        |
    |     E_NOT_FOUND=71       |
    |     E_CHANGED_MIND=72    |
    |                          |
    |     if [ -z "$1" ]   # N |
    | o filename specified.    |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` filename"       |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |     file=$1              |
    |                          |
    |     if [ ! -e "$file" ]  |
    |     then                 |
    |       echo "File \"$file |
    | \" not found."           |
    |       exit $E_NOT_FOUND  |
    |     fi                   |
    |                          |
    |     echo; echo -n "Are y |
    | ou absolutely sure you w |
    | ant to blot out \"$file\ |
    | " (y/n)? "               |
    |     read answer          |
    |     case "$answer" in    |
    |     [nN]) echo "Changed  |
    | your mind, huh?"         |
    |           exit $E_CHANGE |
    | D_MIND                   |
    |           ;;             |
    |     *)    echo "Blotting |
    |  out file \"$file\".";;  |
    |     esac                 |
    |                          |
    |                          |
    |     flength=$(ls -l "$fi |
    | le" | awk '{print $5}')  |
    |  # Field 5 is file lengt |
    | h.                       |
    |     pass_count=1         |
    |                          |
    |     chmod u+w "$file"    |
    | # Allow overwriting/dele |
    | ting the file.           |
    |                          |
    |     echo                 |
    |                          |
    |     while [ "$pass_count |
    | " -le "$PASSES" ]        |
    |     do                   |
    |       echo "Pass #$pass_ |
    | count"                   |
    |       sync         # Flu |
    | sh buffers.              |
    |       dd if=/dev/urandom |
    |  of=$file bs=$BLOCKSIZE  |
    | count=$flength           |
    |                    # Fil |
    | l with random bytes.     |
    |       sync         # Flu |
    | sh buffers again.        |
    |       dd if=/dev/zero of |
    | =$file bs=$BLOCKSIZE cou |
    | nt=$flength              |
    |                    # Fil |
    | l with zeros.            |
    |       sync         # Flu |
    | sh buffers yet again.    |
    |       let "pass_count += |
    |  1"                      |
    |       echo               |
    |     done                 |
    |                          |
    |                          |
    |     rm -f $file    # Fin |
    | ally, delete scrambled a |
    | nd shredded file.        |
    |     sync           # Flu |
    | sh buffers a final time. |
    |                          |
    |     echo "File \"$file\" |
    |  blotted out and deleted |
    | ."; echo                 |
    |                          |
    |                          |
    |     exit 0               |
    |                          |
    |     #  This is a fairly  |
    | secure, if inefficient a |
    | nd slow method           |
    |     #+ of thoroughly "sh |
    | redding" a file.         |
    |     #  The "shred" comma |
    | nd, part of the GNU "fil |
    | eutils" package,         |
    |     #+ does the same thi |
    | ng, although more effici |
    | ently.                   |
    |                          |
    |     #  The file cannot n |
    | ot be "undeleted" or ret |
    | rieved by normal methods |
    | .                        |
    |     #  However . . .     |
    |     #+ this simple metho |
    | d would *not* likely wit |
    | hstand                   |
    |     #+ sophisticated for |
    | ensic analysis.          |
    |                          |
    |     #  This script may n |
    | ot play well with a jour |
    | naled file system.       |
    |     #  Exercise (difficu |
    | lt): Fix it so it does.  |
    |                          |
    |                          |
    |                          |
    |     #  Tom Vier's "wipe" |
    |  file-deletion package d |
    | oes a much more thorough |
    |  job                     |
    |     #+ of file shredding |
    |  than this simple script |
    | .                        |
    |     #     http://www.ibi |
    | blio.org/pub/Linux/utils |
    | /file/wipe-2.0.0.tar.bz2 |
    |                          |
    |     #  For an in-depth a |
    | nalysis on the topic of  |
    | file deletion and securi |
    | ty,                      |
    |     #+ see Peter Gutmann |
    | 's paper,                |
    |     #+     "Secure Delet |
    | ion of Data From Magneti |
    | c and Solid-State Memory |
    | ".                       |
    |     #       http://www.c |
    | s.auckland.ac.nz/~pgut00 |
    | 1/pubs/secure_del.html   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also the `dd thread <biblio.html#DDLINK>`__ entry in the
    `bibliography <biblio.html#BIBLIOREF>`__ .

 **od**
    The **od** , or *octal dump* filter converts input (or files) to
    octal (base-8) or other bases. This is useful for viewing or
    processing binary data files or otherwise unreadable system `device
    files <devref1.html#DEVFILEREF>`__ , such as
    ``         /dev/urandom        `` , and as a filter for binary data.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     head -c4 /dev/urando |
    | m | od -N4 -tu4 | sed -n |
    | e '1s/.* //p'            |
    |     # Sample output: 132 |
    | 4725719, 3918166450, 298 |
    | 9231420, etc.            |
    |                          |
    |     # From rnd.sh exampl |
    | e script, by StĂŠphane C |
    | hazelas                  |
                              
    +--------------------------+--------------------------+--------------------------+

    See also `Example 9-16 <randomvar.html#SEEDINGRANDOM>`__ and
    `Example A-36 <contributed-scripts.html#INSERTIONSORT>`__ .

 **hexdump**
    Performs a hexadecimal, octal, decimal, or ASCII dump of a binary
    file. This command is the rough equivalent of **od** , above, but
    not nearly as useful. May be used to view the contents of a binary
    file, in combination with `dd <extmisc.html#DDREF>`__ and
    `less <filearchiv.html#LESSREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     dd if=/bin/ls | hexd |
    | ump -C | less            |
    |     # The -C option nice |
    | ly formats the output in |
    |  tabular form.           |
                              
    +--------------------------+--------------------------+--------------------------+

 **objdump**
    Displays information about an object file or binary executable in
    either hexadecimal form or as a disassembled listing (with the
    ``         -d        `` option).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ objdump -d /bi |
    | n/ls                     |
    |     /bin/ls:     file fo |
    | rmat elf32-i386          |
    |                          |
    |      Disassembly of sect |
    | ion .init:               |
    |                          |
    |      080490bc <.init>:   |
    |       80490bc:       55  |
    |                      pus |
    | h   %ebp                 |
    |       80490bd:       89  |
    | e5                   mov |
    |     %esp,%ebp            |
    |       . . .              |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **mcookie**
    This command generates a "magic cookie," a 128-bit (32-character)
    pseudorandom hexadecimal number, normally used as an authorization
    "signature" by the X server. This also available for use in a script
    as a "quick 'n dirty" random number.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     random000=$(mcookie) |
                              
    +--------------------------+--------------------------+--------------------------+

    Of course, a script could use `md5sum <filearchiv.html#MD5SUMREF>`__
    for the same purpose.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Generate md5 check |
    | sum on the script itself |
    | .                        |
    |     random001=`md5sum $0 |
    |  | awk '{print $1}'`     |
    |     # Uses 'awk' to stri |
    | p off the filename.      |
                              
    +--------------------------+--------------------------+--------------------------+

    The **mcookie** command gives yet another way to generate a "unique"
    filename.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-62. Filename generator**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # tempfile-name.sh:  |
    |  temp filename generator |
    |                          |
    |     BASE_STR=`mcookie`   |
    |  # 32-character magic co |
    | okie.                    |
    |     POS=11               |
    |  # Arbitrary position in |
    |  magic cookie string.    |
    |     LEN=5                |
    |  # Get $LEN consecutive  |
    | characters.              |
    |                          |
    |     prefix=temp          |
    |  #  This is, after all,  |
    | a "temp" file.           |
    |                          |
    |  #  For more "uniqueness |
    | ," generate the          |
    |                          |
    |  #+ filename prefix usin |
    | g the same method        |
    |                          |
    |  #+ as the suffix, below |
    | .                        |
    |                          |
    |     suffix=${BASE_STR:PO |
    | S:LEN}                   |
    |                          |
    |  #  Extract a 5-characte |
    | r string,                |
    |                          |
    |  #+ starting at position |
    |  11.                     |
    |                          |
    |     temp_filename=$prefi |
    | x.$suffix                |
    |                          |
    |  # Construct the filenam |
    | e.                       |
    |                          |
    |     echo "Temp filename  |
    | = "$temp_filename""      |
    |                          |
    |     # sh tempfile-name.s |
    | h                        |
    |     # Temp filename = te |
    | mp.e19ea                 |
    |                          |
    |     #  Compare this meth |
    | od of generating "unique |
    | " filenames              |
    |     #+ with the 'date' m |
    | ethod in ex51.sh.        |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **units**
    This utility converts between different *units of measure* . While
    normally invoked in interactive mode, **units** may find use in a
    script.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-63. Converting meters to miles**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # unit-conversion.sh |
    |     # Must have 'units'  |
    | utility installed.       |
    |                          |
    |                          |
    |     convert_units ()  #  |
    | Takes as arguments the u |
    | nits to convert.         |
    |     {                    |
    |       cf=$(units "$1" "$ |
    | 2" | sed --silent -e '1p |
    | ' | awk '{print $2}')    |
    |       # Strip off everyt |
    | hing except the actual c |
    | onversion factor.        |
    |       echo "$cf"         |
    |     }                    |
    |                          |
    |     Unit1=miles          |
    |     Unit2=meters         |
    |     cfactor=`convert_uni |
    | ts $Unit1 $Unit2`        |
    |     quantity=3.73        |
    |                          |
    |     result=$(echo $quant |
    | ity*$cfactor | bc)       |
    |                          |
    |     echo "There are $res |
    | ult $Unit2 in $quantity  |
    | $Unit1."                 |
    |                          |
    |     #  What happens if y |
    | ou pass incompatible uni |
    | ts,                      |
    |     #+ such as "acres" a |
    | nd "miles" to the functi |
    | on?                      |
    |                          |
    |     exit 0               |
    |                          |
    |     # Exercise: Edit thi |
    | s script to accept comma |
    | nd-line parameters,      |
    |     #           with app |
    | ropriate error checking, |
    |  of course.              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **m4**
    A hidden treasure, **m4** is a powerful macro ` [6]
     <extmisc.html#FTN.AEN14523>`__ processing filter, virtually a
    complete language. Although originally written as a pre-processor
    for *RatFor* , **m4** turned out to be useful as a stand-alone
    utility. In fact, **m4** combines some of the functionality of
    `eval <internal.html#EVALREF>`__ , `tr <textproc.html#TRREF>`__ ,
    and `awk <awk.html#AWKREF>`__ , in addition to its extensive macro
    expansion facilities.

    The April, 2002 issue of `*Linux
    Journal* <http://www.linuxjournal.com>`__ has a very nice article on
    **m4** and its uses.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-64. Using *m4***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # m4.sh: Using the m |
    | 4 macro processor        |
    |                          |
    |     # Strings            |
    |     string=abcdA01       |
    |     echo "len($string)"  |
    | | m4                     |
    |         #   7            |
    |     echo "substr($string |
    | ,4)" | m4                |
    |         # A01            |
    |     echo "regexp($string |
    | ,[0-1][0-1],\&Z)" | m4   |
    |     # 01Z                |
    |                          |
    |     # Arithmetic         |
    |     var=99               |
    |     echo "incr($var)" |  |
    | m4                       |
    |         #  100           |
    |     echo "eval($var / 3) |
    | " | m4                   |
    |         #   33           |
    |                          |
    |     exit                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **xmessage**
    This X-based variant of `echo <internal.html#ECHOREF>`__ pops up a
    message/query window on the desktop.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     xmessage Left click  |
    | to continue -button okay |
                              
    +--------------------------+--------------------------+--------------------------+

 **zenity**
    The `zenity <http://freshmeat.net/projects/zenity>`__ utility is
    adept at displaying *GTK+* dialog
    `widgets <assortedtips.html#WIDGETREF>`__ and `very suitable for
    scripting purposes <assortedtips.html#ZENITYREF2>`__ .

 **doexec**
    The **doexec** command enables passing an arbitrary list of
    arguments to a *binary executable* . In particular, passing
    ``                   argv[0]                 `` (which corresponds
    to `$0 <othertypesv.html#POSPARAMREF1>`__ in a script) lets the
    executable be invoked by various names, and it can then carry out
    different sets of actions, according to the name by which it was
    called. What this amounts to is roundabout way of passing options to
    an executable.

    For example, the ``         /usr/local/bin        `` directory might
    contain a binary called "aaa" . Invoking **doexec /usr/local/bin/aaa
    list** would *list* all those files in the current working directory
    beginning with an "a" , while invoking (the same executable with)
    **doexec /usr/local/bin/aaa delete** would *delete* those files.

    .. raw:: html

       <div class="NOTE">

    +--------------------------+--------------------------+--------------------------+
    | |Note|                   |
    | The various behaviors of |
    | the executable must be   |
    | defined within the code  |
    | of the executable        |
    | itself, analogous to     |
    | something like the       |
    | following in a shell     |
    | script:                  |
    |                          |
    | +----------------------- |
    | ---+-------------------- |
    | ------+----------------- |
    | ---------+               |
    | | .. code:: PROGRAMLISTI |
    | NG |                     |
    | |                        |
    |    |                     |
    | |     case `basename $0` |
    |  i |                     |
    | | n                      |
    |    |                     |
    | |     "name1" ) do_somet |
    | hi |                     |
    | | ng;;                   |
    |    |                     |
    | |     "name2" ) do_somet |
    | hi |                     |
    | | ng_else;;              |
    |    |                     |
    | |     "name3" ) do_yet_a |
    | no |                     |
    | | ther_thing;;           |
    |    |                     |
    | |     *       ) bail_out |
    | ;; |                     |
    | |     esac               |
    |    |                     |
    |                          |
    |                          |
    | +----------------------- |
    | ---+-------------------- |
    | ------+----------------- |
    | ---------+               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **dialog**
    The `dialog <assortedtips.html#DIALOGREF>`__ family of tools provide
    a method of calling interactive "dialog" boxes from a script. The
    more elaborate variations of **dialog** -- **gdialog** , **Xdialog**
    , and **kdialog** -- actually invoke X-Windows
    `widgets <assortedtips.html#WIDGETREF>`__ .

 **sox**
    The **sox** , or " **so** und e **x** change" command plays and
    performs transformations on sound files. In fact, the
    ``         /usr/bin/play        `` executable (now deprecated) is
    nothing but a shell wrapper for *sox* .

    For example, **sox soundfile.wav soundfile.au** changes a WAV sound
    file into a (Sun audio format) AU sound file.

    Shell scripts are ideally suited for batch-processing **sox**
    operations on sound files. For examples, see the `Linux Radio
    Timeshift HOWTO <http://osl.iu.edu/~tveldhui/radio/>`__ and the
    `MP3do Project <http://savannah.nongnu.org/projects/audiodo>`__ .

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

.. raw:: html

   <table border="0" class="FOOTNOTES" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [1]  <extmisc.html#AEN14105>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

This is actually a script adapted from the Debian Linux distribution.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [2]  <extmisc.html#AEN14214>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

The *print queue* is the group of jobs "waiting in line" to be printed.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [3]  <extmisc.html#AEN14218>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Large mechanical *line printers* printed a single line of type at a time
onto joined sheets of *greenbar* paper, to the accompaniment of `a great
deal of noise <http://www.columbia.edu/cu/computinghistory/1403.html>`__
. The hardcopy thusly printed was referred to as a *printout* .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [4]  <extmisc.html#AEN14280>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

For an excellent overview of this topic, see Andy Vaught's article,
`Introduction to Named
Pipes <http://www2.linuxjournal.com/lj-issues/issue41/2156.html>`__ , in
the September, 1997 issue of `*Linux
Journal* <http://www.linuxjournal.com>`__ .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [5]  <extmisc.html#AEN14318>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

 EBCDIC (pronounced "ebb-sid-ick" ) is an acronym for Extended Binary
Coded Decimal Interchange Code, an obsolete IBM data format. A bizarre
application of the ``        conv=ebcdic       `` option of **dd** is as
a quick 'n easy, but not very secure text file encoder.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     cat $file | dd conv= |
| swab,ebcdic > $file_encr |
| ypted                    |
|     # Encode (looks like |
|  gibberish).             |
|     # Might as well swit |
| ch bytes (swab), too, fo |
| r a little extra obscuri |
| ty.                      |
|                          |
|     cat $file_encrypted  |
| | dd conv=swab,ascii > $ |
| file_plaintext           |
|     # Decode.            |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [6]  <extmisc.html#AEN14523>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

A *macro* is a symbolic constant that expands into a command string or a
set of operations on parameters. Simply put, it's a shortcut or
abbreviation.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <mathc.html>`__    | Math Commands            |
| `Home <index.html>`__    | `Up <external.html>`__   |
| `Next <system.html>`__   | System and               |
|                          | Administrative Commands  |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Warning| image:: ../images/warning.gif
