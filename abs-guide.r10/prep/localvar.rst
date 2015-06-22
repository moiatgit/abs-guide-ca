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

`Prev <complexfunct.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 24. Functions

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <recurnolocvar.html>`__

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

  24.2. Local Variables
======================

.. raw:: html

   <div class="VARIABLELIST">

** What makes a variable *local* ?**

 local variables
    A variable declared as *local* is one that is visible only within
    the `block of code <special-chars.html#CODEBLOCKREF>`__ in which it
    appears. It has local `scope <subshells.html#SCOPEREF>`__ . In a
    function, a *local variable* has meaning only within that function
    block. ` [1]  <localvar.html#FTN.AEN18568>`__

    .. raw:: html

       <div class="EXAMPLE">

    **Example 24-12. Local variable visibility**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # ex62.sh: Global an |
    | d local variables inside |
    |  a function.             |
    |                          |
    |     func ()              |
    |     {                    |
    |       local loc_var=23   |
    |      # Declared as local |
    |  variable.               |
    |       echo               |
    |      # Uses the 'local'  |
    | builtin.                 |
    |       echo "\"loc_var\"  |
    | in function = $loc_var"  |
    |       global_var=999     |
    |      # Not declared as l |
    | ocal.                    |
    |                          |
    |      # Therefore, defaul |
    | ts to global.            |
    |       echo "\"global_var |
    | \" in function = $global |
    | _var"                    |
    |     }                    |
    |                          |
    |     func                 |
    |                          |
    |     # Now, to see if loc |
    | al variable "loc_var" ex |
    | ists outside the functio |
    | n.                       |
    |                          |
    |     echo                 |
    |     echo "\"loc_var\" ou |
    | tside function = $loc_va |
    | r"                       |
    |                          |
    |                   # $loc |
    | _var outside function =  |
    |                          |
    |                   # No,  |
    | $loc_var not visible glo |
    | bally.                   |
    |     echo "\"global_var\" |
    |  outside function = $glo |
    | bal_var"                 |
    |                          |
    |                   # $glo |
    | bal_var outside function |
    |  = 999                   |
    |                          |
    |                   # $glo |
    | bal_var is visible globa |
    | lly.                     |
    |     echo                 |
    |                          |
    |                          |
    |     exit 0               |
    |     #  In contrast to C, |
    |  a Bash variable declare |
    | d inside a function      |
    |     #+ is local ONLY if  |
    | declared as such.        |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +--------------------------+--------------------------+--------------------------+
    | |Caution|                |
    | Before a function is     |
    | called, *all* variables  |
    | declared within the      |
    | function are invisible   |
    | outside the body of the  |
    | function, not just those |
    | explicitly declared as   |
    | *local* .                |
    |                          |
    | +----------------------- |
    | ---+-------------------- |
    | ------+----------------- |
    | ---------+               |
    | | .. code:: PROGRAMLISTI |
    | NG |                     |
    | |                        |
    |    |                     |
    | |     #!/bin/bash        |
    |    |                     |
    | |                        |
    |    |                     |
    | |     func ()            |
    |    |                     |
    | |     {                  |
    |    |                     |
    | |     global_var=37    # |
    |    |                     |
    | | Visible only within th |
    | e  |                     |
    | | function block         |
    |    |                     |
    | |                      # |
    | +  |                     |
    | | before the function ha |
    | s  |                     |
    | | been called.           |
    |    |                     |
    | |     }                # |
    |    |                     |
    | | END OF FUNCTION        |
    |    |                     |
    | |                        |
    |    |                     |
    | |     echo "global_var = |
    |  $ |                     |
    | | global_var"  # global_ |
    | va |                     |
    | | r =                    |
    |    |                     |
    | |                        |
    |    |                     |
    | |              #  Functi |
    | on |                     |
    | |  "func" has not yet be |
    | en |                     |
    | |  called,               |
    |    |                     |
    | |                        |
    |    |                     |
    | |              #+ so $gl |
    | ob |                     |
    | | al_var is not visible  |
    | he |                     |
    | | re.                    |
    |    |                     |
    | |                        |
    |    |                     |
    | |     func               |
    |    |                     |
    | |     echo "global_var = |
    |  $ |                     |
    | | global_var"  # global_ |
    | va |                     |
    | | r = 37                 |
    |    |                     |
    | |                        |
    |    |                     |
    | |              # Has bee |
    | n  |                     |
    | | set by function call.  |
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

       <div class="NOTE">

    +----------------+----------------+----------------+----------------+----------------+
    | |Note|         |
    |                |
    | As Evgeniy     |
    | Ivanov points  |
    | out, when      |
    | declaring and  |
    | setting a      |
    | local variable |
    | in a single    |
    | command,       |
    | apparently the |
    | order of       |
    | operations is  |
    | to *first set  |
    | the variable,  |
    | and only       |
    | afterwards     |
    | restrict it to |
    | local scope* . |
    | This is        |
    | reflected in   |
    | the `return    |
    | value <exit-st |
    | atus.html#EXIT |
    | STATUSREF>`__  |
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
    | |     #!/bin/b |
    | ash          | |
    | |              |
    |              | |
    | |     echo "== |
    | OUTSIDE Func | |
    | | tion (global |
    | )=="         | |
    | |     t=$(exit |
    |  1)          | |
    | |     echo $?  |
    |      # 1     | |
    | |              |
    |      # As ex | |
    | | pected.      |
    |              | |
    | |     echo     |
    |              | |
    | |              |
    |              | |
    | |     function |
    | 0 ()         | |
    | |     {        |
    |              | |
    | |              |
    |              | |
    | |     echo "== |
    | INSIDE Funct | |
    | | ion=="       |
    |              | |
    | |     echo "Gl |
    | obal"        | |
    | |     t0=$(exi |
    | t 1)         | |
    | |     echo $?  |
    |      # 1     | |
    | |              |
    |      # As ex | |
    | | pected.      |
    |              | |
    | |              |
    |              | |
    | |     echo     |
    |              | |
    | |     echo "Lo |
    | cal declared | |
    | |  & assigned  |
    | in same comm | |
    | | and."        |
    |              | |
    | |     local t1 |
    | =$(exit 1)   | |
    | |     echo $?  |
    |      # 0     | |
    | |              |
    |      # Unexp | |
    | | ected!       |
    |              | |
    | |     #  Appar |
    | ently, the v | |
    | | ariable assi |
    | gnment takes | |
    | |  place befor |
    | e            | |
    | |     #+ the l |
    | ocal declara | |
    | | tion.        |
    |              | |
    | |     #+ The r |
    | eturn value  | |
    | | is for the l |
    | atter.       | |
    | |              |
    |              | |
    | |     echo     |
    |              | |
    | |     echo "Lo |
    | cal declared | |
    | | , then assig |
    | ned (separat | |
    | | e commands). |
    | "            | |
    | |     local t2 |
    |              | |
    | |     t2=$(exi |
    | t 1)         | |
    | |     echo $?  |
    |      # 1     | |
    | |              |
    |      # As ex | |
    | | pected.      |
    |              | |
    | |              |
    |              | |
    | |     }        |
    |              | |
    | |              |
    |              | |
    | |     function |
    | 0            | |
    |                |
    |                |
    | +------------- |
    | -------------+ |
    | -------------- |
    | ------------+- |
    | -------------- |
    | -----------+   |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="SECT2">

  24.2.1. Local variables and recursion.
