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

`Prev <external.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 16. External Filters, Programs and Commands

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <moreadv.html>`__

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

16.1. Basic Commands
====================

.. raw:: html

   <div class="VARIABLELIST">

**The first commands a novice learns**

\ **ls**
    The basic file "list" command. It is all too easy to underestimate
    the power of this humble command. For example, using the ``-R``,
    recursive option, **ls** provides a tree-like listing of a directory
    structure. Other useful options are ``-S``, sort listing by file
    size, ``-t``, sort by file modification time, ``-v``, sort by
    (numerical) version numbers embedded in the filenames,
    `[1] <basic.html#FTN.AEN10025>`__ ``-b``, show escape characters,
    and ``-i``, show file inodes (see `Example
    16-4 <moreadv.html#IDELETE>`__).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ls -l          |
    |     -rw-rw-r-- 1 bozo bo |
    | zo 0 Sep 14 18:44 chapte |
    | r10.txt                  |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er11.txt                 |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er12.txt                 |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er1.txt                  |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er2.txt                  |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er3.txt                  |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:49 Chapt |
    | er_headings.txt          |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:49 Prefa |
    | ce.txt                   |
    |                          |
    |                          |
    |     bash$ ls -lv         |
    |      total 0             |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:49 Chapt |
    | er_headings.txt          |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:49 Prefa |
    | ce.txt                   |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er1.txt                  |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er2.txt                  |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er3.txt                  |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er10.txt                 |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er11.txt                 |
    |      -rw-rw-r-- 1 bozo b |
    | ozo 0 Sep 14 18:44 chapt |
    | er12.txt                 |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="TIP">

    +--------------------+--------------------+--------------------+--------------------+
    | |Tip|              |
    | The *ls* command   |
    | returns a non-zero |
    | `exit              |
    | status <exit-statu |
    | s.html#EXITSTATUSR |
    | EF>`__             |
    | when attempting to |
    | list a             |
    | non-existent file. |
    |                    |
    | +----------------- |
    | ---------+-------- |
    | ------------------ |
    | +----------------- |
    | ---------+         |
    | | .. code:: SCREEN |
    |          |         |
    | |                  |
    |          |         |
    | |     bash$ ls abc |
    |          |         |
    | |     ls: abc: No  |
    | such fil |         |
    | | e or directory   |
    |          |         |
    | |                  |
    |          |         |
    | |                  |
    |          |         |
    | |     bash$ echo $ |
    | ?        |         |
    | |     2            |
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
    |    </p>            |
                        
    +--------------------+--------------------+--------------------+--------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-1. Using *ls* to create a table of contents for burning
    a CDR disk**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # ex40.sh (burn-cd.s |
    | h)                       |
    |     # Script to automate |
    |  burning a CDR.          |
    |                          |
    |                          |
    |     SPEED=10         # M |
    | ay use higher speed if y |
    | our hardware supports it |
    | .                        |
    |     IMAGEFILE=cdimage.is |
    | o                        |
    |     CONTENTSFILE=content |
    | s                        |
    |     # DEVICE=/dev/cdrom  |
    |     For older versions o |
    | f cdrecord               |
    |     DEVICE="1,0,0"       |
    |     DEFAULTDIR=/opt  # T |
    | his is the directory con |
    | taining the data to be b |
    | urned.                   |
    |                      # M |
    | ake sure it exists.      |
    |                      # E |
    | xercise: Add a test for  |
    | this.                    |
    |                          |
    |     # Uses Joerg Schilli |
    | ng's "cdrecord" package: |
    |     # http://www.fokus.f |
    | hg.de/usr/schilling/cdre |
    | cord.html                |
    |                          |
    |     #  If this script in |
    | voked as an ordinary use |
    | r, may need to suid cdre |
    | cord                     |
    |     #+ chmod u+s /usr/bi |
    | n/cdrecord, as root.     |
    |     #  Of course, this c |
    | reates a security hole,  |
    | though a relatively mino |
    | r one.                   |
    |                          |
    |     if [ -z "$1" ]       |
    |     then                 |
    |       IMAGE_DIRECTORY=$D |
    | EFAULTDIR                |
    |       # Default director |
    | y, if not specified on c |
    | ommand-line.             |
    |     else                 |
    |         IMAGE_DIRECTORY= |
    | $1                       |
    |     fi                   |
    |                          |
    |     # Create a "table of |
    |  contents" file.         |
    |     ls -lRF $IMAGE_DIREC |
    | TORY > $IMAGE_DIRECTORY/ |
    | $CONTENTSFILE            |
    |     # The "l" option giv |
    | es a "long" file listing |
    | .                        |
    |     # The "R" option mak |
    | es the listing recursive |
    | .                        |
    |     # The "F" option mar |
    | ks the file types (direc |
    | tories get a trailing /) |
    | .                        |
    |     echo "Creating table |
    |  of contents."           |
    |                          |
    |     # Create an image fi |
    | le preparatory to burnin |
    | g it onto the CDR.       |
    |     mkisofs -r -o $IMAGE |
    | FILE $IMAGE_DIRECTORY    |
    |     echo "Creating ISO96 |
    | 60 file system image ($I |
    | MAGEFILE)."              |
    |                          |
    |     # Burn the CDR.      |
    |     echo "Burning the di |
    | sk."                     |
    |     echo "Please be pati |
    | ent, this will take a wh |
    | ile."                    |
    |     wodim -v -isosize de |
    | v=$DEVICE $IMAGEFILE     |
    |     #  In newer Linux di |
    | stros, the "wodim" utili |
    | ty assumes the           |
    |     #+ functionality of  |
    | "cdrecord."              |
    |     exitcode=$?          |
    |     echo "Exit code = $e |
    | xitcode"                 |
    |                          |
    |     exit $exitcode       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

