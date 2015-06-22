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

`Prev <process-sub.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <complexfunct.html>`__

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

Chapter 24. Functions
=====================

.. raw:: html

   <div class="TOC">

.. raw:: html

   <dl>

.. raw:: html

   <dt>

**Table of Contents**

.. raw:: html

   </dt>

.. raw:: html

   <dt>

24.1. `Complex Functions and Function
Complexities <complexfunct.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

24.2. `Local Variables <localvar.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

24.3. `Recursion Without Local Variables <recurnolocvar.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </div>

Like "real" programming languages, Bash has functions, though in a
somewhat limited implementation. A function is a subroutine, a `code
block <special-chars.html#CODEBLOCKREF>`__ that implements a set of
operations, a "black box" that performs a specified task. Wherever there
is repetitive code, when a task repeats with only slight variations in
procedure, then consider using a function.

| **function** ``function_name`` {
|  ``command``...
|  }

or
| ``function_name`` () {
|  ``command``...
|  }

.. raw:: html

   </p>

This second form will cheer the hearts of C programmers (and is more
`portable <portabilityissues.html>`__).

As in C, the function's opening bracket may optionally appear on the
second line.

| ``function_name`` ()
|  {
|  ``command``...
|  }

.. raw:: html

   </p>

.. raw:: html

   <div class="NOTE">

