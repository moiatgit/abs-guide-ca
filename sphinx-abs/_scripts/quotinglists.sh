# Demostració de l'ús de les cometes dobles per preservar espais en blanc
Llista="un dos tres"

for a in $Llista     # Cada paraula separada per espais en blanc.
do
    echo "$a"
done
# Sortida:
#   un
#   dos
#   tres

echo "---"

for a in "$Llista"   # Considera els espais en blanc com part de la paraula.
do #     ^     ^
    echo "$a"
done
# Sortida: un dos tres

