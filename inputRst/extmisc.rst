################################
XXX 16.9. Miscellaneous Commands
################################


** Command that fit in no special category**

 **jot** , **seq**
    These utilities emit a sequence of integers, with a user-selectable
    increment.

    The default separator character between each integer is a newline,
    but this can be changed with the ``         -s        `` option.


    .. code-block:: sh

        bash$ seq 5
        1
         2
         3
         4
         5



        bash$ seq -s : 5
        1:2:3:4:5




    Both **jot** and **seq** come in handy in a `for
    loop <loops1.html#FORLOOPREF1>`__ .


Exemple 54. Using *seq* to generate loop arguments
==================================================


    .. code-block:: sh

        #!/bin/bash
        # Using "seq"

        echo

        for a in `seq 80`  # or   for a in $( seq 80 )
        # Same as   for a in 1 2 3 4 5 ... 80   (saves much typing!).
        # May also use 'jot' (if present on system).
        do
          echo -n "$a "
        done      # 1 2 3 4 5 ... 80
        # Example of using the output of a command to generate
        # the [list] in a "for" loop.

        echo; echo


        COUNT=80  # Yes, 'seq' also accepts a replaceable parameter.

        for a in `seq $COUNT`  # or   for a in $( seq $COUNT )
        do
          echo -n "$a "
        done      # 1 2 3 4 5 ... 80

        echo; echo

        BEGIN=75
        END=80

        for a in `seq $BEGIN $END`
        #  Giving "seq" two arguments starts the count at the first one,
        #+ and continues until it reaches the second.
        do
          echo -n "$a "
        done      # 75 76 77 78 79 80

        echo; echo

        BEGIN=45
        INTERVAL=5
        END=80

        for a in `seq $BEGIN $INTERVAL $END`
        #  Giving "seq" three arguments starts the count at the first one,
        #+ uses the second for a step interval,
        #+ and continues until it reaches the third.
        do
          echo -n "$a "
        done      # 45 50 55 60 65 70 75 80

        echo; echo

        exit 0




    A simpler example:


    .. code-block:: sh

        #  Create a set of 10 files,
        #+ named file.1, file.2 . . . file.10.
        COUNT=10
        PREFIX=file

        for filename in `seq $COUNT`
        do
          touch $PREFIX.$filename
          #  Or, can do other operations,
          #+ such as rm, grep, etc.
        done




