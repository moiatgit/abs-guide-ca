####################################################################
XXX  7.4. Nested ``             if/then           `` Condition Tests
####################################################################

Condition tests using the ``             if/then           `` construct
may be nested. The net result is equivalent to using the
`*&&* <ops.html#LOGOPS1>`__ compound comparison operator.

.. raw:: html

   <div>

.. code:: PROGRAMLISTING

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

.. raw:: html

   </p>

.. raw:: html

   </div>

`Example 37-4 <bashver2.html#CARDS>`__ and `Example
17-11 <system.html#BACKLIGHT>`__ demonstrate nested
``             if/then           `` condition tests.

.. raw:: html

   </div>

