+----------------------------------+--------------------------+-------------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+==========================+===============================+
| `Prev <wrapper.html>`_           | Chapter 36. Miscellany   | `Next <recursionsct.html>`_   |
+----------------------------------+--------------------------+-------------------------------+

--------------

36.3. Tests and Comparisons: Alternatives
=========================================

For tests, the `[[ ]] <testconstructs.html#DBLBRACKETS>`_ construct may
be more appropriate than ``[       ]``. Likewise, `arithmetic
comparisons <comparison-ops.html#ICOMPARISON1>`_ might benefit from the
`(( )) <dblparens.html>`_ construct.

::

    a=8

    # All of the comparisons below are equivalent.
    test "$a" -lt 16 && echo "yes, $a < 16"         # "and list"
    /bin/test "$a" -lt 16 && echo "yes, $a < 16" 
    [ "$a" -lt 16 ] && echo "yes, $a < 16" 
    [[ $a -lt 16 ]] && echo "yes, $a < 16"          # Quoting variables within
    (( a < 16 )) && echo "yes, $a < 16"             # [[ ]] and (( )) not necessary.

    city="New York"
    # Again, all of the comparisons below are equivalent.
    test "$city" \< Paris && echo "Yes, Paris is greater than $city"
                                      # Greater ASCII order.
    /bin/test "$city" \< Paris && echo "Yes, Paris is greater than $city" 
    [ "$city" \< Paris ] && echo "Yes, Paris is greater than $city" 
    [[ $city < Paris ]] && echo "Yes, Paris is greater than $city"
                                      # Need not quote $city.

    # Thank you, S.C.

--------------

+--------------------------+---------------------------+--------------------------------------+
| `Prev <wrapper.html>`_   | `Home <index.html>`_      | `Next <recursionsct.html>`_          |
+--------------------------+---------------------------+--------------------------------------+
| Shell Wrappers           | `Up <miscellany.html>`_   | Recursion: a script calling itself   |
+--------------------------+---------------------------+--------------------------------------+

