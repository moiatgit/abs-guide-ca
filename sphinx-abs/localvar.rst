###################
XXX Local Variables
###################

**What makes a variable *local*?**

local variables
    A variable declared as *local* is one that is visible only within
    the `block of code <special-chars.html#CODEBLOCKREF>`__ in which it
    appears. It has local `scope <subshells.html#SCOPEREF>`__. In a
    function, a *local variable* has meaning only within that function
    block. `[1] <localvar.html#FTN.AEN18568>`__

Exemple 12. Local variable visibility

     .. code-block:: sh

         #!/bin/bash
         # ex62.sh: Global and local variables inside a function.

         func ()
         {
           local loc_var=23       # Declared as local variable.
           echo                   # Uses the 'local' builtin.
           echo "\"loc_var\" in function = $loc_var"
           global_var=999         # Not declared as local.
                                  # Therefore, defaults to global.
           echo "\"global_var\" in function = $global_var"
         }

         func

         # Now, to see if local variable "loc_var" exists outside the functio n.

         echo
         echo "\"loc_var\" outside function = $loc_var"
                                               # $loc_var outside function =
                                               # No, $loc_var not visible glo bally.
         echo "\"global_var\" outside function = $global_var"
                                               # $global_var outside function = 999
                                               # $global_var is visible globa lly.
         echo

         exit 0
         #  In contrast to C, a Bash variable declared inside a function
         #+ is local ONLY if declared as such.


     Caution
     Before a function is
     called, *all* variables
     declared within the
     function are invisible
     outside the body of the
     function, not just those
     explicitly declared as
     *local*.

     .. code-block:: sh






          #!/bin/bash







          func ()



          {



          global_var=37    #
               Visible only within th
             e function block

                                   #
             + before the function ha
             s been called.

                  }                #
               END OF FUNCTION






          echo "global_var =
          $global_var"  # global_
             var =


                    #  Functi on "func" has not yet be en called,




                    #+ so $gl obal_var is not visible he re.







          func



          echo "global_var = $global_var"  # global_ var = 37

                    # Has bee n set by function call.




     Note

     As Evgeniy Ivanov points out, when declaring and setting a local variable in a single command, apparently the order of operations is to *first set the variable, and only afterwards restrict it to local scope*.  This is reflected in the `return value <exit-st atus.html#EXIT STATUSREF>`__.

      .. code-block:: sh










          #!/bin/b ash










          echo "== OUTSIDE Functi on (global)=="



          t=$(exit 1)




          echo $?
          # 1





          # As expe cted.



          echo











          function 0 ()




          {











          echo "== INSIDE Functio n=="



          echo "Gl obal"




          t0=$(exi t 1)




          echo $?
          # 1





          # As expe cted.









          echo





          echo "Lo cal declared & assigned in s ame command."


          local t1 =$(exit 1)



          echo $?
          # 0





          # Unexpec ted!



          #  Appar ently, the var iable assignme nt takes place before

          #+ the l ocal declarati on.



          #+ The r eturn value is for the latte r.








          echo





          echo "Lo cal declared, then assigned (separate comm ands)." local t2 t2=$(exi t 1) echo $?  # 1 # As expe cted.









          }











          function 0











24.2.1. Local variables and recursion.
--------------------------------------

 *Recur sion* is an intere sting and someti mes useful form of *self- refere nce*.  `Herbe rt Mayer <bibli o.html #MAYER REF>`_ _ define s it as ". . .  expres sing an algori thm by using a simple r versio n of that same algori thm . . ."

 Consid er a defini tion define d in terms of itself , `[2] < localv ar.htm l#FTN.  AEN186 07>`__ an expres sion implic it in its own expres sion, `[3] < localv ar.htm l#FTN.  AEN186 10>`__ *a snake swallo wing its own tail*, `[4] < localv ar.htm l#FTN.  AEN186 14>`__ or . .  . a functi on that calls itself .  `[5] < localv ar.htm l#FTN.  AEN186 17>`__

 **Exam ple 24-13.  Demons tratio n of a simple recurs ive functi on**

