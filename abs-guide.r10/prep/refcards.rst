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

`Prev <contributed-scripts.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <sedawk.html>`__

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

   <div class="APPENDIX">

  Appendix B. Reference Cards
============================

The following reference cards provide a useful *summary* of certain
scripting concepts. The foregoing text treats these matters in more
depth, as well as giving usage examples.

.. raw:: html

   <div class="TABLE">

**Table B-1. Special Shell Variables**

+--------------------------------------+--------------------------------------+
| Variable                             |
| Meaning                              |
+======================================+======================================+
| ``          $0         ``            | ``          $1         ``            |
| Filename of script                   | Positional parameter #1              |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

**\*** *Must be quoted* , otherwise it defaults to ``      $@     `` .

.. raw:: html

   <div class="TABLE">

**Table B-2. TEST Operators: Binary Comparison**

.. raw:: html

   <table border="1" class="CALSTABLE">

.. raw:: html

   <thead>

.. raw:: html

   <tr>

.. raw:: html

   <th align="LEFT" valign="TOP">

Operator

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Meaning

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

-----

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Operator

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Meaning

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   </thead>

.. raw:: html

   <tbody>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Arithmetic Comparison <comparison-ops.html#ICOMPARISON1>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`String Comparison <comparison-ops.html#SCOMPARISON1>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -eq         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Equal to

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          =         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Equal to

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ==         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Equal to

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -ne         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Not equal to

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          !=         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Not equal to

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -lt         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Less than

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          \<         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Less than ( `ASCII <special-chars.html#ASCIIDEF>`__ ) \*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -le         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Less than or equal to

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -gt         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Greater than

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          \>         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Greater than (ASCII) \*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -ge         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Greater than or equal to

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -z         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

String is empty

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -n         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

String is not empty

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

Arithmetic Comparison

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`within double parentheses <testconstructs.html#DBLPRX>`__ (( ... ))

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          >         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Greater than

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          >=         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Greater than or equal to

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          <         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Less than

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          <=         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Less than or equal to

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </tbody>

.. raw:: html

   </table>

.. raw:: html

   </div>

**\*** *If within a double-bracket* [[ ... ]] *test construct, then no
escape* \\ *is needed.*

.. raw:: html

   <div class="TABLE">

**Table B-3. TEST Operators: Files**

.. raw:: html

   <table border="1" class="CALSTABLE">

.. raw:: html

   <thead>

.. raw:: html

   <tr>

.. raw:: html

   <th align="LEFT" valign="TOP">

Operator

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Tests Whether

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

-----

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Operator

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Tests Whether

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   </thead>

.. raw:: html

   <tbody>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -e         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File exists

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -s         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File is not zero size

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -f         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File is a *regular* file

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -d         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File is a *directory*

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -r         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File has *read* permission

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -h         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File is a `symbolic link <basic.html#SYMLINKREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -w         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File has *write* permission

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -L         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File is a *symbolic link*

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -x         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File has *execute* permission

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -b         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File is a `block device <devref1.html#BLOCKDEVREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -c         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File is a `character device <devref1.html#CHARDEVREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -g         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*sgid* flag set

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -p         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File is a `pipe <special-chars.html#PIPEREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -u         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*suid* flag set

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -S         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File is a `socket <devref1.html#SOCKETREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -k         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

 "sticky bit" set

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -t         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File is associated with a *terminal*

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -N         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File modified since it was last read

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          F1 -nt F2         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File F1 is *newer* than F2 \*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -O         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

You own the file

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          F1 -ot F2         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

File F1 is *older* than F2 \*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          -G         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*Group id* of file same as yours

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          F1 -ef F2         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Files F1 and F2 are *hard links* to the same file \*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          !         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

NOT (inverts sense of above tests)

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   <td>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </tbody>

.. raw:: html

   </table>

.. raw:: html

   </div>

**\*** *Binary* operator (requires two operands).

.. raw:: html

   <div class="TABLE">

**Table B-4. Parameter Substitution and Expansion**

.. raw:: html

   <table border="1" class="CALSTABLE">

