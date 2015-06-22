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

`Prev <manipulatingvars.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 10. Manipulating Variables

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <parameter-substitution.html>`__

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

10.1. Manipulating Strings
==========================

Bash supports a surprising number of string manipulation operations.
Unfortunately, these tools lack a unified focus. Some are a subset of
`parameter substitution <parameter-substitution.html#PARAMSUBREF>`__,
and others fall under the functionality of the UNIX
`expr <moreadv.html#EXPRREF>`__ command. This results in inconsistent
command syntax and overlap of functionality, not to mention confusion.

.. raw:: html

   <div class="VARIABLELIST">

**String Length**

${#string}
expr length $string
    These are the equivalent of *strlen()* in *C*.

expr "$string" : '.\*'
    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |                          |
    |     echo ${#stringZ}     |
    |              # 15        |
    |     echo `expr length $s |
    | tringZ`      # 15        |
    |     echo `expr "$stringZ |
    | " : '.*'`    # 15        |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 10-1. Inserting a blank line between paragraphs in a text
file**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # paragraph-space.sh |
|     # Ver. 2.1, Reldate  |
| 29Jul12 [fixup]          |
|                          |
|     # Inserts a blank li |
| ne between paragraphs of |
|  a single-spaced text fi |
| le.                      |
|     # Usage: $0 <FILENAM |
| E                        |
|                          |
|     MINLEN=60        # C |
| hange this value? It's a |
|  judgment call.          |
|     #  Assume lines shor |
| ter than $MINLEN charact |
| ers ending in a period   |
|     #+ terminate a parag |
| raph. See exercises belo |
| w.                       |
|                          |
|     while read line  # F |
| or as many lines as the  |
| input file has ...       |
|     do                   |
|       echo "$line"   # O |
| utput the line itself.   |
|                          |
|       len=${#line}       |
|       if [[ "$len" -lt " |
| $MINLEN" && "$line" =~ [ |
| *{\.}]$ ]]               |
|     # if [[ "$len" -lt " |
| $MINLEN" && "$line" =~ \ |
| [*\.\] ]]                |
|     # An update to Bash  |
| broke the previous versi |
| on of this script. Ouch! |
|     # Thank you, Halim S |
| rama, for pointing this  |
| out and suggesting a fix |
| .                        |
|         then echo    #   |
| Add a blank line immedia |
| tely                     |
|       fi             #+  |
| after a short line termi |
| nated by a period.       |
|     done                 |
|                          |
|     exit                 |
|                          |
|     # Exercises:         |
|     # ---------          |
|     #  1) The script usu |
| ally inserts a blank lin |
| e at the end             |
|     #+    of the target  |
| file. Fix this.          |
|     #  2) Line 17 only c |
| onsiders periods as sent |
| ence terminators.        |
|     #     Modify this to |
|  include other common en |
| d-of-sentence characters |
| ,                        |
|     #+    such as ?, !,  |
| and ".                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Length of Matching Substring at Beginning of String**

expr match "$string" '$substring'
    ``$substring`` is a `regular expression <regexp.html#REGEXREF>`__.

expr "$string" : '$substring'
    ``$substring`` is a regular expression.

    

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |     #       |------|     |
    |     #       12345678     |
    |                          |
    |     echo `expr match "$s |
    | tringZ" 'abc[A-Z]*.2'`   |
    |  # 8                     |
    |     echo `expr "$stringZ |
    | " : 'abc[A-Z]*.2'`       |
    |  # 8                     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Index**

expr index $string $substring
    Numerical position in $string of first character in $substring that
    matches.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |     #       123456 ...   |
    |     echo `expr index "$s |
    | tringZ" C12`             |
    |  # 6                     |
    |                          |
    |                          |
    |  # C position.           |
    |                          |
    |     echo `expr index "$s |
    | tringZ" 1c`              |
    |  # 3                     |
    |     # 'c' (in #3 positio |
    | n) matches before '1'.   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    This is the near equivalent of *strchr()* in *C*.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Substring Extraction**

${string:position}
    Extracts substring from ``$string`` at ``$position``.

    If the ``$string`` parameter is "\*" or "@", then this extracts the
    `positional parameters <internalvariables.html#POSPARAMREF>`__,
    `[1] <string-manipulation.html#FTN.AEN5987>`__ starting at
    ``$position``.

