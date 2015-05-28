Advanced Bash-Scripting Guide:

`Prev <functions.html>`__

Chapter 24. Functions

`Next <localvar.html>`__

--------------

24.1. Complex Functions and Function Complexities
=================================================

Functions may process arguments passed to them and return an `exit
status <exit-status.html#EXITSTATUSREF>`__ to the script for further
processing.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     function_name $arg1 $arg2                                            |
                                                                          
+--------------------------------------------------------------------------+

The function refers to the passed arguments by position (as if they were
`positional parameters <internalvariables.html#POSPARAMREF>`__), that
is, ``$1``, ``$2``, and so forth.

**Example 24-2. Function Taking Parameters**

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/bash                                                          |
|     # Functions and parameters                                           |
|                                                                          |
|     DEFAULT=default                             # Default param value.   |
|                                                                          |
|     func2 () {                                                           |
|        if [ -z "$1" ]                           # Is parameter #1 zero l |
| ength?                                                                   |
|        then                                                              |
|          echo "-Parameter #1 is zero length.-"  # Or no parameter passed |
| .                                                                        |
|        else                                                              |
|          echo "-Parameter #1 is \"$1\".-"                                |
|        fi                                                                |
|                                                                          |
|        variable=${1-$DEFAULT}                   #  What does             |
|        echo "variable = $variable"              #+ parameter substitutio |
| n show?                                                                  |
|                                                 #  --------------------- |
| ------                                                                   |
|                                                 #  It distinguishes betw |
| een                                                                      |
|                                                 #+ no param and a null p |
| aram.                                                                    |
|                                                                          |
|        if [ "$2" ]                                                       |
|        then                                                              |
|          echo "-Parameter #2 is \"$2\".-"                                |
|        fi                                                                |
|                                                                          |
|        return 0                                                          |
|     }                                                                    |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     echo "Nothing passed."                                               |
|     func2                          # Called with no params               |
|     echo                                                                 |
|                                                                          |
|                                                                          |
|     echo "Zero-length parameter passed."                                 |
|     func2 ""                       # Called with zero-length param       |
|     echo                                                                 |
|                                                                          |
|     echo "Null parameter passed."                                        |
|     func2 "$uninitialized_param"   # Called with uninitialized param     |
|     echo                                                                 |
|                                                                          |
|     echo "One parameter passed."                                         |
|     func2 first           # Called with one param                        |
|     echo                                                                 |
|                                                                          |
|     echo "Two parameters passed."                                        |
|     func2 first second    # Called with two params                       |
|     echo                                                                 |
|                                                                          |
|     echo "\"\" \"second\" passed."                                       |
|     func2 "" second       # Called with zero-length first parameter      |
|     echo                  # and ASCII string as a second one.            |
|                                                                          |
|     exit 0                                                               |
                                                                          
+--------------------------------------------------------------------------+

+--------------------------------------+--------------------------------------+
| |Important|                          |
| The                                  |
| `shift <othertypesv.html#SHIFTREF>`_ |
| _                                    |
| command works on arguments passed to |
| functions (see `Example              |
| 36-18 <assortedtips.html#MULTIPLICAT |
| ION>`__).                            |
+--------------------------------------+--------------------------------------+

But, what about command-line arguments passed to the script? Does a
function see them? Well, let's clear up the confusion.

**Example 24-3. Functions and command-line args passed to the script**

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/bash                                                          |
|     # func-cmdlinearg.sh                                                 |
|     #  Call this script with a command-line argument,                    |
|     #+ something like $0 arg1.                                           |
|                                                                          |
|                                                                          |
|     func ()                                                              |
|                                                                          |
|     {                                                                    |
|     echo "$1"   # Echoes first arg passed to the function.               |
|     }           # Does a command-line arg qualify?                       |
|                                                                          |
|     echo "First call to function: no arg passed."                        |
|     echo "See if command-line arg is seen."                              |
|     func                                                                 |
|     # No! Command-line arg not seen.                                     |
|                                                                          |
|     echo "============================================================"  |
|     echo                                                                 |
|     echo "Second call to function: command-line arg passed explicitly."  |
|     func $1                                                              |
|     # Now it's seen!                                                     |
|                                                                          |
|     exit 0                                                               |
                                                                          
+--------------------------------------------------------------------------+

In contrast to certain other programming languages, shell scripts
normally pass only value parameters to functions. Variable names (which
are actually *pointers*), if passed as parameters to functions, will be
treated as string literals. *Functions interpret their arguments
literally.*

`Indirect variable references <ivr.html#IVRREF>`__ (see `Example
37-2 <bashver2.html#EX78>`__) provide a clumsy sort of mechanism for
passing variable pointers to functions.

