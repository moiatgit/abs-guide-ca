############################
XXX Comencem amb el Sha-Bang
############################

    *Shell programming is a 1950s juke box . . .*

    -- Larry Wall

En aquest capítol veurem:

.. toctree::
   :titlesonly:

   invoking
   prelimexer


En el cas més simple, un guió no és més que una llista de comandes del
sistema emmagatzemades a un fitxer de text. I ja això és útil, si més
no per evitar-nos teclejar una i altra vegada la mateixa seqüència de
comandes. 


**Exemple 2-1. *cleanup*: Un script per netejar els fitxers de log de /var/log**

.. literalinclude:: _scripts/cleanup.sh
   :language: bash
   :linenos:

No hi ha res inusual aquí. Es tracta d'una seqüència de
comandes que podrien haver estat invocades una darrera de l'altre des
de la línia de comandes en una consola o terminal.
Els avantatges de col·locar aquestes comandes en un guió van més enllà
de simplement no haver de tornar a reescriure-les. El guió es
converteix en un *programa*, una *eina*, i com a tal, pot ser
fàcilment modificada o adaptada a requeriments particulars.

**Exemple 2-2. *cleanup*: versió millorada del guió de neteja.**

.. literalinclude:: _scripts/cleanup2.sh
   :language: bash
   :linenos:

Ara si que comença a semblar un guió real! Però encara podem anar-hi
més lluny...

**Exemple 2-3. *cleanup*: Una versió ampliada i generalitzada dels
guions anteriors.**

.. literalinclude:: _scripts/cleanup3.sh
   :language: bash
   :linenos:


Donat que podria ser que no ens interessi eliminar el log de sistema
completament, aquesta versió del guió conserva la darrera secció dels
missatges de log.
Constantment descobrirem maneres d'ajustar els nostres guions per
millorar l'efectivitat.

-----

