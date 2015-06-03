#############################
XXX Perquè programar en Shell
#############################

    *No programming language is perfect. There is not even a single best
    language; there are only languages well suited or perhaps poorly suited
    for particular purposes.*

    -- Herbert Mayer


Si tens intenció d'administrar sistemes informàtics de manera
mínimament decent, tard o d'hora et caldrà disposar de coneixements de
programació de guions. Fins i tot, si ara ni se t'acut per a què et
pot servir.

Per exemple, quan una màquina GNU/Linux arrenca, executa els guions
que troba a la carpeta ``/etc/rc.d`` per recuperar la configuració del
sistema i arrencar els serveis. És important comprendre el detall
d'aquests guions per a poder analitzar el comportament del sistema i,
si es cau, modificar-lo.

No és massa difícil dominar la programació de guions ja que poden ser
escrits en seccions molt petites i només cal aprendre un conjunt força
reduït d'opcions i operadors que siguin específics de la *shell*
[#builtins]_.

La sintaxi és força simple, hom diria austera, similar a la que fem
servir quan encadenem utilitats en una mateixa línia de la línia de
comandes. A més, hi ha poques "regles" que defineixen el seu ús.

La majoria dels guions breus solen funcionar a la primera i, depurar
guions, fins i tot els més llargs, és trivial.

.. XXX TODO per aquí

.. note::

   Quan van aparèixer els primers ordinadors personals, el llenguatge
   de programació BASIC permetia que qualsevol amb una mica
   d'habilitat amb l'ordinador pogués escriure programes per aquells
   microcomputadors.

   Dècades més tard, el llenguatge de guions Bash permet que qualsevol
   amb un coneixement rudimentari de GNU/Linux (o UNIX), pugui també
   escriure programes en les màquines actuals.

   Ara disposem d'ordinadors miniatura amb capacitats increïbles, com
   ara la `Raspberry Pi <http://www.raspberrypi.org/>`_, i Bash està
   aquí per permetre explorar les possibilitats que ofereixen.

Un guió de shell (o *shell script*) permet realitzar àgilment
prototipus d'aplicacions més complexes.  Sovint és útil disposar d'un
subconjunt limitat de funcionalitats executant-se des d'un guió en les
primeres fases de desenvolupament d'un projecte.  D'aquesta manera, és
possible provar l'estructura de l'aplicació, i arreglar els errors que
es trobin, abans de realitzar la codificació final en llenguatges com
ara *C*, *C++*, *Java*, :doc:`Perl <wrapper>`, o *Python*.

Els guions de shell s'inspiren que la clàssica filosofia UNIX de
dividir tasques complexes en subtasques més simples, per després
encadenar-les juntes de manera que resolguin la tasca complexa.

Hi ha qui considera aquesta manera de resoldre els problemes, millor o
com a mínim més estètica, que la de fer servir llenguatges tot-inclòs
com pot ser *Perl*, que intenten servir per a tot i per a tothom, amb
el cost de forçar a tothom a canviar la manera de pensar per a
adaptar-te a l'eina.

Segons :ref:`Herbert Mayer <HERB89>`, *per què un llenguatge sigui
útil, cal que disposi de cadenes (arrays), punters i algun mecanisme
genèric per crear estructures de dades*. Amb aquests criteris, la
programació en *shell* quedaria una mica per sota de ser "útil". O,
potser no...

Hi ha algunes situacions en les que no voldrem fer servir guions
de shell:

- Amb tasques que requereixin un ús intensiu de recursos, especialment
  quan la velocitat és important, com ara ordenació, càlcul de
  funcions de *hash*, recursivitat [#recursio]_

- Procediments que requereixen operacions matemàtiques molt pesants,
  especialment amb aritmètica de punt flotant, càlculs de precisió
  arbitrària, o nombres complexos. En aquest cas és millor que facis
  servir *C* o *FORTRAN*.

- Quan cal aconseguir portabilitat (és a dir, que el programa funcioni
  en altres plataformes). En aquest cas, fes servir *C* o *Java*.

- Aplicacions complexes on cal una estructura de programa (comprovació
  de tipus de variables, prototipus de funcions, etc.)

- Aplicacions de missió crítica de les que dependrà el futur de la
  teva empresa.

- Situacions en les que la *seguretat* sigui important, en les que
  calgui garantir la integritat del teu sistema i protegir-lo contra
  intrusos, *cracking* i vandalisme.

- Quan el projecte consisteix en subcomponents amb dependències
  entrellaçades.

- Aplicacions que requereixin operacions extensives sobre fitxers.
  *Bash* es limita a l'accés en sèrie d'una manera particularment
  ineficient línia a línia.

- Si es requereix un suport nadiu a matrius (*arrays*
  multidimensionals)

- Quan calen estructures de dades, com ara llistes enllaçades o
  arbres.

- Si cal generar o manipular gràfics o interfícies gràfiques d'usuari.

- Si cal l'accés directe al maquinari del sistema o a perifèrics
  externs.

- Si cal entrada/sortida a través de :doc:`sockets <devref1>`.

- Quan cal fer servir biblioteques o accedir a codi heretat.

- Quan l'aplicació ha de ser de codi tancat, donat que els guions de
  shell mostren el codi obertament llegible per tothom.

Si el teu projecte presenta alguna de les necessitats anteriors,
planteja't fer servir un llenguatge de programació de guions més potent (com ara *Perl*, *Tcl*, *Python*, *Ruby*) o fins i tot algun llenguatge compilat com *C*, *C*, o *Java*. 
Fins i tot en aquests casos és probable que et continuï resultant útil
començant construir prototips de la teva aplicació amb shell script.

XXX PER AQUÍ

We will be using Bash, an acronym `[3] <why-shell.html#FTN.AEN139>`__
for "Bourne-Again shell" and a pun on Stephen Bourne's now classic
*Bourne* shell. Bash has become a *de facto* standard for shell
scripting on most flavors of UNIX. Most of the principles this book
covers apply equally well to scripting with other shells, such as the
*Korn Shell*, from which Bash derives some of its features,
`[4] <why-shell.html#FTN.AEN147>`__ and the *C Shell* and its variants.
(Note that *C Shell* programming is not recommended due to certain
inherent problems, as pointed out in an October, 1993 `Usenet
post <http://www.faqs.org/faqs/unix-faq/shell/csh-whynot/>`__ by Tom
Christiansen.)

What follows is a tutorial on shell scripting. It relies heavily on
examples to illustrate various features of the shell. The example
scripts work -- they've been tested, insofar as possible -- and some of
them are even useful in real life. The reader can play with the actual
working code of the examples in the source archive (``scriptname.sh`` or
``scriptname.bash``), `[5] <why-shell.html#FTN.AEN157>`__ give them
*execute* permission (``chmod u+rx scriptname``), then run them to see
what happens. Should the `source
archive <http://bash.deta.in/abs-guide-latest.tar.bz2>`__ not be
available, then cut-and-paste from the
`HTML <http://www.tldp.org/LDP/abs/abs-guide.html.tar.gz>`__ or
`pdf <http://bash.deta.in/abs-guide.pdf>`__ rendered versions. Be aware
that some of the scripts presented here introduce features before they
are explained, and this may require the reader to temporarily skip ahead
for enlightenment.

Unless otherwise noted, `the author <mailto:thegrendel.abs@gmail.com>`__
of this book wrote the example scripts that follow.


 
    *His countenance was bold and bashed not.* 

    -- Edmund Spenser


.. rubric:: Notes

.. [#builtins] A aquests operadors i funcions que incorpora la *shell*, els coneixem com :doc:`builtins <internal>`.

.. [#recursio] És possible realitzar recursivitat en Bash. Per
   exemple, es factible definir una funció que es crida a si mateixa.
   Sovint, però, el resultat sol executar-se molt lentament i la seva
   implementació queda molt *lletja*.

   Per a més detalls, consulta les seccions on es descriu recursivitat
   :doc:`amb <localvar>` i :doc:`sense <recurnolocvar>` variables
   locals.

.. [3]	An acronym is an ersatz word formed by pasting together the initial letters of the words into a tongue-tripping phrase. This morally corrupt and pernicious practice deserves appropriately severe punishment. Public flogging suggests itself.

.. [4]	Many of the features of ksh88, and even a few from the updated ksh93 have been merged into Bash.

.. [5]	By convention, user-written shell scripts that are Bourne shell compliant generally take a name with a .sh extension. System scripts, such as those found in /etc/rc.d, do not necessarily conform to this nomenclature.
