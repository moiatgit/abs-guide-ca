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

`Prev <devproc.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 29. ``        /dev       `` and ``        /proc       ``

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <procref1.html>`__

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

  29.1. ``      /dev     ``
==========================

 The ``      /dev     `` directory contains entries for the *physical
devices* that may or may not be present in the hardware. ` [1]
 <devref1.html#FTN.AEN19045>`__ Appropriately enough, these are called
*device files* . As an example, the hard drive partitions containing the
mounted filesystem(s) have entries in ``      /dev     `` , as
`df <system.html#DFREF>`__ shows.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ df             |
|     Filesystem           |
|  1k-blocks      Used Ava |
| ilable Use%              |
|      Mounted on          |
|      /dev/hda6           |
|      495876    222748    |
|  247527  48% /           |
|      /dev/hda1           |
|       50755      3887    |
|   44248   9% /boot       |
|      /dev/hda8           |
|      367013     13262    |
|  334803   4% /home       |
|      /dev/hda5           |
|     1714416   1123624    |
|  503704  70% /usr        |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

 Among other things, the ``      /dev     `` directory contains
*loopback* devices, such as ``      /dev/loop0     `` . A loopback
device is a gimmick that allows an ordinary file to be accessed as if it
were a block device. ` [2]  <devref1.html#FTN.AEN19065>`__ This permits
mounting an entire filesystem within a single large file. See `Example
17-8 <system.html#CREATEFS>`__ and `Example
17-7 <system.html#ISOMOUNTREF>`__ .

A few of the pseudo-devices in ``      /dev     `` have other
specialized uses, such as
```       /dev/null      `` <zeros.html#ZEROSREF>`__ ,
```       /dev/zero      `` <zeros.html#ZEROSREF1>`__ ,
```       /dev/urandom      `` <randomvar.html#URANDOMREF>`__ ,
``      /dev/sda1     `` (hard drive partition), ``      /dev/udp     ``
( *User Datagram Packet* port), and
```       /dev/tcp      `` <devref1.html#DEVTCP>`__ .

For instance:

To manually `mount <system.html#MOUNTREF>`__ a USB flash drive, append
the following line to
```       /etc/fstab      `` <system.html#FSTABREF>`__ . ` [3]
 <devref1.html#FTN.AEN19093>`__

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     /dev/sda1    /mnt/fl |
| ashdrive    auto    noau |
| to,user,noatime    0 0   |
                          
+--------------------------+--------------------------+--------------------------+

(See also `Example A-23 <contributed-scripts.html#USBINST>`__ .)
Checking whether a disk is in the CD-burner (soft-linked to
``      /dev/hdc     `` ):

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     head -1 /dev/hdc     |
|                          |
|                          |
|     #  head: cannot open |
|  '/dev/hdc' for reading: |
|  No medium found         |
|     #  (No disc in the d |
| rive.)                   |
|                          |
|     #  head: error readi |
| ng '/dev/hdc': Input/out |
| put error                |
|     #  (There is a disk  |
| in the drive, but it can |
| 't be read;              |
|     #+  possibly it's an |
|  unrecorded CDR blank.)  |
|                          |
|                          |
|     #  Stream of charact |
| ers and assorted gibberi |
| sh                       |
|     #  (There is a pre-r |
| ecorded disk in the driv |
| e,                       |
|     #+ and this is raw o |
| utput -- a stream of ASC |
| II and binary data.)     |
|     #  Here we see the w |
| isdom of using 'head' to |
|  limit the output        |
|     #+ to manageable pro |
| portions, rather than 'c |
| at' or something similar |
| .                        |
|                          |
|                          |
|     #  Now, it's just a  |
| matter of checking/parsi |
| ng the output and taking |
|     #+ appropriate actio |
| n.                       |
                          
+--------------------------+--------------------------+--------------------------+

When executing a command on a ``      /dev/tcp/$host/$port     ``
pseudo-device file, Bash opens a TCP connection to the associated
*socket* .

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| A *socket* is a communications node associated with a specific I/O port. |
| (This is analogous to a *hardware socket* , or *receptacle* , for a      |
| connecting cable.) It permits data transfer between hardware devices on  |
| the same machine, between machines on the same network, between machines |
| across different networks, and, of course, between machines at different |
| locations on the Internet.                                               |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

 The following examples assume an active Internet connection.

Getting the time from ``      nist.gov     `` :

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ cat </dev/tcp/ |
| time.nist.gov/13         |
|     53082 04-03-18 04:26 |
| :54 68 0 0 502.3 UTC(NIS |
| T) *                     |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

[Mark contributed this example.]

Generalizing the above into a script:

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # This script must r |
| un with root permissions |
| .                        |
|                          |
|     URL="time.nist.gov/1 |
| 3"                       |
|                          |
|     Time=$(cat </dev/tcp |
| /"$URL")                 |
|     UTC=$(echo "$Time" | |
|  awk '{print$3}')   # Th |
| ird field is UTC (GMT) t |
| ime.                     |
|     # Exercise: modify t |
| his for different time z |
| ones.                    |
|                          |
|     echo "UTC Time = "$U |
| TC""                     |
                          
+--------------------------+--------------------------+--------------------------+

 Downloading a URL:

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ exec 5<>/dev/t |
| cp/www.net.cn/80         |
|     bash$ echo -e "GET / |
|  HTTP/1.0\n" >&5         |
|     bash$ cat <&5        |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

[Thanks, Mark and Mihai Maties.]

