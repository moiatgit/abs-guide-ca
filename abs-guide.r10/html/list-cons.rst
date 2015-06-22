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

`Prev <aliases.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <arrays.html>`__

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

Chapter 26. List Constructs
===========================

The *and list* and *or list* constructs provide a means of processing a
number of commands consecutively. These can effectively replace complex
nested `if/then <testconstructs.html#TESTCONSTRUCTS1>`__ or even
`case <testbranch.html#CASEESAC1>`__ statements.

.. raw:: html

   <div class="VARIABLELIST">

**Chaining together commands**

and list
    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     command-1 && command |
    | -2 && command-3 && ... c |
    | ommand-n                 |
                              
    +--------------------------+--------------------------+--------------------------+

    Each command executes in turn, provided that the previous command
    has given a return value of ``true`` (zero). At the first ``false``
    (non-zero) return, the command chain terminates (the first command
    returning ``false`` is the last one to execute).

    .. raw:: html

       </p>

    An interesting use of a two-condition *and list* from an early
    version of YongYe's `Tetris game
    script <http://bash.deta.in/Tetris_Game.sh>`__:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     equation()           |
    |                          |
    |     {  # core algorithm  |
    | used for doubling and ha |
    | lving the coordinates    |
    |        [[ ${cdx} ]] && ( |
    | (y=cy+(ccy-cdy)${2}2))   |
    |        eval ${1}+=\"${x} |
    |  ${y} \"                 |
    |     }                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 26-1. Using an *and list* to test for command-line
    arguments**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # and list           |
    |                          |
    |     if [ ! -z "$1" ] &&  |
    | echo "Argument #1 = $1"  |
    | && [ ! -z "$2" ] && \    |
    |     #                ^^  |
    |                          |
    | ^^               ^^      |
    |     echo "Argument #2 =  |
    | $2"                      |
    |     then                 |
    |       echo "At least 2 a |
    | rguments passed to scrip |
    | t."                      |
    |       # All the chained  |
    | commands return true.    |
    |     else                 |
    |       echo "Fewer than 2 |
    |  arguments passed to scr |
    | ipt."                    |
    |       # At least one of  |
    | the chained commands ret |
    | urns false.              |
    |     fi                   |
    |     # Note that "if [ !  |
    | -z $1 ]" works, but its  |
    | alleged equivalent,      |
    |     #   "if [ -n $1 ]" d |
    | oes not.                 |
    |     #     However, quoti |
    | ng fixes this.           |
    |     #  if "[ -n "$1" ]"  |
    | works.                   |
    |     #           ^  ^     |
    | Careful!                 |
    |     # It is always best  |
    | to QUOTE the variables b |
    | eing tested.             |
    |                          |
    |                          |
    |     # This accomplishes  |
    | the same thing, using "p |
    | ure" if/then statements. |
    |     if [ ! -z "$1" ]     |
    |     then                 |
    |       echo "Argument #1  |
    | = $1"                    |
    |     fi                   |
    |     if [ ! -z "$2" ]     |
    |     then                 |
    |       echo "Argument #2  |
    | = $2"                    |
    |       echo "At least 2 a |
    | rguments passed to scrip |
    | t."                      |
    |     else                 |
    |       echo "Fewer than 2 |
    |  arguments passed to scr |
    | ipt."                    |
    |     fi                   |
    |     # It's longer and mo |
    | re ponderous than using  |
    | an "and list".           |
    |                          |
    |                          |
    |     exit $?              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 26-2. Another command-line arg test using an *and list***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     ARGS=1        # Numb |
    | er of arguments expected |
    | .                        |
    |     E_BADARGS=85  # Exit |
    |  value if incorrect numb |
    | er of args passed.       |
    |                          |
    |     test $# -ne $ARGS && |
    |  \                       |
    |     #    ^^^^^^^^^^^^ co |
    | ndition #1               |
    |     echo "Usage: `basena |
    | me $0` $ARGS argument(s) |
    | " && exit $E_BADARGS     |
    |     #                    |
    |                          |
    |   ^^                     |
    |     #  If condition #1 t |
    | ests true (wrong number  |
    | of args passed to script |
    | ),                       |
    |     #+ then the rest of  |
    | the line executes, and s |
    | cript terminates.        |
    |                          |
    |     # Line below execute |
    | s only if the above test |
    |  fails.                  |
    |     echo "Correct number |
    |  of arguments passed to  |
    | this script."            |
    |                          |
    |     exit 0               |
    |                          |
    |     # To check exit valu |
    | e, do a "echo $?" after  |
    | script termination.      |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Of course, an *and list* can also *set* variables to a default
    value.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     arg1=$@ && [ -z "$ar |
    | g1" ] && arg1=DEFAULT    |
    |                          |
    |                   # Set  |
    | $arg1 to command-line ar |
    | guments, if any.         |
    |                   # But  |
    | . . . set to DEFAULT if  |
    | not specified on command |
    | -line.                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

or list
    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     command-1 || command |
    | -2 || command-3 || ... c |
    | ommand-n                 |
                              
    +--------------------------+--------------------------+--------------------------+

    Each command executes in turn for as long as the previous command
    returns false. At the first true return, the command chain
    terminates (the first command returning true is the last one to
    execute). This is obviously the inverse of the "and list".

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 26-3. Using *or lists* in combination with an *and list***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     #  delete.sh, a not- |
    | so-cunning file deletion |
    |  utility.                |
    |     #  Usage: delete fil |
    | ename                    |
    |                          |
    |     E_BADARGS=85         |
    |                          |
    |     if [ -z "$1" ]       |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` filename"       |
    |       exit $E_BADARGS  # |
    |  No arg? Bail out.       |
    |     else                 |
    |       file=$1          # |
    |  Set filename.           |
    |     fi                   |
    |                          |
    |                          |
    |     [ ! -f "$file" ] &&  |
    | echo "File \"$file\" not |
    |  found. \                |
    |     Cowardly refusing to |
    |  delete a nonexistent fi |
    | le."                     |
    |     # AND LIST, to give  |
    | error message if file no |
    | t present.               |
    |     # Note echo message  |
    | continuing on to a secon |
    | d line after an escape.  |
    |                          |
    |     [ ! -f "$file" ] ||  |
    | (rm -f $file; echo "File |
    |  \"$file\" deleted.")    |
    |     # OR LIST, to delete |
    |  file if present.        |
    |                          |
    |     # Note logic inversi |
    | on above.                |
    |     # AND LIST executes  |
    | on true, OR LIST on fals |
    | e.                       |
    |                          |
    |     exit $?              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | If the first command in an *or list* |
    | returns true, it ``will`` execute.   |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # ==> The following  |
