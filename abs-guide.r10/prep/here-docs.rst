.. raw:: html

   <div class="CHAPTER">

  Chapter 19. Here Documents
===========================

.. raw:: html

   <div>

**

*Here and now, boys.*

*--Aldous Huxley, *Island**

.. raw:: html

   </p>

.. raw:: html

   </div>

A *here document* is a special-purpose code block. It uses a form of
`I/O redirection <io-redirection.html#IOREDIRREF>`__ to feed a command
list to an interactive program or a command, such as
`ftp <communications.html#FTPREF>`__ , `cat <basic.html#CATREF>`__ , or
the *ex* text editor.

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    COMMAND <<InputComesFromHERE
    ...
    ...
    ...
    InputComesFromHERE

.. raw:: html

   </p>

.. raw:: html

   </div>

A *limit string* delineates (frames) the command list. The special
symbol << precedes the limit string. This has the effect of redirecting
the output of a command block into the ``      stdin     `` of the
program or command. It is similar to
``             interactive-program <     command-file           `` ,
where ``      command-file     `` contains

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    command #1
    command #2
    ...

.. raw:: html

   </p>

.. raw:: html

   </div>

The *here document* equivalent looks like this:

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    interactive-program <<LimitString
    command #1
    command #2
    ...
    LimitString

.. raw:: html

   </p>

.. raw:: html

   </div>

Choose a *limit string* sufficiently unusual that it will not occur
anywhere in the command list and confuse matters.

Note that *here documents* may sometimes be used to good effect with
non-interactive utilities and commands, such as, for example,
`wall <system.html#WALLREF>`__ .

.. raw:: html

   <div class="EXAMPLE">

**Example 19-1. *broadcast* : Sends message to everyone logged in**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash

    wall <<zzz23EndOfMessagezzz23
    E-mail your noontime orders for pizza to the system administrator.
        (Add an extra dollar for anchovy or mushroom topping.)
    # Additional message text goes here.
    # Note: 'wall' prints comment lines.
    zzz23EndOfMessagezzz23

    # Could have been done more efficiently by
    #         wall <message-file
    #  However, embedding the message template in a script
    #+ is a quick-and-dirty one-off solution.

    exit

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

Even such unlikely candidates as the *vi* text editor lend themselves to
*here documents* .

.. raw:: html

   <div class="EXAMPLE">

