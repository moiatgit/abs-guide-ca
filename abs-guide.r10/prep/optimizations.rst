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

`Prev <colorizing.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 36. Miscellany

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <assortedtips.html>`__

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

  36.6. Optimizations
====================

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

Use `builtin <internal.html#BUILTINREF>`__ commands in preference to
system commands. Builtins execute faster and usually do not launch a
subshell when invoked.

Avoid unnecessary commands, particularly in a
`pipe <special-chars.html#PIPEREF>`__ .

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     cat "$file" | grep " |
| $word"                   |
|                          |
|     grep "$word" "$file" |
|                          |
|     #  The above command |
| -lines have an identical |
|  effect,                 |
|     #+ but the second ru |
| ns faster since it launc |
| hes one fewer subprocess |
| .                        |
                          
+--------------------------+--------------------------+--------------------------+

The `cat <basic.html#CATREF>`__ command seems especially prone to
overuse in scripts.

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| Disabling certain Bash options can speed up scripts.                     |
|                                                                          |
| As Erik Brandsberg points out:                                           |
|                                                                          |
| If you don't need `Unicode <bashver4.html#UNICODEREF>`__ support, you    |
| can get potentially a 2x or more improvement in speed by simply setting  |
| the ``                     LC_ALL                   `` variable.         |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: PROGRAMLISTING |                                             |
| |                          |                                             |
| |        export LC_ALL=C   |                                             |
| |                          |                                             |
| |        [specifies the lo |                                             |
| | cale as ANSI C,          |                                             |
| |        thereby disabling |                                             |
| |  Unicode support]        |                                             |
| |                          |                                             |
| |     [In an example scrip |                                             |
| | t ...]                   |                                             |
| |                          |                                             |
| |     Without [Unicode sup |                                             |
| | port]:                   |                                             |
| |     erik@erik-desktop:~/ |                                             |
| | capture$ time ./cap-ngre |                                             |
| | p.sh                     |                                             |
| |     live2.pcap > out.txt |                                             |
| |                          |                                             |
| |       real        0m20.4 |                                             |
| | 83s                      |                                             |
| |       user        1m34.4 |                                             |
| | 70s                      |                                             |
| |       sys         0m12.8 |                                             |
| | 69s                      |                                             |
| |                          |                                             |
| |     With [Unicode suppor |                                             |
| | t]:                      |                                             |
| |     erik@erik-desktop:~/ |                                             |
| | capture$ time ./cap-ngre |                                             |
| | p.sh                     |                                             |
| |     live2.pcap > out.txt |                                             |
| |                          |                                             |
| |       real        0m50.2 |                                             |
| | 32s                      |                                             |
| |       user        3m51.1 |                                             |
| | 18s                      |                                             |
| |       sys         0m11.2 |                                             |
| | 21s                      |                                             |
| |                          |                                             |
| |     A large part of the  |                                             |
| | overhead that is optimiz |                                             |
| | ed is, I believe,        |                                             |
| |     regex match using [[ |                                             |
| |  string =~ REGEX ]],     |                                             |
| |     but it may help with |                                             |
| |  other portions of the c |                                             |
| | ode as well.             |                                             |
| |     I hadn't [seen it] m |                                             |
| | entioned that this optim |                                             |
| | ization helped           |                                             |
| |     with Bash, but I had |                                             |
| |  seen it helped with "gr |                                             |
| | ep,"                     |                                             |
| |     so why not try?      |                                             |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

.. raw:: html

   <div class="NOTE">

