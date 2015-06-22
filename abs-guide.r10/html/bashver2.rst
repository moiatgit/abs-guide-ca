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

`Prev <bash2.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 37. Bash, versions 2, 3, and 4

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <bashver3.html>`__

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

37.1. Bash, version 2
=====================

The current version of *Bash*, the one you have running on your machine,
is most likely version 2.xx.yy, 3.xx.yy, or 4.xx.yy.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ echo $BASH_VER |
| SION                     |
|     3.2.25(1)-release    |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

The version 2 update of the classic Bash scripting language added array
variables, string and parameter expansion, and a better method of
indirect variable references, among other features.

.. raw:: html

   <div class="EXAMPLE">

**Example 37-1. String expansion**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # String expansion.  |
|     # Introduced with ve |
| rsion 2 of Bash.         |
|                          |
|     #  Strings of the fo |
| rm $'xxx'                |
|     #+ have the standard |
|  escaped characters inte |
| rpreted.                 |
|                          |
|     echo $'Ringing bell  |
| 3 times \a \a \a'        |
|          # May only ring |
|  once with certain termi |
| nals.                    |
|          # Or ...        |
|          # May not ring  |
| at all, depending on ter |
| minal settings.          |
|     echo $'Three form fe |
| eds \f \f \f'            |
|     echo $'10 newlines \ |
| n\n\n\n\n\n\n\n\n\n'     |
|     echo $'\102\141\163\ |
| 150'                     |
|          #   B   a   s   |
|  h                       |
|          # Octal equival |
| ent of characters.       |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 37-2. Indirect variable references - the new way**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # Indirect variable  |
| referencing.             |
|     # This has a few of  |
| the attributes of refere |
| nces in C++.             |
|                          |
|                          |
|     a=letter_of_alphabet |
|     letter_of_alphabet=z |
|                          |
|     echo "a = $a"        |
|     # Direct reference.  |
|                          |
|     echo "Now a = ${!a}" |
|     # Indirect reference |
| .                        |
|     #  The ${!variable}  |
| notation is more intuiti |
| ve than the old          |
|     #+ eval var1=\$$var2 |
|                          |
|     echo                 |
|                          |
|     t=table_cell_3       |
|     table_cell_3=24      |
|     echo "t = ${!t}"     |
|                   # t =  |
| 24                       |
|     table_cell_3=387     |
|     echo "Value of t cha |
| nged to ${!t}"    # 387  |
|     # No 'eval' necessar |
| y.                       |
|                          |
|     #  This is useful fo |
| r referencing members of |
|  an array or table,      |
|     #+ or for simulating |
|  a multi-dimensional arr |
| ay.                      |
|     #  An indexing optio |
| n (analogous to pointer  |
| arithmetic)              |
|     #+ would have been n |
| ice. Sigh.               |
|                          |
|     exit 0               |
|                          |
|     # See also, ind-ref. |
| sh example.              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 37-3. Simple database application, using indirect variable
referencing**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # resistor-inventory |
| .sh                      |
|     # Simple database /  |
| table-lookup application |
| .                        |
|                          |
|     # ================== |
| ======================== |
| ==================== #   |
|     # Data               |
|                          |
|     B1723_value=470      |
|                          |
|       # Ohms             |
|     B1723_powerdissip=.2 |
| 5                        |
|       # Watts            |
|     B1723_colorcode="yel |
| low-violet-brown"        |
|       # Color bands      |
|     B1723_loc=173        |
|                          |
|       # Where they are   |
|     B1723_inventory=78   |
|                          |
|       # How many         |
|                          |
|     B1724_value=1000     |
|     B1724_powerdissip=.2 |
| 5                        |
|     B1724_colorcode="bro |
| wn-black-red"            |
|     B1724_loc=24N        |
|     B1724_inventory=243  |
|                          |
|     B1725_value=10000    |
|     B1725_powerdissip=.1 |
| 25                       |
|     B1725_colorcode="bro |
| wn-black-orange"         |
|     B1725_loc=24N        |
|     B1725_inventory=89   |
|                          |
|     # ================== |
| ======================== |
| ==================== #   |
|                          |
|                          |
|     echo                 |
|                          |
|     PS3='Enter catalog n |
| umber: '                 |
|                          |
|     echo                 |
|                          |
|     select catalog_numbe |
| r in "B1723" "B1724" "B1 |
| 725"                     |
|     do                   |
|       Inv=${catalog_numb |
| er}_inventory            |
|       Val=${catalog_numb |
| er}_value                |
|       Pdissip=${catalog_ |
| number}_powerdissip      |
|       Loc=${catalog_numb |
| er}_loc                  |
|       Ccode=${catalog_nu |
| mber}_colorcode          |
|                          |
|       echo               |
|       echo "Catalog numb |
| er $catalog_number:"     |
|       # Now, retrieve va |
| lue, using indirect refe |
| rencing.                 |
|       echo "There are ${ |
| !Inv} of  [${!Val} ohm / |
|  ${!Pdissip} watt]\      |
|       resistors in stock |
| ."  #        ^           |
|    ^                     |
|       # As of Bash 4.2,  |
| you can replace "ohm" wi |
| th \u2126 (using echo -e |
| ).                       |
|       echo "These are lo |
| cated in bin # ${!Loc}." |
|       echo "Their color  |
| code is \"${!Ccode}\"."  |
|                          |
|       break              |
|     done                 |
|                          |
|     echo; echo           |
|                          |
|     # Exercises:         |
|     # ---------          |
|     # 1) Rewrite this sc |
| ript to read its data fr |
| om an external file.     |
|     # 2) Rewrite this sc |
| ript to use arrays,      |
|     #+   rather than ind |
| irect variable referenci |
| ng.                      |
|     #    Which method is |
|  more straightforward an |
| d intuitive?             |
|     #    Which method is |
|  easier to code?         |
|                          |
|                          |
|     # Notes:             |
|     # -----              |
|     #  Shell scripts are |
|  inappropriate for anyth |
| ing except the most simp |
| le                       |
|     #+ database applicat |
| ions, and even then it i |
| nvolves workarounds and  |
| kludges.                 |
|     #  Much better is to |
|  use a language with nat |
| ive support for data str |
| uctures,                 |
|     #+ such as C++ or Ja |
| va (or even Perl).       |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 37-4. Using arrays and other miscellaneous trickery to deal
four random hands from a deck of cards**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # cards.sh           |
|                          |
|     # Deals four random  |
| hands from a deck of car |
| ds.                      |
|                          |
|     UNPICKED=0           |
|     PICKED=1             |
|                          |
|     DUPE_CARD=99         |
|                          |
|     LOWER_LIMIT=0        |
|     UPPER_LIMIT=51       |
|     CARDS_IN_SUIT=13     |
|     CARDS=52             |
|                          |
|     declare -a Deck      |
|     declare -a Suits     |
|     declare -a Cards     |
|     #  It would have bee |
| n easier to implement an |
| d more intuitive         |
|     #+ with a single, 3- |
| dimensional array.       |
|     #  Perhaps a future  |
| version of Bash will sup |
| port multidimensional ar |
| rays.                    |
|                          |
|                          |
|     initialize_Deck ()   |
|     {                    |
|     i=$LOWER_LIMIT       |
|     until [ "$i" -gt $UP |
| PER_LIMIT ]              |
|     do                   |
|       Deck[i]=$UNPICKED  |
|   # Set each card of "De |
| ck" as unpicked.         |
|       let "i += 1"       |
|     done                 |
|     echo                 |
|     }                    |
|                          |
|     initialize_Suits ()  |
|     {                    |
|     Suits[0]=C #Clubs    |
|     Suits[1]=D #Diamonds |
|     Suits[2]=H #Hearts   |
|     Suits[3]=S #Spades   |
|     }                    |
|                          |
|     initialize_Cards ()  |
|     {                    |
|     Cards=(2 3 4 5 6 7 8 |
|  9 10 J Q K A)           |
|     # Alternate method o |
| f initializing an array. |
|     }                    |
|                          |
|     pick_a_card ()       |
|     {                    |
|     card_number=$RANDOM  |
|     let "card_number %=  |
| $CARDS" # Restrict range |
|  to 0 - 51, i.e., 52 car |
| ds.                      |
|     if [ "${Deck[card_nu |
| mber]}" -eq $UNPICKED ]  |
|     then                 |
|       Deck[card_number]= |
| $PICKED                  |
|       return $card_numbe |
| r                        |
|     else                 |
|       return $DUPE_CARD  |
|     fi                   |
|     }                    |
|                          |
|     parse_card ()        |
|     {                    |
|     number=$1            |
|     let "suit_number = n |
| umber / CARDS_IN_SUIT"   |
|     suit=${Suits[suit_nu |
| mber]}                   |
|     echo -n "$suit-"     |
|     let "card_no = numbe |
| r % CARDS_IN_SUIT"       |
|     Card=${Cards[card_no |
| ]}                       |
|     printf %-4s $Card    |
|     # Print cards in nea |
| t columns.               |
|     }                    |
|                          |
|     seed_random ()  # Se |
| ed random number generat |
| or.                      |
|     {               # Wh |
| at happens if you don't  |
| do this?                 |
|     seed=`eval date +%s` |
|     let "seed %= 32766"  |
|     RANDOM=$seed         |
|     } # Consider other m |
| ethods of seeding the ra |
| ndom number generator.   |
|                          |
|     deal_cards ()        |
|     {                    |
|     echo                 |
|                          |
|     cards_picked=0       |
|     while [ "$cards_pick |
| ed" -le $UPPER_LIMIT ]   |
|     do                   |
|       pick_a_card        |
|       t=$?               |
|                          |
|       if [ "$t" -ne $DUP |
| E_CARD ]                 |
|       then               |
|         parse_card $t    |
|                          |
|         u=$cards_picked+ |
| 1                        |
|         # Change back to |
|  1-based indexing, tempo |
| rarily. Why?             |
|         let "u %= $CARDS |
| _IN_SUIT"                |
|         if [ "$u" -eq 0  |
| ]   # Nested if/then con |
| dition test.             |
|         then             |
|          echo            |
|          echo            |
|         fi               |
|     # Each hand set apar |
| t with a blank line.     |
|                          |
|         let "cards_picke |
| d += 1"                  |
|       fi                 |
|     done                 |
|                          |
|     echo                 |
|                          |
|     return 0             |
|     }                    |
|                          |
|                          |
|     # Structured program |
| ming:                    |
|     # Entire program log |
| ic modularized in functi |
| ons.                     |
|                          |
|     #===============     |
|     seed_random          |
|     initialize_Deck      |
|     initialize_Suits     |
|     initialize_Cards     |
|     deal_cards           |
|     #===============     |
|                          |
|     exit                 |
|                          |
|                          |
|                          |
|     # Exercise 1:        |
|     # Add comments to th |
| oroughly document this s |
| cript.                   |
|                          |
|     # Exercise 2:        |
|     # Add a routine (fun |
| ction) to print out each |
|  hand sorted in suits.   |
|     # You may add other  |
| bells and whistles if yo |
| u like.                  |
|                          |
|     # Exercise 3:        |
|     # Simplify and strea |
| mline the logic of the s |
| cript.                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <bash2.html>`__    | Bash, versions 2, 3, and |
| `Home <index.html>`__    | 4                        |
| `Next <bashver3.html>`__ | `Up <bash2.html>`__      |
|                          | Bash, version 3          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

