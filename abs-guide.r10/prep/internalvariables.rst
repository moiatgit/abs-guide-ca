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

`Prev <variables2.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 9. Another Look at Variables

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <declareref.html>`__

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

  9.1. Internal Variables
========================

.. raw:: html

   <div class="VARIABLELIST">


``                           Builtin                  variables:               ``
    variables affecting bash script behavior

 ``        $BASH       ``
    The path to the *Bash* binary itself

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo $BASH     |
    |     /bin/bash            |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $BASH_ENV       ``
    An `environmental variable <othertypesv.html#ENVREF>`__ pointing to
    a Bash startup file to be read when a script is invoked

 ``        $BASH_SUBSHELL       ``
    A variable indicating the `subshell <subshells.html#SUBSHELLSREF>`__
    level. This is a new addition to Bash, `version
    3 <bashver3.html#BASH3REF>`__ .

    See `Example 21-1 <subshells.html#SUBSHELL>`__ for usage.

 ``        $BASHPID       ``
    *Process ID* of the current instance of Bash. This is not the same
    as the `$$ <internalvariables.html#PROCCID>`__ variable, but it
    often gives the same result.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash4$ echo $$       |
    |     11015                |
    |                          |
    |                          |
    |     bash4$ echo $BASHPID |
    |     11015                |
    |                          |
    |                          |
    |     bash4$ ps ax | grep  |
    | bash4                    |
    |     11015 pts/2    R     |
    |   0:00 bash4             |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

     But ...

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash4         |
    |                          |
    |     echo "\$\$ outside o |
    | f subshell = $$"         |
    |                       #  |
    | 9602                     |
    |     echo "\$BASH_SUBSHEL |
    | L  outside of subshell = |
    |  $BASH_SUBSHELL"      #  |
    | 0                        |
    |     echo "\$BASHPID outs |
    | ide of subshell = $BASHP |
    | ID"                   #  |
    | 9602                     |
    |                          |
    |     echo                 |
    |                          |
    |     ( echo "\$\$ inside  |
    | of subshell = $$"        |
    |                       #  |
    | 9602                     |
    |       echo "\$BASH_SUBSH |
    | ELL inside of subshell = |
    |  $BASH_SUBSHELL"      #  |
    | 1                        |
    |       echo "\$BASHPID in |
    | side of subshell = $BASH |
    | PID" )                #  |
    | 9603                     |
    |       # Note that $$ ret |
    | urns PID of parent proce |
    | ss.                      |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $BASH_VERSINFO[n]       ``
    A 6-element `array <arrays.html#ARRAYREF>`__ containing version
    information about the installed release of Bash. This is similar to
    ``         $BASH_VERSION        `` , below, but a bit more detailed.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Bash version info: |
    |                          |
    |     for n in 0 1 2 3 4 5 |
    |     do                   |
    |       echo "BASH_VERSINF |
    | O[$n] = ${BASH_VERSINFO[ |
    | $n]}"                    |
    |     done                 |
    |                          |
    |     # BASH_VERSINFO[0] = |
    |  3                       |
    | # Major version no.      |
    |     # BASH_VERSINFO[1] = |
    |  00                      |
    | # Minor version no.      |
    |     # BASH_VERSINFO[2] = |
    |  14                      |
    | # Patch level.           |
    |     # BASH_VERSINFO[3] = |
    |  1                       |
    | # Build version.         |
    |     # BASH_VERSINFO[4] = |
    |  release                 |
    | # Release status.        |
    |     # BASH_VERSINFO[5] = |
    |  i386-redhat-linux-gnu   |
    | # Architecture           |
    |                          |
    |                          |
    | # (same as $MACHTYPE).   |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $BASH_VERSION       ``
    The version of Bash installed on the system

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo $BASH_VER |
    | SION                     |
    |     3.2.25(1)-release    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     tcsh% echo $BASH_VER |
    | SION                     |
    |     BASH_VERSION: Undefi |
    | ned variable.            |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    Checking $BASH\_VERSION is a good method of determining which shell
    is running. `$SHELL <internalvariables.html#SHELLVARREF>`__ does not
    necessarily give the correct answer.

 ``        $CDPATH       ``
    A colon-separated list of search paths available to the
    `cd <internal.html#CDREF>`__ command, similar in function to the
    `$PATH <internalvariables.html#PATHREF>`__ variable for binaries.
    The ``         $CDPATH        `` variable may be set in the local
    ```          ~/.bashrc         `` <sample-bashrc.html#BASHRC>`__
    file.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ cd bash-doc    |
    |     bash: cd: bash-doc:  |
    | No such file or director |
    | y                        |
    |                          |
    |                          |
    |     bash$ CDPATH=/usr/sh |
    | are/doc                  |
    |     bash$ cd bash-doc    |
    |     /usr/share/doc/bash- |
    | doc                      |
    |                          |
    |                          |
    |     bash$ echo $PWD      |
    |     /usr/share/doc/bash- |
    | doc                      |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $DIRSTACK       ``
    The top value in the directory stack ` [1]
     <internalvariables.html#FTN.AEN4671>`__ (affected by
    `pushd <internal.html#PUSHDREF>`__ and
    `popd <internal.html#POPDREF>`__ )

    This builtin variable corresponds to the
    `dirs <internal.html#DIRSD>`__ command, however **dirs** shows the
    entire contents of the directory stack.

 ``        $EDITOR       ``
    The default editor invoked by a script, usually **vi** or **emacs**
    .

 ``        $EUID       ``
     "effective" user ID number

    Identification number of whatever identity the current user has
    assumed, perhaps by means of `su <system.html#SUREF>`__ .

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | The                                  |
    | ``             $EUID            ``   |
    | is not necessarily the same as the   |
    | `$UID <internalvariables.html#UIDREF |
    | >`__                                 |
    | .                                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 ``        $FUNCNAME       ``
    Name of the current function

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     xyz23 ()             |
    |     {                    |
    |       echo "$FUNCNAME no |
    | w executing."  # xyz23 n |
    | ow executing.            |
    |     }                    |
    |                          |
    |     xyz23                |
    |                          |
    |     echo "FUNCNAME = $FU |
    | NCNAME"        # FUNCNAM |
    | E =                      |
    |                          |
    |                # Null va |
    | lue outside a function.  |
                              
    +--------------------------+--------------------------+--------------------------+

    See also `Example A-50 <contributed-scripts.html#USEGETOPT>`__ .

 ``        $GLOBIGNORE       ``
    A list of filename patterns to be excluded from matching in
    `globbing <globbingref.html>`__ .

 ``        $GROUPS       ``
    Groups current user belongs to

    This is a listing (array) of the group id numbers for current user,
    as recorded in
    ```          /etc/passwd         `` <files.html#DATAFILESREF1>`__
    and ``         /etc/group        `` .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     root# echo $GROUPS   |
    |     0                    |
    |                          |
    |                          |
    |     root# echo ${GROUPS[ |
    | 1]}                      |
    |     1                    |
    |                          |
    |                          |
    |     root# echo ${GROUPS[ |
    | 5]}                      |
    |     6                    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $HOME       ``
    Home directory of the user, usually
    ``         /home/username        `` (see `Example
    10-7 <parameter-substitution.html#EX6>`__ )

 ``        $HOSTNAME       ``
    The `hostname <system.html#HNAMEREF>`__ command assigns the system
    host name at bootup in an init script. However, the
    ``         gethostname()        `` function sets the Bash internal
    variable ``         $HOSTNAME        `` . See also `Example
    10-7 <parameter-substitution.html#EX6>`__ .

 ``        $HOSTTYPE       ``
    host type

    Like `$MACHTYPE <internalvariables.html#MACHTYPEREF>`__ , identifies
    the system hardware.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo $HOSTTYPE |
    |     i686                 |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $IFS       ``
    internal field separator

    This variable determines how Bash recognizes
    `fields <special-chars.html#FIELDREF>`__ , or word boundaries, when
    it interprets character strings.

    $IFS defaults to `whitespace <special-chars.html#WHITESPACEREF>`__
    (space, tab, and newline), but may be changed, for example, to parse
    a comma-separated data file. Note that
    `$\* <internalvariables.html#APPREF>`__ uses the first character
    held in ``         $IFS        `` . See `Example
    5-1 <quotingvar.html#WEIRDVARS>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo "$IFS"    |
    |                          |
    |     (With $IFS set to de |
    | fault, a blank line disp |
    | lays.)                   |
    |                          |
    |                          |
    |                          |
    |     bash$ echo "$IFS" |  |
    | cat -vte                 |
    |      ^I$                 |
    |      $                   |
    |     (Show whitespace: he |
    | re a single space, ^I [h |
    | orizontal tab],          |
    |       and newline, and d |
    | isplay "$" at end-of-lin |
    | e.)                      |
    |                          |
    |                          |
    |                          |
    |     bash$ bash -c 'set w |
    |  x y z; IFS=":-;"; echo  |
    | "$*"'                    |
    |     w:x:y:z              |
    |     (Read commands from  |
    | string and assign any ar |
    | guments to pos params.)  |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    Set ``         $IFS        `` to eliminate whitespace in
    `pathnames <special-chars.html#PATHNAMEREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     IFS="$(printf '\n\t' |
    | )"   # Per David Wheeler |
    | .                        |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="CAUTION">

    +--------------------------+--------------------------+--------------------------+
    | |Caution|                |
    | ``             $IFS      |
    |        ``                |
    | does not handle          |
    | whitespace the same as   |
    | it does other            |
    | characters.              |
    |                          |
    | .. raw:: html            |
    |                          |
    |    <div class="EXAMPLE"> |
    |                          |
    | **Example 9-1. $IFS and  |
    | whitespace**             |
    |                          |
    | +----------------------- |
    | ---+-------------------- |
    | ------+----------------- |
    | ---------+               |
    | | .. code:: PROGRAMLISTI |
    | NG |                     |
    | |                        |
    |    |                     |
    | |     #!/bin/bash        |
    |    |                     |
    | |     # ifs.sh           |
    |    |                     |
    | |                        |
    |    |                     |
    | |                        |
    |    |                     |
    | |     var1="a+b+c"       |
    |    |                     |
    | |     var2="d-e-f"       |
    |    |                     |
    | |     var3="g,h,i"       |
    |    |                     |
    | |                        |
    |    |                     |
    | |     IFS=+              |
    |    |                     |
    | |     # The plus sign wi |
    | ll |                     |
    | |  be interpreted as a s |
    | ep |                     |
    | | arator.                |
    |    |                     |
    | |     echo $var1     # a |
    |  b |                     |
    | |  c                     |
    |    |                     |
    | |     echo $var2     # d |
    | -e |                     |
    | | -f                     |
    |    |                     |
    | |     echo $var3     # g |
    | ,h |                     |
    | | ,i                     |
    |    |                     |
    | |                        |
    |    |                     |
    | |     echo               |
    |    |                     |
    | |                        |
    |    |                     |
    | |     IFS="-"            |
    |    |                     |
    | |     # The plus sign re |
    | ve |                     |
    | | rts to default interpr |
    | et |                     |
    | | ation.                 |
    |    |                     |
    | |     # The minus sign w |
    | il |                     |
    | | l be interpreted as a  |
    | se |                     |
    | | parator.               |
    |    |                     |
    | |     echo $var1     # a |
    | +b |                     |
    | | +c                     |
    |    |                     |
    | |     echo $var2     # d |
    |  e |                     |
    | |  f                     |
    |    |                     |
    | |     echo $var3     # g |
    | ,h |                     |
    | | ,i                     |
    |    |                     |
    | |                        |
    |    |                     |
    | |     echo               |
    |    |                     |
    | |                        |
    |    |                     |
    | |     IFS=","            |
    |    |                     |
    | |     # The comma will b |
    | e  |                     |
    | | interpreted as a separ |
    | at |                     |
    | | or.                    |
    |    |                     |
    | |     # The minus sign r |
    | ev |                     |
    | | erts to default interp |
    | re |                     |
    | | tation.                |
    |    |                     |
    | |     echo $var1     # a |
    | +b |                     |
    | | +c                     |
    |    |                     |
    | |     echo $var2     # d |
    | -e |                     |
    | | -f                     |
    |    |                     |
    | |     echo $var3     # g |
    |  h |                     |
    | |  i                     |
    |    |                     |
    | |                        |
    |    |                     |
    | |     echo               |
    |    |                     |
    | |                        |
    |    |                     |
    | |     IFS=" "            |
    |    |                     |
    | |     # The space charac |
    | te |                     |
    | | r will be interpreted  |
    | as |                     |
    | |  a separator.          |
    |    |                     |
    | |     # The comma revert |
    | s  |                     |
    | | to default interpretat |
    | io |                     |
    | | n.                     |
    |    |                     |
    | |     echo $var1     # a |
    | +b |                     |
    | | +c                     |
    |    |                     |
    | |     echo $var2     # d |
    | -e |                     |
    | | -f                     |
    |    |                     |
    | |     echo $var3     # g |
    | ,h |                     |
    | | ,i                     |
    |    |                     |
    | |                        |
    |    |                     |
    | |     # ================ |
    | == |                     |
    | | ====================== |
    | == |                     |
    | | ============== #       |
    |    |                     |
    | |                        |
    |    |                     |
    | |     # However ...      |
    |    |                     |
    | |     # $IFS treats whit |
    | es |                     |
    | | pace differently than  |
    | ot |                     |
    | | her characters.        |
    |    |                     |
    | |                        |
    |    |                     |
    | |     output_args_one_pe |
    | r_ |                     |
    | | line()                 |
    |    |                     |
    | |     {                  |
    |    |                     |
    | |       for arg          |
    |    |                     |
    | |       do               |
    |    |                     |
    | |         echo "[$arg]"  |
    |    |                     |
    | |       done #  ^    ^   |
    |  E |                     |
    | | mbed within brackets,  |
    | fo |                     |
    | | r your viewing pleasur |
    | e. |                     |
    | |     }                  |
    |    |                     |
    | |                        |
    |    |                     |
    | |     echo; echo "IFS=\" |
    |  \ |                     |
    | | ""                     |
    |    |                     |
    | |     echo "-------"     |
    |    |                     |
    | |                        |
    |    |                     |
    | |     IFS=" "            |
    |    |                     |
    | |     var=" a  b c   "   |
    |    |                     |
    | |     #    ^ ^^   ^^^    |
    |    |                     |
    | |     output_args_one_pe |
    | r_ |                     |
    | | line $var  # output_ar |
    | gs |                     |
    | | _one_per_line `echo "  |
    | a  |                     |
    | |  b c   "`              |
    |    |                     |
    | |     # [a]              |
    |    |                     |
    | |     # [b]              |
    |    |                     |
    | |     # [c]              |
    |    |                     |
    | |                        |
    |    |                     |
    | |                        |
    |    |                     |
    | |     echo; echo "IFS=:" |
    |    |                     |
    | |     echo "-----"       |
    |    |                     |
    | |                        |
    |    |                     |
    | |     IFS=:              |
    |    |                     |
    | |     var=":a::b:c:::"   |
    |    |                     |
    | |            # Same patt |
    | er |                     |
    | | n as above,            |
    |    |                     |
    | |     #    ^ ^^   ^^^    |
    |    |                     |
    | |            #+ but subs |
    | ti |                     |
    | | tuting ":" for " "  .. |
    | .  |                     |
    | |     output_args_one_pe |
    | r_ |                     |
    | | line $var              |
    |    |                     |
    | |     # []               |
    |    |                     |
    | |     # [a]              |
    |    |                     |
    | |     # []               |
    |    |                     |
    | |     # [b]              |
    |    |                     |
    | |     # [c]              |
    |    |                     |
    | |     # []               |
    |    |                     |
    | |     # []               |
    |    |                     |
    | |                        |
    |    |                     |
    | |     # Note "empty" bra |
    | ck |                     |
    | | ets.                   |
    |    |                     |
    | |     # The same thing h |
    | ap |                     |
    | | pens with the "FS" fie |
    | ld |                     |
    | |  separator in awk.     |
    |    |                     |
    | |                        |
    |    |                     |
    | |                        |
    |    |                     |
    | |     echo               |
    |    |                     |
    | |                        |
    |    |                     |
    | |     exit               |
    |    |                     |
    |                          |
    |                          |
    | +----------------------- |
    | ---+-------------------- |
    | ------+----------------- |
    | ---------+               |
    |                          |
    | .. raw:: html            |
    |                          |
    |    </div>                |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    (Many thanks, Stéphane Chazelas, for clarification and above
    examples.)

    See also `Example 16-41 <communications.html#ISSPAMMER>`__ ,
    `Example 11-8 <loops1.html#BINGREP>`__ , and `Example
    19-14 <x17837.html#MAILBOXGREP>`__ for instructive examples of using
    ``         $IFS        `` .

 ``        $IGNOREEOF       ``
    Ignore EOF: how many end-of-files (control-D) the shell will ignore
    before logging out.

 ``        $LC_COLLATE       ``
    Often set in the
    ```          .bashrc         `` <sample-bashrc.html>`__ or
    ``         /etc/profile        `` files, this variable controls
    collation order in filename expansion and pattern matching. If
    mishandled, ``         LC_COLLATE        `` can cause unexpected
    results in `filename globbing <globbingref.html>`__ .

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | As of version 2.05 of Bash, filename |
    | globbing no longer distinguishes     |
    | between lowercase and uppercase      |
    | letters in a character range between |
    | brackets. For example, **ls          |
    | [A-M]\*** would match both           |
    | ``             File1.txt             |
    | ``                                   |
    | and                                  |
    | ``             file1.txt             |
    | ``                                   |
    | . To revert to the customary         |
    | behavior of bracket matching, set    |
    | ``             LC_COLLATE            |
    |  ``                                  |
    | to ``             C            `` by |
    | an                                   |
    | ``                           export  |
    | LC_COLLATE=C                         |
    |  ``                                  |
    | in                                   |
    | ``             /etc/profile          |
    |    ``                                |
    | and/or                               |
    | ``             ~/.bashrc             |
    | ``                                   |
    | .                                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 ``        $LC_CTYPE       ``
    This internal variable controls character interpretation in
    `globbing <globbingref.html>`__ and pattern matching.

 ``        $LINENO       ``
    This variable is the line number of the shell script in which this
    variable appears. It has significance only within the script in
    which it appears, and is chiefly useful for debugging purposes.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # *** BEGIN DEBUG BL |
    | OCK ***                  |
    |     last_cmd_arg=$_  # S |
    | ave it.                  |
    |                          |
    |     echo "At line number |
    |  $LINENO, variable \"v1\ |
    | " = $v1"                 |
    |     echo "Last command a |
    | rgument processed = $las |
    | t_cmd_arg"               |
    |     # *** END DEBUG BLOC |
    | K ***                    |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $MACHTYPE       ``
    machine type

    Identifies the system hardware.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo $MACHTYPE |
    |     i686                 |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $OLDPWD       ``
    Old working directory ( "OLD-Print-Working-Directory" , previous
    directory you were in).

 ``        $OSTYPE       ``
    operating system type

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo $OSTYPE   |
    |     linux                |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $PATH       ``
    Path to binaries, usually ``         /usr/bin/        `` ,
    ``         /usr/X11R6/bin/        `` ,
    ``         /usr/local/bin        `` , etc.

    When given a command, the shell automatically does a hash table
    search on the directories listed in the *path* for the executable.
    The path is stored in the `environmental
    variable <othertypesv.html#ENVREF>`__ , ``         $PATH        `` ,
    a list of directories, separated by colons. Normally, the system
    stores the ``         $PATH        `` definition in
    ``         /etc/profile        `` and/or
    ```          ~/.bashrc         `` <sample-bashrc.html>`__ (see
    `Appendix H <files.html>`__ ).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo $PATH     |
    |     /bin:/usr/bin:/usr/l |
    | ocal/bin:/usr/X11R6/bin: |
    | /sbin:/usr/sbin          |
                              
    +--------------------------+--------------------------+--------------------------+

    ``                   PATH=${PATH}:/opt/bin                 ``
    appends the ``         /opt/bin        `` directory to the current
    path. In a script, it may be expedient to temporarily add a
    directory to the path in this way. When the script exits, this
    restores the original ``         $PATH        `` (a child process,
    such as a script, may not change the environment of the parent
    process, the shell).

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The current "working directory" ,    |
    | ``             ./            `` , is |
    | usually omitted from the             |
    | ``             $PATH            ``   |
    | as a security measure.               |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 ``        $PIPESTATUS       ``
    `Array <arrays.html#ARRAYREF>`__ variable holding `exit
    status <exit-status.html#EXITSTATUSREF>`__ (es) of last executed
    *foreground* `pipe <special-chars.html#PIPEREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo $PIPESTAT |
    | US                       |
    |     0                    |
    |                          |
    |     bash$ ls -al | bogus |
    | _command                 |
    |     bash: bogus_command: |
    |  command not found       |
    |     bash$ echo ${PIPESTA |
    | TUS[1]}                  |
    |     127                  |
    |                          |
    |     bash$ ls -al | bogus |
    | _command                 |
    |     bash: bogus_command: |
    |  command not found       |
    |     bash$ echo $?        |
    |     127                  |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    The members of the ``         $PIPESTATUS        `` array hold the
    exit status of each respective command executed in a pipe.
    ``         $PIPESTATUS[0]        `` holds the exit status of the
    first command in the pipe, ``         $PIPESTATUS[1]        `` the
    exit status of the second command, and so on.

    .. raw:: html

       <div class="CAUTION">

    +--------------+--------------+--------------+--------------+--------------+--------------+
    | |Caution|    |
    | The          |
    | ``           |
    |    $PIPESTAT |
    | US           |
    |   ``         |
    | variable may |
    | contain an   |
    | erroneous 0  |
    | value in a   |
    | login shell  |
    | (in releases |
    | prior to 3.0 |
    | of Bash).    |
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
    | |     tcsh%  |
    | bash         |
    |    |         |
    | |            |
    |              |
    |    |         |
    | |     bash$  |
    | who | grep n |
    | ob |         |
    | | ody | sort |
    |              |
    |    |         |
    | |     bash$  |
    | echo ${PIPES |
    | TA |         |
    | | TUS[*]}    |
    |              |
    |    |         |
    | |     0      |
    |              |
    |    |         |
    | |            |
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
    |              |
    | The above    |
    | lines        |
    | contained in |
    | a script     |
    | would        |
    | produce the  |
    | expected     |
    | ``           |
    |    0 1 0     |
    |         ``   |
    | output.      |
    |              |
    | Thank you,   |
    | Wayne        |
    | Pollock for  |
    | pointing     |
    | this out and |
    | supplying    |
    | the above    |
    | example.     |
    +--------------+--------------+--------------+--------------+--------------+--------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +----------------+----------------+----------------+----------------+----------------+
    | |Note|         |
    | The            |
    | ``             |
    |  $PIPESTATUS   |
    |           ``   |
    | variable gives |
    | unexpected     |
    | results in     |
    | some contexts. |
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
    | |     bash$ ec |
    | ho $BASH_VER | |
    | | SION         |
    |              | |
    | |     3.00.14( |
    | 1)-release   | |
    | |              |
    |              | |
    | |     bash$ $  |
    | ls | bogus_c | |
    | | ommand | wc  |
    |              | |
    | |     bash: bo |
    | gus_command: | |
    | |  command not |
    |  found       | |
    | |      0       |
    |  0       0   | |
    | |              |
    |              | |
    | |     bash$ ec |
    | ho ${PIPESTA | |
    | | TUS[@]}      |
    |              | |
    | |     141 127  |
    | 0            | |
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
    | Chet Ramey     |
    | attributes the |
    | above output   |
    | to the         |
    | behavior of    |
    | `ls <basic.htm |
    | l#LSREF>`__    |
    | . If *ls*      |
    | writes to a    |
    | *pipe* whose   |
    | output is not  |
    | read, then     |
    | ``             |
    |                |
    |  SIGPIPE       |
    |                |
    |      ``        |
    | kills it, and  |
    | its `exit      |
    | status <exit-s |
    | tatus.html#EXI |
    | TSTATUSREF>`__ |
    | is 141 .       |
    | Otherwise its  |
    | exit status is |
    | 0 , as         |
    | expected. This |
    | likewise is    |
    | the case for   |
    | `tr <textproc. |
    | html#TRREF>`__ |
    | .              |
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------------+--------------------+--------------------+--------------------+
    | |Note|             |
    | ``             $PI |
    | PESTATUS           |
    |   ``               |
    | is a "volatile"    |
    | variable. It needs |
    | to be captured     |
    | immediately after  |
    | the pipe in        |
    | question, before   |
    | any other command  |
    | intervenes.        |
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
    | |     bash$ $ ls | |
    |  bogus_c |         |
    | | ommand | wc      |
    |          |         |
    | |     bash: bogus_ |
    | command: |         |
    | |  command not fou |
    | nd       |         |
    | |      0       0   |
    |      0   |         |
    | |                  |
    |          |         |
    | |     bash$ echo $ |
    | {PIPESTA |         |
    | | TUS[@]}          |
    |          |         |
    | |     0 127 0      |
    |          |         |
    | |                  |
    |          |         |
    | |     bash$ echo $ |
    | {PIPESTA |         |
    | | TUS[@]}          |
    |          |         |
    | |     0            |
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

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The `pipefail                        |
    | option <bashver3.html#PIPEFAILREF>`_ |
    | _                                    |
    | may be useful in cases where         |
    | ``             $PIPESTATUS           |
    |   ``                                 |
    | does not give the desired            |
    | information.                         |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 ``        $PPID       ``
    The ``         $PPID        `` of a process is the process ID (
    ``         pid        `` ) of its parent process. ` [2]
     <internalvariables.html#FTN.AEN5154>`__

    Compare this with the `pidof <system.html#PIDOFREF>`__ command.

 ``        $PROMPT_COMMAND       ``
    A variable holding a command to be executed just before the primary
    prompt, ``         $PS1        `` is to be displayed.

 ``        $PS1       ``
    This is the main prompt, seen at the command-line.

 ``        $PS2       ``
    The secondary prompt, seen when additional input is expected. It
    displays as ">" .

 ``        $PS3       ``
    The tertiary prompt, displayed in a
    `select <testbranch.html#SELECTREF>`__ loop (see `Example
    11-30 <testbranch.html#EX31>`__ ).

 ``        $PS4       ``
    The quartenary prompt, shown at the beginning of each line of output
    when invoking a script with the -x *[verbose trace]*
    `option <options.html#OPTIONSREF>`__ . It displays as "+" .

    As a debugging aid, it may be useful to embed diagnostic information
    in ``         $PS4        `` .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     P4='$(read time junk |
    |  < /proc/$$/schedstat; e |
    | cho "@@@ $time @@@ " )'  |
    |     # Per suggestion by  |
    | Erik Brandsberg.         |
    |     set -x               |
    |     # Various commands f |
    | ollow ...                |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $PWD       ``
    Working directory (directory you are in at the time)

    This is the analog to the `pwd <internal.html#PWD2REF>`__ builtin
    command.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     E_WRONG_DIRECTORY=85 |
    |                          |
    |     clear # Clear the sc |
    | reen.                    |
    |                          |
    |     TargetDirectory=/hom |
    | e/bozo/projects/GreatAme |
    | ricanNovel               |
    |                          |
    |     cd $TargetDirectory  |
    |     echo "Deleting stale |
    |  files in $TargetDirecto |
    | ry."                     |
    |                          |
    |     if [ "$PWD" != "$Tar |
    | getDirectory" ]          |
    |     then    # Keep from  |
    | wiping out wrong directo |
    | ry by accident.          |
    |       echo "Wrong direct |
    | ory!"                    |
    |       echo "In $PWD, rat |
    | her than $TargetDirector |
    | y!"                      |
    |       echo "Bailing out! |
    | "                        |
    |       exit $E_WRONG_DIRE |
    | CTORY                    |
    |     fi                   |
    |                          |
    |     rm -rf *             |
    |     rm .[A-Za-z0-9]*     |
    | # Delete dotfiles.       |
    |     # rm -f .[^.]* ..?*  |
    |   to remove filenames be |
    | ginning with multiple do |
    | ts.                      |
    |     # (shopt -s dotglob; |
    |  rm -f *)   will also wo |
    | rk.                      |
    |     # Thanks, S.C. for p |
    | ointing this out.        |
    |                          |
    |     #  A filename (`base |
    | name`) may contain all c |
    | haracters in the 0 - 255 |
    |  range,                  |
    |     #+ except "/".       |
    |     #  Deleting files be |
    | ginning with weird chara |
    | cters, such as -         |
    |     #+ is left as an exe |
    | rcise. (Hint: rm ./-weir |
    | dname or rm -- -weirdnam |
    | e)                       |
    |     result=$?   # Result |
    |  of delete operations. I |
    | f successful = 0.        |
    |                          |
    |     echo                 |
    |     ls -al               |
    | # Any files left?        |
    |     echo "Done."         |
    |     echo "Old files dele |
    | ted in $TargetDirectory. |
    | "                        |
    |     echo                 |
    |                          |
    |     # Various other oper |
    | ations here, as necessar |
    | y.                       |
    |                          |
    |     exit $result         |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $REPLY       ``
    The default value when a variable is not supplied to
    `read <internal.html#READREF>`__ . Also applicable to
    `select <testbranch.html#SELECTREF>`__ menus, but only supplies the
    item number of the variable chosen, not the value of the variable
    itself.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # reply.sh           |
    |                          |
    |     # REPLY is the defau |
    | lt value for a 'read' co |
    | mmand.                   |
    |                          |
    |     echo                 |
    |     echo -n "What is you |
    | r favorite vegetable? "  |
    |     read                 |
    |                          |
    |     echo "Your favorite  |
    | vegetable is $REPLY."    |
    |     #  REPLY holds the v |
    | alue of last "read" if a |
    | nd only if               |
    |     #+ no variable suppl |
    | ied.                     |
    |                          |
    |     echo                 |
    |     echo -n "What is you |
    | r favorite fruit? "      |
    |     read fruit           |
    |     echo "Your favorite  |
    | fruit is $fruit."        |
    |     echo "but..."        |
    |     echo "Value of \$REP |
    | LY is still $REPLY."     |
    |     #  $REPLY is still s |
    | et to its previous value |
    |  because                 |
    |     #+ the variable $fru |
    | it absorbed the new "rea |
    | d" value.                |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $SECONDS       ``
    The number of seconds the script has been running.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     TIME_LIMIT=10        |
    |     INTERVAL=1           |
    |                          |
    |     echo                 |
    |     echo "Hit Control-C  |
    | to exit before $TIME_LIM |
    | IT seconds."             |
    |     echo                 |
    |                          |
    |     while [ "$SECONDS" - |
    | le "$TIME_LIMIT" ]       |
    |     do   #   $SECONDS is |
    |  an internal shell varia |
    | ble.                     |
    |       if [ "$SECONDS" -e |
    | q 1 ]                    |
    |       then               |
    |         units=second     |
    |       else               |
    |         units=seconds    |
    |       fi                 |
    |                          |
    |       echo "This script  |
    | has been running $SECOND |
    | S $units."               |
    |       #  On a slow or ov |
    | erburdened machine, the  |
    | script may skip a count  |
    |       #+ every once in a |
    |  while.                  |
    |       sleep $INTERVAL    |
    |     done                 |
    |                          |
    |     echo -e "\a"  # Beep |
    | !                        |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $SHELLOPTS       ``
    The list of enabled shell `options <options.html#OPTIONSREF>`__ , a
    readonly variable.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo $SHELLOPT |
    | S                        |
    |     braceexpand:hashall: |
    | histexpand:monitor:histo |
    | ry:interactive-comments: |
    | emacs                    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $SHLVL       ``
    Shell level, how deeply Bash is nested. ` [3]
     <internalvariables.html#FTN.AEN5320>`__ If, at the command-line,
    $SHLVL is 1, then in a script it will increment to 2.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | This variable is `*not* affected by  |
    | subshells <subshells.html#SUBSHNLEVR |
    | EF>`__                               |
    | . Use                                |
    | `$BASH\_SUBSHELL <internalvariables. |
    | html#BASHSUBSHELLREF>`__             |
    | when you need an indication of       |
    | subshell nesting.                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 ``        $TMOUT       ``
    If the ``                   $TMOUT                 `` environmental
    variable is set to a non-zero value ``         time        `` , then
    the shell prompt will time out after ``         $time        ``
    seconds. This will cause a logout.

    As of version 2.05b of Bash, it is now possible to use
    ``                   $TMOUT                 `` in a script in
    combination with `read <internal.html#READREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Works in scripts f |
    | or Bash, versions 2.05b  |
    | and later.               |
    |                          |
    |     TMOUT=3    # Prompt  |
    | times out at three secon |
    | ds.                      |
    |                          |
    |     echo "What is your f |
    | avorite song?"           |
    |     echo "Quickly now, y |
    | ou only have $TMOUT seco |
    | nds to answer!"          |
    |     read song            |
    |                          |
    |     if [ -z "$song" ]    |
    |     then                 |
    |       song="(no answer)" |
    |       # Default response |
    | .                        |
    |     fi                   |
    |                          |
    |     echo "Your favorite  |
    | song is $song."          |
                              
    +--------------------------+--------------------------+--------------------------+

    There are other, more complex, ways of implementing timed input in a
    script. One alternative is to set up a timing loop to signal the
    script when it times out. This also requires a signal handling
    routine to `trap <debugging.html#TRAPREF1>`__ (see `Example
    32-5 <debugging.html#EX76>`__ ) the interrupt generated by the
    timing loop (whew!).

    .. raw:: html

       <div class="EXAMPLE">

    **Example 9-2. Timed Input**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # timed-input.sh     |
    |                          |
    |     # TMOUT=3    Also wo |
    | rks, as of newer version |
    | s of Bash.               |
    |                          |
    |     TIMER_INTERRUPT=14   |
    |     TIMELIMIT=3  # Three |
    |  seconds in this instanc |
    | e.                       |
    |                  # May b |
    | e set to different value |
    | .                        |
    |                          |
    |     PrintAnswer()        |
    |     {                    |
    |       if [ "$answer" = T |
    | IMEOUT ]                 |
    |       then               |
    |         echo $answer     |
    |       else       # Don't |
    |  want to mix up the two  |
    | instances.               |
    |         echo "Your favor |
    | ite veggie is $answer"   |
    |         kill $!  #  Kill |
    | s no-longer-needed Timer |
    | On function              |
    |                  #+ runn |
    | ing in background.       |
    |                  #  $! i |
    | s PID of last job runnin |
    | g in background.         |
    |       fi                 |
    |                          |
    |     }                    |
    |                          |
    |                          |
    |     TimerOn()            |
    |     {                    |
    |       sleep $TIMELIMIT & |
    | & kill -s 14 $$ &        |
    |       # Waits 3 seconds, |
    |  then sends sigalarm to  |
    | script.                  |
    |     }                    |
    |                          |
    |                          |
    |     Int14Vector()        |
    |     {                    |
    |       answer="TIMEOUT"   |
    |       PrintAnswer        |
    |       exit $TIMER_INTERR |
    | UPT                      |
    |     }                    |
    |                          |
    |     trap Int14Vector $TI |
    | MER_INTERRUPT            |
    |     # Timer interrupt (1 |
    | 4) subverted for our pur |
    | poses.                   |
    |                          |
    |     echo "What is your f |
    | avorite vegetable "      |
    |     TimerOn              |
    |     read answer          |
    |     PrintAnswer          |
    |                          |
    |                          |
    |     #  Admittedly, this  |
    | is a kludgy implementati |
    | on of timed input.       |
    |     #  However, the "-t" |
    |  option to "read" simpli |
    | fies this task.          |
    |     #  See the "t-out.sh |
    | " script.                |
    |     #  However, what abo |
    | ut timing not just singl |
    | e user input,            |
    |     #+ but an entire scr |
    | ipt?                     |
    |                          |
    |     #  If you need somet |
    | hing really elegant ...  |
    |     #+ consider writing  |
    | the application in C or  |
    | C++,                     |
    |     #+ using appropriate |
    |  library functions, such |
    |  as 'alarm' and 'setitim |
    | er.'                     |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    An alternative is using `stty <system.html#STTYREF>`__ .

    .. raw:: html

       <div class="EXAMPLE">

    **Example 9-3. Once more, timed input**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # timeout.sh         |
    |                          |
    |     #  Written by Stepha |
    | ne Chazelas,             |
    |     #+ and modified by t |
    | he document author.      |
    |                          |
    |     INTERVAL=5           |
    |       # timeout interval |
    |                          |
    |     timedout_read() {    |
    |       timeout=$1         |
    |       varname=$2         |
    |       old_tty_settings=` |
    | stty -g`                 |
    |       stty -icanon min 0 |
    |  time ${timeout}0        |
    |       eval read $varname |
    |       # or just  read $v |
    | arname                   |
    |       stty "$old_tty_set |
    | tings"                   |
    |       # See man page for |
    |  "stty."                 |
    |     }                    |
    |                          |
    |     echo; echo -n "What' |
    | s your name? Quick! "    |
    |     timedout_read $INTER |
    | VAL your_name            |
    |                          |
    |     #  This may not work |
    |  on every terminal type. |
    |     #  The maximum timeo |
    | ut depends on the termin |
    | al.                      |
    |     #+ (it is often 25.5 |
    |  seconds).               |
    |                          |
    |     echo                 |
    |                          |
    |     if [ ! -z "$your_nam |
    | e" ]  # If name input be |
    | fore timeout ...         |
    |     then                 |
    |       echo "Your name is |
    |  $your_name."            |
    |     else                 |
    |       echo "Timed out."  |
    |     fi                   |
    |                          |
    |     echo                 |
    |                          |
    |     # The behavior of th |
    | is script differs somewh |
    | at from "timed-input.sh. |
    | "                        |
    |     # At each keystroke, |
    |  the counter resets.     |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Perhaps the simplest method is using the ``         -t        ``
    option to `read <internal.html#READREF>`__ .

    .. raw:: html

       <div class="EXAMPLE">

    **Example 9-4. Timed *read***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # t-out.sh [time-out |
    | ]                        |
    |     # Inspired by a sugg |
    | estion from "syngin seve |
    | n" (thanks).             |
    |                          |
    |                          |
    |     TIMELIMIT=4          |
    | # 4 seconds              |
    |                          |
    |     read -t $TIMELIMIT v |
    | ariable <&1              |
    |     #                    |
    |         ^^^              |
    |     #  In this instance, |
    |  "<&1" is needed for Bas |
    | h 1.x and 2.x,           |
    |     #  but unnecessary f |
    | or Bash 3+.              |
    |                          |
    |     echo                 |
    |                          |
    |     if [ -z "$variable"  |
    | ]  # Is null?            |
    |     then                 |
    |       echo "Timed out, v |
    | ariable still unset."    |
    |     else                 |
    |       echo "variable = $ |
    | variable"                |
    |     fi                   |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 ``        $UID       ``
    User ID number

    Current user's user identification number, as recorded in
    ```          /etc/passwd         `` <files.html#DATAFILESREF1>`__

    This is the current user's real id, even if she has temporarily
    assumed another identity through `su <system.html#SUREF>`__ .
    ``         $UID        `` is a readonly variable, not subject to
    change from the command line or within a script, and is the
    counterpart to the `id <system.html#IDREF>`__ builtin.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 9-5. Am I root?**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # am-i-root.sh:   Am |
    |  I root or not?          |
    |                          |
    |     ROOT_UID=0   # Root  |
    | has $UID 0.              |
    |                          |
    |     if [ "$UID" -eq "$RO |
    | OT_UID" ]  # Will the re |
    | al "root" please stand u |
    | p?                       |
    |     then                 |
    |       echo "You are root |
    | ."                       |
    |     else                 |
    |       echo "You are just |
    |  an ordinary user (but m |
    | om loves you just the sa |
    | me)."                    |
    |     fi                   |
    |                          |
    |     exit 0               |
    |                          |
    |                          |
    |     # ================== |
    | ======================== |
    | =================== #    |
    |     # Code below will no |
    | t execute, because the s |
    | cript already exited.    |
    |                          |
    |     # An alternate metho |
    | d of getting to the root |
    |  of matters:             |
    |                          |
    |     ROOTUSER_NAME=root   |
    |                          |
    |     username=`id -nu`    |
    |            # Or...   use |
    | rname=`whoami`           |
    |     if [ "$username" = " |
    | $ROOTUSER_NAME" ]        |
    |     then                 |
    |       echo "Rooty, toot, |
    |  toot. You are root."    |
    |     else                 |
    |       echo "You are just |
    |  a regular fella."       |
    |     fi                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example 2-3 <sha-bang.html#EX2>`__ .

    .. raw:: html

       <div class="NOTE">

    +--------------------+--------------------+--------------------+--------------------+
    | |Note|             |
    | The variables      |
    | ``             $EN |
    | V            ``    |
    | ,                  |
    | ``             $LO |
    | GNAME            ` |
    | `                  |
    | ,                  |
    | ``             $MA |
    | IL            ``   |
    | ,                  |
    | ``             $TE |
    | RM            ``   |
    | ,                  |
    | ``             $US |
    | ER            ``   |
    | , and              |
    | ``             $US |
    | ERNAME             |
    | ``                 |
    | are *not* Bash     |
    | `builtins <interna |
    | l.html#BUILTINREF> |
    | `__                |
    | . These are,       |
    | however, often set |
    | as `environmental  |
    | variables <otherty |
    | pesv.html#ENVREF>` |
    | __                 |
    | in one of the      |
    | `Bash <files.html# |
    | FILESREF1>`__      |
    | or *login* startup |
    | files.             |
    | ``             $SH |
    | ELL            ``  |
    | , the name of the  |
    | user's login       |
    | shell, may be set  |
    | from               |
    | ``             /et |
    | c/passwd           |
    |   ``               |
    | or in an "init"    |
    | script, and it is  |
    | likewise not a     |
    | Bash builtin.      |
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
    | |     tcsh% echo $ |
    | LOGNAME  |         |
    | |     bozo         |
    |          |         |
    | |     tcsh% echo $ |
    | SHELL    |         |
    | |     /bin/tcsh    |
    |          |         |
    | |     tcsh% echo $ |
    | TERM     |         |
    | |     rxvt         |
    |          |         |
    | |                  |
    |          |         |
    | |     bash$ echo $ |
    | LOGNAME  |         |
    | |     bozo         |
    |          |         |
    | |     bash$ echo $ |
    | SHELL    |         |
    | |     /bin/tcsh    |
    |          |         |
    | |     bash$ echo $ |
    | TERM     |         |
    | |     rxvt         |
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

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Positional Parameters**

 ``        $0       `` , ``        $1       `` , ``        $2       `` ,
etc.
    Positional parameters, passed from command line to script, passed to
    a function, or `set <internal.html#SETREF>`__ to a variable (see
    `Example 4-5 <othertypesv.html#EX17>`__ and `Example
    15-16 <internal.html#EX34>`__ )

 ``        $#       ``
    Number of command-line arguments ` [4]
     <internalvariables.html#FTN.AEN5479>`__ or positional parameters
    (see `Example 36-2 <wrapper.html#EX4>`__ )

 ``        $*       ``
    All of the positional parameters, seen as a single word

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    |  " ``              $*             `` |
    | " must be quoted.                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 ``        $@       ``
    Same as $\* , but each parameter is a quoted string, that is, the
    parameters are passed on intact, without interpretation or
    expansion. This means, among other things, that each parameter in
    the argument list is seen as a separate word.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Of course, "                         |
    | ``              $@             `` "  |
    | should be quoted.                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 9-6. *arglist* : Listing arguments with $\* and $@**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # arglist.sh         |
    |     # Invoke this script |
    |  with several arguments, |
    |  such as "one two three" |
    |  ...                     |
    |                          |
    |     E_BADARGS=85         |
    |                          |
    |     if [ ! -n "$1" ]     |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` argument1 argum |
    | ent2 etc."               |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |     echo                 |
    |                          |
    |     index=1          # I |
    | nitialize count.         |
    |                          |
    |     echo "Listing args w |
    | ith \"\$*\":"            |
    |     for arg in "$*"  # D |
    | oesn't work properly if  |
    | "$*" isn't quoted.       |
    |     do                   |
    |       echo "Arg #$index  |
    | = $arg"                  |
    |       let "index+=1"     |
    |     done             # $ |
    | * sees all arguments as  |
    | single word.             |
    |     echo "Entire arg lis |
    | t seen as single word."  |
    |                          |
    |     echo                 |
    |                          |
    |     index=1          # R |
    | eset count.              |
    |                      # W |
    | hat happens if you forge |
    | t to do this?            |
    |                          |
    |     echo "Listing args w |
    | ith \"\$@\":"            |
    |     for arg in "$@"      |
    |     do                   |
    |       echo "Arg #$index  |
    | = $arg"                  |
    |       let "index+=1"     |
    |     done             # $ |
    | @ sees arguments as sepa |
    | rate words.              |
    |     echo "Arg list seen  |
    | as separate words."      |
    |                          |
    |     echo                 |
    |                          |
    |     index=1          # R |
    | eset count.              |
    |                          |
    |     echo "Listing args w |
    | ith \$* (unquoted):"     |
    |     for arg in $*        |
    |     do                   |
    |       echo "Arg #$index  |
    | = $arg"                  |
    |       let "index+=1"     |
    |     done             # U |
    | nquoted $* sees argument |
    | s as separate words.     |
    |     echo "Arg list seen  |
    | as separate words."      |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Following a **shift** , the ``         $@        `` holds the
    remaining command-line parameters, lacking the previous
    ``         $1        `` , which was lost.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Invoke with ./scri |
    | ptname 1 2 3 4 5         |
    |                          |
    |     echo "$@"    # 1 2 3 |
    |  4 5                     |
    |     shift                |
    |     echo "$@"    # 2 3 4 |
    |  5                       |
    |     shift                |
    |     echo "$@"    # 3 4 5 |
    |                          |
    |     # Each "shift" loses |
    |  parameter $1.           |
    |     # "$@" then contains |
    |  the remaining parameter |
    | s.                       |
                              
    +--------------------------+--------------------------+--------------------------+

    The ``         $@        `` special parameter finds use as a tool
    for filtering input into shell scripts. The **cat "$@"**
    construction accepts input to a script either from
    ``         stdin        `` or from files given as parameters to the
    script. See `Example 16-24 <textproc.html#ROT13>`__ and `Example
    16-25 <textproc.html#CRYPTOQUOTE>`__ .

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | The ``             $*            ``  |
    | and ``             $@            ``  |
    | parameters sometimes display         |
    | inconsistent and puzzling behavior,  |
    | depending on the setting of          |
    | `$IFS <internalvariables.html#IFSREF |
    | >`__                                 |
    | .                                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 9-7. Inconsistent ``           $*          `` and
    ``           $@          `` behavior**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     #  Erratic behavior  |
    | of the "$*" and "$@" int |
    | ernal Bash variables,    |
    |     #+ depending on whet |
    | her or not they are quot |
    | ed.                      |
    |     #  Demonstrates inco |
    | nsistent handling of wor |
    | d splitting and linefeed |
    | s.                       |
    |                          |
    |                          |
    |     set -- "First one" " |
    | second" "third:one" "" " |
    | Fifth: :one"             |
    |     # Setting the script |
    |  arguments, $1, $2, $3,  |
    | etc.                     |
    |                          |
    |     echo                 |
    |                          |
    |     echo 'IFS unchanged, |
    |  using "$*"'             |
    |     c=0                  |
    |     for i in "$*"        |
    |         # quoted         |
    |     do echo "$((c+=1)):  |
    | [$i]"   # This line rema |
    | ins the same in every in |
    | stance.                  |
    |                          |
    |         # Echo args.     |
    |     done                 |
    |     echo ---             |
    |                          |
    |     echo 'IFS unchanged, |
    |  using $*'               |
    |     c=0                  |
    |     for i in $*          |
    |         # unquoted       |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     echo 'IFS unchanged, |
    |  using "$@"'             |
    |     c=0                  |
    |     for i in "$@"        |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     echo 'IFS unchanged, |
    |  using $@'               |
    |     c=0                  |
    |     for i in $@          |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     IFS=:                |
    |     echo 'IFS=":", using |
    |  "$*"'                   |
    |     c=0                  |
    |     for i in "$*"        |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     echo 'IFS=":", using |
    |  $*'                     |
    |     c=0                  |
    |     for i in $*          |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     var=$*               |
    |     echo 'IFS=":", using |
    |  "$var" (var=$*)'        |
    |     c=0                  |
    |     for i in "$var"      |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     echo 'IFS=":", using |
    |  $var (var=$*)'          |
    |     c=0                  |
    |     for i in $var        |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     var="$*"             |
    |     echo 'IFS=":", using |
    |  $var (var="$*")'        |
    |     c=0                  |
    |     for i in $var        |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     echo 'IFS=":", using |
    |  "$var" (var="$*")'      |
    |     c=0                  |
    |     for i in "$var"      |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     echo 'IFS=":", using |
    |  "$@"'                   |
    |     c=0                  |
    |     for i in "$@"        |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     echo 'IFS=":", using |
    |  $@'                     |
    |     c=0                  |
    |     for i in $@          |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     var=$@               |
    |     echo 'IFS=":", using |
    |  $var (var=$@)'          |
    |     c=0                  |
    |     for i in $var        |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     echo 'IFS=":", using |
    |  "$var" (var=$@)'        |
    |     c=0                  |
    |     for i in "$var"      |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     var="$@"             |
    |     echo 'IFS=":", using |
    |  "$var" (var="$@")'      |
    |     c=0                  |
    |     for i in "$var"      |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |     echo ---             |
    |                          |
    |     echo 'IFS=":", using |
    |  $var (var="$@")'        |
    |     c=0                  |
    |     for i in $var        |
    |     do echo "$((c+=1)):  |
    | [$i]"                    |
    |     done                 |
    |                          |
    |     echo                 |
    |                          |
    |     # Try this script wi |
    | th ksh or zsh -y.        |
    |                          |
    |     exit 0               |
    |                          |
    |     #  This example scri |
    | pt written by Stephane C |
    | hazelas,                 |
    |     #+ and slightly modi |
    | fied by the document aut |
    | hor.                     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The **$@** and **$\*** parameters    |
    | differ only when between double      |
    | quotes.                              |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 9-8. ``           $*          `` and
    ``           $@          `` when ``           $IFS          `` is
    empty**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     #  If $IFS set, but  |
    | empty,                   |
    |     #+ then "$*" and "$@ |
    | " do not echo positional |
    |  params as expected.     |
    |                          |
    |     mecho ()       # Ech |
    | o positional parameters. |
    |     {                    |
    |     echo "$1,$2,$3";     |
    |     }                    |
    |                          |
    |                          |
    |     IFS=""         # Set |
    | , but empty.             |
    |     set a b c      # Pos |
    | itional parameters.      |
    |                          |
    |     mecho "$*"     # abc |
    | ,,                       |
    |     #                    |
    | ^^                       |
    |     mecho $*       # a,b |
    | ,c                       |
    |                          |
    |     mecho $@       # a,b |
    | ,c                       |
    |     mecho "$@"     # a,b |
    | ,c                       |
    |                          |
    |     #  The behavior of $ |
    | * and $@ when $IFS is em |
    | pty depends              |
    |     #+ on which Bash or  |
    | sh version being run.    |
    |     #  It is therefore i |
    | nadvisable to depend on  |
    | this "feature" in a scri |
    | pt.                      |
    |                          |
    |                          |
    |     # Thanks, Stephane C |
    | hazelas.                 |
    |                          |
    |     exit                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Other Special Parameters**

 ``        $-       ``
    Flags passed to script (using `set <internal.html#SETREF>`__ ). See
    `Example 15-16 <internal.html#EX34>`__ .

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | This was originally a *ksh*          |
    | construct adopted into Bash, and     |
    | unfortunately it does not seem to    |
    | work reliably in Bash scripts. One   |
    | possible use for it is to have a     |
    | script `self-test whether it is      |
    | interactive <intandnonint.html#IITES |
    | T>`__                                |
    | .                                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 ``        $!       ``
    `PID <special-chars.html#PROCESSIDDEF>`__ (process ID) of last job
    run in background

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     LOG=$0.log           |
    |                          |
    |     COMMAND1="sleep 100" |
    |                          |
    |     echo "Logging PIDs b |
    | ackground commands for s |
    | cript: $0" >> "$LOG"     |
    |     # So they can be mon |
    | itored, and killed as ne |
    | cessary.                 |
    |     echo >> "$LOG"       |
    |                          |
    |     # Logging commands.  |
    |                          |
    |     echo -n "PID of \"$C |
    | OMMAND1\":  " >> "$LOG"  |
    |     ${COMMAND1} &        |
    |     echo $! >> "$LOG"    |
    |     # PID of "sleep 100" |
    | :  1506                  |
    |                          |
    |     # Thank you, Jacques |
    |  Lederer, for suggesting |
    |  this.                   |
                              
    +--------------------------+--------------------------+--------------------------+

    Using ``         $!        `` for job control:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     possibly_hanging_job |
    |  & { sleep ${TIMEOUT}; e |
    | val 'kill -9 $!' &> /dev |
    | /null; }                 |
    |     # Forces completion  |
    | of an ill-behaved progra |
    | m.                       |
    |     # Useful, for exampl |
    | e, in init scripts.      |
    |                          |
    |     # Thank you, Sylvain |
    |  Fourmanoit, for this cr |
    | eative use of the "!" va |
    | riable.                  |
                              
    +--------------------------+--------------------------+--------------------------+

    Or, alternately:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # This example by Ma |
    | tthew Sage.              |
    |     # Used with permissi |
    | on.                      |
    |                          |
    |     TIMEOUT=30   # Timeo |
    | ut value in seconds      |
    |     count=0              |
    |                          |
    |     possibly_hanging_job |
    |  & {                     |
    |             while ((coun |
    | t < TIMEOUT )); do       |
    |                     eval |
    |  '[ ! -d "/proc/$!" ] && |
    |  ((count = TIMEOUT))'    |
    |                     # /p |
    | roc is where information |
    |  about running processes |
    |  is found.               |
    |                     # "- |
    | d" tests whether it exis |
    | ts (whether directory ex |
    | ists).                   |
    |                     # So |
    | , we're waiting for the  |
    | job in question to show  |
    | up.                      |
    |                     ((co |
    | unt++))                  |
    |                     slee |
    | p 1                      |
    |             done         |
    |             eval '[ -d " |
    | /proc/$!" ] && kill -15  |
    | $!'                      |
    |             # If the han |
    | ging job is running, kil |
    | l it.                    |
    |     }                    |
    |                          |
    |     #  ----------------- |
    | ------------------------ |
    | --------------------- #  |
    |                          |
    |     #  However, this may |
    |  not not work as specifi |
    | ed if another process    |
    |     #+ begins to run aft |
    | er the "hanging_job" . . |
    |  .                       |
    |     #  In such a case, t |
    | he wrong job may be kill |
    | ed.                      |
    |     #  Ariel Meragelman  |
    | suggests the following f |
    | ix.                      |
    |                          |
    |     TIMEOUT=30           |
    |     count=0              |
    |     # Timeout value in s |
    | econds                   |
    |     possibly_hanging_job |
    |  & {                     |
    |                          |
    |     while ((count < TIME |
    | OUT )); do               |
    |       eval '[ ! -d "/pro |
    | c/$lastjob" ] && ((count |
    |  = TIMEOUT))'            |
    |       lastjob=$!         |
    |       ((count++))        |
    |       sleep 1            |
    |     done                 |
    |     eval '[ -d "/proc/$l |
    | astjob" ] && kill -15 $l |
    | astjob'                  |
    |                          |
    |     }                    |
    |                          |
    |     exit                 |
                              
    +--------------------------+--------------------------+--------------------------+

 ``        $_       ``
    Special variable set to final argument of previous command executed.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 9-9. Underscore variable**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     echo $_              |
    |  #  /bin/bash            |
    |                          |
    |  #  Just called /bin/bas |
    | h to run the script.     |
    |                          |
    |  #  Note that this will  |
    | vary according to        |
    |                          |
    |  #+ how the script is in |
    | voked.                   |
    |                          |
    |     du >/dev/null        |
    |  #  So no output from co |
    | mmand.                   |
    |     echo $_              |
    |  #  du                   |
    |                          |
    |     ls -al >/dev/null    |
    |  #  So no output from co |
    | mmand.                   |
    |     echo $_              |
    |  #  -al  (last argument) |
    |                          |
    |     :                    |
    |     echo $_              |
    |  #  :                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 ``        $?       ``
    `Exit status <exit-status.html#EXITSTATUSREF>`__ of a command,
    `function <functions.html#FUNCTIONREF>`__ , or the script itself
    (see `Example 24-7 <complexfunct.html#MAX>`__ )

 ``        $$       ``
    Process ID ( *PID* ) of the script itself. ` [5]
     <internalvariables.html#FTN.AEN5654>`__ The ``         $$        ``
    variable often finds use in scripts to construct "unique" temp file
    names (see `Example 32-6 <debugging.html#ONLINE>`__ , `Example
    16-31 <filearchiv.html#DERPM>`__ , and `Example
    15-27 <x9644.html#SELFDESTRUCT>`__ ). This is usually simpler than
    invoking `mktemp <filearchiv.html#MKTEMPREF>`__ .

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]                                | ` [2]                                |
|  <internalvariables.html#AEN4671>`__ |  <internalvariables.html#AEN5154>`__ |
|  A *stack register* is a set of      | The PID of the currently running     |
| consecutive memory locations, such   | script is ``        $$       `` , of |
| that the values stored ( *pushed* )  | course.                              |
| are retrieved ( *popped* ) in        |                                      |
| *reverse* order. The last value      |                                      |
| stored is the first retrieved. This  |                                      |
| is sometimes called a                |                                      |
| ``                 LIFO              |                                      |
|   ``                                 |                                      |
| ( *last-in-first-out* ) or           |                                      |
| *pushdown* stack.                    |                                      |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <variables2.html>` | Another Look at          |
| __                       | Variables                |
| `Home <index.html>`__    | `Up <variables2.html>`__ |
| `Next <declareref.html>` | Typing variables:        |
| __                       | **declare** or           |
|                          | **typeset**              |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Note| image:: ../images/note.gif
