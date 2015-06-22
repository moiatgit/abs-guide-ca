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

`Prev <testbranch.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

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
=================================

 **Command substitution** reassigns the output of a command ` [1]
 <commandsub.html#FTN.AEN7205>`__ or even multiple commands; it
literally plugs the command output into another context. ` [2]
 <commandsub.html#FTN.AEN7211>`__

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

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
|  Command substitution invokes a      |
| `subshell <subshells.html#SUBSHELLSR |
| EF>`__                               |
| .                                    |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+--------------+--------------+--------------+--------------+--------------+--------------+
| |Caution|    |
|  Command     |
| substitution |
| may result   |
| in `word     |
| splitting <q |
| uotingvar.ht |
| ml#WSPLITREF |
| >`__         |
| .            |
|              |
| +----------- |
| ------------ |
| ---+-------- |
| ------------ |
| ------+----- |
| ------------ |
| ---------+   |
| | .. code::  |
| PROGRAMLISTI |
| NG |         |
| |            |
|              |
|    |         |
| |     COMMAN |
| D `echo a b` |
|    |         |
| |    # 2 arg |
| s: a and b   |
|    |         |
| |            |
|              |
|    |         |
| |     COMMAN |
| D "`echo a b |
| `" |         |
| |    # 1 arg |
| : "a b"      |
|    |         |
| |            |
|              |
|    |         |
| |     COMMAN |
| D `echo`     |
|    |         |
| |    # no ar |
| g            |
|    |         |
| |            |
|              |
|    |         |
| |     COMMAN |
| D "`echo`"   |
|    |         |
| |    # one e |
| mpty arg     |
|    |         |
| |            |
|              |
|    |         |
| |            |
|              |
|    |         |
| |     # Than |
| ks, S.C.     |
|    |         |
|              |
|              |
|              |
| +----------- |
| ------------ |
| ---+-------- |
| ------------ |
| ------+----- |
| ------------ |
| ---------+   |
|              |
| Even when    |
| there is no  |
| word         |
| splitting,   |
| command      |
| substitution |
| can remove   |
| trailing     |
| newlines.    |
|              |
| +----------- |
| ------------ |
| ---+-------- |
| ------------ |
| ------+----- |
| ------------ |
| ---------+   |
| | .. code::  |
| PROGRAMLISTI |
| NG |         |
| |            |
|              |
|    |         |
| |     # cd " |
| `pwd`"  # Th |
| is |         |
| |  should al |
| ways work.   |
|    |         |
| |     # Howe |
| ver...       |
|    |         |
| |            |
|              |
|    |         |
| |     mkdir  |
| 'dir with tr |
| ai |         |
| | ling newli |
| ne           |
|    |         |
| |     '      |
|              |
|    |         |
| |            |
|              |
|    |         |
| |     cd 'di |
| r with trail |
| in |         |
| | g newline  |
|              |
|    |         |
| |     '      |
|              |
|    |         |
| |            |
|              |
|    |         |
| |     cd "`p |
| wd`"  # Erro |
| r  |         |
| | message:   |
|              |
|    |         |
| |     # bash |
| : cd: /tmp/f |
| il |         |
| | e with tra |
| iling newlin |
| e: |         |
| |  No such f |
| ile or direc |
| to |         |
| | ry         |
|              |
|    |         |
| |            |
|              |
|    |         |
| |     cd "$P |
| WD"   # Work |
| s  |         |
| | fine.      |
|              |
|    |         |
| |            |
|              |
|    |         |
| |            |
|              |
|    |         |
| |            |
|              |
|    |         |
| |            |
|              |
|    |         |
| |            |
|              |
|    |         |
| |     old_tt |
| y_setting=$( |
| st |         |
| | ty -g)   # |
|  Save old te |
| rm |         |
| | inal setti |
| ng.          |
|    |         |
| |     echo " |
| Hit a key "  |
|    |         |
| |     stty - |
| icanon -echo |
|    |         |
| |          # |
|  Disable "ca |
| no |         |
| | nical" mod |
| e for termin |
| al |         |
| | .          |
|              |
|    |         |
| |            |
|              |
|    |         |
| |          # |
|  Also, disab |
| le |         |
| |  *local* e |
| cho.         |
|    |         |
| |     key=$( |
| dd bs=1 coun |
| t= |         |
| | 1 2> /dev/ |
| null)   # Us |
| in |         |
| | g 'dd' to  |
| get a keypre |
| ss |         |
| | .          |
|              |
|    |         |
| |     stty " |
| $old_tty_set |
| ti |         |
| | ng"      # |
|  Restore old |
|  s |         |
| | etting.    |
|              |
|    |         |
| |     echo " |
| You hit ${#k |
| ey |         |
| | } key."  # |
|  ${#variable |
| }  |         |
| | = number o |
| f characters |
|  i |         |
| | n $variabl |
| e            |
|    |         |
| |     #      |
|              |
|    |         |
| |     # Hit  |
| any key exce |
| pt |         |
| |  RETURN, a |
| nd the outpu |
| t  |         |
| | is "You hi |
| t 1 key."    |
|    |         |
| |     # Hit  |
| RETURN, and  |
| it |         |
| | 's "You hi |
| t 0 key."    |
|    |         |
| |     # The  |
| newline gets |
|  e |         |
| | aten in th |
| e command su |
| bs |         |
| | titution.  |
|              |
|    |         |
| |            |
|              |
|    |         |
| |     #Code  |
| snippet by S |
| tĂ |         |
| | Šphane Cha |
| zelas.       |
|    |         |
|              |
|              |
|              |
| +----------- |
| ------------ |
| ---+-------- |
| ------------ |
| ------+----- |
| ------------ |
| ---------+   |
              
+--------------+--------------+--------------+--------------+--------------+--------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+--------------------------+--------------------------+--------------------------+
| |Caution|                |
| Using **echo** to output |
| an *unquoted* variable   |
| set with command         |
| substitution removes     |
| trailing newlines        |
| characters from the      |
| output of the reassigned |
| command(s). This can     |
| cause unpleasant         |
| surprises.               |
|                          |
| +----------------------- |
| ---+-------------------- |
| ------+----------------- |
| ---------+               |
| | .. code:: PROGRAMLISTI |
| NG |                     |
| |                        |
|    |                     |
| |     dir_listing=`ls -l |
| `  |                     |
| |     echo $dir_listing  |
|    |                     |
| |   # unquoted           |
|    |                     |
| |                        |
|    |                     |
| |     # Expecting a nice |
| ly |                     |
| |  ordered directory lis |
| ti |                     |
| | ng.                    |
|    |                     |
| |                        |
|    |                     |
| |     # However, what yo |
| u  |                     |
| | get is:                |
|    |                     |
| |     # total 3 -rw-rw-r |
| -- |                     |
| |  1 bozo bozo 30 May 13 |
|  1 |                     |
| | 7:15 1.txt -rw-rw-r--  |
| 1  |                     |
| | bozo                   |
|    |                     |
| |     # bozo 51 May 15 2 |
| 0: |                     |
| | 57 t2.sh -rwxr-xr-x 1  |
| bo |                     |
| | zo bozo 217 Mar 5 21:1 |
| 3  |                     |
| | wi.sh                  |
|    |                     |
| |                        |
|    |                     |
| |     # The newlines dis |
| ap |                     |
| | peared.                |
|    |                     |
| |                        |
|    |                     |
| |                        |
|    |                     |
| |     echo "$dir_listing |
| "  |                     |
| |   # quoted             |
|    |                     |
| |     # -rw-rw-r--    1  |
| bo |                     |
| | zo       30 May 13 17: |
| 15 |                     |
| |  1.txt                 |
|    |                     |
| |     # -rw-rw-r--    1  |
| bo |                     |
| | zo       51 May 15 20: |
| 57 |                     |
| |  t2.sh                 |
|    |                     |
| |     # -rwxr-xr-x    1  |
| bo |                     |
| | zo      217 Mar  5 21: |
| 13 |                     |
| |  wi.sh                 |
|    |                     |
|                          |
|                          |
| +----------------------- |
| ---+-------------------- |
| ------+----------------- |
| ---------+               |
                          
+--------------------------+--------------------------+--------------------------+

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
`loop <loops1.html#FORLOOPREF1>`__ . The key to this is grabbing the
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
| outputs to ``          stdout         `` (like a well-behaved UNIX tool  |
| should) and assigning that output to a variable.                         |
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
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

