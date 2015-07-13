
####################################
XXX  Chapter 6. Exit and Exit Status
####################################


**

*... there are dark corners in the Bourne shell, and people use all of
them.*

*--Chet Ramey*



 The **exit** command terminates a script, just as in a **C** program.
It can also return a value, which is available to the script's parent
process.

 Every command returns an *exit status* (sometimes referred to as a
*return status* or *exit code* ). A successful command returns a 0 ,
while an unsuccessful one returns a non-zero value that usually can be
interpreted as an *error code* . Well-behaved UNIX commands, programs,
and utilities return a 0 exit code upon successful completion, though
there are some exceptions.

Likewise, `functions <functions.html#FUNCTIONREF>`__ within a script and
the script itself return an exit status. The last command executed in
the function or script determines the exit status. Within a script, an
``             exit                        nnn               `` command
may be used to deliver an ``               nnn             `` exit
status to the shell ( ``               nnn             `` must be an
integer in the 0 - 255 range).



|Note|

When a script ends with an **exit** that has no parameter, the exit
status of the script is the exit status of the last command executed in
the script (previous to the **exit** ).

+--------------------------+--------------------------+--------------------------+
| .. code-block:: sh
|                          |
|     #!/bin/bash          |
|                          |
|     COMMAND_1            |
|                          |
|     . . .                |
|                          |
|     COMMAND_LAST         |
|                          |
|     # Will exit with sta |
| tus of last command.     |
|                          |
|     exit                 |

+--------------------------+--------------------------+--------------------------+

The equivalent of a bare **exit** is **exit $?** or even just omitting
the **exit** .

+--------------------------+--------------------------+--------------------------+
| .. code-block:: sh
|                          |
|     #!/bin/bash          |
|                          |
|     COMMAND_1            |
|                          |
|     . . .                |
|                          |
|     COMMAND_LAST         |
|                          |
|     # Will exit with sta |
| tus of last command.     |
|                          |
|     exit $?              |

+--------------------------+--------------------------+--------------------------+

+--------------------------+--------------------------+--------------------------+
| .. code-block:: sh
|                          |
|     #!/bin/bash          |
|                          |
|     COMMAND1             |
|                          |
|     . . .                |
|                          |
|     COMMAND_LAST         |
|                          |
|     # Will exit with sta |
| tus of last command.     |

+--------------------------+--------------------------+--------------------------+


.. code-block:: sh

    #!/bin/bash

    COMMAND_1

    . . .

    COMMAND_LAST

    # Will exit with status of last command.

    exit


.. code-block:: sh

    #!/bin/bash

    COMMAND_1

    . . .

    COMMAND_LAST

    # Will exit with status of last command.

    exit $?


.. code-block:: sh

    #!/bin/bash

    COMMAND1

    . . .

    COMMAND_LAST

    # Will exit with status of last command.


.. code-block:: sh

    #!/bin/bash

    COMMAND_1

    . . .

    COMMAND_LAST

    # Will exit with status of last command.

    exit


.. code-block:: sh

    #!/bin/bash

    COMMAND_1

    . . .

    COMMAND_LAST

    # Will exit with status of last command.

    exit $?


.. code-block:: sh

    #!/bin/bash

    COMMAND1

    . . .

    COMMAND_LAST

    # Will exit with status of last command.




``      $?     `` reads the exit status of the last command executed.
After a function returns, ``      $?     `` gives the exit status of the
last command executed in the function. This is Bash's way of giving
functions a "return value." ` [1]  <exit-status.html#FTN.AEN2981>`__

 Following the execution of a `pipe <special-chars.html#PIPEREF>`__ , a
``      $?     `` gives the exit status of the last command executed.

After a script terminates, a ``      $?     `` from the command-line
gives the exit status of the script, that is, the last command executed
in the script, which is, by convention, ``             0           `` on
success or an integer in the range 1 - 255 on error.


**Example 6-1. exit / exit status**


