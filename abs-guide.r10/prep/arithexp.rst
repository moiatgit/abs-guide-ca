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

`Prev <commandsub.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <recess-time.html>`__

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

  Chapter 13. Arithmetic Expansion
=================================

 Arithmetic expansion provides a powerful tool for performing (integer)
arithmetic operations in scripts. Translating a string into a numerical
expression is relatively straightforward using *backticks* , *double
parentheses* , or *let* .

.. raw:: html

   <div class="VARIABLELIST">

** Variations**

 Arithmetic expansion with `backticks <commandsub.html#BACKQUOTESREF>`__
(often used in conjunction with `expr <moreadv.html#EXPRREF>`__ )
    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     z=`expr $z + 3`      |
    |      # The 'expr' comman |
    | d performs the expansion |
    | .                        |
                              
    +--------------------------+--------------------------+--------------------------+

 Arithmetic expansion with `double parentheses <dblparens.html>`__ , and
using `let <internal.html#LETREF>`__
    The use of *backticks* ( *backquotes* ) in arithmetic expansion has
    been superseded by *double parentheses* --
    ``                   ((...))                 `` and
    ``                   $((...))                 `` -- and also by the
    very convenient `let <internal.html#LETREF>`__ construction.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     z=$(($z+3))          |
    |     z=$((z+3))           |
    |                          |
    | #  Also correct.         |
    |                          |
    |                          |
    | #  Within double parenth |
    | eses,                    |
    |                          |
    |                          |
    | #+ parameter dereferenci |
    | ng                       |
    |                          |
    |                          |
    | #+ is optional.          |
    |                          |
    |     # $((EXPRESSION)) is |
    |  arithmetic expansion.   |
    | #  Not to be confused wi |
    | th                       |
    |                          |
    |                          |
    | #+ command substitution. |
    |                          |
    |                          |
    |                          |
    |     # You may also use o |
    | perations within double  |
    | parentheses without assi |
    | gnment.                  |
    |                          |
    |       n=0                |
    |       echo "n = $n"      |
    |                          |
    | # n = 0                  |
    |                          |
    |       (( n += 1 ))       |
    |                          |
    | # Increment.             |
    |     # (( $n += 1 )) is i |
    | ncorrect!                |
    |       echo "n = $n"      |
    |                          |
    | # n = 1                  |
    |                          |
    |                          |
    |     let z=z+3            |
    |     let "z += 3"  #  Quo |
    | tes permit the use of sp |
    | aces in variable assignm |
    | ent.                     |
    |                   #  The |
    |  'let' operator actually |
    |  performs arithmetic eva |
    | luation,                 |
    |                   #+ rat |
    | her than expansion.      |
                              
    +--------------------------+--------------------------+--------------------------+

    Examples of arithmetic expansion in scripts:

    #. `Example 16-9 <moreadv.html#EX45>`__

    #. `Example 11-15 <loops1.html#EX25>`__

    #. `Example 27-1 <arrays.html#EX66>`__

    #. `Example 27-11 <arrays.html#BUBBLE>`__

    #. `Example A-16 <contributed-scripts.html#TREE>`__

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <commandsub.html>` | Command Substitution     |
| __                       | `Up <part3.html>`__      |
| `Home <index.html>`__    | Recess Time              |
| `Next <recess-time.html> |                          |
| `__                      |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

