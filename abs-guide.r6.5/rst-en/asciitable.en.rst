+----------------------------------+----+----------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+====+============================+
| `Prev <copyright.html>`_         |    | `Next <xrefindex.html>`_   |
+----------------------------------+----+----------------------------+

--------------

Appendix S. ASCII Table
=======================

By tradition, a book of this sort has an
`ASCII <special-chars.html#ASCIIDEF>`_ Table appendix. This book does
not. Instead, here is a short shell script that generates a complete
ASCII table and writes it to the file ``ASCII.txt``.

**Example S-1. A script that generates an ASCII table**

::

    #!/bin/bash
    # ascii.sh
    # ver. 0.2, reldate 26 Aug 2008
    # Patched by ABS Guide author.

    # Original script by Sebastian Arming.
    # Used with permission (thanks!).

    exec >ASCII.txt         #  Save stdout to file,
                            #+ as in the example scripts
                            #+ reassign-stdout.sh and upperconv.sh.

    MAXNUM=256
    COLUMNS=5
    OCT=8
    OCTSQU=64
    LITTLESPACE=-3
    BIGSPACE=-5

    i=1 # Decimal counter
    o=1 # Octal counter

    while [ "$i" -lt "$MAXNUM" ]; do  # We don't have to count past 400 octal.
            paddi="    $i"
            echo -n "${paddi: $BIGSPACE}  "       # Column spacing.
            paddo="00$o"
    #       echo -ne "\\${paddo: $LITTLESPACE}"   # Original.
            echo -ne "\\0${paddo: $LITTLESPACE}"  # Fixup.
    #                   ^
            echo -n "     "
            if (( i % $COLUMNS == 0)); then       # New line.
               echo
            fi
            ((i++, o++))
            # The octal notation for 8 is 10, and 64 decimal is 100 octal.
            (( i % $OCT == 0))    && ((o+=2))
            (( i % $OCTSQU == 0)) && ((o+=20))
    done

    exit $?

    # Compare this script with the "pr-asc.sh" example.
    # This one handles "unprintable" characters.

    # Exercise:
    # Rewrite this script to use decimal numbers, rather than octal.

--------------

+----------------------------+------------------------+----------------------------+
| `Prev <copyright.html>`_   | `Home <index.html>`_   | `Next <xrefindex.html>`_   |
+----------------------------+------------------------+----------------------------+
| Copyright                  |                        | Index                      |
+----------------------------+------------------------+----------------------------+

