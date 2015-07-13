
###############################
XXX  4.1. Variable Substitution
###############################

The *name* of a variable is a placeholder for its *value* , the data it
holds. Referencing (retrieving) its value is called *variable
substitution* .


 $

    Let us carefully distinguish between the *name* of a variable and
    its *value* . If ``                   variable1                 ``
    is the name of a variable, then
    ``                   $variable1                 `` is a reference to
    its *value* , the data item it contains. ` [1]
     <varsubn.html#FTN.AEN2258>`__


    .. code-block:: sh

        bash$ variable1=23


        bash$ echo variable1
        variable1

        bash$ echo $variable1
        23



    The only times a variable appears "naked" -- without the $ prefix --
    is when declared or assigned, when *unset* , when
    `exported <internal.html#EXPORTREF>`__ , in an arithmetic expression
    within `double parentheses (( ... )) <dblparens.html>`__ , or in the
    special case of a variable representing a
    `signal <debugging.html#SIGNALD>`__ (see `Example
    32-5 <debugging.html#EX76>`__ ). Assignment may be with an = (as in
    ``                   var1=27                 `` ), in a
    `read <internal.html#READREF>`__ statement, and at the head of a
    loop (
    ``                   for var2 in 1                 2 3                 ``
    ).

     Enclosing a referenced value in *double quotes* ( " ... " ) does
    not interfere with variable substitution. This is called *partial
    quoting* , sometimes referred to as "weak quoting." Using single
    quotes ( ' ... ' ) causes the variable name to be used literally,
    and no substitution will take place. This is *full quoting* ,
    sometimes referred to as 'strong quoting.' See `Chapter
    5 <quoting.html>`__ for a detailed discussion.

    Note that ``                   $variable                 `` is
    actually a simplified form of
    ``                   ${variable}                 `` . In contexts
    where the ``                   $variable                 `` syntax
    causes an error, the longer form may work (see `Section
    10.2 <parameter-substitution.html>`__ , below).


    **Example 4-1. Variable assignment and substitution**


    .. code-block:: sh

        #!/bin/bash
        # ex9.sh

        # Variables: assignment and substitution

        a=375
        hello=$a
        #   ^ ^

        #-------------------------------------------------------------------------
        # No space permitted on either side of = sign when initializing variables.
        # What happens if there is a space?

        #  "VARIABLE =value"
        #           ^
        #% Script tries to run "VARIABLE" command with one argument, "=value".

        #  "VARIABLE= value"
        #            ^
        #% Script tries to run "value" command with
        #+ the environmental variable "VARIABLE" set to "".
        #-------------------------------------------------------------------------


        echo hello    # hello
        # Not a variable reference, just the string "hello" ...

        echo $hello   # 375
        #    ^          This *is* a variable reference.
        echo ${hello} # 375
        #               Likewise a variable reference, as above.

        # Quoting . . .
        echo "$hello"    # 375
        echo "${hello}"  # 375

        echo

        hello="A B  C   D"
        echo $hello   # A B C D
        echo "$hello" # A B  C   D
        # As we see, echo $hello   and   echo "$hello"   give different results.
        # =======================================
        # Quoting a variable preserves whitespace.
        # =======================================

        echo

        echo '$hello'  # $hello
        #    ^      ^
        #  Variable referencing disabled (escaped) by single quotes,
        #+ which causes the "$" to be interpreted literally.

        # Notice the effect of different types of quoting.


        hello=    # Setting it to a null value.
        echo "\$hello (null value) = $hello"      # $hello (null value) =
        #  Note that setting a variable to a null value is not the same as
        #+ unsetting it, although the end result is the same (see below).

        # --------------------------------------------------------------

        #  It is permissible to set multiple variables on the same line,
        #+ if separated by white space.
        #  Caution, this may reduce legibility, and may not be portable.

        var1=21  var2=22  var3=$V3
        echo
        echo "var1=$var1   var2=$var2   var3=$var3"

        # May cause problems with legacy versions of "sh" . . .

        # --------------------------------------------------------------

        echo; echo

        numbers="one two three"
        #           ^   ^
        other_numbers="1 2 3"
        #               ^ ^
        #  If there is whitespace embedded within a variable,
        #+ then quotes are necessary.
        #  other_numbers=1 2 3                  # Gives an error message.
        echo "numbers = $numbers"
        echo "other_numbers = $other_numbers"   # other_numbers = 1 2 3
        #  Escaping the whitespace also works.
        mixed_bag=2\ ---\ Whatever
        #           ^    ^ Space after escape (\).

        echo "$mixed_bag"         # 2 --- Whatever

        echo; echo

        echo "uninitialized_variable = $uninitialized_variable"
        # Uninitialized variable has null value (no value at all!).
        uninitialized_variable=   #  Declaring, but not initializing it --
                                  #+ same as setting it to a null value, as above.
        echo "uninitialized_variable = $uninitialized_variable"
                                  # It still has a null value.

        uninitialized_variable=23       # Set it.
        unset uninitialized_variable    # Unset it.
        echo "uninitialized_variable = $uninitialized_variable"
                                        # uninitialized_variable =
                                        # It still has a null value.
        echo

        exit 0






    |Caution|

    An uninitialized variable has a "null" value -- no assigned value at
    all ( *not* zero!).

    +--------------------------+--------------------------+--------------------------+
    | .. code-block:: sh
    |                          |
    |     if [ -z "$unassigned |
    | " ]                      |
    |     then                 |
    |       echo "\$unassigned |
    |  is NULL."               |
    |     fi     # $unassigned |
    |  is NULL.                |

    +--------------------------+--------------------------+--------------------------+

    Using a variable before assigning a value to it may cause problems.
    It is nevertheless possible to perform arithmetic operations on an
    uninitialized variable.

    +--------------------------+--------------------------+--------------------------+
    | .. code-block:: sh
    |                          |
    |     echo "$uninitialized |
    | "                        |
    |          # (blank line)  |
    |     let "uninitialized + |
    | = 5"                     |
    |          # Add 5 to it.  |
    |     echo "$uninitialized |
    | "                        |
    |          # 5             |
    |                          |
    |     #  Conclusion:       |
    |     #  An uninitialized  |
    | variable has no value,   |
    |     #+ however it evalua |
    | tes as 0 in an arithmeti |
    | c operation.             |

    +--------------------------+--------------------------+--------------------------+

    See also `Example 15-23 <internal.html#SELFSOURCE>`__ .


    .. code-block:: sh

        if [ -z "$unassigned" ]
        then
          echo "\$unassigned is NULL."
        fi     # $unassigned is NULL.


    .. code-block:: sh

        echo "$uninitialized"                                # (blank line)
        let "uninitialized += 5"                             # Add 5 to it.
        echo "$uninitialized"                                # 5

        #  Conclusion:
        #  An uninitialized variable has no value,
        #+ however it evaluates as 0 in an arithmetic operation.


    .. code-block:: sh

        if [ -z "$unassigned" ]
        then
          echo "\$unassigned is NULL."
        fi     # $unassigned is NULL.


    .. code-block:: sh

        echo "$uninitialized"                                # (blank line)
        let "uninitialized += 5"                             # Add 5 to it.
        echo "$uninitialized"                                # 5

        #  Conclusion:
        #  An uninitialized variable has no value,
        #+ however it evaluates as 0 in an arithmetic operation.






Notes
~~~~~


` [1]  <varsubn.html#AEN2258>`__

 Technically, the *name* of a variable is called an *lvalue* , meaning
that it appears on the *left* side of an assignment statment, as in
``               VARIABLE=23             `` . A variable's *value* is an
*rvalue* , meaning that it appears on the *right* side of an assignment
statement, as in ``               VAR2=$VARIABLE             `` .

 A variable's *name* is, in fact, a *reference* , a *pointer* to the
memory location(s) where the actual data associated with that variable
is kept.



.. |Caution| image:: ../images/caution.gif