| snippets from the /etc/r |
| c.d/init.d/single        |
|     #+==> script by Miqu |
| el van Smoorenburg       |
|     #+==> illustrate use |
|  of "and" and "or" lists |
| .                        |
|     # ==> "Arrowed" comm |
| ents added by document a |
| uthor.                   |
|                          |
|     [ -x /usr/bin/clear  |
| ] && /usr/bin/clear      |
|       # ==> If /usr/bin/ |
| clear exists, then invok |
| e it.                    |
|       # ==> Checking for |
|  the existence of a comm |
| and before calling it    |
|       #+==> avoids error |
|  messages and other awkw |
| ard consequences.        |
|                          |
|       # ==> . . .        |
|                          |
|     # If they want to ru |
| n something in single us |
| er mode, might as well r |
| un it...                 |
|     for i in /etc/rc1.d/ |
| S[0-9][0-9]* ; do        |
|             # Check if t |
| he script is there.      |
|             [ -x "$i" ]  |
| || continue              |
|       # ==> If correspon |
| ding file in $PWD *not*  |
| found,                   |
|       #+==> then "contin |
| ue" by jumping to the to |
| p of the loop.           |
|                          |
|             # Reject bac |
| kup files and files gene |
| rated by rpm.            |
|             case "$1" in |
|                     *.rp |
| msave|*.rpmorig|*.rpmnew |
| |*~|*.orig)              |
|                          |
|     continue;;           |
|             esac         |
|             [ "$i" = "/e |
| tc/rc1.d/S00single" ] && |
|  continue                |
|       # ==> Set script n |
| ame, but don't execute i |
| t yet.                   |
|             $i start     |
|     done                 |
|                          |
|       # ==> . . .        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="IMPORTANT">

+--------------------------------------+--------------------------------------+
| |Important|                          |
| The `exit                            |
| status <exit-status.html#EXITSTATUSR |
| EF>`__                               |
| of an ``and list`` or an ``or list`` |
| is the exit status of the last       |
| command executed.                    |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

Clever combinations of *and* and *or* lists are possible, but the logic
may easily become convoluted and require close attention to `operator
precedence rules <opprecedence.html#OPPRECEDENCE1>`__, and possibly
extensive debugging.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     false && true || ech |
| o false         # false  |
|                          |
|     # Same result as     |
|     ( false && true ) || |
|  echo false     # false  |
|     # But NOT            |
|     false && ( true || e |
| cho false )     # (nothi |
| ng echoed)               |
|                          |
|     #  Note left-to-righ |
| t grouping and evaluatio |
| n of statements.         |
|                          |
|     #  It's usually best |
|  to avoid such complexit |
| ies.                     |
|                          |
|     #  Thanks, S.C.      |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

See `Example A-7 <contributed-scripts.html#DAYSBETWEEN>`__ and `Example
7-4 <fto.html#BROKENLINK>`__ for illustrations of using
``and     / or list`` constructs to test variables.

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <aliases.html>`__  | Aliases                  |
| `Home <index.html>`__    | `Up <part5.html>`__      |
| `Next <arrays.html>`__   | Arrays                   |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Important| image:: ../images/important.gif
