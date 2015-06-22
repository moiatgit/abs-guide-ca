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

`Prev <untyped.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 4. Introduction to Variables and Parameters

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <quoting.html>`__

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

  4.4. Special Variable Types
============================

.. raw:: html

   <div class="VARIABLELIST">

 ``                 Local variables               ``
    Variables `visible <subshells.html#SCOPEREF>`__ only within a `code
    block <special-chars.html#CODEBLOCKREF>`__ or function (see also
    `local variables <localvar.html#LOCALREF>`__ in
    `functions <functions.html#FUNCTIONREF>`__ )

 ``                 Environmental variables               ``
    Variables that affect the behavior of the shell and user interface

    .. raw:: html

       <div class="NOTE">

    +--------------------------+--------------------------+--------------------------+
    | |Note|                   |
    | In a more general        |
    | context, each            |
    | `process <special-chars. |
    | html#PROCESSREF>`__      |
    | has an "environment" ,   |
    | that is, a group of      |
    | variables that the       |
    | process may reference.   |
    | In this sense, the shell |
    | behaves like any other   |
    | process.                 |
    |                          |
    | Every time a shell       |
    | starts, it creates shell |
    | variables that           |
    | correspond to its own    |
    | environmental variables. |
    | Updating or adding new   |
    | environmental variables  |
    | causes the shell to      |
    | update its environment,  |
    | and all the shell's      |
    | *child processes* (the   |
    | commands it executes)    |
    | inherit this             |
    | environment.             |
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +--------------+--------------+--------------+--------------+--------------+--------------+
    | |Caution|    |
    | The space    |
    | allotted to  |
    | the          |
    | environment  |
    | is limited.  |
    | Creating too |
    | many         |
    | environmenta |
    | l            |
    | variables or |
    | ones that    |
    | use up       |
    | excessive    |
    | space may    |
    | cause        |
    | problems.    |
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
    | eval "`seq 1 |
    | 00 |         |
    | | 00 | sed - |
    | e 's/.*/expo |
    | rt |         |
    | |  var&=ZZZZ |
    | ZZZZZZZZZZ/' |
    | `" |         |
    | |            |
    |              |
    |    |         |
    | |     bash$  |
    | du           |
    |    |         |
    | |     bash:  |
    | /usr/bin/du: |
    |  A |         |
    | | rgument li |
    | st too long  |
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
    | Note: this   |
    | "error" has  |
    | been fixed,  |
    | as of kernel |
    | version      |
    | 2.6.23.      |
    |              |
    | (Thank you,  |
    | StĂŠphane    |
    | Chazelas for |
    | the          |
    | clarificatio |
    | n,           |
    | and for      |
    | providing    |
    | the above    |
    | example.)    |
    +--------------+--------------+--------------+--------------+--------------+--------------+

    .. raw:: html

       </div>

    If a script sets environmental variables, they need to be
    "exported," that is, reported to the *environment* local to the
    script. This is the function of the
    `export <internal.html#EXPORTREF>`__ command.

    .. raw:: html

       <div class="NOTE">

    +--------------------------+--------------------------+--------------------------+
    | |Note|                   |
    | A script can **export**  |
    | variables only to child  |
    | `processes <special-char |
    | s.html#PROCESSREF>`__    |
    | , that is, only to       |
    | commands or processes    |
    | which that particular    |
    | script initiates. A      |
    | script invoked from the  |
    | command-line             |
    | ``                       |
    |      cannot              |
    |             ``           |
    | export variables back to |
    | the command-line         |
    | environment. *`Child     |
    | processes <internal.html |
    | #FORKREF>`__             |
    | cannot export variables  |
    | back to the parent       |
    | processes that spawned   |
    | them.*                   |
    |                          |
    |                          |
    | ``                       |
    |      Definition:         |
    |                  ``      |
    | A *child process* is a   |
    | subprocess launched by   |
    | another process, its     |
    | `parent <internal.html#P |
    | ARENTREF>`__             |
    | .                        |
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 ``                 Positional parameters               ``
    Arguments passed to the script from the command line ` [1]
     <othertypesv.html#FTN.AEN2450>`__ : ``         $0        `` ,
    ``         $1        `` , ``         $2        `` ,
    ``         $3        `` . . .

     ``         $0        `` is the name of the script itself,
    ``         $1        `` is the first argument,
    ``         $2        `` the second, ``         $3        `` the
    third, and so forth. ` [2]  <othertypesv.html#FTN.AEN2464>`__ After
    ``         $9        `` , the arguments must be enclosed in
    brackets, for example, ``         ${10}        `` ,
    ``         ${11}        `` , ``         ${12}        `` .

    The special variables `$\* and $@ <internalvariables.html#APPREF>`__
    denote *all* the positional parameters.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 4-5. Positional Parameters**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     # Call this script w |
    | ith at least 10 paramete |
    | rs, for example          |
    |     # ./scriptname 1 2 3 |
    |  4 5 6 7 8 9 10          |
    |     MINPARAMS=10         |
    |                          |
    |     echo                 |
    |                          |
    |     echo "The name of th |
    | is script is \"$0\"."    |
    |     # Adds ./ for curren |
    | t directory              |
    |     echo "The name of th |
    | is script is \"`basename |
    |  $0`\"."                 |
    |     # Strips out path na |
    | me info (see 'basename') |
    |                          |
    |     echo                 |
    |                          |
    |     if [ -n "$1" ]       |
    |         # Tested variabl |
    | e is quoted.             |
    |     then                 |
    |      echo "Parameter #1  |
    | is $1"  # Need quotes to |
    |  escape #                |
    |     fi                   |
    |                          |
    |     if [ -n "$2" ]       |
    |     then                 |
    |      echo "Parameter #2  |
    | is $2"                   |
    |     fi                   |
    |                          |
    |     if [ -n "$3" ]       |
    |     then                 |
    |      echo "Parameter #3  |
    | is $3"                   |
    |     fi                   |
    |                          |
    |     # ...                |
    |                          |
    |                          |
    |     if [ -n "${10}" ]  # |
    |  Parameters > $9 must be |
    |  enclosed in {brackets}. |
    |     then                 |
    |      echo "Parameter #10 |
    |  is ${10}"               |
    |     fi                   |
    |                          |
    |     echo "-------------- |
    | ---------------------"   |
    |     echo "All the comman |
    | d-line parameters are: " |
    | $*""                     |
    |                          |
    |     if [ $# -lt "$MINPAR |
    | AMS" ]                   |
    |     then                 |
    |       echo               |
    |       echo "This script  |
    | needs at least $MINPARAM |
    | S command-line arguments |
    | !"                       |
    |     fi                   |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    *Bracket notation* for positional parameters leads to a fairly
    simple way of referencing the *last* argument passed to a script on
    the command-line. This also requires `indirect
    referencing <bashver2.html#VARREFNEW>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     args=$#           #  |
    | Number of args passed.   |
    |     lastarg=${!args}     |
    |     # Note: This is an * |
    | indirect reference* to $ |
    | args ...                 |
    |                          |
    |                          |
    |     # Or:       lastarg= |
    | ${!#}             (Thank |
    | s, Chris Monson.)        |
    |     # This is an *indire |
    | ct reference* to the $#  |
    | variable.                |
    |     # Note that lastarg= |
    | ${!$#} doesn't work.     |
                              
    +--------------------------+--------------------------+--------------------------+

    Some scripts can perform different operations, depending on which
    name they are invoked with. For this to work, the script needs to
    check ``         $0        `` , the name it was invoked by. ` [3]
     <othertypesv.html#FTN.AEN2501>`__ There must also exist symbolic
    links to all the alternate names of the script. See `Example
    16-2 <basic.html#HELLOL>`__ .

    .. raw:: html

       <div class="TIP">

    +--------------------------------------+--------------------------------------+
    | |Tip|                                |
    | If a script expects a command-line   |
    | parameter but is invoked without     |
    | one, this may cause a *null variable |
    | assignment* , generally an           |
    | undesirable result. One way to       |
    | prevent this is to append an extra   |
    | character to both sides of the       |
    | assignment statement using the       |
    | expected positional parameter.       |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     variable1_=$1_  # Ra |
    | ther than variable1=$1   |
    |     # This will prevent  |
    | an error, even if positi |
    | onal parameter is absent |
    | .                        |
    |                          |
    |     critical_argument01= |
    | $variable1_              |
    |                          |
    |     # The extra characte |
    | r can be stripped off la |
    | ter, like so.            |
    |     variable1=${variable |
    | 1_/_/}                   |
    |     # Side effects only  |
    | if $variable1_ begins wi |
    | th an underscore.        |
    |     # This uses one of t |
    | he parameter substitutio |
    | n templates discussed la |
    | ter.                     |
    |     # (Leaving out the r |
    | eplacement pattern resul |
    | ts in a deletion.)       |
    |                          |
    |     #  A more straightfo |
    | rward way of dealing wit |
    | h this is                |
    |     #+ to simply test wh |
    | ether expected positiona |
    | l parameters have been p |
    | assed.                   |
    |     if [ -z $1 ]         |
    |     then                 |
    |       exit $E_MISSING_PO |
    | S_PARAM                  |
    |     fi                   |
    |                          |
    |                          |
    |     #  However, as Fabia |
    | n Kreutz points out,     |
    |     #+ the above method  |
    | may have unexpected side |
    | -effects.                |
    |     #  A better method i |
    | s parameter substitution |
    | :                        |
    |     #         ${1:-$Defa |
    | ultVal}                  |
    |     #  See the "Paramete |
    | r Substition" section    |
    |     #+ in the "Variables |
    |  Revisited" chapter.     |
                              
    +--------------------------+--------------------------+--------------------------+

    ---

    .. raw:: html

       <div class="EXAMPLE">

    **Example 4-6. *wh* , *whois* domain name lookup**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # ex18.sh            |
    |                          |
    |     # Does a 'whois doma |
    | in-name' lookup on any o |
    | f 3 alternate servers:   |
    |     #                    |
    |  ripe.net, cw.net, radb. |
    | net                      |
    |                          |
    |     # Place this script  |
    | -- renamed 'wh' -- in /u |
    | sr/local/bin             |
    |                          |
    |     # Requires symbolic  |
    | links:                   |
    |     # ln -s /usr/local/b |
    | in/wh /usr/local/bin/wh- |
    | ripe                     |
    |     # ln -s /usr/local/b |
    | in/wh /usr/local/bin/wh- |
    | apnic                    |
    |     # ln -s /usr/local/b |
    | in/wh /usr/local/bin/wh- |
    | tucows                   |
    |                          |
    |     E_NOARGS=75          |
    |                          |
    |                          |
    |     if [ -z "$1" ]       |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` [domain-name]"  |
    |       exit $E_NOARGS     |
    |     fi                   |
    |                          |
    |     # Check script name  |
    | and call proper server.  |
    |     case `basename $0` i |
    | n    # Or:    case ${0## |
    | */} in                   |
    |         "wh"       ) who |
    | is $1@whois.tucows.com;; |
    |         "wh-ripe"  ) who |
    | is $1@whois.ripe.net;;   |
    |         "wh-apnic" ) who |
    | is $1@whois.apnic.net;;  |
    |         "wh-cw"    ) who |
    | is $1@whois.cw.net;;     |
    |         *          ) ech |
    | o "Usage: `basename $0`  |
    | [domain-name]";;         |
    |     esac                 |
    |                          |
    |     exit $?              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    ---

    The **shift** command reassigns the positional parameters, in effect
    shifting them to the left one notch.

    ``         $1        `` <--- ``         $2        `` ,
    ``         $2        `` <--- ``         $3        `` ,
    ``         $3        `` <--- ``         $4        `` , etc.

    The old ``         $1        `` disappears, but
    *``          $0         `` (the script name) does not change* . If
    you use a large number of positional parameters to a script,
    **shift** lets you access those past ``         10        `` ,
    although `{bracket} notation <othertypesv.html#BRACKETNOTATION>`__
    also permits this.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 4-7. Using *shift***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # shft.sh: Using 'sh |
    | ift' to step through all |
    |  the positional paramete |
    | rs.                      |
    |                          |
    |     #  Name this script  |
    | something like shft.sh,  |
    |     #+ and invoke it wit |
    | h some parameters.       |
    |     #+ For example:      |
    |     #             sh shf |
    | t.sh a b c def 83 barndo |
    | or                       |
    |                          |
    |     until [ -z "$1" ]  # |
    |  Until all parameters us |
    | ed up . . .              |
    |     do                   |
    |       echo -n "$1 "      |
    |       shift              |
    |     done                 |
    |                          |
    |     echo               # |
    |  Extra linefeed.         |
    |                          |
    |     # But, what happens  |
    | to the "used-up" paramet |
    | ers?                     |
    |     echo "$2"            |
    |     #  Nothing echoes!   |
    |     #  When $2 shifts in |
    | to $1 (and there is no $ |
    | 3 to shift into $2)      |
    |     #+ then $2 remains e |
    | mpty.                    |
    |     #  So, it is not a p |
    | arameter *copy*, but a * |
    | move*.                   |
    |                          |
    |     exit                 |
    |                          |
    |     #  See also the echo |
    | -params.sh script for a  |
    | "shiftless"              |
    |     #+ alternative metho |
    | d of stepping through th |
    | e positional params.     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The **shift** command can take a numerical parameter indicating how
    many positions to shift.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # shift-past.sh      |
    |                          |
    |     shift 3    # Shift 3 |
    |  positions.              |
    |     #  n=3; shift $n     |
    |     #  Has the same effe |
    | ct.                      |
    |                          |
    |     echo "$1"            |
    |                          |
    |     exit 0               |
    |                          |
    |     # ================== |
    | ====== #                 |
    |                          |
    |                          |
    |     $ sh shift-past.sh 1 |
    |  2 3 4 5                 |
    |     4                    |
    |                          |
    |     #  However, as Eleni |
    |  Fragkiadaki, points out |
    | ,                        |
    |     #+ attempting a 'shi |
    | ft' past the number of   |
    |     #+ positional parame |
    | ters ($#) returns an exi |
    | t status of 1,           |
    |     #+ and the positiona |
    | l parameters themselves  |
    | do not change.           |
    |     #  This means possib |
    | ly getting stuck in an e |
    | ndless loop. . . .       |
    |     #  For example:      |
    |     #      until [ -z "$ |
    | 1" ]                     |
    |     #      do            |
    |     #         echo -n "$ |
    | 1 "                      |
    |     #         shift 20   |
    |   #  If less than 20 pos |
    |  params,                 |
    |     #      done          |
    |   #+ then loop never end |
    | s!                       |
    |     #                    |
    |     # When in doubt, add |
    |  a sanity check. . . .   |
    |     #           shift 20 |
    |  || break                |
    |     #                    |
    |  ^^^^^^^^                |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The **shift** command works in a     |
    | similar fashion on parameters passed |
    | to a                                 |
    | `function <functions.html#FUNCTIONRE |
    | F>`__                                |
    | . See `Example                       |
    | 36-18 <assortedtips.html#MULTIPLICAT |
    | ION>`__                              |
    | .                                    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

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

` [1]  <othertypesv.html#AEN2450>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Note that `*functions* also take positional
parameters <complexfunct.html#PASSEDARGS>`__ .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [2]  <othertypesv.html#AEN2464>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

 The process calling the script sets the ``        $0       ``
parameter. By convention, this parameter is the name of the script. See
the `manpage <basic.html#MANREF>`__ (manual page) for **execv** .

From the *command-line* , however, ``        $0       `` is the name of
the shell.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ echo $0        |
|     bash                 |
|                          |
|     tcsh% echo $0        |
|     tcsh                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [3]  <othertypesv.html#AEN2501>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

If the the script is `sourced <internal.html#SOURCEREF>`__ or
`symlinked <basic.html#SYMLINKREF>`__ , then this will not work. It is
safer to check `$BASH\_Source <debugging.html#BASHSOURCEREF>`__ .

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
| `Prev <untyped.html>`__  | Bash Variables Are       |
| `Home <index.html>`__    | Untyped                  |
| `Next <quoting.html>`__  | `Up <variables.html>`__  |
|                          | Quoting                  |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Caution| image:: ../images/caution.gif
.. |Tip| image:: ../images/tip.gif
