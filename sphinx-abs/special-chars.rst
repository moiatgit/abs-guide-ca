##########################
XXX 3. Caràcters especials
##########################

Diem que un caràcter és especial quan té un significat més enllà del
seu *valor literal* [#metameaning]_. Juntament amb les comandes i
:doc:`paraules claus<internal>`, els caràcters especials formen
els fonaments de la programació Bash.

Considera la següent llista de caràcters especials que podem trobar en
guions de shell:

Sostingut: #
============

El principal ús del símbol de sostingut ``#`` en Bash és el de marcar l'inici d'un comentari.

Per ser un comentari, ``#`` apareixerà com el primer caràcter de la línia, o a continuació
d'un:ref:`caràcter en blanc <specialchars_whitespaces>` (espai, tabulador).

El que apareix després de ``#`` no serà interpretat. De fet, el control d'errors queda desactivat, pel
que hi podrem posar pràcticament qualsevol cosa.

.. code-block:: sh

    # Aquesta línia és un comentari. El sostingut és el primer caràcter de la línia.
        # aquest comentari està precedit per un tabulador
    echo "A continuació bé un comentari" # Un comentari després d'una comanda
    #                                   ^ Atenció a l'espai abans de #

Podem trobar comentaris, fins i tot, en una :ref:`pipe <specialchars-pipe>`.

.. literalinclude:: /_scripts/comentarisenpipe.sh
   :language: bash
   :emphasize-lines: 11

Cal tenir present què, el final del comentari queda marcar pel salt de línia. És a dir, un cop
començat el comentari, tot el que vingui després en la mateixa línia serà considerat com a
comentari. No hi ha manera d'indicar que el comentari ha finalitzat, a banda del salt de línia.

El sostingut no serà considerat inici de comentari en els següents casos:

* :doc:`sha-bang<sha-bang>`. (``#!``) que, quan apareix en la primera línia d'un fitxer, indica quin
  programa ha d'interpretar el contingut del fitxer.

* Quan el sostingut apareix, però, :doc:`entre cometes <quoting>` o :doc:`escapat <escapingsection>`
  com a argument d'una comanda *echo*, no es considera com a marca de comentari.

* Per altra banda, ``#`` tampoc no es considera inici de comentari quan apareix en una
  :doc:`substitució de paràmetres <parameter-substitution>` ni en :doc:`expressions amb constants
  numèriques <numerical-constants>`.

  .. literalinclude:: /_scripts/nocomments.sh
     :language: bash

Punt i coma: ;
==============

El punt i coma ``;`` serveix com a separador entre comandes que apareixen seqüencialment a una
mateixa línia.

.. literalinclude:: /_scripts/semicolons.sh
   :language: bash

.. note::

    De vegades el ; ha de ser escapat. Considera l'opció :ref:`-exec de la comanda find <moreadv-find-exec>`.


Quan el punt i coma apareix duplicat (``;;``), el seu significat passa a ser de terminador en una
opció *case*.  Mira :doc:`testbranch`.

.. code-block:: sh

    case "$variable" in
      abc)  echo "\$variable = abc" ;;
      xyz)  echo "\$variable = xyz" ;;
    esac

Hi ha altres versions del punt i coma doble (``;;&`` i ``;&``).  Són també terminadors d'opció *case*, en
aquest cas, per versions de Bash a partir de la 4. Mira :doc:`bashver4`.

Punt: .
=======

A l'inici de la línia, el punt equival a la comanda :ref:`internal_dotcommand`.

Quan el nom d'un fitxer o carpeta comença amb punt, es interpretat com a fitxer *ocult* i, per
exemple, no serà llistat per defecte per la comanda ``ls``.

.. code-block:: sh

    bash$ touch .fitxerocult
    bash$ ls -l
    total 10
     -rw-r--r--    1 usuari      4034 Jul 18 22:04 data1.addressbook
     -rw-r--r--    1 usuari      4602 May 25 13:58 data1.addressbook.bak
     -rw-r--r--    1 usuari       877 Dec 17  2000 employment.addressbook


    bash$ ls -al
    total 14
     drwxrwxr-x    2 usuari  usuari      1024 Aug 29 20:54 ./
     drwx------   52 usuari  usuari      3072 Aug 29 20:51 ../
     -rw-r--r--    1 usuari  usuari      4034 Jul 18 22:04 data1.addressbook
     -rw-r--r--    1 usuari  usuari      4602 May 25 13:58 data1.addressbook.bak
     -rw-r--r--    1 usuari  usuari       877 Dec 17  2000 employment.addressbook
     -rw-rw-r--    1 usuari  usuari         0 Aug 29 20:54 .fitxerocult

En el cas del nom d'una carpeta, un punt sol representa el directori actual, mentre que dos punts
denoten la carpeta superior.

.. code-block:: sh

    bash$ pwd
    /home/usuari/projects

    bash$ cd .
    bash$ pwd
    /home/usuari/projects

    bash$ cd ..
    bash$ pwd
    /home/usuari/

El punt apareix sovint com la destinació (carpeta) d'una comanda de moviment o còpia de fitxers. En
aquest cas, s'indica que la destinació és la carpeta actual:

