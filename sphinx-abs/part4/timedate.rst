###########################
XXX Comandes de data i hora
###########################

En aquesta secció estudiarem les comandes time, date i el càlcul de
temps.

**date**
    Invocant-la directament, **date** escriu la data i l'hora a la
    sortida estàndard (``stdout``). Aquesta comanda es torna més
    interessant quan es fan servir les opcions de formatat i anàlisi.

    **Exemple 16-10. Ús de *date***

    ::

        #!/bin/bash
        # Ús de la comanda 'date'

        echo "El nombre de dies des de l'inici de l'any és `date +%j`."
        # Cal un '+' per invocar el formatat.
        # %j retorna el dia de l'any.

        echo "El nombre de segons que ha passat des de 01/01/1970 és `date +%s`."
        #  %s genera el nombre de segons des de que va començar l' "UNIX epoch",
        #+ Però, de què ens pot servir això?

        prefix=temp
        suffix=$(date +%s)  # L'opció "+%s" de 'date' és específica de GNU.
        filename=$prefix.$suffix
        echo "Nom de fitxer temporal = $filename"
        #  És perfecte per crear fitxers temporals amb noms "únics i aleatoris",
        #+ fins i tot millor que fer servir $$.

        # Llegiu la pàgina man de 'date' per a conèixer més opcions de formatat.

        exit 0

    L'opció ``-u`` retorna l' UTC o Temps Universal Coordinat (Universal
    Coordinated Time).

    ::

        bash$ date
        Fri Mar 29 21:07:39 MST 2002



        bash$ date -u
        Sat Mar 30 04:07:42 UTC 2002


    Aquesta opció facilita el càlcul del temps entre diferents dates.

    **Exemple 16-11. Càlculs amb *Date***

    ::

        #!/bin/bash
        # date-calc.sh
        # Autor: Nathan Coulter

        MPHR=60    # Minuts per hora.
        HPD=24     # Hores per dia.

        diff () {
                printf '%s' $(( $(date -u -d"$TARGET" +%s) -
                                $(date -u -d"$CURRENT" +%s)))
        #                       %d = dia del mes
        }


        CURRENT=$(date -u -d '2007-09-01 17:30:24' '+%F %T.%N %Z')
        TARGET=$(date -u -d'2007-12-25 12:30:00' '+%F %T.%N %Z')
        # %F = data completa, %T = %H:%M:%S, %N = nanosegons, %Z = zona horària.

        printf '\nEl %s de 2007 ' \
               "$(date -d"$CURRENT +
                $(( $(diff) /$MPHR /$MPHR /$HPD / 2 )) days" '+%d %B')"
        #       %B = nom del mes                ^ mig camí
        printf 'estava a mig camí entre  %s ' "$(date -d"$CURRENT" '+%d %B')"
        printf 'i %s\n' "$(date -d"$TARGET" '+%d %B')"

        printf '\nEl %s a les %s hi quedaven\n' \
                $(date -u -d"$CURRENT" +%F) $(date -u -d"$CURRENT" +%T)
        DAYS=$(( $(diff) / $MPHR / $MPHR / $HPD ))
        CURRENT=$(date -d"$CURRENT +$DAYS days" '+%F %T.%N %Z')
        HOURS=$(( $(diff) / $MPHR / $MPHR ))
        CURRENT=$(date -d"$CURRENT +$HOURS hours" '+%F %T.%N %Z')
        MINUTES=$(( $(diff) / $MPHR ))
        CURRENT=$(date -d"$CURRENT +$MINUTES minutes" '+%F %T.%N %Z')
        printf '%s dies, %s hores, ' "$DAYS" "$HOURS"
        printf '%s minuts, i %s segons ' "$MINUTES" "$(diff)"
        printf 'fins el dinar de Nadal!\n\n'

        #  Exercici:
        #  --------
        #  Reescriu la funció diff () de manera que accepti paràmetres en comptes de variables globals.
        #+ NdT. Realitza els canvis que calguin per mostrar l'article davant els noms dels mesos.

    La comanda *date* disposa d'un bon nombre d'opcions de sortida
    (*output*). Per exemple ``%N`` retorna la part dels nanosegons del
    temps actual. Això pot ser útil, per exemple, per generar d'enters
    aleatoris.

    ::

        date +%N | sed -e 's/000$//' -e 's/^0//'
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        #  Elimina els zeros que hi puguin haver a l'inici i al final.
        #  La longitud de l'enter generat depèn de
        #+ quants zeros s'hagin eliminat.,

        # 115281032
        # 63408725
        # 394504284

    Hi ha moltes altres opcions (mira **man date**).

    ::

        date +%j
        # Mostra el dia de l'any (dies que han passat des del 1 de gener).

        date +%k%M
        # Mostra l'hora i el minut en format 24-hores en un únic string.



        # El paràmetre 'TZ' permet reemplaçar la zona horària per defecte.
        date                 # Mon Mar 28 21:42:16 MST 2005
        TZ=EST date          # Mon Mar 28 23:42:16 EST 2005



        FaSisDies=$(date --date='6 days ago')
        FaUnMes=$(date --date='1 month ago')  # Quatre setmanes abans (no un mes!)
        FaUnAny=$(date --date='1 year ago')

    Mira també l' `Exemple 3-4 <special-chars.ca.html#EX58>`_ i `Exemple
    A-43 <contributed-scripts.ca.html#STOPWATCH>`_.

**zdump**
    Mostra el temps en la zona horària que se li especifiqui.

    ::

        bash$ zdump EST
        EST  Tue Sep 18 22:09:22 2001 EST

