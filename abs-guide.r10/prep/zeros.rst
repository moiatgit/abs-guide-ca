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

`Prev <networkprogramming.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <debugging.html>`__

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

  Chapter 31. Of Zeros and Nulls
===============================

+--------------------+--------------------+--------------------+--------------------+
| **                 |
| *Faultily          |
| faultless, icily   |
| regular,           |
| splendidly null*   |
|                    |
| *Dead perfection;  |
| no more.*          |
|                    |
| *--Alfred Lord     |
| Tennyson*          |
+--------------------+--------------------+--------------------+--------------------+

.. raw:: html

   <div class="VARIABLELIST">

** ``        /dev/zero       `` ... ``        /dev/null       ``**

 Uses of ``        /dev/null       ``
    Think of ``         /dev/null        `` as a *black hole* . It is
    essentially the equivalent of a write-only file. Everything written
    to it disappears. Attempts to read or output from it result in
    nothing. All the same, ``         /dev/null        `` can be quite
    useful from both the command-line and in scripts.

    Suppressing ``         stdout        `` .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     cat $filename >/dev/ |
    | null                     |
    |     # Contents of the fi |
    | le will not list to stdo |
    | ut.                      |
                              
    +--------------------------+--------------------------+--------------------------+

    Suppressing ``         stderr        `` (from `Example
    16-3 <moreadv.html#EX57>`__ ).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     rm $badname 2>/dev/n |
    | ull                      |
    |     #           So error |
    |  messages [stderr] deep- |
    | sixed.                   |
                              
    +--------------------------+--------------------------+--------------------------+

    Suppressing output from *both* ``         stdout        `` and
    ``         stderr        `` .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     cat $filename 2>/dev |
    | /null >/dev/null         |
    |     # If "$filename" doe |
    | s not exist, there will  |
    | be no error message outp |
    | ut.                      |
    |     # If "$filename" doe |
    | s exist, the contents of |
    |  the file will not list  |
    | to stdout.               |
    |     # Therefore, no outp |
    | ut at all will result fr |
    | om the above line of cod |
    | e.                       |
    |     #                    |
    |     #  This can be usefu |
    | l in situations where th |
    | e return code from a com |
    | mand                     |
    |     #+ needs to be teste |
    | d, but no output is desi |
    | red.                     |
    |     #                    |
    |     # cat $filename &>/d |
    | ev/null                  |
    |     #     also works, as |
    |  Baris Cicek points out. |
                              
    +--------------------------+--------------------------+--------------------------+

    Deleting contents of a file, but preserving the file itself, with
    all attendant permissions (from `Example 2-1 <sha-bang.html#EX1>`__
    and `Example 2-3 <sha-bang.html#EX2>`__ ):

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     cat /dev/null > /var |
    | /log/messages            |
    |     #  : > /var/log/mess |
    | ages   has same effect,  |
    | but does not spawn a new |
    |  process.                |
    |                          |
    |     cat /dev/null > /var |
    | /log/wtmp                |
                              
    +--------------------------+--------------------------+--------------------------+

    Automatically emptying the contents of a logfile (especially good
    for dealing with those nasty "cookies" sent by commercial Web
    sites):

    .. raw:: html

       <div class="EXAMPLE">

    **Example 31-1. Hiding the cookie jar**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Obsolete Netscape  |
    | browser.                 |
    |     # Same principle app |
    | lies to newer browsers.  |
    |                          |
    |     if [ -f ~/.netscape/ |
    | cookies ]  # Remove, if  |
    | exists.                  |
    |     then                 |
    |       rm -f ~/.netscape/ |
    | cookies                  |
    |     fi                   |
    |                          |
    |     ln -s /dev/null ~/.n |
    | etscape/cookies          |
    |     # All cookies now ge |
    | t sent to a black hole,  |
    | rather than saved to dis |
    | k.                       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 Uses of ``        /dev/zero       ``
    Like ``         /dev/null        `` , ``         /dev/zero        ``
    is a pseudo-device file, but it actually produces a stream of nulls
    ( *binary* zeros, not the `ASCII <special-chars.html#ASCIIDEF>`__
    kind). Output written to ``         /dev/zero        `` disappears,
    and it is fairly difficult to actually read the nulls emitted there,
    though it can be done with `od <extmisc.html#ODREF>`__ or a hex
    editor. The chief use of ``         /dev/zero        `` is creating
    an initialized dummy file of predetermined length intended as a
    temporary swap file.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 31-2. Setting up a swapfile using
    ``           /dev/zero          ``**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Creating a swap fi |
    | le.                      |
    |                          |
    |     #  A swap file provi |
    | des a temporary storage  |
    | cache                    |
    |     #+ which helps speed |
    |  up certain filesystem o |
    | perations.               |
    |                          |
    |     ROOT_UID=0         # |
    |  Root has $UID 0.        |
    |     E_WRONG_USER=85    # |
    |  Not root?               |
    |                          |
    |     FILE=/swap           |
    |     BLOCKSIZE=1024       |
    |     MINBLOCKS=40         |
    |     SUCCESS=0            |
    |                          |
    |                          |
    |     # This script must b |
    | e run as root.           |
    |     if [ "$UID" -ne "$RO |
    | OT_UID" ]                |
    |     then                 |
    |       echo; echo "You mu |
    | st be root to run this s |
    | cript."; echo            |
    |       exit $E_WRONG_USER |
    |     fi                   |
    |                          |
    |                          |
    |     blocks=${1:-$MINBLOC |
    | KS}          #  Set to d |
    | efault of 40 blocks,     |
    |                          |
    |              #+ if nothi |
    | ng specified on command- |
    | line.                    |
    |     # This is the equiva |
    | lent of the command bloc |
    | k below.                 |
    |     # ------------------ |
    | ------------------------ |
    | --------                 |
    |     # if [ -n "$1" ]     |
    |     # then               |
    |     #   blocks=$1        |
    |     # else               |
    |     #   blocks=$MINBLOCK |
    | S                        |
    |     # fi                 |
    |     # ------------------ |
    | ------------------------ |
    | --------                 |
    |                          |
    |                          |
    |     if [ "$blocks" -lt $ |
    | MINBLOCKS ]              |
    |     then                 |
    |       blocks=$MINBLOCKS  |
    |              # Must be a |
    | t least 40 blocks long.  |
    |     fi                   |
    |                          |
    |                          |
    |     #################### |
    | ######################## |
    | ######################## |
    | ##                       |
    |     echo "Creating swap  |
    | file of size $blocks blo |
    | cks (KB)."               |
    |     dd if=/dev/zero of=$ |
    | FILE bs=$BLOCKSIZE count |
    | =$blocks  # Zero out fil |
    | e.                       |
    |     mkswap $FILE $blocks |
    |              # Designate |
    |  it a swap file.         |
    |     swapon $FILE         |
    |              # Activate  |
    | swap file.               |
    |     retcode=$?           |
    |              # Everythin |
    | g worked?                |
    |     #  Note that if one  |
    | or more of these command |
    | s fails,                 |
    |     #+ then it could cau |
    | se nasty problems.       |
    |     #################### |
    | ######################## |
    | ######################## |
    | ##                       |
    |                          |
    |     #  Exercise:         |
    |     #  Rewrite the above |
    |  block of code so that i |
    | f it does not execute    |
    |     #+ successfully, the |
    | n:                       |
    |     #    1) an error mes |
    | sage is echoed to stderr |
    | ,                        |
    |     #    2) all temporar |
    | y files are cleaned up,  |
    | and                      |
    |     #    3) the script e |
    | xits in an orderly fashi |
    | on with an               |
    |     #+      appropriate  |
    | error code.              |
    |                          |
    |     echo "Swap file crea |
    | ted and activated."      |
    |                          |
    |     exit $retcode        |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    Another application of ``         /dev/zero        `` is to "zero
    out" a file of a designated size for a special purpose, such as
    mounting a filesystem on a `loopback
    device <devref1.html#LOOPBACKREF>`__ (see `Example
    17-8 <system.html#CREATEFS>`__ ) or "securely" deleting a file (see
    `Example 16-61 <extmisc.html#BLOTOUT>`__ ).

    .. raw:: html

       <div class="EXAMPLE">

    **Example 31-3. Creating a ramdisk**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # ramdisk.sh         |
    |                          |
    |     #  A "ramdisk" is a  |
    | segment of system RAM me |
    | mory                     |
    |     #+ which acts as if  |
    | it were a filesystem.    |
    |     #  Its advantage is  |
    | very fast access (read/w |
    | rite time).              |
    |     #  Disadvantages: vo |
    | latility, loss of data o |
    | n reboot or powerdown,   |
    |     #+                le |
    | ss RAM available to syst |
    | em.                      |
    |     #                    |
    |     #  Of what use is a  |
    | ramdisk?                 |
    |     #  Keeping a large d |
    | ataset, such as a table  |
    | or dictionary on ramdisk |
    | ,                        |
    |     #+ speeds up data lo |
    | okup, since memory acces |
    | s is much faster than di |
    | sk access.               |
    |                          |
    |                          |
    |     E_NON_ROOT_USER=70   |
    |            # Must run as |
    |  root.                   |
    |     ROOTUSER_NAME=root   |
    |                          |
    |     MOUNTPT=/mnt/ramdisk |
    |            # Create with |
    |  mkdir /mnt/ramdisk.     |
    |     SIZE=2000            |
    |            # 2K blocks ( |
    | change as appropriate)   |
    |     BLOCKSIZE=1024       |
    |            # 1K (1024 by |
    | te) block size           |
    |     DEVICE=/dev/ram0     |
    |            # First ram d |
    | evice                    |
    |                          |
    |     username=`id -nu`    |
    |     if [ "$username" !=  |
    | "$ROOTUSER_NAME" ]       |
    |     then                 |
    |       echo "Must be root |
    |  to run \"`basename $0`\ |
    | "."                      |
    |       exit $E_NON_ROOT_U |
    | SER                      |
    |     fi                   |
    |                          |
    |     if [ ! -d "$MOUNTPT" |
    |  ]         #  Test wheth |
    | er mount point already t |
    | here,                    |
    |     then                 |
    |            #+ so no erro |
    | r if this script is run  |
    |       mkdir $MOUNTPT     |
    |            #+ multiple t |
    | imes.                    |
    |     fi                   |
    |                          |
    |     #################### |
    | ######################## |
    | ######################## |
    | ##########               |
    |     dd if=/dev/zero of=$ |
    | DEVICE count=$SIZE bs=$B |
    | LOCKSIZE  # Zero out RAM |
    |  device.                 |
    |                          |
    |                          |
    |           # Why is this  |
    | necessary?               |
    |     mke2fs $DEVICE       |
    |            # Create an e |
    | xt2 filesystem on it.    |
    |     mount $DEVICE $MOUNT |
    | PT         # Mount it.   |
    |     chmod 777 $MOUNTPT   |
    |            # Enables ord |
    | inary user to access ram |
    | disk.                    |
    |                          |
    |            # However, mu |
    | st be root to unmount it |
    | .                        |
    |     #################### |
    | ######################## |
    | ######################## |
    | ##########               |
    |     # Need to test wheth |
    | er above commands succee |
    | d. Could cause problems  |
    | otherwise.               |
    |     # Exercise: modify t |
    | his script to make it sa |
    | fer.                     |
    |                          |
    |     echo "\"$MOUNTPT\" n |
    | ow available for use."   |
    |     # The ramdisk is now |
    |  accessible for storing  |
    | files, even by an ordina |
    | ry user.                 |
    |                          |
    |     #  Caution, the ramd |
    | isk is volatile, and its |
    |  contents will disappear |
    |     #+ on reboot or powe |
    | r loss.                  |
    |     #  Copy anything you |
    |  want saved to a regular |
    |  directory.              |
    |                          |
    |     # After reboot, run  |
    | this script to again set |
    |  up ramdisk.             |
    |     # Remounting /mnt/ra |
    | mdisk without the other  |
    | steps will not work.     |
    |                          |
    |     #  Suitably modified |
    | , this script can by inv |
    | oked in /etc/rc.d/rc.loc |
    | al,                      |
    |     #+ to set up ramdisk |
    |  automatically at bootup |
    | .                        |
    |     #  That may be appro |
    | priate on, for example,  |
    | a database server.       |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    In addition to all the above, ``         /dev/zero        `` is
    needed by ELF ( *Executable and Linking Format* ) UNIX/Linux
    binaries.

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <networkprogrammin | Network Programming      |
| g.html>`__               | `Up <part5.html>`__      |
| `Home <index.html>`__    | Debugging                |
| `Next <debugging.html>`_ |                          |
| _                        |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

