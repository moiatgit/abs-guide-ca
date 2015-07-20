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

Encara que tanquem un valor entre cometes dobles, no s'evita la substitució. Per això se li diu
*cometes parcials* o també *cometes febles*. Amb les cometes simples, en canvi, sí s'anul·la la
substitució i el nom de la variable (juntament amb ``$``) s'interpreten literalment. És el que es
coneix com a *cometes completes* o *cometes fortes*. Mira :doc:`quoting` per una discussió completa
d'aquest tema.

Cal tenir present què ``$variable`` és, en realitat, una forma simplificada de l'expressió
``${variable}``.

.. note::

En alguns contexts en que la forma simplificada ``$variable`` pot donar problemes, la forma completa
``${variable}`` podria funcionar. Mira :doc:`parameter-substitution` per més detalls.

Exemple 1. Assignació i substitució de variable
===============================================

Veiem un exemple:

XXX TODO Per aquí

.. literalinclude:: /_scripts/varasignandsubst.sh
    :language: bash

A tenir present:

* En assignacions, ``=`` sense espais

  A l'hora d'assignar un valor a una variable **no** es pot posar espais en blanc ni abans ni
  després del ``=``.

  Si el posem abans, s'intentaria executar la variable com si fos una comanda amb un argument:

  .. code-block:: sh

        variable =42
        #       ^

  En el cas que l'espai estigui després, s'intentarà executar el valor com una comanda amb la
  variable assignada a "" com a variable d'entorn.

  .. code-block:: sh

        variable= 42
        #        ^



Caution

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

