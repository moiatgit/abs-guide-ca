# Demostració de l'ús de les cometes dobles per preservar espais en blanc

# funció que mostra quantes paraules rep
function compta_arguments () { echo "Paraules rebudes: $# "; }

frase1="una variable amb cinc paraules"
frase2=""    # Buida

compta_arguments Això és $frase1               # Sortida: Paraules rebudes: 7

compta_arguments "Això és $frase1"             # Sortida: Paraules rebudes: 1

compta_arguments $frase2 $frase2 $frase2       # Sortida: Paraules rebudes: 0

compta_arguments "$frase2" "$frase2" "$frase2" # Sortida: Paraules rebudes: 3

compta_arguments "$frase2 $frase2 $frase2"     # Sortida: Paraules rebudes: 1
