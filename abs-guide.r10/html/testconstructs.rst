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

`Prev <tests.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 7. Tests

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <fto.html>`__

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

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     (( 0 && 1 ))         |
   |          # Logical AND   |
   |     echo $?     # 1      |
   | ***                      |
   |     # And so ...         |
   |     let "num = (( 0 && 1 |
   |  ))"                     |
   |     echo $num   # 0      |
   |     # But ...            |
   |     let "num = (( 0 && 1 |
   |  ))"                     |
   |     echo $?     # 1      |
   | ***                      |
   |                          |
   |                          |
   |     (( 200 || 11 ))      |
   |          # Logical OR    |
   |     echo $?     # 0      |
   | ***                      |
   |     # ...                |
   |     let "num = (( 200 || |
   |  11 ))"                  |
   |     echo $num   # 1      |
   |     let "num = (( 200 || |
   |  11 ))"                  |
   |     echo $?     # 0      |
   | ***                      |
   |                          |
   |                          |
   |     (( 200 | 11 ))       |
   |          # Bitwise OR    |
   |     echo $?              |
   |          # 0     ***     |
   |     # ...                |
   |     let "num = (( 200 |  |
   | 11 ))"                   |
   |     echo $num            |
   |          # 203           |
   |     let "num = (( 200 |  |
   | 11 ))"                   |
   |     echo $?              |
   |          # 0     ***     |
   |                          |
   |     # The "let" construc |
   | t returns the same exit  |
   | status                   |
   |     #+ as the double-par |
   | entheses arithmetic expa |
   | nsion.                   |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

   .. raw:: html

      <div class="CAUTION">

   +--------------------+--------------------+--------------------+--------------------+
   | |Caution|          |
   | Again, note that   |
   | the *exit status*  |
   | of an arithmetic   |
   | expression is      |
   | *not* an error     |
   | value.             |
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
   | |     var=-2 && (( |
   |  var+=2  |         |
   | | ))               |
   |          |         |
   | |     echo $?      |
   |          |         |
   | |       # 1        |
   |          |         |
   | |                  |
   |          |         |
   | |     var=-2 && (( |
   |  var+=2  |         |
   | | )) && echo $var  |
   |          |         |
   | |                  |
   |          |         |
   | |       # Will not |
   |  echo $v |         |
   | | ar!              |
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

-  

   An **if** can test any command, not just conditions enclosed within
   brackets.

   +--------------------------+--------------------------+--------------------------+
   | .. code:: PROGRAMLISTING |
   |                          |
   |     if cmp a b &> /dev/n |
   | ull  # Suppress output.  |
   |     then echo "Files a a |
   | nd b are identical."     |
   |     else echo "Files a a |
   | nd b differ."            |
   |     fi                   |
   |                          |
   |     # The very useful "i |
   | f-grep" construct:       |
   |     # ------------------ |
   | -----------------        |
   |     if grep -q Bash file |
   |       then echo "File co |
   | ntains at least one occu |
   | rrence of Bash."         |
   |     fi                   |
   |                          |
   |     word=Linux           |
   |     letter_sequence=inu  |
   |     if echo "$word" | gr |
   | ep -q "$letter_sequence" |
   |     # The "-q" option to |
   |  grep suppresses output. |
   |     then                 |
   |       echo "$letter_sequ |
   | ence found in $word"     |
   |     else                 |
   |       echo "$letter_sequ |
   | ence not found in $word" |
   |     fi                   |
   |                          |
   |                          |
   |     if COMMAND_WHOSE_EXI |
   | T_STATUS_IS_0_UNLESS_ERR |
   | OR_OCCURRED              |
   |       then echo "Command |
   |  succeeded."             |
   |       else echo "Command |
   |  failed."                |
   |     fi                   |
                             
   +--------------------------+--------------------------+--------------------------+

   .. raw:: html

      </p>

-  *These last two examples courtesy of Stéphane Chazelas.*

.. raw:: html

   <div class="EXAMPLE">

