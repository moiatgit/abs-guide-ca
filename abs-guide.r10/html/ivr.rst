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

`Prev <arrays.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <devproc.html>`__

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

   <div class="CHAPTER">

Chapter 28. Indirect References
===============================

We have seen that `referencing a variable <varsubn.html>`__, ``$var``,
fetches its *value*. But, what about the *value of a value*? What about
``$$var``?

The actual notation is ``\$$var``, usually preceded by an
`eval <internal.html#EVALREF>`__ (and sometimes an
`echo <internal.html#ECHOREF>`__). This is called an *indirect
reference*.

.. raw:: html

   <div class="EXAMPLE">

**Example 28-1. Indirect Variable References**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ind-ref.sh: Indire |
| ct variable referencing. |
|     # Accessing the cont |
| ents of the contents of  |
| a variable.              |
|                          |
|     # First, let's fool  |
| around a little.         |
|                          |
|     var=23               |
|                          |
|     echo "\$var   = $var |
| "           # $var   = 2 |
| 3                        |
|     # So far, everything |
|  as expected. But ...    |
|                          |
|     echo "\$\$var  = $$v |
| ar"         # $$var  = 4 |
| 570var                   |
|     #  Not useful ...    |
|     #  \$\$ expanded to  |
| PID of the script        |
|     #  -- refer to the e |
| ntry on the $$ variable  |
| --                       |
|     #+ and "var" is echo |
| ed as plain text.        |
|     #  (Thank you, Jakob |
|  Bohm, for pointing this |
|  out.)                   |
|                          |
|     echo "\\\$\$var = \$ |
| $var"       # \$$var = $ |
| 23                       |
|     #  As expected. The  |
| first $ is escaped and p |
| asted on to              |
|     #+ the value of var  |
| ($var = 23 ).            |
|     #  Meaningful, but s |
| till not useful.         |
|                          |
|     # Now, let's start o |
| ver and do it the right  |
| way.                     |
|                          |
|     # ================== |
| ======================== |
| ==== #                   |
|                          |
|                          |
|     a=letter_of_alphabet |
|    # Variable "a" holds  |
| the name of another vari |
| able.                    |
|     letter_of_alphabet=z |
|                          |
|     echo                 |
|                          |
|     # Direct reference.  |
|     echo "a = $a"        |
|    # a = letter_of_alpha |
| bet                      |
|                          |
|     # Indirect reference |
| .                        |
|       eval a=\$$a        |
|     # ^^^        Forcing |
|  an eval(uation), and .. |
| .                        |
|     #        ^   Escapin |
| g the first $ ...        |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| ------                   |
|     # The 'eval' forces  |
| an update of $a, sets it |
|  to the updated value of |
|  \$$a.                   |
|     # So, we see why 'ev |
| al' so often shows up in |
|  indirect reference nota |
| tion.                    |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| ------                   |
|       echo "Now a = $a"  |
|    # Now a = z           |
|                          |
|     echo                 |
|                          |
|                          |
|     # Now, let's try cha |
| nging the second-order r |
| eference.                |
|                          |
|     t=table_cell_3       |
|     table_cell_3=24      |
|     echo "\"table_cell_3 |
| \" = $table_cell_3"      |
|        # "table_cell_3"  |
| = 24                     |
|     echo -n "dereference |
| d \"t\" = "; eval echo \ |
| $$t    # dereferenced "t |
| " = 24                   |
|     # In this simple cas |
| e, the following also wo |
| rks (why?).              |
|     #         eval t=\$$ |
| t; echo "\"t\" = $t"     |
|                          |
|     echo                 |
|                          |
|     t=table_cell_3       |
|     NEW_VAL=387          |
|     table_cell_3=$NEW_VA |
| L                        |
|     echo "Changing value |
|  of \"table_cell_3\" to  |
| $NEW_VAL."               |
|     echo "\"table_cell_3 |
| \" now $table_cell_3"    |
|     echo -n "dereference |
| d \"t\" now "; eval echo |
|  \$$t                    |
|     # "eval" takes the t |
| wo arguments "echo" and  |
| "\$$t" (set equal to $ta |
| ble_cell_3)              |
|                          |
|                          |
|     echo                 |
|                          |
|     # (Thanks, Stephane  |
| Chazelas, for clearing u |
| p the above behavior.)   |
|                          |
|                          |
|     #   A more straightf |
| orward method is the ${! |
| t} notation, discussed i |
| n the                    |
|     #+ "Bash, version 2" |
|  section.                |
|     #   See also ex78.sh |
| .                        |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| Indirect referencing in Bash is a multi-step process. First, take the    |
| name of a variable: ``varname``. Then, reference it: ``$varname``. Then, |
| reference the reference: ``$$varname``. Then, *escape* the first $:      |
| ``\$$varname``. Finally, force a reevaluation of the expression and      |
| assign it: **eval newvar=\\$$varname**.                                  |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

Of what practical use is indirect referencing of variables? It gives
Bash a little of the functionality of
`pointers <varsubn.html#POINTERREF>`__ in *C*, for instance, in `table
lookup <bashver2.html#RESISTOR>`__. And, it also has some other very
interesting applications. . . .

