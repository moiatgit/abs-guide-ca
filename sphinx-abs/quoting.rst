##################
Chapter 5. Cometes
##################

.. toctree::
   :titlesonly:

   quotingvar
   escapingsection

Quan posem un text entre cometes, permet que es *protegeixin* part o tots els :doc:`caràcters
especials <special-chars>` que contingui aquest, de manera que l'interpret de comandes no els
interpreti de manera especial sinó com el seu significat literal. 

Per exemple, l'asterisc \* representa qualsevol caràcter tan en :doc:`globbingref` com en
:doc:`regexp`. 

.. code-block:: sh

    $ ls -l [Vv]*
    -rw-rw-r--    1 bozo  bozo       324 Apr  2 15:05 VIEWDATA.BAT
    -rw-rw-r--    1 bozo  bozo       507 May  4 14:25 vartrace.sh
    -rw-rw-r--    1 bozo  bozo       539 Apr 14 17:11 viewdata.sh

    $ ls -l '[Vv]*'
    ls: no s’ha pogut accedir a [Vv]*: El fitxer o directori no existeix

En l'exemple anterior veiem com per la primera crida a ``ls``, s'interpreta que es vol tots els
fitxers amb nom iniciat per ``V`` o ``v``. En canvi, a la segona crida de ``ls``, s'interpreta que
el que s'ha de llistar és l'entrada amb el nom literal ``[Vv]*`` que, al menys en aquest cas, no es
troba.

Quan escrivim un document en el nostre dia a dia, i posem una frase entre cometes, indiquem que
aquest contingut és especial. En Bash, quan podem entre cometes un text, també l'estem marcant com a
especial i *protegim* el seu significat literal.

Hi ha alguns programes i utilitats que requereixen determinats caràcters especials
dins del text que reben com a entrada i, per tant, ens cal evitar que la Shell els interpreti abans
que arribin al programa objectiu:

.. code-block:: sh

    $ grep -H '[Pp]rimer' *.txt
    fitxer1.txt:Primer la obligació i després la devoció.
    fitxer2.txt:La obligació primer. Després la devoció.

En l'exemple anterior, la utilitat ``grep`` rep literalment el text ``[Pp]primer`` com a primer
argument de la crida, que interpretarà com a expressió regular per trobar tots els fitxers que
continguin les paraules ``primer`` o ``Primer``. L'asterisc, en canvi, arribarà a ``grep`` en forma
de llista de fitxers amb extensió .txt que es trobin al directori actual.

.. note::

   De fet, Bash acceptaria correctament ``grep -H [Pp]rimer *.txt`` a menys que existeixi un fitxer
   anomenat ``primer`` o ``Primer`` en el directori actual.

Les cometes també poden fer que ``echo`` respecti els salts de línia. Mira :doc:`internal`.

.. code-block:: sh

    $ echo $(ls /etc/mail*)
    /etc/mailcap /etc/mailcap.order /etc/mailname /etc/mail.rc
    $ echo "$(ls /etc/mail*)"
    /etc/mailcap
    /etc/mailcap.order
    /etc/mailname
    /etc/mail.rc

