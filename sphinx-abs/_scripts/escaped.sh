#!/bin/bash
# Demostració de caràcters escapats

### Comencem veient uns exemples bàsics d'escapament de caràcters

# Escapem un salt de línia

echo ""

echo "Aquest text es mostrarà
en dues línies."
# Sortida: Aquest text es mostrarà
#          en dues línies.

echo "Aquest text es mostrarà \
en una única línia."
# Sortida: Aquest text es mostrarà en una única línia.

echo; echo

echo "============="


echo "a\ve\vi\vo\vu"     # Sortida: a\ve\vi\vo\vu
# Amb l'opció -e, la comanda echo mostrarà els caràcters escapats.
echo "Tabulació vertical"
echo -e "a\ve\vi\vo\vu"   # Sortida:    a
                          #                 e
                          #                     i
                          #                         o
                          #                             u


echo "Cometes dobles"
echo -e "\042aeiou\042"       # Sortida: "aeiou"

# Amb $'\X' no cal l'opció -e

echo; echo "Salt de línia i (potser) PIIIP"
echo $'\n'           # Nova línia
echo $'\a'           # Alerta (PIIP).
# Depenent del terminal, pot no fer soroll sinó un parpadeig.

# Hem vist l'expansió $'\xxx'. Ara...

# La versió 2 de Bash va introduir l'expansió de cadenes de text $'\nnn'.
echo "Introducció de l'expansió de cadenes amb \$\' ... \' ..."
echo "... que inclou més marques de cometes."

echo $'a\t \042 \tz'   # Sortida: a    "   z
# Atenció: '\xxx' és un valor octal

# També funciona amb valors hexadecimals amb $'\xhhh'.
echo $'a\t \x22 \tz'  # Sortida: a    "   z

echo


# Assignació d'un caràcter ASCII a una variable.
cometes=$'\042'        # " ara $cometes val "
echo $cometes text entre cometes $cometes i fora de les cometes.

echo

# Concatenació de caràcters ASCII en una variable.
triple_subratllat=$'\137\137\137'  # 137 és el valor octal del caràcter ASCII _
echo "$triple_subratllat SUBRATLLAT $triple_subratllat"

echo

ABC=$'\101\102\103\010'      # 101, 102, 103 són els valors en octal dels caràcters A, B i C.
echo $ABC

echo

escape=$'\033'               # 033 és el valor octal pel caràcter d'escape (tecla ESC)
echo "\"escape\" mostrat com $escape"
# Sortida: "escape" mostrat com 
#                               ^ en el teu terminal segurament es mostra amb un
#                               símbol "raro"

echo

exit 0




