##############################
G.2. Bash Command-Line Options
##############################

Com a programa, ``bash`` ofereix algunes opcions. Entre les més útils, trobem:

- ``-c``

Llegeix les comandes del text que segueix a l'opció i assigna qualsevol argument als
:ref:`paràmetres <internalvariables_parametresposicionals>`.



.. code-block:: sh

       $ bash -c 'set a b c d; IFS="@"; echo "$*"'
       a@b@c@d




- ``-r``

  ``--restricted``

  Executa la shell, o un guió, en :doc:`mode restringit <restricted-sh>`.


- ``--posix``

  Obliga a *bash* a respectar el mode *POSIX* (mira :doc:`sha-bang`).

- ``--version``

  Mostra la versió de *Bash* i finalitza.


- ``--``

  Marca el final de les opcions. Tot el que aparegui a continuació a la línia de comandes, es
  considerarà un argument en comptes d'una opció.

