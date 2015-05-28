Advanced Bash-Scripting Guide:

`Prev <tests.html>`__

Chapter 7. Tests

`Next <fto.html>`__

--------------

7.1. Test Constructs
====================

-  An **if/then** construct tests whether the `exit
   status <exit-status.html#EXITSTATUSREF>`__ of a list of commands is 0
   (since 0 means "success" by UNIX convention), and if so, executes one
   or more commands.

-  There exists a dedicated command called **[** (`left
   bracket <special-chars.html#LEFTBRACKET>`__ special character). It is
   a synonym for **test**, and a `builtin <internal.html#BUILTINREF>`__
   for efficiency reasons. This command considers its arguments as
   comparison expressions or file tests and returns an exit status
   corresponding to the result of the comparison (0 for true, 1 for
   false).

-  With version 2.02, Bash introduced the `[[ ...
   ]] <testconstructs.html#DBLBRACKETS>`__ *extended test command*,
   which performs comparisons in a manner more familiar to programmers
   from other languages. Note that **[[** is a
   `keyword <internal.html#KEYWORDREF>`__, not a command.

   Bash sees ``[[ $a -lt $b ]]`` as a single element, which returns an
   exit status.

-  

   The `(( ... )) <dblparens.html>`__ and `let
   ... <internal.html#LETREF>`__ constructs return an `exit
   status <exit-status.html#EXITSTATUSREF>`__, *according to whether the
   arithmetic expressions they evaluate expand to a non-zero value*.
   These `arithmetic-expansion <arithexp.html#ARITHEXPREF>`__ constructs
   may therefore be used to perform `arithmetic
   comparisons <comparison-ops.html#ICOMPARISON1>`__.

   +--------------------------------------------------------------------------+
   | .. code:: PROGRAMLISTING                                                 |
   |                                                                          |
   |     (( 0 && 1 ))                 # Logical AND                           |
   |     echo $?     # 1     ***                                              |
   |     # And so ...                                                         |
   |     let "num = (( 0 && 1 ))"                                             |
   |     echo $num   # 0                                                      |
   |     # But ...                                                            |
   |     let "num = (( 0 && 1 ))"                                             |
   |     echo $?     # 1     ***                                              |
   |                                                                          |
   |                                                                          |
   |     (( 200 || 11 ))              # Logical OR                            |
   |     echo $?     # 0     ***                                              |
   |     # ...                                                                |
   |     let "num = (( 200 || 11 ))"                                          |
   |     echo $num   # 1                                                      |
   |     let "num = (( 200 || 11 ))"                                          |
   |     echo $?     # 0     ***                                              |
   |                                                                          |
   |                                                                          |
   |     (( 200 | 11 ))               # Bitwise OR                            |
   |     echo $?                      # 0     ***                             |
   |     # ...                                                                |
   |     let "num = (( 200 | 11 ))"                                           |
   |     echo $num                    # 203                                   |
   |     let "num = (( 200 | 11 ))"                                           |
   |     echo $?                      # 0     ***                             |
   |                                                                          |
   |     # The "let" construct returns the same exit status                   |
   |     #+ as the double-parentheses arithmetic expansion.                   |
                                                                             
   +--------------------------------------------------------------------------+

   +--------------------------+--------------------------+--------------------------+
   | |Caution|                |
   | Again, note that the     |
   | *exit status* of an      |
   | arithmetic expression is |
   | *not* an error value.    |
   |                          |
   | +----------------------- |
   | ------------------------ |
   | ------------------------ |
   | ---+                     |
   | | .. code:: PROGRAMLISTI |
   | NG                       |
   |                          |
   |    |                     |
   | |                        |
   |                          |
   |                          |
   |    |                     |
   | |     var=-2 && (( var+= |
   | 2 ))                     |
   |                          |
   |    |                     |
   | |     echo $?            |
   |         # 1              |
   |                          |
   |    |                     |
   | |                        |
   |                          |
   |                          |
   |    |                     |
   | |     var=-2 && (( var+= |
   | 2 )) && echo $var        |
   |                          |
   |    |                     |
   | |                        |
   |         # Will not echo  |
   | $var!                    |
   |    |                     |
   |                          |
   |                          |
   |                          |
   |                          |
   | +----------------------- |
   | ------------------------ |
   | ------------------------ |
   | ---+                     |
                             
   +--------------------------+--------------------------+--------------------------+

-  

   An **if** can test any command, not just conditions enclosed within
   brackets.

   +--------------------------------------------------------------------------+
   | .. code:: PROGRAMLISTING                                                 |
   |                                                                          |
   |     if cmp a b &> /dev/null  # Suppress output.                          |
   |     then echo "Files a and b are identical."                             |
   |     else echo "Files a and b differ."                                    |
   |     fi                                                                   |
   |                                                                          |
   |     # The very useful "if-grep" construct:                               |
   |     # -----------------------------------                                |
   |     if grep -q Bash file                                                 |
   |       then echo "File contains at least one occurrence of Bash."         |
   |     fi                                                                   |
   |                                                                          |
   |     word=Linux                                                           |
   |     letter_sequence=inu                                                  |
   |     if echo "$word" | grep -q "$letter_sequence"                         |
   |     # The "-q" option to grep suppresses output.                         |
   |     then                                                                 |
   |       echo "$letter_sequence found in $word"                             |
   |     else                                                                 |
   |       echo "$letter_sequence not found in $word"                         |
   |     fi                                                                   |
   |                                                                          |
   |                                                                          |
   |     if COMMAND_WHOSE_EXIT_STATUS_IS_0_UNLESS_ERROR_OCCURRED              |
   |       then echo "Command succeeded."                                     |
   |       else echo "Command failed."                                        |
   |     fi                                                                   |
                                                                             
   +--------------------------------------------------------------------------+

-  *These last two examples courtesy of Stéphane Chazelas.*

**Example 7-1. What is truth?**

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/bash                                                          |
|                                                                          |
|     #  Tip:                                                              |
|     #  If you're unsure how a certain condition might evaluate,          |
|     #+ test it in an if-test.                                            |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo "Testing \"0\""                                                 |
|     if [ 0 ]      # zero                                                 |
|     then                                                                 |
|       echo "0 is true."                                                  |
|     else          # Or else ...                                          |
|       echo "0 is false."                                                 |
|     fi            # 0 is true.                                           |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo "Testing \"1\""                                                 |
|     if [ 1 ]      # one                                                  |
|     then                                                                 |
|       echo "1 is true."                                                  |
|     else                                                                 |
|       echo "1 is false."                                                 |
|     fi            # 1 is true.                                           |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo "Testing \"-1\""                                                |
|     if [ -1 ]     # minus one                                            |
|     then                                                                 |
|       echo "-1 is true."                                                 |
|     else                                                                 |
|       echo "-1 is false."                                                |
|     fi            # -1 is true.                                          |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo "Testing \"NULL\""                                              |
|     if [ ]        # NULL (empty condition)                               |
|     then                                                                 |
|       echo "NULL is true."                                               |
|     else                                                                 |
|       echo "NULL is false."                                              |
|     fi            # NULL is false.                                       |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo "Testing \"xyz\""                                               |
|     if [ xyz ]    # string                                               |
|     then                                                                 |
|       echo "Random string is true."                                      |
|     else                                                                 |
|       echo "Random string is false."                                     |
|     fi            # Random string is true.                               |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo "Testing \"\$xyz\""                                             |
|     if [ $xyz ]   # Tests if $xyz is null, but...                        |
|                   # it's only an uninitialized variable.                 |
|     then                                                                 |
|       echo "Uninitialized variable is true."                             |
|     else                                                                 |
|       echo "Uninitialized variable is false."                            |
|     fi            # Uninitialized variable is false.                     |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo "Testing \"-n \$xyz\""                                          |
|     if [ -n "$xyz" ]            # More pedantically correct.             |
|     then                                                                 |
|       echo "Uninitialized variable is true."                             |
|     else                                                                 |
|       echo "Uninitialized variable is false."                            |
|     fi            # Uninitialized variable is false.                     |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|                                                                          |
|     xyz=          # Initialized, but set to null value.                  |
|                                                                          |
|     echo "Testing \"-n \$xyz\""                                          |
|     if [ -n "$xyz" ]                                                     |
|     then                                                                 |
|       echo "Null variable is true."                                      |
|     else                                                                 |
|       echo "Null variable is false."                                     |
|     fi            # Null variable is false.                              |
|                                                                          |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|                                                                          |
|     # When is "false" true?                                              |
|                                                                          |
|     echo "Testing \"false\""                                             |
|     if [ "false" ]              #  It seems that "false" is just a strin |
| g ...                                                                    |
|     then                                                                 |
|       echo "\"false\" is true." #+ and it tests true.                    |
|     else                                                                 |
|       echo "\"false\" is false."                                         |
|     fi            # "false" is true.                                     |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo "Testing \"\$false\""  # Again, uninitialized variable.         |
|     if [ "$false" ]                                                      |
|     then                                                                 |
|       echo "\"\$false\" is true."                                        |
|     else                                                                 |
|       echo "\"\$false\" is false."                                       |
|     fi            # "$false" is false.                                   |
|                   # Now, we get the expected result.                     |
|                                                                          |
|     #  What would happen if we tested the uninitialized variable "$true" |
| ?                                                                        |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     exit 0                                                               |
                                                                          
+--------------------------------------------------------------------------+

**Exercise.** Explain the behavior of `Example
7-1 <testconstructs.html#EX10>`__, above.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     if [ condition-true ]                                                |
|     then                                                                 |
|        command 1                                                         |
|        command 2                                                         |
|        ...                                                               |
|     else  # Or else ...                                                  |
|           # Adds default code block executing if original condition test |
| s false.                                                                 |
|        command 3                                                         |
|        command 4                                                         |
|        ...                                                               |
|     fi                                                                   |
                                                                          
+--------------------------------------------------------------------------+

+--------------------+--------------------+--------------------+--------------------+
| |Note|             |
| When *if* and      |
| *then* are on same |
| line in a          |
| condition test, a  |
| semicolon must     |
| terminate the *if* |
| statement. Both    |
| *if* and *then*    |
| are                |
| `keywords <interna |
| l.html#KEYWORDREF> |
| `__.               |
| Keywords (or       |
| commands) begin    |
| statements, and    |
| before a new       |
| statement on the   |
| same line begins,  |
| the old one must   |
| terminate.         |
|                    |
| +----------------- |
| ------------------ |
| ------------------ |
| ------------------ |
| ---+               |
| | .. code:: PROGRA |
| MLISTING           |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     if [ -x "$fi |
| lename" ]; then    |
|                    |
|                    |
|    |               |
|                    |
|                    |
|                    |
|                    |
|                    |
| +----------------- |
| ------------------ |
| ------------------ |
| ------------------ |
| ---+               |
                    
+--------------------+--------------------+--------------------+--------------------+

**Else if and elif**

elif
    ``elif`` is a contraction for *else if*. The effect is to nest an
    inner if/then construct within an outer one.

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     if [ condition1 ]                                                    |
    |     then                                                                 |
    |        command1                                                          |
    |        command2                                                          |
    |        command3                                                          |
    |     elif [ condition2 ]                                                  |
    |     # Same as else if                                                    |
    |     then                                                                 |
    |        command4                                                          |
    |        command5                                                          |
    |     else                                                                 |
    |        default-command                                                   |
    |     fi                                                                   |
                                                                              
    +--------------------------------------------------------------------------+

The ``if test condition-true`` construct is the exact equivalent of
``if [ condition-true ]``. As it happens, the left bracket, **[** , is a
*token* `[1] <testconstructs.html#FTN.AEN3140>`__ which invokes the
**test** command. The closing right bracket, **]** , in an if/test
should not therefore be strictly necessary, however newer versions of
Bash require it.

+--------------+--------------+--------------+--------------+--------------+--------------+
| |Note|       |
| The **test** |
| command is a |
| Bash         |
| `builtin <in |
| ternal.html# |
| BUILTINREF>` |
| __           |
| which tests  |
| file types   |
| and compares |
| strings.     |
| Therefore,   |
| in a Bash    |
| script,      |
| **test**     |
| does *not*   |
| call the     |
| external     |
| ``/usr/bin/t |
| est``        |
| binary,      |
| which is     |
| part of the  |
| *sh-utils*   |
| package.     |
| Likewise,    |
| **[** does   |
| not call     |
| ``/usr/bin/[ |
| ``,          |
| which is     |
| linked to    |
| ``/usr/bin/t |
| est``.       |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
| | .. code::  |
| SCREEN       |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     bash$  |
| type test    |
|              |
|              |
|              |
|              |
|    |         |
| |     test i |
| s a shell bu |
| iltin        |
|              |
|              |
|              |
|    |         |
| |     bash$  |
| type '['     |
|              |
|              |
|              |
|              |
|    |         |
| |     [ is a |
|  shell built |
| in           |
|              |
|              |
|              |
|    |         |
| |     bash$  |
| type '[['    |
|              |
|              |
|              |
|              |
|    |         |
| |     [[ is  |
| a shell keyw |
| ord          |
|              |
|              |
|              |
|    |         |
| |     bash$  |
| type ']]'    |
|              |
|              |
|              |
|              |
|    |         |
| |     ]] is  |
| a shell keyw |
| ord          |
|              |
|              |
|              |
|    |         |
| |     bash$  |
| type ']'     |
|              |
|              |
|              |
|              |
|    |         |
| |     bash:  |
| type: ]: not |
|  found       |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
|              |
|              |
|              |
|              |
|              |
|              |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
|              |
| If, for some |
| reason, you  |
| wish to use  |
| ``/usr/bin/t |
| est``        |
| in a Bash    |
| script, then |
| specify it   |
| by full      |
| pathname.    |
+--------------+--------------+--------------+--------------+--------------+--------------+

**Example 7-2. Equivalence of *test*, ``/usr/bin/test``, [ ], and
``/usr/bin/[``**

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/bash                                                          |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     if test -z "$1"                                                      |
|     then                                                                 |
|       echo "No command-line arguments."                                  |
|     else                                                                 |
|       echo "First command-line argument is $1."                          |
|     fi                                                                   |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     if /usr/bin/test -z "$1"      # Equivalent to "test" builtin.        |
|     #  ^^^^^^^^^^^^^              # Specifying full pathname.            |
|     then                                                                 |
|       echo "No command-line arguments."                                  |
|     else                                                                 |
|       echo "First command-line argument is $1."                          |
|     fi                                                                   |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     if [ -z "$1" ]                # Functionally identical to above code |
|  blocks.                                                                 |
|     #   if [ -z "$1"                should work, but...                  |
|     #+  Bash responds to a missing close-bracket with an error message.  |
|     then                                                                 |
|       echo "No command-line arguments."                                  |
|     else                                                                 |
|       echo "First command-line argument is $1."                          |
|     fi                                                                   |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|                                                                          |
|     if /usr/bin/[ -z "$1" ]       # Again, functionally identical to abo |
| ve.                                                                      |
|     # if /usr/bin/[ -z "$1"       # Works, but gives an error message.   |
|     #                             # Note:                                |
|     #                               This has been fixed in Bash, version |
|  3.x.                                                                    |
|     then                                                                 |
|       echo "No command-line arguments."                                  |
|     else                                                                 |
|       echo "First command-line argument is $1."                          |
|     fi                                                                   |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     exit 0                                                               |
                                                                          
+--------------------------------------------------------------------------+

+---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+
| The [[  |
| ]]      |
| constru |
| ct      |
| is the  |
| more    |
| versati |
| le      |
| Bash    |
| version |
| of [ ]. |
| This is |
| the     |
| *extend |
| ed      |
| test    |
| command |
| *,      |
| adopted |
| from    |
| *ksh88* |
| .       |
|         |
| \* \*   |
| \*      |
|         |
| No      |
| filenam |
| e       |
| expansi |
| on      |
| or word |
| splitti |
| ng      |
| takes   |
| place   |
| between |
| [[ and  |
| ]], but |
| there   |
| is      |
| paramet |
| er      |
| expansi |
| on      |
| and     |
| command |
| substit |
| ution.  |
|         |
| +------ |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| -----+  |
| | .. co |
| de:: PR |
| OGRAMLI |
| STING   |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     f |
| ile=/et |
| c/passw |
| d       |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     i |
| f [[ -e |
|  $file  |
| ]]      |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     t |
| hen     |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|  echo " |
| Passwor |
| d file  |
| exists. |
| "       |
|         |
|         |
|         |
|         |
|      |  |
| |     f |
| i       |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
| +------ |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| -----+  |
|         |
| Using   |
| the     |
| **[[    |
| ...     |
| ]]**    |
| test    |
| constru |
| ct,     |
| rather  |
| than    |
| **[ ... |
| ]** can |
| prevent |
| many    |
| logic   |
| errors  |
| in      |
| scripts |
| .       |
| For     |
| example |
| ,       |
| the &&, |
| \|\|,   |
| <, and  |
| >       |
| operato |
| rs      |
| work    |
| within  |
| a [[ ]] |
| test,   |
| despite |
| giving  |
| an      |
| error   |
| within  |
| a [ ]   |
| constru |
| ct.     |
|         |
| *Arithm |
| etic    |
| evaluat |
| ion*    |
| of      |
| octal / |
| hexadec |
| imal    |
| constan |
| ts      |
| takes   |
| place   |
| automat |
| ically  |
| within  |
| a [[    |
| ... ]]  |
| constru |
| ct.     |
|         |
| +------ |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| -----+  |
| | .. co |
| de:: PR |
| OGRAMLI |
| STING   |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     # |
|  [[ Oct |
| al and  |
| hexadec |
| imal ev |
| aluatio |
| n ]]    |
|         |
|         |
|         |
|      |  |
| |     # |
|  Thank  |
| you, Mo |
| ritz Gr |
| onbach, |
|  for po |
| inting  |
| this ou |
| t.      |
|         |
|      |  |
| |       |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     d |
| ecimal= |
| 15      |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     o |
| ctal=01 |
| 7   # = |
|  15 (de |
| cimal)  |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     h |
| ex=0x0f |
|     # = |
|  15 (de |
| cimal)  |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     i |
| f [ "$d |
| ecimal" |
|  -eq "$ |
| octal"  |
| ]       |
|         |
|         |
|         |
|         |
|      |  |
| |     t |
| hen     |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|  echo " |
| $decima |
| l equal |
| s $octa |
| l"      |
|         |
|         |
|         |
|         |
|      |  |
| |     e |
| lse     |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|  echo " |
| $decima |
| l is no |
| t equal |
|  to $oc |
| tal"    |
|     # 1 |
| 5 is no |
| t equal |
|  to  |  |
| | 017   |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     f |
| i       |
| # Doesn |
| 't eval |
| uate wi |
| thin [  |
| single  |
| bracket |
| s ]!    |
|         |
|      |  |
| |       |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     i |
| f [[ "$ |
| decimal |
| " -eq " |
| $octal" |
|  ]]     |
|         |
|         |
|         |
|         |
|      |  |
| |     t |
| hen     |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|  echo " |
| $decima |
| l equal |
| s $octa |
| l"      |
|         |
|     # 1 |
| 5 equal |
| s 017   |
|      |  |
| |     e |
| lse     |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|  echo " |
| $decima |
| l is no |
| t equal |
|  to $oc |
| tal"    |
|         |
|         |
|         |
|      |  |
| |     f |
| i       |
| # Evalu |
| ates wi |
| thin [[ |
|  double |
|  bracke |
| ts ]]!  |
|         |
|         |
|      |  |
| |       |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |     i |
| f [[ "$ |
| decimal |
| " -eq " |
| $hex" ] |
| ]       |
|         |
|         |
|         |
|         |
|      |  |
| |     t |
| hen     |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|  echo " |
| $decima |
| l equal |
| s $hex" |
|         |
|         |
|     # 1 |
| 5 equal |
| s 0x0f  |
|      |  |
| |     e |
| lse     |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|      |  |
| |       |
|  echo " |
| $decima |
| l is no |
| t equal |
|  to $he |
| x"      |
|         |
|         |
|         |
|      |  |
| |     f |
| i       |
| # [[ $h |
| exadeci |
| mal ]]  |
| also ev |
| aluates |
| !       |
|         |
|         |
|      |  |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
|         |
| +------ |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| ------- |
| -----+  |
|         |
         
+---------+---------+---------+---------+---------+---------+---------+---------+---------+---------+

+--------------+--------------+--------------+--------------+--------------+--------------+
| |Note|       |
| Following an |
| **if**,      |
| neither the  |
| **test**     |
| command nor  |
| the test     |
| brackets ( [ |
| ] or [[ ]] ) |
| are strictly |
| necessary.   |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
| | .. code::  |
| PROGRAMLISTI |
| NG           |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     dir=/h |
| ome/bozo     |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     if cd  |
| "$dir" 2>/de |
| v/null; then |
|    # "2>/dev |
| /null" hides |
|  error messa |
| ge |         |
| | .          |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |       echo |
|  "Now in $di |
| r."          |
|              |
|              |
|              |
|    |         |
| |     else   |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |       echo |
|  "Can't chan |
| ge to $dir." |
|              |
|              |
|              |
|    |         |
| |     fi     |
|              |
|              |
|              |
|              |
|              |
|    |         |
|              |
|              |
|              |
|              |
|              |
|              |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
|              |
| The "if      |
| COMMAND"     |
| construct    |
| returns the  |
| exit status  |
| of COMMAND.  |
| Similarly, a |
| condition    |
| within test  |
| brackets may |
| stand alone  |
| without an   |
| **if**, when |
| used in      |
| combination  |
| with a `list |
| construct <l |
| ist-cons.htm |
| l#LISTCONSRE |
| F>`__.       |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
| | .. code::  |
| PROGRAMLISTI |
| NG           |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     var1=2 |
| 0            |
|              |
|              |
|              |
|              |
|    |         |
| |     var2=2 |
| 2            |
|              |
|              |
|              |
|              |
|    |         |
| |     [ "$va |
| r1" -ne "$va |
| r2" ] && ech |
| o "$var1 is  |
| not equal to |
|  $var2"      |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     home=/ |
| home/bozo    |
|              |
|              |
|              |
|              |
|    |         |
| |     [ -d " |
| $home" ] ||  |
| echo "$home  |
| directory do |
| es not exist |
| ."           |
|    |         |
|              |
|              |
|              |
|              |
|              |
|              |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
              
+--------------+--------------+--------------+--------------+--------------+--------------+

The `(( )) construct <dblparens.html>`__ expands and evaluates an
arithmetic expression. If the expression evaluates as zero, it returns
an `exit status <exit-status.html#EXITSTATUSREF>`__ of 1, or "false". A
non-zero expression returns an exit status of 0, or "true". This is in
marked contrast to using the **test** and [ ] constructs previously
discussed.

**Example 7-3. Arithmetic Tests using (( ))**

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/bash                                                          |
|     # arith-tests.sh                                                     |
|     # Arithmetic tests.                                                  |
|                                                                          |
|     # The (( ... )) construct evaluates and tests numerical expressions. |
|     # Exit status opposite from [ ... ] construct!                       |
|                                                                          |
|     (( 0 ))                                                              |
|     echo "Exit status of \"(( 0 ))\" is $?."         # 1                 |
|                                                                          |
|     (( 1 ))                                                              |
|     echo "Exit status of \"(( 1 ))\" is $?."         # 0                 |
|                                                                          |
|     (( 5 > 4 ))                                      # true              |
|     echo "Exit status of \"(( 5 > 4 ))\" is $?."     # 0                 |
|                                                                          |
|     (( 5 > 9 ))                                      # false             |
|     echo "Exit status of \"(( 5 > 9 ))\" is $?."     # 1                 |
|                                                                          |
|     (( 5 == 5 ))                                     # true              |
|     echo "Exit status of \"(( 5 == 5 ))\" is $?."    # 0                 |
|     # (( 5 = 5 ))  gives an error message.                               |
|                                                                          |
|     (( 5 - 5 ))                                      # 0                 |
|     echo "Exit status of \"(( 5 - 5 ))\" is $?."     # 1                 |
|                                                                          |
|     (( 5 / 4 ))                                      # Division o.k.     |
|     echo "Exit status of \"(( 5 / 4 ))\" is $?."     # 0                 |
|                                                                          |
|     (( 1 / 2 ))                                      # Division result < |
|  1.                                                                      |
|     echo "Exit status of \"(( 1 / 2 ))\" is $?."     # Rounded off to 0. |
|                                                      # 1                 |
|                                                                          |
|     (( 1 / 0 )) 2>/dev/null                          # Illegal division  |
| by 0.                                                                    |
|     #           ^^^^^^^^^^^                                              |
|     echo "Exit status of \"(( 1 / 0 ))\" is $?."     # 1                 |
|                                                                          |
|     # What effect does the "2>/dev/null" have?                           |
|     # What would happen if it were removed?                              |
|     # Try removing it, then rerunning the script.                        |
|                                                                          |
|     # ======================================= #                          |
|                                                                          |
|     # (( ... )) also useful in an if-then test.                          |
|                                                                          |
|     var1=5                                                               |
|     var2=4                                                               |
|                                                                          |
|     if (( var1 > var2 ))                                                 |
|     then #^      ^      Note: Not $var1, $var2. Why?                     |
|       echo "$var1 is greater than $var2"                                 |
|     fi     # 5 is greater than 4                                         |
|                                                                          |
|     exit 0                                                               |
                                                                          
+--------------------------------------------------------------------------+

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <testconstructs.html#AEN3140>`_ |
| _                                    |
| A *token* is a symbol or short       |
| string with a special meaning        |
| attached to it (a                    |
| `meta-meaning <x17129.html#METAMEANI |
| NGREF>`__).                          |
| In Bash, certain tokens, such as     |
| **[** and `.                         |
| (dot-command) <special-chars.html#DO |
| TREF>`__,                            |
| may expand to *keywords* and         |
| commands.                            |
+--------------------------------------+--------------------------------------+

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <tests.html>`__    | Tests                    |
| `Home <index.html>`__    | `Up <tests.html>`__      |
| `Next <fto.html>`__      | File test operators      |
+--------------------------+--------------------------+--------------------------+

.. |Caution| image:: ../images/caution.gif
.. |Note| image:: ../images/note.gif
