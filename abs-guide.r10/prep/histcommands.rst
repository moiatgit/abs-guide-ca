.. raw:: html

   <div class="APPENDIX">

  Appendix L. History Commands
=============================

The Bash shell provides command-line tools for editing and manipulating
a user's *command history* . This is primarily a convenience, a means of
saving keystrokes.

Bash history commands:

#. **history**

#. **fc**

.. raw:: html

   <div>

.. code:: SCREEN

    bash$ history
       1  mount /mnt/cdrom
        2  cd /mnt/cdrom
        3  ls
         ...
              

.. raw:: html

   </p>

.. raw:: html

   </div>

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

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    # history.sh
    # A (vain) attempt to use the 'history' command in a script.

    history                      # No output.

    var=$(history); echo "$var"  # $var is empty.

    #  History commands are, by default, disabled within a script.
    #  However, as dhw points out,
    #+ set -o history
    #+ enables the history mechanism.

    set -o history
    var=$(history); echo "$var"   # 1  var=$(history)

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   <div>

.. code:: SCREEN

    bash$ ./history.sh
    (no output)       
              

.. raw:: html

   </p>

.. raw:: html

   </div>

The `Advancing in the Bash
Shell <http://samrowe.com/wordpress/advancing-in-the-bash-shell/>`__
site gives a good introduction to the use of history commands in Bash.

.. raw:: html

   </div>

