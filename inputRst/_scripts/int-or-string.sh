#!/bin/bash

# Demostració de tipus de les variables

a=2334                   # Permet ser considerada com a enter
let "a += 1"
echo "a = $a "           # Sortida: a = 2335
echo                     # (continua sent un enter)


b=${a/23/BB}             # Substitueix "23" per "BB"
# Ara $b conté no dígits
echo "b = $b"            # b = BB35
declare -i b             # Encara que la declarem com un enter, no funciona.
echo "b = $b"            # b = BB35

let "b += 1"             # BB35 + 1
echo "b = $b"            # Sortida: b = 1
echo                     # Bash considera que un String val 0 com a enter.

c=BB34
echo "c = $c"            # c = BB34
d=${c/BB/23}             # Substitueix "BB" for "23".
# Ara $d pot ser considerada com a enter.
echo "d = $d"            # d = 2334
let "d += 1"             # 2334 + 1
echo "d = $d"            # d = 2335
echo


# Considerem el cas del valor null
e=''                     # ... o e="" ... o e=
echo "e = $e"            # Sortida: e =
let "e += 1"             # Bash permet operacions aritmètiques amb null.
echo "e = $e"            # Sortida: e = 1
echo                     # El valor null es considera 0 en operacions aritmètiques

# I si la variable no ha estat declarada?
echo "f = $f"            # Sortida: f =
let "f += 1"             # Arithmetic operations allowed?
echo "f = $f"            # Sortida: f = 1
echo                     # Novament, per les variables no declarades es considera 0
#
# No obstant ...
let "f /= $nodeclarada"  # Divisió per zero?
#  let: f /= : syntax error: operand expected (error token is " ")
#  bash: let: f /= nodeclarada: divisió per 0 (error token is "nodeclarada")
#  Es produeix un error sintàctic! En aquest cas no es considera que $nodeclarada
#+ valgui 0!
#
# Amb tot ...
let "f /= 0"
#  bash: let: f /= 0: divisió per 0 (error token is "0")
# El comportament que seria d'esperar.


#  Bash (normalment) assigna un valor enter de zero a null 
#+ quan ha de processar una operació aritmètica.
#  Però compte! No està documentat i probablement no és un comportament
#+ portable.


# Conclussió: Les variables en Bash no tenen tipus, amb tot el que això
# comporta.

exit $?



