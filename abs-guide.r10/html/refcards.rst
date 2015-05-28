Advanced Bash-Scripting Guide:

`Prev <contributed-scripts.html>`__

`Next <sedawk.html>`__

--------------

Appendix B. Reference Cards
===========================

The following reference cards provide a useful *summary* of certain
scripting concepts. The foregoing text treats these matters in more
depth, as well as giving usage examples.

**Table B-1. Special Shell Variables**

+--------------------------------------+--------------------------------------+
| Variable                             |
| Meaning                              |
+======================================+======================================+
| ``$0``                               | ``$1``                               |
| Filename of script                   | Positional parameter #1              |
+--------------------------------------+--------------------------------------+

**\*** *Must be quoted*, otherwise it defaults to ``$@``.

**Table B-2. TEST Operators: Binary Comparison**

+----------------+----------------+----------------+----------------+----------------+
| Operator       |
| Meaning        |
| -----          |
| Operator       |
| Meaning        |
+================+================+================+================+================+
|                | `Arithmetic    | ``-eq``        |                | ``-ne``        |
|                | Comparison <co | Equal to       |                | Not equal to   |
|                | mparison-ops.h |                |                |                |
|                | tml#ICOMPARISO | ``=``          | ``==``         | ``!=``         |
|                | N1>`__         | Equal to       | Equal to       | Not equal to   |
|                |                |                |                |                |
|                |                |                |                |                |
|                | `String        |                |                |                |
|                | Comparison <co |                |                |                |
|                | mparison-ops.h |                |                |                |
|                | tml#SCOMPARISO |                |                |                |
|                | N1>`__         |                |                |                |
|                |                |                |                |                |
+----------------+----------------+----------------+----------------+----------------+

**\*** *If within a double-bracket* [[ ... ]] *test construct, then no
escape* \\ *is needed.*

**Table B-3. TEST Operators: Files**

+----------------+----------------+----------------+----------------+----------------+
| Operator       |
| Tests Whether  |
| -----          |
| Operator       |
| Tests Whether  |
+================+================+================+================+================+
| ``-e``         | ``-f``         | ``-d``         | ``-h``         | ``-L``         |
| File exists    | File is a      | File is a      | File is a      | File is a      |
|                | *regular* file | *directory*    | `symbolic      | *symbolic      |
| ``-s``         |                |                | link <basic.ht | link*          |
| File is not    |                | ``-r``         | ml#SYMLINKREF> |                |
| zero size      |                | File has       | `__            | ``-x``         |
|                |                | *read*         |                | File has       |
|                |                | permission     | ``-w``         | *execute*      |
|                |                |                | File has       | permission     |
|                |                |                | *write*        |                |
|                |                |                | permission     |                |
+----------------+----------------+----------------+----------------+----------------+

**\*** *Binary* operator (requires two operands).

**Table B-4. Parameter Substitution and Expansion**

+--------------------------------------+--------------------------------------+
| Expression                           |
| Meaning                              |
+======================================+======================================+
| ``${var}``                           |                                      |
| Value of ``var`` (same as ``$var``)  |                                      |
+--------------------------------------+--------------------------------------+

**\*** If ``var`` *is* set, evaluate the expression as ``$var`` with no
side-effects.

**# Note** that some of the above behavior of operators has changed from
earlier versions of Bash.

**Table B-5. String Operations**

+--------------------------------------+--------------------------------------+
| Expression                           |
| Meaning                              |
+======================================+======================================+
| ``${#string}``                       |                                      |
| Length of ``$string``                |                                      |
+--------------------------------------+--------------------------------------+

**\*** Where ``$substring`` is a `Regular
Expression <regexp.html#REGEXREF>`__.

**Table B-6. Miscellaneous Constructs**

+--------------------------------------+--------------------------------------+
| Expression                           |
| Interpretation                       |
+======================================+======================================+
|                                      | `Brackets <x17129.html#BRACKETSREF>` |
|                                      | __                                   |
|                                      |                                      |
+--------------------------------------+--------------------------------------+

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <contributed-scrip | Contributed Scripts      |
| ts.html>`__              |                          |
| `Home <index.html>`__    | A Sed and Awk            |
| `Next <sedawk.html>`__   | Micro-Primer             |
+--------------------------+--------------------------+--------------------------+

