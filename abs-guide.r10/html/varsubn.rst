.. raw:: html

   <div class="NAVHEADER">

.. raw:: html

   <table summary="Header navigation table" width="100%" border="0" cellpadding="0" cellspacing="0">

.. raw:: html

   <tr>

.. raw:: html

   <th colspan="3" align="center">

Advanced Bash-Scripting Guide:

.. raw:: html

   </th>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="10%" align="left" valign="bottom">

`Prev <variables.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 4. Introduction to Variables and Parameters

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <varassignment.html>`__

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

4.1. Variable Substitution
==========================

The *name* of a variable is a placeholder for its *value*, the data it
holds. Referencing (retrieving) its value is called *variable
substitution*.

.. raw:: html

   <div class="VARIABLELIST">

$
    Let us carefully distinguish between the *name* of a variable and
    its *value*. If ``variable1`` is the name of a variable, then
    ``$variable1`` is a reference to its *value*, the data item it
    contains. `[1] <varsubn.html#FTN.AEN2258>`__

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ variable1=23   |
    |                          |
    |                          |
    |     bash$ echo variable1 |
    |     variable1            |
    |                          |
    |     bash$ echo $variable |
    | 1                        |
    |     23                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The only times a variable appears "naked" -- without the $ prefix --
    is when declared or assigned, when *unset*, when
    `exported <internal.html#EXPORTREF>`__, in an arithmetic expression
    within `double parentheses (( ... )) <dblparens.html>`__, or in the
    special case of a variable representing a
    `signal <debugging.html#SIGNALD>`__ (see `Example
    32-5 <debugging.html#EX76>`__). Assignment may be with an = (as in
    ``var1=27``), in a `read <internal.html#READREF>`__ statement, and
    at the head of a loop (``for var2 in 1                 2 3``).

    Enclosing a referenced value in *double quotes* (" ... ") does not
    interfere with variable substitution. This is called *partial
    quoting*, sometimes referred to as "weak quoting." Using single
    quotes (' ... ') causes the variable name to be used literally, and
    no substitution will take place. This is *full quoting*, sometimes
    referred to as 'strong quoting.' See `Chapter 5 <quoting.html>`__
    for a detailed discussion.

    Note that ``$variable`` is actually a simplified form of
    ``${variable}``. In contexts where the ``$variable`` syntax causes
    an error, the longer form may work (see `Section
    10.2 <parameter-substitution.html>`__, below).

    .. raw:: html

       <div class="EXAMPLE">

    **Example 4-1. Variable assignment and substitution**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # ex9.sh             |
    |                          |
    |     # Variables: assignm |
    | ent and substitution     |
    |                          |
    |     a=375                |
    |     hello=$a             |
    |     #   ^ ^              |
    |                          |
    |     #------------------- |
    | ------------------------ |
    | ------------------------ |
    | ------                   |
    |     # No space permitted |
    |  on either side of = sig |
    | n when initializing vari |
    | ables.                   |
    |     # What happens if th |
    | ere is a space?          |
    |                          |
    |     #  "VARIABLE =value" |
    |     #           ^        |
    |     #% Script tries to r |
    | un "VARIABLE" command wi |
    | th one argument, "=value |
    | ".                       |
    |                          |
    |     #  "VARIABLE= value" |
    |     #            ^       |
    |     #% Script tries to r |
    | un "value" command with  |
    |     #+ the environmental |
    |  variable "VARIABLE" set |
    |  to "".                  |
    |     #------------------- |
    | ------------------------ |
    | ------------------------ |
    | ------                   |
    |                          |
    |                          |
    |     echo hello    # hell |
    | o                        |
    |     # Not a variable ref |
    | erence, just the string  |
    | "hello" ...              |
    |                          |
    |     echo $hello   # 375  |
    |     #    ^          This |
    |  *is* a variable referen |
    | ce.                      |
    |     echo ${hello} # 375  |
    |     #               Like |
    | wise a variable referenc |
    | e, as above.             |
    |                          |
    |     # Quoting . . .      |
    |     echo "$hello"    # 3 |
    | 75                       |
    |     echo "${hello}"  # 3 |
    | 75                       |
    |                          |
    |     echo                 |
    |                          |
    |     hello="A B  C   D"   |
    |     echo $hello   # A B  |
    | C D                      |
    |     echo "$hello" # A B  |
    |  C   D                   |
    |     # As we see, echo $h |
    | ello   and   echo "$hell |
    | o"   give different resu |
    | lts.                     |
    |     # ================== |
    | =====================    |
    |     # Quoting a variable |
    |  preserves whitespace.   |
    |     # ================== |
    | =====================    |
    |                          |
    |     echo                 |
    |                          |
    |     echo '$hello'  # $he |
    | llo                      |
    |     #    ^      ^        |
    |     #  Variable referenc |
    | ing disabled (escaped) b |
    | y single quotes,         |
    |     #+ which causes the  |
    | "$" to be interpreted li |
    | terally.                 |
    |                          |
    |     # Notice the effect  |
    | of different types of qu |
    | oting.                   |
    |                          |
    |                          |
    |     hello=    # Setting  |
    | it to a null value.      |
    |     echo "\$hello (null  |
    | value) = $hello"      #  |
    | $hello (null value) =    |
    |     #  Note that setting |
    |  a variable to a null va |
    | lue is not the same as   |
    |     #+ unsetting it, alt |
    | hough the end result is  |
    | the same (see below).    |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | --------------------     |
    |                          |
    |     #  It is permissible |
    |  to set multiple variabl |
    | es on the same line,     |
    |     #+ if separated by w |
    | hite space.              |
    |     #  Caution, this may |
    |  reduce legibility, and  |
    | may not be portable.     |
    |                          |
    |     var1=21  var2=22  va |
    | r3=$V3                   |
    |     echo                 |
    |     echo "var1=$var1   v |
    | ar2=$var2   var3=$var3"  |
    |                          |
    |     # May cause problems |
    |  with legacy versions of |
    |  "sh" . . .              |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | --------------------     |
    |                          |
    |     echo; echo           |
    |                          |
    |     numbers="one two thr |
    | ee"                      |
    |     #           ^   ^    |
    |     other_numbers="1 2 3 |
    | "                        |
    |     #               ^ ^  |
    |     #  If there is white |
    | space embedded within a  |
    | variable,                |
    |     #+ then quotes are n |
    | ecessary.                |
    |     #  other_numbers=1 2 |
    |  3                  # Gi |
    | ves an error message.    |
    |     echo "numbers = $num |
    | bers"                    |
    |     echo "other_numbers  |
    | = $other_numbers"   # ot |
    | her_numbers = 1 2 3      |
    |     #  Escaping the whit |
    | espace also works.       |
    |     mixed_bag=2\ ---\ Wh |
    | atever                   |
    |     #           ^    ^ S |
    | pace after escape (\).   |
    |                          |
    |     echo "$mixed_bag"    |
    |       # 2 --- Whatever   |
    |                          |
    |     echo; echo           |
    |                          |
    |     echo "uninitialized_ |
    | variable = $uninitialize |
    | d_variable"              |
    |     # Uninitialized vari |
    | able has null value (no  |
    | value at all!).          |
    |     uninitialized_variab |
    | le=   #  Declaring, but  |
    | not initializing it --   |
    |                          |
    |       #+ same as setting |
    |  it to a null value, as  |
    | above.                   |
    |     echo "uninitialized_ |
    | variable = $uninitialize |
    | d_variable"              |
    |                          |
    |       # It still has a n |
    | ull value.               |
    |                          |
    |     uninitialized_variab |
    | le=23       # Set it.    |
    |     unset uninitialized_ |
    | variable    # Unset it.  |
    |     echo "uninitialized_ |
    | variable = $uninitialize |
    | d_variable"              |
    |                          |
    |             # uninitiali |
    | zed_variable =           |
    |                          |
    |             # It still h |
    | as a null value.         |
    |     echo                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +----------+----------+----------+----------+----------+----------+----------+----------+----------+
    | |Caution |
    | |        |
    |          |
    | An       |
    | uninitia |
    | lized    |
    | variable |
    | has a    |
    | "null"   |
    | value -- |
    | no       |
    | assigned |
    | value at |
    | all      |
    | (*not*   |
    | zero!).  |
    |          |
    | +------- |
    | -------- |
    | -------- |
    | ---+---- |
    | -------- |
    | -------- |
    | ------+- |
    | -------- |
    | -------- |
    | -------- |
    | -+       |
    | | .. cod |
    | e:: PROG |
    | RAMLISTI |
    | NG |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |     if |
    |  [ -z "$ |
    | unassign |
    | ed |     |
    | | " ]    |
    |          |
    |          |
    |    |     |
    | |     th |
    | en       |
    |          |
    |    |     |
    | |        |
    | echo "\$ |
    | unassign |
    | ed |     |
    | |  is NU |
    | LL."     |
    |          |
    |    |     |
    | |     fi |
    |      # $ |
    | unassign |
    | ed |     |
    | |  is NU |
    | LL.      |
    |          |
    |    |     |
    |          |
    |          |
    |          |
    |          |
    | +------- |
    | -------- |
    | -------- |
    | ---+---- |
    | -------- |
    | -------- |
    | ------+- |
    | -------- |
    | -------- |
    | -------- |
    | -+       |
    |          |
    | .. raw:: |
    |  html    |
    |          |
    |    </p>  |
    |          |
    | Using a  |
    | variable |
    | before   |
    | assignin |
    | g        |
    | a value  |
    | to it    |
    | may      |
    | cause    |
    | problems |
    | .        |
    | It is    |
    | neverthe |
    | less     |
    | possible |
    | to       |
    | perform  |
    | arithmet |
    | ic       |
    | operatio |
    | ns       |
    | on an    |
    | uninitia |
    | lized    |
    | variable |
    | .        |
    |          |
    | +------- |
    | -------- |
    | -------- |
    | ---+---- |
    | -------- |
    | -------- |
    | ------+- |
    | -------- |
    | -------- |
    | -------- |
    | -+       |
    | | .. cod |
    | e:: PROG |
    | RAMLISTI |
    | NG |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |     ec |
    | ho "$uni |
    | nitializ |
    | ed |     |
    | | "      |
    |          |
    |          |
    |    |     |
    | |        |
    |    # (bl |
    | ank line |
    | )  |     |
    | |     le |
    | t "unini |
    | tialized |
    |  + |     |
    | | = 5"   |
    |          |
    |          |
    |    |     |
    | |        |
    |    # Add |
    |  5 to it |
    | .  |     |
    | |     ec |
    | ho "$uni |
    | nitializ |
    | ed |     |
    | | "      |
    |          |
    |          |
    |    |     |
    | |        |
    |    # 5   |
    |          |
    |    |     |
    | |        |
    |          |
    |          |
    |    |     |
    | |     #  |
    |  Conclus |
    | ion:     |
    |    |     |
    | |     #  |
    |  An unin |
    | itialize |
    | d  |     |
    | | variab |
    | le has n |
    | o value, |
    |    |     |
    | |     #+ |
    |  however |
    |  it eval |
    | ua |     |
    | | tes as |
    |  0 in an |
    |  arithme |
    | ti |     |
    | | c oper |
    | ation.   |
    |          |
    |    |     |
    |          |
    |          |
    |          |
    |          |
    | +------- |
    | -------- |
    | -------- |
    | ---+---- |
    | -------- |
    | -------- |
    | ------+- |
    | -------- |
    | -------- |
    | -------- |
    | -+       |
    |          |
    | See also |
    | `Example |
    | 15-23 <i |
    | nternal. |
    | html#SEL |
    | FSOURCE> |
    | `__.     |
    |          |
    | .. raw:: |
    |  html    |
    |          |
    |    </p>  |
              
    +----------+----------+----------+----------+----------+----------+----------+----------+----------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------+--------------------------+--------------------------+
| `[1] <varsubn.html#AEN22 |
| 58>`__                   |
| Technically, the *name*  |
| of a variable is called  |
| an *lvalue*, meaning     |
| that it appears on the   |
| *left* side of an        |
| assignment statment, as  |
| in ``VARIABLE=23``. A    |
| variable's *value* is an |
| *rvalue*, meaning that   |
| it appears on the        |
| *right* side of an       |
| assignment statement, as |
| in ``VAR2=$VARIABLE``.   |
|                          |
| A variable's *name* is,  |
| in fact, a *reference*,  |
| a *pointer* to the       |
| memory location(s) where |
| the actual data          |
| associated with that     |
| variable is kept.        |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <variables.html>`_ | Introduction to          |
| _                        | Variables and Parameters |
| `Home <index.html>`__    | `Up <variables.html>`__  |
| `Next <varassignment.htm | Variable Assignment      |
| l>`__                    |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
