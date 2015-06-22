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

`Prev <declareref.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 9. Another Look at Variables

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <manipulatingvars.html>`__

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

  9.3. $RANDOM: generate random integer
======================================

+--------------------------+--------------------------+--------------------------+
| **                       |
| *Anyone who attempts to  |
| generate random numbers  |
| by deterministic means   |
| is, of course, living in |
| a state of sin.*         |
|                          |
| *--John von Neumann*     |
+--------------------------+--------------------------+--------------------------+

``      $RANDOM     `` is an internal Bash
`function <functions.html#FUNCTIONREF>`__ (not a constant) that returns
a *pseudorandom* ` [1]  <randomvar.html#FTN.AEN5817>`__ integer in the
range 0 - 32767. It should ``             not           `` be used to
generate an encryption key.

.. raw:: html

   <div class="EXAMPLE">

**Example 9-11. Generating random numbers**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # $RANDOM returns a  |
| different random integer |
|  at each invocation.     |
|     # Nominal range: 0 - |
|  32767 (signed 16-bit in |
| teger).                  |
|                          |
|     MAXCOUNT=10          |
|     count=1              |
|                          |
|     echo                 |
|     echo "$MAXCOUNT rand |
| om numbers:"             |
|     echo "-------------- |
| ---"                     |
|     while [ "$count" -le |
|  $MAXCOUNT ]      # Gene |
| rate 10 ($MAXCOUNT) rand |
| om integers.             |
|     do                   |
|       number=$RANDOM     |
|       echo $number       |
|       let "count += 1"   |
| # Increment count.       |
|     done                 |
|     echo "-------------- |
| ---"                     |
|                          |
|     # If you need a rand |
| om int within a certain  |
| range, use the 'modulo'  |
| operator.                |
|     # This returns the r |
| emainder of a division o |
| peration.                |
|                          |
|     RANGE=500            |
|                          |
|     echo                 |
|                          |
|     number=$RANDOM       |
|     let "number %= $RANG |
| E"                       |
|     #           ^^       |
|     echo "Random number  |
| less than $RANGE  ---  $ |
| number"                  |
|                          |
|     echo                 |
|                          |
|                          |
|                          |
|     #  If you need a ran |
| dom integer greater than |
|  a lower bound,          |
|     #+ then set up a tes |
| t to discard all numbers |
|  below that.             |
|                          |
|     FLOOR=200            |
|                          |
|     number=0   #initiali |
| ze                       |
|     while [ "$number" -l |
| e $FLOOR ]               |
|     do                   |
|       number=$RANDOM     |
|     done                 |
|     echo "Random number  |
| greater than $FLOOR ---  |
|  $number"                |
|     echo                 |
|                          |
|        # Let's examine a |
|  simple alternative to t |
| he above loop, namely    |
|        #       let "numb |
| er = $RANDOM + $FLOOR"   |
|        # That would elim |
| inate the while-loop and |
|  run faster.             |
|        # But, there migh |
| t be a problem with that |
| . What is it?            |
|                          |
|                          |
|                          |
|     # Combine above two  |
| techniques to retrieve r |
| andom number between two |
|  limits.                 |
|     number=0   #initiali |
| ze                       |
|     while [ "$number" -l |
| e $FLOOR ]               |
|     do                   |
|       number=$RANDOM     |
|       let "number %= $RA |
| NGE"  # Scales $number d |
| own within $RANGE.       |
|     done                 |
|     echo "Random number  |
| between $FLOOR and $RANG |
| E ---  $number"          |
|     echo                 |
|                          |
|                          |
|                          |
|     # Generate binary ch |
| oice, that is, "true" or |
|  "false" value.          |
|     BINARY=2             |
|     T=1                  |
|     number=$RANDOM       |
|                          |
|     let "number %= $BINA |
| RY"                      |
|     #  Note that    let  |
| "number >>= 14"    gives |
|  a better random distrib |
| ution                    |
|     #+ (right shifts out |
|  everything except last  |
| binary digit).           |
|     if [ "$number" -eq $ |
| T ]                      |
|     then                 |
|       echo "TRUE"        |
|     else                 |
|       echo "FALSE"       |
|     fi                   |
|                          |
|     echo                 |
|                          |
|                          |
|     # Generate a toss of |
|  the dice.               |
|     SPOTS=6   # Modulo 6 |
|  gives range 0 - 5.      |
|               # Incremen |
| ting by 1 gives desired  |
| range of 1 - 6.          |
|               # Thanks,  |
| Paulo Marcel Coelho Arag |
| ao, for the simplificati |
| on.                      |
|     die1=0               |
|     die2=0               |
|     # Would it be better |
|  to just set SPOTS=7 and |
|  not add 1? Why or why n |
| ot?                      |
|                          |
|     # Tosses each die se |
| parately, and so gives c |
| orrect odds.             |
|                          |
|         let "die1 = $RAN |
| DOM % $SPOTS +1" # Roll  |
| first one.               |
|         let "die2 = $RAN |
| DOM % $SPOTS +1" # Roll  |
| second one.              |
|         #  Which arithme |
| tic operation, above, ha |
| s greater precedence --  |
|         #+ modulo (%) or |
|  addition (+)?           |
|                          |
|                          |
|     let "throw = $die1 + |
|  $die2"                  |
|     echo "Throw of the d |
| ice = $throw"            |
|     echo                 |
|                          |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 9-12. Picking a random card from a deck**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # pick-card.sh       |
|                          |
|     # This is an example |
|  of choosing random elem |
| ents of an array.        |
|                          |
|                          |
|     # Pick a card, any c |
| ard.                     |
|                          |
|     Suites="Clubs        |
|     Diamonds             |
|     Hearts               |
|     Spades"              |
|                          |
|     Denominations="2     |
|     3                    |
|     4                    |
|     5                    |
|     6                    |
|     7                    |
|     8                    |
|     9                    |
|     10                   |
|     Jack                 |
|     Queen                |
|     King                 |
|     Ace"                 |
|                          |
|     # Note variables spr |
| ead over multiple lines. |
|                          |
|                          |
|     suite=($Suites)      |
|            # Read into a |
| rray variable.           |
|     denomination=($Denom |
| inations)                |
|                          |
|     num_suites=${#suite[ |
| *]}        # Count how m |
| any elements.            |
|     num_denominations=${ |
| #denomination[*]}        |
|                          |
|     echo -n "${denominat |
| ion[$((RANDOM%num_denomi |
| nations))]} of "         |
|     echo ${suite[$((RAND |
| OM%num_suites))]}        |
|                          |
|                          |
|     # $bozo sh pick-card |
| s.sh                     |
|     # Jack of Clubs      |
|                          |
|                          |
|     # Thank you, "jipe," |
|  for pointing out this u |
| se of $RANDOM.           |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 9-13. Brownian Motion Simulation**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # brownian.sh        |
|     # Author: Mendel Coo |
| per                      |
|     # Reldate: 10/26/07  |
|     # License: GPL3      |
|                          |
|     #  ----------------- |
| ------------------------ |
| -----------------------  |
|     #  This script model |
| s Brownian motion:       |
|     #+ the random wander |
| ings of tiny particles i |
| n a fluid,               |
|     #+ as they are buffe |
| ted by random currents a |
| nd collisions.           |
|     #+ This is colloquia |
| lly known as the "Drunka |
| rd's Walk."              |
|                          |
|     #  It can also be co |
| nsidered as a stripped-d |
| own simulation of a      |
|     #+ Galton Board, a s |
| lanted board with a patt |
| ern of pegs,             |
|     #+ down which rolls  |
| a succession of marbles, |
|  one at a time.          |
|     #+ At the bottom is  |
| a row of slots or catch  |
| basins in which          |
|     #+ the marbles come  |
| to rest at the end of th |
| eir journey.             |
|     #  Think of it as a  |
| kind of bare-bones Pachi |
| nko game.                |
|     #  As you see by run |
| ning the script,         |
|     #+ most of the marbl |
| es cluster around the ce |
| nter slot.               |
|     #+ This is consisten |
| t with the expected bino |
| mial distribution.       |
|     #  As a Galton Board |
|  simulation, the script  |
|     #+ disregards such p |
| arameters as             |
|     #+ board tilt-angle, |
|  rolling friction of the |
|  marbles,                |
|     #+ angles of impact, |
|  and elasticity of the p |
| egs.                     |
|     #  To what extent do |
| es this affect the accur |
| acy of the simulation?   |
|     #  ----------------- |
| ------------------------ |
| -----------------------  |
|                          |
|     PASSES=500           |
|   #  Number of particle  |
| interactions / marbles.  |
|     ROWS=10              |
|   #  Number of "collisio |
| ns" (or horiz. peg rows) |
| .                        |
|     RANGE=3              |
|   #  0 - 2 output range  |
| from $RANDOM.            |
|     POS=0                |
|   #  Left/right position |
| .                        |
|     RANDOM=$$            |
|   #  Seeds the random nu |
| mber generator from PID  |
|                          |
|   #+ of script.          |
|                          |
|     declare -a Slots     |
|   # Array holding cumula |
| tive results of passes.  |
|     NUMSLOTS=21          |
|   # Number of slots at b |
| ottom of board.          |
|                          |
|                          |
|     Initialize_Slots ()  |
| { # Zero out all element |
| s of the array.          |
|     for i in $( seq $NUM |
| SLOTS )                  |
|     do                   |
|       Slots[$i]=0        |
|     done                 |
|                          |
|     echo                 |
|   # Blank line at beginn |
| ing of run.              |
|       }                  |
|                          |
|                          |
|     Show_Slots () {      |
|     echo; echo           |
|     echo -n " "          |
|     for i in $( seq $NUM |
| SLOTS )   # Pretty-print |
|  array elements.         |
|     do                   |
|       printf "%3d" ${Slo |
| ts[$i]}   # Allot three  |
| spaces per result.       |
|     done                 |
|                          |
|     echo # Row of slots: |
|     echo " |__|__|__|__| |
| __|__|__|__|__|__|__|__| |
| __|__|__|__|__|__|__|__| |
| __|"                     |
|     echo "               |
|                   ||"    |
|     echo #  Note that if |
|  the count within any pa |
| rticular slot exceeds 99 |
| ,                        |
|          #+ it messes up |
|  the display.            |
|          #  Running only |
| (!) 500 passes usually a |
| voids this.              |
|       }                  |
|                          |
|                          |
|     Move () {            |
|    # Move one unit right |
|  / left, or stay put.    |
|       Move=$RANDOM       |
|    # How random is $RAND |
| OM? Well, let's see ...  |
|       let "Move %= RANGE |
| "  # Normalize into rang |
| e of 0 - 2.              |
|       case "$Move" in    |
|         0 ) ;;           |
|          # Do nothing, i |
| .e., stay in place.      |
|         1 ) ((POS--));;  |
|          # Left.         |
|         2 ) ((POS++));;  |
|          # Right.        |
|         * ) echo -n "Err |
| or ";;   # Anomaly! (Sho |
| uld never occur.)        |
|       esac               |
|       }                  |
|                          |
|                          |
|     Play () {            |
|          # Single pass ( |
| inner loop).             |
|     i=0                  |
|     while [ "$i" -lt "$R |
| OWS" ]   # One event per |
|  row.                    |
|     do                   |
|       Move               |
|       ((i++));           |
|     done                 |
|                          |
|     SHIFT=11             |
|          # Why 11, and n |
| ot 10?                   |
|     let "POS += $SHIFT"  |
|          # Shift "zero p |
| osition" to center.      |
|     (( Slots[$POS]++ ))  |
|          # DEBUG: echo $ |
| POS                      |
|                          |
|     # echo -n "$POS "    |
|                          |
|       }                  |
|                          |
|                          |
|     Run () {             |
|          # Outer loop.   |
|     p=0                  |
|     while [ "$p" -lt "$P |
| ASSES" ]                 |
|     do                   |
|       Play               |
|       (( p++ ))          |
|       POS=0              |
|          # Reset to zero |
| . Why?                   |
|     done                 |
|       }                  |
|                          |
|                          |
|     # --------------     |
|     # main ()            |
|     Initialize_Slots     |
|     Run                  |
|     Show_Slots           |
|     # --------------     |
|                          |
|     exit $?              |
|                          |
|     #  Exercises:        |
|     #  ---------         |
|     #  1) Show the resul |
| ts in a vertical bar gra |
| ph, or as an alternative |
| ,                        |
|     #+    a scattergram. |
|     #  2) Alter the scri |
| pt to use /dev/urandom i |
| nstead of $RANDOM.       |
|     #     Will this make |
|  the results more random |
| ?                        |
|     #  3) Provide some s |
| ort of "animation" or gr |
| aphic output             |
|     #     for each marbl |
| e played.                |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

*Jipe* points out a set of techniques for generating random numbers
within a range.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #  Generate random n |
| umber between 6 and 30.  |
|        rnumber=$((RANDOM |
| %25+6))                  |
|                          |
|     #  Generate random n |
| umber in the same 6 - 30 |
|  range,                  |
|     #+ but the number mu |
| st be evenly divisible b |
| y 3.                     |
|        rnumber=$(((RANDO |
| M%30/3+1)*3))            |
|                          |
|     #  Note that this wi |
| ll not work all the time |
| .                        |
|     #  It fails if $RAND |
| OM%30 returns 0.         |
|                          |
|     #  Frank Wang sugges |
| ts the following alterna |
| tive:                    |
|        rnumber=$(( RANDO |
| M%27/3*3+6 ))            |
                          
+--------------------------+--------------------------+--------------------------+

*Bill Gradwohl* came up with an improved formula that works for positive
numbers.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     rnumber=$(((RANDOM%( |
| max-min+divisibleBy))/di |
| visibleBy*divisibleBy+mi |
| n))                      |
                          
+--------------------------+--------------------------+--------------------------+

Here Bill presents a versatile function that returns a random number
between two specified values.

.. raw:: html

   <div class="EXAMPLE">

**Example 9-14. Random between values**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # random-between.sh  |
|     # Random number betw |
| een two specified values |
| .                        |
|     # Script by Bill Gra |
| dwohl, with minor modifi |
| cations by the document  |
| author.                  |
|     # Corrections in lin |
| es 187 and 189 by Anthon |
| y Le Clezio.             |
|     # Used with permissi |
| on.                      |
|                          |
|                          |
|     randomBetween() {    |
|        #  Generates a po |
| sitive or negative rando |
| m number                 |
|        #+ between $min a |
| nd $max                  |
|        #+ and divisible  |
| by $divisibleBy.         |
|        #  Gives a "reaso |
| nably random" distributi |
| on of return values.     |
|        #                 |
|        #  Bill Gradwohl  |
| - Oct 1, 2003            |
|                          |
|        syntax() {        |
|        # Function embedd |
| ed within function.      |
|           echo           |
|           echo    "Synta |
| x: randomBetween [min] [ |
| max] [multiple]"         |
|           echo           |
|           echo -n "Expec |
| ts up to 3 passed parame |
| ters, "                  |
|           echo    "but a |
| ll are completely option |
| al."                     |
|           echo    "min i |
| s the minimum value"     |
|           echo    "max i |
| s the maximum value"     |
|           echo -n "multi |
| ple specifies that the a |
| nswer must be "          |
|           echo     "a mu |
| ltiple of this value."   |
|           echo    "    i |
| .e. answer must be evenl |
| y divisible by this numb |
| er."                     |
|           echo           |
|           echo    "If an |
| y value is missing, defa |
| ults area supplied as: 0 |
|  32767 1"                |
|           echo -n "Succe |
| ssful completion returns |
|  0, "                    |
|           echo     "unsu |
| ccessful completion retu |
| rns"                     |
|           echo    "funct |
| ion syntax and 1."       |
|           echo -n "The a |
| nswer is returned in the |
|  global variable "       |
|           echo    "rando |
| mBetweenAnswer"          |
|           echo -n "Negat |
| ive values for any passe |
| d parameter are "        |
|           echo    "handl |
| ed correctly."           |
|        }                 |
|                          |
|        local min=${1:-0} |
|        local max=${2:-32 |
| 767}                     |
|        local divisibleBy |
| =${3:-1}                 |
|        # Default values  |
| assigned, in case parame |
| ters not passed to funct |
| ion.                     |
|                          |
|        local x           |
|        local spread      |
|                          |
|        # Let's make sure |
|  the divisibleBy value i |
| s positive.              |
|        [ ${divisibleBy}  |
| -lt 0 ] && divisibleBy=$ |
| ((0-divisibleBy))        |
|                          |
|        # Sanity check.   |
|        if [ $# -gt 3 -o  |
| ${divisibleBy} -eq 0 -o  |
|  ${min} -eq ${max} ]; th |
| en                       |
|           syntax         |
|           return 1       |
|        fi                |
|                          |
|        # See if the min  |
| and max are reversed.    |
|        if [ ${min} -gt $ |
| {max} ]; then            |
|           # Swap them.   |
|           x=${min}       |
|           min=${max}     |
|           max=${x}       |
|        fi                |
|                          |
|        #  If min is itse |
| lf not evenly divisible  |
| by $divisibleBy,         |
|        #+ then fix the m |
| in to be within range.   |
|        if [ $((min/divis |
| ibleBy*divisibleBy)) -ne |
|  ${min} ]; then          |
|           if [ ${min} -l |
| t 0 ]; then              |
|              min=$((min/ |
| divisibleBy*divisibleBy) |
| )                        |
|           else           |
|              min=$((((mi |
| n/divisibleBy)+1)*divisi |
| bleBy))                  |
|           fi             |
|        fi                |
|                          |
|        #  If max is itse |
| lf not evenly divisible  |
| by $divisibleBy,         |
|        #+ then fix the m |
| ax to be within range.   |
|        if [ $((max/divis |
| ibleBy*divisibleBy)) -ne |
|  ${max} ]; then          |
|           if [ ${max} -l |
| t 0 ]; then              |
|              max=$((((ma |
| x/divisibleBy)-1)*divisi |
| bleBy))                  |
|           else           |
|              max=$((max/ |
| divisibleBy*divisibleBy) |
| )                        |
|           fi             |
|        fi                |
|                          |
|        #  -------------- |
| ------------------------ |
| ------------------------ |
| -------                  |
|        #  Now, to do the |
|  real work.              |
|                          |
|        #  Note that to g |
| et a proper distribution |
|  for the end points,     |
|        #+ the range of r |
| andom values has to be a |
| llowed to go between     |
|        #+ 0 and abs(max- |
| min)+divisibleBy, not ju |
| st abs(max-min)+1.       |
|                          |
|        #  The slight inc |
| rease will produce the p |
| roper distribution for t |
| he                       |
|        #+ end points.    |
|                          |
|        #  Changing the f |
| ormula to use abs(max-mi |
| n)+1 will still produce  |
|        #+ correct answer |
| s, but the randomness of |
|  those answers is faulty |
|  in                      |
|        #+ that the numbe |
| r of times the end point |
| s ($min and $max) are re |
| turned                   |
|        #+ is considerabl |
| y lower than when the co |
| rrect formula is used.   |
|        #  -------------- |
| ------------------------ |
| ------------------------ |
| -------                  |
|                          |
|        spread=$((max-min |
| ))                       |
|        #  Omair Eshkenaz |
| i points out that this t |
| est is unnecessary,      |
|        #+ since max and  |
| min have already been sw |
| itched around.           |
|        [ ${spread} -lt 0 |
|  ] && spread=$((0-spread |
| ))                       |
|        let spread+=divis |
| ibleBy                   |
|        randomBetweenAnsw |
| er=$(((RANDOM%spread)/di |
| visibleBy*divisibleBy+mi |
| n))                      |
|                          |
|        return 0          |
|                          |
|        #  However, Paulo |
|  Marcel Coelho Aragao po |
| ints out that            |
|        #+ when $max and  |
| $min are not divisible b |
| y $divisibleBy,          |
|        #+ the formula fa |
| ils.                     |
|        #                 |
|        #  He suggests in |
| stead the following form |
| ula:                     |
|        #    rnumber = $( |
| ((RANDOM%(max-min+1)+min |
| )/divisibleBy*divisibleB |
| y))                      |
|                          |
|     }                    |
|                          |
|     # Let's test the fun |
| ction.                   |
|     min=-14              |
|     max=20               |
|     divisibleBy=3        |
|                          |
|                          |
|     #  Generate an array |
|  of expected answers and |
|  check to make sure we g |
| et                       |
|     #+ at least one of e |
| ach answer if we loop lo |
| ng enough.               |
|                          |
|     declare -a answer    |
|     minimum=${min}       |
|     maximum=${max}       |
|        if [ $((minimum/d |
| ivisibleBy*divisibleBy)) |
|  -ne ${minimum} ]; then  |
|           if [ ${minimum |
| } -lt 0 ]; then          |
|              minimum=$(( |
| minimum/divisibleBy*divi |
| sibleBy))                |
|           else           |
|              minimum=$(( |
| ((minimum/divisibleBy)+1 |
| )*divisibleBy))          |
|           fi             |
|        fi                |
|                          |
|                          |
|        #  If max is itse |
| lf not evenly divisible  |
| by $divisibleBy,         |
|        #+ then fix the m |
| ax to be within range.   |
|                          |
|        if [ $((maximum/d |
| ivisibleBy*divisibleBy)) |
|  -ne ${maximum} ]; then  |
|           if [ ${maximum |
| } -lt 0 ]; then          |
|              maximum=$(( |
| ((maximum/divisibleBy)-1 |
| )*divisibleBy))          |
|           else           |
|              maximum=$(( |
| maximum/divisibleBy*divi |
| sibleBy))                |
|           fi             |
|        fi                |
|                          |
|                          |
|     #  We need to genera |
| te only positive array s |
| ubscripts,               |
|     #+ so we need a disp |
| lacement that that will  |
| guarantee                |
|     #+ positive results. |
|                          |
|     disp=$((0-minimum))  |
|     for ((i=${minimum};  |
| i<=${maximum}; i+=divisi |
| bleBy)); do              |
|        answer[i+disp]=0  |
|     done                 |
|                          |
|                          |
|     # Now loop a large n |
| umber of times to see wh |
| at we get.               |
|     loopIt=1000   #  The |
|  script author suggests  |
| 100000,                  |
|                   #+ but |
|  that takes a good long  |
| while.                   |
|                          |
|     for ((i=0; i<${loopI |
| t}; ++i)); do            |
|                          |
|        #  Note that we a |
| re specifying min and ma |
| x in reversed order here |
|  to                      |
|        #+ make the funct |
| ion correct for this cas |
| e.                       |
|                          |
|        randomBetween ${m |
| ax} ${min} ${divisibleBy |
| }                        |
|                          |
|        # Report an error |
|  if an answer is unexpec |
| ted.                     |
|        [ ${randomBetween |
| Answer} -lt ${min} -o ${ |
| randomBetweenAnswer} -gt |
|  ${max} ] \              |
|        && echo MIN or MA |
| X error - ${randomBetwee |
| nAnswer}!                |
|        [ $((randomBetwee |
| nAnswer%${divisibleBy})) |
|  -ne 0 ] \               |
|        && echo DIVISIBLE |
|  BY error - ${randomBetw |
| eenAnswer}!              |
|                          |
|        # Store the answe |
| r away statistically.    |
|        answer[randomBetw |
| eenAnswer+disp]=$((answe |
| r[randomBetweenAnswer+di |
| sp]+1))                  |
|     done                 |
|                          |
|                          |
|                          |
|     # Let's check the re |
| sults                    |
|                          |
|     for ((i=${minimum};  |
| i<=${maximum}; i+=divisi |
| bleBy)); do              |
|        [ ${answer[i+disp |
| ]} -eq 0 ] \             |
|        && echo "We never |
|  got an answer of $i." \ |
|        || echo "${i} occ |
| urred ${answer[i+disp]}  |
| times."                  |
|     done                 |
|                          |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Just how random is ``      $RANDOM     `` ? The best way to test this is
to write a script that tracks the distribution of "random" numbers
generated by ``      $RANDOM     `` . Let's roll a
``      $RANDOM     `` die a few times . . .

