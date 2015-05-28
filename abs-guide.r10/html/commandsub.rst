Advanced Bash-Scripting Guide:

`Prev <testbranch.html>`__

`Next <arithexp.html>`__

--------------

Chapter 12. Command Substitution
================================

**Command substitution** reassigns the output of a command
`[1] <commandsub.html#FTN.AEN7205>`__ or even multiple commands; it
literally plugs the command output into another context.
`[2] <commandsub.html#FTN.AEN7211>`__

The classic form of command substitution uses *backquotes* (\`...\`).
Commands within backquotes (backticks) generate command-line text.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     script_name=`basename $0`                                            |
|     echo "The name of this script is $script_name."                      |
                                                                          
+--------------------------------------------------------------------------+

**The output of commands can be used as arguments to another command, to
set a variable, and even for generating the argument list in a
`for <loops1.html#FORLOOPREF1>`__ loop.**

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     rm `cat filename`   # "filename" contains a list of files to delete. |
|     #                                                                    |
|     # S. C. points out that "arg list too long" error might result.      |
|     # Better is              xargs rm -- < filename                      |
|     # ( -- covers those cases where "filename" begins with a "-" )       |
|                                                                          |
|     textfile_listing=`ls *.txt`                                          |
|     # Variable contains names of all *.txt files in current working dire |
| ctory.                                                                   |
|     echo $textfile_listing                                               |
|                                                                          |
|     textfile_listing2=$(ls *.txt)   # The alternative form of command su |
| bstitution.                                                              |
|     echo $textfile_listing2                                              |
|     # Same result.                                                       |
|                                                                          |
|     # A possible problem with putting a list of files into a single stri |
| ng                                                                       |
|     # is that a newline may creep in.                                    |
|     #                                                                    |
|     # A safer way to assign a list of files to a parameter is with an ar |
| ray.                                                                     |
|     #      shopt -s nullglob    # If no match, filename expands to nothi |
| ng.                                                                      |
|     #      textfile_listing=( *.txt )                                    |
|     #                                                                    |
|     # Thanks, S.C.                                                       |
                                                                          
+--------------------------------------------------------------------------+

+--------------------------------------+--------------------------------------+
| |Note|                               |
| Command substitution invokes a       |
| `subshell <subshells.html#SUBSHELLSR |
| EF>`__.                              |
+--------------------------------------+--------------------------------------+

+--------------+--------------+--------------+--------------+--------------+--------------+
| |Caution|    |
| Command      |
| substitution |
| may result   |
| in `word     |
| splitting <q |
| uotingvar.ht |
| ml#WSPLITREF |
| >`__.        |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
| | .. code::  |
| PROGRAMLISTI |
| NG           |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     COMMAN |
| D `echo a b` |
|      # 2 arg |
| s: a and b   |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     COMMAN |
| D "`echo a b |
| `"   # 1 arg |
| : "a b"      |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     COMMAN |
| D `echo`     |
|      # no ar |
| g            |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     COMMAN |
| D "`echo`"   |
|      # one e |
| mpty arg     |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     # Than |
| ks, S.C.     |
|              |
|              |
|              |
|              |
|    |         |
|              |
|              |
|              |
|              |
|              |
|              |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
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
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
| | .. code::  |
| PROGRAMLISTI |
| NG           |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     # cd " |
| `pwd`"  # Th |
| is should al |
| ways work.   |
|              |
|              |
|    |         |
| |     # Howe |
| ver...       |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     mkdir  |
| 'dir with tr |
| ailing newli |
| ne           |
|              |
|              |
|    |         |
| |     '      |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     cd 'di |
| r with trail |
| ing newline  |
|              |
|              |
|              |
|    |         |
| |     '      |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     cd "`p |
| wd`"  # Erro |
| r message:   |
|              |
|              |
|              |
|    |         |
| |     # bash |
| : cd: /tmp/f |
| ile with tra |
| iling newlin |
| e: No such f |
| ile or direc |
| to |         |
| | ry         |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     cd "$P |
| WD"   # Work |
| s fine.      |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     old_tt |
| y_setting=$( |
| stty -g)   # |
|  Save old te |
| rminal setti |
| ng.          |
|    |         |
| |     echo " |
| Hit a key "  |
|              |
|              |
|              |
|              |
|    |         |
| |     stty - |
| icanon -echo |
|            # |
|  Disable "ca |
| nonical" mod |
| e for termin |
| al |         |
| | .          |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |            |
|              |
|            # |
|  Also, disab |
| le *local* e |
| cho.         |
|    |         |
| |     key=$( |
| dd bs=1 coun |
| t=1 2> /dev/ |
| null)   # Us |
| ing 'dd' to  |
| get a keypre |
| ss |         |
| | .          |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     stty " |
| $old_tty_set |
| ting"      # |
|  Restore old |
|  setting.    |
|              |
|    |         |
| |     echo " |
| You hit ${#k |
| ey} key."  # |
|  ${#variable |
| } = number o |
| f characters |
|  i |         |
| | n $variabl |
| e            |
|              |
|              |
|              |
|              |
|    |         |
| |     #      |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     # Hit  |
| any key exce |
| pt RETURN, a |
| nd the outpu |
| t is "You hi |
| t 1 key."    |
|    |         |
| |     # Hit  |
| RETURN, and  |
| it's "You hi |
| t 0 key."    |
|              |
|              |
|    |         |
| |     # The  |
| newline gets |
|  eaten in th |
| e command su |
| bstitution.  |
|              |
|    |         |
| |            |
|              |
|              |
|              |
|              |
|              |
|    |         |
| |     #Code  |
| snippet by S |
| téphane Chaz |
| elas.        |
|              |
|              |
|    |         |
|              |
|              |
|              |
|              |
|              |
|              |
|              |
| +----------- |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ------------ |
| ---+         |
              
+--------------+--------------+--------------+--------------+--------------+--------------+

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
| ------------------------ |
| ------------------------ |
| ---+                     |
| | .. code:: PROGRAMLISTI |
| NG                       |
|                          |
|    |                     |
| |                        |
|                          |
|                          |
|    |                     |
| |     dir_listing=`ls -l |
| `                        |
|                          |
|    |                     |
| |     echo $dir_listing  |
|     # unquoted           |
|                          |
|    |                     |
| |                        |
|                          |
|                          |
|    |                     |
| |     # Expecting a nice |
| ly ordered directory lis |
| ting.                    |
|    |                     |
| |                        |
|                          |
|                          |
|    |                     |
| |     # However, what yo |
| u get is:                |
|                          |
|    |                     |
| |     # total 3 -rw-rw-r |
| -- 1 bozo bozo 30 May 13 |
|  17:15 1.txt -rw-rw-r--  |
| 1  |                     |
| | bozo                   |
|                          |
|                          |
|    |                     |
| |     # bozo 51 May 15 2 |
| 0:57 t2.sh -rwxr-xr-x 1  |
| bozo bozo 217 Mar 5 21:1 |
| 3  |                     |
| | wi.sh                  |
|                          |
|                          |
|    |                     |
| |                        |
|                          |
|                          |
|    |                     |
| |     # The newlines dis |
| appeared.                |
|                          |
|    |                     |
| |                        |
|                          |
|                          |
|    |                     |
| |                        |
|                          |
|                          |
|    |                     |
| |     echo "$dir_listing |
| "   # quoted             |
|                          |
|    |                     |
| |     # -rw-rw-r--    1  |
| bozo       30 May 13 17: |
| 15 1.txt                 |
|    |                     |
| |     # -rw-rw-r--    1  |
| bozo       51 May 15 20: |
| 57 t2.sh                 |
|    |                     |
| |     # -rwxr-xr-x    1  |
| bozo      217 Mar  5 21: |
| 13 wi.sh                 |
|    |                     |
|                          |
|                          |
|                          |
|                          |
| +----------------------- |
| ------------------------ |
| ------------------------ |
| ---+                     |
                          
+--------------------------+--------------------------+--------------------------+

Command substitution even permits setting a variable to the contents of
a file, using either `redirection <io-redirection.html#IOREDIRREF>`__ or
the `cat <basic.html#CATREF>`__ command.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     variable1=`<file1`      #  Set "variable1" to contents of "file1".   |
|     variable2=`cat file2`   #  Set "variable2" to contents of "file2".   |
|                             #  This, however, forks a new process,       |
|                             #+ so the line of code executes slower than  |
| the above version.                                                       |
|                                                                          |
|     #  Note that the variables may contain embedded whitespace,          |
|     #+ or even (horrors), control characters.                            |
|                                                                          |
|     #  It is not necessary to explicitly assign a variable.              |
|     echo "` <$0`"           # Echoes the script itself to stdout.        |
                                                                          
+--------------------------------------------------------------------------+

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #  Excerpts from system file, /etc/rc.d/rc.sysinit                   |
|     #+ (on a Red Hat Linux installation)                                 |
|                                                                          |
|                                                                          |
|     if [ -f /fsckoptions ]; then                                         |
|             fsckoptions=`cat /fsckoptions`                               |
|     ...                                                                  |
|     fi                                                                   |
|     #                                                                    |
|     #                                                                    |
|     if [ -e "/proc/ide/${disk[$device]}/media" ] ; then                  |
|                  hdmedia=`cat /proc/ide/${disk[$device]}/media`          |
|     ...                                                                  |
|     fi                                                                   |
|     #                                                                    |
|     #                                                                    |
|     if [ ! -n "`uname -r | grep -- "-"`" ]; then                         |
|            ktag="`cat /proc/version`"                                    |
|     ...                                                                  |
|     fi                                                                   |
|     #                                                                    |
|     #                                                                    |
|     if [ $usb = "1" ]; then                                              |
|         sleep 5                                                          |
|         mouseoutput=`cat /proc/bus/usb/devices 2>/dev/null|grep -E "^I.* |
| Cls=03.*Prot=02"`                                                        |
|         kbdoutput=`cat /proc/bus/usb/devices 2>/dev/null|grep -E "^I.*Cl |
| s=03.*Prot=01"`                                                          |
|     ...                                                                  |
|     fi                                                                   |
                                                                          
+--------------------------------------------------------------------------+

+----------------+----------------+----------------+----------------+----------------+
| |Caution|      |
| Do not set a   |
| variable to    |
| the contents   |
| of a *long*    |
| text file      |
| unless you     |
| have a very    |
| good reason    |
| for doing so.  |
| Do not set a   |
| variable to    |
| the contents   |
| of a *binary*  |
| file, even as  |
| a joke.        |
|                |
| **Example      |
| 12-1. Stupid   |
| script         |
| tricks**       |
|                |
| +------------- |
| -------------- |
| -------------- |
| -------------- |
| -------------- |
| -----+         |
| | .. code:: PR |
| OGRAMLISTING   |
|                |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     #!/bin/b |
| ash            |
|                |
|                |
|                |
|      |         |
| |     # stupid |
| -script-tricks |
| .sh: Don't try |
|  this at home, |
|  folks.        |
|      |         |
| |     # From " |
| Stupid Script  |
| Tricks," Volum |
| e I.           |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     exit 99  |
|  ### Comment o |
| ut this line i |
| f you dare.    |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     dangerou |
| s_variable=`ca |
| t /boot/vmlinu |
| z`   # The com |
| pressed Linux  |
| kern |         |
| | el itself.   |
|                |
|                |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     echo "st |
| ring-length of |
|  \$dangerous_v |
| ariable = ${#d |
| angerous_varia |
| ble} |         |
| | "            |
|                |
|                |
|                |
|                |
|      |         |
| |     # string |
| -length of $da |
| ngerous_variab |
| le = 794151    |
|                |
|      |         |
| |     # (Newer |
|  kernels are b |
| igger.)        |
|                |
|                |
|      |         |
| |     # Does n |
| ot give same c |
| ount as 'wc -c |
|  /boot/vmlinuz |
| '.             |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     # echo " |
| $dangerous_var |
| iable"         |
|                |
|                |
|      |         |
| |     # Don't  |
| try this! It w |
| ould hang the  |
| script.        |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     #  The d |
| ocument author |
|  is aware of n |
| o useful appli |
| cations for    |
|      |         |
| |     #+ setti |
| ng a variable  |
| to the content |
| s of a binary  |
| file.          |
|      |         |
| |              |
|                |
|                |
|                |
|                |
|      |         |
| |     exit 0   |
|                |
|                |
|                |
|                |
|      |         |
|                |
|                |
|                |
|                |
|                |
|                |
| +------------- |
| -------------- |
| -------------- |
| -------------- |
| -------------- |
| -----+         |
|                |
| Notice that a  |
| *buffer        |
| overrun* does  |
| not occur.     |
| This is one    |
| instance where |
| an interpreted |
| language, such |
| as Bash,       |
| provides more  |
| protection     |
| from           |
| programmer     |
| mistakes than  |
| a compiled     |
| language.      |
+----------------+----------------+----------------+----------------+----------------+