Exemple 55. Letter Count"
=========================


    .. code-block:: sh

        #!/bin/bash
        # letter-count.sh: Counting letter occurrences in a text file.
        # Written by Stefano Palmeri.
        # Used in ABS Guide with permission.
        # Slightly modified by document author.

        MINARGS=2          # Script requires at least two arguments.
        E_BADARGS=65
        FILE=$1

        let LETTERS=$#-1   # How many letters specified (as command-line args).
                           # (Subtract 1 from number of command-line args.)


        show_help(){
               echo
                   echo Usage: `basename $0` file letters
                   echo Note: `basename $0` arguments are case sensitive.
                   echo Example: `basename $0` foobar.txt G n U L i N U x.
               echo
        }

        # Checks number of arguments.
        if [ $# -lt $MINARGS ]; then
           echo
           echo "Not enough arguments."
           echo
           show_help
           exit $E_BADARGS
        fi


        # Checks if file exists.
        if [ ! -f $FILE ]; then
            echo "File \"$FILE\" does not exist."
            exit $E_BADARGS
        fi



        # Counts letter occurrences .
        for n in `seq $LETTERS`; do
              shift
              if [[ `echo -n "$1"wc -c` -eq 1 ]]; then             #  Checks arg.
                     echo "$1" -\> `cat $FILEtr -cd  "$1" | wc -c` #  Counting.
              else
                     echo "$1 is not a  single char."
              fi
        done

        exit $?

        #  This script has exactly the same functionality as letter-count2.sh,
        #+ but executes faster.
        #  Why?






    |Note

    Somewhat more capable than *seq* , **jot** is a classic UNIX utility
    that is not normally included in a standard Linux distro. However,
    the source *rpm* is available for download from the `MIT
    repository <http://www.mit.edu/afs/athena/system/rhlinux/athena-9.0/free/SRPMS/athena-jot-9.0-3.src.rpm>`__
    .

    Unlike *seq* , **jot** can generate a sequence of random numbers,
    using the ``            -r           `` option.

.. code-block:: sh

    bash$ jot -r 3 999
    1069
     1272
     1428



    .. code-block:: sh

        bash$ jot -r 3 999
        1069
         1272
         1428


    .. code-block:: sh

        bash$ jot -r 3 999
        1069
         1272
         1428




 **getopt**
    The **getopt** command parses command-line options preceded by a
    `dash <special-chars.html#DASHREF>`__ . This external command
    corresponds to the `getopts <internal.html#GETOPTSX>`__ Bash
    builtin. Using **getopt** permits handling long options by means of
    the ``         -l        `` flag, and this also allows parameter
    reshuffling.


Exemple 56. Using *getopt* to parse command-line options
========================================================


    .. code-block:: sh

        #!/bin/bash
        # Using getopt

        # Try the following when invoking this script:
        #   sh ex33a.sh -a
        #   sh ex33a.sh -abc
        #   sh ex33a.sh -a -b -c
        #   sh ex33a.sh -d
        #   sh ex33a.sh -dXYZ
        #   sh ex33a.sh -d XYZ
        #   sh ex33a.sh -abcd
        #   sh ex33a.sh -abcdZ
        #   sh ex33a.sh -z
        #   sh ex33a.sh a
        # Explain the results of each of the above.

        E_OPTERR=65

        if [ "$#" -eq 0 ]
        then   # Script needs at least one command-line argument.
          echo "Usage $0 -[options a,b,c]"
          exit $E_OPTERR
        fi

        set -- `getopt "abcd:" "$@"`
        # Sets positional parameters to command-line arguments.
        # What happens if you use "$*" instead of "$@"?

        while [ ! -z "$1" ]
        do
          case "$1" in
            -a) echo "Option \"a\"";;
            -b) echo "Option \"b\"";;
            -c) echo "Option \"c\"";;
            -d) echo "Option \"d\" $2";;
             *) break;;
          esac

          shift
        done

        #  It is usually better to use the 'getopts' builtin in a script.
        #  See "ex33.sh."

        exit 0






    |Note

    As *Peggy Russell* points out:

    It is often necessary to include an `eval <internal.html#EVALREF>`__
    to correctly process
    `whitespace <special-chars.html#WHITESPACEREF>`__ and *quotes* .

.. code-block:: sh

    args=$(getopt -o a:b
c:d -- "$@")
    eval set -- "$args"



    .. code-block:: sh

        args=$(getopt -o a:bc:d -- "$@")
        eval set -- "$args"


    .. code-block:: sh

        args=$(getopt -o a:bc:d -- "$@")
        eval set -- "$args"




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

    ``                   yesfsck /dev/hda1                 `` runs
    **fsck** non-interactively (careful!).

    ``                   yesrm -r dirname                 `` has same
    effect as ``                   rm -rf dirname                 ``
    (careful!).



    |Warning

    Caution advised when piping *yes* to a potentially dangerous system
    command, such as `fsck <system.html#FSCKREF>`__ or
    `fdisk <system.html#FDISKREF>`__ . It might have unintended
    consequences.






    |Note

    The *yes* command parses variables, or more accurately, it echoes
    parsed variables. For example:

.. code-block:: sh

    bash$ yes $BASH_VERS
ION
    3.1.17(1)-release
     3.1.17(1)-release
     3.1.17(1)-release
     3.1.17(1)-release
     3.1.17(1)-release
     . . .



    This particular "feature" may be used to create a *very large* ASCII
    file on the fly:

.. code-block:: sh

    bash$ yes $PATH > hu
