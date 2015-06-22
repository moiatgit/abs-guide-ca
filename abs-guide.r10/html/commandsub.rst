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

`Prev <testbranch.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <arithexp.html>`__

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

Chapter 12. Command Substitution
================================

\ **Command substitution** reassigns the output of a command
`[1] <commandsub.html#FTN.AEN7205>`__ or even multiple commands; it
literally plugs the command output into another context.
`[2] <commandsub.html#FTN.AEN7211>`__

The classic form of command substitution uses *backquotes* (\`...\`).
Commands within backquotes (backticks) generate command-line text.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     script_name=`basenam |
| e $0`                    |
|     echo "The name of th |
| is script is $script_nam |
| e."                      |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="FORMALPARA">

**The output of commands can be used as arguments to another command, to
set a variable, and even for generating the argument list in a
`for <loops1.html#FORLOOPREF1>`__ loop.**

.. raw:: html

   </div>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     rm `cat filename`    |
| # "filename" contains a  |
| list of files to delete. |
|     #                    |
|     # S. C. points out t |
| hat "arg list too long"  |
| error might result.      |
|     # Better is          |
|      xargs rm -- < filen |
| ame                      |
|     # ( -- covers those  |
| cases where "filename" b |
| egins with a "-" )       |
|                          |
|     textfile_listing=`ls |
|  *.txt`                  |
|     # Variable contains  |
| names of all *.txt files |
|  in current working dire |
| ctory.                   |
|     echo $textfile_listi |
| ng                       |
|                          |
|     textfile_listing2=$( |
| ls *.txt)   # The altern |
| ative form of command su |
| bstitution.              |
|     echo $textfile_listi |
| ng2                      |
|     # Same result.       |
|                          |
|     # A possible problem |
|  with putting a list of  |
| files into a single stri |
| ng                       |
|     # is that a newline  |
| may creep in.            |
|     #                    |
|     # A safer way to ass |
| ign a list of files to a |
|  parameter is with an ar |
| ray.                     |
|     #      shopt -s null |
| glob    # If no match, f |
| ilename expands to nothi |
| ng.                      |
|     #      textfile_list |
| ing=( *.txt )            |
|     #                    |
|     # Thanks, S.C.       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| Command substitution invokes a       |
| `subshell <subshells.html#SUBSHELLSR |
| EF>`__.                              |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| |Caution| |
| Command   |
| substitut |
| ion       |
| may       |
| result in |
| `word     |
| splitting |
|  <quoting |
| var.html# |
| WSPLITREF |
| >`__.     |
|           |
| +-------- |
| --------- |
| --------- |
| +-------- |
| --------- |
| --------- |
| +-------- |
| --------- |
| --------- |
| +         |
| | .. code |
| :: PROGRA |
| MLISTING  |
| |         |
| |         |
|           |
|           |
| |         |
| |     COM |
| MAND `ech |
| o a b`    |
| |         |
| |    # 2  |
| args: a a |
| nd b      |
| |         |
| |         |
|           |
|           |
| |         |
| |     COM |
| MAND "`ec |
| ho a b`"  |
| |         |
| |    # 1  |
| arg: "a b |
| "         |
| |         |
| |         |
|           |
|           |
| |         |
| |     COM |
| MAND `ech |
| o`        |
| |         |
| |    # no |
|  arg      |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |     COM |
| MAND "`ec |
| ho`"      |
| |         |
| |    # on |
| e empty a |
| rg        |
| |         |
| |         |
|           |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |     # T |
| hanks, S. |
| C.        |
| |         |
|           |
|           |
|           |
| +-------- |
| --------- |
| --------- |
| +-------- |
| --------- |
| --------- |
| +-------- |
| --------- |
| --------- |
| +         |
|           |
| .. raw::  |
| html      |
|           |
|    </p>   |
|           |
| Even when |
| there is  |
| no word   |
| splitting |
| ,         |
| command   |
| substitut |
| ion       |
| can       |
| remove    |
| trailing  |
| newlines. |
|           |
| +-------- |
| --------- |
| --------- |
| +-------- |
| --------- |
| --------- |
| +-------- |
| --------- |
| --------- |
| +         |
| | .. code |
| :: PROGRA |
| MLISTING  |
| |         |
| |         |
|           |
|           |
| |         |
| |     # c |
| d "`pwd`" |
|   # This  |
| |         |
| |  should |
|  always w |
| ork.      |
| |         |
| |     # H |
| owever... |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |     mkd |
| ir 'dir w |
| ith trai  |
| |         |
| | ling ne |
| wline     |
|           |
| |         |
| |     '   |
|           |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |     cd  |
| 'dir with |
|  trailin  |
| |         |
| | g newli |
| ne        |
|           |
| |         |
| |     '   |
|           |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |     cd  |
| "`pwd`"   |
| # Error   |
| |         |
| | message |
| :         |
|           |
| |         |
| |     # b |
| ash: cd:  |
| /tmp/fil  |
| |         |
| | e with  |
| trailing  |
| newline:  |
| |         |
| |  No suc |
| h file or |
|  directo  |
| |         |
| | ry      |
|           |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |     cd  |
| "$PWD"    |
| # Works   |
| |         |
| | fine.   |
|           |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |     old |
| _tty_sett |
| ing=$(st  |
| |         |
| | ty -g)  |
|   # Save  |
| old term  |
| |         |
| | inal se |
| tting.    |
|           |
| |         |
| |     ech |
| o "Hit a  |
| key "     |
| |         |
| |     stt |
| y -icanon |
|  -echo    |
| |         |
| |         |
|   # Disab |
| le "cano  |
| |         |
| | nical"  |
| mode for  |
| terminal  |
| |         |
| | .       |
|           |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |         |
|   # Also, |
|  disable  |
| |         |
| |  *local |
| * echo.   |
|           |
| |         |
| |     key |
| =$(dd bs= |
| 1 count=  |
| |         |
| | 1 2> /d |
| ev/null)  |
|   # Usin  |
| |         |
| | g 'dd'  |
| to get a  |
| keypress  |
| |         |
| | .       |
|           |
|           |
| |         |
| |     stt |
| y "$old_t |
| ty_setti  |
| |         |
| | ng"     |
|   # Resto |
| re old s  |
| |         |
| | etting. |
|           |
|           |
| |         |
| |     ech |
| o "You hi |
| t ${#key  |
| |         |
| | } key." |
|   # ${#va |
| riable}   |
| |         |
| | = numbe |
| r of char |
| acters i  |
| |         |
| | n $vari |
| able      |
|           |
| |         |
| |     #   |
|           |
|           |
| |         |
| |     # H |
| it any ke |
| y except  |
| |         |
| |  RETURN |
| , and the |
|  output   |
| |         |
| | is "You |
|  hit 1 ke |
| y."       |
| |         |
| |     # H |
| it RETURN |
| , and it  |
| |         |
| | 's "You |
|  hit 0 ke |
| y."       |
| |         |
| |     # T |
| he newlin |
| e gets e  |
| |         |
| | aten in |
|  the comm |
| and subs  |
| |         |
| | titutio |
| n.        |
|           |
| |         |
| |         |
|           |
|           |
| |         |
| |     #Co |
| de snippe |
| t by Sté  |
| |         |
| | phane C |
| hazelas.  |
|           |
| |         |
|           |
|           |
|           |
| +-------- |
| --------- |
| --------- |
| +-------- |
| --------- |
| --------- |
| +-------- |
| --------- |
| --------- |
| +         |
|           |
| .. raw::  |
| html      |
|           |
|    </p>   |
           
+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+--------------------+--------------------+--------------------+--------------------+
| |Caution|          |
| Using **echo** to  |
| output an          |
| *unquoted*         |
| variable set with  |
| command            |
| substitution       |
| removes trailing   |
| newlines           |
| characters from    |
| the output of the  |
| reassigned         |
| command(s). This   |
| can cause          |
| unpleasant         |
| surprises.         |
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
| |     dir_listing= |
| `ls -l`  |         |
| |     echo $dir_li |
| sting    |         |
| |   # unquoted     |
|          |         |
| |                  |
|          |         |
| |     # Expecting  |
| a nicely |         |
| |  ordered directo |
| ry listi |         |
| | ng.              |
|          |         |
| |                  |
|          |         |
| |     # However, w |
| hat you  |         |
| | get is:          |
|          |         |
| |     # total 3 -r |
| w-rw-r-- |         |
| |  1 bozo bozo 30  |
| May 13 1 |         |
| | 7:15 1.txt -rw-r |
| w-r-- 1  |         |
| | bozo             |
|          |         |
| |     # bozo 51 Ma |
| y 15 20: |         |
| | 57 t2.sh -rwxr-x |
| r-x 1 bo |         |
| | zo bozo 217 Mar  |
| 5 21:13  |         |
| | wi.sh            |
|          |         |
| |                  |
|          |         |
| |     # The newlin |
| es disap |         |
| | peared.          |
|          |         |
| |                  |
|          |         |
| |                  |
|          |         |
| |     echo "$dir_l |
| isting"  |         |
| |   # quoted       |
|          |         |
| |     # -rw-rw-r-- |
|     1 bo |         |
| | zo       30 May  |
| 13 17:15 |         |
| |  1.txt           |
|          |         |
| |     # -rw-rw-r-- |
|     1 bo |         |
| | zo       51 May  |
| 15 20:57 |         |
| |  t2.sh           |
|          |         |
| |     # -rwxr-xr-x |
|     1 bo |         |
| | zo      217 Mar  |
|  5 21:13 |         |
| |  wi.sh           |
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

Command substitution even permits setting a variable to the contents of
a file, using either `redirection <io-redirection.html#IOREDIRREF>`__ or
the `cat <basic.html#CATREF>`__ command.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     variable1=`<file1`   |
|     #  Set "variable1" t |
| o contents of "file1".   |
|     variable2=`cat file2 |
| `   #  Set "variable2" t |
| o contents of "file2".   |
|                          |
|     #  This, however, fo |
| rks a new process,       |
|                          |
|     #+ so the line of co |
| de executes slower than  |
| the above version.       |
|                          |
|     #  Note that the var |
| iables may contain embed |
| ded whitespace,          |
|     #+ or even (horrors) |
| , control characters.    |
|                          |
|     #  It is not necessa |
| ry to explicitly assign  |
| a variable.              |
|     echo "` <$0`"        |
|     # Echoes the script  |
| itself to stdout.        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #  Excerpts from sys |
| tem file, /etc/rc.d/rc.s |
| ysinit                   |
|     #+ (on a Red Hat Lin |
| ux installation)         |
|                          |
|                          |
|     if [ -f /fsckoptions |
|  ]; then                 |
|             fsckoptions= |
| `cat /fsckoptions`       |
|     ...                  |
|     fi                   |
|     #                    |
|     #                    |
|     if [ -e "/proc/ide/$ |
| {disk[$device]}/media" ] |
|  ; then                  |
|                  hdmedia |
| =`cat /proc/ide/${disk[$ |
| device]}/media`          |
|     ...                  |
|     fi                   |
|     #                    |
|     #                    |
|     if [ ! -n "`uname -r |
|  | grep -- "-"`" ]; then |
|            ktag="`cat /p |
| roc/version`"            |
|     ...                  |
|     fi                   |
|     #                    |
|     #                    |
|     if [ $usb = "1" ]; t |
| hen                      |
|         sleep 5          |
|         mouseoutput=`cat |
|  /proc/bus/usb/devices 2 |
| >/dev/null|grep -E "^I.* |
| Cls=03.*Prot=02"`        |
|         kbdoutput=`cat / |
| proc/bus/usb/devices 2>/ |
| dev/null|grep -E "^I.*Cl |
| s=03.*Prot=01"`          |
|     ...                  |
|     fi                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="CAUTION">

+--------------------+--------------------+--------------------+--------------------+
| |Caution|          |
| Do not set a       |
| variable to the    |
| contents of a      |
| *long* text file   |
| unless you have a  |
| very good reason   |
| for doing so. Do   |
| not set a variable |
| to the contents of |
| a *binary* file,   |
| even as a joke.    |
|                    |
| .. raw:: html      |
|                    |
|    <div            |
|    class="EXAMPLE" |
| >                  |
|                    |
| **Example 12-1.    |
| Stupid script      |
| tricks**           |
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
| |     # stupid-scr |
| ipt-tric |         |
| | ks.sh: Don't try |
|  this at |         |
| |  home, folks.    |
|          |         |
| |     # From "Stup |
| id Scrip |         |
| | t Tricks," Volum |
| e I.     |         |
| |                  |
|          |         |
| |     exit 99  ### |
|  Comment |         |
| |  out this line i |
| f you da |         |
| | re.              |
|          |         |
| |                  |
|          |         |
| |     dangerous_va |
| riable=` |         |
| | cat /boot/vmlinu |
| z`   # T |         |
| | he compressed Li |
| nux kern |         |
| | el itself.       |
|          |         |
| |                  |
|          |         |
| |     echo "string |
| -length  |         |
| | of \$dangerous_v |
| ariable  |         |
| | = ${#dangerous_v |
| ariable} |         |
| | "                |
|          |         |
| |     # string-len |
| gth of $ |         |
| | dangerous_variab |
| le = 794 |         |
| | 151              |
|          |         |
| |     # (Newer ker |
| nels are |         |
| |  bigger.)        |
|          |         |
| |     # Does not g |
| ive same |         |
| |  count as 'wc -c |
|  /boot/v |         |
| | mlinuz'.         |
|          |         |
| |                  |
|          |         |
| |     # echo "$dan |
| gerous_v |         |
| | ariable"         |
|          |         |
| |     # Don't try  |
| this! It |         |
| |  would hang the  |
| script.  |         |
| |                  |
|          |         |
| |                  |
|          |         |
| |     #  The docum |
| ent auth |         |
| | or is aware of n |
| o useful |         |
| |  applications fo |
| r        |         |
| |     #+ setting a |
|  variabl |         |
| | e to the content |
| s of a b |         |
| | inary file.      |
|          |         |
| |                  |
|          |         |
| |     exit 0       |
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
|    </div>          |
|                    |
| Notice that a      |
| *buffer overrun*   |
| does not occur.    |
| This is one        |
| instance where an  |
| interpreted        |
| language, such as  |
| Bash, provides     |
| more protection    |
| from programmer    |
| mistakes than a    |
| compiled language. |
+--------------------+--------------------+--------------------+--------------------+

.. raw:: html

   </div>

Command substitution permits setting a variable to the output of a
`loop <loops1.html#FORLOOPREF1>`__. The key to this is grabbing the
output of an `echo <internal.html#ECHOREF>`__ command within the loop.

.. raw:: html

   <div class="EXAMPLE">

**Example 12-2. Generating a variable from a loop**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # csubloop.sh: Setti |
| ng a variable to the out |
| put of a loop.           |
|                          |
|     variable1=`for i in  |
| 1 2 3 4 5                |
|     do                   |
|       echo -n "$i"       |
|            #  The 'echo' |
|  command is critical     |
|     done`                |
|            #+ to command |
|  substitution here.      |
|                          |
|     echo "variable1 = $v |
| ariable1"  # variable1 = |
|  12345                   |
|                          |
|                          |
|     i=0                  |
|     variable2=`while [ " |
| $i" -lt 10 ]             |
|     do                   |
|       echo -n "$i"       |
|            # Again, the  |
| necessary 'echo'.        |
|       let "i += 1"       |
|            # Increment.  |
|     done`                |
|                          |
|     echo "variable2 = $v |
| ariable2"  # variable2 = |
|  0123456789              |
|                          |
|     #  Demonstrates that |
|  it's possible to embed  |
| a loop                   |
|     #+ inside a variable |
|  declaration.            |
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
| Command substitution makes it possible to extend the toolset available   |
| to Bash. It is simply a matter of writing a program or script that       |
| outputs to ``stdout`` (like a well-behaved UNIX tool should) and         |
| assigning that output to a variable.                                     |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: PROGRAMLISTING |                                             |
| |                          |                                             |
| |     #include <stdio.h>   |                                             |
| |                          |                                             |
| |     /*  "Hello, world."  |                                             |
| | C program  */            |                                             |
| |                          |                                             |
| |     int main()           |                                             |
| |     {                    |                                             |
| |       printf( "Hello, wo |                                             |
| | rld.\n" );               |                                             |
| |       return (0);        |                                             |
| |     }                    |                                             |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: SCREEN         |                                             |
| |                          |                                             |
| |     bash$ gcc -o hello h |                                             |
| | ello.c                   |                                             |
| |                          |                                             |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </p>                                                                  |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: PROGRAMLISTING |                                             |
| |                          |                                             |
| |     #!/bin/bash          |                                             |
| |     # hello.sh           |                                             |
| |                          |                                             |
| |     greeting=`./hello`   |                                             |
| |     echo $greeting       |                                             |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
| | .. code:: SCREEN         |                                             |
| |                          |                                             |
| |     bash$ sh hello.sh    |                                             |
| |     Hello, world.        |                                             |
| |                          |                                             |
|                                                                          |
| +--------------------------+--------------------------+----------------- |
| ---------+                                                               |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </p>                                                                  |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

.. raw:: html

   <div class="NOTE">

+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+
| |Not |
| e|   |
| The  |
| **$( |
| ...) |
| **   |
| form |
| has  |
| supe |
| rsed |
| ed   |
| back |
| tick |
| s    |
| for  |
| comm |
| and  |
| subs |
| titu |
| tion |
| .    |
|      |
| +--- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---+ |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| --+- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| -+   |
| | .. |
|  cod |
| e::  |
| PROG |
| RAML |
| ISTI |
| NG | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   ou |
| tput |
| =$(s |
| ed - |
| n /" |
| $1 | |
| | "/ |
| p $f |
| ile) |
|    # |
|  Fro |
| m "g |
| rp | |
| | .s |
| h"   |
|  exa |
| mple |
| .    |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   #  |
| Sett |
| ing  |
| a va |
| riab |
| le | |
| |  t |
| o th |
| e co |
| nten |
| ts o |
| f a  |
| te | |
| | xt |
|  fil |
| e.   |
|      |
|      |
|      |
|    | |
| |    |
|   Fi |
| le_c |
| onte |
| nts1 |
| =$(c |
| at | |
| |  $ |
| file |
| 1)   |
|      |
|      |
|      |
|    | |
| |    |
|   Fi |
| le_c |
| onte |
| nts2 |
| =$(< |
| $f | |
| | il |
| e2)  |
|      |
|    # |
|  Bas |
| h pe |
| rm | |
| | it |
| s th |
| is a |
| lso. |
|      |
|      |
|    | |
|      |
|      |
|      |
|      |
|      |
|      |
|      |
| +--- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---+ |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| --+- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| -+   |
|      |
| .. r |
| aw:: |
|  htm |
| l    |
|      |
|    < |
| /p>  |
|      |
| The  |
| **$( |
| ...) |
| **   |
| form |
| of   |
| comm |
| and  |
| subs |
| titu |
| tion |
| trea |
| ts   |
| a    |
| doub |
| le   |
| back |
| slas |
| h    |
| in a |
| diff |
| eren |
| t    |
| way  |
| than |
| **\` |
| ...\ |
| `**. |
|      |
| +--- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---+ |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| --+- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| -+   |
| | .. |
|  cod |
| e::  |
| SCRE |
| EN   |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   ba |
| sh$  |
| echo |
|  `ec |
| ho \ |
| \` | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   ba |
| sh$  |
| echo |
|  $(e |
| cho  |
| \\ | |
| | )  |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   \  |
|      |
|      |
|      |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
|      |
|      |
|      |
|      |
|      |
|      |
|      |
| +--- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---+ |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| --+- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| -+   |
|      |
| .. r |
| aw:: |
|  htm |
| l    |
|      |
|    < |
| /p>  |
|      |
| The  |
| **$( |
| ...) |
| **   |
| form |
| of   |
| comm |
| and  |
| subs |
| titu |
| tion |
| perm |
| its  |
| nest |
| ing. |
| `[3] |
|  <co |
| mman |
| dsub |
| .htm |
| l#FT |
| N.AE |
| N730 |
| 8>`_ |
| _    |
|      |
| +--- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---+ |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| --+- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| -+   |
| | .. |
|  cod |
| e::  |
| PROG |
| RAML |
| ISTI |
| NG | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   wo |
| rd_c |
| ount |
| =$(  |
| wc - |
| w  | |
| | $( |
| echo |
|  * | |
|  awk |
|  '{p |
| rint |
|  $ | |
| | 8} |
| ') ) |
|      |
|      |
|      |
|      |
|    | |
|      |
|      |
|      |
|      |
|      |
|      |
|      |
| +--- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---+ |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| --+- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| -+   |
|      |
| .. r |
| aw:: |
|  htm |
| l    |
|      |
|    < |
| /p>  |
|      |
| Or,  |
| for  |
| some |
| thin |
| g    |
| a    |
| bit  |
| more |
| elab |
| orat |
| e    |
| . .  |
| .    |
|      |
| .. r |
| aw:: |
|  htm |
| l    |
|      |
|    < |
| div  |
|    c |
| lass |
| ="EX |
| AMPL |
| E">  |
|      |
| **Ex |
| ampl |
| e    |
| 12-3 |
| .    |
| Find |
| ing  |
| anag |
| rams |
| **   |
|      |
| +--- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---+ |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| --+- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| -+   |
| | .. |
|  cod |
| e::  |
| PROG |
| RAML |
| ISTI |
| NG | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   #! |
| /bin |
| /bas |
| h    |
|      |
|    | |
| |    |
|   #  |
| agra |
| m2.s |
| h    |
|      |
|    | |
| |    |
|   #  |
| Exam |
| ple  |
| of n |
| este |
| d  | |
| | co |
| mman |
| d su |
| bsti |
| tuti |
| on.  |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   #  |
|  Use |
| s "a |
| nagr |
| am"  |
| ut | |
| | il |
| ity  |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   #+ |
|  tha |
| t is |
|  par |
| t of |
|  t | |
| | he |
|  aut |
| hor' |
| s "y |
| awl" |
|  wor |
| d  | |
| | li |
| st p |
| acka |
| ge.  |
|      |
|      |
|    | |
| |    |
|   #  |
|  htt |
| p:// |
| ibib |
| lio. |
| or | |
| | g/ |
| pub/ |
| Linu |
| x/li |
| bs/y |
| awl- |
| 0. | |
| | 3. |
| 2.ta |
| r.gz |
|      |
|      |
|      |
|    | |
| |    |
|   #  |
|  htt |
| p:// |
| bash |
| .det |
| a. | |
| | in |
| /yaw |
| l-0. |
| 3.2. |
| tar. |
| gz   |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   E_ |
| NOAR |
| GS=8 |
| 6    |
|      |
|    | |
| |    |
|   E_ |
| BADA |
| RG=8 |
| 7    |
|      |
|    | |
| |    |
|   MI |
| NLEN |
| =7   |
|      |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   if |
|  [ - |
| z "$ |
| 1" ] |
|      |
|    | |
| |    |
|   th |
| en   |
|      |
|      |
|      |
|    | |
| |    |
|      |
| echo |
|  "Us |
| age  |
| $0 L |
| ET | |
| | TE |
| RSET |
| "    |
|      |
|      |
|      |
|    | |
| |    |
|      |
| exit |
|  $E_ |
| NOAR |
| GS   |
|    | |
| |    |
|    # |
|  Scr |
| ipt  |
| need |
| s a  |
| co | |
| | mm |
| and- |
| line |
|  arg |
| umen |
| t.   |
|    | |
| |    |
|   el |
| if [ |
|  ${# |
| 1} - |
| lt $ |
| MI | |
| | NL |
| EN ] |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   th |
| en   |
|      |
|      |
|      |
|    | |
| |    |
|      |
| echo |
|  "Ar |
| gume |
| nt m |
| us | |
| | t  |
| have |
|  at  |
| leas |
| t $M |
| INLE |
| N  | |
| | le |
| tter |
| s."  |
|      |
|      |
|      |
|    | |
| |    |
|      |
| exit |
|  $E_ |
| BADA |
| RG   |
|    | |
| |    |
|   fi |
|      |
|      |
|      |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   FI |
| LTER |
| ='.. |
| .... |
| .'   |
|    | |
| |    |
|    # |
|  Mus |
| t ha |
| ve a |
| t le |
| as | |
| | t  |
| 7 le |
| tter |
| s.   |
|      |
|      |
|    | |
| |    |
|   #  |
|      |
|   12 |
| 3456 |
| 7    |
|    | |
| |    |
|   An |
| agra |
| ms=( |
|  $(e |
| cho  |
| $( | |
| | an |
| agra |
| m $1 |
|  | g |
| rep  |
| $FIL |
| TE | |
| | R) |
|  ) ) |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   #  |
|      |
|      |
|  $(  |
|      |
| $( | |
| |    |
| nest |
| ed c |
| omma |
| nd s |
| ub.  |
|    | |
| |  ) |
|  )   |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   #  |
|      |
|    ( |
|      |
|      |
|    | |
| |    |
|   ar |
| ray  |
| assi |
| gnme |
| nt   |
|    | |
| |    |
|    ) |
|      |
|      |
|      |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   ec |
| ho   |
|      |
|      |
|      |
|    | |
| |    |
|   ec |
| ho " |
| ${#A |
| nagr |
| ams[ |
| *] | |
| | }  |
|  7+  |
| lett |
| er a |
| nagr |
| ams  |
| fo | |
| | un |
| d"   |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   ec |
| ho   |
|      |
|      |
|      |
|    | |
| |    |
|   ec |
| ho $ |
| {Ana |
| gram |
| s[0] |
| }  | |
| |    |
|    # |
|  Fir |
| st a |
| nagr |
| am.  |
|    | |
| |    |
|   ec |
| ho $ |
| {Ana |
| gram |
| s[1] |
| }  | |
| |    |
|    # |
|  Sec |
| ond  |
| anag |
| ram. |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|    # |
|  Etc |
| .    |
|      |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   #  |
| echo |
|  "${ |
| Anag |
| rams |
| [* | |
| | ]} |
| "  # |
|  To  |
| list |
|  all |
|  the |
|  a | |
| | na |
| gram |
| s in |
|  a s |
| ingl |
| e li |
| ne | |
| |  . |
|  . . |
|      |
|      |
|      |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   #  |
|  Loo |
| k ah |
| ead  |
| to t |
| he | |
| |  A |
| rray |
| s ch |
| apte |
| r fo |
| r en |
| li | |
| | gh |
| tenm |
| ent  |
| on   |
|      |
|      |
|    | |
| |    |
|   #+ |
|  wha |
| t's  |
| goin |
| g on |
|  h | |
| | er |
| e.   |
|      |
|      |
|      |
|      |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   #  |
| See  |
| also |
|  the |
|  agr |
| am | |
| | .s |
| h sc |
| ript |
|  for |
|  an  |
| exer |
| ci | |
| | se |
|  in  |
| anag |
| ram  |
| find |
| ing. |
|    | |
| |    |
|      |
|      |
|      |
|      |
|      |
|    | |
| |    |
|   ex |
| it $ |
| ?    |
|      |
|      |
|    | |
|      |
|      |
|      |
|      |
|      |
|      |
|      |
| +--- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---+ |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| --+- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| ---- |
| -+   |
|      |
| .. r |
| aw:: |
|  htm |
| l    |
|      |
|    < |
| /div |
| >    |
      
+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+

.. raw:: html

   </div>

Examples of command substitution in shell scripts:

#. `Example 11-8 <loops1.html#BINGREP>`__

#. `Example 11-27 <testbranch.html#CASECMD>`__

#. `Example 9-16 <randomvar.html#SEEDINGRANDOM>`__

#. `Example 16-3 <moreadv.html#EX57>`__

#. `Example 16-22 <textproc.html#LOWERCASE>`__

#. `Example 16-17 <textproc.html#GRP>`__

#. `Example 16-54 <extmisc.html#EX53>`__

#. `Example 11-14 <loops1.html#EX24>`__

#. `Example 11-11 <loops1.html#SYMLINKS>`__

#. `Example 16-32 <filearchiv.html#STRIPC>`__

#. `Example 20-8 <redircb.html#REDIR4>`__

#. `Example A-16 <contributed-scripts.html#TREE>`__

#. `Example 29-3 <procref1.html#PIDID>`__

#. `Example 16-47 <mathc.html#MONTHLYPMT>`__

#. `Example 16-48 <mathc.html#BASE>`__

#. `Example 16-49 <mathc.html#ALTBC>`__

.. raw:: html

   </p>

.. raw:: html

   </div>

Notes
~~~~~

.. raw:: html

   <table border="0" class="FOOTNOTES" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[1] <commandsub.html#AEN7205>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

For purposes of *command substitution*, a **command** may be an external
system command, an internal scripting
`builtin <internal.html#BUILTINREF>`__, or even `a script
function <assortedtips.html#RVT>`__.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[2] <commandsub.html#AEN7211>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

In a more technically correct sense, *command substitution* extracts the
``stdout`` of a command, then assigns it to a variable using the =
operator.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[3] <commandsub.html#AEN7308>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

In fact, nesting with backticks is also possible, but only by escaping
the inner backticks, as John Default points out.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     word_count=` wc -w \ |
| `echo * | awk '{print $8 |
| }'\` `                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <testbranch.html>` | Testing and Branching    |
| __                       | `Up <part3.html>`__      |
| `Home <index.html>`__    | Arithmetic Expansion     |
| `Next <arithexp.html>`__ |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Caution| image:: ../images/caution.gif
