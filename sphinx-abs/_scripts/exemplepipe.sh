# demostració de funcionament de conducte

function mostra_tipus_entrada()
{
    [ -p /dev/fd/0 ] && echo PIPE || echo STDIN
}

mostra_tipus_entrada "Input"               # sortida: STDIN
echo "Input" | mostra_tipus_entrada        # sortida: PIPE


