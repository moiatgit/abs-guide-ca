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

`Prev <loops.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 11. Loops and Branches

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <nestedloops.html>`__

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

11.1. Loops
===========

A *loop* is a block of code that *iterates*
`[1] <loops1.html#FTN.AEN6560>`__ a list of commands as long as the
*loop control condition* is true.

.. raw:: html

   <div class="VARIABLELIST">

**for loops**

**for ``arg`` in ``[list]``**
    This is the basic looping construct. It differs significantly from
    its *C* counterpart.

    | **for** ``arg`` in [``list``\ ]
    |  do
    |  `` command(s)``...
    |  done

    .. raw:: html

       </p>

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | During each pass through the loop,   |
    | ``arg`` takes on the value of each   |
    | successive variable in the ``list``. |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     for arg in "$var1" " |
    | $var2" "$var3" ... "$var |
    | N"                       |
    |     # In pass 1 of the l |
    | oop, arg = $var1         |
    |     # In pass 2 of the l |
    | oop, arg = $var2         |
    |     # In pass 3 of the l |
    | oop, arg = $var3         |
    |     # ...                |
    |     # In pass N of the l |
    | oop, arg = $varN         |
    |                          |
    |     # Arguments in [list |
    | ] quoted to prevent poss |
    | ible word splitting.     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The argument ``list`` may contain `wild
    cards <special-chars.html#ASTERISKREF>`__.

    If *do* is on same line as *for*, there needs to be a semicolon
    after list.

    | **for** ``arg`` in [``list``\ ] ; do

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-1. Simple *for* loops**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Listing the planet |
    | s.                       |
    |                          |
    |     for planet in Mercur |
    | y Venus Earth Mars Jupit |
    | er Saturn Uranus Neptune |
    |  Pluto                   |
    |     do                   |
    |       echo $planet  # Ea |
    | ch planet on a separate  |
    | line.                    |
    |     done                 |
    |                          |
    |     echo; echo           |
    |                          |
    |     for planet in "Mercu |
    | ry Venus Earth Mars Jupi |
    | ter Saturn Uranus Neptun |
    | e Pluto"                 |
    |         # All planets on |
    |  same line.              |
    |         # Entire 'list'  |
    | enclosed in quotes creat |
    | es a single variable.    |
    |         # Why? Whitespac |
    | e incorporated into the  |
    | variable.                |
    |     do                   |
    |       echo $planet       |
    |     done                 |
    |                          |
    |     echo; echo "Whoops!  |
    | Pluto is no longer a pla |
    | net!"                    |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Each ``[list]`` element may contain multiple parameters. This is
    useful when processing parameters in groups. In such cases, use the
    `set <internal.html#SETREF>`__ command (see `Example
    15-16 <internal.html#EX34>`__) to force parsing of each ``[list]``
    element and assignment of each component to the positional
    parameters.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-2. *for* loop with two parameters in each [list]
    element**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Planets revisited. |
    |                          |
    |     # Associate the name |
    |  of each planet with its |
    |  distance from the sun.  |
    |                          |
    |     for planet in "Mercu |
    | ry 36" "Venus 67" "Earth |
    |  93"  "Mars 142" "Jupite |
    | r 483"                   |
    |     do                   |
    |       set -- $planet  #  |
    |  Parses variable "planet |
    | "                        |
    |                       #+ |
    |  and sets positional par |
    | ameters.                 |
    |       #  The "--" preven |
    | ts nasty surprises if $p |
    | lanet is null or         |
    |       #+ begins with a d |
    | ash.                     |
    |                          |
    |       #  May need to sav |
    | e original positional pa |
    | rameters,                |
    |       #+ since they get  |
    | overwritten.             |
    |       #  One way of doin |
    | g this is to use an arra |
    | y,                       |
    |       #         original |
    | _params=("$@")           |
    |                          |
    |       echo "$1      $2,0 |
    | 00,000 miles from the su |
    | n"                       |
    |       #-------two  tabs- |
    | --concatenate zeroes ont |
    | o parameter $2           |
    |     done                 |
    |                          |
    |     # (Thanks, S.C., for |
    |  additional clarificatio |
    | n.)                      |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    A variable may supply the ``[list]`` in a *for loop*.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-3. *Fileinfo:* operating on a file list contained in a
    variable**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # fileinfo.sh        |
    |                          |
    |     FILES="/usr/sbin/acc |
    | ept                      |
    |     /usr/sbin/pwck       |
    |     /usr/sbin/chroot     |
    |     /usr/bin/fakefile    |
    |     /sbin/badblocks      |
    |     /sbin/ypbind"     #  |
    | List of files you are cu |
    | rious about.             |
    |                       #  |
    | Threw in a dummy file, / |
    | usr/bin/fakefile.        |
    |                          |
    |     echo                 |
    |                          |
    |     for file in $FILES   |
    |     do                   |
    |                          |
    |       if [ ! -e "$file"  |
    | ]       # Check if file  |
    | exists.                  |
    |       then               |
    |         echo "$file does |
    |  not exist."; echo       |
    |         continue         |
    |         # On to next.    |
    |        fi                |
    |                          |
    |       ls -l $file | awk  |
    | '{ print $8 "         fi |
    | le size: " $5 }'  # Prin |
    | t 2 fields.              |
    |       whatis `basename $ |
    | file`   # File info.     |
    |       # Note that the wh |
    | atis database needs to h |
    | ave been set up for this |
    |  to work.                |
    |       # To do this, as r |
    | oot run /usr/bin/makewha |
    | tis.                     |
    |       echo               |
    |     done                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The ``[list]`` in a *for loop* may be parameterized.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-4. Operating on a parameterized file list**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     filename="*txt"      |
    |                          |
    |     for file in $filenam |
    | e                        |
    |     do                   |
    |      echo "Contents of $ |
    | file"                    |
    |      echo "---"          |
    |      cat "$file"         |
    |      echo                |
    |     done                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    If the ``[list]`` in a *for loop* contains wild cards (\* and ?)
    used in filename expansion, then `globbing <globbingref.html>`__
    takes place.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-5. Operating on files with a *for* loop**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # list-glob.sh: Gene |
    | rating [list] in a for-l |
    | oop, using "globbing" .. |
    | .                        |
    |     # Globbing = filenam |
    | e expansion.             |
    |                          |
    |     echo                 |
    |                          |
    |     for file in *        |
    |     #           ^  Bash  |
    | performs filename expans |
    | ion                      |
    |     #+             on ex |
    | pressions that globbing  |
    | recognizes.              |
    |     do                   |
    |       ls -l "$file"  # L |
    | ists all files in $PWD ( |
    | current directory).      |
    |       #  Recall that the |
    |  wild card character "*" |
    |  matches every filename, |
    |       #+ however, in "gl |
    | obbing," it doesn't matc |
    | h dot-files.             |
    |                          |
    |       #  If the pattern  |
    | matches no file, it is e |
    | xpanded to itself.       |
    |       #  To prevent this |
    | , set the nullglob optio |
    | n                        |
    |       #+   (shopt -s nul |
    | lglob).                  |
    |       #  Thanks, S.C.    |
    |     done                 |
    |                          |
    |     echo; echo           |
    |                          |
    |     for file in [jx]*    |
    |     do                   |
    |       rm -f $file    # R |
    | emoves only files beginn |
    | ing with "j" or "x" in $ |
    | PWD.                     |
    |       echo "Removed file |
    |  \"$file\"".             |
    |     done                 |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Omitting the ``in [list]`` part of a *for loop* causes the loop to
    operate on $@ -- the `positional
    parameters <internalvariables.html#POSPARAMREF>`__. A particularly
    clever illustration of this is `Example
    A-15 <contributed-scripts.html#PRIMES>`__. See also `Example
    15-17 <internal.html#REVPOSPARAMS>`__.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-6. Missing ``in [list]`` in a *for* loop**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     #  Invoke this scrip |
    | t both with and without  |
    | arguments,               |
    |     #+ and see what happ |
    | ens.                     |
    |                          |
    |     for a                |
    |     do                   |
    |      echo -n "$a "       |
    |     done                 |
    |                          |
    |     #  The 'in list' mis |
    | sing, therefore the loop |
    |  operates on '$@'        |
    |     #+ (command-line arg |
    | ument list, including wh |
    | itespace).               |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    It is possible to use `command
    substitution <commandsub.html#COMMANDSUBREF>`__ to generate the
    ``[list]`` in a *for loop*. See also `Example
    16-54 <extmisc.html#EX53>`__, `Example
    11-11 <loops1.html#SYMLINKS>`__ and `Example
    16-48 <mathc.html#BASE>`__.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-7. Generating the ``[list]`` in a *for* loop with
    command substitution**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     #  for-loopcmd.sh: f |
    | or-loop with [list]      |
    |     #+ generated by comm |
    | and substitution.        |
    |                          |
    |     NUMBERS="9 7 3 8 37. |
    | 53"                      |
    |                          |
    |     for number in `echo  |
    | $NUMBERS`  # for number  |
    | in 9 7 3 8 37.53         |
    |     do                   |
    |       echo -n "$number " |
    |     done                 |
    |                          |
    |     echo                 |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Here is a somewhat more complex example of using command
    substitution to create the ``[list]``.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-8. A *grep* replacement for binary files**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # bin-grep.sh: Locat |
    | es matching strings in a |
    |  binary file.            |
    |                          |
    |     # A "grep" replaceme |
    | nt for binary files.     |
    |     # Similar effect to  |
    | "grep -a"                |
    |                          |
    |     E_BADARGS=65         |
    |     E_NOFILE=66          |
    |                          |
    |     if [ $# -ne 2 ]      |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` search_string f |
    | ilename"                 |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |     if [ ! -f "$2" ]     |
    |     then                 |
    |       echo "File \"$2\"  |
    | does not exist."         |
    |       exit $E_NOFILE     |
    |     fi                   |
    |                          |
    |                          |
    |     IFS=$'\012'       #  |
    | Per suggestion of Anton  |
    | Filippov.                |
    |                       #  |
    | was:  IFS="\n"           |
    |     for word in $( strin |
    | gs "$2" | grep "$1" )    |
    |     # The "strings" comm |
    | and lists strings in bin |
    | ary files.               |
    |     # Output then piped  |
    | to "grep", which tests f |
    | or desired string.       |
    |     do                   |
    |       echo $word         |
    |     done                 |
    |                          |
    |     # As S.C. points out |
    | , lines 23 - 30 could be |
    |  replaced with the simpl |
    | er                       |
    |     #    strings "$2" |  |
    | grep "$1" | tr -s "$IFS" |
    |  '[\n*]'                 |
    |                          |
    |                          |
    |     #  Try something lik |
    | e  "./bin-grep.sh mem /b |
    | in/ls"                   |
    |     #+ to exercise this  |
    | script.                  |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    More of the same.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-9. Listing all users on the system**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # userlist.sh        |
    |                          |
    |     PASSWORD_FILE=/etc/p |
    | asswd                    |
    |     n=1           # User |
    |  number                  |
    |                          |
    |     for name in $(awk 'B |
    | EGIN{FS=":"}{print $1}'  |
    | < "$PASSWORD_FILE" )     |
    |     # Field separator =  |
    | :    ^^^^^^              |
    |     # Print first field  |
    |              ^^^^^^^^    |
    |     # Get input from pas |
    | sword file  /etc/passwd  |
    |  ^^^^^^^^^^^^^^^^^       |
    |     do                   |
    |       echo "USER #$n = $ |
    | name"                    |
    |       let "n += 1"       |
    |     done                 |
    |                          |
    |                          |
    |     # USER #1 = root     |
    |     # USER #2 = bin      |
    |     # USER #3 = daemon   |
    |     # ...                |
    |     # USER #33 = bozo    |
    |                          |
    |     exit $?              |
    |                          |
    |     #  Discussion:       |
    |     #  ----------        |
    |     #  How is it that an |
    |  ordinary user, or a scr |
    | ipt run by same,         |
    |     #+ can read /etc/pas |
    | swd? (Hint: Check the /e |
    | tc/passwd file permissio |
    | ns.)                     |
    |     #  Is this a securit |
    | y hole? Why or why not?  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Yet another example of the ``[list]`` resulting from command
    substitution.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-10. Checking all the binaries in a directory for
    authorship**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # findstring.sh:     |
    |     # Find a particular  |
    | string in the binaries i |
    | n a specified directory. |
    |                          |
    |     directory=/usr/bin/  |
    |     fstring="Free Softwa |
    | re Foundation"  # See wh |
    | ich files come from the  |
    | FSF.                     |
    |                          |
    |     for file in $( find  |
    | $directory -type f -name |
    |  '*' | sort )            |
    |     do                   |
    |       strings -f $file | |
    |  grep "$fstring" | sed - |
    | e "s%$directory%%"       |
    |       #  In the "sed" ex |
    | pression,                |
    |       #+ it is necessary |
    |  to substitute for the n |
    | ormal "/" delimiter      |
    |       #+ because "/" hap |
    | pens to be one of the ch |
    | aracters filtered out.   |
    |       #  Failure to do s |
    | o gives an error message |
    | . (Try it.)              |
    |     done                 |
    |                          |
    |     exit $?              |
    |                          |
    |     #  Exercise (easy):  |
    |     #  ---------------   |
    |     #  Convert this scri |
    | pt to take command-line  |
    | parameters               |
    |     #+ for $directory an |
    | d $fstring.              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    A final example of ``[list]`` / command substitution, but this time
    the "command" is a `function <functions.html#FUNCTIONREF>`__.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     generate_list ()     |
    |     {                    |
    |       echo "one two thre |
    | e"                       |
    |     }                    |
    |                          |
    |     for word in $(genera |
    | te_list)  # Let "word" g |
    | rab output of function.  |
    |     do                   |
    |       echo "$word"       |
    |     done                 |
    |                          |
    |     # one                |
    |     # two                |
    |     # three              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The output of a *for loop* may be piped to a command or commands.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-11. Listing the *symbolic links* in a directory**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # symlinks.sh: Lists |
    |  symbolic links in a dir |
    | ectory.                  |
    |                          |
    |                          |
    |     directory=${1-`pwd`} |
    |     #  Defaults to curre |
    | nt working directory,    |
    |     #+ if not otherwise  |
    | specified.               |
    |     #  Equivalent to cod |
    | e block below.           |
    |     # ------------------ |
    | ------------------------ |
    | ----------------         |
    |     # ARGS=1             |
    |      # Expect one comman |
    | d-line argument.         |
    |     #                    |
    |     # if [ $# -ne "$ARGS |
    | " ]  # If not 1 arg...   |
    |     # then               |
    |     #   directory=`pwd`  |
    |      # current working d |
    | irectory                 |
    |     # else               |
    |     #   directory=$1     |
    |     # fi                 |
    |     # ------------------ |
    | ------------------------ |
    | ----------------         |
    |                          |
    |     echo "symbolic links |
    |  in directory \"$directo |
    | ry\""                    |
    |                          |
    |     for file in "$( find |
    |  $directory -type l )"   |
    |  # -type l = symbolic li |
    | nks                      |
    |     do                   |
    |       echo "$file"       |
    |     done | sort          |
    |                          |
    |  # Otherwise file list i |
    | s unsorted.              |
    |     #  Strictly speaking |
    | , a loop isn't really ne |
    | cessary here,            |
    |     #+ since the output  |
    | of the "find" command is |
    |  expanded into a single  |
    | word.                    |
    |     #  However, it's eas |
    | y to understand and illu |
    | strative this way.       |
    |                          |
    |     #  As Dominik 'Aenea |
    | s' Schnitzer points out, |
    |     #+ failing to quote  |
    |  $( find $directory -typ |
    | e l )                    |
    |     #+ will choke on fil |
    | enames with embedded whi |
    | tespace.                 |
    |     #  containing whites |
    | pace.                    |
    |                          |
    |     exit 0               |
    |                          |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | --------------           |
    |     # Jean Helou propose |
    | s the following alternat |
    | ive:                     |
    |                          |
    |     echo "symbolic links |
    |  in directory \"$directo |
    | ry\""                    |
    |     # Backup of the curr |
    | ent IFS. One can never b |
    | e too cautious.          |
    |     OLDIFS=$IFS          |
    |     IFS=:                |
    |                          |
    |     for file in $(find $ |
    | directory -type l -print |
    | f "%p$IFS")              |
    |     do     #             |
    |                   ^^^^^^ |
    | ^^^^^^^^^^               |
    |            echo "$file"  |
    |            done|sort     |
    |                          |
    |     # And, James "Mike"  |
    | Conley suggests modifyin |
    | g Helou's code thusly:   |
    |                          |
    |     OLDIFS=$IFS          |
    |     IFS='' # Null IFS me |
    | ans no word breaks       |
    |     for file in $( find  |
    | $directory -type l )     |
    |     do                   |
    |       echo $file         |
    |       done | sort        |
    |                          |
    |     #  This works in the |
    |  "pathological" case of  |
    | a directory name having  |
    |     #+ an embedded colon |
    | .                        |
    |     #  "This also fixes  |
    | the pathological case of |
    |  the directory name havi |
    | ng                       |
    |     #+  a colon (or spac |
    | e in earlier example) as |
    |  well."                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The ``stdout`` of a loop may be
    `redirected <io-redirection.html#IOREDIRREF>`__ to a file, as this
    slight modification to the previous example shows.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-12. Symbolic links in a directory, saved to a file**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # symlinks.sh: Lists |
    |  symbolic links in a dir |
    | ectory.                  |
    |                          |
    |     OUTFILE=symlinks.lis |
    | t                        |
    |   # save-file            |
    |                          |
    |     directory=${1-`pwd`} |
    |     #  Defaults to curre |
    | nt working directory,    |
    |     #+ if not otherwise  |
    | specified.               |
    |                          |
    |                          |
    |     echo "symbolic links |
    |  in directory \"$directo |
    | ry\"" > "$OUTFILE"       |
    |     echo "-------------- |
    | -------------" >> "$OUTF |
    | ILE"                     |
    |                          |
    |     for file in "$( find |
    |  $directory -type l )"   |
    |   # -type l = symbolic l |
    | inks                     |
    |     do                   |
    |       echo "$file"       |
    |     done | sort >> "$OUT |
    | FILE"                    |
    |   # stdout of loop       |
    |     #           ^^^^^^^^ |
    | ^^^^^                    |
    |     redirected to save f |
    | ile.                     |
    |                          |
    |     # echo "Output file  |
    | = $OUTFILE"              |
    |                          |
    |     exit $?              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    There is an alternative syntax to a *for loop* that will look very
    familiar to C programmers. This requires `double
    parentheses <dblparens.html#DBLPARENSREF>`__.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-13. A C-style *for* loop**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Multiple ways to c |
    | ount up to 10.           |
    |                          |
    |     echo                 |
    |                          |
    |     # Standard syntax.   |
    |     for a in 1 2 3 4 5 6 |
    |  7 8 9 10                |
    |     do                   |
    |       echo -n "$a "      |
    |     done                 |
    |                          |
    |     echo; echo           |
    |                          |
    |     # +================= |
    | ======================== |
    | =+                       |
    |                          |
    |     # Using "seq" ...    |
    |     for a in `seq 10`    |
    |     do                   |
    |       echo -n "$a "      |
    |     done                 |
    |                          |
    |     echo; echo           |
    |                          |
    |     # +================= |
    | ======================== |
    | =+                       |
    |                          |
    |     # Using brace expans |
    | ion ...                  |
    |     # Bash, version 3+.  |
    |     for a in {1..10}     |
    |     do                   |
    |       echo -n "$a "      |
    |     done                 |
    |                          |
    |     echo; echo           |
    |                          |
    |     # +================= |
    | ======================== |
    | =+                       |
    |                          |
    |     # Now, let's do the  |
    | same, using C-like synta |
    | x.                       |
    |                          |
    |     LIMIT=10             |
    |                          |
    |     for ((a=1; a <= LIMI |
    | T ; a++))  # Double pare |
    | ntheses, and naked "LIMI |
    | T"                       |
    |     do                   |
    |       echo -n "$a "      |
    |     done                 |
    |            # A construct |
    |  borrowed from ksh93.    |
    |                          |
    |     echo; echo           |
    |                          |
    |     # +================= |
    | ======================== |
    | ======================== |
    | ========+                |
    |                          |
    |     # Let's use the C "c |
    | omma operator" to increm |
    | ent two variables simult |
    | aneously.                |
    |                          |
    |     for ((a=1, b=1; a <= |
    |  LIMIT ; a++, b++))      |
    |     do  # The comma conc |
    | atenates operations.     |
    |       echo -n "$a-$b "   |
    |     done                 |
    |                          |
    |     echo; echo           |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example 27-16 <arrays.html#QFUNCTION>`__, `Example
    27-17 <arrays.html#TWODIM>`__, and `Example
    A-6 <contributed-scripts.html#COLLATZ>`__.

    ---

    Now, a *for loop* used in a "real-life" context.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-14. Using *efax* in batch mode**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Faxing (must have  |
    | 'efax' package installed |
    | ).                       |
    |                          |
    |     EXPECTED_ARGS=2      |
    |     E_BADARGS=85         |
    |     MODEM_PORT="/dev/tty |
    | S2"   # May be different |
    |  on your machine.        |
    |     #                ^^^ |
    | ^^      PCMCIA modem car |
    | d default port.          |
    |                          |
    |     if [ $# -ne $EXPECTE |
    | D_ARGS ]                 |
    |     # Check for proper n |
    | umber of command-line ar |
    | gs.                      |
    |     then                 |
    |        echo "Usage: `bas |
    | ename $0` phone# text-fi |
    | le"                      |
    |        exit $E_BADARGS   |
    |     fi                   |
    |                          |
    |                          |
    |     if [ ! -f "$2" ]     |
    |     then                 |
    |       echo "File $2 is n |
    | ot a text file."         |
    |       #     File is not  |
    | a regular file, or does  |
    | not exist.               |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |                          |
    |     fax make $2          |
    |      #  Create fax-forma |
    | tted files from text fil |
    | es.                      |
    |                          |
    |     for file in $(ls $2. |
    | 0*)  #  Concatenate the  |
    | converted files.         |
    |                          |
    |      #  Uses wild card ( |
    | filename "globbing")     |
    |                  #+ in v |
    | ariable list.            |
    |     do                   |
    |       fil="$fil $file"   |
    |     done                 |
    |                          |
    |     efax -d "$MODEM_PORT |
    | "  -t "T$1" $fil   # Fin |
    | ally, do the work.       |
    |     # Trying adding  -o1 |
    |   if above line fails.   |
    |                          |
    |                          |
    |     #  As S.C. points ou |
    | t, the for-loop can be e |
    | liminated with           |
    |     #     efax -d /dev/t |
    | tyS2 -o1 -t "T$1" $2.0*  |
    |     #+ but it's not quit |
    | e as instructive [grin]. |
    |                          |
    |     exit $?   # Also, ef |
    | ax sends diagnostic mess |
    | ages to stdout.          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------------+--------------------+--------------------+--------------------+
    | |Note|             |
    | The                |
    | `keywords <interna |
    | l.html#KEYWORDREF> |
    | `__                |
    | **do** and         |
    | **done** delineate |
    | the *for-loop*     |
    | command block.     |
    | However, these     |
    | may, in certain    |
    | contexts, be       |
    | omitted by framing |
    | the command block  |
    | within `curly      |
    | brackets <special- |
    | chars.html#CODEBLO |
    | CKREF>`__          |
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
    | |     for((n=1; n< |
    | =10; n++ |         |
    | | ))               |
    |          |         |
    | |     # No do!     |
    |          |         |
    | |     {            |
    |          |         |
    | |       echo -n "* |
    |  $n *"   |         |
    | |     }            |
    |          |         |
    | |     # No done!   |
    |          |         |
    | |                  |
    |          |         |
    | |                  |
    |          |         |
    | |     # Outputs:   |
    |          |         |
    | |     # * 1 ** 2 * |
    | * 3 ** 4 |         |
    | |  ** 5 ** 6 ** 7  |
    | ** 8 **  |         |
    | | 9 ** 10 *        |
    |          |         |
    | |     # And, echo  |
    | $? retur |         |
    | | ns 0, so Bash do |
    | es not r |         |
    | | egister an error |
    | .        |         |
    | |                  |
    |          |         |
    | |                  |
    |          |         |
    | |     echo         |
    |          |         |
    | |                  |
    |          |         |
    | |                  |
    |          |         |
    | |     #  But, note |
    |  that in |         |
    | |  a classic for-l |
    | oop:     |         |
    | | for n in [list]  |
    | ...      |         |
    | |     #+ a termina |
    | l semico |         |
    | | lon is required. |
    |          |         |
    | |                  |
    |          |         |
    | |     for n in 1 2 |
    |  3       |         |
    | |     {  echo -n " |
    | $n "; }  |         |
    | |     #            |
    |     ^    |         |
    | |                  |
    |          |         |
    | |                  |
    |          |         |
    | |     # Thank you, |
    |  YongYe, |         |
    | |  for pointing th |
    | is out.  |         |
    |                    |
    |                    |
    | +----------------- |
    | ---------+-------- |
    | ------------------ |
    | +----------------- |
    | ---------+         |
    |                    |
    | .. raw:: html      |
    |                    |
    |    </p>            |
                        
    +--------------------+--------------------+--------------------+--------------------+

    .. raw:: html

       </div>

\ **while**
    This construct tests for a condition at the top of a loop, and keeps
    looping as long as that condition is true (returns a 0 `exit
    status <exit-status.html#EXITSTATUSREF>`__). In contrast to a `for
    loop <loops1.html#FORLOOPREF1>`__, a *while loop* finds use in
    situations where the number of loop repetitions is not known
    beforehand.

    | **while** [`` condition ``\ ]
    |  do
    |  `` command(s)``...
    |  done

    .. raw:: html

       </p>

    The bracket construct in a *while loop* is nothing more than our old
    friend, the `test brackets <testconstructs.html#TESTCONSTRUCTS1>`__
    used in an *if/then* test. In fact, a *while loop* can legally use
    the more versatile `double-brackets
    construct <testconstructs.html#DBLBRACKETS>`__ (while [[ condition
    ]]).

    `As is the case with *for loops* <loops1.html#NEEDSEMICOLON>`__,
    placing the *do* on the same line as the condition test requires a
    semicolon.

    **while** [`` condition ``\ ] ; do

    .. raw:: html

       </p>

    Note that the *test brackets* `are *not*
    mandatory <loops1.html#WHILENOBRACKETS>`__ in a *while* loop. See,
    for example, the `getopts construct <internal.html#GETOPTSX>`__.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-15. Simple *while* loop**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     var0=0               |
    |     LIMIT=10             |
    |                          |
    |     while [ "$var0" -lt  |
    | "$LIMIT" ]               |
    |     #      ^             |
    |         ^                |
    |     # Spaces, because th |
    | ese are "test-brackets"  |
    | . . .                    |
    |     do                   |
    |       echo -n "$var0 "   |
    |       # -n suppresses ne |
    | wline.                   |
    |       #             ^    |
    |         Space, to separa |
    | te printed out numbers.  |
    |                          |
    |       var0=`expr $var0 + |
    |  1`   # var0=$(($var0+1) |
    | )  also works.           |
    |                          |
    |       # var0=$((var0 + 1 |
    | )) also works.           |
    |                          |
    |       # let "var0 += 1"  |
    |    also works.           |
    |     done                 |
    |       # Various other me |
    | thods also work.         |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-16. Another *while* loop**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     echo                 |
    |                          |
    |            # Equivalent  |
    | to:                      |
    |     while [ "$var1" != " |
    | end" ]     # while test  |
    | "$var1" != "end"         |
    |     do                   |
    |       echo "Input variab |
    | le #1 (end to exit) "    |
    |       read var1          |
    |            # Not 'read $ |
    | var1' (why?).            |
    |       echo "variable #1  |
    | = $var1"   # Need quotes |
    |  because of "#" . . .    |
    |       # If input is 'end |
    | ', echoes it here.       |
    |       # Does not test fo |
    | r termination condition  |
    | until top of loop.       |
    |       echo               |
    |     done                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    A *while loop* may have multiple conditions. Only the final
    condition determines when the loop terminates. This necessitates a
    slightly different loop syntax, however.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-17. *while* loop with multiple conditions**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     var1=unset           |
    |     previous=$var1       |
    |                          |
    |     while echo "previous |
    | -variable = $previous"   |
    |           echo           |
    |           previous=$var1 |
    |           [ "$var1" != e |
    | nd ] # Keeps track of wh |
    | at $var1 was previously. |
    |           # Four conditi |
    | ons on *while*, but only |
    |  the final one controls  |
    | loop.                    |
    |           # The *last* e |
    | xit status is the one th |
    | at counts.               |
    |     do                   |
    |     echo "Input variable |
    |  #1 (end to exit) "      |
    |       read var1          |
    |       echo "variable #1  |
    | = $var1"                 |
    |     done                 |
    |                          |
    |     # Try to figure out  |
    | how this all works.      |
    |     # It's a wee bit tri |
    | cky.                     |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    As with a *for loop*, a *while loop* may employ C-style syntax by
    using the double-parentheses construct (see also `Example
    8-5 <dblparens.html#CVARS>`__).

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-18. C-style syntax in a *while* loop**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # wh-loopc.sh: Count |
    |  to 10 in a "while" loop |
    | .                        |
    |                          |
    |     LIMIT=10             |
    |      # 10 iterations.    |
    |     a=1                  |
    |                          |
    |     while [ "$a" -le $LI |
    | MIT ]                    |
    |     do                   |
    |       echo -n "$a "      |
    |       let "a+=1"         |
    |     done                 |
    |      # No surprises, so  |
    | far.                     |
    |                          |
    |     echo; echo           |
    |                          |
    |     # +================= |
    | ======================== |
    | ======================== |
    | +                        |
    |                          |
    |     # Now, we'll repeat  |
    | with C-like syntax.      |
    |                          |
    |     ((a = 1))      # a=1 |
    |     # Double parentheses |
    |  permit space when setti |
    | ng a variable, as in C.  |
    |                          |
    |     while (( a <= LIMIT  |
    | ))   #  Double parenthes |
    | es,                      |
    |     do                   |
    |      #+ and no "$" prece |
    | ding variables.          |
    |       echo -n "$a "      |
    |       ((a += 1))         |
    |      # let "a+=1"        |
    |       # Yes, indeed.     |
    |       # Double parenthes |
    | es permit incrementing a |
    |  variable with C-like sy |
    | ntax.                    |
    |     done                 |
    |                          |
    |     echo                 |
    |                          |
    |     # C and Java program |
    | mers can feel right at h |
    | ome in Bash.             |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Inside its test brackets, a *while loop* can call a
    `function <functions.html#FUNCTIONREF>`__.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     t=0                  |
    |                          |
    |     condition ()         |
    |     {                    |
    |       ((t++))            |
    |                          |
    |       if [ $t -lt 5 ]    |
    |       then               |
    |         return 0  # true |
    |       else               |
    |         return 1  # fals |
    | e                        |
    |       fi                 |
    |     }                    |
    |                          |
    |     while condition      |
    |     #     ^^^^^^^^^      |
    |     #     Function call  |
    | -- four loop iterations. |
    |     do                   |
    |       echo "Still going: |
    |  t = $t"                 |
    |     done                 |
    |                          |
    |     # Still going: t = 1 |
    |     # Still going: t = 2 |
    |     # Still going: t = 3 |
    |     # Still going: t = 4 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    +--------------------------------------------------------------------------+
    | .. raw:: html                                                            |
    |                                                                          |
    |    <div class="SIDEBAR">                                                 |
    |                                                                          |
    | Similar to the `if-test <testconstructs.html#IFGREPREF>`__ construct, a  |
    | *while* loop can omit the test brackets.                                 |
    |                                                                          |
    | +--------------------------+--------------------------+----------------- |
    | ---------+                                                               |
    | | .. code:: PROGRAMLISTING |                                             |
    | |                          |                                             |
    | |     while condition      |                                             |
    | |     do                   |                                             |
    | |        command(s) ...    |                                             |
    | |     done                 |                                             |
    |                                                                          |
    | +--------------------------+--------------------------+----------------- |
    | ---------+                                                               |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </p>                                                                  |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </div>                                                                |
                                                                              
    +--------------------------------------------------------------------------+

    By coupling the power of the `read <internal.html#READREF>`__
    command with a *while loop*, we get the handy `while
    read <internal.html#WHILEREADREF>`__ construct, useful for reading
    and parsing files.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     cat $filename |   #  |
    | Supply input from a file |
    | .                        |
    |     while read line   #  |
    | As long as there is anot |
    | her line to read ...     |
    |     do                   |
    |       ...                |
    |     done                 |
    |                          |
    |     # =========== Snippe |
    | t from "sd.sh" example s |
    | cript ========== #       |
    |                          |
    |       while read value   |
    |  # Read one data point a |
    | t a time.                |
    |       do                 |
    |         rt=$(echo "scale |
    | =$SC; $rt + $value" | bc |
    | )                        |
    |         (( ct++ ))       |
    |       done               |
    |                          |
    |       am=$(echo "scale=$ |
    | SC; $rt / $ct" | bc)     |
    |                          |
    |       echo $am; return $ |
    | ct   # This function "re |
    | turns" TWO values!       |
    |       #  Caution: This l |
    | ittle trick will not wor |
    | k if $ct > 255!          |
    |       #  To handle a lar |
    | ger number of data point |
    | s,                       |
    |       #+ simply comment  |
    | out the "return $ct" abo |
    | ve.                      |
    |     } <"$datafile"   # F |
    | eed in data file.        |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="NOTE">

    +--------------------------+--------------------------+--------------------------+
    | |Note|                   |
    | A *while loop* may have  |
    | its ``stdin``            |
    | `redirected to a         |
    | file <redircb.html#REDIR |
    | REF>`__                  |
    | by a < at its end.       |
    |                          |
    | A *while loop* may have  |
    | its ``stdin`` `supplied  |
    | by a                     |
    | pipe <internal.html#READ |
    | PIPEREF>`__.             |
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

\ **until**
    This construct tests for a condition at the top of a loop, and keeps
    looping as long as that condition is *false* (opposite of *while
    loop*).

    | **until** [`` condition-is-true ``\ ]
    |  do
    |  `` command(s)``...
    |  done

    .. raw:: html

       </p>

    Note that an *until loop* tests for the terminating condition at the
    *top* of the loop, differing from a similar construct in some
    programming languages.

    As is the case with *for loops*, placing the *do* on the same line
    as the condition test requires a semicolon.

    **until** [`` condition-is-true ``\ ] ; do

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-19. *until* loop**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     END_CONDITION=end    |
    |                          |
    |     until [ "$var1" = "$ |
    | END_CONDITION" ]         |
    |     # Tests condition he |
    | re, at top of loop.      |
    |     do                   |
    |       echo "Input variab |
    | le #1 "                  |
    |       echo "($END_CONDIT |
    | ION to exit)"            |
    |       read var1          |
    |       echo "variable #1  |
    | = $var1"                 |
    |       echo               |
    |     done                 |
    |                          |
    |     #                    |
    |   ---                    |
    |      #                   |
    |                          |
    |     #  As with "for" and |
    |  "while" loops,          |
    |     #+ an "until" loop p |
    | ermits C-like test const |
    | ructs.                   |
    |                          |
    |     LIMIT=10             |
    |     var=0                |
    |                          |
    |     until (( var > LIMIT |
    |  ))                      |
    |     do  # ^^ ^     ^     |
    |  ^^   No brackets, no $  |
    | prefixing variables.     |
    |       echo -n "$var "    |
    |       (( var++ ))        |
    |     done    # 0 1 2 3 4  |
    | 5 6 7 8 9 10             |
    |                          |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

How to choose between a *for* loop or a *while* loop or *until* loop? In
**C**, you would typically use a *for* loop when the number of loop
iterations is known beforehand. With *Bash*, however, the situation is
fuzzier. The Bash *for* loop is more loosely structured and more
flexible than its equivalent in other languages. Therefore, feel free to
use whatever type of loop gets the job done in the simplest way.

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <loops1.html#AEN6560>`__        |
| \ *Iteration*: Repeated execution of |
| a command or group of commands,      |
| usually -- but not always, *while* a |
| given condition holds, or *until* a  |
| given condition is met.              |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <loops.html>`__    | Loops and Branches       |
| `Home <index.html>`__    | `Up <loops.html>`__      |
| `Next <nestedloops.html> | Nested Loops             |
| `__                      |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
