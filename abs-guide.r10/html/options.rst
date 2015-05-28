Advanced Bash-Scripting Guide:

`Prev <debugging.html>`__

`Next <gotchas.html>`__

--------------

Chapter 33. Options
===================

Options are settings that change shell and/or script behavior.

The `set <internal.html#SETREF>`__ command enables options within a
script. At the point in the script where you want the options to take
effect, use **set -o option-name** or, in short form, **set
-option-abbrev**. These two forms are equivalent.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|           #!/bin/bash                                                    |
|                                                                          |
|           set -o verbose                                                 |
|           # Echoes all commands before executing.                        |
|                                                                          |
                                                                          
+--------------------------------------------------------------------------+

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|           #!/bin/bash                                                    |
|                                                                          |
|           set -v                                                         |
|           # Exact same effect as above.                                  |
|                                                                          |
                                                                          
+--------------------------------------------------------------------------+

+--------------------------------------+--------------------------------------+
| |Note|                               |
| To *disable* an option within a      |
| script, use **set +o option-name**   |
| or **set +option-abbrev**.           |
+--------------------------------------+--------------------------------------+

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|           #!/bin/bash                                                    |
|                                                                          |
|           set -o verbose                                                 |
|           # Command echoing on.                                          |
|           command                                                        |
|           ...                                                            |
|           command                                                        |
|                                                                          |
|           set +o verbose                                                 |
|           # Command echoing off.                                         |
|           command                                                        |
|           # Not echoed.                                                  |
|                                                                          |
|                                                                          |
|           set -v                                                         |
|           # Command echoing on.                                          |
|           command                                                        |
|           ...                                                            |
|           command                                                        |
|                                                                          |
|           set +v                                                         |
|           # Command echoing off.                                         |
|           command                                                        |
|                                                                          |
|           exit 0                                                         |
|                                                                          |
                                                                          
+--------------------------------------------------------------------------+

An alternate method of enabling options in a script is to specify them
immediately following the ``#!`` script header.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|           #!/bin/bash -x                                                 |
|           #                                                              |
|           # Body of script follows.                                      |
|                                                                          |
                                                                          
+--------------------------------------------------------------------------+

It is also possible to enable script options from the command line. Some
options that will not work with **set** are available this way. Among
these are ``-i``, force script to run interactive.

``bash -v script-name``

``bash -o verbose script-name``

The following is a listing of some useful options. They may be specified
in either abbreviated form (preceded by a single dash) or by complete
name (preceded by a *double* dash or by ``-o``).

**Table 33-1. Bash options**

+--------------------------+--------------------------+--------------------------+
| Abbreviation             |
| Name                     |
| Effect                   |
+==========================+==========================+==========================+
| ``-B``                   | ``+B``                   | ``-C``                   |
| brace expansion          | brace expansion          | noclobber                |
| *Enable* `brace          | *Disable* brace          | Prevent overwriting of   |
| expansion <special-chars | expansion                | files by redirection     |
| .html#BRACEEXPREF>`__    |                          | (may be overridden by    |
| (default setting = *on*) |                          | >\|)                     |
+--------------------------+--------------------------+--------------------------+

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <debugging.html>`_ | Debugging                |
| _                        | `Up <part5.html>`__      |
| `Home <index.html>`__    | Gotchas                  |
| `Next <gotchas.html>`__  |                          |
+--------------------------+--------------------------+--------------------------+

.. |Note| image:: ../images/note.gif