---------------------------------------

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| *Recursion* is an interesting and sometimes useful form of               |
| *self-reference* . `Herbert Mayer <biblio.html#MAYERREF>`__ defines it   |
| as ". . . expressing an algorithm by using a simpler version of that     |
| same algorithm . . ."                                                    |
|                                                                          |
| Consider a definition defined in terms of itself, ` [2]                  |
|  <localvar.html#FTN.AEN18607>`__ an expression implicit in its own       |
| expression, ` [3]  <localvar.html#FTN.AEN18610>`__ *a snake swallowing   |
| its own tail* , ` [4]  <localvar.html#FTN.AEN18614>`__ or . . . a        |
| function that calls itself. ` [5]  <localvar.html#FTN.AEN18617>`__       |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    <div class="EXAMPLE">                                                 |
|                                                                          |
| **Example 24-13. Demonstration of a simple recursive function**          |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: PROGRAMLISTING |                                             |
| |                          |                                             |
| |     #!/bin/bash          |                                             |
| |     # recursion-demo.sh  |                                             |
| |     # Demonstration of r |                                             |
| | ecursion.                |                                             |
| |                          |                                             |
| |     RECURSIONS=9   # How |                                             |
| |  many times to recurse.  |                                             |
| |     r_count=0      # Mus |                                             |
| | t be global. Why?        |                                             |
| |                          |                                             |
| |     recurse ()           |                                             |
| |     {                    |                                             |
| |       var="$1"           |                                             |
| |                          |                                             |
| |       while [ "$var" -ge |                                             |
| |  0 ]                     |                                             |
| |       do                 |                                             |
| |         echo "Recursion  |                                             |
| | count = "$r_count"  +-+  |                                             |
| |  \$var = "$var""         |                                             |
| |         (( var-- )); ((  |                                             |
| | r_count++ ))             |                                             |
| |         recurse "$var"   |                                             |
| | #  Function calls itself |                                             |
| |  (recurses)              |                                             |
| |       done               |                                             |
| | #+ until what condition  |                                             |
| | is met?                  |                                             |
| |     }                    |                                             |
| |                          |                                             |
| |     recurse $RECURSIONS  |                                             |
| |                          |                                             |
| |     exit $?              |                                             |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    <div class="EXAMPLE">                                                 |
|                                                                          |
| **Example 24-14. Another simple demonstration**                          |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: PROGRAMLISTING |                                             |
| |                          |                                             |
| |     #!/bin/bash          |                                             |
| |     # recursion-def.sh   |                                             |
| |     # A script that defi |                                             |
| | nes "recursion" in a rat |                                             |
| | her graphic way.         |                                             |
| |                          |                                             |
| |     RECURSIONS=10        |                                             |
| |     r_count=0            |                                             |
| |     sp=" "               |                                             |
| |                          |                                             |
| |     define_recursion ()  |                                             |
| |     {                    |                                             |
| |       ((r_count++))      |                                             |
| |       sp="$sp"" "        |                                             |
| |       echo -n "$sp"      |                                             |
| |       echo "\"The act of |                                             |
| |  recurring ... \""   # P |                                             |
| | er 1913 Webster's dictio |                                             |
| | nary.                    |                                             |
| |                          |                                             |
| |       while [ $r_count - |                                             |
| | le $RECURSIONS ]         |                                             |
| |       do                 |                                             |
| |         define_recursion |                                             |
| |       done               |                                             |
| |     }                    |                                             |
| |                          |                                             |
| |     echo                 |                                             |
| |     echo "Recursion: "   |                                             |
| |     define_recursion     |                                             |
| |     echo                 |                                             |
| |                          |                                             |
| |     exit $?              |                                             |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

