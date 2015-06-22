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

`Prev <string-manipulation.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 10. Manipulating Variables

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <loops.html>`__

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

10.2. Parameter Substitution
============================

.. raw:: html

   <div class="VARIABLELIST">

**Manipulating and/or expanding variables**

``${parameter}``
    Same as ``$parameter``, i.e., value of the variable ``parameter``.
    In certain contexts, only the less ambiguous ``${parameter}`` form
    works.

    May be used for concatenating variables with strings.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     your_id=${USER}-on-$ |
    | {HOSTNAME}               |
    |     echo "$your_id"      |
    |     #                    |
    |     echo "Old \$PATH = $ |
    | PATH"                    |
    |     PATH=${PATH}:/opt/bi |
    | n  # Add /opt/bin to $PA |
    | TH for duration of scrip |
    | t.                       |
    |     echo "New \$PATH = $ |
    | PATH"                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

\ ``${parameter-default}``, ``${parameter:-default}``
    If parameter not set, use default.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     var1=1               |
    |     var2=2               |
    |     # var3 is unset.     |
    |                          |
    |     echo ${var1-$var2}   |
    |  # 1                     |
    |     echo ${var3-$var2}   |
    |  # 2                     |
    |     #           ^        |
    |    Note the $ prefix.    |
    |                          |
    |                          |
    |                          |
    |     echo ${username-`who |
    | ami`}                    |
    |     # Echoes the result  |
    | of `whoami`, if variable |
    |  $username is still unse |
    | t.                       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | \ ``${parameter-default}`` and       |
    | ``${parameter:-default}`` are almost |
    | equivalent. The extra : makes a      |
    | difference only when ``parameter``   |
    | has been declared, but is null.      |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # param-sub.sh       |
    |                          |
    |     #  Whether a variabl |
    | e has been declared      |
    |     #+ affects triggerin |
    | g of the default option  |
    |     #+ even if the varia |
    | ble is null.             |
    |                          |
    |     username0=           |
    |     echo "username0 has  |
    | been declared, but is se |
    | t to null."              |
    |     echo "username0 = ${ |
    | username0-`whoami`}"     |
    |     # Will not echo.     |
    |                          |
    |     echo                 |
    |                          |
    |     echo username1 has n |
    | ot been declared.        |
    |     echo "username1 = ${ |
    | username1-`whoami`}"     |
    |     # Will echo.         |
    |                          |
    |     username2=           |
    |     echo "username2 has  |
    | been declared, but is se |
    | t to null."              |
    |     echo "username2 = ${ |
    | username2:-`whoami`}"    |
    |     #                    |
    |          ^               |
    |     # Will echo because  |
    | of :- rather than just - |
    |  in condition test.      |
    |     # Compare to first i |
    | nstance, above.          |
    |                          |
    |                          |
    |     #                    |
    |                          |
    |     # Once again:        |
    |                          |
    |     variable=            |
    |     # variable has been  |
    | declared, but is set to  |
    | null.                    |
    |                          |
    |     echo "${variable-0}" |
    |     # (no output)        |
    |     echo "${variable:-1} |
    | "   # 1                  |
    |     #               ^    |
    |                          |
    |     unset variable       |
    |                          |
    |     echo "${variable-2}" |
    |     # 2                  |
    |     echo "${variable:-3} |
    | "   # 3                  |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The *default parameter* construct finds use in providing "missing"
    command-line arguments in scripts.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     DEFAULT_FILENAME=gen |
    | eric.data                |
    |     filename=${1:-$DEFAU |
    | LT_FILENAME}             |
    |     #  If not otherwise  |
    | specified, the following |
    |  command block operates  |
    |     #+ on the file "gene |
    | ric.data".               |
    |     #  Begin-Command-Blo |
    | ck                       |
    |     #  ...               |
    |     #  ...               |
    |     #  ...               |
    |     #  End-Command-Block |
    |                          |
    |                          |
    |                          |
    |     #  From "hanoi2.bash |
    | " example:               |
    |     DISKS=${1:-E_NOPARAM |
    | }   # Must specify how m |
    | any disks.               |
    |     #  Set $DISKS to $1  |
    | command-line-parameter,  |
    |     #+ or to $E_NOPARAM  |
    | if that is unset.        |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    See also `Example 3-4 <special-chars.html#EX58>`__, `Example
    31-2 <zeros.html#EX73>`__, and `Example
    A-6 <contributed-scripts.html#COLLATZ>`__.

    Compare this method with `using an *and list* to supply a default
    command-line argument <list-cons.html#ANDDEFAULT>`__.