ge_file.txt
    Ctl-C



    Hit ``                       Ctl-C                     `` *very
    quickly* , or you just might get more than you bargained for. . . .


    .. code-block:: sh

        bash$ yes $BASH_VERSION
        3.1.17(1)-release
         3.1.17(1)-release
         3.1.17(1)-release
         3.1.17(1)-release
         3.1.17(1)-release
         . . .



    .. code-block:: sh

        bash$ yes $PATH > huge_file.txt
        Ctl-C



    .. code-block:: sh

        bash$ yes $BASH_VERSION
        3.1.17(1)-release
         3.1.17(1)-release
         3.1.17(1)-release
         3.1.17(1)-release
         3.1.17(1)-release
         . . .



    .. code-block:: sh

        bash$ yes $PATH > huge_file.txt
        Ctl-C





     The *yes* command may be emulated in a very simple script
    `function <functions.html#FUNCTIONREF>`__ .


    .. code-block:: sh

        yes ()
        { # Trivial emulation of "yes" ...
          local DEFAULT_TEXT="y"
          while [ true ]   # Endless loop.
          do
            if [ -z "$1" ]
            then
              echo "$DEFAULT_TEXT"
            else           # If argument ...
              echo "$1"    # ... expand and echo it.
            fi
          done             #  The only things missing are the
        }                  #+ --help and --version options.



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


    .. code-block:: sh

        bash$ printenvgrep HOME
        HOME=/home/bozo




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
    ``                   pr -options file1.txtlp                 ``

    Formatting packages, such as `groff <textproc.html#GROFFREF>`__ and
    *Ghostscript* may send their output directly to **lp** .

    ``         bash$        ``
    ``                   groff -Tascii file.trlp                 ``

    ``         bash$        ``
    ``                   gs -optionslp file.ps                 ``

    Related commands are **lpq** , for viewing the print queue, and
    **lprm** , for removing jobs from the print queue.

 **tee**
    [UNIX borrows an idea from the plumbing trade.]

    This is a redirection operator, but with a difference. Like the
    plumber's *tee,* it permits "siphoning off" *to a file* the output
    of a command or commands within a pipe, but without affecting the
    result. This is useful for printing an ongoing process to a file or
    paper, perhaps to keep track of it for debugging purposes.


    .. code-block:: sh

                                     (redirection)
                                    |----> to file

          ==========================|====================
          command ---> command ---> |tee ---> command ---> ---> output of pipe
          ===============================================





    .. code-block:: sh

        cat listfile*sort | tee check.file | uniq > result.file
        #                      ^^^^^^^^^^^^^^   ^^^^

        #  The file "check.file" contains the concatenated sorted "listfiles,"
        #+ before the duplicate lines are removed by 'uniq.'



 **mkfifo**
     This obscure command creates a *named pipe* , a temporary
    *first-in-first-out buffer* for transferring data between processes.
    ` [4]  <extmisc.html#FTN.AEN14280>`__ Typically, one process writes
    to the FIFO, and the other reads from it. See `Example
    A-14 <contributed-scripts.html#FIFO>`__ .


    .. code-block:: sh

        #!/bin/bash
        # This short script by Omair Eshkenazi.
        # Used in ABS Guide with permission (thanks!).

        mkfifo pipe1   # Yes, pipes can be given names.
        mkfifo pipe2   # Hence the designation "named pipe."

        (cut -d' ' -f1tr "a-z" "A-Z") >pipe2 <pipe1 &
        ls -ltr -s ' ' | cut -d' ' -f3,9- | tee pipe1
        cut -d' ' -f2paste - pipe2

        rm -f pipe1
        rm -f pipe2

        # No need to kill background processes when script terminates (why not?).

        exit $?

        Now, invoke the script and explain the output:
        sh mkfifo-example.sh

        4830.tar.gz          BOZO
        pipe1   BOZO
        pipe2   BOZO
        mkfifo-example.sh    BOZO
        Mixed.msg BOZO



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


    .. code-block:: sh

        # Converting a file to all uppercase:

        dd if=$filename conv=ucase > $filename.uppercase
        #                    lcase   # For lower case conversion



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