**Example 7-1. What is truth?**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #  Tip:              |
|     #  If you're unsure  |
| how a certain condition  |
| might evaluate,          |
|     #+ test it in an if- |
| test.                    |
|                          |
|     echo                 |
|                          |
|     echo "Testing \"0\"" |
|     if [ 0 ]      # zero |
|     then                 |
|       echo "0 is true."  |
|     else          # Or e |
| lse ...                  |
|       echo "0 is false." |
|     fi            # 0 is |
|  true.                   |
|                          |
|     echo                 |
|                          |
|     echo "Testing \"1\"" |
|     if [ 1 ]      # one  |
|     then                 |
|       echo "1 is true."  |
|     else                 |
|       echo "1 is false." |
|     fi            # 1 is |
|  true.                   |
|                          |
|     echo                 |
|                          |
|     echo "Testing \"-1\" |
| "                        |
|     if [ -1 ]     # minu |
| s one                    |
|     then                 |
|       echo "-1 is true." |
|     else                 |
|       echo "-1 is false. |
| "                        |
|     fi            # -1 i |
| s true.                  |
|                          |
|     echo                 |
|                          |
|     echo "Testing \"NULL |
| \""                      |
|     if [ ]        # NULL |
|  (empty condition)       |
|     then                 |
|       echo "NULL is true |
| ."                       |
|     else                 |
|       echo "NULL is fals |
| e."                      |
|     fi            # NULL |
|  is false.               |
|                          |
|     echo                 |
|                          |
|     echo "Testing \"xyz\ |
| ""                       |
|     if [ xyz ]    # stri |
| ng                       |
|     then                 |
|       echo "Random strin |
| g is true."              |
|     else                 |
|       echo "Random strin |
| g is false."             |
|     fi            # Rand |
| om string is true.       |
|                          |
|     echo                 |
|                          |
|     echo "Testing \"\$xy |
| z\""                     |
|     if [ $xyz ]   # Test |
| s if $xyz is null, but.. |
| .                        |
|                   # it's |
|  only an uninitialized v |
| ariable.                 |
|     then                 |
|       echo "Uninitialize |
| d variable is true."     |
|     else                 |
|       echo "Uninitialize |
| d variable is false."    |
|     fi            # Unin |
| itialized variable is fa |
| lse.                     |
|                          |
|     echo                 |
|                          |
|     echo "Testing \"-n \ |
| $xyz\""                  |
|     if [ -n "$xyz" ]     |
|         # More pedantica |
| lly correct.             |
|     then                 |
|       echo "Uninitialize |
| d variable is true."     |
|     else                 |
|       echo "Uninitialize |
| d variable is false."    |
|     fi            # Unin |
| itialized variable is fa |
| lse.                     |
|                          |
|     echo                 |
|                          |
|                          |
|     xyz=          # Init |
| ialized, but set to null |
|  value.                  |
|                          |
|     echo "Testing \"-n \ |
| $xyz\""                  |
|     if [ -n "$xyz" ]     |
|     then                 |
|       echo "Null variabl |
| e is true."              |
|     else                 |
|       echo "Null variabl |
| e is false."             |
|     fi            # Null |
|  variable is false.      |
|                          |
|                          |
|     echo                 |
|                          |
|                          |
|     # When is "false" tr |
| ue?                      |
|                          |
|     echo "Testing \"fals |
| e\""                     |
|     if [ "false" ]       |
|         #  It seems that |
|  "false" is just a strin |
| g ...                    |
|     then                 |
|       echo "\"false\" is |
|  true." #+ and it tests  |
| true.                    |
|     else                 |
|       echo "\"false\" is |
|  false."                 |
|     fi            # "fal |
| se" is true.             |
|                          |
|     echo                 |
|                          |
|     echo "Testing \"\$fa |
| lse\""  # Again, uniniti |
| alized variable.         |
|     if [ "$false" ]      |
|     then                 |
|       echo "\"\$false\"  |
| is true."                |
|     else                 |
|       echo "\"\$false\"  |
| is false."               |
|     fi            # "$fa |
| lse" is false.           |
|                   # Now, |
|  we get the expected res |
| ult.                     |
|                          |
|     #  What would happen |
|  if we tested the uninit |
| ialized variable "$true" |
| ?                        |
|                          |
|     echo                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="FORMALPARA">

