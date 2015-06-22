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

`Prev <internalvariables.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 9. Another Look at Variables

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <randomvar.html>`__

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

  9.2. Typing variables: **declare** or **typeset**
==================================================

The *declare* or *typeset* `builtins <internal.html#BUILTINREF>`__ ,
which are exact synonyms, permit modifying the properties of variables.
This is a very weak form of the *typing* ` [1]
 <declareref.html#FTN.AEN5685>`__ available in certain programming
languages. The *declare* command is specific to version 2 or later of
Bash. The *typeset* command also works in ksh scripts.

.. raw:: html

   <div class="VARIABLELIST">

** declare/typeset options**

 -r ``                 readonly               ``
    ( ``                   declare -r var1                 `` works the
    same as ``                   readonly var1                 `` )

    This is the rough equivalent of the **C** *const* type qualifier. An
    attempt to change the value of a *readonly* variable fails with an
    error message.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     declare -r var1=1    |
    |     echo "var1 = $var1"  |
    |   # var1 = 1             |
    |                          |
    |     (( var1++ ))         |
    |   # x.sh: line 4: var1:  |
    | readonly variable        |
                              
    +--------------------------+--------------------------+--------------------------+

 -i ``                 integer               ``
    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     declare -i number    |
    |     # The script will tr |
    | eat subsequent occurrenc |
    | es of "number" as an int |
    | eger.                    |
    |                          |
    |     number=3             |
    |     echo "Number = $numb |
    | er"     # Number = 3     |
    |                          |
    |     number=three         |
    |     echo "Number = $numb |
    | er"     # Number = 0     |
    |     # Tries to evaluate  |
    | the string "three" as an |
    |  integer.                |
                              
    +--------------------------+--------------------------+--------------------------+

    Certain arithmetic operations are permitted for declared integer
    variables without the need for `expr <moreadv.html#EXPRREF>`__ or
    `let <internal.html#LETREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     n=6/3                |
    |     echo "n = $n"        |
    | # n = 6/3                |
    |                          |
    |     declare -i n         |
    |     n=6/3                |
    |     echo "n = $n"        |
    | # n = 2                  |
                              
    +--------------------------+--------------------------+--------------------------+

 -a ``                 array               ``
    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     declare -a indices   |
                              
    +--------------------------+--------------------------+--------------------------+

    The variable ``                   indices                 `` will be
    treated as an `array <arrays.html#ARRAYREF>`__ .

 -f ``                 function(s)               ``
    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     declare -f           |
                              
    +--------------------------+--------------------------+--------------------------+

    A ``                   declare -f                 `` line with no
    arguments in a script causes a listing of all the
    `functions <functions.html#FUNCTIONREF>`__ previously defined in
    that script.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     declare -f function_ |
    | name                     |
                              
    +--------------------------+--------------------------+--------------------------+

    A ``                   declare -f function_name                 ``
    in a script lists just the function named.

 -x `export <internal.html#EXPORTREF>`__
    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     declare -x var3      |
                              
    +--------------------------+--------------------------+--------------------------+

    This declares a variable as available for exporting outside the
    environment of the script itself.

 -x var=$value
    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     declare -x var3=373  |
                              
    +--------------------------+--------------------------+--------------------------+

    The **declare** command permits assigning a value to a variable in
    the same statement as setting its properties.

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 9-10. Using *declare* to type variables**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     func1 ()             |
|     {                    |
|       echo This is a fun |
| ction.                   |
|     }                    |
|                          |
|     declare -f        #  |
| Lists the function above |
| .                        |
|                          |
|     echo                 |
|                          |
|     declare -i var1   #  |
| var1 is an integer.      |
|     var1=2367            |
|     echo "var1 declared  |
| as $var1"                |
|     var1=var1+1       #  |
| Integer declaration elim |
| inates the need for 'let |
| '.                       |
|     echo "var1 increment |
| ed by 1 is $var1."       |
|     # Attempt to change  |
| variable declared as int |
| eger.                    |
|     echo "Attempting to  |
| change var1 to floating  |
| point value, 2367.1."    |
|     var1=2367.1       #  |
| Results in error message |
| , with no change to vari |
| able.                    |
|     echo "var1 is still  |
| $var1"                   |
|                          |
|     echo                 |
|                          |
|     declare -r var2=13.3 |
| 6         # 'declare' pe |
| rmits setting a variable |
|  property                |
|                          |
|           #+ and simulta |
| neously assigning it a v |
| alue.                    |
|     echo "var2 declared  |
| as $var2" # Attempt to c |
| hange readonly variable. |
|     var2=13.37           |
|           # Generates er |
| ror message, and exit fr |
| om script.               |
|                          |
|     echo "var2 is still  |
| $var2"    # This line wi |
| ll not execute.          |
|                          |
|     exit 0               |
|           # Script will  |
| not exit here.           |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+----------------+----------------+----------------+----------------+----------------+
| |Caution|      |
| Using the      |
| *declare*      |
| builtin        |
| restricts the  |
| `scope <subshe |
| lls.html#SCOPE |
| REF>`__        |
| of a variable. |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
| | .. code:: PR |
| OGRAMLISTING | |
| |              |
|              | |
| |     foo ()   |
|              | |
| |     {        |
|              | |
| |     FOO="bar |
| "            | |
| |     }        |
|              | |
| |              |
|              | |
| |     bar ()   |
|              | |
| |     {        |
|              | |
| |     foo      |
|              | |
| |     echo $FO |
| O            | |
| |     }        |
|              | |
| |              |
|              | |
| |     bar   #  |
| Prints bar.  | |
|                |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
|                |
| However . . .  |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
| | .. code:: PR |
| OGRAMLISTING | |
| |              |
|              | |
| |     foo (){  |
|              | |
| |     declare  |
| FOO="bar"    | |
| |     }        |
|              | |
| |              |
|              | |
| |     bar ()   |
|              | |
| |     {        |
|              | |
| |     foo      |
|              | |
| |     echo $FO |
| O            | |
| |     }        |
|              | |
| |              |
|              | |
| |     bar  # P |
| rints nothin | |
| | g.           |
|              | |
| |              |
|              | |
| |              |
|              | |
| |     # Thank  |
| you, Michael | |
| |  Iatrou, for |
|  pointing th | |
| | is out.      |
|              | |
|                |
|                |
| +------------- |
| -------------+ |
| -------------- |
| ------------+- |
| -------------- |
| -----------+   |
                