Exemple 57. A script that copies itself
=======================================


    .. code-block:: sh

        #!/bin/bash
        # self-copy.sh

        # This script copies itself.

        file_subscript=copy

        dd if=$0 of=$0.$file_subscript 2>/dev/null
        # Suppress messages from dd:   ^^^^^^^^^^^

        exit $?

        #  A program whose only output is its own source code
        #+ is called a "quine" per Willard Quine.
        #  Does this script qualify as a quine?





Exemple 58. Exercising *dd*
===========================


    .. code-block:: sh

        #!/bin/bash
        # exercising-dd.sh

        # Script by Stephane Chazelas.
        # Somewhat modified by ABS Guide author.

        infile=$0           # This script.
        outfile=log.txt     # Output file left behind.
        n=8
        p=11

        dd if=$infile of=$outfile bs=1 skip=$((n-1)) count=$((p-n+1)) 2> /dev/null
        # Extracts characters n to p (8 to 11) from this script ("bash").

        # ----------------------------------------------------------------

        echo -n "hello vertical world"dd cbs=1 conv=unblock 2> /dev/null
        # Echoes "hello vertical world" vertically downward.
        # Why? A newline follows each character dd emits.

        exit $?




    To demonstrate just how versatile **dd** is, let's use it to capture
    keystrokes.


Exemple 59. Capturing Keystrokes
================================


    .. code-block:: sh

        #!/bin/bash
        # dd-keypress.sh: Capture keystrokes without needing to press ENTER.


        keypresses=4                      # Number of keypresses to capture.


        old_tty_setting=$(stty -g)        # Save old terminal settings.

        echo "Press $keypresses keys."
        stty -icanon -echo                # Disable canonical mode.
                                          # Disable local echo.
        keys=$(dd bs=1 count=$keypresses 2> /dev/null)
        # 'dd' uses stdin, if "if" (input file) not specified.

        stty "$old_tty_setting"           # Restore old terminal settings.

        echo "You pressed the \"$keys\" keys."

        # Thanks, Stephane Chazelas, for showing the way.
        exit 0




    The **dd** command can do random access on a data stream.


    .. code-block:: sh

        echo -n .dd bs=1 seek=4 of=file conv=notrunc
        #  The "conv=notrunc" option means that the output file
        #+ will not be truncated.

        # Thanks, S.C.



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


Exemple 60. Preparing a bootable SD card for the *Raspberry Pi*
===============================================================


    .. code-block:: sh

        #!/bin/bash
        # rp.sdcard.sh
        # Preparing an SD card with a bootable image for the Raspberry Pi.

        # $1 = imagefile name
        # $2 = sdcard (device file)
        # Otherwise defaults to the defaults, see below.

        DEFAULTbs=4M                                 # Block size, 4 mb default.
        DEFAULTif="2013-07-26-wheezy-raspbian.img"   # Commonly used distro.
        DEFAULTsdcard="/dev/mmcblk0"                 # May be different. Check!
        ROOTUSER_NAME=root                           # Must run as root!
        E_NOTROOT=81
        E_NOIMAGE=82

        username=$(id -nu)                           # Who is running this script?
        if [ "$username" != "$ROOTUSER_NAME" ]
        then
          echo "This script must run as root or with root privileges."
          exit $E_NOTROOT
        fi

        if [ -n "$1" ]
        then
          imagefile="$1"
        else
          imagefile="$DEFAULTif"
        fi

        if [ -n "$2" ]
        then
          sdcard="$2"
        else
          sdcard="$DEFAULTsdcard"
        fi

        if [ ! -e $imagefile ]
        then
          echo "Image file \"$imagefile\" not found!"
          exit $E_NOIMAGE
        fi

        echo "Last chance to change your mind!"; echo
        read -s -n1 -p "Hit a key to write $imagefile to $sdcard [Ctl-c to exit]."
        echo; echo

        echo "Writing $imagefile to $sdcard ..."
        dd bs=$DEFAULTbs if=$imagefile of=$sdcard

        exit $?

        # Exercises:
        # ---------
        # 1) Provide additional error checking.
        # 2) Have script autodetect device file for SD card (difficult!).
        # 3) Have script sutodetect image file (*img) in $PWD.




    Other applications of **dd** include initializing temporary swap
    files ( `Example 31-2 <zeros.html#EX73>`__ ) and ramdisks ( `Example
    31-3 <zeros.html#RAMDISK>`__ ). It can even do a low-level copy of
    an entire hard drive partition, although this is not necessarily
    recommended.

    People (with presumably nothing better to do with their time) are
    constantly thinking of interesting applications of **dd** .