**Example 24-4. Passing an indirect reference to a function**

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/bash                                                          |
|     # ind-func.sh: Passing an indirect reference to a function.          |
|                                                                          |
|     echo_var ()                                                          |
|     {                                                                    |
|     echo "$1"                                                            |
|     }                                                                    |
|                                                                          |
|     message=Hello                                                        |
|     Hello=Goodbye                                                        |
|                                                                          |
|     echo_var "$message"        # Hello                                   |
|     # Now, let's pass an indirect reference to the function.             |
|     echo_var "${!message}"     # Goodbye                                 |
|                                                                          |
|     echo "-------------"                                                 |
|                                                                          |
|     # What happens if we change the contents of "hello" variable?        |
|     Hello="Hello, again!"                                                |
|     echo_var "$message"        # Hello                                   |
|     echo_var "${!message}"     # Hello, again!                           |
|                                                                          |
|     exit 0                                                               |
                                                                          
+--------------------------------------------------------------------------+

The next logical question is whether parameters can be dereferenced
*after* being passed to a function.

**Example 24-5. Dereferencing a parameter passed to a function**

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/bash                                                          |
|     # dereference.sh                                                     |
|     # Dereferencing parameter passed to a function.                      |
|     # Script by Bruce W. Clare.                                          |
|                                                                          |
|     dereference ()                                                       |
|     {                                                                    |
|          y=\$"$1"   # Name of variable (not value!).                     |
|          echo $y    # $Junk                                              |
|                                                                          |
|          x=`eval "expr \"$y\" "`                                         |
|          echo $1=$x                                                      |
|          eval "$1=\"Some Different Text \""  # Assign new value.         |
|     }                                                                    |
|                                                                          |
|     Junk="Some Text"                                                     |
|     echo $Junk "before"    # Some Text before                            |
|                                                                          |
|     dereference Junk                                                     |
|     echo $Junk "after"     # Some Different Text after                   |
|                                                                          |
|     exit 0                                                               |
                                                                          
+--------------------------------------------------------------------------+

**Example 24-6. Again, dereferencing a parameter passed to a function**

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/bash                                                          |
|     # ref-params.sh: Dereferencing a parameter passed to a function.     |
|     #                (Complex Example)                                   |
|                                                                          |
|     ITERATIONS=3  # How many times to get input.                         |
|     icount=1                                                             |
|                                                                          |
|     my_read () {                                                         |
|       #  Called with my_read varname,                                    |
|       #+ outputs the previous value between brackets as the default valu |
| e,                                                                       |
|       #+ then asks for a new value.                                      |
|                                                                          |
|       local local_var                                                    |
|                                                                          |
|       echo -n "Enter a value "                                           |
|       eval 'echo -n "[$'$1'] "'  #  Previous value.                      |
|     # eval echo -n "[\$$1] "     #  Easier to understand,                |
|                                  #+ but loses trailing space in user pro |
| mpt.                                                                     |
|       read local_var                                                     |
|       [ -n "$local_var" ] && eval $1=\$local_var                         |
|                                                                          |
|       # "And-list": if "local_var" then set "$1" to its value.           |
|     }                                                                    |
|                                                                          |
|     echo                                                                 |
|                                                                          |
|     while [ "$icount" -le "$ITERATIONS" ]                                |
|     do                                                                   |
|       my_read var                                                        |
|       echo "Entry #$icount = $var"                                       |
|       let "icount += 1"                                                  |
|       echo                                                               |
|     done                                                                 |
|                                                                          |
|                                                                          |
|     # Thanks to Stephane Chazelas for providing this instructive example |
| .                                                                        |
|                                                                          |
|     exit 0                                                               |
                                                                          
+--------------------------------------------------------------------------+

**Exit and Return**

**exit status**
    Functions return a value, called an *exit status*. This is analogous
    to the `exit status <exit-status.html#EXITSTATUSREF>`__ returned by
    a command. The exit status may be explicitly specified by a
    **return** statement, otherwise it is the exit status of the last
    command in the function (0 if successful, and a non-zero error code
    if not). This `exit status <exit-status.html#EXITSTATUSREF>`__ may
    be used in the script by referencing it as
    `$? <internalvariables.html#XSTATVARREF>`__. This mechanism
    effectively permits script functions to have a "return value"
    similar to C functions.