.. code-block:: sh





















     #!/bin
     /bash











     # recu
     rsion-
     demo.s
     h









     # Demo
     nstrat
     ion of
      recur
     sion.





















     RECURS
     IONS=9
        # H
     ow man
     y time
     s to r
     ecurse
     .





      r_coun
      t=0
         # M
      ust be
       globa
      l. Why
      ?



















      recurs
      e ()











      {












        var=
      "$1"
























        whil
      e [ "$
      var" -
      ge 0 ]









        do












          ec
      ho "Re
      cursio
      n coun
      t = "$
      r_coun
      t"  +-
      +  \$v
      ar = "
      $var""



          ((
       var--
       )); (
      ( r_co
      unt++
      ))







          re
      curse
      "$var"
        #  F
      unctio
      n call
      s itse
      lf (re
      curses
      )



        done


        #+ u
      ntil w
      hat co
      nditio
      n is m
      et?




      }

























      recurs
      e $REC
      URSION
      S






















      exit $
      ?























 **Exam
 ple
 24-14.
 Anothe
 r
 simple
 demons
 tratio
 n**

 +-----
 ------
 ------
 ------
 ------
 ------
 ------
 ------
 ------
 ------
 ------
 ------
 ---+
  .. c
 ode::
 PROGRA
 MLISTI
 NG






















 #!/bin
 /bash











 # recu
 rsion-
 def.sh










 # A sc
 ript t
 hat de
 fines
 "recur
 sion"
 in a r
 ather
 graphi
 c way.
















 RECURS
 IONS=1
 0










 r_coun
 t=0











 sp=" "

























 define
 _recur
 sion (
 )









 {












   ((r_
 count+
 +))










   sp="
 $sp""
 "










   echo
  -n "$
 sp"










   echo
  "\"Th
 e act
 of rec
 urring
  ... \
 ""   #
  Per 1
 913 We
 bster'
 s dict
 io
  nary
 .

























   whil
 e [ $r
 _count
  -le $
 RECURS
 IONS ]







   do












     de
 fine_r
 ecursi
 on









   done












 }

























 echo












 echo "
 Recurs
 ion: "










 define
 _recur
 sion










 echo

























 exit $
 ?

























Local variables are a useful tool for writing recursive code, but this
practice generally involves a great deal of computational overhead and
is definitely *not* recommended in a shell script.
`[6] <localvar.html#FTN.AEN18632>`__

Exemple 15. Recursion, using a local variable

 .. code-block:: sh

     #!/bin/bash

     #               factorial
     #               ---------


     # Does bash permit recursion?
     # Well, yes, but...
     # It's so slow that you gotta have rocks in your head to try it.


     MAX_ARG=5
     E_WRONG_ARGS=85
     E_RANGE_ERR=86


     if [ -z "$1" ]
     then
       echo "Usage: `basename $0` number"
       exit $E_WRONG_ARGS
     fi

     if [ "$1" -gt $MAX_ARG ]
     then
       echo "Out of range ($MAX_ARG is maximum)."
       #  Let's get real now.
       #  If you want greater range than this,
       #+ rewrite it in a Real Programming Language.
       exit $E_RANGE_ERR
     fi

     fact ()
     {
       local number=$1
       #  Variable "number" must be declared as local,
       #+ otherwise this doesn't work.
       if [ "$number" -eq 0 ]
       then
         factorial=1    # Factorial of 0 = 1.
       else
         let "decrnum = number - 1"
         fact $decrnum  # Recursive function call (the function calls its elf).
         let "factorial = $number * $?"
       fi

       return $factorial
     }

     fact $1
     echo "Factorial of $1 is $?."

     exit 0


Also see `Example A-15 <contributed-scripts.html#PRIMES>`__ for an
example of recursion in a script. Be aware that recursion is
resource-intensive and executes slowly, and is therefore generally not
appropriate in a script.

Notes
~~~~~

`[1] <localvar.html#AEN18568>`__

However, as Thomas Braunberger points out, a local variable declared in
a function *is also visible to functions called by the parent function.*

 .. code-block:: sh

     #!/bin/bash

     function1 ()
     {
       local func1var=20

       echo "Within function1, \$func1var = $func1var."

       function2
     }

     function2 ()
     {
       echo "Within function2, \$func1var = $func1var."
     }

     function1

     exit 0


     # Output of the script:

     # Within function1, $func1var = 20.
     # Within function2, $func1var = 20.


This is documented in the Bash manual:

"Local can only be used within a function; it makes the variable name
have a visible scope restricted to that function *and its children*."
[emphasis added] *The ABS Guide author considers this behavior to be a
bug.*

`[2] <localvar.html#AEN18607>`__

Otherwise known as *redundancy*.

`[3] <localvar.html#AEN18610>`__

Otherwise known as *tautology*.

`[4] <localvar.html#AEN18614>`__

Otherwise known as a *metaphor*.

`[5] <localvar.html#AEN18617>`__

Otherwise known as a *recursive function*.

`[6] <localvar.html#AEN18632>`__

Too many levels of recursion may crash a script with a segfault.

 .. code-block:: sh

     #!/bin/bash

     #  Warning: Running this script could possibly lock up your system!
     #  If you're lucky, it will segfault before using up all available m emory.

     recursive_function ()
     {
     echo "$1"     # Makes the function do something, and hastens the seg fault.
     (( $1 < $2 )) && recursive_function $(( $1 + 1 )) $2;
     #  As long as 1st parameter is less than 2nd,
     #+ increment 1st and recurse.
     }

     recursive_function 1 50000  # Recurse 50,000 levels!
     #  Most likely segfaults (depending on stack size, set by ulimit -m) .

     #  Recursion this deep might cause even a C program to segfault,
     #+ by using up all the memory allotted to the stack.


     echo "This will probably not print."
     exit 0  # This script will not exit normally.

     #  Thanks, Stéphane Chazelas.


--------------


