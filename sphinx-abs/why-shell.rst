#############################
XXX Perquè programar en Shell
#############################

    *No programming language is perfect. There is not even a single best
    language; there are only languages well suited or perhaps poorly suited
    for particular purposes.*

    -- Herbert Mayer


A qualsevol persona que vulgui administrar sistemes de manera
raonablement eficient, li cal saber-se manegar amb la programació de
guions.
Fins i tot, per a aquells que encara no se'ls hagi passat pel cap que
algun dia els podria ser necessari escriure un guió.

A working knowledge of shell scripting is essential to anyone wishing to
become reasonably proficient at system administration, even if they do
not anticipate ever having to actually write a script. Consider that as
a Linux machine boots up, it executes the shell scripts in ``/etc/rc.d``
to restore the system configuration and set up services. A detailed
understanding of these startup scripts is important for analyzing the
behavior of a system, and possibly modifying it.

The craft of scripting is not hard to master, since scripts can be built
in bite-sized sections and there is only a fairly small set of
shell-specific operators and options `[1] <why-shell.html#FTN.AEN62>`__
to learn. The syntax is simple -- even austere -- similar to that of
invoking and chaining together utilities at the command line, and there
are only a few "rules" governing their use. Most short scripts work
right the first time, and debugging even the longer ones is
straightforward.

    |     In the early days of personal computing, the BASIC language enabled
    | 
        anyone reasonably computer proficient to write programs on an early
    | 
        generation of microcomputers. Decades later, the Bash scripting
    | 
        language enables anyone with a rudimentary knowledge of Linux or
    |      UNIX to do the same on modern machines.
    |      We now have miniaturized single-board computers with amazing
    |      capabilities, such as the `Raspberry
    Pi <http://www.raspberrypi.org/>`__.
    | 
        Bash scripting provides a way to explore the capabilities of these
    |      fascinating devices.
    |              

A shell script is a quick-and-dirty method of prototyping a complex
application. Getting even a limited subset of the functionality to work
in a script is often a useful first stage in project development. In
this way, the structure of the application can be tested and tinkered
with, and the major pitfalls found before proceeding to the final coding
in *C*, *C++*, *Java*, `Perl <wrapper.html#PERLREF>`__, or *Python*.

Shell scripting hearkens back to the classic UNIX philosophy of breaking
complex projects into simpler subtasks, of chaining together components
and utilities. Many consider this a better, or at least more
esthetically pleasing approach to problem solving than using one of the
new generation of high-powered all-in-one languages, such as *Perl*,
which attempt to be all things to all people, but at the cost of forcing
you to alter your thinking processes to fit the tool.

According to `Herbert Mayer <biblio.html#MAYERREF>`__, "a useful
language needs arrays, pointers, and a generic mechanism for building
data structures." By these criteria, shell scripting falls somewhat
short of being "useful." Or, perhaps not. . . .


When not to use shell scripts

-  Resource-intensive tasks, especially where speed is a factor (sorting, hashing, recursion `[2] <why -shell.html# FTN.AEN87>`_ _ ...)

-  Procedures involving heavy-dut y math operation s, especiall y floating point arithmeti c, arbitrary precision calculati ons, or complex numbers (use *C* or *FORTRAN* instead)

-  Cross-pla tform portabili ty required (use *C* or *Java* instead)

-  Complex applicati ons, where structure d programmi ng is a necessity (type-che cking of variables , function prototype s, etc.)

-  Mission-c ritical applicati ons upon which you are betting the future of the company

-  Situation s where *security * is important , where you need to guarantee the integrity of your system and protect against intrusion , cracking, and vandalism

-  Project consists of subcompon ents with interlock ing dependenc ies

-  Extensive file operation s required (*Bash* is limited to serial file access, and that only in a particula rly clumsy and inefficie nt line-by-l ine fashion.)

-  Need native support for multi-dim ensional arrays

-  Need data structure s, such as linked lists or trees

-  Need to generate / manipulat e graphics or GUIs

-  Need direct access to system hardware or external periphera ls

-  Need port or `socket < devref1.html #SOCKETREF>` __ I/O -  Need to use libraries or interface with legacy code

-  Proprieta ry, closed-so urce applicati ons (Shell scripts put the source code right out in the open for all the world to see.)

If any of the above applies, consider a more powerful scripting language -- perhaps *Perl*, *Tcl*, *Python*, *Ruby* -- or possibly a compiled language such as *C*, *C*, or *Java*. Even then, prototyping the application as a shell script might still be a useful development step.


We will be using Bash, an acronym `[3] <why-shell.html#FTN.AEN139>`__
for "Bourne-Again shell" and a pun on Stephen Bourne's now classic
*Bourne* shell. Bash has become a *de facto* standard for shell
scripting on most flavors of UNIX. Most of the principles this book
covers apply equally well to scripting with other shells, such as the
*Korn Shell*, from which Bash derives some of its features,
`[4] <why-shell.html#FTN.AEN147>`__ and the *C Shell* and its variants.
(Note that *C Shell* programming is not recommended due to certain
inherent problems, as pointed out in an October, 1993 `Usenet
post <http://www.faqs.org/faqs/unix-faq/shell/csh-whynot/>`__ by Tom
Christiansen.)

What follows is a tutorial on shell scripting. It relies heavily on
examples to illustrate various features of the shell. The example
scripts work -- they've been tested, insofar as possible -- and some of
them are even useful in real life. The reader can play with the actual
working code of the examples in the source archive (``scriptname.sh`` or
``scriptname.bash``), `[5] <why-shell.html#FTN.AEN157>`__ give them
*execute* permission (``chmod u+rx scriptname``), then run them to see
what happens. Should the `source
archive <http://bash.deta.in/abs-guide-latest.tar.bz2>`__ not be
available, then cut-and-paste from the
`HTML <http://www.tldp.org/LDP/abs/abs-guide.html.tar.gz>`__ or
`pdf <http://bash.deta.in/abs-guide.pdf>`__ rendered versions. Be aware
that some of the scripts presented here introduce features before they
are explained, and this may require the reader to temporarily skip ahead
for enlightenment.

Unless otherwise noted, `the author <mailto:thegrendel.abs@gmail.com>`__
of this book wrote the example scripts that follow.


 
    *His countenance was bold and bashed not.* 

    -- Edmund Spenser


.. rubric:: Footnotes

.. [1] <why-shell.html#AEN62> These are referred to as `builtins <internal.html#BUILTINREF> `__, features internal to the shell.

.. [2] <why-shell.html#AEN87> Although `recursion *is* possible in a shell script <localvar.html#RECURSIONREF0> `__, it tends to be slow and its implementation is often an `ugly kludge <recurnolocvar.html#FIBOREF>` __.

.. [3]	An acronym is an ersatz word formed by pasting together the initial letters of the words into a tongue-tripping phrase. This morally corrupt and pernicious practice deserves appropriately severe punishment. Public flogging suggests itself.

.. [4]	Many of the features of ksh88, and even a few from the updated ksh93 have been merged into Bash.

.. [5]	By convention, user-written shell scripts that are Bourne shell compliant generally take a name with a .sh extension. System scripts, such as those found in /etc/rc.d, do not necessarily conform to this nomenclature.