**Exercise.** Explain the behavior of `Example
7-1 <testconstructs.html#EX10>`__, above.

.. raw:: html

   </div>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     if [ condition-true  |
| ]                        |
|     then                 |
|        command 1         |
|        command 2         |
|        ...               |
|     else  # Or else ...  |
|           # Adds default |
|  code block executing if |
|  original condition test |
| s false.                 |
|        command 3         |
|        command 4         |
|        ...               |
|     fi                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="NOTE">

+----------------+----------------+----------------+----------------+----------------+
| |Note|         |
| When *if* and  |
| *then* are on  |
| same line in a |
| condition      |
| test, a        |
| semicolon must |
| terminate the  |
| *if*           |
| statement.     |
| Both *if* and  |
| *then* are     |
| `keywords <int |
| ernal.html#KEY |
| WORDREF>`__.   |
| Keywords (or   |
| commands)      |
| begin          |
| statements,    |
| and before a   |
| new statement  |
| on the same    |
| line begins,   |
| the old one    |
| must           |
| terminate.     |
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
| |     if [ -x  |
| "$filename"  | |
| | ]; then      |
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

   <div class="VARIABLELIST">

**Else if and elif**

elif
    ``elif`` is a contraction for *else if*. The effect is to nest an
    inner if/then construct within an outer one.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     if [ condition1 ]    |
    |     then                 |
    |        command1          |
    |        command2          |
    |        command3          |
    |     elif [ condition2 ]  |
    |     # Same as else if    |
    |     then                 |
    |        command4          |
    |        command5          |
    |     else                 |
    |        default-command   |
    |     fi                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

.. raw:: html

   </div>

 The ``if test condition-true`` construct is the exact equivalent of
``if [ condition-true ]``. As it happens, the left bracket, **[** , is a
*token* `[1] <testconstructs.html#FTN.AEN3140>`__ which invokes the
**test** command. The closing right bracket, **]** , in an if/test
should not therefore be strictly necessary, however newer versions of
Bash require it.

.. raw:: html

   <div class="NOTE">

