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

`Prev <basic.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 16. External Filters, Programs and Commands

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <timedate.html>`__

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

  16.2. Complex Commands
=======================

.. raw:: html

   <div class="VARIABLELIST">

** Commands for more advanced users**

 **find**

    -exec ``                   COMMAND                 `` \\;

    Carries out ``                   COMMAND                 `` on each
    file that **find** matches. The command sequence terminates with ;
    (the ";" is `escaped <escapingsection.html#ESCP>`__ to make certain
    the shell passes it to **find** literally, without interpreting it
    as a special character).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ find ~/ -name  |
    | '*.txt'                  |
    |     /home/bozo/.kde/shar |
    | e/apps/karm/karmdata.txt |
    |      /home/bozo/misc/irm |
    | eyc.txt                  |
    |      /home/bozo/test-scr |
    | ipts/1.txt               |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    If ``                   COMMAND                 `` contains {} ,
    then **find** substitutes the full path name of the selected file
    for "{}" .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     find ~/ -name 'core* |
    | ' -exec rm {} \;         |
    |     # Removes all core d |
    | ump files from user's ho |
    | me directory.            |
                              
    +--------------------------+--------------------------+--------------------------+

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     find /home/bozo/proj |
    | ects -mtime -1           |
    |     #                    |
    |             ^   Note min |
    | us sign!                 |
    |     #  Lists all files i |
    | n /home/bozo/projects di |
    | rectory tree             |
    |     #+ that were modifie |
    | d within the last day (c |
    | urrent_day - 1).         |
    |     #                    |
    |     find /home/bozo/proj |
    | ects -mtime 1            |
    |     #  Same as above, bu |
    | t modified *exactly* one |
    |  day ago.                |
    |     #                    |
    |     #  mtime = last modi |
    | fication time of the tar |
    | get file                 |
    |     #  ctime = last stat |
    | us change time (via 'chm |
    | od' or otherwise)        |
    |     #  atime = last acce |
    | ss time                  |
    |                          |
    |     DIR=/home/bozo/junk_ |
    | files                    |
    |     find "$DIR" -type f  |
    | -atime +5 -exec rm {} \; |
    |     #                    |
    |        ^           ^^    |
    |     #  Curly brackets ar |
    | e placeholder for the pa |
    | th name output by "find. |
    | "                        |
    |     #                    |
    |     #  Deletes all files |
    |  in "/home/bozo/junk_fil |
    | es"                      |
    |     #+ that have not bee |
    | n accessed in *at least* |
    |  5 days (plus sign ... + |
    | 5).                      |
    |     #                    |
    |     #  "-type filetype", |
    |  where                   |
    |     #  f = regular file  |
    |     #  d = directory     |
    |     #  l = symbolic link |
    | , etc.                   |
    |     #                    |
    |     #  (The 'find' manpa |
    | ge and info page have co |
    | mplete option listings.) |
                              
    +--------------------------+--------------------------+--------------------------+

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     find /etc -exec grep |
    |  '[0-9][0-9]*[.][0-9][0- |
    | 9]*[.][0-9][0-9]*[.][0-9 |
    | ][0-9]*' {} \;           |
    |                          |
    |     # Finds all IP addre |
    | sses (xxx.xxx.xxx.xxx) i |
    | n /etc directory files.  |
    |     # There a few extran |
    | eous hits. Can they be f |
    | iltered out?             |
    |                          |
    |     # Possibly by:       |
    |                          |
    |     find /etc -type f -e |
    | xec cat '{}' \; | tr -c  |
    | '.[:digit:]' '\n' \      |
    |     | grep '^[^.][^.]*\. |
    | [^.][^.]*\.[^.][^.]*\.[^ |
    | .][^.]*$'                |
    |     #                    |
    |     #  [:digit:] is one  |
    | of the character classes |
    |     #+ introduced with t |
    | he POSIX 1003.2 standard |
    | .                        |
    |                          |
    |     # Thanks, StĂŠphane  |
    | Chazelas.                |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The                                  |
    | ``             -exec            ``   |
    | option to **find** should not be     |
    | confused with the                    |
    | `exec <internal.html#EXECREF>`__     |
    | shell builtin.                       |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-3. *Badname* , eliminate file names in current
    directory containing bad characters and
    `whitespace <special-chars.html#WHITESPACEREF>`__ .**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # badname.sh         |
    |     # Delete filenames i |
    | n current directory cont |
    | aining bad characters.   |
    |                          |
    |     for filename in *    |
    |     do                   |
    |       badname=`echo "$fi |
    | lename" | sed -n /[\+\{\ |
    | ;\"\\\=\?~\(\)\<\>\&\*\| |
    | \$]/p`                   |
    |     # badname=`echo "$fi |
    | lename" | sed -n '/[+{;" |
    | \=?~()<>&*|$]/p'`  also  |
    | works.                   |
    |     # Deletes files cont |
    | aining these nasties:    |
    |   + { ; " \ = ? ~ ( ) <  |
    | > & * | $                |
    |     #                    |
    |       rm $badname 2>/dev |
    | /null                    |
    |     #             ^^^^^^ |
    | ^^^^^ Error messages dee |
    | p-sixed.                 |
    |     done                 |
    |                          |
    |     # Now, take care of  |
    | files containing all man |
    | ner of whitespace.       |
    |     find . -name "* *" - |
    | exec rm -f {} \;         |
    |     # The path name of t |
    | he file that _find_ find |
    | s replaces the "{}".     |
    |     # The '\' ensures th |
    | at the ';' is interprete |
    | d literally, as end of c |
    | ommand.                  |
    |                          |
    |     exit 0               |
    |                          |
    |     #------------------- |
    | ------------------------ |
    | ------------------------ |
    | --                       |
    |     # Commands below thi |
    | s line will not execute  |
    | because of _exit_ comman |
    | d.                       |
    |                          |
    |     # An alternative to  |
    | the above script:        |
    |     find . -name '*[+{;" |
    | \\=?~()<>&*|$ ]*' -maxde |
    | pth 0 \                  |
    |     -exec rm -f '{}' \;  |
    |     #  The "-maxdepth 0" |
    |  option ensures that _fi |
    | nd_ will not search      |
    |     #+ subdirectories be |
    | low $PWD.                |
    |                          |
    |     # (Thanks, S.C.)     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-4. Deleting a file by its *inode* number**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # idelete.sh: Deleti |
    | ng a file by its inode n |
    | umber.                   |
    |                          |
    |     #  This is useful wh |
    | en a filename starts wit |
    | h an illegal character,  |
    |     #+ such as ? or -.   |
    |                          |
    |     ARGCOUNT=1           |
    |             # Filename a |
    | rg must be passed to scr |
    | ipt.                     |
    |     E_WRONGARGS=70       |
    |     E_FILE_NOT_EXIST=71  |
    |     E_CHANGED_MIND=72    |
    |                          |
    |     if [ $# -ne "$ARGCOU |
    | NT" ]                    |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` filename"       |
    |       exit $E_WRONGARGS  |
    |     fi                   |
    |                          |
    |     if [ ! -e "$1" ]     |
    |     then                 |
    |       echo "File \""$1"\ |
    | " does not exist."       |
    |       exit $E_FILE_NOT_E |
    | XIST                     |
    |     fi                   |
    |                          |
    |     inum=`ls -i | grep " |
    | $1" | awk '{print $1}'`  |
    |     # inum = inode (inde |
    | x node) number of file   |
    |     # ------------------ |
    | ------------------------ |
    | ------------------------ |
    | -----                    |
    |     # Every file has an  |
    | inode, a record that hol |
    | ds its physical address  |
    | info.                    |
    |     # ------------------ |
    | ------------------------ |
    | ------------------------ |
    | -----                    |
    |                          |
    |     echo; echo -n "Are y |
    | ou absolutely sure you w |
    | ant to delete \"$1\" (y/ |
    | n)? "                    |
    |     # The '-v' option to |
    |  'rm' also asks this.    |
    |     read answer          |
    |     case "$answer" in    |
    |     [nN]) echo "Changed  |
    | your mind, huh?"         |
    |           exit $E_CHANGE |
    | D_MIND                   |
    |           ;;             |
    |     *)    echo "Deleting |
    |  file \"$1\".";;         |
    |     esac                 |
    |                          |
    |     find . -inum $inum - |
    | exec rm {} \;            |
    |     #                    |
    |         ^^               |
    |     #        Curly brack |
    | ets are placeholder      |
    |     #+       for text ou |
    | tput by "find."          |
    |     echo "File "\"$1"\"  |
    | deleted!"                |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The **find** command also works without the
    ``         -exec        `` option.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     #  Find suid root fi |
    | les.                     |
    |     #  A strange suid fi |
    | le might indicate a secu |
    | rity hole,               |
    |     #+ or even a system  |
    | intrusion.               |
    |                          |
    |     directory="/usr/sbin |
    | "                        |
    |     # Might also try /sb |
    | in, /bin, /usr/bin, /usr |
    | /local/bin, etc.         |
    |     permissions="+4000"  |
    |  # suid root (dangerous! |
    | )                        |
    |                          |
    |                          |
    |     for file in $( find  |
    | "$directory" -perm "$per |
    | missions" )              |
    |     do                   |
    |       ls -ltF --author " |
    | $file"                   |
    |     done                 |
                              
    +--------------------------+--------------------------+--------------------------+

    See `Example 16-30 <filearchiv.html#EX48>`__ , `Example
    3-4 <special-chars.html#EX58>`__ , and `Example
    11-10 <loops1.html#FINDSTRING>`__ for scripts using **find** . Its
    `manpage <basic.html#MANREF>`__ provides more detail on this complex
    and powerful command.

 **xargs**
    A filter for feeding arguments to a command, and also a tool for
    assembling the commands themselves. It breaks a data stream into
    small enough chunks for filters and commands to process. Consider it
    as a powerful replacement for
    `backquotes <commandsub.html#BACKQUOTESREF>`__ . In situations where
    `command substitution <commandsub.html#COMMANDSUBREF>`__ fails with
    a too many arguments error, substituting **xargs** often works. `
    [1]  <moreadv.html#FTN.AEN10465>`__ Normally, **xargs** reads from
    ``         stdin        `` or from a pipe, but it can also be given
    the output of a file.

    The default command for **xargs** is
    `echo <internal.html#ECHOREF>`__ . This means that input piped to
    **xargs** may have linefeeds and other whitespace characters
    stripped out.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ls -l          |
    |     total 0              |
    |      -rw-rw-r--    1 boz |
    | o  bozo         0 Jan 29 |
    |  23:58 file1             |
    |      -rw-rw-r--    1 boz |
    | o  bozo         0 Jan 29 |
    |  23:58 file2             |
    |                          |
    |                          |
    |                          |
    |     bash$ ls -l | xargs  |
    |     total 0 -rw-rw-r-- 1 |
    |  bozo bozo 0 Jan 29 23:5 |
    | 8 file1 -rw-rw-r-- 1 boz |
    | o bozo 0 Jan...          |
    |                          |
    |                          |
    |                          |
    |     bash$ find ~/mail -t |
    | ype f | xargs grep "Linu |
    | x"                       |
    |     ./misc:User-Agent: s |
    | lrn/0.9.8.1 (Linux)      |
    |      ./sent-mail-jul-200 |
    | 5: hosted by the Linux D |
    | ocumentation Project.    |
    |      ./sent-mail-jul-200 |
    | 5: (Linux Documentation  |
    | Project Site, rtf versio |
    | n)                       |
    |      ./sent-mail-jul-200 |
    | 5: Subject: Criticism of |
    |  Bozo's Windows/Linux ar |
    | ticle                    |
    |      ./sent-mail-jul-200 |
    | 5: while mentioning that |
    |  the Linux ext2/ext3 fil |
    | esystem                  |
    |      . . .               |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    ``                   ls | xargs -p -l gzip                 ``
    `gzips <filearchiv.html#GZIPREF>`__ every file in current directory,
    one at a time, prompting before each operation.

    .. raw:: html

       <div class="NOTE">

    +--------------------+--------------------+--------------------+--------------------+
    | |Note|             |
    | Note that *xargs*  |
    | processes the      |
    | arguments passed   |
    | to it              |
    | sequentially, *one |
    | at a time* .       |
    |                    |
    | +----------------- |
    | ---------+-------- |
    | ------------------ |
    | +----------------- |
    | ---------+         |
    | | .. code:: SCREEN |
    |          |         |
    | |                  |
    |          |         |
    | |     bash$ find / |
    | usr/bin  |         |
    | | | xargs file     |
    |          |         |
    | |     /usr/bin:    |
    |        d |         |
    | | irectory         |
    |          |         |
    | |      /usr/bin/fo |
    | omatic-p |         |
    | | pd-options:      |
    |      per |         |
    | | l script text ex |
    | ecutable |         |
    | |      . . .       |
    |          |         |
    | |                  |
    |          |         |
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

    .. raw:: html

       <div class="TIP">

    +--------------------------+--------------------------+--------------------------+
    | |Tip|                    |
    | An interesting *xargs*   |
    | option is                |
    | ``             -n        |
    |                          |
    |            NN            |
    |                 ``       |
    | , which limits to        |
    | ``                       |
    |      NN                  |
    |         ``               |
    | the number of arguments  |
    | passed.                  |
    |                          |
    | ``                       |
    |      ls | xargs -n 8 ech |
    | o                        |
    |   ``                     |
    | lists the files in the   |
    | current directory in     |
    | ``             8         |
    |     ``                   |
    | columns.                 |
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="TIP">

    +------------+------------+------------+------------+------------+------------+------------+
    | |Tip|      |
    | Another    |
    | useful     |
    | option is  |
    | ``         |
    |      -0    |
    |          ` |
    | `          |
    | , in       |
    | combinatio |
    | n          |
    | with       |
    | ``         |
    |            |
    |          f |
    | ind        |
    |     -print |
    | 0          |
    |            |
    |       ``   |
    | or         |
    | ``         |
    |            |
    |          g |
    | rep -lZ    |
    |            |
    |            |
    |   ``       |
    | . This     |
    | allows     |
    | handling   |
    | arguments  |
    | containing |
    | whitespace |
    | or quotes. |
    |            |
    | ``         |
    |            |
    |          f |
    | ind / -typ |
    | e f -print |
    | 0 | xargs  |
    | -0 grep -l |
    | iwZ GUI |  |
    | xargs -0 r |
    | m -f       |
    |            |
    |          ` |
    | `          |
    |            |
    | ``         |
    |            |
    |          g |
    | rep -rliwZ |
    |  GUI / | x |
    | args -0 rm |
    |  -f        |
    |            |
    |         `` |
    |            |
    | Either of  |
    | the above  |
    | will       |
    | remove any |
    | file       |
    | containing |
    | "GUI" .    |
    | *(Thanks,  |
    | S.C.)*     |
    |            |
    | Or:        |
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
    | : PROGRAML |
    | ISTING |   |
    | |          |
    |            |
    |        |   |
    | |     cat  |
    | /proc/"$pi |
    | d"/"$O |   |
    | | PTION" | |
    |  xargs -0  |
    | echo   |   |
    | |     #  F |
    | ormats out |
    | put:   |   |
    | |        ^ |
    | ^^^^^^^^^^ |
    | ^^^^   |   |
    | |     #  F |
    | rom Han Ho |
    | ll's f |   |
    | | ixup of  |
    | "get-comma |
    | ndline |   |
    | | .sh"     |
    |            |
    |        |   |
    | |     #+ s |
    | cript in " |
    | /dev a |   |
    | | nd /proc |
    | " chapter. |
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
                
    +------------+------------+------------+------------+------------+------------+------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="TIP">

    +----------------+----------------+----------------+----------------+----------------+
    | |Tip|          |
    |                |
    | The            |
    | ``             |
    |  -P            |
    |  ``            |
    | option to      |
    | *xargs*        |
    | permits        |
    | running        |
    | processes in   |
    | parallel. This |
    | speeds up      |
    | execution in a |
    | machine with a |
    | multicore CPU. |
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
    | |     #!/bin/b |
    | ash          | |
    | |              |
    |              | |
    | |     ls *gif  |
    | | xargs -t - | |
    | | n1 -P2 gif2p |
    | ng           | |
    | |     # Conver |
    | ts all the g | |
    | | if images in |
    |  current dir | |
    | | ectory to pn |
    | g.           | |
    | |              |
    |              | |
    | |     # Option |
    | s:           | |
    | |     # ====== |
    | =            | |
    | |     # -t     |
    | Print comman | |
    | | d to stderr. |
    |              | |
    | |     # -n1    |
    | At most 1 ar | |
    | | gument per c |
    | ommand line. | |
    | |     # -P2    |
    | Run up to 2  | |
    | | processes si |
    | multaneously | |
    | | .            |
    |              | |
    | |              |
    |              | |
    | |     # Thank  |
    | you, Roberto | |
    | |  Polli, for  |
    | the inspirat | |
    | | ion.         |
    |              | |
    |                |
    |                |
    | +------------- |
    | -------------+ |
    | -------------- |
    | ------------+- |
    | -------------- |
    | -----------+   |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-5. Logfile: Using *xargs* to monitor system log**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     # Generates a log fi |
    | le in current directory  |
    |     # from the tail end  |
    | of /var/log/messages.    |
    |                          |
    |     # Note: /var/log/mes |
    | sages must be world read |
    | able                     |
    |     # if this script inv |
    | oked by an ordinary user |
    | .                        |
    |     #         #root chmo |
    | d 644 /var/log/messages  |
    |                          |
    |     LINES=5              |
    |                          |
    |     ( date; uname -a ) > |
    | >logfile                 |
    |     # Time and machine n |
    | ame                      |
    |     echo --------------- |
    | ------------------------ |
    | ------------------- >>lo |
    | gfile                    |
    |     tail -n $LINES /var/ |
    | log/messages | xargs | f |
    | mt -s >>logfile          |
    |     echo >>logfile       |
    |     echo >>logfile       |
    |                          |
    |     exit 0               |
    |                          |
    |     #  Note:             |
    |     #  ----              |
    |     #  As Frank Wang poi |
    | nts out,                 |
    |     #+ unmatched quotes  |
    | (either single or double |
    |  quotes) in the source f |
    | ile                      |
    |     #+ may give xargs in |
    | digestion.               |
    |     #                    |
    |     #  He suggests the f |
    | ollowing substitution fo |
    | r line 15:               |
    |     #  tail -n $LINES /v |
    | ar/log/messages | tr -d  |
    | "\"'" | xargs | fmt -s > |
    | >logfile                 |
    |                          |
    |                          |
    |                          |
    |     #  Exercise:         |
    |     #  --------          |
    |     #  Modify this scrip |
    | t to track changes in /v |
    | ar/log/messages at inter |
    | vals                     |
    |     #+ of 20 minutes.    |
    |     #  Hint: Use the "wa |
    | tch" command.            |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    `As in **find** <moreadv.html#CURLYBRACKETSREF>`__ , a curly bracket
    pair serves as a placeholder for replacement text.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-6. Copying files in current directory to another**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # copydir.sh         |
    |                          |
    |     #  Copy (verbose) al |
    | l files in current direc |
    | tory ($PWD)              |
    |     #+ to directory spec |
    | ified on command-line.   |
    |                          |
    |     E_NOARGS=85          |
    |                          |
    |     if [ -z "$1" ]   # E |
    | xit if no argument given |
    | .                        |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` directory-to-co |
    | py-to"                   |
    |       exit $E_NOARGS     |
    |     fi                   |
    |                          |
    |     ls . | xargs -i -t c |
    | p ./{} $1                |
    |     #            ^^ ^^   |
    |     ^^                   |
    |     #  -t is "verbose" ( |
    | output command-line to s |
    | tderr) option.           |
    |     #  -i is "replace st |
    | rings" option.           |
    |     #  {} is a placehold |
    | er for output text.      |
    |     #  This is similar t |
    | o the use of a curly-bra |
    | cket pair in "find."     |
    |     #                    |
    |     #  List the files in |
    |  current directory (ls . |
    | ),                       |
    |     #+ pass the output o |
    | f "ls" as arguments to " |
    | xargs" (-i -t options),  |
    |     #+ then copy (cp) th |
    | ese arguments ({}) to ne |
    | w directory ($1).        |
    |     #                    |
    |     #  The net result is |
    |  the exact equivalent of |
    |     #+   cp * $1         |
    |     #+ unless any of the |
    |  filenames has embedded  |
    | "whitespace" characters. |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-7. Killing processes by name**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # kill-byname.sh: Ki |
    | lling processes by name. |
    |     # Compare this scrip |
    | t with kill-process.sh.  |
    |                          |
    |     #  For instance,     |
    |     #+ try "./kill-bynam |
    | e.sh xterm" --           |
    |     #+ and watch all the |
    |  xterms on your desktop  |
    | disappear.               |
    |                          |
    |     #  Warning:          |
    |     #  -------           |
    |     #  This is a fairly  |
    | dangerous script.        |
    |     #  Running it carele |
    | ssly (especially as root |
    | )                        |
    |     #+ can cause data lo |
    | ss and other undesirable |
    |  effects.                |
    |                          |
    |     E_BADARGS=66         |
    |                          |
    |     if test -z "$1"  # N |
    | o command-line arg suppl |
    | ied?                     |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` Process(es)_to_ |
    | kill"                    |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |                          |
    |     PROCESS_NAME="$1"    |
    |     ps ax | grep "$PROCE |
    | SS_NAME" | awk '{print $ |
    | 1}' | xargs -i kill {} 2 |
    | &>/dev/null              |
    |     #                    |
    |                          |
    |             ^^      ^^   |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | ---------------------    |
    |     # Notes:             |
    |     # -i is the "replace |
    |  strings" option to xarg |
    | s.                       |
    |     # The curly brackets |
    |  are the placeholder for |
    |  the replacement.        |
    |     # 2&>/dev/null suppr |
    | esses unwanted error mes |
    | sages.                   |
    |     #                    |
    |     # Can  grep "$PROCES |
    | S_NAME" be replaced by p |
    | idof "$PROCESS_NAME"?    |
    |     # ------------------ |
    | ------------------------ |
    | ---------------------    |
    |                          |
    |     exit $?              |
    |                          |
    |     #  The "killall" com |
    | mand has the same effect |
    |  as this script,         |
    |     #+ but using it is n |
    | ot quite as educational. |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-8. Word frequency analysis using *xargs***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # wf2.sh: Crude word |
    |  frequency analysis on a |
    |  text file.              |
    |                          |
    |     # Uses 'xargs' to de |
    | compose lines of text in |
    | to single words.         |
    |     # Compare this examp |
    | le to the "wf.sh" script |
    |  later on.               |
    |                          |
    |                          |
    |     # Check for input fi |
    | le on command-line.      |
    |     ARGS=1               |
    |     E_BADARGS=85         |
    |     E_NOFILE=86          |
    |                          |
    |     if [ $# -ne "$ARGS"  |
    | ]                        |
    |     # Correct number of  |
    | arguments passed to scri |
    | pt?                      |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` filename"       |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |     if [ ! -f "$1" ]     |
    |    # Does file exist?    |
    |     then                 |
    |       echo "File \"$1\"  |
    | does not exist."         |
    |       exit $E_NOFILE     |
    |     fi                   |
    |                          |
    |                          |
    |                          |
    |     #################### |
    | ######################## |
    | #########                |
    |     cat "$1" | xargs -n1 |
    |  | \                     |
    |     #  List the file, on |
    | e word per line.         |
    |     tr A-Z a-z | \       |
    |     #  Shift characters  |
    | to lowercase.            |
    |     sed -e 's/\.//g'  -e |
    |  's/\,//g' -e 's/ /\     |
    |     /g' | \              |
    |     #  Filter out period |
    | s and commas, and        |
    |     #+ change space betw |
    | een words to linefeed,   |
    |     sort | uniq -c | sor |
    | t -nr                    |
    |     #  Finally remove du |
    | plicates, prefix occurre |
    | nce count                |
    |     #+ and sort numerica |
    | lly.                     |
    |     #################### |
    | ######################## |
    | #########                |
    |                          |
    |     #  This does the sam |
    | e job as the "wf.sh" exa |
    | mple,                    |
    |     #+ but a bit more po |
    | nderously, and it runs m |
    | ore slowly (why?).       |
    |                          |
    |     exit $?              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 ``                 expr               ``
    All-purpose expression evaluator: Concatenates and evaluates the
    arguments according to the operation given (arguments must be
    separated by spaces). Operations may be arithmetic, comparison,
    string, or logical.

    .. raw:: html

       <div class="VARIABLELIST">

     ``                       expr 3 + 5                     ``
        returns ``            8           ``

     ``                       expr 5 % 3                     ``
        returns 2

     ``                       expr 1 / 0                     ``
        returns the error message, expr: division by zero

        Illegal arithmetic operations not allowed.

     ``                       expr 5 \* 3                     ``
        returns 15

        The multiplication operator must be escaped when used in an
        arithmetic expression with **expr** .

     ``                       y=`expr $y + 1`                     ``
        Increment a variable, with the same effect as
        ``                         let y=y+1                       ``
        and
        ``                         y=$(($y+1))                       ``
        . This is an example of `arithmetic
        expansion <arithexp.html#ARITHEXPREF>`__ .


    ``                       z=`expr substr         $string $position $length`                     ``
        Extract substring of $length characters, starting at $position.

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-9. Using *expr***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     # Demonstrating some |
    |  of the uses of 'expr'   |
    |     # ================== |
    | =====================    |
    |                          |
    |     echo                 |
    |                          |
    |     # Arithmetic Operato |
    | rs                       |
    |     # ---------- ------- |
    | --                       |
    |                          |
    |     echo "Arithmetic Ope |
    | rators"                  |
    |     echo                 |
    |     a=`expr 5 + 3`       |
    |     echo "5 + 3 = $a"    |
    |                          |
    |     a=`expr $a + 1`      |
    |     echo                 |
    |     echo "a + 1 = $a"    |
    |     echo "(incrementing  |
    | a variable)"             |
    |                          |
    |     a=`expr 5 % 3`       |
    |     # modulo             |
    |     echo                 |
    |     echo "5 mod 3 = $a"  |
    |                          |
    |     echo                 |
    |     echo                 |
    |                          |
    |     # Logical Operators  |
    |     # ------- ---------  |
    |                          |
    |     #  Returns 1 if true |
    | , 0 if false,            |
    |     #+ opposite of norma |
    | l Bash convention.       |
    |                          |
    |     echo "Logical Operat |
    | ors"                     |
    |     echo                 |
    |                          |
    |     x=24                 |
    |     y=25                 |
    |     b=`expr $x = $y`     |
    |      # Test equality.    |
    |     echo "b = $b"        |
    |      # 0  ( $x -ne $y )  |
    |     echo                 |
    |                          |
    |     a=3                  |
    |     b=`expr $a \> 10`    |
    |     echo 'b=`expr $a \>  |
    | 10`, therefore...'       |
    |     echo "If a > 10, b = |
    |  0 (false)"              |
    |     echo "b = $b"        |
    |      # 0  ( 3 ! -gt 10 ) |
    |     echo                 |
    |                          |
    |     b=`expr $a \< 10`    |
    |     echo "If a < 10, b = |
    |  1 (true)"               |
    |     echo "b = $b"        |
    |      # 1  ( 3 -lt 10 )   |
    |     echo                 |
    |     # Note escaping of o |
    | perators.                |
    |                          |
    |     b=`expr $a \<= 3`    |
    |     echo "If a <= 3, b = |
    |  1 (true)"               |
    |     echo "b = $b"        |
    |      # 1  ( 3 -le 3 )    |
    |     # There is also a "\ |
    | >=" operator (greater th |
    | an or equal to).         |
    |                          |
    |                          |
    |     echo                 |
    |     echo                 |
    |                          |
    |                          |
    |                          |
    |     # String Operators   |
    |     # ------ ---------   |
    |                          |
    |     echo "String Operato |
    | rs"                      |
    |     echo                 |
    |                          |
    |     a=1234zipper43231    |
    |     echo "The string bei |
    | ng operated upon is \"$a |
    | \"."                     |
    |                          |
    |     # length: length of  |
    | string                   |
    |     b=`expr length $a`   |
    |     echo "Length of \"$a |
    | \" is $b."               |
    |                          |
    |     # index: position of |
    |  first character in subs |
    | tring                    |
    |     #        that matche |
    | s a character in string  |
    |     b=`expr index $a 23` |
    |     echo "Numerical posi |
    | tion of first \"2\" in \ |
    | "$a\" is \"$b\"."        |
    |                          |
    |     # substr: extract su |
    | bstring, starting positi |
    | on & length specified    |
    |     b=`expr substr $a 2  |
    | 6`                       |
    |     echo "Substring of \ |
    | "$a\", starting at posit |
    | ion 2,\                  |
    |     and 6 chars long is  |
    | \"$b\"."                 |
    |                          |
    |                          |
    |     #  The default behav |
    | ior of the 'match' opera |
    | tions is to              |
    |     #+ search for the sp |
    | ecified match at the BEG |
    | INNING of the string.    |
    |     #                    |
    |     #       Using Regula |
    | r Expressions ...        |
    |     b=`expr match "$a" ' |
    | [0-9]*'`               # |
    |   Numerical count.       |
    |     echo Number of digit |
    | s at the beginning of \" |
    | $a\" is $b.              |
    |     b=`expr match "$a" ' |
    | \([0-9]*\)'`           # |
    |   Note that escaped pare |
    | ntheses                  |
    |     #                    |
    | ==      ==             # |
    | + trigger substring matc |
    | h.                       |
    |     echo "The digits at  |
    | the beginning of \"$a\"  |
    | are \"$b\"."             |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="IMPORTANT">

    +--------------------+--------------------+--------------------+--------------------+
    | |Important|        |
    | The `: ( *null*    |
    | ) <special-chars.h |
    | tml#NULLREF>`__    |
    | operator can       |
    | substitute for     |
    | **match** . For    |
    | example,           |
    | ``                 |
    |            b=`expr |
    |  $a : [0-9]*`      |
    |                    |
    |   ``               |
    | is the exact       |
    | equivalent of      |
    | ``                 |
    |            b=`expr |
    |  match $a          |
    |   [0-9]*`          |
    |                 `` |
    | in the above       |
    | listing.           |
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
    | |     #!/bin/bash  |
    |          |         |
    | |                  |
    |          |         |
    | |     echo         |
    |          |         |
    | |     echo "String |
    |  operati |         |
    | | ons using \"expr |
    |  \$strin |         |
    | | g : \" construct |
    | "        |         |
    | |     echo "====== |
    | ======== |         |
    | | ================ |
    | ======== |         |
    | | ============="   |
    |          |         |
    | |     echo         |
    |          |         |
    | |                  |
    |          |         |
    | |     a=1234zipper |
    | 5FLIPPER |         |
    | | 43231            |
    |          |         |
    | |                  |
    |          |         |
    | |     echo "The st |
    | ring bei |         |
    | | ng operated upon |
    |  is \"`e |         |
    | | xpr "$a" : '\(.* |
    | \)'`\"." |         |
    | |     #     Escape |
    | d parent |         |
    | | heses grouping o |
    | perator. |         |
    | |             ==   |
    | ==       |         |
    | |                  |
    |          |         |
    | |     #       **** |
    | ******** |         |
    | | ***************  |
    |          |         |
    | |     #+           |
    | Escaped  |         |
    | | parentheses      |
    |          |         |
    | |     #+           |
    |  match a |         |
    | |  substring       |
    |          |         |
    | |     #       **** |
    | ******** |         |
    | | ***************  |
    |          |         |
    | |                  |
    |          |         |
    | |                  |
    |          |         |
    | |     #  If no esc |
    | aped par |         |
    | | entheses ...     |
    |          |         |
    | |     #+ then 'exp |
    | r' conve |         |
    | | rts the string o |
    | perand t |         |
    | | o an integer.    |
    |          |         |
    | |                  |
    |          |         |
    | |     echo "Length |
    |  of \"$a |         |
    | | \" is `expr "$a" |
    |  : '.*'` |         |
    | | ."   # Length of |
    |  string  |         |
    | |                  |
    |          |         |
    | |     echo "Number |
    |  of digi |         |
    | | ts at the beginn |
    | ing of \ |         |
    | | "$a\" is `expr " |
    | $a" : '[ |         |
    | | 0-9]*'`."        |
    |          |         |
    | |                  |
    |          |         |
    | |     # ---------- |
    | -------- |         |
    | | ---------------- |
    | -------- |         |
    | | ---------------- |
    | -------- |         |
    | | ------- #        |
    |          |         |
    | |                  |
    |          |         |
    | |     echo         |
    |          |         |
    | |                  |
    |          |         |
    | |     echo "The di |
    | gits at  |         |
    | | the beginning of |
    |  \"$a\"  |         |
    | | are `expr "$a" : |
    |  '\([0-9 |         |
    | | ]*\)'`."         |
    |          |         |
    | |     #            |
    |          |         |
    | |                  |
    |          |         |
    | |                  |
    |   ==     |         |
    | |   ==             |
    |          |         |
    | |     echo "The fi |
    | rst 7 ch |         |
    | | aracters of \"$a |
    | \" are ` |         |
    | | expr "$a" : '\(. |
    | ......\) |         |
    | | '`."             |
    |          |         |
    | |     #         == |
    | ===      |         |
    | |                  |
    |          |         |
    | |              ==  |
    |       == |         |
    | |     # Again, esc |
    | aped par |         |
    | | entheses force a |
    |  substri |         |
    | | ng match.        |
    |          |         |
    | |     #            |
    |          |         |
    | |     echo "The la |
    | st 7 cha |         |
    | | racters of \"$a\ |
    | " are `e |         |
    | | xpr "$a" : '.*\( |
    | .......\ |         |
    | | )'`."            |
    |          |         |
    | |     #         == |
    | ==       |         |
    | |             end  |
    | of strin |         |
    | | g operator  ^^   |
    |          |         |
    | |     #  (In fact, |
    |  means s |         |
    | | kip over one or  |
    | more of  |         |
    | | any characters u |
    | ntil spe |         |
    | | cified           |
    |          |         |
    | |     #+  substrin |
    | g found. |         |
    | | )                |
    |          |         |
    | |                  |
    |          |         |
    | |     echo         |
    |          |         |
    | |                  |
    |          |         |
    | |     exit 0       |
    |          |         |
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