Local variables are a useful tool for writing recursive code, but this
practice generally involves a great deal of computational overhead and
is definitely *not* recommended in a shell script. ` [6]
 <localvar.html#FTN.AEN18632>`__

.. raw:: html

   <div class="EXAMPLE">

**Example 24-15. Recursion, using a local variable**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #               fact |
| orial                    |
|     #               ---- |
| -----                    |
|                          |
|                          |
|     # Does bash permit r |
| ecursion?                |
|     # Well, yes, but...  |
|     # It's so slow that  |
| you gotta have rocks in  |
| your head to try it.     |
|                          |
|                          |
|     MAX_ARG=5            |
|     E_WRONG_ARGS=85      |
|     E_RANGE_ERR=86       |
|                          |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       echo "Usage: `base |
| name $0` number"         |
|       exit $E_WRONG_ARGS |
|     fi                   |
|                          |
|     if [ "$1" -gt $MAX_A |
| RG ]                     |
|     then                 |
|       echo "Out of range |
|  ($MAX_ARG is maximum)." |
|       #  Let's get real  |
| now.                     |
|       #  If you want gre |
| ater range than this,    |
|       #+ rewrite it in a |
|  Real Programming Langua |
| ge.                      |
|       exit $E_RANGE_ERR  |
|     fi                   |
|                          |
|     fact ()              |
|     {                    |
|       local number=$1    |
|       #  Variable "numbe |
| r" must be declared as l |
| ocal,                    |
|       #+ otherwise this  |
| doesn't work.            |
|       if [ "$number" -eq |
|  0 ]                     |
|       then               |
|         factorial=1    # |
|  Factorial of 0 = 1.     |
|       else               |
|         let "decrnum = n |
| umber - 1"               |
|         fact $decrnum  # |
|  Recursive function call |
|  (the function calls its |
| elf).                    |
|         let "factorial = |
|  $number * $?"           |
|       fi                 |
|                          |
|       return $factorial  |
|     }                    |
|                          |
|     fact $1              |
|     echo "Factorial of $ |
| 1 is $?."                |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Also see `Example A-15 <contributed-scripts.html#PRIMES>`__ for an
example of recursion in a script. Be aware that recursion is
resource-intensive and executes slowly, and is therefore generally not
appropriate in a script.

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

