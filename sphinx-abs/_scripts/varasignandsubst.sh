#!/bin/bash

# XXX Exemple d'inicialització i substitució de variable

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

variable="A B  C   D"
echo $variable   # A B C D
echo "$variable" # A B  C   D
# As we see, echo $variable   and   echo "$variable"   give different results.
# =======================================
# Quoting a variable preserves whitespace.
# =======================================

echo

echo '$variable'  # $variable
#    ^      ^
#  Variable referencing disabled (escaped) by single quotes,
#+ which causes the "$" to be interpreted literally.

# Notice the effect of different types of quoting.


variable=    # Setting it to a null value.
echo "\$variable (null value) = $variable"      # $variable (null value) =
#  Note that setting a variable to a null value is not the same as
#+ unsetting it, although the end result is the same (see below).

# --------------------------------------------------------------

#  It is permissible to set multiple variables on the same line,
#+ if separated by white space.
#  Caution, this may reduce legibility, and may not be portable.

var1=21  var2=22  var3=$V3
echo
echo "var1=$var1   var2=$var2   var3=$var3"

# May cause problems with legacy versions of "sh" . . .

# --------------------------------------------------------------

echo; echo

numbers="one two three"
#           ^   ^
other_numbers="1 2 3"
#               ^ ^
#  If there is whitespace embedded within a variable,
#+ then quotes are necessary.
#  other_numbers=1 2 3                  # Gives an error message.
echo "numbers = $numbers"
echo "other_numbers = $other_numbers"   # other_numbers = 1 2 3
#  Escaping the whitespace also works.
mixed_bag=2\ ---\ Whatever
#           ^    ^ Space after escape (\).

echo "$mixed_bag"         # 2 --- Whatever

echo; echo

echo "uninitialized_variable = $uninitialized_variable"
# Uninitialized variable has null value (no value at all!).
uninitialized_variable=   #  Declaring, but not initializing it --
                          #+ same as setting it to a null value, as above.
echo "uninitialized_variable = $uninitialized_variable"
                          # It still has a null value.

uninitialized_variable=23       # Set it.
unset uninitialized_variable    # Unset it.
echo "uninitialized_variable = $uninitialized_variable"
                                # uninitialized_variable =
                                # It still has a null value.
echo

exit 0