${string:position:length}
    Extracts ``$length`` characters of substring from ``$string`` at
    ``$position``.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |     #       0123456789.. |
    | ...                      |
    |     #       0-based inde |
    | xing.                    |
    |                          |
    |     echo ${stringZ:0}    |
    |                          |
    |  # abcABC123ABCabc       |
    |     echo ${stringZ:1}    |
    |                          |
    |  # bcABC123ABCabc        |
    |     echo ${stringZ:7}    |
    |                          |
    |  # 23ABCabc              |
    |                          |
    |     echo ${stringZ:7:3}  |
    |                          |
    |  # 23A                   |
    |                          |
    |                          |
    |  # Three characters of s |
    | ubstring.                |
    |                          |
    |                          |
    |                          |
    |     # Is it possible to  |
    | index from the right end |
    |  of the string?          |
    |                          |
    |     echo ${stringZ:-4}   |
    |                          |
    |  # abcABC123ABCabc       |
    |     # Defaults to full s |
    | tring, as in ${parameter |
    | :-default}.              |
    |     # However . . .      |
    |                          |
    |     echo ${stringZ:(-4)} |
    |                          |
    |  # Cabc                  |
    |     echo ${stringZ: -4}  |
    |                          |
    |  # Cabc                  |
    |     # Now, it works.     |
    |     # Parentheses or add |
    | ed space "escape" the po |
    | sition parameter.        |
    |                          |
    |     # Thank you, Dan Jac |
    | obson, for pointing this |
    |  out.                    |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    The *position* and *length* arguments can be "parameterized," that
    is, represented as a variable, rather than as a numerical constant.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 10-2. Generating an 8-character "random" string**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # rand-string.sh     |
    |     # Generating an 8-ch |
    | aracter "random" string. |
    |                          |
    |     if [ -n "$1" ]  #  I |
    | f command-line argument  |
    | present,                 |
    |     then            #+ t |
    | hen set start-string to  |
    | it.                      |
    |       str0="$1"          |
    |     else            #  E |
    | lse use PID of script as |
    |  start-string.           |
    |       str0="$$"          |
    |     fi                   |
    |                          |
    |     POS=2  # Starting fr |
    | om position 2 in the str |
    | ing.                     |
    |     LEN=8  # Extract eig |
    | ht characters.           |
    |                          |
    |     str1=$( echo "$str0" |
    |  | md5sum | md5sum )     |
    |     #  Doubly scramble   |
    |    ^^^^^^   ^^^^^^       |
    |     #+ by piping and rep |
    | iping to md5sum.         |
    |                          |
    |     randstring="${str1:$ |
    | POS:$LEN}"               |
    |     # Can parameterize ^ |
    | ^^^ ^^^^                 |
    |                          |
    |     echo "$randstring"   |
    |                          |
    |     exit $?              |
    |                          |
    |     # bozo$ ./rand-strin |
    | g.sh my-password         |
    |     # 1bdd88c4           |
    |                          |
    |     #  No, this is is no |
    | t recommended            |
    |     #+ as a method of ge |
    | nerating hack-proof pass |
    | words.                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    If the ``$string`` parameter is "\*" or "@", then this extracts a
    maximum of ``$length`` positional parameters, starting at
    ``$position``.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     echo ${*:2}          |
    |  # Echoes second and fol |
    | lowing positional parame |
    | ters.                    |
    |     echo ${@:2}          |
    |  # Same as above.        |
    |                          |
    |     echo ${*:2:3}        |
    |  # Echoes three position |
    | al parameters, starting  |
    | at second.               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

expr substr $string $position $length
    Extracts ``$length`` characters from ``$string`` starting at
    ``$position``.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |     #       123456789... |
    | ...                      |
    |     #       1-based inde |
    | xing.                    |
    |                          |
    |     echo `expr substr $s |
    | tringZ 1 2`              |
    |  # ab                    |
    |     echo `expr substr $s |
    | tringZ 4 3`              |
    |  # ABC                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

expr match "$string" '\\($substring\\)'
    Extracts ``$substring`` at beginning of ``$string``, where
    ``$substring`` is a `regular expression <regexp.html#REGEXREF>`__.

expr "$string" : '\\($substring\\)'
    Extracts ``$substring`` at beginning of ``$string``, where
    ``$substring`` is a regular expression.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |     #       =======      |
    |                          |
    |     echo `expr match "$s |
    | tringZ" '\(.[b-c]*[A-Z]. |
    | .[0-9]\)'`   # abcABC1   |
    |     echo `expr "$stringZ |
    | " : '\(.[b-c]*[A-Z]..[0- |
    | 9]\)'`       # abcABC1   |
    |     echo `expr "$stringZ |
    | " : '\(.......\)'`       |
    |              # abcABC1   |
    |     # All of the above f |
    | orms give an identical r |
    | esult.                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

