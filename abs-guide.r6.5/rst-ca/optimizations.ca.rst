+----------------------------------+--------------------------+-------------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+==========================+===============================+
| `Prev <colorizing.html>`_        | Chapter 36. Miscellany   | `Next <assortedtips.html>`_   |
+----------------------------------+--------------------------+-------------------------------+

--------------

36.6. Optimizations
===================

Most shell scripts are quick 'n dirty solutions to non-complex problems.
As such, optimizing them for speed is not much of an issue. Consider the
case, though, where a script carries out an important task, does it
well, but runs too slowly. Rewriting it in a compiled language may not
be a palatable option. The simplest fix would be to rewrite the parts of
the script that slow it down. Is it possible to apply principles of code
optimization even to a lowly shell script?

Check the loops in the script. Time consumed by repetitive operations
adds up quickly. If at all possible, remove time-consuming operations
from within loops.

Use `builtin <internal.html#BUILTINREF>`_ commands in preference to
system commands. Builtins execute faster and usually do not launch a
subshell when invoked.

Avoid unnecessary commands, particularly in a
`pipe <special-chars.html#PIPEREF>`_.

::

    cat "$file" | grep "$word"

    grep "$word" "$file"

    #  The above command-lines have an identical effect,
    #+ but the second runs faster since it launches one fewer subprocess.

The `cat <basic.html#CATREF>`_ command seems especially prone to overuse
in scripts.

Use the `time <timedate.html#TIMREF>`_ and
`times <x9585.html#TIMESREF>`_ tools to profile computation-intensive
commands. Consider rewriting time-critical code sections in C, or even
in assembler.

Try to minimize file I/O. Bash is not particularly efficient at handling
files, so consider using more appropriate tools for this within the
script, such as `awk <awk.html#AWKREF>`_ or
`Perl <wrapper.html#PERLREF>`_.

Write your scripts in a modular and coherent form,
`[1] <optimizations.html#FTN.AEN20261>`_ so they can be reorganized and
tightened up as necessary. Some of the optimization techniques
applicable to high-level languages may work for scripts, but others,
such as *loop unrolling*, are mostly irrelevant. Above all, use common
sense.

For an excellent demonstration of how optimization can dramatically
reduce the execution time of a script, see `Example
16-47 <mathc.html#MONTHLYPMT>`_.

Notes
~~~~~

`[1] <optimizations.html#AEN20261>`_

This usually means liberal use of
`functions <functions.html#FUNCTIONREF>`_.

--------------

+-----------------------------+---------------------------+-------------------------------+
| `Prev <colorizing.html>`_   | `Home <index.html>`_      | `Next <assortedtips.html>`_   |
+-----------------------------+---------------------------+-------------------------------+
| "Colorizing" Scripts        | `Up <miscellany.html>`_   | Assorted Tips                 |
+-----------------------------+---------------------------+-------------------------------+

