+----------------------------------+----+-----------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+====+=============================+
| `Prev <othertypesv.html>`_       |    | `Next <quotingvar.html>`_   |
+----------------------------------+----+-----------------------------+

--------------

Chapter 5. Quoting
==================

**Table of Contents**

5.1. `Quoting Variables <quotingvar.html>`_

5.2. `Escaping <escapingsection.html>`_

Quoting means just that, bracketing a string in quotes. This has the
effect of protecting `special
characters <special-chars.html#SCHARLIST1>`_ in the string from
reinterpretation or expansion by the shell or shell script. (A character
is "special" if it has an interpretation other than its literal meaning.
For example, the `asterisk \* <special-chars.html#ASTERISKREF>`_
represents a *wild card* character in `globbing <globbingref.html>`_ and
`Regular Expressions <regexp.html#REGEXREF>`_).

::

    bash$ ls -l [Vv]*
    -rw-rw-r--    1 bozo  bozo       324 Apr  2 15:05 VIEWDATA.BAT
     -rw-rw-r--    1 bozo  bozo       507 May  4 14:25 vartrace.sh
     -rw-rw-r--    1 bozo  bozo       539 Apr 14 17:11 viewdata.sh

    bash$ ls -l '[Vv]*'
    ls: [Vv]*: No such file or directory

In everyday speech or writing, when we "quote" a phrase, we set it apart
and give it special meaning. In a Bash script, when we *quote* a string,
we set it apart and protect its *literal* meaning.

Certain programs and utilities reinterpret or expand special characters
in a quoted string. An important use of quoting is protecting a
command-line parameter from the shell, but still letting the calling
program expand it.

::

    bash$ grep '[Ff]irst' *.txt
    file1.txt:This is the first line of file1.txt.
     file2.txt:This is the First line of file2.txt.

Note that the unquoted ``grep [Ff]irst *.txt`` works under the Bash
shell. `[1] <quoting.html#FTN.AEN2581>`_

Quoting can also suppress `echo's <internal.html#ECHOREF>`_ "appetite"
for newlines.

::

    bash$ echo $(ls -l)
    total 8 -rw-rw-r-- 1 bo bo 13 Aug 21 12:57 t.sh -rw-rw-r-- 1 bo bo 78 Aug 21 12:57 u.sh


    bash$ echo "$(ls -l)"
    total 8
     -rw-rw-r--  1 bo bo  13 Aug 21 12:57 t.sh
     -rw-rw-r--  1 bo bo  78 Aug 21 12:57 u.sh

Notes
~~~~~

`[1] <quoting.html#AEN2581>`_

Unless there is a file named ``first`` in the current working directory.
Yet another reason to *quote*. (Thank you, Harald Koenig, for pointing
this out.

--------------

+------------------------------+------------------------+-----------------------------+
| `Prev <othertypesv.html>`_   | `Home <index.html>`_   | `Next <quotingvar.html>`_   |
+------------------------------+------------------------+-----------------------------+
| Special Variable Types       | `Up <part2.html>`_     | Quoting Variables           |
+------------------------------+------------------------+-----------------------------+

