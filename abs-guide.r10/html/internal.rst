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

`Prev <part4.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <x9644.html>`__

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

Chapter 15. Internal Commands and Builtins
==========================================

A *builtin* is a **command** contained within the Bash tool set,
literally *built in*. This is either for performance reasons -- builtins
execute faster than external commands, which usually require *forking
off* `[1] <internal.html#FTN.AEN8607>`__ a separate process -- or
because a particular builtin needs direct access to the shell internals.

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| When a command or the shell itself initiates (or *spawns*) a new         |
| subprocess to carry out a task, this is called *forking*. This new       |
| process is the *child*, and the process that *forked* it off is the      |
| *parent*. While the *child process* is doing its work, the *parent       |
| process* is still executing.                                             |
|                                                                          |
| Note that while a *parent process* gets the *process ID* of the *child   |
| process*, and can thus pass arguments to it, *the reverse is not true*.  |
| `This can create problems that are subtle and hard to track              |
| down. <gotchas.html#PARCHILDPROBREF>`__                                  |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    <div class="EXAMPLE">                                                 |
|                                                                          |
| **Example 15-1. A script that spawns multiple instances of itself**      |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: PROGRAMLISTING |                                             |
| |                          |                                             |
| |     #!/bin/bash          |                                             |
| |     # spawn.sh           |                                             |
| |                          |                                             |
| |                          |                                             |
| |     PIDS=$(pidof sh $0)  |                                             |
| |  # Process IDs of the va |                                             |
| | rious instances of this  |                                             |
| | script.                  |                                             |
| |     P_array=( $PIDS )    |                                             |
| |  # Put them in an array  |                                             |
| | (why?).                  |                                             |
| |     echo $PIDS           |                                             |
| |  # Show process IDs of p |                                             |
| | arent and child processe |                                             |
| | s.                       |                                             |
| |     let "instances = ${# |                                             |
| | P_array[*]} - 1"  # Coun |                                             |
| | t elements, less 1.      |                                             |
| |                          |                                             |
| |                   # Why  |                                             |
| | subtract 1?              |                                             |
| |     echo "$instances ins |                                             |
| | tance(s) of this script  |                                             |
| | running."                |                                             |
| |     echo "[Hit Ctl-C to  |                                             |
| | exit.]"; echo            |                                             |
| |                          |                                             |
| |                          |                                             |
| |     sleep 1              |                                             |
| |  # Wait.                 |                                             |
| |     sh $0                |                                             |
| |  # Play it again, Sam.   |                                             |
| |                          |                                             |
| |     exit 0               |                                             |
| |  # Not necessary; script |                                             |
| |  will never get to here. |                                             |
| |                          |                                             |
| |  # Why not?              |                                             |
| |                          |                                             |
| |     #  After exiting wit |                                             |
| | h a Ctl-C,               |                                             |
| |     #+ do all the spawne |                                             |
| | d instances of the scrip |                                             |
| | t die?                   |                                             |
| |     #  If so, why?       |                                             |
| |                          |                                             |
| |     # Note:              |                                             |
| |     # ----               |                                             |
| |     # Be careful not to  |                                             |
| | run this script too long |                                             |
| | .                        |                                             |
| |     # It will eventually |                                             |
| |  eat up too many system  |                                             |
| | resources.               |                                             |
| |                          |                                             |
| |     #  Is having a scrip |                                             |
| | t spawn multiple instanc |                                             |
| | es of itself             |                                             |
| |     #+ an advisable scri |                                             |
| | pting technique.         |                                             |
| |     #  Why or why not?   |                                             |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
|                                                                          |
| Generally, a Bash *builtin* does not fork a subprocess when it executes  |
| within a script. An external system command or filter in a script        |
| usually *will* fork a subprocess.                                        |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

A builtin may be a synonym to a system command of the same name, but
Bash reimplements it internally. For example, the Bash **echo** command
is not the same as ``/bin/echo``, although their behavior is almost
identical.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     echo "This line uses |
|  the \"echo\" builtin."  |
|     /bin/echo "This line |
|  uses the /bin/echo syst |
| em command."             |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

A *keyword* is a *reserved* word, token or operator. Keywords have a
special meaning to the shell, and indeed are the building blocks of the
shell's syntax. As examples, *for*, *while*, *do*, and *!* are keywords.
Similar to a `builtin <internal.html#BUILTINREF>`__, a keyword is
hard-coded into Bash, but unlike a *builtin*, a keyword is not in itself
a command, but *a subunit of a command construct*.
`[2] <internal.html#FTN.AEN8650>`__

.. raw:: html

   <div class="VARIABLELIST">

**I/O**

\ **echo**
    prints (to ``stdout``) an expression or variable (see `Example
    4-1 <varsubn.html#EX9>`__).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo Hello           |
    |     echo $a              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    An **echo** requires the ``-e`` option to print escaped characters.
    See `Example 5-2 <escapingsection.html#ESCAPED>`__.

    Normally, each **echo** command prints a terminal newline, but the
    ``-n`` option suppresses this.

    .. raw:: html

       <div class="NOTE">

    +----------------+----------------+----------------+----------------+----------------+
    | |Note|         |
    | An **echo**    |
    | can be used to |
    | feed a         |
    | sequence of    |
    | commands down  |
    | a pipe.        |
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
    | |     if echo  |
    | "$VAR" | gre | |
    | | p -q txt   # |
    |  if [[ $VAR  | |
    | | = *txt* ]]   |
    |              | |
    | |     then     |
    |              | |
    | |       echo " |
    | $VAR contain | |
    | | s the substr |
    | ing sequence | |
    | |  \"txt\""    |
    |              | |
    | |     fi       |
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

       <div class="NOTE">

    +--------------------+--------------------+--------------------+--------------------+
    | |Note|             |
    | An **echo**, in    |
    | combination with   |
    | `command           |
    | substitution <comm |
    | andsub.html#COMMAN |
    | DSUBREF>`__        |
    | can set a          |
    | variable.          |
    |                    |
    | ``a=`echo          |
    |   "HELLO" | tr A-Z |
    |  a-z```            |
    |                    |
    | See also `Example  |
    | 16-22 <textproc.ht |
    | ml#LOWERCASE>`__,  |
    | `Example           |
    | 16-3 <moreadv.html |
    | #EX57>`__,         |
    | `Example           |
    | 16-47 <mathc.html# |
    | MONTHLYPMT>`__,    |
    | and `Example       |
    | 16-48 <mathc.html# |
    | BASE>`__.          |
    +--------------------+--------------------+--------------------+--------------------+

    .. raw:: html

       </div>

    Be aware that **echo \`command\`** deletes any linefeeds that the
    output of ``command`` generates.

    The `$IFS <internalvariables.html#IFSREF>`__ (internal field
    separator) variable normally contains \\n (linefeed) as one of its
    set of `whitespace <special-chars.html#WHITESPACEREF>`__ characters.
    Bash therefore splits the output of ``command`` at linefeeds into
    arguments to **echo**. Then **echo** outputs these arguments,
    separated by spaces.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ls -l /usr/sha |
    | re/apps/kjezz/sounds     |
    |     -rw-r--r--    1 root |
    |      root         1407 N |
    | ov  7  2000 reflect.au   |
    |      -rw-r--r--    1 roo |
    | t     root          362  |
    | Nov  7  2000 seconds.au  |
    |                          |
    |                          |
    |                          |
    |                          |
    |     bash$ echo `ls -l /u |
    | sr/share/apps/kjezz/soun |
    | ds`                      |
    |     total 40 -rw-r--r--  |
    | 1 root root 716 Nov 7 20 |
    | 00 reflect.au -rw-r--r-- |
    |  1 root root ...         |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    So, how can we embed a linefeed within an
    `echoed <internal.html#ECHOREF>`__ character string?

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Embedding a linefe |
    | ed?                      |
    |     echo "Why doesn't th |
    | is string \n split on tw |
    | o lines?"                |
    |     # Doesn't split.     |
    |                          |
    |     # Let's try somethin |
    | g else.                  |
    |                          |
    |     echo                 |
    |                          |
    |     echo $"A line of tex |
    | t containing             |
    |     a linefeed."         |
    |     # Prints as two dist |
    | inct lines (embedded lin |
    | efeed).                  |
    |     # But, is the "$" va |
    | riable prefix really nec |
    | essary?                  |
    |                          |
    |     echo                 |
    |                          |
    |     echo "This string sp |
    | lits                     |
    |     on two lines."       |
    |     # No, the "$" is not |
    |  needed.                 |
    |                          |
    |     echo                 |
    |     echo "-------------- |
    | -"                       |
    |     echo                 |
    |                          |
    |     echo -n $"Another li |
    | ne of text containing    |
    |     a linefeed."         |
    |     # Prints as two dist |
    | inct lines (embedded lin |
    | efeed).                  |
    |     # Even the -n option |
    |  fails to suppress the l |
    | inefeed here.            |
    |                          |
    |     echo                 |
    |     echo                 |
    |     echo "-------------- |
    | -"                       |
    |     echo                 |
    |     echo                 |
    |                          |
    |     # However, the follo |
    | wing doesn't work as exp |
    | ected.                   |
    |     # Why not? Hint: Ass |
    | ignment to a variable.   |
    |     string1=$"Yet anothe |
    | r line of text containin |
    | g                        |
    |     a linefeed (maybe)." |
    |                          |
    |     echo $string1        |
    |     # Yet another line o |
    | f text containing a line |
    | feed (maybe).            |
    |     #                    |
    |                  ^       |
    |     # Linefeed becomes a |
    |  space.                  |
    |                          |
    |     # Thanks, Steve Park |
    | er, for pointing this ou |
    | t.                       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="NOTE">

    +----------------+----------------+----------------+----------------+----------------+
    | |Note|         |
    | This command   |
    | is a shell     |
    | builtin, and   |
    | not the same   |
    | as             |
    | ``/bin/echo``, |
    | although its   |
    | behavior is    |
    | similar.       |
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
    | |     bash$ ty |
    | pe -a echo   | |
    | |     echo is  |
    | a shell buil | |
    | | tin          |
    |              | |
    | |      echo is |
    |  /bin/echo   | |
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
    | .. raw:: html  |
    |                |
    |    </p>        |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

