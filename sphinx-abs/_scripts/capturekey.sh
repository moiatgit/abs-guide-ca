#!/bin/bash
# Demostració de captura de tecles
# Autor original: Sigurd Solaas, 20 abril 2011
# Per versió de Bash 4.2+.

key="De moment no has pres cap tecla"
while true; do
    clear
    echo "Demostració de tecles extra. Prova amb les tecles:"
    echo
    echo "* Insert, Delete, Home, End, Page_Up i Page_Down"
    echo "* Les quatre tecles del cursor"
    echo "* Tab, enter, esc i barra d'espai"
    echo "* Les tecles de lletres, nombres, etc."
    echo
    echo "    d = mostra la data i hora"
    echo "    q = surt"
    echo "================================"
    echo

    # Converteix la tecla separada home-key a home-key_num_7:
    if [ "$key" = $'\x1b\x4f\x48' ]; then
        key=$'\x1b\x5b\x31\x7e' #   expansió de text entre cometes
    fi

    # Converteix la tecla separada end-key a end-key_num_1.
    if [ "$key" = $'\x1b\x4f\x46' ]; then
        key=$'\x1b\x5b\x34\x7e'
    fi

    case "$key" in
        $'\x1b\x5b\x32\x7e')  # Insert
            echo Insert
            ;;
        $'\x1b\x5b\x33\x7e')  # Delete
            echo Delete
            ;;
        $'\x1b\x5b\x31\x7e')  # Home_key_num_7
            echo Inici
            ;;
        $'\x1b\x5b\x34\x7e')  # End_key_num_1
            echo Fi
            ;;
        $'\x1b\x5b\x35\x7e')  # Page_Up
            echo Pàgina amunt
            ;;
        $'\x1b\x5b\x36\x7e')  # Page_Down
            echo Pàgina abaix
            ;;
        $'\x1b\x5b\x41')  # Up_arrow
            echo Cursor amunt
            ;;
        $'\x1b\x5b\x42')  # Down_arrow
            echo Cursor abaix
            ;;
        $'\x1b\x5b\x43')  # Right_arrow
            echo Cursor dreta
            ;;
        $'\x1b\x5b\x44')  # Left_arrow
            echo Cursor esquerra
            ;;
        $'\x09')  # Tab
            echo Tab
            ;;
        $'\x0a')  # Enter
            echo Enter
            ;;
        $'\x1b')  # Escape
            echo Escape
            ;;
        $'\x20')  # Space
            echo Space
            ;;
        d)
            date
            ;;
        q)
            echo "Això s'acaba..."
            echo
            exit 0
            ;;
        *)
            echo Has pres: \'"$key"\'
            ;;
    esac

    echo
    echo "================================"

    unset K1 K2 K3
    read -s -N1 -p "Prem una tecla: "
    K1="$REPLY"
    read -s -N2 -t 0.001
    K2="$REPLY"
    read -s -N1 -t 0.001
    K3="$REPLY"
    key="$K1$K2$K3"

done

exit $?


