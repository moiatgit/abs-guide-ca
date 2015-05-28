Advanced Bash-Scripting Guide:

`Prev <pathmanagement.html>`__

`Next <ioredirintro.html>`__

--------------

Appendix E. Exit Codes With Special Meanings
============================================

**Table E-1. *Reserved* Exit Codes**

+--------------------+--------------------+--------------------+--------------------+
| Exit Code Number   |
| Meaning            |
| Example            |
| Comments           |
+====================+====================+====================+====================+
| ``1``              | ``2``              | ``126``            | ``127``            |
| Catchall for       | Misuse of shell    | Command invoked    | "command not       |
| general errors     | builtins           | cannot execute     | found"             |
| let "var1 = 1/0"   | (according to Bash | /dev/null          | illegal\_command   |
| Miscellaneous      | documentation)     | Permission problem | Possible problem   |
| errors, such as    | empty\_function()  | or command is not  | with ``$PATH`` or  |
| "divide by zero"   | {}                 | an executable      | a typo             |
| and other          | `Missing           |                    |                    |
| impermissible      | keyword <debugging |                    |                    |
| operations         | .html#MISSINGKEYWO |                    |                    |
|                    | RD>`__             |                    |                    |
|                    | or command, or     |                    |                    |
|                    | permission problem |                    |                    |
|                    | (and `*diff*       |                    |                    |
|                    | return code on a   |                    |                    |
|                    | failed binary file |                    |                    |
|                    | comparison <filear |                    |                    |
|                    | chiv.html#DIFFERR2 |                    |                    |
|                    | >`__).             |                    |                    |
+--------------------+--------------------+--------------------+--------------------+

According to the above table, exit codes 1 - 2, 126 - 165, and 255
`[1] <exitcodes.html#FTN.AEN23629>`__ have special meanings, and should
therefore be avoided for user-specified exit parameters. Ending a script
with *exit 127* would certainly cause confusion when troubleshooting (is
the error code a "command not found" or a user-defined one?). However,
many scripts use an *exit 1* as a general bailout-upon-error. Since exit
code 1 signifies so many possible errors, it is not particularly useful
in debugging.

There has been an attempt to systematize exit status numbers (see
``/usr/include/sysexits.h``), but this is intended for C and C++
programmers. A similar standard for scripting might be appropriate. The
author of this document proposes restricting user-defined exit codes to
the range 64 - 113 (in addition to 0, for success), to conform with the
C/C++ standard. This would allot 50 valid codes, and make
troubleshooting scripts more straightforward.
`[2] <exitcodes.html#FTN.AEN23647>`__ All user-defined exit codes in the
accompanying examples to this document conform to this standard, except
where overriding circumstances exist, as in `Example
9-2 <internalvariables.html#TMDIN>`__.

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

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <exitcodes.html#AEN23629>`__    | `[2] <exitcodes.html#AEN23647>`__    |
| Out of range exit values can result  | An update of                         |
| in unexpected exit codes. An exit    | ``/usr/include/sysexits.h``          |
| value greater than 255 returns an    | allocates previously unused exit     |
| exit code                            | codes from 64 - 78. It may be        |
| `modulo <ops.html#MODULOREF>`__ 256. | anticipated that the range of        |
| For example, *exit 3809* gives an    | unallotted exit codes will be        |
| exit code of 225 (3809 % 256 = 225). | further restricted in the future.    |
|                                      | The author of this document will     |
|                                      | *not* do fixups on the scripting     |
|                                      | examples to conform to the changing  |
|                                      | standard. This should not cause any  |
|                                      | problems, since there is no overlap  |
|                                      | or conflict in usage of exit codes   |
|                                      | between compiled C/C++ binaries and  |
|                                      | shell scripts.                       |
+--------------------------------------+--------------------------------------+

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <pathmanagement.ht | Parsing and Managing     |
| ml>`__                   | Pathnames                |
| `Home <index.html>`__    |                          |
| `Next <ioredirintro.html | A Detailed Introduction  |
| >`__                     | to I/O and I/O           |
|                          | Redirection              |
+--------------------------+--------------------------+--------------------------+

.. |Note| image:: ../images/note.gif
