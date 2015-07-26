#!/bin/bash

# Demostració d'assignació elegant de valors

a=23                # Cas simple
echo $a             # Sortida: 23
b=$a
echo $b             # Sortida: 23

# Ara una assignació una mica més "elegant" (substitució de comanda).

a=`echo Hello!`     # Assigna el resultat de la comanda
echo $a             # Sortida: Hello!
#  Fixat que des de la línia de comandes no funcionaria incloure l'exclamació en
#+ una substitució de comandes, doncs arrencaria el mecanisme d'historial de
#+ Bash. Aquí funciona perquè dins d'un guió, el historial queda desabilitat per
#+ defecte.

a=`ls -l /`         # Assignem ara el resultat de llistar el contingut de l'arrel
# Si el mostrem sense cometes, s'eliminen espais en blanc.
echo $a             # Sortida: total 112 drwxr-xr-x 2 root root 4096 jun 22 20:43 bin ...
echo
# En canvi, amb cometes es preserva la informació d'espais en blanc.
echo "$a"           # Sortida: total 112
                    #          drwxr-xr-x   2 root root  4096 jun 22 20:43 bin
                    #          drwxr-xr-x   3 root root  4096 jun 22 20:46 boot
                    # ...

a=$(ls -l /)        # Equivalent a l'assignació anterior
echo "$a"

exit 0
