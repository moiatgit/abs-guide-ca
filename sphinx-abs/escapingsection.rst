####################
XXX  5.2. Escapament
####################

En diem *escapament* al mecanisme de remarcar un caràcter prefixant-lo amb el
caràcter ``\`` per a indicar a la shell que interpreti el caràcter com el seu
significat literal i no com un :doc:`caràcter especial <special-chars>`.

.. note::

   En alguns contextos (ex. amb les comandes :doc:`echo <internal>` i i
   :doc:`sed<sedawk`), escapar un caràcter pot tenir l'efecte contrari: podria
   indicar que es consideri un significat especial pel caràcter escapat.

Significats especials d'alguns caràcters
========================================

Quan escapem els següents caràcters amb les comandes ``echo`` i ``sed``, són
interpretats de la següent manera:

* \\n

  Indica nova línia

* \\r

  Indica retorn de línia

* \\t

  Indica tabulador

* \\v

  Indica tabulador vertical

* \\b

  Indica espai en rere

* \\a

  Indica *alerta* (en forma de so o parpadeig)

* \\0nn

  Tradueix a l'equivalent ASCII en octal. Equival a ``0nn`` on ``nn`` és una
  cadena de dígits.

.. important::

   Es poden assignar caràcters ASCII a variables fent servir valors octals o
   hexadecimals escapats dins de ``$' ... '``. Per exemple:
   ``cometadoble=$'\\042'``.

Exemple #. Caràcters escapats
=============================

.. literalinclude:: _scripts/escaped.sh
   :language: bash


Exemple 3. Detecció de tecles
=============================