``${parameter=default}``, ``${parameter:=default}``
    If parameter not set, set it to *default*.

    Both forms nearly equivalent. The : makes a difference only when
    ``$parameter`` has been declared and is null,
    `[1] <parameter-substitution.html#FTN.AEN6310>`__ as above.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo ${var=abc}   #  |
    | abc                      |
    |     echo ${var=xyz}   #  |
    | abc                      |
    |     # $var had already b |
    | een set to abc, so it di |
    | d not change.            |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

\ ``${parameter+alt_value}``, ``${parameter:+alt_value}``
    If parameter set, use ``alt_value``, else use null string.

    Both forms nearly equivalent. The : makes a difference only when
    ``parameter`` has been declared and is null, see below.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo "###### \${para |
    | meter+alt_value} ####### |
    | #"                       |
    |     echo                 |
    |                          |
    |     a=${param1+xyz}      |
    |     echo "a = $a"      # |
    |  a =                     |
    |                          |
    |     param2=              |
    |     a=${param2+xyz}      |
    |     echo "a = $a"      # |
    |  a = xyz                 |
    |                          |
    |     param3=123           |
    |     a=${param3+xyz}      |
    |     echo "a = $a"      # |
    |  a = xyz                 |
    |                          |
    |     echo                 |
    |     echo "###### \${para |
    | meter:+alt_value} ###### |
    | ##"                      |
    |     echo                 |
    |                          |
    |     a=${param4:+xyz}     |
    |     echo "a = $a"      # |
    |  a =                     |
    |                          |
    |     param5=              |
    |     a=${param5:+xyz}     |
    |     echo "a = $a"      # |
    |  a =                     |
    |     # Different result f |
    | rom   a=${param5+xyz}    |
    |                          |
    |     param6=123           |
    |     a=${param6:+xyz}     |
    |     echo "a = $a"      # |
    |  a = xyz                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

