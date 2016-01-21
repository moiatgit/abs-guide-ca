#########################
7.4. Condicionals aniuats
#########################

Els condicionals ``if/then`` poden ser aniuats. És a dir, entre les accions de a realitzar en cas
que s'acompleixi una condició, poden aparèixer noves condicions.

El resultat net és equivalent a fer servir l'operador de conjunció ``&&`` 
Condition tests using the ``             if/then           `` construct
may be nested. The net result is equivalent to using the
`*&&* <ops.html#LOGOPS1>`__ compound comparison operator.

.. literalinclude:: /_scripts/condicionalsaniuats.sh
    :language: bash


Trobaràs altres exemples de condicionals aniuats a :ref:`bashver2_exemple_cards` i :ref:`system_example_backlight`.

