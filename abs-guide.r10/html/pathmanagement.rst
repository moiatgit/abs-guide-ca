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

`Prev <awk.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <exitcodes.html>`__

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

Appendix D. Parsing and Managing Pathnames
==========================================

Emmanual Rouat contributed the following example of parsing and
transforming *filenames* and, in particular,
`pathnames <special-chars.html#PATHNAMEREF>`__. It draws heavily on the
functionality of *sed*.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/usr/bin/env bash  |
|     #------------------- |
| ------------------------ |
| ----------------         |
|     # Management of PATH |
| , LD_LIBRARY_PATH, MANPA |
| TH variables...          |
|     # By Emmanuel Rouat  |
| <no-email>               |
|     # (Inspired by the b |
| ash documentation 'pathf |
| uncs' and on             |
|     # discussions found  |
| on stackoverflow:        |
|     # http://stackoverfl |
| ow.com/questions/370047/ |
|     # http://stackoverfl |
| ow.com/questions/273909/ |
| #346860 )                |
|     # Last modified: Sat |
|  Sep 22 12:01:55 CEST 20 |
| 12                       |
|     #                    |
|     # The following func |
| tions handle spaces corr |
| ectly.                   |
|     # These functions be |
| long in .bash_profile ra |
| ther than in             |
|     # .bashrc, I guess.  |
|     #                    |
|     # The modular aspect |
|  of these functions shou |
| ld make it easy          |
|     # to expand them to  |
| handle path substitution |
| s instead                |
|     # of path removal et |
| c....                    |
|     #                    |
|     # See http://www.cat |
| onmat.net/blog/awk-one-l |
| iners-explained-part-two |
| /                        |
|     # (item 43) for an e |
| xplanation of the 'dupli |
| cate-entries' removal    |
|     # (it's a nice trick |
| !)                       |
|     #------------------- |
| ------------------------ |
| ----------------         |
|                          |
|     # Show $@ (usually P |
| ATH) as list.            |
|     function p_show() {  |
| local p="$@" && for p; d |
| o [[ ${!p} ]] &&         |
|     echo -e ${!p//:/\\n} |
| ; done }                 |
|                          |
|     # Filter out empty l |
| ines, multiple/trailing  |
| slashes, and duplicate e |
| ntries.                  |
|     function p_filter()  |
|     { awk '/^[ \t]*$/ {n |
| ext} {sub(/\/+$/, "");gs |
| ub(/\/+/, "/")}!x[$0]++' |
|  ;}                      |
|                          |
|     # Rebuild list of it |
| ems into ':' separated w |
| ord (PATH-like).         |
|     function p_build() { |
|  paste -sd: ;}           |
|                          |
|     # Clean $1 (typicall |
| y PATH) and rebuild it   |
|     function p_clean()   |
|     { local p=${1} && ev |
| al ${p}='$(p_show ${p} | |
|  p_filter | p_build)' ;} |
|                          |
|     # Remove $1 from $2  |
| (found on stackoverflow, |
|  with modifications).    |
|     function p_rm()      |
|     { local d=$(echo $1  |
| | p_filter) p=${2} &&    |
|       eval ${p}='$(p_sho |
| w ${p} | p_filter | grep |
|  -xv "${d}" | p_build)'  |
| ;}                       |
|                          |
|     #  Same as previous, |
|  but filters on a patter |
| n (dangerous...          |
|     #+ don't use 'bin' o |
| r '/' as pattern!).      |
|     function p_rmpat()   |
|     { local d=$(echo $1  |
| | p_filter) p=${2} && ev |
| al ${p}='$(p_show ${p} | |
|       p_filter | grep -v |
|  "${d}" | p_build)' ;}   |
|                          |
|     # Delete $1 from $2  |
| and append it cleanly.   |
|     function p_append()  |
|     { local d=$(echo $1  |
| | p_filter) p=${2} && p_ |
| rm "${d}" ${p} &&        |
|       eval ${p}='$(p_sho |
| w ${p} d | p_build)' ;}  |
|                          |
|     # Delete $1 from $2  |
| and prepend it cleanly.  |
|     function p_prepend() |
|     { local d=$(echo $1  |
| | p_filter) p=${2} && p_ |
| rm "${d}" ${p} &&        |
|       eval ${p}='$(p_sho |
| w d ${p} | p_build)' ;}  |
|                          |
|     # Some tests:        |
|     echo                 |
|     MYPATH="/bin:/usr/bi |
| n/:/bin://bin/"          |
|     p_append "/project// |
| my project/bin" MYPATH   |
|     echo "Append '/proje |
| ct//my project/bin' to ' |
| /bin:/usr/bin/:/bin://bi |
| n/'"                     |
|     echo "(result should |
|  be: /bin:/usr/bin:/proj |
| ect/my project/bin)"     |
|     echo $MYPATH         |
|                          |
|     echo                 |
|     MYOTHERPATH="/bin:/u |
| sr/bin/:/bin:/project//m |
| y project/bin"           |
|     p_prepend "/project/ |
| /my project/bin" MYOTHER |
| PATH                     |
|     echo "Prepend '/proj |
| ect//my project/bin' \   |
|     to '/bin:/usr/bin/:/ |
| bin:/project//my project |
| /bin/'"                  |
|     echo "(result should |
|  be: /project/my project |
| /bin:/bin:/usr/bin)"     |
|     echo $MYOTHERPATH    |
|                          |
|     echo                 |
|     p_prepend "/project/ |
| /my project/bin" FOOPATH |
|   # FOOPATH doesn't exis |
| t.                       |
|     echo "Prepend '/proj |
| ect//my project/bin' to  |
| an unset variable"       |
|     echo "(result should |
|  be: /project/my project |
| /bin)"                   |
|     echo $FOOPATH        |
|                          |
|     echo                 |
|     BARPATH="/a:/b/://b  |
| c://a:/my local pub"     |
|     p_clean BARPATH      |
|     echo "Clean BARPATH= |
| '/a:/b/://b c://a:/my lo |
| cal pub'"                |
|     echo "(result should |
|  be: /a:/b:/b c:/my loca |
| l pub)"                  |
|     echo $BARPATH        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