\ ``${parameter?err_msg}``, ``${parameter:?err_msg}``
    If parameter set, use it, else print *err\_msg* and *abort the
    script* with an `exit status <exit-status.html#EXITSTATUSREF>`__ of
    1.

    Both forms nearly equivalent. The : makes a difference only when
    ``parameter`` has been declared and is null, as above.

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 10-7. Using parameter substitution and error messages**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #  Check some of the |
|  system's environmental  |
| variables.               |
|     #  This is good prev |
| entative maintenance.    |
|     #  If, for example,  |
| $USER, the name of the p |
| erson at the console, is |
|  not set,                |
|     #+ the machine will  |
| not recognize you.       |
|                          |
|     : ${HOSTNAME?} ${USE |
| R?} ${HOME?} ${MAIL?}    |
|       echo               |
|       echo "Name of the  |
| machine is $HOSTNAME."   |
|       echo "You are $USE |
| R."                      |
|       echo "Your home di |
| rectory is $HOME."       |
|       echo "Your mail IN |
| BOX is located in $MAIL. |
| "                        |
|       echo               |
|       echo "If you are r |
| eading this message,"    |
|       echo "critical env |
| ironmental variables hav |
| e been set."             |
|       echo               |
|       echo               |
|                          |
|     # ------------------ |
| ------------------------ |
| ------------             |
|                          |
|     #  The ${variablenam |
| e?} construction can als |
| o check                  |
|     #+ for variables set |
|  within the script.      |
|                          |
|     ThisVariable=Value-o |
| f-ThisVariable           |
|     #  Note, by the way, |
|  that string variables m |
| ay be set                |
|     #+ to characters dis |
| allowed in their names.  |
|     : ${ThisVariable?}   |
|     echo "Value of ThisV |
| ariable is $ThisVariable |
| ".                       |
|                          |
|     echo; echo           |
|                          |
|                          |
|     : ${ZZXy23AB?"ZZXy23 |
| AB has not been set."}   |
|     #  Since ZZXy23AB ha |
| s not been set,          |
|     #+ then the script t |
| erminates with an error  |
| message.                 |
|                          |
|     # You can specify th |
| e error message.         |
|     # : ${variablename?" |
| ERROR MESSAGE"}          |
|                          |
|                          |
|     # Same result with:  |
|   dummy_variable=${ZZXy2 |
| 3AB?}                    |
|     #                    |
|   dummy_variable=${ZZXy2 |
| 3AB?"ZXy23AB has not bee |
| n set."}                 |
|     #                    |
|     #                    |
|   echo ${ZZXy23AB?} >/de |
| v/null                   |
|                          |
|     #  Compare these met |
| hods of checking whether |
|  a variable has been set |
|     #+ with "set -u" . . |
|  .                       |
|                          |
|                          |
|                          |
|     echo "You will not s |
| ee this message, because |
|  script already terminat |
| ed."                     |
|                          |
|     HERE=0               |
|     exit $HERE   # Will  |
| NOT exit here.           |
|                          |
|     # In fact, this scri |
| pt will return an exit s |
| tatus (echo $?) of 1.    |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 10-8. Parameter substitution and "usage" messages**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # usage-message.sh   |
|                          |
|     : ${1?"Usage: $0 ARG |
| UMENT"}                  |
|     #  Script exits here |
|  if command-line paramet |
| er absent,               |
|     #+ with following er |
| ror message.             |
|     #    usage-message.s |
| h: 1: Usage: usage-messa |
| ge.sh ARGUMENT           |
|                          |
|     echo "These two line |
| s echo only if command-l |
| ine parameter given."    |
|     echo "command-line p |
| arameter = \"$1\""       |
|                          |
|     exit 0  # Will exit  |
| here only if command-lin |
| e parameter present.     |
|                          |
|     # Check the exit sta |
| tus, both with and witho |
| ut command-line paramete |
| r.                       |
|     # If command-line pa |
| rameter present, then "$ |
| ?" is 0.                 |
|     # If not, then "$?"  |
| is 1.                    |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="FORMALPARA">

**Parameter substitution and/or expansion.** The following expressions
are the complement to the **match** ``in`` **expr** string operations
(see `Example 16-9 <moreadv.html#EX45>`__). These particular ones are
used mostly in parsing file path names.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Variable length / Substring removal**

``${#var}``
    ``String length`` (number of characters in ``$var``). For an
    `array <arrays.html#ARRAYREF>`__, **${#array}** is the length of the
    first element in the array.

    .. raw:: html

       <div class="NOTE">

    +----------------+----------------+----------------+----------------+----------------+
    | |Note|         |
    | Exceptions:    |
    |                |
    | -              |
    |                |
    |    **${#\*}**  |
    |    and         |
    |    **${#@}**   |
    |    give the    |
    |    *number of  |
    |    positional  |
    |    parameters* |
    | .              |
    |                |
    | -  For an      |
    |    array,      |
    |    **${#array[ |
    | \*]}**         |
    |    and         |
    |    **${#array[ |
    | @]}**          |
    |    give the    |
    |    number of   |
    |    elements in |
    |    the array.  |
    |                |
    | .. raw:: html  |
    |                |
    |    </p>        |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 10-9. Length of a variable**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # length.sh          |
    |                          |
    |     E_NO_ARGS=65         |
    |                          |
    |     if [ $# -eq 0 ]  # M |
    | ust have command-line ar |
    | gs to demo script.       |
    |     then                 |
    |       echo "Please invok |
    | e this script with one o |
    | r more command-line argu |
    | ments."                  |
    |       exit $E_NO_ARGS    |
    |     fi                   |
    |                          |
    |     var01=abcdEFGH28ij   |
    |     echo "var01 = ${var0 |
    | 1}"                      |
    |     echo "Length of var0 |
    | 1 = ${#var01}"           |
    |     # Now, let's try emb |
    | edding a space.          |
    |     var02="abcd EFGH28ij |
    | "                        |
    |     echo "var02 = ${var0 |
    | 2}"                      |
    |     echo "Length of var0 |
    | 2 = ${#var02}"           |
    |                          |
    |     echo "Number of comm |
    | and-line arguments passe |
    | d to script = ${#@}"     |
    |     echo "Number of comm |
    | and-line arguments passe |
    | d to script = ${#*}"     |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

\ ``${var#Pattern}``, ``${var##Pattern}``
    **${var#Pattern}** Remove from ``$var`` the *shortest* part of
    ``$Pattern`` that matches the ``front end`` of ``$var``.

    **${var##Pattern}** Remove from ``$var`` the *longest* part of
    ``$Pattern`` that matches the ``front end`` of ``$var``.

    A usage illustration from `Example
    A-7 <contributed-scripts.html#DAYSBETWEEN>`__:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Function from "day |
    | s-between.sh" example.   |
    |     # Strips leading zer |
    | o(s) from argument passe |
    | d.                       |
    |                          |
    |     strip_leading_zero ( |
    | ) #  Strip possible lead |
    | ing zero(s)              |
    |     {                    |
    |   #+ from argument passe |
    | d.                       |
    |       return=${1#0}      |
    |   #  The "1" refers to " |
    | $1" -- passed arg.       |
    |     }                    |
    |   #  The "0" is what to  |
    | remove from "$1" -- stri |
    | ps zeros.                |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Manfred Schwarb's more elaborate variation of the above:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     strip_leading_zero2  |
    | () # Strip possible lead |
    | ing zero(s), since other |
    | wise                     |
    |     {                    |
    |    # Bash will interpret |
    |  such numbers as octal v |
    | alues.                   |
    |       shopt -s extglob   |
    |    # Turn on extended gl |
    | obbing.                  |
    |       local val=${1##+(0 |
    | )} # Use local variable, |
    |  longest matching series |
    |  of 0's.                 |
    |       shopt -u extglob   |
    |    # Turn off extended g |
    | lobbing.                 |
    |       _strip_leading_zer |
    | o2=${val:-0}             |
    |                          |
    |    # If input was 0, ret |
    | urn 0 instead of "".     |
    |     }                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Another usage illustration:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo `basename $PWD` |
    |         # Basename of cu |
    | rrent working directory. |
    |     echo "${PWD##*/}"    |
    |         # Basename of cu |
    | rrent working directory. |
    |     echo                 |
    |     echo `basename $0`   |
    |         # Name of script |
    | .                        |
    |     echo $0              |
    |         # Name of script |
    | .                        |
    |     echo "${0##*/}"      |
    |         # Name of script |
    | .                        |
    |     echo                 |
    |     filename=test.data   |
    |     echo "${filename##*. |
    | }"      # data           |
    |                          |
    |         # Extension of f |
    | ilename.                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

\ ``${var%Pattern}``, ``${var%%Pattern}``
    **${var%Pattern}** Remove from ``$var`` the *shortest* part of
    ``$Pattern`` that matches the ``back end`` of ``$var``.

    **${var%%Pattern}** Remove from ``$var`` the *longest* part of
    ``$Pattern`` that matches the ``back end`` of ``$var``.

.. raw:: html

   </div>

`Version 2 <bashver2.html#BASH2REF>`__ of Bash added additional options.

.. raw:: html

   <div class="EXAMPLE">

**Example 10-10. Pattern matching in parameter substitution**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # patt-matching.sh   |
|                          |
|     # Pattern matching   |
| using the # ## % %% para |
| meter substitution opera |
| tors.                    |
|                          |
|     var1=abcd12345abc678 |
| 9                        |
|     pattern1=a*c  # * (w |
| ild card) matches everyt |
| hing between a - c.      |
|                          |
|     echo                 |
|     echo "var1 = $var1"  |
|           # abcd12345abc |
| 6789                     |
|     echo "var1 = ${var1} |
| "         # abcd12345abc |
| 6789                     |
|                          |
|           # (alternate f |
| orm)                     |
|     echo "Number of char |
| acters in ${var1} = ${#v |
| ar1}"                    |
|     echo                 |
|                          |
|     echo "pattern1 = $pa |
| ttern1"   # a*c  (everyt |
| hing between 'a' and 'c' |
| )                        |
|     echo "-------------- |
| "                        |
|     echo '${var1#$patter |
| n1}  =' "${var1#$pattern |
| 1}"    #         d12345a |
| bc6789                   |
|     # Shortest possible  |
| match, strips out first  |
| 3 characters  abcd12345a |
| bc6789                   |
|     #                    |
|                   ^^^^^  |
|               |-|        |
|     echo '${var1##$patte |
| rn1} =' "${var1##$patter |
| n1}"   #                 |
|   6789                   |
|     # Longest possible m |
| atch, strips out first 1 |
| 2 characters  abcd12345a |
| bc6789                   |
|     #                    |
|                  ^^^^^   |
|               |--------- |
| -|                       |
|                          |
|     echo; echo; echo     |
|                          |
|     pattern2=b*9         |
|     # everything between |
|  'b' and '9'             |
|     echo "var1 = $var1"  |
|     # Still  abcd12345ab |
| c6789                    |
|     echo                 |
|     echo "pattern2 = $pa |
| ttern2"                  |
|     echo "-------------- |
| "                        |
|     echo '${var1%pattern |
| 2}  =' "${var1%$pattern2 |
| }"     #     abcd12345a  |
|     # Shortest possible  |
| match, strips out last 6 |
|  characters  abcd12345ab |
| c6789                    |
|     #                    |
|                   ^^^^   |
|                        | |
| ----|                    |
|     echo '${var1%%patter |
| n2} =' "${var1%%$pattern |
| 2}"    #     a           |
|     # Longest possible m |
| atch, strips out last 12 |
|  characters  abcd12345ab |
| c6789                    |
|     #                    |
|                  ^^^^    |
|               |--------- |
| ----|                    |
|                          |
|     # Remember, # and ## |
|  work from the left end  |
| (beginning) of string,   |
|     #           % and %% |
|  work from the right end |
| .                        |
|                          |
|     echo                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 10-11. Renaming file extensions:**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # rfe.sh: Renaming f |
| ile extensions.          |
|     #                    |
|     #         rfe old_ex |
| tension new_extension    |
|     #                    |
|     # Example:           |
|     # To rename all *.gi |
| f files in working direc |
| tory to *.jpg,           |
|     #          rfe gif j |
| pg                       |
|                          |
|                          |
|     E_BADARGS=65         |
|                          |
|     case $# in           |
|       0|1)             # |
|  The vertical bar means  |
| "or" in this context.    |
|       echo "Usage: `base |
| name $0` old_file_suffix |
|  new_file_suffix"        |
|       exit $E_BADARGS  # |
|  If 0 or 1 arg, then bai |
| l out.                   |
|       ;;                 |
|     esac                 |
|                          |
|                          |
|     for filename in *.$1 |
|     # Traverse list of f |
| iles ending with 1st arg |
| ument.                   |
|     do                   |
|       mv $filename ${fil |
| ename%$1}$2              |
|       #  Strip off part  |
| of filename matching 1st |
|  argument,               |
|       #+ then append 2nd |
|  argument.               |
|     done                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Variable expansion / Substring replacement**

    These constructs have been adopted from *ksh*.

``${var:pos}``
    Variable ``var`` expanded, starting from offset ``pos``.

``${var:pos:len}``
    Expansion to a max of ``len`` characters of variable ``var``, from
    offset ``pos``. See `Example A-13 <contributed-scripts.html#PW>`__
    for an example of the creative use of this operator.