The *sha-bang* ( #!) `[1] <sha-bang.html#FTN.AEN205>`__ at the head of a
script tells your system that this file is a set of commands to be fed
to the command interpreter indicated. The #! is actually a two-byte
`[2] <sha-bang.html#FTN.AEN214>`__ *magic number*, a special marker that
designates a file type, or in this case an executable shell script (type
``man magic`` for more details on this fascinating topic). Immediately
following the *sha-bang* is a *path name*. This is the path to the
program that interprets the commands in the script, whether it be a
shell, a programming language, or a utility. This command interpreter
then executes the commands in the script, starting at the top (the line
following the *sha-bang* line), and ignoring comments.
`[3] <sha-bang.html#FTN.AEN226>`__

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/sh                                                            |
|     #!/bin/bash                                                          |
|     #!/usr/bin/perl                                                      |
|     #!/usr/bin/tcl                                                       |
|     #!/bin/sed -f                                                        |
|     #!/bin/awk -f                                                        |
                                                                          
+--------------------------------------------------------------------------+

Each of the above script header lines calls a different command
interpreter, be it ``/bin/sh``, the default shell (**bash** in a Linux
system) or otherwise. `[4] <sha-bang.html#FTN.AEN242>`__ Using
``#!/bin/sh``, the default Bourne shell in most commercial variants of
UNIX, makes the script `portable <portabilityissues.html>`__ to
non-Linux machines, though you `sacrifice Bash-specific
features <gotchas.html#BINSH>`__. The script will, however, conform to
the POSIX `[5] <sha-bang.html#FTN.AEN256>`__ **sh** standard.

Note that the path given at the "sha-bang" must be correct, otherwise an
error message -- usually "Command not found." -- will be the only result
of running the script. `[6] <sha-bang.html#FTN.AEN269>`__

#! can be omitted if the script consists only of a set of generic system
commands, using no internal shell directives. The second example, above,
requires the initial #!, since the variable assignment line,
``lines=50``, uses a shell-specific construct.
`[7] <sha-bang.html#FTN.AEN279>`__ Note again that ``#!/bin/sh`` invokes
the default shell interpreter, which defaults to ``/bin/bash`` on a
Linux machine.

+----------------+----------------+----------------+----------------+----------------+
| |Tip|          |
| This tutorial  |
| encourages a   |
| modular        |
| approach to    |
| constructing a |
| script. Make   |
| note of and    |
| collect        |
| "boilerplate"  |
| code snippets  |
| that might be  |
| useful in      |
| future         |
| scripts.       |
| Eventually you |
| will build     |
| quite an       |
| extensive      |
| library of     |
| nifty          |
| routines. As   |
| an example,    |
| the following  |
| script prolog  |
| tests whether  |
| the script has |
| been invoked   |
| with the       |
| correct number |
| of parameters. |
|                |
| +------------- |
| -------------- |
| -------------- |
| -------------- |
| -------------- |
| -----+         |
| | .. code:: PR |
| OGRAMLISTING   |
|                |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     E_WRONG_ |
| ARGS=85        |
|                |
|                |
|                |
|      |         |
| |     script_p |
| arameters="-a  |
| -h -m -z"      |
|                |
|                |
|      |         |
| |     #        |
|            -a  |
| = all, -h = he |
| lp, etc.       |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     if [ $#  |
| -ne $Number_of |
| _expected_args |
|  ]             |
|                |
|      |         |
| |     then     |
|                |
|                |
|                |
|                |
|      |         |
| |       echo " |
| Usage: `basena |
| me $0` $script |
| _parameters"   |
|                |
|      |         |
| |       # `bas |
| ename $0` is t |
| he script's fi |
| lename.        |
|                |
|      |         |
| |       exit $ |
| E_WRONG_ARGS   |
|                |
|                |
|                |
|      |         |
| |     fi       |
|                |
|                |
|                |
|                |
|      |         |
|                |
|                |
|                |
|                |
|                |
|                |
| +------------- |
| -------------- |
| -------------- |
| -------------- |
| -------------- |
| -----+         |
|                |
| Many times,    |
| you will write |
| a script that  |
| carries out    |
| one particular |
| task. The      |
| first script   |
| in this        |
| chapter is an  |
| example.       |
| Later, it      |
| might occur to |
| you to         |
| generalize the |
| script to do   |
| other, similar |
| tasks.         |
| Replacing the  |
| literal        |
| ("hard-wired") |
| constants by   |
| variables is a |
| step in that   |
| direction, as  |
| is replacing   |
| repetitive     |
| code blocks by |
| `functions <fu |
| nctions.html#F |
| UNCTIONREF>`__ |
| .              |
+----------------+----------------+----------------+----------------+----------------+

Notes
~~~~~

`[1] <sha-bang.html#AEN205>`__

More commonly seen in the literature as *she-bang* or *sh-bang*. This
derives from the concatenation of the tokens *sharp* (#) and *bang* (!).

`[2] <sha-bang.html#AEN214>`__

Some flavors of UNIX (those based on 4.2 BSD) allegedly take a four-byte
magic number, requiring a blank after the ! -- ``#! /bin/sh``.
`According to Sven
Mascheck <http://www.in-ulm.de/~mascheck/various/shebang/#details>`__
this is probably a myth.

`[3] <sha-bang.html#AEN226>`__

The #! line in a shell script will be the first thing the command
interpreter (**sh** or **bash**) sees. Since this line begins with a #,
it will be correctly interpreted as a comment when the command
interpreter finally executes the script. The line has already served its
purpose - calling the command interpreter.

If, in fact, the script includes an *extra* #! line, then **bash** will
interpret it as a comment.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/bash                                                          |
|                                                                          |
|     echo "Part 1 of script."                                             |
|     a=1                                                                  |
|                                                                          |
|     #!/bin/bash                                                          |
|     # This does *not* launch a new script.                               |
|                                                                          |
|     echo "Part 2 of script."                                             |
|     echo $a  # Value of $a stays at 1.                                   |
                                                                          
+--------------------------------------------------------------------------+

`[4] <sha-bang.html#AEN242>`__

This allows some cute tricks.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/rm                                                            |
|     # Self-deleting script.                                              |
|                                                                          |
|     # Nothing much seems to happen when you run this... except that the  |
| file disappears.                                                         |
|                                                                          |
|     WHATEVER=85                                                          |
|                                                                          |
|     echo "This line will never print (betcha!)."                         |
|                                                                          |
|     exit $WHATEVER  # Doesn't matter. The script will not exit here.     |
|                     # Try an echo $? after script termination.           |
|                     # You'll get a 0, not a 85.                          |
                                                                          
+--------------------------------------------------------------------------+

Also, try starting a ``README`` file with a ``#!/bin/more``, and making
it executable. The result is a self-listing documentation file. (A `here
document <here-docs.html#HEREDOCREF>`__ using
`cat <basic.html#CATREF>`__ is possibly a better alternative -- see
`Example 19-3 <here-docs.html#EX71>`__).

`[5] <sha-bang.html#AEN256>`__

**P**\ ortable **O**\ perating **S**\ ystem *I*\ nterface, an attempt to
standardize UNI\ **X**-like OSes. The POSIX specifications are listed on
the `Open Group
site <http://www.opengroup.org/onlinepubs/007904975/toc.htm>`__.

`[6] <sha-bang.html#AEN269>`__

To avoid this possibility, a script may begin with a `#!/bin/env
bash <system.html#ENVV2REF>`__ *sha-bang* line. This may be useful on
UNIX machines where *bash* is not located in ``/bin``

`[7] <sha-bang.html#AEN279>`__

If *Bash* is your default shell, then the #! isn't necessary at the
beginning of a script. However, if launching a script from a different
shell, such as *tcsh*, then you *will* need the #!.

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <why-shell.html>`_ | Shell Programming!       |
| _                        | `Up <part1.html>`__      |
| `Home <index.html>`__    | Invoking the script      |
| `Next <invoking.html>`__ |                          |
+--------------------------+--------------------------+--------------------------+

.. |Tip| image:: ../images/tip.gif


