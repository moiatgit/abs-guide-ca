#!/bin/bash
# Demostració de com mostrar variables "rares"

echo

var="'(]\\{}\$\""           # Inclou cometes dins de cometes!
echo $var        # '(]\{}$"
echo "$var"      # '(]\{}$"     No fa cap diferencia

echo

IFS='\'
echo $var        # '(] {}$"     \ es converteix en un espai. Perquè?
echo "$var"      # '(]\{}$"

echo

var2="\\\\\""
echo $var2       #   "
echo "$var2"     # \\"
echo
# Però en canvi... var2="\\\\"" no és legal. Perquè?

var3='\\\\'
echo "$var3"     # \\\\
# En canvi, si fem cometes fortes sí que funciona.

# El primer exemple demostra que està permés posar cometes dins de cometes.
echo "$(echo '"')"           # "
#    ^           ^

# De vegades pot ser útil
var1="Dues paraules"
echo "\$var1 = "$var1""      # $var1 = Dues paraules
#    ^                ^