``${var/Pattern/Replacement}``
    First match of ``Pattern``, within ``var`` replaced with
    ``Replacement``.

    If ``Replacement`` is omitted, then the first match of ``Pattern``
    is replaced by *nothing*, that is, deleted.

``${var//Pattern/Replacement}``
    .. raw:: html

       <div class="FORMALPARA">

    **Global replacement.** All matches of ``Pattern``, within ``var``
    replaced with ``Replacement``.

    .. raw:: html

       </div>

    As above, if ``Replacement`` is omitted, then all occurrences of
    ``Pattern`` are replaced by *nothing*, that is, deleted.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 10-12. Using pattern matching to parse arbitrary strings**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     var1=abcd-1234-defg  |
    |     echo "var1 = $var1"  |
    |                          |
    |     t=${var1#*-*}        |
    |     echo "var1 (with eve |
    | rything, up to and inclu |
    | ding first - stripped ou |
    | t) = $t"                 |
    |     #  t=${var1#*-}  wor |
    | ks just the same,        |
    |     #+ since # matches t |
    | he shortest string,      |
    |     #+ and * matches eve |
    | rything preceding, inclu |
    | ding an empty string.    |
    |     # (Thanks, Stephane  |
    | Chazelas, for pointing t |
    | his out.)                |
    |                          |
    |     t=${var1##*-*}       |
    |     echo "If var1 contai |
    | ns a \"-\", returns empt |
    | y string...   var1 = $t" |
    |                          |
    |                          |
    |     t=${var1%*-*}        |
    |     echo "var1 (with eve |
    | rything from the last -  |
    | on stripped out) = $t"   |
    |                          |
    |     echo                 |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | -                        |
    |     path_name=/home/bozo |
    | /ideas/thoughts.for.toda |
    | y                        |
    |     # ------------------ |
    | ------------------------ |
    | -                        |
    |     echo "path_name = $p |
    | ath_name"                |
    |     t=${path_name##/*/}  |
    |     echo "path_name, str |
    | ipped of prefixes = $t"  |
    |     # Same effect as   t |
    | =`basename $path_name` i |
    | n this particular case.  |
    |     #  t=${path_name%/}; |
    |  t=${t##*/}   is a more  |
    | general solution,        |
    |     #+ but still fails s |
    | ometimes.                |
    |     #  If $path_name end |
    | s with a newline, then ` |
    | basename $path_name` wil |
    | l not work,              |
    |     #+ but the above exp |
    | ression will.            |
    |     # (Thanks, S.C.)     |
    |                          |
    |     t=${path_name%/*.*}  |
    |     # Same effect as   t |
    | =`dirname $path_name`    |
    |     echo "path_name, str |
    | ipped of suffixes = $t"  |
    |     # These will fail in |
    |  some cases, such as ".. |
    | /", "/foo////", # "foo/" |
    | , "/".                   |
    |     #  Removing suffixes |
    | , especially when the ba |
    | sename has no suffix,    |
    |     #+ but the dirname d |
    | oes, also complicates ma |
    | tters.                   |
    |     # (Thanks, S.C.)     |
    |                          |
    |     echo                 |
    |                          |
    |     t=${path_name:11}    |
    |     echo "$path_name, wi |
    | th first 11 chars stripp |
    | ed off = $t"             |
    |     t=${path_name:11:5}  |
    |     echo "$path_name, wi |
    | th first 11 chars stripp |
    | ed off, length 5 = $t"   |
    |                          |
    |     echo                 |
    |                          |
    |     t=${path_name/bozo/c |
    | lown}                    |
    |     echo "$path_name wit |
    | h \"bozo\" replaced  by  |
    | \"clown\" = $t"          |
    |     t=${path_name/today/ |
    | }                        |
    |     echo "$path_name wit |
    | h \"today\" deleted = $t |
    | "                        |
    |     t=${path_name//o/O}  |
    |     echo "$path_name wit |
    | h all o's capitalized =  |
    | $t"                      |
    |     t=${path_name//o/}   |
    |     echo "$path_name wit |
    | h all o's deleted = $t"  |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

``${var/#Pattern/Replacement}``
    If *prefix* of ``var`` matches ``Pattern``, then substitute
    ``Replacement`` for ``Pattern``.

``${var/%Pattern/Replacement}``
    If *suffix* of ``var`` matches ``Pattern``, then substitute
    ``Replacement`` for ``Pattern``.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 10-13. Matching patterns at prefix or suffix of string**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # var-match.sh:      |
    |     # Demo of pattern re |
    | placement at prefix / su |
    | ffix of string.          |
    |                          |
    |     v0=abc1234zip1234abc |
    |     # Original variable. |
    |     echo "v0 = $v0"      |
    |     # abc1234zip1234abc  |
    |     echo                 |
    |                          |
    |     # Match at prefix (b |
    | eginning) of string.     |
    |     v1=${v0/#abc/ABCDEF} |
    |     # abc1234zip1234abc  |
    |                          |
    |     # |-|                |
    |     echo "v1 = $v1"      |
    |     # ABCDEF1234zip1234a |
    | bc                       |
    |                          |
    |     # |----|             |
    |                          |
    |     # Match at suffix (e |
    | nd) of string.           |
    |     v2=${v0/%abc/ABCDEF} |
    |     # abc1234zip123abc   |
    |                          |
    |     #              |-|   |
    |     echo "v2 = $v2"      |
    |     # abc1234zip1234ABCD |
    | EF                       |
    |                          |
    |     #               |--- |
    | -|                       |
    |                          |
    |     echo                 |
    |                          |
    |     #  ----------------- |
    | ------------------------ |
    | -----------              |
    |     #  Must match at beg |
    | inning / end of string,  |
    |     #+ otherwise no repl |
    | acement results.         |
    |     #  ----------------- |
    | ------------------------ |
    | -----------              |
    |     v3=${v0/#123/000}    |
    |     # Matches, but not a |
    | t beginning.             |
    |     echo "v3 = $v3"      |
    |     # abc1234zip1234abc  |
    |                          |
    |     # NO REPLACEMENT.    |
    |     v4=${v0/%123/000}    |
    |     # Matches, but not a |
    | t end.                   |
    |     echo "v4 = $v4"      |
    |     # abc1234zip1234abc  |
    |                          |
    |     # NO REPLACEMENT.    |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

\ ``${!varprefix*}``, ``${!varprefix@}``
    Matches *names* of all previously declared variables beginning with
    ``varprefix``.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # This is a variatio |
    | n on indirect reference, |
    |  but with a * or @.      |
    |     # Bash, version 2.04 |
    | , adds this feature.     |
    |                          |
    |     xyz23=whatever       |
    |     xyz24=               |
    |                          |
    |     a=${!xyz*}         # |
    |   Expands to *names* of  |
    | declared variables       |
    |     # ^ ^   ^            |
    | + beginning with "xyz".  |
    |     echo "a = $a"      # |
    |   a = xyz23 xyz24        |
    |     a=${!xyz@}         # |
    |   Same as above.         |
    |     echo "a = $a"      # |
    |   a = xyz23 xyz24        |
    |                          |
    |     echo "---"           |
    |                          |
    |     abc23=something_else |
    |     b=${!abc*}           |
    |     echo "b = $b"      # |
    |   b = abc23              |
    |     c=${!b}            # |
    |   Now, the more familiar |
    |  type of indirect refere |
    | nce.                     |
    |     echo $c            # |
    |   something_else         |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <parameter-substitution.html#AE |
| N6310>`__                            |
| If $parameter is null in a           |
| non-interactive script, it will      |
| terminate with a `127 exit           |
| status <exitcodes.html#EXITCODESREF> |
| `__                                  |
| (the Bash error code for "command    |
| not found").                         |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <string-manipulati | Manipulating Strings     |
| on.html>`__              | `Up <manipulatingvars.ht |
| `Home <index.html>`__    | ml>`__                   |
| `Next <loops.html>`__    | Loops and Branches       |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
