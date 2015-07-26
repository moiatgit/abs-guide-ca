#!/bin/bash

# Demostració de diferents tipus d'assignació de valors a una variable

echo

# Una variable apareix sense $ al davant quan està sent assignada, en comptes de
# referenciada.

# Assignació
a=879
echo "El valor de \"a\" és $a."     # Sortida: El valor de "a" és 879.

# Assignació fent servir 'let'
let a=16+5
echo "El valor de \"a\" ara és $a." # Sortida: El valor de "a" ara és 21.

echo

# En un bucle for (una altra manera d'assignar valors):
echo -n "Els valors de \"a\" en el bucle són: "
for a in 7 8 9 11
do
    echo -n "$a "
done
# Sortida: Els valors de "a" en el bucle són: 7 8 9 11

echo
echo

# En una instrucció 'read' (un altre tipus d'assignació):
echo -n "Introdueix un valor per \"a\" "
read a
echo "El valor de \"a\" ara és $a."     # mostrarà el valor introduït

echo

exit 0