**time**
    Mostra estadístiques detallades de temps de l'execució d'una
    comanda.

    ``time ls -l /`` retorna quelcom similar a:

    ::

        real    0m0.067s
         user    0m0.004s
         sys     0m0.005s

    Mira també a la secció anterior la comanda (molt semblant)
    `times <x9445.ca.html#TIMESREF>`_.

    *Atenció*: Des de la `versió 2.0 <bashver2.ca.html#BASH2REF>`_ de
    Bash, **time** és una paraula reservada. Presenta un comportament
    lleugerament diferent amb pipelines.

**touch**
    Utilitat que modifica els temps de darrera modificació i accés d'un
    fitxer al temps del sistema o bé a un d'especificat. També és útil
    per a crear un nou fitxer. La comanda ``touch zzz`` crea un nou
    fitxer de longitud zero, amb el nom ``zzz`` sempre, és clar, que no
    existeixi ja ``zzz``. És útil deixar marques de temps d'aquesta
    manera en fitxers buits de manera que es pugui fer seguiment dels
    moments de modificació d'un projecte.

    *Atenció*: La comanda **touch** equival a ``: >> newfile`` o ``>>
    newfile`` (en el cas de fitxers ordinaris).

    *Truc*: Abans de fer `cp -u <basic.ca.html#CPREF>`_ (*copia /
    actualitza*), fes servir **touch** per a actualitzar la marca de
    temps d'aquells fitxers que no vulguis sobreescriure.

    Per exemple, si el directori ``/home/bozo/tax_audit`` conté els
    fitxers ``calculs-051606.data``, ``calculs-051706.data``, i
    ``calculs-051806.data``, llavors fent un **touch calculs\*.data**
    protegirà aquests fitxers de ser sobreescrits per fitxers amb el
    mateix nom durant l'execució de **cp -u
    /home/bozo/financial\_info/calculs\*data /home/bozo/tax\_audit**.

**at**
    La comanda de control de treballs **at** executa un conjunt de
    comandes donat en el moment especificat. Recorda al
    `cron <system.ca.html#CRONREF>`_ però **at** és realment útil quan
    volem executar un únic cop un conjunt de comandes.

    ``at 2pm January 15`` demana per un conjunt de comandes a ser
    executades en el moment indicat. Aquestes comandes han de ser
    compatibles amb shell-script donat que, a efectes pràctics, l'usuari
    està escrivint un script de shell línia a línia. L'entrada finalitza
    amb `Ctl-D <special-chars.ca.html#CTLDREF>`_.

    **at** llegeix la llista de comandes des d'un fitxer tant indicant
    l'opció ``-f`` com redireccionant l'entrada (<), El fitxer contindrà
    un shell script tot qualsevol, per suposat sempre i quant no sigui
    interactiu. Resulta particularment adequat incloure la comanda
    `run-parts <extmisc.ca.html#RUNPARTSREF>`_ al fitxer per a executar un
    conjunt diferent de scripts.

    ::

        bash$ at 2:30 am Friday < at-jobs.list
        job 2 at 2000-10-27 02:30


**batch**
    La comanda de control de treballs **batch** és similar a **at**, Es
    diferencia del segon en que executa la llista de comandes quan la
    càrrega del sistema cau per sota de ``.8``. Al igual que **at**, pot
    llegir comandes d'un fitxer amb l'opció ``-f``.

    El concepte de processament en segon pla o *batch processing* data
    de l'era de les computadores mainframe. Vol dir, executar un conjunt
    de comandes sense intervenció de l'usuari.

**cal**
    Mostra un calendari ben formatat per sortida estàndard (
    ``stdout``). Funciona tant per l'any actual com per un ampli rang
    d'anys al passat i al futur,

**sleep**
    És l'equivalent per la shell d'un *bucle d'espera*. Es queda en
    pausa durant el nombre especificat de segons sense fer res. Pot ser
    útil per calcular temps i també en processos que s'executen en segon
    pla comprovant un esdeveniment amb certa freqüència (polling), com
    ara a l'`Exemple 31-6 <debugging.ca.html#ONLINE>`_.

    ::

        sleep 3     # Pausa 3 segons.

    *Atenció*: Per defecte la comanda **sleep** funciona amb segons,
    però es pot especificar també minuts, hores o dies.

    ::

        sleep 3 h   # Pausa 3 hores!


    *Atenció*: La comanda `watch <system.ca.html#WATCHREF>`_ pot ser una
    millor elecció que **sleep** quan el que volem és executar
    comandes cada cert interval de temps.

**usleep**
    *Microsleep* (la *u* es llegeix com la lletra grega *mu*, o el
    prefix *micro-*). És el mateix que **sleep**, però amb intervals de
    microsegons. Pot ser usada per càlcul de temps amb precisió, o bé
    per controlar un procés amb un interval molt freqüent.

    ::

        usleep 30     # Pausa 30 microsegons.

    Aquesta comanda és part dels paquet de Red Hat *initscripts /
    rc-scripts*.

   *Compte!*: La comanda **usleep** no ofereix un càlcul de temps
   particularment precís i , per tant, no és adequada per a bucles on
   el temps sigui crític.

**hwclock**, **clock**
    La comanda **hwclock** accedeix o ajusta el rellotge físic de la
    màquina. Algunes opcions requereixen privilegis de *root*. El fitxer
    d'inici ``/etc/rc.d/rc.sysinit`` fa servir **hwclock** per a
    assignar durant l'arrancada l'hora del sistema a partir del rellotge
    de la màquina.

    La comanda **clock** s'anomena també **hwclock**.

----------


`Inici <index.ca.html>`_ :  Guia avançada de Bash-Scripting

`Amunt <external.ca.html>`_ : Capítol 16. Filtres externs, programes i
comandes

`Anterior <moreadv.ca.html>`_ : Comandes complexes

`Següent <textproc.ca.html>`_ : Comandes de processament de text