.. raw:: html

   <div class="NOTE">

+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| |Note |
| |     |
|  The  |
| **$(. |
| ..)** |
| form  |
| has   |
| super |
| seded |
| backt |
| icks  |
| for   |
| comma |
| nd    |
| subst |
| ituti |
| on.   |
|       |
| +---- |
| ----- |
| ----- |
| ----- |
| ----- |
| --+-- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----+ |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| -+    |
| | ..  |
| code: |
| : PRO |
| GRAML |
| ISTIN |
| G |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  outp |
| ut=$( |
| sed - |
| n /"$ |
| 1 |   |
| | "/p |
|  $fil |
| e)    |
| # Fro |
| m "gr |
| p |   |
| | .sh |
| " exa |
| mple. |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  # Se |
| tting |
|  a va |
| riabl |
| e |   |
| |  to |
|  the  |
| conte |
| nts o |
| f a t |
| e |   |
| | xt  |
| file. |
|       |
|       |
|       |
|   |   |
| |     |
|  File |
| _cont |
| ents1 |
| =$(ca |
| t |   |
| |  $f |
| ile1) |
|       |
|       |
|       |
|   |   |
| |     |
|  File |
| _cont |
| ents2 |
| =$(<$ |
| f |   |
| | ile |
| 2)    |
|       |
| # Bas |
| h per |
| m |   |
| | its |
|  this |
|  also |
| .     |
|       |
|   |   |
|       |
|       |
|       |
|       |
|       |
|       |
| +---- |
| ----- |
| ----- |
| ----- |
| ----- |
| --+-- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----+ |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| -+    |
|       |
| The   |
| **$(. |
| ..)** |
| form  |
| of    |
| comma |
| nd    |
| subst |
| ituti |
| on    |
| treat |
| s     |
| a     |
| doubl |
| e     |
| backs |
| lash  |
| in a  |
| diffe |
| rent  |
| way   |
| than  |
| **\`. |
| ..\`* |
| *     |
| .     |
|       |
| +---- |
| ----- |
| ----- |
| ----- |
| ----- |
| --+-- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----+ |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| -+    |
| | ..  |
| code: |
| : SCR |
| EEN   |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  bash |
| $ ech |
| o `ec |
| ho \\ |
| ` |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  bash |
| $ ech |
| o $(e |
| cho \ |
| \ |   |
| | )   |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  \    |
|       |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
|       |
|       |
|       |
|       |
|       |
|       |
| +---- |
| ----- |
| ----- |
| ----- |
| ----- |
| --+-- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----+ |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| -+    |
|       |
| The   |
| **$(. |
| ..)** |
| form  |
| of    |
| comma |
| nd    |
| subst |
| ituti |
| on    |
| permi |
| ts    |
| nesti |
| ng.   |
| ` [3] |
|  <com |
| mands |
| ub.ht |
| ml#FT |
| N.AEN |
| 7308> |
| `__   |
|       |
| +---- |
| ----- |
| ----- |
| ----- |
| ----- |
| --+-- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----+ |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| -+    |
| | ..  |
| code: |
| : PRO |
| GRAML |
| ISTIN |
| G |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  word |
| _coun |
| t=$(  |
| wc -w |
|   |   |
| | $(e |
| cho * |
|  | aw |
| k '{p |
| rint  |
| $ |   |
| | 8}' |
| ) )   |
|       |
|       |
|       |
|   |   |
|       |
|       |
|       |
|       |
|       |
|       |
| +---- |
| ----- |
| ----- |
| ----- |
| ----- |
| --+-- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----+ |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| -+    |
|       |
| Or,   |
| for   |
| somet |
| hing  |
| a bit |
| more  |
| elabo |
| rate  |
| . . . |
|       |
| .. ra |
| w:: h |
| tml   |
|       |
|    <d |
| iv    |
|    cl |
| ass=" |
| EXAMP |
| LE">  |
|       |
| **Exa |
| mple  |
| 12-3. |
| Findi |
| ng    |
| anagr |
| ams** |
|       |
| +---- |
| ----- |
| ----- |
| ----- |
| ----- |
| --+-- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----+ |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| -+    |
| | ..  |
| code: |
| : PRO |
| GRAML |
| ISTIN |
| G |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  #!/b |
| in/ba |
| sh    |
|       |
|   |   |
| |     |
|  # ag |
| ram2. |
| sh    |
|       |
|   |   |
| |     |
|  # Ex |
| ample |
|  of n |
| ested |
|   |   |
| | com |
| mand  |
| subst |
| ituti |
| on.   |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  #  U |
| ses " |
| anagr |
| am" u |
| t |   |
| | ili |
| ty    |
|       |
|       |
|       |
|   |   |
| |     |
|  #+ t |
| hat i |
| s par |
| t of  |
| t |   |
| | he  |
| autho |
| r's " |
| yawl" |
|  word |
|   |   |
| | lis |
| t pac |
| kage. |
|       |
|       |
|   |   |
| |     |
|  #  h |
| ttp:/ |
| /ibib |
| lio.o |
| r |   |
| | g/p |
| ub/Li |
| nux/l |
| ibs/y |
| awl-0 |
| . |   |
| | 3.2 |
| .tar. |
| gz    |
|       |
|       |
|   |   |
| |     |
|  #  h |
| ttp:/ |
| /bash |
| .deta |
| . |   |
| | in/ |
| yawl- |
| 0.3.2 |
| .tar. |
| gz    |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  E_NO |
| ARGS= |
| 86    |
|       |
|   |   |
| |     |
|  E_BA |
| DARG= |
| 87    |
|       |
|   |   |
| |     |
|  MINL |
| EN=7  |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  if [ |
|  -z " |
| $1" ] |
|       |
|   |   |
| |     |
|  then |
|       |
|       |
|       |
|   |   |
| |     |
|    ec |
| ho "U |
| sage  |
| $0 LE |
| T |   |
| | TER |
| SET"  |
|       |
|       |
|       |
|   |   |
| |     |
|    ex |
| it $E |
| _NOAR |
| GS    |
|   |   |
| |     |
|   # S |
| cript |
|  need |
| s a c |
| o |   |
| | mma |
| nd-li |
| ne ar |
| gumen |
| t.    |
|   |   |
| |     |
|  elif |
|  [ ${ |
| #1} - |
| lt $M |
| I |   |
| | NLE |
| N ]   |
|       |
|       |
|       |
|   |   |
| |     |
|  then |
|       |
|       |
|       |
|   |   |
| |     |
|    ec |
| ho "A |
| rgume |
| nt mu |
| s |   |
| | t h |
| ave a |
| t lea |
| st $M |
| INLEN |
|   |   |
| | let |
| ters. |
| "     |
|       |
|       |
|   |   |
| |     |
|    ex |
| it $E |
| _BADA |
| RG    |
|   |   |
| |     |
|  fi   |
|       |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  FILT |
| ER='. |
| ..... |
| .'    |
|   |   |
| |     |
|   # M |
| ust h |
| ave a |
| t lea |
| s |   |
| | t 7 |
|  lett |
| ers.  |
|       |
|       |
|   |   |
| |     |
|  #    |
|     1 |
| 23456 |
| 7     |
|   |   |
| |     |
|  Anag |
| rams= |
| ( $(e |
| cho $ |
| ( |   |
| | ana |
| gram  |
| $1 |  |
| grep  |
| $FILT |
| E |   |
| | R)  |
| ) )   |
|       |
|       |
|       |
|   |   |
| |     |
|  #    |
|       |
|   $(  |
|     $ |
| ( |   |
| |   n |
| ested |
|  comm |
| and s |
| ub.   |
|   |   |
| |  )  |
| )     |
|       |
|       |
|       |
|   |   |
| |     |
|  #    |
|       |
| (     |
|       |
|   |   |
| |     |
|  arra |
| y ass |
| ignme |
| nt    |
|   |   |
| |     |
|   )   |
|       |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  echo |
|       |
|       |
|       |
|   |   |
| |     |
|  echo |
|  "${# |
| Anagr |
| ams[* |
| ] |   |
| | }   |
| 7+ le |
| tter  |
| anagr |
| ams f |
| o |   |
| | und |
| "     |
|       |
|       |
|       |
|   |   |
| |     |
|  echo |
|       |
|       |
|       |
|   |   |
| |     |
|  echo |
|  ${An |
| agram |
| s[0]} |
|   |   |
| |     |
|   # F |
| irst  |
| anagr |
| am.   |
|   |   |
| |     |
|  echo |
|  ${An |
| agram |
| s[1]} |
|   |   |
| |     |
|   # S |
| econd |
|  anag |
| ram.  |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|   # E |
| tc.   |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  # ec |
| ho "$ |
| {Anag |
| rams[ |
| * |   |
| | ]}" |
|   # T |
| o lis |
| t all |
|  the  |
| a |   |
| | nag |
| rams  |
| in a  |
| singl |
| e lin |
| e |   |
| |  .  |
| . .   |
|       |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  #  L |
| ook a |
| head  |
| to th |
| e |   |
| |  Ar |
| rays  |
| chapt |
| er fo |
| r enl |
| i |   |
| | ght |
| enmen |
| t on  |
|       |
|       |
|   |   |
| |     |
|  #+ w |
| hat's |
|  goin |
| g on  |
| h |   |
| | ere |
| .     |
|       |
|       |
|       |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  # Se |
| e als |
| o the |
|  agra |
| m |   |
| | .sh |
|  scri |
| pt fo |
| r an  |
| exerc |
| i |   |
| | se  |
| in an |
| agram |
|  find |
| ing.  |
|   |   |
| |     |
|       |
|       |
|       |
|       |
|   |   |
| |     |
|  exit |
|  $?   |
|       |
|       |
|   |   |
|       |
|       |
|       |
|       |
|       |
|       |
| +---- |
| ----- |
| ----- |
| ----- |
| ----- |
| --+-- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----+ |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| -+    |
|       |
| .. ra |
| w:: h |
| tml   |
|       |
|    </ |
| div>  |
       
+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+

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

   </div>

Notes
~~~~~

.. raw:: html

   <table border="0" class="FOOTNOTES" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [1]  <commandsub.html#AEN7205>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

For purposes of *command substitution* , a **command** may be an
external system command, an internal scripting
`builtin <internal.html#BUILTINREF>`__ , or even `a script
function <assortedtips.html#RVT>`__ .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [2]  <commandsub.html#AEN7211>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

In a more technically correct sense, *command substitution* extracts the
``        stdout       `` of a command, then assigns it to a variable
using the = operator.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [3]  <commandsub.html#AEN7308>`__

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
