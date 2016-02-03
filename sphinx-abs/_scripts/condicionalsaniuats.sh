#!/bin/bash
# Exemple d'ús de condicionals aniuats

edat=3

if [ "$edat" -gt 0 ]
then
    if [ "$edat" -lt 5 ]
    then
        echo "L'edat es troba entre 0 i 5 anys."
    fi
fi

# Equival edat:

if [ "$edat" -gt 0 ] && [ "$edat" -lt 5 ]
then
    echo "L'edat es troba entre 0 i 5 anys."
fi
