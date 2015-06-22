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

`Prev <functions.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 24. Functions

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <localvar.html>`__

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

  24.1. Complex Functions and Function Complexities
==================================================

Functions may process arguments passed to them and return an `exit
status <exit-status.html#EXITSTATUSREF>`__ to the script for further
processing.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     function_name $arg1  |
| $arg2                    |
                          
+--------------------------+--------------------------+--------------------------+

The function refers to the passed arguments by position (as if they were
`positional parameters <internalvariables.html#POSPARAMREF>`__ ), that
is, ``      $1     `` , ``      $2     `` , and so forth.

.. raw:: html

   <div class="EXAMPLE">

**Example 24-2. Function Taking Parameters**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # Functions and para |
| meters                   |
|                          |
|     DEFAULT=default      |
|                          |
| # Default param value.   |
|                          |
|     func2 () {           |
|        if [ -z "$1" ]    |
|                          |
| # Is parameter #1 zero l |
| ength?                   |
|        then              |
|          echo "-Paramete |
| r #1 is zero length.-"   |
| # Or no parameter passed |
| .                        |
|        else              |
|          echo "-Paramete |
| r #1 is \"$1\".-"        |
|        fi                |
|                          |
|        variable=${1-$DEF |
| AULT}                    |
| #  What does             |
|        echo "variable =  |
| $variable"               |
| #+ parameter substitutio |
| n show?                  |
|                          |
|                          |
| #  --------------------- |
| ------                   |
|                          |
|                          |
| #  It distinguishes betw |
| een                      |
|                          |
|                          |
| #+ no param and a null p |
| aram.                    |
|                          |
|        if [ "$2" ]       |
|        then              |
|          echo "-Paramete |
| r #2 is \"$2\".-"        |
|        fi                |
|                          |
|        return 0          |
|     }                    |
|                          |
|     echo                 |
|                          |
|     echo "Nothing passed |
| ."                       |
|     func2                |
|            # Called with |
|  no params               |
|     echo                 |
|                          |
|                          |
|     echo "Zero-length pa |
| rameter passed."         |
|     func2 ""             |
|            # Called with |
|  zero-length param       |
|     echo                 |
|                          |
|     echo "Null parameter |
|  passed."                |
|     func2 "$uninitialize |
| d_param"   # Called with |
|  uninitialized param     |
|     echo                 |
|                          |
|     echo "One parameter  |
| passed."                 |
|     func2 first          |
|   # Called with one para |
| m                        |
|     echo                 |
|                          |
|     echo "Two parameters |
|  passed."                |
|     func2 first second   |
|   # Called with two para |
| ms                       |
|     echo                 |
|                          |
|     echo "\"\" \"second\ |
| " passed."               |
|     func2 "" second      |
|   # Called with zero-len |
| gth first parameter      |
|     echo                 |
|   # and ASCII string as  |
| a second one.            |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="IMPORTANT">

+--------------------------------------+--------------------------------------+
| |Important|                          |
| The                                  |
| `shift <othertypesv.html#SHIFTREF>`_ |
| _                                    |
| command works on arguments passed to |
| functions (see `Example              |
| 36-18 <assortedtips.html#MULTIPLICAT |
| ION>`__                              |
| ).                                   |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

But, what about command-line arguments passed to the script? Does a
function see them? Well, let's clear up the confusion.

.. raw:: html

   <div class="EXAMPLE">

**Example 24-3. Functions and command-line args passed to the script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # func-cmdlinearg.sh |
|     #  Call this script  |
| with a command-line argu |
| ment,                    |
|     #+ something like $0 |
|  arg1.                   |
|                          |
|                          |
|     func ()              |
|                          |
|     {                    |
|     echo "$1"   # Echoes |
|  first arg passed to the |
|  function.               |
|     }           # Does a |
|  command-line arg qualif |
| y?                       |
|                          |
|     echo "First call to  |
| function: no arg passed. |
| "                        |
|     echo "See if command |
| -line arg is seen."      |
|     func                 |
|     # No! Command-line a |
| rg not seen.             |
|                          |
|     echo "============== |
| ======================== |
| ======================"  |
|     echo                 |
|     echo "Second call to |
|  function: command-line  |
| arg passed explicitly."  |
|     func $1              |
|     # Now it's seen!     |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

In contrast to certain other programming languages, shell scripts
normally pass only value parameters to functions. Variable names (which
are actually *pointers* ), if passed as parameters to functions, will be
treated as string literals. *Functions interpret their arguments
literally.*

`Indirect variable references <ivr.html#IVRREF>`__ (see `Example
37-2 <bashver2.html#EX78>`__ ) provide a clumsy sort of mechanism for
passing variable pointers to functions.

.. raw:: html

   <div class="EXAMPLE">

**Example 24-4. Passing an indirect reference to a function**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ind-func.sh: Passi |
| ng an indirect reference |
|  to a function.          |
|                          |
|     echo_var ()          |
|     {                    |
|     echo "$1"            |
|     }                    |
|                          |
|     message=Hello        |
|     Hello=Goodbye        |
|                          |
|     echo_var "$message"  |
|        # Hello           |
|     # Now, let's pass an |
|  indirect reference to t |
| he function.             |
|     echo_var "${!message |
| }"     # Goodbye         |
|                          |
|     echo "-------------" |
|                          |
|     # What happens if we |
|  change the contents of  |
| "hello" variable?        |
|     Hello="Hello, again! |
| "                        |
|     echo_var "$message"  |
|        # Hello           |
|     echo_var "${!message |
| }"     # Hello, again!   |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

