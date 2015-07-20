#!/bin/bash

# Exemple d'inicialització i substitució de variable

a=375
variable=$a
#      ^ ^ sense espais

echo variable    # sortida: variable
# No es una referència a variable, simplemente és el String "variable"

echo $variable   # sortida: 375
#    ^           Ara sí que és una referència a variable.

echo ${variable} # sortida: 375
#                La versió ampliada de la referència.

# Amb cometes febles, en aquest cas el resultat no canvia
echo "$variable"    # sortida: 375
echo "${variable}"  # sortida: 375

# XXX TODO: vas per aquí. Estàs passant les explicacions "gruixudes" al text que la descriu.

echo


# Provem amb Strings
variable="A B  C   D"
#          ^ ^^ ^^^   diferents espais
echo $variable   # sortida: A B C D
echo "$variable" # sortida: A B  C   D
# Fixa't que echo $variable i echo "$variable" donen resultats diferents.

echo

echo '$variable'  # Sortida: $variable
#    ^         ^
#  Amb cometes simples, no es fa la substitució donat que $ s'interpreta literalment


# Comprovem els efectes de les diferents cometes

variable=    # assignem el valor null
echo "\$variable (valor null) = $variable"      # sortida: $variable (valor null) =
#  Assignar-li el valor null equivaldria a desassignar la variable.


#  Assignació múltiple en una mateixa línia
var1=21  var2=22  var3=$V3
echo
echo "var1=$var1   var2=$var2   var3=$var3"



echo; echo

nombres="un dos tres"
#           ^   ^
altres_nombres="1 2 3"
#                ^ ^
#  Quan el valor d'una variable conté espais, és obligatori posar-lo entre cometes.
#  altres_nombres=1 2 3                   # Generaria un missatge d'error.
echo "nombres = $nombres"
echo "altres_nombres = $altres_nombres"   # sortida: altres_nombres = 1 2 3
#  També funciona si escapem els espais
una_cosa=1\ ---\ cosa
#          ^    ^ un espai després de l'escape (\).

echo "$una_cosa"         # 1 --- cosa

echo; echo

echo "variable_no_inicialitzada = $variable_no_inicialitzada"
# Una variable sense inicialitzar no té cap valor.
variable_no_inicialitzada=   #  Així la declarem però no la inicialitzem, el que
                             #+ equival a assignar-li el valor null, com abans.
echo "variable_no_inicialitzada = $variable_no_inicialitzada"
                             # Encara amb valor null.

variable_no_inicialitzada=23       # Ara queda inicialitzada.
unset variable_no_inicialitzada    # Ara la desassignem.
echo "variable_no_inicialitzada = $variable_no_inicialitzada"
                                # sortida: variable_no_inicialitzada =
                                # Continua mostrant un valor null
echo

exit 0