+----------------+----------------+----------------+----------------+----------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="SECT2">

  9.2.1. Another use for *declare*
---------------------------------

The *declare* command can be helpful in identifying variables,
`environmental <othertypesv.html#ENVREF>`__ or otherwise. This can be
especially useful with `arrays <arrays.html#ARRAYREF>`__ .

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ declare | grep |
|  HOME                    |
|     HOME=/home/bozo      |
|                          |
|                          |
|     bash$ zzy=68         |
|     bash$ declare | grep |
|  zzy                     |
|     zzy=68               |
|                          |
|                          |
|     bash$ Colors=([0]="p |
| urple" [1]="reddish-oran |
| ge" [2]="light green")   |
|     bash$ echo ${Colors[ |
| @]}                      |
|     purple reddish-orang |
| e light green            |
|     bash$ declare | grep |
|  Colors                  |
|     Colors=([0]="purple" |
|  [1]="reddish-orange" [2 |
| ]="light green")         |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------+--------------------+--------------------+--------------------+
| ` [1]              |
|  <declareref.html# |
| AEN5685>`__        |
|  In this context,  |
| *typing* a         |
| variable means to  |
| classify it and    |
| restrict its       |
| properties. For    |
| example, a         |
| variable           |
| *declared* or      |
| *typed* as an      |
| integer is no      |
| longer available   |
| for `string        |
| operations <refcar |
| ds.html#STRINGOPST |
| AB>`__             |
| .                  |
|                    |
| +----------------- |
| ---------+-------- |
| ------------------ |
| +----------------- |
| ---------+         |
| | .. code:: PROGRA |
| MLISTING |         |
| |                  |
|          |         |
| |     declare -i i |
| ntvar    |         |
| |                  |
|          |         |
| |     intvar=23    |
|          |         |
| |     echo "$intva |
| r"   # 2 |         |
| | 3                |
|          |         |
| |     intvar=strin |
| gval     |         |
| |     echo "$intva |
| r"   # 0 |         |
|                    |
|                    |
| +----------------- |
| ---------+-------- |
| ------------------ |
| +----------------- |
| ---------+         |
                    
+--------------------+--------------------+--------------------+--------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <internalvariables | Internal Variables       |
| .html>`__                | `Up <variables2.html>`__ |
| `Home <index.html>`__    | $RANDOM: generate random |
| `Next <randomvar.html>`_ | integer                  |
| _                        |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
