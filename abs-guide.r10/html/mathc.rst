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

`Prev <terminalccmds.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 16. External Filters, Programs and Commands

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <extmisc.html>`__

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

16.8. Math Commands
===================

.. raw:: html

   <div class="VARIABLELIST">

**"Doing the numbers"**

\ **factor**
    Decompose an integer into prime factors.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ factor 27417   |
    |     27417: 3 13 19 37    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-46. Generating prime numbers**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # primes2.sh         |
    |                          |
    |     #  Generating prime  |
    | numbers the quick-and-ea |
    | sy way,                  |
    |     #+ without resorting |
    |  to fancy algorithms.    |
    |                          |
    |     CEILING=10000   # 1  |
    | to 10000                 |
    |     PRIME=0              |
    |     E_NOTPRIME=          |
    |                          |
    |     is_prime ()          |
    |     {                    |
    |       local factors      |
    |       factors=( $(factor |
    |  $1) )  # Load output of |
    |  `factor` into array.    |
    |                          |
    |     if [ -z "${factors[2 |
    | ]}" ]                    |
    |     #  Third element of  |
    | "factors" array:         |
    |     #+ ${factors[2]} is  |
    | 2nd factor of argument.  |
    |     #  If it is blank, t |
    | hen there is no 2nd fact |
    | or,                      |
    |     #+ and the argument  |
    | is therefore prime.      |
    |     then                 |
    |       return $PRIME      |
    |         # 0              |
    |     else                 |
    |       return $E_NOTPRIME |
    |         # null           |
    |     fi                   |
    |     }                    |
    |                          |
    |     echo                 |
    |     for n in $(seq $CEIL |
    | ING)                     |
    |     do                   |
    |       if is_prime $n     |
    |       then               |
    |         printf %5d $n    |
    |       fi   #    ^  Five  |
    | positions per number suf |
    | fices.                   |
    |     done   #       For a |
    |  higher $CEILING, adjust |
    |  upward, as necessary.   |
    |                          |
    |     echo                 |
    |                          |
    |     exit                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