.. raw:: html

   <thead>

.. raw:: html

   <tr>

.. raw:: html

   <th align="LEFT" valign="TOP">

Expression

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Meaning

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   </thead>

.. raw:: html

   <tbody>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${var}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Value of ``                     var                   `` (same as
``                     $var                   `` )

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${var-$DEFAULT}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

If ``                     var                   `` not set,
`evaluate <internal.html#EVALREF>`__ expression as
``                     $DEFAULT                   `` \*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${var:-$DEFAULT}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

If ``                     var                   `` not set or is empty,
*evaluate* expression as
``                     $DEFAULT                   `` \*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${var=$DEFAULT}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

If ``                     var                   `` not set, evaluate
expression as ``                     $DEFAULT                   `` \*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${var:=$DEFAULT}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

If ``                     var                   `` not set or is empty,
evaluate expression as
``                     $DEFAULT                   `` \*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${var+$OTHER}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

If ``                     var                   `` set, evaluate
expression as ``                     $OTHER                   `` ,
otherwise as null string

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${var:+$OTHER}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

If ``                     var                   `` set, evaluate
expression as ``                     $OTHER                   `` ,
otherwise as null string

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${var?$ERR_MSG}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

If ``                     var                   `` not set, print
``                     $ERR_MSG                   `` and abort script
with an exit status of 1 .\*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${var:?$ERR_MSG}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

If ``                     var                   `` not set, print
``                     $ERR_MSG                   `` and abort script
with an exit status of 1 .\*

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${!varprefix*}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Matches all previously declared variables beginning with
``                     varprefix                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${!varprefix@}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Matches all previously declared variables beginning with
``                     varprefix                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </tbody>

.. raw:: html

   </table>

.. raw:: html

   </div>

**\*** If ``             var           `` *is* set, evaluate the
expression as ``             $var           `` with no side-effects.

**# Note** that some of the above behavior of operators has changed from
earlier versions of Bash.

.. raw:: html

   <div class="TABLE">

**Table B-5. String Operations**

.. raw:: html

   <table border="1" class="CALSTABLE">

.. raw:: html

   <thead>

.. raw:: html

   <tr>

.. raw:: html

   <th align="LEFT" valign="TOP">

Expression

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Meaning

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   </thead>