expr match "$string" '.\*\\($substring\\)'
    Extracts ``$substring`` at *end* of ``$string``, where
    ``$substring`` is a regular expression.

expr "$string" : '.\*\\($substring\\)'
    Extracts ``$substring`` at *end* of ``$string``, where
    ``$substring`` is a regular expression.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |     #                === |
    | ===                      |
    |                          |
    |     echo `expr match "$s |
    | tringZ" '.*\([A-C][A-C][ |
    | A-C][a-c]*\)'`    # ABCa |
    | bc                       |
    |     echo `expr "$stringZ |
    | " : '.*\(......\)'`      |
    |                   # ABCa |
    | bc                       |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Substring Removal**

${string#substring}
    Deletes shortest match of ``$substring`` from *front* of
    ``$string``.

${string##substring}
    Deletes longest match of ``$substring`` from *front* of ``$string``.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |     #       |----|       |
    |     shortest             |
    |     #       |----------| |
    |     longest              |
    |                          |
    |     echo ${stringZ#a*C}  |
    |      # 123ABCabc         |
    |     # Strip out shortest |
    |  match between 'a' and ' |
    | C'.                      |
    |                          |
    |     echo ${stringZ##a*C} |
    |      # abc               |
    |     # Strip out longest  |
    | match between 'a' and 'C |
    | '.                       |
    |                          |
    |                          |
    |                          |
    |     # You can parameteri |
    | ze the substrings.       |
    |                          |
    |     X='a*C'              |
    |                          |
    |     echo ${stringZ#$X}   |
    |     # 123ABCabc          |
    |     echo ${stringZ##$X}  |
    |     # abc                |
    |                          |
    |     # As above.          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

${string%substring}
    Deletes shortest match of ``$substring`` from *back* of ``$string``.

    For example:

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     # Rename all filenam |
    | es in $PWD with "TXT" su |
    | ffix to a "txt" suffix.  |
    |     # For example, "file |
    | 1.TXT" becomes "file1.tx |
    | t" . . .                 |
    |                          |
    |     SUFF=TXT             |
    |     suff=txt             |
    |                          |
    |     for i in $(ls *.$SUF |
    | F)                       |
    |     do                   |
    |       mv -f $i ${i%.$SUF |
    | F}.$suff                 |
    |       #  Leave unchanged |
    |  everything *except* the |
    |  shortest pattern match  |
    |       #+ starting from t |
    | he right-hand-side of th |
    | e variable $i . . .      |
    |     done ### This could  |
    | be condensed into a "one |
    | -liner" if desired.      |
    |                          |
    |     # Thank you, Rory Wi |
    | nston.                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

${string%%substring}
    Deletes longest match of ``$substring`` from *back* of ``$string``.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |     #                    |
    |  ||     shortest         |
    |     #        |---------- |
    | --|     longest          |
    |                          |
    |     echo ${stringZ%b*c}  |
    |      # abcABC123ABCa     |
    |     # Strip out shortest |
    |  match between 'b' and ' |
    | c', from back of $string |
    | Z.                       |
    |                          |
    |     echo ${stringZ%%b*c} |
    |      # a                 |
    |     # Strip out longest  |
    | match between 'b' and 'c |
    | ', from back of $stringZ |
    | .                        |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    This operator is useful for generating filenames.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 10-3. Converting graphic file formats, with filename
    change**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     #  cvt.sh:           |
    |     #  Converts all the  |
    | MacPaint image files in  |
    | a directory to "pbm" for |
    | mat.                     |
    |                          |
    |     #  Uses the "macptop |
    | bm" binary from the "net |
    | pbm" package,            |
    |     #+ which is maintain |
    | ed by Brian Henderson (b |
    | ryanh@giraffe-data.com). |
    |     #  Netpbm is a stand |
    | ard part of most Linux d |
    | istros.                  |
    |                          |
    |     OPERATION=macptopbm  |
    |     SUFFIX=pbm           |
    | # New filename suffix.   |
    |                          |
    |     if [ -n "$1" ]       |
    |     then                 |
    |       directory=$1       |
    | # If directory name give |
    | n as a script argument.. |
    | .                        |
    |     else                 |
    |       directory=$PWD     |
    | # Otherwise use current  |
    | working directory.       |
    |     fi                   |
    |                          |
    |     #  Assumes all files |
    |  in the target directory |
    |  are MacPaint image file |
    | s,                       |
    |     #+ with a ".mac" fil |
    | ename suffix.            |
    |                          |
    |     for file in $directo |
    | ry/*    # Filename globb |
    | ing.                     |
    |     do                   |
    |       filename=${file%.* |
    | c}      #  Strip ".mac"  |
    | suffix off filename      |
    |                          |
    |         #+ ('.*c' matche |
    | s everything             |
    |                     #+ b |
    | etween '.' and 'c', incl |
    | usive).                  |
    |       $OPERATION $file > |
    |  "$filename.$SUFFIX"     |
    |                          |
    |         # Redirect conve |
    | rsion to new filename.   |
    |       rm -f $file        |
    |         # Delete origina |
    | l files after converting |
    | .                        |
    |       echo "$filename.$S |
    | UFFIX"  # Log what is ha |
    | ppening to stdout.       |
    |     done                 |
    |                          |
    |     exit 0               |
    |                          |
    |     # Exercise:          |
    |     # --------           |
    |     #  As it stands, thi |
    | s script converts *all*  |
    | the files in the current |
    |     #+ working directory |
    | .                        |
    |     #  Modify it to work |
    |  *only* on files with a  |
    | ".mac" suffix.           |
    |                          |
    |                          |
    |                          |
    |     # *** And here's ano |
    | ther way to do it. *** # |
    |                          |
    |     #!/bin/bash          |
    |     # Batch convert into |
    |  different graphic forma |
    | ts.                      |
    |     # Assumes imagemagic |
    | k installed (standard in |
    |  most Linux distros).    |
    |                          |
    |     INFMT=png   # Can be |
    |  tif, jpg, gif, etc.     |
    |     OUTFMT=pdf  # Can be |
    |  tif, jpg, gif, pdf, etc |
    | .                        |
    |                          |
    |     for pic in *"$INFMT" |
    |     do                   |
    |       p2=$(ls "$pic" | s |
    | ed -e s/\.$INFMT//)      |
    |       # echo $p2         |
    |         convert "$pic" $ |
    | p2.$OUTFMT               |
    |         done             |
    |                          |
    |     exit $?              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 10-4. Converting streaming audio files to *ogg***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # ra2ogg.sh: Convert |
    |  streaming audio files ( |
    | *.ra) to ogg.            |
    |                          |
    |     # Uses the "mplayer" |
    |  media player program:   |
    |     #      http://www.mp |
    | layerhq.hu/homepage      |
    |     # Uses the "ogg" lib |
    | rary and "oggenc":       |
    |     #      http://www.xi |
    | ph.org/                  |
    |     #                    |
    |     # This script may ne |
    | ed appropriate codecs in |
    | stalled, such as sipr.so |
    |  ...                     |
    |     # Possibly also the  |
    | compat-libstdc++ package |
    | .                        |
    |                          |
    |                          |
    |     OFILEPREF=${1%%ra}   |
    |     # Strip off the "ra" |
    |  suffix.                 |
    |     OFILESUFF=wav        |
    |     # Suffix for wav fil |
    | e.                       |
    |     OUTFILE="$OFILEPREF" |
    | "$OFILESUFF"             |
    |     E_NOARGS=85          |
    |                          |
    |     if [ -z "$1" ]       |
    |     # Must specify a fil |
    | ename to convert.        |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` [filename]"     |
    |       exit $E_NOARGS     |
    |     fi                   |
    |                          |
    |                          |
    |     #################### |
    | ######################## |
    | ######################## |
    | ######                   |
    |     mplayer "$1" -ao pcm |
    | :file=$OUTFILE           |
    |     oggenc "$OUTFILE"  # |
    |  Correct file extension  |
    | automatically added by o |
    | ggenc.                   |
    |     #################### |
    | ######################## |
    | ######################## |
    | ######                   |
    |                          |
    |     rm "$OUTFILE"      # |
    |  Delete intermediate *.w |
    | av file.                 |
    |                        # |
    |  If you want to keep it, |
    |  comment out above line. |
    |                          |
    |     exit $?              |
    |                          |
    |     #  Note:             |
    |     #  ----              |
    |     #  On a Website, sim |
    | ply clicking on a *.ram  |
    | streaming audio file     |
    |     #+ usually only down |
    | loads the URL of the act |
    | ual *.ra audio file.     |
    |     #  You can then use  |
    | "wget" or something simi |
    | lar                      |
    |     #+ to download the * |
    | .ra file itself.         |
    |                          |
    |                          |
    |     #  Exercises:        |
    |     #  ---------         |
    |     #  As is, this scrip |
    | t converts only *.ra fil |
    | enames.                  |
    |     #  Add flexibility b |
    | y permitting use of *.ra |
    | m and other filenames.   |
    |     #                    |
    |     #  If you're really  |
    | ambitious, expand the sc |
    | ript                     |
    |     #+ to do automatic d |
    | ownloads and conversions |
    |  of streaming audio file |
    | s.                       |
    |     #  Given a URL, batc |
    | h download streaming aud |
    | io files (using "wget")  |
    |     #+ and convert them  |
    | on the fly.              |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    A simple emulation of `getopt <extmisc.html#GETOPTY>`__ using
    substring-extraction constructs.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 10-5. Emulating *getopt***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # getopt-simple.sh   |
    |     # Author: Chris Morg |
    | an                       |
    |     # Used in the ABS Gu |
    | ide with permission.     |
    |                          |
    |                          |
    |     getopt_simple()      |
    |     {                    |
    |         echo "getopt_sim |
    | ple()"                   |
    |         echo "Parameters |
    |  are '$*'"               |
    |         until [ -z "$1"  |
    | ]                        |
    |         do               |
    |           echo "Processi |
    | ng parameter of: '$1'"   |
    |           if [ ${1:0:1}  |
    | = '/' ]                  |
    |           then           |
    |               tmp=${1:1} |
    |                # Strip o |
    | ff leading '/' . . .     |
    |               parameter= |
    | ${tmp%%=*}     # Extract |
    |  name.                   |
    |               value=${tm |
    | p##*=}         # Extract |
    |  value.                  |
    |               echo "Para |
    | meter: '$parameter', val |
    | ue: '$value'"            |
    |               eval $para |
    | meter=$value             |
    |           fi             |
    |           shift          |
    |         done             |
    |     }                    |
    |                          |
    |     # Pass all options t |
    | o getopt_simple().       |
    |     getopt_simple $*     |
    |                          |
    |     echo "test is '$test |
    | '"                       |
    |     echo "test2 is '$tes |
    | t2'"                     |
    |                          |
    |     exit 0  # See also,  |
    | UseGetOpt.sh, a modified |
    |  version of this script. |
    |                          |
    |     ---                  |
    |                          |
    |     sh getopt_example.sh |
    |  /test=value1 /test2=val |
    | ue2                      |
    |                          |
    |     Parameters are '/tes |
    | t=value1 /test2=value2'  |
    |     Processing parameter |
    |  of: '/test=value1'      |
    |     Parameter: 'test', v |
    | alue: 'value1'           |
    |     Processing parameter |
    |  of: '/test2=value2'     |
    |     Parameter: 'test2',  |
    | value: 'value2'          |
    |     test is 'value1'     |
    |     test2 is 'value2'   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**Substring Replacement**

${string/substring/replacement}
    Replace first *match* of ``$substring`` with ``$replacement``.
    `[2] <string-manipulation.html#FTN.AEN6164>`__

${string//substring/replacement}
    Replace all matches of ``$substring`` with ``$replacement``.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |                          |
    |     echo ${stringZ/abc/x |
    | yz}       # xyzABC123ABC |
    | abc                      |
    |                          |
    |           # Replaces fir |
    | st match of 'abc' with ' |
    | xyz'.                    |
    |                          |
    |     echo ${stringZ//abc/ |
    | xyz}      # xyzABC123ABC |
    | xyz                      |
    |                          |
    |           # Replaces all |
    |  matches of 'abc' with # |
    |  'xyz'.                  |
    |                          |
    |     echo  -------------- |
    | -                        |
    |     echo "$stringZ"      |
    |           # abcABC123ABC |
    | abc                      |
    |     echo  -------------- |
    | -                        |
    |                          |
    |           # The string i |
    | tself is not altered!    |
    |                          |
    |     # Can the match and  |
    | replacement strings be p |
    | arameterized?            |
    |     match=abc            |
    |     repl=000             |
    |     echo ${stringZ/$matc |
    | h/$repl}  # 000ABC123ABC |
    | abc                      |
    |     #              ^     |
    |   ^         ^^^          |
    |     echo ${stringZ//$mat |
    | ch/$repl} # 000ABC123ABC |
    | 000                      |
    |     # Yes!          ^    |
    |    ^        ^^^          |
    | ^^^                      |
    |                          |
    |     echo                 |
    |                          |
    |     # What happens if no |
    |  $replacement string is  |
    | supplied?                |
    |     echo ${stringZ/abc}  |
    |           # ABC123ABCabc |
    |     echo ${stringZ//abc} |
    |           # ABC123ABC    |
    |     # A simple deletion  |
    | takes place.             |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

${string/#substring/replacement}
    If ``$substring`` matches *front* end of ``$string``, substitute
    ``$replacement`` for ``$substring``.

${string/%substring/replacement}
    If ``$substring`` matches *back* end of ``$string``, substitute
    ``$replacement`` for ``$substring``.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     stringZ=abcABC123ABC |
    | abc                      |
    |                          |
    |     echo ${stringZ/#abc/ |
    | XYZ}          # XYZABC12 |
    | 3ABCabc                  |
    |                          |
    |               # Replaces |
    |  front-end match of 'abc |
    | ' with 'XYZ'.            |
    |                          |
    |     echo ${stringZ/%abc/ |
    | XYZ}          # abcABC12 |
    | 3ABCXYZ                  |
    |                          |
    |               # Replaces |
    |  back-end match of 'abc' |
    |  with 'XYZ'.             |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

.. raw:: html

   </div>

.. raw:: html

   <div class="SECT2">

10.1.1. Manipulating strings using awk
--------------------------------------

A Bash script may invoke the string manipulation facilities of
`awk <awk.html#AWKREF>`__ as an alternative to using its built-in
operations.

.. raw:: html

   <div class="EXAMPLE">

**Example 10-6. Alternate ways of extracting and locating substrings**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # substring-extracti |
| on.sh                    |
|                          |
|     String=23skidoo1     |
|     #      012345678     |
| Bash                     |
|     #      123456789     |
| awk                      |
|     # Note different str |
| ing indexing system:     |
|     # Bash numbers first |
|  character of string as  |
| 0.                       |
|     # Awk  numbers first |
|  character of string as  |
| 1.                       |
|                          |
|     echo ${String:2:4} # |
|  position 3 (0-1-2), 4 c |
| haracters long           |
|                          |
|                      # s |
| kid                      |
|                          |
|     # The awk equivalent |
|  of ${string:pos:length} |
|  is substr(string,pos,le |
| ngth).                   |
|     echo | awk '         |
|     { print substr("'"${ |
| String}"'",3,4)      # s |
| kid                      |
|     }                    |
|     '                    |
|     #  Piping an empty " |
| echo" to awk gives it du |
| mmy input,               |
|     #+ and thus makes it |
|  unnecessary to supply a |
|  filename.               |
|                          |
|     echo "----"          |
|                          |
|     # And likewise:      |
|                          |
|     echo | awk '         |
|     { print index("'"${S |
| tring}"'", "skid")       |
| # 3                      |
|     }                    |
|                          |
| # (skid starts at positi |
| on 3)                    |
|     '   # The awk equiva |
| lent of "expr index" ... |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="SECT2">

10.1.2. Further Reference
-------------------------

For more on string manipulation in scripts, refer to `Section
10.2 <parameter-substitution.html>`__ and the `relevant
section <moreadv.html#EXPEXTRSUB>`__ of the
`expr <moreadv.html#EXPRREF>`__ command listing.

Script examples:

#. `Example 16-9 <moreadv.html#EX45>`__

#. `Example 10-9 <parameter-substitution.html#LENGTH>`__

#. `Example 10-10 <parameter-substitution.html#PATTMATCHING>`__

#. `Example 10-11 <parameter-substitution.html#RFE>`__

#. `Example 10-13 <parameter-substitution.html#VARMATCH>`__

#. `Example A-36 <contributed-scripts.html#INSERTIONSORT>`__

#. `Example A-41 <contributed-scripts.html#QKY>`__

.. raw:: html

   </p>

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <string-manipulation.html#AEN59 | `[2] <string-manipulation.html#AEN61 |
| 87>`__                               | 64>`__                               |
| This applies to either command-line  | Note that ``$substring`` and         |
| arguments or parameters passed to a  | ``$replacement`` may refer to either |
| `function <functions.html#FUNCTIONRE | *literal strings* or *variables*,    |
| F>`__.                               | depending on context. See the first  |
|                                      | usage example.                       |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <manipulatingvars. | Manipulating Variables   |
| html>`__                 | `Up <manipulatingvars.ht |
| `Home <index.html>`__    | ml>`__                   |
| `Next <parameter-substit | Parameter Substitution   |
| ution.html>`__           |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