\ **bc**
    Bash can't handle floating point calculations, and it lacks
    operators for certain important mathematical functions. Fortunately,
    **bc** gallops to the rescue.

    Not just a versatile, arbitrary precision calculation utility,
    **bc** offers many of the facilities of a programming language. It
    has a syntax vaguely resembling **C**.

    Since it is a fairly well-behaved UNIX utility, and may therefore be
    used in a `pipe <special-chars.html#PIPEREF>`__, **bc** comes in
    handy in scripts.

    Here is a simple template for using **bc** to calculate a script
    variable. This uses `command
    substitution <commandsub.html#COMMANDSUBREF>`__.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |              variable=$( |
    | echo "OPTIONS; OPERATION |
    | S" | bc)                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-47. Monthly Payment on a Mortgage**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # monthlypmt.sh: Cal |
    | culates monthly payment  |
    | on a mortgage.           |
    |                          |
    |                          |
    |     #  This is a modific |
    | ation of code in the     |
    |     #+ "mcalc" (mortgage |
    |  calculator) package,    |
    |     #+ by Jeff Schmidt   |
    |     #+ and               |
    |     #+ Mendel Cooper (yo |
    | urs truly, the ABS Guide |
    |  author).                |
    |     #   http://www.ibibl |
    | io.org/pub/Linux/apps/fi |
    | nancial/mcalc-1.6.tar.gz |
    |                          |
    |     echo                 |
    |     echo "Given the prin |
    | cipal, interest rate, an |
    | d term of a mortgage,"   |
    |     echo "calculate the  |
    | monthly payment."        |
    |                          |
    |     bottom=1.0           |
    |                          |
    |     echo                 |
    |     echo -n "Enter princ |
    | ipal (no commas) "       |
    |     read principal       |
    |     echo -n "Enter inter |
    | est rate (percent) "  #  |
    | If 12%, enter "12", not  |
    | ".12".                   |
    |     read interest_r      |
    |     echo -n "Enter term  |
    | (months) "               |
    |     read term            |
    |                          |
    |                          |
    |      interest_r=$(echo " |
    | scale=9; $interest_r/100 |
    | .0" | bc) # Convert to d |
    | ecimal.                  |
    |                      #   |
    |          ^^^^^^^^^^^^^^^ |
    | ^^  Divide by 100.       |
    |                      # " |
    | scale" determines how ma |
    | ny decimal places.       |
    |                          |
    |      interest_rate=$(ech |
    | o "scale=9; $interest_r/ |
    | 12 + 1.0" | bc)          |
    |                          |
    |                          |
    |      top=$(echo "scale=9 |
    | ; $principal*$interest_r |
    | ate^$term" | bc)         |
    |               #          |
    |   ^^^^^^^^^^^^^^^^^^^^^^ |
    | ^^^^^^^^^                |
    |               #          |
    |   Standard formula for f |
    | iguring interest.        |
    |                          |
    |      echo; echo "Please  |
    | be patient. This may tak |
    | e a while."              |
    |                          |
    |      let "months = $term |
    |  - 1"                    |
    |     # ================== |
    | ======================== |
    | ======================== |
    | ==                       |
    |      for ((x=$months; x  |
    | > 0; x--))               |
    |      do                  |
    |        bot=$(echo "scale |
    | =9; $interest_rate^$x" | |
    |  bc)                     |
    |        bottom=$(echo "sc |
    | ale=9; $bottom+$bot" | b |
    | c)                       |
    |     #  bottom = $(($bott |
    | om + $bot"))             |
    |      done                |
    |     # ================== |
    | ======================== |
    | ======================== |
    | ==                       |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | ------------------------ |
    | --                       |
    |     #  Rick Boivie point |
    | ed out a more efficient  |
    | implementation           |
    |     #+ of the above loop |
    | , which decreases comput |
    | ation time by 2/3.       |
    |                          |
    |     # for ((x=1; x <= $m |
    | onths; x++))             |
    |     # do                 |
    |     #   bottom=$(echo "s |
    | cale=9; $bottom * $inter |
    | est_rate + 1" | bc)      |
    |     # done               |
    |                          |
    |                          |
    |     #  And then he came  |
    | up with an even more eff |
    | icient alternative,      |
    |     #+ one that cuts dow |
    | n the run time by about  |
    | 95%!                     |
    |                          |
    |     # bottom=`{          |
    |     #     echo "scale=9; |
    |  bottom=$bottom; interes |
    | t_rate=$interest_rate"   |
    |     #     for ((x=1; x < |
    | = $months; x++))         |
    |     #     do             |
    |     #          echo 'bot |
    | tom = bottom * interest_ |
    | rate + 1'                |
    |     #     done           |
    |     #     echo 'bottom'  |
    |     #     } | bc`        |
    | # Embeds a 'for loop' wi |
    | thin command substitutio |
    | n.                       |
    |     # ------------------ |
    | ------------------------ |
    | ------------------------ |
    | --------                 |
    |     #  On the other hand |
    | , Frank Wang suggests:   |
    |     #  bottom=$(echo "sc |
    | ale=9; ($interest_rate^$ |
    | term-1)/($interest_rate- |
    | 1)" | bc)                |
    |                          |
    |     #  Because . . .     |
    |     #  The algorithm beh |
    | ind the loop             |
    |     #+ is actually a sum |
    |  of geometric proportion |
    |  series.                 |
    |     #  The sum formula i |
    | s e0(1-q^n)/(1-q),       |
    |     #+ where e0 is the f |
    | irst element and q=e(n+1 |
    | )/e(n)                   |
    |     #+ and n is the numb |
    | er of elements.          |
    |     # ------------------ |
    | ------------------------ |
    | ------------------------ |
    | --------                 |
    |                          |
    |                          |
    |      # let "payment = $t |
    | op/$bottom"              |
    |      payment=$(echo "sca |
    | le=2; $top/$bottom" | bc |
    | )                        |
    |      # Use two decimal p |
    | laces for dollars and ce |
    | nts.                     |
    |                          |
    |      echo                |
    |      echo "monthly payme |
    | nt = \$$payment"  # Echo |
    |  a dollar sign in front  |
    | of amount.               |
    |      echo                |
    |                          |
    |                          |
    |      exit 0              |
    |                          |
    |                          |
    |      # Exercises:        |
    |      #   1) Filter input |
    |  to permit commas in pri |
    | ncipal amount.           |
    |      #   2) Filter input |
    |  to permit interest to b |
    | e entered as percent or  |
    | decimal.                 |
    |      #   3) If you are r |
    | eally ambitious,         |
    |      #+     expand this  |
    | script to print complete |
    |  amortization tables.    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-48. Base Conversion**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     #################### |
    | ######################## |
    | ######################## |
    | #######                  |
    |     # Shellscript:  base |
    | .sh - print number to di |
    | fferent bases (Bourne Sh |
    | ell)                     |
    |     # Author     :  Hein |
    | er Steven (heiner.steven |
    | @odn.de)                 |
    |     # Date       :  07-0 |
    | 3-95                     |
    |     # Category   :  Desk |
    | top                      |
    |     # $Id: base.sh,v 1.2 |
    |  2000/02/06 19:55:35 hei |
    | ner Exp $                |
    |     # ==> Above line is  |
    | RCS ID info.             |
    |     #################### |
    | ######################## |
    | ######################## |
    | #######                  |
    |     # Description        |
    |     #                    |
    |     # Changes            |
    |     # 21-03-95 stv  fixe |
    | d error occuring with 0x |
    | b as input (0.2)         |
    |     #################### |
    | ######################## |
    | ######################## |
    | #######                  |
    |                          |
    |     # ==> Used in ABS Gu |
    | ide with the script auth |
    | or's permission.         |
    |     # ==> Comments added |
    |  by ABS Guide author.    |
    |                          |
    |     NOARGS=85            |
    |     PN=`basename "$0"`   |
    |                # Program |
    |  name                    |
    |     VER=`echo '$Revision |
    | : 1.2 $' | cut -d' ' -f2 |
    | `  # ==> VER=1.2         |
    |                          |
    |     Usage () {           |
    |         echo "$PN - prin |
    | t number to different ba |
    | ses, $VER (stv '95)      |
    |     usage: $PN [number . |
    | ..]                      |
    |                          |
    |     If no number is give |
    | n, the numbers are read  |
    | from standard input.     |
    |     A number may be      |
    |         binary (base 2)  |
    |     starting with 0b (i. |
    | e. 0b1100)               |
    |         octal (base 8)   |
    |     starting with 0  (i. |
    | e. 014)                  |
    |         hexadecimal (bas |
    | e 16)   starting with 0x |
    |  (i.e. 0xc)              |
    |         decimal          |
    | otherwise (i.e. 12)" >&2 |
    |         exit $NOARGS     |
    |     }   # ==> Prints usa |
    | ge message.              |
    |                          |
    |     Msg () {             |
    |         for i   # ==> in |
    |  [list] missing. Why?    |
    |         do echo "$PN: $i |
    | " >&2                    |
    |         done             |
    |     }                    |
    |                          |
    |     Fatal () { Msg "$@"; |
    |  exit 66; }              |
    |                          |
    |     PrintBases () {      |
    |         # Determine base |
    |  of the number           |
    |         for i      # ==> |
    |  in [list] missing...    |
    |         do         # ==> |
    |  so operates on command- |
    | line arg(s).             |
    |         case "$i" in     |
    |             0b*)         |
    | ibase=2;;   # binary     |
    |             0x*|[a-f]*|[ |
    | A-F]*)  ibase=16;;  # he |
    | xadecimal                |
    |             0*)          |
    | ibase=8;;   # octal      |
    |             [1-9]*)      |
    | ibase=10;;  # decimal    |
    |             *)           |
    |             Msg "illegal |
    |  number $i - ignored"    |
    |             continue;;   |
    |         esac             |
    |                          |
    |         # Remove prefix, |
    |  convert hex digits to u |
    | ppercase (bc needs this) |
    | .                        |
    |         number=`echo "$i |
    | " | sed -e 's:^0[bBxX]:: |
    | ' | tr '[a-f]' '[A-F]'`  |
    |         # ==> Uses ":" a |
    | s sed separator, rather  |
    | than "/".                |
    |                          |
    |         # Convert number |
    |  to decimal              |
    |         dec=`echo "ibase |
    | =$ibase; $number" | bc`  |
    |  # ==> 'bc' is calculato |
    | r utility.               |
    |         case "$dec" in   |
    |             [0-9]*) ;;   |
    |          # number ok     |
    |             *)      cont |
    | inue;;       # error: ig |
    | nore                     |
    |         esac             |
    |                          |
    |         # Print all conv |
    | ersions in one line.     |
    |         # ==> 'here docu |
    | ment' feeds command list |
    |  to 'bc'.                |
    |         echo `bc <<!     |
    |             obase=16; "h |
    | ex="; $dec               |
    |             obase=10; "d |
    | ec="; $dec               |
    |             obase=8;  "o |
    | ct="; $dec               |
    |             obase=2;  "b |
    | in="; $dec               |
    |     !                    |
    |         ` | sed -e 's: : |
    |     :g'                  |
    |                          |
    |         done             |
    |     }                    |
    |                          |
    |     while [ $# -gt 0 ]   |
    |     # ==>  Is a "while l |
    | oop" really necessary he |
    | re,                      |
    |     # ==>+ since all the |
    |  cases either break out  |
    | of the loop              |
    |     # ==>+ or terminate  |
    | the script.              |
    |     # ==> (Above comment |
    |  by Paulo Marcel Coelho  |
    | Aragao.)                 |
    |     do                   |
    |         case "$1" in     |
    |         --)     shift; b |
    | reak;;                   |
    |         -h)     Usage;;  |
    |                 # ==> He |
    | lp message.              |
    |         -*)     Usage;;  |
    |              *)     brea |
    | k;;                 # Fi |
    | rst number               |
    |         esac   # ==> Err |
    | or checking for illegal  |
    | input might be appropria |
    | te.                      |
    |         shift            |
    |     done                 |
    |                          |
    |     if [ $# -gt 0 ]      |
    |     then                 |
    |         PrintBases "$@"  |
    |     else                 |
    |     # Read from stdin.   |
    |         while read line  |
    |         do               |
    |         PrintBases $line |
    |         done             |
    |     fi                   |
    |                          |
    |                          |
    |     exit                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    An alternate method of invoking **bc** involves using a `here
    document <here-docs.html#HEREDOCREF>`__ embedded within a `command
    substitution <commandsub.html#COMMANDSUBREF>`__ block. This is
    especially appropriate when a script needs to pass a list of options
    and commands to **bc**.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     variable=`bc << LIMI |
    | T_STRING                 |
    |     options              |
    |     statements           |
    |     operations           |
    |     LIMIT_STRING         |
    |     `                    |
    |                          |
    |     ...or...             |
    |                          |
    |                          |
    |     variable=$(bc << LIM |
    | IT_STRING                |
    |     options              |
    |     statements           |
    |     operations           |
    |     LIMIT_STRING         |
    |     )                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-49. Invoking *bc* using a *here document***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Invoking 'bc' usin |
    | g command substitution   |
    |     # in combination wit |
    | h a 'here document'.     |
    |                          |
    |                          |
    |     var1=`bc << EOF      |
    |     18.33 * 19.78        |
    |     EOF                  |
    |     `                    |
    |     echo $var1       # 3 |
    | 62.56                    |
    |                          |
    |                          |
    |     #  $( ... ) notation |
    |  also works.             |
    |     v1=23.53             |
    |     v2=17.881            |
    |     v3=83.501            |
    |     v4=171.63            |
    |                          |
    |     var2=$(bc << EOF     |
    |     scale = 4            |
    |     a = ( $v1 + $v2 )    |
    |     b = ( $v3 * $v4 )    |
    |     a * b + 15.35        |
    |     EOF                  |
    |     )                    |
    |     echo $var2       # 5 |
    | 93487.8452               |
    |                          |
    |                          |
    |     var3=$(bc -l << EOF  |
    |     scale = 9            |
    |     s ( 1.7 )            |
    |     EOF                  |
    |     )                    |
    |     # Returns the sine o |
    | f 1.7 radians.           |
    |     # The "-l" option ca |
    | lls the 'bc' math librar |
    | y.                       |
    |     echo $var3       # . |
    | 991664810                |
    |                          |
    |                          |
    |     # Now, try it in a f |
    | unction...               |
    |     hypotenuse ()    # C |
    | alculate hypotenuse of a |
    |  right triangle.         |
    |     {                # c |
    |  = sqrt( a^2 + b^2 )     |
    |     hyp=$(bc -l << EOF   |
    |     scale = 9            |
    |     sqrt ( $1 * $1 + $2  |
    | * $2 )                   |
    |     EOF                  |
    |     )                    |
    |     # Can't directly ret |
    | urn floating point value |
    | s from a Bash function.  |
    |     # But, can echo-and- |
    | capture:                 |
    |     echo "$hyp"          |
    |     }                    |
    |                          |
    |     hyp=$(hypotenuse 3.6 |
    | 8 7.31)                  |
    |     echo "hypotenuse = $ |
    | hyp"    # 8.184039344    |
    |                          |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-50. Calculating PI**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # cannon.sh: Approxi |
    | mating PI by firing cann |
    | onballs.                 |
    |                          |
    |     # Author: Mendel Coo |
    | per                      |
    |     # License: Public Do |
    | main                     |
    |     # Version 2.2, relda |
    | te 13oct08.              |
    |                          |
    |     # This is a very sim |
    | ple instance of a "Monte |
    |  Carlo" simulation:      |
    |     #+ a mathematical mo |
    | del of a real-life event |
    | ,                        |
    |     #+ using pseudorando |
    | m numbers to emulate ran |
    | dom chance.              |
    |                          |
    |     #  Consider a perfec |
    | tly square plot of land, |
    |  10000 units on a side.  |
    |     #  This land has a p |
    | erfectly circular lake i |
    | n its center,            |
    |     #+ with a diameter o |
    | f 10000 units.           |
    |     #  The plot is actua |
    | lly mostly water, except |
    |  for land in the four co |
    | rners.                   |
    |     #  (Think of it as a |
    |  square with an inscribe |
    | d circle.)               |
    |     #                    |
    |     #  We will fire iron |
    |  cannonballs from an old |
    | -style cannon            |
    |     #+ at the square.    |
    |     #  All the shots imp |
    | act somewhere on the squ |
    | are,                     |
    |     #+ either in the lak |
    | e or on the dry corners. |
    |     #  Since the lake ta |
    | kes up most of the area, |
    |     #+ most of the shots |
    |  will SPLASH! into the w |
    | ater.                    |
    |     #  Just a few shots  |
    | will THUD! into solid gr |
    | ound                     |
    |     #+ in the four corne |
    | rs of the square.        |
    |     #                    |
    |     #  If we take enough |
    |  random, unaimed shots a |
    | t the square,            |
    |     #+ Then the ratio of |
    |  SPLASHES to total shots |
    |  will approximate        |
    |     #+ the value of PI/4 |
    | .                        |
    |     #                    |
    |     #  The simplified ex |
    | planation is that the ca |
    | nnon is actually         |
    |     #+ shooting only at  |
    | the upper right-hand qua |
    | drant of the square,     |
    |     #+ i.e., Quadrant I  |
    | of the Cartesian coordin |
    | ate plane.               |
    |     #                    |
    |     #                    |
    |     #  Theoretically, th |
    | e more shots taken, the  |
    | better the fit.          |
    |     #  However, a shell  |
    | script, as opposed to a  |
    | compiled language        |
    |     #+ with floating-poi |
    | nt math built in, requir |
    | es some compromises.     |
    |     #  This decreases th |
    | e accuracy of the simula |
    | tion.                    |
    |                          |
    |                          |
    |     DIMENSION=10000  # L |
    | ength of each side of th |
    | e plot.                  |
    |                      # A |
    | lso sets ceiling for ran |
    | dom integers generated.  |
    |                          |
    |     MAXSHOTS=1000    # F |
    | ire this many shots.     |
    |                      # 1 |
    | 0000 or more would be be |
    | tter, but would take too |
    |  long.                   |
    |     PMULTIPLIER=4.0  # S |
    | caling factor.           |
    |                          |
    |     declare -r M_PI=3.14 |
    | 1592654                  |
    |                      # A |
    | ctual 9-place value of P |
    | I, for comparison purpos |
    | es.                      |
    |                          |
    |     get_random ()        |
    |     {                    |
    |     SEED=$(head -n 1 /de |
    | v/urandom | od -N 1 | aw |
    | k '{ print $2 }')        |
    |     RANDOM=$SEED         |
    |                          |
    |   #  From "seeding-rando |
    | m.sh"                    |
    |                          |
    |                          |
    |   #+ example script.     |
    |     let "rnum = $RANDOM  |
    | % $DIMENSION"            |
    |   #  Range less than 100 |
    | 00.                      |
    |     echo $rnum           |
    |     }                    |
    |                          |
    |     distance=        # D |
    | eclare global variable.  |
    |     hypotenuse ()    # C |
    | alculate hypotenuse of a |
    |  right triangle.         |
    |     {                # F |
    | rom "alt-bc.sh" example. |
    |     distance=$(bc -l <<  |
    | EOF                      |
    |     scale = 0            |
    |     sqrt ( $1 * $1 + $2  |
    | * $2 )                   |
    |     EOF                  |
    |     )                    |
    |     #  Setting "scale" t |
    | o zero rounds down resul |
    | t to integer value,      |
    |     #+ a necessary compr |
    | omise in this script.    |
    |     #  It decreases the  |
    | accuracy of this simulat |
    | ion.                     |
    |     }                    |
    |                          |
    |                          |
    |     # ================== |
    | ======================== |
    | ================         |
    |     # main() {           |
    |     # "Main" code block, |
    |  mimicking a C-language  |
    | main() function.         |
    |                          |
    |     # Initialize variabl |
    | es.                      |
    |     shots=0              |
    |     splashes=0           |
    |     thuds=0              |
    |     Pi=0                 |
    |     error=0              |
    |                          |
    |     while [ "$shots" -lt |
    |   "$MAXSHOTS" ]          |
    |   # Main loop.           |
    |     do                   |
    |                          |
    |       xCoord=$(get_rando |
    | m)                       |
    |   # Get random X and Y c |
    | oords.                   |
    |       yCoord=$(get_rando |
    | m)                       |
    |       hypotenuse $xCoord |
    |  $yCoord                 |
    |   #  Hypotenuse of       |
    |                          |
    |                          |
    |   #+ right-triangle = di |
    | stance.                  |
    |       ((shots++))        |
    |                          |
    |       printf "#%4d   " $ |
    | shots                    |
    |       printf "Xc = %4d   |
    | " $xCoord                |
    |       printf "Yc = %4d   |
    | " $yCoord                |
    |       printf "Distance = |
    |  %5d  " $distance        |
    |   #   Distance from      |
    |                          |
    |                          |
    |   #+  center of lake     |
    |                          |
    |                          |
    |   #+  -- the "origin" -- |
    |                          |
    |                          |
    |   #+  coordinate (0,0).  |
    |                          |
    |       if [ "$distance" - |
    | le "$DIMENSION" ]        |
    |       then               |
    |         echo -n "SPLASH! |
    |   "                      |
    |         ((splashes++))   |
    |       else               |
    |         echo -n "THUD!   |
    |   "                      |
    |         ((thuds++))      |
    |       fi                 |
    |                          |
    |       Pi=$(echo "scale=9 |
    | ; $PMULTIPLIER*$splashes |
    | /$shots" | bc)           |
    |       # Multiply ratio b |
    | y 4.0.                   |
    |       echo -n "PI ~ $Pi" |
    |       echo               |
    |                          |
    |     done                 |
    |                          |
    |     echo                 |
    |     echo "After $shots s |
    | hots, PI looks like appr |
    | oximately   $Pi"         |
    |     #  Tends to run a bi |
    | t high,                  |
    |     #+ possibly due to r |
    | ound-off error and imper |
    | fect randomness of $RAND |
    | OM.                      |
    |     #  But still usually |
    |  within plus-or-minus 5% |
    |  . . .                   |
    |     #+ a pretty fair rou |
    | gh approximation.        |
    |     error=$(echo "scale= |
    | 9; $Pi - $M_PI" | bc)    |
    |     pct_error=$(echo "sc |
    | ale=2; 100.0 * $error /  |
    | $M_PI" | bc)             |
    |     echo -n "Deviation f |
    | rom mathematical value o |
    | f PI =        $error"    |
    |     echo " ($pct_error%  |
    | error)"                  |
    |     echo                 |
    |                          |
    |     # End of "main" code |
    |  block.                  |
    |     # }                  |
    |     # ================== |
    | ======================== |
    | ================         |
    |                          |
    |     exit 0               |
    |                          |
    |     #  One might well wo |
    | nder whether a shell scr |
    | ipt is appropriate for   |
    |     #+ an application as |
    |  complex and computation |
    | -intensive as a simulati |
    | on.                      |
    |     #                    |
    |     #  There are at leas |
    | t two justifications.    |
    |     #  1) As a proof of  |
    | concept: to show it can  |
    | be done.                 |
    |     #  2) To prototype a |
    | nd test the algorithms b |
    | efore rewriting          |
    |     #+    it in a compil |
    | ed high-level language.  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example A-37 <contributed-scripts.html#STDDEV>`__.

\ **dc**
    The **dc** (**d**\ esk **c**\ alculator) utility is
    `stack-oriented <internalvariables.html#STACKDEFREF>`__ and uses RPN
    (*Reverse Polish Notation*). Like **bc**, it has much of the power
    of a programming language.

    Similar to the procedure with **bc**,
    `echo <internal.html#ECHOREF>`__ a command-string to **dc**.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo "[Printing a st |
    | ring ... ]P" | dc        |
    |     # The P command prin |
    | ts the string between th |
    | e preceding brackets.    |
    |                          |
    |     # And now for some s |
    | imple arithmetic.        |
    |     echo "7 8 * p" | dc  |
    |     # 56                 |
    |     #  Pushes 7, then 8  |
    | onto the stack,          |
    |     #+ multiplies ("*" o |
    | perator), then prints th |
    | e result ("p" operator). |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    Most persons avoid **dc**, because of its non-intuitive input and
    rather cryptic operators. Yet, it has its uses.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-51. Converting a decimal number to hexadecimal**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # hexconvert.sh: Con |
    | vert a decimal number to |
    |  hexadecimal.            |
    |                          |
    |     E_NOARGS=85 # Comman |
    | d-line arg missing.      |
    |     BASE=16     # Hexade |
    | cimal.                   |
    |                          |
    |     if [ -z "$1" ]       |
    |     then        # Need a |
    |  command-line argument.  |
    |       echo "Usage: $0 nu |
    | mber"                    |
    |       exit $E_NOARGS     |
    |     fi          # Exerci |
    | se: add argument validit |
    | y checking.              |
    |                          |
    |                          |
    |     hexcvt ()            |
    |     {                    |
    |     if [ -z "$1" ]       |
    |     then                 |
    |       echo 0             |
    |       return    # "Retur |
    | n" 0 if no arg passed to |
    |  function.               |
    |     fi                   |
    |                          |
    |     echo ""$1" "$BASE" o |
    |  p" | dc                 |
    |     #                  o |
    |     sets radix (numerica |
    | l base) of output.       |
    |     #                    |
    |  p  prints the top of st |
    | ack.                     |
    |     # For other options: |
    |  'man dc' ...            |
    |     return               |
    |     }                    |
    |                          |
    |     hexcvt "$1"          |
    |                          |
    |     exit                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Studying the `info <basic.html#INFOREF>`__ page for **dc** is a
    painful path to understanding its intricacies. There seems to be a
    small, select group of *dc wizards* who delight in showing off their
    mastery of this powerful, but arcane utility.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ echo "16i[q]sa |
    | [ln0=aln100%Pln100/snlbx |
    | ]sbA0D68736142snlbxq" |  |
    | dc                       |
    |     Bash                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     dc <<< 10k5v1+2/p #  |
    | 1.6180339887             |
    |     #  ^^^            Fe |
    | ed operations to dc usin |
    | g a Here String.         |
    |     #      ^^^        Pu |
    | shes 10 and sets that as |
    |  the precision (10k).    |
    |     #         ^^      Pu |
    | shes 5 and takes its squ |
    | are root                 |
    |     #                 (5 |
    | v, v = square root).     |
    |     #           ^^    Pu |
    | shes 1 and adds it to th |
    | e running total (1+).    |
    |     #             ^^  Pu |
    | shes 2 and divides the r |
    | unning total by that (2/ |
    | ).                       |
    |     #               ^ Po |
    | ps and prints the result |
    |  (p)                     |
    |     #  The result is  1. |
    | 6180339887 ...           |
    |     #  ... which happens |
    |  to be the Pythagorean G |
    | olden Ratio, to 10 place |
    | s.                       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-52. Factoring**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # factr.sh: Factor a |
    |  number                  |
    |                          |
    |     MIN=2       # Will n |
    | ot work for number small |
    | er than this.            |
    |     E_NOARGS=85          |
    |     E_TOOSMALL=86        |
    |                          |
    |     if [ -z $1 ]         |
    |     then                 |
    |       echo "Usage: $0 nu |
    | mber"                    |
    |       exit $E_NOARGS     |
    |     fi                   |
    |                          |
    |     if [ "$1" -lt "$MIN" |
    |  ]                       |
    |     then                 |
    |       echo "Number to fa |
    | ctor must be $MIN or gre |
    | ater."                   |
    |       exit $E_TOOSMALL   |
    |     fi                   |
    |                          |
    |     # Exercise: Add type |
    |  checking (to reject non |
    | -integer arg).           |
    |                          |
    |     echo "Factors of $1: |
    | "                        |
    |     # ------------------ |
    | ------------------------ |
    | -------------            |
    |     echo  "$1[p]s2[lip/d |
    | li%0=1dvsr]s12sid2%0=13s |
    | idvsr[dli%0=\            |
    |     1lrli2+dsi!>.]ds.xd1 |
    | <2" | dc                 |
    |     # ------------------ |
    | ------------------------ |
    | -------------            |
    |     #  Above code writte |
    | n by Michel Charpentier  |
    | <charpov@cs.unh.edu>     |
    |     #  (as a one-liner,  |
    | here broken into two lin |
    | es for display purposes) |
    | .                        |
    |     #  Used in ABS Guide |
    |  with permission (thanks |
    | !).                      |
    |                          |
    |      exit                |
    |                          |
    |      # $ sh factr.sh 270 |
    | 138                      |
    |      # 2                 |
    |      # 3                 |
    |      # 11                |
    |      # 4093              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

