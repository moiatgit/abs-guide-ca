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

`Prev <moreadv.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 16. External Filters, Programs and Commands

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <textproc.html>`__

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

  16.3. Time / Date Commands
===========================

.. raw:: html

   <div class="VARIABLELIST">

** Time/date and timing**

 **date**
    Simply invoked, **date** prints the date and time to
    ``         stdout        `` . Where this command gets interesting is
    in its formatting and parsing options.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-10. Using *date***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # Exercising the 'da |
    | te' command              |
    |                          |
    |     echo "The number of  |
    | days since the year's be |
    | ginning is `date +%j`."  |
    |     # Needs a leading '+ |
    | ' to invoke formatting.  |
    |     # %j gives day of ye |
    | ar.                      |
    |                          |
    |     echo "The number of  |
    | seconds elapsed since 01 |
    | /01/1970 is `date +%s`." |
    |     #  %s yields number  |
    | of seconds since "UNIX e |
    | poch" began,             |
    |     #+ but how is this u |
    | seful?                   |
    |                          |
    |     prefix=temp          |
    |     suffix=$(date +%s)   |
    | # The "+%s" option to 'd |
    | ate' is GNU-specific.    |
    |     filename=$prefix.$su |
    | ffix                     |
    |     echo "Temporary file |
    | name = $filename"        |
    |     #  It's great for cr |
    | eating "unique and rando |
    | m" temp filenames,       |
    |     #+ even better than  |
    | using $$.                |
    |                          |
    |     # Read the 'date' ma |
    | n page for more formatti |
    | ng options.              |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The ``         -u        `` option gives the UTC (Universal
    Coordinated Time).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ date           |
    |     Fri Mar 29 21:07:39  |
    | MST 2002                 |
    |                          |
    |                          |
    |                          |
    |     bash$ date -u        |
    |     Sat Mar 30 04:07:42  |
    | UTC 2002                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    This option facilitates calculating the time between different
    dates.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-11. *Date* calculations**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # date-calc.sh       |
    |     # Author: Nathan Cou |
    | lter                     |
    |     # Used in ABS Guide  |
    | with permission (thanks! |
    | ).                       |
    |                          |
    |     MPHR=60    # Minutes |
    |  per hour.               |
    |     HPD=24     # Hours p |
    | er day.                  |
    |                          |
    |     diff () {            |
    |             printf '%s'  |
    | $(( $(date -u -d"$TARGET |
    | " +%s) -                 |
    |                          |
    |     $(date -u -d"$CURREN |
    | T" +%s)))                |
    |     #                    |
    |     %d = day of month.   |
    |     }                    |
    |                          |
    |                          |
    |     CURRENT=$(date -u -d |
    |  '2007-09-01 17:30:24' ' |
    | +%F %T.%N %Z')           |
    |     TARGET=$(date -u -d' |
    | 2007-12-25 12:30:00' '+% |
    | F %T.%N %Z')             |
    |     # %F = full date, %T |
    |  = %H:%M:%S, %N = nanose |
    | conds, %Z = time zone.   |
    |                          |
    |     printf '\nIn 2007, % |
    | s ' \                    |
    |            "$(date -d"$C |
    | URRENT +                 |
    |             $(( $(diff)  |
    | /$MPHR /$MPHR /$HPD / 2  |
    | )) days" '+%d %B')"      |
    |     #       %B = name of |
    |  month                ^  |
    | halfway                  |
    |     printf 'was halfway  |
    | between %s ' "$(date -d" |
    | $CURRENT" '+%d %B')"     |
    |     printf 'and %s\n' "$ |
    | (date -d"$TARGET" '+%d % |
    | B')"                     |
    |                          |
    |     printf '\nOn %s at % |
    | s, there were\n' \       |
    |             $(date -u -d |
    | "$CURRENT" +%F) $(date - |
    | u -d"$CURRENT" +%T)      |
    |     DAYS=$(( $(diff) / $ |
    | MPHR / $MPHR / $HPD ))   |
    |     CURRENT=$(date -d"$C |
    | URRENT +$DAYS days" '+%F |
    |  %T.%N %Z')              |
    |     HOURS=$(( $(diff) /  |
    | $MPHR / $MPHR ))         |
    |     CURRENT=$(date -d"$C |
    | URRENT +$HOURS hours" '+ |
    | %F %T.%N %Z')            |
    |     MINUTES=$(( $(diff)  |
    | / $MPHR ))               |
    |     CURRENT=$(date -d"$C |
    | URRENT +$MINUTES minutes |
    | " '+%F %T.%N %Z')        |
    |     printf '%s days, %s  |
    | hours, ' "$DAYS" "$HOURS |
    | "                        |
    |     printf '%s minutes,  |
    | and %s seconds ' "$MINUT |
    | ES" "$(diff)"            |
    |     printf 'until Christ |
    | mas Dinner!\n\n'         |
    |                          |
    |     #  Exercise:         |
    |     #  --------          |
    |     #  Rewrite the diff  |
    | () function to accept pa |
    | ssed parameters,         |
    |     #+ rather than using |
    |  global variables.       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    The *date* command has quite a number of *output* options. For
    example ``         %N        `` gives the nanosecond portion of the
    current time. One interesting use for this is to generate random
    integers.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     date +%N | sed -e 's |
    | /000$//' -e 's/^0//'     |
    |                ^^^^^^^^^ |
    | ^^^^^^^^^^^^^^^^^^^^     |
    |     #  Strip off leading |
    |  and trailing zeroes, if |
    |  present.                |
    |     #  Length of generat |
    | ed integer depends on    |
    |     #+ how many zeroes s |
    | tripped off.             |
    |                          |
    |     # 115281032          |
    |     # 63408725           |
    |     # 394504284          |
                              
    +--------------------------+--------------------------+--------------------------+

    There are many more options (try **man date** ).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     date +%j             |
    |     # Echoes day of the  |
    | year (days elapsed since |
    |  January 1).             |
    |                          |
    |     date +%k%M           |
    |     # Echoes hour and mi |
    | nute in 24-hour format,  |
    | as a single digit string |
    | .                        |
    |                          |
    |                          |
    |                          |
    |     # The 'TZ' parameter |
    |  permits overriding the  |
    | default time zone.       |
    |     date                 |
    |  # Mon Mar 28 21:42:16 M |
    | ST 2005                  |
    |     TZ=EST date          |
    |  # Mon Mar 28 23:42:16 E |
    | ST 2005                  |
    |     # Thanks, Frank Kann |
    | emann and Pete Sjoberg,  |
    | for the tip.             |
    |                          |
    |                          |
    |     SixDaysAgo=$(date -- |
    | date='6 days ago')       |
    |     OneMonthAgo=$(date - |
    | -date='1 month ago')  #  |
    | Four weeks back (not a m |
    | onth!)                   |
    |     OneYearAgo=$(date -- |
    | date='1 year ago')       |
                              
    +--------------------------+--------------------------+--------------------------+

    See also `Example 3-4 <special-chars.html#EX58>`__ and `Example
    A-43 <contributed-scripts.html#STOPWATCH>`__ .

 **zdump**
    Time zone dump: echoes the time in a specified time zone.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ zdump EST      |
    |     EST  Tue Sep 18 22:0 |
    | 9:22 2001 EST            |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **time**
    Outputs verbose timing statistics for executing a command.

    ``                   time ls -l /                 `` gives something
    like this:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     real    0m0.067s     |
    |      user    0m0.004s    |
    |      sys     0m0.005s    |
                              
    +--------------------------+--------------------------+--------------------------+

    See also the very similar `times <x9644.html#TIMESREF>`__ command in
    the previous section.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | As of `version                       |
    | 2.0 <bashver2.html#BASH2REF>`__ of   |
    | Bash, **time** became a shell        |
    | reserved word, with slightly altered |
    | behavior in a pipeline.              |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **touch**
    Utility for updating access/modification times of a file to current
    system time or other specified time, but also useful for creating a
    new file. The command
    ``                   touch zzz                 `` will create a new
    file of zero length, named ``         zzz        `` , assuming that
    ``         zzz        `` did not previously exist. Time-stamping
    empty files in this way is useful for storing date information, for
    example in keeping track of modification times on a project.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The **touch** command is equivalent  |
    | to                                   |
    | ``                           : >> ne |
    | wfile                         ``     |
    | or                                   |
    | ``                           >> newf |
    | ile                         ``       |
    | (for ordinary files).                |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="TIP">

    +--------------------------+--------------------------+--------------------------+
    | |Tip|                    |
    | Before doing a `cp       |
    | -u <basic.html#CPREF>`__ |
    | ( *copy/update* ), use   |
    | **touch** to update the  |
    | time stamp of files you  |
    | don't wish overwritten.  |
    |                          |
    | As an example, if the    |
    | directory                |
    | ``             /home/boz |
    | o/tax_audit            ` |
    | `                        |
    | contains the files       |
    | ``             spreadshe |
    | et-051606.data           |
    |   ``                     |
    | ,                        |
    | ``             spreadshe |
    | et-051706.data           |
    |   ``                     |
    | , and                    |
    | ``             spreadshe |
    | et-051806.data           |
    |   ``                     |
    | , then doing a **touch   |
    | spreadsheet\*.data**     |
    | will protect these files |
    | from being overwritten   |
    | by files with the same   |
    | names during a **cp -u   |
    | /home/bozo/financial\_in |
    | fo/spreadsheet\*data     |
    | /home/bozo/tax\_audit**  |
    | .                        |
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **at**
    The **at** job control command executes a given set of commands at a
    specified time. Superficially, it resembles
    `cron <system.html#CRONREF>`__ , however, **at** is chiefly useful
    for one-time execution of a command set.

    ``                   at 2pm January 15                 `` prompts
    for a set of commands to execute at that time. These commands should
    be shell-script compatible, since, for all practical purposes, the
    user is typing in an executable shell script a line at a time. Input
    terminates with a `Ctl-D <special-chars.html#CTLDREF>`__ .

    Using either the ``         -f        `` option or input redirection
    ( < ), **at** reads a command list from a file. This file is an
    executable shell script, though it should, of course, be
    non-interactive. Particularly clever is including the
    `run-parts <extmisc.html#RUNPARTSREF>`__ command in the file to
    execute a different set of scripts.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ at 2:30 am Fri |
    | day < at-jobs.list       |
    |     job 2 at 2000-10-27  |
    | 02:30                    |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **batch**
    The **batch** job control command is similar to **at** , but it runs
    a command list when the system load drops below
    ``         .8        `` . Like **at** , it can read commands from a
    file with the ``         -f        `` option.

    +--------------------------------------------------------------------------+
    | .. raw:: html                                                            |
    |                                                                          |
    |    <div class="SIDEBAR">                                                 |
    |                                                                          |
    | The concept of *batch processing* dates back to the era of mainframe     |
    | computers. It means running a set of commands without user intervention. |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </div>                                                                |
                                                                              
    +--------------------------------------------------------------------------+

 **cal**
    Prints a neatly formatted monthly calendar to
    ``         stdout        `` . Will do current year or a large range
    of past and future years.

 **sleep**
    This is the shell equivalent of a *wait loop* . It pauses for a
    specified number of seconds, doing nothing. It can be useful for
    timing or in processes running in the background, checking for a
    specific event every so often (polling), as in `Example
    32-6 <debugging.html#ONLINE>`__ .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     sleep 3     # Pauses |
    |  3 seconds.              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="NOTE">

    +--------------------------+--------------------------+--------------------------+
    | |Note|                   |
    | The **sleep** command    |
    | defaults to seconds, but |
    | minute, hours, or days   |
    | may also be specified.   |
    |                          |
    | +----------------------- |
    | ---+-------------------- |
    | ------+----------------- |
    | ---------+               |
    | | .. code:: PROGRAMLISTI |
    | NG |                     |
    | |                        |
    |    |                     |
    | |     sleep 3 h   # Paus |
    | es |                     |
    | |  3 hours!              |
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

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The `watch <system.html#WATCHREF>`__ |
    | command may be a better choice than  |
    | **sleep** for running commands at    |
    | timed intervals.                     |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **usleep**
    *Microsleep* (the *u* may be read as the Greek *mu* , or *micro-*
    prefix). This is the same as **sleep** , above, but "sleeps" in
    microsecond intervals. It can be used for fine-grained timing, or
    for polling an ongoing process at very frequent intervals.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     usleep 30     # Paus |
    | es 30 microseconds.      |
                              
    +--------------------------+--------------------------+--------------------------+

    This command is part of the Red Hat *initscripts / rc-scripts*
    package.

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | The **usleep** command does not      |
    | provide particularly accurate        |
    | timing, and is therefore unsuitable  |
    | for critical timing loops.           |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **hwclock** , **clock**
    The **hwclock** command accesses or adjusts the machine's hardware
    clock. Some options require *root* privileges. The
    ``         /etc/rc.d/rc.sysinit        `` startup file uses
    **hwclock** to set the system time from the hardware clock at
    bootup.

    The **clock** command is a synonym for **hwclock** .

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <moreadv.html>`__  | Complex Commands         |
| `Home <index.html>`__    | `Up <external.html>`__   |
| `Next <textproc.html>`__ | Text Processing Commands |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Tip| image:: ../images/tip.gif
.. |Caution| image:: ../images/caution.gif