+------------+------------+------------+------------+------------+------------+------------+
| |Note|     |
| Certain    |
| operators, |
| notably    |
| `expr <mor |
| eadv.html# |
| EXPRREF>`_ |
| _          |
| , are very |
| inefficien |
| t          |
| and might  |
| be         |
| replaced   |
| by `double |
| parenthese |
| s <dblpare |
| ns.html>`_ |
| _          |
| arithmetic |
| expansion. |
| See        |
| `Example   |
| A-59 <cont |
| ributed-sc |
| ripts.html |
| #TESTEXECT |
| IME>`__    |
| .          |
|            |
| +--------- |
| ---------- |
| -------+-- |
| ---------- |
| ---------- |
| ----+----- |
| ---------- |
| ---------- |
| -+         |
| | .. code: |
| : PROGRAML |
| ISTING |   |
| |          |
|            |
|        |   |
| |     Math |
|  tests     |
|        |   |
| |          |
|            |
|        |   |
| |     math |
|  via $(( ) |
| )      |   |
| |     real |
|            |
| 0m0.29 |   |
| | 4s       |
|            |
|        |   |
| |     user |
|            |
| 0m0.28 |   |
| | 8s       |
|            |
|        |   |
| |     sys  |
|            |
| 0m0.00 |   |
| | 8s       |
|            |
|        |   |
| |          |
|            |
|        |   |
| |     math |
|  via expr: |
|        |   |
| |     real |
|            |
| 1m17.8 |   |
| | 79s   #  |
| Much slowe |
| r!     |   |
| |     user |
|            |
| 0m3.60 |   |
| | 0s       |
|            |
|        |   |
| |     sys  |
|            |
| 0m8.76 |   |
| | 5s       |
|            |
|        |   |
| |          |
|            |
|        |   |
| |     math |
|  via let:  |
|        |   |
| |     real |
|            |
| 0m0.36 |   |
| | 4s       |
|            |
|        |   |
| |     user |
|            |
| 0m0.37 |   |
| | 2s       |
|            |
|        |   |
| |     sys  |
|            |
| 0m0.00 |   |
| | 0s       |
|            |
|        |   |
|            |
|            |
|            |
| +--------- |
| ---------- |
| -------+-- |
| ---------- |
| ---------- |
| ----+----- |
| ---------- |
| ---------- |
| -+         |
|            |
| `Condition |
| testing <t |
| ests.html# |
| IFTHEN>`__ |
| constructs |
| in scripts |
| deserve    |
| close      |
| scrutiny.  |
| Substitute |
| `case <tes |
| tbranch.ht |
| ml#CASEESA |
| C1>`__     |
| for        |
| `if-then < |
| tests.html |
| #IFTHEN>`_ |
| _          |
| constructs |
| and        |
| combine    |
| tests when |
| possible,  |
| to         |
| minimize   |
| script     |
| execution  |
| time.      |
| Again,     |
| refer to   |
| `Example   |
| A-59 <cont |
| ributed-sc |
| ripts.html |
| #TESTEXECT |
| IME>`__    |
| .          |
|            |
| +--------- |
| ---------- |
| -------+-- |
| ---------- |
| ---------- |
| ----+----- |
| ---------- |
| ---------- |
| -+         |
| | .. code: |
| : PROGRAML |
| ISTING |   |
| |          |
|            |
|        |   |
| |     Test |
|  using "ca |
| se" co |   |
| | nstruct: |
|            |
|        |   |
| |     real |
|            |
| 0m0.32 |   |
| | 9s       |
|            |
|        |   |
| |     user |
|            |
| 0m0.32 |   |
| | 0s       |
|            |
|        |   |
| |     sys  |
|            |
| 0m0.00 |   |
| | 0s       |
|            |
|        |   |
| |          |
|            |
|        |   |
| |          |
|            |
|        |   |
| |     Test |
|  with if [ |
| ], no  |   |
| | quotes:  |
|            |
|        |   |
| |     real |
|            |
| 0m0.43 |   |
| | 8s       |
|            |
|        |   |
| |     user |
|            |
| 0m0.43 |   |
| | 2s       |
|            |
|        |   |
| |     sys  |
|            |
| 0m0.00 |   |
| | 8s       |
|            |
|        |   |
| |          |
|            |
|        |   |
| |          |
|            |
|        |   |
| |     Test |
|  with if [ |
| ], quo |   |
| | tes:     |
|            |
|        |   |
| |     real |
|            |
| 0m0.47 |   |
| | 6s       |
|            |
|        |   |
| |     user |
|            |
| 0m0.45 |   |
| | 2s       |
|            |
|        |   |
| |     sys  |
|            |
| 0m0.02 |   |
| | 4s       |
|            |
|        |   |
| |          |
|            |
|        |   |
| |          |
|            |
|        |   |
| |     Test |
|  with if [ |
| ], usi |   |
| | ng -eq:  |
|            |
|        |   |
| |     real |
|            |
| 0m0.45 |   |
| | 7s       |
|            |
|        |   |
| |     user |
|            |
| 0m0.45 |   |
| | 6s       |
|            |
|        |   |
| |     sys  |
|            |
| 0m0.00 |   |
| | 0s       |
|            |
|        |   |
|            |
|            |
|            |
| +--------- |
| ---------- |
| -------+-- |
| ---------- |
| ---------- |
| ----+----- |
| ---------- |
| ---------- |
| -+         |
            
