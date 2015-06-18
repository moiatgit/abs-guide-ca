#!/bin/rm
# Guió que s'auto elimina

# No sembla que passi gran cosa quan executes aquest guió... excepte
# que el fitxer desapareix.

VALOR=85

echo "Aquesta línia no es mostrarà mai (vols apostar?)."

exit $VALOR  # No importa. El guió no surt per aquí.
             # Si fas echo $? després de finalitzar el guió, rebràs un
             # 0 i no un 85.
