+-----------------------------------+------------------------------------+------------------------+
| Advanced Bash-Scripting Guide:    |
+===================================+====================================+========================+
| `Prev <standard-options.html>`_   | Appendix F. Command-Line Options   | `Next <files.html>`_   |
+-----------------------------------+------------------------------------+------------------------+

--------------

F.2. Bash Command-Line Options
==============================

*Bash* itself has a number of command-line options. Here are some of the
more useful ones.

-  ``-c``

   *Read commands from the following string and assign any arguments to
   the `positional parameters <internalvariables.html#POSPARAMREF>`_.*

   ::

       bash$ bash -c 'set a b c d; IFS="+-;"; echo "$*"'
       a+b+c+d
                 

-  ``-r``

   ``--restricted``

   *Runs the shell, or a script, in `restricted
   mode <restricted-sh.html#RESTRICTEDSHREF>`_.*

-  ``--posix``

   *Forces Bash to conform to `POSIX <sha-bang.html#POSIX2REF>`_ mode.*

-  ``--version``

   *Display Bash version information and exit.*

-  ``--``

   *End of options. Anything further on the command line is an argument,
   not an option.*

--------------

+-----------------------------------+-------------------------------------+------------------------+
| `Prev <standard-options.html>`_   | `Home <index.html>`_                | `Next <files.html>`_   |
+-----------------------------------+-------------------------------------+------------------------+
| Standard Command-Line Options     | `Up <command-line-options.html>`_   | Important Files        |
+-----------------------------------+-------------------------------------+------------------------+