\ **printf**
    The **printf**, formatted print, command is an enhanced **echo**. It
    is a limited variant of the *C* language ``printf()`` library
    function, and its syntax is somewhat different.

    **printf** ``format-string``... ``parameter``...

    This is the Bash *builtin* version of the ``/bin/printf`` or
    ``/usr/bin/printf`` command. See the **printf**
    `manpage <basic.html#MANREF>`__ (of the system command) for in-depth
    coverage.

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | Older versions of Bash may not       |
    | support **printf**.                  |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-2. *printf* in action**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # printf demo        |
    |                          |
    |     declare -r PI=3.1415 |
    | 9265358979     # Read-on |
    | ly variable, i.e., a con |
    | stant.                   |
    |     declare -r DecimalCo |
    | nstant=31373             |
    |                          |
    |     Message1="Greetings, |
    | "                        |
    |     Message2="Earthling. |
    | "                        |
    |                          |
    |     echo                 |
    |                          |
    |     printf "Pi to 2 deci |
    | mal places = %1.2f" $PI  |
    |     echo                 |
    |     printf "Pi to 9 deci |
    | mal places = %1.9f" $PI  |
    |  # It even rounds off co |
    | rrectly.                 |
    |                          |
    |     printf "\n"          |
    |                          |
    |  # Prints a line feed,   |
    |                          |
    |                          |
    |  # Equivalent to 'echo'  |
    | . . .                    |
    |                          |
    |     printf "Constant = \ |
    | t%d\n" $DecimalConstant  |
    |  # Inserts tab (\t).     |
    |                          |
    |     printf "%s %s \n" $M |
    | essage1 $Message2        |
    |                          |
    |     echo                 |
    |                          |
    |     # ================== |
    | ======================== |
    | #                        |
    |     # Simulation of C fu |
    | nction, sprintf().       |
    |     # Loading a variable |
    |  with a formatted string |
    | .                        |
    |                          |
    |     echo                 |
    |                          |
    |     Pi12=$(printf "%1.12 |
    | f" $PI)                  |
    |     echo "Pi to 12 decim |
    | al places = $Pi12"       |
    | # Roundoff error!        |
    |                          |
    |     Msg=`printf "%s %s \ |
    | n" $Message1 $Message2`  |
    |     echo $Msg; echo $Msg |
    |                          |
    |     #  As it happens, th |
    | e 'sprintf' function can |
    |  now be accessed         |
    |     #+ as a loadable mod |
    | ule to Bash,             |
    |     #+ but this is not p |
    | ortable.                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Formatting error messages is a useful application of **printf**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     E_BADDIR=85          |
    |                          |
    |     var=nonexistent_dire |
    | ctory                    |
    |                          |
    |     error()              |
    |     {                    |
    |       printf "$@" >&2    |
    |       # Formats position |
    | al params passed, and se |
    | nds them to stderr.      |
    |       echo               |
    |       exit $E_BADDIR     |
    |     }                    |
    |                          |
    |     cd $var || error $"C |
    | an't cd to %s." "$var"   |
    |                          |
    |     # Thanks, S.C.       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    See also `Example 36-17 <assortedtips.html#PROGRESSBAR>`__.

\ **read**
    "Reads" the value of a variable from ``stdin``, that is,
    interactively fetches input from the keyboard. The ``-a`` option
    lets **read** get array variables (see `Example
    27-6 <arrays.html#EX67>`__).

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-3. Variable assignment, using *read***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # "Reading" variable |
    | s.                       |
    |                          |
    |     echo -n "Enter the v |
    | alue of variable 'var1': |
    |  "                       |
    |     # The -n option to e |
    | cho suppresses newline.  |
    |                          |
    |     read var1            |
    |     # Note no '$' in fro |
    | nt of var1, since it is  |
    | being set.               |
    |                          |
    |     echo "var1 = $var1"  |
    |                          |
    |                          |
    |     echo                 |
    |                          |
    |     # A single 'read' st |
    | atement can set multiple |
    |  variables.              |
    |     echo -n "Enter the v |
    | alues of variables 'var2 |
    | ' and 'var3' "           |
    |     echo =n "(separated  |
    | by a space or tab): "    |
    |     read var2 var3       |
    |     echo "var2 = $var2   |
    |     var3 = $var3"        |
    |     #  If you input only |
    |  one value,              |
    |     #+ the other variabl |
    | e(s) will remain unset ( |
    | null).                   |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    A **read** without an associated variable assigns its input to the
    dedicated variable `$REPLY <internalvariables.html#REPLYREF>`__.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-4. What happens when *read* has no variable**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # read-novar.sh      |
    |                          |
    |     echo                 |
    |                          |
    |     # ------------------ |
    | -------- #               |
    |     echo -n "Enter a val |
    | ue: "                    |
    |     read var             |
    |     echo "\"var\" = "$va |
    | r""                      |
    |     # Everything as expe |
    | cted here.               |
    |     # ------------------ |
    | -------- #               |
    |                          |
    |     echo                 |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | ------------------------ |
    | - #                      |
    |     echo -n "Enter anoth |
    | er value: "              |
    |     read           #  No |
    |  variable supplied for ' |
    | read', therefore...      |
    |                    #+ In |
    | put to 'read' assigned t |
    | o default variable, $REP |
    | LY.                      |
    |     var="$REPLY"         |
    |     echo "\"var\" = "$va |
    | r""                      |
    |     # This is equivalent |
    |  to the first code block |
    | .                        |
    |     # ------------------ |
    | ------------------------ |
    | ------------------------ |
    | - #                      |
    |                          |
    |     echo                 |
    |     echo "============== |
    | ==========="             |
    |     echo                 |
    |                          |
    |                          |
    |     #  This example is s |
    | imilar to the "reply.sh" |
    |  script.                 |
    |     #  However, this one |
    |  shows that $REPLY is av |
    | ailable                  |
    |     #+ even after a 'rea |
    | d' to a variable in the  |
    | conventional way.        |
    |                          |
    |                          |
    |     # ================== |
    | ======================== |
    | =======================  |
    | #                        |
    |                          |
    |     #  In some instances |
    | , you might wish to disc |
    | ard the first value read |
    | .                        |
    |     #  In such cases, si |
    | mply ignore the $REPLY v |
    | ariable.                 |
    |                          |
    |     { # Code block.      |
    |     read            # Li |
    | ne 1, to be discarded.   |
    |     read line2      # Li |
    | ne 2, saved in variable. |
    |       } <$0              |
    |     echo "Line 2 of this |
    |  script is:"             |
    |     echo "$line2"   #    |
    | # read-novar.sh          |
    |     echo            #    |
    | #!/bin/bash  line discar |
    | ded.                     |
    |                          |
    |     # See also the sound |
    | card-on.sh script.       |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Normally, inputting a ``\`` suppresses a newline during input to a
    **read**. The ``-r`` option causes an inputted ``\`` to be
    interpreted literally.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-5. Multi-line input to *read***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     echo                 |
    |                          |
    |     echo "Enter a string |
    |  terminated by a \\, the |
    | n press <ENTER>."        |
    |     echo "Then, enter a  |
    | second string (no \\ thi |
    | s time), and again press |
    |  <ENTER>."               |
    |                          |
    |     read var1     # The  |
    | "\" suppresses the newli |
    | ne, when reading $var1.  |
    |                   #      |
    | first line \             |
    |                   #      |
    | second line              |
    |                          |
    |     echo "var1 = $var1"  |
    |     #     var1 = first l |
    | ine second line          |
    |                          |
    |     #  For each line ter |
    | minated by a "\"         |
    |     #+ you get a prompt  |
    | on the next line to cont |
    | inue feeding characters  |
    | into var1.               |
    |                          |
    |     echo; echo           |
    |                          |
    |     echo "Enter another  |
    | string terminated by a \ |
    | \ , then press <ENTER>." |
    |     read -r var2  # The  |
    | -r option causes the "\" |
    |  to be read literally.   |
    |                   #      |
    | first line \             |
    |                          |
    |     echo "var2 = $var2"  |
    |     #     var2 = first l |
    | ine \                    |
    |                          |
    |     # Data entry termina |
    | tes with the first <ENTE |
    | R>.                      |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The **read** command has some interesting options that permit
    echoing a prompt and even reading keystrokes without hitting
    **ENTER**.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Read a keypress wi |
    | thout hitting ENTER.     |
    |                          |
    |     read -s -n1 -p "Hit  |
    | a key " keypress         |
    |     echo; echo "Keypress |
    |  was "\"$keypress\""."   |
    |                          |
    |     # -s option means do |
    |  not echo input.         |
    |     # -n N option means  |
    | accept only N characters |
    |  of input.               |
    |     # -p option means ec |
    | ho the following prompt  |
    | before reading input.    |
    |                          |
    |     # Using these option |
    | s is tricky, since they  |
    | need to be in the correc |
    | t order.                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The ``-n`` option to **read** also allows detection of the **arrow
    keys** and certain of the other unusual keys.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-6. Detecting the arrow keys**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # arrow-detect.sh: D |
    | etects the arrow keys, a |
    | nd a few more.           |
    |     # Thank you, Sandro  |
    | Magi, for showing me how |
    | .                        |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | --                       |
    |     # Character codes ge |
    | nerated by the keypresse |
    | s.                       |
    |     arrowup='\[A'        |
    |     arrowdown='\[B'      |
    |     arrowrt='\[C'        |
    |     arrowleft='\[D'      |
    |     insert='\[2'         |
    |     delete='\[3'         |
    |     # ------------------ |
    | ------------------------ |
    | --                       |
    |                          |
    |     SUCCESS=0            |
    |     OTHER=65             |
    |                          |
    |     echo -n "Press a key |
    | ...  "                   |
    |     # May need to also p |
    | ress ENTER if a key not  |
    | listed above pressed.    |
    |     read -n3 key         |
    |               # Read 3 c |
    | haracters.               |
    |                          |
    |     echo -n "$key" | gre |
    | p "$arrowup"  #Check if  |
    | character code detected. |
    |     if [ "$?" -eq $SUCCE |
    | SS ]                     |
    |     then                 |
    |       echo "Up-arrow key |
    |  pressed."               |
    |       exit $SUCCESS      |
    |     fi                   |
    |                          |
    |     echo -n "$key" | gre |
    | p "$arrowdown"           |
    |     if [ "$?" -eq $SUCCE |
    | SS ]                     |
    |     then                 |
    |       echo "Down-arrow k |
    | ey pressed."             |
    |       exit $SUCCESS      |
    |     fi                   |
    |                          |
    |     echo -n "$key" | gre |
    | p "$arrowrt"             |
    |     if [ "$?" -eq $SUCCE |
    | SS ]                     |
    |     then                 |
    |       echo "Right-arrow  |
    | key pressed."            |
    |       exit $SUCCESS      |
    |     fi                   |
    |                          |
    |     echo -n "$key" | gre |
    | p "$arrowleft"           |
    |     if [ "$?" -eq $SUCCE |
    | SS ]                     |
    |     then                 |
    |       echo "Left-arrow k |
    | ey pressed."             |
    |       exit $SUCCESS      |
    |     fi                   |
    |                          |
    |     echo -n "$key" | gre |
    | p "$insert"              |
    |     if [ "$?" -eq $SUCCE |
    | SS ]                     |
    |     then                 |
    |       echo "\"Insert\" k |
    | ey pressed."             |
    |       exit $SUCCESS      |
    |     fi                   |
    |                          |
    |     echo -n "$key" | gre |
    | p "$delete"              |
    |     if [ "$?" -eq $SUCCE |
    | SS ]                     |
    |     then                 |
    |       echo "\"Delete\" k |
    | ey pressed."             |
    |       exit $SUCCESS      |
    |     fi                   |
    |                          |
    |                          |
    |     echo " Some other ke |
    | y pressed."              |
    |                          |
    |     exit $OTHER          |
    |                          |
    |     # ================== |
    | =======================  |
    | #                        |
    |                          |
    |     #  Mark Alexander ca |
    | me up with a simplified  |
    |     #+ version of the ab |
    | ove script (Thank you!). |
    |     #  It eliminates the |
    |  need for grep.          |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |       uparrow=$'\x1b[A'  |
    |       downarrow=$'\x1b[B |
    | '                        |
    |       leftarrow=$'\x1b[D |
    | '                        |
    |       rightarrow=$'\x1b[ |
    | C'                       |
    |                          |
    |       read -s -n3 -p "Hi |
    | t an arrow key: " x      |
    |                          |
    |       case "$x" in       |
    |       $uparrow)          |
    |          echo "You press |
    | ed up-arrow"             |
    |          ;;              |
    |       $downarrow)        |
    |          echo "You press |
    | ed down-arrow"           |
    |          ;;              |
    |       $leftarrow)        |
    |          echo "You press |
    | ed left-arrow"           |
    |          ;;              |
    |       $rightarrow)       |
    |          echo "You press |
    | ed right-arrow"          |
    |          ;;              |
    |       esac               |
    |                          |
    |     exit $?              |
    |                          |
    |     # ================== |
    | =======================  |
    | #                        |
    |                          |
    |     # Antonio Macchi has |
    |  a simpler alternative.  |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     while true           |
    |     do                   |
    |       read -sn1 a        |
    |       test "$a" == `echo |
    |  -en "\e"` || continue   |
    |       read -sn1 a        |
    |       test "$a" == "[" | |
    | | continue               |
    |       read -sn1 a        |
    |       case "$a" in       |
    |         A)  echo "up";;  |
    |         B)  echo "down"; |
    | ;                        |
    |         C)  echo "right" |
    | ;;                       |
    |         D)  echo "left"; |
    | ;                        |
    |       esac               |
    |     done                 |
    |                          |
    |     # ================== |
    | =======================  |
    | #                        |
    |                          |
    |     #  Exercise:         |
    |     #  --------          |
    |     #  1) Add detection  |
    | of the "Home," "End," "P |
    | gUp," and "PgDn" keys.   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The ``-n`` option to **read** will   |
    | not detect the **ENTER** (newline)   |
    | key.                                 |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    The ``-t`` option to **read** permits timed input (see `Example
    9-4 <internalvariables.html#TOUT>`__ and `Example
    A-41 <contributed-scripts.html#QKY>`__).

    The ``-u`` option takes the `file
    descriptor <io-redirection.html#FDREF>`__ of the target file.

    The **read** command may also "read" its variable value from a file
    `redirected <io-redirection.html#IOREDIRREF>`__ to ``stdin``. If the
    file contains more than one line, only the first line is assigned to
    the variable. If **read** has more than one parameter, then each of
    these variables gets assigned a successive
    `whitespace-delineated <special-chars.html#WHITESPACEREF>`__ string.
    Caution!

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-7. Using *read* with `file
    redirection <io-redirection.html#IOREDIRREF>`__**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     read var1 <data-file |
    |     echo "var1 = $var1"  |
    |     # var1 set to the en |
    | tire first line of the i |
    | nput file "data-file"    |
    |                          |
    |     read var2 var3 <data |
    | -file                    |
    |     echo "var2 = $var2   |
    |  var3 = $var3"           |
    |     # Note non-intuitive |
    |  behavior of "read" here |
    | .                        |
    |     # 1) Rewinds back to |
    |  the beginning of input  |
    | file.                    |
    |     # 2) Each variable i |
    | s now set to a correspon |
    | ding string,             |
    |     #    separated by wh |
    | itespace, rather than to |
    |  an entire line of text. |
    |     # 3) The final varia |
    | ble gets the remainder o |
    | f the line.              |
    |     # 4) If there are mo |
    | re variables to be set t |
    | han whitespace-terminate |
    | d strings                |
    |     #    on the first li |
    | ne of the file, then the |
    |  excess variables remain |
    |  empty.                  |
    |                          |
    |     echo "-------------- |
    | ------------------------ |
    | ----------"              |
    |                          |
    |     # How to resolve the |
    |  above problem with a lo |
    | op:                      |
    |     while read line      |
    |     do                   |
    |       echo "$line"       |
    |     done <data-file      |
    |     # Thanks, Heiner Ste |
    | ven for pointing this ou |
    | t.                       |
    |                          |
    |     echo "-------------- |
    | ------------------------ |
    | ----------"              |
    |                          |
    |     # Use $IFS (Internal |
    |  Field Separator variabl |
    | e) to split a line of in |
    | put to                   |
    |     # "read", if you do  |
    | not want the default to  |
    | be whitespace.           |
    |                          |
    |     echo "List of all us |
    | ers:"                    |
    |     OIFS=$IFS; IFS=:     |
    |    # /etc/passwd uses ": |
    | " for field separator.   |
    |     while read name pass |
    | wd uid gid fullname igno |
    | re                       |
    |     do                   |
    |       echo "$name ($full |
    | name)"                   |
    |     done </etc/passwd    |
    | # I/O redirection.       |
    |     IFS=$OIFS            |
    |    # Restore original $I |
    | FS.                      |
    |     # This code snippet  |
    | also by Heiner Steven.   |
    |                          |
    |                          |
    |                          |
    |     #  Setting the $IFS  |
    | variable within the loop |
    |  itself                  |
    |     #+ eliminates the ne |
    | ed for storing the origi |
    | nal $IFS                 |
    |     #+ in a temporary va |
    | riable.                  |
    |     #  Thanks, Dim Segeb |
    | art, for pointing this o |
    | ut.                      |
    |     echo "-------------- |
    | ------------------------ |
    | ----------"              |
    |     echo "List of all us |
    | ers:"                    |
    |                          |
    |     while IFS=: read nam |
    | e passwd uid gid fullnam |
    | e ignore                 |
    |     do                   |
    |       echo "$name ($full |
    | name)"                   |
    |     done </etc/passwd    |
    | # I/O redirection.       |
    |                          |
    |     echo                 |
    |     echo "\$IFS still $I |
    | FS"                      |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+
    | |Note |
    | |     |
    |       |
    | `Pipi |
    | ng <s |
    | pecia |
    | l-cha |
    | rs.ht |
    | ml#PI |
    | PEREF |
    | >`__  |
    | outpu |
    | t     |
    | to a  |
    | *read |
    | *,    |
    | using |
    | `echo |
    |  <int |
    | ernal |
    | .html |
    | #ECHO |
    | REF>` |
    | __    |
    | to    |
    | set   |
    | varia |
    | bles  |
    | `will |
    | fail  |
    | <gotc |
    | has.h |
    | tml#B |
    | ADREA |
    | D0>`_ |
    | _.    |
    |       |
    | Yet,  |
    | pipin |
    | g     |
    | the   |
    | outpu |
    | t     |
    | of    |
    | `cat  |
    | <basi |
    | c.htm |
    | l#CAT |
    | REF>` |
    | __    |
    | *seem |
    | s*    |
    | to    |
    | work. |
    |       |
    | +---- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | --+-- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----+ |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | -+    |
    | | ..  |
    | code: |
    | : PRO |
    | GRAML |
    | ISTIN |
    | G |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  cat  |
    | file1 |
    |  file |
    | 2 |   |
    |   |   |
    | |     |
    |  whil |
    | e rea |
    | d lin |
    | e     |
    |   |   |
    | |     |
    |  do   |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  echo |
    |  $lin |
    | e     |
    |       |
    |   |   |
    | |     |
    |  done |
    |       |
    |       |
    |       |
    |   |   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | +---- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | --+-- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----+ |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | -+    |
    |       |
    | .. ra |
    | w:: h |
    | tml   |
    |       |
    |    </ |
    | p>    |
    |       |
    | Howev |
    | er,   |
    | as    |
    | Bjön  |
    | Eriks |
    | son   |
    | shows |
    | :     |
    |       |
    | .. ra |
    | w:: h |
    | tml   |
    |       |
    |    <d |
    | iv    |
    |    cl |
    | ass=" |
    | EXAMP |
    | LE">  |
    |       |
    | **Exa |
    | mple  |
    | 15-8. |
    | Probl |
    | ems   |
    | readi |
    | ng    |
    | from  |
    | a     |
    | pipe* |
    | *     |
    |       |
    | +---- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | --+-- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----+ |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | -+    |
    | | ..  |
    | code: |
    | : PRO |
    | GRAML |
    | ISTIN |
    | G |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  #!/b |
    | in/sh |
    |       |
    |       |
    |   |   |
    | |     |
    |  # re |
    | adpip |
    | e.sh  |
    |       |
    |   |   |
    | |     |
    |  # Th |
    | is ex |
    | ample |
    |  cont |
    | r |   |
    | | ibu |
    | ted b |
    | y Bjo |
    | n Eri |
    | ksson |
    | . |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  ###  |
    | shopt |
    |  -s l |
    | astpi |
    | p |   |
    | | e   |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  last |
    | ="(nu |
    | ll)"  |
    |       |
    |   |   |
    | |     |
    |  cat  |
    | $0 |  |
    |       |
    |       |
    |   |   |
    | |     |
    |  whil |
    | e rea |
    | d lin |
    | e     |
    |   |   |
    | |     |
    |  do   |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    | echo  |
    | "{$li |
    | ne}"  |
    |   |   |
    | |     |
    |       |
    | last= |
    | $line |
    |       |
    |   |   |
    | |     |
    |  done |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  echo |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  echo |
    |  "+++ |
    | +++++ |
    | +++++ |
    | + |   |
    | | +++ |
    | +++++ |
    | "     |
    |       |
    |       |
    |   |   |
    | |     |
    |  prin |
    | tf "\ |
    | nAll  |
    | done, |
    |   |   |
    | | las |
    | t: $l |
    | ast\n |
    | " #   |
    | The o |
    | u |   |
    | | tpu |
    | t of  |
    | this  |
    | line  |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |   #+  |
    | chang |
    | e |   |
    | | s i |
    | f you |
    |  unco |
    | mment |
    |  line |
    |   |   |
    | | 5.  |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |   #   |
    | (Bash |
    | , |   |
    | |  ve |
    | rsion |
    |  -ge  |
    | 4.2 r |
    | equir |
    | e |   |
    | | d.) |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  exit |
    |  0  # |
    |  End  |
    | of co |
    | d |   |
    | | e.  |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |     # |
    |  (Par |
    | tial) |
    |   |   |
    | | out |
    | put o |
    | f scr |
    | ipt f |
    | ollow |
    | s |   |
    | | .   |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |     # |
    |  The  |
    | 'echo |
    | ' |   |
    | |  su |
    | pplie |
    | s ext |
    | ra br |
    | acket |
    | s |   |
    | | .   |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  #### |
    | ##### |
    | ##### |
    | ##### |
    | # |   |
    | | ### |
    | ##### |
    | ##### |
    | ##### |
    | ##### |
    | # |   |
    | | #   |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  ./re |
    | adpip |
    | e.sh  |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  {#!/ |
    | bin/s |
    | h}    |
    |       |
    |   |   |
    | |     |
    |  {las |
    | t="(n |
    | ull)" |
    | }     |
    |   |   |
    | |     |
    |  {cat |
    |  $0 | |
    | }     |
    |       |
    |   |   |
    | |     |
    |  {whi |
    | le re |
    | ad li |
    | ne}   |
    |   |   |
    | |     |
    |  {do} |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  {ech |
    | o "{$ |
    | line} |
    | "}    |
    |   |   |
    | |     |
    |  {las |
    | t=$li |
    | ne}   |
    |       |
    |   |   |
    | |     |
    |  {don |
    | e}    |
    |       |
    |       |
    |   |   |
    | |     |
    |  {pri |
    | ntf " |
    | nAll  |
    | done, |
    |   |   |
    | | las |
    | t: $l |
    | astn" |
    | }     |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  All  |
    | done, |
    |  last |
    | : (nu |
    | l |   |
    | | l)  |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  The  |
    | varia |
    | ble ( |
    | last) |
    |   |   |
    | | is  |
    | set w |
    | ithin |
    |  the  |
    | loop/ |
    | s |   |
    | | ubs |
    | hell  |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  but  |
    | its v |
    | alue  |
    | does  |
    | n |   |
    | | ot  |
    | persi |
    | st ou |
    | tside |
    |  the  |
    | l |   |
    | | oop |
    | .     |
    |       |
    |       |
    |       |
    |   |   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | +---- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | --+-- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----+ |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | -+    |
    |       |
    | .. ra |
    | w:: h |
    | tml   |
    |       |
    |    </ |
    | div>  |
    |       |
    | The   |
    | *gend |
    | iff*  |
    | scrip |
    | t,    |
    | usual |
    | ly    |
    | found |
    | in    |
    | ``/us |
    | r/bin |
    | ``    |
    | on    |
    | many  |
    | Linux |
    | distr |
    | os,   |
    | pipes |
    | the   |
    | outpu |
    | t     |
    | of    |
    | `find |
    |  <mor |
    | eadv. |
    | html# |
    | FINDR |
    | EF>`_ |
    | _     |
    | to a  |
    | *whil |
    | e     |
    | read* |
    | const |
    | ruct. |
    |       |
    | +---- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | --+-- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----+ |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | -+    |
    | | ..  |
    | code: |
    | : PRO |
    | GRAML |
    | ISTIN |
    | G |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  find |
    |  $1 \ |
    | ( -na |
    | me "* |
    | $ |   |
    | | 2"  |
    | -o -n |
    | ame " |
    | .*$2" |
    |  \) - |
    | p |   |
    | | rin |
    | t |   |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  whil |
    | e rea |
    | d f;  |
    | do    |
    |   |   |
    | |     |
    |  . .  |
    | .     |
    |       |
    |       |
    |   |   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | +---- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | --+-- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----+ |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | -+    |
    |       |
    | .. ra |
    | w:: h |
    | tml   |
    |       |
    |    </ |
    | p>    |
           
    +-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="TIP">

    +--------------------------------------+--------------------------------------+
    | |Tip|                                |
    | It is possible to *paste* text into  |
    | the input field of a *read* (but     |
    | *not* multiple lines!). See `Example |
    | A-38 <contributed-scripts.html#PADSW |
    | >`__.                                |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Filesystem**

