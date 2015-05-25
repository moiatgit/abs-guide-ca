`Inici <index.ca.html>`_ :  Guia avançada de Bash-Scripting

`Anterior <recurnolocvar.html>`_ : Recursion Without Local Variables

`Següent <list-cons.html>`_ : List Constructs

--------------

Capítol 25. Àlies
=================

En Bash, un *àlies* no és més que una drecera de teclat, una
abreviació, una manera d'evitar escriure una seqüència llarga de
comandes. Si, per exemple, incloem **alias lm="ls -l \| more"** en el
fitxer ` ~/.bashrc <sample-bashrc.html>`_, cada cop que escrivim
``lm`` a la línia de comandes `[1] <aliases.html#FTN.AEN18532>`_,
automàticament serà reemplaçat per la comanda **ls -l \| more**.

Tot plegat, podem estalviar-nos escriure un munt a la línia de
comandes i evitar-nos haver de recordar combinacions complexes de
comandes i opcions.

Un altre exemple, si definim l'àlies **alias rm="rm -i"**, podem
evitar-nos molts problemes esborrant accidentalment fitxers
importants, donat que sempre que fem servir **rm** (comanda per
eliminar fitxers), ens demanarà confirmació en comptes d'eliminar els
fitxers directament.

Dins d'un guió, els àlies no tenen gaire utilitat. Fora bo que els
àlies disposessin de part de la funcionalitat del preprocessador de C,
com ara l'expansió de macros. Malauradament Bash no és capaç
d'expandir arguments dins del cos d'un àlies.  `[2]
<aliases.html#FTN.AEN18539>`_ És més, dins d'un guió no es pot ni
expandir un àlies dins d'una "sentència composta" com ara les
sentències `if/then <tests.html#IFTHEN>`_, els bucles, i les funcions.
Una altra limitació és que els àlies no s'expandeixen recursivament.
Quasi sempre, tot el que es pugui aconseguir amb un àlies, ho podrem
realitzar molt més efectivament amb una `funció
<functions.html#FUNCTIONREF>`_.

**Exemple 25-1. Àlies dins d'un guió**

::

    #!/bin/bash
    # alias.sh

    # Cal executar la següent opció per a poder expandir els àlies
    shopt -s expand_aliases


    # Una mica d'humor per començar
    alias Jesse_James='echo "\"Alias Jesse James\" va ser una comedia del 1959 protagonitzada per Bob Hope."'
    Jesse_James

    echo; echo; echo;

    # Podem fer servir tant cometes dobles com simples a l'hora de definir un àlies
    alias ll="ls -l"

    echo "Provant el nou àlies \"ll\":"
    ll /etc/pa*   #* L'àlies funciona!

    echo

    directori=/etc/
    prefix=pa*  # Comprovem si el comodín causa problemes
    echo "Variables \"directori\" + \"prefix\" = $directori$prefix"
    echo

    alias lll="ls -l $directori$prefix"

    echo "Provant l'àlies \"lll\":"
    lll         # Resultarà en la llista de fitxers a /etc/ que continguin
                # pa* o bé que estiguin en un subdirectori que comenci amb pa*

    # Comprovat: un àlies pot gestionar variables concatenades, incloent comodins.




    TRUE=1

    echo

    if [ TRUE ]
    then
        alias rr="ls -l"
        echo "Provant l'àlies \"rr\" dins d'un bloc if/then:"
        rr /etc/pa*   #* Apareix un missatge d'error de comanda no trobada!
        # És a dir, els àlies no s'expandeixen dins de sentències compostes.
        echo "En canvi, els àlies definits fora del bloc sí que són reconeguts:"
        ll /etc/pa*
    fi

    echo

    comptador=0
    while [ $comptador -lt 3 ]
    do
        alias rrr="ls -l"
        echo "Provant l'àlies \"rrr\" dins d'un bucle \"while\":"
        rrr /etc/pa*    #* Aquí tampoc no s'expandirà l'àlies.
                        # Es mostrarà l'error de comanda no trobada!
        let comptador+=1
    done 

    echo; echo

    alias xyz='cat $0'  # Mostra el codi d'aquest guió.
                        # Atenció a les cometes simples.
    xyz
    #  Sembla que funciona,
    #+ malgrat la documentació de Bash suggereix que no hauria de fer-ho.
    #
    #  Amb tot, tal i com Steve Jacobson indica,
    #+ el paràmetre "$0" s'expandeix immediàtament en el moment de la declaració de l'àlies.

    exit 0


La comanda **unalias** elimina els àlies prèviament definits amb
**alias**.

**Exemple 25-2. *unalias*: assignant i desassignant un àlies**

::

    #!/bin/bash
    # unalias.sh

    shopt -s expand_aliases  # Permet l'expansió d'àlies.

    alias llm='ls -al | more'
    llm

    echo

    unalias llm              # desassigna l'àlies.
    llm
    # Ara genera un error perquè 'llm' ja no està reconegut.

    exit 0


::

    bash$ ./unalias.sh
    total 6
    drwxrwxr-x    2 bozo     bozo         3072 Feb  6 14:04 .
    drwxr-xr-x   40 bozo     bozo         2048 Feb  6 14:04 ..
    -rwxr-xr-x    1 bozo     bozo          199 Feb  6 14:04 unalias.sh

    ./unalias.sh: line 12: llm: no s'ha trobat l'ordre

Anotacions
----------

`[1] <aliases.html#AEN18532>`_

... Com a primera paraula d'una comanda. Evidentment, un àlies només
té sentit a l'inici d'una comanda.

`[2] <aliases.html#AEN18539>`_

No obstant, els àlies semblen expandir paràmetres posicionals.

--------------

`Inici <index.ca.html>`_ :  Guia avançada de Bash-Scripting

`Anterior <recurnolocvar.html>`_ : Recursion Without Local Variables

`Següent <list-cons.html>`_ : List Constructs