Exemple 61. Securely deleting a file
====================================


    .. code-block:: sh

        #!/bin/bash
        # blot-out.sh: Erase "all" traces of a file.

        #  This script overwrites a target file alternately
        #+ with random bytes, then zeros before finally deleting it.
        #  After that, even examining the raw disk sectors by conventional methods
        #+ will not reveal the original file data.

        PASSES=7         #  Number of file-shredding passes.
                         #  Increasing this slows script execution,
                         #+ especially on large target files.
        BLOCKSIZE=1      #  I/O with /dev/urandom requires unit block size,
                         #+ otherwise you get weird results.
        E_BADARGS=70     #  Various error exit codes.
        E_NOT_FOUND=71
        E_CHANGED_MIND=72

        if [ -z "$1" ]   # No filename specified.
        then
          echo "Usage: `basename $0` filename"
          exit $E_BADARGS
        fi

        file=$1

        if [ ! -e "$file" ]
        then
          echo "File \"$file\" not found."
          exit $E_NOT_FOUND
        fi

        echo; echo -n "Are you absolutely sure you want to blot out \"$file\" (y/n)? "
        read answer
        case "$answer" in
        [nN]) echo "Changed your mind, huh?"
              exit $E_CHANGED_MIND
              ;;
        *)    echo "Blotting out file \"$file\".";;
        esac


        flength=$(ls -l "$file"awk '{print $5}')  # Field 5 is file length.
        pass_count=1

        chmod u+w "$file"   # Allow overwriting/deleting the file.

        echo

        while [ "$pass_count" -le "$PASSES" ]
        do
          echo "Pass #$pass_count"
          sync         # Flush buffers.
          dd if=/dev/urandom of=$file bs=$BLOCKSIZE count=$flength
                       # Fill with random bytes.
          sync         # Flush buffers again.
          dd if=/dev/zero of=$file bs=$BLOCKSIZE count=$flength
                       # Fill with zeros.
          sync         # Flush buffers yet again.
          let "pass_count += 1"
          echo
        done


        rm -f $file    # Finally, delete scrambled and shredded file.
        sync           # Flush buffers a final time.

        echo "File \"$file\" blotted out and deleted."; echo


        exit 0

        #  This is a fairly secure, if inefficient and slow method
        #+ of thoroughly "shredding" a file.
        #  The "shred" command, part of the GNU "fileutils" package,
        #+ does the same thing, although more efficiently.

        #  The file cannot not be "undeleted" or retrieved by normal methods.
        #  However . . .
        #+ this simple method would *not* likely withstand
        #+ sophisticated forensic analysis.

        #  This script may not play well with a journaled file system.
        #  Exercise (difficult): Fix it so it does.



        #  Tom Vier's "wipe" file-deletion package does a much more thorough job
        #+ of file shredding than this simple script.
        #     http://www.ibiblio.org/pub/Linux/utils/file/wipe-2.0.0.tar.bz2

        #  For an in-depth analysis on the topic of file deletion and security,
        #+ see Peter Gutmann's paper,
        #+     "Secure Deletion of Data From Magnetic and Solid-State Memory".
        #       http://www.cs.auckland.ac.nz/~pgut001/pubs/secure_del.html




    See also the `dd thread <biblio.html#DDLINK>`__ entry in the
    `bibliography <biblio.html#BIBLIOREF>`__ .

 **od**
    The **od** , or *octal dump* filter converts input (or files) to
    octal (base-8) or other bases. This is useful for viewing or
    processing binary data files or otherwise unreadable system `device
    files <devref1.html#DEVFILEREF>`__ , such as
    ``         /dev/urandom        `` , and as a filter for binary data.


    .. code-block:: sh

        head -c4 /dev/urandomod -N4 -tu4 | sed -ne '1s/.* //p'
        # Sample output: 1324725719, 3918166450, 2989231420, etc.

        # From rnd.sh example script, by StÃ©phane Chazelas



    See also `Example 9-16 <randomvar.html#SEEDINGRANDOM>`__ and
    `Example A-36 <contributed-scripts.html#INSERTIONSORT>`__ .

 **hexdump**
    Performs a hexadecimal, octal, decimal, or ASCII dump of a binary
    file. This command is the rough equivalent of **od** , above, but
    not nearly as useful. May be used to view the contents of a binary
    file, in combination with `dd <extmisc.html#DDREF>`__ and
    `less <filearchiv.html#LESSREF>`__ .


    .. code-block:: sh

        dd if=/bin/lshexdump -C | less
        # The -C option nicely formats the output in tabular form.



 **objdump**
    Displays information about an object file or binary executable in
    either hexadecimal form or as a disassembled listing (with the
    ``         -d        `` option).


    .. code-block:: sh

        bash$ objdump -d /bin/ls
        /bin/ls:     file format elf32-i386

         Disassembly of section .init:

         080490bc <.init>:
          80490bc:       55                      push   %ebp
          80490bd:       89 e5                   mov    %esp,%ebp
          . . .




 **mcookie**
    This command generates a "magic cookie," a 128-bit (32-character)
    pseudorandom hexadecimal number, normally used as an authorization
    "signature" by the X server. This also available for use in a script
    as a "quick 'n dirty" random number.


    .. code-block:: sh

        random000=$(mcookie)



    Of course, a script could use `md5sum <filearchiv.html#MD5SUMREF>`__
    for the same purpose.


    .. code-block:: sh

        # Generate md5 checksum on the script itself.
        random001=`md5sum $0awk '{print $1}'`
        # Uses 'awk' to strip off the filename.



    The **mcookie** command gives yet another way to generate a "unique"
    filename.


