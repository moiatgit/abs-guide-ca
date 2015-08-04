#!/bin/bash
# XXX Demostració de caràcters escapats

### Comencem veient uns exemples bàsics d'escapament de caràcters

# Escapem un salt de línia

echo ""

echo "Aquest text es mostrarà
en dues línies."
# Sortida: Aquest text es mostrarà
#          en dues línies.

echo "Aquest text es mostrarà \
en una única línia."
# Sortida: Aquest text es mostrarà en una única línia.

echo; echo

echo "============="


echo "a\ve\vi\vo\vu"     # Sortida: a\ve\vi\vo\vu
# Amb l'opció -e, la comanda echo mostrarà els caràcters escapats.
echo "Tabulació vertical"
echo -e "a\ve\vi\vo\vu"   # Sortida:    a
                          #                 e
                          #                     i
                          #                         o
                          #                             u


echo "Cometes dobles
echo -e "\042aeiou\042"       # Sortida: "aeiou"

XXX vas per aquí

# The $'\X' construct makes the -e option unnecessary.

echo; echo "NEWLINE and (maybe) BEEP"
echo $'\n'           # Newline.
echo $'\a'           # Alert (beep).
# May only flash, not beep, depending on terminal.

# We have seen $'\nnn" string expansion, and now . . .

# =================================================================== #
# Version 2 of Bash introduced the $'\nnn' string expansion construct.
# =================================================================== #

echo "Introducing the \$\' ... \' string-expansion construct . . . "
echo ". . . featuring more quotation marks."

echo $'\t \042 \t'   # Quote (") framed by tabs.
# Note that  '\nnn' is an octal value.

# It also works with hexadecimal values, in an $'\xhhh' construct.
echo $'\t \x22 \t'  # Quote (") framed by tabs.
# Thank you, Greg Keraunen, for pointing this out.
# Earlier Bash versions allowed '\x022'.

echo


# Assigning ASCII characters to a variable.
# ----------------------------------------
quote=$'\042'        # " assigned to a variable.
echo "$quote Quoted string $quote and this lies outside the quotes."

echo

# Concatenating ASCII chars in a variable.
triple_underline=$'\137\137\137'  # 137 is octal ASCII code for '_'.
echo "$triple_underline UNDERLINE $triple_underline"

echo

ABC=$'\101\102\103\010'           # 101, 102, 103 are octal A, B, C.
echo $ABC

echo

escape=$'\033'                    # 033 is octal for escape.
echo "\"escape\" echoes as $escape"
#                                   no visible output.

echo

exit 0




