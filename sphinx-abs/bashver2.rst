##########################
XXX  37.1. Bash, version 2
##########################

The current version of *Bash* , the one you have running on your
machine, is most likely version 2.xx.yy, 3.xx.yy, or 4.xx.yy.


.. code-block:: sh

    bash$ echo $BASH_VERSION
    3.2.25(1)-release

The version 2 update of the classic Bash scripting language added array
variables, string and parameter expansion, and a better method of
indirect variable references, among other features.

Exemple 1. String expansion
===========================

.. literalinclude:: _scripts/stringexpansion.sh
   :language: bash

Exemple 2. Indirect variable references - the new way
=====================================================


.. code-block:: sh

    #!/bin/bash

    # Indirect variable referencing.
    # This has a few of the attributes of references in C++.


    a=letter_of_alphabet
    letter_of_alphabet=z

    echo "a = $a"           # Direct reference.

    echo "Now a = ${!a}"    # Indirect reference.
    #  The ${!variable} notation is more intuitive than the old
    #+ eval var1=\$$var2

    echo

    t=table_cell_3
    table_cell_3=24
    echo "t = ${!t}"                      # t = 24
    table_cell_3=387
    echo "Value of t changed to ${!t}"    # 387
    # No 'eval' necessary.

    #  This is useful for referencing members of an array or table,
    #+ or for simulating a multi-dimensional array.
    #  An indexing option (analogous to pointer arithmetic)
    #+ would have been nice. Sigh.

    exit 0

    # See also, ind-ref.sh example.



Exemple 3. Simple database application, using indirect variable referencing
===========================================================================

.. literalinclude:: _scripts/resistor-inventory.sh


.. _bashver2_exemple_cards:

Exemple 4. Using arrays and other miscellaneous trickery to deal four random hands from a deck of cards
=======================================================================================================


.. code-block:: sh

    #!/bin/bash
    # cards.sh

    # Deals four random hands from a deck of cards.

    UNPICKED=0
    PICKED=1

    DUPE_CARD=99

    LOWER_LIMIT=0
    UPPER_LIMIT=51
    CARDS_IN_SUIT=13
    CARDS=52

    declare -a Deck
    declare -a Suits
    declare -a Cards
    #  It would have been easier to implement and more intuitive
    #+ with a single, 3-dimensional array.
    #  Perhaps a future version of Bash will support multidimensional arrays.


    initialize_Deck ()
    {
    i=$LOWER_LIMIT
    until [ "$i" -gt $UPPER_LIMIT ]
    do
      Deck[i]=$UNPICKED   # Set each card of "Deck" as unpicked.
      let "i += 1"
    done
    echo
    }

    initialize_Suits ()
    {
    Suits[0]=C #Clubs
    Suits[1]=D #Diamonds
    Suits[2]=H #Hearts
    Suits[3]=S #Spades
    }

    initialize_Cards ()
    {
    Cards=(2 3 4 5 6 7 8 9 10 J Q K A)
    # Alternate method of initializing an array.
    }

    pick_a_card ()
    {
    card_number=$RANDOM
    let "card_number %= $CARDS" # Restrict range to 0 - 51, i.e., 52 cards.
    if [ "${Deck[card_number]}" -eq $UNPICKED ]
    then
      Deck[card_number]=$PICKED
      return $card_number
    else
      return $DUPE_CARD
    fi
    }

    parse_card ()
    {
    number=$1
    let "suit_number = number / CARDS_IN_SUIT"
    suit=${Suits[suit_number]}
    echo -n "$suit-"
    let "card_no = number % CARDS_IN_SUIT"
    Card=${Cards[card_no]}
    printf %-4s $Card
    # Print cards in neat columns.
    }

    seed_random ()  # Seed random number generator.
    {               # What happens if you don't do this?
    seed=`eval date +%s`
    let "seed %= 32766"
    RANDOM=$seed
    } # Consider other methods of seeding the random number generator.

    deal_cards ()
    {
    echo

    cards_picked=0
    while [ "$cards_picked" -le $UPPER_LIMIT ]
    do
      pick_a_card
      t=$?

      if [ "$t" -ne $DUPE_CARD ]
      then
        parse_card $t

        u=$cards_picked+1
        # Change back to 1-based indexing, temporarily. Why?
        let "u %= $CARDS_IN_SUIT"
        if [ "$u" -eq 0 ]   # Nested if/then condition test.
        then
         echo
         echo
        fi                  # Each hand set apart with a blank line.

        let "cards_picked += 1"
      fi
    done

    echo

    return 0
    }


    # Structured programming:
    # Entire program logic modularized in functions.

    #===============
    seed_random
    initialize_Deck
    initialize_Suits
    initialize_Cards
    deal_cards
    #===============

    exit



    # Exercise 1:
    # Add comments to thoroughly document this script.

    # Exercise 2:
    # Add a routine (function) to print out each hand sorted in suits.
    # You may add other bells and whistles if you like.

    # Exercise 3:
    # Simplify and streamline the logic of the script.





