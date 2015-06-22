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

`Prev <sample-bashrc.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <exercises.html>`__

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

   <div class="APPENDIX">

  Appendix N. Converting DOS Batch Files to Shell Scripts
========================================================

Quite a number of programmers learned scripting on a PC running DOS.
Even the crippled DOS batch file language allowed writing some fairly
powerful scripts and applications, though they often required extensive
kludges and workarounds. Occasionally, the need still arises to convert
an old DOS batch file to a UNIX shell script. This is generally not
difficult, as DOS batch file operators are only a limited subset of the
equivalent shell scripting ones.

.. raw:: html

   <div class="TABLE">

**Table N-1. Batch file keywords / variables / operators, and their
shell equivalents**

+--------------------------+--------------------------+--------------------------+
| Batch File Operator      |
| Shell Script Equivalent  |
| Meaning                  |
+==========================+==========================+==========================+
| ``          %         `` | ``          /         `` | ``          \         `` |
| $                        | -                        | /                        |
| command-line parameter   | command option flag      | directory path separator |
| prefix                   |                          |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Batch files usually contain DOS commands. These must be translated into
their UNIX equivalents in order to convert a batch file into a shell
script.

.. raw:: html

   <div class="TABLE">

**Table N-2. DOS commands and their UNIX equivalents**

+--------------------------+--------------------------+--------------------------+
| DOS Command              |
| UNIX Equivalent          |
| Effect                   |
+==========================+==========================+==========================+
| ``          ASSIGN       | ``          ATTRIB       | ``          CD         ` |
|    ``                    |    ``                    | `                        |
| ln                       | chmod                    | cd                       |
| link file or directory   | change file permissions  | change directory         |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="NOTE">

+--------------------------+--------------------------+--------------------------+
| |Note|                   |
| Virtually all UNIX and   |
| shell operators and      |
| commands have many more  |
| options and enhancements |
| than their DOS and batch |
| file counterparts. Many  |
| DOS batch files rely on  |
| auxiliary utilities,     |
| such as **ask.com** , a  |
| crippled counterpart to  |
| `read <internal.html#REA |
| DREF>`__                 |
| .                        |
|                          |
| DOS supports only a very |
| limited and incompatible |
| subset of filename       |
| `wild-card               |
| expansion <globbingref.h |
| tml>`__                  |
| , recognizing just the   |
| \* and ? characters.     |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Converting a DOS batch file into a shell script is generally
straightforward, and the result ofttimes reads better than the original.

.. raw:: html

   <div class="EXAMPLE">

**Example N-1. VIEWDATA.BAT: DOS Batch File**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     REM VIEWDATA         |
|                          |
|     REM INSPIRED BY AN E |
| XAMPLE IN "DOS POWERTOOL |
| S"                       |
|     REM                  |
|           BY PAUL SOMERS |
| ON                       |
|                          |
|                          |
|     @ECHO OFF            |
|                          |
|     IF !%1==! GOTO VIEWD |
| ATA                      |
|     REM  IF NO COMMAND-L |
| INE ARG...               |
|     FIND "%1" C:\BOZO\BO |
| OKLIST.TXT               |
|     GOTO EXIT0           |
|     REM  PRINT LINE WITH |
|  STRING MATCH, THEN EXIT |
| .                        |
|                          |
|     :VIEWDATA            |
|     TYPE C:\BOZO\BOOKLIS |
| T.TXT | MORE             |
|     REM  SHOW ENTIRE FIL |
| E, 1 PAGE AT A TIME.     |
|                          |
|     :EXIT0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

The script conversion is somewhat of an improvement. ` [1]
 <dosbatch.html#FTN.AEN24713>`__

.. raw:: html

   <div class="EXAMPLE">

**Example N-2. *viewdata.sh* : Shell Script Conversion of VIEWDATA.BAT**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # viewdata.sh        |
|     # Conversion of VIEW |
| DATA.BAT to shell script |
| .                        |
|                          |
|     DATAFILE=/home/bozo/ |
| datafiles/book-collectio |
| n.data                   |
|     ARGNO=1              |
|                          |
|     # @ECHO OFF          |
|         Command unnecess |
| ary here.                |
|                          |
|     if [ $# -lt "$ARGNO" |
|  ]    # IF !%1==! GOTO V |
| IEWDATA                  |
|     then                 |
|       less $DATAFILE     |
|       # TYPE C:\MYDIR\BO |
| OKLIST.TXT | MORE        |
|     else                 |
|       grep "$1" $DATAFIL |
| E     # FIND "%1" C:\MYD |
| IR\BOOKLIST.TXT          |
|     fi                   |
|                          |
|     exit 0               |
|       # :EXIT0           |
|                          |
|     #  GOTOs, labels, sm |
| oke-and-mirrors, and fli |
| mflam unnecessary.       |
|     #  The converted scr |
| ipt is short, sweet, and |
|  clean,                  |
|     #+ which is more tha |
| n can be said for the or |
| iginal.                  |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Ted Davis' `Shell Scripts on the PC <http://www.maem.umr.edu/batch/>`__
site had a set of comprehensive tutorials on the old-fashioned art of
batch file programming. Unfortunately the page has vanished without a
trace.

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <dosbatch.html#AEN24713>`__   |
| Various readers have suggested       |
| modifications of the above batch     |
| file to prettify it and make it more |
| compact and efficient. In the        |
| opinion of the *ABS Guide* author,   |
| this is wasted effort. A Bash script |
| can access a DOS filesystem, or even |
| an NTFS partition (with the help of  |
| `ntfs-3g <http://www.ntfs-3g.org>`__ |
| ) to do batch or scripted            |
| operations.                          |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

.. raw:: html

   <table border="0" cellpadding="0" cellspacing="0" summary="Footer navigation table" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

`Prev <sample-bashrc.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

`Home <index.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

`Next <exercises.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

Sample ``        .bashrc       `` and ``        .bash_profile       ``
Files

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

Exercises

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