Exemple 62. Filename generator
==============================


    .. code-block:: sh

        #!/bin/bash
        # tempfile-name.sh:  temp filename generator

        BASE_STR=`mcookie`   # 32-character magic cookie.
        POS=11               # Arbitrary position in magic cookie string.
        LEN=5                # Get $LEN consecutive characters.

        prefix=temp          #  This is, after all, a "temp" file.
                             #  For more "uniqueness," generate the
                             #+ filename prefix using the same method
                             #+ as the suffix, below.

        suffix=${BASE_STR:POS:LEN}
                             #  Extract a 5-character string,
                             #+ starting at position 11.

        temp_filename=$prefix.$suffix
                             # Construct the filename.

        echo "Temp filename = "$temp_filename""

        # sh tempfile-name.sh
        # Temp filename = temp.e19ea

        #  Compare this method of generating "unique" filenames
        #+ with the 'date' method in ex51.sh.

        exit 0




 **units**
    This utility converts between different *units of measure* . While
    normally invoked in interactive mode, **units** may find use in a
    script.


Exemple 63. Converting meters to miles
======================================


    .. code-block:: sh

        #!/bin/bash
        # unit-conversion.sh
        # Must have 'units' utility installed.


        convert_units ()  # Takes as arguments the units to convert.
        {
          cf=$(units "$1" "$2"sed --silent -e '1p' | awk '{print $2}')
          # Strip off everything except the actual conversion factor.
          echo "$cf"
        }

        Unit1=miles
        Unit2=meters
        cfactor=`convert_units $Unit1 $Unit2`
        quantity=3.73

        result=$(echo $quantity*$cfactorbc)

        echo "There are $result $Unit2 in $quantity $Unit1."

        #  What happens if you pass incompatible units,
        #+ such as "acres" and "miles" to the function?

        exit 0

        # Exercise: Edit this script to accept command-line parameters,
        #           with appropriate error checking, of course.




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


