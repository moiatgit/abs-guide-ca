##################################
Capítol 28. Referències indirectes
##################################

Hem vist que en :doc:`referenciar una variable <varsubn>` fent ``$var``.
bash retorna el seu *valor*. Què passa, però, si aquest valor és a la seva
vegada una variable? Com obtenim el valor d'un valor?  Potser amb
``$$var`` ?

Encara que l'intent amb dos ``$`` s'acosta, la manera de fer-ho és amb
``\$$var``.
Normalment el precedirem per un `eval`, però també amb `echo`. Mira :doc:`internal`.
Anomenarem aquest tipus de referències *referència indirecta*.

Exemple 1. referències indirectes
=================================

.. literalinclude:: _scripts/ind-ref.sh
   :language: bash

Les referències indirectes en Bash es realitzen amb més d'una passada:

#. Primer, s'obté el nom de la variable ``varname``.

#. A continuació es referencia: ``$varname``.

#. Tot seguit, s'indica la referència de la referència: ``$$varname``.

#. Ara escapem el primer ``$``: ``\$$varname``

#. Finalment demanem la seva reevaluació: ``eval newvar=\\$$varname``.

Quina utilitat pot tenir l'ús de referenciació indirecta? Proporciona a
Bash una aproximació a la funcionalitat dels punters de *C*. Per exemple, 
considera:

.. literalinclude:: _scripts/resistor-inventory.sh
    :language: bash

Exemple 2. Generació de variable a partir d'un nom
==================================================

Un altre ús interessant és la possibilitat de crear una nova variable a
partir d'un nom. Per exemple, pot ser útil quan carreguem fitxers de
configuració (mireu :doc:sourcing.rst`).


.. literalinclude:: _scripts/sourceable_example.sh
    :language: bash


Exemple 3. Una referència indirecta cap a ``awk``
=================================================

En el següent exemple, passarem una referència indirecta cap a ``awk``

.. literalinclude:: _scripts/var2awk_example.sh
    :language: bash

Aquest mètode de refenciació indirecta és una mica complicat. Si la
variable de segon ordre veu modificat el seu valor, la variable de primer
ordre haurà de ser derreferenciada adequadament (tal i com a l'exemple
anterior). Afortunadament, la notació ``${!variable}`` que va ser
introduïda a la :doc:`segona versió de Bash <bashver2>`,
permet realitzar referenciació indirecta de manera més intuitiva.

Més exemples
============

Considera també:

* :ref:`bashver2_exemple_referenciesindirectes`, i

* :ref:`contributed-scripts_exemple_moreonhashfunctions`.


Bash no ofereix suport a punters aritmètics, el que limita
considerablement la utilitat de les referències indirectes. De fet, les
referències indirectes en els llenguatges de guions són, sovint,
afegiments d'últim moment.
