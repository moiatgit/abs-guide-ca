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

`Prev <extmisc.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <sysscripts.html>`__

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

  Chapter 17. System and Administrative Commands
===============================================

The startup and shutdown scripts in ``      /etc/rc.d     `` illustrate
the uses (and usefulness) of many of these comands. These are usually
invoked by *root* and used for system maintenance or emergency
filesystem repairs. Use with caution, as some of these commands may
damage your system if misused.

.. raw:: html

   <div class="VARIABLELIST">

** Users and Groups**

 **users**
    Show all logged on users. This is the approximate equivalent of
    **who -q** .

 **groups**
    Lists the current user and the groups she belongs to. This
    corresponds to the `$GROUPS <internalvariables.html#GROUPSREF>`__
    internal variable, but gives the group names, rather than the
    numbers.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ groups         |
    |     bozita cdrom cdwrite |
    | r audio xgrp             |
    |                          |
    |     bash$ echo $GROUPS   |
    |     501                  |
                              
    +--------------------------+--------------------------+--------------------------+

 **chown** , **chgrp**
    The **chown** command changes the ownership of a file or files. This
    command is a useful method that *root* can use to shift file
    ownership from one user to another. An ordinary user may not change
    the ownership of files, not even her own files. ` [1]
     <system.html#FTN.AEN14695>`__

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     root# chown bozo *.t |
    | xt                       |
    |                          |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    The **chgrp** command changes the
    ``                   group                 `` ownership of a file or
    files. You must be owner of the file(s) as well as a member of the
    destination group (or *root* ) to use this operation.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     chgrp --recursive du |
    | nderheads *.data         |
    |     #  The "dunderheads" |
    |  group will now own all  |
    | the "*.data" files       |
    |     #+ all the way down  |
    | the $PWD directory tree  |
    | (that's what "recursive" |
    |  means).                 |
                              
    +--------------------------+--------------------------+--------------------------+

 **useradd** , **userdel**
    The **useradd** administrative command adds a user account to the
    system and creates a home directory for that particular user, if so
    specified. The corresponding **userdel** command removes a user
    account from the system ` [2]  <system.html#FTN.AEN14727>`__ and
    deletes associated files.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The **adduser** command is a synonym |
    | for **useradd** and is usually a     |
    | symbolic link to it.                 |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **usermod**
    Modify a user account. Changes may be made to the password, group
    membership, expiration date, and other attributes of a given user's
    account. With this command, a user's password may be locked, which
    has the effect of disabling the account.

 **groupmod**
    Modify a given group. The group name and/or ID number may be changed
    using this command.

 **id**
    The **id** command lists the real and effective user IDs and the
    group IDs of the user associated with the current process. This is
    the counterpart to the `$UID <internalvariables.html#UIDREF>`__ ,
    `$EUID <internalvariables.html#EUIDREF>`__ , and
    `$GROUPS <internalvariables.html#GROUPSREF>`__ internal Bash
    variables.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ id             |
    |     uid=501(bozo) gid=50 |
    | 1(bozo) groups=501(bozo) |
    | ,22(cdrom),80(cdwriter), |
    | 81(audio)                |
    |                          |
    |     bash$ echo $UID      |
    |     501                  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The **id** command shows the         |
    | *effective* IDs only when they       |
    | differ from the *real* ones.         |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    Also see `Example 9-5 <internalvariables.html#AMIROOT>`__ .

 **lid**
    The *lid* (list ID) command shows the group(s) that a given user
    belongs to, or alternately, the users belonging to a given group.
    May be invoked only by root.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     root# lid bozo       |
    |      bozo(gid=500)       |
    |                          |
    |                          |
    |     root# lid daemon     |
    |      bin(gid=1)          |
    |       daemon(gid=2)      |
    |       adm(gid=4)         |
    |       lp(gid=7)          |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **who**
    Show all users logged on to the system.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ who            |
    |     bozo  tty1     Apr 2 |
    | 7 17:45                  |
    |      bozo  pts/0    Apr  |
    | 27 17:46                 |
    |      bozo  pts/1    Apr  |
    | 27 17:47                 |
    |      bozo  pts/2    Apr  |
    | 27 17:49                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    The ``         -m        `` gives detailed information about only
    the current user. Passing any two arguments to **who** is the
    equivalent of **who -m** , as in **who am i** or **who The Man** .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ who -m         |
    |     localhost.localdomai |
    | n!bozo  pts/2    Apr 27  |
    | 17:49                    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

     **whoami** is similar to **who -m** , but only lists the user name.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ whoami         |
    |     bozo                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **w**
    Show all logged on users and the processes belonging to them. This
    is an extended version of **who** . The output of **w** may be piped
    to `grep <textproc.html#GREPREF>`__ to find a specific user and/or
    process.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ w | grep start |
    | x                        |
    |     bozo  tty1     -     |
    |              4:22pm  6:4 |
    | 1   4.47s  0.45s  startx |
                              
    +--------------------------+--------------------------+--------------------------+

 **logname**
    Show current user's login name (as found in
    ``         /var/run/utmp        `` ). This is a near-equivalent to
    `whoami <system.html#WHOAMIREF>`__ , above.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ logname        |
    |     bozo                 |
    |                          |
    |     bash$ whoami         |
    |     bozo                 |
                              
    +--------------------------+--------------------------+--------------------------+

    However . . .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ su             |
    |     Password: ......     |
    |                          |
    |     bash# whoami         |
    |     root                 |
    |     bash# logname        |
    |     bozo                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | While **logname** prints the name of |
    | the logged in user, **whoami** gives |
    | the name of the user attached to the |
    | current process. As we have just     |
    | seen, sometimes these are not the    |
    | same.                                |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **su**
    Runs a program or script as a **s** ubstitute **u** ser. **su
    rjones** starts a shell as user *rjones* . A naked **su** defaults
    to *root* . See `Example A-14 <contributed-scripts.html#FIFO>`__ .

 **sudo**
    Runs a command as *root* (or another user). This may be used in a
    script, thus permitting a *regular user* to run the script.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     # Some commands.     |
    |     sudo cp /root/secret |
    | file /home/bozo/secret   |
    |     # Some more commands |
    | .                        |
                              
    +--------------------------+--------------------------+--------------------------+

    The file ``         /etc/sudoers        `` holds the names of users
    permitted to invoke **sudo** .

 **passwd**
    Sets, changes, or manages a user's password.

    The **passwd** command can be used in a script, but probably *should
    not* be.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-1. Setting a new password**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     #  setnew-password.s |
    | h: For demonstration pur |
    | poses only.              |
    |     #                    |
    |    Not a good idea to ac |
    | tually run this script.  |
    |     #  This script must  |
    | be run as root.          |
    |                          |
    |     ROOT_UID=0         # |
    |  Root has $UID 0.        |
    |     E_WRONG_USER=65    # |
    |  Not root?               |
    |                          |
    |     E_NOSUCHUSER=70      |
    |     SUCCESS=0            |
    |                          |
    |                          |
    |     if [ "$UID" -ne "$RO |
    | OT_UID" ]                |
    |     then                 |
    |       echo; echo "Only r |
    | oot can run this script. |
    | "; echo                  |
    |       exit $E_WRONG_USER |
    |     else                 |
    |       echo               |
    |       echo "You should k |
    | now better than to run t |
    | his script, root."       |
    |       echo "Even root us |
    | ers get the blues... "   |
    |       echo               |
    |     fi                   |
    |                          |
    |                          |
    |     username=bozo        |
    |     NEWPASSWORD=security |
    | _violation               |
    |                          |
    |     # Check if bozo live |
    | s here.                  |
    |     grep -q "$username"  |
    | /etc/passwd              |
    |     if [ $? -ne $SUCCESS |
    |  ]                       |
    |     then                 |
    |       echo "User $userna |
    | me does not exist."      |
    |       echo "No password  |
    | changed."                |
    |       exit $E_NOSUCHUSER |
    |     fi                   |
    |                          |
    |     echo "$NEWPASSWORD"  |
    | | passwd --stdin "$usern |
    | ame"                     |
    |     #  The '--stdin' opt |
    | ion to 'passwd' permits  |
    |     #+ getting a new pas |
    | sword from stdin (or a p |
    | ipe).                    |
    |                          |
    |     echo; echo "User $us |
    | ername's password change |
    | d!"                      |
    |                          |
    |     # Using the 'passwd' |
    |  command in a script is  |
    | dangerous.               |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The **passwd** command's ``         -l        `` ,
    ``         -u        `` , and ``         -d        `` options permit
    locking, unlocking, and deleting a user's password. Only *root* may
    use these options.

 **ac**
    Show users' logged in time, as read from
    ``         /var/log/wtmp        `` . This is one of the GNU
    accounting utilities.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ac             |
    |             total        |
    | 68.08                    |
                              
    +--------------------------+--------------------------+--------------------------+

 **last**
    List *last* logged in users, as read from
    ``         /var/log/wtmp        `` . This command can also show
    remote logins.

    For example, to show the last few times the system rebooted:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ last reboot    |
    |     reboot   system boot |
    |   2.6.9-1.667      Fri F |
    | eb  4 18:18          (00 |
    | :02)                     |
    |      reboot   system boo |
    | t  2.6.9-1.667      Fri  |
    | Feb  4 15:20          (0 |
    | 1:27)                    |
    |      reboot   system boo |
    | t  2.6.9-1.667      Fri  |
    | Feb  4 12:56          (0 |
    | 0:49)                    |
    |      reboot   system boo |
    | t  2.6.9-1.667      Thu  |
    | Feb  3 21:08          (0 |
    | 2:17)                    |
    |      . . .               |
    |                          |
    |      wtmp begins Tue Feb |
    |   1 12:50:09 2005        |
                              
    +--------------------------+--------------------------+--------------------------+

 **newgrp**
    Change user's *group ID* without logging out. This permits access to
    the new group's files. Since users may be members of multiple groups
    simultaneously, this command finds only limited use.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Kurt Glaesemann points out that the  |
    | *newgrp* command could prove helpful |
    | in setting the default group         |
    | permissions for files a user writes. |
    | However, the                         |
    | `chgrp <system.html#CHGRPREF>`__     |
    | command might be more convenient for |
    | this purpose.                        |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Terminals**

 **tty**
    Echoes the name (filename) of the current user's terminal. Note that
    each separate *xterm* window counts as a different terminal.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ tty            |
    |     /dev/pts/1           |
                              
    +--------------------------+--------------------------+--------------------------+

 **stty**
    Shows and/or changes terminal settings. This complex command, used
    in a script, can control terminal behavior and the way output
    displays. See the info page, and study it carefully.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-2. Setting an *erase* character**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # erase.sh: Using "s |
    | tty" to set an erase cha |
    | racter when reading inpu |
    | t.                       |
    |                          |
    |     echo -n "What is you |
    | r name? "                |
    |     read name            |
    |            #  Try to bac |
    | kspace                   |
    |                          |
    |            #+ to erase c |
    | haracters of input.      |
    |                          |
    |            #  Problems?  |
    |     echo "Your name is $ |
    | name."                   |
    |                          |
    |     stty erase '#'       |
    |            #  Set "hashm |
    | ark" (#) as erase charac |
    | ter.                     |
    |     echo -n "What is you |
    | r name? "                |
    |     read name            |
    |            #  Use # to e |
    | rase last character type |
    | d.                       |
    |     echo "Your name is $ |
    | name."                   |
    |                          |
    |     exit 0               |
    |                          |
    |     # Even after the scr |
    | ipt exits, the new key v |
    | alue remains set.        |
    |     # Exercise: How woul |
    | d you reset the erase ch |
    | aracter to the default v |
    | alue?                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-3. *secret password* : Turning off terminal echoing**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # secret-pw.sh: secr |
    | et password              |
    |                          |
    |     echo                 |
    |     echo -n "Enter passw |
    | ord "                    |
    |     read passwd          |
    |     echo "password is $p |
    | asswd"                   |
    |     echo -n "If someone  |
    | had been looking over yo |
    | ur shoulder, "           |
    |     echo "your password  |
    | would have been compromi |
    | sed."                    |
    |                          |
    |     echo && echo  # Two  |
    | line-feeds in an "and li |
    | st."                     |
    |                          |
    |                          |
    |     stty -echo    # Turn |
    | s off screen echo.       |
    |     #   May also be done |
    |  with                    |
    |     #   read -sp passwd  |
    |     #   A big Thank You  |
    | to Leigh James for point |
    | ing this out.            |
    |                          |
    |     echo -n "Enter passw |
    | ord again "              |
    |     read passwd          |
    |     echo                 |
    |     echo "password is $p |
    | asswd"                   |
    |     echo                 |
    |                          |
    |     stty echo     # Rest |
    | ores screen echo.        |
    |                          |
    |     exit 0               |
    |                          |
    |     # Do an 'info stty'  |
    | for more on this useful- |
    | but-tricky command.      |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    A creative use of **stty** is detecting a user keypress (without
    hitting **ENTER** ).

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-4. Keypress detection**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # keypress.sh: Detec |
    | t a user keypress ("hot  |
    | keys").                  |
    |                          |
    |     echo                 |
    |                          |
    |     old_tty_settings=$(s |
    | tty -g)   # Save old set |
    | tings (why?).            |
    |     stty -icanon         |
    |     Keypress=$(head -c1) |
    |           # or $(dd bs=1 |
    |  count=1 2> /dev/null)   |
    |                          |
    |           # on non-GNU s |
    | ystems                   |
    |                          |
    |     echo                 |
    |     echo "Key pressed wa |
    | s \""$Keypress"\"."      |
    |     echo                 |
    |                          |
    |     stty "$old_tty_setti |
    | ngs"      # Restore old  |
    | settings.                |
    |                          |
    |     # Thanks, Stephane C |
    | hazelas.                 |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Also see `Example 9-3 <internalvariables.html#TIMEOUT>`__ and
    `Example A-43 <contributed-scripts.html#STOPWATCH>`__ .

    +--------------------------------------------------------------------------+
    | .. raw:: html                                                            |
    |                                                                          |
    |    <div class="SIDEBAR">                                                 |
    |                                                                          |
    | **terminals and modes**                                                  |
    |                                                                          |
    | Normally, a terminal works in the *canonical* mode. When a user hits a   |
    | key, the resulting character does not immediately go to the program      |
    | actually running in this terminal. A buffer local to the terminal stores |
    | keystrokes. When the user hits the **ENTER** key, this sends all the     |
    | stored keystrokes to the program running. There is even a basic line     |
    | editor inside the terminal.                                              |
    |                                                                          |
    | +--------------------------+--------------------------+----------------- |
    | ---------+                                                               |
    | | .. code:: SCREEN         |                                             |
    | |                          |                                             |
    | |     bash$ stty -a        |                                             |
    | |     speed 9600 baud; row |                                             |
    | | s 36; columns 96; line = |                                             |
    | |  0;                      |                                             |
    | |      intr = ^C; quit = ^ |                                             |
    | | \; erase = ^H; kill = ^U |                                             |
    | | ; eof = ^D; eol = <undef |                                             |
    | | >; eol2 = <undef>;       |                                             |
    | |      start = ^Q; stop =  |                                             |
    | | ^S; susp = ^Z; rprnt = ^ |                                             |
    | | R; werase = ^W; lnext =  |                                             |
    | | ^V; flush = ^O;          |                                             |
    | |      ...                 |                                             |
    | |      isig icanon iexten  |                                             |
    | | echo echoe echok -echonl |                                             |
    | |  -noflsh -xcase -tostop  |                                             |
    | | -echoprt                 |                                             |
    | |                          |                                             |
    |                                                                          |
    | +--------------------------+--------------------------+----------------- |
    | ---------+                                                               |
    |                                                                          |
    | Using canonical mode, it is possible to redefine the special keys for    |
    | the local terminal line editor.                                          |
    |                                                                          |
    | +--------------------------+--------------------------+----------------- |
    | ---------+                                                               |
    | | .. code:: SCREEN         |                                             |
    | |                          |                                             |
    | |     bash$ cat > filexxx  |                                             |
    | |     wha<ctl-W>I<ctl-H>fo |                                             |
    | | o bar<ctl-U>hello world< |                                             |
    | | ENTER>                   |                                             |
    | |     <ctl-D>              |                                             |
    | |     bash$ cat filexxx    |                                             |
    | |     hello world          |                                             |
    | |     bash$ wc -c < filexx |                                             |
    | | x                        |                                             |
    | |     12                   |                                             |
    | |                          |                                             |
    |                                                                          |
    | +--------------------------+--------------------------+----------------- |
    | ---------+                                                               |
    |                                                                          |
    | The process controlling the terminal receives only 12 characters (11     |
    | alphabetic ones, plus a newline), although the user hit 26 keys.         |
    | In non-canonical ( "raw" ) mode, every key hit (including special        |
    | editing keys such as **ctl-H** ) sends a character immediately to the    |
    | controlling process.                                                     |
    |                                                                          |
    | The Bash prompt disables both ``             icanon            `` and    |
    | ``             echo            `` , since it replaces the basic terminal |
    | line editor with its own more elaborate one. For example, when you hit   |
    | **ctl-A** at the Bash prompt, there's no **^A** echoed by the terminal,  |
    | but Bash gets a **\\1** character, interprets it, and moves the cursor   |
    | to the begining of the line.                                             |
    |                                                                          |
    | *Stéphane Chazelas*                                                      |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </div>                                                                |
                                                                              
    +--------------------------------------------------------------------------+

 **setterm**
    Set certain terminal attributes. This command writes to its
    terminal's ``         stdout        `` a string that changes the
    behavior of that terminal.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ setterm -curso |
    | r off                    |
    |     bash$                |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    The **setterm** command can be used within a script to change the
    appearance of text written to ``         stdout        `` , although
    there are certainly `better tools <colorizing.html#COLORIZINGREF>`__
    available for this purpose.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     setterm -bold on     |
    |     echo bold hello      |
    |                          |
    |     setterm -bold off    |
    |     echo normal hello    |
                              
    +--------------------------+--------------------------+--------------------------+

 **tset**
    Show or initialize terminal settings. This is a less capable version
    of **stty** .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ tset -r        |
    |     Terminal type is xte |
    | rm-xfree86.              |
    |      Kill is control-U ( |
    | ^U).                     |
    |      Interrupt is contro |
    | l-C (^C).                |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **setserial**
    Set or display serial port parameters. This command must be run by
    *root* and is usually found in a system setup script.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # From /etc/pcmcia/s |
    | erial script:            |
    |                          |
    |     IRQ=`setserial /dev/ |
    | $DEVICE | sed -e 's/.*IR |
    | Q: //'`                  |
    |     setserial /dev/$DEVI |
    | CE irq 0 ; setserial /de |
    | v/$DEVICE irq $IRQ       |
                              
    +--------------------------+--------------------------+--------------------------+

 **getty** , **agetty**
    The initialization process for a terminal uses **getty** or
    **agetty** to set it up for login by a user. These commands are not
    used within user shell scripts. Their scripting counterpart is
    **stty** .

 **mesg**
    Enables or disables write access to the current user's terminal.
    Disabling access would prevent another user on the network to
    `write <communications.html#WRITEREF>`__ to the terminal.

    .. raw:: html

       <div class="TIP">

    +--------------------------------------+--------------------------------------+
    | |Tip|                                |
    | It can be quite annoying to have a   |
    | message about ordering pizza         |
    | suddenly appear in the middle of the |
    | text file you are editing. On a      |
    | multi-user network, you might        |
    | therefore wish to disable write      |
    | access to your terminal when you     |
    | need to avoid interruptions.         |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **wall**
    This is an acronym for " `write <communications.html#WRITEREF>`__
    all," i.e., sending a message to all users at every terminal logged
    into the network. It is primarily a system administrator's tool,
    useful, for example, when warning everyone that the system will
    shortly go down due to a problem (see `Example
    19-1 <here-docs.html#EX70>`__ ).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ wall System go |
    | ing down for maintenance |
    |  in 5 minutes!           |
    |     Broadcast message fr |
    | om bozo (pts/1) Sun Jul  |
    |  8 13:53:27 2001...      |
    |                          |
    |      System going down f |
    | or maintenance in 5 minu |
    | tes!                     |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | If write access to a particular      |
    | terminal has been disabled with      |
    | **mesg** , then **wall** cannot send |
    | a message to that terminal.          |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Information and Statistics**

 **uname**
    Output system specifications (OS, kernel version, etc.) to
    ``         stdout        `` . Invoked with the
    ``         -a        `` option, gives verbose system info (see
    `Example 16-5 <moreadv.html#EX41>`__ ). The ``         -s        ``
    option shows only the OS type.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ uname          |
    |     Linux                |
    |                          |
    |     bash$ uname -s       |
    |     Linux                |
    |                          |
    |                          |
    |     bash$ uname -a       |
    |     Linux iron.bozo 2.6. |
    | 15-1.2054_FC5 #1 Tue Mar |
    |  14 15:48:33 EST 2006    |
    |      i686 i686 i386 GNU/ |
    | Linux                    |
                              
    +--------------------------+--------------------------+--------------------------+

 **arch**
    Show system architecture. Equivalent to **uname -m** . See `Example
    11-27 <testbranch.html#CASECMD>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ arch           |
    |     i686                 |
    |                          |
    |     bash$ uname -m       |
    |     i686                 |
                              
    +--------------------------+--------------------------+--------------------------+

 **lastcomm**
    Gives information about previous commands, as stored in the
    ``         /var/account/pacct        `` file. Command name and user
    name can be specified by options. This is one of the GNU accounting
    utilities.

 **lastlog**
    List the last login time of all system users. This references the
    ``         /var/log/lastlog        `` file.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ lastlog        |
    |     root          tty1   |
    |                     Fri  |
    | Dec  7 18:43:21 -0700 20 |
    | 01                       |
    |      bin                 |
    |                      **N |
    | ever logged in**         |
    |      daemon              |
    |                      **N |
    | ever logged in**         |
    |      ...                 |
    |      bozo          tty1  |
    |                      Sat |
    |  Dec  8 21:14:29 -0700 2 |
    | 001                      |
    |                          |
    |                          |
    |                          |
    |     bash$ lastlog | grep |
    |  root                    |
    |     root          tty1   |
    |                     Fri  |
    | Dec  7 18:43:21 -0700 20 |
    | 01                       |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | This command will fail if the user   |
    | invoking it does not have read       |
    | permission for the                   |
    | ``             /var/log/lastlog      |
    |        ``                            |
    | file.                                |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **lsof**
    List open files. This command outputs a detailed table of all
    currently open files and gives information about their owner, size,
    the processes associated with them, and more. Of course, **lsof**
    may be piped to `grep <textproc.html#GREPREF>`__ and/or
    `awk <awk.html#AWKREF>`__ to parse and analyze its results.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ lsof           |
    |     COMMAND    PID    US |
    | ER   FD   TYPE     DEVIC |
    | E    SIZE     NODE NAME  |
    |      init         1    r |
    | oot  mem    REG        3 |
    | ,5   30748    30303 /sbi |
    | n/init                   |
    |      init         1    r |
    | oot  mem    REG        3 |
    | ,5   73120     8069 /lib |
    | /ld-2.1.3.so             |
    |      init         1    r |
    | oot  mem    REG        3 |
    | ,5  931668     8075 /lib |
    | /libc-2.1.3.so           |
    |      cardmgr    213    r |
    | oot  mem    REG        3 |
    | ,5   36956    30357 /sbi |
    | n/cardmgr                |
    |      ...                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    The **lsof** command is a useful, if complex administrative tool. If
    you are unable to dismount a filesystem and get an error message
    that it is still in use, then running *lsof* helps determine which
    files are still open on that filesystem. The ``         -i        ``
    option lists open network socket files, and this can help trace
    intrusion or hack attempts.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ lsof -an -i tc |
    | p                        |
    |     COMMAND  PID USER  F |
    | D  TYPE DEVICE SIZE NODE |
    |  NAME                    |
    |      firefox 2330 bozo   |
    | 32u IPv4   9956       TC |
    | P 66.0.118.137:57596->67 |
    | .112.7.104:http ...      |
    |      firefox 2330 bozo   |
    | 38u IPv4  10535       TC |
    | P 66.0.118.137:57708->21 |
    | 6.79.48.24:http ...      |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    See `Example 30-2 <networkprogramming.html#IPADDRESSES>`__ for an
    effective use of **lsof** .

 **strace**
    **S** ystem **trace** : diagnostic and debugging tool for tracing
    *system calls* and signals. This command and **ltrace** , following,
    are useful for diagnosing why a given program or package fails to
    run . . . perhaps due to missing libraries or related causes.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ strace df      |
    |     execve("/bin/df", [" |
    | df"], [/* 45 vars */]) = |
    |  0                       |
    |      uname({sys="Linux", |
    |  node="bozo.localdomain" |
    | , ...}) = 0              |
    |      brk(0)              |
    |                      = 0 |
    | x804f5e4                 |
    |                          |
    |      ...                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    This is the Linux equivalent of the Solaris **truss** command.

 **ltrace**
    **L** ibrary **trace** : diagnostic and debugging tool that traces
    *library calls* invoked by a given command.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ltrace df      |
    |     __libc_start_main(0x |
    | 804a910, 1, 0xbfb589a4,  |
    | 0x804fb70, 0x804fb68 <un |
    | finished ...>:           |
    |      setlocale(6, "")    |
    |                          |
    |       = "en_US.UTF-8"    |
    |     bindtextdomain("core |
    | utils", "/usr/share/loca |
    | le") = "/usr/share/local |
    | e"                       |
    |     textdomain("coreutil |
    | s")                      |
    |      = "coreutils"       |
    |     __cxa_atexit(0x804b6 |
    | 50, 0, 0, 0x8052bf0, 0xb |
    | fb58908) = 0             |
    |     getenv("DF_BLOCK_SIZ |
    | E")                      |
    |      = NULL              |
    |                          |
    |      ...                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **nc**
    The **nc** ( *netcat* ) utility is a complete toolkit for connecting
    to and listening to TCP and UDP ports. It is useful as a diagnostic
    and testing tool and as a component in simple script-based HTTP
    clients and servers.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ nc localhost.l |
    | ocaldomain 25            |
    |     220 localhost.locald |
    | omain ESMTP Sendmail 8.1 |
    | 3.1/8.13.1;              |
    |      Thu, 31 Mar 2005 15 |
    | :41:35 -0700             |
                              
    +--------------------------+--------------------------+--------------------------+

    A real-life `usage example <process-sub.html#NETCATEXAMPLE>`__ .

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-5. Checking a remote server for *identd***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #! /bin/sh           |
    |     ## Duplicate DaveG's |
    |  ident-scan thingie usin |
    | g netcat. Oooh, he'll be |
    |  p*ssed.                 |
    |     ## Args: target port |
    |  [port port port ...]    |
    |     ## Hose stdout _and_ |
    |  stderr together.        |
    |     ##                   |
    |     ##  Advantages: runs |
    |  slower than ident-scan, |
    |  giving remote inetd les |
    | s cause                  |
    |     ##+ for alarm, and o |
    | nly hits the few known d |
    | aemon ports you specify. |
    |     ##  Disadvantages: r |
    | equires numeric-only por |
    | t args, the output sleaz |
    | itude,                   |
    |     ##+ and won't work f |
    | or r-services when comin |
    | g from high source ports |
    | .                        |
    |     # Script author: Hob |
    | bit <hobbit@avian.org>   |
    |     # Used in ABS Guide  |
    | with permission.         |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | ---------                |
    |     E_BADARGS=65       # |
    |  Need at least two args. |
    |     TWO_WINKS=2        # |
    |  How long to sleep.      |
    |     THREE_WINKS=3        |
    |     IDPORT=113         # |
    |  Authentication "tap ide |
    | nt" port.                |
    |     RAND1=999            |
    |     RAND2=31337          |
    |     TIMEOUT0=9           |
    |     TIMEOUT1=8           |
    |     TIMEOUT2=4           |
    |     # ------------------ |
    | ------------------------ |
    | ---------                |
    |                          |
    |     case "${2}" in       |
    |       "" ) echo "Need HO |
    | ST and at least one PORT |
    | ." ; exit $E_BADARGS ;;  |
    |     esac                 |
    |                          |
    |     # Ping 'em once and  |
    | see if they *are* runnin |
    | g identd.                |
    |     nc -z -w $TIMEOUT0 " |
    | $1" $IDPORT || \         |
    |     { echo "Oops, $1 isn |
    | 't running identd." ; ex |
    | it 0 ; }                 |
    |     #  -z scans for list |
    | ening daemons.           |
    |     #     -w $TIMEOUT =  |
    | How long to try to conne |
    | ct.                      |
    |                          |
    |     # Generate a randomi |
    | sh base port.            |
    |     RP=`expr $$ % $RAND1 |
    |  + $RAND2`               |
    |                          |
    |     TRG="$1"             |
    |     shift                |
    |                          |
    |     while test "$1" ; do |
    |       nc -v -w $TIMEOUT1 |
    |  -p ${RP} "$TRG" ${1} <  |
    | /dev/null > /dev/null &  |
    |       PROC=$!            |
    |       sleep $THREE_WINKS |
    |       echo "${1},${RP}"  |
    | | nc -w $TIMEOUT2 -r "$T |
    | RG" $IDPORT 2>&1         |
    |       sleep $TWO_WINKS   |
    |                          |
    |     # Does this look lik |
    | e a lamer script or what |
    |  . . . ?                 |
    |     # ABS Guide author c |
    | omments: "Ain't really a |
    | ll that bad . . .        |
    |     #+                   |
    |           kinda clever,  |
    | actually."               |
    |                          |
    |       kill -HUP $PROC    |
    |       RP=`expr ${RP} + 1 |
    | `                        |
    |       shift              |
    |     done                 |
    |                          |
    |     exit $?              |
    |                          |
    |     #  Notes:            |
    |     #  -----             |
    |                          |
    |     #  Try commenting ou |
    | t line 30 and running th |
    | is script                |
    |     #+ with "localhost.l |
    | ocaldomain 25" as argume |
    | nts.                     |
    |                          |
    |     #  For more of Hobbi |
    | t's 'nc' example scripts |
    | ,                        |
    |     #+ look in the docum |
    | entation:                |
    |     #+ the /usr/share/do |
    | c/nc-X.XX/scripts direct |
    | ory.                     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    And, of course, there's Dr. Andrew Tridgell's notorious one-line
    script in the BitKeeper Affair:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo clone | nc thun |
    | k.org 5000 > e2fsprogs.d |
    | at                       |
                              
    +--------------------------+--------------------------+--------------------------+

 **free**
    Shows memory and cache usage in tabular form. The output of this
    command lends itself to parsing, using
    `grep <textproc.html#GREPREF>`__ , `awk <awk.html#AWKREF>`__ or
    **Perl** . The **procinfo** command shows all the information that
    **free** does, and much more.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ free           |
    |                     tota |
    | l       used       free  |
    |     shared    buffers    |
    |   cached                 |
    |        Mem:         3050 |
    | 4      28624       1880  |
    |      15820       1608    |
    |     16376                |
    |        -/+ buffers/cache |
    | :      10640      19864  |
    |        Swap:        6854 |
    | 0       3128      65412  |
                              
    +--------------------------+--------------------------+--------------------------+

    To show unused RAM memory:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ free | grep Me |
    | m | awk '{ print $4 }'   |
    |     1880                 |
                              
    +--------------------------+--------------------------+--------------------------+

 **procinfo**
    Extract and list information and statistics from the
    ```          /proc         ``
    pseudo-filesystem <devproc.html#DEVPROCREF>`__ . This gives a very
    extensive and detailed listing.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ procinfo | gre |
    | p Bootup                 |
    |     Bootup: Wed Mar 21 1 |
    | 5:15:50 2001    Load ave |
    | rage: 0.04 0.21 0.34 3/4 |
    | 7 6829                   |
                              
    +--------------------------+--------------------------+--------------------------+

 **lsdev**
    List devices, that is, show installed hardware.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ lsdev          |
    |     Device            DM |
    | A   IRQ  I/O Ports       |
    |      ------------------- |
    | ------------------------ |
    | -----                    |
    |      cascade             |
    |  4     2                 |
    |      dma                 |
    |           0080-008f      |
    |      dma1                |
    |           0000-001f      |
    |      dma2                |
    |           00c0-00df      |
    |      fpu                 |
    |           00f0-00ff      |
    |      ide0                |
    |       14  01f0-01f7 03f6 |
    | -03f6                    |
    |      ...                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **du**
    Show (disk) file usage, recursively. Defaults to current working
    directory, unless otherwise specified.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ du -ach        |
    |     1.0k    ./wi.sh      |
    |      1.0k    ./tst.sh    |
    |      1.0k    ./random.fi |
    | le                       |
    |      6.0k    .           |
    |      6.0k    total       |
                              
    +--------------------------+--------------------------+--------------------------+

 **df**
    Shows filesystem usage in tabular form.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ df             |
    |     Filesystem           |
    |  1k-blocks      Used Ava |
    | ilable Use% Mounted on   |
    |      /dev/hda5           |
    |      273262     92607    |
    |  166547  36% /           |
    |      /dev/hda8           |
    |      222525    123951    |
    |   87085  59% /home       |
    |      /dev/hda7           |
    |     1408796   1075744    |
    |  261488  80% /usr        |
                              
    +--------------------------+--------------------------+--------------------------+

 **dmesg**
    Lists all system bootup messages to ``         stdout        `` .
    Handy for debugging and ascertaining which device drivers were
    installed and which system interrupts in use. The output of
    **dmesg** may, of course, be parsed with
    `grep <textproc.html#GREPREF>`__ , `sed <sedawk.html#SEDREF>`__ , or
    `awk <awk.html#AWKREF>`__ from within a script.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ dmesg | grep h |
    | da                       |
    |     Kernel command line: |
    |  ro root=/dev/hda2       |
    |      hda: IBM-DLGA-23080 |
    | , ATA DISK drive         |
    |      hda: 6015744 sector |
    | s (3080 MB) w/96KiB Cach |
    | e, CHS=746/128/63        |
    |      hda: hda1 hda2 hda3 |
    |  < hda5 hda6 hda7 > hda4 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **stat**
    Gives detailed and verbose *stat* istics on a given file (even a
    directory or device file) or set of files.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ stat test.cru  |
    |       File: "test.cru"   |
    |        Size: 49970       |
    |   Allocated Blocks: 100  |
    |          Filetype: Regul |
    | ar File                  |
    |        Mode: (0664/-rw-r |
    | w-r--)         Uid: (  5 |
    | 01/ bozo)  Gid: (  501/  |
    | bozo)                    |
    |      Device:  3,8   Inod |
    | e: 18185     Links: 1    |
    |                          |
    |      Access: Sat Jun  2  |
    | 16:40:24 2001            |
    |      Modify: Sat Jun  2  |
    | 16:40:24 2001            |
    |      Change: Sat Jun  2  |
    | 16:40:24 2001            |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    If the target file does not exist, **stat** returns an error
    message.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ stat nonexiste |
    | nt-file                  |
    |     nonexistent-file: No |
    |  such file or directory  |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    In a script, you can use **stat** to extract information about files
    (and filesystems) and set variables accordingly.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # fileinfo2.sh       |
    |                          |
    |     # Per suggestion of  |
    | Joël Bourquard and . . . |
    |     # http://www.linuxqu |
    | estions.org/questions/sh |
    | owthread.php?t=410766    |
    |                          |
    |                          |
    |     FILENAME=testfile.tx |
    | t                        |
    |     file_name=$(stat -c% |
    | n "$FILENAME")   # Same  |
    | as "$FILENAME" of course |
    | .                        |
    |     file_owner=$(stat -c |
    | %U "$FILENAME")          |
    |     file_size=$(stat -c% |
    | s "$FILENAME")           |
    |     #  Certainly easier  |
    | than using "ls -l $FILEN |
    | AME"                     |
    |     #+ and then parsing  |
    | with sed.                |
    |     file_inode=$(stat -c |
    | %i "$FILENAME")          |
    |     file_type=$(stat -c% |
    | F "$FILENAME")           |
    |     file_access_rights=$ |
    | (stat -c%A "$FILENAME")  |
    |                          |
    |     echo "File name:     |
    |       $file_name"        |
    |     echo "File owner:    |
    |       $file_owner"       |
    |     echo "File size:     |
    |       $file_size"        |
    |     echo "File inode:    |
    |       $file_inode"       |
    |     echo "File type:     |
    |       $file_type"        |
    |     echo "File access ri |
    | ghts: $file_access_right |
    | s"                       |
    |                          |
    |     exit 0               |
    |                          |
    |     sh fileinfo2.sh      |
    |                          |
    |     File name:           |
    | testfile.txt             |
    |     File owner:          |
    | bozo                     |
    |     File size:           |
    | 418                      |
    |     File inode:          |
    | 1730378                  |
    |     File type:           |
    | regular file             |
    |     File access rights:  |
    | -rw-rw-r--               |
                              
    +--------------------------+--------------------------+--------------------------+

 **vmstat**
    Display virtual memory statistics.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ vmstat         |
    |        procs             |
    |           memory    swap |
    |           io system      |
    |     cpu                  |
    |      r  b  w   swpd   fr |
    | ee   buff  cache  si  so |
    |     bi    bo   in    cs  |
    |  us  sy id               |
    |      0  0  0      0  110 |
    | 40   2636  38952   0   0 |
    |     33     7  271    88  |
    |   8   3 89               |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **uptime**
    Shows how long the system has been running, along with associated
    statistics.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ uptime         |
    |     10:28pm  up  1:57,   |
    | 3 users,  load average:  |
    | 0.17, 0.34, 0.27         |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | A *load average* of 1 or less        |
    | indicates that the system handles    |
    | processes immediately. A load        |
    | average greater than 1 means that    |
    | processes are being queued. When the |
    | load average gets above 3 (on a      |
    | single-core processor), then system  |
    | performance is significantly         |
    | degraded.                            |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **hostname**
    Lists the system's host name. This command sets the host name in an
    ``         /etc/rc.d        `` setup script (
    ``         /etc/rc.d/rc.sysinit        `` or similar). It is
    equivalent to **uname -n** , and a counterpart to the
    `$HOSTNAME <internalvariables.html#HOSTNAMEREF>`__ internal
    variable.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ hostname       |
    |     localhost.localdomai |
    | n                        |
    |                          |
    |     bash$ echo $HOSTNAME |
    |     localhost.localdomai |
    | n                        |
                              
    +--------------------------+--------------------------+--------------------------+

    Similar to the **hostname** command are the **domainname** ,
    **dnsdomainname** , **nisdomainname** , and **ypdomainname**
    commands. Use these to display or set the system DNS or NIS/YP
    domain name. Various options to **hostname** also perform these
    functions.

 **hostid**
    Echo a 32-bit hexadecimal numerical identifier for the host machine.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ hostid         |
    |     7f0100               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------+--------------+--------------+--------------+--------------+--------------+
    | |Note|       |
    | This command |
    | allegedly    |
    | fetches a    |
    | "unique"     |
    | serial       |
    | number for a |
    | particular   |
    | system.      |
    | Certain      |
    | product      |
    | registration |
    | procedures   |
    | use this     |
    | number to    |
    | brand a      |
    | particular   |
    | user         |
    | license.     |
    | Unfortunatel |
    | y,           |
    | **hostid**   |
    | only returns |
    | the machine  |
    | network      |
    | address in   |
    | hexadecimal, |
    | with pairs   |
    | of bytes     |
    | transposed.  |
    |              |
    | The network  |
    | address of a |
    | typical      |
    | non-networke |
    | d            |
    | Linux        |
    | machine, is  |
    | found in     |
    | ``           |
    |    /etc/host |
    | s            |
    |  ``          |
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
    | SCREEN       |
    |    |         |
    | |            |
    |              |
    |    |         |
    | |     bash$  |
    | cat /etc/hos |
    | ts |         |
    | |     127.0. |
    | 0.1          |
    |    |         |
    | |     localh |
    | ost.localdom |
    | ai |         |
    | | n localhos |
    | t            |
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
    | As it        |
    | happens,     |
    | transposing  |
    | the bytes of |
    | ``           |
    |              |
    |      127.0.0 |
    | .1           |
    |              |
    |    ``        |
    | , we get     |
    | ``           |
    |              |
    |      0.127.1 |
    | .0           |
    |              |
    |    ``        |
    | , which      |
    | translates   |
    | in hex to    |
    | ``           |
    |              |
    |      007f010 |
    | 0            |
    |              |
    |   ``         |
    | , the exact  |
    | equivalent   |
    | of what      |
    | **hostid**   |
    | returns,     |
    | above. There |
    | exist only a |
    | few million  |
    | other Linux  |
    | machines     |
    | with this    |
    | identical    |
    | *hostid* .   |
    +--------------+--------------+--------------+--------------+--------------+--------------+

    .. raw:: html

       </div>

 **sar**
    Invoking **sar** (System Activity Reporter) gives a very detailed
    rundown on system statistics. The Santa Cruz Operation ( "Old" SCO)
    released **sar** as Open Source in June, 1999.

    This command is not part of the base Linux distribution, but may be
    obtained as part of the `sysstat
    utilities <http://perso.wanadoo.fr/sebastien.godard/>`__ package,
    written by `Sebastien Godard <mailto:sebastien.godard@wanadoo.fr>`__
    .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ sar            |
    |     Linux 2.4.9 (brooks. |
    | seringas.fr)     09/26/0 |
    | 3                        |
    |                          |
    |     10:30:00          CP |
    | U     %user     %nice    |
    | %system   %iowait     %i |
    | dle                      |
    |     10:40:00          al |
    | l      2.21     10.90    |
    |   65.48      0.00     21 |
    | .41                      |
    |     10:50:00          al |
    | l      3.36      0.00    |
    |   72.36      0.00     24 |
    | .28                      |
    |     11:00:00          al |
    | l      1.12      0.00    |
    |   80.77      0.00     18 |
    | .11                      |
    |     Average:          al |
    | l      2.23      3.63    |
    |   72.87      0.00     21 |
    | .27                      |
    |                          |
    |     14:32:30          LI |
    | NUX RESTART              |
    |                          |
    |     15:00:00          CP |
    | U     %user     %nice    |
    | %system   %iowait     %i |
    | dle                      |
    |     15:10:00          al |
    | l      8.59      2.40    |
    |   17.47      0.00     71 |
    | .54                      |
    |     15:20:00          al |
    | l      4.07      1.00    |
    |   11.95      0.00     82 |
    | .98                      |
    |     15:30:00          al |
    | l      0.79      2.94    |
    |    7.56      0.00     88 |
    | .71                      |
    |     Average:          al |
    | l      6.33      1.70    |
    |   14.71      0.00     77 |
    | .26                      |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **readelf**
    Show information and statistics about a designated *elf* binary.
    This is part of the *binutils* package.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ readelf -h /bi |
    | n/bash                   |
    |     ELF Header:          |
    |        Magic:   7f 45 4c |
    |  46 01 01 01 00 00 00 00 |
    |  00 00 00 00 00          |
    |        Class:            |
    |                   ELF32  |
    |        Data:             |
    |                   2's co |
    | mplement, little endian  |
    |        Version:          |
    |                   1 (cur |
    | rent)                    |
    |        OS/ABI:           |
    |                   UNIX - |
    |  System V                |
    |        ABI Version:      |
    |                   0      |
    |        Type:             |
    |                   EXEC ( |
    | Executable file)         |
    |        . . .             |
                              
    +--------------------------+--------------------------+--------------------------+

 **size**
    The **size [/path/to/binary]** command gives the segment sizes of a
    binary executable or archive file. This is mainly of use to
    programmers.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ size /bin/bash |
    |        text    data      |
    | bss     dec     hex file |
    | name                     |
    |       495971   22496   1 |
    | 7392  535859   82d33 /bi |
    | n/bash                   |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** System Logs**

 **logger**
    Appends a user-generated message to the system log (
    ``         /var/log/messages        `` ). You do not have to be
    *root* to invoke **logger** .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     logger Experiencing  |
    | instability in network c |
    | onnection at 23:10, 05/2 |
    | 1.                       |
    |     # Now, do a 'tail /v |
    | ar/log/messages'.        |
                              
    +--------------------------+--------------------------+--------------------------+

    By embedding a **logger** command in a script, it is possible to
    write debugging information to
    ``         /var/log/messages        `` .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     logger -t $0 -i Logg |
    | ing at line "$LINENO".   |
    |     # The "-t" option sp |
    | ecifies the tag for the  |
    | logger entry.            |
    |     # The "-i" option re |
    | cords the process ID.    |
    |                          |
    |     # tail /var/log/mess |
    | age                      |
    |     # ...                |
    |     # Jul  7 20:48:58 lo |
    | calhost ./test.sh[1712]: |
    |  Logging at line 3.      |
                              
    +--------------------------+--------------------------+--------------------------+

 **logrotate**
    This utility manages the system log files, rotating, compressing,
    deleting, and/or e-mailing them, as appropriate. This keeps the
    ``         /var/log        `` from getting cluttered with old log
    files. Usually `cron <system.html#CRONREF>`__ runs **logrotate** on
    a daily basis.

    Adding an appropriate entry to
    ``         /etc/logrotate.conf        `` makes it possible to manage
    personal log files, as well as system-wide ones.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Stefano Falsetto has created         |
    | `rottlog <http://www.gnu.org/softwar |
    | e/rottlog/>`__                       |
    | , which he considers to be an        |
    | improved version of **logrotate** .  |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Job Control**

 **ps**
    ``                   P                 `` rocess
    ``                   S                 `` tatistics: lists currently
    executing processes by owner and PID (process ID). This is usually
    invoked with ``         ax        `` or ``         aux        ``
    options, and may be piped to `grep <textproc.html#GREPREF>`__ or
    `sed <sedawk.html#SEDREF>`__ to search for a specific process (see
    `Example 15-14 <internal.html#EX44>`__ and `Example
    29-3 <procref1.html#PIDID>`__ ).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$  ps ax | grep  |
    | sendmail                 |
    |     295 ?       S      0 |
    | :00 sendmail: accepting  |
    | connections on port 25   |
                              
    +--------------------------+--------------------------+--------------------------+

    To display system processes in graphical "tree" format: **ps afjx**
    or **ps ax --forest** .

 **pgrep** , **pkill**
    Combining the **ps** command with `grep <textproc.html#GREPREF>`__
    or `kill <x9644.html#KILLREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ps a | grep mi |
    | ngetty                   |
    |     2212 tty2     Ss+    |
    |  0:00 /sbin/mingetty tty |
    | 2                        |
    |      2213 tty3     Ss+   |
    |   0:00 /sbin/mingetty tt |
    | y3                       |
    |      2214 tty4     Ss+   |
    |   0:00 /sbin/mingetty tt |
    | y4                       |
    |      2215 tty5     Ss+   |
    |   0:00 /sbin/mingetty tt |
    | y5                       |
    |      2216 tty6     Ss+   |
    |   0:00 /sbin/mingetty tt |
    | y6                       |
    |      4849 pts/2    S+    |
    |   0:00 grep mingetty     |
    |                          |
    |                          |
    |     bash$ pgrep mingetty |
    |     2212 mingetty        |
    |      2213 mingetty       |
    |      2214 mingetty       |
    |      2215 mingetty       |
    |      2216 mingetty       |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    Compare the action of **pkill** with
    `killall <x9644.html#KILLALLREF>`__ .

 **pstree**
    Lists currently executing processes in "tree" format. The
    ``         -p        `` option shows the PIDs, as well as the
    process names.

 **top**
    Continuously updated display of most cpu-intensive processes. The
    ``         -b        `` option displays in text mode, so that the
    output may be parsed or accessed from a script.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ top -b         |
    |       8:30pm  up 3 min,  |
    |  3 users,  load average: |
    |  0.49, 0.32, 0.13        |
    |      45 processes: 44 sl |
    | eeping, 1 running, 0 zom |
    | bie, 0 stopped           |
    |      CPU states: 13.6% u |
    | ser,  7.3% system,  0.0% |
    |  nice, 78.9% idle        |
    |      Mem:    78396K av,  |
    |   65468K used,   12928K  |
    | free,       0K shrd,     |
    | 2352K buff               |
    |      Swap:  157208K av,  |
    |       0K used,  157208K  |
    | free                   3 |
    | 7244K cached             |
    |                          |
    |        PID USER     PRI  |
    |  NI  SIZE  RSS SHARE STA |
    | T %CPU %MEM   TIME COMMA |
    | ND                       |
    |        848 bozo      17  |
    |   0   996  996   800 R   |
    |    5.6  1.2   0:00 top   |
    |          1 root       8  |
    |   0   512  512   444 S   |
    |    0.0  0.6   0:04 init  |
    |          2 root       9  |
    |   0     0    0     0 SW  |
    |    0.0  0.0   0:00 keven |
    | td                       |
    |        ...               |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **nice**

    Run a background job with an altered priority. Priorities run from
    19 (lowest) to -20 (highest). Only *root* may set the negative
    (higher) priorities. Related commands are **renice** and **snice** ,
    which change the priority of a running process or processes, and
    **skill** , which sends a `kill <x9644.html#KILLREF>`__ signal to a
    process or processes.

 **nohup**
    Keeps a command running even after user logs off. The command will
    run as a foreground process unless followed by & . If you use
    **nohup** within a script, consider coupling it with a
    `wait <x9644.html#WAITREF>`__ to avoid creating an *orphan* or
    `zombie <x9644.html#ZOMBIEREF>`__ process.

 **pidof**
    Identifies *process ID (PID)* of a running job. Since job control
    commands, such as `kill <x9644.html#KILLREF>`__ and
    `renice <system.html#NICE2REF>`__ act on the *PID* of a process (not
    its name), it is sometimes necessary to identify that *PID* . The
    **pidof** command is the approximate counterpart to the
    `$PPID <internalvariables.html#PPIDREF>`__ internal variable.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ pidof xclock   |
    |     880                  |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-6. *pidof* helps kill a process**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # kill-process.sh    |
    |                          |
    |     NOPROCESS=2          |
    |                          |
    |     process=xxxyyyzzz  # |
    |  Use nonexistent process |
    | .                        |
    |     # For demo purposes  |
    | only...                  |
    |     # ... don't want to  |
    | actually kill any actual |
    |  process with this scrip |
    | t.                       |
    |     #                    |
    |     # If, for example, y |
    | ou wanted to use this sc |
    | ript to logoff the Inter |
    | net,                     |
    |     #     process=pppd   |
    |                          |
    |     t=`pidof $process`   |
    |      # Find pid (process |
    |  id) of $process.        |
    |     # The pid is needed  |
    | by 'kill' (can't 'kill'  |
    | by program name).        |
    |                          |
    |     if [ -z "$t" ]       |
    |      # If process not pr |
    | esent, 'pidof' returns n |
    | ull.                     |
    |     then                 |
    |       echo "Process $pro |
    | cess was not running."   |
    |       echo "Nothing kill |
    | ed."                     |
    |       exit $NOPROCESS    |
    |     fi                   |
    |                          |
    |     kill $t              |
    |      # May need 'kill -9 |
    | ' for stubborn process.  |
    |                          |
    |     # Need a check here  |
    | to see if process allowe |
    | d itself to be killed.   |
    |     # Perhaps another "  |
    | t=`pidof $process` " or  |
    | ...                      |
    |                          |
    |                          |
    |     # This entire script |
    |  could be replaced by    |
    |     #        kill $(pido |
    | f -x process_name)       |
    |     # or                 |
    |     #        killall pro |
    | cess_name                |
    |     # but it would not b |
    | e as instructive.        |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **fuser**
    Identifies the processes (by PID) that are accessing a given file,
    set of files, or directory. May also be invoked with the
    ``         -k        `` option, which kills those processes. This
    has interesting implications for system security, especially in
    scripts preventing unauthorized users from accessing system
    services.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ fuser -u /usr/ |
    | bin/vim                  |
    |     /usr/bin/vim:        |
    |   3207e(bozo)            |
    |                          |
    |                          |
    |                          |
    |     bash$ fuser -u /dev/ |
    | null                     |
    |     /dev/null:           |
    |   3009(bozo)  3010(bozo) |
    |   3197(bozo)  3199(bozo) |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    One important application for **fuser** is when physically inserting
    or removing storage media, such as CD ROM disks or USB flash drives.
    Sometimes trying a `umount <system.html#UMOUNTREF>`__ fails with a
    device is busy error message. This means that some user(s) and/or
    process(es) are accessing the device. An **fuser -um
    /dev/device\_name** will clear up the mystery, so you can kill any
    relevant processes.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ umount /mnt/us |
    | bdrive                   |
    |     umount: /mnt/usbdriv |
    | e: device is busy        |
    |                          |
    |                          |
    |                          |
    |     bash$ fuser -um /dev |
    | /usbdrive                |
    |     /mnt/usbdrive:       |
    |   1772c(bozo)            |
    |                          |
    |     bash$ kill -9 1772   |
    |     bash$ umount /mnt/us |
    | bdrive                   |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    The **fuser** command, invoked with the ``         -n        ``
    option identifies the processes accessing a *port* . This is
    especially useful in combination with `nmap <system.html#NMAPREF>`__
    .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     root# nmap localhost |
    | .localdomain             |
    |     PORT     STATE SERVI |
    | CE                       |
    |      25/tcp   open  smtp |
    |                          |
    |                          |
    |                          |
    |     root# fuser -un tcp  |
    | 25                       |
    |     25/tcp:              |
    |   2095(root)             |
    |                          |
    |     root# ps ax | grep 2 |
    | 095 | grep -v grep       |
    |     2095 ?        Ss     |
    |  0:00 sendmail: acceptin |
    | g connections            |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **cron**
    Administrative program scheduler, performing such duties as cleaning
    up and deleting system log files and updating the slocate database.
    This is the *superuser* version of `at <timedate.html#ATREF>`__
    (although each user may have their own ``         crontab        ``
    file which can be changed with the **crontab** command). It runs as
    a `daemon <communications.html#DAEMONREF>`__ and executes scheduled
    entries from ``         /etc/crontab        `` .

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Some flavors of Linux run **crond**  |
    | , Matthew Dillon's version of        |
    | **cron** .                           |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Process Control and Booting**

 **init**

    The **init** command is the `parent <internal.html#FORKREF>`__ of
    all processes. Called in the final step of a bootup, **init**
    determines the runlevel of the system from
    ``         /etc/inittab        `` . Invoked by its alias **telinit**
    , and by *root* only.

 **telinit**
    Symlinked to **init** , this is a means of changing the system
    runlevel, usually done for system maintenance or emergency
    filesystem repairs. Invoked only by *root* . This command can be
    dangerous -- be certain you understand it well before using!

 **runlevel**
    Shows the current and last runlevel, that is, whether the system is
    halted (runlevel ``         0        `` ), in single-user mode (
    ``         1        `` ), in multi-user mode (
    ``         2        `` or ``         3        `` ), in X Windows (
    ``         5        `` ), or rebooting ( ``         6        `` ).
    This command accesses the ``         /var/run/utmp        `` file.

 **halt** , **shutdown** , **reboot**
    Command set to shut the system down, usually just prior to a power
    down.

    .. raw:: html

       <div class="WARNING">

    +--------------------------------------+--------------------------------------+
    | |Warning|                            |
    | On some Linux distros, the **halt**  |
    | command has 755 permissions, so it   |
    | can be invoked by a non-root user. A |
    | careless *halt* in a terminal or a   |
    | script may shut down the system!     |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **service**
    Starts or stops a system *service* . The startup scripts in
    ``         /etc/init.d        `` and ``         /etc/rc.d        ``
    use this command to start services at bootup.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     root# /sbin/service  |
    | iptables stop            |
    |     Flushing firewall ru |
    | les:                     |
    |                [  OK  ]  |
    |      Setting chains to p |
    | olicy ACCEPT: filter     |
    |                 [  OK  ] |
    |      Unloading iptables  |
    | modules:                 |
    |                 [  OK  ] |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Network**

 **nmap**
    **N** etwork **map** per and port scanner. This command scans a
    server to locate open ports and the services associated with those
    ports. It can also report information about packet filters and
    firewalls. This is an important security tool for locking down a
    network against hacking attempts.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     SERVER=$HOST         |
    |                    # loc |
    | alhost.localdomain (127. |
    | 0.0.1).                  |
    |     PORT_NUMBER=25       |
    |                    # SMT |
    | P port.                  |
    |                          |
    |     nmap $SERVER | grep  |
    | -w "$PORT_NUMBER"  # Is  |
    | that particular port ope |
    | n?                       |
    |     #              grep  |
    | -w matches whole words o |
    | nly,                     |
    |     #+             so th |
    | is wouldn't match port 1 |
    | 025, for example.        |
    |                          |
    |     exit 0               |
    |                          |
    |     # 25/tcp     open    |
    |      smtp                |
                              
    +--------------------------+--------------------------+--------------------------+

 **ifconfig**
    Network *interface configuration* and tuning utility.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ifconfig -a    |
    |     lo        Link encap |
    | :Local Loopback          |
    |                inet addr |
    | :127.0.0.1  Mask:255.0.0 |
    | .0                       |
    |                UP LOOPBA |
    | CK RUNNING  MTU:16436  M |
    | etric:1                  |
    |                RX packet |
    | s:10 errors:0 dropped:0  |
    | overruns:0 frame:0       |
    |                TX packet |
    | s:10 errors:0 dropped:0  |
    | overruns:0 carrier:0     |
    |                collision |
    | s:0 txqueuelen:0         |
    |                RX bytes: |
    | 700 (700.0 b)  TX bytes: |
    | 700 (700.0 b)            |
                              
    +--------------------------+--------------------------+--------------------------+

    The **ifconfig** command is most often used at bootup to set up the
    interfaces, or to shut them down when rebooting.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Code snippets from |
    |  /etc/rc.d/init.d/networ |
    | k                        |
    |                          |
    |     # ...                |
    |                          |
    |     # Check that network |
    | ing is up.               |
    |     [ ${NETWORKING} = "n |
    | o" ] && exit 0           |
    |                          |
    |     [ -x /sbin/ifconfig  |
    | ] || exit 0              |
    |                          |
    |     # ...                |
    |                          |
    |     for i in $interfaces |
    |  ; do                    |
    |       if ifconfig $i 2>/ |
    | dev/null | grep -q "UP"  |
    | >/dev/null 2>&1 ; then   |
    |         action "Shutting |
    |  down interface $i: " ./ |
    | ifdown $i boot           |
    |       fi                 |
    |     #  The GNU-specific  |
    | "-q" option to "grep" me |
    | ans "quiet", i.e.,       |
    |     #+ producing no outp |
    | ut.                      |
    |     #  Redirecting outpu |
    | t to /dev/null is theref |
    | ore not strictly necessa |
    | ry.                      |
    |                          |
    |     # ...                |
    |                          |
    |     echo "Currently acti |
    | ve devices:"             |
    |     echo `/sbin/ifconfig |
    |  | grep ^[a-z] | awk '{p |
    | rint $1}'`               |
    |     #                    |
    |          ^^^^^  should b |
    | e quoted to prevent glob |
    | bing.                    |
    |     #  The following als |
    | o work.                  |
    |     #    echo $(/sbin/if |
    | config | awk '/^[a-z]/ { |
    |  print $1 })'            |
    |     #    echo $(/sbin/if |
    | config | sed -e 's/ .*// |
    | ')                       |
    |     #  Thanks, S.C., for |
    |  additional comments.    |
                              
    +--------------------------+--------------------------+--------------------------+

    See also `Example 32-6 <debugging.html#ONLINE>`__ .

 **netstat**
    Show current network statistics and information, such as routing
    tables and active connections. This utility accesses information in
    ``         /proc/net        `` ( `Chapter 29 <devproc.html>`__ ).
    See `Example 29-4 <procref1.html#CONSTAT>`__ .

    **netstat -r** is equivalent to `route <system.html#ROUTEREF>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ netstat        |
    |     Active Internet conn |
    | ections (w/o servers)    |
    |      Proto Recv-Q Send-Q |
    |  Local Address           |
    |  Foreign Address         |
    |  State                   |
    |      Active UNIX domain  |
    | sockets (w/o servers)    |
    |      Proto RefCnt Flags  |
    |       Type       State   |
    |        I-Node Path       |
    |      unix  11     [ ]    |
    |       DGRAM              |
    |        906    /dev/log   |
    |      unix  3      [ ]    |
    |       STREAM     CONNECT |
    | ED     4514   /tmp/.X11- |
    | unix/X0                  |
    |      unix  3      [ ]    |
    |       STREAM     CONNECT |
    | ED     4513              |
    |      . . .               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | A **netstat -lptu** shows            |
    | `sockets <devref1.html#SOCKETREF>`__ |
    | that are listening to ports, and the |
    | associated processes. This can be    |
    | useful for determining whether a     |
    | computer has been hacked or          |
    | compromised.                         |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **iwconfig**
    This is the command set for configuring a wireless network. It is
    the wireless equivalent of **ifconfig** , above.

 **ip**
    General purpose utility for setting up, changing, and analyzing *IP*
    (Internet Protocol) networks and attached devices. This command is
    part of the *iproute2* package.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ip link show   |
    |     1: lo: <LOOPBACK,UP> |
    |  mtu 16436 qdisc noqueue |
    |                          |
    |          link/loopback 0 |
    | 0:00:00:00:00:00 brd 00: |
    | 00:00:00:00:00           |
    |      2: eth0: <BROADCAST |
    | ,MULTICAST> mtu 1500 qdi |
    | sc pfifo_fast qlen 1000  |
    |          link/ether 00:d |
    | 0:59:ce:af:da brd ff:ff: |
    | ff:ff:ff:ff              |
    |      3: sit0: <NOARP> mt |
    | u 1480 qdisc noop        |
    |          link/sit 0.0.0. |
    | 0 brd 0.0.0.0            |
    |                          |
    |                          |
    |     bash$ ip route list  |
    |     169.254.0.0/16 dev l |
    | o  scope link            |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    Or, in a script:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Script by Juan Nic |
    | olas Ruiz                |
    |     # Used with his kind |
    |  permission.             |
    |                          |
    |     # Setting up (and st |
    | opping) a GRE tunnel.    |
    |                          |
    |                          |
    |     # --- start-tunnel.s |
    | h ---                    |
    |                          |
    |     LOCAL_IP="192.168.1. |
    | 17"                      |
    |     REMOTE_IP="10.0.5.33 |
    | "                        |
    |     OTHER_IFACE="192.168 |
    | .0.100"                  |
    |     REMOTE_NET="192.168. |
    | 3.0/24"                  |
    |                          |
    |     /sbin/ip tunnel add  |
    | netb mode gre remote $RE |
    | MOTE_IP \                |
    |       local $LOCAL_IP tt |
    | l 255                    |
    |     /sbin/ip addr add $O |
    | THER_IFACE dev netb      |
    |     /sbin/ip link set ne |
    | tb up                    |
    |     /sbin/ip route add $ |
    | REMOTE_NET dev netb      |
    |                          |
    |     exit 0  ############ |
    | ######################## |
    | #########                |
    |                          |
    |     # --- stop-tunnel.sh |
    |  ---                     |
    |                          |
    |     REMOTE_NET="192.168. |
    | 3.0/24"                  |
    |                          |
    |     /sbin/ip route del $ |
    | REMOTE_NET dev netb      |
    |     /sbin/ip link set ne |
    | tb down                  |
    |     /sbin/ip tunnel del  |
    | netb                     |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

 **route**
    Show info about or make changes to the kernel routing table.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ route          |
    |     Destination     Gate |
    | way         Genmask      |
    |     Flags   MSS Window   |
    | irtt Iface               |
    |      pm3-67.bozosisp *   |
    |              255.255.255 |
    | .255 UH       40 0       |
    |     0 ppp0               |
    |      127.0.0.0       *   |
    |              255.0.0.0   |
    |      U        40 0       |
    |     0 lo                 |
    |      default         pm3 |
    | -67.bozosisp 0.0.0.0     |
    |      UG       40 0       |
    |     0 ppp0               |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **iptables**
    The **iptables** command set is a packet filtering tool used mainly
    for such security purposes as setting up network firewalls. This is
    a complex tool, and a detailed explanation of its use is beyond the
    scope of this document. `Oskar Andreasson's
    tutorial <http://www.frozentux.net/iptables-tutorial/iptables-tutorial.html>`__
    is a reasonable starting point.

    See also `shutting down *iptables* <system.html#IPTABLES01>`__ and
    `Example 30-2 <networkprogramming.html#IPADDRESSES>`__ .

 **chkconfig**
    Check network and system configuration. This command lists and
    manages the network and system services started at bootup in the
    ``         /etc/rc?.d        `` directory.

    Originally a port from IRIX to Red Hat Linux, **chkconfig** may not
    be part of the core installation of some Linux flavors.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ chkconfig --li |
    | st                       |
    |     atd             0:of |
    | f   1:off   2:off   3:on |
    |     4:on    5:on    6:of |
    | f                        |
    |      rwhod           0:o |
    | ff   1:off   2:off   3:o |
    | ff   4:off   5:off   6:o |
    | ff                       |
    |      ...                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **tcpdump**
    Network packet "sniffer." This is a tool for analyzing and
    troubleshooting traffic on a network by dumping packet headers that
    match specified criteria.

    Dump ip packet traffic between hosts *bozoville* and *caduceus* :

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ tcpdump ip hos |
    | t bozoville and caduceus |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    Of course, the output of **tcpdump** can be parsed with certain of
    the previously discussed `text processing
    utilities <textproc.html#TPCOMMANDLISTING1>`__ .

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Filesystem**

 **mount**
    Mount a filesystem, usually on an external device, such as a floppy
    or CDROM. The file ``         /etc/fstab        `` provides a handy
    listing of available filesystems, partitions, and devices, including
    options, that may be automatically or manually mounted. The file
    ``         /etc/mtab        `` shows the currently mounted
    filesystems and partitions (including the virtual ones, such as
    ``         /proc        `` ).

    **mount -a** mounts all filesystems and partitions listed in
    ``         /etc/fstab        `` , except those with a
    ``         noauto        `` option. At bootup, a startup script in
    ``         /etc/rc.d        `` ( ``         rc.sysinit        `` or
    something similar) invokes this to get everything mounted.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     mount -t iso9660 /de |
    | v/cdrom /mnt/cdrom       |
    |     # Mounts CD ROM. ISO |
    |  9660 is a standard CD R |
    | OM filesystem.           |
    |     mount /mnt/cdrom     |
    |     # Shortcut, if /mnt/ |
    | cdrom listed in /etc/fst |
    | ab                       |
                              
    +--------------------------+--------------------------+--------------------------+

    The versatile *mount* command can even mount an ordinary file on a
    block device, and the file will act as if it were a filesystem.
    *Mount* accomplishes that by associating the file with a `loopback
    device <devref1.html#LOOPBACKREF>`__ . One application of this is to
    mount and examine an ISO9660 filesystem image before burning it onto
    a CDR. ` [3]  <system.html#FTN.AEN16255>`__

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-7. Checking a CD image**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # As root...         |
    |                          |
    |     mkdir /mnt/cdtest  # |
    |  Prepare a mount point,  |
    | if not already there.    |
    |                          |
    |     mount -r -t iso9660  |
    | -o loop cd-image.iso /mn |
    | t/cdtest   # Mount the i |
    | mage.                    |
    |     #                  " |
    | -o loop" option equivale |
    | nt to "losetup /dev/loop |
    | 0"                       |
    |     cd /mnt/cdtest     # |
    |  Now, check the image.   |
    |     ls -alR            # |
    |  List the files in the d |
    | irectory tree there.     |
    |                        # |
    |  And so forth.           |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **umount**
    Unmount a currently mounted filesystem. Before physically removing a
    previously mounted floppy or CDROM disk, the device must be
    **umount** ed, else filesystem corruption may result.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     umount /mnt/cdrom    |
    |     # You may now press  |
    | the eject button and saf |
    | ely remove the disk.     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The **automount** utility, if        |
    | properly installed, can mount and    |
    | unmount floppies or CDROM disks as   |
    | they are accessed or removed. On     |
    | "multispindle" laptops with          |
    | swappable floppy and optical drives, |
    | this can cause problems, however.    |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **gnome-mount**
    The newer Linux distros have deprecated **mount** and **umount** .
    The successor, for command-line mounting of removable storage
    devices, is **gnome-mount** . It can take the
    ``         -d        `` option to mount a `device
    file <devref1.html#DEVFILEREF>`__ by its listing in
    ``         /dev        `` .

    For example, to mount a USB flash drive:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ gnome-mount -d |
    |  /dev/sda1               |
    |     gnome-mount 0.4      |
    |                          |
    |                          |
    |     bash$ df             |
    |     . . .                |
    |      /dev/sda1           |
    |       63584     12034    |
    |   51550  19% /media/disk |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **sync**
    Forces an immediate write of all updated data from buffers to hard
    drive (synchronize drive with buffers). While not strictly
    necessary, a **sync** assures the sys admin or user that the data
    just changed will survive a sudden power failure. In the olden days,
    a ``                   sync;           sync                 ``
    (twice, just to make absolutely sure) was a useful precautionary
    measure before a system reboot.

    At times, you may wish to force an immediate buffer flush, as when
    securely deleting a file (see `Example
    16-61 <extmisc.html#BLOTOUT>`__ ) or when the lights begin to
    flicker.

 **losetup**
    Sets up and configures `loopback
    devices <devref1.html#LOOPBACKREF>`__ .

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-8. Creating a filesystem in a file**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     SIZE=1000000  # 1 me |
    | g                        |
    |                          |
    |     head -c $SIZE < /dev |
    | /zero > file  # Set up f |
    | ile of designated size.  |
    |     losetup /dev/loop0 f |
    | ile           # Set it u |
    | p as loopback device.    |
    |     mke2fs /dev/loop0    |
    |               # Create f |
    | ilesystem.               |
    |     mount -o loop /dev/l |
    | oop0 /mnt     # Mount it |
    | .                        |
    |                          |
    |     # Thanks, S.C.       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **mkswap**
    Creates a swap partition or file. The swap area must subsequently be
    enabled with **swapon** .

 **swapon** , **swapoff**
    Enable / disable swap partitition or file. These commands usually
    take effect at bootup and shutdown.

 **mke2fs**
    Create a Linux *ext2* filesystem. This command must be invoked as
    *root* .

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-9. Adding a new hard drive**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |                          |
    |     # Adding a second ha |
    | rd drive to system.      |
    |     # Software configura |
    | tion. Assumes hardware a |
    | lready mounted.          |
    |     # From an article by |
    |  the author of the ABS G |
    | uide.                    |
    |     # In issue #38 of _L |
    | inux Gazette_, http://ww |
    | w.linuxgazette.com.      |
    |                          |
    |     ROOT_UID=0     # Thi |
    | s script must be run as  |
    | root.                    |
    |     E_NOTROOT=67   # Non |
    | -root exit error.        |
    |                          |
    |     if [ "$UID" -ne "$RO |
    | OT_UID" ]                |
    |     then                 |
    |       echo "Must be root |
    |  to run this script."    |
    |       exit $E_NOTROOT    |
    |     fi                   |
    |                          |
    |     # Use with extreme c |
    | aution!                  |
    |     # If something goes  |
    | wrong, you may wipe out  |
    | your current filesystem. |
    |                          |
    |                          |
    |     NEWDISK=/dev/hdb     |
    |      # Assumes /dev/hdb  |
    | vacant. Check!           |
    |     MOUNTPOINT=/mnt/newd |
    | isk  # Or choose another |
    |  mount point.            |
    |                          |
    |                          |
    |     fdisk $NEWDISK       |
    |     mke2fs -cv $NEWDISK1 |
    |    # Check for bad block |
    | s (verbose output).      |
    |     #  Note:           ^ |
    |      /dev/hdb1, *not* /d |
    | ev/hdb!                  |
    |     mkdir $MOUNTPOINT    |
    |     chmod 777 $MOUNTPOIN |
    | T  # Makes new drive acc |
    | essible to all users.    |
    |                          |
    |                          |
    |     # Now, test ...      |
    |     # mount -t ext2 /dev |
    | /hdb1 /mnt/newdisk       |
    |     # Try creating a dir |
    | ectory.                  |
    |     # If it works, umoun |
    | t it, and proceed.       |
    |                          |
    |     # Final step:        |
    |     # Add the following  |
    | line to /etc/fstab.      |
    |     # /dev/hdb1  /mnt/ne |
    | wdisk  ext2  defaults  1 |
    |  1                       |
    |                          |
    |     exit                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example 17-8 <system.html#CREATEFS>`__ and `Example
    31-3 <zeros.html#RAMDISK>`__ .

 **mkdosfs**
    Create a DOS *FAT* filesystem.

 **tune2fs**
    Tune *ext2* filesystem. May be used to change filesystem parameters,
    such as maximum mount count. This must be invoked as *root* .

    .. raw:: html

       <div class="WARNING">

    +--------------------------------------+--------------------------------------+
    | |Warning|                            |
    | This is an extremely dangerous       |
    | command. Use it at your own risk, as |
    | you may inadvertently destroy your   |
    | filesystem.                          |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **dumpe2fs**
    Dump (list to ``         stdout        `` ) very verbose filesystem
    info. This must be invoked as *root* .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     root# dumpe2fs /dev/ |
    | hda7 | grep 'ount count' |
    |     dumpe2fs 1.19, 13-Ju |
    | l-2000 for EXT2 FS 0.5b, |
    |  95/08/09                |
    |      Mount count:        |
    |        6                 |
    |      Maximum mount count |
    | :      20                |
                              
    +--------------------------+--------------------------+--------------------------+

 **hdparm**
    List or change hard disk parameters. This command must be invoked as
    *root* , and it may be dangerous if misused.

 **fdisk**
    Create or change a partition table on a storage device, usually a
    hard drive. This command must be invoked as *root* .

    .. raw:: html

       <div class="WARNING">

    +--------------------------------------+--------------------------------------+
    | |Warning|                            |
    | Use this command with extreme        |
    | caution. If something goes wrong,    |
    | you may destroy an existing          |
    | filesystem.                          |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **fsck** , **e2fsck** , **debugfs**
    Filesystem check, repair, and debug command set.

    **fsck** : a front end for checking a UNIX filesystem (may invoke
    other utilities). The actual filesystem type generally defaults to
    *ext2* .

    **e2fsck** : ext2 filesystem checker.

    **debugfs** : ext2 filesystem debugger. One of the uses of this
    versatile, but dangerous command is to (attempt to) recover deleted
    files. For advanced users only!

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | All of these should be invoked as    |
    | *root* , and they can damage or      |
    | destroy a filesystem if misused.     |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **badblocks**
    Checks for bad blocks (physical media flaws) on a storage device.
    This command finds use when formatting a newly installed hard drive
    or testing the integrity of backup media. ` [4]
     <system.html#FTN.AEN16504>`__ As an example, **badblocks /dev/fd0**
    tests a floppy disk.

    The **badblocks** command may be invoked destructively (overwrite
    all data) or in non-destructive read-only mode. If *root user* owns
    the device to be tested, as is generally the case, then *root* must
    invoke this command.

 **lsusb** , **usbmodules**
    The **lsusb** command lists all USB (Universal Serial Bus) buses and
    the devices hooked up to them.

    The **usbmodules** command outputs information about the driver
    modules for connected USB devices.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ lsusb          |
    |     Bus 001 Device 001:  |
    | ID 0000:0000             |
    |      Device Descriptor:  |
    |        bLength           |
    |       18                 |
    |        bDescriptorType   |
    |        1                 |
    |        bcdUSB            |
    |     1.00                 |
    |        bDeviceClass      |
    |        9 Hub             |
    |        bDeviceSubClass   |
    |        0                 |
    |        bDeviceProtocol   |
    |        0                 |
    |        bMaxPacketSize0   |
    |        8                 |
    |        idVendor          |
    |   0x0000                 |
    |        idProduct         |
    |   0x0000                 |
    |                          |
    |        . . .             |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **lspci**
    Lists *pci* busses present.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ lspci          |
    |     00:00.0 Host bridge: |
    |  Intel Corporation 82845 |
    |  845                     |
    |      (Brookdale) Chipset |
    |  Host Bridge (rev 04)    |
    |      00:01.0 PCI bridge: |
    |  Intel Corporation 82845 |
    |  845                     |
    |      (Brookdale) Chipset |
    |  AGP Bridge (rev 04)     |
    |      00:1d.0 USB Control |
    | ler: Intel Corporation 8 |
    | 2801CA/CAM USB (Hub #1)  |
    | (rev 02)                 |
    |      00:1d.1 USB Control |
    | ler: Intel Corporation 8 |
    | 2801CA/CAM USB (Hub #2)  |
    | (rev 02)                 |
    |      00:1d.2 USB Control |
    | ler: Intel Corporation 8 |
    | 2801CA/CAM USB (Hub #3)  |
    | (rev 02)                 |
    |      00:1e.0 PCI bridge: |
    |  Intel Corporation 82801 |
    |  Mobile PCI Bridge (rev  |
    | 42)                      |
    |                          |
    |        . . .             |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **mkbootdisk**
    Creates a boot floppy which can be used to bring up the system if,
    for example, the MBR (master boot record) becomes corrupted. Of
    special interest is the ``         --iso        `` option, which
    uses **mkisofs** to create a bootable *ISO9660* filesystem image
    suitable for burning a bootable CDR.

    The **mkbootdisk** command is actually a Bash script, written by
    Erik Troan, in the ``         /sbin        `` directory.

 **mkisofs**
    Creates an *ISO9660* filesystem suitable for a CDR image.

 **chroot**
    CHange ROOT directory. Normally commands are fetched from
    `$PATH <internalvariables.html#PATHREF>`__ , relative to
    ``         /        `` , the default *root directory* . This changes
    the *root* directory to a different one (and also changes the
    working directory to there). This is useful for security purposes,
    for instance when the system administrator wishes to restrict
    certain users, such as those
    `telnetting <communications.html#TELNETREF>`__ in, to a secured
    portion of the filesystem (this is sometimes referred to as
    confining a guest user to a "chroot jail" ). Note that after a
    **chroot** , the execution path for system binaries is no longer
    valid.

    A ``                   chroot /opt                 `` would cause
    references to ``         /usr/bin        `` to be translated to
    ``         /opt/usr/bin        `` . Likewise,
    ``                   chroot /aaa/bbb /bin/ls                 ``
    would redirect future instances of **ls** to
    ``         /aaa/bbb        `` as the base directory, rather than
    ``         /        `` as is normally the case. An **alias XX
    'chroot /aaa/bbb ls'** in a user's
    ```          ~/.bashrc         `` <sample-bashrc.html>`__
    effectively restricts which portion of the filesystem she may run
    command "XX" on.

    The **chroot** command is also handy when running from an emergency
    boot floppy ( **chroot** to ``         /dev/fd0        `` ), or as
    an option to **lilo** when recovering from a system crash. Other
    uses include installation from a different filesystem (an
    `rpm <filearchiv.html#RPMREF>`__ option) or running a readonly
    filesystem from a CD ROM. Invoke only as *root* , and use with care.

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | It might be necessary to copy        |
    | certain system files to a *chrooted* |
    | directory, since the normal          |
    | ``             $PATH            ``   |
    | can no longer be relied upon.        |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **lockfile**
    This utility is part of the **procmail** package (
    `www.procmail.org <http://www.procmail.org>`__ ). It creates a *lock
    file* , a *semaphore* that controls access to a file, device, or
    resource.

    +--------------------------------------------------------------------------+
    | .. raw:: html                                                            |
    |                                                                          |
    |    <div class="SIDEBAR">                                                 |
    |                                                                          |
    |  ``                           Definition:                         `` A   |
    | *semaphore* is a flag or signal. (The usage originated in railroading,   |
    | where a colored flag, lantern, or striped movable arm *semaphore*        |
    | indicated whether a particular track was in use and therefore            |
    | unavailable for another train.) A UNIX process can check the appropriate |
    | semaphore to determine whether a particular resource is                  |
    | available/accessible.                                                    |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </div>                                                                |
                                                                              
    +--------------------------------------------------------------------------+

    The lock file serves as a flag that this particular file, device, or
    resource is in use by a process (and is therefore "busy" ). The
    presence of a lock file permits only restricted access (or no
    access) to other processes.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     lockfile /home/bozo/ |
    | lockfiles/$0.lock        |
    |     # Creates a write-pr |
    | otected lockfile prefixe |
    | d with the name of the s |
    | cript.                   |
    |                          |
    |     lockfile /home/bozo/ |
    | lockfiles/${0##*/}.lock  |
    |     # A safer version of |
    |  the above, as pointed o |
    | ut by E. Choroba.        |
                              
    +--------------------------+--------------------------+--------------------------+

    Lock files are used in such applications as protecting system mail
    folders from simultaneously being changed by multiple users,
    indicating that a modem port is being accessed, and showing that an
    instance of Firefox is using its cache. Scripts may check for the
    existence of a lock file created by a certain process to check if
    that process is running. Note that if a script attempts to create a
    lock file that already exists, the script will likely hang.

    Normally, applications create and check for lock files in the
    ``         /var/lock        `` directory. ` [5]
     <system.html#FTN.AEN16659>`__ A script can test for the presence of
    a lock file by something like the following.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     appname=xyzip        |
    |     # Application "xyzip |
    | " created lock file "/va |
    | r/lock/xyzip.lock".      |
    |                          |
    |     if [ -e "/var/lock/$ |
    | appname.lock" ]          |
    |     then   #+ Prevent ot |
    | her programs & scripts   |
    |            #  from acces |
    | sing files/resources use |
    | d by xyzip.              |
    |       ...                |
                              
    +--------------------------+--------------------------+--------------------------+

 **flock**
    Much less useful than the **lockfile** command is **flock** . It
    sets an "advisory" lock on a file and then executes a command while
    the lock is on. This is to prevent any other process from setting a
    lock on that file until completion of the specified command.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     flock $0 cat $0 > lo |
    | ckfile__$0               |
    |     #  Set a lock on the |
    |  script the above line a |
    | ppears in,               |
    |     #+ while listing the |
    |  script to stdout.       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Unlike **lockfile** , **flock** does |
    | *not* automatically create a lock    |
    | file.                                |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **mknod**
    Creates block or character `device
    files <devref1.html#DEVFILEREF>`__ (may be necessary when installing
    new hardware on the system). The **MAKEDEV** utility has virtually
    all of the functionality of **mknod** , and is easier to use.

 **MAKEDEV**
    Utility for creating device files. It must be run as *root* , and in
    the ``         /dev        `` directory. It is a sort of advanced
    version of **mknod** .

 **tmpwatch**
    Automatically deletes files which have not been accessed within a
    specified period of time. Usually invoked by
    `cron <system.html#CRONREF>`__ to remove stale log files.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Backup**

 **dump** , **restore**
    The **dump** command is an elaborate filesystem backup utility,
    generally used on larger installations and networks. ` [6]
     <system.html#FTN.AEN16748>`__ It reads raw disk partitions and
    writes a backup file in a binary format. Files to be backed up may
    be saved to a variety of storage media, including disks and tape
    drives. The **restore** command restores backups made with **dump**
    .

 **fdformat**
    Perform a low-level format on a floppy disk (
    ``         /dev/fd0*        `` ).

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** System Resources**

 **ulimit**
    Sets an *upper limit* on use of system resources. Usually invoked
    with the ``         -f        `` option, which sets a limit on file
    size ( **ulimit -f 1000** limits files to 1 meg maximum). ` [7]
     <system.html#FTN.AEN16782>`__ The ``         -t        `` option
    limits the coredump size ( **ulimit -c 0** eliminates coredumps).
    Normally, the value of **ulimit** would be set in
    ``         /etc/profile        `` and/or
    ``         ~/.bash_profile        `` (see `Appendix
    H <files.html>`__ ).

    .. raw:: html

       <div class="IMPORTANT">

    +----------------+----------------+----------------+----------------+----------------+
    | |Important|    |
    | Judicious use  |
    | of **ulimit**  |
    | can protect a  |
    | system against |
    | the dreaded    |
    | *fork bomb* .  |
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
    | |     #!/bin/b |
    | ash          | |
    | |     # This s |
    | cript is for | |
    | |  illustrativ |
    | e purposes o | |
    | | nly.         |
    |              | |
    | |     # Run it |
    |  at your own | |
    | |  peril -- it |
    |  WILL freeze | |
    | |  your system |
    | .            | |
    | |              |
    |              | |
    | |     while tr |
    | ue  #  Endle | |
    | | ss loop.     |
    |              | |
    | |     do       |
    |              | |
    | |       $0 &   |
    |     #  This  | |
    | | script invok |
    | es itself .  | |
    | | . .          |
    |              | |
    | |              |
    |     #+ forks | |
    | |  an infinite |
    |  number of t | |
    | | imes . . .   |
    |              | |
    | |              |
    |     #+ until | |
    | |  the system  |
    | freezes up b | |
    | | ecause all r |
    | esources exh | |
    | | austed.      |
    |              | |
    | |     done     |
    |     #  This  | |
    | | is the notor |
    | ious "sorcer | |
    | | er's appenti |
    | ce" scenario | |
    | | .            |
    |              | |
    | |              |
    |              | |
    | |     exit 0   |
    |     #  Will  | |
    | | not exit her |
    | e, because t | |
    | | his script w |
    | ill never te | |
    | | rminate.     |
    |              | |
    |                |
    |                |
    | +------------- |
    | -------------+ |
    | -------------- |
    | ------------+- |
    | -------------- |
    | -----------+   |
    |                |
    | A **ulimit -Hu |
    | XX** (where    |
    | *XX* is the    |
    | user process   |
    | limit) in      |
    | ``             |
    |  /etc/profile  |
    |            ``  |
    | would abort    |
    | this script    |
    | when it        |
    | exceeded the   |
    | preset limit.  |
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

 **quota**
    Display user or group disk quotas.

 **setquota**
    Set user or group disk quotas from the command-line.

 **umask**
    User file creation permissions *mask* . Limit the default file
    attributes for a particular user. All files created by that user
    take on the attributes specified by **umask** . The (octal) value
    passed to **umask** defines the file permissions *disabled* . For
    example, **umask 022** ensures that new files will have at most 755
    permissions (777 NAND 022). ` [8]  <system.html#FTN.AEN16847>`__ Of
    course, the user may later change the attributes of particular files
    with `chmod <basic.html#CHMODREF>`__ . The usual practice is to set
    the value of **umask** in ``         /etc/profile        `` and/or
    ``         ~/.bash_profile        `` (see `Appendix
    H <files.html>`__ ).

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-10. Using *umask* to hide an output file from prying
    eyes**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # rot13a.sh: Same as |
    |  "rot13.sh" script, but  |
    | writes output to "secure |
    | " file.                  |
    |                          |
    |     # Usage: ./rot13a.sh |
    |  filename                |
    |     # or     ./rot13a.sh |
    |  <filename               |
    |     # or     ./rot13a.sh |
    |  and supply keyboard inp |
    | ut (stdin)               |
    |                          |
    |     umask 177            |
    |     #  File creation mas |
    | k.                       |
    |                          |
    |     #  Files created by  |
    | this script              |
    |                          |
    |     #+ will have 600 per |
    | missions.                |
    |                          |
    |     OUTFILE=decrypted.tx |
    | t   #  Results output to |
    |  file "decrypted.txt"    |
    |                          |
    |     #+ which can only be |
    |  read/written            |
    |                          |
    |     #  by invoker of scr |
    | ipt (or root).           |
    |                          |
    |     cat "$@" | tr 'a-zA- |
    | Z' 'n-za-mN-ZA-M' > $OUT |
    | FILE                     |
    |     #    ^^ Input from s |
    | tdin or a file.   ^^^^^^ |
    | ^^^^ Output redirected t |
    | o file.                  |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **rdev**
    Get info about or make changes to root device, swap space, or video
    mode. The functionality of **rdev** has generally been taken over by
    **lilo** , but **rdev** remains useful for setting up a ram disk.
    This is a dangerous command, if misused.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Modules**

 **lsmod**
    List installed kernel modules.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ lsmod          |
    |     Module               |
    |     Size  Used by        |
    |      autofs              |
    |      9456   2 (autoclean |
    | )                        |
    |      opl3                |
    |     11376   0            |
    |      serial_cs           |
    |      5456   0 (unused)   |
    |      sb                  |
    |     34752   0            |
    |      uart401             |
    |      6384   0 [sb]       |
    |      sound               |
    |     58368   0 [opl3 sb u |
    | art401]                  |
    |      soundlow            |
    |       464   0 [sound]    |
    |      soundcore           |
    |      2800   6 [sb sound] |
    |      ds                  |
    |      6448   2 [serial_cs |
    | ]                        |
    |      i82365              |
    |     22928   2            |
    |      pcmcia_core         |
    |     45984   0 [serial_cs |
    |  ds i82365]              |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Doing a **cat /proc/modules** gives  |
    | the same information.                |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **insmod**
    Force installation of a kernel module (use **modprobe** instead,
    when possible). Must be invoked as *root* .

 **rmmod**
    Force unloading of a kernel module. Must be invoked as *root* .

 **modprobe**
    Module loader that is normally invoked automatically in a startup
    script. Must be invoked as *root* .

 **depmod**
    Creates module dependency file. Usually invoked from a startup
    script.

 **modinfo**
    Output information about a loadable module.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ modinfo hid    |
    |     filename:    /lib/mo |
    | dules/2.4.20-6/kernel/dr |
    | ivers/usb/hid.o          |
    |      description: "USB H |
    | ID support drivers"      |
    |      author:      "Andre |
    | as Gal, Vojtech Pavlik < |
    | vojtech@suse.cz>"        |
    |      license:     "GPL"  |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Miscellaneous**

 **env**
    Runs a program or script with certain `environmental
    variables <othertypesv.html#ENVREF>`__ set or changed (without
    changing the overall system environment). The
    ``         [varname=xxx]        `` permits changing the
    environmental variable ``         varname        `` for the duration
    of the script. With no options specified, this command lists all the
    environmental variable settings. ` [9]
     <system.html#FTN.AEN16975>`__

    .. raw:: html

       <div class="NOTE">

    +------------+------------+------------+------------+------------+------------+------------+
    | |Note|     |
    |  The first |
    | line of a  |
    | script     |
    | (the       |
    | "sha-bang" |
    | line) may  |
    | use        |
    | **env**    |
    | when the   |
    | path to    |
    | the shell  |
    | or         |
    | interprete |
    | r          |
    | is         |
    | unknown.   |
    |            |
    | +--------- |
    | ---------- |
    | -------+-- |
    | ---------- |
    | ---------- |
    | ----+----- |
    | ---------- |
    | ---------- |
    | -+         |
    | | .. code: |
    | : PROGRAML |
    | ISTING |   |
    | |          |
    |            |
    |        |   |
    | |     #! / |
    | usr/bin/en |
    | v perl |   |
    | |          |
    |            |
    |        |   |
    | |     prin |
    | t "This Pe |
    | rl scr |   |
    | | ipt will |
    |  run,\n";  |
    |        |   |
    | |     prin |
    | t "even wh |
    | en I d |   |
    | | on't kno |
    | w where to |
    |  find  |   |
    | | Perl.\n" |
    | ;          |
    |        |   |
    | |          |
    |            |
    |        |   |
    | |     # Go |
    | od for por |
    | table  |   |
    | | cross-pl |
    | atform scr |
    | ipts,  |   |
    | |     # wh |
    | ere the Pe |
    | rl bin |   |
    | | aries ma |
    | y not be i |
    | n the  |   |
    | | expected |
    |  place.    |
    |        |   |
    | |     # Th |
    | anks, S.C. |
    |        |   |
    |            |
    |            |
    |            |
    | +--------- |
    | ---------- |
    | -------+-- |
    | ---------- |
    | ---------- |
    | ----+----- |
    | ---------- |
    | ---------- |
    | -+         |
    |            |
    | Or even    |
    | ...        |
    |            |
    | +--------- |
    | ---------- |
    | -------+-- |
    | ---------- |
    | ---------- |
    | ----+----- |
    | ---------- |
    | ---------- |
    | -+         |
    | | .. code: |
    | : PROGRAML |
    | ISTING |   |
    | |          |
    |            |
    |        |   |
    | |     #!/b |
    | in/env bas |
    | h      |   |
    | |     # Qu |
    | eries the  |
    | $PATH  |   |
    | | envirome |
    | ntal varia |
    | ble fo |   |
    | | r the lo |
    | cation of  |
    | bash.  |   |
    | |     # Th |
    | erefore .. |
    | .      |   |
    | |     # Th |
    | is script  |
    | will r |   |
    | | un where |
    |  Bash is n |
    | ot in  |   |
    | | its usua |
    | l place, i |
    | n /bin |   |
    | | .        |
    |            |
    |        |   |
    | |     ...  |
    |            |
    |        |   |
    |            |
    |            |
    |            |
    | +--------- |
    | ---------- |
    | -------+-- |
    | ---------- |
    | ---------- |
    | ----+----- |
    | ---------- |
    | ---------- |
    | -+         |
                
    +------------+------------+------------+------------+------------+------------+------------+

    .. raw:: html

       </div>

 **ldd**
    Show shared lib dependencies for an executable file.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ldd /bin/ls    |
    |     libc.so.6 => /lib/li |
    | bc.so.6 (0x4000c000)     |
    |     /lib/ld-linux.so.2 = |
    | > /lib/ld-linux.so.2 (0x |
    | 80000000)                |
                              
    +--------------------------+--------------------------+--------------------------+

 **watch**
    Run a command repeatedly, at specified time intervals.

    The default is two-second intervals, but this may be changed with
    the ``         -n        `` option.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     watch -n 5 tail /var |
    | /log/messages            |
    |     # Shows tail end of  |
    | system log, /var/log/mes |
    | sages, every five second |
    | s.                       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Unfortunately,                       |
    | `piping <special-chars.html#PIPEREF> |
    | `__                                  |
    | the output of **watch command** to   |
    | `grep <textproc.html#GREPREF>`__     |
    | does not work.                       |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **strip**
    Remove the debugging symbolic references from an executable binary.
    This decreases its size, but makes debugging it impossible.

    This command often occurs in a
    `Makefile <filearchiv.html#MAKEFILEREF>`__ , but rarely in a shell
    script.

 **nm**
    List symbols in an unstripped compiled binary.

 **xrandr**
    Command-line tool for manipulating the root window of the screen.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 17-11. *Backlight* : changes the brightness of the
    (laptop) screen backlight**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # backlight.sh       |
    |     # reldate 02dec2011  |
    |                          |
    |     #  A bug in Fedora C |
    | ore 16/17 messes up the  |
    | keyboard backlight contr |
    | ols.                     |
    |     #  This script is a  |
    | quick-n-dirty workaround |
    | , essentially a shell wr |
    | apper                    |
    |     #+ for xrandr. It gi |
    | ves more control than on |
    | -screen sliders and widg |
    | ets.                     |
    |                          |
    |     OUTPUT=$(xrandr | gr |
    | ep LV | awk '{print $1}' |
    | )   # Get display name!  |
    |     INCR=.05      # For  |
    | finer-grained control, s |
    | et INCR to .03 or .02.   |
    |                          |
    |     old_brightness=$(xra |
    | ndr --verbose | grep rig |
    | htness | awk '{ print $2 |
    |  }')                     |
    |                          |
    |                          |
    |     if [ -z "$1" ]       |
    |     then                 |
    |       bright=1    # If n |
    | o command-line arg, set  |
    | brightness to 1.0 (defau |
    | lt).                     |
    |                          |
    |       else               |
    |         if [ "$1" = "+"  |
    | ]                        |
    |         then             |
    |           bright=$(echo  |
    | "scale=2; $old_brightnes |
    | s + $INCR" | bc)   # +.0 |
    | 5                        |
    |                          |
    |       else               |
    |         if [ "$1" = "-"  |
    | ]                        |
    |         then             |
    |           bright=$(echo  |
    | "scale=2; $old_brightnes |
    | s - $INCR" | bc)   # -.0 |
    | 5                        |
    |                          |
    |       else               |
    |         if [ "$1" = "#"  |
    | ]   # Echoes current bri |
    | ghtness; does not change |
    |  it.                     |
    |         then             |
    |           bright=$old_br |
    | ightness                 |
    |                          |
    |       else               |
    |         if [[ "$1" = "h" |
    |  || "$1" = "H" ]]        |
    |         then             |
    |           echo           |
    |           echo "Usage:"  |
    |           echo "$0 [No a |
    | rgs]    Sets/resets brig |
    | htness to default (1.0). |
    | "                        |
    |           echo "$0 +     |
    |         Increments brigh |
    | tness by 0.5."           |
    |           echo "$0 -     |
    |         Decrements brigh |
    | tness by 0.5."           |
    |           echo "$0 #     |
    |         Echoes current b |
    | rightness without changi |
    | ng it."                  |
    |           echo "$0 N (nu |
    | mber)   Sets brightness  |
    | to N (useful range .7 -  |
    | 1.2)."                   |
    |           echo "$0 h [H] |
    |         Echoes this help |
    |  message."               |
    |           echo "$0 any-o |
    | ther    Gives xrandr usa |
    | ge message."             |
    |                          |
    |           bright=$old_br |
    | ightness                 |
    |                          |
    |       else               |
    |         bright="$1"      |
    |                          |
    |           fi             |
    |          fi              |
    |         fi               |
    |       fi                 |
    |     fi                   |
    |                          |
    |                          |
    |     xrandr --output "$OU |
    | TPUT" --brightness "$bri |
    | ght"   # See xrandr manp |
    | age.                     |
    |                          |
    |                          |
    |        # As root!        |
    |     E_CHANGE0=$?         |
    |     echo "Current bright |
    | ness = $bright"          |
    |                          |
    |     exit $E_CHANGE0      |
    |                          |
    |                          |
    |     # =========== Or, al |
    | ternately . . . ======== |
    | ============ #           |
    |                          |
    |     #!/bin/bash          |
    |     # backlight2.sh      |
    |     # reldate 20jun2012  |
    |                          |
    |     #  A bug in Fedora C |
    | ore 16/17 messes up the  |
    | keyboard backlight contr |
    | ols.                     |
    |     #  This is a quick-n |
    | -dirty workaround, an al |
    | ternate to backlight.sh. |
    |                          |
    |     target_dir=\         |
    |     /sys/devices/pci0000 |
    | :00/0000:00:01.0/0000:01 |
    | :00.0/backlight/acpi_vid |
    | eo0                      |
    |     # Hardware directory |
    | .                        |
    |                          |
    |     actual_brightness=$( |
    | cat $target_dir/actual_b |
    | rightness)               |
    |     max_brightness=$(cat |
    |  $target_dir/max_brightn |
    | ess)                     |
    |     Brightness=$target_d |
    | ir/brightness            |
    |                          |
    |     let "req_brightness  |
    | = actual_brightness"   # |
    |  Requested brightness.   |
    |                          |
    |     if [ "$1" = "-" ]    |
    |     then     # Decrement |
    |  brightness 1 notch.     |
    |       let "req_brightnes |
    | s = $actual_brightness - |
    |  1"                      |
    |     else                 |
    |       if [ "$1" = "+" ]  |
    |       then   # Increment |
    |  brightness 1 notch.     |
    |         let "req_brightn |
    | ess = $actual_brightness |
    |  + 1"                    |
    |        fi                |
    |     fi                   |
    |                          |
    |     if [ $req_brightness |
    |  -gt $max_brightness ]   |
    |     then                 |
    |       req_brightness=$ma |
    | x_brightness             |
    |     fi   # Do not exceed |
    |  max. hardware design br |
    | ightness.                |
    |                          |
    |     echo                 |
    |                          |
    |     echo "Old brightness |
    |  = $actual_brightness"   |
    |     echo "Max brightness |
    |  = $max_brightness"      |
    |     echo "Requested brig |
    | htness = $req_brightness |
    | "                        |
    |     echo                 |
    |                          |
    |     # ================== |
    | ===================      |
    |     echo $req_brightness |
    |  > $Brightness           |
    |     # Must be root for t |
    | his to take effect.      |
    |     E_CHANGE1=$?   # Suc |
    | cessful?                 |
    |     # ================== |
    | ===================      |
    |                          |
    |     if [ "$?" -eq 0 ]    |
    |     then                 |
    |       echo "Changed brig |
    | htness!"                 |
    |     else                 |
    |       echo "Failed to ch |
    | ange brightness!"        |
    |     fi                   |
    |                          |
    |     act_brightness=$(cat |
    |  $Brightness)            |
    |     echo "Actual brightn |
    | ess = $act_brightness"   |
    |                          |
    |     scale0=2             |
    |     sf=100 # Scale facto |
    | r.                       |
    |     pct=$(echo "scale=$s |
    | cale0; $act_brightness / |
    |  $max_brightness * $sf"  |
    | | bc)                    |
    |     echo "Percentage bri |
    | ghtness = $pct%"         |
    |                          |
    |     exit $E_CHANGE1      |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **rdist**
    Remote distribution client: synchronizes, clones, or backs up a file
    system on a remote server.

.. raw:: html

   </div>

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

` [1]  <system.html#AEN14695>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

This is the case on a Linux machine or a UNIX system with disk quotas.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [2]  <system.html#AEN14727>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

The **userdel** command will fail if the particular user being deleted
is still logged on.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [3]  <system.html#AEN16255>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

For more detail on burning CDRs, see Alex Withers' article, `Creating
CDs <http://www2.linuxjournal.com/lj-issues/issue66/3335.html>`__ , in
the October, 1999 issue of `*Linux
Journal* <http://www.linuxjournal.com>`__ .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [4]  <system.html#AEN16504>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

The ``        -c       `` option to `mke2fs <system.html#MKE2FSREF>`__
also invokes a check for bad blocks.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [5]  <system.html#AEN16659>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Since only *root* has write permission in the
``        /var/lock       `` directory, a user script cannot set a lock
file there.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [6]  <system.html#AEN16748>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Operators of single-user Linux systems generally prefer something
simpler for backups, such as **tar** .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [7]  <system.html#AEN16782>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

As of the `version 4 update <bashver4.html#BASH4REF>`__ of Bash, the
``        -f       `` and ``        -c       `` options take a block
size of 512 when in `POSIX <sha-bang.html#POSIX2REF>`__ mode.
Additionally, there are two new options: ``        -b       `` for
`socket <devref1.html#SOCKETREF>`__ buffer size, and
``        -T       `` for the limit on the number of *threads* .

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [8]  <system.html#AEN16847>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

NAND is the logical *not-and* operator. Its effect is somewhat similar
to subtraction.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [9]  <system.html#AEN16975>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

In Bash and other Bourne shell derivatives, it is possible to set
variables in a single command's environment.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     var1=value1 var2=val |
| ue2 commandXXX           |
|     # $var1 and $var2 se |
| t in the environment of  |
| 'commandXXX' only.       |
                          
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
| `Prev <extmisc.html>`__  | Miscellaneous Commands   |
| `Home <index.html>`__    | `Up <part4.html>`__      |
| `Next <sysscripts.html>` | Analyzing a System       |
| __                       | Script                   |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Tip| image:: ../images/tip.gif
.. |Caution| image:: ../images/caution.gif
.. |Warning| image:: ../images/warning.gif
.. |Important| image:: ../images/important.gif
