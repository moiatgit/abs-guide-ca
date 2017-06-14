###################################
XXX Chapter 6. Exit and Exit Status
###################################


    Hi ha cantonades fosques a la *Bourne shell* i la gent les fa servir totes.

    --Chet Ramey



La comanda ``exit`` finalitza un guió tal i com ho fa en un programa en
*C*. A banda, pot retornar un valor que quedarà disponible pel procés pare
del guió.

Cada comanda retorna un *estat de sortida* o *codi de sortida*. Quan la
comanda té èxit, el resultat a retornar és 0. En canvi, una comanda amb
problemes retornarà un valor diferent de cero que normalment pot ser
interpretat com a *codi d'error*.
Les comandes UNIX, els programes i les utilitats retornen en general un 0
quan tot ha anat correctament. Amb tot, hi ha algunes excepcions.

De la mateixa manera les :doc:`funcions <functions.rst>` dins d'un guió
poden també retornar un estat de sortida.
La darrera comanda executada a la funció (o al guió) determina el resultat
de sortida.
La comanda ``exit nnn`` permet especificar ``nnn`` com a estat de sortida
a la línia de comandes. ``nnn`` ha de ser un enter de 0 a 255.

Quan un guió finalitza amb ``exit`` sense paràmetre, l'estat de
sortida que retorna correspon al de la darrera comanda executada tot
just abans del ``exit``.

És equivalent a fer ``exit $?`` o, fins i tot, a simplement no
posar-hi cap ``exit``.

Els següents codis d'exemple són equivalents:

.. code-block:: sh

    #!/bin/bash
    PRIMERA_COMANDA
    . . .
    DARRERA_COMANDA
    # Surt amb l'estat de sortida de la darrera comanda
    exit


.. code-block:: sh

    #!/bin/bash
    PRIMERA_COMANDA
    . . .
    DARRERA_COMANDA
    # Surt amb l'estat de sortida de la darrera comanda
    exit $?

.. code-block:: sh

    #!/bin/bash
    PRIMERA_COMANDA
    . . .
    DARRERA_COMANDA
    # Surt amb l'estat de sortida de la darrera comanda
    # Fixa't que aquí ja no hi ha cap exit



``$?`` equival a l'estat de sortida de la darrera comanda executada.
Un cop la funció retorna, ``$?`` correspon a l'estat de la darrera comanda
executada a la funció. Aquesta és la *manera* en que les funcions Bash
retornen un valor en aquells casos que la funció no finalitza amb un
``return`` (considera :doc:`funcions complexes <complexfunct.rst>` per més
detalls)

En cas de seguir l'execució d'una :doc:`canonada 
<special-chars.rst>` o *pipe*, ``$?`` també correspon al valor de la darrera
comanda executada.

En finalitzar un guió, ``$?`` des de la línia de comandes mostra l'estat
de sortida del guió. És a dir, l'estat de sortida de la darrera comanda
executada pel guió. Per convenció, el valor serà 0 si tot ha anat bé i un
valor enter del 1 al 255 per indicar que hi ha hagut error.

XXX per aquí

Exemple 1. exit / exit status
=============================


.. code-block:: sh

    #!/bin/bash

    echo hello
    echo $?    # Exit status 0 returned because command executed successfully.

    lskdf      # Unrecognized command.
    echo $?    # Non-zero exit status returned -- command failed to execute.

    echo

    exit 113   # Will return 113 to shell.
               # To verify this, type "echo $?" after script terminates.

    #  By convention, an 'exit 0' indicates success,
    #+ while a non-zero exit value means an error or anomalous condition.
    #  See the "Exit Codes With Special Meanings" appendix.




`$? <internalvariables.html#XSTATVARREF>`__ is especially useful for
testing the result of a command in a script (see `Example
16-35 <filearchiv.html#FILECOMP>`__ and `Example
16-20 <textproc.html#LOOKUP>`__ ).



.. note:: 
    The `! <special-chars.html#NOTREF>`__ , the *logical not* qualifier,
    reverses the outcome of a test or command, and this affects its `exit
    status <exit-status.html#EXITSTATUSREF>`__ .


.. _exit-status_negatingconditionwithbang:

Exemple 2. Negating a condition using !
=======================================


.. literalinclude:: /_scripts/negatingconditionusingbang.sh
    :language: bash



.. code-block:: sh

    true    # The "true" builtin.
    echo "exit status of \"true\" = $?"     # 0

    ! true
    echo "exit status of \"! true\" = $?"   # 1
    # Note that the "!" needs a space between it and the command.
    #    !true   leads to a "command not found" error
    #
    # The '!' operator prefixing a command invokes the Bash history mechanism.

    true
    !true
    # No error this time, but no negation either.
    # It just repeats the previous command (true).


    # =========================================================== #
    # Preceding a _pipe_ with ! inverts the exit status returned.
    lsbogus_command     # bash: bogus_command: command not found
    echo $?                # 127

    ! lsbogus_command   # bash: bogus_command: command not found
    echo $?                # 0
    # Note that the ! does not change the execution of the pipe.
    # Only the exit status changes.
    # =========================================================== #

    # Thanks, StÃ©phane Chazelas and Kristopher Newsome.


.. code-block:: sh

    true    # The "true" builtin.
    echo "exit status of \"true\" = $?"     # 0

    ! true
    echo "exit status of \"! true\" = $?"   # 1
    # Note that the "!" needs a space between it and the command.
    #    !true   leads to a "command not found" error
    #
    # The '!' operator prefixing a command invokes the Bash history mechanism.

    true
    !true
    # No error this time, but no negation either.
    # It just repeats the previous command (true).


    # =========================================================== #
    # Preceding a _pipe_ with ! inverts the exit status returned.
    lsbogus_command     # bash: bogus_command: command not found
    echo $?                # 127

    ! lsbogus_command   # bash: bogus_command: command not found
    echo $?                # 0
    # Note that the ! does not change the execution of the pipe.
    # Only the exit status changes.
    # =========================================================== #

    # Thanks, StÃ©phane Chazelas and Kristopher Newsome.






.. caution::
    Certain exit status codes have `reserved
    meanings <exitcodes.html#EXITCODESREF>`__ and should not be
    user-specified in a script.