\ **cd**
    The familiar **cd** change directory command finds use in scripts
    where execution of a command requires being in a specified
    directory.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     (cd /source/director |
    | y && tar cf - . ) | (cd  |
    | /dest/directory && tar x |
    | pvf -)                   |
                              
    +--------------------------+--------------------------+--------------------------+

    [from the `previously cited <special-chars.html#COXEX>`__ example by
    Alan Cox]

    .. raw:: html

       </p>

    The ``-P`` (physical) option to **cd** causes it to ignore symbolic
    links.

    **cd -** changes to `$OLDPWD <internalvariables.html#OLDPWD>`__, the
    previous working directory.

    .. raw:: html

       <div class="CAUTION">

    +----------------+----------------+----------------+----------------+----------------+
    | |Caution|      |
    | The **cd**     |
    | command does   |
    | not function   |
    | as expected    |
    | when presented |
    | with two       |
    | forward        |
    | slashes.       |
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
    | |     bash$ cd |
    |  //          | |
    | |     bash$ pw |
    | d            | |
    | |     //       |
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
    | The output     |
    | should, of     |
    | course, be     |
    | ``/``. This is |
    | a problem both |
    | from the       |
    | command-line   |
    | and in a       |
    | script.        |
    |                |
    | .. raw:: html  |
    |                |
    |    </p>        |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

