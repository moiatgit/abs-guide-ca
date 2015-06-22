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

`Prev <timedate.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 16. External Filters, Programs and Commands

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <filearchiv.html>`__

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

  16.4. Text Processing Commands
===============================

.. raw:: html

   <div class="VARIABLELIST">

** Commands affecting text and text files**

 **sort**
    File sort utility, often used as a filter in a pipe. This command
    sorts a *text stream* or file forwards or backwards, or according to
    various keys or character positions. Using the
    ``         -m        `` option, it merges presorted input files. The
    *info page* lists its many capabilities and options. See `Example
    11-10 <loops1.html#FINDSTRING>`__ , `Example
    11-11 <loops1.html#SYMLINKS>`__ , and `Example
    A-8 <contributed-scripts.html#MAKEDICT>`__ .

 **tsort**
    *Topological sort* , reading in pairs of whitespace-separated
    strings and sorting according to input patterns. The original
    purpose of **tsort** was to sort a list of dependencies for an
    obsolete version of the *ld* linker in an "ancient" version of UNIX.

    The results of a *tsort* will usually differ markedly from those of
    the standard **sort** command, above.

 **uniq**
    This filter removes duplicate lines from a sorted file. It is often
    seen in a pipe coupled with `sort <textproc.html#SORTREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     cat list-1 list-2 li |
    | st-3 | sort | uniq > fin |
    | al.list                  |
    |     # Concatenates the l |
    | ist files,               |
    |     # sorts them,        |
    |     # removes duplicate  |
    | lines,                   |
    |     # and finally writes |
    |  the result to an output |
    |  file.                   |
                              
    +--------------------------+--------------------------+--------------------------+

    The useful ``         -c        `` option prefixes each line of the
    input file with its number of occurrences.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ cat testfile   |
    |     This line occurs onl |
    | y once.                  |
    |      This line occurs tw |
    | ice.                     |
    |      This line occurs tw |
    | ice.                     |
    |      This line occurs th |
    | ree times.               |
    |      This line occurs th |
    | ree times.               |
    |      This line occurs th |
    | ree times.               |
    |                          |
    |                          |
    |     bash$ uniq -c testfi |
    | le                       |
    |           1 This line oc |
    | curs only once.          |
    |            2 This line o |
    | ccurs twice.             |
    |            3 This line o |
    | ccurs three times.       |
    |                          |
    |                          |
    |     bash$ sort testfile  |
    | | uniq -c | sort -nr     |
    |           3 This line oc |
    | curs three times.        |
    |            2 This line o |
    | ccurs twice.             |
    |            1 This line o |
    | ccurs only once.         |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    The
    ``                   sort INPUTFILE | uniq -c | sort -nr                 ``
    command string produces a *frequency of occurrence* listing on the
    ``         INPUTFILE        `` file (the ``         -nr        ``
    options to **sort** cause a reverse numerical sort). This template
    finds use in analysis of log files and dictionary lists, and
    wherever the lexical structure of a document needs to be examined.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-12. Word Frequency Analysis**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # wf.sh: Crude word  |
    | frequency analysis on a  |
    | text file.               |
    |     # This is a more eff |
    | icient version of the "w |
    | f2.sh" script.           |
    |                          |
    |                          |
    |     # Check for input fi |
    | le on command-line.      |
    |     ARGS=1               |
    |     E_BADARGS=85         |
    |     E_NOFILE=86          |
    |                          |
    |     if [ $# -ne "$ARGS"  |
    | ]  # Correct number of a |
    | rguments passed to scrip |
    | t?                       |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` filename"       |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |     if [ ! -f "$1" ]     |
    |    # Check if file exist |
    | s.                       |
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
    | ############             |
    |     # main ()            |
    |     sed -e 's/\.//g'  -e |
    |  's/\,//g' -e 's/ /\     |
    |     /g' "$1" | tr 'A-Z'  |
    | 'a-z' | sort | uniq -c | |
    |  sort -nr                |
    |     #                    |
    |         ================ |
    | =========                |
    |     #                    |
    |          Frequency of oc |
    | currence                 |
    |                          |
    |     #  Filter out period |
    | s and commas, and        |
    |     #+ change space betw |
    | een words to linefeed,   |
    |     #+ then shift charac |
    | ters to lowercase, and   |
    |     #+ finally prefix oc |
    | currence count and sort  |
    | numerically.             |
    |                          |
    |     #  Arun Giridhar sug |
    | gests modifying the abov |
    | e to:                    |
    |     #  . . . | sort | un |
    | iq -c | sort +1 [-f] | s |
    | ort +0 -nr               |
    |     #  This adds a secon |
    | dary sort key, so instan |
    | ces of                   |
    |     #+ equal occurrence  |
    | are sorted alphabeticall |
    | y.                       |
    |     #  As he explains it |
    | :                        |
    |     #  "This is effectiv |
    | ely a radix sort, first  |
    | on the                   |
    |     #+ least significant |
    |  column                  |
    |     #+ (word or string,  |
    | optionally case-insensit |
    | ive)                     |
    |     #+ and last on the m |
    | ost significant column ( |
    | frequency)."             |
    |     #                    |
    |     #  As Frank Wang exp |
    | lains, the above is equi |
    | valent to                |
    |     #+       . . . | sor |
    | t | uniq -c | sort +0 -n |
    | r                        |
    |     #+ and the following |
    |  also works:             |
    |     #+       . . . | sor |
    | t | uniq -c | sort -k1nr |
    |  -k                      |
    |     #################### |
    | ######################## |
    | ############             |
    |                          |
    |     exit 0               |
    |                          |
    |     # Exercises:         |
    |     # ---------          |
    |     # 1) Add 'sed' comma |
    | nds to filter out other  |
    | punctuation,             |
    |     #+   such as semicol |
    | ons.                     |
    |     # 2) Modify the scri |
    | pt to also filter out mu |
    | ltiple spaces and        |
    |     #+   other whitespac |
    | e.                       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ cat testfile   |
    |     This line occurs onl |
    | y once.                  |
    |      This line occurs tw |
    | ice.                     |
    |      This line occurs tw |
    | ice.                     |
    |      This line occurs th |
    | ree times.               |
    |      This line occurs th |
    | ree times.               |
    |      This line occurs th |
    | ree times.               |
    |                          |
    |                          |
    |     bash$ ./wf.sh testfi |
    | le                       |
    |           6 this         |
    |            6 occurs      |
    |            6 line        |
    |            3 times       |
    |            3 three       |
    |            2 twice       |
    |            1 only        |
    |            1 once        |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **expand** , **unexpand**
    The **expand** filter converts tabs to spaces. It is often used in a
    `pipe <special-chars.html#PIPEREF>`__ .

    The **unexpand** filter converts spaces to tabs. This reverses the
    effect of **expand** .

 **cut**
    A tool for extracting `fields <special-chars.html#FIELDREF>`__ from
    files. It is similar to the
    ``                   print $N                 `` command set in
    `awk <awk.html#AWKREF>`__ , but more limited. It may be simpler to
    use *cut* in a script than *awk* . Particularly important are the
    ``         -d        `` (delimiter) and ``         -f        ``
    (field specifier) options.

    Using **cut** to obtain a listing of the mounted filesystems:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     cut -d ' ' -f1,2 /et |
    | c/mtab                   |
                              
    +--------------------------+--------------------------+--------------------------+

    Using **cut** to list the OS and kernel version:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     uname -a | cut -d" " |
    |  -f1,3,11,12             |
                              
    +--------------------------+--------------------------+--------------------------+

    Using **cut** to extract message headers from an e-mail folder:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ grep '^Subject |
    | :' read-messages | cut - |
    | c10-80                   |
    |     Re: Linux suitable f |
    | or mission-critical apps |
    | ?                        |
    |      MAKE MILLIONS WORKI |
    | NG AT HOME!!!            |
    |      Spam complaint      |
    |      Re: Spam complaint  |
                              
    +--------------------------+--------------------------+--------------------------+

    Using **cut** to parse a file:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # List all the users |
    |  in /etc/passwd.         |
    |                          |
    |     FILENAME=/etc/passwd |
    |                          |
    |     for user in $(cut -d |
    | : -f1 $FILENAME)         |
    |     do                   |
    |       echo $user         |
    |     done                 |
    |                          |
    |     # Thanks, Oleg Philo |
    | n for suggesting this.   |
                              
    +--------------------------+--------------------------+--------------------------+

    ``                   cut -d ' ' -f2,3 filename                 `` is
    equivalent to
    ``                   awk -F'[ ]' '{ print $2, $3 }' filename                 ``

    .. raw:: html

       <div class="NOTE">

    +----------------+----------------+----------------+----------------+----------------+
    | |Note|         |
    | It is even     |
    | possible to    |
    | specify a      |
    | linefeed as a  |
    | delimiter. The |
    | trick is to    |
    | actually embed |
    | a linefeed (   |
    | **RETURN** )   |
    | in the command |
    | sequence.      |
    |                |
    | +------------- |
    | -------------+ |
    | -------------- |
    | ------------+- |
    | -------------- |
    | -----------+   |
    | | .. code:: SC |
    | REEN         | |
    | |              |
    |              | |
    | |     bash$ cu |
    | t -d'        | |
    | |      ' -f3,7 |
    | ,19 testfile | |
    | |     This is  |
    | line 3 of te | |
    | | stfile.      |
    |              | |
    | |      This is |
    |  line 7 of t | |
    | | estfile.     |
    |              | |
    | |      This is |
    |  line 19 of  | |
    | | testfile.    |
    |              | |
    | |              |
    |              | |
    |                |
    |                |
    | +------------- |
    | -------------+ |
    | -------------- |
    | ------------+- |
    | -------------- |
    | -----------+   |
    |                |
    | Thank you,     |
    | Jaka Kranjc,   |
    | for pointing   |
    | this out.      |
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

    See also `Example 16-48 <mathc.html#BASE>`__ .

 **paste**
    Tool for merging together different files into a single,
    multi-column file. In combination with
    `cut <textproc.html#CUTREF>`__ , useful for creating system log
    files.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ cat items      |
    |     alphabet blocks      |
    |      building blocks     |
    |      cables              |
    |                          |
    |     bash$ cat prices     |
    |     $1.00/dozen          |
    |      $2.50 ea.           |
    |      $3.75               |
    |                          |
    |     bash$ paste items pr |
    | ices                     |
    |     alphabet blocks $1.0 |
    | 0/dozen                  |
    |      building blocks $2. |
    | 50 ea.                   |
    |      cables  $3.75       |
                              
    +--------------------------+--------------------------+--------------------------+

 **join**
    Consider this a special-purpose cousin of **paste** . This powerful
    utility allows merging two files in a meaningful fashion, which
    essentially creates a simple version of a relational database.

    The **join** command operates on exactly two files, but pastes
    together only those lines with a common tagged
    `field <special-chars.html#FIELDREF>`__ (usually a numerical label),
    and writes the result to ``         stdout        `` . The files to
    be joined should be sorted according to the tagged field for the
    matchups to work properly.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     File: 1.data         |
    |                          |
    |     100 Shoes            |
    |     200 Laces            |
    |     300 Socks            |
                              
    +--------------------------+--------------------------+--------------------------+

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     File: 2.data         |
    |                          |
    |     100 $40.00           |
    |     200 $1.00            |
    |     300 $2.00            |
                              
    +--------------------------+--------------------------+--------------------------+

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ join 1.data 2. |
    | data                     |
    |     File: 1.data 2.data  |
    |                          |
    |      100 Shoes $40.00    |
    |      200 Laces $1.00     |
    |      300 Socks $2.00     |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The tagged field appears only once   |
    | in the output.                       |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **head**
    lists the beginning of a file to ``         stdout        `` . The
    default is ``         10        `` lines, but a different number can
    be specified. The command has a number of interesting options.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-13. Which files are scripts?**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # script-detector.sh |
    | : Detects scripts within |
    |  a directory.            |
    |                          |
    |     TESTCHARS=2    # Tes |
    | t first 2 characters.    |
    |     SHABANG='#!'   # Scr |
    | ipts begin with a "sha-b |
    | ang."                    |
    |                          |
    |     for file in *  # Tra |
    | verse all the files in c |
    | urrent directory.        |
    |     do                   |
    |       if [[ `head -c$TES |
    | TCHARS "$file"` = "$SHAB |
    | ANG" ]]                  |
    |       #      head -c2    |
    |                    #!    |
    |       #  The '-c' option |
    |  to "head" outputs a spe |
    | cified                   |
    |       #+ number of chara |
    | cters, rather than lines |
    |  (the default).          |
    |       then               |
    |         echo "File \"$fi |
    | le\" is a script."       |
    |       else               |
    |         echo "File \"$fi |
    | le\" is *not* a script." |
    |       fi                 |
    |     done                 |
    |                          |
    |     exit 0               |
    |                          |
    |     #  Exercises:        |
    |     #  ---------         |
    |     #  1) Modify this sc |
    | ript to take as an optio |
    | nal argument             |
    |     #+    the directory  |
    | to scan for scripts      |
    |     #+    (rather than j |
    | ust the current working  |
    | directory).              |
    |     #                    |
    |     #  2) As it stands,  |
    | this script gives "false |
    |  positives" for          |
    |     #+    Perl, awk, and |
    |  other scripting languag |
    | e scripts.               |
    |     #     Correct this.  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-14. Generating 10-digit random numbers**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # rnd.sh: Outputs a  |
    | 10-digit random number   |
    |                          |
    |     # Script by Stephane |
    |  Chazelas.               |
    |                          |
    |     head -c4 /dev/urando |
    | m | od -N4 -tu4 | sed -n |
    | e '1s/.* //p'            |
    |                          |
    |                          |
    |     # ================== |
    | ======================== |
    | ======================== |
    | = #                      |
    |                          |
    |     # Analysis           |
    |     # --------           |
    |                          |
    |     # head:              |
    |     # -c4 option takes f |
    | irst 4 bytes.            |
    |                          |
    |     # od:                |
    |     # -N4 option limits  |
    | output to 4 bytes.       |
    |     # -tu4 option select |
    | s unsigned decimal forma |
    | t for output.            |
    |                          |
    |     # sed:               |
    |     # -n option, in comb |
    | ination with "p" flag to |
    |  the "s" command,        |
    |     # outputs only match |
    | ed lines.                |
    |                          |
    |                          |
    |                          |
    |     # The author of this |
    |  script explains the act |
    | ion of 'sed', as follows |
    | .                        |
    |                          |
    |     # head -c4 /dev/uran |
    | dom | od -N4 -tu4 | sed  |
    | -ne '1s/.* //p'          |
    |     # ------------------ |
    | ----------------> |      |
    |                          |
    |     # Assume output up t |
    | o "sed" --------> |      |
    |     # is 0000000 1198195 |
    | 154\n                    |
    |                          |
    |     #  sed begins readin |
    | g characters: 0000000 11 |
    | 98195154\n.              |
    |     #  Here it finds a n |
    | ewline character,        |
    |     #+ so it is ready to |
    |  process the first line  |
    | (0000000 1198195154).    |
    |     #  It looks at its < |
    | range><action>s. The fir |
    | st and only one is       |
    |                          |
    |     #   range     action |
    |     #   1         s/.* / |
    | /p                       |
    |                          |
    |     #  The line number i |
    | s in the range, so it ex |
    | ecutes the action:       |
    |     #+ tries to substitu |
    | te the longest string en |
    | ding with a space in the |
    |  line                    |
    |     #  ("0000000 ") with |
    |  nothing (//), and if it |
    |  succeeds, prints the re |
    | sult                     |
    |     #  ("p" is a flag to |
    |  the "s" command here, t |
    | his is different         |
    |     #+ from the "p" comm |
    | and).                    |
    |                          |
    |     #  sed is now ready  |
    | to continue reading its  |
    | input. (Note that before |
    |     #+ continuing, if -n |
    |  option had not been pas |
    | sed, sed would have prin |
    | ted                      |
    |     #+ the line once aga |
    | in).                     |
    |                          |
    |     #  Now, sed reads th |
    | e remainder of the chara |
    | cters, and finds the     |
    |     #+ end of the file.  |
    |     #  It is now ready t |
    | o process its 2nd line ( |
    | which is also numbered ' |
    | $' as                    |
    |     #+ it's the last one |
    | ).                       |
    |     #  It sees it is not |
    |  matched by any <range>, |
    |  so its job is done.     |
    |                          |
    |     #  In few word this  |
    | sed commmand means:      |
    |     #  "On the first lin |
    | e only, remove any chara |
    | cter up to the right-mos |
    | t space,                 |
    |     #+ then print it."   |
    |                          |
    |     # A better way to do |
    |  this would have been:   |
    |     #           sed -e ' |
    | s/.* //;q'               |
    |                          |
    |     # Here, two <range>< |
    | action>s (could have bee |
    | n written                |
    |     #           sed -e ' |
    | s/.* //' -e q):          |
    |                          |
    |     #   range            |
    |          action          |
    |     #   nothing (matches |
    |  line)   s/.* //         |
    |     #   nothing (matches |
    |  line)   q (quit)        |
    |                          |
    |     #  Here, sed only re |
    | ads its first line of in |
    | put.                     |
    |     #  It performs both  |
    | actions, and prints the  |
    | line (substituted) befor |
    | e                        |
    |     #+ quitting (because |
    |  of the "q" action) sinc |
    | e the "-n" option is not |
    |  passed.                 |
    |                          |
    |     # ================== |
    | ======================== |
    | ======================== |
    | = #                      |
    |                          |
    |     # An even simpler al |
    | tenative to the above on |
    | e-line script would be:  |
    |     #           head -c4 |
    |  /dev/urandom| od -An -t |
    | u4                       |
    |                          |
    |     exit                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example 16-39 <filearchiv.html#EX52>`__ .

 **tail**
    lists the (tail) end of a file to ``         stdout        `` . The
    default is ``         10        `` lines, but this can be changed
    with the ``         -n        `` option. Commonly used to keep track
    of changes to a system logfile, using the ``         -f        ``
    option, which outputs lines appended to the file.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-15. Using *tail* to monitor the system log**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     filename=sys.log     |
    |                          |
    |     cat /dev/null > $fil |
    | ename; echo "Creating /  |
    | cleaning out file."      |
    |     #  Creates the file  |
    | if it does not already e |
    | xist,                    |
    |     #+ and truncates it  |
    | to zero length if it doe |
    | s.                       |
    |     #  : > filename   an |
    | d   > filename also work |
    | .                        |
    |                          |
    |     tail /var/log/messag |
    | es > $filename           |
    |     # /var/log/messages  |
    | must have world read per |
    | mission for this to work |
    | .                        |
    |                          |
    |     echo "$filename cont |
    | ains tail end of system  |
    | log."                    |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="TIP">

    +--------------------+--------------------+--------------------+--------------------+
    | |Tip|              |
    | To list a specific |
    | line of a text     |
    | file,              |
    | `pipe <special-cha |
    | rs.html#PIPEREF>`_ |
    | _                  |
    | the output of      |
    | **head** to **tail |
    | -n 1** . For       |
    | example            |
    | ``                 |
    |            head -n |
    |  8 database.txt |  |
    | tail         -n 1  |
    |                    |
    |       ``           |
    | lists the 8th line |
    | of the file        |
    | ``             dat |
    | abase.txt          |
    |    ``              |
    | .                  |
    |                    |
    | To set a variable  |
    | to a given block   |
    | of a text file:    |
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
    | |     var=$(head - |
    | n $m $fi |         |
    | | lename | tail -n |
    |  $n)     |         |
    | |                  |
    |          |         |
    | |     # filename = |
    |  name of |         |
    | |  file            |
    |          |         |
    | |     # m = from b |
    | eginning |         |
    | |  of file, number |
    |  of line |         |
    | | s to end of bloc |
    | k        |         |
    | |     # n = number |
    |  of line |         |
    | | s to set variabl |
    | e to (tr |         |
    | | im from end of b |
    | lock)    |         |
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

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Newer implementations of **tail**    |
    | deprecate the older **tail -$LINES   |
    | filename** usage. The standard       |
    | **tail -n $LINES filename** is       |
    | correct.                             |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    See also `Example 16-5 <moreadv.html#EX41>`__ , `Example
    16-39 <filearchiv.html#EX52>`__ and `Example
    32-6 <debugging.html#ONLINE>`__ .

 **grep**
    A multi-purpose file search tool that uses `Regular
    Expressions <regexp.html#REGEXREF>`__ . It was originally a
    command/filter in the venerable **ed** line editor:
    ``                   g/re/p                 `` -- *global - regular
    expression - print* .

    **grep** ``                   pattern                 `` [
    ``                   file                 `` ...]

    Search the target file(s) for occurrences of
    ``                 pattern               `` , where
    ``                 pattern               `` may be literal text or a
    Regular Expression.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ grep '[rst]yst |
    | em.$' osinfo.txt         |
    |     The GPL governs the  |
    | distribution of the Linu |
    | x operating system.      |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    If no target file(s) specified, **grep** works as a filter on
    ``         stdout        `` , as in a
    `pipe <special-chars.html#PIPEREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ps ax | grep c |
    | lock                     |
    |     765 tty1     S       |
    | 0:00 xclock              |
    |      901 pts/1    S      |
    |  0:00 grep clock         |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    The ``         -i        `` option causes a case-insensitive search.

    The ``         -w        `` option matches only whole words.

    The ``         -l        `` option lists only the files in which
    matches were found, but not the matching lines.

    The ``         -r        `` (recursive) option searches files in the
    current working directory and all subdirectories below it.

    The ``         -n        `` option lists the matching lines,
    together with line numbers.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ grep -n Linux  |
    | osinfo.txt               |
    |     2:This is a file con |
    | taining information abou |
    | t Linux.                 |
    |      6:The GPL governs t |
    | he distribution of the L |
    | inux operating system.   |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    The ``         -v        `` (or ``         --invert-match        ``
    ) option *filters out* matches.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     grep pattern1 *.txt  |
    | | grep -v pattern2       |
    |                          |
    |     # Matches all lines  |
    | in "*.txt" files contain |
    | ing "pattern1",          |
    |     # but ***not*** "pat |
    | tern2".                  |
                              
    +--------------------------+--------------------------+--------------------------+

    The ``         -c        `` ( ``         --count        `` ) option
    gives a numerical count of matches, rather than actually listing the
    matches.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     grep -c txt *.sgml   |
    |  # (number of occurrence |
    | s of "txt" in "*.sgml" f |
    | iles)                    |
    |                          |
    |                          |
    |     #   grep -cz .       |
    |     #            ^ dot   |
    |     # means count (-c) z |
    | ero-separated (-z) items |
    |  matching "."            |
    |     # that is, non-empty |
    |  ones (containing at lea |
    | st 1 character).         |
    |     #                    |
    |     printf 'a b\nc  d\n\ |
    | n\n\n\n\000\n\000e\000\0 |
    | 00\nf' | grep -cz .      |
    | # 3                      |
    |     printf 'a b\nc  d\n\ |
    | n\n\n\n\000\n\000e\000\0 |
    | 00\nf' | grep -cz '$'    |
    | # 5                      |
    |     printf 'a b\nc  d\n\ |
    | n\n\n\n\000\n\000e\000\0 |
    | 00\nf' | grep -cz '^'    |
    | # 5                      |
    |     #                    |
    |     printf 'a b\nc  d\n\ |
    | n\n\n\n\000\n\000e\000\0 |
    | 00\nf' | grep -c '$'     |
    | # 9                      |
    |     # By default, newlin |
    | e chars (\n) separate it |
    | ems to match.            |
    |                          |
    |     # Note that the -z o |
    | ption is GNU "grep" spec |
    | ific.                    |
    |                          |
    |                          |
    |     # Thanks, S.C.       |
                              
    +--------------------------+--------------------------+--------------------------+

    The ``         --color        `` (or ``         --colour        `` )
    option marks the matching string in color (on the console or in an
    *xterm* window). Since *grep* prints out each entire line containing
    the matching pattern, this lets you see exactly *what* is being
    matched. See also the ``         -o        `` option, which shows
    only the matching portion of the line(s).

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-16. Printing out the *From* lines in stored e-mail
    messages**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # from.sh            |
    |                          |
    |     #  Emulates the usef |
    | ul 'from' utility in Sol |
    | aris, BSD, etc.          |
    |     #  Echoes the "From" |
    |  header line in all mess |
    | ages                     |
    |     #+ in your e-mail di |
    | rectory.                 |
    |                          |
    |                          |
    |     MAILDIR=~/mail/*     |
    |            #  No quoting |
    |  of variable. Why?       |
    |     # Maybe check if-exi |
    | sts $MAILDIR:   if [ -d  |
    | $MAILDIR ] . . .         |
    |     GREP_OPTS="-H -A 5 - |
    | -color"    #  Show file, |
    |  plus extra context line |
    | s                        |
    |                          |
    |            #+ and displa |
    | y "From" in color.       |
    |     TARGETSTR="^From"    |
    |            # "From" at b |
    | eginning of line.        |
    |                          |
    |     for file in $MAILDIR |
    |            #  No quoting |
    |  of variable.            |
    |     do                   |
    |       grep $GREP_OPTS "$ |
    | TARGETSTR" "$file"       |
    |       #    ^^^^^^^^^^    |
    |            #  Again, do  |
    | not quote this variable. |
    |       echo               |
    |     done                 |
    |                          |
    |     exit $?              |
    |                          |
    |     #  You might wish to |
    |  pipe the output of this |
    |  script to 'more'        |
    |     #+ or redirect it to |
    |  a file . . .            |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    When invoked with more than one target file given, **grep**
    specifies which file contains matches.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ grep Linux osi |
    | nfo.txt misc.txt         |
    |     osinfo.txt:This is a |
    |  file containing informa |
    | tion about Linux.        |
    |      osinfo.txt:The GPL  |
    | governs the distribution |
    |  of the Linux operating  |
    | system.                  |
    |      misc.txt:The Linux  |
    | operating system is stea |
    | dily gaining in populari |
    | ty.                      |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="TIP">

    +--------------------+--------------------+--------------------+--------------------+
    | |Tip|              |
    | To force **grep**  |
    | to show the        |
    | filename when      |
    | searching only one |
    | target file,       |
    | simply give        |
    | ``             /de |
    | v/null             |
    | ``                 |
    | as the second      |
    | file.              |
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
    | |     bash$ grep L |
    | inux osi |         |
    | | nfo.txt /dev/nul |
    | l        |         |
    | |     osinfo.txt:T |
    | his is a |         |
    | |  file containing |
    |  informa |         |
    | | tion about Linux |
    | .        |         |
    | |      osinfo.txt: |
    | The GPL  |         |
    | | governs the dist |
    | ribution |         |
    | |  of the Linux op |
    | erating  |         |
    | | system.          |
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

    If there is a successful match, **grep** returns an `exit
    status <exit-status.html#EXITSTATUSREF>`__ of 0, which makes it
    useful in a condition test in a script, especially in combination
    with the ``         -q        `` option to suppress output.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     SUCCESS=0            |
    |            # if grep loo |
    | kup succeeds             |
    |     word=Linux           |
    |     filename=data.file   |
    |                          |
    |     grep -q "$word" "$fi |
    | lename"    #  The "-q" o |
    | ption                    |
    |                          |
    |            #+ causes not |
    | hing to echo to stdout.  |
    |     if [ $? -eq $SUCCESS |
    |  ]                       |
    |     # if grep -q "$word" |
    |  "$filename"   can repla |
    | ce lines 5 - 7.          |
    |     then                 |
    |       echo "$word found  |
    | in $filename"            |
    |     else                 |
    |       echo "$word not fo |
    | und in $filename"        |
    |     fi                   |
                              
    +--------------------------+--------------------------+--------------------------+

    `Example 32-6 <debugging.html#ONLINE>`__ demonstrates how to use
    **grep** to search for a word pattern in a system logfile.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-17. Emulating *grep* in a script**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # grp.sh: Rudimentar |
    | y reimplementation of gr |
    | ep.                      |
    |                          |
    |     E_BADARGS=85         |
    |                          |
    |     if [ -z "$1" ]    #  |
    | Check for argument to sc |
    | ript.                    |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` pattern"        |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |     echo                 |
    |                          |
    |     for file in *     #  |
    | Traverse all files in $P |
    | WD.                      |
    |     do                   |
    |       output=$(sed -n /" |
    | $1"/p $file)  # Command  |
    | substitution.            |
    |                          |
    |       if [ ! -z "$output |
    | " ]           # What hap |
    | pens if "$output" is not |
    |  quoted?                 |
    |       then               |
    |         echo -n "$file:  |
    | "                        |
    |         echo "$output"   |
    |       fi              #  |
    |  sed -ne "/$1/s|^|${file |
    | }: |p"  is equivalent to |
    |  above.                  |
    |                          |
    |       echo               |
    |     done                 |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
    |                          |
    |     # Exercises:         |
    |     # ---------          |
    |     # 1) Add newlines to |
    |  output, if more than on |
    | e match in any given fil |
    | e.                       |
    |     # 2) Add features.   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    How can **grep** search for two (or more) separate patterns? What if
    you want **grep** to display all lines in a file or files that
    contain both "pattern1" *and* "pattern2" ?

    One method is to `pipe <special-chars.html#PIPEREF>`__ the result of
    **grep pattern1** to **grep pattern2** .

    For example, given the following file:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Filename: tstfile  |
    |                          |
    |     This is a sample fil |
    | e.                       |
    |     This is an ordinary  |
    | text file.               |
    |     This file does not c |
    | ontain any unusual text. |
    |     This file is not unu |
    | sual.                    |
    |     Here is some text.   |
                              
    +--------------------------+--------------------------+--------------------------+

    Now, let's search this file for lines containing *both* "file" and
    "text" . . .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ grep file tstf |
    | ile                      |
    |     # Filename: tstfile  |
    |      This is a sample fi |
    | le.                      |
    |      This is an ordinary |
    |  text file.              |
    |      This file does not  |
    | contain any unusual text |
    | .                        |
    |      This file is not un |
    | usual.                   |
    |                          |
    |     bash$ grep file tstf |
    | ile | grep text          |
    |     This is an ordinary  |
    | text file.               |
    |      This file does not  |
    | contain any unusual text |
    | .                        |
                              
    +--------------------------+--------------------------+--------------------------+

    Now, for an interesting recreational use of *grep* . . .

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-18. Crossword puzzle solver**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # cw-solver.sh       |
    |     # This is actually a |
    |  wrapper around a one-li |
    | ner (line 46).           |
    |                          |
    |     #  Crossword puzzle  |
    | and anagramming word gam |
    | e solver.                |
    |     #  You know *some* o |
    | f the letters in the wor |
    | d you're looking for,    |
    |     #+ so you need a lis |
    | t of all valid words     |
    |     #+ with the known le |
    | tters in given positions |
    | .                        |
    |     #  For example: w... |
    | i....n                   |
    |     #               1??? |
    | 5????10                  |
    |     # w in position 1, 3 |
    |  unknowns, i in the 5th, |
    |  4 unknowns, n at the en |
    | d.                       |
    |     # (See comments at e |
    | nd of script.)           |
    |                          |
    |                          |
    |     E_NOPATT=71          |
    |     DICT=/usr/share/dict |
    | /word.lst                |
    |     #                    |
    |  ^^^^^^^^   Looks for wo |
    | rd list here.            |
    |     #  ASCII word list,  |
    | one word per line.       |
    |     #  If you happen to  |
    | need an appropriate list |
    | ,                        |
    |     #+ download the auth |
    | or's "yawl" word list pa |
    | ckage.                   |
    |     #  http://ibiblio.or |
    | g/pub/Linux/libs/yawl-0. |
    | 3.2.tar.gz               |
    |     #  or                |
    |     #  http://bash.deta. |
    | in/yawl-0.3.2.tar.gz     |
    |                          |
    |                          |
    |     if [ -z "$1" ]   #   |
    | If no word pattern speci |
    | fied                     |
    |     then             #+  |
    | as a command-line argume |
    | nt . . .                 |
    |       echo           #+  |
    | . . . then . . .         |
    |       echo "Usage:"  #+  |
    | Usage message.           |
    |       echo               |
    |       echo ""$0" \"patte |
    | rn,\""                   |
    |       echo "where \"patt |
    | ern\" is in the form"    |
    |       echo "xxx..x.x..." |
    |       echo               |
    |       echo "The x's repr |
    | esent known letters,"    |
    |       echo "and the peri |
    | ods are unknown letters  |
    | (blanks)."               |
    |       echo "Letters and  |
    | periods can be in any po |
    | sition."                 |
    |       echo "For example, |
    |  try:   sh cw-solver.sh  |
    | w...i....n"              |
    |       echo               |
    |       exit $E_NOPATT     |
    |     fi                   |
    |                          |
    |     echo                 |
    |     # ================== |
    | ======================== |
    | =====                    |
    |     # This is where all  |
    | the work gets done.      |
    |     grep ^"$1"$ "$DICT"  |
    |   # Yes, only one line!  |
    |     #    |    |          |
    |     # ^ is start-of-word |
    |  regex anchor.           |
    |     # $ is end-of-word r |
    | egex anchor.             |
    |                          |
    |     #  From _Stupid Grep |
    |  Tricks_, vol. 1,        |
    |     #+ a book the ABS Gu |
    | ide author may yet get a |
    | round                    |
    |     #+ to writing . . .  |
    | one of these days . . .  |
    |     # ================== |
    | ======================== |
    | =====                    |
    |     echo                 |
    |                          |
    |                          |
    |     exit $?  # Script te |
    | rminates here.           |
    |     #  If there are too  |
    | many words generated,    |
    |     #+ redirect the outp |
    | ut to a file.            |
    |                          |
    |     $ sh cw-solver.sh w. |
    | ..i....n                 |
    |                          |
    |     wellington           |
    |     workingman           |
    |     workingmen           |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

     **egrep** -- *extended grep* -- is the same as **grep -E** . This
    uses a somewhat different, extended set of `Regular
    Expressions <regexp.html#REGEXREF>`__ , which can make the search a
    bit more flexible. It also allows the boolean \| ( *or* ) operator.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash $ egrep 'matche |
    | s|Matches' file.txt      |
    |     Line 1 matches.      |
    |      Line 3 Matches.     |
    |      Line 4 contains mat |
    | ches, but also Matches   |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

     **fgrep** -- *fast grep* -- is the same as **grep -F** . It does a
    literal string search (no `Regular
    Expressions <regexp.html#REGEXREF>`__ ), which generally speeds
    things up a bit.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | On some Linux distros, **egrep** and |
    | **fgrep** are symbolic links to, or  |
    | aliases for **grep** , but invoked   |
    | with the                             |
    | ``             -E            `` and  |
    | ``             -F            ``      |
    | options, respectively.               |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-19. Looking up definitions in *Webster's 1913
    Dictionary***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # dict-lookup.sh     |
    |                          |
    |     #  This script looks |
    |  up definitions in the 1 |
    | 913 Webster's Dictionary |
    | .                        |
    |     #  This Public Domai |
    | n dictionary is availabl |
    | e for download           |
    |     #+ from various site |
    | s, including             |
    |     #+ Project Gutenberg |
    |  (http://www.gutenberg.o |
    | rg/etext/247).           |
    |     #                    |
    |     #  Convert it from D |
    | OS to UNIX format (with  |
    | only LF at end of line)  |
    |     #+ before using it w |
    | ith this script.         |
    |     #  Store the file in |
    |  plain, uncompressed ASC |
    | II text.                 |
    |     #  Set DEFAULT_DICTF |
    | ILE variable below to pa |
    | th/filename.             |
    |                          |
    |                          |
    |     E_BADARGS=85         |
    |     MAXCONTEXTLINES=50   |
    |                       #  |
    | Maximum number of lines  |
    | to show.                 |
    |     DEFAULT_DICTFILE="/u |
    | sr/share/dict/webster191 |
    | 3-dict.txt"              |
    |                          |
    |                       #  |
    | Default dictionary file  |
    | pathname.                |
    |                          |
    |                       #  |
    | Change this as necessary |
    | .                        |
    |     #  Note:             |
    |     #  ----              |
    |     #  This particular e |
    | dition of the 1913 Webst |
    | er's                     |
    |     #+ begins each entry |
    |  with an uppercase lette |
    | r                        |
    |     #+ (lowercase for th |
    | e remaining characters). |
    |     #  Only the *very fi |
    | rst line* of an entry be |
    | gins this way,           |
    |     #+ and that's why th |
    | e search algorithm below |
    |  works.                  |
    |                          |
    |                          |
    |                          |
    |     if [[ -z $(echo "$1" |
    |  | sed -n '/^[A-Z]/p') ] |
    | ]                        |
    |     #  Must at least spe |
    | cify word to look up, an |
    | d                        |
    |     #+ it must start wit |
    | h an uppercase letter.   |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` Word-to-define  |
    | [dictionary-file]"       |
    |       echo               |
    |       echo "Note: Word t |
    | o look up must start wit |
    | h capital letter,"       |
    |       echo "with the res |
    | t of the word in lowerca |
    | se."                     |
    |       echo "------------ |
    | ------------------------ |
    | --------"                |
    |       echo "Examples: Ab |
    | andon, Dictionary, Marki |
    | ng, etc."                |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |                          |
    |     if [ -z "$2" ]       |
    |                       #  |
    |  May specify different d |
    | ictionary                |
    |                          |
    |                       #+ |
    |  as an argument to this  |
    | script.                  |
    |     then                 |
    |       dictfile=$DEFAULT_ |
    | DICTFILE                 |
    |     else                 |
    |       dictfile="$2"      |
    |     fi                   |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | ---------------          |
    |     Definition=$(fgrep - |
    | A $MAXCONTEXTLINES "$1 \ |
    | \" "$dictfile")          |
    |     #                  D |
    | efinitions in form "Word |
    |  \..."                   |
    |     #                    |
    |     #  And, yes, "fgrep" |
    |  is fast enough          |
    |     #+ to search even a  |
    | very large text file.    |
    |                          |
    |                          |
    |     # Now, snip out just |
    |  the definition block.   |
    |                          |
    |     echo "$Definition" | |
    |     sed -n '1,/^[A-Z]/p' |
    |  |                       |
    |     #  Print from first  |
    | line of output           |
    |     #+ to the first line |
    |  of the next entry.      |
    |     sed '$d' | sed '$d'  |
    |     #  Delete last two l |
    | ines of output           |
    |     #+ (blank line and f |
    | irst line of next entry) |
    | .                        |
    |     # ------------------ |
    | ------------------------ |
    | ---------------          |
    |                          |
    |     exit $?              |
    |                          |
    |     # Exercises:         |
    |     # ---------          |
    |     # 1)  Modify the scr |
    | ipt to accept any type o |
    | f alphabetic input       |
    |     #   + (uppercase, lo |
    | wercase, mixed case), an |
    | d convert it             |
    |     #   + to an acceptab |
    | le format for processing |
    | .                        |
    |     #                    |
    |     # 2)  Convert the sc |
    | ript to a GUI applicatio |
    | n,                       |
    |     #   + using somethin |
    | g like 'gdialog' or 'zen |
    | ity' . . .               |
    |     #     The script wil |
    | l then no longer take it |
    | s argument(s)            |
    |     #   + from the comma |
    | nd-line.                 |
    |     #                    |
    |     # 3)  Modify the scr |
    | ipt to parse one of the  |
    | other available          |
    |     #   + Public Domain  |
    | Dictionaries, such as th |
    | e U.S. Census Bureau Gaz |
    | etteer.                  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | See also `Example                    |
    | A-41 <contributed-scripts.html#QKY>` |
    | __                                   |
    | for an example of speedy *fgrep*     |
    | lookup on a large text file.         |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    **agrep** ( *approximate grep* ) extends the capabilities of
    **grep** to approximate matching. The search string may differ by a
    specified number of characters from the resulting matches. This
    utility is not part of the core Linux distribution.

    .. raw:: html

       <div class="TIP">

    +--------------------+--------------------+--------------------+--------------------+
    | |Tip|              |
    | To search          |
    | compressed files,  |
    | use **zgrep** ,    |
    | **zegrep** , or    |
    | **zfgrep** . These |
    | also work on       |
    | non-compressed     |
    | files, though      |
    | slower than plain  |
    | **grep** ,         |
    | **egrep** ,        |
    | **fgrep** . They   |
    | are handy for      |
    | searching through  |
    | a mixed set of     |
    | files, some        |
    | compressed, some   |
    | not.               |
    |                    |
    | To search          |
    | `bzipped <filearch |
    | iv.html#BZIPREF>`_ |
    | _                  |
    | files, use         |
    | **bzgrep** .       |
    +--------------------+--------------------+--------------------+--------------------+

    .. raw:: html

       </div>

 **look**
    The command **look** works like **grep** , but does a lookup on a
    "dictionary," a sorted word list. By default, **look** searches for
    a match in ``         /usr/dict/words        `` , but a different
    dictionary file may be specified.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-20. Checking words in a list for validity**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # lookup: Does a dic |
    | tionary lookup on each w |
    | ord in a data file.      |
    |                          |
    |     file=words.data  # D |
    | ata file from which to r |
    | ead words to test.       |
    |                          |
    |     echo                 |
    |     echo "Testing file $ |
    | file"                    |
    |     echo                 |
    |                          |
    |     while [ "$word" != e |
    | nd ]  # Last word in dat |
    | a file.                  |
    |     do               # ^ |
    | ^^                       |
    |       read word      # F |
    | rom data file, because o |
    | f redirection at end of  |
    | loop.                    |
    |       look $word > /dev/ |
    | null  # Don't want to di |
    | splay lines in dictionar |
    | y file.                  |
    |       #  Searches for wo |
    | rds in the file /usr/sha |
    | re/dict/words            |
    |       #+ (usually a link |
    |  to linux.words).        |
    |       lookup=$?      # E |
    | xit status of 'look' com |
    | mand.                    |
    |                          |
    |       if [ "$lookup" -eq |
    |  0 ]                     |
    |       then               |
    |         echo "\"$word\"  |
    | is valid."               |
    |       else               |
    |         echo "\"$word\"  |
    | is invalid."             |
    |       fi                 |
    |                          |
    |     done <"$file"    # R |
    | edirects stdin to $file, |
    |  so "reads" come from th |
    | ere.                     |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | ----------------------   |
    |     # Code below line wi |
    | ll not execute because o |
    | f "exit" command above.  |
    |                          |
    |                          |
    |     # Stephane Chazelas  |
    | proposes the following,  |
    | more concise alternative |
    | :                        |
    |                          |
    |     while read word && [ |
    | [ $word != end ]]        |
    |     do if look "$word" > |
    |  /dev/null               |
    |        then echo "\"$wor |
    | d\" is valid."           |
    |        else echo "\"$wor |
    | d\" is invalid."         |
    |        fi                |
    |     done <"$file"        |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **sed** , **awk**
    Scripting languages especially suited for parsing text files and
    command output. May be embedded singly or in combination in pipes
    and shell scripts.

 **`sed <sedawk.html#SEDREF>`__**
    Non-interactive "stream editor" , permits using many **ex** commands
    in `batch <timedate.html#BATCHPROCREF>`__ mode. It finds many uses
    in shell scripts.

 **`awk <awk.html#AWKREF>`__**
    Programmable file extractor and formatter, good for manipulating
    and/or extracting `fields <special-chars.html#FIELDREF>`__ (columns)
    in structured text files. Its syntax is similar to C.

 **wc**
    *wc* gives a "word count" on a file or I/O stream:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash $ wc /usr/share |
    | /doc/sed-4.1.2/README    |
    |     13  70  447 README   |
    |     [13 lines  70 words  |
    |  447 characters]         |
                              
    +--------------------------+--------------------------+--------------------------+

    ``                   wc -w                 `` gives only the word
    count.

    ``                   wc -l                 `` gives only the line
    count.

    ``                   wc -c                 `` gives only the byte
    count.

    ``                   wc -m                 `` gives only the
    character count.

    ``                   wc -L                 `` gives only the length
    of the longest line.

    Using **wc** to count how many ``         .txt        `` files are
    in current working directory:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     $ ls *.txt | wc -l   |
    |     #  Will work as long |
    |  as none of the "*.txt"  |
    | files                    |
    |     #+ have a linefeed e |
    | mbedded in their name.   |
    |                          |
    |     #  Alternative ways  |
    | of doing this are:       |
    |     #      find . -maxde |
    | pth 1 -name \*.txt -prin |
    | t0 | grep -cz .          |
    |     #      (shopt -s nul |
    | lglob; set -- *.txt; ech |
    | o $#)                    |
    |                          |
    |     #  Thanks, S.C.      |
                              
    +--------------------------+--------------------------+--------------------------+

    Using **wc** to total up the size of all the files whose names begin
    with letters in the range d - h

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ wc [d-h]* | gr |
    | ep total | awk '{print $ |
    | 3}'                      |
    |     71832                |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    Using **wc** to count the instances of the word "Linux" in the main
    source file for this book.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ grep Linux abs |
    | -book.sgml | wc -l       |
    |     138                  |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    See also `Example 16-39 <filearchiv.html#EX52>`__ and `Example
    20-8 <redircb.html#REDIR4>`__ .

    Certain commands include some of the functionality of **wc** as
    options.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     ... | grep foo | wc  |
    | -l                       |
    |     # This frequently us |
    | ed construct can be more |
    |  concisely rendered.     |
    |                          |
    |     ... | grep -c foo    |
    |     # Just use the "-c"  |
    | (or "--count") option of |
    |  grep.                   |
    |                          |
    |     # Thanks, S.C.       |
                              
    +--------------------------+--------------------------+--------------------------+

 **tr**
    character translation filter.

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | `Must use quoting and/or             |
    | brackets <special-chars.html#UCREF>` |
    | __                                   |
    | , as appropriate. Quotes prevent the |
    | shell from reinterpreting the        |
    | special characters in **tr** command |
    | sequences. Brackets should be quoted |
    | to prevent expansion by the shell.   |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    Either
    ``                   tr "A-Z" "*" <filename                 `` or
    ``                   tr A-Z \* <filename                 `` changes
    all the uppercase letters in ``         filename        `` to
    asterisks (writes to ``         stdout        `` ). On some systems
    this may not work, but
    ``                   tr A-Z           '[**]'                 ``
    will.

    The ``         -d        `` option deletes a range of characters.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo "abcdef"        |
    |           # abcdef       |
    |     echo "abcdef" | tr - |
    | d b-d     # aef          |
    |                          |
    |                          |
    |     tr -d 0-9 <filename  |
    |     # Deletes all digits |
    |  from the file "filename |
    | ".                       |
                              
    +--------------------------+--------------------------+--------------------------+

    The ``         --squeeze-repeats        `` (or
    ``         -s        `` ) option deletes all but the first instance
    of a string of consecutive characters. This option is useful for
    removing excess `whitespace <special-chars.html#WHITESPACEREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo "XXXXX" | |
    |  tr --squeeze-repeats 'X |
    | '                        |
    |     X                    |
                              
    +--------------------------+--------------------------+--------------------------+

    The ``         -c        `` "complement" option *inverts* the
    character set to match. With this option, **tr** acts only upon
    those characters *not* matching the specified set.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo "acfdeb12 |
    | 3" | tr -c b-d +         |
    |     +c+d+b++++           |
                              
    +--------------------------+--------------------------+--------------------------+

    Note that **tr** recognizes `POSIX character
    classes <x17129.html#POSIXREF>`__ . ` [1]
     <textproc.html#FTN.AEN11502>`__

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo "abcd2ef1 |
    | " | tr '[:alpha:]' -     |
    |     ----2--1             |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-21. *toupper* : Transforms a file to all uppercase.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Changes a file to  |
    | all uppercase.           |
    |                          |
    |     E_BADARGS=85         |
    |                          |
    |     if [ -z "$1" ]  # St |
    | andard check for command |
    | -line arg.               |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` filename"       |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |     tr a-z A-Z <"$1"     |
    |                          |
    |     # Same effect as abo |
    | ve, but using POSIX char |
    | acter set notation:      |
    |     #        tr '[:lower |
    | :]' '[:upper:]' <"$1"    |
    |     # Thanks, S.C.       |
    |                          |
    |     #     Or even . . .  |
    |     #     cat "$1" | tr  |
    | a-z A-Z                  |
    |     #     Or dozens of o |
    | ther ways . . .          |
    |                          |
    |     exit 0               |
    |                          |
    |     #  Exercise:         |
    |     #  Rewrite this scri |
    | pt to give the option of |
    |  changing a file         |
    |     #+ to *either* upper |
    |  or lowercase.           |
    |     #  Hint: Use either  |
    | the "case" or "select" c |
    | ommand.                  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-22. *lowercase* : Changes all filenames in working
    directory to lowercase.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     #                    |
    |     #  Changes every fil |
    | ename in working directo |
    | ry to all lowercase.     |
    |     #                    |
    |     #  Inspired by a scr |
    | ipt of John Dubois,      |
    |     #+ which was transla |
    | ted into Bash by Chet Ra |
    | mey,                     |
    |     #+ and considerably  |
    | simplified by the author |
    |  of the ABS Guide.       |
    |                          |
    |                          |
    |     for filename in *    |
    |              # Traverse  |
    | all files in directory.  |
    |     do                   |
    |        fname=`basename $ |
    | filename`                |
    |        n=`echo $fname |  |
    | tr A-Z a-z`  # Change na |
    | me to lowercase.         |
    |        if [ "$fname" !=  |
    | "$n" ]       # Rename on |
    | ly files not already low |
    | ercase.                  |
    |        then              |
    |          mv $fname $n    |
    |        fi                |
    |     done                 |
    |                          |
    |     exit $?              |
    |                          |
    |                          |
    |     # Code below this li |
    | ne will not execute beca |
    | use of "exit".           |
    |     #------------------- |
    | ------------------------ |
    | -------------#           |
    |     # To run it, delete  |
    | script above line.       |
    |                          |
    |     # The above script w |
    | ill not work on filename |
    | s containing blanks or n |
    | ewlines.                 |
    |     # Stephane Chazelas  |
    | therefore suggests the f |
    | ollowing alternative:    |
    |                          |
    |                          |
    |     for filename in *    |
    |  # Not necessary to use  |
    | basename,                |
    |                          |
    |  # since "*" won't retur |
    | n any file containing "/ |
    | ".                       |
    |     do n=`echo "$filenam |
    | e/" | tr '[:upper:]' '[: |
    | lower:]'`                |
    |     #                    |
    |           POSIX char set |
    |  notation.               |
    |     #                    |
    |  Slash added so that tra |
    | iling newlines are not   |
    |     #                    |
    |  removed by command subs |
    | titution.                |
    |        # Variable substi |
    | tution:                  |
    |        n=${n%/}          |
    |  # Removes trailing slas |
    | h, added above, from fil |
    | ename.                   |
    |        [[ $filename == $ |
    | n ]] || mv "$filename" " |
    | $n"                      |
    |                          |
    |  # Checks if filename al |
    | ready lowercase.         |
    |     done                 |
    |                          |
    |     exit $?              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-23. *du* : DOS to UNIX text file conversion.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Du.sh: DOS to UNIX |
    |  text file converter.    |
    |                          |
    |     E_WRONGARGS=85       |
    |                          |
    |     if [ -z "$1" ]       |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` filename-to-con |
    | vert"                    |
    |       exit $E_WRONGARGS  |
    |     fi                   |
    |                          |
    |     NEWFILENAME=$1.unx   |
    |                          |
    |     CR='\015'  # Carriag |
    | e return.                |
    |                # 015 is  |
    | octal ASCII code for CR. |
    |                # Lines i |
    | n a DOS text file end in |
    |  CR-LF.                  |
    |                # Lines i |
    | n a UNIX text file end i |
    | n LF only.               |
    |                          |
    |     tr -d $CR < $1 > $NE |
    | WFILENAME                |
    |     # Delete CR's and wr |
    | ite to new file.         |
    |                          |
    |     echo "Original DOS t |
    | ext file is \"$1\"."     |
    |     echo "Converted UNIX |
    |  text file is \"$NEWFILE |
    | NAME\"."                 |
    |                          |
    |     exit 0               |
    |                          |
    |     # Exercise:          |
    |     # --------           |
    |     # Change the above s |
    | cript to convert from UN |
    | IX to DOS.               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-24. *rot13* : ultra-weak encryption.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # rot13.sh: Classic  |
    | rot13 algorithm,         |
    |     #           encrypti |
    | on that might fool a 3-y |
    | ear old                  |
    |     #           for abou |
    | t 10 minutes.            |
    |                          |
    |     # Usage: ./rot13.sh  |
    | filename                 |
    |     # or     ./rot13.sh  |
    | <filename                |
    |     # or     ./rot13.sh  |
    | and supply keyboard inpu |
    | t (stdin)                |
    |                          |
    |     cat "$@" | tr 'a-zA- |
    | Z' 'n-za-mN-ZA-M'   # "a |
    | " goes to "n", "b" to "o |
    | " ...                    |
    |     #  The   cat "$@"    |
    | construct                |
    |     #+ permits input eit |
    | her from stdin or from f |
    | iles.                    |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-25. Generating "Crypto-Quote" Puzzles**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # crypto-quote.sh: E |
    | ncrypt quotes            |
    |                          |
    |     #  Will encrypt famo |
    | us quotes in a simple mo |
    | noalphabetic substitutio |
    | n.                       |
    |     #  The result is sim |
    | ilar to the "Crypto Quot |
    | e" puzzles               |
    |     #+ seen in the Op Ed |
    |  pages of the Sunday pap |
    | er.                      |
    |                          |
    |                          |
    |     key=ETAOINSHRDLUBCFG |
    | JMQPVWZYXK               |
    |     # The "key" is nothi |
    | ng more than a scrambled |
    |  alphabet.               |
    |     # Changing the "key" |
    |  changes the encryption. |
    |                          |
    |     # The 'cat "$@"' con |
    | struction gets input eit |
    | her from stdin or from f |
    | iles.                    |
    |     # If using stdin, te |
    | rminate input with a Con |
    | trol-D.                  |
    |     # Otherwise, specify |
    |  filename as command-lin |
    | e parameter.             |
    |                          |
    |     cat "$@" | tr "a-z"  |
    | "A-Z" | tr "A-Z" "$key"  |
    |     #        |  to upper |
    | case  |     encrypt      |
    |                          |
    |     # Will work on lower |
    | case, uppercase, or mixe |
    | d-case quotes.           |
    |     # Passes non-alphabe |
    | tic characters through u |
    | nchanged.                |
    |                          |
    |                          |
    |     # Try this script wi |
    | th something like:       |
    |     # "Nothing so needs  |
    | reforming as other peopl |
    | e's habits."             |
    |     # --Mark Twain       |
    |     #                    |
    |     # Output is:         |
    |     # "CFPHRCS QF CIIOQ  |
    | MINFMBRCS EQ FPHIM GIFGU |
    | I'Q HETRPQ."             |
    |     # --BEML PZERC       |
    |                          |
    |     # To reverse the enc |
    | ryption:                 |
    |     # cat "$@" | tr "$ke |
    | y" "A-Z"                 |
    |                          |
    |                          |
    |     #  This simple-minde |
    | d cipher can be broken b |
    | y an average 12-year old |
    |     #+ using only pencil |
    |  and paper.              |
    |                          |
    |     exit 0               |
    |                          |
    |     #  Exercise:         |
    |     #  --------          |
    |     #  Modify the script |
    |  so that it will either  |
    | encrypt or decrypt,      |
    |     #+ depending on comm |
    | and-line argument(s).    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

     Of course, *tr* lends itself to *code obfuscation* .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # jabh.sh            |
    |                          |
    |     x="wftedskaebjgdBstb |
    | dbsmnjgz"                |
    |     echo $x | tr "a-z" ' |
    | oh, turtleneck Phrase Ja |
    | r!'                      |
    |                          |
    |     # Based on the Wikip |
    | edia "Just another Perl  |
    | hacker" article.         |
                              
    +--------------------------+--------------------------+--------------------------+

    +--------------------------------------------------------------------------+
    | .. raw:: html                                                            |
    |                                                                          |
    |    <div class="SIDEBAR">                                                 |
    |                                                                          |
    | ***tr* variants**                                                        |
    |                                                                          |
    | The **tr** utility has two historic variants. The BSD version does not   |
    | use brackets (                                                           |
    | ``                           tr a-z A-Z                         `` ),    |
    | but the SysV one does (                                                  |
    | ``                           tr '[a-z]' '[A-Z]'                          |
    | ``                                                                       |
    | ). The GNU version of **tr** resembles the BSD one.                      |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </div>                                                                |
                                                                              
    +--------------------------------------------------------------------------+

 **fold**
    A filter that wraps lines of input to a specified width. This is
    especially useful with the ``         -s        `` option, which
    breaks lines at word spaces (see `Example
    16-26 <textproc.html#EX50>`__ and `Example
    A-1 <contributed-scripts.html#MAILFORMAT>`__ ).

 **fmt**
    Simple-minded file formatter, used as a filter in a pipe to "wrap"
    long lines of text output.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-26. Formatted file listing.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     WIDTH=40             |
    |         # 40 columns wid |
    | e.                       |
    |                          |
    |     b=`ls /usr/local/bin |
    | `       # Get a file lis |
    | ting...                  |
    |                          |
    |     echo $b | fmt -w $WI |
    | DTH                      |
    |                          |
    |     # Could also have be |
    | en done by               |
    |     #    echo $b | fold  |
    | - -s -w $WIDTH           |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example 16-5 <moreadv.html#EX41>`__ .

    .. raw:: html

       <div class="TIP">

    +--------------------------------------+--------------------------------------+
    | |Tip|                                |
    | A powerful alternative to **fmt** is |
    | Kamil Toman's **par** utility,       |
    | available from                       |
    | http://www.cs.berkeley.edu/~amc/Par/ |
    | .                                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **col**
    This deceptively named filter removes reverse line feeds from an
    input stream. It also attempts to replace whitespace with equivalent
    tabs. The chief use of **col** is in filtering the output from
    certain text processing utilities, such as **groff** and **tbl** .

 **column**
    Column formatter. This filter transforms list-type text output into
    a "pretty-printed" table by inserting tabs at appropriate places.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-27. Using *column* to format a directory listing**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # colms.sh           |
    |     # A minor modificati |
    | on of the example file i |
    | n the "column" man page. |
    |                          |
    |                          |
    |     (printf "PERMISSIONS |
    |  LINKS OWNER GROUP SIZE  |
    | MONTH DAY HH:MM PROG-NAM |
    | E\n" \                   |
    |     ; ls -l | sed 1d) |  |
    | column -t                |
    |     #         ^^^^^^     |
    |        ^^                |
    |                          |
    |     #  The "sed 1d" in t |
    | he pipe deletes the firs |
    | t line of output,        |
    |     #+ which would be "t |
    | otal        N",          |
    |     #+ where "N" is the  |
    | total number of files fo |
    | und by "ls -l".          |
    |                          |
    |     # The -t option to " |
    | column" pretty-prints a  |
    | table.                   |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **colrm**
    Column removal filter. This removes columns (characters) from a file
    and writes the file, lacking the range of specified columns, back to
    ``         stdout        `` .
    ``                   colrm 2 4 <filename                 `` removes
    the second through fourth characters from each line of the text file
    ``         filename        `` .

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | If the file contains tabs or         |
    | nonprintable characters, this may    |
    | cause unpredictable behavior. In     |
    | such cases, consider using           |
    | `expand <textproc.html#EXPANDREF>`__ |
    | and **unexpand** in a pipe preceding |
    | **colrm** .                          |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **nl**
    Line numbering filter:
    ``                   nl filename                 `` lists
    ``         filename        `` to ``         stdout        `` , but
    inserts consecutive numbers at the beginning of each non-blank line.
    If ``         filename        `` omitted, operates on
    ``         stdin.        ``

    The output of **nl** is very similar to
    ``                   cat -b                 `` , since, by default
    **nl** does not list blank lines.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-28. *nl* : A self-numbering script.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # line-number.sh     |
    |                          |
    |     # This script echoes |
    |  itself twice to stdout  |
    | with its lines numbered. |
    |                          |
    |     echo "     line numb |
    | er = $LINENO" # 'nl' see |
    | s this as line 4         |
    |     #                    |
    |                 (nl does |
    |  not number blank lines) |
    | .                        |
    |     #                    |
    |                 'cat -n' |
    |  sees it correctly as li |
    | ne #6.                   |
    |                          |
    |     nl `basename $0`     |
    |                          |
    |     echo; echo  # Now, l |
    | et's try it with 'cat -n |
    | '                        |
    |                          |
    |     cat -n `basename $0` |
    |     # The difference is  |
    | that 'cat -n' numbers th |
    | e blank lines.           |
    |     # Note that 'nl -ba' |
    |  will also do so.        |
    |                          |
    |     exit 0               |
    |     # ------------------ |
    | ------------------------ |
    | -----------------------  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **pr**
    Print formatting filter. This will paginate files (or
    ``         stdout        `` ) into sections suitable for hard copy
    printing or viewing on screen. Various options permit row and column
    manipulation, joining lines, setting margins, numbering lines,
    adding page headers, and merging files, among other things. The
    **pr** command combines much of the functionality of **nl** ,
    **paste** , **fold** , **column** , and **expand** .

    ``                   pr -o 5 --width=65 fileZZZ | more                 ``
    gives a nice paginated listing to screen of
    ``         fileZZZ        `` with margins set at 5 and 65.

    A particularly useful option is ``         -d        `` , forcing
    double-spacing (same effect as **sed -G** ).

 **gettext**
    The GNU **gettext** package is a set of utilities for
    `localizing <localization.html>`__ and translating the text output
    of programs into foreign languages. While originally intended for C
    programs, it now supports quite a number of programming and
    scripting languages.

    The **gettext** *program* works on shell scripts. See the
    ``                   info page                 `` .

 **msgfmt**
    A program for generating binary message catalogs. It is used for
    `localization <localization.html>`__ .

 **iconv**
    A utility for converting file(s) to a different encoding (character
    set). Its chief use is for `localization <localization.html>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Convert a string f |
    | rom UTF-8 to UTF-16 and  |
    | print to the BookList    |
    |     function write_utf8_ |
    | string {                 |
    |         STRING=$1        |
    |         BOOKLIST=$2      |
    |         echo -n "$STRING |
    | " | iconv -f UTF8 -t UTF |
    | 16 | \                   |
    |         cut -b 3- | tr - |
    | d \\n >> "$BOOKLIST"     |
    |     }                    |
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

 **recode**
    Consider this a fancier version of **iconv** , above. This very
    versatile utility for converting a file to a different encoding
    scheme. Note that *recode* is not part of the standard Linux
    installation.

 **TeX** , **gs**
    **TeX** and **Postscript** are text markup languages used for
    preparing copy for printing or formatted video display.

    **TeX** is Donald Knuth's elaborate typsetting system. It is often
    convenient to write a shell script encapsulating all the options and
    arguments passed to one of these markup languages.

    *Ghostscript* ( **gs** ) is a GPL-ed Postscript interpreter.

 **texexec**
    Utility for processing *TeX* and *pdf* files. Found in
    ``         /usr/bin        `` on many Linux distros, it is actually
    a `shell wrapper <wrapper.html#SHWRAPPER>`__ that calls
    `Perl <wrapper.html#PERLREF>`__ to invoke *Tex* .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     texexec --pdfarrange |
    |  --result=Concatenated.p |
    | df *pdf                  |
    |                          |
    |     #  Concatenates all  |
    | the pdf files in the cur |
    | rent working directory   |
    |     #+ into the merged f |
    | ile, Concatenated.pdf .  |
    | . .                      |
    |     #  (The --pdfarrange |
    |  option repaginates a pd |
    | f file. See also --pdfco |
    | mbine.)                  |
    |     #  The above command |
    | -line could be parameter |
    | ized and put into a shel |
    | l script.                |
                              
    +--------------------------+--------------------------+--------------------------+

 **enscript**
    Utility for converting plain text file to PostScript

    For example, **enscript filename.txt -p filename.ps** produces the
    PostScript output file ``         filename.ps        `` .

 **groff** , **tbl** , **eqn**
    Yet another text markup and display formatting language is **groff**
    . This is the enhanced GNU version of the venerable UNIX
    **roff/troff** display and typesetting package.
    `Manpages <basic.html#MANREF>`__ use **groff** .

    The **tbl** table processing utility is considered part of **groff**
    , as its function is to convert table markup into **groff**
    commands.

    The **eqn** equation processing utility is likewise part of
    **groff** , and its function is to convert equation markup into
    **groff** commands.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-29. *manview* : Viewing formatted manpages**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # manview.sh: Format |
    | s the source of a man pa |
    | ge for viewing.          |
    |                          |
    |     #  This script is us |
    | eful when writing man pa |
    | ge source.               |
    |     #  It lets you look  |
    | at the intermediate resu |
    | lts on the fly           |
    |     #+ while working on  |
    | it.                      |
    |                          |
    |     E_WRONGARGS=85       |
    |                          |
    |     if [ -z "$1" ]       |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` filename"       |
    |       exit $E_WRONGARGS  |
    |     fi                   |
    |                          |
    |     # ------------------ |
    | ---------                |
    |     groff -Tascii -man $ |
    | 1 | less                 |
    |     # From the man page  |
    | for groff.               |
    |     # ------------------ |
    | ---------                |
    |                          |
    |     #  If the man page i |
    | ncludes tables and/or eq |
    | uations,                 |
    |     #+ then the above co |
    | de will barf.            |
    |     #  The following lin |
    | e can handle such cases. |
    |     #                    |
    |     #   gtbl < "$1" | ge |
    | qn -Tlatin1 | groff -Tla |
    | tin1 -mtty-char -man     |
    |     #                    |
    |     #   Thanks, S.C.     |
    |                          |
    |     exit $?   # See also |
    |  the "maned.sh" script.  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example A-39 <contributed-scripts.html#MANED>`__ .

 **lex** , **yacc**

    The **lex** lexical analyzer produces programs for pattern matching.
    This has been replaced by the nonproprietary **flex** on Linux
    systems.

    The **yacc** utility creates a parser based on a set of
    specifications. This has been replaced by the nonproprietary
    **bison** on Linux systems.

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <textproc.html#AEN11502>`__   |
| This is only true of the GNU version |
| of **tr** , not the generic version  |
| often found on commercial UNIX       |
| systems.                             |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <timedate.html>`__ | Time / Date Commands     |
| `Home <index.html>`__    | `Up <external.html>`__   |
| `Next <filearchiv.html>` | File and Archiving       |
| __                       | Commands                 |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Tip| image:: ../images/tip.gif
.. |Caution| image:: ../images/caution.gif
