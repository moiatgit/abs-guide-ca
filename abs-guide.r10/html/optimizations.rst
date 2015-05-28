Advanced Bash-Scripting Guide:

`Prev <colorizing.html>`__

Chapter 36. Miscellany

`Next <assortedtips.html>`__

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

Use `builtin <internal.html#BUILTINREF>`__ commands in preference to
system commands. Builtins execute faster and usually do not launch a
subshell when invoked.

Avoid unnecessary commands, particularly in a
`pipe <special-chars.html#PIPEREF>`__.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     cat "$file" | grep "$word"                                           |
|                                                                          |
|     grep "$word" "$file"                                                 |
|                                                                          |
|     #  The above command-lines have an identical effect,                 |
|     #+ but the second runs faster since it launches one fewer subprocess |
| .                                                                        |
                                                                          
+--------------------------------------------------------------------------+

The `cat <basic.html#CATREF>`__ command seems especially prone to
overuse in scripts.

+--------------+--------------+--------------+--------------+--------------+--------------+
| Disabling    |
| certain Bash |
| options can  |
| speed up     |
| scripts.     |
|              |
| As Erik      |
| Brandsberg   |
| points out:  |
|              |
| If you don't |
| need         |
| `Unicode <ba |
| shver4.html# |
| UNICODEREF>` |
| __           |
| support, you |
| can get      |
| potentially  |
| a 2x or more |
| improvement  |
| in speed by  |
| simply       |
| setting the  |
| ``LC_ALL``   |
| variable.    |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
| | .. code::  |
| PROGRAMLISTI |
| NG           |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |        exp |
| ort LC_ALL=C |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |        [sp |
| ecifies the  |
| locale as AN |
| SI C,        |
|              |
|              |
|    |         |
| |        the |
| reby disabli |
| ng Unicode s |
| upport]      |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     [In an |
|  example scr |
| ipt ...]     |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     Withou |
| t [Unicode s |
| upport]:     |
|              |
|              |
|              |
|    |         |
| |     erik@e |
| rik-desktop: |
| ~/capture$ t |
| ime ./cap-ng |
| rep.sh       |
|              |
|    |         |
| |     live2. |
| pcap > out.t |
| xt           |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |       real |
|         0m20 |
| .483s        |
|              |
|              |
|              |
|    |         |
| |       user |
|         1m34 |
| .470s        |
|              |
|              |
|              |
|    |         |
| |       sys  |
|         0m12 |
| .869s        |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     With [ |
| Unicode supp |
| ort]:        |
|              |
|              |
|              |
|    |         |
| |     erik@e |
| rik-desktop: |
| ~/capture$ t |
| ime ./cap-ng |
| rep.sh       |
|              |
|    |         |
| |     live2. |
| pcap > out.t |
| xt           |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |       real |
|         0m50 |
| .232s        |
|              |
|              |
|              |
|    |         |
| |       user |
|         3m51 |
| .118s        |
|              |
|              |
|              |
|    |         |
| |       sys  |
|         0m11 |
| .221s        |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     A larg |
| e part of th |
| e overhead t |
| hat is optim |
| ized is, I b |
| elieve,      |
|    |         |
| |     regex  |
| match using  |
| [[ string =~ |
|  REGEX ]],   |
|              |
|              |
|    |         |
| |     but it |
|  may help wi |
| th other por |
| tions of the |
|  code as wel |
| l.           |
|    |         |
| |     I hadn |
| 't [seen it] |
|  mentioned t |
| hat this opt |
| imization he |
| lped         |
|    |         |
| |     with B |
| ash, but I h |
| ad seen it h |
| elped with " |
| grep,"       |
|              |
|    |         |
| |     so why |
|  not try?    |
|              |
|              |
|              |
|              |
|    |         |
|              |
|              |
|              |
|              |
|              |
|              |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
|              |
              
+--------------+--------------+--------------+--------------+--------------+--------------+

