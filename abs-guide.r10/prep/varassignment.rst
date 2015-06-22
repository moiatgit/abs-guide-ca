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

`Prev <varsubn.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 4. Introduction to Variables and Parameters

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <untyped.html>`__

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

  4.2. Variable Assignment
=========================

.. raw:: html

   <div class="VARIABLELIST">

 =
    the assignment operator ( *no space before and after* )

    .. raw:: html

       <div class="CAUTION">

    +--------------------------+--------------------------+--------------------------+
    | |Caution|                |
    | Do not confuse this with |
    | `= <comparison-ops.html# |
    | EQUALSIGNREF>`__         |
    | and                      |
    | `-eq <comparison-ops.htm |
    | l#EQUALREF>`__           |
    | , which                  |
    | `test <tests.html#IFTHEN |
    | >`__                     |
    | , rather than assign!    |
    |                          |
    | Note that = can be       |
    | either an *assignment*   |
    | or a *test* operator,    |
    | depending on context.    |
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 4-2. Plain Variable Assignment**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Naked variables    |
    |                          |
    |     echo                 |
    |                          |
    |     # When is a variable |
    |  "naked", i.e., lacking  |
    | the '$' in front?        |
    |     # When it is being a |
    | ssigned, rather than ref |
    | erenced.                 |
    |                          |
    |     # Assignment         |
    |     a=879                |
    |     echo "The value of \ |
    | "a\" is $a."             |
    |                          |
    |     # Assignment using ' |
    | let'                     |
    |     let a=16+5           |
    |     echo "The value of \ |
    | "a\" is now $a."         |
    |                          |
    |     echo                 |
    |                          |
    |     # In a 'for' loop (r |
    | eally, a type of disguis |
    | ed assignment):          |
    |     echo -n "Values of \ |
    | "a\" in the loop are: "  |
    |     for a in 7 8 9 11    |
    |     do                   |
    |       echo -n "$a "      |
    |     done                 |
    |                          |
    |     echo                 |
    |     echo                 |
    |                          |
    |     # In a 'read' statem |
    | ent (also a type of assi |
    | gnment):                 |
    |     echo -n "Enter \"a\" |
    |  "                       |
    |     read a               |
    |     echo "The value of \ |
    | "a\" is now $a."         |
    |                          |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 4-3. Variable Assignment, plain and fancy**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     a=23              #  |
    | Simple case              |
    |     echo $a              |
    |     b=$a                 |
    |     echo $b              |
    |                          |
    |     # Now, getting a lit |
    | tle bit fancier (command |
    |  substitution).          |
    |                          |
    |     a=`echo Hello!`   #  |
    | Assigns result of 'echo' |
    |  command to 'a' ...      |
    |     echo $a              |
    |     #  Note that includi |
    | ng an exclamation mark ( |
    | !) within a              |
    |     #+ command substitut |
    | ion construct will not w |
    | ork from the command-lin |
    | e,                       |
    |     #+ since this trigge |
    | rs the Bash "history mec |
    | hanism."                 |
    |     #  Inside a script,  |
    | however, the history fun |
    | ctions are disabled by d |
    | efault.                  |
    |                          |
    |     a=`ls -l`         #  |
    | Assigns result of 'ls -l |
    | ' command to 'a'         |
    |     echo $a           #  |
    | Unquoted, however, it re |
    | moves tabs and newlines. |
    |     echo                 |
    |     echo "$a"         #  |
    | The quoted variable pres |
    | erves whitespace.        |
    |                       #  |
    | (See the chapter on "Quo |
    | ting.")                  |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Variable assignment using the *$(...)* mechanism (a newer method
    than `backquotes <commandsub.html#BACKQUOTESREF>`__ ). This is
    likewise a form of `command
    substitution <commandsub.html#COMMANDSUBREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # From /etc/rc.d/rc. |
    | local                    |
    |     R=$(cat /etc/redhat- |
    | release)                 |
    |     arch=$(uname -m)     |
                              
    +--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <varsubn.html>`__  | Variable Substitution    |
| `Home <index.html>`__    | `Up <variables.html>`__  |
| `Next <untyped.html>`__  | Bash Variables Are       |
|                          | Untyped                  |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