\ **pwd**
    Print Working Directory. This gives the user's (or script's) current
    directory (see `Example 15-9 <internal.html#EX37>`__). The effect is
    identical to reading the value of the builtin variable
    `$PWD <internalvariables.html#PWDREF>`__.

\ **pushd**, **popd**, **dirs**
    This command set is a mechanism for bookmarking working directories,
    a means of moving back and forth through directories in an orderly
    manner. A pushdown `stack <internalvariables.html#STACKDEFREF>`__ is
    used to keep track of directory names. Options allow various
    manipulations of the directory stack.

    \ ``pushd           dir-name`` pushes the path ``dir-name`` onto the
    directory stack (to the *top* of the stack) and simultaneously
    changes the current working directory to ``dir-name``

    \ **popd** removes (pops) the top directory path name off the
    directory stack and simultaneously changes the current working
    directory to the directory now at the *top* of the stack.

    \ **dirs** lists the contents of the directory stack (compare this
    with the `$DIRSTACK <internalvariables.html#DIRSTACKREF>`__
    variable). A successful **pushd** or **popd** will automatically
    invoke **dirs**.

    Scripts that require various changes to the current working
    directory without hard-coding the directory name changes can make
    good use of these commands. Note that the implicit ``$DIRSTACK``
    array variable, accessible from within a script, holds the contents
    of the directory stack.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-9. Changing the current working directory**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     dir1=/usr/local      |
    |     dir2=/var/spool      |
    |                          |
    |     pushd $dir1          |
    |     # Will do an automat |
    | ic 'dirs' (list director |
    | y stack to stdout).      |
    |     echo "Now in directo |
    | ry `pwd`." # Uses back-q |
    | uoted 'pwd'.             |
    |                          |
    |     # Now, do some stuff |
    |  in directory 'dir1'.    |
    |     pushd $dir2          |
    |     echo "Now in directo |
    | ry `pwd`."               |
    |                          |
    |     # Now, do some stuff |
    |  in directory 'dir2'.    |
    |     echo "The top entry  |
    | in the DIRSTACK array is |
    |  $DIRSTACK."             |
    |     popd                 |
    |     echo "Now back in di |
    | rectory `pwd`."          |
    |                          |
    |     # Now, do some more  |
    | stuff in directory 'dir1 |
    | '.                       |
    |     popd                 |
    |     echo "Now back in or |
    | iginal working directory |
    |  `pwd`."                 |
    |                          |
    |     exit 0               |
    |                          |
    |     # What happens if yo |
    | u don't 'popd' -- then e |
    | xit the script?          |
    |     # Which directory do |
    |  you end up in? Why?     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Variables**

\ **let**
    The **let** command carries out *arithmetic* operations on
    variables. `[3] <internal.html#FTN.AEN9009>`__ In many cases, it
    functions as a less complex version of
    `expr <moreadv.html#EXPRREF>`__.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-10. Letting *let* do arithmetic.**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     echo                 |
    |                          |
    |     let a=11             |
    | # Same as 'a=11'         |
    |     let a=a+5            |
    | # Equivalent to  let "a  |
    | = a + 5"                 |
    |                          |
    | # (Double quotes and spa |
    | ces make it more readabl |
    | e.)                      |
    |     echo "11 + 5 = $a"   |
    | # 16                     |
    |                          |
    |     let "a <<= 3"        |
    | # Equivalent to  let "a  |
    | = a << 3"                |
    |     echo "\"\$a\" (=16)  |
    | left-shifted 3 places =  |
    | $a"                      |
    |                          |
    | # 128                    |
    |                          |
    |     let "a /= 4"         |
    | # Equivalent to  let "a  |
    | = a / 4"                 |
    |     echo "128 / 4 = $a"  |
    | # 32                     |
    |                          |
    |     let "a -= 5"         |
    | # Equivalent to  let "a  |
    | = a - 5"                 |
    |     echo "32 - 5 = $a"   |
    | # 27                     |
    |                          |
    |     let "a *=  10"       |
    | # Equivalent to  let "a  |
    | = a * 10"                |
    |     echo "27 * 10 = $a"  |
    | # 270                    |
    |                          |
    |     let "a %= 8"         |
    | # Equivalent to  let "a  |
    | = a % 8"                 |
    |     echo "270 modulo 8 = |
    |  $a  (270 / 8 = 33, rema |
    | inder $a)"               |
    |                          |
    | # 6                      |
    |                          |
    |                          |
    |     # Does "let" permit  |
    | C-style operators?       |
    |     # Yes, just as the ( |
    | ( ... )) double-parenthe |
    | ses construct does.      |
    |                          |
    |     let a++              |
    | # C-style (post) increme |
    | nt.                      |
    |     echo "6++ = $a"      |
    | # 6++ = 7                |
    |     let a--              |
    | # C-style decrement.     |
    |     echo "7-- = $a"      |
    | # 7-- = 6                |
    |     # Of course, ++a, et |
    | c., also allowed . . .   |
    |     echo                 |
    |                          |
    |                          |
    |     # Trinary operator.  |
    |                          |
    |     # Note that $a is 6, |
    |  see above.              |
    |     let "t = a<7?7:11"   |
    |  # True                  |
    |     echo $t  # 7         |
    |                          |
    |     let a++              |
    |     let "t = a<7?7:11"   |
    |  # False                 |
    |     echo $t  #     11    |
    |                          |
    |     exit                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +----------------+----------------+----------------+----------------+----------------+
    | |Caution|      |
    | The *let*      |
    | command can,   |
    | in certain     |
    | contexts,      |
    | return a       |
    | surprising     |
    | `exit          |
    | status <exit-s |
    | tatus.html#EXI |
    | TSTATUSREF>`__ |
    | .              |
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
    | |     # Evgeni |
    | y Ivanov poi | |
    | | nts out:     |
    |              | |
    | |              |
    |              | |
    | |     var=0    |
    |              | |
    | |     echo $?  |
    |     # 0      | |
    | |              |
    |     # As exp | |
    | | ected.       |
    |              | |
    | |              |
    |              | |
    | |     let var+ |
    | +            | |
    | |     echo $?  |
    |     # 1      | |
    | |              |
    |     # The co | |
    | | mmand was su |
    | ccessful, so | |
    | |  why isn't $ |
    | ?=0 ???      | |
    | |              |
    |     # Anomal | |
    | | y!           |
    |              | |
    | |              |
    |              | |
    | |     let var+ |
    | +            | |
    | |     echo $?  |
    |     # 0      | |
    | |              |
    |     # As exp | |
    | | ected.       |
    |              | |
    | |              |
    |              | |
    | |              |
    |              | |
    | |     # Likewi |
    | se . . .     | |
    | |              |
    |              | |
    | |     let var= |
    | 0            | |
    | |     echo $?  |
    |     # 1      | |
    | |              |
    |     # The co | |
    | | mmand was su |
    | ccessful, so | |
    | |  why isn't $ |
    | ?=0 ???      | |
    | |              |
    |              | |
    | |     #  Howev |
    | er, as Jeff  | |
    | | Gorak points |
    |  out,        | |
    | |     #+ this  |
    | is part of t | |
    | | he design sp |
    | ec for 'let' | |
    | |  . . .       |
    |              | |
    | |     # "If th |
    | e last ARG e | |
    | | valuates to  |
    | 0, let retur | |
    | | ns 1;        |
    |              | |
    | |     #  let r |
    | eturns 0 oth | |
    | | erwise." ['h |
    | elp let']    | |
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

