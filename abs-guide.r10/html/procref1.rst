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

`Prev <devref1.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 29. ``/dev`` and ``/proc``

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <networkprogramming.html>`__

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

29.2. ``/proc``
===============

The ``/proc`` directory is actually a pseudo-filesystem. The files in
``/proc`` mirror currently running system and kernel
`processes <special-chars.html#PROCESSREF>`__ and contain information
and statistics about them.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ cat /proc/devi |
| ces                      |
|     Character devices:   |
|        1 mem             |
|        2 pty             |
|        3 ttyp            |
|        4 ttyS            |
|        5 cua             |
|        7 vcs             |
|       10 misc            |
|       14 sound           |
|       29 fb              |
|       36 netlink         |
|      128 ptm             |
|      136 pts             |
|      162 raw             |
|      254 pcmcia          |
|                          |
|      Block devices:      |
|        1 ramdisk         |
|        2 fd              |
|        3 ide0            |
|        9 md              |
|                          |
|                          |
|                          |
|     bash$ cat /proc/inte |
| rrupts                   |
|                CPU0      |
|                          |
|        0:      84505     |
|       XT-PIC  timer      |
|        1:       3375     |
|       XT-PIC  keyboard   |
|        2:          0     |
|       XT-PIC  cascade    |
|        5:          1     |
|       XT-PIC  soundblast |
| er                       |
|        8:          1     |
|       XT-PIC  rtc        |
|       12:       4231     |
|       XT-PIC  PS/2 Mouse |
|       14:     109373     |
|       XT-PIC  ide0       |
|      NMI:          0     |
|      ERR:          0     |
|                          |
|                          |
|     bash$ cat /proc/part |
| itions                   |
|     major minor  #blocks |
|   name     rio rmerge rs |
| ect ruse wio wmerge wsec |
| t wuse running use aveq  |
|                          |
|         3     0    30078 |
| 72 hda 4472 22260 114520 |
|  94240 3551 18703 50384  |
| 549710 0 111550 644030   |
|         3     1      524 |
| 16 hda1 27 395 844 960 4 |
|  2 14 180 0 800 1140     |
|         3     2          |
|  1 hda2 0 0 0 0 0 0 0 0  |
| 0 0 0                    |
|         3     4     1652 |
| 80 hda4 10 0 20 210 0 0  |
| 0 0 0 210 210            |
|         ...              |
|                          |
|                          |
|                          |
|     bash$ cat /proc/load |
| avg                      |
|     0.13 0.42 0.27 2/44  |
| 1119                     |
|                          |
|                          |
|                          |
|     bash$ cat /proc/apm  |
|     1.16 1.2 0x03 0x01 0 |
| xff 0x80 -1% -1 ?        |
|                          |
|                          |
|                          |
|     bash$ cat /proc/acpi |
| /battery/BAT0/info       |
|     present:             |
|      yes                 |
|      design capacity:    |
|       43200 mWh          |
|      last full capacity: |
|       36640 mWh          |
|      battery technology: |
|       rechargeable       |
|      design voltage:     |
|       10800 mV           |
|      design capacity war |
| ning: 1832 mWh           |
|      design capacity low |
| :     200 mWh            |
|      capacity granularit |
| y 1:  1 mWh              |
|      capacity granularit |
| y 2:  1 mWh              |
|      model number:       |
|       IBM-02K6897        |
|      serial number:      |
|        1133              |
|      battery type:       |
|       LION               |
|      OEM info:           |
|       Panasonic          |
|                          |
|                          |
|                          |
|     bash$ fgrep Mem /pro |
| c/meminfo                |
|     MemTotal:       5152 |
| 16 kB                    |
|      MemFree:        266 |
| 248 kB                   |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

