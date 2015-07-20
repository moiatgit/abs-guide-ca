#############################
4.1. Substitució de variables
#############################

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

Veiem un exemple:

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

* Les cometes febles conserven blancs

  Quan posem una variable entre cometes, es preserven els espais en blanc del seu valor

  .. code-block:: sh

        variable="A B  C   D"
        #          ^ ^^ ^^^   diferents espais
        echo $variable   # sortida: A B C D
        echo "$variable" # sortida: A B  C   D

* Més d'una assignació per línia

  És possible assignar més d'una variable en una mateixa línia si les separem amb espais blancs.

  .. code-block:: sh

        var1=21  var2=22  var3=$V3

  .. caution::

     Aquesta pràctica pot fer més difícil de llegir el nostre codi i podria no ser portable.
     Podria donar problemes amb versions antigues de ``sh``.

* Les variables sense inicialitzar tenen valor ``null``

  Una variable sense inicialitzar té el valor ``null`` que indica que no té cap valor assignat.
  Compte que ``null`` no és zero.

  .. code-block:: sh

        if [ -z "$variable_no_inicialitzada" ]
        then
            echo "\$variable_no_inicialitzada val null."
        fi     # sortida: $variable_no_inicialitzada val null.

  Pot provocar problemes l'ús d'una variable abans de ser inicialitzada. Amb tot, és possible
  realitzar operacions aritmètiques amb variables no inicialitzades.


  .. code-block:: sh

        echo "$variable_no_inicialitzada"
        # (una línia en blanc)
        let "variable_no_inicialitzada += 5"
        # Suma 5 al seu valor
        echo "$variable_no_inicialitzada"
        # sortida: 5

  Això implica que, malgrat una variable no inicialitzada val null, en cas de realitzar una operació
  aritmètica amb ella, es considera que té com a valor el 0.

  Considera també :ref:`internal_uselessthatsourcesitself`.


.. rubric:: Anotacions

.. [#mestecnicament] Tècnicament, el *nom* d'una variable es coneix com a *lvalue* o valor esquerre,
   perquè apareix a la part esquerra d'una assignació. En canvi, el *valor* d'una variable és coneix
   com a *rvalue* doncs sol apareixer a la part dreta de l'assignació: ``variable2=$variable1``.

