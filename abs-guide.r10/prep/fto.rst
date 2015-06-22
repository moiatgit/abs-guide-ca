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

`Prev <testconstructs.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 7. Tests

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <comparison-ops.html>`__

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

  7.2. File test operators
=========================

.. raw:: html

   <div class="VARIABLELIST">

** Returns true if...**

 -e
    file exists

 -a
    file exists

    This is identical in effect to -e . It has been "deprecated," ` [1]
     <fto.html#FTN.AEN3289>`__ and its use is discouraged.

 -f
    file is a ``                   regular                 `` file (not
    a directory or `device file <devref1.html#DEVFILEREF>`__ )

 -s
    file is not zero size

 -d
    file is a directory

 -b
    file is a `block device <devref1.html#BLOCKDEVREF>`__

 -c
     file is a `character device <devref1.html#CHARDEVREF>`__

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     device0="/dev/sda2"  |
    |    # /   (root directory |
    | )                        |
    |     if [ -b "$device0" ] |
    |     then                 |
    |       echo "$device0 is  |
    | a block device."         |
    |     fi                   |
    |                          |
    |     # /dev/sda2 is a blo |
    | ck device.               |
    |                          |
    |                          |
    |                          |
    |     device1="/dev/ttyS1" |
    |    # PCMCIA modem card.  |
    |     if [ -c "$device1" ] |
    |     then                 |
    |       echo "$device1 is  |
    | a character device."     |
    |     fi                   |
    |                          |
    |     # /dev/ttyS1 is a ch |
    | aracter device.          |
                              
    +--------------------------+--------------------------+--------------------------+

 -p
    file is a `pipe <special-chars.html#PIPEREF>`__

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     function show_input_ |
    | type()                   |
    |     {                    |
    |        [ -p /dev/fd/0 ]  |
    | && echo PIPE || echo STD |
    | IN                       |
    |     }                    |
    |                          |
    |     show_input_type "Inp |
    | ut"                      |
    |       # STDIN            |
    |     echo "Input" | show_ |
    | input_type               |
    |       # PIPE             |
    |                          |
    |     # This example court |
    | esy of Carl Anderson.    |
                              
    +--------------------------+--------------------------+--------------------------+

 -h
    file is a `symbolic link <basic.html#SYMLINKREF>`__

 -L
    file is a symbolic link

 -S
    file is a `socket <devref1.html#SOCKETREF>`__

 -t
     file ( `descriptor <io-redirection.html#FDREF>`__ ) is associated
    with a terminal device

    This test option `may be used to
    check <intandnonint.html#II2TEST>`__ whether the
    ``         stdin        ``
    ``                   [ -t 0 ]                 `` or
    ``         stdout        ``
    ``                   [ -t 1 ]                 `` in a given script
    is a terminal.

 -r
    file has read permission ( *for the user running the test* )

 -w
    file has write permission (for the user running the test)

 -x
    file has execute permission (for the user running the test)

 -g
    set-group-id (sgid) flag set on file or directory

    If a directory has the ``                   sgid                 ``
    flag set, then a file created within that directory belongs to the
    group that owns the directory, not necessarily to the group of the
    user who created the file. This may be useful for a directory shared
    by a workgroup.

 -u

    set-user-id (suid) flag set on file

    A binary owned by *root* with
    ``                   set-user-id                 `` flag set runs
    with *root* privileges, even when an ordinary user invokes it. ` [2]
     <fto.html#FTN.AEN3400>`__ This is useful for executables (such as
    **pppd** and **cdrecord** ) that need to access system hardware.
    Lacking the *suid* flag, these binaries could not be invoked by a
    *non-root* user.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |             -rwsr-xr-t   |
    |   1 root       178236 Oc |
    | t  2  2000 /usr/sbin/ppp |
    | d                        |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    A file with the ``                   suid                 `` flag
    set shows an *s* in its permissions.

 -k
    ``                   sticky bit                 `` set

    Commonly known as the *sticky bit,* the *save-text-mode* flag is a
    special type of file permission. If a file has this flag set, that
    file will be kept in cache memory, for quicker access. ` [3]
     <fto.html#FTN.AEN3423>`__ If set on a directory, it restricts write
    permission. Setting the sticky bit adds a *t* to the permissions on
    the file or directory listing. This restricts altering or deleting
    specific files in that directory to the owner of those files.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |             drwxrwxrwt   |
    |   7 root         1024 Ma |
    | y 19 21:26 tmp/          |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    If a user does not own a directory that has the sticky bit set, but
    has write permission in that directory, she can only delete those
    files that she owns in it. This keeps users from inadvertently
    overwriting or deleting each other's files in a publicly accessible
    directory, such as ``         /tmp        `` . (The *owner* of the
    directory or *root* can, of course, delete or rename files there.)

 -O
    you are owner of file

 -G
    group-id of file same as yours

 -N
    file modified since it was last read

 f1 -nt f2
    file ``                   f1                 `` is newer than
    ``                   f2                 ``

 f1 -ot f2
    file ``                   f1                 `` is older than
    ``                   f2                 ``

 f1 -ef f2
    files ``                   f1                 `` and
    ``                   f2                 `` are hard links to the
    same file

 !
     "not" -- reverses the sense of the tests above (returns true if
    condition absent).

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 7-4. Testing for broken links**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # broken-link.sh     |
|     # Written by Lee big |
| elow <ligelowbee@yahoo.c |
| om>                      |
|     # Used in ABS Guide  |
| with permission.         |
|                          |
|     #  A pure shell scri |
| pt to find dead symlinks |
|  and output them quoted  |
|     #+ so they can be fe |
| d to xargs and dealt wit |
| h :)                     |
|     #+ eg. sh broken-lin |
| k.sh /somedir /someother |
| dir|xargs rm             |
|     #                    |
|     #  This, however, is |
|  a better method:        |
|     #                    |
|     #  find "somedir" -t |
| ype l -print0|\          |
|     #  xargs -r0 file|\  |
|     #  grep "broken symb |
| olic"|                   |
|     #  sed -e 's/^\|: *b |
| roken symbolic.*$/"/g'   |
|     #                    |
|     #+ but that wouldn't |
|  be pure Bash, now would |
|  it.                     |
|     #  Caution: beware t |
| he /proc file system and |
|  any circular links!     |
|     #################### |
| ######################## |
| ####################     |
|                          |
|                          |
|     #  If no args are pa |
| ssed to the script set d |
| irectories-to-search     |
|     #+ to current direct |
| ory.  Otherwise set the  |
| directories-to-search    |
|     #+ to the args passe |
| d.                       |
|     #################### |
| ##                       |
|                          |
|     [ $# -eq 0 ] && dire |
| ctorys=`pwd` || director |
| ys=$@                    |
|                          |
|                          |
|     #  Setup the functio |
| n linkchk to check the d |
| irectory it is passed    |
|     #+ for files that ar |
| e links and don't exist, |
|  then print them quoted. |
|     #  If one of the ele |
| ments in the directory i |
| s a subdirectory then    |
|     #+ send that subdire |
| ctory to the linkcheck f |
| unction.                 |
|     ##########           |
|                          |
|     linkchk () {         |
|         for element in $ |
| 1/*; do                  |
|           [ -h "$element |
| " -a ! -e "$element" ] & |
| & echo \"$element\"      |
|           [ -d "$element |
| " ] && linkchk $element  |
|         # Of course, '-h |
| ' tests for symbolic lin |
| k, '-d' for directory.   |
|         done             |
|     }                    |
|                          |
|     #  Send each arg tha |
| t was passed to the scri |
| pt to the linkchk() func |
| tion                     |
|     #+ if it is a valid  |
| directoy.  If not, then  |
| print the error message  |
|     #+ and usage info.   |
|     ##################   |
|     for directory in $di |
| rectorys; do             |
|         if [ -d $directo |
| ry ]                     |
|         then linkchk $di |
| rectory                  |
|         else             |
|             echo "$direc |
| tory is not a directory" |
|             echo "Usage: |
|  $0 dir1 dir2 ..."       |
|         fi               |
|     done                 |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

`Example 31-1 <zeros.html#COOKIES>`__ , `Example
11-8 <loops1.html#BINGREP>`__ , `Example 11-3 <loops1.html#FILEINFO>`__
, `Example 31-3 <zeros.html#RAMDISK>`__ , and `Example
A-1 <contributed-scripts.html#MAILFORMAT>`__ also illustrate uses of the
file test operators.

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

` [1]  <fto.html#AEN3289>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Per the 1913 edition of *Webster's Dictionary* :

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     Deprecate            |
|     ...                  |
|                          |
|     To pray against, as  |
| an evil;                 |
|     to seek to avert by  |
| prayer;                  |
|     to desire the remova |
| l of;                    |
|     to seek deliverance  |
| from;                    |
|     to express deep regr |
| et for;                  |
|     to disapprove of str |
| ongly.                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [2]  <fto.html#AEN3400>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

Be aware that *suid* binaries may open security holes. The *suid* flag
has no effect on shell scripts.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

` [3]  <fto.html#AEN3423>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

On Linux systems, the sticky bit is no longer used for files, only on
directories.

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
| `Prev <testconstructs.ht | Test Constructs          |
| ml>`__                   | `Up <tests.html>`__      |
| `Home <index.html>`__    | Other Comparison         |
| `Next <comparison-ops.ht | Operators                |
| ml>`__                   |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

