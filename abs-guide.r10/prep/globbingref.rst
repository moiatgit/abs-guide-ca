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

`Prev <x17129.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 18. Regular Expressions

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <here-docs.html>`__

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

   <div class="SECT1">

  18.2. Globbing
===============

Bash itself cannot recognize Regular Expressions. Inside scripts, it is
commands and utilities -- such as `sed <sedawk.html#SEDREF>`__ and
`awk <awk.html#AWKREF>`__ -- that interpret RE's.

Bash *does* carry out *filename expansion* ` [1]
 <globbingref.html#FTN.AEN17572>`__ -- a process known as *globbing* --
but this does *not* use the standard RE set. Instead, globbing
recognizes and expands *wild cards* . Globbing interprets the standard
wild card characters ` [2]  <globbingref.html#FTN.AEN17581>`__ --
`\* <special-chars.html#ASTERISKREF>`__ and
`? <special-chars.html#WILDCARDQU>`__ , character lists in square
brackets, and certain other special characters (such as ^ for negating
the sense of a match). There are important limitations on wild card
characters in globbing, however. Strings containing
``             *           `` will not match filenames that start with a
dot, as, for example, ```       .bashrc      `` <sample-bashrc.html>`__
. ` [3]  <globbingref.html#FTN.AEN17592>`__ Likewise, the
``             ?           `` has a different meaning in globbing than
as part of an RE.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ ls -l          |
|     total 2              |
|      -rw-rw-r--    1 boz |
| o  bozo         0 Aug  6 |
|  18:42 a.1               |
|      -rw-rw-r--    1 boz |
| o  bozo         0 Aug  6 |
|  18:42 b.1               |
|      -rw-rw-r--    1 boz |
| o  bozo         0 Aug  6 |
|  18:42 c.1               |
|      -rw-rw-r--    1 boz |
| o  bozo       466 Aug  6 |
|  17:48 t2.sh             |
|      -rw-rw-r--    1 boz |
| o  bozo       758 Jul 30 |
|  09:02 test1.txt         |
|                          |
|     bash$ ls -l t?.sh    |
|     -rw-rw-r--    1 bozo |
|   bozo       466 Aug  6  |
| 17:48 t2.sh              |
|                          |
|     bash$ ls -l [ab]*    |
|     -rw-rw-r--    1 bozo |
|   bozo         0 Aug  6  |
| 18:42 a.1                |
|      -rw-rw-r--    1 boz |
| o  bozo         0 Aug  6 |
|  18:42 b.1               |
|                          |
|     bash$ ls -l [a-c]*   |
|     -rw-rw-r--    1 bozo |
|   bozo         0 Aug  6  |
| 18:42 a.1                |
|      -rw-rw-r--    1 boz |
| o  bozo         0 Aug  6 |
|  18:42 b.1               |
|      -rw-rw-r--    1 boz |
| o  bozo         0 Aug  6 |
|  18:42 c.1               |
|                          |
|     bash$ ls -l [^ab]*   |
|     -rw-rw-r--    1 bozo |
|   bozo         0 Aug  6  |
| 18:42 c.1                |
|      -rw-rw-r--    1 boz |
| o  bozo       466 Aug  6 |
|  17:48 t2.sh             |
|      -rw-rw-r--    1 boz |
| o  bozo       758 Jul 30 |
|  09:02 test1.txt         |
|                          |
|     bash$ ls -l {b*,c*,* |
| est*}                    |
|     -rw-rw-r--    1 bozo |
|   bozo         0 Aug  6  |
| 18:42 b.1                |
|      -rw-rw-r--    1 boz |
| o  bozo         0 Aug  6 |
|  18:42 c.1               |
|      -rw-rw-r--    1 boz |
| o  bozo       758 Jul 30 |
|  09:02 test1.txt         |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