+----------+----------+----------+----------+----------+----------+----------+----------+----------+
| |Note|   |
| A        |
| function |
| may be   |
| "compact |
| ed"      |
| into a   |
| single   |
| line.    |
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
| |     fu |
| n () { e |
| cho "Thi |
| s  |     |
| | is a f |
| unction" |
| ; echo;  |
| }  |     |
| |     #  |
|          |
|          |
|    |     |
| |        |
|          |
| ^     ^  |
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
| In this  |
| case,    |
| however, |
| a        |
| *semicol |
| on*      |
| must     |
| follow   |
| the      |
| final    |
| command  |
| in the   |
| function |
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
| |     fu |
| n () { e |
| cho "Thi |
| s  |     |
| | is a f |
| unction" |
| ; echo } |
|  # |     |
| |  Error |
| !        |
|          |
|    |     |
| |     #  |
|          |
|          |
|    |     |
| |        |
|          |
|       ^  |
|    |     |
| |        |
|          |
|          |
|    |     |
| |     fu |
| n2 () {  |
| echo "Ev |
| en |     |
| |  a sin |
| gle-comm |
| and func |
| ti |     |
| | on? Ye |
| s!"; }   |
|          |
|    |     |
| |     #  |
|          |
|          |
|    |     |
| |        |
|          |
|          |
|    |     |
| |        |
|    ^     |
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
          
+----------+----------+----------+----------+----------+----------+----------+----------+----------+

.. raw:: html

   </div>

Functions are called, *triggered*, simply by invoking their names. *A
function call is equivalent to a command.*

.. raw:: html

   <div class="EXAMPLE">

**Example 24-1. Simple functions**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ex59.sh: Exercisin |
| g functions (simple).    |
|                          |
|     JUST_A_SECOND=1      |
|                          |
|     funky ()             |
|     { # This is about as |
|  simple as functions get |
| .                        |
|       echo "This is a fu |
| nky function."           |
|       echo "Now exiting  |
| funky function."         |
|     } # Function declara |
| tion must precede call.  |
|                          |
|                          |
|     fun ()               |
|     { # A somewhat more  |
| complex function.        |
|       i=0                |
|       REPEATS=30         |
|                          |
|       echo               |
|       echo "And now the  |
| fun really begins."      |
|       echo               |
|                          |
|       sleep $JUST_A_SECO |
| ND    # Hey, wait a seco |
| nd!                      |
|       while [ $i -lt $RE |
| PEATS ]                  |
|       do                 |
|         echo "---------- |
| FUNCTIONS---------->"    |
|         echo "<--------- |
| ---ARE-------------"     |
|         echo "<--------- |
| ---FUN------------>"     |
|         echo             |
|         let "i+=1"       |
|       done               |
|     }                    |
|                          |
|       # Now, call the fu |
| nctions.                 |
|                          |
|     funky                |
|     fun                  |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

The function definition must precede the first call to it. There is no
method of "declaring" the function, as, for example, in C.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     f1                   |
|     # Will give an error |
|  message, since function |
|  "f1" not yet defined.   |
|                          |
|     declare -f f1      # |
|  This doesn't help eithe |
| r.                       |
|     f1                 # |
|  Still an error message. |
|                          |
|     # However...         |
|                          |
|                          |
|     f1 ()                |
|     {                    |
|       echo "Calling func |
| tion \"f2\" from within  |
| function \"f1\"."        |
|       f2                 |
|     }                    |
|                          |
|     f2 ()                |
|     {                    |
|       echo "Function \"f |
| 2\"."                    |
|     }                    |
|                          |
|     f1  #  Function "f2" |
|  is not actually called  |
| until this point,        |
|         #+ although it i |
| s referenced before its  |
| definition.              |
|         #  This is permi |
| ssible.                  |
|                          |
|         # Thanks, S.C.   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="NOTE">

+--------------------+--------------------+--------------------+--------------------+
| |Note|             |
| Functions may not  |
| be empty!          |
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
| |     #!/bin/bash  |
|          |         |
| |     # empty-func |
| tion.sh  |         |
| |                  |
|          |         |
| |     empty ()     |
|          |         |
| |     {            |
|          |         |
| |     }            |
|          |         |
| |                  |
|          |         |
| |     exit 0  # Wi |
| ll not e |         |
| | xit here!        |
|          |         |
| |                  |
|          |         |
| |     # $ sh empty |
| -functio |         |
| | n.sh             |
|          |         |
| |     # empty-func |
| tion.sh: |         |
| |  line 6: syntax  |
| error ne |         |
| | ar unexpected to |
| ken `}'  |         |
| |     # empty-func |
| tion.sh: |         |
| |  line 6: `}'     |
|          |         |
| |                  |
|          |         |
| |     # $ echo $?  |
|          |         |
| |     # 2          |
|          |         |
| |                  |
|          |         |
| |                  |
|          |         |
| |     # Note that  |
| a functi |         |
| | on containing on |
| ly comme |         |
| | nts is empty.    |
|          |         |
| |                  |
|          |         |
| |     func ()      |
|          |         |
| |     {            |
|          |         |
| |       # Comment  |
| 1.       |         |
| |       # Comment  |
| 2.       |         |
| |       # This is  |
| still an |         |
| |  empty function. |
|          |         |
| |       # Thank yo |
| u, Mark  |         |
| | Bova, for pointi |
| ng this  |         |
| | out.             |
|          |         |
| |     }            |
|          |         |
| |     # Results in |
|  same er |         |
| | ror message as a |
| bove.    |         |
| |                  |
|          |         |
| |                  |
|          |         |
| |     # However .. |
| .        |         |
| |                  |
|          |         |
| |     not_quite_em |
| pty ()   |         |
| |     {            |
|          |         |
| |       illegal_co |
| mmand    |         |
| |     } #  A scrip |
| t contai |         |
| | ning this functi |
| on will  |         |
| | *not* bomb       |
|          |         |
| |       #+ as long |
|  as the  |         |
| | function is not  |
| called.  |         |
| |                  |
|          |         |
| |     not_empty () |
|          |         |
| |     {            |
|          |         |
| |       :          |
|          |         |
| |     } # Contains |
|  a : (nu |         |
| | ll command), and |
|  this is |         |
| |  okay.           |
|          |         |
| |                  |
|          |         |
| |                  |
|          |         |
| |     # Thank you, |
|  Dominic |         |
| | k Geyer and Thie |
| mo Kelln |         |
| | er.              |
|          |         |
|                    |
|                    |
| +----------------- |
| ---------+-------- |
| ------------------ |
| +----------------- |
| ---------+         |
|                    |
| .. raw:: html      |
|                    |
|    </p>            |
                    
+--------------------+--------------------+--------------------+--------------------+

.. raw:: html

   </div>

It is even possible to nest a function within another function, although
this is not very useful.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     f1 ()                |
|     {                    |
|                          |
|       f2 () # nested     |
|       {                  |
|         echo "Function \ |
| "f2\", inside \"f1\"."   |
|       }                  |
|                          |
|     }                    |
|                          |
|     f2  #  Gives an erro |
| r message.               |
|         #  Even a preced |
| ing "declare -f f2" woul |
| dn't help.               |
|                          |
|     echo                 |
|                          |
|     f1  #  Does nothing, |
|  since calling "f1" does |
|  not automatically call  |
| "f2".                    |
|     f2  #  Now, it's all |
|  right to call "f2",     |
|         #+ since its def |
| inition has been made vi |
| sible by calling "f1".   |
|                          |
|         # Thanks, S.C.   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