Shell scripts may extract data from certain of the files in ``/proc``.
`[1] <procref1.html#FTN.AEN19180>`__

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     FS=iso               |
|          # ISO filesyste |
| m support in kernel?     |
|                          |
|     grep $FS /proc/files |
| ystems   # iso9660       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     kernel_version=$( aw |
| k '{ print $3 }' /proc/v |
| ersion )                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     CPU=$( awk '/model n |
| ame/ {print $5}' < /proc |
| /cpuinfo )               |
|                          |
|     if [ "$CPU" = "Penti |
| um(R)" ]                 |
|     then                 |
|       run_some_commands  |
|       ...                |
|     else                 |
|       run_other_commands |
|       ...                |
|     fi                   |
|                          |
|                          |
|                          |
|     cpu_speed=$( fgrep " |
| cpu MHz" /proc/cpuinfo | |
|  awk '{print $4}' )      |
|     #  Current operating |
|  speed (in MHz) of the c |
| pu on your machine.      |
|     #  On a laptop this  |
| may vary, depending on u |
| se of battery            |
|     #+ or AC power.      |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # get-commandline.sh |
|     # Get the command-li |
| ne parameters of a proce |
| ss.                      |
|                          |
|     OPTION=cmdline       |
|                          |
|     # Identify PID.      |
|     pid=$( echo $(pidof  |
| "$1") | awk '{ print $1  |
| }' )                     |
|     # Get only first     |
|         ^^^^^^^^^^^^^^^^ |
| ^^ of multiple instances |
| .                        |
|                          |
|     echo                 |
|     echo "Process ID of  |
| (first instance of) "$1" |
|  = $pid"                 |
|     echo -n "Command-lin |
| e arguments: "           |
|     cat /proc/"$pid"/"$O |
| PTION" | xargs -0 echo   |
|     #   Formats output:  |
|        ^^^^^^^^^^^^^^^   |
|     #   (Thanks, Han Hol |
| l, for the fixup!)       |
|                          |
|     echo; echo           |
|                          |
|                          |
|     # For example:       |
|     # sh get-commandline |
| .sh xterm                |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

+

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     devfile="/proc/bus/u |
| sb/devices"              |
|     text="Spd"           |
|     USB1="Spd=12"        |
|     USB2="Spd=480"       |
|                          |
|                          |
|     bus_speed=$(fgrep -m |
|  1 "$text" $devfile | aw |
| k '{print $9}')          |
|     #                 ^^ |
| ^^ Stop after first matc |
| h.                       |
|                          |
|     if [ "$bus_speed" =  |
| "$USB1" ]                |
|     then                 |
|       echo "USB 1.1 port |
|  found."                 |
|       # Do something app |
| ropriate for USB 1.1.    |
|     fi                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="NOTE">

+--------------+--------------+--------------+--------------+--------------+--------------+
| |Note|       |
| It is even   |
| possible to  |
| control      |
| certain      |
| peripherals  |
| with         |
| commands     |
| sent to the  |
| ``/proc``    |
| directory.   |
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
| |          r |
| oot# echo on |
|  > |         |
| |  /proc/acp |
| i/ibm/light  |
|    |         |
| |            |
|              |
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
| This turns   |
| on the       |
| *Thinklight* |
| in certain   |
| models of    |
| IBM/Lenovo   |
| Thinkpads.   |
| (May not     |
| work on all  |
| Linux        |
| distros.)    |
|              |
| .. raw:: htm |
| l            |
|              |
|    </p>      |
|              |
| Of course,   |
| caution is   |
| advised when |
| writing to   |
| ``/proc``.   |
+--------------+--------------+--------------+--------------+--------------+--------------+

.. raw:: html

   </div>

The ``/proc`` directory contains subdirectories with unusual numerical
names. Every one of these names maps to the `process
ID <internalvariables.html#PPIDREF>`__ of a currently running process.
Within each of these subdirectories, there are a number of files that
hold useful information about the corresponding process. The ``stat``
and ``status`` files keep running statistics on the process, the
``cmdline`` file holds the command-line arguments the process was
invoked with, and the ``exe`` file is a symbolic link to the complete
path name of the invoking process. There are a few more such files, but
these seem to be the most interesting from a scripting standpoint.

.. raw:: html

   <div class="EXAMPLE">

