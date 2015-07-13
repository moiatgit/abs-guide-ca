###################################
XXX  16.4. Text Processing Commands
###################################

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        cat list-1 list-2 list-3 | sort | uniq > final.list
        # Concatenates the list files,
        # sorts them,
        # removes duplicate lines,
        # and finally writes the result to an output file.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    The useful ``         -c        `` option prefixes each line of the
    input file with its number of occurrences.

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ cat testfile
        This line occurs only once.
         This line occurs twice.
         This line occurs twice.
         This line occurs three times.
         This line occurs three times.
         This line occurs three times.


        bash$ uniq -c testfile
              1 This line occurs only once.
               2 This line occurs twice.
               3 This line occurs three times.


        bash$ sort testfile | uniq -c | sort -nr
              3 This line occurs three times.
               2 This line occurs twice.
               1 This line occurs only once.


    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # wf.sh: Crude word frequency analysis on a text file.
        # This is a more efficient version of the "wf2.sh" script.


        # Check for input file on command-line.
        ARGS=1
        E_BADARGS=85
        E_NOFILE=86

        if [ $# -ne "$ARGS" ]  # Correct number of arguments passed to script?
        then
          echo "Usage: `basename $0` filename"
          exit $E_BADARGS
        fi

        if [ ! -f "$1" ]       # Check if file exists.
        then
          echo "File \"$1\" does not exist."
          exit $E_NOFILE
        fi



        ########################################################
        # main ()
        sed -e 's/\.//g'  -e 's/\,//g' -e 's/ /\
        /g' "$1" | tr 'A-Z' 'a-z' | sort | uniq -c | sort -nr
        #                           =========================
        #                            Frequency of occurrence

        #  Filter out periods and commas, and
        #+ change space between words to linefeed,
        #+ then shift characters to lowercase, and
        #+ finally prefix occurrence count and sort numerically.

        #  Arun Giridhar suggests modifying the above to:
        #  . . . | sort | uniq -c | sort +1 [-f] | sort +0 -nr
        #  This adds a secondary sort key, so instances of
        #+ equal occurrence are sorted alphabetically.
        #  As he explains it:
        #  "This is effectively a radix sort, first on the
        #+ least significant column
        #+ (word or string, optionally case-insensitive)
        #+ and last on the most significant column (frequency)."
        #
        #  As Frank Wang explains, the above is equivalent to
        #+       . . . | sort | uniq -c | sort +0 -nr
        #+ and the following also works:
        #+       . . . | sort | uniq -c | sort -k1nr -k
        ########################################################

        exit 0

        # Exercises:
        # ---------
        # 1) Add 'sed' commands to filter out other punctuation,
        #+   such as semicolons.
        # 2) Modify the script to also filter out multiple spaces and
        #+   other whitespace.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ cat testfile
        This line occurs only once.
         This line occurs twice.
         This line occurs twice.
         This line occurs three times.
         This line occurs three times.
         This line occurs three times.


        bash$ ./wf.sh testfile
              6 this
               6 occurs
               6 line
               3 times
               3 three
               2 twice
               1 only
               1 once


    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        cut -d ' ' -f1,2 /etc/mtab

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    Using **cut** to list the OS and kernel version:

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        uname -a | cut -d" " -f1,3,11,12

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    Using **cut** to extract message headers from an e-mail folder:

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ grep '^Subject:' read-messages | cut -c10-80
        Re: Linux suitable for mission-critical apps?
         MAKE MILLIONS WORKING AT HOME!!!
         Spam complaint
         Re: Spam complaint

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    Using **cut** to parse a file:

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        # List all the users in /etc/passwd.

        FILENAME=/etc/passwd

        for user in $(cut -d: -f1 $FILENAME)
        do
          echo $user
        done

        # Thanks, Oleg Philon for suggesting this.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    ``                   cut -d ' ' -f2,3 filename                 `` is
    equivalent to
    ``                   awk -F'[ ]' '{ print $2, $3 }' filename                 ``

    .. raw:: html

       <div class="NOTE">

    .. raw:: html

       <div>

    |Note|

    It is even possible to specify a linefeed as a delimiter. The trick
    is to actually embed a linefeed ( **RETURN** ) in the command
    sequence.

    | .. code:: SCREEN         |
    |                          |
    |     bash$ cut -d'        |
    |      ' -f3,7,19 testfile |
    |     This is line 3 of te |
    | stfile.                  |
    |      This is line 7 of t |
    | estfile.                 |
    |      This is line 19 of  |
    | testfile.                |
    |                          |


    Thank you, Jaka Kranjc, for pointing this out.

    .. raw:: html

       </p>

    .. code:: SCREEN

        bash$ cut -d'
         ' -f3,7,19 testfile
        This is line 3 of testfile.
         This is line 7 of testfile.
         This is line 19 of testfile.


    .. raw:: html

       </p>

    .. code:: SCREEN

        bash$ cut -d'
         ' -f3,7,19 testfile
        This is line 3 of testfile.
         This is line 7 of testfile.
         This is line 19 of testfile.


    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    See also `Example 16-48 <mathc.html#BASE>`__ .

 **paste**
    Tool for merging together different files into a single,
    multi-column file. In combination with
    `cut <textproc.html#CUTREF>`__ , useful for creating system log
    files.

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ cat items
        alphabet blocks
         building blocks
         cables

        bash$ cat prices
        $1.00/dozen
         $2.50 ea.
         $3.75

        bash$ paste items prices
        alphabet blocks $1.00/dozen
         building blocks $2.50 ea.
         cables  $3.75

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        File: 1.data

        100 Shoes
        200 Laces
        300 Socks

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        File: 2.data

        100 $40.00
        200 $1.00
        300 $2.00

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ join 1.data 2.data
        File: 1.data 2.data

         100 Shoes $40.00
         200 Laces $1.00
         300 Socks $2.00


    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    .. raw:: html

       <div>

    |Note|

    The tagged field appears only once in the output.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

 **head**
    lists the beginning of a file to ``         stdout        `` . The
    default is ``         10        `` lines, but a different number can
    be specified. The command has a number of interesting options.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-13. Which files are scripts?**

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # script-detector.sh: Detects scripts within a directory.

        TESTCHARS=2    # Test first 2 characters.
        SHABANG='#!'   # Scripts begin with a "sha-bang."

        for file in *  # Traverse all the files in current directory.
        do
          if [[ `head -c$TESTCHARS "$file"` = "$SHABANG" ]]
          #      head -c2                      #!
          #  The '-c' option to "head" outputs a specified
          #+ number of characters, rather than lines (the default).
          then
            echo "File \"$file\" is a script."
          else
            echo "File \"$file\" is *not* a script."
          fi
        done

        exit 0

        #  Exercises:
        #  ---------
        #  1) Modify this script to take as an optional argument
        #+    the directory to scan for scripts
        #+    (rather than just the current working directory).
        #
        #  2) As it stands, this script gives "false positives" for
        #+    Perl, awk, and other scripting language scripts.
        #     Correct this.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-14. Generating 10-digit random numbers**

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # rnd.sh: Outputs a 10-digit random number

        # Script by Stephane Chazelas.

        head -c4 /dev/urandom | od -N4 -tu4 | sed -ne '1s/.* //p'


        # =================================================================== #

        # Analysis
        # --------

        # head:
        # -c4 option takes first 4 bytes.

        # od:
        # -N4 option limits output to 4 bytes.
        # -tu4 option selects unsigned decimal format for output.

        # sed:
        # -n option, in combination with "p" flag to the "s" command,
        # outputs only matched lines.



        # The author of this script explains the action of 'sed', as follows.

        # head -c4 /dev/urandom | od -N4 -tu4 | sed -ne '1s/.* //p'
        # ----------------------------------> |

        # Assume output up to "sed" --------> |
        # is 0000000 1198195154\n

        #  sed begins reading characters: 0000000 1198195154\n.
        #  Here it finds a newline character,
        #+ so it is ready to process the first line (0000000 1198195154).
        #  It looks at its <range><action>s. The first and only one is

        #   range     action
        #   1         s/.* //p

        #  The line number is in the range, so it executes the action:
        #+ tries to substitute the longest string ending with a space in the line
        #  ("0000000 ") with nothing (//), and if it succeeds, prints the result
        #  ("p" is a flag to the "s" command here, this is different
        #+ from the "p" command).

        #  sed is now ready to continue reading its input. (Note that before
        #+ continuing, if -n option had not been passed, sed would have printed
        #+ the line once again).

        #  Now, sed reads the remainder of the characters, and finds the
        #+ end of the file.
        #  It is now ready to process its 2nd line (which is also numbered '$' as
        #+ it's the last one).
        #  It sees it is not matched by any <range>, so its job is done.

        #  In few word this sed commmand means:
        #  "On the first line only, remove any character up to the right-most space,
        #+ then print it."

        # A better way to do this would have been:
        #           sed -e 's/.* //;q'

        # Here, two <range><action>s (could have been written
        #           sed -e 's/.* //' -e q):

        #   range                    action
        #   nothing (matches line)   s/.* //
        #   nothing (matches line)   q (quit)

        #  Here, sed only reads its first line of input.
        #  It performs both actions, and prints the line (substituted) before
        #+ quitting (because of the "q" action) since the "-n" option is not passed.

        # =================================================================== #

        # An even simpler altenative to the above one-line script would be:
        #           head -c4 /dev/urandom| od -An -tu4

        exit

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash

        filename=sys.log

        cat /dev/null > $filename; echo "Creating / cleaning out file."
        #  Creates the file if it does not already exist,
        #+ and truncates it to zero length if it does.
        #  : > filename   and   > filename also work.

        tail /var/log/messages > $filename
        # /var/log/messages must have world read permission for this to work.

        echo "$filename contains tail end of system log."

        exit 0

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="TIP">

    .. raw:: html

       <div>

    |Tip|

    To list a specific line of a text file,
    `pipe <special-chars.html#PIPEREF>`__ the output of **head** to
    **tail -n 1** . For example
    ``                         head -n 8 database.txt | tail         -n 1                       ``
    lists the 8th line of the file
    ``            database.txt           `` .

    To set a variable to a given block of a text file:

    | .. code:: PROGRAMLISTING |
    |                          |
    |     var=$(head -n $m $fi |
    | lename | tail -n $n)     |
    |                          |
    |     # filename = name of |
    |  file                    |
    |     # m = from beginning |
    |  of file, number of line |
    | s to end of block        |
    |     # n = number of line |
    | s to set variable to (tr |
    | im from end of block)    |


    .. raw:: html

       </p>

    .. code:: PROGRAMLISTING

        var=$(head -n $m $filename | tail -n $n)

        # filename = name of file
        # m = from beginning of file, number of lines to end of block
        # n = number of lines to set variable to (trim from end of block)

    .. raw:: html

       </p>

    .. code:: PROGRAMLISTING

        var=$(head -n $m $filename | tail -n $n)

        # filename = name of file
        # m = from beginning of file, number of lines to end of block
        # n = number of lines to set variable to (trim from end of block)

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    .. raw:: html

       <div>

    |Note|

    Newer implementations of **tail** deprecate the older **tail -$LINES
    filename** usage. The standard **tail -n $LINES filename** is
    correct.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ grep '[rst]ystem.$' osinfo.txt
        The GPL governs the distribution of the Linux operating system.


    .. raw:: html

       </p>

    .. raw:: html

       </div>

    If no target file(s) specified, **grep** works as a filter on
    ``         stdout        `` , as in a
    `pipe <special-chars.html#PIPEREF>`__ .

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ ps ax | grep clock
        765 tty1     S      0:00 xclock
         901 pts/1    S      0:00 grep clock


    .. raw:: html

       </p>

    .. raw:: html

       </div>

    The ``         -i        `` option causes a case-insensitive search.

    The ``         -w        `` option matches only whole words.

    The ``         -l        `` option lists only the files in which
    matches were found, but not the matching lines.

    The ``         -r        `` (recursive) option searches files in the
    current working directory and all subdirectories below it.

    The ``         -n        `` option lists the matching lines,
    together with line numbers.

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ grep -n Linux osinfo.txt
        2:This is a file containing information about Linux.
         6:The GPL governs the distribution of the Linux operating system.


    .. raw:: html

       </p>

    .. raw:: html

       </div>

    The ``         -v        `` (or ``         --invert-match        ``
    ) option *filters out* matches.

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        grep pattern1 *.txt | grep -v pattern2

        # Matches all lines in "*.txt" files containing "pattern1",
        # but ***not*** "pattern2".

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    The ``         -c        `` ( ``         --count        `` ) option
    gives a numerical count of matches, rather than actually listing the
    matches.

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        grep -c txt *.sgml   # (number of occurrences of "txt" in "*.sgml" files)


        #   grep -cz .
        #            ^ dot
        # means count (-c) zero-separated (-z) items matching "."
        # that is, non-empty ones (containing at least 1 character).
        #
        printf 'a b\nc  d\n\n\n\n\n\000\n\000e\000\000\nf' | grep -cz .     # 3
        printf 'a b\nc  d\n\n\n\n\n\000\n\000e\000\000\nf' | grep -cz '$'   # 5
        printf 'a b\nc  d\n\n\n\n\n\000\n\000e\000\000\nf' | grep -cz '^'   # 5
        #
        printf 'a b\nc  d\n\n\n\n\n\000\n\000e\000\000\nf' | grep -c '$'    # 9
        # By default, newline chars (\n) separate items to match.

        # Note that the -z option is GNU "grep" specific.


        # Thanks, S.C.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # from.sh

        #  Emulates the useful 'from' utility in Solaris, BSD, etc.
        #  Echoes the "From" header line in all messages
        #+ in your e-mail directory.


        MAILDIR=~/mail/*               #  No quoting of variable. Why?
        # Maybe check if-exists $MAILDIR:   if [ -d $MAILDIR ] . . .
        GREP_OPTS="-H -A 5 --color"    #  Show file, plus extra context lines
                                       #+ and display "From" in color.
        TARGETSTR="^From"              # "From" at beginning of line.

        for file in $MAILDIR           #  No quoting of variable.
        do
          grep $GREP_OPTS "$TARGETSTR" "$file"
          #    ^^^^^^^^^^              #  Again, do not quote this variable.
          echo
        done

        exit $?

        #  You might wish to pipe the output of this script to 'more'
        #+ or redirect it to a file . . .

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    When invoked with more than one target file given, **grep**
    specifies which file contains matches.

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ grep Linux osinfo.txt misc.txt
        osinfo.txt:This is a file containing information about Linux.
         osinfo.txt:The GPL governs the distribution of the Linux operating system.
         misc.txt:The Linux operating system is steadily gaining in popularity.


    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="TIP">

    .. raw:: html

       <div>

    |Tip|

    To force **grep** to show the filename when searching only one
    target file, simply give ``            /dev/null           `` as the
    second file.

    | .. code:: SCREEN         |
    |                          |
    |     bash$ grep Linux osi |
    | nfo.txt /dev/null        |
    |     osinfo.txt:This is a |
    |  file containing informa |
    | tion about Linux.        |
    |      osinfo.txt:The GPL  |
    | governs the distribution |
    |  of the Linux operating  |
    | system.                  |
    |                          |


    .. raw:: html

       </p>

    .. code:: SCREEN

        bash$ grep Linux osinfo.txt /dev/null
        osinfo.txt:This is a file containing information about Linux.
         osinfo.txt:The GPL governs the distribution of the Linux operating system.


    .. raw:: html

       </p>

    .. code:: SCREEN

        bash$ grep Linux osinfo.txt /dev/null
        osinfo.txt:This is a file containing information about Linux.
         osinfo.txt:The GPL governs the distribution of the Linux operating system.


    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    If there is a successful match, **grep** returns an `exit
    status <exit-status.html#EXITSTATUSREF>`__ of 0, which makes it
    useful in a condition test in a script, especially in combination
    with the ``         -q        `` option to suppress output.

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        SUCCESS=0                      # if grep lookup succeeds
        word=Linux
        filename=data.file

        grep -q "$word" "$filename"    #  The "-q" option
                                       #+ causes nothing to echo to stdout.
        if [ $? -eq $SUCCESS ]
        # if grep -q "$word" "$filename"   can replace lines 5 - 7.
        then
          echo "$word found in $filename"
        else
          echo "$word not found in $filename"
        fi

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    `Example 32-6 <debugging.html#ONLINE>`__ demonstrates how to use
    **grep** to search for a word pattern in a system logfile.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-17. Emulating *grep* in a script**

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # grp.sh: Rudimentary reimplementation of grep.

        E_BADARGS=85

        if [ -z "$1" ]    # Check for argument to script.
        then
          echo "Usage: `basename $0` pattern"
          exit $E_BADARGS
        fi

        echo

        for file in *     # Traverse all files in $PWD.
        do
          output=$(sed -n /"$1"/p $file)  # Command substitution.

          if [ ! -z "$output" ]           # What happens if "$output" is not quoted?
          then
            echo -n "$file: "
            echo "$output"
          fi              #  sed -ne "/$1/s|^|${file}: |p"  is equivalent to above.

          echo
        done

        echo

        exit 0

        # Exercises:
        # ---------
        # 1) Add newlines to output, if more than one match in any given file.
        # 2) Add features.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    How can **grep** search for two (or more) separate patterns? What if
    you want **grep** to display all lines in a file or files that
    contain both "pattern1" *and* "pattern2" ?

    One method is to `pipe <special-chars.html#PIPEREF>`__ the result of
    **grep pattern1** to **grep pattern2** .

    For example, given the following file:

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        # Filename: tstfile

        This is a sample file.
        This is an ordinary text file.
        This file does not contain any unusual text.
        This file is not unusual.
        Here is some text.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    Now, let's search this file for lines containing *both* "file" and
    "text" . . .

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ grep file tstfile
        # Filename: tstfile
         This is a sample file.
         This is an ordinary text file.
         This file does not contain any unusual text.
         This file is not unusual.

        bash$ grep file tstfile | grep text
        This is an ordinary text file.
         This file does not contain any unusual text.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    Now, for an interesting recreational use of *grep* . . .

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-18. Crossword puzzle solver**

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # cw-solver.sh
        # This is actually a wrapper around a one-liner (line 46).

        #  Crossword puzzle and anagramming word game solver.
        #  You know *some* of the letters in the word you're looking for,
        #+ so you need a list of all valid words
        #+ with the known letters in given positions.
        #  For example: w...i....n
        #               1???5????10
        # w in position 1, 3 unknowns, i in the 5th, 4 unknowns, n at the end.
        # (See comments at end of script.)


        E_NOPATT=71
        DICT=/usr/share/dict/word.lst
        #                    ^^^^^^^^   Looks for word list here.
        #  ASCII word list, one word per line.
        #  If you happen to need an appropriate list,
        #+ download the author's "yawl" word list package.
        #  http://ibiblio.org/pub/Linux/libs/yawl-0.3.2.tar.gz
        #  or
        #  http://bash.deta.in/yawl-0.3.2.tar.gz


        if [ -z "$1" ]   #  If no word pattern specified
        then             #+ as a command-line argument . . .
          echo           #+ . . . then . . .
          echo "Usage:"  #+ Usage message.
          echo
          echo ""$0" \"pattern,\""
          echo "where \"pattern\" is in the form"
          echo "xxx..x.x..."
          echo
          echo "The x's represent known letters,"
          echo "and the periods are unknown letters (blanks)."
          echo "Letters and periods can be in any position."
          echo "For example, try:   sh cw-solver.sh w...i....n"
          echo
          exit $E_NOPATT
        fi

        echo
        # ===============================================
        # This is where all the work gets done.
        grep ^"$1"$ "$DICT"   # Yes, only one line!
        #    |    |
        # ^ is start-of-word regex anchor.
        # $ is end-of-word regex anchor.

        #  From _Stupid Grep Tricks_, vol. 1,
        #+ a book the ABS Guide author may yet get around
        #+ to writing . . . one of these days . . .
        # ===============================================
        echo


        exit $?  # Script terminates here.
        #  If there are too many words generated,
        #+ redirect the output to a file.

        $ sh cw-solver.sh w...i....n

        wellington
        workingman
        workingmen

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

     **egrep** -- *extended grep* -- is the same as **grep -E** . This
    uses a somewhat different, extended set of `Regular
    Expressions <regexp.html#REGEXREF>`__ , which can make the search a
    bit more flexible. It also allows the boolean \| ( *or* ) operator.

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash $ egrep 'matches|Matches' file.txt
        Line 1 matches.
         Line 3 Matches.
         Line 4 contains matches, but also Matches


    .. raw:: html

       </p>

    .. raw:: html

       </div>

     **fgrep** -- *fast grep* -- is the same as **grep -F** . It does a
    literal string search (no `Regular
    Expressions <regexp.html#REGEXREF>`__ ), which generally speeds
    things up a bit.

    .. raw:: html

       <div class="NOTE">

    .. raw:: html

       <div>

    |Note|

    On some Linux distros, **egrep** and **fgrep** are symbolic links
    to, or aliases for **grep** , but invoked with the
    ``            -E           `` and ``            -F           ``
    options, respectively.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-19. Looking up definitions in *Webster's 1913
    Dictionary***

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # dict-lookup.sh

        #  This script looks up definitions in the 1913 Webster's Dictionary.
        #  This Public Domain dictionary is available for download
        #+ from various sites, including
        #+ Project Gutenberg (http://www.gutenberg.org/etext/247).
        #
        #  Convert it from DOS to UNIX format (with only LF at end of line)
        #+ before using it with this script.
        #  Store the file in plain, uncompressed ASCII text.
        #  Set DEFAULT_DICTFILE variable below to path/filename.


        E_BADARGS=85
        MAXCONTEXTLINES=50                        # Maximum number of lines to show.
        DEFAULT_DICTFILE="/usr/share/dict/webster1913-dict.txt"
                                                  # Default dictionary file pathname.
                                                  # Change this as necessary.
        #  Note:
        #  ----
        #  This particular edition of the 1913 Webster's
        #+ begins each entry with an uppercase letter
        #+ (lowercase for the remaining characters).
        #  Only the *very first line* of an entry begins this way,
        #+ and that's why the search algorithm below works.



        if [[ -z $(echo "$1" | sed -n '/^[A-Z]/p') ]]
        #  Must at least specify word to look up, and
        #+ it must start with an uppercase letter.
        then
          echo "Usage: `basename $0` Word-to-define [dictionary-file]"
          echo
          echo "Note: Word to look up must start with capital letter,"
          echo "with the rest of the word in lowercase."
          echo "--------------------------------------------"
          echo "Examples: Abandon, Dictionary, Marking, etc."
          exit $E_BADARGS
        fi


        if [ -z "$2" ]                            #  May specify different dictionary
                                                  #+ as an argument to this script.
        then
          dictfile=$DEFAULT_DICTFILE
        else
          dictfile="$2"
        fi

        # ---------------------------------------------------------
        Definition=$(fgrep -A $MAXCONTEXTLINES "$1 \\" "$dictfile")
        #                  Definitions in form "Word \..."
        #
        #  And, yes, "fgrep" is fast enough
        #+ to search even a very large text file.


        # Now, snip out just the definition block.

        echo "$Definition" |
        sed -n '1,/^[A-Z]/p' |
        #  Print from first line of output
        #+ to the first line of the next entry.
        sed '$d' | sed '$d'
        #  Delete last two lines of output
        #+ (blank line and first line of next entry).
        # ---------------------------------------------------------

        exit $?

        # Exercises:
        # ---------
        # 1)  Modify the script to accept any type of alphabetic input
        #   + (uppercase, lowercase, mixed case), and convert it
        #   + to an acceptable format for processing.
        #
        # 2)  Convert the script to a GUI application,
        #   + using something like 'gdialog' or 'zenity' . . .
        #     The script will then no longer take its argument(s)
        #   + from the command-line.
        #
        # 3)  Modify the script to parse one of the other available
        #   + Public Domain Dictionaries, such as the U.S. Census Bureau Gazetteer.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    .. raw:: html

       <div>

    |Note|

    See also `Example A-41 <contributed-scripts.html#QKY>`__ for an
    example of speedy *fgrep* lookup on a large text file.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    **agrep** ( *approximate grep* ) extends the capabilities of
    **grep** to approximate matching. The search string may differ by a
    specified number of characters from the resulting matches. This
    utility is not part of the core Linux distribution.

    .. raw:: html

       <div class="TIP">

    .. raw:: html

       <div>

    |Tip|

    To search compressed files, use **zgrep** , **zegrep** , or
    **zfgrep** . These also work on non-compressed files, though slower
    than plain **grep** , **egrep** , **fgrep** . They are handy for
    searching through a mixed set of files, some compressed, some not.

    To search `bzipped <filearchiv.html#BZIPREF>`__ files, use
    **bzgrep** .

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # lookup: Does a dictionary lookup on each word in a data file.

        file=words.data  # Data file from which to read words to test.

        echo
        echo "Testing file $file"
        echo

        while [ "$word" != end ]  # Last word in data file.
        do               # ^^^
          read word      # From data file, because of redirection at end of loop.
          look $word > /dev/null  # Don't want to display lines in dictionary file.
          #  Searches for words in the file /usr/share/dict/words
          #+ (usually a link to linux.words).
          lookup=$?      # Exit status of 'look' command.

          if [ "$lookup" -eq 0 ]
          then
            echo "\"$word\" is valid."
          else
            echo "\"$word\" is invalid."
          fi

        done <"$file"    # Redirects stdin to $file, so "reads" come from there.

        echo

        exit 0

        # ----------------------------------------------------------------
        # Code below line will not execute because of "exit" command above.


        # Stephane Chazelas proposes the following, more concise alternative:

        while read word && [[ $word != end ]]
        do if look "$word" > /dev/null
           then echo "\"$word\" is valid."
           else echo "\"$word\" is invalid."
           fi
        done <"$file"

        exit 0

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash $ wc /usr/share/doc/sed-4.1.2/README
        13  70  447 README
        [13 lines  70 words  447 characters]

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        $ ls *.txt | wc -l
        #  Will work as long as none of the "*.txt" files
        #+ have a linefeed embedded in their name.

        #  Alternative ways of doing this are:
        #      find . -maxdepth 1 -name \*.txt -print0 | grep -cz .
        #      (shopt -s nullglob; set -- *.txt; echo $#)

        #  Thanks, S.C.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    Using **wc** to total up the size of all the files whose names begin
    with letters in the range d - h

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ wc [d-h]* | grep total | awk '{print $3}'
        71832


    .. raw:: html

       </p>

    .. raw:: html

       </div>

    Using **wc** to count the instances of the word "Linux" in the main
    source file for this book.

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ grep Linux abs-book.sgml | wc -l
        138


    .. raw:: html

       </p>

    .. raw:: html

       </div>

    See also `Example 16-39 <filearchiv.html#EX52>`__ and `Example
    20-8 <redircb.html#REDIR4>`__ .

    Certain commands include some of the functionality of **wc** as
    options.

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        ... | grep foo | wc -l
        # This frequently used construct can be more concisely rendered.

        ... | grep -c foo
        # Just use the "-c" (or "--count") option of grep.

        # Thanks, S.C.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

 **tr**
    character translation filter.

    .. raw:: html

       <div class="CAUTION">

    .. raw:: html

       <div>

    |Caution|

    `Must use quoting and/or brackets <special-chars.html#UCREF>`__ , as
    appropriate. Quotes prevent the shell from reinterpreting the
    special characters in **tr** command sequences. Brackets should be
    quoted to prevent expansion by the shell.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        echo "abcdef"                 # abcdef
        echo "abcdef" | tr -d b-d     # aef


        tr -d 0-9 <filename
        # Deletes all digits from the file "filename".

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    The ``         --squeeze-repeats        `` (or
    ``         -s        `` ) option deletes all but the first instance
    of a string of consecutive characters. This option is useful for
    removing excess `whitespace <special-chars.html#WHITESPACEREF>`__ .

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ echo "XXXXX" | tr --squeeze-repeats 'X'
        X

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    The ``         -c        `` "complement" option *inverts* the
    character set to match. With this option, **tr** acts only upon
    those characters *not* matching the specified set.

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ echo "acfdeb123" | tr -c b-d +
        +c+d+b++++

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    Note that **tr** recognizes `POSIX character
    classes <x17129.html#POSIXREF>`__ . ` [1]
     <textproc.html#FTN.AEN11502>`__

    .. raw:: html

       <div>

    .. code:: SCREEN

        bash$ echo "abcd2ef1" | tr '[:alpha:]' -
        ----2--1


    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-21. *toupper* : Transforms a file to all uppercase.**

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # Changes a file to all uppercase.

        E_BADARGS=85

        if [ -z "$1" ]  # Standard check for command-line arg.
        then
          echo "Usage: `basename $0` filename"
          exit $E_BADARGS
        fi

        tr a-z A-Z <"$1"

        # Same effect as above, but using POSIX character set notation:
        #        tr '[:lower:]' '[:upper:]' <"$1"
        # Thanks, S.C.

        #     Or even . . .
        #     cat "$1" | tr a-z A-Z
        #     Or dozens of other ways . . .

        exit 0

        #  Exercise:
        #  Rewrite this script to give the option of changing a file
        #+ to *either* upper or lowercase.
        #  Hint: Use either the "case" or "select" command.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-22. *lowercase* : Changes all filenames in working
    directory to lowercase.**

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        #
        #  Changes every filename in working directory to all lowercase.
        #
        #  Inspired by a script of John Dubois,
        #+ which was translated into Bash by Chet Ramey,
        #+ and considerably simplified by the author of the ABS Guide.


        for filename in *                # Traverse all files in directory.
        do
           fname=`basename $filename`
           n=`echo $fname | tr A-Z a-z`  # Change name to lowercase.
           if [ "$fname" != "$n" ]       # Rename only files not already lowercase.
           then
             mv $fname $n
           fi
        done

        exit $?


        # Code below this line will not execute because of "exit".
        #--------------------------------------------------------#
        # To run it, delete script above line.

        # The above script will not work on filenames containing blanks or newlines.
        # Stephane Chazelas therefore suggests the following alternative:


        for filename in *    # Not necessary to use basename,
                             # since "*" won't return any file containing "/".
        do n=`echo "$filename/" | tr '[:upper:]' '[:lower:]'`
        #                             POSIX char set notation.
        #                    Slash added so that trailing newlines are not
        #                    removed by command substitution.
           # Variable substitution:
           n=${n%/}          # Removes trailing slash, added above, from filename.
           [[ $filename == $n ]] || mv "$filename" "$n"
                             # Checks if filename already lowercase.
        done

        exit $?

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-23. *du* : DOS to UNIX text file conversion.**

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # Du.sh: DOS to UNIX text file converter.

        E_WRONGARGS=85

        if [ -z "$1" ]
        then
          echo "Usage: `basename $0` filename-to-convert"
          exit $E_WRONGARGS
        fi

        NEWFILENAME=$1.unx

        CR='\015'  # Carriage return.
                   # 015 is octal ASCII code for CR.
                   # Lines in a DOS text file end in CR-LF.
                   # Lines in a UNIX text file end in LF only.

        tr -d $CR < $1 > $NEWFILENAME
        # Delete CR's and write to new file.

        echo "Original DOS text file is \"$1\"."
        echo "Converted UNIX text file is \"$NEWFILENAME\"."

        exit 0

        # Exercise:
        # --------
        # Change the above script to convert from UNIX to DOS.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-24. *rot13* : ultra-weak encryption.**

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # rot13.sh: Classic rot13 algorithm,
        #           encryption that might fool a 3-year old
        #           for about 10 minutes.

        # Usage: ./rot13.sh filename
        # or     ./rot13.sh <filename
        # or     ./rot13.sh and supply keyboard input (stdin)

        cat "$@" | tr 'a-zA-Z' 'n-za-mN-ZA-M'   # "a" goes to "n", "b" to "o" ...
        #  The   cat "$@"   construct
        #+ permits input either from stdin or from files.

        exit 0

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-25. Generating "Crypto-Quote" Puzzles**

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # crypto-quote.sh: Encrypt quotes

        #  Will encrypt famous quotes in a simple monoalphabetic substitution.
        #  The result is similar to the "Crypto Quote" puzzles
        #+ seen in the Op Ed pages of the Sunday paper.


        key=ETAOINSHRDLUBCFGJMQPVWZYXK
        # The "key" is nothing more than a scrambled alphabet.
        # Changing the "key" changes the encryption.

        # The 'cat "$@"' construction gets input either from stdin or from files.
        # If using stdin, terminate input with a Control-D.
        # Otherwise, specify filename as command-line parameter.

        cat "$@" | tr "a-z" "A-Z" | tr "A-Z" "$key"
        #        |  to uppercase  |     encrypt
        # Will work on lowercase, uppercase, or mixed-case quotes.
        # Passes non-alphabetic characters through unchanged.


        # Try this script with something like:
        # "Nothing so needs reforming as other people's habits."
        # --Mark Twain
        #
        # Output is:
        # "CFPHRCS QF CIIOQ MINFMBRCS EQ FPHIM GIFGUI'Q HETRPQ."
        # --BEML PZERC

        # To reverse the encryption:
        # cat "$@" | tr "$key" "A-Z"


        #  This simple-minded cipher can be broken by an average 12-year old
        #+ using only pencil and paper.

        exit 0

        #  Exercise:
        #  --------
        #  Modify the script so that it will either encrypt or decrypt,
        #+ depending on command-line argument(s).

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

     Of course, *tr* lends itself to *code obfuscation* .

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # jabh.sh

        x="wftedskaebjgdBstbdbsmnjgz"
        echo $x | tr "a-z" 'oh, turtleneck Phrase Jar!'

        # Based on the Wikipedia "Just another Perl hacker" article.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       <div>

    .. raw:: html

       <div class="SIDEBAR">

    ***tr* variants**

    The **tr** utility has two historic variants. The BSD version does
    not use brackets (
    ``                         tr a-z A-Z                       `` ),
    but the SysV one does (
    ``                         tr '[a-z]' '[A-Z]'                       ``
    ). The GNU version of **tr** resembles the BSD one.

    .. raw:: html

       </div>

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash

        WIDTH=40                    # 40 columns wide.

        b=`ls /usr/local/bin`       # Get a file listing...

        echo $b | fmt -w $WIDTH

        # Could also have been done by
        #    echo $b | fold - -s -w $WIDTH

        exit 0

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       </div>

    See also `Example 16-5 <moreadv.html#EX41>`__ .

    .. raw:: html

       <div class="TIP">

    .. raw:: html

       <div>

    |Tip|

    A powerful alternative to **fmt** is Kamil Toman's **par** utility,
    available from http://www.cs.berkeley.edu/~amc/Par/ .

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # colms.sh
        # A minor modification of the example file in the "column" man page.


        (printf "PERMISSIONS LINKS OWNER GROUP SIZE MONTH DAY HH:MM PROG-NAME\n" \
        ; ls -l | sed 1d) | column -t
        #         ^^^^^^           ^^

        #  The "sed 1d" in the pipe deletes the first line of output,
        #+ which would be "total        N",
        #+ where "N" is the total number of files found by "ls -l".

        # The -t option to "column" pretty-prints a table.

        exit 0

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    |Caution|

    If the file contains tabs or nonprintable characters, this may cause
    unpredictable behavior. In such cases, consider using
    `expand <textproc.html#EXPANDREF>`__ and **unexpand** in a pipe
    preceding **colrm** .

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # line-number.sh

        # This script echoes itself twice to stdout with its lines numbered.

        echo "     line number = $LINENO" # 'nl' sees this as line 4
        #                                   (nl does not number blank lines).
        #                                   'cat -n' sees it correctly as line #6.

        nl `basename $0`

        echo; echo  # Now, let's try it with 'cat -n'

        cat -n `basename $0`
        # The difference is that 'cat -n' numbers the blank lines.
        # Note that 'nl -ba' will also do so.

        exit 0
        # -----------------------------------------------------------------

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        # Convert a string from UTF-8 to UTF-16 and print to the BookList
        function write_utf8_string {
            STRING=$1
            BOOKLIST=$2
            echo -n "$STRING" | iconv -f UTF8 -t UTF16 | \
            cut -b 3- | tr -d \\n >> "$BOOKLIST"
        }

        #  From Peter Knowles' "booklistgen.sh" script
        #+ for converting files to Sony Librie/PRS-50X format.
        #  (http://booklistgensh.peterknowles.com)

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        texexec --pdfarrange --result=Concatenated.pdf *pdf

        #  Concatenates all the pdf files in the current working directory
        #+ into the merged file, Concatenated.pdf . . .
        #  (The --pdfarrange option repaginates a pdf file. See also --pdfcombine.)
        #  The above command-line could be parameterized and put into a shell script.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

    .. raw:: html

       <div>

    .. code:: PROGRAMLISTING

        #!/bin/bash
        # manview.sh: Formats the source of a man page for viewing.

        #  This script is useful when writing man page source.
        #  It lets you look at the intermediate results on the fly
        #+ while working on it.

        E_WRONGARGS=85

        if [ -z "$1" ]
        then
          echo "Usage: `basename $0` filename"
          exit $E_WRONGARGS
        fi

        # ---------------------------
        groff -Tascii -man $1 | less
        # From the man page for groff.
        # ---------------------------

        #  If the man page includes tables and/or equations,
        #+ then the above code will barf.
        #  The following line can handle such cases.
        #
        #   gtbl < "$1" | geqn -Tlatin1 | groff -Tlatin1 -mtty-char -man
        #
        #   Thanks, S.C.

        exit $?   # See also the "maned.sh" script.

    .. raw:: html

       </p>

    .. raw:: html

       </div>

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

.. raw:: html

   <div>

` [1]  <textproc.html#AEN11502>`__

This is only true of the GNU version of **tr** , not the generic version
often found on commercial UNIX systems.

.. raw:: html

   </p>

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Tip| image:: ../images/tip.gif
.. |Caution| image:: ../images/caution.gif
