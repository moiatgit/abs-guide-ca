+----------------------------------+--------------------+---------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+====================+===========================+
| `Prev <comparison-ops.html>`_    | Chapter 7. Tests   | `Next <testtest.html>`_   |
+----------------------------------+--------------------+---------------------------+

--------------

7.4. Nested ``if/then`` Condition Tests
=======================================

Condition tests using the ``if/then`` construct may be nested. The net
result is equivalent to using the `*&&* <ops.html#LOGOPS1>`_ compound
comparison operator.

::

    a=3

    if [ "$a" -gt 0 ]
    then
      if [ "$a" -lt 5 ]
      then
        echo "The value of \"a\" lies somewhere between 0 and 5."
      fi
    fi

    # Same result as:

    if [ "$a" -gt 0 ] && [ "$a" -lt 5 ]
    then
      echo "The value of \"a\" lies somewhere between 0 and 5."
    fi

`Example 37-4 <bashver2.html#CARDS>`_ and `Example
17-11 <system.html#BACKLIGHT>`_ demonstrate nested ``if/then`` condition
tests.

--------------

+---------------------------------+------------------------+-----------------------------------+
| `Prev <comparison-ops.html>`_   | `Home <index.html>`_   | `Next <testtest.html>`_           |
+---------------------------------+------------------------+-----------------------------------+
| Other Comparison Operators      | `Up <tests.html>`_     | Testing Your Knowledge of Tests   |
+---------------------------------+------------------------+-----------------------------------+

