#!/bin/bash
# Cleanup, versió 3

#  Atenció:
#  -------
#  Aquest guió fa servir força característiques que seran explicades
#  més endavant.
#  Quan ja entenguis la primera meitat d'aquest llibre, no hauries de
#  trobar res misterios aquí.

LOG_DIR=/var/log
ROOT_UID=0     # Només l'usuari amb $UID 0 té privilegis de root
LINIES=50      # El nombre de línies guardades per defecte
E_XCD=86       # Error: no es pot canviar de directori
E_NOTROOT=87   # Error: No és root

# A executar com a root, per suposat
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Cal ser executat per root"
  exit $E_NOTROOT
fi

if [ -n "$1" ]
# Comprova si se li ha passat al menys un argument per línia de comandes
then
  linies=$1
else
  linies=$LINIES # Si no ha estat especificat el nombre de línies, es
                # considera el valor per defecte
fi


#  Stephane Chazelas suggereix la següent manera de comprovar els
#  arguments de línia de comandes, encara que és una mica avançat pel
#  nivell actual d'aquest llibre.
#
#    E_WRONGARGS=85  # Error: argument no numèric (format d'argument
#    incorrecte)
#
#    case "$1" in
#    ""      ) linies=50;;
#    *[!0-9]*) echo "Ús: `basename $0` linies-a-netejar";
#     exit $E_WRONGARGS;;
#    *       ) linies=$1;;
#    esac
#
#  Salta a la secció sobre bucles per desxifrar-ho.

cd $LOG_DIR

if [ `pwd` != "$LOG_DIR" ]  # o bé   if [ "$PWD" != "$LOG_DIR" ]
                            # que vol dir si no es troba a /var/log?
then
  echo "No es pot canviar al directori $LOG_DIR."
  exit $E_XCD
fi  # Torna a comprovar si es troba en el directori adequat abans de
    # començar a trastejar amb el fitxer de log.

# Seria molt més eficient de la següent manera:
#
# cd /var/log || {
#   echo "No es pot canviar al directori corresponent." >&2
#   exit $E_XCD;
# }

tail -n $linies messages > mesg.temp # Guarda la darrera secció del
                                     # fitxer de missatges de log.
mv mesg.temp messages                # Reanomena el fitxer com a log
                                     # del sistema.


#  cat /dev/null > messages
#  Ja no cal, doncs el mètode anterior és més segur.

cat /dev/null > wtmp  #  ': > wtmp' i '> wtmp'  produeixen el mateix efecte.

echo "Fitxers de Log netejats."
#  Fixat que la resta de fitxers de log que es trobin a /var/log no
#  es toquen.

exit 0
#  El valor zero de retorn, indica a la shell que el guió ha
#  finalitzat sense errors.