.. code-block:: sh

    bash$ cp /home/usuari/feina/brossa/* .

La comanda anterior copiarà tots els fitxers de la carpeta brossa/ a la carpeta actual o
:ref:`internalvars_pwd`.

Finalment, el caràcter punt serveix per indicar *qualsevol caràcter* quan forma part d'una
:doc:`expressió regular <regexp>`.

Cometes dobles: \"
==================

Envoltar un text entre cometes dobles, evita que la majoria dels caràcters especials que conté el
text, siguin interpretats. Es coneix com *partial quoting*. Mira
:doc:`quoting`.

Cometes simples: '
==================

Quan envoltem un text entre cometes simples (*full quoting*), tots els caràcters especials deixen de
ser interpretats.
És, per tant, una forma més forta de posar entre cometes un text que amb les cometes dobles.
Mira :doc:`quoting`.

Coma: ,
=======

L'*operador coma* [#operadors]_ enllaça una sèrie d'operacions aritmètiques. Totes són avaluades, i
finalment es retorna el resultat de la darrera.

.. code-block:: sh

    let "v2 = ((v1 = 9, 15 / 3))"
    # Assigna un 9 a v1 i 15/3 a v2.


Amb l'operador coma també podem concatenar Strings, com al següent exemple:

.. literalinclude:: /_scripts/mostraexecutablesctl.sh
   :language: bash

En una substitució de paràmetres, s'interpreta com a passar a minúscules.

.. code-block:: sh

    var=ElMeuText
    echo ${var,}    # elMeuText
    echo ${var,,}   # elmeutext

Mira :ref:`bash4_modificacas`

Contrabarra: \\
===============

La contrabarra permet evitar que el caràcter següent sigui interpretat, de manera que s'entengui
literalment. Aquest mecanisme es coneix com a *escapar* el caràcter per traducció directa del
*escape* anglès.

Per exemple:

.. code-block:: sh

    echo "Una \" i una \'"
    #    ^ indica inici de text entre cometes. No es mostra.
    #         ^^       ^^ aquestes cometes sí es mostren
    #                    ^ final del text entre cometes. No es mostra.

Mira :doc:`escapingsection` per més detalls sobre escapament de caràcters. Considera :doc:`quoting`
per una explicació global d'aquest tema.


Barra: /
========

La barra és el separador de carpetes en les especificacions del camí a un fitxer. El que es coneix
com a *path*.

Per exemple:

.. code-block:: none

    /home/usuari/traduccions/absguide/Makefile

També es fa servir per indicar l'operador aritmètic de divisió.  Mira :doc:`ops` per més detalls.

Tilde oberta: \`
================

Anomenat substitució de comanda (*command substitution*), envoltar un text entre tildes obertes
fa què:

#. s'executi el text que apareix entre tildes com si fos una comanda Bash

#. es retorni com a string el resultat que la comanda escrigui en la sortida estàndard, per exemple,
   per a ser assignat a una variable.

Mira :doc:`commandsub` per més detalls.


Dos punts: :
============

La comanda nulla: és l'equivalent en Bash del "NOP" (No Operation). Es tracta d'una :doc:`comanda
interna <internal>` de Bash, que no fa res i sempre té com a :doc:`valor de sortida
<exit-status>` ``0``. Es pot considerar sinònim de la comanda ``true``.

.. code-block:: sh

    :
    echo $?   # 0


Amb ``:`` podem fer un bucle infinit:

.. literalinclude:: /_scripts/bucleinfinit.sh
    :language: bash

En algunes ocasions, cal començar una operació aritmètica o una substitució de paràmetres amb els
``:``.  Considera l'exemple: :ref:`ops_exemple_operadorsaritmetics` i :doc:`parameter-substitution`.

.. code-block:: sh

    : ${username=`whoami`}
    # ${username=`whoami`}   Genera un error quan no està precedit del :
    #                        a menys que "username" sigui una comanda.

    : ${1?"Ús: $0 ARGUMENT"}


Un ús típic és com a *marcador de posició* allà on s'espera que hi hagi una comanda però que, per
alguna raó, no la tenim o no la volem especificar. Per exemple, permet mantenir l'estructura d'un
condicional, quan no es disposa de quelcom a fer per un determinat cas:

.. code-block:: sh

    if condicio
    then :   # No fa res i passa a continuació del fi
    else
       fes-alguna-cosa
    fi


Un altre exemple d'ús per marcar posició el trobem en funcions buides:

.. code-block:: sh

    no_buida ()
    {
      :
    } # Conté un : (comanda nul·la) i, per tant, la funció no està buida.

En :doc:`documents immediats <here-docs>` permet marcar una posició allà on s'esperava una comanda.
Mira :ref:`heredocs_anonim`.

Avalua variables fent servir :doc:`parameter-substitution` com a
:ref:`parameter-substitution_missatges_error`.

.. code-block:: sh

    : ${HOSTNAME?} ${USER?} ${MAIL?}
    #  Mostra un missatge d'error si alguna de les variables 
    #+ d'entorn no està assignada.

Trobem un altre ús de la comanda nul·la, combinant-la amb :doc:`l'operador de redirecció <io-redirection>` ``>``.
Donat que no genera cap resultat per sortida estàndard, quan redireccionem la seva sortida cap a un
fitxer, elimina el seu contingut. Per exemple:

.. code-block:: sh

    : > fitxer.dat   # "fitxer.dat" passa a ser buit

El resultat equival a fer ``cat /dev/null > fitxer.dat`` La diferència és que amb ``:`` no es crea
un nou procés, doncs ``:`` és una comanda interna (*builtin*) de la shell.

Pot ser interessant quan no ens interessi canviar els permisos del fitxer a buidar. En cas que el
fitxer no existís, el crea.

En combinació amb el operador de redirecció ``>>``, no té efecte sobre un fitxer ja existent:

.. code-block:: sh

    : >> fitxer_existent.dat      # cap efecte quan el fitxer ja existeix

Tant amb ``>`` com amb ``>>``, en cas que el fitxer no existís, el crea.

.. note::

    Funciona només amb fitxers regulars, no amb *pipes*, enllaços simbòlics ni altres fitxers especials.

De vegades trobarem ``:`` utilitzat per començar una línia de comentaris. No és una pràctica
recomanada doncs, a diferència de ``#``, no queda desactivat el control d'errors.

.. code-block:: sh

    : Aquest comentari genera un error, ( if [ $x -eq 3] ).

Els dos punts també serveixen com a separador de camps al :doc:`fitxer<files>` ``/etc/passwd`` i en
variables del sistema com ara :ref:`internalvariables_path`.

.. code-block:: sh

    $ echo $PATH
    /usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin:/sbin:/usr/sbin:/usr/games

.. note::

    Bash accepta anomenar una :doc:`funció<functions>` amb ``:``, com per exemple:

    .. code-block:: sh

        :()
        {
          echo "El nom d'aquesta funció és "$FUNCNAME" "
          # Perquè voldria algú fer servir dos punts com a nom d'una funció?
          # És una manera d'emmascarar el teu codi!
        }

        :

        # El nom d'aquesta funció és :

    Cal tenir present que és un comportament :doc:`portable <portabilityissues>` i, per tant, es
    desaconsella el seu ús.

Exclamació: !
=============

L'exclamació és una :doc:`paraula reservada<internal>` de Bash.

En el seu ús més habitual, l'exclamació ``!`` (o *bang*) :ref:`nega o
inverteix<exit-status_negatingconditionwithbang:` el resultat d'un test o un :doc:`estat de
sortida<exit-status>`.

.. code-block:: sh

    true    # la funció "builtin"
    echo "El valor de sortida de \"true\" = $?"     # 0

    ! true
    echo "El valor de sortida de \"! true\" = $?"   # 1

També indica *desigualtat* quan es fa servir en conjunt amb l':ref:`operador de comparació
<comparison-ops_notequalto>` ``=``.

Altres funcions de ``!`` són:

* Com a referència indirecta a variable: mira :doc:`ivr`.

* Des de la línia de comandes permet invocar el mecanisme :doc:`d'històric de comandes de Bash
  <histcommands>`.

  .. note::

      Dins d'un guió, el mecanisme d'històric de comandes està desabilitat.

Asterisc: \*
============

XXX TODO per aquí

    **wild card [asterisk].** The \* character serves as a "wild card"
    for filename expansion in `globbing <globbingref.html>`__ . By
    itself, it matches every filename in a given directory.



    .. code-block:: sh

        bash$ echo *
        abs-book.sgml add-drive.sh agram.sh alias.sh




    The \* also represents `any number (or zero)
    characters <x17129.html#ASTERISKREG>`__ in a `regular
    expression <regexp.html#REGEXREF>`__ .

 \*

    **`arithmetic operator <ops.html#AROPS1>`__ .** In the context of
    arithmetic operations, the \* denotes multiplication.


     \*\* A double asterisk can represent the
    `exponentiation <ops.html#EXPONENTIATIONREF>`__ operator or
    `extended file-match <bashver4.html#GLOBSTARREF>`__ *globbing* .

Interrogant: ?
==============

    **test operator.** Within certain expressions, the ? indicates a
    test for a condition.


    In a `double-parentheses construct <dblparens.html>`__ , the ? can
    serve as an element of a C-style *trinary* operator. ` [2]
     <special-chars.html#FTN.AEN888>`__

    ``         condition        `` **?**
    ``         result-if-true        `` **:**
    ``         result-if-false        ``


    .. code-block:: sh

        (( var0 = var1<98?9:21 ))
        #                ^ ^

        # if [ "$var1" -lt 98 ]
        # then
        #   var0=9
        # else
        #   var0=21
        # fi



    In a `parameter
    substitution <parameter-substitution.html#PARAMSUBREF>`__
    expression, the ? `tests whether a variable has been
    set <parameter-substitution.html#QERRMSG>`__ .

 ?

    **wild card.** The ? character serves as a single-character "wild
    card" for filename expansion in `globbing <globbingref.html>`__ , as
    well as `representing one character <x17129.html#QUEXREGEX>`__ in an
    `extended regular expression <x17129.html#EXTREGEX>`__ .


Dollar: $
=========

    **`Variable substitution <varsubn.html>`__ (contents of a
    variable).**


    .. code-block:: sh

        var1=5
        var2=23skidoo

        echo $var1     # 5
        echo $var2     # 23skidoo




    A $ prefixing a variable name indicates the *value* the variable
    holds.

 $

    **end-of-line.** In a `regular expression <regexp.html#REGEXREF>`__
    , a "$" addresses the `end of a line <x17129.html#DOLLARSIGNREF>`__
    of text.


 ${}

    **`Parameter
    substitution <parameter-substitution.html#PARAMSUBREF>`__ .**


 $' ... '

    **`Quoted string expansion <escapingsection.html#STRQ>`__ .** This
    construct expands single or multiple escaped octal or hex values
    into ASCII ` [3]  <special-chars.html#FTN.AEN1001>`__ or
    `Unicode <bashver4.html#UNICODEREF>`__ characters.


 $\* , $@

    **`positional parameters <internalvariables.html#APPREF>`__ .**


 $?

    **exit status variable.** The `$?
    variable <exit-status.html#EXSREF>`__ holds the `exit
    status <exit-status.html#EXITSTATUSREF>`__ of a command, a
    `function <functions.html#FUNCTIONREF>`__ , or of the script itself.


 $$

    **process ID variable.** The `$$
    variable <internalvariables.html#PROCCID>`__ holds the *process ID*
    ` [4]  <special-chars.html#FTN.AEN1071>`__ of the script in which it
    appears.


Parèntesis: ()
==============

    **command group.**


    .. code-block:: sh

        (a=hello; echo $a)






    |Important

    A listing of commands within
    ``                         parentheses                       ``
    starts a `subshell <subshells.html#SUBSHELLSREF>`__ .

    Variables inside parentheses, within the subshell, are not visible
    to the rest of the script. The parent process, the script, `cannot
    read variables created in the child
    process <subshells.html#PARVIS>`__ , the subshell.


.. code-block:: sh

    a=123
    ( a=321; )

    echo "a = $a"   # a
= 123
    # "a" within parenth
eses acts like a local v
ariable.




    .. code-block:: sh

        a=123
        ( a=321; )

        echo "a = $a"   # a = 123
        # "a" within parentheses acts like a local variable.


    .. code-block:: sh

        a=123
        ( a=321; )

        echo "a = $a"   # a = 123
        # "a" within parentheses acts like a local variable.





    **array initialization.**


    .. code-block:: sh

        Array=(element1 element2 element3)


Claus: {}
=========

 {xxx,yyy,zzz,...}

    **Brace expansion.**


    .. code-block:: sh

        echo \"{These,words,are,quoted}\"   # " prefix and suffix
        # "These" "words" "are" "quoted"


        cat {file1,file2,file3} > combined_file
        # Concatenates the files file1, file2, and file3 into combined_file.

        cp file22.{txt,backup}
        # Copies "file22.txt" to "file22.backup"




    A command may act upon a comma-separated list of file specs within
    ``                   braces                 `` . ` [5]
     <special-chars.html#FTN.AEN1124>`__ Filename expansion (
    `globbing <globbingref.html>`__ ) applies to the file specs between
    the braces.



    |Caution

    No spaces allowed within the braces *unless* the spaces are quoted
    or escaped.

    ``                         echo {file1,file2}\ :{\ A," B",' C'}                       ``

    ``            file1 : A file1 : B file1 : C file2 : A file2 : B file2 : C           ``




 {a..z}

    **Extended Brace expansion.**


    .. code-block:: sh

        echo {a..z} # a b c d e f g h i j k l m n o p q r s t u v w x y z
        # Echoes characters between a and z.

        echo {0..3} # 0 1 2 3
        # Echoes characters between 0 and 3.


        base64_charset=( {A..Z} {a..z} {0..9} + / = )
        # Initializing an array, using extended brace expansion.
        # From vladz's "base64.sh" example script.




    The *{a..z}* `extended brace
    expansion <bashver3.html#BRACEEXPREF3>`__ construction is a feature
    introduced in `version 3 <bashver3.html#BASH3REF>`__ of *Bash* .

 {}

    **Block of code [curly brackets].** Also referred to as an *inline
    group* , this construct, in effect, creates an *anonymous function*
    (a function without a name). However, unlike in a "standard"
    `function <functions.html#FUNCTIONREF>`__ , the variables inside a
    code block remain visible to the remainder of the script.



    .. code-block:: sh

        bash$ { local a;
                  a=123; }
        bash: local: can only be used in a
        function





    .. code-block:: sh

        a=123
        { a=321; }
        echo "a = $a"   # a = 321   (value inside code block)

        # Thanks, S.C.



    The code block enclosed in braces may have `I/O
    redirected <io-redirection.html#IOREDIRREF>`__ to and from it.


    **Example 3-1. Code blocks and I/O redirection**


    .. code-block:: sh

        #!/bin/bash
        # Reading lines in /etc/fstab.

        File=/etc/fstab

        {
        read line1
        read line2
        } < $File

        echo "First line in $File is:"
        echo "$line1"
        echo
        echo "Second line in $File is:"
        echo "$line2"

        exit 0

        # Now, how do you parse the separate fields of each line?
        # Hint: use awk, or . . .
        # . . . Hans-Joerg Diers suggests using the "set" Bash builtin.





    **Example 3-2. Saving the output of a code block to a file**


    .. code-block:: sh

        #!/bin/bash
        # rpm-check.sh

        #  Queries an rpm file for description, listing,
        #+ and whether it can be installed.
        #  Saves output to a file.
        #
        #  This script illustrates using a code block.

        SUCCESS=0
        E_NOARGS=65

        if [ -z "$1" ]
        then
          echo "Usage: `basename $0` rpm-file"
          exit $E_NOARGS
        fi

        { # Begin code block.
          echo
          echo "Archive Description:"
          rpm -qpi $1       # Query description.
          echo
          echo "Archive Listing:"
          rpm -qpl $1       # Query listing.
          echo
          rpm -i --test $1  # Query whether rpm file can be installed.
          if [ "$?" -eq $SUCCESS ]
          then
            echo "$1 can be installed."
          else
            echo "$1 cannot be installed."
          fi
          echo              # End code block.
        } > "$1.test"       # Redirects output of everything in block to file.

        echo "Results of rpm test in file $1.test"

        # See rpm man page for explanation of options.

        exit 0






    |Note

    Unlike a command group within (parentheses), as above, a code block
    enclosed by {braces} will *not* normally launch a
    `subshell <subshells.html#SUBSHELLSREF>`__ . ` [6]
     <special-chars.html#FTN.AEN1199>`__

    It is possible to `iterate <loops1.html#ITERATIONREF>`__ a code
    block using a `non-standard *for-loop* <loops1.html#NODODONE>`__ .




 {}

    **placeholder for text.** Used after `xargs
    ``           -i          `` <moreadv.html#XARGSCURLYREF>`__ (
    *replace strings* option). The {} double curly brackets are a
    placeholder for output text.



    .. code-block:: sh

        ls .xargs -i -t cp ./{} $1
        #            ^^         ^^

        # From "ex42.sh" (copydir.sh) example.



 {} \\;

    **pathname.** Mostly used in `find <moreadv.html#FINDREF>`__
    constructs. This is *not* a shell
    `builtin <internal.html#BUILTINREF>`__ .




    Definition: A *pathname* is a *filename* that includes the complete
    `path <internalvariables.html#PATHREF>`__ . As an example,
    ``            /home/bozo/Notes/Thursday/schedule.txt           `` .
    This is sometimes referred to as the *absolute path* .






    |Note

    The " ; " ends the ``            -exec           `` option of a
    **find** command sequence. It needs to be escaped to protect it from
    interpretation by the shell.



Claudàtors: [ ]
===============

    **test.**


    `Test <tests.html#IFTHEN>`__ expression between **[ ]** . Note that
    **[** is part of the shell *builtin*
    `test <testconstructs.html#TTESTREF>`__ (and a synonym for it),
    *not* a link to the external command
    ``         /usr/bin/test        `` .

 [[ ]]

    **test.**


    Test expression between [[ ]] . More flexible than the
    single-bracket [ ] test, this is a shell
    `keyword <internal.html#KEYWORDREF>`__ .

    See the discussion on the `[[ ... ]]
    construct <testconstructs.html#DBLBRACKETS>`__ .

 [ ]

    **array element.**


    In the context of an `array <arrays.html#ARRAYREF>`__ , brackets set
    off the numbering of each element of that array.


    .. code-block:: sh

        Array[1]=slot_1
        echo ${Array[1]}



 [ ]

    **range of characters.**


    As part of a `regular expression <regexp.html#REGEXREF>`__ ,
    brackets delineate a `range of
    characters <x17129.html#BRACKETSREF>`__ to match.

 $[ ... ]

    **integer expansion.**


    Evaluate integer expression between $[ ] .


    .. code-block:: sh

        a=3
        b=7

        echo $[$a+$b]   # 10
        echo $[$a*$b]   # 21



    Note that this usage is *deprecated* , and has been replaced by the
    `(( ... )) <dblparens.html>`__ construct.

 (( ))

    **integer expansion.**


    Expand and evaluate integer expression between (( )) .

    See the discussion on the `(( ... )) construct <dblparens.html>`__ .

 > &> >& >> < <>

    **`redirection <io-redirection.html#IOREDIRREF>`__ .**


    ``                   scriptname >filename                 ``
    redirects the output of ``         scriptname        `` to file
    ``         filename        `` . Overwrite
    ``         filename        `` if it already exists.

    ``                   command &>filename                 `` redirects
    both the
    ``          stdout         `` <ioredirintro.html#STDINOUTDEF>`__
    and the ``         stderr        `` of ``         command        ``
    to ``         filename        `` .



    |Note

     This is useful for suppressing output when testing for a condition.
    For example, let us test whether a certain command exists.


.. code-block:: sh

    bash$ type bogus_com
mand &>/dev/null



    bash$ echo $?
    1




    Or in a script:


.. code-block:: sh

    command_test () { ty
pe "$1" &>/dev/null; }
    #
                   ^

    cmd=rmdir
 # Legitimate command.
    command_test $cmd; e
cho $?   # 0


    cmd=bogus_command
 # Illegitimate command
    command_test $cmd; e
cho $?   # 1




    .. code-block:: sh

        bash$ type bogus_command &>/dev/null



        bash$ echo $?
        1



    .. code-block:: sh

        command_test () { type "$1" &>/dev/null; }
        #                                      ^

        cmd=rmdir            # Legitimate command.
        command_test $cmd; echo $?   # 0


        cmd=bogus_command    # Illegitimate command
        command_test $cmd; echo $?   # 1


    .. code-block:: sh

        bash$ type bogus_command &>/dev/null



        bash$ echo $?
        1



    .. code-block:: sh

        command_test () { type "$1" &>/dev/null; }
        #                                      ^

        cmd=rmdir            # Legitimate command.
        command_test $cmd; echo $?   # 0


        cmd=bogus_command    # Illegitimate command
        command_test $cmd; echo $?   # 1




    ``                   command >&2                 `` redirects
    ``         stdout        `` of ``         command        `` to
    ``         stderr        `` .

    ``                   scriptname >>filename                 ``
    appends the output of ``         scriptname        `` to file
    ``         filename        `` . If ``         filename        ``
    does not already exist, it is created.

    ``                   [i]<>filename                 `` opens file
    ``         filename        `` for reading and writing, and assigns
    `file descriptor <io-redirection.html#FDREF>`__ i to it. If
    ``         filename        `` does not exist, it is created.


    **`process substitution <process-sub.html#PROCESSSUBREF>`__ .**


    ``                   (command)>                 ``

    ``                   <(command)                 ``

    `In a different context <comparison-ops.html#LTREF>`__ , the " < "
    and " > " characters act as `string comparison
    operators <comparison-ops.html#SCOMPARISON1>`__ .

    `In yet another context <comparison-ops.html#INTLT>`__ , the " < "
    and " > " characters act as `integer comparison
    operators <comparison-ops.html#ICOMPARISON1>`__ . See also `Example
    16-9 <moreadv.html#EX45>`__ .

Signes de menor i major: < >
============================

 <<

    **redirection used in a `here
    document <here-docs.html#HEREDOCREF>`__ .**


 <<<

    **redirection used in a `here string <x17837.html#HERESTRINGSREF>`__
    .**


 < , >

    **`ASCII comparison <comparison-ops.html#LTREF>`__ .**


    .. code-block:: sh

        veg1=carrots
        veg2=tomatoes

        if [[ "$veg1" < "$veg2" ]]
        then
          echo "Although $veg1 precede $veg2 in the dictionary,"
          echo -n "this does not necessarily imply anything "
          echo "about my culinary preferences."
        else
          echo "What kind of dictionary are you using, anyhow?"
        fi




 \\< , \\>

    **`word boundary <x17129.html#ANGLEBRAC>`__ in a `regular
    expression <regexp.html#REGEXREF>`__ .**


    ``         bash$        ``
    ``                   grep '\<the\>' textfile                 ``

.. _specialchars-pipe:

Barra vertical o *pipe*: \
===========================


    **pipe.** Passes the output ( ``          stdout         `` ) of a
    previous command to the input ( ``          stdin         `` ) of
    the next one, or to the shell. This is a method of chaining commands
    together.



    .. code-block:: sh

        echo ls -lsh
        #  Passes the output of "echo ls -l" to the shell,
        #+ with the same result as a simple "ls -l".


        cat *.lstsort | uniq
        # Merges and sorts all ".lst" files, then deletes duplicate lines.





    A pipe, as a classic method of interprocess communication, sends the
    ``            stdout           `` of one
    `process <special-chars.html#PROCESSREF>`__ to the
    ``            stdin           `` of another. In a typical case, a
    command, such as `cat <basic.html#CATREF>`__ or
    `echo <internal.html#ECHOREF>`__ , pipes a stream of data to a
    *filter* , a command that transforms its input for processing. ` [7]
     <special-chars.html#FTN.AEN1564>`__

    ``                         cat $filename1 $filename2grep $search_word                       ``

    For an interesting note on the complexity of using UNIX pipes, see
    `the UNIX FAQ, Part
    3 <http://www.faqs.org/faqs/unix-faq/faq>`__ .




     The output of a command or commands may be piped to a script.


    .. code-block:: sh

        #!/bin/bash
        # uppercase.sh : Changes input to uppercase.

        tr 'a-z' 'A-Z'
        #  Letter ranges must be quoted
        #+ to prevent filename generation from single-letter filenames.

        exit 0



    Now, let us pipe the output of **ls -l** to this script.


    .. code-block:: sh

        bash$ ls -l./uppercase.sh
        -RW-RW-R--    1 BOZO  BOZO       109 APR  7 19:49 1.TXT
         -RW-RW-R--    1 BOZO  BOZO       109 APR 14 16:48 2.TXT
         -RW-R--R--    1 BOZO  BOZO       725 APR 20 20:56 DATA-FILE






    |Note

    The ``            stdout           `` of each process in a pipe must
    be read as the ``            stdin           `` of the next. If this
    is not the case, the data stream will *block* , and the pipe will
    not behave as expected.


.. code-block:: sh

    cat file1 file2 | ls
 -l | sort
    # The output from "c
at file1 file2" disappea
rs.



    A pipe runs as a `child process <othertypesv.html#CHILDREF>`__ , and
    therefore cannot alter script variables.


.. code-block:: sh

    variable="initial_va
lue"
    echo "new_value" | r
ead variable
    echo "variable = $va
riable"     # variable =
 initial_value



    If one of the commands in the pipe aborts, this prematurely
    terminates execution of the pipe. Called a *broken pipe* , this
    condition sends a
    ``                         SIGPIPE                       ``
    `signal <debugging.html#SIGNALD>`__ .


    .. code-block:: sh

        cat file1 file2ls -l | sort
        # The output from "cat file1 file2" disappears.


    .. code-block:: sh

        variable="initial_value"
        echo "new_value"read variable
        echo "variable = $variable"     # variable = initial_value


    .. code-block:: sh

        cat file1 file2ls -l | sort
        # The output from "cat file1 file2" disappears.


    .. code-block:: sh

        variable="initial_value"
        echo "new_value"read variable
        echo "variable = $variable"     # variable = initial_value




 >\

    **force redirection (even if the `noclobber
    option <options.html#NOCLOBBERREF>`__ is set).** This will forcibly
    overwrite an existing file.


 \|\

    **`OR logical operator <ops.html#ORREF>`__ .** In a `test
    construct <testconstructs.html#TESTCONSTRUCTS1>`__ , the \|\
    operator causes a return of 0 (success) if *either* of the linked
    test conditions is true.


Símbol d'unió o *ampersand*: &
==============================

    **Run job in background.** A command followed by an & will run in
    the background.



    .. code-block:: sh

        bash$ sleep 10 &
        [1] 850
        [1]+  Done                    sleep 10




    Within a script, commands and even
    `loops <loops1.html#FORLOOPREF1>`__ may run in the background.


    **Example 3-3. Running a loop in the background**


    .. code-block:: sh

        #!/bin/bash
        # background-loop.sh

        for i in 1 2 3 4 5 6 7 8 9 10            # First loop.
        do
          echo -n "$i "
        done & # Run this loop in background.
               # Will sometimes execute after second loop.

        echo   # This 'echo' sometimes will not display.

        for i in 11 12 13 14 15 16 17 18 19 20   # Second loop.
        do
          echo -n "$i "
        done

        echo   # This 'echo' sometimes will not display.

        # ======================================================

        # The expected output from the script:
        # 1 2 3 4 5 6 7 8 9 10
        # 11 12 13 14 15 16 17 18 19 20

        # Sometimes, though, you get:
        # 11 12 13 14 15 16 17 18 19 20
        # 1 2 3 4 5 6 7 8 9 10 bozo $
        # (The second 'echo' doesn't execute. Why?)

        # Occasionally also:
        # 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
        # (The first 'echo' doesn't execute. Why?)

        # Very rarely something like:
        # 11 12 13 1 2 3 4 5 6 7 8 9 10 14 15 16 17 18 19 20
        # The foreground loop preempts the background one.

        exit 0

        #  Nasimuddin Ansari suggests adding    sleep 1
        #+ after the   echo -n "$i"   in lines 6 and 14,
        #+ for some real fun.






    |Caution

    A command run in the background within a script may cause the script
    to hang, waiting for a keystroke. Fortunately, there is a
    `remedy <x9644.html#WAITHANG>`__ for this.




 &&

    **`AND logical operator <ops.html#LOGOPS1>`__ .** In a `test
    construct <testconstructs.html#TESTCONSTRUCTS1>`__ , the && operator
    causes a return of 0 (success) only if *both* the linked test
    conditions are true.


Guió: -
=======

    **option, prefix.** Option flag for a command or filter. Prefix for
    an operator. Prefix for a `default
    parameter <parameter-substitution.html#DEFPARAM1>`__ in `parameter
    substitution <parameter-substitution.html#PARAMSUBREF>`__ .


    ``                   COMMAND -[Option1][Option2][...]                 ``

    ``                   ls -al                 ``

    ``                   sort -dfu $filename                 ``


    .. code-block:: sh

        if [ $file1 -ot $file2 ]
        then #      ^
          echo "File $file1 is older than $file2."
        fi

        if [ "$a" -eq "$b" ]
        then #    ^
          echo "$a is equal to $b."
        fi

        if [ "$c" -eq 24 -a "$d" -eq 47 ]
        then #    ^              ^
          echo "$c equals 24 and $d equals 47."
        fi


        param2=${param1:-$DEFAULTVAL}
        #               ^



    **--**

    The *double-dash* ``         --        `` prefixes *long* (verbatim)
    options to commands.

    ``                   sort --ignore-leading-blanks                 ``

    Used with a `Bash builtin <internal.html#BUILTINREF>`__ , it means
    the *end of options* to that particular command.



    |Tip

    This provides a handy means of removing files whose *names begin
    with a dash* .


.. code-block:: sh

    bash$ ls -l
    -rw-r--r-- 1 bozo bo
zo 0 Nov 25 12:29 -badna
me


    bash$ rm -- -badname

    bash$ ls -l
    total 0




    .. code-block:: sh

        bash$ ls -l
        -rw-r--r-- 1 bozo bozo 0 Nov 25 12:29 -badname


        bash$ rm -- -badname

        bash$ ls -l
        total 0


    .. code-block:: sh

        bash$ ls -l
        -rw-r--r-- 1 bozo bozo 0 Nov 25 12:29 -badname


        bash$ rm -- -badname

        bash$ ls -l
        total 0




    The *double-dash* is also used in conjunction with
    `set <internal.html#SETREF>`__ .

    ``                   set -- $variable                 `` (as in
    `Example 15-18 <internal.html#SETPOS>`__ )

 -

    **redirection from/to ``           stdin          `` or
    ``           stdout          `` [dash].**



    .. code-block:: sh

        bash$ cat -
        abc
        abc

        ...

        Ctl-D



    As expected, ``                   cat -                 `` echoes
    ``         stdin        `` , in this case keyboarded user input, to
    ``         stdout        `` . But, does I/O redirection using **-**
    have real-world applications?


    .. code-block:: sh

        (cd /source/directory && tar cf - . )(cd /dest/directory && tar xpvf -)
        # Move entire file tree from one directory to another
        # [courtesy Alan Cox <a.cox@swansea.ac.uk>, with a minor change]

        # 1) cd /source/directory
        #    Source directory, where the files to be moved are.
        # 2) &&
        #   "And-list": if the 'cd' operation successful,
        #    then execute the next command.
        # 3) tar cf - .
        #    The 'c' option 'tar' archiving command creates a new archive,
        #    the 'f' (file) option, followed by '-' designates the target file
        #    as stdout, and do it in current directory tree ('.').
        # 4)
        #    Piped to ...
        # 5) ( ... )
        #    a subshell
        # 6) cd /dest/directory
        #    Change to the destination directory.
        # 7) &&
        #   "And-list", as above
        # 8) tar xpvf -
        #    Unarchive ('x'), preserve ownership and file permissions ('p'),
        #    and send verbose messages to stdout ('v'),
        #    reading data from stdin ('f' followed by '-').
        #
        #    Note that 'x' is a command, and 'p', 'v', 'f' are options.
        #
        # Whew!



        # More elegant than, but equivalent to:
        #   cd source/directory
        #   tar cf - .(cd ../dest/directory; tar xpvf -)
        #
        #     Also having same effect:
        # cp -a /source/directory/* /dest/directory
        #     Or:
        # cp -a /source/directory/* /source/directory/.[^.]* /dest/directory
        #     If there are hidden files in /source/directory.




    .. code-block:: sh

        bunzip2 -c linux-2.6.16.tar.bz2tar xvf -
        #  --uncompress tar file----then pass it to "tar"--
        #  If "tar" has not been patched to handle "bunzip2",
        #+ this needs to be done in two discrete steps, using a pipe.
        #  The purpose of the exercise is to unarchive "bzipped" kernel source.



    Note that in this context the "-" is not itself a Bash operator, but
    rather an option recognized by certain UNIX utilities that write to
    ``         stdout        `` , such as **tar** , **cat** , etc.


    .. code-block:: sh

        bash$ echo "whatever"cat -
        whatever



    Where a filename is expected,
    ``                   -                 `` redirects output to
    ``         stdout        `` (sometimes seen with
    ``                   tar cf                 `` ), or accepts input
    from ``         stdin        `` , rather than from a file. This is a
    method of using a file-oriented utility as a filter in a pipe.


    .. code-block:: sh

        bash$ file
        Usage: file [-bciknvzL] [-f namefile] [-m magicfiles] file...




    By itself on the command-line, `file <filearchiv.html#FILEREF>`__
    fails with an error message.

    Add a "-" for a more useful result. This causes the shell to await
    user input.


    .. code-block:: sh

        bash$ file -
        abc
        standard input:              ASCII text



        bash$ file -
        #!/bin/bash
        standard input:              Bourne-Again shell script text executable




    Now the command accepts input from ``        stdin       `` and
    analyzes it.

    The "-" can be used to pipe ``         stdout        `` to other
    commands. This permits such stunts as `prepending lines to a
    file <assortedtips.html#PREPENDREF>`__ .

    Using `diff <filearchiv.html#DIFFREF>`__ to compare a file with a
    *section* of another:

    ``                   grep Linux file1diff file2 -                 ``

    Finally, a real-world example using
    ``                   -                 `` with
    `tar <filearchiv.html#TARREF>`__ .


    **Example 3-4. Backup of all files changed in last day**


    .. code-block:: sh

        #!/bin/bash

        #  Backs up all files in current directory modified within last 24 hours
        #+ in a "tarball" (tarred and gzipped file).

        BACKUPFILE=backup-$(date +%m-%d-%Y)
        #                 Embeds date in backup filename.
        #                 Thanks, Joshua Tschida, for the idea.
        archive=${1:-$BACKUPFILE}
        #  If no backup-archive filename specified on command-line,
        #+ it will default to "backup-MM-DD-YYYY.tar.gz."

        tar cvf - `find . -mtime -1 -type f -print` > $archive.tar
        gzip $archive.tar
        echo "Directory $PWD backed up in archive file \"$archive.tar.gz\"."


        #  Stephane Chazelas points out that the above code will fail
        #+ if there are too many files found
        #+ or if any filenames contain blank characters.

        # He suggests the following alternatives:
        # -------------------------------------------------------------------
        #   find . -mtime -1 -type f -print0xargs -0 tar rvf "$archive.tar"
        #      using the GNU version of "find".


        #   find . -mtime -1 -type f -exec tar rvf "$archive.tar" '{}' \;
        #         portable to other UNIX flavors, but much slower.
        # -------------------------------------------------------------------


        exit 0






    |Caution

    Filenames beginning with "-" may cause problems when coupled with
    the "-" redirection operator. A script should check for this and add
    an appropriate prefix to such filenames, for example
    ``            ./-FILENAME           `` ,
    ``            $PWD/-FILENAME           `` , or
    ``            $PATHNAME/-FILENAME           `` .

    If the value of a variable begins with a
    ``                         -                       `` , this may
    likewise create problems.


.. code-block:: sh

    var="-n"
    echo $var
    # Has the effect of
"echo -n", and outputs n
othing.




    .. code-block:: sh

        var="-n"
        echo $var
        # Has the effect of "echo -n", and outputs nothing.


    .. code-block:: sh

        var="-n"
        echo $var
        # Has the effect of "echo -n", and outputs nothing.




 -

    **previous working directory.** A **cd -** command changes to the
    previous working directory. This uses the
    `$OLDPWD <internalvariables.html#OLDPWD>`__ `environmental
    variable <othertypesv.html#ENVREF>`__ .




    |Caution

    Do not confuse the "-" used in this sense with the "-" redirection
    operator just discussed. The interpretation of the "-" depends on
    the context in which it appears.




 -

    **Minus.** Minus sign in an `arithmetic
    operation <ops.html#AROPS1>`__ .


Igual: =
========

    **Equals.** `Assignment operator <varassignment.html#EQREF>`__


    .. code-block:: sh

        a=28
        echo $a   # 28




    In a `different context <comparison-ops.html#EQUALSIGNREF>`__ , the
    " = " is a `string comparison <comparison-ops.html#SCOMPARISON1>`__
    operator.

Suma: +
=======

    **Plus.** Addition `arithmetic operator <ops.html#AROPS1>`__ .


    In a `different context <x17129.html#PLUSREF>`__ , the + is a
    `Regular Expression <regexp.html>`__ operator.

 +

    **Option.** Option flag for a command or filter.


    Certain commands and `builtins <internal.html#BUILTINREF>`__ use the
    ``         +        `` to enable certain options and the
    ``         -        `` to disable them. In `parameter
    substitution <parameter-substitution.html#PARAMSUBREF>`__ , the
    ``         +        `` prefixes an `alternate
    value <parameter-substitution.html#PARAMALTV>`__ that a variable
    expands to.

Percentatge: %
==============

    **`modulo <ops.html#MODULOREF>`__ .** Modulo (remainder of a
    division) `arithmetic operation <ops.html#AROPS1>`__ .



    .. code-block:: sh

        let "z = 5 % 3"
        echo $z  # 2



    In a `different context <parameter-substitution.html#PCTPATREF>`__ ,
    the % is a `pattern matching <parameter-substitution.html#PSUB2>`__
    operator.

Tilde: ~
========

    **home directory [tilde].** This corresponds to the
    `$HOME <internalvariables.html#HOMEDIRREF>`__ internal variable.
    ``          ~bozo         `` is bozo's home directory, and **ls
    ~bozo** lists the contents of it. ~/ is the current user's home
    directory, and **ls ~/** lists the contents of it.


    .. code-block:: sh

        bash$ echo ~bozo
        /home/bozo

        bash$ echo ~
        /home/bozo

        bash$ echo ~/
        /home/bozo/

        bash$ echo ~:
        /home/bozo:

        bash$ echo ~nonexistent-user
        ~nonexistent-user





 ~+

    **current working directory.** This corresponds to the
    `$PWD <internalvariables.html#PWDREF>`__ internal variable.


 ~-

    **previous working directory.** This corresponds to the
    `$OLDPWD <internalvariables.html#OLDPWD>`__ internal variable.


 =~

    **`regular expression match <bashver3.html#REGEXMATCHREF>`__ .**
    This operator was introduced with `version
    3 <bashver3.html#BASH3REF>`__ of Bash.


 ^

    **beginning-of-line.** In a `regular
    expression <regexp.html#REGEXREF>`__ , a "^" addresses the
    `beginning of a line <x17129.html#CARETREF>`__ of text.


 ^ , ^^

    **`Uppercase conversion <bashver4.html#CASEMODPARAMSUB>`__ in
    *parameter substitution* (added in `version
    4 <bashver4.html#BASH4REF>`__ of Bash).**


Caràcters de control
====================

    **change the behavior of the terminal or text display.** A control
    character is a **CONTROL** + **key** combination (pressed
    simultaneously). A control character may also be written in *octal*
    or *hexadecimal* notation, following an *escape* .


    Control characters are not normally useful inside a script.

    -  ``                       Ctl-A                     ``

       Moves cursor to beginning of line of text (on the command-line).

    -  ``                       Ctl-B                     ``

       ``                       Backspace                     ``
       (nondestructive).

    -

       ``                       Ctl-C                     ``

       ``                       Break                     `` . Terminate
       a foreground job.

    -

       ``                       Ctl-D                     ``

       *Log out* from a shell (similar to
       `exit <exit-status.html#EXITCOMMANDREF>`__ ).

       ``                       EOF                     ``
       (end-of-file). This also terminates input from
       ``           stdin          `` .

       When typing text on the console or in an *xterm* window,
       ``                       Ctl-D                     `` erases the
       character under the cursor. When there are no characters present,
       ``                       Ctl-D                     `` logs out of
       the session, as expected. In an *xterm* window, this has the
       effect of closing the window.

    -  ``                       Ctl-E                     ``

       Moves cursor to end of line of text (on the command-line).

    -  ``                       Ctl-F                     ``

       Moves cursor forward one character position (on the
       command-line).

    -

       ``                       Ctl-G                     ``

       ``                       BEL                     `` . On some
       old-time teletype terminals, this would actually ring a bell. In
       an *xterm* it might beep.

    -

       ``                       Ctl-H                     ``

       ``                       Rubout                     ``
       (destructive backspace). Erases characters the cursor backs over
       while backspacing.


       .. code-block:: sh

           #!/bin/bash
           # Embedding Ctl-H in a string.

           a="^H^H"                  # Two Ctl-H's -- backspaces
                                     # ctl-V ctl-H, using vi/vim
           echo "abcdef"             # abcdef
           echo
           echo -n "abcdef$a "       # abcd f
           #  Space at end  ^              ^  Backspaces twice.
           echo
           echo -n "abcdef$a"        # abcdef
           #  No space at end               ^ Doesn't backspace (why?).
                                     # Results may not be quite as expected.
           echo; echo

           # Constantin Hagemeier suggests trying:
           # a=$'\010\010'
           # a=$'\b\b'
           # a=$'\x08\x08'
           # But, this does not change the results.

           ########################################

           # Now, try this.

           rubout="^H^H^H^H^H"       # 5 x Ctl-H.

           echo -n "12345678"
           sleep 2
           echo -n "$rubout"
           sleep 2



    -  ``                       Ctl-I                     ``

       ``                       Horizontal tab                     `` .

    -

       ``                       Ctl-J                     ``

       ``                       Newline                     `` (line
       feed). In a script, may also be expressed in octal notation --
       '\\012' or in hexadecimal -- '\\x0a'.

    -  ``                       Ctl-K                     ``

       ``                       Vertical tab                     `` .

       When typing text on the console or in an *xterm* window,
       ``                       Ctl-K                     `` erases from
       the character under the cursor to end of line. Within a script,
       ``                       Ctl-K                     `` may behave
       differently, as in Lee Lee Maschmeyer's example, below.

    -  ``                       Ctl-L                     ``

       ``                       Formfeed                     `` (clear
       the terminal screen). In a terminal, this has the same effect as
       the `clear <terminalccmds.html#CLEARREF>`__ command. When sent to
       a printer, a
       ``                       Ctl-L                     `` causes an
       advance to end of the paper sheet.

    -

       ``                       Ctl-M                     ``

       ``                       Carriage return                     `` .


       .. code-block:: sh

           #!/bin/bash
           # Thank you, Lee Maschmeyer, for this example.

           read -n 1 -s -p \
           $'Control-M leaves cursor at beginning of this line. Press Enter. \x0d'
                      # Of course, '0d' is the hex equivalent of Control-M.
           echo >&2   #  The '-s' makes anything typed silent,
                      #+ so it is necessary to go to new line explicitly.

           read -n 1 -s -p $'Control-J leaves cursor on next line. \x0a'
                      #  '0a' is the hex equivalent of Control-J, linefeed.
           echo >&2

           ###

           read -n 1 -s -p $'And Control-K\x0bgoes straight down.'
           echo >&2   #  Control-K is vertical tab.

           # A better example of the effect of a vertical tab is:

           var=$'\x0aThis is the bottom line\x0bThis is the top line\x0a'
           echo "$var"
           #  This works the same way as the above example. However:
           echo "$var"col
           #  This causes the right end of the line to be higher than the left end.
           #  It also explains why we started and ended with a line feed --
           #+ to avoid a garbled screen.

           # As Lee Maschmeyer explains:
           # --------------------------
           #  In the [first vertical tab example] . . . the vertical tab
           #+ makes the printing go straight down without a carriage return.
           #  This is true only on devices, such as the Linux console,
           #+ that can't go "backward."
           #  The real purpose of VT is to go straight UP, not down.
           #  It can be used to print superscripts on a printer.
           #  The col utility can be used to emulate the proper behavior of VT.

           exit 0



    -  ``                       Ctl-N                     ``

       Erases a line of text recalled from *history buffer* ` [8]
        <special-chars.html#FTN.AEN2107>`__ (on the command-line).

    -  ``                       Ctl-O                     ``

       Issues a *newline* (on the command-line).

    -  ``                       Ctl-P                     ``

       Recalls last command from *history buffer* (on the command-line).

    -  ``                       Ctl-Q                     ``

       Resume ( ``                       XON                     `` ).

       This resumes ``           stdin          `` in a terminal.

    -  ``                       Ctl-R                     ``

       Backwards search for text in *history buffer* (on the
       command-line).

    -  ``                       Ctl-S                     ``

       Suspend ( ``                       XOFF                     `` ).

       This freezes ``           stdin          `` in a terminal. (Use
       Ctl-Q to restore input.)

    -  ``                       Ctl-T                     ``

       Reverses the position of the character the cursor is on with the
       previous character (on the command-line).

    -  ``                       Ctl-U                     ``

       Erase a line of input, from the cursor backward to beginning of
       line. In some settings,
       ``                       Ctl-U                     `` erases the
       entire line of input, *regardless of cursor position* .

    -  ``                       Ctl-V                     ``

       When inputting text,
       ``                       Ctl-V                     `` permits
       inserting control characters. For example, the following two are
       equivalent:


       .. code-block:: sh

           echo -e '\x0a'
           echo <Ctl-V><Ctl-J>



       ``                       Ctl-V                     `` is
       primarily useful from within a text editor.

    -  ``                       Ctl-W                     ``

       When typing text on the console or in an xterm window,
       ``                       Ctl-W                     `` erases from
       the character under the cursor backwards to the first instance of
       `whitespace <special-chars.html#WHITESPACEREF>`__ . In some
       settings, ``                       Ctl-W                     ``
       erases backwards to first non-alphanumeric character.

    -  ``                       Ctl-X                     ``

       In certain word processing programs, *Cuts* highlighted text and
       copies to *clipboard* .

    -  ``                       Ctl-Y                     ``

       *Pastes* back text previously erased (with
       ``                       Ctl-U                     `` or
       ``                       Ctl-W                     `` ).

    -  ``                       Ctl-Z                     ``

       *Pauses* a foreground job.

       *Substitute* operation in certain word processing applications.

       ``                       EOF                     `` (end-of-file)
       character in the MSDOS filesystem.


.. _specialchars_whitespaces:

Caràcters en blanc
==================

    **functions as a separator between commands and/or variables.**
    Whitespace consists of either *spaces* , *tabs* , *blank lines* , or
    any combination thereof. ` [9]  <special-chars.html#FTN.AEN2198>`__
    In some contexts, such as `variable
    assignment <gotchas.html#WSBAD>`__ , whitespace is not permitted,
    and results in a syntax error.


    Blank lines have no effect on the action of a script, and are
    therefore useful for visually separating functional sections.

    `$IFS <internalvariables.html#IFSREF>`__ , the special variable
    separating *fields* of input to certain commands. It defaults to
    whitespace.



     ``                         Definition:                       `` A
    *field* is a discrete chunk of data expressed as a string of
    consecutive characters. Separating each field from adjacent fields
    is either *whitespace* or some other designated character (often
    determined by the $IFS ). In some contexts, a field may be called a
    *record* .




    To preserve *whitespace* within a string or in a variable, use
    `quoting <quoting.html#QUOTINGREF>`__ .

    UNIX `filters <special-chars.html#FILTERDEF>`__ can target and
    operate on *whitespace* using the `POSIX <x17129.html#POSIXREF>`__
    character class `[:space:] <x17129.html#WSPOSIX>`__ .


.. rubric:: Anotacions


.. [#metameaning] Consulta :doc:`x17129` per més informació
   sobre el concepte de *meta-significat*.

.. [#operadors] Els *operadors* defineixen l'operació a realitzar en una expressió. Alguns exemples
   són els coneguts operadors aritmètics (+, -, \* i \/) (mira :doc:`ops`) per més detalls.

   En Bash els conceptes d'*operador* i de *paraula clau* apareixen una mica superposats. Mira
   :ref:`internal_keyword`.

` [2]  <special-chars.html#AEN888>`__

This is more commonly known as the *ternary* operator. Unfortunately,
*ternary* is an ugly word. It doesn't roll off the tongue, and it
doesn't elucidate. It obfuscates. *Trinary* is by far the more elegant
usage.


` [3]  <special-chars.html#AEN1001>`__

**A** merican **S** tandard **C** ode for **I** nformation **I**
nterchange. This is a system for encoding text characters (alphabetic,
numeric, and a limited set of symbols) as 7-bit numbers that can be
stored and manipulated by computers. Many of the ASCII characters are
represented on a standard keyboard.


` [4]  <special-chars.html#AEN1071>`__

A *PID* , or *process ID* , is a number assigned to a running process.
The *PID* s of running processes may be viewed with a
`ps <system.html#PPSSREF>`__ command.

``               Definition:             `` A *process* is a currently
executing command (or program), sometimes referred to as a *job* .


` [5]  <special-chars.html#AEN1124>`__

The shell does the *brace expansion* . The command itself acts upon the
*result* of the expansion.


` [6]  <special-chars.html#AEN1199>`__

Exception: a code block in braces as part of a pipe *may* run as a
`subshell <subshells.html#SUBSHELLSREF>`__ .

 .. code-block:: sh

     ls{ read firstlin
 e; read secondline; }
     #  Error. The code b
 lock in braces runs as a
  subshell,
     #+ so the output of
 "ls" cannot be passed to
  variables within the bl
 ock.
     echo "First line is
 $firstline; second line
 is $secondline"  # Won't
  work.

     # Thanks, S.C.


.. code-block:: sh

    ls{ read firstline; read secondline; }
    #  Error. The code block in braces runs as a subshell,
    #+ so the output of "ls" cannot be passed to variables within the block.
    echo "First line is $firstline; second line is $secondline"  # Won't work.

    # Thanks, S.C.


.. code-block:: sh

    ls{ read firstline; read secondline; }
    #  Error. The code block in braces runs as a subshell,
    #+ so the output of "ls" cannot be passed to variables within the block.
    echo "First line is $firstline; second line is $secondline"  # Won't work.

    # Thanks, S.C.


` [7]  <special-chars.html#AEN1564>`__

Even as in olden times a *philtre* denoted a potion alleged to have
magical transformative powers, so does a UNIX *filter* transform its
target in (roughly) analogous fashion. (The coder who comes up with a
"love philtre" that runs on a Linux machine will likely win accolades
and honors.)


` [8]  <special-chars.html#AEN2107>`__

Bash stores a list of commands previously issued from the command-line
in a *buffer* , or memory space, for recall with the
`builtin <internal.html#BUILTINREF>`__ *history* commands.

` [9]  <special-chars.html#AEN2198>`__

A linefeed ( *newline* ) is also a whitespace character. This explains
why a *blank line* , consisting only of a linefeed, is considered
whitespace.


