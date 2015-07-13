###################################
XXX 10.2. Substitució de paràmetres
###################################

**Manipulació i/o expansió de variables**

``${parametre}``
    El mateix que ``$parametre``, És a dir, el valor de la variable
    ``parametre``. En certs contextos, només funciona la forma menys
    ambigua de `` ${parametre} ``.

    Es pot utilitzar per concatenar variables amb strings.

    ::

        el_teu_id=${USER}-a-${HOSTNAME}
        echo "$el_teu_id"
        #
        echo "Antic \$PATH = $PATH"
        PATH=${PATH}:/opt/bin  # Afegeix /opt/bin a $PATH durant l'execució del script.
        echo "Nou \$PATH = $PATH"

``${parametre-perdefecte}``, ``${parametre:-perdefecte}``
    En cas que el paràmetre no estigui assignat, es fa servir el valor
    per defecte.

    ::

        var1=1
        var2=2
        # var3 no està assignada.

        echo ${var1-$var2}   # 1
        echo ${var3-$var2}   # 2
        #           ^          Atenció al prefix $.



        echo ${username-`whoami`}
        # Mostra el resultat de `whoami` si la variable $username no està assignada.

    .. figure:: ../images/note.gif
       :align: center
       :alt: Atenció

       Atenció
    ``${parametre-perdefecte}`` i ``${parametre:-perdefecte}`` són
    pràcticament equivalents. Els : extra només tenen sentit quan
    ``parametre`` està declarat però té assignat nul.

    ::

        #!/bin/bash
        # param-sub.sh

        #  El fet que una variable estigui o no declarada
        #+ suposa l'activació de l'opció per defecte
        #+ fins i tot quan el valor és nul.

        username0=
        echo "username0 està declarat però té assignat el valor nul."
        echo "username0 = ${username0-`whoami`}"
        # No mostrarà res.

        echo

        echo username1 no està declarat.
        echo "username1 = ${username1-`whoami`}"
        # Mostra el valor per defecte (resultat de whoami).

        username2=
        echo "username2 està declarat però té assignat nul."
        echo "username2 = ${username2:-`whoami`}"
        #                            ^
        # Mostra el valor per defecte donat que hem posat a la condició :- en comptes de un simple - .
        # Compara amb la primera instància, per sobre.


        #

        # Un cop més:

        variable=
        # variable està declarada però assignada a nul.

        echo "${variable-0}"    # (sense sortida)
        echo "${variable:-1}"   # 1
        #               ^

        unset variable

        echo "${variable-2}"    # 2
        echo "${variable:-3}"   # 3

        exit 0

    Aquesta funcionalitat de *paràmetre per defecte* és útil quan cal
    definir paràmetres "no indicats" a la línia de comandes de la crida
    al script.

    ::

        DEFAULT_FILENAME=generic.data
        filename=${1:-$DEFAULT_FILENAME}
        #  En cas que no s'indiqui el contrari, les comandes al següent bloc actuen
        #+ sobre el fitxer "generic.data".
        #  Inici del bloc de comandes
        #  ...
        #  ...
        #  ...
        #  Final del bloc de comandes



        #  De l'exemple "hanoi2.bash":
        DISKS=${1:-E_NOPARAM}   # Cal especificar el nombre de discos.
        #  Assigna $DISKS al paràmetre de línia de comanda $1,
        #+ o bé a $E_NOPARAM en cas que $1 no estigui especificat.

    Mira també `Exemple
    3-4 <http://tldp.org/LDP/abs/html/special-chars.html#EX58>`_,
    `Exemple 30-2 <http://tldp.org/LDP/abs/html/zeros.html#EX73>`_, i
    `Exemple
    A-6 <http://tldp.org/LDP/abs/html/contributed-scripts.html#COLLATZ>`_.

    Compara aquest mètode amb l'`ús d'una*llista "and"* per a suplir un
    argument de línia de comandes per
    defecte <http://tldp.org/LDP/abs/html/list-cons.html#ANDDEFAULT>`_.

