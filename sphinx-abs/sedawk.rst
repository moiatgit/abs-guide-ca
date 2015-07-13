
###########################################
XXX  Appendix C. A Sed and Awk Micro-Primer
###########################################




**Table of Contents**



C.1. `Sed <x23170.html>`__



C.2. `Awk <awk.html>`__




This is a very brief introduction to the **sed** and **awk** text
processing utilities. We will deal with only a few basic commands here,
but that will suffice for understanding simple sed and awk constructs
within shell scripts.

**sed** : a non-interactive text file editor

**awk** : a field-oriented pattern processing language with a **C**
-style syntax

For all their differences, the two utilities share a similar invocation
syntax, use `regular expressions <regexp.html#REGEXREF>`__ , read input
by default from ``      stdin     `` , and output to
``      stdout     `` . These are well-behaved UNIX tools, and they work
together well. The output from one can be piped to the other, and their
combined capabilities give shell scripts some of the power of
`Perl <wrapper.html#PERLREF>`__ .



|Note|

One important difference between the utilities is that while shell
scripts can easily pass arguments to sed, it is more cumbersome for awk
(see `Example 36-5 <wrapper.html#COLTOTALER>`__ and `Example
28-2 <ivr.html#COLTOTALER2>`__ ).





.. |Note| image:: ../images/note.gif