+------------+------------+------------+------------+------------+------------+------------+
| |Note|     |
| Certain    |
| operators, |
| notably    |
| `expr <mor |
| eadv.html# |
| EXPRREF>`_ |
| _,         |
| are very   |
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
| IME>`__.   |
|            |
| +--------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| -----+     |
| | .. code: |
| : PROGRAML |
| ISTING     |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |     Math |
|  tests     |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |     math |
|  via $(( ) |
| )          |
|            |
|            |
|            |
|            |
|      |     |
| |     real |
|            |
| 0m0.294s   |
|            |
|            |
|            |
|            |
|      |     |
| |     user |
|            |
| 0m0.288s   |
|            |
|            |
|            |
|            |
|      |     |
| |     sys  |
|            |
| 0m0.008s   |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |     math |
|  via expr: |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |     real |
|            |
| 1m17.879s  |
|   # Much s |
| lower!     |
|            |
|            |
|      |     |
| |     user |
|            |
| 0m3.600s   |
|            |
|            |
|            |
|            |
|      |     |
| |     sys  |
|            |
| 0m8.765s   |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |     math |
|  via let:  |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |     real |
|            |
| 0m0.364s   |
|            |
|            |
|            |
|            |
|      |     |
| |     user |
|            |
| 0m0.372s   |
|            |
|            |
|            |
|            |
|      |     |
| |     sys  |
|            |
| 0m0.000s   |
|            |
|            |
|            |
|            |
|      |     |
|            |
|            |
|            |
|            |
|            |
|            |
|            |
|            |
| +--------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| -----+     |
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
| IME>`__.   |
|            |
| +--------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| -----+     |
| | .. code: |
| : PROGRAML |
| ISTING     |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |     Test |
|  using "ca |
| se" constr |
| uct:       |
|            |
|            |
|            |
|      |     |
| |     real |
|            |
| 0m0.329s   |
|            |
|            |
|            |
|            |
|      |     |
| |     user |
|            |
| 0m0.320s   |
|            |
|            |
|            |
|            |
|      |     |
| |     sys  |
|            |
| 0m0.000s   |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |     Test |
|  with if [ |
| ], no quot |
| es:        |
|            |
|            |
|            |
|      |     |
| |     real |
|            |
| 0m0.438s   |
|            |
|            |
|            |
|            |
|      |     |
| |     user |
|            |
| 0m0.432s   |
|            |
|            |
|            |
|            |
|      |     |
| |     sys  |
|            |
| 0m0.008s   |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |     Test |
|  with if [ |
| ], quotes: |
|            |
|            |
|            |
|            |
|      |     |
| |     real |
|            |
| 0m0.476s   |
|            |
|            |
|            |
|            |
|      |     |
| |     user |
|            |
| 0m0.452s   |
|            |
|            |
|            |
|            |
|      |     |
| |     sys  |
|            |
| 0m0.024s   |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |          |
|            |
|            |
|            |
|            |
|            |
|            |
|      |     |
| |     Test |
|  with if [ |
| ], using - |
| eq:        |
|            |
|            |
|            |
|      |     |
| |     real |
|            |
| 0m0.457s   |
|            |
|            |
|            |
|            |
|      |     |
| |     user |
|            |
| 0m0.456s   |
|            |
|            |
|            |
|            |
|      |     |
| |     sys  |
|            |
| 0m0.000s   |
|            |
|            |
|            |
|            |
|      |     |
|            |
|            |
|            |
|            |
|            |
|            |
|            |
|            |
| +--------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| ---------- |
| -----+     |
            
