Advanced Bash-Scripting Guide:

`Prev <standard-options.html>`__

Appendix G. Command-Line Options

`Next <files.html>`__

--------------

G.2. Bash Command-Line Options
==============================

*Bash* itself has a number of command-line options. Here are some of the
more useful ones.

-  ``-c``

   *Read commands from the following string and assign any arguments to
   the `positional parameters <internalvariables.html#POSPARAMREF>`__.*

   +--------------------------------------------------------------------------+
   | .. code:: SCREEN                                                         |
   |                                                                          |
   |     bash$ bash -c 'set a b c d; IFS="+-;"; echo "$*"'                    |
   |     a+b+c+d                                                              |
   |                                                                          |
                                                                             
   +--------------------------------------------------------------------------+

-  ``-r``

   ``--restricted``

   *Runs the shell, or a script, in `restricted
   mode <restricted-sh.html#RESTRICTEDSHREF>`__.*

-  ``--posix``

   *Forces Bash to conform to `POSIX <sha-bang.html#POSIX2REF>`__ mode.*

-  ``--version``

   *Display Bash version information and exit.*

-  ``--``

   *End of options. Anything further on the command line is an argument,
   not an option.*

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <standard-options. | Standard Command-Line    |
| html>`__                 | Options                  |
| `Home <index.html>`__    | `Up <command-line-option |
| `Next <files.html>`__    | s.html>`__               |
|                          | Important Files          |
+--------------------------+--------------------------+--------------------------+