\ **cat**, **tac**
    **cat**, an acronym for *concatenate*, lists a file to ``stdout``.
    When combined with redirection (> or >>), it is commonly used to
    concatenate files.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Uses of 'cat'      |
    |     cat filename         |
    |                   # List |
    | s the file.              |
    |                          |
    |     cat file.1 file.2 fi |
    | le.3 > file.123   # Comb |
    | ines three files into on |
    | e.                       |
                              
    +--------------------------+--------------------------+--------------------------+

    The ``-n`` option to **cat** inserts consecutive numbers before all
    lines of the target file(s). The ``-b`` option numbers only the
    non-blank lines. The ``-v`` option echoes nonprintable characters,
    using ^ notation. The ``-s`` option squeezes multiple consecutive
    blank lines into a single blank line.

    .. raw:: html

       </p>

    See also `Example 16-28 <textproc.html#LNUM>`__ and `Example
    16-24 <textproc.html#ROT13>`__.

    .. raw:: html

       <div class="NOTE">

    +----------------+----------------+----------------+----------------+----------------+
    | |Note|         |
    |  In a          |
    | `pipe <special |
    | -chars.html#PI |
    | PEREF>`__,     |
    | it may be more |
    | efficient to   |
    | `redirect <io- |
    | redirection.ht |
    | ml#IOREDIRREF> |
    | `__            |
    | the ``stdin``  |
    | to a file,     |
    | rather than to |
    | **cat** the    |
    | file.          |
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
    | |     cat file |
    | name | tr a- | |
    | | z A-Z        |
    |              | |
    | |              |
    |              | |
    | |     tr a-z A |
    | -Z < filenam | |
    | | e   #  Same  |
    | effect, but  | |
    | | starts one l |
    | ess process, | |
    | |              |
    |              | |
    | |     #+ and a |
    | lso dispense | |
    | | s with the p |
    | ipe.         | |
    |                |
    |                |
    | +------------- |
    | -------------+ |
    | -------------- |
    | ------------+- |
    | -------------- |
    | -----------+   |
    |                |
    | .. raw:: html  |
    |                |
    |    </p>        |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

    **tac**, is the inverse of *cat*, listing a file backwards from its
    end.

