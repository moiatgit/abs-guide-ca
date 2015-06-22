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

`Prev <standard-options.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Appendix G. Command-Line Options

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <files.html>`__

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

  G.2. Bash Command-Line Options
===============================

*Bash* itself has a number of command-line options. Here are some of the
more useful ones.

-  ``        -c       ``

   *Read commands from the following string and assign any arguments to
   the `positional parameters <internalvariables.html#POSPARAMREF>`__ .*

   +--------------------------+--------------------------+--------------------------+
   | .. code:: SCREEN         |
   |                          |
   |     bash$ bash -c 'set a |
   |  b c d; IFS="+-;"; echo  |
   | "$*"'                    |
   |     a+b+c+d              |
   |                          |
                             
   +--------------------------+--------------------------+--------------------------+

-  ``        -r       ``

   ``        --restricted       ``

   *Runs the shell, or a script, in `restricted
   mode <restricted-sh.html#RESTRICTEDSHREF>`__ .*

-  ``        --posix       ``

   *Forces Bash to conform to `POSIX <sha-bang.html#POSIX2REF>`__ mode.*

-  ``        --version       ``

   *Display Bash version information and exit.*

-  ``        --       ``

   *End of options. Anything further on the command line is an argument,
   not an option.*

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <standard-options. | Standard Command-Line    |
| html>`__                 | Options                  |
| `Home <index.html>`__    | `Up <command-line-option |
| `Next <files.html>`__    | s.html>`__               |
|                          | Important Files          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