.. code-block:: sh

    #!/bin/bash

    echo hello
    echo $?    # Exit status 0 returned because command executed successfully.

    lskdf      # Unrecognized command.
    echo $?    # Non-zero exit status returned -- command failed to execute.

    echo

    exit 113   # Will return 113 to shell.
               # To verify this, type "echo $?" after script terminates.

    #  By convention, an 'exit 0' indicates success,
    #+ while a non-zero exit value means an error or anomalous condition.
    #  See the "Exit Codes With Special Meanings" appendix.




`$? <internalvariables.html#XSTATVARREF>`__ is especially useful for
testing the result of a command in a script (see `Example
16-35 <filearchiv.html#FILECOMP>`__ and `Example
16-20 <textproc.html#LOOKUP>`__ ).



|Note|

The `! <special-chars.html#NOTREF>`__ , the *logical not* qualifier,
reverses the outcome of a test or command, and this affects its `exit
status <exit-status.html#EXITSTATUSREF>`__ .


**Example 6-2. Negating a condition using ! **


.. code-block:: sh

    true    # The "true" builtin.
    echo "exit status of \"true\" = $?"     # 0

    ! true
    echo "exit status of \"! true\" = $?"   # 1
    # Note that the "!" needs a space between it and the command.
    #    !true   leads to a "command not found" error
    #
    # The '!' operator prefixing a command invokes the Bash history mechanism.

    true
    !true
    # No error this time, but no negation either.
    # It just repeats the previous command (true).


    # =========================================================== #
    # Preceding a _pipe_ with ! inverts the exit status returned.
    ls | bogus_command     # bash: bogus_command: command not found
    echo $?                # 127

    ! ls | bogus_command   # bash: bogus_command: command not found
    echo $?                # 0
    # Note that the ! does not change the execution of the pipe.
    # Only the exit status changes.
    # =========================================================== #

    # Thanks, StÃ©phane Chazelas and Kristopher Newsome.





.. code-block:: sh

    true    # The "true" builtin.
    echo "exit status of \"true\" = $?"     # 0

    ! true
    echo "exit status of \"! true\" = $?"   # 1
    # Note that the "!" needs a space between it and the command.
    #    !true   leads to a "command not found" error
    #
    # The '!' operator prefixing a command invokes the Bash history mechanism.

    true
    !true
    # No error this time, but no negation either.
    # It just repeats the previous command (true).


    # =========================================================== #
    # Preceding a _pipe_ with ! inverts the exit status returned.
    ls | bogus_command     # bash: bogus_command: command not found
    echo $?                # 127

    ! ls | bogus_command   # bash: bogus_command: command not found
    echo $?                # 0
    # Note that the ! does not change the execution of the pipe.
    # Only the exit status changes.
    # =========================================================== #

    # Thanks, StÃ©phane Chazelas and Kristopher Newsome.


.. code-block:: sh

    true    # The "true" builtin.
    echo "exit status of \"true\" = $?"     # 0

    ! true
    echo "exit status of \"! true\" = $?"   # 1
    # Note that the "!" needs a space between it and the command.
    #    !true   leads to a "command not found" error
    #
    # The '!' operator prefixing a command invokes the Bash history mechanism.

    true
    !true
    # No error this time, but no negation either.
    # It just repeats the previous command (true).


    # =========================================================== #
    # Preceding a _pipe_ with ! inverts the exit status returned.
    ls | bogus_command     # bash: bogus_command: command not found
    echo $?                # 127

    ! ls | bogus_command   # bash: bogus_command: command not found
    echo $?                # 0
    # Note that the ! does not change the execution of the pipe.
    # Only the exit status changes.
    # =========================================================== #

    # Thanks, StÃ©phane Chazelas and Kristopher Newsome.






|Caution|

Certain exit status codes have `reserved
meanings <exitcodes.html#EXITCODESREF>`__ and should not be
user-specified in a script.





Notes
~~~~~


` [1]  <exit-status.html#AEN2981>`__

In those instances when there is no
`return <complexfunct.html#RETURNREF>`__ terminating the function.



.. |Note| image:: ../images/note.gif
.. |Caution| image:: ../images/caution.gif
