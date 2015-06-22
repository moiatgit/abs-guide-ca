.. raw:: html

   <div class="SECT1">

  8.3. The Double-Parentheses Construct
======================================

Similar to the `let <internal.html#LETREF>`__ command, the **(( ... ))**
construct permits arithmetic expansion and evaluation. In its simplest
form, ``             a=$(( 5 + 3 ))           `` would set
``             a           `` to ``             5 + 3           `` , or
``             8           `` . However, this double-parentheses
construct is also a mechanism for allowing C-style manipulation of
variables in Bash, for example, ``      (( var++ ))     `` .

.. raw:: html

   <div class="EXAMPLE">

**Example 8-5. C-style manipulation of variables**

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

    #!/bin/bash
    # c-vars.sh
    # Manipulating a variable, C-style, using the (( ... )) construct.


    echo

    (( a = 23 ))  #  Setting a value, C-style,
                  #+ with spaces on both sides of the "=".
    echo "a (initial value) = $a"   # 23

    (( a++ ))     #  Post-increment 'a', C-style.
    echo "a (after a++) = $a"       # 24

    (( a-- ))     #  Post-decrement 'a', C-style.
    echo "a (after a--) = $a"       # 23


    (( ++a ))     #  Pre-increment 'a', C-style.
    echo "a (after ++a) = $a"       # 24

    (( --a ))     #  Pre-decrement 'a', C-style.
    echo "a (after --a) = $a"       # 23

    echo

    ########################################################
    #  Note that, as in C, pre- and post-decrement operators
    #+ have different side-effects.

    n=1; let --n && echo "True" || echo "False"  # False
    n=1; let n-- && echo "True" || echo "False"  # True

    #  Thanks, Jeroen Domburg.
    ########################################################

    echo

    (( t = a<45?7:11 ))   # C-style trinary operator.
    #       ^  ^ ^
    echo "If a < 45, then t = 7, else t = 11."  # a = 23
    echo "t = $t "                              # t = 7

    echo


    # -----------------
    # Easter Egg alert!
    # -----------------
    #  Chet Ramey seems to have snuck a bunch of undocumented C-style
    #+ constructs into Bash (actually adapted from ksh, pretty much).
    #  In the Bash docs, Ramey calls (( ... )) shell arithmetic,
    #+ but it goes far beyond that.
    #  Sorry, Chet, the secret is out.

    # See also "for" and "while" loops using the (( ... )) construct.

    # These work only with version 2.04 or later of Bash.

    exit

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

See also `Example 11-13 <loops1.html#FORLOOPC>`__ and `Example
8-4 <numerical-constants.html#NUMBERS>`__ .

.. raw:: html

   </div>