The next logical question is whether parameters can be dereferenced
*after* being passed to a function.

.. raw:: html

   <div class="EXAMPLE">

**Example 24-5. Dereferencing a parameter passed to a function**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # dereference.sh     |
|     # Dereferencing para |
| meter passed to a functi |
| on.                      |
|     # Script by Bruce W. |
|  Clare.                  |
|                          |
|     dereference ()       |
|     {                    |
|          y=\$"$1"   # Na |
| me of variable (not valu |
| e!).                     |
|          echo $y    # $J |
| unk                      |
|                          |
|          x=`eval "expr \ |
| "$y\" "`                 |
|          echo $1=$x      |
|          eval "$1=\"Some |
|  Different Text \""  # A |
| ssign new value.         |
|     }                    |
|                          |
|     Junk="Some Text"     |
|     echo $Junk "before"  |
|    # Some Text before    |
|                          |
|     dereference Junk     |
|     echo $Junk "after"   |
|    # Some Different Text |
|  after                   |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 24-6. Again, dereferencing a parameter passed to a function**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ref-params.sh: Der |
| eferencing a parameter p |
| assed to a function.     |
|     #                (Co |
| mplex Example)           |
|                          |
|     ITERATIONS=3  # How  |
| many times to get input. |
|     icount=1             |
|                          |
|     my_read () {         |
|       #  Called with my_ |
| read varname,            |
|       #+ outputs the pre |
| vious value between brac |
| kets as the default valu |
| e,                       |
|       #+ then asks for a |
|  new value.              |
|                          |
|       local local_var    |
|                          |
|       echo -n "Enter a v |
| alue "                   |
|       eval 'echo -n "[$' |
| $1'] "'  #  Previous val |
| ue.                      |
|     # eval echo -n "[\$$ |
| 1] "     #  Easier to un |
| derstand,                |
|                          |
|          #+ but loses tr |
| ailing space in user pro |
| mpt.                     |
|       read local_var     |
|       [ -n "$local_var"  |
| ] && eval $1=\$local_var |
|                          |
|       # "And-list": if " |
| local_var" then set "$1" |
|  to its value.           |
|     }                    |
|                          |
|     echo                 |
|                          |
|     while [ "$icount" -l |
| e "$ITERATIONS" ]        |
|     do                   |
|       my_read var        |
|       echo "Entry #$icou |
| nt = $var"               |
|       let "icount += 1"  |
|       echo               |
|     done                 |
|                          |
|                          |
|     # Thanks to Stephane |
|  Chazelas for providing  |
| this instructive example |
| .                        |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Exit and Return**

 **exit status**
    Functions return a value, called an *exit status* . This is
    analogous to the `exit status <exit-status.html#EXITSTATUSREF>`__
    returned by a command. The exit status may be explicitly specified
    by a **return** statement, otherwise it is the exit status of the
    last command in the function ( 0 if successful, and a non-zero error
    code if not). This `exit status <exit-status.html#EXITSTATUSREF>`__
    may be used in the script by referencing it as
    `$? <internalvariables.html#XSTATVARREF>`__ . This mechanism
    effectively permits script functions to have a "return value"
    similar to C functions.

 **return**

    Terminates a function. A **return** command ` [1]
     <complexfunct.html#FTN.AEN18474>`__ optionally takes an *integer*
    argument, which is returned to the calling script as the "exit
    status" of the function, and this exit status is assigned to the
    variable `$? <internalvariables.html#XSTATVARREF>`__ .

    .. raw:: html

       <div class="EXAMPLE">

    **Example 24-7. Maximum of two numbers**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # max.sh: Maximum of |
    |  two integers.           |
    |                          |
    |     E_PARAM_ERR=250    # |
    |  If less than 2 params p |
    | assed to function.       |
    |     EQUAL=251          # |
    |  Return value if both pa |
    | rams equal.              |
    |     #  Error values out  |
    | of range of any          |
    |     #+ params that might |
    |  be fed to the function. |
    |                          |
    |     max2 ()              |
    | # Returns larger of two  |
    | numbers.                 |
    |     {                    |
    | # Note: numbers compared |
    |  must be less than 250.  |
    |     if [ -z "$2" ]       |
    |     then                 |
    |       return $E_PARAM_ER |
    | R                        |
    |     fi                   |
    |                          |
    |     if [ "$1" -eq "$2" ] |
    |     then                 |
    |       return $EQUAL      |
    |     else                 |
    |       if [ "$1" -gt "$2" |
    |  ]                       |
    |       then               |
    |         return $1        |
    |       else               |
    |         return $2        |
    |       fi                 |
    |     fi                   |
    |     }                    |
    |                          |
    |     max2 33 34           |
    |     return_val=$?        |
    |                          |
    |     if [ "$return_val" - |
    | eq $E_PARAM_ERR ]        |
    |     then                 |
    |       echo "Need to pass |
    |  two parameters to the f |
    | unction."                |
    |     elif [ "$return_val" |
    |  -eq $EQUAL ]            |
    |       then               |
    |         echo "The two nu |
    | mbers are equal."        |
    |     else                 |
    |         echo "The larger |
    |  of the two numbers is $ |
    | return_val."             |
    |     fi                   |
    |                          |
    |                          |
    |     exit 0               |
    |                          |
    |     #  Exercise (easy):  |
    |     #  ---------------   |
    |     #  Convert this to a |
    | n interactive script,    |
    |     #+ that is, have the |
    |  script ask for input (t |
    | wo numbers).             |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="TIP">

    +--------------------------+--------------------------+--------------------------+
    | |Tip|                    |
    | For a function to return |
    | a string or array, use a |
    | dedicated variable.      |
    |                          |
    | +----------------------- |
    | ---+-------------------- |
    | ------+----------------- |
    | ---------+               |
    | | .. code:: PROGRAMLISTI |
    | NG |                     |
    | |                        |
    |    |                     |
    | |     count_lines_in_etc |
    | _p |                     |
    | | asswd()                |
    |    |                     |
    | |     {                  |
    |    |                     |
    | |       [[ -r /etc/passw |
    | d  |                     |
    | | ]] && REPLY=$(echo $(w |
    | c  |                     |
    | | -l < /etc/passwd))     |
    |    |                     |
    | |       #  If /etc/passw |
    | d  |                     |
    | | is readable, set REPLY |
    |  t |                     |
    | | o line count.          |
    |    |                     |
    | |       #  Returns both  |
    | a  |                     |
    | | parameter value and st |
    | at |                     |
    | | us information.        |
    |    |                     |
    | |       #  The 'echo' se |
    | em |                     |
    | | s unnecessary, but . . |
    |  . |                     |
    | |       #+ it removes ex |
    | ce |                     |
    | | ss whitespace from the |
    |  o |                     |
    | | utput.                 |
    |    |                     |
    | |     }                  |
    |    |                     |
    | |                        |
    |    |                     |
    | |     if count_lines_in_ |
    | et |                     |
    | | c_passwd               |
    |    |                     |
    | |     then               |
    |    |                     |
    | |       echo "There are  |
    | $R |                     |
    | | EPLY lines in /etc/pas |
    | sw |                     |
    | | d."                    |
    |    |                     |
    | |     else               |
    |    |                     |
    | |       echo "Cannot cou |
    | nt |                     |
    | |  lines in /etc/passwd. |
    | "  |                     |
    | |     fi                 |
    |    |                     |
    | |                        |
    |    |                     |
    | |     # Thanks, S.C.     |
    |    |                     |
    |                          |
    |                          |
    | +----------------------- |
    | ---+-------------------- |
    | ------+----------------- |
    | ---------+               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 24-8. Converting numbers to Roman numerals**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     # Arabic number to R |
    | oman numeral conversion  |
    |     # Range: 0 - 200     |
    |     # It's crude, but it |
    |  works.                  |
    |                          |
    |     # Extending the rang |
    | e and otherwise improvin |
    | g the script is left as  |
    | an exercise.             |
    |                          |
    |     # Usage: roman numbe |
    | r-to-convert             |
    |                          |
    |     LIMIT=200            |
    |     E_ARG_ERR=65         |
    |     E_OUT_OF_RANGE=66    |
    |                          |
    |     if [ -z "$1" ]       |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` number-to-conve |
    | rt"                      |
    |       exit $E_ARG_ERR    |
    |     fi                   |
    |                          |
    |     num=$1               |
    |     if [ "$num" -gt $LIM |
    | IT ]                     |
    |     then                 |
    |       echo "Out of range |
    | !"                       |
    |       exit $E_OUT_OF_RAN |
    | GE                       |
    |     fi                   |
    |                          |
    |     to_roman ()   # Must |
    |  declare function before |
    |  first call to it.       |
    |     {                    |
    |     number=$1            |
    |     factor=$2            |
    |     rchar=$3             |
    |     let "remainder = num |
    | ber - factor"            |
    |     while [ "$remainder" |
    |  -ge 0 ]                 |
    |     do                   |
    |       echo -n $rchar     |
    |       let "number -= fac |
    | tor"                     |
    |       let "remainder = n |
    | umber - factor"          |
    |     done                 |
    |                          |
    |     return $number       |
    |            # Exercises:  |
    |            # ---------   |
    |            # 1) Explain  |
    | how this function works. |
    |            #    Hint: di |
    | vision by successive sub |
    | traction.                |
    |            # 2) Extend t |
    | o range of the function. |
    |            #    Hint: us |
    | e "echo" and command-sub |
    | stitution capture.       |
    |     }                    |
    |                          |
    |                          |
    |     to_roman $num 100 C  |
    |     num=$?               |
    |     to_roman $num 90 LXX |
    | XX                       |
    |     num=$?               |
    |     to_roman $num 50 L   |
    |     num=$?               |
    |     to_roman $num 40 XL  |
    |     num=$?               |
    |     to_roman $num 10 X   |
    |     num=$?               |
    |     to_roman $num 9 IX   |
    |     num=$?               |
    |     to_roman $num 5 V    |
    |     num=$?               |
    |     to_roman $num 4 IV   |
    |     num=$?               |
    |     to_roman $num 1 I    |
    |     # Successive calls t |
    | o conversion function!   |
    |     # Is this really nec |
    | essary??? Can it be simp |
    | lified?                  |
    |                          |
    |     echo                 |
    |                          |
    |     exit                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example 11-29 <testbranch.html#ISALPHA>`__ .

    .. raw:: html

       <div class="IMPORTANT">

    +--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
    | |Impor |
    | tant|  |
    | The    |
    | larges |
    | t      |
    | positi |
    | ve     |
    | intege |
    | r      |
    | a      |
    | functi |
    | on     |
    | can    |
    | return |
    | is     |
    | 255.   |
    | The    |
    | **retu |
    | rn**   |
    | comman |
    | d      |
    | is     |
    | closel |
    | y      |
    | tied   |
    | to the |
    | concep |
    | t      |
    | of     |
    | `exit  |
    | status |
    |  <exit |
    | -statu |
    | s.html |
    | #EXITS |
    | TATUSR |
    | EF>`__ |
    | ,      |
    | which  |
    | accoun |
    | ts     |
    | for    |
    | this   |
    | partic |
    | ular   |
    | limita |
    | tion.  |
    | Fortun |
    | ately, |
    | there  |
    | are    |
    | variou |
    | s      |
    | `worka |
    | rounds |
    |  <asso |
    | rtedti |
    | ps.htm |
    | l#RVT> |
    | `__    |
    | for    |
    | those  |
    | situat |
    | ions   |
    | requir |
    | ing    |
    | a      |
    | large  |
    | intege |
    | r      |
    | return |
    | value  |
    | from a |
    | functi |
    | on.    |
    |        |
    | .. raw |
    | :: htm |
    | l      |
    |        |
    |    <di |
    | v      |
    |    cla |
    | ss="EX |
    | AMPLE" |
    | >      |
    |        |
    | **Exam |
    | ple    |
    | 24-9.  |
    | Testin |
    | g      |
    | large  |
    | return |
    | values |
    | in a   |
    | functi |
    | on**   |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    | | .. c |
    | ode::  |
    | PROGRA |
    | MLISTI |
    | NG |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | #!/bin |
    | /bash  |
    |        |
    |    |   |
    | |      |
    | # retu |
    | rn-tes |
    | t.sh   |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | # The  |
    | larges |
    | t posi |
    | ti |   |
    | | ve v |
    | alue a |
    |  funct |
    | ion ca |
    | n  |   |
    | | retu |
    | rn is  |
    | 255.   |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | return |
    | _test  |
    | ()     |
    |    |   |
    | |    # |
    |  Retur |
    | ns wha |
    | tever  |
    | pa |   |
    | | ssed |
    |  to it |
    | .      |
    |        |
    |    |   |
    | |      |
    | {      |
    |        |
    |        |
    |    |   |
    | |      |
    |   retu |
    | rn $1  |
    |        |
    |    |   |
    | |      |
    | }      |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | return |
    | _test  |
    | 27     |
    |    |   |
    | |    # |
    |  o.k.  |
    |        |
    |        |
    |    |   |
    | |      |
    | echo $ |
    | ?      |
    |        |
    |    |   |
    | |    # |
    |  Retur |
    | ns 27. |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | return |
    | _test  |
    | 255    |
    |    |   |
    | |    # |
    |  Still |
    |  o.k.  |
    |        |
    |    |   |
    | |      |
    | echo $ |
    | ?      |
    |        |
    |    |   |
    | |    # |
    |  Retur |
    | ns 255 |
    | .      |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | return |
    | _test  |
    | 257    |
    |    |   |
    | |    # |
    |  Error |
    | !      |
    |        |
    |    |   |
    | |      |
    | echo $ |
    | ?      |
    |        |
    |    |   |
    | |    # |
    |  Retur |
    | ns 1 ( |
    | return |
    |  c |   |
    | | ode  |
    | for mi |
    | scella |
    | neous  |
    | er |   |
    | | ror) |
    | .      |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | # ==== |
    | ====== |
    | ====== |
    | == |   |
    | | ==== |
    | ====== |
    | ====== |
    | ====== |
    | == |   |
    | | ==== |
    | ====== |
    | =====  |
    |        |
    |    |   |
    | |      |
    | return |
    | _test  |
    | -15189 |
    | 6  |   |
    | |    # |
    |  Do la |
    | rge ne |
    | gative |
    |  n |   |
    | | umbe |
    | rs wor |
    | k?     |
    |        |
    |    |   |
    | |      |
    | echo $ |
    | ?      |
    |        |
    |    |   |
    | |    # |
    |  Will  |
    | this r |
    | eturn  |
    | -1 |   |
    | | 5189 |
    | 6?     |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |    # |
    |  No! I |
    | t retu |
    | rns 16 |
    | 8. |   |
    | |      |
    | #  Ver |
    | sion o |
    | f Bash |
    |  b |   |
    | | efor |
    | e 2.05 |
    | b perm |
    | itted  |
    |    |   |
    | |      |
    | #+ lar |
    | ge neg |
    | ative  |
    | in |   |
    | | tege |
    | r retu |
    | rn val |
    | ues.   |
    |    |   |
    | |      |
    | #  It  |
    | happen |
    | ed to  |
    | be |   |
    | |  a u |
    | seful  |
    | featur |
    | e.     |
    |    |   |
    | |      |
    | #  New |
    | er ver |
    | sions  |
    | of |   |
    | |  Bas |
    | h unfo |
    | rtunat |
    | ely pl |
    | ug |   |
    | |  thi |
    | s loop |
    | hole.  |
    |        |
    |    |   |
    | |      |
    | #  Thi |
    | s may  |
    | break  |
    | ol |   |
    | | der  |
    | script |
    | s.     |
    |        |
    |    |   |
    | |      |
    | #  Cau |
    | tion!  |
    |        |
    |    |   |
    | |      |
    | # ==== |
    | ====== |
    | ====== |
    | == |   |
    | | ==== |
    | ====== |
    | ====== |
    | ====== |
    | == |   |
    | | ==== |
    | ====== |
    | =====  |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | exit 0 |
    |        |
    |        |
    |    |   |
    |        |
    |        |
    |        |
    |        |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    |        |
    | .. raw |
    | :: htm |
    | l      |
    |        |
    |    </d |
    | iv>    |
    |        |
    | A      |
    | workar |
    | ound   |
    | for    |
    | obtain |
    | ing    |
    | large  |
    | intege |
    | r      |
    | "retur |
    | n      |
    | values |
    | "      |
    | is to  |
    | simply |
    | assign |
    | the    |
    | "retur |
    | n      |
    | value" |
    | to a   |
    | global |
    | variab |
    | le.    |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    | | .. c |
    | ode::  |
    | PROGRA |
    | MLISTI |
    | NG |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | Return |
    | _Val=  |
    |   # Gl |
    | ob |   |
    | | al v |
    | ariabl |
    | e to h |
    | old ov |
    | er |   |
    | | size |
    |  retur |
    | n valu |
    | e of f |
    | un |   |
    | | ctio |
    | n.     |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | alt_re |
    | turn_t |
    | est () |
    |    |   |
    | |      |
    | {      |
    |        |
    |        |
    |    |   |
    | |      |
    |   fvar |
    | =$1    |
    |        |
    |    |   |
    | |      |
    |   Retu |
    | rn_Val |
    | =$fvar |
    |    |   |
    | |      |
    |   retu |
    | rn   # |
    |  Retur |
    | ns |   |
    | |  0 ( |
    | succes |
    | s).    |
    |        |
    |    |   |
    | |      |
    | }      |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | alt_re |
    | turn_t |
    | est 1  |
    |    |   |
    | |      |
    | echo $ |
    | ?      |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |  # 0   |
    |    |   |
    | |      |
    | echo " |
    | return |
    |  value |
    |  = |   |
    | |  $Re |
    | turn_V |
    | al"    |
    |  # 1   |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | alt_re |
    | turn_t |
    | est 25 |
    | 6  |   |
    | |      |
    | echo " |
    | return |
    |  value |
    |  = |   |
    | |  $Re |
    | turn_V |
    | al"    |
    |  # 256 |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | alt_re |
    | turn_t |
    | est 25 |
    | 7  |   |
    | |      |
    | echo " |
    | return |
    |  value |
    |  = |   |
    | |  $Re |
    | turn_V |
    | al"    |
    |  # 257 |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | alt_re |
    | turn_t |
    | est 25 |
    | 70 |   |
    | | 1    |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | echo " |
    | return |
    |  value |
    |  = |   |
    | |  $Re |
    | turn_V |
    | al"    |
    |  #2570 |
    | 1  |   |
    |        |
    |        |
    |        |
    |        |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    |        |
    | A more |
    | elegan |
    | t      |
    | method |
    | is to  |
    | have   |
    | the    |
    | functi |
    | on     |
    | **echo |
    | **     |
    | its    |
    | "retur |
    | n      |
    | value  |
    | to     |
    | ``     |
    |        |
    |     st |
    | dout   |
    |        |
    |      ` |
    | `      |
    | ," and |
    | then   |
    | captur |
    | e      |
    | it by  |
    | `comma |
    | nd     |
    | substi |
    | tution |
    |  <comm |
    | andsub |
    | .html# |
    | COMMAN |
    | DSUBRE |
    | F>`__  |
    | . See  |
    | the    |
    | `discu |
    | ssion  |
    | of     |
    | this < |
    | assort |
    | edtips |
    | .html# |
    | RVT>`_ |
    | _      |
    | in     |
    | `Secti |
    | on     |
    | 36.7 < |
    | assort |
    | edtips |
    | .html> |
    | `__    |
    | .      |
    |        |
    | .. raw |
    | :: htm |
    | l      |
    |        |
    |    <di |
    | v      |
    |    cla |
    | ss="EX |
    | AMPLE" |
    | >      |
    |        |
    | **Exam |
    | ple    |
    | 24-10. |
    | Compar |
    | ing    |
    | two    |
    | large  |
    | intege |
    | rs**   |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    | | .. c |
    | ode::  |
    | PROGRA |
    | MLISTI |
    | NG |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | #!/bin |
    | /bash  |
    |        |
    |    |   |
    | |      |
    | # max2 |
    | .sh: M |
    | aximum |
    |  o |   |
    | | f tw |
    | o LARG |
    | E inte |
    | gers.  |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | #  Thi |
    | s is t |
    | he pre |
    | vi |   |
    | | ous  |
    | "max.s |
    | h" exa |
    | mple,  |
    |    |   |
    | |      |
    | #+ mod |
    | ified  |
    | to per |
    | mi |   |
    | | t co |
    | mparin |
    | g larg |
    | e inte |
    | ge |   |
    | | rs.  |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | EQUAL= |
    | 0      |
    |        |
    |    |   |
    | | # Re |
    | turn v |
    | alue i |
    | f both |
    |  p |   |
    | | aram |
    | s equa |
    | l.     |
    |        |
    |    |   |
    | |      |
    | E_PARA |
    | M_ERR= |
    | -99999 |
    |    |   |
    | | # No |
    | t enou |
    | gh par |
    | ams pa |
    | ss |   |
    | | ed t |
    | o func |
    | tion.  |
    |        |
    |    |   |
    | |      |
    | #      |
    |        |
    | ^^^^^^ |
    |    |   |
    | |   Ou |
    | t of r |
    | ange o |
    | f any  |
    | pa |   |
    | | rams |
    |  that  |
    | might  |
    | be pas |
    | se |   |
    | | d.   |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | max2 ( |
    | )      |
    |        |
    |    |   |
    | | # "R |
    | eturns |
    | " larg |
    | er of  |
    | tw |   |
    | | o nu |
    | mbers. |
    |        |
    |        |
    |    |   |
    | |      |
    | {      |
    |        |
    |        |
    |    |   |
    | |      |
    | if [ - |
    | z "$2" |
    |  ]     |
    |    |   |
    | |      |
    | then   |
    |        |
    |        |
    |    |   |
    | |      |
    |   echo |
    |  $E_PA |
    | RAM_ER |
    | R  |   |
    | |      |
    |   retu |
    | rn     |
    |        |
    |    |   |
    | |      |
    | fi     |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | if [ " |
    | $1" -e |
    | q "$2" |
    |  ] |   |
    | |      |
    | then   |
    |        |
    |        |
    |    |   |
    | |      |
    |   echo |
    |  $EQUA |
    | L      |
    |    |   |
    | |      |
    |   retu |
    | rn     |
    |        |
    |    |   |
    | |      |
    | else   |
    |        |
    |        |
    |    |   |
    | |      |
    |   if [ |
    |  "$1"  |
    | -gt "$ |
    | 2" |   |
    | |  ]   |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    |   then |
    |        |
    |        |
    |    |   |
    | |      |
    |     re |
    | tval=$ |
    | 1      |
    |    |   |
    | |      |
    |   else |
    |        |
    |        |
    |    |   |
    | |      |
    |     re |
    | tval=$ |
    | 2      |
    |    |   |
    | |      |
    |   fi   |
    |        |
    |        |
    |    |   |
    | |      |
    | fi     |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | echo $ |
    | retval |
    |        |
    |    |   |
    | | # Ec |
    | hoes ( |
    | to std |
    | out),  |
    | ra |   |
    | | ther |
    |  than  |
    | return |
    | ing va |
    | lu |   |
    | | e.   |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | | # Wh |
    | y?     |
    |        |
    |        |
    |    |   |
    | |      |
    | }      |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | return |
    | _val=$ |
    | (max2  |
    | 33 |   |
    | | 001  |
    | 33997) |
    |        |
    |        |
    |    |   |
    | |      |
    | #      |
    |        |
    |  ^^^^  |
    |    |   |
    | |      |
    |        |
    | Functi |
    | on nam |
    | e  |   |
    | |      |
    | #      |
    |        |
    |        |
    | ^^ |   |
    | | ^^^  |
    | ^^^^^  |
    | Params |
    |  passe |
    | d  |   |
    | |      |
    | #  Thi |
    | s is a |
    | ctuall |
    | y  |   |
    | | a fo |
    | rm of  |
    | comman |
    | d subs |
    | ti |   |
    | | tuti |
    | on:    |
    |        |
    |        |
    |    |   |
    | |      |
    | #+ tre |
    | ating  |
    | a func |
    | ti |   |
    | | on a |
    | s if i |
    | t were |
    |  a com |
    | ma |   |
    | | nd,  |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | #+ and |
    |  assig |
    | ning t |
    | he |   |
    | |  std |
    | out of |
    |  the f |
    | unctio |
    | n  |   |
    | | to t |
    | he var |
    | iable  |
    | "retur |
    | n_ |   |
    | | val. |
    | "      |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | # ==== |
    | ====== |
    | ====== |
    | == |   |
    | | ==== |
    | === OU |
    | TPUT = |
    | ====== |
    | == |   |
    | | ==== |
    | ====== |
    | =====  |
    |        |
    |    |   |
    | |      |
    | if [ " |
    | $retur |
    | n_val" |
    |  - |   |
    | | eq " |
    | $E_PAR |
    | AM_ERR |
    | " ]    |
    |    |   |
    | |      |
    |   then |
    |        |
    |        |
    |    |   |
    | |      |
    |   echo |
    |  "Erro |
    | r in p |
    | ar |   |
    | | amet |
    | ers pa |
    | ssed t |
    | o comp |
    | ar |   |
    | | ison |
    |  funct |
    | ion!"  |
    |        |
    |    |   |
    | |      |
    | elif [ |
    |  "$ret |
    | urn_va |
    | l" |   |
    | |  -eq |
    |  "$EQU |
    | AL" ]  |
    |        |
    |    |   |
    | |      |
    |   then |
    |        |
    |        |
    |    |   |
    | |      |
    |     ec |
    | ho "Th |
    | e two  |
    | nu |   |
    | | mber |
    | s are  |
    | equal. |
    | "      |
    |    |   |
    | |      |
    | else   |
    |        |
    |        |
    |    |   |
    | |      |
    |     ec |
    | ho "Th |
    | e larg |
    | er |   |
    | |  of  |
    | the tw |
    | o numb |
    | ers is |
    |  $ |   |
    | | retu |
    | rn_val |
    | ."     |
    |        |
    |    |   |
    | |      |
    | fi     |
    |        |
    |        |
    |    |   |
    | |      |
    | # ==== |
    | ====== |
    | ====== |
    | == |   |
    | | ==== |
    | ====== |
    | ====== |
    | ====== |
    | == |   |
    | | ==== |
    | ====== |
    | =====  |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | exit 0 |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | #  Exe |
    | rcises |
    | :      |
    |    |   |
    | |      |
    | #  --- |
    | ------ |
    |        |
    |    |   |
    | |      |
    | #  1)  |
    | Find a |
    |  more  |
    | el |   |
    | | egan |
    | t way  |
    | of tes |
    | ting   |
    |    |   |
    | |      |
    | #+     |
    | the pa |
    | ramete |
    | rs |   |
    | |  pas |
    | sed to |
    |  the f |
    | unctio |
    | n. |   |
    | |      |
    | #  2)  |
    | Simpli |
    | fy the |
    |  i |   |
    | | f/th |
    | en str |
    | ucture |
    |  at "O |
    | UT |   |
    | | PUT. |
    | "      |
    |        |
    |        |
    |    |   |
    | |      |
    | #  3)  |
    | Rewrit |
    | e the  |
    | sc |   |
    | | ript |
    |  to ta |
    | ke inp |
    | ut fro |
    | m  |   |
    | | comm |
    | and-li |
    | ne par |
    | ameter |
    | s. |   |
    |        |
    |        |
    |        |
    |        |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    |        |
    | .. raw |
    | :: htm |
    | l      |
    |        |
    |    </d |
    | iv>    |
    |        |
    | Here   |
    | is     |
    | anothe |
    | r      |
    | exampl |
    | e      |
    | of     |
    | captur |
    | ing    |
    | a      |
    | functi |
    | on     |
    | "retur |
    | n      |
    | value. |
    | "      |
    | Unders |
    | tandin |
    | g      |
    | it     |
    | requir |
    | es     |
    | some   |
    | knowle |
    | dge    |
    | of     |
    | `awk < |
    | awk.ht |
    | ml#AWK |
    | REF>`_ |
    | _      |
    | .      |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    | | .. c |
    | ode::  |
    | PROGRA |
    | MLISTI |
    | NG |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | month_ |
    | length |
    |  ()  # |
    |  T |   |
    | | akes |
    |  month |
    |  numbe |
    | r as a |
    | n  |   |
    | | argu |
    | ment.  |
    |        |
    |        |
    |    |   |
    | |      |
    | {      |
    |        |
    |      # |
    |  R |   |
    | | etur |
    | ns num |
    | ber of |
    |  days  |
    | in |   |
    | |  mon |
    | th.    |
    |        |
    |        |
    |    |   |
    | |      |
    | monthD |
    | ="31 2 |
    | 8 31 3 |
    | 0  |   |
    | | 31 3 |
    | 0 31 3 |
    | 1 30 3 |
    | 1 30 3 |
    | 1" |   |
    | |   #  |
    | Declar |
    | e as l |
    | ocal?  |
    |    |   |
    | |      |
    | echo " |
    | $month |
    | D" | a |
    | wk |   |
    | |  '{  |
    | print  |
    | $'"${1 |
    | }"' }' |
    |    |   |
    | |   #  |
    | Tricky |
    | .      |
    |        |
    |    |   |
    | |      |
    | #      |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    | ^^^^^^ |
    | ^^^    |
    |    |   |
    | |      |
    | # Para |
    | meter  |
    | passed |
    |  t |   |
    | | o fu |
    | nction |
    |   ($1  |
    | -- mon |
    | th |   |
    | |  num |
    | ber),  |
    | then t |
    | o awk. |
    |    |   |
    | |      |
    | # Awk  |
    | sees t |
    | his as |
    |  " |   |
    | | prin |
    | t $1 . |
    |  . . p |
    | rint $ |
    | 12 |   |
    | | " (d |
    | ependi |
    | ng on  |
    | month  |
    | nu |   |
    | | mber |
    | )      |
    |        |
    |        |
    |    |   |
    | |      |
    | # Temp |
    | late f |
    | or pas |
    | si |   |
    | | ng a |
    |  param |
    | eter t |
    | o embe |
    | dd |   |
    | | ed a |
    | wk scr |
    | ipt:   |
    |        |
    |    |   |
    | |      |
    | #      |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |     $' |
    | "${scr |
    | ip |   |
    | | t_pa |
    | ramete |
    | r}"'   |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | #    H |
    | ere's  |
    | a slig |
    | ht |   |
    | | ly s |
    | impler |
    |  awk c |
    | onstru |
    | ct |   |
    | | :    |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | #    e |
    | cho $m |
    | onthD  |
    | |  |   |
    | | awk  |
    | -v mon |
    | th=$1  |
    | '{prin |
    | t  |   |
    | | $(mo |
    | nth)}' |
    |        |
    |        |
    |    |   |
    | |      |
    | #    U |
    | ses th |
    | e -v a |
    | wk |   |
    | |  opt |
    | ion, w |
    | hich a |
    | ssigns |
    |  a |   |
    | |  var |
    | iable  |
    | value  |
    |        |
    |    |   |
    | |      |
    | #+   p |
    | rior t |
    | o exec |
    | ut |   |
    | | ion  |
    | of the |
    |  awk p |
    | rogram |
    |  b |   |
    | | lock |
    | .      |
    |        |
    |        |
    |    |   |
    | |      |
    | #    T |
    | hank y |
    | ou, Ri |
    | ch |   |
    | | .    |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | #  Nee |
    | ds err |
    | or che |
    | ck |   |
    | | ing  |
    | for co |
    | rrect  |
    | parame |
    | te |   |
    | | r ra |
    | nge (1 |
    | -12)   |
    |        |
    |    |   |
    | |      |
    | #+ and |
    |  for F |
    | ebruar |
    | y  |   |
    | | in l |
    | eap ye |
    | ar.    |
    |        |
    |    |   |
    | |      |
    | }      |
    |        |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | # ---- |
    | ------ |
    | ------ |
    | -- |   |
    | | ---- |
    | ------ |
    | ------ |
    | ------ |
    | -- |   |
    | | ---- |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | # Usag |
    | e exam |
    | ple:   |
    |    |   |
    | |      |
    | month= |
    | 4      |
    |    # A |
    | pr |   |
    | | il,  |
    | for ex |
    | ample  |
    | (4th m |
    | on |   |
    | | th). |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | days_i |
    | n=$(mo |
    | nth_le |
    | ng |   |
    | | th $ |
    | month) |
    |        |
    |        |
    |    |   |
    | |      |
    | echo $ |
    | days_i |
    | n  # 3 |
    | 0  |   |
    | |      |
    | # ---- |
    | ------ |
    | ------ |
    | -- |   |
    | | ---- |
    | ------ |
    | ------ |
    | ------ |
    | -- |   |
    | | ---- |
    |        |
    |        |
    |        |
    |    |   |
    |        |
    |        |
    |        |
    |        |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    |        |
    | See    |
    | also   |
    | `Examp |
    | le     |
    | A-7 <c |
    | ontrib |
    | uted-s |
    | cripts |
    | .html# |
    | DAYSBE |
    | TWEEN> |
    | `__    |
    | and    |
    | `Examp |
    | le     |
    | A-37 < |
    | contri |
    | buted- |
    | script |
    | s.html |
    | #STDDE |
    | V>`__  |
    | .      |
    |        |
    | ``     |
    |        |
    |        |
    |        |
    |      E |
    | xercis |
    | e:     |
    |        |
    |        |
    |        |
    |    ``  |
    | Using  |
    | what   |
    | we     |
    | have   |
    | just   |
    | learne |
    | d,     |
    | extend |
    | the    |
    | previo |
    | us     |
    | `Roman |
    | numera |
    | ls     |
    | exampl |
    | e <com |
    | plexfu |
    | nct.ht |
    | ml#EX6 |
    | 1>`__  |
    | to     |
    | accept |
    | arbitr |
    | arily  |
    | large  |
    | input. |
    +--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Redirection**


