`Inici <index.ca.html>`_ :  Guia avançada de Bash-Scripting

`Amunt <tests.ca.html>`_ : Capítol 7. Comprovacions

`Anterior <comparison-ops.ca.html>`_ : Altres operadors de comparació

`Següent <testtest.ca.html>`_ : Comprova el teu coneixement sobre comprovacions

--------------

7.4. Estructures if/then imbricades
===================================
L’estructura if/then pot ser imbricada. És a dir, pot aparèixer dins d’una altra estructura if/then. El resultat final equival a l’ús de l’operador 
`*&&* <ops.ca.html>`_ .

::

    a=3

    if [ "$a" -gt 0 ]
    then
      if [ "$a" -lt 5 ]
      then
        echo "El valor de \"a\" es troba entre 0 i 5."
      fi
    fi

    # El resultat és equivalent al de:

    if [ "$a" -gt 0 ] && [ "$a" -lt 5 ]
    then
      echo "El valor de \"a\" es troba entre 0 i 5."
    fi

`Exemples 37-4 <bashver2.ca.html>`_ i  `17-11 <system.ca.html>`_ que demostren l'ús imbricat de l'estructrura ``if/then``.

--------------

`Inici <index.ca.html>`_ :  Guia avançada de Bash-Scripting

`Amunt <tests.ca.html>`_ : Capítol 7. Comprovacions

`Anterior <comparison-ops.ca.html>`_ : Altres operadors de comparació

`Següent <testtest.ca.html>`_ : Comprova el teu coneixement sobre comprovacions
