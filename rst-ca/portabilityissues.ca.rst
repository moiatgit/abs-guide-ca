+----------------------------------+--------------------------+----------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+==========================+============================+
| `Prev <securityissues.html>`_    | Chapter 36. Miscellany   | `Next <winscript.html>`_   |
+----------------------------------+--------------------------+----------------------------+

--------------

36.9. Portability Issues
========================

**

*It is easier to port a shell than a shell script.*

*--Larry Wall*

This book deals specifically with Bash scripting on a GNU/Linux system.
All the same, users of **sh** and **ksh** will find much of value here.

As it happens, many of the various shells and scripting languages seem
to be converging toward the `POSIX <sha-bang.html#POSIX2REF>`_ 1003.2
standard. Invoking Bash with the ``--posix`` option or inserting a **set
-o posix** at the head of a script causes Bash to conform very closely
to this standard. Another alternative is to use a *#!/bin/sh* `sha-bang
header <sha-bang.html#SHABANGREF>`_ in the script, rather than
*#!/bin/bash*. `[1] <portabilityissues.html#FTN.AEN20608>`_ Note that
``/bin/sh`` is a `link <basic.html#LINKREF>`_ to ``/bin/bash`` in Linux
and certain other flavors of UNIX, and a script invoked this way
disables extended Bash functionality.

Most Bash scripts will run as-is under **ksh**, and vice-versa, since
Chet Ramey has been busily porting **ksh** features to the latest
versions of Bash.

On a commercial UNIX machine, scripts using GNU-specific features of
standard commands may not work. This has become less of a problem in the
last few years, as the GNU utilities have pretty much displaced their
proprietary counterparts even on "big-iron" UNIX. `Caldera's release of
the
source <http://linux.oreillynet.com/pub/a/linux/2002/02/28/caldera.html>`_
to many of the original UNIX utilities has accelerated the trend.

Bash has certain features that the traditional `Bourne
shell <why-shell.html#BASHDEF>`_ lacks. Among these are:

-  Certain extended `invocation
   options <options.html#INVOCATIONOPTIONSREF>`_

-  `Command substitution <commandsub.html#COMMANDSUBREF>`_ using **$(
   )** notation

-  `Brace expansion <bashver3.html#BRACEEXPREF3>`_

-  Certain `array <arrays.html#ARRAYREF>`_ operations, and `associative
   arrays <bashver4.html#ASSOCARR>`_

-  The `double brackets <testconstructs.html#DBLBRACKETS>`_ extended
   test construct

-  The `double-parentheses <dblparens.html#DBLPARENSREF>`_
   arithmetic-evaluation construct

-  Certain `string manipulation <string-manipulation.html#STRINGMANIP>`_
   operations

-  `Process substitution <process-sub.html#PROCESSSUBREF>`_

-  A Regular Expression `matching
   operator <bashver3.html#REGEXMATCHREF>`_

-  Bash-specific `builtins <internal.html#BUILTINREF>`_

-  `Coprocesses <bashver4.html#COPROCREF>`_

See the `Bash F.A.Q. <ftp://ftp.cwru.edu/pub/bash/FAQ>`_ for a complete
listing.

36.9.1. A Test Suite
--------------------

Let us illustrate some of the incompatibilities between Bash and the
classic Bourne shell. Download and install the `"Heirloom Bourne
Shell" <http://freshmeat.net/projects/bournesh>`_ and run the following
script, first using Bash, then the classic *sh*.

**Example 36-21. Test Suite**

::

    #!/bin/bash
    # test-suite.sh
    # A partial Bash compatibility test suite.
    # Run this on your version of Bash, or some other shell.

    default_option=FAIL         # Tests below will fail unless . . .

    echo
    echo -n "Testing "
    sleep 1; echo -n ". "
    sleep 1; echo -n ". "
    sleep 1; echo ". "
    echo

    # Double brackets
    String="Double brackets supported?"
    echo -n "Double brackets test: "
    if [[ "$String" = "Double brackets supported?" ]]
    then
      echo "PASS"
    else
      echo "FAIL"
    fi


    # Double brackets and regex matching
    String="Regex matching supported?"
    echo -n "Regex matching: "
    if [[ "$String" =~ R.....matching* ]]
    then
      echo "PASS"
    else
      echo "FAIL"
    fi


    # Arrays
    test_arr=$default_option     # FAIL
    Array=( If supports arrays will print PASS )
    test_arr=${Array[5]}
    echo "Array test: $test_arr"


    # Command Substitution
    csub_test ()
    {
      echo "PASS"
    }

    test_csub=$default_option    # FAIL
    test_csub=$(csub_test)
    echo "Command substitution test: $test_csub"

    echo

    #  Completing this script is an exercise for the reader.
    #  Add to the above similar tests for double parentheses,
    #+ brace expansion, process substitution, etc.

    exit $?

Notes
~~~~~

`[1] <portabilityissues.html#AEN20608>`_

Or, better yet, `#!/bin/env sh <system.html#ENVV2REF>`_.

--------------

+---------------------------------+---------------------------+---------------------------------+
| `Prev <securityissues.html>`_   | `Home <index.html>`_      | `Next <winscript.html>`_        |
+---------------------------------+---------------------------+---------------------------------+
| Security Issues                 | `Up <miscellany.html>`_   | Shell Scripting Under Windows   |
+---------------------------------+---------------------------+---------------------------------+