\ **eval**
    ``eval arg1 [arg2] ... [argN]``

    Combines the arguments in an expression or list of expressions and
    ``evaluates`` them. Any variables within the expression are
    expanded. The net result is to **convert a string into a command**.

    .. raw:: html

       <div class="TIP">

    +--------------------------------------+--------------------------------------+
    | |Tip|                                |
    | The **eval** command can be used for |
    | code generation from the             |
    | command-line or within a script.     |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ command_string |
    | ="ps ax"                 |
    |     bash$ process="ps ax |
    | "                        |
    |     bash$ eval "$command |
    | _string" | grep "$proces |
    | s"                       |
    |     26973 pts/3    R+    |
    |   0:00 grep --color ps a |
    | x                        |
    |      26974 pts/3    R+   |
    |    0:00 ps ax            |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Each invocation of *eval* forces a re-\ *evaluation* of its
    arguments.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     a='$b'               |
    |     b='$c'               |
    |     c=d                  |
    |                          |
    |     echo $a              |
    | # $b                     |
    |                          |
    | # First level.           |
    |     eval echo $a         |
    | # $c                     |
    |                          |
    | # Second level.          |
    |     eval eval echo $a    |
    | # d                      |
    |                          |
    | # Third level.           |
    |                          |
    |     # Thank you, E. Chor |
    | oba.                     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-11. Showing the effect of *eval***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Exercising "eval"  |
    | ...                      |
    |                          |
    |     y=`eval ls -l`  #  S |
    | imilar to y=`ls -l`      |
    |     echo $y         #+ b |
    | ut linefeeds removed bec |
    | ause "echoed" variable i |
    | s unquoted.              |
    |     echo                 |
    |     echo "$y"       #  L |
    | inefeeds preserved when  |
    | variable is quoted.      |
    |                          |
    |     echo; echo           |
    |                          |
    |     y=`eval df`     #  S |
    | imilar to y=`df`         |
    |     echo $y         #+ b |
    | ut linefeeds removed.    |
    |                          |
    |     #  When LF's not pre |
    | served, it may make it e |
    | asier to parse output,   |
    |     #+ using utilities s |
    | uch as "awk".            |
    |                          |
    |     echo                 |
    |     echo "============== |
    | ======================== |
    | ====================="   |
    |     echo                 |
    |                          |
    |     eval "`seq 3 | sed - |
    | e 's/.*/echo var&=ABCDEF |
    | GHIJ/'`"                 |
    |     # var1=ABCDEFGHIJ    |
    |     # var2=ABCDEFGHIJ    |
    |     # var3=ABCDEFGHIJ    |
    |                          |
    |     echo                 |
    |     echo "============== |
    | ======================== |
    | ====================="   |
    |     echo                 |
    |                          |
    |                          |
    |     # Now, showing how t |
    | o do something useful wi |
    | th "eval" . . .          |
    |     # (Thank you, E. Cho |
    | roba!)                   |
    |                          |
    |     version=3.4     #  C |
    | an we split the version  |
    | into major and minor     |
    |                     #+ p |
    | art in one command?      |
    |     echo "version = $ver |
    | sion"                    |
    |     eval major=${version |
    | /./;minor=}     #  Repla |
    | ces '.' in version by '; |
    | minor='                  |
    |                          |
    |                 #  The s |
    | ubstitution yields '3; m |
    | inor=4'                  |
    |                          |
    |                 #+ so ev |
    | al does minor=4, major=3 |
    |     echo Major: $major,  |
    | minor: $minor   #  Major |
    | : 3, minor: 4            |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-12. Using *eval* to select among variables**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # arr-choice.sh      |
    |                          |
    |     #  Passing arguments |
    |  to a function to select |
    |     #+ one particular va |
    | riable out of a group.   |
    |                          |
    |     arr0=( 10 11 12 13 1 |
    | 4 15 )                   |
    |     arr1=( 20 21 22 23 2 |
    | 4 25 )                   |
    |     arr2=( 30 31 32 33 3 |
    | 4 35 )                   |
    |     #       0  1  2  3   |
    | 4  5      Element number |
    |  (zero-indexed)          |
    |                          |
    |                          |
    |     choose_array ()      |
    |     {                    |
    |       eval array_member= |
    | \${arr${array_number}[el |
    | ement_number]}           |
    |       #                  |
    | ^       ^^^^^^^^^^^^     |
    |       #  Using eval to c |
    | onstruct the name of a v |
    | ariable,                 |
    |       #+ in this particu |
    | lar case, an array name. |
    |                          |
    |       echo "Element $ele |
    | ment_number of array $ar |
    | ray_number is $array_mem |
    | ber"                     |
    |     } #  Function can be |
    |  rewritten to take param |
    | eters.                   |
    |                          |
    |     array_number=0    #  |
    | First array.             |
    |     element_number=3     |
    |     choose_array      #  |
    | 13                       |
    |                          |
    |     array_number=2    #  |
    | Third array.             |
    |     element_number=4     |
    |     choose_array      #  |
    | 34                       |
    |                          |
    |     array_number=3    #  |
    | Null array (arr3 not all |
    | ocated).                 |
    |     element_number=4     |
    |     choose_array      #  |
    | (null)                   |
    |                          |
    |     # Thank you, Antonio |
    |  Macchi, for pointing th |
    | is out.                  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-13. *Echoing* the *command-line parameters***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # echo-params.sh     |
    |                          |
    |     # Call this script w |
    | ith a few command-line p |
    | arameters.               |
    |     # For example:       |
    |     #     sh echo-params |
    | .sh first second third f |
    | ourth fifth              |
    |                          |
    |     params=$#            |
    |    # Number of command-l |
    | ine parameters.          |
    |     param=1              |
    |    # Start at first comm |
    | and-line param.          |
    |                          |
    |     while [ "$param" -le |
    |  "$params" ]             |
    |     do                   |
    |       echo -n "Command-l |
    | ine parameter "          |
    |       echo -n \$$param   |
    |    #  Gives only the *na |
    | me* of variable.         |
    |     #         ^^^        |
    |    #  $1, $2, $3, etc.   |
    |                          |
    |    #  Why?               |
    |                          |
    |    #  \$ escapes the fir |
    | st "$"                   |
    |                          |
    |    #+ so it echoes liter |
    | ally,                    |
    |                          |
    |    #+ and $param derefer |
    | ences "$param" . . .     |
    |                          |
    |    #+ . . . as expected. |
    |       echo -n " = "      |
    |       eval echo \$$param |
    |    #  Gives the *value*  |
    | of variable.             |
    |     # ^^^^      ^^^      |
    |    #  The "eval" forces  |
    | the *evaluation*         |
    |                          |
    |    #+ of \$$             |
    |                          |
    |    #+ as an indirect var |
    | iable reference.         |
    |                          |
    |     (( param ++ ))       |
    |    # On to the next.     |
    |     done                 |
    |                          |
    |     exit $?              |
    |                          |
    |     # ================== |
    | ======================== |
    | =======                  |
    |                          |
    |     $ sh echo-params.sh  |
    | first second third fourt |
    | h fifth                  |
    |     Command-line paramet |
    | er $1 = first            |
    |     Command-line paramet |
    | er $2 = second           |
    |     Command-line paramet |
    | er $3 = third            |
    |     Command-line paramet |
    | er $4 = fourth           |
    |     Command-line paramet |
    | er $5 = fifth            |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-14. Forcing a log-off**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Killing ppp to for |
    | ce a log-off.            |
    |     # For dialup connect |
    | ion, of course.          |
    |                          |
    |     # Script should be r |
    | un as root user.         |
    |                          |
    |     SERPORT=ttyS3        |
    |     #  Depending on the  |
    | hardware and even the ke |
    | rnel version,            |
    |     #+ the modem port on |
    |  your machine may be dif |
    | ferent --                |
    |     #+ /dev/ttyS1 or /de |
    | v/ttyS2.                 |
    |                          |
    |                          |
    |     killppp="eval kill - |
    | 9 `ps ax | awk '/ppp/ {  |
    | print $1 }'`"            |
    |     #                    |
    |   -------- process ID of |
    |  ppp -------             |
    |                          |
    |     $killppp             |
    |          # This variable |
    |  is now a command.       |
    |                          |
    |                          |
    |     # The following oper |
    | ations must be done as r |
    | oot user.                |
    |                          |
    |     chmod 666 /dev/$SERP |
    | ORT      # Restore r+w p |
    | ermissions, or else what |
    | ?                        |
    |     #  Since doing a SIG |
    | KILL on ppp changed the  |
    | permissions on the seria |
    | l port,                  |
    |     #+ we restore permis |
    | sions to previous state. |
    |                          |
    |     rm /var/lock/LCK..$S |
    | ERPORT   # Remove the se |
    | rial port lock file. Why |
    | ?                        |
    |                          |
    |     exit $?              |
    |                          |
    |     # Exercises:         |
    |     # ---------          |
    |     # 1) Have script che |
    | ck whether root user is  |
    | invoking it.             |
    |     # 2) Do a check on w |
    | hether the process to be |
    |  killed                  |
    |     #+   is actually run |
    | ning before attempting t |
    | o kill it.               |
    |     # 3) Write an altern |
    | ate version of this scri |
    | pt based on 'fuser':     |
    |     #+      if [ fuser - |
    | s /dev/modem ]; then . . |
    |  .                       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-15. A version of *rot13***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # A version of "rot1 |
    | 3" using 'eval'.         |
    |     # Compare to "rot13. |
    | sh" example.             |
    |                          |
    |     setvar_rot_13()      |
    |          # "rot13" scram |
    | bling                    |
    |     {                    |
    |       local varname=$1 v |
    | arvalue=$2               |
    |       eval $varname='$(e |
    | cho "$varvalue" | tr a-z |
    |  n-za-m)'                |
    |     }                    |
    |                          |
    |                          |
    |     setvar_rot_13 var "f |
    | oobar"   # Run "foobar"  |
    | through rot13.           |
    |     echo $var            |
    |          # sbbone        |
    |                          |
    |     setvar_rot_13 var "$ |
    | var"     # Run "sbbone"  |
    | through rot13.           |
    |                          |
    |          # Back to origi |
    | nal variable.            |
    |     echo $var            |
    |          # foobar        |
    |                          |
    |     # This example by St |
    | ephane Chazelas.         |
    |     # Modified by docume |
    | nt author.               |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Here is another example of using *eval* to *evaluate* a complex
    expression, this one from an earlier version of YongYe's `Tetris
    game
    script <https://github.com/yongye/shell/blob/master/Tetris_Game.sh>`__.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     eval ${1}+=\"${x} ${ |
    | y} \"                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    `Example A-53 <contributed-scripts.html#SAMORSE>`__ uses *eval* to
    convert `array <arrays.html#ARRAYREF>`__ elements into a command
    list.

    The *eval* command occurs in the older version of `indirect
    referencing <ivr.html#IVRREF>`__.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     eval var=\$$var      |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="TIP">

    +--------------------------------------+--------------------------------------+
    | |Tip|                                |
    | The *eval* command can be used to    |
    | `parameterize *brace                 |
    | expansion* <bashver3.html#BRACEEXPRE |
    | F3>`__.                              |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | The **eval** command can be risky,   |
    | and normally should be avoided when  |
    | there exists a reasonable            |
    | alternative. An                      |
    | ``eval           $COMMANDS``         |
    | executes the contents of             |
    | ``COMMANDS``, which may contain such |
    | unpleasant surprises as **rm -rf     |
    | \***. Running an **eval** on         |
    | unfamiliar code written by persons   |
    | unknown is living dangerously.       |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

