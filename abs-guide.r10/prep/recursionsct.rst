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

`Prev <testsandcomparisons.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 36. Miscellany

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <colorizing.html>`__

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

  36.4. Recursion: a script calling itself
=========================================

Can a script `recursively <localvar.html#RECURSIONREF>`__ call itself?
Indeed.

.. raw:: html

   <div class="EXAMPLE">

**Example 36-10. A (useless) script that recursively calls itself**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # recurse.sh         |
|                          |
|     #  Can a script recu |
| rsively call itself?     |
|     #  Yes, but is this  |
| of any practical use?    |
|     #  (See the followin |
| g.)                      |
|                          |
|     RANGE=10             |
|     MAXVAL=9             |
|                          |
|     i=$RANDOM            |
|     let "i %= $RANGE"  # |
|  Generate a random numbe |
| r between 0 and $RANGE - |
|  1.                      |
|                          |
|     if [ "$i" -lt "$MAXV |
| AL" ]                    |
|     then                 |
|       echo "i = $i"      |
|       ./$0             # |
|   Script recursively spa |
| wns a new instance of it |
| self.                    |
|     fi                 # |
|   Each child script does |
|  the same, until         |
|                        # |
| + a generated $i equals  |
| $MAXVAL.                 |
|                          |
|     #  Using a "while" l |
| oop instead of an "if/th |
| en" test causes problems |
| .                        |
|     #  Explain why.      |
|                          |
|     exit 0               |
|                          |
|     # Note:              |
|     # ----               |
|     # This script must h |
| ave execute permission f |
| or it to work properly.  |
|     # This is the case e |
| ven if it is invoked by  |
| an "sh" command.         |
|     # Explain why.       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 36-11. A (useful) script that recursively calls itself**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # pb.sh: phone book  |
|                          |
|     # Written by Rick Bo |
| ivie, and used with perm |
| ission.                  |
|     # Modifications by A |
| BS Guide author.         |
|                          |
|     MINARGS=1     #  Scr |
| ipt needs at least one a |
| rgument.                 |
|     DATAFILE=./phonebook |
|                   #  A d |
| ata file in current work |
| ing directory            |
|                   #+ nam |
| ed "phonebook" must exis |
| t.                       |
|     PROGNAME=$0          |
|     E_NOARGS=70   #  No  |
| arguments error.         |
|                          |
|     if [ $# -lt $MINARGS |
|  ]; then                 |
|           echo "Usage: " |
| $PROGNAME" data-to-look- |
| up"                      |
|           exit $E_NOARGS |
|     fi                   |
|                          |
|                          |
|     if [ $# -eq $MINARGS |
|  ]; then                 |
|           grep $1 "$DATA |
| FILE"                    |
|           # 'grep' print |
| s an error message if $D |
| ATAFILE not present.     |
|     else                 |
|           ( shift; "$PRO |
| GNAME" $* ) | grep $1    |
|           # Script recur |
| sively calls itself.     |
|     fi                   |
|                          |
|     exit 0        #  Scr |
| ipt exits here.          |
|                   #  The |
| refore, it's o.k. to put |
|                   #+ non |
| -hashmarked comments and |
|  data after this point.  |
|                          |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| ------                   |
|     Sample "phonebook" d |
| atafile:                 |
|                          |
|     John Doe        1555 |
|  Main St., Baltimore, MD |
|  21228          (410) 22 |
| 2-3333                   |
|     Mary Moe        9899 |
|  Jones Blvd., Warren, NH |
|  03787          (603) 89 |
| 8-3232                   |
|     Richard Roe     856  |
| E. 7th St., New York, NY |
|  10009          (212) 33 |
| 3-4567                   |
|     Sam Roe         956  |
| E. 8th St., New York, NY |
|  10009          (212) 44 |
| 4-5678                   |
|     Zoe Zenobia     4481 |
|  N. Baker St., San Franc |
| isco, SF 94338  (415) 50 |
| 1-1631                   |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| ------                   |
|                          |
|     $bash pb.sh Roe      |
|     Richard Roe     856  |
| E. 7th St., New York, NY |
|  10009          (212) 33 |
| 3-4567                   |
|     Sam Roe         956  |
| E. 8th St., New York, NY |
|  10009          (212) 44 |
| 4-5678                   |
|                          |
|     $bash pb.sh Roe Sam  |
|     Sam Roe         956  |
| E. 8th St., New York, NY |
|  10009          (212) 44 |
| 4-5678                   |
|                          |
|     #  When more than on |
| e argument is passed to  |
| this script,             |
|     #+ it prints *only*  |
| the line(s) containing a |
| ll the arguments.        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 36-12. Another (useful) script that recursively calls itself**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # usrmnt.sh, written |
|  by Anthony Richardson   |
|     # Used in ABS Guide  |
| with permission.         |
|                          |
|     # usage:       usrmn |
| t.sh                     |
|     # description: mount |
|  device, invoking user m |
| ust be listed in the     |
|     #              MNTUS |
| ERS group in the /etc/su |
| doers file.              |
|                          |
|     # ------------------ |
| ------------------------ |
| ----------------         |
|     #  This is a usermou |
| nt script that reruns it |
| self using sudo.         |
|     #  A user with the p |
| roper permissions only h |
| as to type               |
|                          |
|     #   usermount /dev/f |
| d0 /mnt/floppy           |
|                          |
|     # instead of         |
|                          |
|     #   sudo usermount / |
| dev/fd0 /mnt/floppy      |
|                          |
|     #  I use this same t |
| echnique for all of my   |
|     #+ sudo scripts, bec |
| ause I find it convenien |
| t.                       |
|     # ------------------ |
| ------------------------ |
| ----------------         |
|                          |
|     #  If SUDO_COMMAND v |
| ariable is not set we ar |
| e not being run through  |
|     #+ sudo, so rerun ou |
| rselves. Pass the user's |
|  real and group id . . . |
|                          |
|     if [ -z "$SUDO_COMMA |
| ND" ]                    |
|     then                 |
|        mntusr=$(id -u) g |
| rpusr=$(id -g) sudo $0 $ |
| *                        |
|        exit 0            |
|     fi                   |
|                          |
|     # We will only get h |
| ere if we are being run  |
| by sudo.                 |
|     /bin/mount $* -o uid |
| =$mntusr,gid=$grpusr     |
|                          |
|     exit 0               |
|                          |
|     # Additional notes ( |
| from the author of this  |
| script):                 |
|     # ------------------ |
| ------------------------ |
| -------                  |
|                          |
|     # 1) Linux allows th |
| e "users" option in the  |
| /etc/fstab               |
|     #    file so that an |
| y user can mount removab |
| le media.                |
|     #    But, on a serve |
| r, I like to allow only  |
| a few                    |
|     #    individuals acc |
| ess to removable media.  |
|     #    I find using su |
| do gives me more control |
| .                        |
|                          |
|     # 2) I also find sud |
| o to be more convenient  |
| than                     |
|     #    accomplishing t |
| his task through groups. |
|                          |
|     # 3) This method giv |
| es anyone with proper pe |
| rmissions                |
|     #    root access to  |
| the mount command, so be |
|  careful                 |
|     #    about who you a |
| llow access.             |
|     #    You can get fin |
| er control over which ac |
| cess can be mounted      |
|     #    by using this s |
| ame technique in separat |
| e mntfloppy, mntcdrom,   |
|     #    and mntsamba sc |
| ripts.                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="CAUTION">

+--------------------------------------+--------------------------------------+
| |Caution|                            |
| Too many levels of recursion can     |
| exhaust the script's stack space,    |
| causing a segfault.                  |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <testsandcompariso | Tests and Comparisons:   |
| ns.html>`__              | Alternatives             |
| `Home <index.html>`__    | `Up <miscellany.html>`__ |
| `Next <colorizing.html>` |  "Colorizing" Scripts    |
| __                       |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
