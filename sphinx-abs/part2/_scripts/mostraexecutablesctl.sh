# Mostra tots els fitxers executables que acabin en "ctl"
# dins dels directoris /bin i /usr/bin
for fitxer in /{,usr/}bin/*ctl
do
    if [ -x "$fitxer" ]
    then
        echo $fitxer
    fi
done