Bash performs filename expansion on unquoted command-line arguments. The
`echo <internal.html#ECHOREF>`__ command demonstrates this.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ echo *         |
|     a.1 b.1 c.1 t2.sh te |
| st1.txt                  |
|                          |
|     bash$ echo t*        |
|     t2.sh test1.txt      |
|                          |
|     bash$ echo t?.sh     |
|     t2.sh                |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| It is possible to modify the way     |
| Bash interprets special characters   |
| in globbing. A **set -f** command    |
| disables globbing, and the           |
| ``          nocaseglob         ``    |
| and ``          nullglob         ``  |
| options to                           |
| `shopt <internal.html#SHOPTREF>`__   |
| change globbing behavior.            |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

See also `Example 11-5 <loops1.html#LISTGLOB>`__ .

.. raw:: html

   <div class="CAUTION">

+--------------------+--------------------+--------------------+--------------------+
| |Caution|          |
|  Filenames with    |
| embedded           |
| `whitespace <speci |
| al-chars.html#WHIT |
| ESPACEREF>`__      |
| can cause          |
| *globbing* to      |
| choke. `David      |
| Wheeler <http://ww |
| w.dwheeler.com/ess |
| ays/filenames-in-s |
| hell.html>`__      |
| shows how to avoid |
| many such          |
| pitfalls.          |
|                    |
| +----------------- |
| ---------+-------- |
| ------------------ |
| +----------------- |
| ---------+         |
| | .. code:: PROGRA |
| MLISTING |         |
| |                  |
|          |         |
| |     IFS="$(print |
| f '\n\t' |         |
| | )"   # Remove sp |
| ace.     |         |
| |                  |
|          |         |
| |     #  Correct g |
| lob use: |         |
| |     #  Always us |
| e for-lo |         |
| | op, prefix glob, |
|  check i |         |
| | f exists file.   |
|          |         |
| |     for file in  |
| ./* ; do |         |
| |          # Use . |
| /* ... N |         |
| | EVER bare *      |
|          |         |
| |       if [ -e "$ |
| file" ]  |         |
| | ; then   # Check |
|  whether |         |
| |  file exists.    |
|          |         |
| |          COMMAND |
|  ... "$f |         |
| | ile" ...         |
|          |         |
| |       fi         |
|          |         |
| |     done         |
|          |         |
| |                  |
|          |         |
| |     # This examp |
| le taken |         |
| |  from David Whee |
| ler's si |         |
| | te, with permiss |
| ion.     |         |
|                    |
|                    |
| +----------------- |
| ---------+-------- |
| ------------------ |
| +----------------- |
| ---------+         |
                    
+--------------------+--------------------+--------------------+--------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

.. raw:: html

   <table border="0" class="FOOTNOTES" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [1]  <globbingref.html#AEN17572>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

*Filename expansion* means expanding filename patterns or templates
containing special characters. For example,
``        example.???       `` might expand to
``        example.001       `` and/or ``        example.txt       `` .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [2]  <globbingref.html#AEN17581>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

 A *wild card* character, analogous to a wild card in poker, can
represent (almost) any other character.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [3]  <globbingref.html#AEN17592>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Filename expansion *can* match dotfiles, but only if the pattern
explicitly includes the dot as a literal character.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     ~/[.]bashrc    #  Wi |
| ll not expand to ~/.bash |
| rc                       |
|     ~/?bashrc      #  Ne |
| ither will this.         |
|                    #  Wi |
| ld cards and metacharact |
| ers will NOT             |
|                    #+ ex |
| pand to a dot in globbin |
| g.                       |
|                          |
|     ~/.[b]ashrc    #  Wi |
| ll expand to ~/.bashrc   |
|     ~/.ba?hrc      #  Li |
| kewise.                  |
|     ~/.bashr*      #  Li |
| kewise.                  |
|                          |
|     # Setting the "dotgl |
| ob" option turns this of |
| f.                       |
|                          |
|     # Thanks, S.C.       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <x17129.html>`__   | A Brief Introduction to  |
| `Home <index.html>`__    | Regular Expressions      |
| `Next <here-docs.html>`_ | `Up <regexp.html>`__     |
| _                        | Here Documents           |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Caution| image:: ../images/caution.gif
