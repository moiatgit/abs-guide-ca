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

`Prev <list-cons.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <ivr.html>`__

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

   <div class="CHAPTER">

  Chapter 27. Arrays
===================

Newer versions of Bash support one-dimensional arrays. Array elements
may be initialized with the ``             variable[xx]           ``
notation. Alternatively, a script may introduce the entire array by an
explicit ``             declare -a variable           `` statement. To
dereference (retrieve the contents of) an array element, use *curly
bracket* notation, that is, ``             ${element[xx]}           `` .

.. raw:: html

   <div class="EXAMPLE">

**Example 27-1. Simple array usage**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|                          |
|     area[11]=23          |
|     area[13]=37          |
|     area[51]=UFOs        |
|                          |
|     #  Array members nee |
| d not be consecutive or  |
| contiguous.              |
|                          |
|     #  Some members of t |
| he array can be left uni |
| nitialized.              |
|     #  Gaps in the array |
|  are okay.               |
|     #  In fact, arrays w |
| ith sparse data ("sparse |
|  arrays")                |
|     #+ are useful in spr |
| eadsheet-processing soft |
| ware.                    |
|                          |
|                          |
|     echo -n "area[11] =  |
| "                        |
|     echo ${area[11]}     |
| #  {curly brackets} need |
| ed.                      |
|                          |
|     echo -n "area[13] =  |
| "                        |
|     echo ${area[13]}     |
|                          |
|     echo "Contents of ar |
| ea[51] are ${area[51]}." |
|                          |
|     # Contents of uninit |
| ialized array variable p |
| rint blank (null variabl |
| e).                      |
|     echo -n "area[43] =  |
| "                        |
|     echo ${area[43]}     |
|     echo "(area[43] unas |
| signed)"                 |
|                          |
|     echo                 |
|                          |
|     # Sum of two array v |
| ariables assigned to thi |
| rd                       |
|     area[5]=`expr ${area |
| [11]} + ${area[13]}`     |
|     echo "area[5] = area |
| [11] + area[13]"         |
|     echo -n "area[5] = " |
|     echo ${area[5]}      |
|                          |
|     area[6]=`expr ${area |
| [11]} + ${area[51]}`     |
|     echo "area[6] = area |
| [11] + area[51]"         |
|     echo -n "area[6] = " |
|     echo ${area[6]}      |
|     # This fails because |
|  adding an integer to a  |
| string is not permitted. |
|                          |
|     echo; echo; echo     |
|                          |
|     # ------------------ |
| ------------------------ |
| -----------------------  |
|     # Another array, "ar |
| ea2".                    |
|     # Another way of ass |
| igning array variables.. |
| .                        |
|     # array_name=( XXX Y |
| YY ZZZ ... )             |
|                          |
|     area2=( zero one two |
|  three four )            |
|                          |
|     echo -n "area2[0] =  |
| "                        |
|     echo ${area2[0]}     |
|     # Aha, zero-based in |
| dexing (first element of |
|  array is [0], not [1]). |
|                          |
|     echo -n "area2[1] =  |
| "                        |
|     echo ${area2[1]}     |
| # [1] is second element  |
| of array.                |
|     # ------------------ |
| ------------------------ |
| -----------------------  |
|                          |
|     echo; echo; echo     |
|                          |
|     # ------------------ |
| ------------------------ |
| -----                    |
|     # Yet another array, |
|  "area3".                |
|     # Yet another way of |
|  assigning array variabl |
| es...                    |
|     # array_name=([xx]=X |
| XX [yy]=YYY ...)         |
|                          |
|     area3=([17]=seventee |
| n [24]=twenty-four)      |
|                          |
|     echo -n "area3[17] = |
|  "                       |
|     echo ${area3[17]}    |
|                          |
|     echo -n "area3[24] = |
|  "                       |
|     echo ${area3[24]}    |
|     # ------------------ |
| ------------------------ |
| -----                    |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

As we have seen, a convenient way of initializing an entire array is the
``      array=( element1 element2 ... elementN )     `` notation.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     base64_charset=( {A. |
| .Z} {a..z} {0..9} + / =  |
| )                        |
|                    #  Us |
| ing extended brace expan |
| sion                     |
|                    #+ to |
|  initialize the elements |
|  of the array.           |
|                          |
|                    #  Ex |
| cerpted from vladz's "ba |
| se64.sh" script          |
|                    #+ in |
|  the "Contributed Script |
| s" appendix.             |
                          
