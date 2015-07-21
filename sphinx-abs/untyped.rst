######################
4.3. Variables i Tipus
######################

A diferència d'altres llenguatges de programació, Bash no classifica les seves
variables per tipus. En general, les variables en Bash són cadenes de caràcters
què, depenent del context en que apareixen, són interpretades com nombres a
l'hora de realitzar operacions o comparacions aritmètiques. El punt determinant
és que el valor només contingui dígits.

Considera el següent exemple:

.. literalinclude:: /_scripts/untypedvars.sh

Que les variables no tinguin tipus és a l'hora una benedicció i una maledicció.
Permeten més flexibilitat durant la programació i fan més fàcil generar línies
de codi (donant-te prou corda per penjar-te a tu mateix!). No obstant, també
permeten incorporar errors subtils que fomenten hàbits de programació
descuidats.

Per alleugerir la càrrega de fer el seguiment del tipus de les variables en un
guió, Bash permet :doc:`declarar variables <declareref>`.