A continuació un exemple més elaborat [#atribuciodelguio]_:

.. literalinclude:: _scripts/capturekey.sh
   :language: bash


XXX per aquí

See also `Example 37-1 <bashver2.html#EX77>`__ .

 \\"
    gives the quote its literal meaning


    .. code-block:: sh

        echo "Hello"                     # Hello
        echo "\"Hello\" ... he said."    # "Hello" ... he said.



 \\$
    gives the dollar sign its literal meaning (variable name following
    \\$ will not be referenced)


    .. code-block:: sh

        echo "\$variable01"           # $variable01
        echo "The book cost \$7.98."  # The book cost $7.98.



 \\\\
    gives the backslash its literal meaning


    .. code-block:: sh

        echo "\\"  # Results in \

        # Whereas . . .

        echo "\"   # Invokes secondary prompt from the command-line.
                   # In a script, gives an error message.

        # However . . .

        echo '\'   # Results in \






|Note

The behavior of \\ depends on whether it is escaped,
`strong-quoted <varsubn.html#SNGLQUO>`__ ,
`weak-quoted <varsubn.html#DBLQUO>`__ , or appearing within `command
substitution <commandsub.html#COMMANDSUBREF>`__ or a `here
document <here-docs.html#HEREDOCREF>`__ .

----------------------------------------------------------------------------------

.. code-block:: sh


  #  Simple escaping and
 quoting
    echo \z
  #  z
    echo \\z
  # \z
    echo '\z'
  # \z
    echo '\\z'
  # \\z
    echo "\z"
  # \z
    echo "\\z"
  # \z


  #  Command substitutio
n
    echo `echo \z`
  #  z
    echo `echo \\z`
  #  z
    echo `echo \\\z`
  # \z
    echo `echo \\\\z`
  # \z
    echo `echo \\\\\\z`
  # \z
    echo `echo \\\\\\\z`
  # \\z
    echo `echo "\z"`
  # \z
    echo `echo "\\z"`
  # \z


  # Here document
    cat <<EOF

    \z

    EOF
  # \z

    cat <<EOF

    \\z

    EOF
  # \z

    # These examples sup
plied by Stéphane Chazel
as.

----------------------------------------------------------------------------------


Elements of a string assigned to a variable may be escaped, but the
escape character alone may not be assigned to a variable.

----------------------------------------------------------------------------------

.. code-block:: sh

    variable=\
    echo "$variable"
    # Will not work - gi
ves an error message:
    # test.sh: : command
 not found
    # A "naked" escape c
annot safely be assigned
 to a variable.
    #
    #  What actually hap
pens here is that the "\
" escapes the newline an
d
    #+ the effect is
    variable=echo "$vari
able"
    #+
    invalid variable ass
ignment

    variable=\
    23skidoo
    echo "$variable"
    #  23skidoo

    #  This works, since
 the second line

    #+ is a valid variab
le assignment.

    variable=\
    #        \^    escap
e followed by space
    echo "$variable"
    # space

    variable=\\
    echo "$variable"
    # \

    variable=\\\
    echo "$variable"
    # Will not work - gi
ves an error message:
    # test.sh: \: comman
d not found
    #
    #  First escape esca
pes second one, but the
third one is left "naked
",
    #+ with same result
as first instance, above
.

    variable=\\\\
    echo "$variable"
    # \\

    # Second and fourth
escapes escaped.

    # This is o.k.

----------------------------------------------------------------------------------



.. code-block:: sh

                          #  Simple escaping and quoting
    echo \z               #  z
    echo \\z              # \z
    echo '\z'             # \z
    echo '\\z'            # \\z
    echo "\z"             # \z
    echo "\\z"            # \z

                          #  Command substitution
    echo `echo \z`        #  z
    echo `echo \\z`       #  z
    echo `echo \\\z`      # \z
    echo `echo \\\\z`     # \z
    echo `echo \\\\\\z`   # \z
    echo `echo \\\\\\\z`  # \\z
    echo `echo "\z"`      # \z
    echo `echo "\\z"`     # \z

                          # Here document
    cat <<EOF
    \z
    EOF                   # \z

    cat <<EOF
    \\z
    EOF                   # \z

    # These examples supplied by Stéphane Chazelas.


.. code-block:: sh

    variable=\
    echo "$variable"
    # Will not work - gives an error message:
    # test.sh: : command not found
    # A "naked" escape cannot safely be assigned to a variable.
    #
    #  What actually happens here is that the "\" escapes the newline and
    #+ the effect is        variable=echo "$variable"
    #+                      invalid variable assignment

    variable=\
    23skidoo
    echo "$variable"        #  23skidoo
                            #  This works, since the second line
                            #+ is a valid variable assignment.

    variable=\
    #        \^    escape followed by space
    echo "$variable"        # space

    variable=\\
    echo "$variable"        # \

    variable=\\\
    echo "$variable"
    # Will not work - gives an error message:
    # test.sh: \: command not found
    #
    #  First escape escapes second one, but the third one is left "naked",
    #+ with same result as first instance, above.

    variable=\\\\
    echo "$variable"        # \\
                            # Second and fourth escapes escaped.
                            # This is o.k.


.. code-block:: sh

                          #  Simple escaping and quoting
    echo \z               #  z
    echo \\z              # \z
    echo '\z'             # \z
    echo '\\z'            # \\z
    echo "\z"             # \z
    echo "\\z"            # \z

                          #  Command substitution
    echo `echo \z`        #  z
    echo `echo \\z`       #  z
    echo `echo \\\z`      # \z
    echo `echo \\\\z`     # \z
    echo `echo \\\\\\z`   # \z
    echo `echo \\\\\\\z`  # \\z
    echo `echo "\z"`      # \z
    echo `echo "\\z"`     # \z

                          # Here document
    cat <<EOF
    \z
    EOF                   # \z

    cat <<EOF
    \\z
    EOF                   # \z

    # These examples supplied by Stéphane Chazelas.


.. code-block:: sh

    variable=\
    echo "$variable"
    # Will not work - gives an error message:
    # test.sh: : command not found
    # A "naked" escape cannot safely be assigned to a variable.
    #
    #  What actually happens here is that the "\" escapes the newline and
    #+ the effect is        variable=echo "$variable"
    #+                      invalid variable assignment

    variable=\
    23skidoo
    echo "$variable"        #  23skidoo
                            #  This works, since the second line
                            #+ is a valid variable assignment.

    variable=\
    #        \^    escape followed by space
    echo "$variable"        # space

    variable=\\
    echo "$variable"        # \

    variable=\\\
    echo "$variable"
    # Will not work - gives an error message:
    # test.sh: \: command not found
    #
    #  First escape escapes second one, but the third one is left "naked",
    #+ with same result as first instance, above.

    variable=\\\\
    echo "$variable"        # \\
                            # Second and fourth escapes escaped.
                            # This is o.k.




Escaping a space can prevent word splitting in a command's argument
list.


.. code-block:: sh

    file_list="/bin/cat /bin/gzip /bin/more /usr/bin/less /usr/bin/emacs-20.7"
    # List of files as argument(s) to a command.

    # Add two files to the list, and list all.
    ls -l /usr/X11R6/bin/xsetroot /sbin/dump $file_list

    echo "-------------------------------------------------------------------------"

    # What happens if we escape a couple of spaces?
    ls -l /usr/X11R6/bin/xsetroot\ /sbin/dump\ $file_list
    # Error: the first three files concatenated into a single argument to 'ls -l'
    #        because the two escaped spaces prevent argument (word) splitting.



The escape also provides a means of writing a multi-line command.
Normally, each separate line constitutes a different command, but an
escape at the end of a line *escapes the newline character* , and the
command sequence continues on to the next line.


.. code-block:: sh

    (cd /source/directory && tar cf - . )\
    (cd /dest/directory && tar xpvf -)
    # Repeating Alan Cox's directory tree copy command,
    # but split into two lines for increased legibility.

    # As an alternative:
    tar cf - -C /source/directory .
    tar xpvf - -C /dest/directory
    # See note below.
    # (Thanks, Stéphane Chazelas.)





|Note

If a script line ends with a \, a pipe character, then a \\ , an
escape, is not strictly necessary. It is, however, good programming
practice to always escape the end of a line of code that continues to
the following line.





.. code-block:: sh

    echo "foo
    bar"
    #foo
    #bar

    echo

    echo 'foo
    bar'    # No difference yet.
    #foo
    #bar

    echo

    echo foo\
    bar     # Newline escaped.
    #foobar

    echo

    echo "foo\
    bar"     # Same here, as \ still interpreted as escape within weak quotes.
    #foobar

    echo

    echo 'foo\
    bar'     # Escape character \ taken literally because of strong quoting.
    #foo\
    #bar

    # Examples suggested by Stéphane Chazelas.



.. rubric:: Anotacions

.. [#atribuciodelguio] L'autor de la versió original d'aquest guió és Sigurd
   Solaas, 20 abril # 2011 que amablement va donar permís per afegir-lo a la
   versió original # d'aquest treball. He (el traductor) suposat que en oferir
   el seu codi a un treball de domini públic, està acceptant que aquest també és
   de domini públic. Si ets el Sigurd o algun beneficiari, i no estàs d'acord,
   per favor avisa i el substitueixo per un altre guió que il·lustri l'exemple.

