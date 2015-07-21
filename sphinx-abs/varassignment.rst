##########################
4.2. Assignació a variable
##########################

L'assignació d'un valor a una variable es pot realitzar mitjançant L'operador
``=`` sense espais ni abans ni després.

.. code-block:: sh

    $ variable=23
    #        ^ ^  cap espai de separació


.. caution::

No confonguis l'operador d'assignació amb l'operador de comparació (mira
:doc:`comparison-ops`. La diferència és el context on apareix ``=``.

Exemple 1. Assignació de valors a una variable
==============================================

.. literalinclude:: /_scripts/nakedvariables.sh
    :language: bash

Exemple 2. Variable Assignment, plain and fancy
===============================================

.. literalinclude:: /_scripts/fancyassignment.sh
    :language: bash


L'assignació amb ``$(...)`` és un mètode més recent que amb ``\`..\```, amb tot,
és també una forma de :doc:`substitució de comanda <commandsub>`.