\ **set**
    The **set** command changes the value of internal script
    variables/options. One use for this is to toggle `option
    flags <options.html#OPTIONSREF>`__ which help determine the behavior
    of the script. Another application for it is to reset the
    `positional parameters <internalvariables.html#POSPARAMREF>`__ that
    a script sees as the result of a command
    (``set           `command```). The script can then parse the
    `fields <special-chars.html#FIELDREF>`__ of the command output.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-16. Using *set* with positional parameters**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # ex34.sh            |
    |     # Script "set-test"  |
    |                          |
    |     # Invoke this script |
    |  with three command-line |
    |  parameters,             |
    |     # for example, "sh e |
    | x34.sh one two three".   |
    |                          |
    |     echo                 |
    |     echo "Positional par |
    | ameters before  set \`un |
    | ame -a\` :"              |
    |     echo "Command-line a |
    | rgument #1 = $1"         |
    |     echo "Command-line a |
    | rgument #2 = $2"         |
    |     echo "Command-line a |
    | rgument #3 = $3"         |
    |                          |
    |                          |
    |     set `uname -a` # Set |
    | s the positional paramet |
    | ers to the output        |
    |                    # of  |
    | the command `uname -a`   |
    |                          |
    |     echo                 |
    |     echo +++++           |
    |     echo $_        # +++ |
    | ++                       |
    |     # Flags set in scrip |
    | t.                       |
    |     echo $-        # hB  |
    |     #                Ano |
    | malous behavior?         |
    |     echo                 |
    |                          |
    |     echo "Positional par |
    | ameters after  set \`una |
    | me -a\` :"               |
    |     # $1, $2, $3, etc. r |
    | einitialized to result o |
    | f `uname -a`             |
    |     echo "Field #1 of 'u |
    | name -a' = $1"           |
    |     echo "Field #2 of 'u |
    | name -a' = $2"           |
    |     echo "Field #3 of 'u |
    | name -a' = $3"           |
    |     echo \#\#\#          |
    |     echo $_        # ### |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    More fun with positional parameters.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-17. Reversing the positional parameters**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # revposparams.sh: R |
    | everse positional parame |
    | ters.                    |
    |     # Script by Dan Jaco |
    | bson, with stylistic rev |
    | isions by document autho |
    | r.                       |
    |                          |
    |                          |
    |     set a\ b c d\ e;     |
    |     #     ^      ^     S |
    | paces escaped            |
    |     #       ^ ^        S |
    | paces not escaped        |
    |     OIFS=$IFS; IFS=:;    |
    |     #              ^   S |
    | aving old IFS and settin |
    | g new one.               |
    |                          |
    |     echo                 |
    |                          |
    |     until [ $# -eq 0 ]   |
    |     do          #      S |
    | tep through positional p |
    | arameters.               |
    |       echo "### k0 = "$k |
    | ""     # Before          |
    |       k=$1:$k;  #      A |
    | ppend each pos param to  |
    | loop variable.           |
    |     #     ^              |
    |       echo "### k = "$k" |
    | "      # After           |
    |       echo               |
    |       shift;             |
    |     done                 |
    |                          |
    |     set $k  #  Set new p |
    | ositional parameters.    |
    |     echo -               |
    |     echo $# #  Count of  |
    | positional parameters.   |
    |     echo -               |
    |     echo                 |
    |                          |
    |     for i   #  Omitting  |
    | the "in list" sets the v |
    | ariable -- i --          |
    |             #+ to the po |
    | sitional parameters.     |
    |     do                   |
    |       echo $i  # Display |
    |  new positional paramete |
    | rs.                      |
    |     done                 |
    |                          |
    |     IFS=$OIFS  # Restore |
    |  IFS.                    |
    |                          |
    |     #  Question:         |
    |     #  Is it necessary t |
    | o set an new IFS, intern |
    | al field separator,      |
    |     #+ in order for this |
    |  script to work properly |
    | ?                        |
    |     #  What happens if y |
    | ou don't? Try it.        |
    |     #  And, why use the  |
    | new IFS -- a colon -- in |
    |  line 17,                |
    |     #+ to append to the  |
    | loop variable?           |
    |     #  What is the purpo |
    | se of this?              |
    |                          |
    |     exit 0               |
    |                          |
    |     $ ./revposparams.sh  |
    |                          |
    |     ### k0 =             |
    |     ### k = a b          |
    |                          |
    |     ### k0 = a b         |
    |     ### k = c a b        |
    |                          |
    |     ### k0 = c a b       |
    |     ### k = d e c a b    |
    |                          |
    |     -                    |
    |     3                    |
    |     -                    |
    |                          |
    |     d e                  |
    |     c                    |
    |     a b                  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Invoking **set** without any options or arguments simply lists all
    the `environmental <othertypesv.html#ENVREF>`__ and other variables
    that have been initialized.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ set            |
    |     AUTHORCOPY=/home/boz |
    | o/posts                  |
    |      BASH=/bin/bash      |
    |      BASH_VERSION=$'2.05 |
    | .8(1)-release'           |
    |      ...                 |
    |      XAUTHORITY=/home/bo |
    | zo/.Xauthority           |
    |      _=/etc/bashrc       |
    |      variable22=abc      |
    |      variable23=xzy      |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Using **set** with the ``--`` option explicitly assigns the contents
    of a variable to the positional parameters. If no variable follows
    the ``--`` it *unsets* the positional parameters.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-18. Reassigning the positional parameters**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     variable="one two th |
    | ree four five"           |
    |                          |
    |     set -- $variable     |
    |     # Sets positional pa |
    | rameters to the contents |
    |  of "$variable".         |
    |                          |
    |     first_param=$1       |
    |     second_param=$2      |
    |     shift; shift         |
    | # Shift past first two p |
    | ositional params.        |
    |     # shift 2            |
    |   also works.            |
    |     remaining_params="$* |
    | "                        |
    |                          |
    |     echo                 |
    |     echo "first paramete |
    | r = $first_param"        |
    |       # one              |
    |     echo "second paramet |
    | er = $second_param"      |
    |       # two              |
    |     echo "remaining para |
    | meters = $remaining_para |
    | ms"   # three four five  |
    |                          |
    |     echo; echo           |
    |                          |
    |     # Again.             |
    |     set -- $variable     |
    |     first_param=$1       |
    |     second_param=$2      |
    |     echo "first paramete |
    | r = $first_param"        |
    |       # one              |
    |     echo "second paramet |
    | er = $second_param"      |
    |       # two              |
    |                          |
    |     # ================== |
    | ======================== |
    | ============             |
    |                          |
    |     set --               |
    |     # Unsets positional  |
    | parameters if no variabl |
    | e specified.             |
    |                          |
    |     first_param=$1       |
    |     second_param=$2      |
    |     echo "first paramete |
    | r = $first_param"        |
    |       # (null value)     |
    |     echo "second paramet |
    | er = $second_param"      |
    |       # (null value)     |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example 11-2 <loops1.html#EX22A>`__ and `Example
    16-56 <extmisc.html#EX33A>`__.

\ **unset**
    The **unset** command deletes a shell variable, effectively setting
    it to *null*. Note that this command does not affect positional
    parameters.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ unset PATH     |
    |                          |
    |     bash$ echo $PATH     |
    |                         |
    |     bash$                |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-19. "Unsetting" a variable**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # unset.sh: Unsettin |
    | g a variable.            |
    |                          |
    |     variable=hello       |
    |                  #  Init |
    | ialized.                 |
    |     echo "variable = $va |
    | riable"                  |
    |                          |
    |     unset variable       |
    |                  #  Unse |
    | t.                       |
    |                          |
    |                  #  In t |
    | his particular context,  |
    |                          |
    |                  #+ same |
    |  effect as:   variable=  |
    |     echo "(unset) variab |
    | le = $variable"  #  $var |
    | iable is null.           |
    |                          |
    |     if [ -z "$variable"  |
    | ]                #  Try  |
    | a string-length test.    |
    |     then                 |
    |       echo "\$variable h |
    | as zero length."         |
    |     fi                   |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | In most contexts, an *undeclared*    |
    | variable and one that has been       |
    | *unset* are equivalent. However, the |
    | `${parameter:-default} <parameter-su |
    | bstitution.html#UNDDR>`__            |
    | parameter substitution construct can |
    | distinguish between the two.         |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

\ **export**
    The **export** `[4] <internal.html#FTN.AEN9199>`__ command makes
    available variables to all child processes of the running script or
    shell. One important use of the **export** command is in `startup
    files <files.html#FILESREF1>`__, to initialize and make accessible
    `environmental variables <othertypesv.html#ENVREF>`__ to subsequent
    user processes.

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | Unfortunately, `there is no way to   |
    | export variables back to the parent  |
    | process <gotchas.html#PARCHILDPROBRE |
    | F>`__,                               |
    | to the process that called or        |
    | invoked the script or shell.         |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-20. Using *export* to pass a variable to an embedded
    *awk* script**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     #  Yet another versi |
    | on of the "column totale |
    | r" script (col-totaler.s |
    | h)                       |
    |     #+ that adds up a sp |
    | ecified column (of numbe |
    | rs) in the target file.  |
    |     #  This uses the env |
    | ironment to pass a scrip |
    | t variable to 'awk' . .  |
    | .                        |
    |     #+ and places the aw |
    | k script in a variable.  |
    |                          |
    |                          |
    |     ARGS=2               |
    |     E_WRONGARGS=85       |
    |                          |
    |     if [ $# -ne "$ARGS"  |
    | ] # Check for proper num |
    | ber of command-line args |
    | .                        |
    |     then                 |
    |        echo "Usage: `bas |
    | ename $0` filename colum |
    | n-number"                |
    |        exit $E_WRONGARGS |
    |     fi                   |
    |                          |
    |     filename=$1          |
    |     column_number=$2     |
    |                          |
    |     #===== Same as origi |
    | nal script, up to this p |
    | oint =====#              |
    |                          |
    |     export column_number |
    |     # Export column numb |
    | er to environment, so it |
    | 's available for retriev |
    | al.                      |
    |                          |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | -----                    |
    |     awkscript='{ total + |
    | = $ENVIRON["column_numbe |
    | r"] }                    |
    |     END { print total }' |
    |     # Yes, a variable ca |
    | n hold an awk script.    |
    |     # ------------------ |
    | ------------------------ |
    | -----                    |
    |                          |
    |     # Now, run the awk s |
    | cript.                   |
    |     awk "$awkscript" "$f |
    | ilename"                 |
    |                          |
    |     # Thanks, Stephane C |
    | hazelas.                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="TIP">

    +--------------+--------------+--------------+--------------+--------------+--------------+
    | |Tip|        |
    | It is        |
    | possible to  |
    | initialize   |
    | and export   |
    | variables in |
    | the same     |
    | operation,   |
    | as in        |
    | **export     |
    | var1=xxx**.  |
    |              |
    | However, as  |
    | Greg         |
    | Keraunen     |
    | points out,  |
    | in certain   |
    | situations   |
    | this may     |
    | have a       |
    | different    |
    | effect than  |
    | setting a    |
    | variable,    |
    | then         |
    | exporting    |
    | it.          |
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
    | export var=( |
    | a  |         |
    | | b); echo $ |
    | {var[0]}     |
    |    |         |
    | |     (a b)  |
    |              |
    |    |         |
    | |            |
    |              |
    |    |         |
    | |            |
    |              |
    |    |         |
    | |            |
    |              |
    |    |         |
    | |     bash$  |
    | var=(a b); e |
    | xp |         |
    | | ort var; e |
    | cho ${var[0] |
    | }  |         |
    | |     a      |
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
    | .. raw:: htm |
    | l            |
    |              |
    |    </p>      |
                  
    +--------------+--------------+--------------+--------------+--------------+--------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | A variable to be exported may        |
    | require special treatment. See       |
    | `Example                             |
    | M-2 <sample-bashrc.html#BASHPROF>`__ |
    | .                                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

\ **declare**, **typeset**
    The `declare <declareref.html>`__ and `typeset <declareref.html>`__
    commands specify and/or restrict properties of variables.

\ **readonly**
    Same as `declare -r <declareref.html>`__, sets a variable as
    read-only, or, in effect, as a constant. Attempts to change the
    variable fail with an error message. This is the shell analog of the
    *C* language **const** type qualifier.