\ **rev**
    reverses each line of a file, and outputs to ``stdout``. This does
    not have the same effect as **tac**, as it preserves the order of
    the lines, but flips each one around (mirror image).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ cat file1.txt  |
    |     This is line 1.      |
    |      This is line 2.     |
    |                          |
    |                          |
    |     bash$ tac file1.txt  |
    |     This is line 2.      |
    |      This is line 1.     |
    |                          |
    |                          |
    |     bash$ rev file1.txt  |
    |     .1 enil si sihT      |
    |      .2 enil si sihT     |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

\ **cp**
    This is the file copy command. ``cp file1           file2`` copies
    ``file1`` to ``file2``, overwriting ``file2`` if it already exists
    (see `Example 16-6 <moreadv.html#EX42>`__).

    .. raw:: html

       <div class="TIP">

    +----------------+----------------+----------------+----------------+----------------+
    | |Tip|          |
    | Particularly   |
    | useful are the |
    | ``-a`` archive |
    | flag (for      |
    | copying an     |
    | entire         |
    | directory      |
    | tree), the     |
    | ``-u`` update  |
    | flag (which    |
    | prevents       |
    | overwriting    |
    | identically-na |
    | med            |
    | newer files),  |
    | and the ``-r`` |
    | and ``-R``     |
    | recursive      |
    | flags.         |
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
    | |     cp -u so |
    | urce_dir/* d | |
    | | est_dir      |
    |              | |
    | |     #  "Sync |
    | hronize" des | |
    | | t_dir to sou |
    | rce_dir      | |
    | |     #+  by c |
    | opying over  | |
    | | all newer an |
    | d not previo | |
    | | usly existin |
    | g files.     | |
    |                |
    |                |
    | +------------- |
    | -------------+ |
    | -------------- |
    | ------------+- |
    | -------------- |
    | -----------+   |
    |                |
    | .. raw:: html  |
    |                |
    |    </p>        |
                    
    +----------------+----------------+----------------+----------------+----------------+

    .. raw:: html

       </div>

\ **mv**
    This is the file *move* command. It is equivalent to a combination
    of **cp** and **rm**. It may be used to move multiple files to a
    directory, or even to rename a directory. For some examples of using
    **mv** in a script, see `Example
    10-11 <parameter-substitution.html#RFE>`__ and `Example
    A-2 <contributed-scripts.html#RN>`__.

    .. raw:: html

       <div class="NOTE">

    +--------------+--------------+--------------+--------------+--------------+--------------+
    | |Note|       |
    | When used in |
    | a            |
    | non-interact |
    | ive          |
    | script,      |
    | **mv** takes |
    | the ``-f``   |
    | (*force*)    |
    | option to    |
    | bypass user  |
    | input.       |
    |              |
    | When a       |
    | directory is |
    | moved to a   |
    | preexisting  |
    | directory,   |
    | it becomes a |
    | subdirectory |
    | of the       |
    | destination  |
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
    | |     bash$  |
    | mv source_di |
    | re |         |
    | | ctory targ |
    | et_directory |
    |    |         |
    | |            |
    |              |
    |    |         |
    | |     bash$  |
    | ls -lF targe |
    | t_ |         |
    | | directory  |
    |              |
    |    |         |
    | |     total  |
    | 1            |
    |    |         |
    | |      drwxr |
    | wxr-x    2 b |
    | oz |         |
    | | o  bozo    |
    |    1024 May  |
    | 28 |         |
    | |  19:20 sou |
    | rce_director |
    | y/ |         |
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
    | .. raw:: htm |
    | l            |
    |              |
    |    </p>      |
                  
    +--------------+--------------+--------------+--------------+--------------+--------------+

    .. raw:: html

       </div>

\ **rm**
    Delete (remove) a file or files. The ``-f`` option forces removal of
    even readonly files, and is useful for bypassing user input in a
    script.

    .. raw:: html

       <div class="NOTE">

    +--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
    | |Note| |
    |        |
    | The    |
    | *rm*   |
    | comman |
    | d      |
    | will,  |
    | by     |
    | itself |
    | ,      |
    | fail   |
    | to     |
    | remove |
    | filena |
    | mes    |
    | beginn |
    | ing    |
    | with a |
    | dash.  |
    | Why?   |
    | Becaus |
    | e      |
    | *rm*   |
    | sees a |
    | dash-p |
    | refixe |
    | d      |
    | filena |
    | me     |
    | as an  |
    | *optio |
    | n*.    |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    | | .. c |
    | ode::  |
    | SCREEN |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | bash$  |
    | rm -ba |
    | dname  |
    |    |   |
    | |      |
    | rm: in |
    | valid  |
    | option |
    |  - |   |
    | | - b  |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    |  Try ` |
    | rm --h |
    | elp' f |
    | or |   |
    | |  mor |
    | e info |
    | rmatio |
    | n.     |
    |    |   |
    |        |
    |        |
    |        |
    |        |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    |        |
    | .. raw |
    | :: htm |
    | l      |
    |        |
    |    </p |
    | >      |
    |        |
    | One    |
    | clever |
    | workar |
    | ound   |
    | is to  |
    | preced |
    | e      |
    | the    |
    | filena |
    | me     |
    | with a |
    | " -- " |
    | (the   |
    | *end-o |
    | f-opti |
    | ons*   |
    | flag). |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    | | .. c |
    | ode::  |
    | SCREEN |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | bash$  |
    | rm --  |
    | -badna |
    | me |   |
    |        |
    |        |
    |        |
    |        |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    |        |
    | .. raw |
    | :: htm |
    | l      |
    |        |
    |    </p |
    | >      |
    |        |
    | Anothe |
    | r      |
    | method |
    | to is  |
    | to     |
    | prefac |
    | e      |
    | the    |
    | filena |
    | me     |
    | to be  |
    | remove |
    | d      |
    | with a |
    | ``dot- |
    | slash` |
    | `      |
    | .      |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    | | .. c |
    | ode::  |
    | SCREEN |
    |        |
    |    |   |
    | |      |
    |        |
    |        |
    |        |
    |    |   |
    | |      |
    | bash$  |
    | rm ./- |
    | badnam |
    | e  |   |
    |        |
    |        |
    |        |
    |        |
    |        |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+-- |
    | ------ |
    | ------ |
    | ------ |
    | ------ |
    | +----- |
    | ------ |
    | ------ |
    | ------ |
    | ---+   |
    |        |
    | .. raw |
    | :: htm |
    | l      |
    |        |
    |    </p |
    | >      |
            
    +--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="WARNING">

    +--------------------------------------+--------------------------------------+
    | |Warning|                            |
    | When used with the recursive flag    |
    | ``-r``, this command removes files   |
    | all the way down the directory tree  |
    | from the current directory. A        |
    | careless **rm -rf \*** can wipe out  |
    | a big chunk of a directory           |
    | structure.                           |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

\ **rmdir**
    Remove directory. The directory must be empty of all files --
    including "invisible" *dotfiles* `[2] <basic.html#FTN.AEN10228>`__
    -- for this command to succeed.

\ **mkdir**
    Make directory, creates a new directory. For example,
    ``mkdir -p project/programs/December`` creates the named directory.
    The ``-p`` option automatically creates any necessary parent
    directories.

\ **chmod**
    Changes the attributes of an existing file or directory (see
    `Example 15-14 <internal.html#EX44>`__).

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     chmod +x filename    |
    |     # Makes "filename" e |
    | xecutable for all users. |
    |                          |
    |     chmod u+s filename   |
    |     # Sets "suid" bit on |
    |  "filename" permissions. |
    |     # An ordinary user m |
    | ay execute "filename" wi |
    | th same privileges as th |
    | e file's owner.          |
    |     # (This does not app |
    | ly to shell scripts.)    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     chmod 644 filename   |
    |     #  Makes "filename"  |
    | readable/writable to own |
    | er, readable to others   |
    |     #+ (octal mode).     |
    |                          |
    |     chmod 444 filename   |
    |     #  Makes "filename"  |
    | read-only for all.       |
    |     #  Modifying the fil |
    | e (for example, with a t |
    | ext editor)              |
    |     #+ not allowed for a |
    |  user who does not own t |
    | he file (except for root |
    | ),                       |
    |     #+ and even the file |
    |  owner must force a file |
    | -save                    |
    |     #+ if she modifies t |
    | he file.                 |
    |     #  Same restrictions |
    |  apply for deleting the  |
    | file.                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     chmod 1777 directory |
    | -name                    |
    |     #  Gives everyone re |
    | ad, write, and execute p |
    | ermission in directory,  |
    |     #+ however also sets |
    |  the "sticky bit".       |
    |     #  This means that o |
    | nly the owner of the dir |
    | ectory,                  |
    |     #+ owner of the file |
    | , and, of course, root   |
    |     #+ can delete any pa |
    | rticular file in that di |
    | rectory.                 |
    |                          |
    |     chmod 111 directory- |
    | name                     |
    |     #  Gives everyone ex |
    | ecute-only permission in |
    |  a directory.            |
    |     #  This means that y |
    | ou can execute and READ  |
    | the files in that direct |
    | ory                      |
    |     #+ (execute permissi |
    | on necessarily includes  |
    | read permission          |
    |     #+ because you can't |
    |  execute a file without  |
    | being able to read it).  |
    |     #  But you can't lis |
    | t the files or search fo |
    | r them with the "find" c |
    | ommand.                  |
    |     #  These restriction |
    | s do not apply to root.  |
    |                          |
    |     chmod 000 directory- |
    | name                     |
    |     #  No permissions at |
    |  all for that directory. |
    |     #  Can't read, write |
    | , or execute files in it |
    | .                        |
    |     #  Can't even list f |
    | iles in it or "cd" to it |
    | .                        |
    |     #  But, you can rena |
    | me (mv) the directory    |
    |     #+ or delete it (rmd |
    | ir) if it is empty.      |
    |     #  You can even syml |
    | ink to files in the dire |
    | ctory,                   |
    |     #+ but you can't rea |
    | d, write, or execute the |
    |  symlinks.               |
    |     #  These restriction |
    | s do not apply to root.  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

\ **chattr**
    **Ch**\ ange file **attr**\ ibutes. This is analogous to **chmod**
    above, but with different options and a different invocation syntax,
    and it works only on *ext2/ext3* filesystems.

    One particularly interesting **chattr** option is ``i``. A **chattr
    +i ``filename``** marks the file as immutable. The file cannot be
    modified, linked to, or deleted, *not even by root*. This file
    attribute can be set or removed only by *root*. In a similar
    fashion, the ``a`` option marks the file as append only.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     root# chattr +i file |
    | 1.txt                    |
    |                          |
    |                          |
    |     root# rm file1.txt   |
    |                          |
    |     rm: remove write-pro |
    | tected regular file `fil |
    | e1.txt'? y               |
    |      rm: cannot remove ` |
    | file1.txt': Operation no |
    | t permitted              |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    If a file has the ``s`` (secure) attribute set, then when it is
    deleted its block is overwritten with binary zeroes.
    `[3] <basic.html#FTN.AEN10301>`__

    If a file has the ``u`` (undelete) attribute set, then when it is
    deleted, its contents can still be retrieved (undeleted).

    If a file has the ``c`` (compress) attribute set, then it will
    automatically be compressed on writes to disk, and uncompressed on
    reads.

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | The file attributes set with         |
    | **chattr** do not show in a file     |
    | listing (**ls -l**).                 |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

\ **ln**
    Creates links to pre-existings files. A "link" is a reference to a
    file, an alternate name for it. The **ln** command permits
    referencing the linked file by more than one name and is a superior
    alternative to aliasing (see `Example
    4-6 <othertypesv.html#EX18>`__).

    The **ln** creates only a reference, a pointer to the file only a
    few bytes in size.

    The **ln** command is most often used with the ``-s``, symbolic or
    "soft" link flag. Advantages of using the ``-s`` flag are that it
    permits linking across file systems or to directories.

    The syntax of the command is a bit tricky. For example:
    ``ln -s oldfile newfile`` links the previously existing ``oldfile``
    to the newly created link, ``newfile``.

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | If a file named ``newfile`` has      |
    | previously existed, an error message |
    | will result.                         |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

    +--------------------------------------------------------------------------+
    | .. raw:: html                                                            |
    |                                                                          |
    |    <div class="SIDEBAR">                                                 |
    |                                                                          |
    | **Which type of link to use?**                                           |
    |                                                                          |
    | As John Macdonald explains it:                                           |
    |                                                                          |
    | Both of these [types of links] provide a certain measure of dual         |
    | reference -- if you edit the contents of the file using any name, your   |
    | changes will affect both the original name and either a hard or soft new |
    | name. The differences between them occurs when you work at a higher      |
    | level. The advantage of a hard link is that the new name is totally      |
    | independent of the old name -- if you remove or rename the old name,     |
    | that does not affect the hard link, which continues to point to the data |
    | while it would leave a soft link hanging pointing to the old name which  |
    | is no longer there. The advantage of a soft link is that it can refer to |
    | a different file system (since it is just a reference to a file name,    |
    | not to actual data). And, unlike a hard link, a symbolic link can refer  |
    | to a directory.                                                          |
    |                                                                          |
    | .. raw:: html                                                            |
    |                                                                          |
    |    </div>                                                                |
                                                                              
    +--------------------------------------------------------------------------+

    Links give the ability to invoke a script (or any other type of
    executable) with multiple names, and having that script behave
    according to how it was invoked.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-2. Hello or Good-bye**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # hello.sh: Saying " |
    | hello" or "goodbye"      |
    |     #+          dependin |
    | g on how script is invok |
    | ed.                      |
    |                          |
    |     # Make a link in cur |
    | rent working directory ( |
    | $PWD) to this script:    |
    |     #    ln -s hello.sh  |
    | goodbye                  |
    |     # Now, try invoking  |
    | this script both ways:   |
    |     # ./hello.sh         |
    |     # ./goodbye          |
    |                          |
    |                          |
    |     HELLO_CALL=65        |
    |     GOODBYE_CALL=66      |
    |                          |
    |     if [ $0 = "./goodbye |
    | " ]                      |
    |     then                 |
    |       echo "Good-bye!"   |
    |       # Some other goodb |
    | ye-type commands, as app |
    | ropriate.                |
    |       exit $GOODBYE_CALL |
    |     fi                   |
    |                          |
    |     echo "Hello!"        |
    |     # Some other hello-t |
    | ype commands, as appropr |
    | iate.                    |
    |     exit $HELLO_CALL     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

\ **man**, \ **info**
    These commands access the manual and information pages on system
    commands and installed utilities. When available, the *info* pages
    usually contain more detailed descriptions than do the *man* pages.

    There have been various attempts at "automating" the writing of *man
    pages*. For a script that makes a tentative first step in that
    direction, see `Example A-39 <contributed-scripts.html#MANED>`__.

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

`[1] <basic.html#AEN10025>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

The ``-v`` option also orders the sort by *upper- and lowercase
prefixed* filenames.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[2] <basic.html#AEN10228>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

*Dotfiles* are files whose names begin with a *dot*, such as
``~/.Xdefaults``. Such filenames do not appear in a normal **ls**
listing (although an **ls -a** will show them), and they cannot be
deleted by an accidental **rm -rf \***. Dotfiles are generally used as
setup and configuration files in a user's home directory.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="LEFT" valign="TOP" width="5%">

`[3] <basic.html#AEN10301>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="LEFT" valign="TOP" width="95%">

This particular feature may not yet be implemented in the version of the
ext2/ext3 filesystem installed on your system. Check the documentation
for your Linux distro.

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
| `Prev <external.html>`__ | External Filters,        |
| `Home <index.html>`__    | Programs and Commands    |
| `Next <moreadv.html>`__  | `Up <external.html>`__   |
|                          | Complex Commands         |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Tip| image:: ../images/tip.gif
.. |Note| image:: ../images/note.gif
.. |Warning| image:: ../images/warning.gif
.. |Caution| image:: ../images/caution.gif
