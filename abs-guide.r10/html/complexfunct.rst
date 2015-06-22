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

`Prev <functions.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 24. Functions

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

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
=================================================

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
`positional parameters <internalvariables.html#POSPARAMREF>`__), that
is, ``$1``, ``$2``, and so forth.

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
| ION>`__).                            |
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
are actually *pointers*), if passed as parameters to functions, will be
treated as string literals. *Functions interpret their arguments
literally.*

`Indirect variable references <ivr.html#IVRREF>`__ (see `Example
37-2 <bashver2.html#EX78>`__) provide a clumsy sort of mechanism for
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

    +--------------------+--------------------+--------------------+--------------------+
    | |Tip|              |
    | For a function to  |
    | return a string or |
    | array, use a       |
    | dedicated          |
    | variable.          |
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
    | |     count_lines_ |
    | in_etc_p |         |
    | | asswd()          |
    |          |         |
    | |     {            |
    |          |         |
    | |       [[ -r /etc |
    | /passwd  |         |
    | | ]] && REPLY=$(ec |
    | ho $(wc  |         |
    | | -l < /etc/passwd |
    | ))       |         |
    | |       #  If /etc |
    | /passwd  |         |
    | | is readable, set |
    |  REPLY t |         |
    | | o line count.    |
    |          |         |
    | |       #  Returns |
    |  both a  |         |
    | | parameter value  |
    | and stat |         |
    | | us information.  |
    |          |         |
    | |       #  The 'ec |
    | ho' seem |         |
    | | s unnecessary, b |
    | ut . . . |         |
    | |       #+ it remo |
    | ves exce |         |
    | | ss whitespace fr |
    | om the o |         |
    | | utput.           |
    |          |         |
    | |     }            |
    |          |         |
    | |                  |
    |          |         |
    | |     if count_lin |
    | es_in_et |         |
    | | c_passwd         |
    |          |         |
    | |     then         |
    |          |         |
    | |       echo "Ther |
    | e are $R |         |
    | | EPLY lines in /e |
    | tc/passw |         |
    | | d."              |
    |          |         |
    | |     else         |
    |          |         |
    | |       echo "Cann |
    | ot count |         |
    | |  lines in /etc/p |
    | asswd."  |         |
    | |     fi           |
    |          |         |
    | |                  |
    |          |         |
    | |     # Thanks, S. |
    | C.       |         |
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

    See also `Example 11-29 <testbranch.html#ISALPHA>`__.

    .. raw:: html

       <div class="IMPORTANT">

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
    | in/ba |
    | sh    |
    |       |
    |   |   |
    | |     |
    |  # re |
    | turn- |
    | test. |
    | sh    |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  # Th |
    | e lar |
    | gest  |
    | posit |
    | i |   |
    | | ve  |
    | value |
    |  a fu |
    | nctio |
    | n can |
    |   |   |
    | | ret |
    | urn i |
    | s 255 |
    | .     |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  retu |
    | rn_te |
    | st () |
    |       |
    |   |   |
    | |     |
    | # Ret |
    | urns  |
    | whate |
    | ver p |
    | a |   |
    | | sse |
    | d to  |
    | it.   |
    |       |
    |       |
    |   |   |
    | |     |
    |  {    |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |    re |
    | turn  |
    | $1    |
    |       |
    |   |   |
    | |     |
    |  }    |
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
    |  retu |
    | rn_te |
    | st 27 |
    |       |
    |   |   |
    | |     |
    | # o.k |
    | .     |
    |       |
    |       |
    |   |   |
    | |     |
    |  echo |
    |  $?   |
    |       |
    |       |
    |   |   |
    | |     |
    | # Ret |
    | urns  |
    | 27.   |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  retu |
    | rn_te |
    | st 25 |
    | 5     |
    |   |   |
    | |     |
    | # Sti |
    | ll o. |
    | k.    |
    |       |
    |   |   |
    | |     |
    |  echo |
    |  $?   |
    |       |
    |       |
    |   |   |
    | |     |
    | # Ret |
    | urns  |
    | 255.  |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  retu |
    | rn_te |
    | st 25 |
    | 7     |
    |   |   |
    | |     |
    | # Err |
    | or!   |
    |       |
    |       |
    |   |   |
    | |     |
    |  echo |
    |  $?   |
    |       |
    |       |
    |   |   |
    | |     |
    | # Ret |
    | urns  |
    | 1 (re |
    | turn  |
    | c |   |
    | | ode |
    |  for  |
    | misce |
    | llane |
    | ous e |
    | r |   |
    | | ror |
    | ).    |
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
    |  # == |
    | ===== |
    | ===== |
    | ===== |
    | = |   |
    | | === |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | = |   |
    | | === |
    | ===== |
    | ===== |
    | ==    |
    |       |
    |   |   |
    | |     |
    |  retu |
    | rn_te |
    | st -1 |
    | 51896 |
    |   |   |
    | |     |
    | # Do  |
    | large |
    |  nega |
    | tive  |
    | n |   |
    | | umb |
    | ers w |
    | ork?  |
    |       |
    |       |
    |   |   |
    | |     |
    |  echo |
    |  $?   |
    |       |
    |       |
    |   |   |
    | |     |
    | # Wil |
    | l thi |
    | s ret |
    | urn - |
    | 1 |   |
    | | 518 |
    | 96?   |
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
    | # No! |
    |  It r |
    | eturn |
    | s 168 |
    | . |   |
    | |     |
    |  #  V |
    | ersio |
    | n of  |
    | Bash  |
    | b |   |
    | | efo |
    | re 2. |
    | 05b p |
    | ermit |
    | ted   |
    |   |   |
    | |     |
    |  #+ l |
    | arge  |
    | negat |
    | ive i |
    | n |   |
    | | teg |
    | er re |
    | turn  |
    | value |
    | s.    |
    |   |   |
    | |     |
    |  #  I |
    | t hap |
    | pened |
    |  to b |
    | e |   |
    | |  a  |
    | usefu |
    | l fea |
    | ture. |
    |       |
    |   |   |
    | |     |
    |  #  N |
    | ewer  |
    | versi |
    | ons o |
    | f |   |
    | |  Ba |
    | sh un |
    | fortu |
    | natel |
    | y plu |
    | g |   |
    | |  th |
    | is lo |
    | ophol |
    | e.    |
    |       |
    |   |   |
    | |     |
    |  #  T |
    | his m |
    | ay br |
    | eak o |
    | l |   |
    | | der |
    |  scri |
    | pts.  |
    |       |
    |       |
    |   |   |
    | |     |
    |  #  C |
    | autio |
    | n!    |
    |       |
    |   |   |
    | |     |
    |  # == |
    | ===== |
    | ===== |
    | ===== |
    | = |   |
    | | === |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | = |   |
    | | === |
    | ===== |
    | ===== |
    | ==    |
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
    |  0    |
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
    |  Retu |
    | rn_Va |
    | l=    |
    | # Glo |
    | b |   |
    | | al  |
    | varia |
    | ble t |
    | o hol |
    | d ove |
    | r |   |
    | | siz |
    | e ret |
    | urn v |
    | alue  |
    | of fu |
    | n |   |
    | | cti |
    | on.   |
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
    |  alt_ |
    | retur |
    | n_tes |
    | t ()  |
    |   |   |
    | |     |
    |  {    |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |    fv |
    | ar=$1 |
    |       |
    |       |
    |   |   |
    | |     |
    |    Re |
    | turn_ |
    | Val=$ |
    | fvar  |
    |   |   |
    | |     |
    |    re |
    | turn  |
    |   # R |
    | eturn |
    | s |   |
    | |  0  |
    | (succ |
    | ess). |
    |       |
    |       |
    |   |   |
    | |     |
    |  }    |
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
    |  alt_ |
    | retur |
    | n_tes |
    | t 1   |
    |   |   |
    | |     |
    |  echo |
    |  $?   |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |     # |
    |  0    |
    |   |   |
    | |     |
    |  echo |
    |  "ret |
    | urn v |
    | alue  |
    | = |   |
    | |  $R |
    | eturn |
    | _Val" |
    |     # |
    |  1    |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  alt_ |
    | retur |
    | n_tes |
    | t 256 |
    |   |   |
    | |     |
    |  echo |
    |  "ret |
    | urn v |
    | alue  |
    | = |   |
    | |  $R |
    | eturn |
    | _Val" |
    |     # |
    |  256  |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  alt_ |
    | retur |
    | n_tes |
    | t 257 |
    |   |   |
    | |     |
    |  echo |
    |  "ret |
    | urn v |
    | alue  |
    | = |   |
    | |  $R |
    | eturn |
    | _Val" |
    |     # |
    |  257  |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  alt_ |
    | retur |
    | n_tes |
    | t 257 |
    | 0 |   |
    | | 1   |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  echo |
    |  "ret |
    | urn v |
    | alue  |
    | = |   |
    | |  $R |
    | eturn |
    | _Val" |
    |     # |
    | 25701 |
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
    | in/ba |
    | sh    |
    |       |
    |   |   |
    | |     |
    |  # ma |
    | x2.sh |
    | : Max |
    | imum  |
    | o |   |
    | | f t |
    | wo LA |
    | RGE i |
    | ntege |
    | rs.   |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  #  T |
    | his i |
    | s the |
    |  prev |
    | i |   |
    | | ous |
    |  "max |
    | .sh"  |
    | examp |
    | le,   |
    |   |   |
    | |     |
    |  #+ m |
    | odifi |
    | ed to |
    |  perm |
    | i |   |
    | | t c |
    | ompar |
    | ing l |
    | arge  |
    | integ |
    | e |   |
    | | rs. |
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
    |  EQUA |
    | L=0   |
    |       |
    |       |
    |   |   |
    | | # R |
    | eturn |
    |  valu |
    | e if  |
    | both  |
    | p |   |
    | | ara |
    | ms eq |
    | ual.  |
    |       |
    |       |
    |   |   |
    | |     |
    |  E_PA |
    | RAM_E |
    | RR=-9 |
    | 9999  |
    |   |   |
    | | # N |
    | ot en |
    | ough  |
    | param |
    | s pas |
    | s |   |
    | | ed  |
    | to fu |
    | nctio |
    | n.    |
    |       |
    |   |   |
    | |     |
    |  #    |
    |       |
    |    ^^ |
    | ^^^^  |
    |   |   |
    | |   O |
    | ut of |
    |  rang |
    | e of  |
    | any p |
    | a |   |
    | | ram |
    | s tha |
    | t mig |
    | ht be |
    |  pass |
    | e |   |
    | | d.  |
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
    |  max2 |
    |  ()   |
    |       |
    |       |
    |   |   |
    | | # " |
    | Retur |
    | ns" l |
    | arger |
    |  of t |
    | w |   |
    | | o n |
    | umber |
    | s.    |
    |       |
    |       |
    |   |   |
    | |     |
    |  {    |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  if [ |
    |  -z " |
    | $2" ] |
    |       |
    |   |   |
    | |     |
    |  then |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |    ec |
    | ho $E |
    | _PARA |
    | M_ERR |
    |   |   |
    | |     |
    |    re |
    | turn  |
    |       |
    |       |
    |   |   |
    | |     |
    |  fi   |
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
    |  if [ |
    |  "$1" |
    |  -eq  |
    | "$2"  |
    | ] |   |
    | |     |
    |  then |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |    ec |
    | ho $E |
    | QUAL  |
    |       |
    |   |   |
    | |     |
    |    re |
    | turn  |
    |       |
    |       |
    |   |   |
    | |     |
    |  else |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |    if |
    |  [ "$ |
    | 1" -g |
    | t "$2 |
    | " |   |
    | |  ]  |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |    th |
    | en    |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    | retva |
    | l=$1  |
    |       |
    |   |   |
    | |     |
    |    el |
    | se    |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    | retva |
    | l=$2  |
    |       |
    |   |   |
    | |     |
    |    fi |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  fi   |
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
    |  $ret |
    | val   |
    |       |
    |   |   |
    | | # E |
    | choes |
    |  (to  |
    | stdou |
    | t), r |
    | a |   |
    | | the |
    | r tha |
    | n ret |
    | urnin |
    | g val |
    | u |   |
    | | e.  |
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
    | | # W |
    | hy?   |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  }    |
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
    |       |
    |       |
    |   |   |
    | |     |
    |  retu |
    | rn_va |
    | l=$(m |
    | ax2 3 |
    | 3 |   |
    | | 001 |
    |  3399 |
    | 7)    |
    |       |
    |       |
    |   |   |
    | |     |
    |  #    |
    |       |
    |     ^ |
    | ^^^   |
    |   |   |
    | |     |
    |       |
    |   Fun |
    | ction |
    |  name |
    |   |   |
    | |     |
    |  #    |
    |       |
    |       |
    |     ^ |
    | ^ |   |
    | | ^^^ |
    |  ^^^^ |
    | ^ Par |
    | ams p |
    | assed |
    |   |   |
    | |     |
    |  #  T |
    | his i |
    | s act |
    | ually |
    |   |   |
    | | a f |
    | orm o |
    | f com |
    | mand  |
    | subst |
    | i |   |
    | | tut |
    | ion:  |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  #+ t |
    | reati |
    | ng a  |
    | funct |
    | i |   |
    | | on  |
    | as if |
    |  it w |
    | ere a |
    |  comm |
    | a |   |
    | | nd, |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  #+ a |
    | nd as |
    | signi |
    | ng th |
    | e |   |
    | |  st |
    | dout  |
    | of th |
    | e fun |
    | ction |
    |   |   |
    | | to  |
    | the v |
    | ariab |
    | le "r |
    | eturn |
    | _ |   |
    | | val |
    | ."    |
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
    |       |
    |       |
    |   |   |
    | |     |
    |  # == |
    | ===== |
    | ===== |
    | ===== |
    | = |   |
    | | === |
    | ====  |
    | OUTPU |
    | T === |
    | ===== |
    | = |   |
    | | === |
    | ===== |
    | ===== |
    | ==    |
    |       |
    |   |   |
    | |     |
    |  if [ |
    |  "$re |
    | turn_ |
    | val"  |
    | - |   |
    | | eq  |
    | "$E_P |
    | ARAM_ |
    | ERR"  |
    | ]     |
    |   |   |
    | |     |
    |    th |
    | en    |
    |       |
    |       |
    |   |   |
    | |     |
    |    ec |
    | ho "E |
    | rror  |
    | in pa |
    | r |   |
    | | ame |
    | ters  |
    | passe |
    | d to  |
    | compa |
    | r |   |
    | | iso |
    | n fun |
    | ction |
    | !"    |
    |       |
    |   |   |
    | |     |
    |  elif |
    |  [ "$ |
    | retur |
    | n_val |
    | " |   |
    | |  -e |
    | q "$E |
    | QUAL" |
    |  ]    |
    |       |
    |   |   |
    | |     |
    |    th |
    | en    |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    | echo  |
    | "The  |
    | two n |
    | u |   |
    | | mbe |
    | rs ar |
    | e equ |
    | al."  |
    |       |
    |   |   |
    | |     |
    |  else |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    | echo  |
    | "The  |
    | large |
    | r |   |
    | |  of |
    |  the  |
    | two n |
    | umber |
    | s is  |
    | $ |   |
    | | ret |
    | urn_v |
    | al."  |
    |       |
    |       |
    |   |   |
    | |     |
    |  fi   |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  # == |
    | ===== |
    | ===== |
    | ===== |
    | = |   |
    | | === |
    | ===== |
    | ===== |
    | ===== |
    | ===== |
    | = |   |
    | | === |
    | ===== |
    | ===== |
    | ==    |
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
    |  0    |
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
    |  #  E |
    | xerci |
    | ses:  |
    |       |
    |   |   |
    | |     |
    |  #  - |
    | ----- |
    | ---   |
    |       |
    |   |   |
    | |     |
    |  #  1 |
    | ) Fin |
    | d a m |
    | ore e |
    | l |   |
    | | ega |
    | nt wa |
    | y of  |
    | testi |
    | ng    |
    |   |   |
    | |     |
    |  #+   |
    |   the |
    |  para |
    | meter |
    | s |   |
    | |  pa |
    | ssed  |
    | to th |
    | e fun |
    | ction |
    | . |   |
    | |     |
    |  #  2 |
    | ) Sim |
    | plify |
    |  the  |
    | i |   |
    | | f/t |
    | hen s |
    | truct |
    | ure a |
    | t "OU |
    | T |   |
    | | PUT |
    | ."    |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  #  3 |
    | ) Rew |
    | rite  |
    | the s |
    | c |   |
    | | rip |
    | t to  |
    | take  |
    | input |
    |  from |
    |   |   |
    | | com |
    | mand- |
    | line  |
    | param |
    | eters |
    | . |   |
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
    |  mont |
    | h_len |
    | gth ( |
    | )  #  |
    | T |   |
    | | ake |
    | s mon |
    | th nu |
    | mber  |
    | as an |
    |   |   |
    | | arg |
    | ument |
    | .     |
    |       |
    |       |
    |   |   |
    | |     |
    |  {    |
    |       |
    |       |
    |    #  |
    | R |   |
    | | etu |
    | rns n |
    | umber |
    |  of d |
    | ays i |
    | n |   |
    | |  mo |
    | nth.  |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  mont |
    | hD="3 |
    | 1 28  |
    | 31 30 |
    |   |   |
    | | 31  |
    | 30 31 |
    |  31 3 |
    | 0 31  |
    | 30 31 |
    | " |   |
    | |   # |
    |  Decl |
    | are a |
    | s loc |
    | al?   |
    |   |   |
    | |     |
    |  echo |
    |  "$mo |
    | nthD" |
    |  | aw |
    | k |   |
    | |  '{ |
    |  prin |
    | t $'" |
    | ${1}" |
    | ' }'  |
    |   |   |
    | |   # |
    |  Tric |
    | ky.   |
    |       |
    |       |
    |   |   |
    | |     |
    |  #    |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |   ^^^ |
    | ^^^^^ |
    | ^     |
    |   |   |
    | |     |
    |  # Pa |
    | ramet |
    | er pa |
    | ssed  |
    | t |   |
    | | o f |
    | uncti |
    | on  ( |
    | $1 -- |
    |  mont |
    | h |   |
    | |  nu |
    | mber) |
    | , the |
    | n to  |
    | awk.  |
    |   |   |
    | |     |
    |  # Aw |
    | k see |
    | s thi |
    | s as  |
    | " |   |
    | | pri |
    | nt $1 |
    |  . .  |
    | . pri |
    | nt $1 |
    | 2 |   |
    | | " ( |
    | depen |
    | ding  |
    | on mo |
    | nth n |
    | u |   |
    | | mbe |
    | r)    |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  # Te |
    | mplat |
    | e for |
    |  pass |
    | i |   |
    | | ng  |
    | a par |
    | amete |
    | r to  |
    | embed |
    | d |   |
    | | ed  |
    | awk s |
    | cript |
    | :     |
    |       |
    |   |   |
    | |     |
    |  #    |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |  $'"$ |
    | {scri |
    | p |   |
    | | t_p |
    | arame |
    | ter}" |
    | '     |
    |       |
    |   |   |
    | |     |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  #    |
    |  Here |
    | 's a  |
    | sligh |
    | t |   |
    | | ly  |
    | simpl |
    | er aw |
    | k con |
    | struc |
    | t |   |
    | | :   |
    |       |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  #    |
    |  echo |
    |  $mon |
    | thD | |
    |   |   |
    | | awk |
    |  -v m |
    | onth= |
    | $1 '{ |
    | print |
    |   |   |
    | | $(m |
    | onth) |
    | }'    |
    |       |
    |       |
    |   |   |
    | |     |
    |  #    |
    |  Uses |
    |  the  |
    | -v aw |
    | k |   |
    | |  op |
    | tion, |
    |  whic |
    | h ass |
    | igns  |
    | a |   |
    | |  va |
    | riabl |
    | e val |
    | ue    |
    |       |
    |   |   |
    | |     |
    |  #+   |
    |  prio |
    | r to  |
    | execu |
    | t |   |
    | | ion |
    |  of t |
    | he aw |
    | k pro |
    | gram  |
    | b |   |
    | | loc |
    | k.    |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  #    |
    |  Than |
    | k you |
    | , Ric |
    | h |   |
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
    |  #  N |
    | eeds  |
    | error |
    |  chec |
    | k |   |
    | | ing |
    |  for  |
    | corre |
    | ct pa |
    | ramet |
    | e |   |
    | | r r |
    | ange  |
    | (1-12 |
    | )     |
    |       |
    |   |   |
    | |     |
    |  #+ a |
    | nd fo |
    | r Feb |
    | ruary |
    |   |   |
    | | in  |
    | leap  |
    | year. |
    |       |
    |       |
    |   |   |
    | |     |
    |  }    |
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
    |  # -- |
    | ----- |
    | ----- |
    | ----- |
    | - |   |
    | | --- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | - |   |
    | | --- |
    | -     |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  # Us |
    | age e |
    | xampl |
    | e:    |
    |   |   |
    | |     |
    |  mont |
    | h=4   |
    |       |
    |  # Ap |
    | r |   |
    | | il, |
    |  for  |
    | examp |
    | le (4 |
    | th mo |
    | n |   |
    | | th) |
    | .     |
    |       |
    |       |
    |       |
    |   |   |
    | |     |
    |  days |
    | _in=$ |
    | (mont |
    | h_len |
    | g |   |
    | | th  |
    | $mont |
    | h)    |
    |       |
    |       |
    |   |   |
    | |     |
    |  echo |
    |  $day |
    | s_in  |
    |  # 30 |
    |   |   |
    | |     |
    |  # -- |
    | ----- |
    | ----- |
    | ----- |
    | - |   |
    | | --- |
    | ----- |
    | ----- |
    | ----- |
    | ----- |
    | - |   |
    | | --- |
    | -     |
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

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Redirection**

``Redirecting the stdin         of a function``
    A function is essentially a `code
    block <special-chars.html#CODEBLOCKREF>`__, which means its
    ``stdin`` can be redirected (as in `Example
    3-1 <special-chars.html#EX8>`__).

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
    redirecting a function's ``stdin``. This involves redirecting the
    ``stdin`` to an embedded bracketed code block within the function.

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

       </p>

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Emmanuel Rouat's `sample ``bashrc``  |
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
| `[1] <complexfunct.html#AEN18474>`__ |
| The **return** command is a Bash     |
| `builtin <internal.html#BUILTINREF>` |
| __.                                  |
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
