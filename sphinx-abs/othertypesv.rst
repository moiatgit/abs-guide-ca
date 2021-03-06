################################
XXX  4.4. Special Variable Types
################################


Variable local
    Les variables locals són variables :doc:`visibles <subshells>` només dins d'un bloc de codi o
    funció.

    Considera :doc:`localvar` i :doc:`functions`.

Variable d'entorn
    Les variables d'entorn afecten el comportament del sistema.


En un context més general, cada procés disposa d'un *entorn* o grup de variables que el procés pot
fer referència. En aquest sentit, la shell es comporta com qualsevol altre procés. Cada cop que
s'inicia una shell, es creen les variables que corresponen al seu entorn. Afegir noves variables
d'entorn, o modificar el valor d'alguna existent, modifica l'entorn de la shell i el dels seus
processos fill (comandes que executi la shell), doncs aquests hereten l'entorn de la shell.


XXX TODO per aquí







.. caution::

    The space allotted to the environment is limited. Creating too many
    environmental variables or ones that use up excessive space may
    cause problems.


.. code-block:: sh

    bash$ eval "`seq 100
00 | sed -e 's/.*/export
 var&=ZZZZZZZZZZZZZZ/'`"

    bash$ du
    bash: /usr/bin/du: A
rgument list too long

    .. code-block:: sh

        bash$ eval "`seq 10000sed -e 's/.*/export var&=ZZZZZZZZZZZZZZ/'`"

        bash$ du
        bash: /usr/bin/du: Argument list too long



    .. code-block:: sh

        bash$ eval "`seq 10000sed -e 's/.*/export var&=ZZZZZZZZZZZZZZ/'`"

        bash$ du
        bash: /usr/bin/du: Argument list too long





    If a script sets environmental variables, they need to be
    "exported," that is, reported to the *environment* local to the
    script. This is the function of the
    `export <internal.html#EXPORTREF>`__ command.



.. note::

    A script can **export** variables only to child
    `processes <special-chars.html#PROCESSREF>`__ , that is, only to
    commands or processes which that particular script initiates. A
    script invoked from the command-line
    ``                         cannot                       `` export
    variables back to the command-line environment. *`Child
    processes <internal.html#FORKREF>`__ cannot export variables back to
    the parent processes that spawned them.*

     ``                         Definition:                       `` A
    *child process* is a subprocess launched by another process, its
    `parent <internal.html#PARENTREF>`__ .




 ``                 Positional parameters               ``
    Arguments passed to the script from the command line ` [1]
     <othertypesv.html#FTN.AEN2450>`__ : ``         $0        `` ,
    ``         $1        `` , ``         $2        `` ,
    ``         $3        `` . . .

     ``         $0        `` is the name of the script itself,
    ``         $1        `` is the first argument,
    ``         $2        `` the second, ``         $3        `` the
    third, and so forth. ` [2]  <othertypesv.html#FTN.AEN2464>`__ After
    ``         $9        `` , the arguments must be enclosed in
    brackets, for example, ``         ${10}        `` ,
    ``         ${11}        `` , ``         ${12}        `` .

    The special variables `$\* and $@ <internalvariables.html#APPREF>`__
    denote *all* the positional parameters.


Exemple 5. Positional Parameters
================================


    .. code-block:: sh

        #!/bin/bash

        # Call this script with at least 10 parameters, for example
        # ./scriptname 1 2 3 4 5 6 7 8 9 10
        MINPARAMS=10

        echo

        echo "The name of this script is \"$0\"."
        # Adds ./ for current directory
        echo "The name of this script is \"`basename $0`\"."
        # Strips out path name info (see 'basename')

        echo

        if [ -n "$1" ]              # Tested variable is quoted.
        then
         echo "Parameter #1 is $1"  # Need quotes to escape #
        fi

        if [ -n "$2" ]
        then
         echo "Parameter #2 is $2"
        fi

        if [ -n "$3" ]
        then
         echo "Parameter #3 is $3"
        fi

        # ...


        if [ -n "${10}" ]  # Parameters > $9 must be enclosed in {brackets}.
        then
         echo "Parameter #10 is ${10}"
        fi

        echo "-----------------------------------"
        echo "All the command-line parameters are: "$*""

        if [ $# -lt "$MINPARAMS" ]
        then
          echo
          echo "This script needs at least $MINPARAMS command-line arguments!"
        fi

        echo

        exit 0




    *Bracket notation* for positional parameters leads to a fairly
    simple way of referencing the *last* argument passed to a script on
    the command-line. This also requires `indirect
    referencing <bashver2.html#VARREFNEW>`__ .


    .. code-block:: sh

        args=$#           # Number of args passed.
        lastarg=${!args}
        # Note: This is an *indirect reference* to $args ...


        # Or:       lastarg=${!#}             (Thanks, Chris Monson.)
        # This is an *indirect reference* to the $# variable.
        # Note that lastarg=${!$#} doesn't work.



    Some scripts can perform different operations, depending on which
    name they are invoked with. For this to work, the script needs to
    check ``         $0        `` , the name it was invoked by. ` [3]
     <othertypesv.html#FTN.AEN2501>`__ There must also exist symbolic
    links to all the alternate names of the script. See `Example
    16-2 <basic.html#HELLOL>`__ .



.. tip::

    If a script expects a command-line parameter but is invoked without
    one, this may cause a *null variable assignment* , generally an
    undesirable result. One way to prevent this is to append an extra
    character to both sides of the assignment statement using the
    expected positional parameter.





    .. code-block:: sh

        variable1_=$1_  # Rather than variable1=$1
        # This will prevent an error, even if positional parameter is absent.

        critical_argument01=$variable1_

        # The extra character can be stripped off later, like so.
        variable1=${variable1_/_/}
        # Side effects only if $variable1_ begins with an underscore.
        # This uses one of the parameter substitution templates discussed later.
        # (Leaving out the replacement pattern results in a deletion.)

        #  A more straightforward way of dealing with this is
        #+ to simply test whether expected positional parameters have been passed.
        if [ -z $1 ]
        then
          exit $E_MISSING_POS_PARAM
        fi


        #  However, as Fabian Kreutz points out,
        #+ the above method may have unexpected side-effects.
        #  A better method is parameter substitution:
        #         ${1:-$DefaultVal}
        #  See the "Parameter Substition" section
        #+ in the "Variables Revisited" chapter.



    ---


Exemple 6. *wh* , *whois* domain name lookup
============================================


    .. code-block:: sh

        #!/bin/bash
        # ex18.sh

        # Does a 'whois domain-name' lookup on any of 3 alternate servers:
        #                    ripe.net, cw.net, radb.net

        # Place this script -- renamed 'wh' -- in /usr/local/bin

        # Requires symbolic links:
        # ln -s /usr/local/bin/wh /usr/local/bin/wh-ripe
        # ln -s /usr/local/bin/wh /usr/local/bin/wh-apnic
        # ln -s /usr/local/bin/wh /usr/local/bin/wh-tucows

        E_NOARGS=75


        if [ -z "$1" ]
        then
          echo "Usage: `basename $0` [domain-name]"
          exit $E_NOARGS
        fi

        # Check script name and call proper server.
        case `basename $0` in    # Or:    case ${0##*/} in
            "wh"       ) whois $1@whois.tucows.com;;
            "wh-ripe"  ) whois $1@whois.ripe.net;;
            "wh-apnic" ) whois $1@whois.apnic.net;;
            "wh-cw"    ) whois $1@whois.cw.net;;
            *          ) echo "Usage: `basename $0` [domain-name]";;
        esac

        exit $?




    ---

    The **shift** command reassigns the positional parameters, in effect
    shifting them to the left one notch.

    ``         $1        `` <--- ``         $2        `` ,
    ``         $2        `` <--- ``         $3        `` ,
    ``         $3        `` <--- ``         $4        `` , etc.

    The old ``         $1        `` disappears, but
    *``          $0         `` (the script name) does not change* . If
    you use a large number of positional parameters to a script,
    **shift** lets you access those past ``         10        `` ,
    although `{bracket} notation <othertypesv.html#BRACKETNOTATION>`__
    also permits this.


