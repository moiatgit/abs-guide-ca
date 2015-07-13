#!/bin/bash
# Una capçalera adequada per un guió Bash

# Cleanup, versió 2

# A executar com a root, per suposat

# Mostra un missatge d'error i sorti si no s'executa com a root.

LOG_DIR=/var/log
# És millor fer servir variables que els valors directament.
cd $LOG_DIR

cat /dev/null > messages
cat /dev/null > wtmp


echo "Fitxers de Log netejats."

exit #  La manera adequada de sortir d'un guió.
     #  Un "exit" sense paràmetres retorna el resultat de sortida de
     #  la comanda anterior.
