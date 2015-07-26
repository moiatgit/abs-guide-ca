#!/bin/bash4
# Exemple de modificació del cas d'un string

var=unTextAmbMajúsculesIMINÚSCULESBarrejades
echo ${var}            # unTextAmbMajúsculesIMINÚSCULESBarrejades
echo ${var^}           # UnTextAmbMajúsculesIMINÚSCULESBarrejades
#         *              ^ el primer caràcter en majúscules
echo ${var^^}          # UNTEXTAMBMAJÚSCULESIMINÚSCULESBARREJADES
#         **             Tot en majúscules
echo ${var,}           # unTextAmbMajúsculesIMINÚSCULESBarrejades
#         *              El primer caràcter en minúscules
echo ${var,,}          # untextambmajúsculesiminúsculesbarrejades
#         **             Tot en minúscules

# Nota: fixa't que també funciona amb caracters especials com Ú