Nils Radtke shows how to build "dynamic" variable names and evaluate
their contents. This can be useful when
`sourcing <internal.html#SOURCEREF>`__ configuration files.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|                          |
|     # ------------------ |
| ------------------------ |
| ---                      |
|     # This could be "sou |
| rced" from a separate fi |
| le.                      |
|     isdnMyProviderRemote |
| Net=172.16.0.100         |
|     isdnYourProviderRemo |
| teNet=10.0.0.10          |
|     isdnOnlineService="M |
| yProvider"               |
|     # ------------------ |
| ------------------------ |
| ---                      |
|                          |
|                          |
|     remoteNet=$(eval "ec |
| ho \$$(echo isdn${isdnOn |
| lineService}RemoteNet)") |
|     remoteNet=$(eval "ec |
| ho \$$(echo isdnMyProvid |
| erRemoteNet)")           |
|     remoteNet=$(eval "ec |
| ho \$isdnMyProviderRemot |
| eNet")                   |
|     remoteNet=$(eval "ec |
| ho $isdnMyProviderRemote |
| Net")                    |
|                          |
|     echo "$remoteNet"    |
|  # 172.16.0.100          |
|                          |
|     # ================== |
| ======================== |
| ======================   |
|                          |
|     #  And, it gets even |
|  better.                 |
|                          |
|     #  Consider the foll |
| owing snippet given a va |
| riable named getSparc,   |
|     #+ but no such varia |
| ble getIa64:             |
|                          |
|     chkMirrorArchs () {  |
|       arch="$1";         |
|       if [ "$(eval "echo |
|  \${$(echo get$(echo -ne |
|  $arch |                 |
|            sed 's/^\(.\) |
| .*/\1/g' | tr 'a-z' 'A-Z |
| '; echo $arch |          |
|            sed 's/^.\(.* |
| \)/\1/g')):-false}")" =  |
| true ]                   |
|       then               |
|          return 0;       |
|       else               |
|          return 1;       |
|       fi;                |
|     }                    |
|                          |
|     getSparc="true"      |
|     unset getIa64        |
|     chkMirrorArchs sparc |
|     echo $?        # 0   |
|                    # Tru |
| e                        |
|                          |
|     chkMirrorArchs Ia64  |
|     echo $?        # 1   |
|                    # Fal |
| se                       |
|                          |
|     # Notes:             |
|     # -----              |
|     # Even the to-be-sub |
| stituted variable name p |
| art is built explicitly. |
|     # The parameters to  |
| the chkMirrorArchs calls |
|  are all lower case.     |
|     # The variable name  |
| is composed of two parts |
| : "get" and "Sparc" . .  |
| .                        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="EXAMPLE">

**Example 28-2. Passing an indirect reference to *awk***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #  Another version o |
| f the "column totaler" s |
| cript                    |
|     #+ that adds up a sp |
| ecified column (of numbe |
| rs) in the target file.  |
|     #  This one uses ind |
| irect references.        |
|                          |
|     ARGS=2               |
|     E_WRONGARGS=85       |
|                          |
|     if [ $# -ne "$ARGS"  |
| ] # Check for proper num |
| ber of command-line args |
| .                        |
|     then                 |
|        echo "Usage: `bas |
| ename $0` filename colum |
| n-number"                |
|        exit $E_WRONGARGS |
|     fi                   |
|                          |
|     filename=$1          |
| # Name of file to operat |
| e on.                    |
|     column_number=$2     |
| # Which column to total  |
| up.                      |
|                          |
|     #===== Same as origi |
| nal script, up to this p |
| oint =====#              |
|                          |
|                          |
|     # A multi-line awk s |
| cript is invoked by      |
|     #   awk "            |
|     #   ...              |
|     #   ...              |
|     #   ...              |
|     #   "                |
|                          |
|                          |
|     # Begin awk script.  |
|     # ------------------ |
| ------------------------ |
| -------                  |
|     awk "                |
|                          |
|     { total += \$${colum |
| n_number} # Indirect ref |
| erence                   |
|     }                    |
|     END {                |
|          print total     |
|          }               |
|                          |
|          " "$filename"   |
|     # Note that awk does |
| n't need an eval precedi |
| ng \$$.                  |
|     # ------------------ |
| ------------------------ |
| -------                  |
|     # End awk script.    |
|                          |
|     #  Indirect variable |
|  reference avoids the ha |
| ssles                    |
|     #+ of referencing a  |
| shell variable within th |
| e embedded awk script.   |
|     #  Thanks, Stephane  |
| Chazelas.                |
|                          |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+--------------------------------------+--------------------------------------+
| |Caution|                            |
| This method of indirect referencing  |
| is a bit tricky. If the second order |
| variable changes its value, then the |
| first order variable must be         |
| properly dereferenced (as in the     |
| above example). Fortunately, the     |
| ``${!variable}`` notation introduced |
| with `version                        |
| 2 <bashver2.html#BASH2REF>`__ of     |
| Bash (see `Example                   |
| 37-2 <bashver2.html#EX78>`__ and     |
| `Example                             |
| A-22 <contributed-scripts.html#HASHE |
| X2>`__)                              |
| makes indirect referencing more      |
| intuitive.                           |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| Bash does not support pointer arithmetic, and this severely limits the   |
| usefulness of indirect referencing. In fact, indirect referencing in a   |
| scripting language is, at best, something of an afterthought.            |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <arrays.html>`__   | Arrays                   |
| `Home <index.html>`__    | `Up <part5.html>`__      |
| `Next <devproc.html>`__  | ``/dev`` and ``/proc``   |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
