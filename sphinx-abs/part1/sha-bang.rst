########################
Comencem amb el Sha-Bang
########################

    *Shell programming is a 1950s juke box . . .*

    -- Larry Wall

En el cas més simple, un guió no és més que una llista de comandes del
sistema emmagatzemades a un fitxer de text. I ja això és útil, si més
no per evitar-nos teclejar una i altra vegada la mateixa seqüència de
comandes.


**Exemple 1. *cleanup*: Un script per netejar els fitxers de log de
/var/log**

.. literalinclude:: _scripts/cleanup.sh
   :language: bash
   :linenos:

No hi ha res inusual aquí. Es tracta d'una seqüència de
comandes que podrien haver estat invocades una darrera de l'altre des
de la línia de comandes en una consola o terminal.
Els avantatges de col·locar aquestes comandes en un guió van més enllà
de simplement no haver de tornar a reescriure-les. El guió es
converteix en un *programa*, una *eina*, i com a tal, pot ser
fàcilment modificada o adaptada a requeriments particulars.

**Exemple 2. *cleanup*: versió millorada del guió de neteja.**

.. literalinclude:: _scripts/cleanup2.sh
   :language: bash
   :linenos:

Ara si que comença a semblar un guió real! Però encara podem anar-hi
més lluny...

**Exemple 3. *cleanup*: Una versió ampliada i generalitzada dels
guions anteriors.**

.. literalinclude:: _scripts/cleanup3.sh
   :language: bash
   :linenos:


Donat que podria ser que no ens interessés eliminar el log de sistema
completament, aquesta versió del guió conserva la darrera secció dels
missatges de log.
Constantment descobrirem maneres d'ajustar els nostres guions per
millorar l'efectivitat.

-----

El *sha-bang* ( #!) [#sha-bang]_
a l'inici d'un fitxer permet al sistema saber que el contingut d'aquest fitxer ha de ser processat per un determinat intèrpret.
De fet, #! és un *número màgic* de dos bytes [#omesdedos]_, una marca especial que
designa el tipus de fitxer. En aquest cas indica que és un executable.
Trobaràs més informació sobre aquest fascinant tema escrivint ``man magic``
a la teva consola.
Tot just després del *sha-bang* apareix el programa que
interpreta el contingut del fitxer, ja sigui comandes de la shell,
d'un altre llenguatge de programació (ex. Python) o qualsevol altra
utilitat.
El que apareix a continuació del *sha-bang* és interpretat per a aquest
programa [#elprimer]_.

Considera les següents capçaleres:

.. code-block:: sh

    #!/bin/sh
    #!/bin/bash
    #!/usr/bin/perl
    #!/usr/bin/tcl
    #!/bin/sed -f
    #!/bin/awk -f

Cadascuna d'aquestes línies defineixen un intèrpret diferent per
processar el contingut del fitxer. [#cutetrick]_


``/bin/sh`` és generalment la shell per defecte en la majoria de les
variants comercials de UNIX (no així en sistemes Linux que fan servir
**bash**). Si ens interessa molt la portabilitat en màquines no Linux,
podem fer servir sh, tot i que sacrificarem les característiques
específiques de Bash. Amb tot, un guió que s'executi amb sh respectarà
l'estàndard POSIX [#posixstandard]_. Per més informació, mira
:doc:`/part5/portabilityissues` i :doc:`/part5/gotchas`.


Fixat que el camí que s'indica al sha-bang ha de ser correcte,
altrament generarà un missatge d'error (normalment *No es troba
la comanda*) com a única resposta d'executar el guió [#envline].

Si el nostre guió consisteix únicament en una llista de comandes i no
inclou cap directiva interna de la shell (com ara una assignació a una
variable de l'estil ``linies=50``), podem ometre #!.
De fet, si Bash és la teva shell per defecte, #! no és en realitat
necessària a l'inici del guió. Amb tot, la necessitaràs si finalment
et cal executar el guió des d'alguna altra shell com ara *tcsh*.

.. note::

   En aquest llibre, se't proposa que construeixis els teus guions de
   manera modular.
   Guarda peces de codi que creguis que poden ser-te d'utilitat en el
   futur. Amb el temps, disposaràs d'una biblioteca extensa
   d'utilitats. Per exemple, considera el següent guió que comprova si
   ha estat cridat amb un cert nombre d'arguments:

   .. literalinclude:: _scripts/testargs.sh
       :language: bash
       :linenos:

.. rubric:: Notes

.. [#sha-bang] En la literatura es sol trobar com *she-bang* o
   *sh-bang*.  El nom està format per les inicials dels mots amb els
   que sovint s'anomenen els símbols que el composen: *sharp* (#) i
   *bang* (!).

.. [#omesdedos] Algunes versions de UNIX (aquelles basades en 4.2 BSD)
   suposadament prenen un nombre màgic de quatre bytes, en requerir un
   espai en blanc després de l'exclamació (*bang*). Per exemple ``#!
   /bin/sh``. Probablement no sigui més que un mite segons `Sven
   Mascheck
   <http://www.in-ulm.de/~mascheck/various/shebang/#details>`_.

.. [#elprimer] El *sha-bang* en un guió de shell serà la primera
   línia que veurà l'intèrpret de comandes (*sh* o *bash* per
   exemple).  Donat que la línia comença amb  #, serà interpretat
   correctament com un comentari. La línia ja haurà fet la seva feina,
   permetent escollir l'intèrpret.

   De fet, si el guió inclou una línia extra amb #!, **bash** la
   interpretarà com un comentari.

   .. literalinclude:: _scripts/extrashabang.sh
       :language: bash
       :linenos:

.. [#cutetrick] El sha-bang permet fer alguns trucs interessants, com per exemple:

   .. literalinclude:: _scripts/selfdeleting.sh
       :language: bash
       :linenos:

   També pots intentar afegir a un fitxer de text, com ara ``README``,
   el sha-bang ``#!/bin/more`` i donar-li permissos d'execució.
   El resultat és un fitxer de documentació que s'auto llista.

.. [#posixstandard] (P)ortable (O)perating (S)ystem (I)nterface
   (POSIX) és un intent d'estandardització dels sistemes operatius
   "tipus" UNIX. Les especificacions POSIX apareixen llistades a la
   `web del Open Group
   <http://www.opengroup.org/onlinepubs/007904975/toc.htm>`_.

.. [#envline] Per evitar aquests problemes, els guions poden començar
   amb ``#!/bin/env bash``. En el cas de les màquines UNIX, això pot
   ser especialment útil, donat que *bash* no es troba a ``/bin``

