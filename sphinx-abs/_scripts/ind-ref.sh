#!/bin/bash
# ind-ref.sh: Referenciació indirecta de variablesdt.
# Accés al contingut del contingut d'una variable.

#  Unes quantes proves per començar

var=23

echo "\$var   = $var"           # $var   = 23
#  Res que no esperem, de moment.

echo "\$\$var  = $$var"         # $$var  = 4570var
#  \$\$ ens ha retornat el PID del script doncs:
#       $$ és una variable que conté el PID
#       var, en no venir precedida de $ es considera un literal.

echo "\\\$\$var = \$$var"       # \$$var = $23
#  Com és d'esperar, el primer $ es escapat i es mostra com a literal
#+ abans del valor de var ($var = 23 ).

# Anem ara a com s'ha de fer
# ==========================


a=lletra   # La variable "a" conté el nom d'una altra variable
lletra=z

echo

# Referència directa
echo "a = $a"          # a = lletra

# Referència indirecta
eval a=\$$a
# ^^^        Forcem una eval(uació) i
#        ^   escapem el primer $

#  'eval' força actualitzar $a i assigna el resultat actualitzat de \$$a.
#  Per aquesta raó és molt freqüent trobar 'eval' quan es fan referències
#+ indirectes.

echo "ara a = $a"    # ara a = z

echo


# Ara intentarem canviar la segona referència.

t=casella
casella=24
echo "\"casella\" = $casella"            # "casella" = 24
echo -n "derreferència \"t\" = "; eval echo \$$t    # derreferència "t" = 24
# En aquest cas simle, el següent també funciona. Perquè?
#         eval t=\$$t; echo "\"t\" = $t"

echo

t=casella
VALOR_NOU=387
casella=$VALOR_NOU
echo "Canviant el valor de \"casella\" a $VALOR_NOU."
echo "\"casella\" ara $casella"
echo -n "derreferència \"t\" ara "; eval echo \$$t
# 'eval' pren els dos arguments "echo" i "\$$t" (assignat a $casella)

echo

#  Una manera més senzilla és fer servir la notació ${!t} que es veu a la 
#+ secció de "Bash, version 2".

#  Mira també l'exemple ex78.sh.

exit 0