\*\*\*

David Wheeler kindly permitted me to use his instructive examples.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     Doing it correctly:  |
| A quick summary          |
|     by David Wheeler     |
|     http://www.dwheeler. |
| com/essays/filenames-in- |
| shell.html               |
|                          |
|     So, how can you proc |
| ess filenames correctly  |
| in shell? Here's a quick |
|     summary about how to |
|  do it correctly, for th |
| e impatient who "just wa |
| nt the                   |
|     answer". In short: D |
| ouble-quote to use "$var |
| iable" instead of $varia |
| ble,                     |
|     set IFS to just newl |
| ine and tab, prefix all  |
| globs/filenames so they  |
| cannot                   |
|     begin with "-" when  |
| expanded, and use one of |
|  a few templates that wo |
| rk                       |
|     correctly. Here are  |
| some of those templates  |
| that work correctly:     |
|                          |
|                          |
|      IFS="$(printf '\n\t |
| ')"                      |
|      # Remove SPACE, so  |
| filenames with spaces wo |
| rk well.                 |
|                          |
|      #  Correct glob use |
| :                        |
|      #+ always use "for" |
|  loop, prefix glob, chec |
| k for existence:         |
|      for file in ./* ; d |
| o          # Use "./*" . |
| .. NEVER bare "*" ...    |
|        if [ -e "$file" ] |
|  ; then    # Make sure i |
| t isn't an empty match.  |
|          COMMAND ... "$f |
| ile" ...                 |
|        fi                |
|      done                |
|                          |
|                          |
|                          |
|      # Correct glob use, |
|  but requires nonstandar |
| d bash extension.        |
|      shopt -s nullglob   |
| #  Bash extension,       |
|                          |
| #+ so that empty glob ma |
| tches will work.         |
|      for file in ./* ; d |
| o        # Use "./*", NE |
| VER bare "*"             |
|        COMMAND ... "$fil |
| e" ...                   |
|      done                |
|                          |
|                          |
|                          |
|      #  These handle all |
|  filenames correctly;    |
|      #+ can be unwieldy  |
| if COMMAND is large:     |
|      find ... -exec COMM |
| AND... {} \;             |
|      find ... -exec COMM |
| AND... {} \+ # If multip |
| le files are okay for CO |
| MMAND.                   |
|                          |
|                          |
|                          |
|      #  This skips filen |
| ames with control charac |
| ters                     |
|      #+ (including tab a |
| nd newline).             |
|      IFS="$(printf '\n\t |
| ')"                      |
|      controlchars="$(pri |
| ntf '*[\001-\037\177]*') |
| "                        |
|      for file in $(find  |
| . ! -name "$controlchars |
| "') ; do                 |
|        COMMAND "$file" . |
| ..                       |
|      done                |
|                          |
|                          |
|                          |
|      #  Okay if filename |
| s can't contain tabs or  |
| newlines --              |
|      #+ beware the assum |
| ption.                   |
|      IFS="$(printf '\n\t |
| ')"                      |
|      for file in $(find  |
| .) ; do                  |
|        COMMAND "$file" . |
| ..                       |
|      done                |
|                          |
|                          |
|                          |
|      # Requires nonstand |
| ard but common extension |
| s in find and xargs:     |
|      find . -print0 | xa |
| rgs -0 COMMAND           |
|                          |
|      # Requires nonstand |
| ard extensions to find a |
| nd to shell (bash works) |
| .                        |
|      # variables might n |
| ot stay set once the loo |
| p ends:                  |
|      find . -print0 | wh |
| ile IFS="" read -r -d "" |
|  file ; do ...           |
|        COMMAND "$file" # |
|  Use quoted "$file", not |
|  $file, everywhere.      |
|      done                |
|                          |
|                          |
|                          |
|      #  Requires nonstan |
| dard extensions to find  |
| and to shell (bash works |
| ).                       |
|      #  Underlying syste |
| m must include named pip |
| es (FIFOs)               |
|      #+ or the /dev/fd m |
| echanism.                |
|      #  In this version, |
|  variables *do* stay set |
|  after the loop ends,    |
|      #  and you can read |
|  from stdin.             |
|      #+ (Change the 4 to |
|  another number if fd 4  |
| is needed.)              |
|                          |
|      while IFS="" read - |
| r -d "" file <&4 ; do    |
|        COMMAND "$file"   |
|  # Use quoted "$file" -- |
|  not $file, everywhere.  |
|      done 4< <(find . -p |
| rint0)                   |
|                          |
|                          |
|      #  Named pipe versi |
| on.                      |
|      #  Requires nonstan |
| dard extensions to find  |
| and to shell's read (bas |
| h ok).                   |
|      #  Underlying syste |
| m must include named pip |
| es (FIFOs).              |
|      #  Again, in this v |
| ersion, variables *do* s |
| tay set after the loop e |
| nds,                     |
|      #  and you can read |
|  from stdin.             |
|      # (Change the 4 to  |
| something else if fd 4 n |
| eeded).                  |
|                          |
|      mkfifo mypipe       |
|                          |
|      find . -print0 > my |
| pipe &                   |
|      while IFS="" read - |
| r -d "" file <&4 ; do    |
|        COMMAND "$file" # |
|  Use quoted "$file", not |
|  $file, everywhere.      |
|      done 4< mypipe      |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <awk.html>`__      | Awk                      |
| `Home <index.html>`__    |                          |
| `Next <exitcodes.html>`_ | Exit Codes With Special  |
| _                        | Meanings                 |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

