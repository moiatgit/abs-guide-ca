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

`Prev <securityissues.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 36. Miscellany

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <winscript.html>`__

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

  36.9. Portability Issues
=========================

+--------------------------+--------------------------+--------------------------+
| **                       |
| *It is easier to port a  |
| shell than a shell       |
| script.*                 |
|                          |
| *--Larry Wall*           |
+--------------------------+--------------------------+--------------------------+

This book deals specifically with Bash scripting on a GNU/Linux system.
All the same, users of **sh** and **ksh** will find much of value here.

 As it happens, many of the various shells and scripting languages seem
to be converging toward the `POSIX <sha-bang.html#POSIX2REF>`__ 1003.2
standard. Invoking Bash with the ``      --posix     `` option or
inserting a **set -o posix** at the head of a script causes Bash to
conform very closely to this standard. Another alternative is to use a
*#!/bin/sh* `sha-bang header <sha-bang.html#SHABANGREF>`__ in the
script, rather than *#!/bin/bash* . ` [1]
 <portabilityissues.html#FTN.AEN20799>`__ Note that
``      /bin/sh     `` is a `link <basic.html#LINKREF>`__ to
``      /bin/bash     `` in Linux and certain other flavors of UNIX, and
a script invoked this way disables extended Bash functionality.

Most Bash scripts will run as-is under **ksh** , and vice-versa, since
Chet Ramey has been busily porting **ksh** features to the latest
versions of Bash.

On a commercial UNIX machine, scripts using GNU-specific features of
standard commands may not work. This has become less of a problem in the
last few years, as the GNU utilities have pretty much displaced their
proprietary counterparts even on "big-iron" UNIX. `Caldera's release of
the
source <http://linux.oreillynet.com/pub/a/linux/2002/02/28/caldera.html>`__
to many of the original UNIX utilities has accelerated the trend.

Bash has certain features that the traditional `Bourne
shell <why-shell.html#BASHDEF>`__ lacks. Among these are:

-  Certain extended `invocation
   options <options.html#INVOCATIONOPTIONSREF>`__

-  `Command substitution <commandsub.html#COMMANDSUBREF>`__ using **$(
   )** notation

-  `Brace expansion <bashver3.html#BRACEEXPREF3>`__

-  Certain `array <arrays.html#ARRAYREF>`__ operations, and `associative
   arrays <bashver4.html#ASSOCARR>`__

-  The `double brackets <testconstructs.html#DBLBRACKETS>`__ extended
   test construct

-  The `double-parentheses <dblparens.html#DBLPARENSREF>`__
   arithmetic-evaluation construct

-  Certain `string
   manipulation <string-manipulation.html#STRINGMANIP>`__ operations

-  `Process substitution <process-sub.html#PROCESSSUBREF>`__

-  A Regular Expression `matching
   operator <bashver3.html#REGEXMATCHREF>`__

-  Bash-specific `builtins <internal.html#BUILTINREF>`__

-  `Coprocesses <bashver4.html#COPROCREF>`__

See the `Bash F.A.Q. <ftp://ftp.cwru.edu/pub/bash/FAQ>`__ for a complete
listing.

.. raw:: html

   <div class="SECT2">

  36.9.1. A Test Suite
---------------------

 Let us illustrate some of the incompatibilities between Bash and the
classic Bourne shell. Download and install the ` "Heirloom Bourne Shell"
 <http://freshmeat.net/projects/bournesh>`__ and run the following
script, first using Bash, then the classic *sh* .

.. raw:: html

   <div class="EXAMPLE">

**Example 36-23. Test Suite**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # test-suite.sh      |
|     # A partial Bash com |
| patibility test suite.   |
|     # Run this on your v |
| ersion of Bash, or some  |
| other shell.             |
|                          |
|     default_option=FAIL  |
|         # Tests below wi |
| ll fail unless . . .     |
|                          |
|     echo                 |
|     echo -n "Testing "   |
|     sleep 1; echo -n ".  |
| "                        |
|     sleep 1; echo -n ".  |
| "                        |
|     sleep 1; echo ". "   |
|     echo                 |
|                          |
|     # Double brackets    |
|     String="Double brack |
| ets supported?"          |
|     echo -n "Double brac |
| kets test: "             |
|     if [[ "$String" = "D |
| ouble brackets supported |
| ?" ]]                    |
|     then                 |
|       echo "PASS"        |
|     else                 |
|       echo "FAIL"        |
|     fi                   |
|                          |
|                          |
|     # Double brackets an |
| d regex matching         |
|     String="Regex matchi |
| ng supported?"           |
|     echo -n "Regex match |
| ing: "                   |
|     if [[ "$String" =~ R |
| .....matching* ]]        |
|     then                 |
|       echo "PASS"        |
|     else                 |
|       echo "FAIL"        |
|     fi                   |
|                          |
|                          |
|     # Arrays             |
|     test_arr=$default_op |
| tion     # FAIL          |
|     Array=( If supports  |
| arrays will print PASS ) |
|     test_arr=${Array[5]} |
|     echo "Array test: $t |
| est_arr"                 |
|                          |
|                          |
|     # Command Substituti |
| on                       |
|     csub_test ()         |
|     {                    |
|       echo "PASS"        |
|     }                    |
|                          |
|     test_csub=$default_o |
| ption    # FAIL          |
|     test_csub=$(csub_tes |
| t)                       |
|     echo "Command substi |
| tution test: $test_csub" |
|                          |
|     echo                 |
|                          |
|     #  Completing this s |
| cript is an exercise for |
|  the reader.             |
|     #  Add to the above  |
| similar tests for double |
|  parentheses,            |
|     #+ brace expansion,  |
| process substitution, et |
| c.                       |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]                                |
|  <portabilityissues.html#AEN20799>`_ |
| _                                    |
| Or, better yet, `#!/bin/env          |
| sh <system.html#ENVV2REF>`__ .       |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <securityissues.ht | Security Issues          |
| ml>`__                   | `Up <miscellany.html>`__ |
| `Home <index.html>`__    | Shell Scripting Under    |
| `Next <winscript.html>`_ | Windows                  |
| _                        |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