.. raw:: html

   </div>

The above script illustrates how **expr** uses the *escaped parentheses
-- \\( ... \\) --* grouping operator in tandem with `regular
expression <regexp.html#REGEXREF>`__ parsing to match a substring. Here
is a another example, this time from "real life."

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # Strip the whitespa |
| ce from the beginning an |
| d end.                   |
|     LRFDATE=`expr "$LRFD |
| ATE" : '[[:space:]]*\(.* |
| \)[[:space:]]*$'`        |
|                          |
|     #  From Peter Knowle |
| s' "booklistgen.sh" scri |
| pt                       |
|     #+ for converting fi |
| les to Sony Librie/PRS-5 |
| 0X format.               |
|     #  (http://booklistg |
| ensh.peterknowles.com)   |
                          
+--------------------------+--------------------------+--------------------------+

`Perl <wrapper.html#PERLREF>`__ , `sed <sedawk.html#SEDREF>`__ , and
`awk <awk.html#AWKREF>`__ have far superior string parsing facilities. A
short **sed** or **awk** "subroutine" within a script (see `Section
36.2 <wrapper.html>`__ ) is an attractive alternative to **expr** .

See `Section 10.1 <string-manipulation.html>`__ for more on using
**expr** in string operations.

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <moreadv.html#AEN10465>`__    |
| And even when *xargs* is not         |
| strictly necessary, it can speed up  |
| execution of a command involving     |
| `batch-processing <timedate.html#BAT |
| CHPROCREF>`__                        |
| of multiple files.                   |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <basic.html>`__    | Basic Commands           |
| `Home <index.html>`__    | `Up <external.html>`__   |
| `Next <timedate.html>`__ | Time / Date Commands     |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Tip| image:: ../images/tip.gif
.. |Important| image:: ../images/important.gif
