####################
XXX  5.2. Escapament
####################

En diem *escapament* al mecanisme de remarcar un caràcter prefixant-lo amb el
caràcter ``\`` per a indicar a la shell que interpreti el caràcter com el seu
significat literal i no com un :doc:`caràcter especial <special-chars>`.

En alguns contextos (ex. amb les comandes :doc:`echo <internal>` i i
:doc:`sed<sedawk>`), escapar un caràcter pot tenir l'efecte contrari. Podria
indicar que es consideri un significat especial pel caràcter escapat.

Significats especials d'alguns caràcters
========================================

Quan escapem els següents caràcters amb les comandes ``echo`` i ``sed``, són
interpretats de la següent manera:

* ``\n``: nova línia

* ``\r``: retorn de línia

* ``\t``: tabulador

* ``\v``: tabulador vertical

* ``\b``: espai en rere

* ``\a``: *alerta* (en forma de so o parpadeig)

* ``\0nn``: tradueix a l'equivalent ASCII en octal. Equival a ``0nn`` on ``nn``
  és una cadena de dígits.

  .. note::

     Es poden assignar caràcters ASCII a variables fent servir valors octals o
     hexadecimals escapats dins de ``$' ... '``. Per exemple:
     ``cometadoble=$'\\042'``.

* ``\"``: Indica que les cometes s'interpretin com el caràcter i no com inici o
  final de text entre cometes.

  .. code-block:: sh

        echo "Hola"                    # Sortida: Hola
        echo "\"Hola\" ... va dir."    # Sortida: "Hola" ... va dir.

* ``\$``: Indica que ``$`` sigui interpretat com el caràcter. Així, les
  variables precedides per ``\$`` no fan referència al seu valor.

  .. code-block:: sh

        echo \$variable01             # Sortida: $variable01
        echo "El llibre val \$7.98."  # Sortida: El llibre val $7.98.

.. _escapingsection_escapedbackslash:

* ``\\``: Indica que la contrabarra sigui interpretada com el caràcter i no com
  escapament del següent caràcter.

  .. code-block:: sh

        echo "\\"  # Sortida: \

        # Mentre que ...

        echo "\"   # Escapa la segona cometa doble.
                   # Des de la línia de comandes invoca el *prompt* secundari
                   # per continuar introduint una comanda multi-linia en
                   # posteriors línies fins acabar amb ``"`` en aquest cas, o amb
                   # ``ctrl-d`` en general.
                   # Dins d'un guió, generaria un missatge d'error.

        # En canvi ...

        echo '\'   # Sortida: \


Exemple 1. Caràcters escapats
=============================

.. literalinclude:: _scripts/escaped.sh
   :language: bash

.. _escapingsection_detecciotecles:

Exemple 2. Detecció de tecles
=============================

A continuació un exemple més elaborat:

.. literalinclude:: _scripts/capturekey.sh
   :language: bash

Exemple 3. Expansió de cadenes de text
======================================

Considera també el següent exemple que també apareix a :doc:`bashver2`.

.. literalinclude:: _scripts/stringexpansion.sh
   :language: bash

Exemple 4. Comportament de ``\``
================================

El comportament de ``\`` depén de si apareix:

* entre cometes dobles o simples (mira :doc:`varsubn`),

* dins d'una substitució de comandes (mira :doc:`commandsub`), o

* en un document immediat (mira :doc:`here-docs`)


.. literalinclude:: _scripts/escapedbackslash.sh
   :language: bash

Exemple 5. Contrabarra com a valor d'una variable
=================================================


Els elements d'una cadena de caràcters assignada a una variable poden ser
escapats, però el caràcter d'escapament en si (la contrabarra) no pot ser
assignada com a únic valor a una variable.

.. literalinclude:: _scripts/backslashasvariablevalue.sh
   :language: bash


Exemple 6. Escapament d'espai
=============================

Quan escapem espais, hem de tenir present que té implicacions a l'hora de
separar paraules en una llista d'arguments.

.. literalinclude:: _scripts/escapespace.sh
   :language: bash


Exemple 7. Escapament i comandes multi-línia
============================================

Amb ``\`` també disposem d'un mecanisme per escriure comandes multi-línia. Ja ho
hem vist per sobre, a un :ref:`exemple previ
<escapingsection_escapedbackslash>`. Considera aquest exemple més complet:

.. literalinclude:: _scripts/escapingmultilinecommand.sh
   :language: bash

.. note::

    En cas que la línia acabi amb el caràcter ``|`` (*pipe*), no és extrictament
    necessari escapar el salt de línia. Amb tot, es considera una bona pràctica
    escapar sempre el final de cada línia que continua amb la següent.


Exemple 8. Comandes multi-línia i text
======================================

.. literalinclude:: _scripts/escapingmultilinetext.sh
   :language: bash