.. raw:: html

   <div class="EXAMPLE">

**Example 29-1. Using ``        /dev/tcp       `` for troubleshooting**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # dev-tcp.sh: /dev/t |
| cp redirection to check  |
| Internet connection.     |
|                          |
|     # Script by Troy Eng |
| el.                      |
|     # Used with permissi |
| on.                      |
|                          |
|     TCP_HOST=news-15.net |
|        # A known spam-fr |
| iendly ISP.              |
|     TCP_PORT=80          |
|        # Port 80 is http |
| .                        |
|                          |
|     # Try to connect. (S |
| omewhat similar to a 'pi |
| ng' . . .)               |
|     echo "HEAD / HTTP/1. |
| 0" >/dev/tcp/${TCP_HOST} |
| /${TCP_PORT}             |
|     MYEXIT=$?            |
|                          |
|     : <<EXPLANATION      |
|     If bash was compiled |
|  with --enable-net-redir |
| ections, it has the capa |
| bility of                |
|     using a special char |
| acter device for both TC |
| P and UDP redirections.  |
| These                    |
|     redirections are use |
| d identically as STDIN/S |
| TDOUT/STDERR. The device |
|  entries                 |
|     are 30,36 for /dev/t |
| cp:                      |
|                          |
|       mknod /dev/tcp c 3 |
| 0 36                     |
|                          |
|     >From the bash refer |
| ence:                    |
|     /dev/tcp/host/port   |
|         If host is a val |
| id hostname or Internet  |
| address, and port is an  |
| integer                  |
|     port number or servi |
| ce name, Bash attempts t |
| o open a TCP connection  |
| to the                   |
|     corresponding socket |
| .                        |
|     EXPLANATION          |
|                          |
|                          |
|     if [ "X$MYEXIT" = "X |
| 0" ]; then               |
|       echo "Connection s |
| uccessful. Exit code: $M |
| YEXIT"                   |
|     else                 |
|       echo "Connection u |
| nsuccessful. Exit code:  |
| $MYEXIT"                 |
|     fi                   |
|                          |
|     exit $MYEXIT         |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 29-2. Playing music**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # music.sh           |
|                          |
|     # Music without exte |
| rnal files               |
|                          |
|     # Author: Antonio Ma |
| cchi                     |
|     # Used in ABS Guide  |
| with permission.         |
|                          |
|                          |
|     #  /dev/dsp default  |
| = 8000 frames per second |
| , 8 bits per frame (1 by |
| te),                     |
|     #+ 1 channel (mono)  |
|                          |
|     duration=2000        |
| # If 8000 bytes = 1 seco |
| nd, then 2000 = 1/4 seco |
| nd.                      |
|     volume=$'\xc0'       |
| # Max volume = \xff (or  |
| \x00).                   |
|     mute=$'\x80'         |
| # No volume = \x80 (the  |
| middle).                 |
|                          |
|     function mknote ()   |
| # $1=Note Hz in bytes (e |
| .g. A = 440Hz ::         |
|     {                    |
| #+ 8000 fps / 440 = 16 : |
| : A = 16 bytes per secon |
| d)                       |
|       for t in `seq 0 $d |
| uration`                 |
|       do                 |
|         test $(( $t % $1 |
|  )) = 0 && echo -n $volu |
| me || echo -n $mute      |
|       done               |
|     }                    |
|                          |
|     e=`mknote 49`        |
|     g=`mknote 41`        |
|     a=`mknote 36`        |
|     b=`mknote 32`        |
|     c=`mknote 30`        |
|     cis=`mknote 29`      |
|     d=`mknote 27`        |
|     e2=`mknote 24`       |
|     n=`mknote 32767`     |
|     # European notation. |
|                          |
|     echo -n "$g$e2$d$c$d |
| $c$a$g$n$g$e$n$g$e2$d$c$ |
| c$b$c$cis$n$cis$d \      |
|     $n$g$e2$d$c$d$c$a$g$ |
| n$g$e$n$g$a$d$c$b$a$b$c" |
|  > /dev/dsp              |
|     # dsp = Digital Sign |
| al Processor             |
|                          |
|     exit      # A "bonny |
| " example of an elegant  |
| shell script!            |
                          
+--------------------------+--------------------------+--------------------------+

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

` [1]  <devref1.html#AEN19045>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

The entries in ``        /dev       `` provide mount points for physical
and virtual devices. These entries use very little drive space.

Some devices, such as ``        /dev/null       `` ,
``        /dev/zero       `` , and ``        /dev/urandom       `` are
virtual. They are not actual physical devices and exist only in
software.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [2]  <devref1.html#AEN19065>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

 A *block device* reads and/or writes data in chunks, or *blocks* , in
contrast to a *character device* , which acesses data in *character*
units. Examples of block devices are hard drives, CDROM drives, and
flash drives. Examples of character devices are keyboards, modems, sound
cards.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [3]  <devref1.html#AEN19093>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Of course, the mount point ``        /mnt/flashdrive       `` must
exist. If not, then, as *root* , **mkdir /mnt/flashdrive** .

To actually mount the drive, use the following command: **mount
/mnt/flashdrive**

Newer Linux distros automount flash drives in the
``        /media       `` directory without user intervention.

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
| `Prev <devproc.html>`__  | ``        /dev       ``  |
| `Home <index.html>`__    | and                      |
| `Next <procref1.html>`__ | ``        /proc       `` |
|                          | `Up <devproc.html>`__    |
|                          | ``        /proc       `` |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