Function declarations can appear in unlikely places, even where a
command would otherwise go.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     ls -l | foo() { echo |
|  "foo"; }  # Permissible |
| , but useless.           |
|                          |
|                          |
|                          |
|     if [ "$USER" = bozo  |
| ]                        |
|     then                 |
|       bozo_greet ()   #  |
| Function definition embe |
| dded in an if/then const |
| ruct.                    |
|       {                  |
|         echo "Hello, Boz |
| o."                      |
|       }                  |
|     fi                   |
|                          |
|     bozo_greet        #  |
| Works only for Bozo, and |
|  other users get an erro |
| r.                       |
|                          |
|                          |
|                          |
|     # Something like thi |
| s might be useful in som |
| e contexts.              |
|     NO_EXIT=1   # Will e |
| nable function definitio |
| n below.                 |
|                          |
|     [[ $NO_EXIT -eq 1 ]] |
|  && exit() { true; }     |
|  # Function definition i |
| n an "and-list".         |
|     # If $NO_EXIT is 1,  |
| declares "exit ()".      |
|     # This disables the  |
| "exit" builtin by aliasi |
| ng it to "true".         |
|                          |
|     exit  # Invokes "exi |
| t ()" function, not "exi |
| t" builtin.              |
|                          |
|                          |
|                          |
|     # Or, similarly:     |
|     filename=file1       |
|                          |
|     [ -f "$filename" ] & |
| &                        |
|     foo () { rm -f "$fil |
| ename"; echo "File "$fil |
| ename" deleted."; } ||   |
|     foo () { echo "File  |
| "$filename" not found."; |
|  touch bar; }            |
|                          |
|     foo                  |
|                          |
|     # Thanks, S.C. and C |
| hristopher Head          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

Function names can take strange forms.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|       _(){ for i in {1.. |
| 10}; do echo -n "$FUNCNA |
| ME"; done; echo; }       |
|     # ^^^         No spa |
| ce between function name |
|  and parentheses.        |
|     #             This d |
| oesn't always work. Why  |
| not?                     |
|                          |
|     # Now, let's invoke  |
| the function.            |
|       _         # ______ |
| ____                     |
|     #             ^^^^^^ |
| ^^^^   10 underscores (1 |
| 0 x function name)!      |
|     # A "naked" undersco |
| re is an acceptable func |
| tion name.               |
|                          |
|                          |
|     # In fact, a colon i |
| s likewise an acceptable |
|  function name.          |
|                          |
|     :(){ echo ":"; }; :  |
|                          |
|     # Of what use is thi |
| s?                       |
|     # It's a devious way |
|  to obfuscate the code i |
| n a script.              |
                          
+--------------------------+--------------------------+--------------------------+

See also `Example A-56 <contributed-scripts.html#GRONSFELD>`__

.. raw:: html

   </p>

.. raw:: html

   <div class="NOTE">

+--------------------+--------------------+--------------------+--------------------+
| |Note|             |
| What happens when  |
| different versions |
| of the same        |
| function appear in |
| a script?          |
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
| |     #  As Yan Ch |
| en point |         |
| | s out,           |
|          |         |
| |     #  when a fu |
| nction i |         |
| | s defined multip |
| le times |         |
| | ,                |
|          |         |
| |     #  the final |
|  version |         |
| |  is what is invo |
| ked.     |         |
| |     #  This is n |
| ot, howe |         |
| | ver, particularl |
| y useful |         |
| | .                |
|          |         |
| |                  |
|          |         |
| |     func ()      |
|          |         |
| |     {            |
|          |         |
| |       echo "Firs |
| t versio |         |
| | n of func ()."   |
|          |         |
| |     }            |
|          |         |
| |                  |
|          |         |
| |     func ()      |
|          |         |
| |     {            |
|          |         |
| |       echo "Seco |
| nd versi |         |
| | on of func ()."  |
|          |         |
| |     }            |
|          |         |
| |                  |
|          |         |
| |     func   # Sec |
| ond vers |         |
| | ion of func ().  |
|          |         |
| |                  |
|          |         |
| |     exit $?      |
|          |         |
| |                  |
|          |         |
| |     #  It is eve |
| n possib |         |
| | le to use functi |
| ons to o |         |
| | verride          |
|          |         |
| |     #+ or preemp |
| t system |         |
| |  commands.       |
|          |         |
| |     #  Of course |
| , this i |         |
| | s *not* advisabl |
| e.       |         |
|                    |
|                    |
| +----------------- |
| ---------+-------- |
| ------------------ |
| +----------------- |
| ---------+         |
|                    |
| .. raw:: html      |
|                    |
|    </p>            |
                    
+--------------------+--------------------+--------------------+--------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <process-sub.html> | Process Substitution     |
| `__                      | `Up <part5.html>`__      |
| `Home <index.html>`__    | Complex Functions and    |
| `Next <complexfunct.html | Function Complexities    |
| >`__                     |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
