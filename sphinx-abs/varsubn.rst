##################################
XXX  4.1. Substitució de variables
##################################

El nom d'una variable és un marcador o referència al seu valor. El valor de la variable és la dada
que conté la posició de memòria a què fa referència. En diem *substitució de variable* a l'obtenció
del valor associat a la variable.

Comencem diferenciant cuidadosament entre el *nom* d'una variable i el seu *valor*. 

Si ``variable1`` és el nom d'una variable, llavors ``$variable1`` fa referència al seu valor, és a
dir, la dada guardada en la posició de memòria a la que fa referència ``variable1`` [#mestecnicament]_.

Per exemple, considera el següent codi:

.. code-block:: sh

    $ variable1=23
    $ echo variable1
    variable1
    $ echo $variable1
    23

Trobarem el nom de les variables sense ``$``:

#. quan és declada, assignada o desassignada (*unset*)

#. quan s'exporta

#. en expressions aritmètiques amb :doc:`doble parèntesis <dblparens>'

#. en variables que representen :ref:`senyals <debugging_example_trappingandexit>`.

L'assignació pot realitzar-se:

* amb ``=`` com en ``var1=27``

* amb una instrucció de lectura ``read`` com a :ref:`internal_variableassignwithread`.

* a la capçalera d'un bucle:

  .. code-block:: sh

    for var in 1 2 3;
    do
        echo $var; 
    done

XXX TODO Per aquí

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


Exemple 1. Variable assignment and substitution
===============================================


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






    |Caution

    An uninitialized variable has a "null" value -- no assigned value at
    all ( *not* zero!).

--------------------------------------------------------------------------------------

.. code-block:: sh

    if [ -z "$unassigned
" ]
    then
      echo "\$unassigned
 is NULL."
    fi     # $unassigned
 is NULL.

--------------------------------------------------------------------------------------


    Using a variable before assigning a value to it may cause problems.
    It is nevertheless possible to perform arithmetic operations on an
    uninitialized variable.

--------------------------------------------------------------------------------------

.. code-block:: sh

    echo "$uninitialized
"
         # (blank line)
    let "uninitialized +
= 5"
         # Add 5 to it.
    echo "$uninitialized
"
         # 5

    #  Conclusion:
    #  An uninitialized
variable has no value,
    #+ however it evalua
tes as 0 in an arithmeti
c operation.

--------------------------------------------------------------------------------------


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



.. rubric:: Anotacions

.. [#mestecnicament] Tècnicament, el *nom* d'una variable es coneix com a *lvalue* o valor esquerre,
   perquè apareix a la part esquerra d'una assignació. En canvi, el *valor* d'una variable és coneix
   com a *rvalue* doncs sol apareixer a la part dreta de l'assignació: ``variable2=$variable1``.