+--------------------------+--------------------------+--------------------------+

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| Bash permits array operations on variables, even if the variables are    |
| not explicitly declared as arrays.                                       |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: PROGRAMLISTING |                                             |
| |                          |                                             |
| |     string=abcABC123ABCa |                                             |
| | bc                       |                                             |
| |     echo ${string[@]}    |                                             |
| |             # abcABC123A |                                             |
| | BCabc                    |                                             |
| |     echo ${string[*]}    |                                             |
| |             # abcABC123A |                                             |
| | BCabc                    |                                             |
| |     echo ${string[0]}    |                                             |
| |             # abcABC123A |                                             |
| | BCabc                    |                                             |
| |     echo ${string[1]}    |                                             |
| |             # No output! |                                             |
| |                          |                                             |
| |             # Why?       |                                             |
| |     echo ${#string[@]}   |                                             |
| |             # 1          |                                             |
| |                          |                                             |
| |             # One elemen |                                             |
| | t in the array.          |                                             |
| |                          |                                             |
| |             # The string |                                             |
| |  itself.                 |                                             |
| |                          |                                             |
| |     # Thank you, Michael |                                             |
| |  Zick, for pointing this |                                             |
| |  out.                    |                                             |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
|                                                                          |
| Once again this demonstrates that `Bash variables are                    |
| untyped <untyped.html#BVUNTYPED>`__ .                                    |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

.. raw:: html

   <div class="EXAMPLE">

**Example 27-2. Formatting a poem**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # poem.sh: Pretty-pr |
| ints one of the ABS Guid |
| e author's favorite poem |
| s.                       |
|                          |
|     # Lines of the poem  |
| (single stanza).         |
|     Line[1]="I do not kn |
| ow which to prefer,"     |
|     Line[2]="The beauty  |
| of inflections"          |
|     Line[3]="Or the beau |
| ty of innuendoes,"       |
|     Line[4]="The blackbi |
| rd whistling"            |
|     Line[5]="Or just aft |
| er."                     |
|     # Note that quoting  |
| permits embedding whites |
| pace.                    |
|                          |
|     # Attribution.       |
|     Attrib[1]=" Wallace  |
| Stevens"                 |
|     Attrib[2]="\"Thirtee |
| n Ways of Looking at a B |
| lackbird\""              |
|     # This poem is in th |
| e Public Domain (copyrig |
| ht expired).             |
|                          |
|     echo                 |
|                          |
|     tput bold   # Bold p |
| rint.                    |
|                          |
|     for index in 1 2 3 4 |
|  5    # Five lines.      |
|     do                   |
|       printf "     %s\n" |
|  "${Line[index]}"        |
|     done                 |
|                          |
|     for index in 1 2     |
|       # Two attribution  |
| lines.                   |
|     do                   |
|       printf "           |
| %s\n" "${Attrib[index]}" |
|     done                 |
|                          |
|     tput sgr0   # Reset  |
| terminal.                |
|                 # See 't |
| put' docs.               |
|                          |
|     echo                 |
|                          |
|     exit 0               |
|                          |
|     # Exercise:          |
|     # --------           |
|     # Modify this script |
|  to pretty-print a poem  |
| from a text data file.   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Array variables have a syntax all their own, and even standard Bash
commands and operators have special options adapted for array use.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-3. Various array operations**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # array-ops.sh: More |
|  fun with arrays.        |
|                          |
|                          |
|     array=( zero one two |
|  three four five )       |
|     # Element 0   1   2  |
|    3     4    5          |
|                          |
|     echo ${array[0]}     |
|    #  zero               |
|     echo ${array:0}      |
|    #  zero               |
|                          |
|    #  Parameter expansio |
| n of first element,      |
|                          |
|    #+ starting at positi |
| on # 0 (1st character).  |
|     echo ${array:1}      |
|    #  ero                |
|                          |
|    #  Parameter expansio |
| n of first element,      |
|                          |
|    #+ starting at positi |
| on # 1 (2nd character).  |
|                          |
|     echo "-------------- |
| "                        |
|                          |
|     echo ${#array[0]}    |
|    #  4                  |
|                          |
|    #  Length of first el |
| ement of array.          |
|     echo ${#array}       |
|    #  4                  |
|                          |
|    #  Length of first el |
| ement of array.          |
|                          |
|    #  (Alternate notatio |
| n)                       |
|                          |
|     echo ${#array[1]}    |
|    #  3                  |
|                          |
|    #  Length of second e |
| lement of array.         |
|                          |
|    #  Arrays in Bash hav |
| e zero-based indexing.   |
|                          |
|     echo ${#array[*]}    |
|    #  6                  |
|                          |
|    #  Number of elements |
|  in array.               |
|     echo ${#array[@]}    |
|    #  6                  |
|                          |
|    #  Number of elements |
|  in array.               |
|                          |
|     echo "-------------- |
| "                        |
|                          |
|     array2=( [0]="first  |
| element" [1]="second ele |
| ment" [3]="fourth elemen |
| t" )                     |
|     #            ^     ^ |
|        ^     ^      ^    |
|     ^     ^      ^       |
|  ^                       |
|     # Quoting permits em |
| bedding whitespace withi |
| n individual array eleme |
| nts.                     |
|                          |
|     echo ${array2[0]}    |
|    # first element       |
|     echo ${array2[1]}    |
|    # second element      |
|     echo ${array2[2]}    |
|    #                     |
|                          |
|    # Skipped in initiali |
| zation, and therefore nu |
| ll.                      |
|     echo ${array2[3]}    |
|    # fourth element      |
|     echo ${#array2[0]}   |
|    # 13    (length of fi |
| rst element)             |
|     echo ${#array2[*]}   |
|    # 3     (number of el |
| ements in array)         |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Many of the standard `string
operations <string-manipulation.html#STRINGMANIP>`__ work on arrays.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-4. String operations on arrays**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # array-strops.sh: S |
| tring operations on arra |
| ys.                      |
|                          |
|     # Script by Michael  |
| Zick.                    |
|     # Used in ABS Guide  |
| with permission.         |
|     # Fixups: 05 May 08, |
|  04 Aug 08.              |
|                          |
|     #  In general, any s |
| tring operation using th |
| e ${name ... } notation  |
|     #+ can be applied to |
|  all string elements in  |
| an array,                |
|     #+ with the ${name[@ |
| ] ... } or ${name[*] ... |
| } notation.              |
|                          |
|                          |
|     arrayZ=( one two thr |
| ee four five five )      |
|                          |
|     echo                 |
|                          |
|     # Trailing Substring |
|  Extraction              |
|     echo ${arrayZ[@]:0}  |
|     # one two three four |
|  five five               |
|     #                ^   |
|       All elements.      |
|                          |
|     echo ${arrayZ[@]:1}  |
|     # two three four fiv |
| e five                   |
|     #                ^   |
|       All elements follo |
| wing element[0].         |
|                          |
|     echo ${arrayZ[@]:1:2 |
| }   # two three          |
|     #                  ^ |
|       Only the two eleme |
| nts after element[0].    |
|                          |
|     echo "---------"     |
|                          |
|                          |
|     # Substring Removal  |
|                          |
|     # Removes shortest m |
| atch from front of strin |
| g(s).                    |
|                          |
|     echo ${arrayZ[@]#f*r |
| }   # one two three five |
|  five                    |
|     #               ^    |
|     # Applied to all ele |
| ments of the array.      |
|                          |
|     # Matches "four" and |
|  removes it.             |
|                          |
|     # Longest match from |
|  front of string(s)      |
|     echo ${arrayZ[@]##t* |
| e}  # one two four five  |
| five                     |
|     #               ^^   |
|     # Applied to all ele |
| ments of the array.      |
|                          |
|     # Matches "three" an |
| d removes it.            |
|                          |
|     # Shortest match fro |
| m back of string(s)      |
|     echo ${arrayZ[@]%h*e |
| }   # one two t four fiv |
| e five                   |
|     #               ^    |
|     # Applied to all ele |
| ments of the array.      |
|                          |
|     # Matches "hree" and |
|  removes it.             |
|                          |
|     # Longest match from |
|  back of string(s)       |
|     echo ${arrayZ[@]%%t* |
| e}  # one two four five  |
| five                     |
|     #               ^^   |
|     # Applied to all ele |
| ments of the array.      |
|                          |
|     # Matches "three" an |
| d removes it.            |
|                          |
|     echo "-------------- |
| --------"                |
|                          |
|                          |
|     # Substring Replacem |
| ent                      |
|                          |
|     # Replace first occu |
| rrence of substring with |
|  replacement.            |
|     echo ${arrayZ[@]/fiv |
| /XYZ}   # one two three  |
| four XYZe XYZe           |
|     #               ^    |
|         # Applied to all |
|  elements of the array.  |
|                          |
|     # Replace all occurr |
| ences of substring.      |
|     echo ${arrayZ[@]//iv |
| /YY}    # one two three  |
| four fYYe fYYe           |
|                          |
|         # Applied to all |
|  elements of the array.  |
|                          |
|     # Delete all occurre |
| nces of substring.       |
|     # Not specifing a re |
| placement defaults to 'd |
| elete' ...               |
|     echo ${arrayZ[@]//fi |
| /}      # one two three  |
| four ve ve               |
|     #               ^^   |
|         # Applied to all |
|  elements of the array.  |
|                          |
|     # Replace front-end  |
| occurrences of substring |
| .                        |
|     echo ${arrayZ[@]/#fi |
| /XY}    # one two three  |
| four XYve XYve           |
|     #                ^   |
|         # Applied to all |
|  elements of the array.  |
|                          |
|     # Replace back-end o |
| ccurrences of substring. |
|     echo ${arrayZ[@]/%ve |
| /ZZ}    # one two three  |
| four fiZZ fiZZ           |
|     #                ^   |
|         # Applied to all |
|  elements of the array.  |
|                          |
|     echo ${arrayZ[@]/%o/ |
| XX}     # one twXX three |
|  four five five          |
|     #                ^   |
|         # Why?           |
|                          |
|     echo "-------------- |
| ---------------"         |
|                          |
|                          |
|     replacement() {      |
|         echo -n "!!!"    |
|     }                    |
|                          |
|     echo ${arrayZ[@]/%e/ |
| $(replacement)}          |
|     #                ^   |
| ^^^^^^^^^^^^^^           |
|     # on!!! two thre!!!  |
| four fiv!!! fiv!!!       |
|     # The stdout of repl |
| acement() is the replace |
| ment string.             |
|     # Q.E.D: The replace |
| ment action is, in effec |
| t, an 'assignment.'      |
|                          |
|     echo "-------------- |
| ----------------------"  |
|                          |
|     #  Accessing the "fo |
| r-each":                 |
|     echo ${arrayZ[@]//*/ |
| $(replacement optional_a |
| rguments)}               |
|     #                ^^  |
| ^^^^^^^^^^^^^            |
|     # !!! !!! !!! !!! !! |
| ! !!!                    |
|                          |
|     #  Now, if Bash woul |
| d only pass the matched  |
| string                   |
|     #+ to the function b |
| eing called . . .        |
|                          |
|     echo                 |
|                          |
|     exit 0               |
|                          |
|     #  Before reaching f |
| or a Big Hammer -- Perl, |
|  Python, or all the rest |
|  --                      |
|     #  recall:           |
|     #    $( ... ) is com |
| mand substitution.       |
|     #    A function runs |
|  as a sub-process.       |
|     #    A function writ |
| es its output (if echo-e |
| d) to stdout.            |
|     #    Assignment, in  |
| conjunction with "echo"  |
| and command substitution |
| ,                        |
|     #+   can read a func |
| tion's stdout.           |
|     #    The name[@] not |
| ation specifies (the equ |
| ivalent of) a "for-each" |
|     #+   operation.      |
|     #  Bash is more powe |
| rful than you think!     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

`Command substitution <commandsub.html#COMMANDSUBREF>`__ can construct
the individual elements of an array.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-5. Loading the contents of a script into an array**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # script-array.sh: L |
| oads this script into an |
|  array.                  |
|     # Inspired by an e-m |
| ail from Chris Martin (t |
| hanks!).                 |
|                          |
|     script_contents=( $( |
| cat "$0") )  #  Stores c |
| ontents of this script ( |
| $0)                      |
|                          |
|              #+ in an ar |
| ray.                     |
|                          |
|     for element in $(seq |
|  0 $((${#script_contents |
| [@]} - 1)))              |
|       do                 |
| #  ${#script_contents[@] |
| }                        |
|                          |
| #+ gives number of eleme |
| nts in the array.        |
|                          |
| #                        |
|                          |
| #  Question:             |
|                          |
| #  Why is  seq 0  necess |
| ary?                     |
|                          |
| #  Try changing it to se |
| q 1.                     |
|       echo -n "${script_ |
| contents[$element]}"     |
|                          |
| # List each field of thi |
| s script on a single lin |
| e.                       |
|     # echo -n "${script_ |
| contents[element]}" also |
|  works because of ${ ... |
|  }.                      |
|       echo -n " -- "     |
| # Use " -- " as a field  |
| separator.               |
|     done                 |
|                          |
|     echo                 |
|                          |
|     exit 0               |
|                          |
|     # Exercise:          |
|     # --------           |
|     #  Modify this scrip |
| t so it lists itself     |
|     #+ in its original f |
| ormat,                   |
|     #+ complete with whi |
| tespace, line breaks, et |
| c.                       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

In an array context, some Bash `builtins <internal.html#BUILTINREF>`__
have a slightly altered meaning. For example,
`unset <internal.html#UNSETREF>`__ deletes array elements, or even an
entire array.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-6. Some special properties of arrays**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     declare -a colors    |
|     #  All subsequent co |
| mmands in this script wi |
| ll treat                 |
|     #+ the variable "col |
| ors" as an array.        |
|                          |
|     echo "Enter your fav |
| orite colors (separated  |
| from each other by a spa |
| ce)."                    |
|                          |
|     read -a colors    #  |
| Enter at least 3 colors  |
| to demonstrate features  |
| below.                   |
|     #  Special option to |
|  'read' command,         |
|     #+ allowing assignme |
| nt of elements in an arr |
| ay.                      |
|                          |
|     echo                 |
|                          |
|     element_count=${#col |
| ors[@]}                  |
|     # Special syntax to  |
| extract number of elemen |
| ts in array.             |
|     #     element_count= |
| ${#colors[*]} works also |
| .                        |
|     #                    |
|     #  The "@" variable  |
| allows word splitting wi |
| thin quotes              |
|     #+ (extracts variabl |
| es separated by whitespa |
| ce).                     |
|     #                    |
|     #  This corresponds  |
| to the behavior of "$@"  |
| and "$*"                 |
|     #+ in positional par |
| ameters.                 |
|                          |
|     index=0              |
|                          |
|     while [ "$index" -lt |
|  "$element_count" ]      |
|     do    # List all the |
|  elements in the array.  |
|       echo ${colors[$ind |
| ex]}                     |
|       #    ${colors[inde |
| x]} also works because i |
| t's within ${ ... } brac |
| kets.                    |
|       let "index = $inde |
| x + 1"                   |
|       # Or:              |
|       #    ((index++))   |
|     done                 |
|     # Each array element |
|  listed on a separate li |
| ne.                      |
|     # If this is not des |
| ired, use  echo -n "${co |
| lors[$index]} "          |
|     #                    |
|     # Doing it with a "f |
| or" loop instead:        |
|     #   for i in "${colo |
| rs[@]}"                  |
|     #   do               |
|     #     echo "$i"      |
|     #   done             |
|     # (Thanks, S.C.)     |
|                          |
|     echo                 |
|                          |
|     # Again, list all th |
| e elements in the array, |
|  but using a more elegan |
| t method.                |
|       echo ${colors[@]}  |
|          # echo ${colors |
| [*]} also works.         |
|                          |
|     echo                 |
|                          |
|     # The "unset" comman |
| d deletes elements of an |
|  array, or entire array. |
|     unset colors[1]      |
|          # Remove 2nd el |
| ement of array.          |
|                          |
|          # Same effect a |
| s   colors[1]=           |
|     echo  ${colors[@]}   |
|          # List array ag |
| ain, missing 2nd element |
| .                        |
|                          |
|     unset colors         |
|          # Delete entire |
|  array.                  |
|                          |
|          #  unset colors |
| [*] and                  |
|                          |
|          #+ unset colors |
| [@] also work.           |
|     echo; echo -n "Color |
| s gone."                 |
|     echo ${colors[@]}    |
|          # List array ag |
| ain, now empty.          |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