Exemple 64. Using *m4*
======================


    .. code-block:: sh

        #!/bin/bash
        # m4.sh: Using the m4 macro processor

        # Strings
        string=abcdA01
        echo "len($string)"m4                            #   7
        echo "substr($string,4)"m4                       # A01
        echo "regexp($string,[0-1][0-1],\&Z)"m4      # 01Z

        # Arithmetic
        var=99
        echo "incr($var)"m4                              #  100
        echo "eval($var / 3)"m4                          #   33

        exit




 **xmessage**
    This X-based variant of `echo <internal.html#ECHOREF>`__ pops up a
    message/query window on the desktop.


    .. code-block:: sh

        xmessage Left click to continue -button okay



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



    |Note

    The various behaviors of the executable must be defined within the
    code of the executable itself, analogous to something like the
    following in a shell script:

.. code-block:: sh

    case `basename $0` i
n
    "name1" ) do_somethi
ng;;
    "name2" ) do_somethi
ng_else;;
    "name3" ) do_yet_ano
ther_thing;;
    *       ) bail_out;;
    esac



    .. code-block:: sh

        case `basename $0` in
        "name1" ) do_something;;
        "name2" ) do_something_else;;
        "name3" ) do_yet_another_thing;;
        *       ) bail_out;;
        esac


    .. code-block:: sh

        case `basename $0` in
        "name1" ) do_something;;
        "name2" ) do_something_else;;
        "name3" ) do_yet_another_thing;;
        *       ) bail_out;;
        esac




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



Notes
~~~~~


` [1]  <extmisc.html#AEN14105>`__

This is actually a script adapted from the Debian Linux distribution.


` [2]  <extmisc.html#AEN14214>`__

The *print queue* is the group of jobs "waiting in line" to be printed.


` [3]  <extmisc.html#AEN14218>`__

Large mechanical *line printers* printed a single line of type at a time
onto joined sheets of *greenbar* paper, to the accompaniment of `a great
deal of noise <http://www.columbia.edu/cu/computinghistory/1403.html>`__
. The hardcopy thusly printed was referred to as a *printout* .


` [4]  <extmisc.html#AEN14280>`__

For an excellent overview of this topic, see Andy Vaught's article,
`Introduction to Named
Pipes <http://www2.linuxjournal.com/lj-issues/issue41/2156.html>`__ , in
the September, 1997 issue of `*Linux
Journal* <http://www.linuxjournal.com>`__ .


` [5]  <extmisc.html#AEN14318>`__

 EBCDIC (pronounced "ebb-sid-ick" ) is an acronym for Extended Binary
Coded Decimal Interchange Code, an obsolete IBM data format. A bizarre
application of the ``       conv=ebcdic      `` option of **dd** is as a
quick 'n easy, but not very secure text file encoder.

.. code-block:: sh

    cat $file | dd conv=
swab,ebcdic > $file_encr
ypted
    # Encode (looks like
 gibberish).
    # Might as well swit
ch bytes (swab), too, fo
r a little extra obscuri
ty.

    cat $file_encrypted
| dd conv=swab,ascii > $
file_plaintext
    # Decode.



.. code-block:: sh

    cat $filedd conv=swab,ebcdic > $file_encrypted
    # Encode (looks like gibberish).
    # Might as well switch bytes (swab), too, for a little extra obscurity.

    cat $file_encrypteddd conv=swab,ascii > $file_plaintext
    # Decode.


.. code-block:: sh

    cat $filedd conv=swab,ebcdic > $file_encrypted
    # Encode (looks like gibberish).
    # Might as well switch bytes (swab), too, for a little extra obscurity.

    cat $file_encrypteddd conv=swab,ascii > $file_plaintext
    # Decode.


` [6]  <extmisc.html#AEN14523>`__

A *macro* is a symbolic constant that expands into a command string or a
set of operations on parameters. Simply put, it's a shortcut or
abbreviation.