**return**
    Terminates a function. A **return** command
    `[1] <complexfunct.html#FTN.AEN18474>`__ optionally takes an
    *integer* argument, which is returned to the calling script as the
    "exit status" of the function, and this exit status is assigned to
    the variable `$? <internalvariables.html#XSTATVARREF>`__.

    **Example 24-7. Maximum of two numbers**

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     #!/bin/bash                                                          |
    |     # max.sh: Maximum of two integers.                                   |
    |                                                                          |
    |     E_PARAM_ERR=250    # If less than 2 params passed to function.       |
    |     EQUAL=251          # Return value if both params equal.              |
    |     #  Error values out of range of any                                  |
    |     #+ params that might be fed to the function.                         |
    |                                                                          |
    |     max2 ()             # Returns larger of two numbers.                 |
    |     {                   # Note: numbers compared must be less than 250.  |
    |     if [ -z "$2" ]                                                       |
    |     then                                                                 |
    |       return $E_PARAM_ERR                                                |
    |     fi                                                                   |
    |                                                                          |
    |     if [ "$1" -eq "$2" ]                                                 |
    |     then                                                                 |
    |       return $EQUAL                                                      |
    |     else                                                                 |
    |       if [ "$1" -gt "$2" ]                                               |
    |       then                                                               |
    |         return $1                                                        |
    |       else                                                               |
    |         return $2                                                        |
    |       fi                                                                 |
    |     fi                                                                   |
    |     }                                                                    |
    |                                                                          |
    |     max2 33 34                                                           |
    |     return_val=$?                                                        |
    |                                                                          |
    |     if [ "$return_val" -eq $E_PARAM_ERR ]                                |
    |     then                                                                 |
    |       echo "Need to pass two parameters to the function."                |
    |     elif [ "$return_val" -eq $EQUAL ]                                    |
    |       then                                                               |
    |         echo "The two numbers are equal."                                |
    |     else                                                                 |
    |         echo "The larger of the two numbers is $return_val."             |
    |     fi                                                                   |
    |                                                                          |
    |                                                                          |
    |     exit 0                                                               |
    |                                                                          |
    |     #  Exercise (easy):                                                  |
    |     #  ---------------                                                   |
    |     #  Convert this to an interactive script,                            |
    |     #+ that is, have the script ask for input (two numbers).             |
                                                                              
    +--------------------------------------------------------------------------+

    +--------------------------+--------------------------+--------------------------+
    | |Tip|                    |
    | For a function to return |
    | a string or array, use a |
    | dedicated variable.      |
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
    | |     count_lines_in_etc |
    | _passwd()                |
    |                          |
    |    |                     |
    | |     {                  |
    |                          |
    |                          |
    |    |                     |
    | |       [[ -r /etc/passw |
    | d ]] && REPLY=$(echo $(w |
    | c -l < /etc/passwd))     |
    |    |                     |
    | |       #  If /etc/passw |
    | d is readable, set REPLY |
    |  to line count.          |
    |    |                     |
    | |       #  Returns both  |
    | a parameter value and st |
    | atus information.        |
    |    |                     |
    | |       #  The 'echo' se |
    | ems unnecessary, but . . |
    |  .                       |
    |    |                     |
    | |       #+ it removes ex |
    | cess whitespace from the |
    |  output.                 |
    |    |                     |
    | |     }                  |
    |                          |
    |                          |
    |    |                     |
    | |                        |
    |                          |
    |                          |
    |    |                     |
    | |     if count_lines_in_ |
    | etc_passwd               |
    |                          |
    |    |                     |
    | |     then               |
    |                          |
    |                          |
    |    |                     |
    | |       echo "There are  |
    | $REPLY lines in /etc/pas |
    | swd."                    |
    |    |                     |
    | |     else               |
    |                          |
    |                          |
    |    |                     |
    | |       echo "Cannot cou |
    | nt lines in /etc/passwd. |
    | "                        |
    |    |                     |
    | |     fi                 |
    |                          |
    |                          |
    |    |                     |
    | |                        |
    |                          |
    |                          |
    |    |                     |
    | |     # Thanks, S.C.     |
    |                          |
    |                          |
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

    **Example 24-8. Converting numbers to Roman numerals**

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     #!/bin/bash                                                          |
    |                                                                          |
    |     # Arabic number to Roman numeral conversion                          |
    |     # Range: 0 - 200                                                     |
    |     # It's crude, but it works.                                          |
    |                                                                          |
    |     # Extending the range and otherwise improving the script is left as  |
    | an exercise.                                                             |
    |                                                                          |
    |     # Usage: roman number-to-convert                                     |
    |                                                                          |
    |     LIMIT=200                                                            |
    |     E_ARG_ERR=65                                                         |
    |     E_OUT_OF_RANGE=66                                                    |
    |                                                                          |
    |     if [ -z "$1" ]                                                       |
    |     then                                                                 |
    |       echo "Usage: `basename $0` number-to-convert"                      |
    |       exit $E_ARG_ERR                                                    |
    |     fi                                                                   |
    |                                                                          |
    |     num=$1                                                               |
    |     if [ "$num" -gt $LIMIT ]                                             |
    |     then                                                                 |
    |       echo "Out of range!"                                               |
    |       exit $E_OUT_OF_RANGE                                               |
    |     fi                                                                   |
    |                                                                          |
    |     to_roman ()   # Must declare function before first call to it.       |
    |     {                                                                    |
    |     number=$1                                                            |
    |     factor=$2                                                            |
    |     rchar=$3                                                             |
    |     let "remainder = number - factor"                                    |
    |     while [ "$remainder" -ge 0 ]                                         |
    |     do                                                                   |
    |       echo -n $rchar                                                     |
    |       let "number -= factor"                                             |
    |       let "remainder = number - factor"                                  |
    |     done                                                                 |
    |                                                                          |
    |     return $number                                                       |
    |            # Exercises:                                                  |
    |            # ---------                                                   |
    |            # 1) Explain how this function works.                         |
    |            #    Hint: division by successive subtraction.                |
    |            # 2) Extend to range of the function.                         |
    |            #    Hint: use "echo" and command-substitution capture.       |
    |     }                                                                    |
    |                                                                          |
    |                                                                          |
    |     to_roman $num 100 C                                                  |
    |     num=$?                                                               |
    |     to_roman $num 90 LXXXX                                               |
    |     num=$?                                                               |
    |     to_roman $num 50 L                                                   |
    |     num=$?                                                               |
    |     to_roman $num 40 XL                                                  |
    |     num=$?                                                               |
    |     to_roman $num 10 X                                                   |
    |     num=$?                                                               |
    |     to_roman $num 9 IX                                                   |
    |     num=$?                                                               |
    |     to_roman $num 5 V                                                    |
    |     num=$?                                                               |
    |     to_roman $num 4 IV                                                   |
    |     num=$?                                                               |
    |     to_roman $num 1 I                                                    |
    |     # Successive calls to conversion function!                           |
    |     # Is this really necessary??? Can it be simplified?                  |
    |                                                                          |
    |     echo                                                                 |
    |                                                                          |
    |     exit                                                                 |
                                                                              
    +--------------------------------------------------------------------------+

    See also `Example 11-29 <testbranch.html#ISALPHA>`__.

    +-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+
    | |Impo |
    | rtant |
    | |     |
    | The   |
    | large |
    | st    |
    | posit |
    | ive   |
    | integ |
    | er    |
    | a     |
    | funct |
    | ion   |
    | can   |
    | retur |
    | n     |
    | is    |
    | 255.  |
    | The   |
    | **ret |
    | urn** |
    | comma |
    | nd    |
    | is    |
    | close |
    | ly    |
    | tied  |
    | to    |
    | the   |
    | conce |
    | pt    |
    | of    |
    | `exit |
    | statu |
    | s <ex |
    | it-st |
    | atus. |
    | html# |
    | EXITS |
    | TATUS |
    | REF>` |
    | __,   |
    | which |
    | accou |
    | nts   |
    | for   |
    | this  |
    | parti |
    | cular |
    | limit |
    | ation |
    | .     |
    | Fortu |
    | natel |
    | y,    |
    | there |
    | are   |
    | vario |
    | us    |
    | `work |
    | aroun |
    | ds <a |
    | ssort |
    | edtip |
    | s.htm |
    | l#RVT |
    | >`__  |
    | for   |
    | those |
    | situa |
    | tions |
    | requi |
    | ring  |
    | a     |
    | large |
    | integ |
    | er    |
    | retur |
    | n     |
    | value |
    | from  |
    | a     |
    | funct |
    | ion.  |
    |       |
    | **Exa |
    | mple  |
    | 24-9. |
    | Testi |
    | ng    |
    | large |
    | retur |
    | n     |
    | value |
    | s     |
    | in a  |
    | funct |
    | ion** |
    |       |
    | +---- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | +     |
    | | ..  |
    | code: |
    | : PRO |
    | GRAML |
    | ISTIN |
    | G     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #!/b |
    | in/ba |
    | sh    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # re |
    | turn- |
    | test. |
    | sh    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # Th |
    | e lar |
    | gest  |
    | posit |
    | ive v |
    | alue  |
    | a fun |
    | ction |
    |  can  |
    | retur |
    | n is  |
    | 255.  |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  retu |
    | rn_te |
    | st () |
    |       |
    |     # |
    |  Retu |
    | rns w |
    | hatev |
    | er pa |
    | ssed  |
    | to it |
    | .     |
    |       |
    |       |
    | |     |
    | |     |
    |  {    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    re |
    | turn  |
    | $1    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  }    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  retu |
    | rn_te |
    | st 27 |
    |       |
    |     # |
    |  o.k. |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  $?   |
    |       |
    |       |
    |     # |
    |  Retu |
    | rns 2 |
    | 7.    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  retu |
    | rn_te |
    | st 25 |
    | 5     |
    |     # |
    |  Stil |
    | l o.k |
    | .     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  $?   |
    |       |
    |       |
    |     # |
    |  Retu |
    | rns 2 |
    | 55.   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  retu |
    | rn_te |
    | st 25 |
    | 7     |
    |     # |
    |  Erro |
    | r!    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  $?   |
    |       |
    |       |
    |     # |
    |  Retu |
    | rns 1 |
    |  (ret |
    | urn c |
    | ode f |
    | or mi |
    | scell |
    | aneou |
    | s er  |
    | |     |
    | | ror |
    | ).    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # == |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    |       |
    |       |
    | |     |
    | |     |
    |  retu |
    | rn_te |
    | st -1 |
    | 51896 |
    |     # |
    |  Do l |
    | arge  |
    | negat |
    | ive n |
    | umber |
    | s wor |
    | k?    |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  $?   |
    |       |
    |       |
    |     # |
    |  Will |
    |  this |
    |  retu |
    | rn -1 |
    | 51896 |
    | ?     |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |     # |
    |  No!  |
    | It re |
    | turns |
    |  168. |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  V |
    | ersio |
    | n of  |
    | Bash  |
    | befor |
    | e 2.0 |
    | 5b pe |
    | rmitt |
    | ed    |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #+ l |
    | arge  |
    | negat |
    | ive i |
    | ntege |
    | r ret |
    | urn v |
    | alues |
    | .     |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  I |
    | t hap |
    | pened |
    |  to b |
    | e a u |
    | seful |
    |  feat |
    | ure.  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  N |
    | ewer  |
    | versi |
    | ons o |
    | f Bas |
    | h unf |
    | ortun |
    | ately |
    |  plug |
    |  this |
    |  loop |
    | hole. |
    |       |
    |       |
    | |     |
    | |     |
    |  #  T |
    | his m |
    | ay br |
    | eak o |
    | lder  |
    | scrip |
    | ts.   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  C |
    | autio |
    | n!    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # == |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  exit |
    |  0    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
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
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | +     |
    |       |
    | A     |
    | worka |
    | round |
    | for   |
    | obtai |
    | ning  |
    | large |
    | integ |
    | er    |
    | "retu |
    | rn    |
    | value |
    | s"    |
    | is to |
    | simpl |
    | y     |
    | assig |
    | n     |
    | the   |
    | "retu |
    | rn    |
    | value |
    | "     |
    | to a  |
    | globa |
    | l     |
    | varia |
    | ble.  |
    |       |
    | +---- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | +     |
    | | ..  |
    | code: |
    | : PRO |
    | GRAML |
    | ISTIN |
    | G     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  Retu |
    | rn_Va |
    | l=    |
    | # Glo |
    | bal v |
    | ariab |
    | le to |
    |  hold |
    |  over |
    | size  |
    | retur |
    | n val |
    | ue of |
    |  fun  |
    | |     |
    | | cti |
    | on.   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  alt_ |
    | retur |
    | n_tes |
    | t ()  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  {    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    fv |
    | ar=$1 |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    Re |
    | turn_ |
    | Val=$ |
    | fvar  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    re |
    | turn  |
    |   # R |
    | eturn |
    | s 0 ( |
    | succe |
    | ss).  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  }    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  alt_ |
    | retur |
    | n_tes |
    | t 1   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  $?   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |    #  |
    | 0     |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  "ret |
    | urn v |
    | alue  |
    | = $Re |
    | turn_ |
    | Val"  |
    |    #  |
    | 1     |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  alt_ |
    | retur |
    | n_tes |
    | t 256 |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  "ret |
    | urn v |
    | alue  |
    | = $Re |
    | turn_ |
    | Val"  |
    |    #  |
    | 256   |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  alt_ |
    | retur |
    | n_tes |
    | t 257 |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  "ret |
    | urn v |
    | alue  |
    | = $Re |
    | turn_ |
    | Val"  |
    |    #  |
    | 257   |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  alt_ |
    | retur |
    | n_tes |
    | t 257 |
    | 01    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  "ret |
    | urn v |
    | alue  |
    | = $Re |
    | turn_ |
    | Val"  |
    |    #2 |
    | 5701  |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
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
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | +     |
    |       |
    | A     |
    | more  |
    | elega |
    | nt    |
    | metho |
    | d     |
    | is to |
    | have  |
    | the   |
    | funct |
    | ion   |
    | **ech |
    | o**   |
    | its   |
    | "retu |
    | rn    |
    | value |
    | to    |
    | ``std |
    | out`` |
    | ,"    |
    | and   |
    | then  |
    | captu |
    | re    |
    | it by |
    | `comm |
    | and   |
    | subst |
    | ituti |
    | on <c |
    | omman |
    | dsub. |
    | html# |
    | COMMA |
    | NDSUB |
    | REF>` |
    | __.   |
    | See   |
    | the   |
    | `disc |
    | ussio |
    | n     |
    | of    |
    | this  |
    | <asso |
    | rtedt |
    | ips.h |
    | tml#R |
    | VT>`_ |
    | _     |
    | in    |
    | `Sect |
    | ion   |
    | 36.7  |
    | <asso |
    | rtedt |
    | ips.h |
    | tml>` |
    | __.   |
    |       |
    | **Exa |
    | mple  |
    | 24-10 |
    | .     |
    | Compa |
    | ring  |
    | two   |
    | large |
    | integ |
    | ers** |
    |       |
    | +---- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | +     |
    | | ..  |
    | code: |
    | : PRO |
    | GRAML |
    | ISTIN |
    | G     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #!/b |
    | in/ba |
    | sh    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # ma |
    | x2.sh |
    | : Max |
    | imum  |
    | of tw |
    | o LAR |
    | GE in |
    | teger |
    | s.    |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  T |
    | his i |
    | s the |
    |  prev |
    | ious  |
    | "max. |
    | sh" e |
    | xampl |
    | e,    |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #+ m |
    | odifi |
    | ed to |
    |  perm |
    | it co |
    | mpari |
    | ng la |
    | rge i |
    | ntege |
    | rs.   |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  EQUA |
    | L=0   |
    |       |
    |       |
    |  # Re |
    | turn  |
    | value |
    |  if b |
    | oth p |
    | arams |
    |  equa |
    | l.    |
    |       |
    |       |
    | |     |
    | |     |
    |  E_PA |
    | RAM_E |
    | RR=-9 |
    | 9999  |
    |  # No |
    | t eno |
    | ugh p |
    | arams |
    |  pass |
    | ed to |
    |  func |
    | tion. |
    |       |
    |       |
    | |     |
    | |     |
    |  #    |
    |       |
    |    ^^ |
    | ^^^^  |
    |    Ou |
    | t of  |
    | range |
    |  of a |
    | ny pa |
    | rams  |
    | that  |
    | might |
    |  be p |
    | asse  |
    | |     |
    | | d.  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  max2 |
    |  ()   |
    |       |
    |       |
    |  # "R |
    | eturn |
    | s" la |
    | rger  |
    | of tw |
    | o num |
    | bers. |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  {    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  if [ |
    |  -z " |
    | $2" ] |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  then |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    ec |
    | ho $E |
    | _PARA |
    | M_ERR |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    re |
    | turn  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  fi   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  if [ |
    |  "$1" |
    |  -eq  |
    | "$2"  |
    | ]     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  then |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    ec |
    | ho $E |
    | QUAL  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    re |
    | turn  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  else |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    if |
    |  [ "$ |
    | 1" -g |
    | t "$2 |
    | " ]   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    th |
    | en    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    | retva |
    | l=$1  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    el |
    | se    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    | retva |
    | l=$2  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    fi |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  fi   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  $ret |
    | val   |
    |       |
    |  # Ec |
    | hoes  |
    | (to s |
    | tdout |
    | ), ra |
    | ther  |
    | than  |
    | retur |
    | ning  |
    | valu  |
    | |     |
    | | e.  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |  # Wh |
    | y?    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  }    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  retu |
    | rn_va |
    | l=$(m |
    | ax2 3 |
    | 3001  |
    | 33997 |
    | )     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #    |
    |       |
    |     ^ |
    | ^^^   |
    |       |
    |       |
    |  Func |
    | tion  |
    | name  |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #    |
    |       |
    |       |
    |     ^ |
    | ^^^^  |
    | ^^^^^ |
    |  Para |
    | ms pa |
    | ssed  |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  T |
    | his i |
    | s act |
    | ually |
    |  a fo |
    | rm of |
    |  comm |
    | and s |
    | ubsti |
    | tutio |
    | n:    |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #+ t |
    | reati |
    | ng a  |
    | funct |
    | ion a |
    | s if  |
    | it we |
    | re a  |
    | comma |
    | nd,   |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #+ a |
    | nd as |
    | signi |
    | ng th |
    | e std |
    | out o |
    | f the |
    |  func |
    | tion  |
    | to th |
    | e var |
    | iable |
    |  "ret |
    | urn_  |
    | |     |
    | | val |
    | ."    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # == |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | === O |
    | UTPUT |
    |  ==== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    |       |
    |       |
    | |     |
    | |     |
    |  if [ |
    |  "$re |
    | turn_ |
    | val"  |
    | -eq " |
    | $E_PA |
    | RAM_E |
    | RR" ] |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    th |
    | en    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    ec |
    | ho "E |
    | rror  |
    | in pa |
    | ramet |
    | ers p |
    | assed |
    |  to c |
    | ompar |
    | ison  |
    | funct |
    | ion!" |
    |       |
    |       |
    | |     |
    | |     |
    |  elif |
    |  [ "$ |
    | retur |
    | n_val |
    | " -eq |
    |  "$EQ |
    | UAL"  |
    | ]     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |    th |
    | en    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    | echo  |
    | "The  |
    | two n |
    | umber |
    | s are |
    |  equa |
    | l."   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  else |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    | echo  |
    | "The  |
    | large |
    | r of  |
    | the t |
    | wo nu |
    | mbers |
    |  is $ |
    | retur |
    | n_val |
    | ."    |
    |       |
    |       |
    | |     |
    | |     |
    |  fi   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # == |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  exit |
    |  0    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  E |
    | xerci |
    | ses:  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  - |
    | ----- |
    | ---   |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  1 |
    | ) Fin |
    | d a m |
    | ore e |
    | legan |
    | t way |
    |  of t |
    | estin |
    | g     |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #+   |
    |   the |
    |  para |
    | meter |
    | s pas |
    | sed t |
    | o the |
    |  func |
    | tion. |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  2 |
    | ) Sim |
    | plify |
    |  the  |
    | if/th |
    | en st |
    | ructu |
    | re at |
    |  "OUT |
    | PUT." |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  3 |
    | ) Rew |
    | rite  |
    | the s |
    | cript |
    |  to t |
    | ake i |
    | nput  |
    | from  |
    | comma |
    | nd-li |
    | ne pa |
    | ramet |
    | ers.  |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
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
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | +     |
    |       |
    | Here  |
    | is    |
    | anoth |
    | er    |
    | examp |
    | le    |
    | of    |
    | captu |
    | ring  |
    | a     |
    | funct |
    | ion   |
    | "retu |
    | rn    |
    | value |
    | ."    |
    | Under |
    | stand |
    | ing   |
    | it    |
    | requi |
    | res   |
    | some  |
    | knowl |
    | edge  |
    | of    |
    | `awk  |
    | <awk. |
    | html# |
    | AWKRE |
    | F>`__ |
    | .     |
    |       |
    | +---- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | +     |
    | | ..  |
    | code: |
    | : PRO |
    | GRAML |
    | ISTIN |
    | G     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  mont |
    | h_len |
    | gth ( |
    | )  #  |
    | Takes |
    |  mont |
    | h num |
    | ber a |
    | s an  |
    | argum |
    | ent.  |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  {    |
    |       |
    |       |
    |    #  |
    | Retur |
    | ns nu |
    | mber  |
    | of da |
    | ys in |
    |  mont |
    | h.    |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  mont |
    | hD="3 |
    | 1 28  |
    | 31 30 |
    |  31 3 |
    | 0 31  |
    | 31 30 |
    |  31 3 |
    | 0 31" |
    |   # D |
    | eclar |
    | e as  |
    | local |
    | ?     |
    | |     |
    | |     |
    |  echo |
    |  "$mo |
    | nthD" |
    |  | aw |
    | k '{  |
    | print |
    |  $'"$ |
    | {1}"' |
    |  }'   |
    |   # T |
    | ricky |
    | .     |
    |       |
    |       |
    | |     |
    | |     |
    |  #    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |  ^^^^ |
    | ^^^^^ |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # Pa |
    | ramet |
    | er pa |
    | ssed  |
    | to fu |
    | nctio |
    | n  ($ |
    | 1 --  |
    | month |
    |  numb |
    | er),  |
    | then  |
    | to aw |
    | k.    |
    | |     |
    | |     |
    |  # Aw |
    | k see |
    | s thi |
    | s as  |
    | "prin |
    | t $1  |
    | . . . |
    |  prin |
    | t $12 |
    | " (de |
    | pendi |
    | ng on |
    |  mont |
    | h nu  |
    | |     |
    | | mbe |
    | r)    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # Te |
    | mplat |
    | e for |
    |  pass |
    | ing a |
    |  para |
    | meter |
    |  to e |
    | mbedd |
    | ed aw |
    | k scr |
    | ipt:  |
    |       |
    |       |
    | |     |
    | |     |
    |  #    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | $'"${ |
    | scrip |
    | t_par |
    | amete |
    | r}"'  |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #    |
    |  Here |
    | 's a  |
    | sligh |
    | tly s |
    | imple |
    | r awk |
    |  cons |
    | truct |
    | :     |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #    |
    |  echo |
    |  $mon |
    | thD | |
    |  awk  |
    | -v mo |
    | nth=$ |
    | 1 '{p |
    | rint  |
    | $(mon |
    | th)}' |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #    |
    |  Uses |
    |  the  |
    | -v aw |
    | k opt |
    | ion,  |
    | which |
    |  assi |
    | gns a |
    |  vari |
    | able  |
    | value |
    |       |
    |       |
    | |     |
    | |     |
    |  #+   |
    |  prio |
    | r to  |
    | execu |
    | tion  |
    | of th |
    | e awk |
    |  prog |
    | ram b |
    | lock. |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #    |
    |  Than |
    | k you |
    | , Ric |
    | h.    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  #  N |
    | eeds  |
    | error |
    |  chec |
    | king  |
    | for c |
    | orrec |
    | t par |
    | amete |
    | r ran |
    | ge (1 |
    | -12)  |
    |       |
    |       |
    | |     |
    | |     |
    |  #+ a |
    | nd fo |
    | r Feb |
    | ruary |
    |  in l |
    | eap y |
    | ear.  |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  }    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # -- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----  |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # Us |
    | age e |
    | xampl |
    | e:    |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  mont |
    | h=4   |
    |       |
    |  # Ap |
    | ril,  |
    | for e |
    | xampl |
    | e (4t |
    | h mon |
    | th).  |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  days |
    | _in=$ |
    | (mont |
    | h_len |
    | gth $ |
    | month |
    | )     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  echo |
    |  $day |
    | s_in  |
    |  # 30 |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    | |     |
    | |     |
    |  # -- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----  |
    |       |
    |       |
    |       |
    |       |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
    |       |
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
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | +     |
    |       |
    | See   |
    | also  |
    | `Exam |
    | ple   |
    | A-7 < |
    | contr |
    | ibute |
    | d-scr |
    | ipts. |
    | html# |
    | DAYSB |
    | ETWEE |
    | N>`__ |
    | and   |
    | `Exam |
    | ple   |
    | A-37  |
    | <cont |
    | ribut |
    | ed-sc |
    | ripts |
    | .html |
    | #STDD |
    | EV>`_ |
    | _.    |
    |       |
    | ``Exe |
    | rcise |
    | :``   |
    | Using |
    | what  |
    | we    |
    | have  |
    | just  |
    | learn |
    | ed,   |
    | exten |
    | d     |
    | the   |
    | previ |
    | ous   |
    | `Roma |
    | n     |
    | numer |
    | als   |
    | examp |
    | le <c |
    | omple |
    | xfunc |
    | t.htm |
    | l#EX6 |
    | 1>`__ |
    | to    |
    | accep |
    | t     |
    | arbit |
    | raril |
    | y     |
    | large |
    | input |
    | .     |
    +-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+