As seen in the previous example, either **${array\_name[@]}** or
**${array\_name[\*]}** refers to *all* the elements of the array.
Similarly, to get a count of the number of elements in an array, use
either **${#array\_name[@]}** or **${#array\_name[\*]}** .
**${#array\_name}** is the length (number of characters) of
**${array\_name[0]}** , the first element of the array.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-7. Of empty arrays and empty elements**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # empty-array.sh     |
|                          |
|     #  Thanks to Stephan |
| e Chazelas for the origi |
| nal example,             |
|     #+ and to Michael Zi |
| ck and Omair Eshkenazi,  |
| for extending it.        |
|     #  And to Nathan Cou |
| lter for clarifications  |
| and corrections.         |
|                          |
|                          |
|     # An empty array is  |
| not the same as an array |
|  with empty elements.    |
|                          |
|       array0=( first sec |
| ond third )              |
|       array1=( '' )   #  |
| "array1" consists of one |
|  empty element.          |
|       array2=( )      #  |
| No elements . . . "array |
| 2" is empty.             |
|       array3=(   )    #  |
| What about this array?   |
|                          |
|                          |
|     echo                 |
|     ListArray()          |
|     {                    |
|     echo                 |
|     echo "Elements in ar |
| ray0:  ${array0[@]}"     |
|     echo "Elements in ar |
| ray1:  ${array1[@]}"     |
|     echo "Elements in ar |
| ray2:  ${array2[@]}"     |
|     echo "Elements in ar |
| ray3:  ${array3[@]}"     |
|     echo                 |
|     echo "Length of firs |
| t element in array0 = ${ |
| #array0}"                |
|     echo "Length of firs |
| t element in array1 = ${ |
| #array1}"                |
|     echo "Length of firs |
| t element in array2 = ${ |
| #array2}"                |
|     echo "Length of firs |
| t element in array3 = ${ |
| #array3}"                |
|     echo                 |
|     echo "Number of elem |
| ents in array0 = ${#arra |
| y0[*]}"  # 3             |
|     echo "Number of elem |
| ents in array1 = ${#arra |
| y1[*]}"  # 1  (Surprise! |
| )                        |
|     echo "Number of elem |
| ents in array2 = ${#arra |
| y2[*]}"  # 0             |
|     echo "Number of elem |
| ents in array3 = ${#arra |
| y3[*]}"  # 0             |
|     }                    |
|                          |
|     # ================== |
| ======================== |
| ======================== |
| =                        |
|                          |
|     ListArray            |
|                          |
|     # Try extending thos |
| e arrays.                |
|                          |
|     # Adding an element  |
| to an array.             |
|     array0=( "${array0[@ |
| ]}" "new1" )             |
|     array1=( "${array1[@ |
| ]}" "new1" )             |
|     array2=( "${array2[@ |
| ]}" "new1" )             |
|     array3=( "${array3[@ |
| ]}" "new1" )             |
|                          |
|     ListArray            |
|                          |
|     # or                 |
|     array0[${#array0[*]} |
| ]="new2"                 |
|     array1[${#array1[*]} |
| ]="new2"                 |
|     array2[${#array2[*]} |
| ]="new2"                 |
|     array3[${#array3[*]} |
| ]="new2"                 |
|                          |
|     ListArray            |
|                          |
|     # When extended as a |
| bove, arrays are 'stacks |
| ' ...                    |
|     # Above is the 'push |
| ' ...                    |
|     # The stack 'height' |
|  is:                     |
|     height=${#array2[@]} |
|     echo                 |
|     echo "Stack height f |
| or array2 = $height"     |
|                          |
|     # The 'pop' is:      |
|     unset array2[${#arra |
| y2[@]}-1]   #  Arrays ar |
| e zero-based,            |
|     height=${#array2[@]} |
|             #+ which mea |
| ns first element has ind |
| ex 0.                    |
|     echo                 |
|     echo "POP"           |
|     echo "New stack heig |
| ht for array2 = $height" |
|                          |
|     ListArray            |
|                          |
|     # List only 2nd and  |
| 3rd elements of array0.  |
|     from=1          # Ze |
| ro-based numbering.      |
|     to=2                 |
|     array3=( ${array0[@] |
| :1:2} )                  |
|     echo                 |
|     echo "Elements in ar |
| ray3:  ${array3[@]}"     |
|                          |
|     # Works like a strin |
| g (array of characters). |
|     # Try some other "st |
| ring" forms.             |
|                          |
|     # Replacement:       |
|     array4=( ${array0[@] |
| /second/2nd} )           |
|     echo                 |
|     echo "Elements in ar |
| ray4:  ${array4[@]}"     |
|                          |
|     # Replace all matchi |
| ng wildcarded string.    |
|     array5=( ${array0[@] |
| //new?/old} )            |
|     echo                 |
|     echo "Elements in ar |
| ray5:  ${array5[@]}"     |
|                          |
|     # Just when you are  |
| getting the feel for thi |
| s . . .                  |
|     array6=( ${array0[@] |
| #*new} )                 |
|     echo # This one migh |
| t surprise you.          |
|     echo "Elements in ar |
| ray6:  ${array6[@]}"     |
|                          |
|     array7=( ${array0[@] |
| #new1} )                 |
|     echo # After array6  |
| this should not be a sur |
| prise.                   |
|     echo "Elements in ar |
| ray7:  ${array7[@]}"     |
|                          |
|     # Which looks a lot  |
| like . . .               |
|     array8=( ${array0[@] |
| /new1/} )                |
|     echo                 |
|     echo "Elements in ar |
| ray8:  ${array8[@]}"     |
|                          |
|     #  So what can one s |
| ay about this?           |
|                          |
|     #  The string operat |
| ions are performed on    |
|     #+ each of the eleme |
| nts in var[@] in success |
| ion.                     |
|     #  Therefore : Bash  |
| supports string vector o |
| perations.               |
|     #  If the result is  |
| a zero length string,    |
|     #+ that element disa |
| ppears in the resulting  |
| assignment.              |
|     #  However, if the e |
| xpansion is in quotes, t |
| he null elements remain. |
|                          |
|     #  Michael Zick:     |
| Question, are those stri |
| ngs hard or soft quotes? |
|     #  Nathan Coulter:   |
| There is no such thing a |
| s "soft quotes."         |
|     #!    What's really  |
| happening is that        |
|     #!+   the pattern ma |
| tching happens after     |
|     #!+   all the other  |
| expansions of [word]     |
|     #!+   in cases like  |
| ${parameter#word}.       |
|                          |
|                          |
|     zap='new*'           |
|     array9=( ${array0[@] |
| /$zap/} )                |
|     echo                 |
|     echo "Number of elem |
| ents in array9:  ${#arra |
| y9[@]}"                  |
|     array9=( "${array0[@ |
| ]/$zap/}" )              |
|     echo "Elements in ar |
| ray9:  ${array9[@]}"     |
|     # This time the null |
|  elements remain.        |
|     echo "Number of elem |
| ents in array9:  ${#arra |
| y9[@]}"                  |
|                          |
|                          |
|     # Just when you thou |
| ght you were still in Ka |
| nsas . . .               |
|     array10=( ${array0[@ |
| ]#$zap} )                |
|     echo                 |
|     echo "Elements in ar |
| ray10:  ${array10[@]}"   |
|     # But, the asterisk  |
| in zap won't be interpre |
| ted if quoted.           |
|     array10=( ${array0[@ |
| ]#"$zap"} )              |
|     echo                 |
|     echo "Elements in ar |
| ray10:  ${array10[@]}"   |
|     # Well, maybe we _ar |
| e_ still in Kansas . . . |
|     # (Revisions to abov |
| e code block by Nathan C |
| oulter.)                 |
|                          |
|                          |
|     #  Compare array7 wi |
| th array10.              |
|     #  Compare array8 wi |
| th array9.               |
|                          |
|     #  Reiterating: No s |
| uch thing as soft quotes |
| !                        |
|     #  Nathan Coulter ex |
| plains:                  |
|     #  Pattern matching  |
| of 'word' in ${parameter |
| #word} is done after     |
|     #+ parameter expansi |
| on and *before* quote re |
| moval.                   |
|     #  In the normal cas |
| e, pattern matching is d |
| one *after* quote remova |
| l.                       |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

The relationship of **${array\_name[@]}** and **${array\_name[\*]}** is
analogous to that between `$@ and $\* <internalvariables.html#APPREF>`__
. This powerful array notation has a number of uses.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # Copying an array.  |
|     array2=( "${array1[@ |
| ]}" )                    |
|     # or                 |
|     array2="${array1[@]} |
| "                        |
|     #                    |
|     #  However, this fai |
| ls with "sparse" arrays, |
|     #+ arrays with holes |
|  (missing elements) in t |
| hem,                     |
|     #+ as Jochen DeSmet  |
| points out.              |
|     # ------------------ |
| ------------------------ |
|       array1[0]=0        |
|     # array1[1] not assi |
| gned                     |
|       array1[2]=2        |
|       array2=( "${array1 |
| [@]}" )       # Copy it? |
|                          |
|     echo ${array2[0]}    |
|    # 0                   |
|     echo ${array2[2]}    |
|    # (null), should be 2 |
|     # ------------------ |
| ------------------------ |
|                          |
|                          |
|                          |
|     # Adding an element  |
| to an array.             |
|     array=( "${array[@]} |
| " "new element" )        |
|     # or                 |
|     array[${#array[*]}]= |
| "new element"            |
|                          |
|     # Thanks, S.C.       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="TIP">

+--------------------+--------------------+--------------------+--------------------+
| |Tip|              |
| The **array=(      |
| element1 element2  |
| ... elementN )**   |
| initialization     |
| operation, with    |
| the help of        |
| `command           |
| substitution <comm |
| andsub.html#COMMAN |
| DSUBREF>`__        |
| , makes it         |
| possible to load   |
| the contents of a  |
| text file into an  |
| array.             |
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
| |     #!/bin/bash  |
|          |         |
| |                  |
|          |         |
| |     filename=sam |
| ple_file |         |
| |                  |
|          |         |
| |     #            |
|  cat sam |         |
| | ple_file         |
|          |         |
| |     #            |
|          |         |
| |     #            |
|  1 a b c |         |
| |     #            |
|  2 d e f |         |
| | g                |
|          |         |
| |                  |
|          |         |
| |                  |
|          |         |
| |     declare -a a |
| rray1    |         |
| |                  |
|          |         |
| |     array1=( `ca |
| t "$file |         |
| | name"`)          |
|        # |         |
| |   Loads contents |
|          |         |
| |     #         Li |
| st file  |         |
| | to stdout        |
|        # |         |
| | + of $filename i |
| nto arra |         |
| | y1.              |
|          |         |
| |     #            |
|          |         |
| |     #  array1=(  |
| `cat "$f |         |
| | ilename" | tr '\ |
| n' ' '`) |         |
| |     #            |
|          |         |
| |          change  |
| linefeed |         |
| | s in file to spa |
| ces.     |         |
| |     #  Not neces |
| sary bec |         |
| | ause Bash does w |
| ord spli |         |
| | tting,           |
|          |         |
| |     #+ changing  |
| linefeed |         |
| | s to spaces.     |
|          |         |
| |                  |
|          |         |
| |     echo ${array |
| 1[@]}    |         |
| |          # List  |
| the arra |         |
| | y.               |
|          |         |
| |     #            |
|          |         |
| |            1 a b |
|  c 2 d e |         |
| |  fg              |
|          |         |
| |     #            |
|          |         |
| |     #  Each whit |
| espace-s |         |
| | eparated "word"  |
| in the f |         |
| | ile              |
|          |         |
| |     #+ has been  |
| assigned |         |
| |  to an element o |
| f the ar |         |
| | ray.             |
|          |         |
| |                  |
|          |         |
| |     element_coun |
| t=${#arr |         |
| | ay1[*]}          |
|          |         |
| |     echo $elemen |
| t_count  |         |
| |          # 8     |
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

   </div>

Clever scripting makes it possible to add array operations.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-8. Initializing arrays**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # array-assign.bash  |
|                          |
|     #  Array operations  |
| are Bash-specific,       |
|     #+ hence the ".bash" |
|  in the script name.     |
|                          |
|     # Copyright (c) Mich |
| ael S. Zick, 2003, All r |
| ights reserved.          |
|     # License: Unrestric |
| ted reuse in any form, f |
| or any purpose.          |
|     # Version: $ID$      |
|     #                    |
|     # Clarification and  |
| additional comments by W |
| illiam Park.             |
|                          |
|     #  Based on an examp |
| le provided by Stephane  |
| Chazelas                 |
|     #+ which appeared in |
|  an earlier version of t |
| he                       |
|     #+ Advanced Bash Scr |
| ipting Guide.            |
|                          |
|     # Output format of t |
| he 'times' command:      |
|     # User CPU <space> S |
| ystem CPU                |
|     # User CPU of dead c |
| hildren <space> System C |
| PU of dead children      |
|                          |
|     #  Bash has two vers |
| ions of assigning all el |
| ements of an array       |
|     #+ to a new array va |
| riable.                  |
|     #  Both drop 'null r |
| eference' elements       |
|     #+ in Bash versions  |
| 2.04 and later.          |
|     #  An additional arr |
| ay assignment that maint |
| ains the relationship of |
|     #+ [subscript]=value |
|  for arrays may be added |
|  to newer versions.      |
|                          |
|     #  Constructs a larg |
| e array using an interna |
| l command,               |
|     #+ but anything crea |
| ting an array of several |
|  thousand elements       |
|     #+ will do just fine |
| .                        |
|                          |
|     declare -a bigOne=(  |
| /dev/* )  # All the file |
| s in /dev . . .          |
|     echo                 |
|     echo 'Conditions: Un |
| quoted, default IFS, All |
| -Elements-Of'            |
|     echo "Number of elem |
| ents in array is ${#bigO |
| ne[@]}"                  |
|                          |
|     # set -vx            |
|                          |
|                          |
|                          |
|     echo                 |
|     echo '- - testing: = |
| ( ${array[@]} ) - -'     |
|     times                |
|     declare -a bigTwo=(  |
| ${bigOne[@]} )           |
|     # Note parens:    ^  |
|              ^           |
|     times                |
|                          |
|                          |
|     echo                 |
|     echo '- - testing: = |
| ${array[@]} - -'         |
|     times                |
|     declare -a bigThree= |
| ${bigOne[@]}             |
|     # No parentheses thi |
| s time.                  |
|     times                |
|                          |
|     #  Comparing the num |
| bers shows that the seco |
| nd form, pointed out     |
|     #+ by Stephane Chaze |
| las, is faster.          |
|     #                    |
|     #  As William Park e |
| xplains:                 |
|     #+ The bigTwo array  |
| assigned element by elem |
| ent (because of parenthe |
| ses),                    |
|     #+ whereas bigThree  |
| assigned as a single str |
| ing.                     |
|     #  So, in essence, y |
| ou have:                 |
|     #                    |
| bigTwo=( [0]="..." [1]=" |
| ..." [2]="..." ... )     |
|     #                    |
| bigThree=( [0]="... ...  |
| ..." )                   |
|     #                    |
|     #  Verify this by:   |
| echo ${bigTwo[0]}        |
|     #                    |
| echo ${bigThree[0]}      |
|                          |
|                          |
|     #  I will continue t |
| o use the first form in  |
| my example descriptions  |
|     #+ because I think i |
| t is a better illustrati |
| on of what is happening. |
|                          |
|     #  The reusable port |
| ions of my examples will |
|  actual contain          |
|     #+ the second form w |
| here appropriate because |
|  of the speedup.         |
|                          |
|     # MSZ: Sorry about t |
| hat earlier oversight fo |
| lks.                     |
|                          |
|                          |
|     #  Note:             |
|     #  ----              |
|     #  The "declare -a"  |
| statements in lines 32 a |
| nd 44                    |
|     #+ are not strictly  |
| necessary, since it is i |
| mplicit                  |
|     #+ in the  Array=( . |
| .. )  assignment form.   |
|     #  However, eliminat |
| ing these declarations s |
| lows down                |
|     #+ the execution of  |
| the following sections o |
| f the script.            |
|     #  Try it, and see.  |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| Adding a superfluous **declare -a**  |
| statement to an array declaration    |
| may speed up execution of subsequent |
| operations on the array.             |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 27-9. Copying and concatenating arrays**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # CopyArray.sh       |
|     #                    |
|     # This script writte |
| n by Michael Zick.       |
|     # Used here with per |
| mission.                 |
|                          |
|     #  How-To "Pass by N |
| ame & Return by Name"    |
|     #+ or "Building your |
|  own assignment statemen |
| t".                      |
|                          |
|                          |
|     CpArray_Mac() {      |
|                          |
|     # Assignment Command |
|  Statement Builder       |
|                          |
|         echo -n 'eval '  |
|         echo -n "$2"     |
|                 # Destin |
| ation name               |
|         echo -n '=( ${'  |
|         echo -n "$1"     |
|                 # Source |
|  name                    |
|         echo -n '[@]} )' |
|                          |
|     # That could all be  |
| a single command.        |
|     # Matter of style on |
| ly.                      |
|     }                    |
|                          |
|     declare -f CopyArray |
|                 # Functi |
| on "Pointer"             |
|     CopyArray=CpArray_Ma |
| c               # Statem |
| ent Builder              |
|                          |
|     Hype()               |
|     {                    |
|                          |
|     # Hype the array nam |
| ed $1.                   |
|     # (Splice it togethe |
| r with array containing  |
| "Really Rocks".)         |
|     # Return in array na |
| med $2.                  |
|                          |
|         local -a TMP     |
|         local -a hype=(  |
| Really Rocks )           |
|                          |
|         $($CopyArray $1  |
| TMP)                     |
|         TMP=( ${TMP[@]}  |
| ${hype[@]} )             |
|         $($CopyArray TMP |
|  $2)                     |
|     }                    |
|                          |
|     declare -a before=(  |
| Advanced Bash Scripting  |
| )                        |
|     declare -a after     |
|                          |
|     echo "Array Before = |
|  ${before[@]}"           |
|                          |
|     Hype before after    |
|                          |
|     echo "Array After =  |
| ${after[@]}"             |
|                          |
|     # Too much hype?     |
|                          |
|     echo "What ${after[@ |
| ]:3:2}?"                 |
|                          |
|     declare -a modest=(  |
| ${after[@]:2:1} ${after[ |
| @]:3:2} )                |
|     #                    |
|  ---- substring extracti |
| on ----                  |
|                          |
|     echo "Array Modest = |
|  ${modest[@]}"           |
|                          |
|     # What happened to ' |
| before' ?                |
|                          |
|     echo "Array Before = |
|  ${before[@]}"           |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 27-10. More on concatenating arrays**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # array-append.bash  |
|                          |
|     # Copyright (c) Mich |
| ael S. Zick, 2003, All r |
| ights reserved.          |
|     # License: Unrestric |
| ted reuse in any form, f |
| or any purpose.          |
|     # Version: $ID$      |
|     #                    |
|     # Slightly modified  |
| in formatting by M.C.    |
|                          |
|                          |
|     # Array operations a |
| re Bash-specific.        |
|     # Legacy UNIX /bin/s |
| h lacks equivalents.     |
|                          |
|                          |
|     #  Pipe the output o |
| f this script to 'more'  |
|     #+ so it doesn't scr |
| oll off the terminal.    |
|     #  Or, redirect outp |
| ut to a file.            |
|                          |
|                          |
|     declare -a array1=(  |
| zero1 one1 two1 )        |
|     # Subscript packed.  |
|     declare -a array2=(  |
| [0]=zero2 [2]=two2 [3]=t |
| hree2 )                  |
|     # Subscript sparse - |
| - [1] is not defined.    |
|                          |
|     echo                 |
|     echo '- Confirm that |
|  the array is really sub |
| script sparse. -'        |
|     echo "Number of elem |
| ents: 4"        # Hard-c |
| oded for illustration.   |
|     for (( i = 0 ; i < 4 |
|  ; i++ ))                |
|     do                   |
|         echo "Element [$ |
| i]: ${array2[$i]}"       |
|     done                 |
|     # See also the more  |
| general code example in  |
| basics-reviewed.bash.    |
|                          |
|                          |
|     declare -a dest      |
|                          |
|     # Combine (append) t |
| wo arrays into a third a |
| rray.                    |
|     echo                 |
|     echo 'Conditions: Un |
| quoted, default IFS, All |
| -Elements-Of operator'   |
|     echo '- Undefined el |
| ements not present, subs |
| cripts not maintained. - |
| '                        |
|     # # The undefined el |
| ements do not exist; the |
| y are not being dropped. |
|                          |
|     dest=( ${array1[@]}  |
| ${array2[@]} )           |
|     # dest=${array1[@]}$ |
| {array2[@]}     # Strang |
| e results, possibly a bu |
| g.                       |
|                          |
|     # Now, list the resu |
| lt.                      |
|     echo                 |
|     echo '- - Testing Ar |
| ray Append - -'          |
|     cnt=${#dest[@]}      |
|                          |
|     echo "Number of elem |
| ents: $cnt"              |
|     for (( i = 0 ; i < c |
| nt ; i++ ))              |
|     do                   |
|         echo "Element [$ |
| i]: ${dest[$i]}"         |
|     done                 |
|                          |
|     # Assign an array to |
|  a single array element  |
| (twice).                 |
|     dest[0]=${array1[@]} |
|     dest[1]=${array2[@]} |
|                          |
|     # List the result.   |
|     echo                 |
|     echo '- - Testing mo |
| dified array - -'        |
|     cnt=${#dest[@]}      |
|                          |
|     echo "Number of elem |
| ents: $cnt"              |
|     for (( i = 0 ; i < c |
| nt ; i++ ))              |
|     do                   |
|         echo "Element [$ |
| i]: ${dest[$i]}"         |
|     done                 |
|                          |
|     # Examine the modifi |
| ed second element.       |
|     echo                 |
|     echo '- - Reassign a |
| nd list second element - |
|  -'                      |
|                          |
|     declare -a subArray= |
| ${dest[1]}               |
|     cnt=${#subArray[@]}  |
|                          |
|     echo "Number of elem |
| ents: $cnt"              |
|     for (( i = 0 ; i < c |
| nt ; i++ ))              |
|     do                   |
|         echo "Element [$ |
| i]: ${subArray[$i]}"     |
|     done                 |
|                          |
|     #  The assignment of |
|  an entire array to a si |
| ngle element             |
|     #+ of another array  |
| using the '=${ ... }' ar |
| ray assignment           |
|     #+ has converted the |
|  array being assigned in |
| to a string,             |
|     #+ with the elements |
|  separated by a space (t |
| he first character of IF |
| S).                      |
|                          |
|     # If the original el |
| ements didn't contain wh |
| itespace . . .           |
|     # If the original ar |
| ray isn't subscript spar |
| se . . .                 |
|     # Then we could get  |
| the original array struc |
| ture back again.         |
|                          |
|     # Restore from the m |
| odified second element.  |
|     echo                 |
|     echo '- - Listing re |
| stored element - -'      |
|                          |
|     declare -a subArray= |
| ( ${dest[1]} )           |
|     cnt=${#subArray[@]}  |
|                          |
|     echo "Number of elem |
| ents: $cnt"              |
|     for (( i = 0 ; i < c |
| nt ; i++ ))              |
|     do                   |
|         echo "Element [$ |
| i]: ${subArray[$i]}"     |
|     done                 |
|     echo '- - Do not dep |
| end on this behavior. -  |
| -'                       |
|     echo '- - This behav |
| ior is subject to change |
|  - -'                    |
|     echo '- - in version |
| s of Bash newer than ver |
| sion 2.05b - -'          |
|                          |
|     # MSZ: Sorry about a |
| ny earlier confusion fol |
| ks.                      |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

--

Arrays permit deploying old familiar algorithms as shell scripts.
Whether this is necessarily a good idea is left for the reader to
decide.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-11. The Bubble Sort**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # bubble.sh: Bubble  |
| sort, of sorts.          |
|                          |
|     # Recall the algorit |
| hm for a bubble sort. In |
|  this particular version |
| ...                      |
|                          |
|     #  With each success |
| ive pass through the arr |
| ay to be sorted,         |
|     #+ compare two adjac |
| ent elements, and swap t |
| hem if out of order.     |
|     #  At the end of the |
|  first pass, the "heavie |
| st" element has sunk to  |
| bottom.                  |
|     #  At the end of the |
|  second pass, the next " |
| heaviest" one has sunk n |
| ext to bottom.           |
|     #  And so forth.     |
|     #  This means that e |
| ach successive pass need |
| s to traverse less of th |
| e array.                 |
|     #  You will therefor |
| e notice a speeding up i |
| n the printing of the la |
| ter passes.              |
|                          |
|                          |
|     exchange()           |
|     {                    |
|       # Swaps two member |
| s of the array.          |
|       local temp=${Count |
| ries[$1]} #  Temporary s |
| torage                   |
|                          |
|           #+ for element |
|  getting swapped out.    |
|       Countries[$1]=${Co |
| untries[$2]}             |
|       Countries[$2]=$tem |
| p                        |
|                          |
|       return             |
|     }                    |
|                          |
|     declare -a Countries |
|   #  Declare array,      |
|                          |
|   #+ optional here since |
|  it's initialized below. |
|                          |
|     #  Is it permissable |
|  to split an array varia |
| ble over multiple lines  |
|     #+ using an escape ( |
| \)?                      |
|     #  Yes.              |
|                          |
|     Countries=(Netherlan |
| ds Ukraine Zaire Turkey  |
| Russia Yemen Syria \     |
|     Brazil Argentina Nic |
| aragua Japan Mexico Vene |
| zuela Greece England \   |
|     Israel Peru Canada O |
| man Denmark Wales France |
|  Kenya \                 |
|     Xanadu Qatar Liechte |
| nstein Hungary)          |
|                          |
|     # "Xanadu" is the my |
| thical place where, acco |
| rding to Coleridge,      |
|     #+ Kubla Khan did a  |
| pleasure dome decree.    |
|                          |
|                          |
|     clear                |
|        # Clear the scree |
| n to start with.         |
|                          |
|     echo "0: ${Countries |
| [*]}"  # List entire arr |
| ay at pass 0.            |
|                          |
|     number_of_elements=$ |
| {#Countries[@]}          |
|     let "comparisons = $ |
| number_of_elements - 1"  |
|                          |
|     count=1 # Pass numbe |
| r.                       |
|                          |
|     while [ "$comparison |
| s" -gt 0 ]          # Be |
| ginning of outer loop    |
|     do                   |
|                          |
|       index=0  # Reset i |
| ndex to start of array a |
| fter each pass.          |
|                          |
|       while [ "$index" - |
| lt "$comparisons" ] # Be |
| ginning of inner loop    |
|       do                 |
|         if [ ${Countries |
| [$index]} \> ${Countries |
| [`expr $index + 1`]} ]   |
|         #  If out of ord |
| er...                    |
|         #  Recalling tha |
| t \> is ASCII comparison |
|  operator                |
|         #+ within single |
|  brackets.               |
|                          |
|         #  if [[ ${Count |
| ries[$index]} > ${Countr |
| ies[`expr $index + 1`]}  |
| ]]                       |
|         #+ also works.   |
|         then             |
|           exchange $inde |
| x `expr $index + 1`  # S |
| wap.                     |
|         fi               |
|         let "index += 1" |
|   # Or,   index+=1   on  |
| Bash, ver. 3.1 or newer. |
|       done # End of inne |
| r loop                   |
|                          |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| ----                     |
|     # Paulo Marcel Coelh |
| o Aragao suggests for-lo |
| ops as a simpler altenat |
| ive.                     |
|     #                    |
|     # for (( last = $num |
| ber_of_elements - 1 ; la |
| st > 0 ; last-- ))       |
|     ##                   |
|    Fix by C.Y. Hunt      |
|      ^   (Thanks!)       |
|     # do                 |
|     #     for (( i = 0 ; |
|  i < last ; i++ ))       |
|     #     do             |
|     #         [[ "${Coun |
| tries[$i]}" > "${Countri |
| es[$((i+1))]}" ]] \      |
|     #             && exc |
| hange $i $((i+1))        |
|     #     done           |
|     # done               |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| ----                     |
|                          |
|                          |
|     let "comparisons -=  |
| 1" #  Since "heaviest" e |
| lement bubbles to bottom |
| ,                        |
|                          |
|    #+ we need do one les |
| s comparison each pass.  |
|                          |
|     echo                 |
|     echo "$count: ${Coun |
| tries[@]}"  # Print resu |
| ltant array at end of ea |
| ch pass.                 |
|     echo                 |
|     let "count += 1"     |
|             # Increment  |
| pass count.              |
|                          |
|     done                 |
|             # End of out |
| er loop                  |
|                          |
|             # All done.  |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

--

Is it possible to nest arrays within arrays?

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # "Nested" array.    |
|                          |
|     #  Michael Zick prov |
| ided this example,       |
|     #+ with corrections  |
| and clarifications by Wi |
| lliam Park.              |
|                          |
|     AnArray=( $(ls --ino |
| de --ignore-backups --al |
| most-all \               |
|         --directory --fu |
| ll-time --color=none --t |
| ime=status \             |
|         --sort=time -l $ |
| {PWD} ) )  # Commands an |
| d options.               |
|                          |
|     # Spaces are signifi |
| cant . . . and don't quo |
| te anything in the above |
| .                        |
|                          |
|     SubArray=( ${AnArray |
| [@]:11:1}  ${AnArray[@]: |
| 6:5} )                   |
|     #  This array has si |
| x elements:              |
|     #+     SubArray=( [0 |
| ]=${AnArray[11]} [1]=${A |
| nArray[6]} [2]=${AnArray |
| [7]}                     |
|     #      [3]=${AnArray |
| [8]} [4]=${AnArray[9]} [ |
| 5]=${AnArray[10]} )      |
|     #                    |
|     #  Arrays in Bash ar |
| e (circularly) linked li |
| sts                      |
|     #+ of type string (c |
| har *).                  |
|     #  So, this isn't ac |
| tually a nested array,   |
|     #+ but it's function |
| ally similar.            |
|                          |
|     echo "Current direct |
| ory and date of last sta |
| tus change:"             |
|     echo "${SubArray[@]} |
| "                        |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

--

Embedded arrays in combination with `indirect
references <bashver2.html#VARREFNEW>`__ create some fascinating
possibilities

.. raw:: html

   <div class="EXAMPLE">

**Example 27-12. Embedded arrays and indirect references**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # embedded-arrays.sh |
|     # Embedded arrays an |
| d indirect references.   |
|                          |
|     # This script by Den |
| nis Leeuw.               |
|     # Used with permissi |
| on.                      |
|     # Modified by docume |
| nt author.               |
|                          |
|                          |
|     ARRAY1=(             |
|             VAR1_1=value |
| 11                       |
|             VAR1_2=value |
| 12                       |
|             VAR1_3=value |
| 13                       |
|     )                    |
|                          |
|     ARRAY2=(             |
|             VARIABLE="te |
| st"                      |
|             STRING="VAR1 |
| =value1 VAR2=value2 VAR3 |
| =value3"                 |
|             ARRAY21=${AR |
| RAY1[*]}                 |
|     )       # Embed ARRA |
| Y1 within this second ar |
| ray.                     |
|                          |
|     function print () {  |
|             OLD_IFS="$IF |
| S"                       |
|             IFS=$'\n'    |
|     #  To print each arr |
| ay element               |
|                          |
|     #+ on a separate lin |
| e.                       |
|             TEST1="ARRAY |
| 2[*]"                    |
|             local ${!TES |
| T1} # See what happens i |
| f you delete this line.  |
|             #  Indirect  |
| reference.               |
|         #  This makes th |
| e components of $TEST1   |
|         #+ accessible to |
|  this function.          |
|                          |
|                          |
|             #  Let's see |
|  what we've got so far.  |
|             echo         |
|             echo "\$TEST |
| 1 = $TEST1"       #  Jus |
| t the name of the variab |
| le.                      |
|             echo; echo   |
|             echo "{\$TES |
| T1} = ${!TEST1}"  #  Con |
| tents of the variable.   |
|                          |
|                   #  Tha |
| t's what an indirect     |
|                          |
|                   #+ ref |
| erence does.             |
|             echo         |
|             echo "------ |
| ------------------------ |
| -------------"; echo     |
|             echo         |
|                          |
|                          |
|             # Print vari |
| able                     |
|             echo "Variab |
| le VARIABLE: $VARIABLE"  |
|                          |
|             # Print a st |
| ring element             |
|             IFS="$OLD_IF |
| S"                       |
|             TEST2="STRIN |
| G[*]"                    |
|             local ${!TES |
| T2}      # Indirect refe |
| rence (as above).        |
|             echo "String |
|  element VAR2: $VAR2 fro |
| m STRING"                |
|                          |
|             # Print an a |
| rray element             |
|             TEST2="ARRAY |
| 21[*]"                   |
|             local ${!TES |
| T2}      # Indirect refe |
| rence (as above).        |
|             echo "Array  |
| element VAR1_1: $VAR1_1  |
| from ARRAY21"            |
|     }                    |
|                          |
|     print                |
|     echo                 |
|                          |
|     exit 0               |
|                          |
|     #   As the author of |
|  the script notes,       |
|     #+ "you can easily e |
| xpand it to create named |
| -hashes in bash."        |
|     #   (Difficult) exer |
| cise for the reader: imp |
| lement this.             |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

--

Arrays enable implementing a shell script version of the *Sieve of
Eratosthenes* . Of course, a resource-intensive application of this
nature should really be written in a compiled language, such as C. It
runs excruciatingly slowly as a script.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-13. The Sieve of Eratosthenes**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # sieve.sh (ex68.sh) |
|                          |
|     # Sieve of Eratosthe |
| nes                      |
|     # Ancient algorithm  |
| for finding prime number |
| s.                       |
|                          |
|     #  This runs a coupl |
| e of orders of magnitude |
|  slower                  |
|     #+ than the equivale |
| nt program written in C. |
|                          |
|     LOWER_LIMIT=1        |
| # Starting with 1.       |
|     UPPER_LIMIT=1000     |
| # Up to 1000.            |
|     # (You may set this  |
| higher . . . if you have |
|  time on your hands.)    |
|                          |
|     PRIME=1              |
|     NON_PRIME=0          |
|                          |
|     let SPLIT=UPPER_LIMI |
| T/2                      |
|     # Optimization:      |
|     # Need to test numbe |
| rs only halfway to upper |
|  limit. Why?             |
|                          |
|                          |
|     declare -a Primes    |
|     # Primes[] is an arr |
| ay.                      |
|                          |
|                          |
|     initialize ()        |
|     {                    |
|     # Initialize the arr |
| ay.                      |
|                          |
|     i=$LOWER_LIMIT       |
|     until [ "$i" -gt "$U |
| PPER_LIMIT" ]            |
|     do                   |
|       Primes[i]=$PRIME   |
|       let "i += 1"       |
|     done                 |
|     #  Assume all array  |
| members guilty (prime)   |
|     #+ until proven inno |
| cent.                    |
|     }                    |
|                          |
|     print_primes ()      |
|     {                    |
|     # Print out the memb |
| ers of the Primes[] arra |
| y tagged as prime.       |
|                          |
|     i=$LOWER_LIMIT       |
|                          |
|     until [ "$i" -gt "$U |
| PPER_LIMIT" ]            |
|     do                   |
|                          |
|       if [ "${Primes[i]} |
| " -eq "$PRIME" ]         |
|       then               |
|         printf "%8d" $i  |
|         # 8 spaces per n |
| umber gives nice, even c |
| olumns.                  |
|       fi                 |
|                          |
|       let "i += 1"       |
|                          |
|     done                 |
|                          |
|     }                    |
|                          |
|     sift () # Sift out t |
| he non-primes.           |
|     {                    |
|                          |
|     let i=$LOWER_LIMIT+1 |
|     # Let's start with 2 |
| .                        |
|                          |
|     until [ "$i" -gt "$U |
| PPER_LIMIT" ]            |
|     do                   |
|                          |
|     if [ "${Primes[i]}"  |
| -eq "$PRIME" ]           |
|     # Don't bother sievi |
| ng numbers already sieve |
| d (tagged as non-prime). |
|     then                 |
|                          |
|       t=$i               |
|                          |
|       while [ "$t" -le " |
| $UPPER_LIMIT" ]          |
|       do                 |
|         let "t += $i "   |
|         Primes[t]=$NON_P |
| RIME                     |
|         # Tag as non-pri |
| me all multiples.        |
|       done               |
|                          |
|     fi                   |
|                          |
|       let "i += 1"       |
|     done                 |
|                          |
|                          |
|     }                    |
|                          |
|                          |
|     # ================== |
| ======================== |
| ====                     |
|     # main ()            |
|     # Invoke the functio |
| ns sequentially.         |
|     initialize           |
|     sift                 |
|     print_primes         |
|     # This is what they  |
| call structured programm |
| ing.                     |
|     # ================== |
| ======================== |
| ====                     |
|                          |
|     echo                 |
|                          |
|     exit 0               |
|                          |
|                          |
|                          |
|     # ------------------ |
| ------------------------ |
| -------------- #         |
|     # Code below line wi |
| ll not execute, because  |
| of 'exit.'               |
|                          |
|     #  This improved ver |
| sion of the Sieve, by St |
| ephane Chazelas,         |
|     #+ executes somewhat |
|  faster.                 |
|                          |
|     # Must invoke with c |
| ommand-line argument (li |
| mit of primes).          |
|                          |
|     UPPER_LIMIT=$1       |
|             # From comma |
| nd-line.                 |
|     let SPLIT=UPPER_LIMI |
| T/2         # Halfway to |
|  max number.             |
|                          |
|     Primes=( '' $(seq $U |
| PPER_LIMIT) )            |
|                          |
|     i=1                  |
|     until (( ( i += 1 )  |
| > SPLIT ))  # Need check |
|  only halfway.           |
|     do                   |
|       if [[ -n ${Primes[ |
| i]} ]]                   |
|       then               |
|         t=$i             |
|         until (( ( t +=  |
| i ) > UPPER_LIMIT ))     |
|         do               |
|           Primes[t]=     |
|         done             |
|       fi                 |
|     done                 |
|     echo ${Primes[*]}    |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 27-14. The Sieve of Eratosthenes, Optimized**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # Optimized Sieve of |
|  Eratosthenes            |
|     # Script by Jared Ma |
| rtin, with very minor ch |
| anges by ABS Guide autho |
| r.                       |
|     # Used in ABS Guide  |
| with permission (thanks! |
| ).                       |
|                          |
|     # Based on script in |
|  Advanced Bash Scripting |
|  Guide.                  |
|     # http://tldp.org/LD |
| P/abs/html/arrays.html#P |
| RIMES0 (ex68.sh).        |
|                          |
|     # http://www.cs.hmc. |
| edu/~oneill/papers/Sieve |
| -JFP.pdf (reference)     |
|     # Check results agai |
| nst http://primes.utm.ed |
| u/lists/small/1000.txt   |
|                          |
|     # Necessary but not  |
| sufficient would be, e.g |
| .,                       |
|     #     (($(sieve 7919 |
|  | wc -w) == 1000)) && e |
| cho "7919 is the 1000th  |
| prime"                   |
|                          |
|     UPPER_LIMIT=${1:?"Ne |
| ed an upper limit of pri |
| mes to search."}         |
|                          |
|     Primes=( '' $(seq ${ |
| UPPER_LIMIT}) )          |
|                          |
|     typeset -i i t       |
|     Primes[i=1]='' # 1 i |
| s not a prime.           |
|     until (( ( i += 1 )  |
| > (${UPPER_LIMIT}/i) ))  |
|  # Need check only ith-w |
| ay.                      |
|       do                 |
|                          |
|  # Why?                  |
|         if ((${Primes[t= |
| i*(i-1), i]}))           |
|         # Obscure, but i |
| nstructive, use of arith |
| metic expansion in subsc |
| ript.                    |
|         then             |
|           until (( ( t + |
| = i ) > ${UPPER_LIMIT} ) |
| )                        |
|             do Primes[t] |
| =; done                  |
|         fi               |
|       done               |
|                          |
|     # echo ${Primes[*]}  |
|     echo   # Change to o |
| riginal script for prett |
| y-printing (80-col. disp |
| lay).                    |
|     printf "%8d" ${Prime |
| s[*]}                    |
|     echo; echo           |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Compare these array-based prime number generators with alternatives that
do not use arrays, `Example A-15 <contributed-scripts.html#PRIMES>`__ ,
and `Example 16-46 <mathc.html#PRIMES2>`__ .

--

Arrays lend themselves, to some extent, to emulating data structures for
which Bash has no native support.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-15. Emulating a push-down stack**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # stack.sh: push-dow |
| n stack simulation       |
|                          |
|     #  Similar to the CP |
| U stack, a push-down sta |
| ck stores data items     |
|     #+ sequentially, but |
|  releases them in revers |
| e order, last-in first-o |
| ut.                      |
|                          |
|                          |
|     BP=100            #  |
|  Base Pointer of stack a |
| rray.                    |
|                       #  |
|  Begin at element 100.   |
|                          |
|     SP=$BP            #  |
|  Stack Pointer.          |
|                       #  |
|  Initialize it to "base" |
|  (bottom) of stack.      |
|                          |
|     Data=             #  |
|  Contents of stack locat |
| ion.                     |
|                       #  |
|  Must use global variabl |
| e,                       |
|                       #+ |
|  because of limitation o |
| n function return range. |
|                          |
|                          |
|                       #  |
| 100     Base pointer     |
|    <-- Base Pointer      |
|                       #  |
|  99     First data item  |
|                       #  |
|  98     Second data item |
|                       #  |
| ...     More data        |
|                       #  |
|         Last data item   |
|    <-- Stack pointer     |
|                          |
|                          |
|     declare -a stack     |
|                          |
|                          |
|     push()            #  |
| Push item on stack.      |
|     {                    |
|     if [ -z "$1" ]    #  |
| Nothing to push?         |
|     then                 |
|       return             |
|     fi                   |
|                          |
|     let "SP -= 1"     #  |
| Bump stack pointer.      |
|     stack[$SP]=$1        |
|                          |
|     return               |
|     }                    |
|                          |
|     pop()                |
|      # Pop item off stac |
| k.                       |
|     {                    |
|     Data=                |
|      # Empty out data it |
| em.                      |
|                          |
|     if [ "$SP" -eq "$BP" |
|  ]   # Stack empty?      |
|     then                 |
|       return             |
|     fi                   |
|      #  This also keeps  |
| SP from getting past 100 |
| ,                        |
|                          |
|      #+ i.e., prevents a |
|  runaway stack.          |
|                          |
|     Data=${stack[$SP]}   |
|     let "SP += 1"        |
|      # Bump stack pointe |
| r.                       |
|     return               |
|     }                    |
|                          |
|     status_report()      |
|      # Find out what's h |
| appening.                |
|     {                    |
|     echo "-------------- |
| -----------------------" |
|     echo "REPORT"        |
|     echo "Stack Pointer  |
| = $SP"                   |
|     echo "Just popped \" |
| "$Data"\" off the stack. |
| "                        |
|     echo "-------------- |
| -----------------------" |
|     echo                 |
|     }                    |
|                          |
|                          |
|     # ================== |
| ======================== |
| =============            |
|     # Now, for some fun. |
|                          |
|     echo                 |
|                          |
|     # See if you can pop |
|  anything off empty stac |
| k.                       |
|     pop                  |
|     status_report        |
|                          |
|     echo                 |
|                          |
|     push garbage         |
|     pop                  |
|     status_report     #  |
| Garbage in, garbage out. |
|                          |
|                          |
|     value1=23;        pu |
| sh $value1               |
|     value2=skidoo;    pu |
| sh $value2               |
|     value3=LAST;      pu |
| sh $value3               |
|                          |
|     pop               #  |
| LAST                     |
|     status_report        |
|     pop               #  |
| skidoo                   |
|     status_report        |
|     pop               #  |
| 23                       |
|     status_report     #  |
| Last-in, first-out!      |
|                          |
|     #  Notice how the st |
| ack pointer decrements w |
| ith each push,           |
|     #+ and increments wi |
| th each pop.             |
|                          |
|     echo                 |
|                          |
|     exit 0               |
|                          |
|     # ================== |
| ======================== |
| =============            |
|                          |
|                          |
|     # Exercises:         |
|     # ---------          |
|                          |
|     # 1)  Modify the "pu |
| sh()" function to permit |
|  pushing                 |
|     #   + multiple eleme |
| nt on the stack with a s |
| ingle function call.     |
|                          |
|     # 2)  Modify the "po |
| p()" function to permit  |
| popping                  |
|     #   + multiple eleme |
| nt from the stack with a |
|  single function call.   |
|                          |
|     # 3)  Add error chec |
| king to the critical fun |
| ctions.                  |
|     #     That is, retur |
| n an error code, dependi |
| ng on                    |
|     #   + successful or  |
| unsuccessful completion  |
| of the operation,        |
|     #   + and take appro |
| priate action.           |
|                          |
|     # 4)  Using this scr |
| ipt as a starting point, |
|     #   + write a stack- |
| based 4-function calcula |
| tor.                     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

--

Fancy manipulation of array "subscripts" may require intermediate
variables. For projects involving this, again consider using a more
powerful programming language, such as Perl or C.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-16. Complex array application: *Exploring a weird
mathematical series***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # Douglas Hofstadter |
| 's notorious "Q-series": |
|                          |
|     # Q(1) = Q(2) = 1    |
|     # Q(n) = Q(n - Q(n-1 |
| )) + Q(n - Q(n-2)), for  |
| n>2                      |
|                          |
|     #  This is a "chaoti |
| c" integer series with s |
| trange                   |
|     #+ and unpredictable |
|  behavior.               |
|     #  The first 20 term |
| s of the series are:     |
|     #  1 1 2 3 3 4 5 5 6 |
|  6 6 8 8 8 10 9 10 11 11 |
|  12                      |
|                          |
|     #  See Hofstadter's  |
| book, _Goedel, Escher, B |
| ach: An Eternal Golden B |
| raid_,                   |
|     #+ p. 137, ff.       |
|                          |
|                          |
|     LIMIT=100     # Numb |
| er of terms to calculate |
| .                        |
|     LINEWIDTH=20  # Numb |
| er of terms printed per  |
| line.                    |
|                          |
|     Q[1]=1        # Firs |
| t two terms of series ar |
| e 1.                     |
|     Q[2]=1               |
|                          |
|     echo                 |
|     echo "Q-series [$LIM |
| IT terms]:"              |
|     echo -n "${Q[1]} "   |
|            # Output firs |
| t two terms.             |
|     echo -n "${Q[2]} "   |
|                          |
|     for ((n=3; n <= $LIM |
| IT; n++))  # C-like loop |
|  expression.             |
|     do   # Q[n] = Q[n -  |
| Q[n-1]] + Q[n - Q[n-2]]  |
|  for n>2                 |
|     #    Need to break t |
| he expression into inter |
| mediate terms,           |
|     #+   since Bash does |
| n't handle complex array |
|  arithmetic very well.   |
|                          |
|       let "n1 = $n - 1"  |
|        # n-1             |
|       let "n2 = $n - 2"  |
|        # n-2             |
|                          |
|       t0=`expr $n - ${Q[ |
| n1]}`  # n - Q[n-1]      |
|       t1=`expr $n - ${Q[ |
| n2]}`  # n - Q[n-2]      |
|                          |
|       T0=${Q[t0]}        |
|        # Q[n - Q[n-1]]   |
|       T1=${Q[t1]}        |
|        # Q[n - Q[n-2]]   |
|                          |
|     Q[n]=`expr $T0 + $T1 |
| `      # Q[n - Q[n-1]] + |
|  Q[n - Q[n-2]]           |
|     echo -n "${Q[n]} "   |
|                          |
|     if [ `expr $n % $LIN |
| EWIDTH` -eq 0 ]    # For |
| mat output.              |
|     then   #      ^ modu |
| lo                       |
|       echo # Break lines |
|  into neat chunks.       |
|     fi                   |
|                          |
|     done                 |
|                          |
|     echo                 |
|                          |
|     exit 0               |
|                          |
|     #  This is an iterat |
| ive implementation of th |
| e Q-series.              |
|     #  The more intuitiv |
| e recursive implementati |
| on is left as an exercis |
| e.                       |
|     #  Warning: calculat |
| ing this series recursiv |
| ely takes a VERY long ti |
| me                       |
|     #+ via a script. C/C |
| ++ would be orders of ma |
| gnitude faster.          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

--

Bash supports only one-dimensional arrays, though a little trickery
permits simulating multi-dimensional ones.

.. raw:: html

   <div class="EXAMPLE">

**Example 27-17. Simulating a two-dimensional array, then tilting it**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # twodim.sh: Simulat |
| ing a two-dimensional ar |
| ray.                     |
|                          |
|     # A one-dimensional  |
| array consists of a sing |
| le row.                  |
|     # A two-dimensional  |
| array stores rows sequen |
| tially.                  |
|                          |
|     Rows=5               |
|     Columns=5            |
|     # 5 X 5 Array.       |
|                          |
|     declare -a alpha     |
|  # char alpha [Rows] [Co |
| lumns];                  |
|                          |
|  # Unnecessary declarati |
| on. Why?                 |
|                          |
|     load_alpha ()        |
|     {                    |
|     local rc=0           |
|     local index          |
|                          |
|     for i in A B C D E F |
|  G H I J K L M N O P Q R |
|  S T U V W X Y           |
|     do     # Use differe |
| nt symbols if you like.  |
|       local row=`expr $r |
| c / $Columns`            |
|       local column=`expr |
|  $rc % $Rows`            |
|       let "index = $row  |
| * $Rows + $column"       |
|       alpha[$index]=$i   |
|     # alpha[$row][$colum |
| n]                       |
|       let "rc += 1"      |
|     done                 |
|                          |
|     #  Simpler would be  |
|     #+   declare -a alph |
| a=( A B C D E F G H I J  |
| K L M N O P Q R S T U V  |
| W X Y )                  |
|     #+ but this somehow  |
| lacks the "flavor" of a  |
| two-dimensional array.   |
|     }                    |
|                          |
|     print_alpha ()       |
|     {                    |
|     local row=0          |
|     local index          |
|                          |
|     echo                 |
|                          |
|     while [ "$row" -lt " |
| $Rows" ]   #  Print out  |
| in "row major" order:    |
|     do                   |
|            #+ columns va |
| ry,                      |
|                          |
|            #+ while row  |
| (outer loop) remains the |
|  same.                   |
|       local column=0     |
|                          |
|       echo -n "       "  |
|            #  Lines up " |
| square" array with rotat |
| ed one.                  |
|                          |
|       while [ "$column"  |
| -lt "$Columns" ]         |
|       do                 |
|         let "index = $ro |
| w * $Rows + $column"     |
|         echo -n "${alpha |
| [index]} "  # alpha[$row |
| ][$column]               |
|         let "column += 1 |
| "                        |
|       done               |
|                          |
|       let "row += 1"     |
|       echo               |
|                          |
|     done                 |
|                          |
|     # The simpler equiva |
| lent is                  |
|     #     echo ${alpha[* |
| ]} | xargs -n $Columns   |
|                          |
|     echo                 |
|     }                    |
|                          |
|     filter ()     # Filt |
| er out negative array in |
| dices.                   |
|     {                    |
|                          |
|     echo -n "  "  # Prov |
| ides the tilt.           |
|                   # Expl |
| ain how.                 |
|                          |
|     if [[ "$1" -ge 0 &&  |
|  "$1" -lt "$Rows" && "$2 |
| " -ge 0 && "$2" -lt "$Co |
| lumns" ]]                |
|     then                 |
|         let "index = $1  |
| * $Rows + $2"            |
|         # Now, print it  |
| rotated.                 |
|         echo -n " ${alph |
| a[index]}"               |
|         #           alph |
| a[$row][$column]         |
|     fi                   |
|                          |
|     }                    |
|                          |
|                          |
|                          |
|                          |
|     rotate ()  #  Rotate |
|  the array 45 degrees -- |
|     {          #+ "balan |
| ce" it on its lower left |
| hand corner.             |
|     local row            |
|     local column         |
|                          |
|     for (( row = Rows; r |
| ow > -Rows; row-- ))     |
|       do       # Step th |
| rough the array backward |
| s. Why?                  |
|                          |
|       for (( column = 0; |
|  column < Columns; colum |
| n++ ))                   |
|       do                 |
|                          |
|         if [ "$row" -ge  |
| 0 ]                      |
|         then             |
|           let "t1 = $col |
| umn - $row"              |
|           let "t2 = $col |
| umn"                     |
|         else             |
|           let "t1 = $col |
| umn"                     |
|           let "t2 = $col |
| umn + $row"              |
|         fi               |
|                          |
|         filter $t1 $t2   |
|  # Filter out negative a |
| rray indices.            |
|                          |
|  # What happens if you d |
| on't do this?            |
|       done               |
|                          |
|       echo; echo         |
|                          |
|     done                 |
|                          |
|     #  Array rotation in |
| spired by examples (pp.  |
| 143-146) in              |
|     #+ "Advanced C Progr |
| amming on the IBM PC," b |
| y Herbert Mayer          |
|     #+ (see bibliography |
| ).                       |
|     #  This just goes to |
|  show that much of what  |
| can be done in C         |
|     #+ can also be done  |
| in shell scripting.      |
|                          |
|     }                    |
|                          |
|                          |
|     #--------------- Now |
| , let the show begin. -- |
| ----------#              |
|     load_alpha     # Loa |
| d the array.             |
|     print_alpha    # Pri |
| nt it out.               |
|     rotate         # Rot |
| ate it 45 degrees counte |
| rclockwise.              |
|     #------------------- |
| ------------------------ |
| ----------#              |
|                          |
|     exit 0               |
|                          |
|     # This is a rather c |
| ontrived, not to mention |
|  inelegant simulation.   |
|                          |
|     # Exercises:         |
|     # ---------          |
|     # 1)  Rewrite the ar |
| ray loading and printing |
|  functions               |
|     #     in a more intu |
| itive and less kludgy fa |
| shion.                   |
|     #                    |
|     # 2)  Figure out how |
|  the array rotation func |
| tions work.              |
|     #     Hint: think ab |
| out the implications of  |
| backwards-indexing an ar |
| ray.                     |
|     #                    |
|     # 3)  Rewrite this s |
| cript to handle a non-sq |
| uare array,              |
|     #     such as a 6 X  |
| 4 one.                   |
|     #     Try to minimiz |
| e "distortion" when the  |
| array is rotated.        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

A two-dimensional array is essentially equivalent to a one-dimensional
one, but with additional addressing modes for referencing and
manipulating the individual elements by *row* and *column* position.

For an even more elaborate example of simulating a two-dimensional
array, see `Example A-10 <contributed-scripts.html#LIFESLOW>`__ .

--

For more interesting scripts using arrays, see:

-  `Example 12-3 <commandsub.html#AGRAM2>`__

-  `Example 16-46 <mathc.html#PRIMES2>`__

-  `Example A-22 <contributed-scripts.html#HASHEX2>`__

-  `Example A-44 <contributed-scripts.html#HOMEWORK>`__

-  `Example A-41 <contributed-scripts.html#QKY>`__

-  `Example A-42 <contributed-scripts.html#NIM>`__

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <list-cons.html>`_ | List Constructs          |
| _                        | `Up <part5.html>`__      |
| `Home <index.html>`__    | Indirect References      |
| `Next <ivr.html>`__      |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Tip| image:: ../images/tip.gif
.. |Note| image:: ../images/note.gif
