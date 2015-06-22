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

`Prev <loopcontrol.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 11. Loops and Branches

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <commandsub.html>`__

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

  11.4. Testing and Branching
============================

The **case** and **select** constructs are technically not loops, since
they do not iterate the execution of a code block. Like loops, however,
they direct program flow according to conditions at the top or bottom of
the block.

.. raw:: html

   <div class="VARIABLELIST">

** Controlling program flow in a code block**

 **case (in) / esac**
    The **case** construct is the shell scripting analog to
    ``                   switch                 `` in **C/C++** . It
    permits branching to one of a number of code blocks, depending on
    condition tests. It serves as a kind of shorthand for multiple
    if/then/else statements and is an appropriate tool for creating
    menus.

    | **case** "$ ``                   variable                 `` " in
    |  "$ ``                   condition1                 `` " )
    |  ``                   command                 `` ...
    |  ;;
    |  "$ ``                   condition2                 `` " )
    |  ``                   command                 `` ...
    |  ;;
    |  **esac**

    .. raw:: html

       <div class="NOTE">

    +--------------------+--------------------+--------------------+--------------------+
    | |Note|             |
    |                    |
    | -  Quoting the     |
    |    variables is    |
    |    not mandatory,  |
    |    since word      |
    |    splitting does  |
    |    not take place. |
    |                    |
    | -   Each test line |
    |    ends with a     |
    |    right paren     |
    |    **)** . ` [1]   |
    |     <testbranch.ht |
    | ml#FTN.AEN7087>`__ |
    |                    |
    | -  Each condition  |
    |    block ends with |
    |    a *double*      |
    |    semicolon ;; .  |
    |                    |
    | -  If a condition  |
    |    tests *true* ,  |
    |    then the        |
    |    associated      |
    |    commands        |
    |    execute and the |
    |    **case** block  |
    |    terminates.     |
    |                    |
    | -  The entire      |
    |    **case** block  |
    |    ends with an    |
    |    **esac** (      |
    |    *case* spelled  |
    |    backwards).     |
    |                    |
                        
    +--------------------+--------------------+--------------------+--------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-25. Using *case***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Testing ranges of  |
    | characters.              |
    |                          |
    |     echo; echo "Hit a ke |
    | y, then hit return."     |
    |     read Keypress        |
    |                          |
    |     case "$Keypress" in  |
    |       [[:lower:]]   ) ec |
    | ho "Lowercase letter";;  |
    |       [[:upper:]]   ) ec |
    | ho "Uppercase letter";;  |
    |       [0-9]         ) ec |
    | ho "Digit";;             |
    |       *             ) ec |
    | ho "Punctuation, whitesp |
    | ace, or other";;         |
    |     esac      #  Allows  |
    | ranges of characters in  |
    | [square brackets],       |
    |               #+ or POSI |
    | X ranges in [[double squ |
    | are brackets.            |
    |                          |
    |     #  In the first vers |
    | ion of this example,     |
    |     #+ the tests for low |
    | ercase and uppercase cha |
    | racters were             |
    |     #+ [a-z] and [A-Z].  |
    |     #  This no longer wo |
    | rks in certain locales a |
    | nd/or Linux distros.     |
    |     #  POSIX is more por |
    | table.                   |
    |     #  Thanks to Frank W |
    | ang for pointing this ou |
    | t.                       |
    |                          |
    |     #  Exercise:         |
    |     #  --------          |
    |     #  As the script sta |
    | nds, it accepts a single |
    |  keystroke, then termina |
    | tes.                     |
    |     #  Change the script |
    |  so it accepts repeated  |
    | input,                   |
    |     #+ reports on each k |
    | eystroke, and terminates |
    |  only when "X" is hit.   |
    |     #  Hint: enclose eve |
    | rything in a "while" loo |
    | p.                       |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-26. Creating menus using *case***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     # Crude address data |
    | base                     |
    |                          |
    |     clear # Clear the sc |
    | reen.                    |
    |                          |
    |     echo "          Cont |
    | act List"                |
    |     echo "          ---- |
    | --- ----"                |
    |     echo "Choose one of  |
    | the following persons:"  |
    |     echo                 |
    |     echo "[E]vans, Rolan |
    | d"                       |
    |     echo "[J]ones, Mildr |
    | ed"                      |
    |     echo "[S]mith, Julie |
    | "                        |
    |     echo "[Z]ane, Morris |
    | "                        |
    |     echo                 |
    |                          |
    |     read person          |
    |                          |
    |     case "$person" in    |
    |     # Note variable is q |
    | uoted.                   |
    |                          |
    |       "E" | "e" )        |
    |       # Accept upper or  |
    | lowercase input.         |
    |       echo               |
    |       echo "Roland Evans |
    | "                        |
    |       echo "4321 Flash D |
    | r."                      |
    |       echo "Hardscrabble |
    | , CO 80753"              |
    |       echo "(303) 734-98 |
    | 74"                      |
    |       echo "(303) 734-98 |
    | 92 fax"                  |
    |       echo "revans@zzy.n |
    | et"                      |
    |       echo "Business par |
    | tner & old friend"       |
    |       ;;                 |
    |     # Note double semico |
    | lon to terminate each op |
    | tion.                    |
    |                          |
    |       "J" | "j" )        |
    |       echo               |
    |       echo "Mildred Jone |
    | s"                       |
    |       echo "249 E. 7th S |
    | t., Apt. 19"             |
    |       echo "New York, NY |
    |  10009"                  |
    |       echo "(212) 533-28 |
    | 14"                      |
    |       echo "(212) 533-99 |
    | 72 fax"                  |
    |       echo "milliej@lois |
    | aida.com"                |
    |       echo "Ex-girlfrien |
    | d"                       |
    |       echo "Birthday: Fe |
    | b. 11"                   |
    |       ;;                 |
    |                          |
    |     # Add info for Smith |
    |  & Zane later.           |
    |                          |
    |               * )        |
    |        # Default option. |
    |                          |
    |        # Empty input (hi |
    | tting RETURN) fits here, |
    |  too.                    |
    |        echo              |
    |        echo "Not yet in  |
    | database."               |
    |       ;;                 |
    |                          |
    |     esac                 |
    |                          |
    |     echo                 |
    |                          |
    |     #  Exercise:         |
    |     #  --------          |
    |     #  Change the script |
    |  so it accepts multiple  |
    | inputs,                  |
    |     #+ instead of termin |
    | ating after displaying j |
    | ust one address.         |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    An exceptionally clever use of **case** involves testing for
    command-line parameters.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #! /bin/bash         |
    |                          |
    |     case "$1" in         |
    |       "") echo "Usage: $ |
    | {0##*/} <filename>"; exi |
    | t $E_PARAM;;             |
    |                          |
    |   # No command-line para |
    | meters,                  |
    |                          |
    |   # or first parameter e |
    | mpty.                    |
    |     # Note that ${0##*/} |
    |  is ${var##pattern} para |
    | m substitution.          |
    |                          |
    |   # Net result is $0.    |
    |                          |
    |       -*) FILENAME=./$1; |
    | ;   #  If filename passe |
    | d as argument ($1)       |
    |                          |
    |   #+ starts with a dash, |
    |                          |
    |   #+ replace it with ./$ |
    | 1                        |
    |                          |
    |   #+ so further commands |
    |  don't interpret it      |
    |                          |
    |   #+ as an option.       |
    |                          |
    |       * ) FILENAME=$1;;  |
    |     # Otherwise, $1.     |
    |     esac                 |
                              
    +--------------------------+--------------------------+--------------------------+

    Here is a more straightforward example of command-line parameter
    handling:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #! /bin/bash         |
    |                          |
    |                          |
    |     while [ $# -gt 0 ];  |
    | do    # Until you run ou |
    | t of parameters . . .    |
    |       case "$1" in       |
    |         -d|--debug)      |
    |                   # "-d" |
    |  or "--debug" parameter? |
    |                   DEBUG= |
    | 1                        |
    |                   ;;     |
    |         -c|--conf)       |
    |                   CONFFI |
    | LE="$2"                  |
    |                   shift  |
    |                   if [ ! |
    |  -f $CONFFILE ]; then    |
    |                     echo |
    |  "Error: Supplied file d |
    | oesn't exist!"           |
    |                     exit |
    |  $E_CONFFILE     # File  |
    | not found error.         |
    |                   fi     |
    |                   ;;     |
    |       esac               |
    |       shift       # Chec |
    | k next set of parameters |
    | .                        |
    |     done                 |
    |                          |
    |     #  From Stefano Fals |
    | etto's "Log2Rot" script, |
    |     #+ part of his "rott |
    | log" package.            |
    |     #  Used with permiss |
    | ion.                     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-27. Using *command substitution* to generate the *case*
    variable**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # case-cmd.sh: Using |
    |  command substitution to |
    |  generate a "case" varia |
    | ble.                     |
    |                          |
    |     case $( arch ) in    |
    | # $( arch ) returns mach |
    | ine architecture.        |
    |                          |
    | # Equivalent to 'uname - |
    | m' ...                   |
    |       i386 ) echo "80386 |
    | -based machine";;        |
    |       i486 ) echo "80486 |
    | -based machine";;        |
    |       i586 ) echo "Penti |
    | um-based machine";;      |
    |       i686 ) echo "Penti |
    | um2+-based machine";;    |
    |       *    ) echo "Other |
    |  type of machine";;      |
    |     esac                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    A **case** construct can filter strings for
    `globbing <globbingref.html>`__ patterns.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-28. Simple string matching**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # match-string.sh: S |
    | imple string matching    |
    |     #                  u |
    | sing a 'case' construct. |
    |                          |
    |     match_string ()      |
    |     { # Exact string mat |
    | ch.                      |
    |       MATCH=0            |
    |       E_NOMATCH=90       |
    |       PARAMS=2     # Fun |
    | ction requires 2 argumen |
    | ts.                      |
    |       E_BAD_PARAMS=91    |
    |                          |
    |       [ $# -eq $PARAMS ] |
    |  || return $E_BAD_PARAMS |
    |                          |
    |       case "$1" in       |
    |       "$2") return $MATC |
    | H;;                      |
    |       *   ) return $E_NO |
    | MATCH;;                  |
    |       esac               |
    |                          |
    |     }                    |
    |                          |
    |                          |
    |     a=one                |
    |     b=two                |
    |     c=three              |
    |     d=two                |
    |                          |
    |                          |
    |     match_string $a      |
    | # wrong number of parame |
    | ters                     |
    |     echo $?              |
    | # 91                     |
    |                          |
    |     match_string $a $b   |
    | # no match               |
    |     echo $?              |
    | # 90                     |
    |                          |
    |     match_string $b $d   |
    | # match                  |
    |     echo $?              |
    | # 0                      |
    |                          |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-29. Checking for alphabetic input**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # isalpha.sh: Using  |
    | a "case" structure to fi |
    | lter a string.           |
    |                          |
    |     SUCCESS=0            |
    |     FAILURE=1   #  Was F |
    | AILURE=-1,               |
    |                 #+ but B |
    | ash no longer allows neg |
    | ative return value.      |
    |                          |
    |     isalpha ()  # Tests  |
    | whether *first character |
    | * of input string is alp |
    | habetic.                 |
    |     {                    |
    |     if [ -z "$1" ]       |
    |           # No argument  |
    | passed?                  |
    |     then                 |
    |       return $FAILURE    |
    |     fi                   |
    |                          |
    |     case "$1" in         |
    |       [a-zA-Z]*) return  |
    | $SUCCESS;;  # Begins wit |
    | h a letter?              |
    |       *        ) return  |
    | $FAILURE;;               |
    |     esac                 |
    |     }             # Comp |
    | are this with "isalpha ( |
    | )" function in C.        |
    |                          |
    |                          |
    |     isalpha2 ()   # Test |
    | s whether *entire string |
    | * is alphabetic.         |
    |     {                    |
    |       [ $# -eq 1 ] || re |
    | turn $FAILURE            |
    |                          |
    |       case $1 in         |
    |       *[!a-zA-Z]*|"") re |
    | turn $FAILURE;;          |
    |                    *) re |
    | turn $SUCCESS;;          |
    |       esac               |
    |     }                    |
    |                          |
    |     isdigit ()    # Test |
    | s whether *entire string |
    | * is numerical.          |
    |     {             # In o |
    | ther words, tests for in |
    | teger variable.          |
    |       [ $# -eq 1 ] || re |
    | turn $FAILURE            |
    |                          |
    |       case $1 in         |
    |         *[!0-9]*|"") ret |
    | urn $FAILURE;;           |
    |                   *) ret |
    | urn $SUCCESS;;           |
    |       esac               |
    |     }                    |
    |                          |
    |                          |
    |                          |
    |     check_var ()  # Fron |
    | t-end to isalpha ().     |
    |     {                    |
    |     if isalpha "$@"      |
    |     then                 |
    |       echo "\"$*\" begin |
    | s with an alpha characte |
    | r."                      |
    |       if isalpha2 "$@"   |
    |       then        # No p |
    | oint in testing if first |
    |  char is non-alpha.      |
    |         echo "\"$*\" con |
    | tains only alpha charact |
    | ers."                    |
    |       else               |
    |         echo "\"$*\" con |
    | tains at least one non-a |
    | lpha character."         |
    |       fi                 |
    |     else                 |
    |       echo "\"$*\" begin |
    | s with a non-alpha chara |
    | cter."                   |
    |                   # Also |
    |  "non-alpha" if no argum |
    | ent passed.              |
    |     fi                   |
    |                          |
    |     echo                 |
    |                          |
    |     }                    |
    |                          |
    |     digit_check ()  # Fr |
    | ont-end to isdigit ().   |
    |     {                    |
    |     if isdigit "$@"      |
    |     then                 |
    |       echo "\"$*\" conta |
    | ins only digits [0 - 9]. |
    | "                        |
    |     else                 |
    |       echo "\"$*\" has a |
    | t least one non-digit ch |
    | aracter."                |
    |     fi                   |
    |                          |
    |     echo                 |
    |                          |
    |     }                    |
    |                          |
    |     a=23skidoo           |
    |     b=H3llo              |
    |     c=-What?             |
    |     d=What?              |
    |     e=$(echo $b)   # Com |
    | mand substitution.       |
    |     f=AbcDef             |
    |     g=27234              |
    |     h=27a34              |
    |     i=27.34              |
    |                          |
    |     check_var $a         |
    |     check_var $b         |
    |     check_var $c         |
    |     check_var $d         |
    |     check_var $e         |
    |     check_var $f         |
    |     check_var     # No a |
    | rgument passed, so what  |
    | happens?                 |
    |     #                    |
    |     digit_check $g       |
    |     digit_check $h       |
    |     digit_check $i       |
    |                          |
    |                          |
    |     exit 0        # Scri |
    | pt improved by S.C.      |
    |                          |
    |     # Exercise:          |
    |     # --------           |
    |     #  Write an 'isfloat |
    |  ()' function that tests |
    |  for floating point numb |
    | ers.                     |
    |     #  Hint: The functio |
    | n duplicates 'isdigit () |
    | ',                       |
    |     #+ but adds a test f |
    | or a mandatory decimal p |
    | oint.                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **select**
    The **select** construct, adopted from the Korn Shell, is yet
    another tool for building menus.

    | **select** ``                   variable                 `` [in
    ``                   list                 `` ]
    |  do
    |  ``                   command                 `` ...
    |  break
    |  done

    This prompts the user to enter one of the choices presented in the
    variable list. Note that **select** uses the
    ``         $PS3        `` prompt ( ``         #?        `` ) by
    default, but this may be changed.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-30. Creating menus using *select***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     PS3='Choose your fav |
    | orite vegetable: ' # Set |
    | s the prompt string.     |
    |                          |
    |                    # Oth |
    | erwise it defaults to #? |
    |  .                       |
    |                          |
    |     echo                 |
    |                          |
    |     select vegetable in  |
    | "beans" "carrots" "potat |
    | oes" "onions" "rutabagas |
    | "                        |
    |     do                   |
    |       echo               |
    |       echo "Your favorit |
    | e veggie is $vegetable." |
    |       echo "Yuck!"       |
    |       echo               |
    |       break  # What happ |
    | ens if there is no 'brea |
    | k' here?                 |
    |     done                 |
    |                          |
    |     exit                 |
    |                          |
    |     # Exercise:          |
    |     # --------           |
    |     #  Fix this script t |
    | o accept user input not  |
    | specified in             |
    |     #+ the "select" stat |
    | ement.                   |
    |     #  For example, if t |
    | he user inputs "peas,"   |
    |     #+ the script would  |
    | respond "Sorry. That is  |
    | not on the menu."        |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    If
    ``                   in                                 list                     ``
    is omitted, then **select** uses the list of command line arguments
    ( ``         $@        `` ) passed to the script or the function
    containing the **select** construct.

    Compare this to the behavior of a

    **for** ``                   variable                 `` [in
    ``                   list                 `` ]

    construct with the
    ``                 in                              list                   ``
    omitted.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 11-31. Creating menus using *select* in a function**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     PS3='Choose your fav |
    | orite vegetable: '       |
    |                          |
    |     echo                 |
    |                          |
    |     choice_of()          |
    |     {                    |
    |     select vegetable     |
    |     # [in list] omitted, |
    |  so 'select' uses argume |
    | nts passed to function.  |
    |     do                   |
    |       echo               |
    |       echo "Your favorit |
    | e veggie is $vegetable." |
    |       echo "Yuck!"       |
    |       echo               |
    |       break              |
    |     done                 |
    |     }                    |
    |                          |
    |     choice_of beans rice |
    |  carrots radishes rutaba |
    | ga spinach               |
    |     #         $1    $2   |
    |  $3      $4       $5     |
    |    $6                    |
    |     #         passed to  |
    | choice_of() function     |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example 37-3 <bashver2.html#RESISTOR>`__ .

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------+--------------------+--------------------+--------------------+
| ` [1]              |
|  <testbranch.html# |
| AEN7087>`__        |
| Pattern-match      |
| lines may also     |
| *start* with a     |
| **(** left paren   |
| to give the layout |
| a more structured  |
| appearance.        |
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
| |     case $( arch |
|  ) in    |         |
| | # $( arch ) retu |
| rns mach |         |
| | ine architecture |
| .        |         |
| |       ( i386 ) e |
| cho "803 |         |
| | 86-based machine |
| ";;      |         |
| |     # ^      ^   |
|          |         |
| |       ( i486 ) e |
| cho "804 |         |
| | 86-based machine |
| ";;      |         |
| |       ( i586 ) e |
| cho "Pen |         |
| | tium-based machi |
| ne";;    |         |
| |       ( i686 ) e |
| cho "Pen |         |
| | tium2+-based mac |
| hine";;  |         |
| |       (    * ) e |
| cho "Oth |         |
| | er type of machi |
| ne";;    |         |
| |     esac         |
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

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <loopcontrol.html> | Loop Control             |
| `__                      | `Up <loops.html>`__      |
| `Home <index.html>`__    | Command Substitution     |
| `Next <commandsub.html>` |                          |
| __                       |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