**Redirection**

``Redirecting the stdin         of a function``
    A function is essentially a `code
    block <special-chars.html#CODEBLOCKREF>`__, which means its
    ``stdin`` can be redirected (as in `Example
    3-1 <special-chars.html#EX8>`__).

    **Example 24-11. Real name from username**

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     #!/bin/bash                                                          |
    |     # realname.sh                                                        |
    |     #                                                                    |
    |     # From username, gets "real name" from /etc/passwd.                  |
    |                                                                          |
    |                                                                          |
    |     ARGCOUNT=1       # Expect one arg.                                   |
    |     E_WRONGARGS=85                                                       |
    |                                                                          |
    |     file=/etc/passwd                                                     |
    |     pattern=$1                                                           |
    |                                                                          |
    |     if [ $# -ne "$ARGCOUNT" ]                                            |
    |     then                                                                 |
    |       echo "Usage: `basename $0` USERNAME"                               |
    |       exit $E_WRONGARGS                                                  |
    |     fi                                                                   |
    |                                                                          |
    |     file_excerpt ()    #  Scan file for pattern,                         |
    |     {                  #+ then print relevant portion of line.           |
    |       while read line  # "while" does not necessarily need [ condition ] |
    |       do                                                                 |
    |         echo "$line" | grep $1 | awk -F":" '{ print $5 }'                |
    |         # Have awk use ":" delimiter.                                    |
    |       done                                                               |
    |     } <$file  # Redirect into function's stdin.                          |
    |                                                                          |
    |     file_excerpt $pattern                                                |
    |                                                                          |
    |     # Yes, this entire script could be reduced to                        |
    |     #       grep PATTERN /etc/passwd | awk -F":" '{ print $5 }'          |
    |     # or                                                                 |
    |     #       awk -F: '/PATTERN/ {print $5}'                               |
    |     # or                                                                 |
    |     #       awk -F: '($1 == "username") { print $5 }' # real name from u |
    | sername                                                                  |
    |     # However, it might not be as instructive.                           |
    |                                                                          |
    |     exit 0                                                               |
                                                                              
    +--------------------------------------------------------------------------+

    There is an alternate, and perhaps less confusing method of
    redirecting a function's ``stdin``. This involves redirecting the
    ``stdin`` to an embedded bracketed code block within the function.

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     # Instead of:                                                        |
    |     Function ()                                                          |
    |     {                                                                    |
    |      ...                                                                 |
    |      } < file                                                            |
    |                                                                          |
    |     # Try this:                                                          |
    |     Function ()                                                          |
    |     {                                                                    |
    |       {                                                                  |
    |         ...                                                              |
    |        } < file                                                          |
    |     }                                                                    |
    |                                                                          |
    |     # Similarly,                                                         |
    |                                                                          |
    |     Function ()  # This works.                                           |
    |     {                                                                    |
    |       {                                                                  |
    |        echo $*                                                           |
    |       } | tr a b                                                         |
    |     }                                                                    |
    |                                                                          |
    |     Function ()  # This doesn't work.                                    |
    |     {                                                                    |
    |       echo $*                                                            |
    |     } | tr a b   # A nested code block is mandatory here.                |
    |                                                                          |
    |                                                                          |
    |     # Thanks, S.C.                                                       |
                                                                              
    +--------------------------------------------------------------------------+

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Emmanuel Rouat's `sample ``bashrc``  |
    | file <sample-bashrc.html>`__         |
    | contains some instructive examples   |
    | of functions.                        |
    +--------------------------------------+--------------------------------------+

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <complexfunct.html#AEN18474>`__ |
| The **return** command is a Bash     |
| `builtin <internal.html#BUILTINREF>` |
| __.                                  |
+--------------------------------------+--------------------------------------+

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <functions.html>`_ | Functions                |
| _                        | `Up <functions.html>`__  |
| `Home <index.html>`__    | Local Variables          |
| `Next <localvar.html>`__ |                          |
+--------------------------+--------------------------+--------------------------+

.. |Important| image:: ../images/important.gif
.. |Tip| image:: ../images/tip.gif
.. |Note| image:: ../images/note.gif
