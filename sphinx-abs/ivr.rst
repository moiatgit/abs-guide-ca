######################################
XXX Capítol 28. Referències indirectes
######################################

Hem vist que en :doc:`referenciar una variable <varsubn>` fent
``$var``. bash retorna el seu *valor*. Què passa, però, si aquest valor és a la seva
vegada una variable? Com obtenim el valor d'un valor?
Potser amb ``$$var`` ?

Encara que l'intent amb dos ``$`` s'acosta, la manera de fer-ho és amb
``\$$var``.
Normalment el precedirem per un `eval`, però també amb `echo`. Mira :doc:`internal``.
Anomenarem aquest tipus de referències *referència indirecta*.

Exemple 1
=========

.. literalinclude:: _scripts/ind-ref.sh
   :language: bash

Les referències indirectes en Bash es realitzen amb més d'una passada:

#. Primer, s'obté el nom de la variable ``varname``.

#. A continuació es referencia: ``$varname``.

#. Tot seguit, s'indica la referència de la referència: ``$$varname``.

#. Ara escapem el primer ``$``: ``\$$varname``

#. Finalment demanem la seva reevaluació: ``eval newvar=\\$$varname``.

Quina utilitat pot tenir l'ús de referenciació indirecta? Proporciona a
Bash una aproximació a la funcionalitat dels punters de *C*. Per exemple, 
considera l'exemple:

.. literalinclude:: _scripts/resistor-inventory.sh


Una altra aplicació interessant...

.. XXX TODO: vas per aquí

Nils Radtke shows how to build "dynamic" variable names and evaluate
their contents. This can be useful when
`sourcing <internal.html#SOURCEREF>`__ configuration files.


.. code-block:: sh

    #!/bin/bash


    # ---------------------------------------------
    # This could be "sourced" from a separate file.
    isdnMyProviderRemoteNet=172.16.0.100
    isdnYourProviderRemoteNet=10.0.0.10
    isdnOnlineService="MyProvider"
    # ---------------------------------------------


    remoteNet=$(eval "echo \$$(echo isdn${isdnOnlineService}RemoteNet)")
    remoteNet=$(eval "echo \$$(echo isdnMyProviderRemoteNet)")
    remoteNet=$(eval "echo \$isdnMyProviderRemoteNet")
    remoteNet=$(eval "echo $isdnMyProviderRemoteNet")

    echo "$remoteNet"    # 172.16.0.100

    # ================================================================

    #  And, it gets even better.

    #  Consider the following snippet given a variable named getSparc,
    #+ but no such variable getIa64:

    chkMirrorArchs () {
      arch="$1";
      if [ "$(eval "echo \${$(echo get$(echo -ne $arch
           sed 's/^\(.\).*/\1/g'tr 'a-z' 'A-Z'; echo $arch
           sed 's/^.\(.*\)/\1/g')):-false}")" = true ]
      then
         return 0;
      else
         return 1;
      fi;
    }

    getSparc="true"
    unset getIa64
    chkMirrorArchs sparc
    echo $?        # 0
                   # True

    chkMirrorArchs Ia64
    echo $?        # 1
                   # False

    # Notes:
    # -----
    # Even the to-be-substituted variable name part is built explicitly.
    # The parameters to the chkMirrorArchs calls are all lower case.
    # The variable name is composed of two parts: "get" and "Sparc" . . .




Exemple 2. Passing an indirect reference to *awk*
=================================================


.. code-block:: sh

    #!/bin/bash

    #  Another version of the "column totaler" script
    #+ that adds up a specified column (of numbers) in the target file.
    #  This one uses indirect references.

    ARGS=2
    E_WRONGARGS=85

    if [ $# -ne "$ARGS" ] # Check for proper number of command-line args.
    then
       echo "Usage: `basename $0` filename column-number"
       exit $E_WRONGARGS
    fi

    filename=$1         # Name of file to operate on.
    column_number=$2    # Which column to total up.

    #===== Same as original script, up to this point =====#


    # A multi-line awk script is invoked by
    #   awk "
    #   ...
    #   ...
    #   ...
    #   "


    # Begin awk script.
    # -------------------------------------------------
    awk "

    { total += \$${column_number} # Indirect reference
    }
    END {
         print total
         }

         " "$filename"
    # Note that awk doesn't need an eval preceding \$$.
    # -------------------------------------------------
    # End awk script.

    #  Indirect variable reference avoids the hassles
    #+ of referencing a shell variable within the embedded awk script.
    #  Thanks, Stephane Chazelas.


    exit $?






|Caution

This method of indirect referencing is a bit tricky. If the second order
variable changes its value, then the first order variable must be
properly dereferenced (as in the above example). Fortunately, the
``                   ${!variable}                 `` notation introduced
with `version 2 <bashver2.html#BASH2REF>`__ of Bash (see `Example
37-2 <bashver2.html#EX78>`__ and `Example
A-22 <contributed-scripts.html#HASHEX2>`__ ) makes indirect referencing
more intuitive.






Bash does not support pointer arithmetic, and this severely limits the
usefulness of indirect referencing. In fact, indirect referencing in a
scripting language is, at best, something of an afterthought.