``${parametre=perdefecte}``, ``${parametre:=perdefecte}``

    En cas que el paràmetre no estigui assignat, assigna'l a
    *perdefecte*.

    Les dues formes són pràcticament equivalents. El funcionament amb
    els : només es diferencia quan ``$parametre`` està declarat i
    assignat a nul `[1] <#FTN.AEN6179>`_ com passava més amunt.

    ::

        echo ${var=abc}   # abc
        echo ${var=xyz}   # abc
        # $var ja se li a assignat abc i per tant no canvia.

``${parametre+altre_valor}``, ``${parametre:+altre_valor}``
    Si el paràmetre està assignat, canvia el valor a ``altre_valor``,
    altrament fes servir el string nul.

    Les dues formes són pràcticament equivalents. El funcionament amb
    els : només es diferencia quan ``parametre`` està declarat i
    assignat a nul (mira més amunt).

    ::

        echo "###### \${parametre+altre_valor} ########"
        echo

        a=${param1+xyz}
        echo "a = $a"      # a =

        param2=
        a=${param2+xyz}
        echo "a = $a"      # a = xyz
        <t0><b1>${parameter=default}</b1></t0>, <t2><b3>${parameter:=default}</b3></t2>
        <t0><b1>${parametre=perdefecte}</b1></t0>, <t2><b3>${parametre:=perdefecte}</b3></t2>
        (50%, 50%, 82%)


        param3=123
        a=${param3+xyz}
        echo "a = $a"      # a = xyz

        echo
        echo "###### \${parametre:+altre_valor} ########"
        echo

        a=${param4:+xyz}
        echo "a = $a"      # a =

        param5=
        a=${param5:+xyz}
        echo "a = $a"      # a =
        # Resultat diferent de a=${param5+xyz}

        param6=123
        a=${param6:+xyz}
        echo "a = $a"      # a = xyz

``${parametre?msg_err}``, ``${parametre:?msg_err}``
    Si el paràmetre està assignat fes servir el seu valor, altrament
    mostra el missatge msg\_err.

    Les dues formes són pràcticament equivalents. El funcionament amb
    els : només es diferencia quan ``$parametre`` està declarat i
    assignat a nul com passava més amunt.

**Exemple 10-7. Ús de la substitució de paràmetres i els missatges
d'error**

::

    #!/bin/bash

    #  Comprovació d'algunes variables d'entorn del sistema.
    #  És una bona pràctica de manteniment preventiu.
    #  Si, per exemple, la variable d'entorn $USER (el nom de la persona logada a la consola), no està assignada,
    #+ la màquina no et podrà reconèixer!.

    : ${HOSTNAME?} ${USER?} ${HOME?} ${MAIL?}
      echo
      echo "El nom de la màquina és $HOSTNAME."
      echo "Tu ets $USER."
      echo "El teu directori d'inici és $HOME."
      echo "La teva carpeta d'entrada de correu es troba a $MAIL."
      echo
      echo "Si pots llegir aquest missatge, "
      echo "vol dir que les variables d'entorn crítiques estan definides."
      echo
      echo

    # ------------------------------------------------------

    #  L'expressió ${variablename?} també pot consultar
    #+ si una variable està assignada dins el script.

    AquestaVar=Valor-daquesta-var
    #  Fixat, per cert, que una variable pot ser assignada
    #+ a strings amb caràcters que no estan permesos en el seu nom.
    : ${AquestaVar?}
    echo "El valor de AquestaVar és $AquestaVar".

    echo; echo


    : ${ZZXy23AB?"ZZXy23AB no està assignada."}
    #  Donat que ZZXy23AB no està assignada,
    #+ el script finalitza amb un missatge d'error.

    # Es pot especificar el missatge d'error.
    # : ${nomvariable?"MISSATGE D'ERROR"}


    # El mateix resultat que amb:   altravariable=${ZZXy23AB?}
    #                     altravariable=${ZZXy23AB?"ZXy23AB no està assignada."}
    #
    #                     echo ${ZZXy23AB?} >/dev/null

    #  Compara aquests mètodes de comprovar si una variable ha estat assignada
    #+ amb "set -u" . . .



    echo "Aquest missatge no es mostrarà perquè hores d'ara el script ja haurà terminat."

    HERE=0
    exit $HERE   # NO finalitzarà aquí!.

    # De fet, el script retornarà 1 com a resultat d'execució (echo $?).