Command substitution permits setting a variable to the output of a
`loop <loops1.html#FORLOOPREF1>`__. The key to this is grabbing the
output of an `echo <internal.html#ECHOREF>`__ command within the loop.

**Example 12-2. Generating a variable from a loop**

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     #!/bin/bash                                                          |
|     # csubloop.sh: Setting a variable to the output of a loop.           |
|                                                                          |
|     variable1=`for i in 1 2 3 4 5                                        |
|     do                                                                   |
|       echo -n "$i"                 #  The 'echo' command is critical     |
|     done`                          #+ to command substitution here.      |
|                                                                          |
|     echo "variable1 = $variable1"  # variable1 = 12345                   |
|                                                                          |
|                                                                          |
|     i=0                                                                  |
|     variable2=`while [ "$i" -lt 10 ]                                     |
|     do                                                                   |
|       echo -n "$i"                 # Again, the necessary 'echo'.        |
|       let "i += 1"                 # Increment.                          |
|     done`                                                                |
|                                                                          |
|     echo "variable2 = $variable2"  # variable2 = 0123456789              |
|                                                                          |
|     #  Demonstrates that it's possible to embed a loop                   |
|     #+ inside a variable declaration.                                    |
|                                                                          |
|     exit 0                                                               |
                                                                          
+--------------------------------------------------------------------------+