.. raw:: html

   <div class="EXAMPLE">

**Example 9-15. Rolling a single die with RANDOM**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # How random is RAND |
| OM?                      |
|                          |
|     RANDOM=$$       # Re |
| seed the random number g |
| enerator using script pr |
| ocess ID.                |
|                          |
|     PIPS=6          # A  |
| die has 6 pips.          |
|     MAXTHROWS=600   # In |
| crease this if you have  |
| nothing better to do wit |
| h your time.             |
|     throw=0         # Nu |
| mber of times the dice h |
| ave been cast.           |
|                          |
|     ones=0          #  M |
| ust initialize counts to |
|  zero,                   |
|     twos=0          #+ s |
| ince an uninitialized va |
| riable is null, NOT zero |
| .                        |
|     threes=0             |
|     fours=0              |
|     fives=0              |
|     sixes=0              |
|                          |
|     print_result ()      |
|     {                    |
|     echo                 |
|     echo "ones =   $ones |
| "                        |
|     echo "twos =   $twos |
| "                        |
|     echo "threes = $thre |
| es"                      |
|     echo "fours =  $four |
| s"                       |
|     echo "fives =  $five |
| s"                       |
|     echo "sixes =  $sixe |
| s"                       |
|     echo                 |
|     }                    |
|                          |
|     update_count()       |
|     {                    |
|     case "$1" in         |
|       0) ((ones++));;    |
| # Since a die has no "ze |
| ro", this corresponds to |
|  1.                      |
|       1) ((twos++));;    |
| # And this to 2.         |
|       2) ((threes++));;  |
| # And so forth.          |
|       3) ((fours++));;   |
|       4) ((fives++));;   |
|       5) ((sixes++));;   |
|     esac                 |
|     }                    |
|                          |
|     echo                 |
|                          |
|                          |
|     while [ "$throw" -lt |
|  "$MAXTHROWS" ]          |
|     do                   |
|       let "die1 = RANDOM |
|  % $PIPS"                |
|       update_count $die1 |
|       let "throw += 1"   |
|     done                 |
|                          |
|     print_result         |
|                          |
|     exit $?              |
|                          |
|     #  The scores should |
|  distribute evenly, assu |
| ming RANDOM is random.   |
|     #  With $MAXTHROWS a |
| t 600, all should cluste |
| r around 100,            |
|     #+ plus-or-minus 20  |
| or so.                   |
|     #                    |
|     #  Keep in mind that |
|  RANDOM is a ***pseudora |
| ndom*** generator,       |
|     #+ and not a spectac |
| ularly good one at that. |
|                          |
|     #  Randomness is a d |
| eep and complex subject. |
|     #  Sufficiently long |
|  "random" sequences may  |
| exhibit                  |
|     #+ chaotic and other |
|  "non-random" behavior.  |
|                          |
|     # Exercise (easy):   |
|     # ---------------    |
|     # Rewrite this scrip |
| t to flip a coin 1000 ti |
| mes.                     |
|     # Choices are "HEADS |
| " and "TAILS."           |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