**Exemple 10-8. Ús de la substitució de paràmetres i els missatges
d'"informació"**

::

    #!/bin/bash
    # usage-message.sh

    : ${1?"Ús: $0 ARGUMENT"}
    #  El script finalitza aquí si falta el 1er paràmetre de línia de comandes.
    #+ Mostrarà el següent missatge d'error:
    #    usage-message.sh: 1: Ús: usage-message.sh ARGUMENT

    echo "Aquestes dues línies només s'executaran si s'ha especificat el paràmetre per línia de comandes."
    echo "Paràmetre de línia de comanda = \"$1\""

    exit 0  # Finalitzarà aquí només si s'ha especificar el primer paràmetre per línia de comandes.

    # Pots comprovar el resultat de sortida tant passant-li el primer paràmetre per línia de comandes com no.
    # Si li passes el paràmetre, "$?" serà 0.
    # En cas contrari, "$?" serà 1.

**Ús de la substitució de paràmetres i/o l'expansió.**Les expressions
següents complementen les operacions de strings que consideren la
**coincidència** ``amb`` **expressió** (mira l'`Exemple
16-9 <http://tldp.org/LDP/abs/html/moreadv.html#EX45>`_). Aquestes en
concret es fan servir majoritàriament en l'anàlisi de camins (path)
d'arxius.

**Longitud de variables / Eliminació de substrings**

``${#var}``
    ``Longitud del string`` (nombre de caràcters a ``$var``). Per a un
    `array <http://tldp.org/LDP/abs/html/arrays.html#ARRAYREF>`_,
    **${#array}** correspon a la longitud del primer element de l'array.

    .. figure:: ../images/note.gif
       :align: center
       :alt: Atenció

       Atenció
    Excepcions:

    -

       **${#\*}** i **${#@}** retornen el *nombre de paràmetres*.

    -  En cas d'array, **${#array[\*]}** i **${#array[@]}** retornen el
       nombre d'elements que conté l'array.

    **Exemple 10-9. Durada d'una variable**

    ::

        #!/bin/bash
        # length.sh

        E_NO_ARGS=65

        if [ $# -eq 0 ]  # Per a aquesta demo cal que hi hagi arguments a la línia de comandes.
        then
          echo "Crideu aquest script amb un o més arguments."
          exit $E_NO_ARGS
        fi

        var01=abcdEFGH28ij
        echo "var01 = ${var01}"
        echo "Longitud de var01 = ${#var01}"
        # Intentem-ho ara amb un espai entre els caràcters.
        var02="abcd EFGH28ij"
        echo "var02 = ${var02}"
        echo "Longitud de var02 = ${#var02}"

        echo "Nombre d'arguments de línia de comandes passats al script = ${#@}"
        echo "Nombre d'arguments de línia de comandes passats al script = ${#*}"

        exit 0

``${var#Patró}``, ``${var##Patró}``

    **${var#Patró}** Elimina de ``$var`` la part *més curta* del patró
    que coincideixi ``des de l'inici`` amb el contingut de ``$var``.
    NdT. No he pogut comprovar aquest funcionament. A les meves proves,
    ${var#patró} elimina la cadena "Patró" de l'inici de $var en cas que
    coincideixi perfectament.

    **${var##Patríó}** Elimina de ``$var`` la part *més llarga* de
    ``$Patró`` que coincideixi ``des de l'inici`` amb el contingut de
    ``$var``. NdT. No he pogut comprovar aquest funcionament. A les
    meves proves, ${var##Patró} es comporta idènticament a ${var#Patró}
    excepte en el cas que s'afegeixi el caràcter \*. Ex. ${var#\*Patró}
    no sempre resulta igual a ${var##\*Patró}.

    Veiem un exemple d'ús a l'`Exemple
    A-7 <http://tldp.org/LDP/abs/html/contributed-scripts.html#DAYSBETWEEN>`_:

    ::

        # Una funció de l'exemple "days-between.sh".
        # Elimina els zeros inicials de l'argument.

        strip_leading_zero () #  Elimina un possible zero inicial
        {                     #+ del paràmetre.
          return=${1#0}       #  El "1" correspon al argument "$1".
        }                     #  El "0" és el que volem eliminar de "$1".

    Una versió de Manfred Schwarb amb una variació més elaborada de
    l'anterior:

    ::

        strip_leading_zero2 () # Elimina els possibles zeros inicials de manera que
        {                      # Bash no els interpreti com a valors en octal.
          shopt -s extglob     # Activa l'expansió (globbing) estesa.
          local val=${1##+(0)} # Guarda a la variable local val el resultat d'eliminar els 0's inicials.
          shopt -u extglob     # Desactiva l'expansió estesa.
          _strip_leading_zero2=${val:-0}
                               # En cas que l'entrada fos 0, retorna un 0 en comptes de "".
        }

    Un altre exemple d'ús:

    ::

        echo `basename $PWD`        # Nom del directori de treball actual (incloent el camí absolut).
        echo "${PWD##*/}"           # Nom del directori de treball actual (només el nom)
        echo
        echo `basename $0`          # Nom del script.
        echo $0                     # Nom del script.
        echo "${0##*/}"             # Nom del script.
        echo
        nomfitxer=test.data
        echo "${nomfitxer##*.}"      # dades
                                    # Extensió del fitxer nomfitxer.

``${var%Pattern}``, ``${var%%Pattern}``

    **${var%Pattern}** elimina de ``$var`` la part *més curta* del patró
    ``$Pattern`` que coincideixi amb la ``part final`` de ``$var``.

    **${var%%Pattern}** elimina de ``$var`` la part *més llarga* de
    ``$Pattern`` que coincideixi amb la ``part final`` de ``$var``.

La `versió 2 <http://tldp.org/LDP/abs/html/bashver2.html#BASH2REF>`_ de
Bash va afegir noves opcions.

**Exemple 10-10. Patrons a la substitució de paràmetres**

::

    #!/bin/bash
    # patt-matching.sh

    # Patrons fent servir els operadors de substitució de paràmetres  # ## % %% .

    var1=abcd12345abc6789
    pattern1=a*c  # * (comodí) coincideix amb qualsevol cosa entre a - c.

    echo
    echo "var1 = $var1"           # abcd12345abc6789
    echo "var1 = ${var1}"         # abcd12345abc6789
                                  # (forma alternativa)
    echo "Nombre de caràcters en ${var1} = ${#var1}"
    echo

    echo "pattern1 = $pattern1"   # a*c  (qualsevol cosa entre 'a' i 'c')
    echo "--------------"
    echo '${var1#$pattern1}  =' "${var1#$pattern1}"    #         d12345abc6789
    # La coincidència més curta possible. Elimina els tres primers caràcters abcd12345abc6789 (NdT. No l'he pogut replicar)
    #                                     ^^^^^               |-|
    echo '${var1##$pattern1} =' "${var1##$pattern1}"   #                  6789
    # La coincidència més llarga possible. Elimina els primers 12 caràcters abcd12345abc6789 (NdT. No l'he pogut replicar)
    #                                    ^^^^^                |----------|

    echo; echo; echo

    pattern2=b*9            # qualsevol cosa entre 'b' i '9'
    echo "var1 = $var1"     # es manté abcd12345abc6789
    echo
    echo "pattern2 = $pattern2"
    echo "--------------"
    echo '${var1%pattern2}  =' "${var1%$pattern2}"     #     abcd12345a
    # La coincidència més curta possible. Elimina els darrers 6 caràcters  abcd12345abc6789
    #                                     ^^^^                         |----|
    echo '${var1%%pattern2} =' "${var1%%$pattern2}"    #     a
    # La coincidència més llarga possible. Elimina els darrers 12 caràcters  abcd12345abc6789
    #                                    ^^^^                 |-------------|

    # Recordem, # i ## actuen d'esquerra a dreta (des de l'inici) de la cadena,
    #           % i %% actuen de dreta a esquerra (des del final) de la cadena.

    echo

    exit 0

**Exemple 10-11. Canvi d'extensió d'un fitxer:**

::

    #!/bin/bash
    # rfe.sh: Canvi d'extensió d'un fitxer
    #
    #         rfe extensio_anterior extensio_nova
    #
    # Exemple:
    # per canviar tots els *.gif del directori actual per *.jpg,
    #          rfe gif jpg


    E_BADARGS=65

    case $# in
      0|1)             # Aquí la barra vertical significa disjunció "o" ("or").
      echo "Ús: `basename $0` sufix_antic sufix_nou"
      exit $E_BADARGS  # En cas de 0 o 1 arguments.
      ;;
    esac


    for nomfitxer in *.$1
    # Ordre invers de la llista de fitxers, tot començant amb el primer argument.
    do
      mv $nomfitxer ${nomfitxer%$1}$2
      #  Elimina la part del fitxer que coincideixi amb el primer argument, i
      #+ a continuació afegeix el segon argument.
    done

    exit 0

**Expansió de variables / substitució de substrings**

    Les següents funcions van ser adoptades del *ksh*.

``${var:pos}``
    Variable ``var`` expandida, començant des de la posició ``pos``.

``${var:pos:len}``
    Expansió de ``len`` caràcters de la variable ``var`` començant des
    de la posició ``pos``. A l'`Exemple
    A-13 <http://tldp.org/LDP/abs/html/contributed-scripts.html#PW>`_ es
    troba un exemple (creatiu) d'ús d'aquest operador.

``${var/Patró/Substitució}``
    Substitueix la primera aparició del ``Patró``, a la variable ``var``
    per ``Substitució``.

    En cas que no s'especifiqui ``Substitució``, la primera ocurrència
    de ``Patró`` es substitueix per *no res*. És a dir, elimina aquesta
    part de la variable.

``${var//Patró/Substitució}``
    **Substitució global.** Substitueix totes les aparicions de
    ``Patró`` de la variable ``var`` per ``Substitució``.

    Com abans, si no s'especifica ``Substitució`` es substitueixen totes
    les ocurrències de ``Patró`` per *no res*. És a dir, són eliminades.

    **Exemple 10-12. Anàlisi de strings arbitraris**

    ::

        empty string.
        #!/bin/bash

        var1=abcd-1234-defg
        echo "var1 = $var1"

        t=${var1#*-*}
        echo "var1 (un cop eliminat la part inicial fins al primer - ) = $t"
        #  t=${var1#*-}  el string buit fa exactament el mateix,
        #+ donat que # coincideix amb el string més curt,
        #+ i * coincideix amb qualsevol cosa (incloent res) que precedeixi el string buit.
        # (Agraïment per Stephane Chazelas)

        t=${var1##*-*}
        echo "si var1 conté un  \"-\" retornarà la cadena buida...   var1 = $t"


        t=${var1%*-*}
        echo "var1 (un cop eliminat el contingut des del darrer - fins al final) = $t"

        echo

        # -------------------------------------------
        path_name=/home/bozo/ideas/thoughts.for.today
        # -------------------------------------------
        echo "path_name = $path_name"
        t=${path_name##/*/}
        echo "path_name un cop eliminat els prefixos = $t"
        # En aquest cas, ofereix el mateix resultat que t=`basename $path_name`.
        #  t=${path_name%/}; t=${t##*/}   és una solució més general,
        #+ però encara falla de vegades.
        #  En cas que $path_name acabi amb salt de línia, no funcionarà `basename $path_name`,
        #+ mentre que l'expressió anterior continuarà funcionant.
        # (Gràcies  S.C.)

        t=${path_name%/*.*}
        # El mateix resultat que t=`dirname $path_name`
        echo "path_name, sense l'extensió= $t"
        # Fallarà en alguns casos, com ara amb "../", "/foo////", # "foo/", "/".
        #  L'eliminació de sufixos es complica especialment quan el nom base no té extensió
        #+ però el directori que el conté sí que en té.
        # (Agraïment per S.C.)

        echo

        t=${path_name:11}
        echo "$path_name sense els primers 11 caràcters = $t"
        t=${path_name:11:5}
        echo "$path_name sense els primers 11 caràcters i amb 5 de longitud = $t"

        echo

        t=${path_name/bozo/clown}
        echo "$path_name on \"bozo\" ha estat substituït per \"clown\" = $t"
        t=${path_name/today/}
        echo "$path_name on \"today\" ha estat eliminat = $t"
        t=${path_name//o/O}
        echo "$path_name on s'ha passat totes les "o" a majúscules = $t"
        t=${path_name//o/}
        echo "$path_name sense cap "o" = $t"

        exit 0

``${var/#Patró/Substitució}``
    Quan l'*inici* de ``var`` coincideix amb ``Patró``, llavors
    ``Substitució`` apareix en comptes de ``Patró``.

``${var/%Patró/Substitució}``
    Quan el *final* de ``var`` coincideix amb ``Patró``, llavors
    ``Substitució`` apareix en comptes de ``Patró``.

    **Exemple 10-13. Coincidència de patrons a l'inici o al final d'un
    string**

    ::

        #!/bin/bash
        # var-match.sh:
        # Demostració de la substitució del patró a l'inici/final d'un string.

        v0=abc1234zip1234abc    # Variable original.
        echo "v0 = $v0"         # abc1234zip1234abc
        echo

        # Coincideix amb l'inici del string.
        v1=${v0/#abc/ABCDEF}    # abc1234zip1234abc
                                # |-|
        echo "v1 = $v1"         # ABCDEF1234zip1234abc
                                # |----|

        # Coincideix amb el final del string.
        v2=${v0/%abc/ABCDEF}    # abc1234zip123abc
                                #              |-|
        echo "v2 = $v2"         # abc1234zip1234ABCDEF
                                #               |----|

        echo

        #  ----------------------------------------------------
        #  Cal que coincideixi extactament amb l'inici/final del string.
        #+ Altrament no es realitza cap canvi.
        #  ----------------------------------------------------
        v3=${v0/#123/000}       # Coincideix però no amb l'inici.
        echo "v3 = $v3"         # abc1234zip1234abc
                                # CAP CANVI.
        v4=${v0/%123/000}       # Coincideix però no amb el final.
        echo "v4 = $v4"         # abc1234zip1234abc
                                # CAP CANVI.

        exit 0

``${!varprefix*}``, ``${!varprefix@}``
    Coincideix amb els *noms* de totes les variables declarades que
    comencen per ``varprefix``.

    ::

        # Es tracta d'una variació d'una referència directa que fa servir  * o @.
        # Aquesta funcionalitat està disponible en Bash des de la versió 2.04.

        xyz23=elquesigui
        xyz24=

        a=${!xyz*}         #  Expandeix als *noms* de les variables declarades
        # ^ ^   ^           + que comencen per "xyz".
        echo "a = $a"      #  a = xyz23 xyz24
        a=${!xyz@}         #  Com abans.
        echo "a = $a"      #  a = xyz23 xyz24

        echo "---"

        abc23=algunaaltracosa
        b=${!abc*}
        echo "b = $b"      #  b = abc23
        c=${!b}            #  Aquesta és la manera més habitual de fer una referència indirecta.
        echo $c            #  una_altra_cosa

Notes
~~~~~

`[1] <http://blamitec.wordpress.com/2011/04/13/abs-guide-10-2-substitucio-de-parametres>`_

Quan a un script no interactiu $parametre és null, l'execució finalitza
amb codi de sortida
`127 <http://tldp.org/LDP/abs/html/exitcodes.html#EXITCODESREF>`_ (codi
d'error de Bash que indica "No es troba la comanda").

