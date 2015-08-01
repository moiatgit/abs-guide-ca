#################################
XXX  5.1. Variables entre cometes
#################################

En referenciar una variable, en general es recomanable posar-la entre cometes
dobles per evitar que es reinterpretin tots els caràcters especials que hi pugui
contenir (a excepció de ``$``, la cometa invertida ````` i la contrabarra ``\``
[#quotingbang]_.

El caràcter ``$`` es manté amb el seu significat especial per permetre
referenciar el contingut de les variables. Mira :doc:`varsubn` per més detall.

Farem servir les cometes dobles per evitar que es separin les paraules que
apareixen en el text separades per blancs.  Un valor entre cometes dobles es
presenta com una única paraula, fins i tot si conté espais en blanc.

Posarem els arguments d'una crida a ``echo`` entre cometes dobles només quan
ens sigui important separar per paraules o preservar els espais.

Exemple 1. Preservació d'espais en blanc
========================================

.. literalinclude:: _scripts/quotinglists.sh
   :language: bash

Exemple 2. Espais en blanc i variables buides
=============================================

.. literalinclude:: _scripts/quotingwords.sh
   :language: bash

.. note:: Aquest exemple mostra la definició d'una funció. Pots trobar més
   detalls sobre funcions a :doc:`functions`.

Exemple 3. Com mostrar variables *rares*
========================================

.. literalinclude:: _scripts/weirdvars.sh
   :language: bash

Les cometes simples funcionen de manera semblant a les dobles. Entre
d'altres coses, però, no permeten referenciar variables donat que el significat
especial de ``$`` es perd. Dins de cometes simples, **cada** caràcter especial
és interpretat literalment. Les cometes simples es consideren com a *completes*
o *fortes*, mentre que les dobles es consideren com *parcials* o *febles*.

Com que fins i tot el ``\`` és interpretat literalment dins de cometes simples,
ens trobarem que intentar posar cometes simples dins de cometes simples no ens
donarà el resultat esperat.

.. literalinclude:: _scripts/nestedsinglequotes.sh
   :language: bash

.. rubric:: Anotacions

.. [#quotingbang] Posar entre cometes ``!`` en la línia de comandes, ens
   generarà un error donat que arrenca el :doc:`mecanisme d'històric
   <histcommands>`. Això no passa dins d'un guió on l'històric queda
   deshabilitat.

   Més preocupant pot resultar el comportament aparentment inconsistent de ``\``
   entre cometes dobles, especialment seguint ``echo -e``.

   .. code-block:: sh

        $ echo hola\!
        hola!
        $ echo "hola\!"
        hola\!


        $ echo \
        >
        # surt amb control-c
        $ echo "\"
        >
        # surt amb control-c
        $ echo \a
        a
        $ echo "\a"
        \a


        $ echo x\ty
        xty
        $ echo "x\ty"
        x\ty

        $ echo -e x\ty
        xty
        $ echo -e "x\ty"
        x       y

   Les cometes dobles a continuació de ``echo`` de vegades escapen ``\``. És
   més, l'opció ``-e`` fa que ``\t`` sigui interpretat com un tabulador.

