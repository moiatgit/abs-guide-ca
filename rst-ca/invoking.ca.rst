+----------------------------------+-------------------------------------------+-----------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+===========================================+=============================+
| `Prev <sha-bang.html>`_          | Chapter 2. Starting Off With a Sha-Bang   | `Next <prelimexer.html>`_   |
+----------------------------------+-------------------------------------------+-----------------------------+

--------------

2.1. Invoking the script
========================

Having written the script, you can invoke it by ``sh     scriptname``,
`[1] <invoking.html#FTN.AEN296>`_ or alternatively ``bash scriptname``.
(Not recommended is using ``sh <scriptname``, since this effectively
disables reading from ```stdin`` <ioredirintro.html#STDINOUTDEF>`_
within the script.) Much more convenient is to make the script itself
directly executable with a `chmod <basic.html#CHMODREF>`_.

Either:
    ``chmod 555 scriptname`` (gives everyone read/execute permission)
    `[2] <invoking.html#FTN.AEN311>`_

or
    ``chmod +rx scriptname`` (gives everyone read/execute permission)

    ``chmod           u+rx scriptname`` (gives only the script owner
    read/execute permission)

Having made the script executable, you may now test it by
``./scriptname``. `[3] <invoking.html#FTN.AEN323>`_ If it begins with a
"sha-bang" line, invoking the script calls the correct command
interpreter to run it.

As a final step, after testing and debugging, you would likely want to
move it to ``/usr/local/bin`` (as *root*, of course), to make the script
available to yourself and all other users as a systemwide executable.
The script could then be invoked by simply typing **scriptname**
**[ENTER]** from the command-line.

Notes
~~~~~

`[1] <invoking.html#AEN296>`_

Caution: invoking a *Bash* script by ``sh scriptname`` turns off
Bash-specific extensions, and the script may therefore fail to execute.

`[2] <invoking.html#AEN311>`_

A script needs *read*, as well as execute permission for it to run,
since the shell needs to be able to read it.

`[3] <invoking.html#AEN323>`_

Why not simply invoke the script with ``scriptname``? If the directory
you are in (`$PWD <internalvariables.html#PWDREF>`_) is where
``scriptname`` is located, why doesn't this work? This fails because,
for security reasons, the current directory (``./``) is not by default
included in a user's `$PATH <internalvariables.html#PATHREF>`_. It is
therefore necessary to explicitly invoke the script in the current
directory with a ``./scriptname``.

--------------

+--------------------------------+-------------------------+-----------------------------+
| `Prev <sha-bang.html>`_        | `Home <index.html>`_    | `Next <prelimexer.html>`_   |
+--------------------------------+-------------------------+-----------------------------+
| Starting Off With a Sha-Bang   | `Up <sha-bang.html>`_   | Preliminary Exercises       |
+--------------------------------+-------------------------+-----------------------------+