` [1]  <localvar.html#AEN18568>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

However, as Thomas Braunberger points out, a local variable declared in
a function *is also visible to functions called by the parent function.*

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     function1 ()         |
|     {                    |
|       local func1var=20  |
|                          |
|       echo "Within funct |
| ion1, \$func1var = $func |
| 1var."                   |
|                          |
|       function2          |
|     }                    |
|                          |
|     function2 ()         |
|     {                    |
|       echo "Within funct |
| ion2, \$func1var = $func |
| 1var."                   |
|     }                    |
|                          |
|     function1            |
|                          |
|     exit 0               |
|                          |
|                          |
|     # Output of the scri |
| pt:                      |
|                          |
|     # Within function1,  |
| $func1var = 20.          |
|     # Within function2,  |
| $func1var = 20.          |
                          
+--------------------------+--------------------------+--------------------------+

This is documented in the Bash manual:

 "Local can only be used within a function; it makes the variable name
have a visible scope restricted to that function *and its children* ."
[emphasis added] *The ABS Guide author considers this behavior to be a
bug.*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [2]  <localvar.html#AEN18607>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Otherwise known as *redundancy* .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [3]  <localvar.html#AEN18610>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Otherwise known as *tautology* .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [4]  <localvar.html#AEN18614>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Otherwise known as a *metaphor* .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [5]  <localvar.html#AEN18617>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Otherwise known as a *recursive function* .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [6]  <localvar.html#AEN18632>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Too many levels of recursion may crash a script with a segfault.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #  Warning: Running  |
| this script could possib |
| ly lock up your system!  |
|     #  If you're lucky,  |
| it will segfault before  |
| using up all available m |
| emory.                   |
|                          |
|     recursive_function ( |
| )                        |
|     {                    |
|     echo "$1"     # Make |
| s the function do someth |
| ing, and hastens the seg |
| fault.                   |
|     (( $1 < $2 )) && rec |
| ursive_function $(( $1 + |
|  1 )) $2;                |
|     #  As long as 1st pa |
| rameter is less than 2nd |
| ,                        |
|     #+ increment 1st and |
|  recurse.                |
|     }                    |
|                          |
|     recursive_function 1 |
|  50000  # Recurse 50,000 |
|  levels!                 |
|     #  Most likely segfa |
| ults (depending on stack |
|  size, set by ulimit -m) |
| .                        |
|                          |
|     #  Recursion this de |
| ep might cause even a C  |
| program to segfault,     |
|     #+ by using up all t |
| he memory allotted to th |
| e stack.                 |
|                          |
|                          |
|     echo "This will prob |
| ably not print."         |
|     exit 0  # This scrip |
| t will not exit normally |
| .                        |
|                          |
|     #  Thanks, StĂŠphane |
|  Chazelas.               |
                          
+--------------------------+--------------------------+--------------------------+

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
| `Prev <complexfunct.html | Complex Functions and    |
| >`__                     | Function Complexities    |
| `Home <index.html>`__    | `Up <functions.html>`__  |
| `Next <recurnolocvar.htm | Recursion Without Local  |
| l>`__                    | Variables                |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Note| image:: ../images/note.gif
