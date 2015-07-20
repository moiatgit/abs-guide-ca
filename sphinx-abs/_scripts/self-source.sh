#!/bin/bash

# Aquest guió es carrega a si mateix de manera recursiva

LIMIT_COMPTADOR=100    # Valor màxim del comptador

echo -n  "$comptador  "
#  A la primera execució, la comanda anterior només mostra dos espais en blanc.
#+ donat que la variable $comptador encara no ha estat inicialitzada.

let "comptador += 1"
#  Assumeix que la variable $comptador pot ser incrementada encara que 
#+ estigui sense inicialitzar la primera vegada.
#  Això funcionarà amb Bash i pdksh, però es basa en un comportament no 
#+ portable, i probablement perillós.
#  És preferible inicialitzar $comptador a 0 abans d'incrementar.

while [ "$comptador" -le $LIMIT_COMPTADOR ]
do
    . $0   # Torna a carregar aquest mateix guió, en comptes de cridar-se a si mateix.
    # ./$0 (que seria recursivitat real) no funciona aquí. Saps per què?
done

#  El que passa aquí no és una recursivitat real. Per contra, el guió
#  s'espandeix a si mateix, és a dir, genera una nova secció de codi per cada
#  iteració del bucle while.
#
#  La primera línia amb el sha-bang només és interpretada com a tal el primer
#  cop. La resta es consideren simplement comentaris.

echo

exit 0   # El resultat final és comptar del 1 al 100.
# Impressionant!

# Exercici: Escriu un guió que faci servir aquest truc, però que faci alguna cosa
# útil.