As we have seen in the last example, it is best to *reseed* the
``             RANDOM           `` generator each time it is invoked.
Using the same seed for ``             RANDOM           `` repeats the
same series of numbers. ` [2]  <randomvar.html#FTN.AEN5857>`__ (This
mirrors the behavior of the ``             random()           ``
function in *C* .)

.. raw:: html

   <div class="EXAMPLE">

**Example 9-16. Reseeding RANDOM**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # seeding-random.sh: |
|  Seeding the RANDOM vari |
| able.                    |
|     # v 1.1, reldate 09  |
| Feb 2013                 |
|                          |
|     MAXCOUNT=25       #  |
| How many numbers to gene |
| rate.                    |
|     SEED=                |
|                          |
|     random_numbers ()    |
|     {                    |
|     local count=0        |
|     local number         |
|                          |
|     while [ "$count" -lt |
|  "$MAXCOUNT" ]           |
|     do                   |
|       number=$RANDOM     |
|       echo -n "$number " |
|       let "count++"      |
|     done                 |
|     }                    |
|                          |
|     echo; echo           |
|                          |
|     SEED=1               |
|     RANDOM=$SEED      #  |
| Setting RANDOM seeds the |
|  random number generator |
| .                        |
|     echo "Random seed =  |
| $SEED"                   |
|     random_numbers       |
|                          |
|                          |
|     RANDOM=$SEED      #  |
| Same seed for RANDOM . . |
|  .                       |
|     echo; echo "Again, w |
| ith same random seed ... |
| "                        |
|     echo "Random seed =  |
| $SEED"                   |
|     random_numbers    #  |
| . . . reproduces the exa |
| ct same number series.   |
|                       #  |
|                       #  |
| When is it useful to dup |
| licate a "random" series |
| ?                        |
|                          |
|     echo; echo           |
|                          |
|     SEED=2               |
|     RANDOM=$SEED      #  |
| Trying again, but with a |
|  different seed . . .    |
|     echo "Random seed =  |
| $SEED"                   |
|     random_numbers    #  |
| . . . gives a different  |
| number series.           |
|                          |
|     echo; echo           |
|                          |
|     # RANDOM=$$  seeds R |
| ANDOM from process id of |
|  script.                 |
|     # It is also possibl |
| e to seed RANDOM from 't |
| ime' or 'date' commands. |
|                          |
|     # Getting fancy...   |
|     SEED=$(head -1 /dev/ |
| urandom | od -N 1 | awk  |
| '{ print $2 }'| sed s/^0 |
| *//)                     |
|     #  Pseudo-random out |
| put fetched              |
|     #+ from /dev/urandom |
|  (system pseudo-random d |
| evice-file),             |
|     #+ then converted to |
|  line of printable (octa |
| l) numbers by "od",      |
|     #+ then "awk" retrie |
| ves just one number for  |
| SEED,                    |
|     #+ finally "sed" rem |
| oves any leading zeros.  |
|     RANDOM=$SEED         |
|     echo "Random seed =  |
| $SEED"                   |
|     random_numbers       |
|                          |
|     echo; echo           |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="NOTE">

+--------------+--------------+--------------+--------------+--------------+--------------+
| |Note|       |
| The          |
| ``           |
| /dev/urandom |
|          ``  |
| pseudo-devic |
| e            |
| file         |
| provides a   |
| method of    |
| generating   |
| much more    |
| "random"     |
| pseudorandom |
| numbers than |
| the          |
| ``           |
| $RANDOM      |
|     ``       |
| variable.    |
| ``           |
|            d |
| d if=/dev/ur |
| andom of=tar |
| getfile      |
|   bs=1 count |
| =XX          |
|           `` |
| creates a    |
| file of      |
| well-scatter |
| ed           |
| pseudorandom |
| numbers.     |
| However,     |
| assigning    |
| these        |
| numbers to a |
| variable in  |
| a script     |
| requires a   |
| workaround,  |
| such as      |
| filtering    |
| through      |
| `od <extmisc |
| .html#ODREF> |
| `__          |
| (as in above |
| example,     |
| `Example     |
| 16-14 <textp |
| roc.html#RND |
| >`__         |
| , and        |
| `Example     |
| A-36 <contri |
| buted-script |
| s.html#INSER |
| TIONSORT>`__ |
| ), or even   |
| piping to    |
| `md5sum <fil |
| earchiv.html |
| #MD5SUMREF>` |
| __           |
| (see         |
| `Example     |
| 36-16 <color |
| izing.html#H |
| ORSERACE>`__ |
| ).           |
|              |
| There are    |
| also other   |
| ways to      |
| generate     |
| pseudorandom |
| numbers in a |
| script.      |
| **Awk**      |
| provides a   |
| convenient   |
| means of     |
| doing this.  |
|              |
| .. raw:: htm |
| l            |
|              |
|    <div      |
|    class="EX |
| AMPLE">      |
|              |
| **Example    |
| 9-17.        |
| Pseudorandom |
| numbers,     |
| using        |
| `awk <awk.ht |
| ml#AWKREF>`_ |
| _**          |
|              |
| +----------- |
| ------------ |
| ---+-------- |
| ------------ |
| ------+----- |
| ------------ |
| ---------+   |
| | .. code::  |
| PROGRAMLISTI |
| NG |         |
| |            |
|              |
|    |         |
| |     #!/bin |
| /bash        |
|    |         |
| |     #  ran |
| dom2.sh: Ret |
| ur |         |
| | ns a pseud |
| orandom numb |
| er |         |
| |  in the ra |
| nge 0 - 1,   |
|    |         |
| |     #+ to  |
| 6 decimal pl |
| ac |         |
| | es. For ex |
| ample: 0.822 |
| 72 |         |
| | 5          |
|              |
|    |         |
| |     #  Use |
| s the awk ra |
| nd |         |
| | () functio |
| n.           |
|    |         |
| |            |
|              |
|    |         |
| |     AWKSCR |
| IPT=' { sran |
| d( |         |
| | ); print r |
| and() } '    |
|    |         |
| |     #      |
|       Comman |
| d( |         |
| | s)/paramet |
| ers passed t |
| o  |         |
| | awk        |
|              |
|    |         |
| |     # Note |
|  that srand( |
| )  |         |
| | reseeds aw |
| k's random n |
| um |         |
| | ber genera |
| tor.         |
|    |         |
| |            |
|              |
|    |         |
| |            |
|              |
|    |         |
| |     echo - |
| n "Random nu |
| mb |         |
| | er between |
|  0 and 1 = " |
|    |         |
| |            |
|              |
|    |         |
| |     echo | |
|  awk "$AWKSC |
| RI |         |
| | PT"        |
|              |
|    |         |
| |     # What |
|  happens if  |
| yo |         |
| | u leave ou |
| t the 'echo' |
| ?  |         |
| |            |
|              |
|    |         |
| |     exit 0 |
|              |
|    |         |
| |            |
|              |
|    |         |
| |            |
|              |
|    |         |
| |     # Exer |
| cises:       |
|    |         |
| |     # ---- |
| -----        |
|    |         |
| |            |
|              |
|    |         |
| |     # 1) U |
| sing a loop  |
| co |         |
| | nstruct, p |
| rint out 10  |
| di |         |
| | fferent ra |
| ndom numbers |
| .  |         |
| |     #      |
|  (Hint: you  |
| mu |         |
| | st reseed  |
| the srand()  |
| fu |         |
| | nction wit |
| h a differen |
| t  |         |
| | seed       |
|              |
|    |         |
| |     #+     |
|  in each pas |
| s  |         |
| | through th |
| e loop. What |
|  h |         |
| | appens if  |
| you omit thi |
| s? |         |
| | )          |
|              |
|    |         |
| |            |
|              |
|    |         |
| |     # 2) U |
| sing an inte |
| ge |         |
| | r multipli |
| er as a scal |
| in |         |
| | g factor,  |
| generate ran |
| do |         |
| | m numbers  |
|              |
|    |         |
| |     #+   i |
| n the range  |
| of |         |
| |  10 to 100 |
| .            |
|    |         |
| |            |
|              |
|    |         |
| |     # 3) S |
| ame as exerc |
| is |         |
| | e #2, abov |
| e, but gener |
| at |         |
| | e random i |
| ntegers this |
|  t |         |
| | ime.       |
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
| .. raw:: htm |
| l            |
|              |
|    </div>    |
|              |
| The          |
| `date <timed |
| ate.html#DAT |
| EREF>`__     |
| command also |
| lends itself |
| to           |
| `generating  |
| pseudorandom |
| integer      |
| sequences <t |
| imedate.html |
| #DATERANDREF |
| >`__         |
| .            |
+--------------+--------------+--------------+--------------+--------------+--------------+

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

` [1]  <randomvar.html#AEN5817>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

True "randomness," insofar as it exists at all, can only be found in
certain incompletely understood natural phenomena, such as radioactive
decay. Computers only *simulate* randomness, and computer-generated
sequences of "random" numbers are therefore referred to as
*pseudorandom* .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [2]  <randomvar.html#AEN5857>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

The *seed* of a computer-generated pseudorandom number series can be
considered an identification label. For example, think of the
pseudorandom series with a seed of *23* as
``                 Series           #23               `` .

A property of a pseurandom number series is the length of the cycle
before it starts repeating itself. A good pseurandom generator will
produce series with very long cycles.

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
| `Prev <declareref.html>` | Typing variables:        |
| __                       | **declare** or           |
| `Home <index.html>`__    | **typeset**              |
| `Next <manipulatingvars. | `Up <variables2.html>`__ |
| html>`__                 | Manipulating Variables   |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
