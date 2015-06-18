E_WRONG_ARGS=85     # resultat de retorn en cas d'error
parametres_valids="-a -h -m -z"
#                  -a = all, -h = help, etc.

if [ $# -ne $nr_args_esperats ]
then
  echo "Ús: `basename $0` $parametres_valids"
  # `basename $0` és el nom d'aquest fitxer
  exit $E_WRONG_ARGS
fi
