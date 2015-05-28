Advanced Bash-Scripting Guide:

`Prev <commandsub.html>`__

`Next <recess-time.html>`__

--------------

Chapter 13. Arithmetic Expansion
================================

Arithmetic expansion provides a powerful tool for performing (integer)
arithmetic operations in scripts. Translating a string into a numerical
expression is relatively straightforward using *backticks*, *double
parentheses*, or *let*.

**Variations**

Arithmetic expansion with `backticks <commandsub.html#BACKQUOTESREF>`__
(often used in conjunction with `expr <moreadv.html#EXPRREF>`__)
    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     z=`expr $z + 3`          # The 'expr' command performs the expansion |
    | .                                                                        |
                                                                              
    +--------------------------------------------------------------------------+

Arithmetic expansion with `double parentheses <dblparens.html>`__, and
using `let <internal.html#LETREF>`__
    The use of *backticks* (*backquotes*) in arithmetic expansion has
    been superseded by *double parentheses* -- ``((...))`` and
    ``$((...))`` -- and also by the very convenient
    `let <internal.html#LETREF>`__ construction.

    +--------------------------------------------------------------------------+
    | .. code:: PROGRAMLISTING                                                 |
    |                                                                          |
    |     z=$(($z+3))                                                          |
    |     z=$((z+3))                                  #  Also correct.         |
    |                                                 #  Within double parenth |
    | eses,                                                                    |
    |                                                 #+ parameter dereferenci |
    | ng                                                                       |
    |                                                 #+ is optional.          |
    |                                                                          |
    |     # $((EXPRESSION)) is arithmetic expansion.  #  Not to be confused wi |
    | th                                                                       |
    |                                                 #+ command substitution. |
    |                                                                          |
    |                                                                          |
    |                                                                          |
    |     # You may also use operations within double parentheses without assi |
    | gnment.                                                                  |
    |                                                                          |
    |       n=0                                                                |
    |       echo "n = $n"                             # n = 0                  |
    |                                                                          |
    |       (( n += 1 ))                              # Increment.             |
    |     # (( $n += 1 )) is incorrect!                                        |
    |       echo "n = $n"                             # n = 1                  |
    |                                                                          |
    |                                                                          |
    |     let z=z+3                                                            |
    |     let "z += 3"  #  Quotes permit the use of spaces in variable assignm |
    | ent.                                                                     |
    |                   #  The 'let' operator actually performs arithmetic eva |
    | luation,                                                                 |
    |                   #+ rather than expansion.                              |
                                                                              
    +--------------------------------------------------------------------------+

    Examples of arithmetic expansion in scripts:

    #. `Example 16-9 <moreadv.html#EX45>`__

    #. `Example 11-15 <loops1.html#EX25>`__

    #. `Example 27-1 <arrays.html#EX66>`__

    #. `Example 27-11 <arrays.html#BUBBLE>`__

    #. `Example A-16 <contributed-scripts.html#TREE>`__

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <commandsub.html>` | Command Substitution     |
| __                       | `Up <part3.html>`__      |
| `Home <index.html>`__    | Recess Time              |
| `Next <recess-time.html> |                          |
| `__                      |                          |
+--------------------------+--------------------------+--------------------------+

