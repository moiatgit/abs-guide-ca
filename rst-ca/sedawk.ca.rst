+----------------------------------+----+-------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+====+=========================+
| `Prev <refcards.html>`_          |    | `Next <x22929.html>`_   |
+----------------------------------+----+-------------------------+

--------------

Appendix C. A Sed and Awk Micro-Primer
======================================

**Table of Contents**

C.1. `Sed <x22929.html>`_

C.2. `Awk <awk.html>`_

This is a very brief introduction to the **sed** and **awk** text
processing utilities. We will deal with only a few basic commands here,
but that will suffice for understanding simple sed and awk constructs
within shell scripts.

**sed**: a non-interactive text file editor

**awk**: a field-oriented pattern processing language with a **C**-style
syntax

For all their differences, the two utilities share a similar invocation
syntax, use `regular expressions <regexp.html#REGEXREF>`_, read input by
default from ``stdin``, and output to ``stdout``. These are well-behaved
UNIX tools, and they work together well. The output from one can be
piped to the other, and their combined capabilities give shell scripts
some of the power of `Perl <wrapper.html#PERLREF>`_.

.. figure:: http://tldp.org/LDP/abs/images/note.gif
   :align: center
   :alt: Note

   Note
One important difference between the utilities is that while shell
scripts can easily pass arguments to sed, it is more complicated for awk
(see `Example 36-5 <wrapper.html#COLTOTALER>`_ and `Example
28-2 <ivr.html#COLTOTALER2>`_).

--------------

+---------------------------+------------------------+-------------------------+
| `Prev <refcards.html>`_   | `Home <index.html>`_   | `Next <x22929.html>`_   |
+---------------------------+------------------------+-------------------------+
| Reference Cards           |                        | Sed                     |
+---------------------------+------------------------+-------------------------+