\ **getopts**
    This powerful tool parses command-line arguments passed to the
    script. This is the Bash analog of the
    `getopt <extmisc.html#GETOPTY>`__ external command and the *getopt*
    library function familiar to *C* programmers. It permits passing and
    concatenating multiple options `[5] <internal.html#FTN.AEN9289>`__
    and associated arguments to a script (for example
    ``scriptname -abc -e           /usr/local``).

    The **getopts** construct uses two implicit variables. ``$OPTIND``
    is the argument pointer (*OPTion INDex*) and ``$OPTARG`` (*OPTion
    ARGument*) the (optional) argument attached to an option. A colon
    following the option name in the declaration tags that option as
    having an associated argument.

    A **getopts** construct usually comes packaged in a `while
    loop <loops1.html#WHILELOOPREF>`__, which processes the options and
    arguments one at a time, then increments the implicit ``$OPTIND``
    variable to point to the next.

    .. raw:: html

       <div class="NOTE">

    +----------------+----------------+----------------+----------------+----------------+
    | |Note|         |
    |                |
    | #. The         |
    |    arguments   |
    |    passed from |
    |    the         |
    |    command-lin |
    | e              |
    |    to the      |
    |    script must |
    |    be preceded |
    |    by a dash   |
    |    (``-``). It |
    |    is the      |
    |    prefixed    |
    |    ``-`` that  |
    |    lets        |
    |    **getopts** |
    |    recognize   |
    |    command-lin |
    | e              |
    |    arguments   |
    |    as          |
    |    *options*.  |
    |    In fact,    |
    |    **getopts** |
    |    will not    |
    |    process     |
    |    arguments   |
    |    without the |
    |    prefixed    |
    |    ``-``, and  |
    |    will        |
    |    terminate   |
    |    option      |
    |    processing  |
    |    at the      |
    |    first       |
    |    argument    |
    |    encountered |
    |    lacking     |
    |    them.       |
    |                |
    | #. The         |
    |    **getopts** |
    |    template    |
    |    differs     |
    |    slightly    |
    |    from the    |
    |    standard    |
    |    `while      |
    |    loop <loops |
    | 1.html#WHILELO |
    | OPREF>`__,     |
    |    in that it  |
    |    lacks       |
    |    condition   |
    |    brackets.   |
    |                |
    | #. The         |
    |    **getopts** |
    |    construct   |
    |    is a highly |
    |    functional  |
    |    replacement |
    |    for the     |
    |    traditional |
    |    `getopt <ex |
    | tmisc.html#GET |
    | OPTY>`__       |
    |    external    |
    |    command.    |
    |                |
    | .. raw:: html  |
    |                |
    |    </p>        |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     while getopts ":abcd |
    | e:fg" Option             |
    |     # Initial declaratio |
    | n.                       |
    |     # a, b, c, d, e, f,  |
    | and g are the options (f |
    | lags) expected.          |
    |     # The : after option |
    |  'e' shows it will have  |
    | an argument passed with  |
    | it.                      |
    |     do                   |
    |       case $Option in    |
    |         a ) # Do somethi |
    | ng with variable 'a'.    |
    |         b ) # Do somethi |
    | ng with variable 'b'.    |
    |         ...              |
    |         e)  # Do somethi |
    | ng with 'e', and also wi |
    | th $OPTARG,              |
    |             # which is t |
    | he associated argument p |
    | assed with option 'e'.   |
    |         ...              |
    |         g ) # Do somethi |
    | ng with variable 'g'.    |
    |       esac               |
    |     done                 |
    |     shift $(($OPTIND - 1 |
    | ))                       |
    |     # Move argument poin |
    | ter to next.             |
    |                          |
    |     # All this is not ne |
    | arly as complicated as i |
    | t looks <grin>.          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-21. Using *getopts* to read the options/arguments
    passed to a script**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # ex33.sh: Exercisin |
    | g getopts and OPTIND     |
    |     #          Script mo |
    | dified 10/09/03 at the s |
    | uggestion of Bill Gradwo |
    | hl.                      |
    |                          |
    |                          |
    |     # Here we observe ho |
    | w 'getopts' processes co |
    | mmand-line arguments to  |
    | script.                  |
    |     # The arguments are  |
    | parsed as "options" (fla |
    | gs) and associated argum |
    | ents.                    |
    |                          |
    |     # Try invoking this  |
    | script with:             |
    |     #   'scriptname -mn' |
    |     #   'scriptname -oq  |
    | qOption' (qOption can be |
    |  some arbitrary string.) |
    |     #   'scriptname -qXX |
    | X -r'                    |
    |     #                    |
    |     #   'scriptname -qr' |
    |     #+      - Unexpected |
    |  result, takes "r" as th |
    | e argument to option "q" |
    |     #   'scriptname -q - |
    | r'                       |
    |     #+      - Unexpected |
    |  result, same as above   |
    |     #   'scriptname -mno |
    | p -mnop'  - Unexpected r |
    | esult                    |
    |     #   (OPTIND is unrel |
    | iable at stating where a |
    | n option came from.)     |
    |     #                    |
    |     #  If an option expe |
    | cts an argument ("flag:" |
    | ), then it will grab     |
    |     #+ whatever is next  |
    | on the command-line.     |
    |                          |
    |     NO_ARGS=0            |
    |     E_OPTERROR=85        |
    |                          |
    |     if [ $# -eq "$NO_ARG |
    | S" ]    # Script invoked |
    |  with no command-line ar |
    | gs?                      |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` options (-mnopq |
    | rs)"                     |
    |       exit $E_OPTERROR   |
    |         # Exit and expla |
    | in usage.                |
    |                          |
    |         # Usage: scriptn |
    | ame -options             |
    |                          |
    |         # Note: dash (-) |
    |  necessary               |
    |     fi                   |
    |                          |
    |                          |
    |     while getopts ":mnop |
    | q:rs" Option             |
    |     do                   |
    |       case $Option in    |
    |         m     ) echo "Sc |
    | enario #1: option -m-    |
    | [OPTIND=${OPTIND}]";;    |
    |         n | o ) echo "Sc |
    | enario #2: option -$Opti |
    | on-   [OPTIND=${OPTIND}] |
    | ";;                      |
    |         p     ) echo "Sc |
    | enario #3: option -p-    |
    | [OPTIND=${OPTIND}]";;    |
    |         q     ) echo "Sc |
    | enario #4: option -q-\   |
    |                       wi |
    | th argument \"$OPTARG\"  |
    |   [OPTIND=${OPTIND}]";;  |
    |         #  Note that opt |
    | ion 'q' must have an ass |
    | ociated argument,        |
    |         #+ otherwise it  |
    | falls through to the def |
    | ault.                    |
    |         r | s ) echo "Sc |
    | enario #5: option -$Opti |
    | on-";;                   |
    |         *     ) echo "Un |
    | implemented option chose |
    | n.";;   # Default.       |
    |       esac               |
    |     done                 |
    |                          |
    |     shift $(($OPTIND - 1 |
    | ))                       |
    |     #  Decrements the ar |
    | gument pointer so it poi |
    | nts to next argument.    |
    |     #  $1 now references |
    |  the first non-option it |
    | em supplied on the comma |
    | nd-line                  |
    |     #+ if one exists.    |
    |                          |
    |     exit $?              |
    |                          |
    |     #   As Bill Gradwohl |
    |  states,                 |
    |     #  "The getopts mech |
    | anism allows one to spec |
    | ify:  scriptname -mnop - |
    | mnop                     |
    |     #+  but there is no  |
    | reliable way to differen |
    | tiate what came          |
    |     #+ from where by usi |
    | ng OPTIND."              |
    |     #  There are, howeve |
    | r, workarounds.          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Script Behavior**

\ **source**, . (`dot <special-chars.html#DOTREF>`__ command)
    This command, when invoked from the command-line, executes a script.
    Within a script, a ``source file-name`` loads the file
    ``file-name``. *Sourcing* a file (dot-command) *imports* code into
    the script, appending to the script (same effect as the ``#include``
    directive in a *C* program). The net result is the same as if the
    "sourced" lines of code were physically present in the body of the
    script. This is useful in situations when multiple scripts use a
    common data file or function library.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-22. "Including" a data file**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     #  Note that this ex |
    | ample must be invoked wi |
    | th bash, i.e., bash ex38 |
    | .sh                      |
    |     #+ not  sh ex38.sh ! |
    |                          |
    |     . data-file    # Loa |
    | d a data file.           |
    |     # Same effect as "so |
    | urce data-file", but mor |
    | e portable.              |
    |                          |
    |     #  The file "data-fi |
    | le" must be present in c |
    | urrent working directory |
    | ,                        |
    |     #+ since it is refer |
    | red to by its basename.  |
    |                          |
    |     # Now, let's referen |
    | ce some data from that f |
    | ile.                     |
    |                          |
    |     echo "variable1 (fro |
    | m data-file) = $variable |
    | 1"                       |
    |     echo "variable3 (fro |
    | m data-file) = $variable |
    | 3"                       |
    |                          |
    |     let "sum = $variable |
    | 2 + $variable4"          |
    |     echo "Sum of variabl |
    | e2 + variable4 (from dat |
    | a-file) = $sum"          |
    |     echo "message1 (from |
    |  data-file) is \"$messag |
    | e1\""                    |
    |     #                    |
    |                Escaped q |
    | uotes                    |
    |     echo "message2 (from |
    |  data-file) is \"$messag |
    | e2\""                    |
    |                          |
    |     print_message This i |
    | s the message-print func |
    | tion in the data-file.   |
    |                          |
    |                          |
    |     exit $?              |
                              
    +--------------------------+--------------------------+--------------------------+

    File ``data-file`` for `Example 15-22 <internal.html#EX38>`__,
    above. Must be present in same directory.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # This is a data fil |
    | e loaded by a script.    |
    |     # Files of this type |
    |  may contain variables,  |
    | functions, etc.          |
    |     # It loads with a 's |
    | ource' or '.' command fr |
    | om a shell script.       |
    |                          |
    |     # Let's initialize s |
    | ome variables.           |
    |                          |
    |     variable1=23         |
    |     variable2=474        |
    |     variable3=5          |
    |     variable4=97         |
    |                          |
    |     message1="Greetings  |
    | from *** line $LINENO ** |
    | * of the data file!"     |
    |     message2="Enough for |
    |  now. Goodbye."          |
    |                          |
    |     print_message ()     |
    |     {   # Echoes any mes |
    | sage passed to it.       |
    |                          |
    |       if [ -z "$1" ]     |
    |       then               |
    |         return 1 # Error |
    | , if argument missing.   |
    |       fi                 |
    |                          |
    |       echo               |
    |                          |
    |       until [ -z "$1" ]  |
    |       do             # S |
    | tep through arguments pa |
    | ssed to function.        |
    |         echo -n "$1" # E |
    | cho args one at a time,  |
    | suppressing line feeds.  |
    |         echo -n " "  # I |
    | nsert spaces between wor |
    | ds.                      |
    |         shift        # N |
    | ext one.                 |
    |       done               |
    |                          |
    |       echo               |
    |                          |
    |       return 0           |
    |     }                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    If the *sourced* file is itself an executable script, then it will
    run, then return control to the script that called it. A *sourced*
    executable script may use a `return <complexfunct.html#RETURNREF>`__
    for this purpose.

    Arguments may be (optionally) passed to the *sourced* file as
    `positional parameters <othertypesv.html#POSPARAMREF1>`__.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     source $filename $ar |
    | g1 arg2                  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    It is even possible for a script to *source* itself, though this
    does not seem to have any practical applications.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-23. A (useless) script that sources itself**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # self-source.sh: a  |
    | script sourcing itself " |
    | recursively."            |
    |     # From "Stupid Scrip |
    | t Tricks," Volume II.    |
    |                          |
    |     MAXPASSCNT=100    #  |
    | Maximum number of execut |
    | ion passes.              |
    |                          |
    |     echo -n  "$pass_coun |
    | t  "                     |
    |     #  At first executio |
    | n pass, this just echoes |
    |  two blank spaces,       |
    |     #+ since $pass_count |
    |  still uninitialized.    |
    |                          |
    |     let "pass_count += 1 |
    | "                        |
    |     #  Assumes the unini |
    | tialized variable $pass_ |
    | count                    |
    |     #+ can be incremente |
    | d the first time around. |
    |     #  This works with B |
    | ash and pdksh, but       |
    |     #+ it relies on non- |
    | portable (and possibly d |
    | angerous) behavior.      |
    |     #  Better would be t |
    | o initialize $pass_count |
    |  to 0 before incrementin |
    | g.                       |
    |                          |
    |     while [ "$pass_count |
    | " -le $MAXPASSCNT ]      |
    |     do                   |
    |       . $0   # Script "s |
    | ources" itself, rather t |
    | han calling itself.      |
    |              # ./$0 (whi |
    | ch would be true recursi |
    | on) doesn't work here. W |
    | hy?                      |
    |     done                 |
    |                          |
    |     #  What occurs here  |
    | is not actually recursio |
    | n,                       |
    |     #+ since the script  |
    | effectively "expands" it |
    | self, i.e.,              |
    |     #+ generates a new s |
    | ection of code           |
    |     #+ with each pass th |
    | rough the 'while' loop', |
    |     #  with each 'source |
    | ' in line 20.            |
    |     #                    |
    |     #  Of course, the sc |
    | ript interprets each new |
    | ly 'sourced' "#!" line   |
    |     #+ as a comment, and |
    |  not as the start of a n |
    | ew script.               |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0   # The net e |
    | ffect is counting from 1 |
    |  to 100.                 |
    |              # Very impr |
    | essive.                  |
    |                          |
    |     # Exercise:          |
    |     # --------           |
    |     # Write a script tha |
    | t uses this trick to act |
    | ually do something usefu |
    | l.                       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