``                 Redirecting the stdin         of a function               ``
    A function is essentially a `code
    block <special-chars.html#CODEBLOCKREF>`__ , which means its
    ``         stdin        `` can be redirected (as in `Example
    3-1 <special-chars.html#EX8>`__ ).

    .. raw:: html

       <div class="EXAMPLE">

    **Example 24-11. Real name from username**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # realname.sh        |
    |     #                    |
    |     # From username, get |
    | s "real name" from /etc/ |
    | passwd.                  |
    |                          |
    |                          |
    |     ARGCOUNT=1       # E |
    | xpect one arg.           |
    |     E_WRONGARGS=85       |
    |                          |
    |     file=/etc/passwd     |
    |     pattern=$1           |
    |                          |
    |     if [ $# -ne "$ARGCOU |
    | NT" ]                    |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` USERNAME"       |
    |       exit $E_WRONGARGS  |
    |     fi                   |
    |                          |
    |     file_excerpt ()    # |
    |   Scan file for pattern, |
    |     {                  # |
    | + then print relevant po |
    | rtion of line.           |
    |       while read line  # |
    |  "while" does not necess |
    | arily need [ condition ] |
    |       do                 |
    |         echo "$line" | g |
    | rep $1 | awk -F":" '{ pr |
    | int $5 }'                |
    |         # Have awk use " |
    | :" delimiter.            |
    |       done               |
    |     } <$file  # Redirect |
    |  into function's stdin.  |
    |                          |
    |     file_excerpt $patter |
    | n                        |
    |                          |
    |     # Yes, this entire s |
    | cript could be reduced t |
    | o                        |
    |     #       grep PATTERN |
    |  /etc/passwd | awk -F":" |
    |  '{ print $5 }'          |
    |     # or                 |
    |     #       awk -F: '/PA |
    | TTERN/ {print $5}'       |
    |     # or                 |
    |     #       awk -F: '($1 |
    |  == "username") { print  |
    | $5 }' # real name from u |
    | sername                  |
    |     # However, it might  |
    | not be as instructive.   |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    There is an alternate, and perhaps less confusing method of
    redirecting a function's ``         stdin        `` . This involves
    redirecting the ``         stdin        `` to an embedded bracketed
    code block within the function.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Instead of:        |
    |     Function ()          |
    |     {                    |
    |      ...                 |
    |      } < file            |
    |                          |
    |     # Try this:          |
    |     Function ()          |
    |     {                    |
    |       {                  |
    |         ...              |
    |        } < file          |
    |     }                    |
    |                          |
    |     # Similarly,         |
    |                          |
    |     Function ()  # This  |
    | works.                   |
    |     {                    |
    |       {                  |
    |        echo $*           |
    |       } | tr a b         |
    |     }                    |
    |                          |
    |     Function ()  # This  |
    | doesn't work.            |
    |     {                    |
    |       echo $*            |
    |     } | tr a b   # A nes |
    | ted code block is mandat |
    | ory here.                |
    |                          |
    |                          |
    |     # Thanks, S.C.       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Emmanuel Rouat's `sample             |
    | ``              bashrc             ` |
    | `                                    |
    | file <sample-bashrc.html>`__         |
    | contains some instructive examples   |
    | of functions.                        |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]                                |
|  <complexfunct.html#AEN18474>`__     |
| The **return** command is a Bash     |
| `builtin <internal.html#BUILTINREF>` |
| __                                   |
| .                                    |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <functions.html>`_ | Functions                |
| _                        | `Up <functions.html>`__  |
| `Home <index.html>`__    | Local Variables          |
| `Next <localvar.html>`__ |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Important| image:: ../images/important.gif
.. |Tip| image:: ../images/tip.gif
.. |Note| image:: ../images/note.gif
