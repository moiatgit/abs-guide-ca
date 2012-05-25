+----------------------------------+-----------------------------------+----------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+===================================+============================+
| `Prev <x17000.html>`_            | Chapter 18. Regular Expressions   | `Next <here-docs.html>`_   |
+----------------------------------+-----------------------------------+----------------------------+

--------------

18.2. Globbing
==============

Bash itself cannot recognize Regular Expressions. Inside scripts, it is
commands and utilities -- such as `sed <sedawk.html#SEDREF>`_ and
`awk <awk.html#AWKREF>`_ -- that interpret RE's.

Bash *does* carry out *filename expansion*
`[1] <globbingref.html#FTN.AEN17443>`_ -- a process known as *globbing*
-- but this does *not* use the standard RE set. Instead, globbing
recognizes and expands *wild cards*. Globbing interprets the standard
wild card characters `[2] <globbingref.html#FTN.AEN17452>`_ --
`\* <special-chars.html#ASTERISKREF>`_ and
`? <special-chars.html#WILDCARDQU>`_, character lists in square
brackets, and certain other special characters (such as ^ for negating
the sense of a match). There are important limitations on wild card
characters in globbing, however. Strings containing ``*`` will not match
filenames that start with a dot, as, for example,
```.bashrc`` <sample-bashrc.html>`_.
`[3] <globbingref.html#FTN.AEN17463>`_ Likewise, the ``?`` has a
different meaning in globbing than as part of an RE.

::

    bash$ ls -l
    total 2
     -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 a.1
     -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 b.1
     -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 c.1
     -rw-rw-r--    1 bozo  bozo       466 Aug  6 17:48 t2.sh
     -rw-rw-r--    1 bozo  bozo       758 Jul 30 09:02 test1.txt

    bash$ ls -l t?.sh
    -rw-rw-r--    1 bozo  bozo       466 Aug  6 17:48 t2.sh

    bash$ ls -l [ab]*
    -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 a.1
     -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 b.1

    bash$ ls -l [a-c]*
    -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 a.1
     -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 b.1
     -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 c.1

    bash$ ls -l [^ab]*
    -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 c.1
     -rw-rw-r--    1 bozo  bozo       466 Aug  6 17:48 t2.sh
     -rw-rw-r--    1 bozo  bozo       758 Jul 30 09:02 test1.txt

    bash$ ls -l {b*,c*,*est*}
    -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 b.1
     -rw-rw-r--    1 bozo  bozo         0 Aug  6 18:42 c.1
     -rw-rw-r--    1 bozo  bozo       758 Jul 30 09:02 test1.txt
              

Bash performs filename expansion on unquoted command-line arguments. The
`echo <internal.html#ECHOREF>`_ command demonstrates this.

::

    bash$ echo *
    a.1 b.1 c.1 t2.sh test1.txt

    bash$ echo t*
    t2.sh test1.txt

    bash$ echo t?.sh
    t2.sh
              

.. figure:: http://tldp.org/LDP/abs/images/note.gif
   :align: center
   :alt: Note

   Note
It is possible to modify the way Bash interprets special characters in
globbing. A **set -f** command disables globbing, and the ``nocaseglob``
and ``nullglob`` options to `shopt <internal.html#SHOPTREF>`_ change
globbing behavior.

See also `Example 11-4 <loops1.html#LISTGLOB>`_.

Notes
~~~~~

`[1] <globbingref.html#AEN17443>`_

*Filename expansion* means expanding filename patterns or templates
containing special characters. For example, ``example.???`` might expand
to ``example.001`` and/or ``example.txt``.

`[2] <globbingref.html#AEN17452>`_

A *wild card* character, analogous to a wild card in poker, can
represent (almost) any other character.

`[3] <globbingref.html#AEN17463>`_

Filename expansion *can* match dotfiles, but only if the pattern
explicitly includes the dot as a literal character.

::

    ~/[.]bashrc    #  Will not expand to ~/.bashrc
    ~/?bashrc      #  Neither will this.
                   #  Wild cards and metacharacters will NOT
                   #+ expand to a dot in globbing.

    ~/.[b]ashrc    #  Will expand to ~/.bashrc
    ~/.ba?hrc      #  Likewise.
    ~/.bashr*      #  Likewise.

    # Setting the "dotglob" option turns this off.

    # Thanks, S.C.

--------------

+-----------------------------------------------+------------------------+----------------------------+
| `Prev <x17000.html>`_                         | `Home <index.html>`_   | `Next <here-docs.html>`_   |
+-----------------------------------------------+------------------------+----------------------------+
| A Brief Introduction to Regular Expressions   | `Up <regexp.html>`_    | Here Documents             |
+-----------------------------------------------+------------------------+----------------------------+