\ **exit**
    Unconditionally terminates a script.
    `[6] <internal.html#FTN.AEN9393>`__ The **exit** command may
    optionally take an integer argument, which is returned to the shell
    as the `exit status <exit-status.html#EXITSTATUSREF>`__ of the
    script. It is good practice to end all but the simplest scripts with
    an ``exit 0``, indicating a successful run.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | If a script terminates with an       |
    | **exit** lacking an argument, the    |
    | exit status of the script is the     |
    | exit status of the last command      |
    | executed in the script, not counting |
    | the **exit**. This is equivalent to  |
    | an **exit $?**.                      |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | An **exit** command may also be used |
    | to terminate a                       |
    | `subshell <subshells.html#SUBSHELLSR |
    | EF>`__.                              |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

\ **exec**
    This shell builtin replaces the current process with a specified
    command. Normally, when the shell encounters a command, it `forks
    off <internal.html#FORKREF>`__ a child process to actually execute
    the command. Using the **exec** builtin, the shell does not fork,
    and the command *exec*'ed replaces the shell. When used in a script,
    therefore, it forces an exit from the script when the **exec**'ed
    command terminates. `[7] <internal.html#FTN.AEN9425>`__

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-24. Effects of *exec***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     exec echo "Exiting \ |
    | "$0\" at line $LINENO."  |
    |   # Exit from script her |
    | e.                       |
    |     # $LINENO is an inte |
    | rnal Bash variable set t |
    | o the line number it's o |
    | n.                       |
    |                          |
    |     # ------------------ |
    | ----------------         |
    |     # The following line |
    | s never execute.         |
    |                          |
    |     echo "This echo fail |
    | s to echo."              |
    |                          |
    |     exit 99              |
    |           #  This script |
    |  will not exit here.     |
    |                          |
    |           #  Check exit  |
    | value after script termi |
    | nates                    |
    |                          |
    |           #+ with an 'ec |
    | ho $?'.                  |
    |                          |
    |           #  It will *no |
    | t* be 99.                |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 15-25. A script that *exec's* itself**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # self-exec.sh       |
    |                          |
    |     # Note: Set permissi |
    | ons on this script to 55 |
    | 5 or 755,                |
    |     #       then call it |
    |  with ./self-exec.sh or  |
    | sh ./self-exec.sh.       |
    |                          |
    |     echo                 |
    |                          |
    |     echo "This line appe |
    | ars ONCE in the script,  |
    | yet it keeps echoing."   |
    |     echo "The PID of thi |
    | s instance of the script |
    |  is still $$."           |
    |     #     Demonstrates t |
    | hat a subshell is not fo |
    | rked off.                |
    |                          |
    |     echo "============== |
    | ====== Hit Ctl-C to exit |
    |  ===================="   |
    |                          |
    |     sleep 1              |
    |                          |
    |     exec $0   #  Spawns  |
    | another instance of this |
    |  same script             |
    |               #+ that re |
    | places the previous one. |
    |                          |
    |     echo "This line will |
    |  never echo!"  # Why not |
    | ?                        |
    |                          |
    |     exit 99              |
    |                # Will no |
    | t exit here!             |
    |                          |
    |                # Exit co |
    | de will not be 99!       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    An **exec** also serves to `reassign file
    descriptors <x17974.html#USINGEXECREF>`__. For example,
    ``exec           <zzz-file`` replaces ``stdin`` with the file
    ``zzz-file``.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The ``-exec`` option to              |
    | `find <moreadv.html#FINDREF>`__ is   |
    | ``not`` the same as the **exec**     |
    | shell builtin.                       |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

\ **shopt**
    This command permits changing *shell options* on the fly (see
    `Example 25-1 <aliases.html#AL>`__ and `Example
    25-2 <aliases.html#UNAL>`__). It often appears in the Bash `startup
    files <files.html#FILESREF1>`__, but also has its uses in scripts.
    Needs `version 2 <bashver2.html#BASH2REF>`__ or later of Bash.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     shopt -s cdspell     |
    |     # Allows minor missp |
    | elling of directory name |
    | s with 'cd'              |
    |     # Option -s sets, -u |
    |  unsets.                 |
    |                          |
    |     cd /hpme  # Oops! Mi |
    | styped '/home'.          |
    |     pwd       # /home    |
    |               # The shel |
    | l corrected the misspell |
    | ing.                     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

**caller**\ 
    Putting a **caller** command inside a
    `function <functions.html#FUNCTIONREF>`__ echoes to ``stdout``
    information about the *caller* of that function.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     function1 ()         |
    |     {                    |
    |       # Inside function1 |
    |  ().                     |
    |       caller 0   # Tell  |
    | me about it.             |
    |     }                    |
    |                          |
    |     function1    # Line  |
    | 9 of script.             |
    |                          |
    |     # 9 main test.sh     |
    |     # ^                  |
    | Line number that the fun |
    | ction was called from.   |
    |     #   ^^^^             |
    | Invoked from "main" part |
    |  of script.              |
    |     #        ^^^^^^^     |
    | Name of calling script.  |
    |                          |
    |     caller 0     # Has n |
    | o effect because it's no |
    | t inside a function.     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    A **caller** command can also return *caller* information from a
    script `sourced <internal.html#SOURCEREF>`__ within another script.
    Analogous to a function, this is a "subroutine call."

    You may find this command useful in debugging.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Commands**

\ **true**
    A command that returns a successful (zero) `exit
    status <exit-status.html#EXITSTATUSREF>`__, but does nothing else.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ true           |
    |     bash$ echo $?        |
    |     0                    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Endless loop       |
    |     while true   # alias |
    |  for ":"                 |
    |     do                   |
    |        operation-1       |
    |        operation-2       |
    |        ...               |
    |        operation-n       |
    |        # Need a way to b |
    | reak out of loop or scri |
    | pt will hang.            |
    |     done                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

\ **false**
    A command that returns an unsuccessful `exit
    status <exit-status.html#EXITSTATUSREF>`__, but does nothing else.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ false          |
    |     bash$ echo $?        |
    |     1                    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Testing "false"    |
    |     if false             |
    |     then                 |
    |       echo "false evalua |
    | tes \"true\""            |
    |     else                 |
    |       echo "false evalua |
    | tes \"false\""           |
    |     fi                   |
    |     # false evaluates "f |
    | alse"                    |
    |                          |
    |                          |
    |     # Looping while "fal |
    | se" (null loop)          |
    |     while false          |
    |     do                   |
    |        # The following c |
    | ode will not execute.    |
    |        operation-1       |
    |        operation-2       |
    |        ...               |
    |        operation-n       |
    |        # Nothing happens |
    | !                        |
    |     done                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

\ **type [cmd]**
    Similar to the `which <filearchiv.html#WHICHREF>`__ external
    command, **type cmd** identifies "cmd." Unlike **which**, **type**
    is a Bash builtin. The useful ``-a`` option to **type** identifies
    ``keywords`` and ``builtins``, and also locates system commands with
    identical names.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ type '['       |
    |     [ is a shell builtin |
    |     bash$ type -a '['    |
    |     [ is a shell builtin |
    |      [ is /usr/bin/[     |
    |                          |
    |                          |
    |     bash$ type type      |
    |     type is a shell buil |
    | tin                      |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The **type** command can be useful for `testing whether a certain
    command exists <special-chars.html#DEVNULLREDIRECT>`__.

\ **hash [cmds]**
    Records the *path* name of specified commands -- in the shell *hash
    table* `[8] <internal.html#FTN.AEN9591>`__ -- so the shell or script
    will not need to search the
    `$PATH <internalvariables.html#PATHREF>`__ on subsequent calls to
    those commands. When **hash** is called with no arguments, it simply
    lists the commands that have been hashed. The ``-r`` option resets
    the hash table.

\ **bind**
    The **bind** builtin displays or modifies *readline*
    `[9] <internal.html#FTN.AEN9621>`__ key bindings.

\ **help**
    Gets a short usage summary of a shell builtin. This is the
    counterpart to `whatis <filearchiv.html#WHATISREF>`__, but for
    builtins. The display of *help* information got a much-needed update
    in the `version 4 release <bashver4.html#BASH4REF>`__ of Bash.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ help exit      |
    |     exit: exit [n]       |
    |         Exit the shell w |
    | ith a status of N.  If N |
    |  is omitted, the exit st |
    | atus                     |
    |         is that of the l |
    | ast command executed.    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

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

`[1] <internal.html#AEN8607>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

As Nathan Coulter points out, "while forking a process is a low-cost
operation, executing a new program in the newly-forked child process
adds more overhead."

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[2] <internal.html#AEN8650>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

An exception to this is the `time <timedate.html#TIMREF>`__ command,
listed in the official Bash documentation as a keyword ("reserved
word").

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[3] <internal.html#AEN9009>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Note that *let* `cannot be used for setting *string*
variables. <gotchas.html#LETBAD>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[4] <internal.html#AEN9199>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

To *Export* information is to make it available in a more general
context. See also `scope <subshells.html#SCOPEREF>`__.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[5] <internal.html#AEN9289>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

An *option* is an argument that acts as a flag, switching script
behaviors on or off. The argument associated with a particular option
indicates the behavior that the option (flag) switches on or off.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[6] <internal.html#AEN9393>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Technically, an **exit** only terminates the process (or shell) in which
it is running, *not* the *parent process*.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[7] <internal.html#AEN9425>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Unless the **exec** is used to `reassign file
descriptors <x17974.html#USINGEXECREF>`__.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[8] <internal.html#AEN9591>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

*Hashing* is a method of creating lookup keys for data stored in a
table. The *data items themselves* are "scrambled" to create keys, using
one of a number of simple mathematical *algorithms* (methods, or
recipes).

An advantage of *hashing* is that it is fast. A disadvantage is that
*collisions* -- where a single key maps to more than one data item --
are possible.

For examples of hashing see `Example
A-20 <contributed-scripts.html#HASHLIB>`__ and `Example
A-21 <contributed-scripts.html#HASHEXAMPLE>`__.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[9] <internal.html#AEN9621>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

The *readline* library is what Bash uses for reading input in an
interactive shell.

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
| `Prev <part4.html>`__    | Commands                 |
| `Home <index.html>`__    | `Up <part4.html>`__      |
| `Next <x9644.html>`__    | Job Control Commands     |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Caution| image:: ../images/caution.gif
.. |Tip| image:: ../images/tip.gif