\ **awk**
    Yet another way of doing floating point math in a script is using
    `awk's <awk.html#AWKREF>`__ built-in math functions in a `shell
    wrapper <wrapper.html#SHWRAPPER>`__.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-53. Calculating the hypotenuse of a triangle**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # hypotenuse.sh: Ret |
    | urns the "hypotenuse" of |
    |  a right triangle.       |
    |     #                (sq |
    | uare root of sum of squa |
    | res of the "legs")       |
    |                          |
    |     ARGS=2               |
    |   # Script needs sides o |
    | f triangle passed.       |
    |     E_BADARGS=85         |
    |   # Wrong number of argu |
    | ments.                   |
    |                          |
    |     if [ $# -ne "$ARGS"  |
    | ] # Test number of argum |
    | ents to script.          |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` side_1 side_2"  |
    |       exit $E_BADARGS    |
    |     fi                   |
    |                          |
    |                          |
    |     AWKSCRIPT=' { printf |
    | ( "%3.7f\n", sqrt($1*$1  |
    | + $2*$2) ) } '           |
    |     #             comman |
    | d(s) / parameters passed |
    |  to awk                  |
    |                          |
    |                          |
    |     # Now, pipe the para |
    | meters to awk.           |
    |         echo -n "Hypoten |
    | use of $1 and $2 = "     |
    |         echo $1 $2 | awk |
    |  "$AWKSCRIPT"            |
    |     #   ^^^^^^^^^^^^     |
    |     # An echo-and-pipe i |
    | s an easy way of passing |
    |  shell parameters to awk |
    | .                        |
    |                          |
    |     exit                 |
    |                          |
    |     # Exercise: Rewrite  |
    | this script using 'bc' r |
    | ather than awk.          |
    |     #           Which me |
    | thod is more intuitive?  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <terminalccmds.htm | Terminal Control         |
| l>`__                    | Commands                 |
| `Home <index.html>`__    | `Up <external.html>`__   |
| `Next <extmisc.html>`__  | Miscellaneous Commands   |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

