################################################
XXX  7.2. Operadors de comprovació sobre fitxers
################################################

Els següents operadors retornen cert si:

 -e
    existeix el fitxer

 -a
    existeix el fitxer

    Presenta el mateix resultat que ``-e`` però es considera desfasat i es desaconsella el seu ús.

 -f
    és un fitxer regular (ni un directori, ni un :doc:`fitxer de dispositiu <devref1>` )

 -s
    la mida del fitxer no és zero (fitxer no buit)

 -d
    és un directori

 -b
    és un :ref:`dispositiu de bloc <fto_exemple_condicionsfitxersespecials>`

 -c
    és un :ref:`dispositiu de caràcter <fto_exemple_condicionsfitxersespecials>`

 -p
    el fitxer és un :ref:`conducte <specialchars-pipe>` o *pipe*.

    Considera l'exemple :ref:`fto_exemple_pipe`.

.. XXX per aquí

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


    .. code-block:: sh

                 -rwsr-xr-t    1 root       178236 Oct  2  2000 /usr/sbin/pppd




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


    .. code-block:: sh

                 drwxrwxrwt    7 root         1024 May 19 21:26 tmp/




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

.. _fto_exemple_condicionsfitxersespecials:

Exemple 1. Condicions amb fitxers especials
===========================================

.. literalinclude:: _scripts/fitxersespecials.sh
    :language: sh

.. _fto_exemple_pipe:

Exemple 2. Comprovacions amb conductes
======================================

.. literalinclude:: _scripts/exemplepipe.sh
    :language: sh


Exemple 4. Testing for broken links
===================================


.. code-block:: sh

    #!/bin/bash
    # broken-link.sh
    # Written by Lee bigelow <ligelowbee@yahoo.com>
    # Used in ABS Guide with permission.

    #  A pure shell script to find dead symlinks and output them quoted
    #+ so they can be fed to xargs and dealt with :)
    #+ eg. sh broken-link.sh /somedir /someotherdir|xargs rm
    #
    #  This, however, is a better method:
    #
    #  find "somedir" -type l -print0|\
    #  xargs -r0 file|\
    #  grep "broken symbolic"
    #  sed -e 's/^\|: *broken symbolic.*$/"/g'
    #
    #+ but that wouldn't be pure Bash, now would it.
    #  Caution: beware the /proc file system and any circular links!
    ################################################################


    #  If no args are passed to the script set directories-to-search
    #+ to current directory.  Otherwise set the directories-to-search
    #+ to the args passed.
    ######################

    [ $# -eq 0 ] && directorys=`pwd` |directorys=$@


    #  Setup the function linkchk to check the directory it is passed
    #+ for files that are links and don't exist, then print them quoted.
    #  If one of the elements in the directory is a subdirectory then
    #+ send that subdirectory to the linkcheck function.
    ##########

    linkchk () {
        for element in $1/*; do
          [ -h "$element" -a ! -e "$element" ] && echo \"$element\"
          [ -d "$element" ] && linkchk $element
        # Of course, '-h' tests for symbolic link, '-d' for directory.
        done
    }

    #  Send each arg that was passed to the script to the linkchk() function
    #+ if it is a valid directoy.  If not, then print the error message
    #+ and usage info.
    ##################
    for directory in $directorys; do
        if [ -d $directory ]
        then linkchk $directory
        else
            echo "$directory is not a directory"
            echo "Usage: $0 dir1 dir2 ..."
        fi
    done

    exit $?




`Example 31-1 <zeros.html#COOKIES>`__ , `Example
11-8 <loops1.html#BINGREP>`__ , `Example 11-3 <loops1.html#FILEINFO>`__
, `Example 31-3 <zeros.html#RAMDISK>`__ , and `Example
A-1 <contributed-scripts.html#MAILFORMAT>`__ also illustrate uses of the
file test operators.


Notes
~~~~~



` [2]  <fto.html#AEN3400>`__

Be aware that *suid* binaries may open security holes. The *suid* flag
has no effect on shell scripts.


` [3]  <fto.html#AEN3423>`__

On Linux systems, the sticky bit is no longer used for files, only on
directories.