**Example 29-3. Finding the process associated with a PID**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # pid-identifier.sh: |
|     # Gives complete pat |
| h name to process associ |
| ated with pid.           |
|                          |
|     ARGNO=1  # Number of |
|  arguments the script ex |
| pects.                   |
|     E_WRONGARGS=65       |
|     E_BADPID=66          |
|     E_NOSUCHPROCESS=67   |
|     E_NOPERMISSION=68    |
|     PROCFILE=exe         |
|                          |
|     if [ $# -ne $ARGNO ] |
|     then                 |
|       echo "Usage: `base |
| name $0` PID-number" >&2 |
|   # Error message >stder |
| r.                       |
|       exit $E_WRONGARGS  |
|     fi                   |
|                          |
|     pidno=$( ps ax | gre |
| p $1 | awk '{ print $1 } |
| ' | grep $1 )            |
|     # Checks for pid in  |
| "ps" listing, field #1.  |
|     # Then makes sure it |
|  is the actual process,  |
| not the process invoked  |
| by this script.          |
|     # The last "grep $1" |
|  filters out this possib |
| ility.                   |
|     #                    |
|     #    pidno=$( ps ax  |
| | awk '{ print $1 }' | g |
| rep $1 )                 |
|     #    also works, as  |
| Teemu Huovila, points ou |
| t.                       |
|                          |
|     if [ -z "$pidno" ]   |
| #  If, after all the fil |
| tering, the result is a  |
| zero-length string,      |
|     then                 |
| #+ no running process co |
| rresponds to the pid giv |
| en.                      |
|       echo "No such proc |
| ess running."            |
|       exit $E_NOSUCHPROC |
| ESS                      |
|     fi                   |
|                          |
|     # Alternatively:     |
|     #   if ! ps $1 > /de |
| v/null 2>&1              |
|     #   then             |
|     # no running process |
|  corresponds to the pid  |
| given.                   |
|     #     echo "No such  |
| process running."        |
|     #     exit $E_NOSUCH |
| PROCESS                  |
|     #    fi              |
|                          |
|     # To simplify the en |
| tire process, use "pidof |
| ".                       |
|                          |
|                          |
|     if [ ! -r "/proc/$1/ |
| $PROCFILE" ]  # Check fo |
| r read permission.       |
|     then                 |
|       echo "Process $1 r |
| unning, but..."          |
|       echo "Can't get re |
| ad permission on /proc/$ |
| 1/$PROCFILE."            |
|       exit $E_NOPERMISSI |
| ON  # Ordinary user can' |
| t access some files in / |
| proc.                    |
|     fi                   |
|                          |
|     # The last two tests |
|  may be replaced by:     |
|     #    if ! kill -0 $1 |
|  > /dev/null 2>&1 # '0'  |
| is not a signal, but     |
|                          |
|                   # this |
|  will test whether it is |
|  possible                |
|                          |
|                   # to s |
| end a signal to the proc |
| ess.                     |
|     #    then echo "PID  |
| doesn't exist or you're  |
| not its owner" >&2       |
|     #    exit $E_BADPID  |
|     #    fi              |
|                          |
|                          |
|                          |
|     exe_file=$( ls -l /p |
| roc/$1 | grep "exe" | aw |
| k '{ print $11 }' )      |
|     # Or       exe_file= |
| $( ls -l /proc/$1/exe |  |
| awk '{print $11}' )      |
|     #                    |
|     #  /proc/pid-number/ |
| exe is a symbolic link   |
|     #+ to the complete p |
| ath name of the invoking |
|  process.                |
|                          |
|     if [ -e "$exe_file"  |
| ]  #  If /proc/pid-numbe |
| r/exe exists,            |
|     then                 |
|    #+ then the correspon |
| ding process exists.     |
|       echo "Process #$1  |
| invoked by $exe_file."   |
|     else                 |
|       echo "No such proc |
| ess running."            |
|     fi                   |
|                          |
|                          |
|     #  This elaborate sc |
| ript can *almost* be rep |
| laced by                 |
|     #       ps ax | grep |
|  $1 | awk '{ print $5 }' |
|     #  However, this wil |
| l not work...            |
|     #+ because the fifth |
|  field of 'ps' is argv[0 |
| ] of the process,        |
|     #+ not the executabl |
| e file path.             |
|     #                    |
|     # However, either of |
|  the following would wor |
| k.                       |
|     #       find /proc/$ |
| 1/exe -printf '%l\n'     |
|     #       lsof -aFn -p |
|  $1 -d txt | sed -ne 's/ |
| ^n//p'                   |
|                          |
|     # Additional comment |
| ary by Stephane Chazelas |
| .                        |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 29-4. On-line connect status**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # connect-stat.sh    |
|     #  Note that this sc |
| ript may need modificati |
| on                       |
|     #+ to work with a wi |
| reless connection.       |
|                          |
|     PROCNAME=pppd        |
|  # ppp daemon            |
|     PROCFILENAME=status  |
|  # Where to look.        |
|     NOTCONNECTED=85      |
|     INTERVAL=2           |
|  # Update every 2 second |
| s.                       |
|                          |
|     pidno=$( ps ax | gre |
| p -v "ps ax" | grep -v g |
| rep | grep $PROCNAME |   |
|     awk '{ print $1 }' ) |
|                          |
|     # Finding the proces |
| s number of 'pppd', the  |
| 'ppp daemon'.            |
|     # Have to filter out |
|  the process lines gener |
| ated by the search itsel |
| f.                       |
|     #                    |
|     #  However, as Oleg  |
| Philon points out,       |
|     #+ this could have b |
| een considerably simplif |
| ied by using "pidof".    |
|     #  pidno=$( pidof $P |
| ROCNAME )                |
|     #                    |
|     #  Moral of the stor |
| y:                       |
|     #+ When a command se |
| quence gets too complex, |
|  look for a shortcut.    |
|                          |
|                          |
|     if [ -z "$pidno" ]   |
|  # If no pid, then proce |
| ss is not running.       |
|     then                 |
|       echo "Not connecte |
| d."                      |
|     # exit $NOTCONNECTED |
|     else                 |
|       echo "Connected."; |
|  echo                    |
|     fi                   |
|                          |
|     while [ true ]       |
|  # Endless loop, script  |
| can be improved here.    |
|     do                   |
|                          |
|       if [ ! -e "/proc/$ |
| pidno/$PROCFILENAME" ]   |
|       # While process ru |
| nning, then "status" fil |
| e exists.                |
|       then               |
|         echo "Disconnect |
| ed."                     |
|     #   exit $NOTCONNECT |
| ED                       |
|       fi                 |
|                          |
|     netstat -s | grep "p |
| ackets received"  # Get  |
| some connect statistics. |
|     netstat -s | grep "p |
| ackets delivered"        |
|                          |
|                          |
|       sleep $INTERVAL    |
|       echo; echo         |
|                          |
|     done                 |
|                          |
|     exit 0               |
|                          |
|     # As it stands, this |
|  script must be terminat |
| ed with a Control-C.     |
|                          |
|     #    Exercises:      |
|     #    ---------       |
|     #    Improve the scr |
| ipt so it exits on a "q" |
|  keystroke.              |
|     #    Make the script |
|  more user-friendly in o |
| ther ways.               |
|     #    Fix the script  |
| to work with wireless/DS |
| L connections.           |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="WARNING">

+--------------------------------------+--------------------------------------+
| |Warning|                            |
| In general, it is dangerous to       |
| *write* to the files in ``/proc``,   |
| as this can corrupt the filesystem   |
| or crash the machine.                |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <procref1.html#AEN19180>`__     |
| Certain system commands, such as     |
| `procinfo <system.html#PROCINFOREF>` |
| __,                                  |
| `free <system.html#FREEREF>`__,      |
| `vmstat <system.html#VMSTATREF>`__,  |
| `lsdev <system.html#LSDEVREF>`__,    |
| and                                  |
| `uptime <system.html#UPTIMEREF>`__   |
| do this as well.                     |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <devref1.html>`__  | ``/dev``                 |
| `Home <index.html>`__    | `Up <devproc.html>`__    |
| `Next <networkprogrammin | Network Programming      |
| g.html>`__               |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Warning| image:: ../images/warning.gif
