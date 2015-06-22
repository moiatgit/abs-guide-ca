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

`Prev <pathmanagement.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <ioredirintro.html>`__

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

  Appendix E. Exit Codes With Special Meanings
=============================================

.. raw:: html

   <div class="TABLE">

**Table E-1. *Reserved* Exit Codes**

+--------------------+--------------------+--------------------+--------------------+
| Exit Code Number   |
| Meaning            |
| Example            |
| Comments           |
+====================+====================+====================+====================+
| ``          1      | ``          2      | ``          126    | ``          127    |
|     ``             |     ``             |       ``           |       ``           |
| Catchall for       | Misuse of shell    | Command invoked    |  "command not      |
| general errors     | builtins           | cannot execute     | found"             |
| let "var1 = 1/0"   | (according to Bash | /dev/null          | illegal\_command   |
| Miscellaneous      | documentation)     | Permission problem | Possible problem   |
| errors, such as    | empty\_function()  | or command is not  | with               |
| "divide by zero"   | {}                 | an executable      | ``          $PATH  |
| and other          | `Missing           |                    |         ``         |
| impermissible      | keyword <debugging |                    | or a typo          |
| operations         | .html#MISSINGKEYWO |                    |                    |
|                    | RD>`__             |                    |                    |
|                    | or command, or     |                    |                    |
|                    | permission problem |                    |                    |
|                    | (and `*diff*       |                    |                    |
|                    | return code on a   |                    |                    |
|                    | failed binary file |                    |                    |
|                    | comparison <filear |                    |                    |
|                    | chiv.html#DIFFERR2 |                    |                    |
|                    | >`__               |                    |                    |
|                    | ).                 |                    |                    |
+--------------------+--------------------+--------------------+--------------------+

.. raw:: html

   </div>

According to the above table, exit codes 1 - 2, 126 - 165, and 255 ` [1]
 <exitcodes.html#FTN.AEN23629>`__ have special meanings, and should
therefore be avoided for user-specified exit parameters. Ending a script
with *exit 127* would certainly cause confusion when troubleshooting (is
the error code a "command not found" or a user-defined one?). However,
many scripts use an *exit 1* as a general bailout-upon-error. Since exit
code 1 signifies so many possible errors, it is not particularly useful
in debugging.

There has been an attempt to systematize exit status numbers (see
``      /usr/include/sysexits.h     `` ), but this is intended for C and
C++ programmers. A similar standard for scripting might be appropriate.
The author of this document proposes restricting user-defined exit codes
to the range 64 - 113 (in addition to 0 , for success), to conform with
the C/C++ standard. This would allot 50 valid codes, and make
troubleshooting scripts more straightforward. ` [2]
 <exitcodes.html#FTN.AEN23647>`__ All user-defined exit codes in the
accompanying examples to this document conform to this standard, except
where overriding circumstances exist, as in `Example
9-2 <internalvariables.html#TMDIN>`__ .

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| Issuing a                            |
| `$? <internalvariables.html#XSTATVAR |
| REF>`__                              |
| from the command-line after a shell  |
| script exits gives results           |
| consistent with the table above only |
| from the Bash or *sh* prompt.        |
| Running the *C-shell* or *tcsh* may  |
| give different values in some cases. |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <exitcodes.html#AEN23629>`__  | ` [2]  <exitcodes.html#AEN23647>`__  |
|  Out of range exit values can result | An update of                         |
| in unexpected exit codes. An exit    | ``        /usr/include/sysexits.h    |
| value greater than 255 returns an    |     ``                               |
| exit code                            | allocates previously unused exit     |
| `modulo <ops.html#MODULOREF>`__ 256  | codes from 64 - 78 . It may be       |
| . For example, *exit 3809* gives an  | anticipated that the range of        |
| exit code of 225 (3809 % 256 = 225). | unallotted exit codes will be        |
|                                      | further restricted in the future.    |
|                                      | The author of this document will     |
|                                      | *not* do fixups on the scripting     |
|                                      | examples to conform to the changing  |
|                                      | standard. This should not cause any  |
|                                      | problems, since there is no overlap  |
|                                      | or conflict in usage of exit codes   |
|                                      | between compiled C/C++ binaries and  |
|                                      | shell scripts.                       |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

.. raw:: html

   <table border="0" cellpadding="0" cellspacing="0" summary="Footer navigation table" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

`Prev <pathmanagement.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

`Home <index.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

`Next <ioredirintro.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

Parsing and Managing Pathnames

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

A Detailed Introduction to I/O and I/O Redirection

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
