###################
Invoking the script
###################

Un cop tenim el nostre guió (per exemple, elnostreguio.sh), el podem invocar fent:

.. code-block:: sh

    $ sh elnostreguio.sh

o també

.. code-block:: sh

    $ bash elnostreguio.sh

Encara que és possible, es desaconsella fer

.. code-block:: sh

    $ sh < elnostreguio.sh

Aquesta invocació inhabilita la lectura de l'entrada estàndard o
*stdin* dins del guió. Per exemple, considera el següent guió:

.. literalinclude:: _script/saludam.sh
   :language: bash
   :linenos:

Podem invocar aquest guió amb [#resaltadaentrada]_:

.. code-block:: sh
    :linenos:
    :emphasize-lines: 3

    $ sh saludam.sh
    Com et dius?
    Pepe
    Hola Pepe. Gaudeix de la shell!

Però, en canvi:

.. code-block:: sh
    :linenos:

    $ sh < saludam.sh
    Com et dius?
    Hola . Gaudeix de la shell!

.. warning::

    Si el nostre guió conté elements específics de Bash, i el cridem
    fent servir ``sh elnostreguio.sh``, perdrem les extensions de Bash
    i el guió podria no funcionar correctament.

Encara més interessant seria donar permís d'execució al nostre guió.
Ho podem fer de múltiples maneres amb la comanda *chmod*
[#comandesbasiques]_, per exemple,
amb alguna de les següents comandes:

.. code-block:: sh

    $ chmod 555 elnostreguio.sh     # Tothom pot llegir i executar
                                    # però ningú no podrà, per
                                    # exemple, editar-lo.
    $ chmod +rx elnostreguio.sh     # Tothom pot llegir i executar,
                                    # però no modifica altres permisos
                                    # com ara el d'edició.
    $ chmod u+rx elnostreguio.sh    # Com l'anterior, però només
                                    # modifica els permisos del
                                    # propietari del guió.

Cal tenir present que hem de tenir permisos de lectura i execució per
a poder invocar el nostre guió.

Un cop el nostre guió és executable, podem invocar-lo directament amb:

.. code-block:: sh

    $ ./elnostreguio.sh

.. note::

    Generalment no podrem invocar directament el nostre guió sense
    aquest ./ previ, encara que estiguem situats en el directori que
    el conté. La raó és que, la shell cerca els programes a executar
    entre les carpetes indicades a la variable d'entorn *PATH*, i ./
    no està inclosa per defecte [#mesvariablesentorn]_.

En el cas que comenci amb una línia de shabang, serà executat per la
comanda indicada en el shabang. Altrament, si Bash és la teva shell
per defecte, se'n farà càrrec aquesta.

Un cop hem comprovat el funcionament del nostre guió, i potser
corregit els errors trobats, és possible que el vulguis moure a la
carpeta ``/usr/local/bin`` (com a *root*, és clar), de manera que el
guió estigui disponible per tots els usuaris del teu sistema. En
aquest cas, el guió podria ser invocat simplement escrivint a la línia
de comandes:

.. code-block:: sh

    $ elnostreguio.sh


.. rubric:: Notes

.. [#resaltadaentrada] L'entrada de l'usuari apareix resaltada a la
   línia 3.

.. [#comandesbasiques] trobareu la descripció d'aquesta i altres
   comandes bàsiques a :doc:`basic`.

.. [#mesvariablesentorn] Pots trobar més informació sobre variables
   d'entorn a :doc:`internalvariables`.