+----------+----------+----------+----------+----------+----------+----------+----------+----------+
| Command  |
| substitu |
| tion     |
| makes it |
| possible |
| to       |
| extend   |
| the      |
| toolset  |
| availabl |
| e        |
| to Bash. |
| It is    |
| simply a |
| matter   |
| of       |
| writing  |
| a        |
| program  |
| or       |
| script   |
| that     |
| outputs  |
| to       |
| ``stdout |
| ``       |
| (like a  |
| well-beh |
| aved     |
| UNIX     |
| tool     |
| should)  |
| and      |
| assignin |
| g        |
| that     |
| output   |
| to a     |
| variable |
| .        |
|          |
| +------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| ---+     |
| | .. cod |
| e:: PROG |
| RAMLISTI |
| NG       |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |        |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     #i |
| nclude < |
| stdio.h> |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |        |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     /* |
|   "Hello |
| , world. |
| " C prog |
| ram  */  |
|          |
|          |
|          |
|          |
|    |     |
| |        |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     in |
| t main() |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     {  |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |        |
| printf(  |
| "Hello,  |
| world.\n |
| " );     |
|          |
|          |
|          |
|          |
|    |     |
| |        |
| return ( |
| 0);      |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     }  |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
| +------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| ---+     |
|          |
| +------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| ---+     |
| | .. cod |
| e:: SCRE |
| EN       |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |        |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     ba |
| sh$ gcc  |
| -o hello |
|  hello.c |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |        |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
| +------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| ---+     |
|          |
| +------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| ---+     |
| | .. cod |
| e:: PROG |
| RAMLISTI |
| NG       |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |        |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     #! |
| /bin/bas |
| h        |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     #  |
| hello.sh |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |        |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     gr |
| eeting=` |
| ./hello` |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     ec |
| ho $gree |
| ting     |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
| +------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| ---+     |
|          |
| +------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| ---+     |
| | .. cod |
| e:: SCRE |
| EN       |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |        |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     ba |
| sh$ sh h |
| ello.sh  |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |     He |
| llo, wor |
| ld.      |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
| |        |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|    |     |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
|          |
| +------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| -------- |
| ---+     |
|          |
          
+----------+----------+----------+----------+----------+----------+----------+----------+----------+

+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+
| |Note |
| |     |
| The   |
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
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| +     |
| | ..  |
| code: |
| : PRO |
| GRAML |
| ISTIN |
| G     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  outp |
| ut=$( |
| sed - |
| n /"$ |
| 1"/p  |
| $file |
| )   # |
|  From |
|  "grp |
| .sh"  |
|   exa |
| mple. |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  # Se |
| tting |
|  a va |
| riabl |
| e to  |
| the c |
| onten |
| ts of |
|  a te |
| xt fi |
| le.   |
|       |
|       |
|       |
| |     |
| |     |
|  File |
| _cont |
| ents1 |
| =$(ca |
| t $fi |
| le1)  |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  File |
| _cont |
| ents2 |
| =$(<$ |
| file2 |
| )     |
|     # |
|  Bash |
|  perm |
| its t |
| his a |
| lso.  |
|       |
|       |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
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
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| +     |
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
| *.    |
|       |
| +---- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| +     |
| | ..  |
| code: |
| : SCR |
| EEN   |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  bash |
| $ ech |
| o `ec |
| ho \\ |
| `     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  bash |
| $ ech |
| o $(e |
| cho \ |
| \)    |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  \    |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
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
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| +     |
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
| `[3]  |
| <comm |
| andsu |
| b.htm |
| l#FTN |
| .AEN7 |
| 308>` |
| __    |
|       |
| +---- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| +     |
| | ..  |
| code: |
| : PRO |
| GRAML |
| ISTIN |
| G     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  word |
| _coun |
| t=$(  |
| wc -w |
|  $(ec |
| ho *  |
| | awk |
|  '{pr |
| int $ |
| 8}')  |
| )     |
|       |
|       |
|       |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
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
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| +     |
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
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| +     |
| | ..  |
| code: |
| : PRO |
| GRAML |
| ISTIN |
| G     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  #!/b |
| in/ba |
| sh    |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  # ag |
| ram2. |
| sh    |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  # Ex |
| ample |
|  of n |
| ested |
|  comm |
| and s |
| ubsti |
| tutio |
| n.    |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  #  U |
| ses " |
| anagr |
| am" u |
| tilit |
| y     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  #+ t |
| hat i |
| s par |
| t of  |
| the a |
| uthor |
| 's "y |
| awl"  |
| word  |
| list  |
| packa |
| ge.   |
|       |
|       |
| |     |
| |     |
|  #  h |
| ttp:/ |
| /ibib |
| lio.o |
| rg/pu |
| b/Lin |
| ux/li |
| bs/ya |
| wl-0. |
| 3.2.t |
| ar.gz |
|       |
|       |
|       |
| |     |
| |     |
|  #  h |
| ttp:/ |
| /bash |
| .deta |
| .in/y |
| awl-0 |
| .3.2. |
| tar.g |
| z     |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  E_NO |
| ARGS= |
| 86    |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  E_BA |
| DARG= |
| 87    |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  MINL |
| EN=7  |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  if [ |
|  -z " |
| $1" ] |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  then |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|    ec |
| ho "U |
| sage  |
| $0 LE |
| TTERS |
| ET"   |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|    ex |
| it $E |
| _NOAR |
| GS    |
|       |
|  # Sc |
| ript  |
| needs |
|  a co |
| mmand |
| -line |
|  argu |
| ment. |
|       |
| |     |
| |     |
|  elif |
|  [ ${ |
| #1} - |
| lt $M |
| INLEN |
|  ]    |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  then |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|    ec |
| ho "A |
| rgume |
| nt mu |
| st ha |
| ve at |
|  leas |
| t $MI |
| NLEN  |
| lette |
| rs."  |
|       |
|       |
|       |
| |     |
| |     |
|    ex |
| it $E |
| _BADA |
| RG    |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  fi   |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  FILT |
| ER='. |
| ..... |
| .'    |
|       |
|  # Mu |
| st ha |
| ve at |
|  leas |
| t 7 l |
| etter |
| s.    |
|       |
|       |
| |     |
| |     |
|  #    |
|     1 |
| 23456 |
| 7     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  Anag |
| rams= |
| ( $(e |
| cho $ |
| (anag |
| ram $ |
| 1 | g |
| rep $ |
| FILTE |
| R) )  |
| )     |
|       |
|       |
|       |
| |     |
| |     |
|  #    |
|       |
|   $(  |
|     $ |
| (  ne |
| sted  |
| comma |
| nd su |
| b.    |
|  ) )  |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  #    |
|       |
| (     |
|       |
|       |
| array |
|  assi |
| gnmen |
| t     |
|       |
| )     |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  echo |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  echo |
|  "${# |
| Anagr |
| ams[* |
| ]}  7 |
| + let |
| ter a |
| nagra |
| ms fo |
| und"  |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  echo |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  echo |
|  ${An |
| agram |
| s[0]} |
|       |
|  # Fi |
| rst a |
| nagra |
| m.    |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  echo |
|  ${An |
| agram |
| s[1]} |
|       |
|  # Se |
| cond  |
| anagr |
| am.   |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|  # Et |
| c.    |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  # ec |
| ho "$ |
| {Anag |
| rams[ |
| *]}"  |
|  # To |
|  list |
|  all  |
| the a |
| nagra |
| ms in |
|  a si |
| ngle  |
| line  |
| |     |
| |  .  |
| . .   |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  #  L |
| ook a |
| head  |
| to th |
| e Arr |
| ays c |
| hapte |
| r for |
|  enli |
| ghten |
| ment  |
| on    |
|       |
|       |
| |     |
| |     |
|  #+ w |
| hat's |
|  goin |
| g on  |
| here. |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  # Se |
| e als |
| o the |
|  agra |
| m.sh  |
| scrip |
| t for |
|  an e |
| xerci |
| se in |
|  anag |
| ram f |
| indin |
| g.    |
| |     |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
| |     |
|  exit |
|  $?   |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
| |     |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
|       |
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
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| ----- |
| +     |
       
+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+-------+

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

Notes
~~~~~

`[1] <commandsub.html#AEN7205>`__

For purposes of *command substitution*, a **command** may be an external
system command, an internal scripting
`builtin <internal.html#BUILTINREF>`__, or even `a script
function <assortedtips.html#RVT>`__.

`[2] <commandsub.html#AEN7211>`__

In a more technically correct sense, *command substitution* extracts the
``stdout`` of a command, then assigns it to a variable using the =
operator.

`[3] <commandsub.html#AEN7308>`__

In fact, nesting with backticks is also possible, but only by escaping
the inner backticks, as John Default points out.

+--------------------------------------------------------------------------+
| .. code:: PROGRAMLISTING                                                 |
|                                                                          |
|     word_count=` wc -w \`echo * | awk '{print $8}'\` `                   |
                                                                          
+--------------------------------------------------------------------------+

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <testbranch.html>` | Testing and Branching    |
| __                       | `Up <part3.html>`__      |
| `Home <index.html>`__    | Arithmetic Expansion     |
| `Next <arithexp.html>`__ |                          |
+--------------------------+--------------------------+--------------------------+

.. |Note| image:: ../images/note.gif
.. |Caution| image:: ../images/caution.gif