+------------+------------+------------+------------+------------+------------+------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="NOTE">

+--------------------+--------------------+--------------------+--------------------+
| |Note|             |
| Erik Brandsberg    |
| recommends using   |
| `associative       |
| arrays <bashver4.h |
| tml#ASSOCARR>`__   |
| in preference to   |
| conventional       |
| numeric-indexed    |
| arrays in most     |
| cases. When        |
| overwriting values |
| in a numeric       |
| array, there is a  |
| significant        |
| performance        |
| penalty vs.        |
| associative        |
| arrays. Running a  |
| test script        |
| confirms this. See |
| `Example           |
| A-60 <contributed- |
| scripts.html#ASSOC |
| ARRTEST>`__        |
| .                  |
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
| |     Assignment t |
| ests     |         |
| |                  |
|          |         |
| |     Assigning a  |
| simple v |         |
| | ariable          |
|          |         |
| |     real         |
|   0m0.41 |         |
| | 8s               |
|          |         |
| |     user         |
|   0m0.41 |         |
| | 6s               |
|          |         |
| |     sys          |
|   0m0.00 |         |
| | 4s               |
|          |         |
| |                  |
|          |         |
| |     Assigning a  |
| numeric  |         |
| | index array entr |
| y        |         |
| |     real         |
|   0m0.58 |         |
| | 2s               |
|          |         |
| |     user         |
|   0m0.56 |         |
| | 4s               |
|          |         |
| |     sys          |
|   0m0.01 |         |
| | 6s               |
|          |         |
| |                  |
|          |         |
| |     Overwriting  |
| a numeri |         |
| | c index array en |
| try      |         |
| |     real         |
|   0m21.9 |         |
| | 31s              |
|          |         |
| |     user         |
|   0m21.9 |         |
| | 13s              |
|          |         |
| |     sys          |
|   0m0.01 |         |
| | 6s               |
|          |         |
| |                  |
|          |         |
| |     Linear readi |
| ng of nu |         |
| | meric index arra |
| y        |         |
| |     real         |
|   0m0.42 |         |
| | 2s               |
|          |         |
| |     user         |
|   0m0.41 |         |
| | 6s               |
|          |         |
| |     sys          |
|   0m0.00 |         |
| | 4s               |
|          |         |
| |                  |
|          |         |
| |     Assigning an |
|  associa |         |
| | tive array entry |
|          |         |
| |     real         |
|   0m1.80 |         |
| | 0s               |
|          |         |
| |     user         |
|   0m1.79 |         |
| | 6s               |
|          |         |
| |     sys          |
|   0m0.00 |         |
| | 4s               |
|          |         |
| |                  |
|          |         |
| |     Overwriting  |
| an assoc |         |
| | iative array ent |
| ry       |         |
| |     real         |
|   0m1.79 |         |
| | 8s               |
|          |         |
| |     user         |
|   0m1.78 |         |
| | 4s               |
|          |         |
| |     sys          |
|   0m0.01 |         |
| | 2s               |
|          |         |
| |                  |
|          |         |
| |     Linear readi |
| ng an as |         |
| | sociative array  |
| entry    |         |
| |     real         |
|   0m0.42 |         |
| | 0s               |
|          |         |
| |     user         |
|   0m0.42 |         |
| | 0s               |
|          |         |
| |     sys          |
|   0m0.00 |         |
| | 0s               |
|          |         |
| |                  |
|          |         |
| |     Assigning a  |
| random n |         |
| | umber to a simpl |
| e variab |         |
| | le               |
|          |         |
| |     real         |
|   0m0.40 |         |
| | 2s               |
|          |         |
| |     user         |
|   0m0.38 |         |
| | 8s               |
|          |         |
| |     sys          |
|   0m0.01 |         |
| | 6s               |
|          |         |
| |                  |
|          |         |
| |     Assigning a  |
| sparse n |         |
| | umeric index arr |
| ay entry |         |
| |  randomly into 6 |
| 4k cells |         |
| |     real         |
|   0m12.6 |         |
| | 78s              |
|          |         |
| |     user         |
|   0m12.6 |         |
| | 49s              |
|          |         |
| |     sys          |
|   0m0.02 |         |
| | 8s               |
|          |         |
| |                  |
|          |         |
| |     Reading spar |
| se numer |         |
| | ic index array e |
| ntry     |         |
| |     real         |
|   0m0.08 |         |
| | 7s               |
|          |         |
| |     user         |
|   0m0.08 |         |
| | 4s               |
|          |         |
| |     sys          |
|   0m0.00 |         |
| | 0s               |
|          |         |
| |                  |
|          |         |
| |     Assigning a  |
| sparse a |         |
| | ssociative array |
|  entry r |         |
| | andomly into 64k |
|  cells   |         |
| |     real         |
|   0m0.69 |         |
| | 8s               |
|          |         |
| |     user         |
|   0m0.69 |         |
| | 6s               |
|          |         |
| |     sys          |
|   0m0.00 |         |
| | 4s               |
|          |         |
| |                  |
|          |         |
| |     Reading spar |
| se assoc |         |
| | iative index arr |
| ay entry |         |
| |     real         |
|   0m0.08 |         |
| | 3s               |
|          |         |
| |     user         |
|   0m0.08 |         |
| | 4s               |
|          |         |
| |     sys          |
|   0m0.00 |         |
| | 0s               |
|          |         |
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

