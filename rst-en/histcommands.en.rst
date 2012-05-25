+----------------------------------+----+--------------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+====+================================+
| `Prev <localization.html>`_      |    | `Next <sample-bashrc.html>`_   |
+----------------------------------+----+--------------------------------+

--------------

Appendix K. History Commands
============================

The Bash shell provides command-line tools for editing and manipulating
a user's *command history*. This is primarily a convenience, a means of
saving keystrokes.

Bash history commands:

#. **history**

#. **fc**

::

    bash$ history
       1  mount /mnt/cdrom
        2  cd /mnt/cdrom
        3  ls
         ...
              

Internal variables associated with Bash history commands:

#. $HISTCMD

#. $HISTCONTROL

#. $HISTIGNORE

#. $HISTFILE

#. $HISTFILESIZE

#. $HISTSIZE

#. $HISTTIMEFORMAT (Bash, ver. 3.0 or later)

#. !!

#. !$

#. !#

#. !N

#. !-N

#. !STRING

#. !?STRING?

#. ^STRING^string^

Unfortunately, the Bash history tools find no use in scripting.

::

    #!/bin/bash
    # history.sh
    # A (vain) attempt to use the 'history' command in a script.

    history                      # No output.

    var=$(history); echo "$var"  # $var is empty.

    # History commands disabled within a script.

::

    bash$ ./history.sh
    (no output)         
              

The `Advancing in the Bash
Shell <http://samrowe.com/wordpress/advancing-in-the-bash-shell/>`_ site
gives a good introduction to the use of history commands in Bash.

--------------

+-------------------------------+------------------------+--------------------------------------------------+
| `Prev <localization.html>`_   | `Home <index.html>`_   | `Next <sample-bashrc.html>`_                     |
+-------------------------------+------------------------+--------------------------------------------------+
| Localization                  |                        | Sample ``.bashrc`` and ``.bash_profile`` Files   |
+-------------------------------+------------------------+--------------------------------------------------+