+------------+------------+------------+------------+------------+------------+------------+
| |Note|     |
| The        |
| **test**   |
| command is |
| a Bash     |
| `builtin < |
| internal.h |
| tml#BUILTI |
| NREF>`__   |
| which      |
| tests file |
| types and  |
| compares   |
| strings.   |
| Therefore, |
| in a Bash  |
| script,    |
| **test**   |
| does *not* |
| call the   |
| external   |
| ``/usr/bin |
| /test``    |
| binary,    |
| which is   |
| part of    |
| the        |
| *sh-utils* |
| package.   |
| Likewise,  |
| **[** does |
| not call   |
| ``/usr/bin |
| /[``,      |
| which is   |
| linked to  |
| ``/usr/bin |
| /test``.   |
|            |
| +--------- |
| ---------- |
| -------+-- |
| ---------- |
| ---------- |
| ----+----- |
| ---------- |
| ---------- |
| -+         |
| | .. code: |
| : SCREEN   |
|        |   |
| |          |
|            |
|        |   |
| |     bash |
| $ type tes |
| t      |   |
| |     test |
|  is a shel |
| l buil |   |
| | tin      |
|            |
|        |   |
| |     bash |
| $ type '[' |
|        |   |
| |     [ is |
|  a shell b |
| uiltin |   |
| |     bash |
| $ type '[[ |
| '      |   |
| |     [[ i |
| s a shell  |
| keywor |   |
| | d        |
|            |
|        |   |
| |     bash |
| $ type ']] |
| '      |   |
| |     ]] i |
| s a shell  |
| keywor |   |
| | d        |
|            |
|        |   |
| |     bash |
| $ type ']' |
|        |   |
| |     bash |
| : type: ]: |
|  not f |   |
| | ound     |
|            |
|        |   |
| |          |
|            |
|        |   |
|            |
|            |
|            |
| +--------- |
| ---------- |
| -------+-- |
| ---------- |
| ---------- |
| ----+----- |
| ---------- |
| ---------- |
| -+         |
|            |
| .. raw:: h |
| tml        |
|            |
|    </p>    |
|            |
| If, for    |
| some       |
| reason,    |
| you wish   |
| to use     |
| ``/usr/bin |
| /test``    |
| in a Bash  |
| script,    |
| then       |
| specify it |
| by full    |
| pathname.  |
+------------+------------+------------+------------+------------+------------+------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 7-2. Equivalence of *test*, ``/usr/bin/test``, [ ], and
``/usr/bin/[``**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     echo                 |
|                          |
|     if test -z "$1"      |
|     then                 |
|       echo "No command-l |
| ine arguments."          |
|     else                 |
|       echo "First comman |
| d-line argument is $1."  |
|     fi                   |
|                          |
|     echo                 |
|                          |
|     if /usr/bin/test -z  |
| "$1"      # Equivalent t |
| o "test" builtin.        |
|     #  ^^^^^^^^^^^^^     |
|           # Specifying f |
| ull pathname.            |
|     then                 |
|       echo "No command-l |
| ine arguments."          |
|     else                 |
|       echo "First comman |
| d-line argument is $1."  |
|     fi                   |
|                          |
|     echo                 |
|                          |
|     if [ -z "$1" ]       |
|           # Functionally |
|  identical to above code |
|  blocks.                 |
|     #   if [ -z "$1"     |
|             should work, |
|  but...                  |
|     #+  Bash responds to |
|  a missing close-bracket |
|  with an error message.  |
|     then                 |
|       echo "No command-l |
| ine arguments."          |
|     else                 |
|       echo "First comman |
| d-line argument is $1."  |
|     fi                   |
|                          |
|     echo                 |
|                          |
|                          |
|     if /usr/bin/[ -z "$1 |
| " ]       # Again, funct |
| ionally identical to abo |
| ve.                      |
|     # if /usr/bin/[ -z " |
| $1"       # Works, but g |
| ives an error message.   |
|     #                    |
|           # Note:        |
|     #                    |
|             This has bee |
| n fixed in Bash, version |
|  3.x.                    |
|     then                 |
|       echo "No command-l |
| ine arguments."          |
|     else                 |
|       echo "First comman |
| d-line argument is $1."  |
|     fi                   |
|                          |
|     echo                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| The [[ ]] construct is the more versatile Bash version of [ ]. This is   |
| the *extended test command*, adopted from *ksh88*.                       |
|                                                                          |
| \* \* \*                                                                 |
|                                                                          |
| No filename expansion or word splitting takes place between [[ and ]],   |
| but there is parameter expansion and command substitution.               |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: PROGRAMLISTING |                                             |
| |                          |                                             |
| |     file=/etc/passwd     |                                             |
| |                          |                                             |
| |     if [[ -e $file ]]    |                                             |
| |     then                 |                                             |
| |       echo "Password fil |                                             |
| | e exists."               |                                             |
| |     fi                   |                                             |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </p>                                                                  |
|                                                                          |
| Using the **[[ ... ]]** test construct, rather than **[ ... ]** can      |
| prevent many logic errors in scripts. For example, the &&, \|\|, <, and  |
| > operators work within a [[ ]] test, despite giving an error within a [ |
| ] construct.                                                             |
|                                                                          |
| *Arithmetic evaluation* of octal / hexadecimal constants takes place     |
| automatically within a [[ ... ]] construct.                              |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: PROGRAMLISTING |                                             |
| |                          |                                             |
| |     # [[ Octal and hexad |                                             |
| | ecimal evaluation ]]     |                                             |
| |     # Thank you, Moritz  |                                             |
| | Gronbach, for pointing t |                                             |
| | his out.                 |                                             |
| |                          |                                             |
| |                          |                                             |
| |     decimal=15           |                                             |
| |     octal=017   # = 15 ( |                                             |
| | decimal)                 |                                             |
| |     hex=0x0f    # = 15 ( |                                             |
| | decimal)                 |                                             |
| |                          |                                             |
| |     if [ "$decimal" -eq  |                                             |
| | "$octal" ]               |                                             |
| |     then                 |                                             |
| |       echo "$decimal equ |                                             |
| | als $octal"              |                                             |
| |     else                 |                                             |
| |       echo "$decimal is  |                                             |
| | not equal to $octal"     |                                             |
| |    # 15 is not equal to  |                                             |
| | 017                      |                                             |
| |     fi      # Doesn't ev |                                             |
| | aluate within [ single b |                                             |
| | rackets ]!               |                                             |
| |                          |                                             |
| |                          |                                             |
| |     if [[ "$decimal" -eq |                                             |
| |  "$octal" ]]             |                                             |
| |     then                 |                                             |
| |       echo "$decimal equ |                                             |
| | als $octal"              |                                             |
| |    # 15 equals 017       |                                             |
| |     else                 |                                             |
| |       echo "$decimal is  |                                             |
| | not equal to $octal"     |                                             |
| |     fi      # Evaluates  |                                             |
| | within [[ double bracket |                                             |
| | s ]]!                    |                                             |
| |                          |                                             |
| |     if [[ "$decimal" -eq |                                             |
| |  "$hex" ]]               |                                             |
| |     then                 |                                             |
| |       echo "$decimal equ |                                             |
| | als $hex"                |                                             |
| |    # 15 equals 0x0f      |                                             |
| |     else                 |                                             |
| |       echo "$decimal is  |                                             |
| | not equal to $hex"       |                                             |
| |     fi      # [[ $hexade |                                             |
| | cimal ]] also evaluates! |                                             |
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

