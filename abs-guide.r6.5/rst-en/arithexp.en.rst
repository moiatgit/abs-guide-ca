+----------------------------------+----+------------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+====+==============================+
| `Prev <commandsub.html>`_        |    | `Next <recess-time.html>`_   |
+----------------------------------+----+------------------------------+

--------------

Chapter 13. Arithmetic Expansion
================================

Arithmetic expansion provides a powerful tool for performing (integer)
arithmetic operations in scripts. Translating a string into a numerical
expression is relatively straightforward using *backticks*, *double
parentheses*, or *let*.

**Variations**

Arithmetic expansion with `backticks <commandsub.html#BACKQUOTESREF>`_
(often used in conjunction with `expr <moreadv.html#EXPRREF>`_)

    ::

        z=`expr $z + 3`          # The 'expr' command performs the expansion.

Arithmetic expansion with `double parentheses <dblparens.html>`_, and
using `let <internal.html#LETREF>`_
    The use of *backticks* (*backquotes*) in arithmetic expansion has
    been superseded by *double parentheses* -- ``((...))`` and
    ``$((...))`` -- and also by the very convenient
    `let <internal.html#LETREF>`_ construction.

    ::

        z=$(($z+3))
        z=$((z+3))                                  #  Also correct.
                                                    #  Within double parentheses,
                                                    #+ parameter dereferencing
                                                    #+ is optional.

        # $((EXPRESSION)) is arithmetic expansion.  #  Not to be confused with
                                                    #+ command substitution.



        # You may also use operations within double parentheses without assignment.

          n=0
          echo "n = $n"                             # n = 0

          (( n += 1 ))                              # Increment.
        # (( $n += 1 )) is incorrect!
          echo "n = $n"                             # n = 1


        let z=z+3
        let "z += 3"  #  Quotes permit the use of spaces in variable assignment.
                      #  The 'let' operator actually performs arithmetic evaluation,
                      #+ rather than expansion.

    Examples of arithmetic expansion in scripts:

    #. `Example 16-9 <moreadv.html#EX45>`_

    #. `Example 11-14 <loops1.html#EX25>`_

    #. `Example 27-1 <arrays.html#EX66>`_

    #. `Example 27-11 <arrays.html#BUBBLE>`_

    #. `Example A-16 <contributed-scripts.html#TREE>`_

--------------

+-----------------------------+------------------------+------------------------------+
| `Prev <commandsub.html>`_   | `Home <index.html>`_   | `Next <recess-time.html>`_   |
+-----------------------------+------------------------+------------------------------+
| Command Substitution        | `Up <part3.html>`_     | Recess Time                  |
+-----------------------------+------------------------+------------------------------+