.. raw:: html

   <tbody>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${#string}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Length of ``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${string:position}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Extract substring from
``                     $string                   `` at
``                     $position                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${string:position:length}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Extract ``                     $length                   `` characters
substring from ``                     $string                   `` at
``                     $position                   `` [zero-indexed,
first character is at position 0]

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${string#substring}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Strip shortest match of
``                     $substring                   `` from front of
``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${string##substring}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Strip longest match of
``                     $substring                   `` from front of
``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${string%substring}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Strip shortest match of
``                     $substring                   `` from back of
``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${string%%substring}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Strip longest match of
``                     $substring                   `` from back of
``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${string/substring/replacement}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Replace first match of
``                     $substring                   `` with
``                     $replacement                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${string//substring/replacement}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Replace *all* matches of
``                     $substring                   `` with
``                     $replacement                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${string/#substring/replacement}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

If ``                     $substring                   `` matches
*front* end of ``                     $string                   `` ,
substitute ``                     $replacement                   `` for
``                     $substring                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${string/%substring/replacement}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

If ``                     $substring                   `` matches *back*
end of ``                     $string                   `` , substitute
``                     $replacement                   `` for
``                     $substring                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          expr match "$string" '$substring'         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Length of matching
``                     $substring                   `` \* at beginning
of ``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          expr "$string" : '$substring'         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Length of matching
``                     $substring                   `` \* at beginning
of ``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          expr index "$string" $substring         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Numerical position in
``                     $string                   `` of first character
in ``                     $substring                   `` \* that
matches [0 if no match, first character counts as position 1]

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          expr substr $string $position             $length         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Extract ``                     $length                   `` characters
from ``                     $string                   `` starting at
``                     $position                   `` [0 if no match,
first character counts as position 1]

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          expr match "$string"             '\($substring\)'         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Extract ``                     $substring                   `` \*,
searching from beginning of
``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          expr "$string" :             '\($substring\)'         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Extract ``                     $substring                   `` \* ,
searching from beginning of
``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          expr match "$string"             '.*\($substring\)'         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Extract ``                     $substring                   `` \*,
searching from end of
``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          expr "$string" :             '.*\($substring\)'         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Extract ``                     $substring                   `` \*,
searching from end of
``                     $string                   ``

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </tbody>

.. raw:: html

   </table>

.. raw:: html

   </div>

**\*** Where ``             $substring           `` is a `Regular
Expression <regexp.html#REGEXREF>`__ .

.. raw:: html

   <div class="TABLE">

**Table B-6. Miscellaneous Constructs**

.. raw:: html

   <table border="1" class="CALSTABLE">

.. raw:: html

   <thead>

.. raw:: html

   <tr>

.. raw:: html

   <th align="LEFT" valign="TOP">

Expression

.. raw:: html

   </th>

.. raw:: html

   <th align="LEFT" valign="TOP">

Interpretation

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   </thead>

.. raw:: html

   <tbody>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Brackets <x17129.html#BRACKETSREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          if [ CONDITION ]         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Test construct <special-chars.html#LEFTBRACKET>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          if [[ CONDITION ]]         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Extended test construct <testconstructs.html#DBLBRACKETS>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          Array[1]=element1         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Array initialization <arrays.html#ARRAYREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          [a-z]         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Range of characters <x17129.html#BRACKETSREF>`__ within a `Regular
Expression <regexp.html#REGEXREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

Curly Brackets

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${variable}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Parameter substitution <parameter-substitution.html#PARAMSUBREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ${!variable}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Indirect variable reference <ivr.html#IVRREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          { command1; command2; . . . commandN; }         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Block of code <special-chars.html#CODEBLOCKREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          {string1,string2,string3,...}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Brace expansion <special-chars.html#BRACEEXPREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          {a..z}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Extended brace expansion <bashver3.html#BRACEEXPREF3>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          {}         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Text replacement, after `find <moreadv.html#CURLYBRACKETSREF>`__ and
`xargs <moreadv.html#XARGSCURLYREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Parentheses <special-chars.html#PARENSREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          ( command1; command2 )         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Command group executed within a
`subshell <subshells.html#SUBSHELLSREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          Array=(element1 element2 element3)         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Array initialization <arrays.html#ARRAYINIT0>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          result=$(COMMAND)         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Command substitution <commandsub.html#CSPARENS>`__ , new style

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          >(COMMAND)         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Process substitution <process-sub.html#PROCESSSUBREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          <(COMMAND)         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Process substitution

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Double Parentheses <dblparens.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          (( var = 78 ))         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Integer arithmetic <dblparens.html#DBLPARENSREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          var=$(( 20 + 5 ))         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

Integer arithmetic, with variable assignment

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          (( var++ ))         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*C-style* `variable increment <dblparens.html#PLUSPLUSREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          (( var-- ))         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*C-style* `variable decrement <dblparens.html#PLUSPLUSREF>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          (( var0 = var1<98?9:21 ))         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

*C-style* `ternary <special-chars.html#CSTRINARY>`__ operation

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Quoting <quoting.html#QUOTINGREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          "$variable"         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`"Weak" quoting <varsubn.html#DBLQUO>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          'string'         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`'Strong' quoting <varsubn.html#SNGLQUO>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Back Quotes <commandsub.html#BACKQUOTESREF>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP">

``          result=`COMMAND`         ``

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP">

`Command substitution <commandsub.html#COMMANDSUBREF>`__ , classic style

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </tbody>

.. raw:: html

   </table>

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

.. raw:: html

   <table border="0" cellpadding="0" cellspacing="0" summary="Footer navigation table" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

`Prev <contributed-scripts.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

`Home <index.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

`Next <sedawk.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

Contributed Scripts

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

A Sed and Awk Micro-Primer

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   </div>

