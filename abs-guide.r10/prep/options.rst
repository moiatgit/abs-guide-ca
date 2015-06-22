.. raw:: html

   <div class="NAVHEADER">

.. raw:: html

   <table border="0" cellpadding="0" cellspacing="0" summary="Header navigation table" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <th align="center" colspan="3">

Advanced Bash-Scripting Guide:

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="bottom" width="10%">

`Prev <debugging.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <gotchas.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

--------------

.. raw:: html

   </div>

.. raw:: html

   <div class="CHAPTER">

  Chapter 33. Options
====================

Options are settings that change shell and/or script behavior.

The `set <internal.html#SETREF>`__ command enables options within a
script. At the point in the script where you want the options to take
effect, use **set -o option-name** or, in short form, **set
-option-abbrev** . These two forms are equivalent.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|           #!/bin/bash    |
|                          |
|           set -o verbose |
|           # Echoes all c |
| ommands before executing |
| .                        |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|           #!/bin/bash    |
|                          |
|           set -v         |
|           # Exact same e |
| ffect as above.          |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| To *disable* an option within a      |
| script, use **set +o option-name**   |
| or **set +option-abbrev** .          |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|           #!/bin/bash    |
|                          |
|           set -o verbose |
|           # Command echo |
| ing on.                  |
|           command        |
|           ...            |
|           command        |
|                          |
|           set +o verbose |
|           # Command echo |
| ing off.                 |
|           command        |
|           # Not echoed.  |
|                          |
|                          |
|           set -v         |
|           # Command echo |
| ing on.                  |
|           command        |
|           ...            |
|           command        |
|                          |
|           set +v         |
|           # Command echo |
| ing off.                 |
|           command        |
|                          |
|           exit 0         |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

An alternate method of enabling options in a script is to specify them
immediately following the ``             #!           `` script header.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|           #!/bin/bash -x |
|           #              |
|           # Body of scri |
| pt follows.              |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

It is also possible to enable script options from the command line. Some
options that will not work with **set** are available this way. Among
these are ``             -i           `` , force script to run
interactive.

``             bash -v script-name           ``

``             bash -o verbose script-name           ``

The following is a listing of some useful options. They may be specified
in either abbreviated form (preceded by a single dash) or by complete
name (preceded by a *double* dash or by ``      -o     `` ).

.. raw:: html

   <div class="TABLE">

**Table 33-1. Bash options**

.. raw:: html

   <table border="1" class="CALSTABLE">

.. raw:: html

   <thead>

.. raw:: html

   <tr>

.. raw:: html

   <th align="LEFT" valign="TOP">

Abbreviation

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Name

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Effect

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   </thead>

.. raw:: html

   <tbody>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -B         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

brace expansion

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*Enable* `brace expansion <special-chars.html#BRACEEXPREF>`__ (default
setting = *on* )

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          +B         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

brace expansion

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*Disable* brace expansion

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

 ``          -C         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

noclobber

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Prevent overwriting of files by redirection (may be overridden by >\| )

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -D         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

(none)

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

List double-quoted strings prefixed by $ , but do not execute commands
in script

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -a         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

allexport

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Export all defined variables

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -b         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

notify

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Notify when jobs running in background terminate (not of much use in a
script)

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -c ...         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

(none)

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Read commands from **...**

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          checkjobs         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Informs user of any open `jobs <x9644.html#JOBSREF>`__ upon shell exit.
Introduced in `version 4 <bashver4.html#BASH4REF>`__ of Bash, and still
"experimental." *Usage:* shopt -s checkjobs ( *Caution:* may hang!)

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -e         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

errexit

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Abort script at first error, when a command exits with non-zero status
(except in `until <loops1.html#UNTILLOOPREF>`__ or `while
loops <loops1.html#WHILELOOPREF>`__ ,
`if-tests <testconstructs.html#TESTCONSTRUCTS1>`__ , `list
constructs <list-cons.html#LCONS1>`__ )

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -f         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

noglob

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Filename expansion (globbing) disabled

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          globstar         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`*globbing* star-match <bashver4.html#GLOBSTARREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Enables the \*\* `globbing <globbingref.html>`__ operator ( `version
4+ <bashver4.html#BASH4REF>`__ of Bash). *Usage:* shopt -s globstar

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -i         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

interactive

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Script runs in *interactive* mode

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -n         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

noexec

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Read commands in script, but do not execute them (syntax check)

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -o Option-Name         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

(none)

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Invoke the *Option-Name* option

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -o posix         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

POSIX

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Change the behavior of Bash, or invoked script, to conform to
`POSIX <sha-bang.html#POSIX2REF>`__ standard.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -o pipefail         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

pipe failure

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Causes a pipeline to return the `exit
status <exit-status.html#EXITSTATUSREF>`__ of the last command in the
pipe that returned a non-zero return value.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -p         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

privileged

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Script runs as "suid" (caution!)

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -r         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

restricted

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Script runs in *restricted* mode (see `Chapter
22 <restricted-sh.html>`__ ).

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -s         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

stdin

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Read commands from ``          stdin         ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -t         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

(none)

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Exit after first command

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -u         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

nounset

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Attempt to use undefined variable outputs error message, and forces an
exit

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -v         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

verbose

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Print each command to ``          stdout         `` before executing it

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -x         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

xtrace

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Similar to ``          -v         `` , but expands commands

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

(none)

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

End of options flag. All other arguments are `positional
parameters <internalvariables.html#POSPARAMREF>`__ .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          --         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

(none)

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Unset positional parameters. If arguments given (
``                     -- arg1 arg2                   `` ), positional
parameters set to arguments.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </tbody>

.. raw:: html

   </table>

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <debugging.html>`_ | Debugging                |
| _                        | `Up <part5.html>`__      |
| `Home <index.html>`__    | Gotchas                  |
| `Next <gotchas.html>`__  |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
