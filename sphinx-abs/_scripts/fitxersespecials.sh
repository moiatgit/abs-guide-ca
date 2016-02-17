# Demostració de condicions amb fitxers especials

dispositiu0="/dev/sda2"    # /   (directori arrel)
if [ -b "$dispositiu0" ]
then
    echo "$dispositiu0 és un dispositiu de bloc"
fi

dispositiu1="/dev/ttyS1"   # targeta de modem PCMCIA
if [ -c "$dispositiu1" ]
then
    echo "$dispositiu1 és un dispositiu de caràcter"
fi