+------------+------------+------------+------------+------------+------------+------------+

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
| ARRTEST>`__.       |
|                    |
| +----------------- |
| ------------------ |
| ------------------ |
| ------------------ |
| ---+               |
| | .. code:: PROGRA |
| MLISTING           |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Assignment t |
| ests               |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Assigning a  |
| simple variable    |
|                    |
|                    |
|    |               |
| |     real         |
|   0m0.418s         |
|                    |
|                    |
|    |               |
| |     user         |
|   0m0.416s         |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.004s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Assigning a  |
| numeric index arra |
| y entry            |
|                    |
|    |               |
| |     real         |
|   0m0.582s         |
|                    |
|                    |
|    |               |
| |     user         |
|   0m0.564s         |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.016s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Overwriting  |
| a numeric index ar |
| ray entry          |
|                    |
|    |               |
| |     real         |
|   0m21.931s        |
|                    |
|                    |
|    |               |
| |     user         |
|   0m21.913s        |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.016s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Linear readi |
| ng of numeric inde |
| x array            |
|                    |
|    |               |
| |     real         |
|   0m0.422s         |
|                    |
|                    |
|    |               |
| |     user         |
|   0m0.416s         |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.004s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Assigning an |
|  associative array |
|  entry             |
|                    |
|    |               |
| |     real         |
|   0m1.800s         |
|                    |
|                    |
|    |               |
| |     user         |
|   0m1.796s         |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.004s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Overwriting  |
| an associative arr |
| ay entry           |
|                    |
|    |               |
| |     real         |
|   0m1.798s         |
|                    |
|                    |
|    |               |
| |     user         |
|   0m1.784s         |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.012s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Linear readi |
| ng an associative  |
| array entry        |
|                    |
|    |               |
| |     real         |
|   0m0.420s         |
|                    |
|                    |
|    |               |
| |     user         |
|   0m0.420s         |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.000s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Assigning a  |
| random number to a |
|  simple variable   |
|                    |
|    |               |
| |     real         |
|   0m0.402s         |
|                    |
|                    |
|    |               |
| |     user         |
|   0m0.388s         |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.016s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Assigning a  |
| sparse numeric ind |
| ex array entry ran |
| domly into 64k cel |
| ls |               |
| |     real         |
|   0m12.678s        |
|                    |
|                    |
|    |               |
| |     user         |
|   0m12.649s        |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.028s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Reading spar |
| se numeric index a |
| rray entry         |
|                    |
|    |               |
| |     real         |
|   0m0.087s         |
|                    |
|                    |
|    |               |
| |     user         |
|   0m0.084s         |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.000s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Assigning a  |
| sparse associative |
|  array entry rando |
| mly into 64k cells |
|    |               |
| |     real         |
|   0m0.698s         |
|                    |
|                    |
|    |               |
| |     user         |
|   0m0.696s         |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.004s         |
|                    |
|                    |
|    |               |
| |                  |
|                    |
|                    |
|                    |
|    |               |
| |     Reading spar |
| se associative ind |
| ex array entry     |
|                    |
|    |               |
| |     real         |
|   0m0.083s         |
|                    |
|                    |
|    |               |
| |     user         |
|   0m0.084s         |
|                    |
|                    |
|    |               |
| |     sys          |
|   0m0.000s         |
|                    |
|                    |
|    |               |
|                    |
|                    |
|                    |
|                    |
|                    |
| +----------------- |
| ------------------ |
| ------------------ |
| ------------------ |
| ---+               |
                    
+--------------------+--------------------+--------------------+--------------------+

Use the `time <timedate.html#TIMREF>`__ and
`times <x9644.html#TIMESREF>`__ tools to profile computation-intensive
commands. Consider rewriting time-critical code sections in C, or even
in assembler.

Try to minimize file I/O. Bash is not particularly efficient at handling
files, so consider using more appropriate tools for this within the
script, such as `awk <awk.html#AWKREF>`__ or
`Perl <wrapper.html#PERLREF>`__.

Write your scripts in a modular and coherent form,
`[1] <optimizations.html#FTN.AEN20452>`__ so they can be reorganized and
tightened up as necessary. Some of the optimization techniques
applicable to high-level languages may work for scripts, but others,
such as *loop unrolling*, are mostly irrelevant. Above all, use common
sense.

For an excellent demonstration of how optimization can dramatically
reduce the execution time of a script, see `Example
16-47 <mathc.html#MONTHLYPMT>`__.

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <optimizations.html#AEN20452>`_ |
| _                                    |
| This usually means liberal use of    |
| `functions <functions.html#FUNCTIONR |
| EF>`__.                              |
+--------------------------------------+--------------------------------------+

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <colorizing.html>` | "Colorizing" Scripts     |
| __                       | `Up <miscellany.html>`__ |
| `Home <index.html>`__    | Assorted Tips            |
| `Next <assortedtips.html |                          |
| >`__                     |                          |
+--------------------------+--------------------------+--------------------------+

.. |Note| image:: ../images/note.gif