**Example 19-2. *dummyfile* : Creates a 2-line dummy file**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash

    # Noninteractive use of 'vi' to edit a file.
    # Emulates 'sed'.

    E_BADARGS=85

    if [ -z "$1" ]
    then
      echo "Usage: `basename $0` filename"
      exit $E_BADARGS
    fi

    TARGETFILE=$1

    # Insert 2 lines in file, then save.
    #--------Begin here document-----------#
    vi $TARGETFILE <<x23LimitStringx23
    i
    This is line 1 of the example file.
    This is line 2 of the example file.
    ^[
    ZZ
    x23LimitStringx23
    #----------End here document-----------#

    #  Note that ^[ above is a literal escape
    #+ typed by Control-V <Esc>.

    #  Bram Moolenaar points out that this may not work with 'vim'
    #+ because of possible problems with terminal interaction.

    exit

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

The above script could just as effectively have been implemented with
**ex** , rather than **vi** . *Here documents* containing a list of
**ex** commands are common enough to form their own category, known as
*ex scripts* .

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    #  Replace all instances of "Smith" with "Jones"
    #+ in files with a ".txt" filename suffix. 

    ORIGINAL=Smith
    REPLACEMENT=Jones

    for word in $(fgrep -l $ORIGINAL *.txt)
    do
      # -------------------------------------
      ex $word <<EOF
      :%s/$ORIGINAL/$REPLACEMENT/g
      :wq
    EOF
      # :%s is the "ex" substitution command.
      # :wq is write-and-quit.
      # -------------------------------------
    done

.. raw:: html

   </p>

.. raw:: html

   </div>

Analogous to "ex scripts" are *cat scripts* .

.. raw:: html

   <div class="EXAMPLE">

**Example 19-3. Multi-line message using *cat***

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash

    #  'echo' is fine for printing single line messages,
    #+  but somewhat problematic for for message blocks.
    #   A 'cat' here document overcomes this limitation.

    cat <<End-of-message
    -------------------------------------
    This is line 1 of the message.
    This is line 2 of the message.
    This is line 3 of the message.
    This is line 4 of the message.
    This is the last line of the message.
    -------------------------------------
    End-of-message

    #  Replacing line 7, above, with
    #+   cat > $Newfile <<End-of-message
    #+       ^^^^^^^^^^
    #+ writes the output to the file $Newfile, rather than to stdout.

    exit 0


    #--------------------------------------------
    # Code below disabled, due to "exit 0" above.

    # S.C. points out that the following also works.
    echo "-------------------------------------
    This is line 1 of the message.
    This is line 2 of the message.
    This is line 3 of the message.
    This is line 4 of the message.
    This is the last line of the message.
    -------------------------------------"
    # However, text may not include double quotes unless they are escaped.

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

The ``      -     `` option to mark a here document limit string (
``             <<-LimitString           `` ) suppresses leading tabs
(but not spaces) in the output. This may be useful in making a script
more readable.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-4. Multi-line message, with tabs suppressed**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    # Same as previous example, but...

    #  The - option to a here document <<-
    #+ suppresses leading tabs in the body of the document,
    #+ but *not* spaces.

    cat <<-ENDOFMESSAGE
        This is line 1 of the message.
        This is line 2 of the message.
        This is line 3 of the message.
        This is line 4 of the message.
        This is the last line of the message.
    ENDOFMESSAGE
    # The output of the script will be flush left.
    # Leading tab in each line will not show.

    # Above 5 lines of "message" prefaced by a tab, not spaces.
    # Spaces not affected by   <<-  .

    # Note that this option has no effect on *embedded* tabs.

    exit 0

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

A *here document* supports parameter and command substitution. It is
therefore possible to pass different parameters to the body of the here
document, changing its output accordingly.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-5. Here document with replaceable parameters**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    # Another 'cat' here document, using parameter substitution.

    # Try it with no command-line parameters,   ./scriptname
    # Try it with one command-line parameter,   ./scriptname Mortimer
    # Try it with one two-word quoted command-line parameter,
    #                           ./scriptname "Mortimer Jones"

    CMDLINEPARAM=1     #  Expect at least command-line parameter.

    if [ $# -ge $CMDLINEPARAM ]
    then
      NAME=$1          #  If more than one command-line param,
                       #+ then just take the first.
    else
      NAME="John Doe"  #  Default, if no command-line parameter.
    fi  

    RESPONDENT="the author of this fine script"  
      

    cat <<Endofmessage

    Hello, there, $NAME.
    Greetings to you, $NAME, from $RESPONDENT.

    # This comment shows up in the output (why?).

    Endofmessage

    # Note that the blank lines show up in the output.
    # So does the comment.

    exit

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

This is a useful script containing a *here document* with parameter
substitution.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-6. Upload a file pair to *Sunsite* incoming directory**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    # upload.sh

    #  Upload file pair (Filename.lsm, Filename.tar.gz)
    #+ to incoming directory at Sunsite/UNC (ibiblio.org).
    #  Filename.tar.gz is the tarball itself.
    #  Filename.lsm is the descriptor file.
    #  Sunsite requires "lsm" file, otherwise will bounce contributions.


    E_ARGERROR=85

    if [ -z "$1" ]
    then
      echo "Usage: `basename $0` Filename-to-upload"
      exit $E_ARGERROR
    fi  


    Filename=`basename $1`           # Strips pathname out of file name.

    Server="ibiblio.org"
    Directory="/incoming/Linux"
    #  These need not be hard-coded into script,
    #+ but may instead be changed to command-line argument.

    Password="your.e-mail.address"   # Change above to suit.

    ftp -n $Server <<End-Of-Session
    # -n option disables auto-logon

    user anonymous "$Password"       #  If this doesn't work, then try:
                                     #  quote user anonymous "$Password"
    binary
    bell                             # Ring 'bell' after each file transfer.
    cd $Directory
    put "$Filename.lsm"
    put "$Filename.tar.gz"
    bye
    End-Of-Session

    exit 0

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

Quoting or escaping the "limit string" at the head of a here document
disables parameter substitution within its body. The reason for this is
that *quoting/escaping the limit string* effectively
`escapes <escapingsection.html#ESCP>`__ the $ , \` , and \\ `special
characters <special-chars.html#SCHARLIST>`__ , and causes them to be
interpreted literally. (Thank you, Allen Halsey, for pointing this out.)

.. raw:: html

   <div class="EXAMPLE">

**Example 19-7. Parameter substitution turned off**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    #  A 'cat' here-document, but with parameter substitution disabled.

    NAME="John Doe"
    RESPONDENT="the author of this fine script"  

    cat <<'Endofmessage'

    Hello, there, $NAME.
    Greetings to you, $NAME, from $RESPONDENT.

    Endofmessage

    #   No parameter substitution when the "limit string" is quoted or escaped.
    #   Either of the following at the head of the here document would have
    #+  the same effect.
    #   cat <<"Endofmessage"
    #   cat <<\Endofmessage



    #   And, likewise:

    cat <<"SpecialCharTest"

    Directory listing would follow
    if limit string were not quoted.
    `ls -l`

    Arithmetic expansion would take place
    if limit string were not quoted.
    $((5 + 3))

    A a single backslash would echo
    if limit string were not quoted.
    \\

    SpecialCharTest


    exit

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

Disabling parameter substitution permits outputting literal text.
Generating scripts or even program code is one use for this.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-8. A script that generates another script**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    # generate-script.sh
    # Based on an idea by Albert Reiner.

    OUTFILE=generated.sh         # Name of the file to generate.


    # -----------------------------------------------------------
    # 'Here document containing the body of the generated script.
    (
    cat <<'EOF'
    #!/bin/bash

    echo "This is a generated shell script."
    #  Note that since we are inside a subshell,
    #+ we can't access variables in the "outside" script.

    echo "Generated file will be named: $OUTFILE"
    #  Above line will not work as normally expected
    #+ because parameter expansion has been disabled.
    #  Instead, the result is literal output.

    a=7
    b=3

    let "c = $a * $b"
    echo "c = $c"

    exit 0
    EOF
    ) > $OUTFILE
    # -----------------------------------------------------------

    #  Quoting the 'limit string' prevents variable expansion
    #+ within the body of the above 'here document.'
    #  This permits outputting literal strings in the output file.

    if [ -f "$OUTFILE" ]
    then
      chmod 755 $OUTFILE
      # Make the generated file executable.
    else
      echo "Problem in creating file: \"$OUTFILE\""
    fi

    #  This method also works for generating
    #+ C programs, Perl programs, Python programs, Makefiles,
    #+ and the like.

    exit 0

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

It is possible to set a variable from the output of a here document.
This is actually a devious form of `command
substitution <commandsub.html#COMMANDSUBREF>`__ .

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    variable=$(cat <<SETVAR
    This variable
    runs over multiple lines.
    SETVAR
    )

    echo "$variable"

.. raw:: html

   </p>

.. raw:: html

   </div>

A here document can supply input to a function in the same script.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-9. Here documents and functions**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    # here-function.sh

    GetPersonalData ()
    {
      read firstname
      read lastname
      read address
      read city 
      read state 
      read zipcode
    } # This certainly appears to be an interactive function, but . . .


    # Supply input to the above function.
    GetPersonalData <<RECORD001
    Bozo
    Bozeman
    2726 Nondescript Dr.
    Bozeman
    MT
    21226
    RECORD001


    echo
    echo "$firstname $lastname"
    echo "$address"
    echo "$city, $state $zipcode"
    echo

    exit 0

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

It is possible to use : as a dummy command accepting output from a here
document. This, in effect, creates an "anonymous" here document.

.. raw:: html

   <div class="EXAMPLE">

**Example 19-10. "Anonymous" Here Document**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash

    : <<TESTVARIABLES
    ${HOSTNAME?}${USER?}${MAIL?}  # Print error message if one of the variables not set.
    TESTVARIABLES

    exit $?

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

A variation of the above technique permits "commenting out" blocks of
code.

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 19-11. Commenting out a block of code**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    # commentblock.sh

    : <<COMMENTBLOCK
    echo "This line will not echo."
    This is a comment line missing the "#" prefix.
    This is another comment line missing the "#" prefix.

    &*@!!++=
    The above line will cause no error message,
    because the Bash interpreter will ignore it.
    COMMENTBLOCK

    echo "Exit value of above \"COMMENTBLOCK\" is $?."   # 0
    # No error shown.
    echo


    #  The above technique also comes in useful for commenting out
    #+ a block of working code for debugging purposes.
    #  This saves having to put a "#" at the beginning of each line,
    #+ then having to go back and delete each "#" later.
    #  Note that the use of of colon, above, is optional.

    echo "Just before commented-out code block."
    #  The lines of code between the double-dashed lines will not execute.
    #  ===================================================================
    : <<DEBUGXXX
    for file in *
    do
     cat "$file"
    done
    DEBUGXXX
    #  ===================================================================
    echo "Just after commented-out code block."

    exit 0



    ######################################################################
    #  Note, however, that if a bracketed variable is contained within
    #+ the commented-out code block,
    #+ then this could cause problems.
    #  for example:


    #/!/bin/bash

      : <<COMMENTBLOCK
      echo "This line will not echo."
      &*@!!++=
      ${foo_bar_bazz?}
      $(rm -rf /tmp/foobar/)
      $(touch my_build_directory/cups/Makefile)
    COMMENTBLOCK


    $ sh commented-bad.sh
    commented-bad.sh: line 3: foo_bar_bazz: parameter null or not set

    # The remedy for this is to strong-quote the 'COMMENTBLOCK' in line 49, above.

      : <<'COMMENTBLOCK'

    # Thank you, Kurt Pfeifle, for pointing this out.

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

Yet another twist of this nifty trick makes "self-documenting" scripts
possible.

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 19-12. A self-documenting script**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    # self-document.sh: self-documenting script
    # Modification of "colm.sh".

    DOC_REQUEST=70

    if [ "$1" = "-h"  -o "$1" = "--help" ]     # Request help.
    then
      echo; echo "Usage: $0 [directory-name]"; echo
      sed --silent -e '/DOCUMENTATIONXX$/,/^DOCUMENTATIONXX$/p' "$0" |
      sed -e '/DOCUMENTATIONXX$/d'; exit $DOC_REQUEST; fi


    : <<DOCUMENTATIONXX
    List the statistics of a specified directory in tabular format.
    ---------------------------------------------------------------
    The command-line parameter gives the directory to be listed.
    If no directory specified or directory specified cannot be read,
    then list the current working directory.

    DOCUMENTATIONXX

    if [ -z "$1" -o ! -r "$1" ]
    then
      directory=.
    else
      directory="$1"
    fi  

    echo "Listing of "$directory":"; echo
    (printf "PERMISSIONS LINKS OWNER GROUP SIZE MONTH DAY HH:MM PROG-NAME\n" \
    ; ls -l "$directory" | sed 1d) | column -t

    exit 0

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

Using a `cat script <here-docs.html#CATSCRIPTREF>`__ is an alternate way
of accomplishing this.

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    DOC_REQUEST=70

    if [ "$1" = "-h"  -o "$1" = "--help" ]     # Request help.
    then                                       # Use a "cat script" . . .
      cat <<DOCUMENTATIONXX
    List the statistics of a specified directory in tabular format.
    ---------------------------------------------------------------
    The command-line parameter gives the directory to be listed.
    If no directory specified or directory specified cannot be read,
    then list the current working directory.

    DOCUMENTATIONXX
    exit $DOC_REQUEST
    fi

.. raw:: html

   </p>

.. raw:: html

   </div>

See also `Example A-28 <contributed-scripts.html#ISSPAMMER2>`__ ,
`Example A-40 <contributed-scripts.html#PETALS>`__ , `Example
A-41 <contributed-scripts.html#QKY>`__ , and `Example
A-42 <contributed-scripts.html#NIM>`__ for more examples of
self-documenting scripts.

.. raw:: html

   <div class="NOTE">

.. raw:: html

   <div>

|Note|

Here documents create temporary files, but these files are deleted after
opening and are not accessible to any other process.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ bash -c 'lsof  |
| -a -p $$ -d0' << EOF     |
|     > EOF                |
|     lsof    1213 bozo    |
|  0r   REG    3,5    0 30 |
| 386 /tmp/t1213-0-sh (del |
| eted)                    |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. code:: SCREEN

    bash$ bash -c 'lsof -a -p $$ -d0' << EOF
    > EOF
    lsof    1213 bozo    0r   REG    3,5    0 30386 /tmp/t1213-0-sh (deleted)
              

.. raw:: html

   </p>

.. code:: SCREEN

    bash$ bash -c 'lsof -a -p $$ -d0' << EOF
    > EOF
    lsof    1213 bozo    0r   REG    3,5    0 30386 /tmp/t1213-0-sh (deleted)
              

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

.. raw:: html

   <div>

|Caution|

Some utilities will not work inside a *here document* .

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="WARNING">

.. raw:: html

   <div>

|Warning|

The closing *limit string* , on the final line of a here document, must
start in the *first* character position. There can be *no leading
whitespace* . Trailing whitespace after the limit string likewise causes
unexpected behavior. The whitespace prevents the limit string from being
recognized. ` [1]  <here-docs.html#FTN.AEN17822>`__

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     echo "-------------- |
| ------------------------ |
| ------------------------ |
| --------"                |
|                          |
|     cat <<LimitString    |
|     echo "This is line 1 |
|  of the message inside t |
| he here document."       |
|     echo "This is line 2 |
|  of the message inside t |
| he here document."       |
|     echo "This is the fi |
| nal line of the message  |
| inside the here document |
| ."                       |
|          LimitString     |
|     #^^^^Indented limit  |
| string. Error! This scri |
| pt will not behave as ex |
| pected.                  |
|                          |
|     echo "-------------- |
| ------------------------ |
| ------------------------ |
| --------"                |
|                          |
|     #  These comments ar |
| e outside the 'here docu |
| ment',                   |
|     #+ and should not ec |
| ho.                      |
|                          |
|     echo "Outside the he |
| re document."            |
|                          |
|     exit 0               |
|                          |
|     echo "This line had  |
| better not echo."  # Fol |
| lows an 'exit' command.  |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. code:: PROGRAMLISTING

    #!/bin/bash

    echo "----------------------------------------------------------------------"

    cat <<LimitString
    echo "This is line 1 of the message inside the here document."
    echo "This is line 2 of the message inside the here document."
    echo "This is the final line of the message inside the here document."
         LimitString
    #^^^^Indented limit string. Error! This script will not behave as expected.

    echo "----------------------------------------------------------------------"

    #  These comments are outside the 'here document',
    #+ and should not echo.

    echo "Outside the here document."

    exit 0

    echo "This line had better not echo."  # Follows an 'exit' command.

.. raw:: html

   </p>

.. code:: PROGRAMLISTING

    #!/bin/bash

    echo "----------------------------------------------------------------------"

    cat <<LimitString
    echo "This is line 1 of the message inside the here document."
    echo "This is line 2 of the message inside the here document."
    echo "This is the final line of the message inside the here document."
         LimitString
    #^^^^Indented limit string. Error! This script will not behave as expected.

    echo "----------------------------------------------------------------------"

    #  These comments are outside the 'here document',
    #+ and should not echo.

    echo "Outside the here document."

    exit 0

    echo "This line had better not echo."  # Follows an 'exit' command.

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

.. raw:: html

   <div>

|Caution|

 Some people very cleverly use a single ! as a limit string. But, that's
not necessarily a good idea.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # This works.        |
|     cat <<!              |
|     Hello!               |
|     ! Three more exclama |
| tions !!!                |
|     !                    |
|                          |
|                          |
|     # But . . .          |
|     cat <<!              |
|     Hello!               |
|     Single exclamation p |
| oint follows!            |
|     !                    |
|     !                    |
|     # Crashes with an er |
| ror message.             |
|                          |
|                          |
|     # However, the follo |
| wing will work.          |
|     cat <<EOF            |
|     Hello!               |
|     Single exclamation p |
| oint follows!            |
|     !                    |
|     EOF                  |
|     # It's safer to use  |
| a multi-character limit  |
| string.                  |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. code:: PROGRAMLISTING

    # This works.
    cat <<!
    Hello!
    ! Three more exclamations !!!
    !


    # But . . .
    cat <<!
    Hello!
    Single exclamation point follows!
    !
    !
    # Crashes with an error message.


    # However, the following will work.
    cat <<EOF
    Hello!
    Single exclamation point follows!
    !
    EOF
    # It's safer to use a multi-character limit string.

.. raw:: html

   </p>

.. code:: PROGRAMLISTING

    # This works.
    cat <<!
    Hello!
    ! Three more exclamations !!!
    !


    # But . . .
    cat <<!
    Hello!
    Single exclamation point follows!
    !
    !
    # Crashes with an error message.


    # However, the following will work.
    cat <<EOF
    Hello!
    Single exclamation point follows!
    !
    EOF
    # It's safer to use a multi-character limit string.

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

For those tasks too complex for a *here document* , consider using the
``             expect           `` scripting language, which was
specifically designed for feeding input into interactive programs.

.. raw:: html

   </div>

Notes
~~~~~

.. raw:: html

   <div>

` [1]  <here-docs.html#AEN17822>`__

Except, as Dennis Benzinger points out, if `using **<<-** to suppress
tabs <here-docs.html#LIMITSTRDASH>`__ .

.. raw:: html

   </p>

.. raw:: html

   </div>

.. |Tip| image:: ../images/tip.gif
.. |Note| image:: ../images/note.gif
.. |Caution| image:: ../images/caution.gif
.. |Warning| image:: ../images/warning.gif