Exemple 7. Using *shift*
========================


    .. code-block:: sh

        #!/bin/bash
        # shft.sh: Using 'shift' to step through all the positional parameters.

        #  Name this script something like shft.sh,
        #+ and invoke it with some parameters.
        #+ For example:
        #             sh shft.sh a b c def 83 barndoor

        until [ -z "$1" ]  # Until all parameters used up . . .
        do
          echo -n "$1 "
          shift
        done

        echo               # Extra linefeed.

        # But, what happens to the "used-up" parameters?
        echo "$2"
        #  Nothing echoes!
        #  When $2 shifts into $1 (and there is no $3 to shift into $2)
        #+ then $2 remains empty.
        #  So, it is not a parameter *copy*, but a *move*.

        exit

        #  See also the echo-params.sh script for a "shiftless"
        #+ alternative method of stepping through the positional params.




    The **shift** command can take a numerical parameter indicating how
    many positions to shift.


    .. code-block:: sh

        #!/bin/bash
        # shift-past.sh

        shift 3    # Shift 3 positions.
        #  n=3; shift $n
        #  Has the same effect.

        echo "$1"

        exit 0

        # ======================== #


        $ sh shift-past.sh 1 2 3 4 5
        4

        #  However, as Eleni Fragkiadaki, points out,
        #+ attempting a 'shift' past the number of
        #+ positional parameters ($#) returns an exit status of 1,
        #+ and the positional parameters themselves do not change.
        #  This means possibly getting stuck in an endless loop. . . .
        #  For example:
        #      until [ -z "$1" ]
        #      do
        #         echo -n "$1 "
        #         shift 20    #  If less than 20 pos params,
        #      done           #+ then loop never ends!
        #
        # When in doubt, add a sanity check. . . .
        #           shift 20.. break::
        #                    ^^^^^^^^





.. note::

    The **shift** command works in a similar fashion on parameters
    passed to a `function <functions.html#FUNCTIONREF>`__ . See `Example
    36-18 <assortedtips.html#MULTIPLICATION>`__ .






Notes
~~~~~


` [1]  <othertypesv.html#AEN2450>`__

Note that `*functions* also take positional
parameters <complexfunct.html#PASSEDARGS>`__ .


` [2]  <othertypesv.html#AEN2464>`__

 The process calling the script sets the ``       $0      `` parameter.
By convention, this parameter is the name of the script. See the
`manpage <basic.html#MANREF>`__ (manual page) for **execv** .

From the *command-line* , however, ``       $0      `` is the name of
the shell.

----------------------------------------------------------------------------------

.. code-block:: sh

    bash$ echo $0
    bash

    tcsh% echo $0
    tcsh

----------------------------------------------------------------------------------



.. code-block:: sh

    bash$ echo $0
    bash

    tcsh% echo $0
    tcsh


.. code-block:: sh

    bash$ echo $0
    bash

    tcsh% echo $0
    tcsh


` [3]  <othertypesv.html#AEN2501>`__

If the the script is `sourced <internal.html#SOURCEREF>`__ or
`symlinked <basic.html#SYMLINKREF>`__ , then this will not work. It is
safer to check `$BASH\_Source <debugging.html#BASHSOURCEREF>`__ .