.. raw:: html

   <div class="NOTE">

+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| |Note|    |
| Following |
| an        |
| **if**,   |
| neither   |
| the       |
| **test**  |
| command   |
| nor the   |
| test      |
| brackets  |
| ( [ ] or  |
| [[ ]] )   |
| are       |
| strictly  |
| necessary |
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
| |     dir |
| =/home/bo |
| zo        |
| |         |
| |         |
|           |
|           |
| |         |
| |     if  |
| cd "$dir" |
|  2>/dev/  |
| |         |
| | null; t |
| hen   # " |
| 2>/dev/n  |
| |         |
| | ull" hi |
| des error |
|  message  |
| |         |
| | .       |
|           |
|           |
| |         |
| |       e |
| cho "Now  |
| in $dir.  |
| |         |
| | "       |
|           |
|           |
| |         |
| |     els |
| e         |
|           |
| |         |
| |       e |
| cho "Can' |
| t change  |
| |         |
| |  to $di |
| r."       |
|           |
| |         |
| |     fi  |
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
| The "if   |
| COMMAND"  |
| construct |
| returns   |
| the exit  |
| status of |
| COMMAND.  |
|           |
| .. raw::  |
| html      |
|           |
|    </p>   |
|           |
| Similarly |
| ,         |
| a         |
| condition |
| within    |
| test      |
| brackets  |
| may stand |
| alone     |
| without   |
| an        |
| **if**,   |
| when used |
| in        |
| combinati |
| on        |
| with a    |
| `list     |
| construct |
|  <list-co |
| ns.html#L |
| ISTCONSRE |
| F>`__.    |
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
| 1=20      |
|           |
| |         |
| |     var |
| 2=22      |
|           |
| |         |
| |     [ " |
| $var1" -n |
| e "$var2  |
| |         |
| | " ] &&  |
| echo "$va |
| r1 is no  |
| |         |
| | t equal |
|  to $var2 |
| "         |
| |         |
| |         |
|           |
|           |
| |         |
| |     hom |
| e=/home/b |
| ozo       |
| |         |
| |     [ - |
| d "$home" |
|  ] || ec  |
| |         |
| | ho "$ho |
| me direct |
| ory does  |
| |         |
| |  not ex |
| ist."     |
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
           
+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+

.. raw:: html

   </div>

The `(( )) construct <dblparens.html>`__ expands and evaluates an
arithmetic expression. If the expression evaluates as zero, it returns
an `exit status <exit-status.html#EXITSTATUSREF>`__ of 1, or "false". A
non-zero expression returns an exit status of 0, or "true". This is in
marked contrast to using the **test** and [ ] constructs previously
discussed.

.. raw:: html

   <div class="EXAMPLE">

**Example 7-3. Arithmetic Tests using (( ))**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # arith-tests.sh     |
|     # Arithmetic tests.  |
|                          |
|     # The (( ... )) cons |
| truct evaluates and test |
| s numerical expressions. |
|     # Exit status opposi |
| te from [ ... ] construc |
| t!                       |
|                          |
|     (( 0 ))              |
|     echo "Exit status of |
|  \"(( 0 ))\" is $?."     |
|      # 1                 |
|                          |
|     (( 1 ))              |
|     echo "Exit status of |
|  \"(( 1 ))\" is $?."     |
|      # 0                 |
|                          |
|     (( 5 > 4 ))          |
|                          |
|      # true              |
|     echo "Exit status of |
|  \"(( 5 > 4 ))\" is $?." |
|      # 0                 |
|                          |
|     (( 5 > 9 ))          |
|                          |
|      # false             |
|     echo "Exit status of |
|  \"(( 5 > 9 ))\" is $?." |
|      # 1                 |
|                          |
|     (( 5 == 5 ))         |
|                          |
|      # true              |
|     echo "Exit status of |
|  \"(( 5 == 5 ))\" is $?. |
| "    # 0                 |
|     # (( 5 = 5 ))  gives |
|  an error message.       |
|                          |
|     (( 5 - 5 ))          |
|                          |
|      # 0                 |
|     echo "Exit status of |
|  \"(( 5 - 5 ))\" is $?." |
|      # 1                 |
|                          |
|     (( 5 / 4 ))          |
|                          |
|      # Division o.k.     |
|     echo "Exit status of |
|  \"(( 5 / 4 ))\" is $?." |
|      # 0                 |
|                          |
|     (( 1 / 2 ))          |
|                          |
|      # Division result < |
|  1.                      |
|     echo "Exit status of |
|  \"(( 1 / 2 ))\" is $?." |
|      # Rounded off to 0. |
|                          |
|                          |
|      # 1                 |
|                          |
|     (( 1 / 0 )) 2>/dev/n |
| ull                      |
|      # Illegal division  |
| by 0.                    |
|     #           ^^^^^^^^ |
| ^^^                      |
|     echo "Exit status of |
|  \"(( 1 / 0 ))\" is $?." |
|      # 1                 |
|                          |
|     # What effect does t |
| he "2>/dev/null" have?   |
|     # What would happen  |
| if it were removed?      |
|     # Try removing it, t |
| hen rerunning the script |
| .                        |
|                          |
|     # ================== |
| ===================== #  |
|                          |
|     # (( ... )) also use |
| ful in an if-then test.  |
|                          |
|     var1=5               |
|     var2=4               |
|                          |
|     if (( var1 > var2 )) |
|     then #^      ^       |
| Note: Not $var1, $var2.  |
| Why?                     |
|       echo "$var1 is gre |
| ater than $var2"         |
|     fi     # 5 is greate |
| r than 4                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

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

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <tests.html>`__    | Tests                    |
| `Home <index.html>`__    | `Up <tests.html>`__      |
| `Next <fto.html>`__      | File test operators      |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Note| image:: ../images/note.gif