Use the `time <timedate.html#TIMREF>`__ and
`times <x9644.html#TIMESREF>`__ tools to profile computation-intensive
commands. Consider rewriting time-critical code sections in C, or even
in assembler.

Try to minimize file I/O. Bash is not particularly efficient at handling
files, so consider using more appropriate tools for this within the
script, such as `awk <awk.html#AWKREF>`__ or
`Perl <wrapper.html#PERLREF>`__ .

Write your scripts in a modular and coherent form, ` [1]
 <optimizations.html#FTN.AEN20452>`__ so they can be reorganized and
tightened up as necessary. Some of the optimization techniques
applicable to high-level languages may work for scripts, but others,
such as *loop unrolling* , are mostly irrelevant. Above all, use common
sense.

For an excellent demonstration of how optimization can dramatically
reduce the execution time of a script, see `Example
16-47 <mathc.html#MONTHLYPMT>`__ .

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]                                |
|  <optimizations.html#AEN20452>`__    |
| This usually means liberal use of    |
| `functions <functions.html#FUNCTIONR |
| EF>`__                               |
| .                                    |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <colorizing.html>` |  "Colorizing" Scripts    |
| __                       | `Up <miscellany.html>`__ |
| `Home <index.html>`__    | Assorted Tips            |
| `Next <assortedtips.html |                          |
| >`__                     |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
