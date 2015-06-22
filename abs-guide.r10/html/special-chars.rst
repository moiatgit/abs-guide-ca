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

`Prev <part2.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <variables.html>`__

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

Chapter 3. Special Characters
=============================

What makes a character *special*? If it has a meaning beyond its
*literal meaning*, a `meta-meaning <x17129.html#METAMEANINGREF>`__, then
we refer to it as a *special character*. Along with commands and
`keywords <internal.html#KEYWORDREF>`__, *special characters* are
building blocks of Bash scripts.

.. raw:: html

   <div class="VARIABLELIST">

**Special Characters Found In Scripts and Elsewhere**

#
    .. raw:: html

       <div class="FORMALPARA">

    **Comments.** Lines beginning with a # (with the exception of
    `#! <sha-bang.html#MAGNUMREF>`__) are comments and will *not* be
    executed.

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # This line is a com |
    | ment.                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Comments may also occur following the end of a command.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo "A comment will |
    |  follow." # Comment here |
    | .                        |
    |     #                    |
    |          ^ Note whitespa |
    | ce before #              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

     Comments may also follow
    `whitespace <special-chars.html#WHITESPACEREF>`__ at the beginning
    of a line.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |          # A tab precede |
    | s this comment.          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Comments may even be embedded within a
    `pipe <special-chars.html#PIPEREF>`__.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     initial=( `cat "$sta |
    | rtfile" | sed -e '/#/d'  |
    | | tr -d '\n' |\          |
    |     # Delete lines conta |
    | ining '#' comment charac |
    | ter.                     |
    |                sed -e 's |
    | /\./\. /g' -e 's/_/_ /g' |
    | ` )                      |
    |     # Excerpted from lif |
    | e.sh script              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | A command may not follow a comment   |
    | on the same line. There is no method |
    | of terminating the comment, in order |
    | for "live code" to begin on the same |
    | line. Use a new line for the next    |
    | command.                             |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +----------------+----------------+----------------+----------------+----------------+
    | |Note|         |
    | Of course, a   |
    | `quoted <quoti |
    | ng.html#QUOTIN |
    | GREF>`__       |
    | or an          |
    | `escaped <esca |
    | pingsection.ht |
    | ml#ESCP>`__    |
    | # in an        |
    | `echo <interna |
    | l.html#ECHOREF |
    | >`__           |
    | statement does |
    | *not* begin a  |
    | comment.       |
    | Likewise, a #  |
    | appears in     |
    | `certain       |
    | parameter-subs |
    | titution       |
    | constructs <pa |
    | rameter-substi |
    | tution.html#PS |
    | UB2>`__        |
    | and in         |
    | `numerical     |
    | constant       |
    | expressions <n |
    | umerical-const |
    | ants.html#NUMC |
    | ONSTANTS>`__.  |
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
    | |     echo "Th |
    | e # here doe | |
    | | s not begin  |
    | a comment."  | |
    | |     echo 'Th |
    | e # here doe | |
    | | s not begin  |
    | a comment.'  | |
    | |     echo The |
    |  \# here doe | |
    | | s not begin  |
    | a comment.   | |
    | |     echo The |
    |  # here begi | |
    | | ns a comment |
    | .            | |
    | |              |
    |              | |
    | |     echo ${P |
    | ATH#*:}      | |
    | |   # Paramete |
    | r substituti | |
    | | on, not a co |
    | mment.       | |
    | |     echo $(( |
    |  2#101011 )) | |
    | |   # Base con |
    | version, not | |
    | |  a comment.  |
    |              | |
    | |              |
    |              | |
    | |     # Thanks |
    | , S.C.       | |
    |                |
    |                |
    | +------------- |
    | -------------+ |
    | -------------- |
    | ------------+- |
    | -------------- |
    | -----------+   |
    |                |
    | The standard   |
    | `quoting and   |
    | escape <quotin |
    | g.html#QUOTING |
    | REF>`__        |
    | characters ("  |
    | ' \\) escape   |
    | the #.         |
    |                |
    | .. raw:: html  |
    |                |
    |    </p>        |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

    Certain `pattern matching
    operations <parameter-substitution.html#PSOREX1>`__ also use the #.

;
    .. raw:: html

       <div class="FORMALPARA">

    **Command separator [semicolon].** Permits putting two or more
    commands on the same line.

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo hello; echo the |
    | re                       |
    |                          |
    |                          |
    |     if [ -x "$filename"  |
    | ]; then    #  Note the s |
    | pace after the semicolon |
    | .                        |
    |     #+                   |
    |  ^^                      |
    |       echo "File $filena |
    | me exists."; cp $filenam |
    | e $filename.bak          |
    |     else   #             |
    |            ^^            |
    |       echo "File $filena |
    | me not found."; touch $f |
    | ilename                  |
    |     fi; echo "File test  |
    | complete."               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Note that the ";" `sometimes needs to be
    *escaped* <moreadv.html#FINDREF0>`__.

;;
    .. raw:: html

       <div class="FORMALPARA">

    **Terminator in a `case <testbranch.html#CASEESAC1>`__ option
    [double semicolon].**

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     case "$variable" in  |
    |       abc)  echo "\$vari |
    | able = abc" ;;           |
    |       xyz)  echo "\$vari |
    | able = xyz" ;;           |
    |     esac                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

;;&, ;&
    .. raw:: html

       <div class="FORMALPARA">

    **`Terminators <bashver4.html#NCTERM>`__ in a *case* option
    (`version 4+ <bashver4.html#BASH4REF>`__ of Bash).**

    .. raw:: html

       </div>

.

    .. raw:: html

       <div class="FORMALPARA">

    **"dot" command [period].** Equivalent to
    `source <internal.html#SOURCEREF>`__ (see `Example
    15-22 <internal.html#EX38>`__). This is a bash
    `builtin <internal.html#BUILTINREF>`__.

    .. raw:: html

       </div>

.
    .. raw:: html

       <div class="FORMALPARA">

    **"dot", as a component of a filename.** When working with
    filenames, a leading dot is the prefix of a "hidden" file, a file
    that an `ls <basic.html#LSREF>`__ will not normally show.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ touch .hidden- |
    | file                     |
    |     bash$ ls -l          |
    |     total 10             |
    |      -rw-r--r--    1 boz |
    | o      4034 Jul 18 22:04 |
    |  data1.addressbook       |
    |      -rw-r--r--    1 boz |
    | o      4602 May 25 13:58 |
    |  data1.addressbook.bak   |
    |      -rw-r--r--    1 boz |
    | o       877 Dec 17  2000 |
    |  employment.addressbook  |
    |                          |
    |                          |
    |     bash$ ls -al         |
    |                          |
    |     total 14             |
    |      drwxrwxr-x    2 boz |
    | o  bozo      1024 Aug 29 |
    |  20:54 ./                |
    |      drwx------   52 boz |
    | o  bozo      3072 Aug 29 |
    |  20:51 ../               |
    |      -rw-r--r--    1 boz |
    | o  bozo      4034 Jul 18 |
    |  22:04 data1.addressbook |
    |      -rw-r--r--    1 boz |
    | o  bozo      4602 May 25 |
    |  13:58 data1.addressbook |
    | .bak                     |
    |      -rw-r--r--    1 boz |
    | o  bozo       877 Dec 17 |
    |   2000 employment.addres |
    | sbook                    |
    |      -rw-rw-r--    1 boz |
    | o  bozo         0 Aug 29 |
    |  20:54 .hidden-file      |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    When considering directory names, *a single dot* represents the
    current working directory, and *two dots* denote the parent
    directory.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ pwd            |
    |     /home/bozo/projects  |
    |                          |
    |     bash$ cd .           |
    |     bash$ pwd            |
    |     /home/bozo/projects  |
    |                          |
    |     bash$ cd ..          |
    |     bash$ pwd            |
    |     /home/bozo/          |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The *dot* often appears as the destination (directory) of a file
    movement command, in this context meaning *current directory*.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ cp /home/bozo/ |
    | current_work/junk/* .    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    Copy all the "junk" files to
    `$PWD <internalvariables.html#PWDREF>`__.

    .. raw:: html

       </p>

.
    .. raw:: html

       <div class="FORMALPARA">

    **"dot" character match.** When `matching
    characters <x17129.html#REGEXDOT>`__, as part of a `regular
    expression <regexp.html#REGEXREF>`__, a "dot" `matches a single
    character <x17129.html#REGEXDOT>`__.

    .. raw:: html

       </div>

"
    .. raw:: html

       <div class="FORMALPARA">

    **`partial quoting <varsubn.html#DBLQUO>`__ [double quote].**
    *"STRING"* preserves (from interpretation) most of the special
    characters within *STRING*. See `Chapter 5 <quoting.html>`__.

    .. raw:: html

       </div>

'
    .. raw:: html

       <div class="FORMALPARA">

    **`full quoting <varsubn.html#SNGLQUO>`__ [single quote].**
    *'STRING'* preserves all special characters within *STRING*. This is
    a stronger form of quoting than *"STRING"*. See `Chapter
    5 <quoting.html>`__.

    .. raw:: html

       </div>

,
    .. raw:: html

       <div class="FORMALPARA">

    **`comma operator <ops.html#COMMAOP>`__.** The *comma operator*
    `[1] <special-chars.html#FTN.AEN612>`__ links together a series of
    arithmetic operations. All are evaluated, but only the last one is
    returned.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     let "t2 = ((a = 9, 1 |
    | 5 / 3))"                 |
    |     # Set "a = 9" and "t |
    | 2 = 15 / 3"              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    The *comma* operator can also concatenate strings.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     for file in /{,usr/} |
    | bin/*calc                |
    |     #             ^    F |
    | ind all executable files |
    |  ending in "calc"        |
    |     #+                 i |
    | n /bin and /usr/bin dire |
    | ctories.                 |
    |     do                   |
    |             if [ -x "$fi |
    | le" ]                    |
    |             then         |
    |               echo $file |
    |             fi           |
    |     done                 |
    |                          |
    |     # /bin/ipcalc        |
    |     # /usr/bin/kcalc     |
    |     # /usr/bin/oidcalc   |
    |     # /usr/bin/oocalc    |
    |                          |
    |                          |
    |     # Thank you, Rory Wi |
    | nston, for pointing this |
    |  out.                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

,, ,
    .. raw:: html

       <div class="FORMALPARA">

    **`Lowercase conversion <bashver4.html#CASEMODPARAMSUB>`__ in
    *parameter substitution* (added in `version
    4 <bashver4.html#BASH4REF>`__ of Bash).**

    .. raw:: html

       </div>

\\
    .. raw:: html

       <div class="FORMALPARA">

    **`escape <escapingsection.html#ESCP>`__ [backslash].** A quoting
    mechanism for single characters.

    .. raw:: html

       </div>

    ``\X`` *escapes* the character *X*. This has the effect of "quoting"
    *X*, equivalent to *'X'*. The \\ may be used to quote " and ', so
    they are expressed literally.

    See `Chapter 5 <quoting.html>`__ for an in-depth explanation of
    escaped characters.

/
    .. raw:: html

       <div class="FORMALPARA">

    **Filename path separator [forward slash].** Separates the
    components of a filename (as in ``/home/bozo/projects/Makefile``).

    .. raw:: html

       </div>

    This is also the division `arithmetic operator <ops.html#AROPS1>`__.

\`
    .. raw:: html

       <div class="FORMALPARA">

    **`command substitution <commandsub.html#COMMANDSUBREF>`__.** The
    **\`command\`** construct makes available the output of **command**
    for assignment to a variable. This is also known as
    `backquotes <commandsub.html#BACKQUOTESREF>`__ or backticks.

    .. raw:: html

       </div>

:

    .. raw:: html

       <div class="FORMALPARA">

    **null command [colon].** This is the shell equivalent of a "NOP"
    (``no op``, a do-nothing operation). It may be considered a synonym
    for the shell builtin `true <internal.html#TRUEREF>`__. The ":"
    command is itself a *Bash* `builtin <internal.html#BUILTINREF>`__,
    and its `exit status <exit-status.html#EXITSTATUSREF>`__ is *true*
    (0).

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     :                    |
    |     echo $?   # 0        |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Endless loop:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     while :              |
    |     do                   |
    |        operation-1       |
    |        operation-2       |
    |        ...               |
    |        operation-n       |
    |     done                 |
    |                          |
    |     # Same as:           |
    |     #    while true      |
    |     #    do              |
    |     #      ...           |
    |     #    done            |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Placeholder in if/then test:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     if condition         |
    |     then :   # Do nothin |
    | g and branch ahead       |
    |     else     # Or else . |
    | ..                       |
    |        take-some-action  |
    |     fi                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Provide a placeholder where a binary operation is expected, see
    `Example 8-2 <ops.html#ARITHOPS>`__ and `default
    parameters <parameter-substitution.html#DEFPARAM>`__.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     : ${username=`whoami |
    | `}                       |
    |     # ${username=`whoami |
    | `}   Gives an error with |
    | out the leading :        |
    |     #                    |
    |      unless "username" i |
    | s a command or builtin.. |
    | .                        |
    |                          |
    |     : ${1?"Usage: $0 ARG |
    | UMENT"}     # From "usag |
    | e-message.sh example scr |
    | ipt.                     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Provide a placeholder where a command is expected in a `here
    document <here-docs.html#HEREDOCREF>`__. See `Example
    19-10 <here-docs.html#ANONHEREDOC>`__.

    Evaluate string of variables using `parameter
    substitution <parameter-substitution.html#PARAMSUBREF>`__ (as in
    `Example 10-7 <parameter-substitution.html#EX6>`__).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     : ${HOSTNAME?} ${USE |
    | R?} ${MAIL?}             |
    |     #  Prints error mess |
    | age                      |
    |     #+ if one or more of |
    |  essential environmental |
    |  variables not set.      |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    **`Variable expansion / substring
    replacement <parameter-substitution.html#EXPREPL1>`__**.

    In combination with the > `redirection
    operator <io-redirection.html#IOREDIRREF>`__, truncates a file to
    zero length, without changing its permissions. If the file did not
    previously exist, creates it.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     : > data.xxx   # Fil |
    | e "data.xxx" now empty.  |
    |                          |
    |                          |
    |     # Same effect as   c |
    | at /dev/null >data.xxx   |
    |     # However, this does |
    |  not fork a new process, |
    |  since ":" is a builtin. |
                              
    +--------------------------+--------------------------+--------------------------+

    See also `Example 16-15 <textproc.html#EX12>`__.

    .. raw:: html

       </p>

    In combination with the >> redirection operator, has no effect on a
    pre-existing target file (``: >> target_file``). If the file did not
    previously exist, creates it.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | This applies to regular files, not   |
    | pipes, symlinks, and certain special |
    | files.                               |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    May be used to begin a comment line, although this is not
    recommended. Using # for a comment turns off error checking for the
    remainder of that line, so almost anything may appear in a comment.
    However, this is not the case with :.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     : This is a comment  |
    | that generates an error, |
    |  ( if [ $x -eq 3] ).     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The ":" serves as a `field <special-chars.html#FIELDREF>`__
    separator, in ```/etc/passwd`` <files.html#DATAFILESREF1>`__, and in
    the `$PATH <internalvariables.html#PATHREF>`__ variable.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo $PATH     |
    |     /usr/local/bin:/bin: |
    | /usr/bin:/usr/X11R6/bin: |
    | /sbin:/usr/sbin:/usr/gam |
    | es                       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    A *colon* is `acceptable as a function
    name <functions.html#FSTRANGEREF>`__.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     :()                  |
    |     {                    |
    |       echo "The name of  |
    | this function is "$FUNCN |
    | AME" "                   |
    |       # Why use a colon  |
    | as a function name?      |
    |       # It's a way of ob |
    | fuscating your code.     |
    |     }                    |
    |                          |
    |     :                    |
    |                          |
    |     # The name of this f |
    | unction is :             |
                              
    +--------------------------+--------------------------+--------------------------+

    This is not `portable <portabilityissues.html>`__ behavior, and
    therefore not a recommended practice. In fact, more recent releases
    of Bash do not permit this usage. An underscore **\_** works,
    though.

    .. raw:: html

       </p>

    A *colon* can serve as a placeholder in an otherwise empty function.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     not_empty ()         |
    |     {                    |
    |       :                  |
    |     } # Contains a : (nu |
    | ll command), and so is n |
    | ot empty.                |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

!
    .. raw:: html

       <div class="FORMALPARA">

    **reverse (or negate) the sense of a test or exit status [bang].**
    The ! operator inverts the `exit
    status <exit-status.html#EXITSTATUSREF>`__ of the command to which
    it is applied (see `Example 6-2 <exit-status.html#NEGCOND>`__). It
    also inverts the meaning of a test operator. This can, for example,
    change the sense of *equal* (
    `= <comparison-ops.html#EQUALSIGNREF>`__ ) to *not-equal* ( != ).
    The ! operator is a Bash `keyword <internal.html#KEYWORDREF>`__.

    .. raw:: html

       </div>

    In a different context, the ! also appears in `indirect variable
    references <ivr.html#IVRREF>`__.

    In yet another context, from the *command line*, the ! invokes the
    Bash *history mechanism* (see `Appendix L <histcommands.html>`__).
    Note that within a script, the history mechanism is disabled.

\*
    .. raw:: html

       <div class="FORMALPARA">

    **wild card [asterisk].** The \* character serves as a "wild card"
    for filename expansion in `globbing <globbingref.html>`__. By
    itself, it matches every filename in a given directory.

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo *         |
    |     abs-book.sgml add-dr |
    | ive.sh agram.sh alias.sh |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The \* also represents `any number (or zero)
    characters <x17129.html#ASTERISKREG>`__ in a `regular
    expression <regexp.html#REGEXREF>`__.

\*
    .. raw:: html

       <div class="FORMALPARA">

    **`arithmetic operator <ops.html#AROPS1>`__.** In the context of
    arithmetic operations, the \* denotes multiplication.

    .. raw:: html

       </div>

    \*\* A double asterisk can represent the
    `exponentiation <ops.html#EXPONENTIATIONREF>`__ operator or
    `extended file-match <bashver4.html#GLOBSTARREF>`__ *globbing*.

?
    .. raw:: html

       <div class="FORMALPARA">

    **test operator.** Within certain expressions, the ? indicates a
    test for a condition.

    .. raw:: html

       </div>

    In a `double-parentheses construct <dblparens.html>`__, the ? can
    serve as an element of a C-style *trinary* operator.
    `[2] <special-chars.html#FTN.AEN888>`__

    ``condition``\ **?**\ ``result-if-true``\ **:**\ ``result-if-false``

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     (( var0 = var1<98?9: |
    | 21 ))                    |
    |     #                ^ ^ |
    |                          |
    |     # if [ "$var1" -lt 9 |
    | 8 ]                      |
    |     # then               |
    |     #   var0=9           |
    |     # else               |
    |     #   var0=21          |
    |     # fi                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    In a `parameter
    substitution <parameter-substitution.html#PARAMSUBREF>`__
    expression, the ? `tests whether a variable has been
    set <parameter-substitution.html#QERRMSG>`__.

?
    .. raw:: html

       <div class="FORMALPARA">

    **wild card.** The ? character serves as a single-character "wild
    card" for filename expansion in `globbing <globbingref.html>`__, as
    well as `representing one character <x17129.html#QUEXREGEX>`__ in an
    `extended regular expression <x17129.html#EXTREGEX>`__.

    .. raw:: html

       </div>

$
    .. raw:: html

       <div class="FORMALPARA">

    **`Variable substitution <varsubn.html>`__ (contents of a
    variable).**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     var1=5               |
    |     var2=23skidoo        |
    |                          |
    |     echo $var1     # 5   |
    |     echo $var2     # 23s |
    | kidoo                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    A $ prefixing a variable name indicates the *value* the variable
    holds.

$
    .. raw:: html

       <div class="FORMALPARA">

    **end-of-line.** In a `regular expression <regexp.html#REGEXREF>`__,
    a "$" addresses the `end of a line <x17129.html#DOLLARSIGNREF>`__ of
    text.

    .. raw:: html

       </div>

${}
    .. raw:: html

       <div class="FORMALPARA">

    **`Parameter
    substitution <parameter-substitution.html#PARAMSUBREF>`__.**

    .. raw:: html

       </div>

$' ... '
    .. raw:: html

       <div class="FORMALPARA">

    **`Quoted string expansion <escapingsection.html#STRQ>`__.** This
    construct expands single or multiple escaped octal or hex values
    into ASCII `[3] <special-chars.html#FTN.AEN1001>`__ or
    `Unicode <bashver4.html#UNICODEREF>`__ characters.

    .. raw:: html

       </div>

$\*, $@
    .. raw:: html

       <div class="FORMALPARA">

    **`positional parameters <internalvariables.html#APPREF>`__.**

    .. raw:: html

       </div>

$?
    .. raw:: html

       <div class="FORMALPARA">

    **exit status variable.** The `$?
    variable <exit-status.html#EXSREF>`__ holds the `exit
    status <exit-status.html#EXITSTATUSREF>`__ of a command, a
    `function <functions.html#FUNCTIONREF>`__, or of the script itself.

    .. raw:: html

       </div>

$$
    .. raw:: html

       <div class="FORMALPARA">

    **process ID variable.** The `$$
    variable <internalvariables.html#PROCCID>`__ holds the *process ID*
    `[4] <special-chars.html#FTN.AEN1071>`__ of the script in which it
    appears.

    .. raw:: html

       </div>

()
    .. raw:: html

       <div class="FORMALPARA">

    **command group.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     (a=hello; echo $a)   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    .. raw:: html

       <div class="IMPORTANT">

    +----------------+----------------+----------------+----------------+----------------+
    | |Important|    |
    | A listing of   |
    | commands       |
    | within         |
    | ``parentheses` |
    | `              |
    | starts a       |
    | `subshell <sub |
    | shells.html#SU |
    | BSHELLSREF>`__ |
    | .              |
    |                |
    | Variables      |
    | inside         |
    | parentheses,   |
    | within the     |
    | subshell, are  |
    | not visible to |
    | the rest of    |
    | the script.    |
    | The parent     |
    | process, the   |
    | script,        |
    | `cannot read   |
    | variables      |
    | created in the |
    | child          |
    | process <subsh |
    | ells.html#PARV |
    | IS>`__,        |
    | the subshell.  |
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
    | |     a=123    |
    |              | |
    | |     ( a=321; |
    |  )           | |
    | |              |
    |              | |
    | |     echo "a  |
    | = $a"   # a  | |
    | | = 123        |
    |              | |
    | |     # "a" wi |
    | thin parenth | |
    | | eses acts li |
    | ke a local v | |
    | | ariable.     |
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
    | .. raw:: html  |
    |                |
    |    </p>        |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="FORMALPARA">

    **array initialization.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     Array=(element1 elem |
    | ent2 element3)           |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       </div>

{xxx,yyy,zzz,...}
    .. raw:: html

       <div class="FORMALPARA">

    **Brace expansion.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo \"{These,words, |
    | are,quoted}\"   # " pref |
    | ix and suffix            |
    |     # "These" "words" "a |
    | re" "quoted"             |
    |                          |
    |                          |
    |     cat {file1,file2,fil |
    | e3} > combined_file      |
    |     # Concatenates the f |
    | iles file1, file2, and f |
    | ile3 into combined_file. |
    |                          |
    |     cp file22.{txt,backu |
    | p}                       |
    |     # Copies "file22.txt |
    | " to "file22.backup"     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    A command may act upon a comma-separated list of file specs within
    ``braces``. `[5] <special-chars.html#FTN.AEN1124>`__ Filename
    expansion (`globbing <globbingref.html>`__) applies to the file
    specs between the braces.

    .. raw:: html

       <div class="CAUTION">

    +--------------------+--------------------+--------------------+--------------------+
    | |Caution|          |
    | No spaces allowed  |
    | within the braces  |
    | *unless* the       |
    | spaces are quoted  |
    | or escaped.        |
    |                    |
    | ``echo {file1,file |
    | 2}\ :{\ A," B",' C |
    | '}``               |
    |                    |
    | ``file1 : A file1  |
    | : B file1 : C file |
    | 2 : A file2 : B fi |
    | le2 : C``          |
    +--------------------+--------------------+--------------------+--------------------+

    .. raw:: html

       </div>

{a..z}
    .. raw:: html

       <div class="FORMALPARA">

    **Extended Brace expansion.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo {a..z} # a b c  |
    | d e f g h i j k l m n o  |
    | p q r s t u v w x y z    |
    |     # Echoes characters  |
    | between a and z.         |
    |                          |
    |     echo {0..3} # 0 1 2  |
    | 3                        |
    |     # Echoes characters  |
    | between 0 and 3.         |
    |                          |
    |                          |
    |     base64_charset=( {A. |
    | .Z} {a..z} {0..9} + / =  |
    | )                        |
    |     # Initializing an ar |
    | ray, using extended brac |
    | e expansion.             |
    |     # From vladz's "base |
    | 64.sh" example script.   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    The *{a..z}* `extended brace
    expansion <bashver3.html#BRACEEXPREF3>`__ construction is a feature
    introduced in `version 3 <bashver3.html#BASH3REF>`__ of *Bash*.

{}
    .. raw:: html

       <div class="FORMALPARA">

    **Block of code [curly brackets].** Also referred to as an *inline
    group*, this construct, in effect, creates an *anonymous function*
    (a function without a name). However, unlike in a "standard"
    `function <functions.html#FUNCTIONREF>`__, the variables inside a
    code block remain visible to the remainder of the script.

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ { local a;     |
    |               a=123; }   |
    |     bash: local: can onl |
    | y be used in a           |
    |     function             |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     a=123                |
    |     { a=321; }           |
    |     echo "a = $a"   # a  |
    | = 321   (value inside co |
    | de block)                |
    |                          |
    |     # Thanks, S.C.       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The code block enclosed in braces may have `I/O
    redirected <io-redirection.html#IOREDIRREF>`__ to and from it.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 3-1. Code blocks and I/O redirection**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Reading lines in / |
    | etc/fstab.               |
    |                          |
    |     File=/etc/fstab      |
    |                          |
    |     {                    |
    |     read line1           |
    |     read line2           |
    |     } < $File            |
    |                          |
    |     echo "First line in  |
    | $File is:"               |
    |     echo "$line1"        |
    |     echo                 |
    |     echo "Second line in |
    |  $File is:"              |
    |     echo "$line2"        |
    |                          |
    |     exit 0               |
    |                          |
    |     # Now, how do you pa |
    | rse the separate fields  |
    | of each line?            |
    |     # Hint: use awk, or  |
    | . . .                    |
    |     # . . . Hans-Joerg D |
    | iers suggests using the  |
    | "set" Bash builtin.      |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 3-2. Saving the output of a code block to a file**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # rpm-check.sh       |
    |                          |
    |     #  Queries an rpm fi |
    | le for description, list |
    | ing,                     |
    |     #+ and whether it ca |
    | n be installed.          |
    |     #  Saves output to a |
    |  file.                   |
    |     #                    |
    |     #  This script illus |
    | trates using a code bloc |
    | k.                       |
    |                          |
    |     SUCCESS=0            |
    |     E_NOARGS=65          |
    |                          |
    |     if [ -z "$1" ]       |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` rpm-file"       |
    |       exit $E_NOARGS     |
    |     fi                   |
    |                          |
    |     { # Begin code block |
    | .                        |
    |       echo               |
    |       echo "Archive Desc |
    | ription:"                |
    |       rpm -qpi $1        |
    | # Query description.     |
    |       echo               |
    |       echo "Archive List |
    | ing:"                    |
    |       rpm -qpl $1        |
    | # Query listing.         |
    |       echo               |
    |       rpm -i --test $1   |
    | # Query whether rpm file |
    |  can be installed.       |
    |       if [ "$?" -eq $SUC |
    | CESS ]                   |
    |       then               |
    |         echo "$1 can be  |
    | installed."              |
    |       else               |
    |         echo "$1 cannot  |
    | be installed."           |
    |       fi                 |
    |       echo               |
    | # End code block.        |
    |     } > "$1.test"        |
    | # Redirects output of ev |
    | erything in block to fil |
    | e.                       |
    |                          |
    |     echo "Results of rpm |
    |  test in file $1.test"   |
    |                          |
    |     # See rpm man page f |
    | or explanation of option |
    | s.                       |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------------------+--------------------------+--------------------------+
    | |Note|                   |
    | Unlike a command group   |
    | within (parentheses), as |
    | above, a code block      |
    | enclosed by {braces}     |
    | will *not* normally      |
    | launch a                 |
    | `subshell <subshells.htm |
    | l#SUBSHELLSREF>`__.      |
    | `[6] <special-chars.html |
    | #FTN.AEN1199>`__         |
    |                          |
    | It is possible to        |
    | `iterate <loops1.html#IT |
    | ERATIONREF>`__           |
    | a code block using a     |
    | `non-standard            |
    | *for-loop* <loops1.html# |
    | NODODONE>`__.            |
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

{}
    .. raw:: html

       <div class="FORMALPARA">

    **placeholder for text.** Used after `xargs
    ``-i`` <moreadv.html#XARGSCURLYREF>`__ (*replace strings* option).
    The {} double curly brackets are a placeholder for output text.

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     ls . | xargs -i -t c |
    | p ./{} $1                |
    |     #            ^^      |
    |     ^^                   |
    |                          |
    |     # From "ex42.sh" (co |
    | pydir.sh) example.       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

{} \\;
    .. raw:: html

       <div class="FORMALPARA">

    **pathname.** Mostly used in `find <moreadv.html#FINDREF>`__
    constructs. This is *not* a shell
    `builtin <internal.html#BUILTINREF>`__.

    .. raw:: html

       </div>

    +--------------------------------------------------------------------------+
    | .. raw:: html                                                            |
    |                                                                          |
    |    <div class="SIDEBAR">                                                 |
    |                                                                          |
    | Definition: A *pathname* is a *filename* that includes the complete      |
    | `path <internalvariables.html#PATHREF>`__. As an example,                |
    | ``/home/bozo/Notes/Thursday/schedule.txt``. This is sometimes referred   |
    | to as the *absolute path*.                                               |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </div>                                                                |
                                                                              
    +--------------------------------------------------------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The ";" ends the ``-exec`` option of |
    | a **find** command sequence. It      |
    | needs to be escaped to protect it    |
    | from interpretation by the shell.    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

[ ]
    .. raw:: html

       <div class="FORMALPARA">

    **test.**

    .. raw:: html

       </div>

    `Test <tests.html#IFTHEN>`__ expression between **[ ]**. Note that
    **[** is part of the shell *builtin*
    `test <testconstructs.html#TTESTREF>`__ (and a synonym for it),
    *not* a link to the external command ``/usr/bin/test``.

[[ ]]
    .. raw:: html

       <div class="FORMALPARA">

    **test.**

    .. raw:: html

       </div>

    Test expression between [[ ]]. More flexible than the single-bracket
    [ ] test, this is a shell `keyword <internal.html#KEYWORDREF>`__.

    See the discussion on the `[[ ... ]]
    construct <testconstructs.html#DBLBRACKETS>`__.

[ ]
    .. raw:: html

       <div class="FORMALPARA">

    **array element.**

    .. raw:: html

       </div>

    In the context of an `array <arrays.html#ARRAYREF>`__, brackets set
    off the numbering of each element of that array.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     Array[1]=slot_1      |
    |     echo ${Array[1]}     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

[ ]
    .. raw:: html

       <div class="FORMALPARA">

    **range of characters.**

    .. raw:: html

       </div>

    As part of a `regular expression <regexp.html#REGEXREF>`__, brackets
    delineate a `range of characters <x17129.html#BRACKETSREF>`__ to
    match.

$[ ... ]
    .. raw:: html

       <div class="FORMALPARA">

    **integer expansion.**

    .. raw:: html

       </div>

    Evaluate integer expression between $[ ].

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     a=3                  |
    |     b=7                  |
    |                          |
    |     echo $[$a+$b]   # 10 |
    |     echo $[$a*$b]   # 21 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Note that this usage is *deprecated*, and has been replaced by the
    `(( ... )) <dblparens.html>`__ construct.

(( ))
    .. raw:: html

       <div class="FORMALPARA">

    **integer expansion.**

    .. raw:: html

       </div>

    Expand and evaluate integer expression between (( )).

    See the discussion on the `(( ... )) construct <dblparens.html>`__.

> &> >& >> < <>
    .. raw:: html

       <div class="FORMALPARA">

    **`redirection <io-redirection.html#IOREDIRREF>`__.**

    .. raw:: html

       </div>

    ``scriptname >filename`` redirects the output of ``scriptname`` to
    file ``filename``. Overwrite ``filename`` if it already exists.

    ``command &>filename`` redirects both the
    ```stdout`` <ioredirintro.html#STDINOUTDEF>`__ and the ``stderr`` of
    ``command`` to ``filename``.

    .. raw:: html

       <div class="NOTE">

    +----------+----------+----------+----------+----------+----------+----------+----------+----------+
    | |Note|   |
    |  This is |
    | useful   |
    | for      |
    | suppress |
    | ing      |
    | output   |
    | when     |
    | testing  |
    | for a    |
    | conditio |
    | n.       |
    | For      |
    | example, |
    | let us   |
    | test     |
    | whether  |
    | a        |
    | certain  |
    | command  |
    | exists.  |
    |          |
    | +------- |
    | -------- |
    | -------- |
    | ---+---- |
    | -------- |
    | -------- |
    | ------+- |
    | -------- |
    | -------- |
    | -------- |
    | -+       |
    | | .. cod |
    | e:: SCRE |
    | EN       |
    |    |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |     ba |
    | sh$ type |
    |  bogus_c |
    | om |     |
    | | mand & |
    | >/dev/nu |
    | ll       |
    |    |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |     ba |
    | sh$ echo |
    |  $?      |
    |    |     |
    | |     1  |
    |          |
    |          |
    |    |     |
    | |        |
    |          |
    |          |
    |    |     |
    |          |
    |          |
    |          |
    |          |
    | +------- |
    | -------- |
    | -------- |
    | ---+---- |
    | -------- |
    | -------- |
    | ------+- |
    | -------- |
    | -------- |
    | -------- |
    | -+       |
    |          |
    | .. raw:: |
    |  html    |
    |          |
    |    </p>  |
    |          |
    | Or in a  |
    | script:  |
    |          |
    | +------- |
    | -------- |
    | -------- |
    | ---+---- |
    | -------- |
    | -------- |
    | ------+- |
    | -------- |
    | -------- |
    | -------- |
    | -+       |
    | | .. cod |
    | e:: PROG |
    | RAMLISTI |
    | NG |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |     co |
    | mmand_te |
    | st () {  |
    | ty |     |
    | | pe "$1 |
    | " &>/dev |
    | /null; } |
    |    |     |
    | |     #  |
    |          |
    |          |
    |    |     |
    | |        |
    |          |
    |      ^   |
    |    |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |     cm |
    | d=rmdir  |
    |          |
    |    |     |
    | |  # Leg |
    | itimate  |
    | command. |
    |    |     |
    | |     co |
    | mmand_te |
    | st $cmd; |
    |  e |     |
    | | cho $? |
    |    # 0   |
    |          |
    |    |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |     cm |
    | d=bogus_ |
    | command  |
    |    |     |
    | |  # Ill |
    | egitimat |
    | e comman |
    | d  |     |
    | |     co |
    | mmand_te |
    | st $cmd; |
    |  e |     |
    | | cho $? |
    |    # 1   |
    |          |
    |    |     |
    |          |
    |          |
    |          |
    |          |
    | +------- |
    | -------- |
    | -------- |
    | ---+---- |
    | -------- |
    | -------- |
    | ------+- |
    | -------- |
    | -------- |
    | -------- |
    | -+       |
    |          |
    | .. raw:: |
    |  html    |
    |          |
    |    </p>  |
              
    +----------+----------+----------+----------+----------+----------+----------+----------+----------+

    .. raw:: html

       </div>

    ``command >&2`` redirects ``stdout`` of ``command`` to ``stderr``.

    ``scriptname >>filename`` appends the output of ``scriptname`` to
    file ``filename``. If ``filename`` does not already exist, it is
    created.

    ``[i]<>filename`` opens file ``filename`` for reading and writing,
    and assigns `file descriptor <io-redirection.html#FDREF>`__ i to it.
    If ``filename`` does not exist, it is created.

    .. raw:: html

       <div class="FORMALPARA">

    **`process substitution <process-sub.html#PROCESSSUBREF>`__.**

    .. raw:: html

       </div>

    ``(command)>``

    ``<(command)``

    `In a different context <comparison-ops.html#LTREF>`__, the "<" and
    ">" characters act as `string comparison
    operators <comparison-ops.html#SCOMPARISON1>`__.

    `In yet another context <comparison-ops.html#INTLT>`__, the "<" and
    ">" characters act as `integer comparison
    operators <comparison-ops.html#ICOMPARISON1>`__. See also `Example
    16-9 <moreadv.html#EX45>`__.

<<
    .. raw:: html

       <div class="FORMALPARA">

    **redirection used in a `here
    document <here-docs.html#HEREDOCREF>`__.**

    .. raw:: html

       </div>

<<<
    .. raw:: html

       <div class="FORMALPARA">

    **redirection used in a `here
    string <x17837.html#HERESTRINGSREF>`__.**

    .. raw:: html

       </div>

<, >
    .. raw:: html

       <div class="FORMALPARA">

    **`ASCII comparison <comparison-ops.html#LTREF>`__.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     veg1=carrots         |
    |     veg2=tomatoes        |
    |                          |
    |     if [[ "$veg1" < "$ve |
    | g2" ]]                   |
    |     then                 |
    |       echo "Although $ve |
    | g1 precede $veg2 in the  |
    | dictionary,"             |
    |       echo -n "this does |
    |  not necessarily imply a |
    | nything "                |
    |       echo "about my cul |
    | inary preferences."      |
    |     else                 |
    |       echo "What kind of |
    |  dictionary are you usin |
    | g, anyhow?"              |
    |     fi                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       </div>

\\<, \\>
    .. raw:: html

       <div class="FORMALPARA">

    **`word boundary <x17129.html#ANGLEBRAC>`__ in a `regular
    expression <regexp.html#REGEXREF>`__.**

    .. raw:: html

       </div>

    ``bash$ ``\ ``grep '\<the\>' textfile``

\|

    .. raw:: html

       <div class="FORMALPARA">

    **pipe.** Passes the output (``stdout``) of a previous command to
    the input (``stdin``) of the next one, or to the shell. This is a
    method of chaining commands together.

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo ls -l | sh      |
    |     #  Passes the output |
    |  of "echo ls -l" to the  |
    | shell,                   |
    |     #+ with the same res |
    | ult as a simple "ls -l". |
    |                          |
    |                          |
    |     cat *.lst | sort | u |
    | niq                      |
    |     # Merges and sorts a |
    | ll ".lst" files, then de |
    | letes duplicate lines.   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    +--------------------------------------------------------------------------+
    | .. raw:: html                                                            |
    |                                                                          |
    |    <div class="SIDEBAR">                                                 |
    |                                                                          |
    | A pipe, as a classic method of interprocess communication, sends the     |
    | ``stdout`` of one `process <special-chars.html#PROCESSREF>`__ to the     |
    | ``stdin`` of another. In a typical case, a command, such as              |
    | `cat <basic.html#CATREF>`__ or `echo <internal.html#ECHOREF>`__, pipes a |
    | stream of data to a *filter*, a command that transforms its input for    |
    | processing. `[7] <special-chars.html#FTN.AEN1564>`__                     |
    |                                                                          |
    | ``cat $filename1 $filename2 | grep $search_word``                        |
    |                                                                          |
    | For an interesting note on the complexity of using UNIX pipes, see `the  |
    | UNIX FAQ, Part 3 <http://www.faqs.org/faqs/unix-faq/faq/part3/>`__.      |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </div>                                                                |
                                                                              
    +--------------------------------------------------------------------------+

    The output of a command or commands may be piped to a script.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # uppercase.sh : Cha |
    | nges input to uppercase. |
    |                          |
    |     tr 'a-z' 'A-Z'       |
    |     #  Letter ranges mus |
    | t be quoted              |
    |     #+ to prevent filena |
    | me generation from singl |
    | e-letter filenames.      |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    Now, let us pipe the output of **ls -l** to this script.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ls -l | ./uppe |
    | rcase.sh                 |
    |     -RW-RW-R--    1 BOZO |
    |   BOZO       109 APR  7  |
    | 19:49 1.TXT              |
    |      -RW-RW-R--    1 BOZ |
    | O  BOZO       109 APR 14 |
    |  16:48 2.TXT             |
    |      -RW-R--R--    1 BOZ |
    | O  BOZO       725 APR 20 |
    |  20:56 DATA-FILE         |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="NOTE">

    +-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
    | |Note|    |
    | The       |
    | ``stdout` |
    | `         |
    | of each   |
    | process   |
    | in a pipe |
    | must be   |
    | read as   |
    | the       |
    | ``stdin`` |
    | of the    |
    | next. If  |
    | this is   |
    | not the   |
    | case, the |
    | data      |
    | stream    |
    | will      |
    | *block*,  |
    | and the   |
    | pipe will |
    | not       |
    | behave as |
    | expected. |
    |           |
    | +-------- |
    | --------- |
    | --------- |
    | +-------- |
    | --------- |
    | --------- |
    | +-------- |
    | --------- |
    | --------- |
    | +         |
    | | .. code |
    | :: PROGRA |
    | MLISTING  |
    | |         |
    | |         |
    |           |
    |           |
    | |         |
    | |     cat |
    |  file1 fi |
    | le2 | ls  |
    | |         |
    | |  -l | s |
    | ort       |
    |           |
    | |         |
    | |     # T |
    | he output |
    |  from "c  |
    | |         |
    | | at file |
    | 1 file2"  |
    | disappea  |
    | |         |
    | | rs.     |
    |           |
    |           |
    | |         |
    |           |
    |           |
    |           |
    | +-------- |
    | --------- |
    | --------- |
    | +-------- |
    | --------- |
    | --------- |
    | +-------- |
    | --------- |
    | --------- |
    | +         |
    |           |
    | .. raw::  |
    | html      |
    |           |
    |    </p>   |
    |           |
    | A pipe    |
    | runs as a |
    | `child    |
    | process < |
    | othertype |
    | sv.html#C |
    | HILDREF>` |
    | __,       |
    | and       |
    | therefore |
    | cannot    |
    | alter     |
    | script    |
    | variables |
    | .         |
    |           |
    | +-------- |
    | --------- |
    | --------- |
    | +-------- |
    | --------- |
    | --------- |
    | +-------- |
    | --------- |
    | --------- |
    | +         |
    | | .. code |
    | :: PROGRA |
    | MLISTING  |
    | |         |
    | |         |
    |           |
    |           |
    | |         |
    | |     var |
    | iable="in |
    | itial_va  |
    | |         |
    | | lue"    |
    |           |
    |           |
    | |         |
    | |     ech |
    | o "new_va |
    | lue" | r  |
    | |         |
    | | ead var |
    | iable     |
    |           |
    | |         |
    | |     ech |
    | o "variab |
    | le = $va  |
    | |         |
    | | riable" |
    |      # va |
    | riable =  |
    | |         |
    | |  initia |
    | l_value   |
    |           |
    | |         |
    |           |
    |           |
    |           |
    | +-------- |
    | --------- |
    | --------- |
    | +-------- |
    | --------- |
    | --------- |
    | +-------- |
    | --------- |
    | --------- |
    | +         |
    |           |
    | .. raw::  |
    | html      |
    |           |
    |    </p>   |
    |           |
    | If one of |
    | the       |
    | commands  |
    | in the    |
    | pipe      |
    | aborts,   |
    | this      |
    | premature |
    | ly        |
    | terminate |
    | s         |
    | execution |
    | of the    |
    | pipe.     |
    | Called a  |
    | *broken   |
    | pipe*,    |
    | this      |
    | condition |
    | sends a   |
    | ``SIGPIPE |
    | ``        |
    | `signal < |
    | debugging |
    | .html#SIG |
    | NALD>`__. |
    +-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+

    .. raw:: html

       </div>

>\|
    .. raw:: html

       <div class="FORMALPARA">

    **force redirection (even if the `noclobber
    option <options.html#NOCLOBBERREF>`__ is set).** This will forcibly
    overwrite an existing file.

    .. raw:: html

       </div>

\|\|
    .. raw:: html

       <div class="FORMALPARA">

    **`OR logical operator <ops.html#ORREF>`__.** In a `test
    construct <testconstructs.html#TESTCONSTRUCTS1>`__, the \|\|
    operator causes a return of 0 (success) if *either* of the linked
    test conditions is true.

    .. raw:: html

       </div>

&
    .. raw:: html

       <div class="FORMALPARA">

    **Run job in background.** A command followed by an & will run in
    the background.

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ sleep 10 &     |
    |     [1] 850              |
    |     [1]+  Done           |
    |           sleep 10       |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Within a script, commands and even
    `loops <loops1.html#FORLOOPREF1>`__ may run in the background.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 3-3. Running a loop in the background**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # background-loop.sh |
    |                          |
    |     for i in 1 2 3 4 5 6 |
    |  7 8 9 10            # F |
    | irst loop.               |
    |     do                   |
    |       echo -n "$i "      |
    |     done & # Run this lo |
    | op in background.        |
    |            # Will someti |
    | mes execute after second |
    |  loop.                   |
    |                          |
    |     echo   # This 'echo' |
    |  sometimes will not disp |
    | lay.                     |
    |                          |
    |     for i in 11 12 13 14 |
    |  15 16 17 18 19 20   # S |
    | econd loop.              |
    |     do                   |
    |       echo -n "$i "      |
    |     done                 |
    |                          |
    |     echo   # This 'echo' |
    |  sometimes will not disp |
    | lay.                     |
    |                          |
    |     # ================== |
    | ======================== |
    | ============             |
    |                          |
    |     # The expected outpu |
    | t from the script:       |
    |     # 1 2 3 4 5 6 7 8 9  |
    | 10                       |
    |     # 11 12 13 14 15 16  |
    | 17 18 19 20              |
    |                          |
    |     # Sometimes, though, |
    |  you get:                |
    |     # 11 12 13 14 15 16  |
    | 17 18 19 20              |
    |     # 1 2 3 4 5 6 7 8 9  |
    | 10 bozo $                |
    |     # (The second 'echo' |
    |  doesn't execute. Why?)  |
    |                          |
    |     # Occasionally also: |
    |     # 1 2 3 4 5 6 7 8 9  |
    | 10 11 12 13 14 15 16 17  |
    | 18 19 20                 |
    |     # (The first 'echo'  |
    | doesn't execute. Why?)   |
    |                          |
    |     # Very rarely someth |
    | ing like:                |
    |     # 11 12 13 1 2 3 4 5 |
    |  6 7 8 9 10 14 15 16 17  |
    | 18 19 20                 |
    |     # The foreground loo |
    | p preempts the backgroun |
    | d one.                   |
    |                          |
    |     exit 0               |
    |                          |
    |     #  Nasimuddin Ansari |
    |  suggests adding    slee |
    | p 1                      |
    |     #+ after the   echo  |
    | -n "$i"   in lines 6 and |
    |  14,                     |
    |     #+ for some real fun |
    | .                        |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | A command run in the background      |
    | within a script may cause the script |
    | to hang, waiting for a keystroke.    |
    | Fortunately, there is a              |
    | `remedy <x9644.html#WAITHANG>`__ for |
    | this.                                |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

&&
    .. raw:: html

       <div class="FORMALPARA">

    **`AND logical operator <ops.html#LOGOPS1>`__.** In a `test
    construct <testconstructs.html#TESTCONSTRUCTS1>`__, the && operator
    causes a return of 0 (success) only if *both* the linked test
    conditions are true.

    .. raw:: html

       </div>

-
    .. raw:: html

       <div class="FORMALPARA">

    **option, prefix.** Option flag for a command or filter. Prefix for
    an operator. Prefix for a `default
    parameter <parameter-substitution.html#DEFPARAM1>`__ in `parameter
    substitution <parameter-substitution.html#PARAMSUBREF>`__.

    .. raw:: html

       </div>

    ``COMMAND -[Option1][Option2][...]``

    ``ls -al``

    ``sort -dfu $filename``

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     if [ $file1 -ot $fil |
    | e2 ]                     |
    |     then #      ^        |
    |       echo "File $file1  |
    | is older than $file2."   |
    |     fi                   |
    |                          |
    |     if [ "$a" -eq "$b" ] |
    |     then #    ^          |
    |       echo "$a is equal  |
    | to $b."                  |
    |     fi                   |
    |                          |
    |     if [ "$c" -eq 24 -a  |
    | "$d" -eq 47 ]            |
    |     then #    ^          |
    |      ^                   |
    |       echo "$c equals 24 |
    |  and $d equals 47."      |
    |     fi                   |
    |                          |
    |                          |
    |     param2=${param1:-$DE |
    | FAULTVAL}                |
    |     #               ^    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    **--**

    The *double-dash* ``--`` prefixes *long* (verbatim) options to
    commands.

    ``sort --ignore-leading-blanks``

    Used with a `Bash builtin <internal.html#BUILTINREF>`__, it means
    the *end of options* to that particular command.

    .. raw:: html

       <div class="TIP">

    +--------------------+--------------------+--------------------+--------------------+
    | |Tip|              |
    | This provides a    |
    | handy means of     |
    | removing files     |
    | whose *names begin |
    | with a dash*.      |
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
    | |     bash$ ls -l  |
    |          |         |
    | |     -rw-r--r-- 1 |
    |  bozo bo |         |
    | | zo 0 Nov 25 12:2 |
    | 9 -badna |         |
    | | me               |
    |          |         |
    | |                  |
    |          |         |
    | |                  |
    |          |         |
    | |     bash$ rm --  |
    | -badname |         |
    | |                  |
    |          |         |
    | |     bash$ ls -l  |
    |          |         |
    | |     total 0      |
    |          |         |
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

    The *double-dash* is also used in conjunction with
    `set <internal.html#SETREF>`__.

    ``set -- $variable`` (as in `Example
    15-18 <internal.html#SETPOS>`__)

-
    .. raw:: html

       <div class="FORMALPARA">

    **redirection from/to ``stdin`` or ``stdout`` [dash].**

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ cat -          |
    |     abc                  |
    |     abc                  |
    |                          |
    |     ...                  |
    |                          |
    |     Ctl-D                |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    As expected, ``cat -`` echoes ``stdin``, in this case keyboarded
    user input, to ``stdout``. But, does I/O redirection using **-**
    have real-world applications?

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     (cd /source/director |
    | y && tar cf - . ) | (cd  |
    | /dest/directory && tar x |
    | pvf -)                   |
    |     # Move entire file t |
    | ree from one directory t |
    | o another                |
    |     # [courtesy Alan Cox |
    |  <a.cox@swansea.ac.uk>,  |
    | with a minor change]     |
    |                          |
    |     # 1) cd /source/dire |
    | ctory                    |
    |     #    Source director |
    | y, where the files to be |
    |  moved are.              |
    |     # 2) &&              |
    |     #   "And-list": if t |
    | he 'cd' operation succes |
    | sful,                    |
    |     #    then execute th |
    | e next command.          |
    |     # 3) tar cf - .      |
    |     #    The 'c' option  |
    | 'tar' archiving command  |
    | creates a new archive,   |
    |     #    the 'f' (file)  |
    | option, followed by '-'  |
    | designates the target fi |
    | le                       |
    |     #    as stdout, and  |
    | do it in current directo |
    | ry tree ('.').           |
    |     # 4) |               |
    |     #    Piped to ...    |
    |     # 5) ( ... )         |
    |     #    a subshell      |
    |     # 6) cd /dest/direct |
    | ory                      |
    |     #    Change to the d |
    | estination directory.    |
    |     # 7) &&              |
    |     #   "And-list", as a |
    | bove                     |
    |     # 8) tar xpvf -      |
    |     #    Unarchive ('x') |
    | , preserve ownership and |
    |  file permissions ('p'), |
    |     #    and send verbos |
    | e messages to stdout ('v |
    | '),                      |
    |     #    reading data fr |
    | om stdin ('f' followed b |
    | y '-').                  |
    |     #                    |
    |     #    Note that 'x' i |
    | s a command, and 'p', 'v |
    | ', 'f' are options.      |
    |     #                    |
    |     # Whew!              |
    |                          |
    |                          |
    |                          |
    |     # More elegant than, |
    |  but equivalent to:      |
    |     #   cd source/direct |
    | ory                      |
    |     #   tar cf - . | (cd |
    |  ../dest/directory; tar  |
    | xpvf -)                  |
    |     #                    |
    |     #     Also having sa |
    | me effect:               |
    |     # cp -a /source/dire |
    | ctory/* /dest/directory  |
    |     #     Or:            |
    |     # cp -a /source/dire |
    | ctory/* /source/director |
    | y/.[^.]* /dest/directory |
    |     #     If there are h |
    | idden files in /source/d |
    | irectory.                |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     bunzip2 -c linux-2.6 |
    | .16.tar.bz2 | tar xvf -  |
    |     #  --uncompress tar  |
    | file--      | --then pas |
    | s it to "tar"--          |
    |     #  If "tar" has not  |
    | been patched to handle " |
    | bunzip2",                |
    |     #+ this needs to be  |
    | done in two discrete ste |
    | ps, using a pipe.        |
    |     #  The purpose of th |
    | e exercise is to unarchi |
    | ve "bzipped" kernel sour |
    | ce.                      |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Note that in this context the "-" is not itself a Bash operator, but
    rather an option recognized by certain UNIX utilities that write to
    ``stdout``, such as **tar**, **cat**, etc.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo "whatever |
    | " | cat -                |
    |     whatever             |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Where a filename is expected, ``-`` redirects output to ``stdout``
    (sometimes seen with ``tar cf``), or accepts input from ``stdin``,
    rather than from a file. This is a method of using a file-oriented
    utility as a filter in a pipe.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ file           |
    |     Usage: file [-bciknv |
    | zL] [-f namefile] [-m ma |
    | gicfiles] file...        |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    By itself on the command-line, `file <filearchiv.html#FILEREF>`__
    fails with an error message.

    .. raw:: html

       </p>

    Add a "-" for a more useful result. This causes the shell to await
    user input.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ file -         |
    |     abc                  |
    |     standard input:      |
    |          ASCII text      |
    |                          |
    |                          |
    |                          |
    |     bash$ file -         |
    |     #!/bin/bash          |
    |     standard input:      |
    |          Bourne-Again sh |
    | ell script text executab |
    | le                       |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    Now the command accepts input from ``stdin`` and analyzes it.

    .. raw:: html

       </p>

    The "-" can be used to pipe ``stdout`` to other commands. This
    permits such stunts as `prepending lines to a
    file <assortedtips.html#PREPENDREF>`__.

    Using `diff <filearchiv.html#DIFFREF>`__ to compare a file with a
    *section* of another:

    ``grep Linux file1 | diff file2 -``

    Finally, a real-world example using ``-`` with
    `tar <filearchiv.html#TARREF>`__.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 3-4. Backup of all files changed in last day**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     #  Backs up all file |
    | s in current directory m |
    | odified within last 24 h |
    | ours                     |
    |     #+ in a "tarball" (t |
    | arred and gzipped file). |
    |                          |
    |     BACKUPFILE=backup-$( |
    | date +%m-%d-%Y)          |
    |     #                 Em |
    | beds date in backup file |
    | name.                    |
    |     #                 Th |
    | anks, Joshua Tschida, fo |
    | r the idea.              |
    |     archive=${1:-$BACKUP |
    | FILE}                    |
    |     #  If no backup-arch |
    | ive filename specified o |
    | n command-line,          |
    |     #+ it will default t |
    | o "backup-MM-DD-YYYY.tar |
    | .gz."                    |
    |                          |
    |     tar cvf - `find . -m |
    | time -1 -type f -print`  |
    | > $archive.tar           |
    |     gzip $archive.tar    |
    |     echo "Directory $PWD |
    |  backed up in archive fi |
    | le \"$archive.tar.gz\"." |
    |                          |
    |                          |
    |     #  Stephane Chazelas |
    |  points out that the abo |
    | ve code will fail        |
    |     #+ if there are too  |
    | many files found         |
    |     #+ or if any filenam |
    | es contain blank charact |
    | ers.                     |
    |                          |
    |     # He suggests the fo |
    | llowing alternatives:    |
    |     # ------------------ |
    | ------------------------ |
    | ------------------------ |
    | -                        |
    |     #   find . -mtime -1 |
    |  -type f -print0 | xargs |
    |  -0 tar rvf "$archive.ta |
    | r"                       |
    |     #      using the GNU |
    |  version of "find".      |
    |                          |
    |                          |
    |     #   find . -mtime -1 |
    |  -type f -exec tar rvf " |
    | $archive.tar" '{}' \;    |
    |     #         portable t |
    | o other UNIX flavors, bu |
    | t much slower.           |
    |     # ------------------ |
    | ------------------------ |
    | ------------------------ |
    | -                        |
    |                          |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +----------------+----------------+----------------+----------------+----------------+
    | |Caution|      |
    | Filenames      |
    | beginning with |
    | "-" may cause  |
    | problems when  |
    | coupled with   |
    | the "-"        |
    | redirection    |
    | operator. A    |
    | script should  |
    | check for this |
    | and add an     |
    | appropriate    |
    | prefix to such |
    | filenames, for |
    | example        |
    | ``./-FILENAME` |
    | `,             |
    | ``$PWD/-FILENA |
    | ME``,          |
    | or             |
    | ``$PATHNAME/-F |
    | ILENAME``.     |
    |                |
    | If the value   |
    | of a variable  |
    | begins with a  |
    | ``-``, this    |
    | may likewise   |
    | create         |
    | problems.      |
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
    | |     var="-n" |
    |              | |
    | |     echo $va |
    | r            | |
    | |     # Has th |
    | e effect of  | |
    | | "echo -n", a |
    | nd outputs n | |
    | | othing.      |
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
    | .. raw:: html  |
    |                |
    |    </p>        |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

-
    .. raw:: html

       <div class="FORMALPARA">

    **previous working directory.** A **cd -** command changes to the
    previous working directory. This uses the
    `$OLDPWD <internalvariables.html#OLDPWD>`__ `environmental
    variable <othertypesv.html#ENVREF>`__.

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | Do not confuse the "-" used in this  |
    | sense with the "-" redirection       |
    | operator just discussed. The         |
    | interpretation of the "-" depends on |
    | the context in which it appears.     |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

-
    .. raw:: html

       <div class="FORMALPARA">

    **Minus.** Minus sign in an `arithmetic
    operation <ops.html#AROPS1>`__.

    .. raw:: html

       </div>

=
    .. raw:: html

       <div class="FORMALPARA">

    **Equals.** `Assignment operator <varassignment.html#EQREF>`__

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     a=28                 |
    |     echo $a   # 28       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       </div>

    In a `different context <comparison-ops.html#EQUALSIGNREF>`__, the
    "=" is a `string comparison <comparison-ops.html#SCOMPARISON1>`__
    operator.

+
    .. raw:: html

       <div class="FORMALPARA">

    **Plus.** Addition `arithmetic operator <ops.html#AROPS1>`__.

    .. raw:: html

       </div>

    In a `different context <x17129.html#PLUSREF>`__, the + is a
    `Regular Expression <regexp.html>`__ operator.

+
    .. raw:: html

       <div class="FORMALPARA">

    **Option.** Option flag for a command or filter.

    .. raw:: html

       </div>

    Certain commands and `builtins <internal.html#BUILTINREF>`__ use the
    ``+`` to enable certain options and the ``-`` to disable them. In
    `parameter
    substitution <parameter-substitution.html#PARAMSUBREF>`__, the ``+``
    prefixes an `alternate
    value <parameter-substitution.html#PARAMALTV>`__ that a variable
    expands to.

%
    .. raw:: html

       <div class="FORMALPARA">

    **`modulo <ops.html#MODULOREF>`__.** Modulo (remainder of a
    division) `arithmetic operation <ops.html#AROPS1>`__.

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     let "z = 5 % 3"      |
    |     echo $z  # 2         |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    In a `different context <parameter-substitution.html#PCTPATREF>`__,
    the % is a `pattern matching <parameter-substitution.html#PSUB2>`__
    operator.

~
    .. raw:: html

       <div class="FORMALPARA">

    **home directory [tilde].** This corresponds to the
    `$HOME <internalvariables.html#HOMEDIRREF>`__ internal variable.
    ``~bozo`` is bozo's home directory, and **ls ~bozo** lists the
    contents of it. ~/ is the current user's home directory, and **ls
    ~/** lists the contents of it.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo ~bozo     |
    |     /home/bozo           |
    |                          |
    |     bash$ echo ~         |
    |     /home/bozo           |
    |                          |
    |     bash$ echo ~/        |
    |     /home/bozo/          |
    |                          |
    |     bash$ echo ~:        |
    |     /home/bozo:          |
    |                          |
    |     bash$ echo ~nonexist |
    | ent-user                 |
    |     ~nonexistent-user    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       </div>

~+
    .. raw:: html

       <div class="FORMALPARA">

    **current working directory.** This corresponds to the
    `$PWD <internalvariables.html#PWDREF>`__ internal variable.

    .. raw:: html

       </div>

~-
    .. raw:: html

       <div class="FORMALPARA">

    **previous working directory.** This corresponds to the
    `$OLDPWD <internalvariables.html#OLDPWD>`__ internal variable.

    .. raw:: html

       </div>

=~
    .. raw:: html

       <div class="FORMALPARA">

    **`regular expression match <bashver3.html#REGEXMATCHREF>`__.** This
    operator was introduced with `version 3 <bashver3.html#BASH3REF>`__
    of Bash.

    .. raw:: html

       </div>

^
    .. raw:: html

       <div class="FORMALPARA">

    **beginning-of-line.** In a `regular
    expression <regexp.html#REGEXREF>`__, a "^" addresses the `beginning
    of a line <x17129.html#CARETREF>`__ of text.

    .. raw:: html

       </div>

^, ^^
    .. raw:: html

       <div class="FORMALPARA">

    **`Uppercase conversion <bashver4.html#CASEMODPARAMSUB>`__ in
    *parameter substitution* (added in `version
    4 <bashver4.html#BASH4REF>`__ of Bash).**

    .. raw:: html

       </div>

Control Characters
    .. raw:: html

       <div class="FORMALPARA">

    **change the behavior of the terminal or text display.** A control
    character is a **CONTROL** + **key** combination (pressed
    simultaneously). A control character may also be written in *octal*
    or *hexadecimal* notation, following an *escape*.

    .. raw:: html

       </div>

    Control characters are not normally useful inside a script.

    -  ``Ctl-A``

       Moves cursor to beginning of line of text (on the command-line).

    -  ``Ctl-B``

       ``Backspace`` (nondestructive).

    -  

       ``Ctl-C``

       ``Break``. Terminate a foreground job.

    -  

       ``Ctl-D``

       *Log out* from a shell (similar to
       `exit <exit-status.html#EXITCOMMANDREF>`__).

       ``EOF`` (end-of-file). This also terminates input from ``stdin``.

       When typing text on the console or in an *xterm* window,
       ``Ctl-D`` erases the character under the cursor. When there are
       no characters present, ``Ctl-D`` logs out of the session, as
       expected. In an *xterm* window, this has the effect of closing
       the window.

    -  ``Ctl-E``

       Moves cursor to end of line of text (on the command-line).

    -  ``Ctl-F``

       Moves cursor forward one character position (on the
       command-line).

    -  

       ``Ctl-G``

       ``BEL``. On some old-time teletype terminals, this would actually
       ring a bell. In an *xterm* it might beep.

    -  

       ``Ctl-H``

       ``Rubout`` (destructive backspace). Erases characters the cursor
       backs over while backspacing.

       +--------------------------+--------------------------+--------------------------+
       | .. code:: PROGRAMLISTING |
       |                          |
       |     #!/bin/bash          |
       |     # Embedding Ctl-H in |
       |  a string.               |
       |                          |
       |     a="^H^H"             |
       |       # Two Ctl-H's -- b |
       | ackspaces                |
       |                          |
       |       # ctl-V ctl-H, usi |
       | ng vi/vim                |
       |     echo "abcdef"        |
       |       # abcdef           |
       |     echo                 |
       |     echo -n "abcdef$a "  |
       |       # abcd f           |
       |     #  Space at end  ^   |
       |             ^  Backspace |
       | s twice.                 |
       |     echo                 |
       |     echo -n "abcdef$a"   |
       |       # abcdef           |
       |     #  No space at end   |
       |              ^ Doesn't b |
       | ackspace (why?).         |
       |                          |
       |       # Results may not  |
       | be quite as expected.    |
       |     echo; echo           |
       |                          |
       |     # Constantin Hagemei |
       | er suggests trying:      |
       |     # a=$'\010\010'      |
       |     # a=$'\b\b'          |
       |     # a=$'\x08\x08'      |
       |     # But, this does not |
       |  change the results.     |
       |                          |
       |     #################### |
       | ####################     |
       |                          |
       |     # Now, try this.     |
       |                          |
       |     rubout="^H^H^H^H^H"  |
       |       # 5 x Ctl-H.       |
       |                          |
       |     echo -n "12345678"   |
       |     sleep 2              |
       |     echo -n "$rubout"    |
       |     sleep 2              |
                                 
       +--------------------------+--------------------------+--------------------------+

       .. raw:: html

          </p>

    -  ``Ctl-I``

       ``Horizontal tab``.

    -  

       ``Ctl-J``

       ``Newline`` (line feed). In a script, may also be expressed in
       octal notation -- '\\012' or in hexadecimal -- '\\x0a'.

    -  ``Ctl-K``

       ``Vertical tab``.

       When typing text on the console or in an *xterm* window,
       ``Ctl-K`` erases from the character under the cursor to end of
       line. Within a script, ``Ctl-K`` may behave differently, as in
       Lee Lee Maschmeyer's example, below.

    -  ``Ctl-L``

       ``Formfeed`` (clear the terminal screen). In a terminal, this has
       the same effect as the `clear <terminalccmds.html#CLEARREF>`__
       command. When sent to a printer, a ``Ctl-L`` causes an advance to
       end of the paper sheet.

    -  

       ``Ctl-M``

       ``Carriage return``.

       +--------------------------+--------------------------+--------------------------+
       | .. code:: PROGRAMLISTING |
       |                          |
       |     #!/bin/bash          |
       |     # Thank you, Lee Mas |
       | chmeyer, for this exampl |
       | e.                       |
       |                          |
       |     read -n 1 -s -p \    |
       |     $'Control-M leaves c |
       | ursor at beginning of th |
       | is line. Press Enter. \x |
       | 0d'                      |
       |                # Of cour |
       | se, '0d' is the hex equi |
       | valent of Control-M.     |
       |     echo >&2   #  The '- |
       | s' makes anything typed  |
       | silent,                  |
       |                #+ so it  |
       | is necessary to go to ne |
       | w line explicitly.       |
       |                          |
       |     read -n 1 -s -p $'Co |
       | ntrol-J leaves cursor on |
       |  next line. \x0a'        |
       |                #  '0a' i |
       | s the hex equivalent of  |
       | Control-J, linefeed.     |
       |     echo >&2             |
       |                          |
       |     ###                  |
       |                          |
       |     read -n 1 -s -p $'An |
       | d Control-K\x0bgoes stra |
       | ight down.'              |
       |     echo >&2   #  Contro |
       | l-K is vertical tab.     |
       |                          |
       |     # A better example o |
       | f the effect of a vertic |
       | al tab is:               |
       |                          |
       |     var=$'\x0aThis is th |
       | e bottom line\x0bThis is |
       |  the top line\x0a'       |
       |     echo "$var"          |
       |     #  This works the sa |
       | me way as the above exam |
       | ple. However:            |
       |     echo "$var" | col    |
       |     #  This causes the r |
       | ight end of the line to  |
       | be higher than the left  |
       | end.                     |
       |     #  It also explains  |
       | why we started and ended |
       |  with a line feed --     |
       |     #+ to avoid a garble |
       | d screen.                |
       |                          |
       |     # As Lee Maschmeyer  |
       | explains:                |
       |     # ------------------ |
       | --------                 |
       |     #  In the [first ver |
       | tical tab example] . . . |
       |  the vertical tab        |
       |     #+ makes the printin |
       | g go straight down witho |
       | ut a carriage return.    |
       |     #  This is true only |
       |  on devices, such as the |
       |  Linux console,          |
       |     #+ that can't go "ba |
       | ckward."                 |
       |     #  The real purpose  |
       | of VT is to go straight  |
       | UP, not down.            |
       |     #  It can be used to |
       |  print superscripts on a |
       |  printer.                |
       |     #  The col utility c |
       | an be used to emulate th |
       | e proper behavior of VT. |
       |                          |
       |     exit 0               |
                                 
       +--------------------------+--------------------------+--------------------------+

       .. raw:: html

          </p>

    -  ``Ctl-N``

       Erases a line of text recalled from *history buffer*
       `[8] <special-chars.html#FTN.AEN2107>`__ (on the command-line).

    -  ``Ctl-O``

       Issues a *newline* (on the command-line).

    -  ``Ctl-P``

       Recalls last command from *history buffer* (on the command-line).

    -  ``Ctl-Q``

       Resume (``XON``).

       This resumes ``stdin`` in a terminal.

    -  ``Ctl-R``

       Backwards search for text in *history buffer* (on the
       command-line).

    -  ``Ctl-S``

       Suspend (``XOFF``).

       This freezes ``stdin`` in a terminal. (Use Ctl-Q to restore
       input.)

    -  ``Ctl-T``

       Reverses the position of the character the cursor is on with the
       previous character (on the command-line).

    -  ``Ctl-U``

       Erase a line of input, from the cursor backward to beginning of
       line. In some settings, ``Ctl-U`` erases the entire line of
       input, *regardless of cursor position*.

    -  ``Ctl-V``

       When inputting text, ``Ctl-V`` permits inserting control
       characters. For example, the following two are equivalent:

       +--------------------------+--------------------------+--------------------------+
       | .. code:: PROGRAMLISTING |
       |                          |
       |     echo -e '\x0a'       |
       |     echo <Ctl-V><Ctl-J>  |
                                 
       +--------------------------+--------------------------+--------------------------+

       .. raw:: html

          </p>

       ``Ctl-V`` is primarily useful from within a text editor.

    -  ``Ctl-W``

       When typing text on the console or in an xterm window, ``Ctl-W``
       erases from the character under the cursor backwards to the first
       instance of `whitespace <special-chars.html#WHITESPACEREF>`__. In
       some settings, ``Ctl-W`` erases backwards to first
       non-alphanumeric character.

    -  ``Ctl-X``

       In certain word processing programs, *Cuts* highlighted text and
       copies to *clipboard*.

    -  ``Ctl-Y``

       *Pastes* back text previously erased (with ``Ctl-U`` or
       ``Ctl-W``).

    -  ``Ctl-Z``

       *Pauses* a foreground job.

       *Substitute* operation in certain word processing applications.

       ``EOF`` (end-of-file) character in the MSDOS filesystem.

Whitespace
    .. raw:: html

       <div class="FORMALPARA">

    **functions as a separator between commands and/or variables.**
    Whitespace consists of either *spaces*, *tabs*, *blank lines*, or
    any combination thereof. `[9] <special-chars.html#FTN.AEN2198>`__ In
    some contexts, such as `variable assignment <gotchas.html#WSBAD>`__,
    whitespace is not permitted, and results in a syntax error.

    .. raw:: html

       </div>

    Blank lines have no effect on the action of a script, and are
    therefore useful for visually separating functional sections.

    `$IFS <internalvariables.html#IFSREF>`__, the special variable
    separating *fields* of input to certain commands. It defaults to
    whitespace.

    +--------------------------------------------------------------------------+
    | .. raw:: html                                                            |
    |                                                                          |
    |    <div class="SIDEBAR">                                                 |
    |                                                                          |
    | \ ``Definition:`` A *field* is a discrete chunk of data expressed as a   |
    | string of consecutive characters. Separating each field from adjacent    |
    | fields is either *whitespace* or some other designated character (often  |
    | determined by the $IFS). In some contexts, a field may be called a       |
    | *record*.                                                                |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </div>                                                                |
                                                                              
    +--------------------------------------------------------------------------+

    To preserve *whitespace* within a string or in a variable, use
    `quoting <quoting.html#QUOTINGREF>`__.

    UNIX `filters <special-chars.html#FILTERDEF>`__ can target and
    operate on *whitespace* using the `POSIX <x17129.html#POSIXREF>`__
    character class `[:space:] <x17129.html#WSPOSIX>`__.

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

`[1] <special-chars.html#AEN612>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

An *operator* is an agent that carries out an *operation*. Some examples
are the common `arithmetic operators <ops.html#AROPS1>`__, **+ - \* /**.
In Bash, there is some overlap between the concepts of *operator* and
`keyword <internal.html#KEYWORDREF>`__.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[2] <special-chars.html#AEN888>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

This is more commonly known as the *ternary* operator. Unfortunately,
*ternary* is an ugly word. It doesn't roll off the tongue, and it
doesn't elucidate. It obfuscates. *Trinary* is by far the more elegant
usage.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[3] <special-chars.html#AEN1001>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

**A**\ merican **S**\ tandard **C**\ ode for **I**\ nformation
**I**\ nterchange. This is a system for encoding text characters
(alphabetic, numeric, and a limited set of symbols) as 7-bit numbers
that can be stored and manipulated by computers. Many of the ASCII
characters are represented on a standard keyboard.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[4] <special-chars.html#AEN1071>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

A *PID*, or *process ID*, is a number assigned to a running process. The
*PID*\ s of running processes may be viewed with a
`ps <system.html#PPSSREF>`__ command.

``Definition:`` A *process* is a currently executing command (or
program), sometimes referred to as a *job*.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[5] <special-chars.html#AEN1124>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

The shell does the *brace expansion*. The command itself acts upon the
*result* of the expansion.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[6] <special-chars.html#AEN1199>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Exception: a code block in braces as part of a pipe *may* run as a
`subshell <subshells.html#SUBSHELLSREF>`__.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     ls | { read firstlin |
| e; read secondline; }    |
|     #  Error. The code b |
| lock in braces runs as a |
|  subshell,               |
|     #+ so the output of  |
| "ls" cannot be passed to |
|  variables within the bl |
| ock.                     |
|     echo "First line is  |
| $firstline; second line  |
| is $secondline"  # Won't |
|  work.                   |
|                          |
|     # Thanks, S.C.       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[7] <special-chars.html#AEN1564>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Even as in olden times a *philtre* denoted a potion alleged to have
magical transformative powers, so does a UNIX *filter* transform its
target in (roughly) analogous fashion. (The coder who comes up with a
"love philtre" that runs on a Linux machine will likely win accolades
and honors.)

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[8] <special-chars.html#AEN2107>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Bash stores a list of commands previously issued from the command-line
in a *buffer*, or memory space, for recall with the
`builtin <internal.html#BUILTINREF>`__ *history* commands.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[9] <special-chars.html#AEN2198>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

A linefeed (*newline*) is also a whitespace character. This explains why
a *blank line*, consisting only of a linefeed, is considered whitespace.

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
| `Prev <part2.html>`__    | Basics                   |
| `Home <index.html>`__    | `Up <part2.html>`__      |
| `Next <variables.html>`_ | Introduction to          |
| _                        | Variables and Parameters |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Note| image:: ../images/note.gif
.. |Important| image:: ../images/important.gif
.. |Tip| image:: ../images/tip.gif
