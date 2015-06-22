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

`Prev <biblio.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <refcards.html>`__

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

  Appendix A. Contributed Scripts
================================

These scripts, while not fitting into the text of this document, do
illustrate some interesting shell programming techniques. Some are
useful, too. Have fun analyzing and running them.

.. raw:: html

   <div class="EXAMPLE">

**Example A-1. *mailformat* : Formatting an e-mail message**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # mail-format.sh (ve |
| r. 1.1): Format e-mail m |
| essages.                 |
|                          |
|     # Gets rid of carets |
| , tabs, and also folds e |
| xcessively long lines.   |
|                          |
|     # ================== |
| ======================== |
| =======================  |
|     #                 St |
| andard Check for Script  |
| Argument(s)              |
|     ARGS=1               |
|     E_BADARGS=85         |
|     E_NOFILE=86          |
|                          |
|     if [ $# -ne $ARGS ]  |
|  # Correct number of arg |
| uments passed to script? |
|     then                 |
|       echo "Usage: `base |
| name $0` filename"       |
|       exit $E_BADARGS    |
|     fi                   |
|                          |
|     if [ -f "$1" ]       |
|  # Check if file exists. |
|     then                 |
|         file_name=$1     |
|     else                 |
|         echo "File \"$1\ |
| " does not exist."       |
|         exit $E_NOFILE   |
|     fi                   |
|     # ------------------ |
| ------------------------ |
| -----------------------  |
|                          |
|     MAXWIDTH=70          |
|  # Width to fold excessi |
| vely long lines to.      |
|                          |
|     # ================== |
| ===============          |
|     # A variable can hol |
| d a sed script.          |
|     # It's a useful tech |
| nique.                   |
|     sedscript='s/^>//    |
|     s/^  *>//            |
|     s/^  *//             |
|     s/      *//'         |
|     # ================== |
| ===============          |
|                          |
|     #  Delete carets and |
|  tabs at beginning of li |
| nes,                     |
|     #+ then fold lines t |
| o $MAXWIDTH characters.  |
|     sed "$sedscript" $1  |
| | fold -s --width=$MAXWI |
| DTH                      |
|                          |
|     #  -s option to "fol |
| d"                       |
|                          |
|     #+ breaks lines at w |
| hitespace, if possible.  |
|                          |
|                          |
|     #  This script was i |
| nspired by an article in |
|  a well-known trade jour |
| nal                      |
|     #+ extolling a 164K  |
| MS Windows utility with  |
| similar functionality.   |
|     #                    |
|     #  An nice set of te |
| xt processing utilities  |
| and an efficient         |
|     #+ scripting languag |
| e provide an alternative |
|  to the bloated executab |
| les                      |
|     #+ of a clunky opera |
| ting system.             |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-2. *rn* : A simple-minded file renaming utility**

This script is a modification of `Example
16-22 <textproc.html#LOWERCASE>`__ .

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # rn.sh              |
|                          |
|     # Very simpleminded  |
| filename "rename" utilit |
| y (based on "lowercase.s |
| h").                     |
|     #                    |
|     #  The "ren" utility |
| , by Vladimir Lanin (lan |
| in@csd2.nyu.edu),        |
|     #+ does a much bette |
| r job of this.           |
|                          |
|                          |
|     ARGS=2               |
|     E_BADARGS=85         |
|     ONE=1                |
|       # For getting sing |
| ular/plural right (see b |
| elow).                   |
|                          |
|     if [ $# -ne "$ARGS"  |
| ]                        |
|     then                 |
|       echo "Usage: `base |
| name $0` old-pattern new |
| -pattern"                |
|       # As in "rn gif jp |
| g", which renames all gi |
| f files in working direc |
| tory to jpg.             |
|       exit $E_BADARGS    |
|     fi                   |
|                          |
|     number=0             |
|       # Keeps track of h |
| ow many files actually r |
| enamed.                  |
|                          |
|                          |
|     for filename in *$1* |
|       #Traverse all matc |
| hing files in directory. |
|     do                   |
|        if [ -f "$filenam |
| e" ]  # If finds match.. |
| .                        |
|        then              |
|          fname=`basename |
|  $filename`            # |
|  Strip off path.         |
|          n=`echo $fname  |
| | sed -e "s/$1/$2/"`   # |
|  Substitute new for old  |
| in filename.             |
|          mv $fname $n    |
|                        # |
|  Rename.                 |
|          let "number +=  |
| 1"                       |
|        fi                |
|     done                 |
|                          |
|     if [ "$number" -eq " |
| $ONE" ]                # |
|  For correct grammar.    |
|     then                 |
|      echo "$number file  |
| renamed."                |
|     else                 |
|      echo "$number files |
|  renamed."               |
|     fi                   |
|                          |
|     exit $?              |
|                          |
|                          |
|     # Exercises:         |
|     # ---------          |
|     # What types of file |
| s will this not work on? |
|     # How can this be fi |
| xed?                     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-3. *blank-rename* : Renames filenames containing blanks**

This is an even simpler-minded version of previous script.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # blank-rename.sh    |
|     #                    |
|     # Substitutes unders |
| cores for blanks in all  |
| the filenames in a direc |
| tory.                    |
|                          |
|     ONE=1                |
|       # For getting sing |
| ular/plural right (see b |
| elow).                   |
|     number=0             |
|       # Keeps track of h |
| ow many files actually r |
| enamed.                  |
|     FOUND=0              |
|       # Successful retur |
| n value.                 |
|                          |
|     for filename in *    |
|       #Traverse all file |
| s in directory.          |
|     do                   |
|          echo "$filename |
| " | grep -q " "          |
| #  Check whether filenam |
| e                        |
|          if [ $? -eq $FO |
| UND ]                    |
| #+ contains space(s).    |
|          then            |
|            fname=$filena |
| me                       |
| # Yes, this filename nee |
| ds work.                 |
|            n=`echo $fnam |
| e | sed -e "s/ /_/g"`    |
| # Substitute underscore  |
| for blank.               |
|            mv "$fname" " |
| $n"                      |
| # Do the actual renaming |
| .                        |
|            let "number + |
| = 1"                     |
|          fi              |
|     done                 |
|                          |
|     if [ "$number" -eq " |
| $ONE" ]                  |
| # For correct grammar.   |
|     then                 |
|      echo "$number file  |
| renamed."                |
|     else                 |
|      echo "$number files |
|  renamed."               |
|     fi                   |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-4. *encryptedpw* : Uploading to an ftp site, using a locally
encrypted password**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # Example "ex72.sh"  |
| modified to use encrypte |
| d password.              |
|                          |
|     #  Note that this is |
|  still rather insecure,  |
|     #+ since the decrypt |
| ed password is sent in t |
| he clear.                |
|     #  Use something lik |
| e "ssh" if this is a con |
| cern.                    |
|                          |
|     E_BADARGS=85         |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       echo "Usage: `base |
| name $0` filename"       |
|       exit $E_BADARGS    |
|     fi                   |
|                          |
|     Username=bozo        |
|     # Change to suit.    |
|     pword=/home/bozo/sec |
| ret/password_encrypted.f |
| ile                      |
|     # File containing en |
| crypted password.        |
|                          |
|     Filename=`basename $ |
| 1`  # Strips pathname ou |
| t of file name.          |
|                          |
|     Server="XXX"         |
|     Directory="YYY"      |
|     # Change above to ac |
| tual server name & direc |
| tory.                    |
|                          |
|                          |
|     Password=`cruft <$pw |
| ord`          # Decrypt  |
| password.                |
|     #  Uses the author's |
|  own "cruft" file encryp |
| tion package,            |
|     #+ based on the clas |
| sic "onetime pad" algori |
| thm,                     |
|     #+ and obtainable fr |
| om:                      |
|     #+ Primary-site:   f |
| tp://ibiblio.org/pub/Lin |
| ux/utils/file            |
|     #+                 c |
| ruft-0.2.tar.gz [16k]    |
|                          |
|                          |
|     ftp -n $Server <<End |
| -Of-Session              |
|     user $Username $Pass |
| word                     |
|     binary               |
|     bell                 |
|     cd $Directory        |
|     put $Filename        |
|     bye                  |
|     End-Of-Session       |
|     # -n option to "ftp" |
|  disables auto-logon.    |
|     # Note that "bell" r |
| ings 'bell' after each f |
| ile transfer.            |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-5. *copy-cd* : Copying a data CD**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # copy-cd.sh: copyin |
| g a data CD              |
|                          |
|     CDROM=/dev/cdrom     |
|                        # |
|  CD ROM device           |
|     OF=/home/bozo/projec |
| ts/cdimage.iso         # |
|  output file             |
|     #       /xxxx/xxxxxx |
| xx/                      |
|  Change to suit your sys |
| tem.                     |
|     BLOCKSIZE=2048       |
|     # SPEED=10           |
|                        # |
|  If unspecified, uses ma |
| x spd.                   |
|     # DEVICE=/dev/cdrom  |
|                          |
|  older version.          |
|     DEVICE="1,0,0"       |
|                          |
|     echo; echo "Insert s |
| ource CD, but do *not* m |
| ount it."                |
|     echo "Press ENTER wh |
| en ready. "              |
|     read ready           |
|                        # |
|  Wait for input, $ready  |
| not used.                |
|                          |
|     echo; echo "Copying  |
| the source CD to $OF."   |
|     echo "This may take  |
| a while. Please be patie |
| nt."                     |
|                          |
|     dd if=$CDROM of=$OF  |
| bs=$BLOCKSIZE          # |
|  Raw device copy.        |
|                          |
|                          |
|     echo; echo "Remove d |
| ata CD."                 |
|     echo "Insert blank C |
| DR."                     |
|     echo "Press ENTER wh |
| en ready. "              |
|     read ready           |
|                        # |
|  Wait for input, $ready  |
| not used.                |
|                          |
|     echo "Copying $OF to |
|  CDR."                   |
|                          |
|     # cdrecord -v -isosi |
| ze speed=$SPEED dev=$DEV |
| ICE $OF   # Old version. |
|     wodim -v -isosize de |
| v=$DEVICE $OF            |
|     # Uses Joerg Schilli |
| ng's "cdrecord" package  |
| (see its docs).          |
|     # http://www.fokus.g |
| md.de/nthp/employees/sch |
| illing/cdrecord.html     |
|     # Newer Linux distro |
| s may use "wodim" rather |
|  than "cdrecord" ...     |
|                          |
|                          |
|     echo; echo "Done cop |
| ying $OF to CDR on devic |
| e $CDROM."               |
|                          |
|     echo "Do you want to |
|  erase the image file (y |
| /n)? "  # Probably a hug |
| e file.                  |
|     read answer          |
|                          |
|     case "$answer" in    |
|     [yY]) rm -f $OF      |
|           echo "$OF eras |
| ed."                     |
|           ;;             |
|     *)    echo "$OF not  |
| erased.";;               |
|     esac                 |
|                          |
|     echo                 |
|                          |
|     # Exercise:          |
|     # Change the above " |
| case" statement to also  |
| accept "yes" and "Yes" a |
| s input.                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-6. Collatz series**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # collatz.sh         |
|                          |
|     #  The notorious "ha |
| ilstone" or Collatz seri |
| es.                      |
|     #  ----------------- |
| ------------------------ |
| --                       |
|     #  1) Get the intege |
| r "seed" from the comman |
| d-line.                  |
|     #  2) NUMBER <-- see |
| d                        |
|     #  3) Print NUMBER.  |
|     #  4)  If NUMBER is  |
| even, divide by 2, or    |
|     #  5)+ if odd, multi |
| ply by 3 and add 1.      |
|     #  6) NUMBER <-- res |
| ult                      |
|     #  7) Loop back to s |
| tep 3 (for specified num |
| ber of iterations).      |
|     #                    |
|     #  The theory is tha |
| t every such sequence,   |
|     #+ no matter how lar |
| ge the initial value,    |
|     #+ eventually settle |
| s down to repeating "4,2 |
| ,1..." cycles,           |
|     #+ even after fluctu |
| ating through a wide ran |
| ge of values.            |
|     #                    |
|     #  This is an instan |
| ce of an "iterate,"      |
|     #+ an operation that |
|  feeds its output back i |
| nto its input.           |
|     #  Sometimes the res |
| ult is a "chaotic" serie |
| s.                       |
|                          |
|                          |
|     MAX_ITERATIONS=200   |
|     # For large seed num |
| bers (>32000), try incre |
| asing MAX_ITERATIONS.    |
|                          |
|     h=${1:-$$}           |
|             #  Seed.     |
|                          |
|             #  Use $PID  |
| as seed,                 |
|                          |
|             #+ if not sp |
| ecified as command-line  |
| arg.                     |
|                          |
|     echo                 |
|     echo "C($h) -*- $MAX |
| _ITERATIONS Iterations"  |
|     echo                 |
|                          |
|     for ((i=1; i<=MAX_IT |
| ERATIONS; i++))          |
|     do                   |
|                          |
|     # echo -n "$h   "    |
|     #            ^^^     |
|     #            tab     |
|     # printf does it bet |
| ter ...                  |
|     COLWIDTH=%7d         |
|     printf $COLWIDTH $h  |
|                          |
|       let "remainder = h |
|  % 2"                    |
|       if [ "$remainder"  |
| -eq 0 ]   # Even?        |
|       then               |
|         let "h /= 2"     |
|           # Divide by 2. |
|       else               |
|         let "h = h*3 + 1 |
| "         # Multiply by  |
| 3 and add 1.             |
|       fi                 |
|                          |
|                          |
|     COLUMNS=10           |
|           # Output 10 va |
| lues per line.           |
|     let "line_break = i  |
| % $COLUMNS"              |
|     if [ "$line_break" - |
| eq 0 ]                   |
|     then                 |
|       echo               |
|     fi                   |
|                          |
|     done                 |
|                          |
|     echo                 |
|                          |
|     #  For more informat |
| ion on this strange math |
| ematical function,       |
|     #+ see _Computers, P |
| attern, Chaos, and Beaut |
| y_, by Pickover, p. 185  |
| ff.,                     |
|     #+ as listed in the  |
| bibliography.            |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-7. *days-between* : Days between two dates**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # days-between.sh:   |
|   Number of days between |
|  two dates.              |
|     # Usage: ./days-betw |
| een.sh [M]M/[D]D/YYYY [M |
| ]M/[D]D/YYYY             |
|     #                    |
|     # Note: Script modif |
| ied to account for chang |
| es in Bash, v. 2.05b +,  |
|     #+      that closed  |
| the loophole permitting  |
| large negative           |
|     #+      integer retu |
| rn values.               |
|                          |
|     ARGS=2               |
|   # Two command-line par |
| ameters expected.        |
|     E_PARAM_ERR=85       |
|   # Param error.         |
|                          |
|     REFYR=1600           |
|   # Reference year.      |
|     CENTURY=100          |
|     DIY=365              |
|     ADJ_DIY=367          |
|   # Adjusted for leap ye |
| ar + fraction.           |
|     MIY=12               |
|     DIM=31               |
|     LEAPCYCLE=4          |
|                          |
|     MAXRETVAL=255        |
|   #  Largest permissible |
|                          |
|   #+ positive return val |
| ue from a function.      |
|                          |
|     diff=                |
|   # Declare global varia |
| ble for date difference. |
|     value=               |
|   # Declare global varia |
| ble for absolute value.  |
|     day=                 |
|   # Declare globals for  |
| day, month, year.        |
|     month=               |
|     year=                |
|                          |
|                          |
|     Param_Error ()       |
|   # Command-line paramet |
| ers wrong.               |
|     {                    |
|       echo "Usage: `base |
| name $0` [M]M/[D]D/YYYY  |
| [M]M/[D]D/YYYY"          |
|       echo "       (date |
|  must be after 1/3/1600) |
| "                        |
|       exit $E_PARAM_ERR  |
|     }                    |
|                          |
|                          |
|     Parse_Date ()        |
|           # Parse date f |
| rom command-line params. |
|     {                    |
|       month=${1%%/**}    |
|       dm=${1%/**}        |
|           # Day and mont |
| h.                       |
|       day=${dm#*/}       |
|       let "year = `basen |
| ame $1`"  # Not a filena |
| me, but works just the s |
| ame.                     |
|     }                    |
|                          |
|                          |
|     check_date ()        |
|           # Checks for i |
| nvalid date(s) passed.   |
|     {                    |
|       [ "$day" -gt "$DIM |
| " ] || [ "$month" -gt "$ |
| MIY" ] ||                |
|       [ "$year" -lt "$RE |
| FYR" ] && Param_Error    |
|       # Exit script on b |
| ad value(s).             |
|       # Uses or-list / a |
| nd-list.                 |
|       #                  |
|       # Exercise: Implem |
| ent more rigorous date c |
| hecking.                 |
|     }                    |
|                          |
|                          |
|     strip_leading_zero ( |
| ) #  Better to strip pos |
| sible leading zero(s)    |
|     {                    |
|   #+ from day and/or mon |
| th                       |
|       return ${1#0}      |
|   #+ since otherwise Bas |
| h will interpret them    |
|     }                    |
|   #+ as octal values (PO |
| SIX.2, sect 2.9.2.1).    |
|                          |
|                          |
|     day_index ()         |
|   # Gauss' Formula:      |
|     {                    |
|   # Days from March 1, 1 |
| 600 to date passed as pa |
| ram.                     |
|                          |
|   #           ^^^^^^^^^^ |
| ^^^                      |
|       day=$1             |
|       month=$2           |
|       year=$3            |
|                          |
|       let "month = $mont |
| h - 2"                   |
|       if [ "$month" -le  |
| 0 ]                      |
|       then               |
|         let "month += 12 |
| "                        |
|         let "year -= 1"  |
|       fi                 |
|                          |
|       let "year -= $REFY |
| R"                       |
|       let "indexyr = $ye |
| ar / $CENTURY"           |
|                          |
|                          |
|       let "Days = $DIY*$ |
| year + $year/$LEAPCYCLE  |
| - $indexyr \             |
|                   + $ind |
| exyr/$LEAPCYCLE + $ADJ_D |
| IY*$month/$MIY + $day -  |
| $DIM"                    |
|       #  For an in-depth |
|  explanation of this alg |
| orithm, see              |
|       #+   http://weblog |
| s.asp.net/pgreborio/arch |
| ive/2005/01/06/347968.as |
| px                       |
|                          |
|                          |
|       echo $Days         |
|                          |
|     }                    |
|                          |
|                          |
|     calculate_difference |
|  ()            # Differe |
| nce between two day indi |
| ces.                     |
|     {                    |
|       let "diff = $1 - $ |
| 2"             # Global  |
| variable.                |
|     }                    |
|                          |
|                          |
|     abs ()               |
|                #  Absolu |
| te value                 |
|     {                    |
|                #  Uses g |
| lobal "value" variable.  |
|       if [ "$1" -lt 0 ]  |
|                #  If neg |
| ative                    |
|       then               |
|                #+ then   |
|         let "value = 0 - |
|  $1"           #+ change |
|  sign,                   |
|       else               |
|                #+ else   |
|         let "value = $1" |
|                #+ leave  |
| it alone.                |
|       fi                 |
|     }                    |
|                          |
|                          |
|                          |
|     if [ $# -ne "$ARGS"  |
| ]              # Require |
|  two command-line params |
| .                        |
|     then                 |
|       Param_Error        |
|     fi                   |
|                          |
|     Parse_Date $1        |
|     check_date $day $mon |
| th $year       #  See if |
|  valid date.             |
|                          |
|     strip_leading_zero $ |
| day            #  Remove |
|  any leading zeroes      |
|     day=$?               |
|                #+ on day |
|  and/or month.           |
|     strip_leading_zero $ |
| month                    |
|     month=$?             |
|                          |
|     let "date1 = `day_in |
| dex $day $month $year`"  |
|                          |
|                          |
|     Parse_Date $2        |
|     check_date $day $mon |
| th $year                 |
|                          |
|     strip_leading_zero $ |
| day                      |
|     day=$?               |
|     strip_leading_zero $ |
| month                    |
|     month=$?             |
|                          |
|     date2=$(day_index $d |
| ay $month $year) # Comma |
| nd substitution.         |
|                          |
|                          |
|     calculate_difference |
|  $date1 $date2           |
|                          |
|     abs $diff            |
|                  # Make  |
| sure it's positive.      |
|     diff=$value          |
|                          |
|     echo $diff           |
|                          |
|     exit 0               |
|                          |
|     #  Exercise:         |
|     #  --------          |
|     #  If given only one |
|  command-line parameter, |
|  have the script         |
|     #+ use today's date  |
| as the second.           |
|                          |
|                          |
|     #  Compare this scri |
| pt with                  |
|     #+ the implementatio |
| n of Gauss' Formula in a |
|  C program at            |
|     #+    http://buschen |
| crew.hypermart.net/softw |
| are/datedif              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-8. Making a *dictionary***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # makedict.sh  [make |
|  dictionary]             |
|                          |
|     # Modification of /u |
| sr/sbin/mkdict (/usr/sbi |
| n/cracklib-forman) scrip |
| t.                       |
|     # Original script co |
| pyright 1993, by Alec Mu |
| ffett.                   |
|     #                    |
|     #  This modified scr |
| ipt included in this doc |
| ument in a manner        |
|     #+ consistent with t |
| he "LICENSE" document of |
|  the "Crack" package     |
|     #+ that the original |
|  script is a part of.    |
|                          |
|     #  This script proce |
| sses text files to produ |
| ce a sorted list         |
|     #+ of words found in |
|  the files.              |
|     #  This may be usefu |
| l for compiling dictiona |
| ries                     |
|     #+ and for other lex |
| icographic purposes.     |
|                          |
|                          |
|     E_BADARGS=85         |
|                          |
|     if [ ! -r "$1" ]     |
|                 #  Need  |
| at least one             |
|     then                 |
|                 #+ valid |
|  file argument.          |
|       echo "Usage: $0 fi |
| les-to-process"          |
|       exit $E_BADARGS    |
|     fi                   |
|                          |
|                          |
|     # SORT="sort"        |
|                 #  No lo |
| nger necessary to define |
|                          |
|                 #+ optio |
| ns to sort. Changed from |
|                          |
|                 #+ origi |
| nal script.              |
|                          |
|     cat $* |             |
|                 #  Dump  |
| specified files to stdou |
| t.                       |
|             tr A-Z a-z | |
|                 #  Conve |
| rt to lowercase.         |
|             tr ' ' '\012 |
| ' |             #  New:  |
| change spaces to newline |
| s.                       |
|     #       tr -cd '\012 |
| [a-z][0-9]' |   #  Get r |
| id of everything         |
|                          |
|                 #+ non-a |
| lphanumeric (in orig. sc |
| ript).                   |
|             tr -c '\012a |
| -z'  '\012' |   #  Rathe |
| r than deleting non-alph |
| a                        |
|                          |
|                 #+ chars |
| , change them to newline |
| s.                       |
|             sort |       |
|                 #  $SORT |
|  options unnecessary now |
| .                        |
|             uniq |       |
|                 #  Remov |
| e duplicates.            |
|             grep -v '^#' |
|  |              #  Delet |
| e lines starting with #. |
|             grep -v '^$' |
|                 #  Delet |
| e blank lines.           |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-9. Soundex conversion**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # soundex.sh: Calcul |
| ate "soundex" code for n |
| ames                     |
|                          |
|     # ================== |
| ======================== |
| =============            |
|     #        Soundex scr |
| ipt                      |
|     #              by    |
|     #         Mendel Coo |
| per                      |
|     #     thegrendel.abs |
| @gmail.com               |
|     #     reldate: 23 Ja |
| nuary, 2002              |
|     #                    |
|     #   Placed in the Pu |
| blic Domain.             |
|     #                    |
|     # A slightly differe |
| nt version of this scrip |
| t appeared in            |
|     #+ Ed Schaefer's Jul |
| y, 2002 "Shell Corner" c |
| olumn                    |
|     #+ in "Unix Review"  |
| on-line,                 |
|     #+ http://www.unixre |
| view.com/documents/uni10 |
| 26336632258/             |
|     # ================== |
| ======================== |
| =============            |
|                          |
|                          |
|     ARGCOUNT=1           |
|            # Need name a |
| s argument.              |
|     E_WRONGARGS=90       |
|                          |
|     if [ $# -ne "$ARGCOU |
| NT" ]                    |
|     then                 |
|       echo "Usage: `base |
| name $0` name"           |
|       exit $E_WRONGARGS  |
|     fi                   |
|                          |
|                          |
|     assign_value ()      |
|            #  Assigns nu |
| merical value            |
|     {                    |
|            #+ to letters |
|  of name.                |
|                          |
|       val1=bfpv          |
|            # 'b,f,p,v' = |
|  1                       |
|       val2=cgjkqsxz      |
|            # 'c,g,j,k,q, |
| s,x,z' = 2               |
|       val3=dt            |
|            #  etc.       |
|       val4=l             |
|       val5=mn            |
|       val6=r             |
|                          |
|     # Exceptionally clev |
| er use of 'tr' follows.  |
|     # Try to figure out  |
| what is going on here.   |
|                          |
|     value=$( echo "$1" \ |
|     | tr -d wh \         |
|     | tr $val1 1 | tr $v |
| al2 2 | tr $val3 3 \     |
|     | tr $val4 4 | tr $v |
| al5 5 | tr $val6 6 \     |
|     | tr -s 123456 \     |
|     | tr -d aeiouy )     |
|                          |
|     # Assign letter valu |
| es.                      |
|     # Remove duplicate n |
| umbers, except when sepa |
| rated by vowels.         |
|     # Ignore vowels, exc |
| ept as separators, so de |
| lete them last.          |
|     # Ignore 'w' and 'h' |
| , even as separators, so |
|  delete them first.      |
|     #                    |
|     # The above command  |
| substitution lays more p |
| ipe than a plumber <g>.  |
|                          |
|     }                    |
|                          |
|                          |
|     input_name="$1"      |
|     echo                 |
|     echo "Name = $input_ |
| name"                    |
|                          |
|                          |
|     # Change all charact |
| ers of name input to low |
| ercase.                  |
|     # ------------------ |
| ------------------------ |
| ------                   |
|     name=$( echo $input_ |
| name | tr A-Z a-z )      |
|     # ------------------ |
| ------------------------ |
| ------                   |
|     # Just in case argum |
| ent to script is mixed c |
| ase.                     |
|                          |
|                          |
|     # Prefix of soundex  |
| code: first letter of na |
| me.                      |
|     # ------------------ |
| ------------------------ |
| --                       |
|                          |
|                          |
|     char_pos=0           |
|            # Initialize  |
| character position.      |
|     prefix0=${name:$char |
| _pos:1}                  |
|     prefix=`echo $prefix |
| 0 | tr a-z A-Z`          |
|                          |
|            # Uppercase 1 |
| st letter of soundex.    |
|                          |
|     let "char_pos += 1"  |
|            # Bump charac |
| ter position to 2nd lett |
| er of name.              |
|     name1=${name:$char_p |
| os}                      |
|                          |
|                          |
|     # ++++++++++++++++++ |
| ++++++++ Exception Patch |
|  +++++++++++++++++++++++ |
| +++++++                  |
|     #  Now, we run both  |
| the input name and the n |
| ame shifted one char     |
|     #+ to the right thro |
| ugh the value-assigning  |
| function.                |
|     #  If we get the sam |
| e value out, that means  |
| that the first two chara |
| cters                    |
|     #+ of the name have  |
| the same value assigned, |
|  and that one should can |
| cel.                     |
|     #  However, we also  |
| need to test whether the |
|  first letter of the nam |
| e                        |
|     #+ is a vowel or 'w' |
|  or 'h', because otherwi |
| se this would bollix thi |
| ngs up.                  |
|                          |
|     char1=`echo $prefix  |
| | tr A-Z a-z`    # First |
|  letter of name, lowerca |
| sed.                     |
|                          |
|     assign_value $name   |
|     s1=$value            |
|     assign_value $name1  |
|     s2=$value            |
|     assign_value $char1  |
|     s3=$value            |
|     s3=9$s3              |
|                  #  If f |
| irst letter of name is a |
|  vowel                   |
|                          |
|                  #+ or ' |
| w' or 'h',               |
|                          |
|                  #+ then |
|  its "value" will be nul |
| l (unset).               |
|                          |
|  #+ Therefore, set it to |
|  9, an otherwise         |
|                          |
|  #+ unused value, which  |
| can be tested for.       |
|                          |
|                          |
|     if [[ "$s1" -ne "$s2 |
| " || "$s3" -eq 9 ]]      |
|     then                 |
|       suffix=$s2         |
|     else                 |
|       suffix=${s2:$char_ |
| pos}                     |
|     fi                   |
|     # ++++++++++++++++++ |
| ++++ end Exception Patch |
|  +++++++++++++++++++++++ |
| +++++++                  |
|                          |
|                          |
|     padding=000          |
|            # Use at most |
|  3 zeroes to pad.        |
|                          |
|                          |
|     soun=$prefix$suffix$ |
| padding    # Pad with ze |
| roes.                    |
|                          |
|     MAXLEN=4             |
|            # Truncate to |
|  maximum of 4 chars.     |
|     soundex=${soun:0:$MA |
| XLEN}                    |
|                          |
|     echo "Soundex = $sou |
| ndex"                    |
|                          |
|     echo                 |
|                          |
|     #  The soundex code  |
| is a method of indexing  |
| and classifying names    |
|     #+ by grouping toget |
| her the ones that sound  |
| alike.                   |
|     #  The soundex code  |
| for a given name is the  |
| first letter of the name |
| ,                        |
|     #+ followed by a cal |
| culated three-number cod |
| e.                       |
|     #  Similar sounding  |
| names should have almost |
|  the same soundex codes. |
|                          |
|     #   Examples:        |
|     #   Smith and Smythe |
|  both have a "S-530" sou |
| ndex.                    |
|     #   Harrison = H-625 |
|     #   Hargison = H-622 |
|     #   Harriman = H-655 |
|                          |
|     #  This works out fa |
| irly well in practice, b |
| ut there are numerous an |
| omalies.                 |
|     #                    |
|     #                    |
|     #  The U.S. Census a |
| nd certain other governm |
| ental agencies use sound |
| ex,                      |
|     #  as do genealogica |
| l researchers.           |
|     #                    |
|     #  For more informat |
| ion,                     |
|     #+ see the "National |
|  Archives and Records Ad |
| ministration home page", |
|     #+ http://www.nara.g |
| ov/genealogy/soundex/sou |
| ndex.html                |
|                          |
|                          |
|                          |
|     # Exercise:          |
|     # --------           |
|     # Simplify the "Exce |
| ption Patch" section of  |
| this script.             |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-10. *Game of Life***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # life.sh: "Life in  |
| the Slow Lane"           |
|     # Author: Mendel Coo |
| per                      |
|     # License: GPL3      |
|                          |
|     # Version 0.2:   Pat |
| ched by Daniel Albers    |
|     #+               to  |
| allow non-square grids a |
| s input.                 |
|     # Version 0.2.1: Add |
| ed 2-second delay betwee |
| n generations.           |
|                          |
|     # ################## |
| ######################## |
| ######################## |
| ### #                    |
|     # This is the Bash s |
| cript version of John Co |
| nway's "Game of Life".   |
|     #                    |
|     # "Life" is a simple |
|  implementation of cellu |
| lar automata.            |
|     #                    |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| --- #                    |
|     # On a rectangular g |
| rid, let each "cell" be  |
| either "living" or "dead |
| ."  #                    |
|     # Designate a living |
|  cell with a dot, and a  |
| dead one with a blank sp |
| ace.#                    |
|     #      Begin with an |
|  arbitrarily drawn dot-a |
| nd-blank grid,           |
|     #                    |
|     #+     and let this  |
| be the starting generati |
| on: generation 0.        |
|     #                    |
|     # Determine each suc |
| cessive generation by th |
| e following rules:       |
|     #                    |
|     #   1) Each cell has |
|  8 neighbors, the adjoin |
| ing cells                |
|     #                    |
|     #+     left, right,  |
| top, bottom, and the 4 d |
| iagonals.                |
|     #                    |
|     #                    |
|                          |
|                          |
|     #                    |
|     #                    |
|     123                  |
|                          |
|     #                    |
|     #                    |
|     4*5     The * is the |
|  cell under consideratio |
| n.  #                    |
|     #                    |
|     678                  |
|                          |
|     #                    |
|     #                    |
|                          |
|                          |
|     #                    |
|     # 2) A living cell w |
| ith either 2 or 3 living |
|  neighbors remains alive |
| .   #                    |
|     SURVIVE=2            |
|                          |
|                          |
|     #                    |
|     # 3) A dead cell wit |
| h 3 living neighbors com |
| es alive, a "birth."     |
|     #                    |
|     BIRTH=3              |
|                          |
|                          |
|     #                    |
|     # 4) All other cases |
|  result in a dead cell f |
| or the next generation.  |
|     #                    |
|     # ################## |
| ######################## |
| ######################## |
| ### #                    |
|                          |
|                          |
|     startfile=gen0   # R |
| ead the starting generat |
| ion from the file "gen0" |
|  ...                     |
|                      # D |
| efault, if no other file |
|  specified when invoking |
|  script.                 |
|                      #   |
|     if [ -n "$1" ]   # S |
| pecify another "generati |
| on 0" file.              |
|     then                 |
|         startfile="$1"   |
|     fi                   |
|                          |
|     #################### |
| ######################## |
|     #  Abort script if " |
| startfile" not specified |
|     #+ and               |
|     #+ default file "gen |
| 0" not present.          |
|                          |
|     E_NOSTARTFILE=86     |
|                          |
|     if [ ! -e "$startfil |
| e" ]                     |
|     then                 |
|       echo "Startfile \" |
| "$startfile"\" missing!" |
|       exit $E_NOSTARTFIL |
| E                        |
|     fi                   |
|     #################### |
| ######################## |
|                          |
|                          |
|     ALIVE1=.             |
|     DEAD1=_              |
|                      # R |
| epresent living and dead |
|  cells in the start-up f |
| ile.                     |
|                          |
|     #  ----------------- |
| ------------------------ |
| ------------#            |
|     #  This script uses  |
| a 10 x 10 grid (may be i |
| ncreased,                |
|     #+ but a large grid  |
| will slow down execution |
| ).                       |
|     ROWS=10              |
|     COLS=10              |
|     #  Change above two  |
| variables to match desir |
| ed grid size.            |
|     #  ----------------- |
| ------------------------ |
| ------------#            |
|                          |
|     GENERATIONS=10       |
|     #  How many generati |
| ons to cycle through.    |
|                          |
|     #  Adjust this upwar |
| ds                       |
|                          |
|     #+ if you have time  |
| on your hands.           |
|                          |
|     NONE_ALIVE=85        |
|     #  Exit status on pr |
| emature bailout,         |
|                          |
|     #+ if no cells left  |
| alive.                   |
|     DELAY=2              |
|     #  Pause between gen |
| erations.                |
|     TRUE=0               |
|     FALSE=1              |
|     ALIVE=0              |
|     DEAD=1               |
|                          |
|     avar=                |
|     # Global; holds curr |
| ent generation.          |
|     generation=0         |
|     # Initialize generat |
| ion count.               |
|                          |
|     # ================== |
| ======================== |
| =======================  |
|                          |
|     let "cells = $ROWS * |
|  $COLS"   # How many cel |
| ls.                      |
|                          |
|     # Arrays containing  |
| "cells."                 |
|     declare -a initial   |
|     declare -a current   |
|                          |
|     display ()           |
|     {                    |
|                          |
|     alive=0              |
|     # How many cells ali |
| ve at any given time.    |
|                          |
|     # Initially zero.    |
|                          |
|     declare -a arr       |
|     arr=( `echo "$1"` )  |
|     # Convert passed arg |
|  to array.               |
|                          |
|     element_count=${#arr |
| [*]}                     |
|                          |
|     local i              |
|     local rowcheck       |
|                          |
|     for ((i=0; i<$elemen |
| t_count; i++))           |
|     do                   |
|                          |
|       # Insert newline a |
| t end of each row.       |
|       let "rowcheck = $i |
|  % COLS"                 |
|       if [ "$rowcheck" - |
| eq 0 ]                   |
|       then               |
|         echo             |
|     # Newline.           |
|         echo -n "      " |
|     # Indent.            |
|       fi                 |
|                          |
|       cell=${arr[i]}     |
|                          |
|       if [ "$cell" = . ] |
|       then               |
|         let "alive += 1" |
|       fi                 |
|                          |
|       echo -n "$cell" |  |
| sed -e 's/_/ /g'         |
|       # Print out array, |
|  changing underscores to |
|  spaces.                 |
|     done                 |
|                          |
|     return               |
|                          |
|     }                    |
|                          |
|     IsValid ()           |
|                   # Test |
|  if cell coordinate vali |
| d.                       |
|     {                    |
|                          |
|       if [ -z "$1"  -o - |
| z "$2" ]          # Mand |
| atory arguments missing? |
|       then               |
|         return $FALSE    |
|       fi                 |
|                          |
|     local row            |
|     local lower_limit=0  |
|                   # Disa |
| llow negative coordinate |
| .                        |
|     local upper_limit    |
|     local left           |
|     local right          |
|                          |
|     let "upper_limit = $ |
| ROWS * $COLS - 1" # Tota |
| l number of cells.       |
|                          |
|                          |
|     if [ "$1" -lt "$lowe |
| r_limit" -o "$1" -gt "$u |
| pper_limit" ]            |
|     then                 |
|       return $FALSE      |
|                   # Out  |
| of array bounds.         |
|     fi                   |
|                          |
|     row=$2               |
|     let "left = $row * $ |
| COLS"             # Left |
|  limit.                  |
|     let "right = $left + |
|  $COLS - 1"       # Righ |
| t limit.                 |
|                          |
|     if [ "$1" -lt "$left |
| " -o "$1" -gt "$right" ] |
|     then                 |
|       return $FALSE      |
|                   # Beyo |
| nd row boundary.         |
|     fi                   |
|                          |
|     return $TRUE         |
|                   # Vali |
| d coordinate.            |
|                          |
|     }                    |
|                          |
|                          |
|     IsAlive ()           |
|     #  Test whether cell |
|  is alive.               |
|                          |
|     #  Takes array, cell |
|  number, and             |
|     {                    |
|     #+ state of cell as  |
| arguments.               |
|       GetCount "$1" $2   |
|     #  Get alive cell co |
| unt in neighborhood.     |
|       local nhbd=$?      |
|                          |
|       if [ "$nhbd" -eq " |
| $BIRTH" ]  # Alive in an |
| y case.                  |
|       then               |
|         return $ALIVE    |
|       fi                 |
|                          |
|       if [ "$3" = "." -a |
|  "$nhbd" -eq "$SURVIVE"  |
| ]                        |
|       then               |
|     # Alive only if prev |
| iously alive.            |
|         return $ALIVE    |
|       fi                 |
|                          |
|       return $DEAD       |
|     # Defaults to dead.  |
|                          |
|     }                    |
|                          |
|                          |
|     GetCount ()          |
|     # Count live cells i |
| n passed cell's neighbor |
| hood.                    |
|                          |
|     # Two arguments need |
| ed:                      |
|                 # $1) va |
| riable holding array     |
|                 # $2) ce |
| ll number                |
|     {                    |
|       local cell_number= |
| $2                       |
|       local array        |
|       local top          |
|       local center       |
|       local bottom       |
|       local r            |
|       local row          |
|       local i            |
|       local t_top        |
|       local t_cen        |
|       local t_bot        |
|       local count=0      |
|       local ROW_NHBD=3   |
|                          |
|       array=( `echo "$1" |
| ` )                      |
|                          |
|       let "top = $cell_n |
| umber - $COLS - 1"    #  |
| Set up cell neighborhood |
| .                        |
|       let "center = $cel |
| l_number - 1"            |
|       let "bottom = $cel |
| l_number + $COLS - 1"    |
|       let "r = $cell_num |
| ber / $COLS"             |
|                          |
|       for ((i=0; i<$ROW_ |
| NHBD; i++))           #  |
| Traverse from left to ri |
| ght.                     |
|       do                 |
|         let "t_top = $to |
| p + $i"                  |
|         let "t_cen = $ce |
| nter + $i"               |
|         let "t_bot = $bo |
| ttom + $i"               |
|                          |
|                          |
|         let "row = $r"   |
|                       #  |
| Count center row.        |
|         IsValid $t_cen $ |
| row                   #  |
| Valid cell position?     |
|         if [ $? -eq "$TR |
| UE" ]                    |
|         then             |
|           if [ ${array[$ |
| t_cen]} = "$ALIVE1" ] #  |
| Is it alive?             |
|           then           |
|                       #  |
| If yes, then ...         |
|             let "count + |
| = 1"                  #  |
| Increment count.         |
|           fi             |
|         fi               |
|                          |
|         let "row = $r -  |
| 1"                    #  |
| Count top row.           |
|         IsValid $t_top $ |
| row                      |
|         if [ $? -eq "$TR |
| UE" ]                    |
|         then             |
|           if [ ${array[$ |
| t_top]} = "$ALIVE1" ] #  |
| Redundancy here.         |
|           then           |
|                       #  |
| Can it be optimized?     |
|             let "count + |
| = 1"                     |
|           fi             |
|         fi               |
|                          |
|         let "row = $r +  |
| 1"                    #  |
| Count bottom row.        |
|         IsValid $t_bot $ |
| row                      |
|         if [ $? -eq "$TR |
| UE" ]                    |
|         then             |
|           if [ ${array[$ |
| t_bot]} = "$ALIVE1" ]    |
|           then           |
|             let "count + |
| = 1"                     |
|           fi             |
|         fi               |
|                          |
|       done               |
|                          |
|                          |
|       if [ ${array[$cell |
| _number]} = "$ALIVE1" ]  |
|       then               |
|         let "count -= 1" |
|         #  Make sure val |
| ue of tested cell itself |
|       fi                 |
|         #+ is not counte |
| d.                       |
|                          |
|                          |
|       return $count      |
|                          |
|     }                    |
|                          |
|     next_gen ()          |
|       # Update generatio |
| n array.                 |
|     {                    |
|                          |
|     local array          |
|     local i=0            |
|                          |
|     array=( `echo "$1"`  |
| )     # Convert passed a |
| rg to array.             |
|                          |
|     while [ "$i" -lt "$c |
| ells" ]                  |
|     do                   |
|       IsAlive "$1" $i ${ |
| array[$i]}   # Is the ce |
| ll alive?                |
|       if [ $? -eq "$ALIV |
| E" ]                     |
|       then               |
|              #  If alive |
| , then                   |
|         array[$i]=.      |
|              #+ represen |
| t the cell as a period.  |
|       else               |
|         array[$i]="_"    |
|              #  Otherwis |
| e underscore             |
|        fi                |
|              #+ (will la |
| ter be converted to spac |
| e).                      |
|       let "i += 1"       |
|     done                 |
|                          |
|                          |
|     #    let "generation |
|  += 1"       # Increment |
|  generation count.       |
|     ###  Why was the abo |
| ve line commented out?   |
|                          |
|                          |
|     # Set variable to pa |
| ss as parameter to "disp |
| lay" function.           |
|     avar=`echo ${array[@ |
| ]}`   # Convert array ba |
| ck to string variable.   |
|     display "$avar"      |
|       # Display it.      |
|     echo; echo           |
|     echo "Generation $ge |
| neration  -  $alive aliv |
| e"                       |
|                          |
|     if [ "$alive" -eq 0  |
| ]                        |
|     then                 |
|       echo               |
|       echo "Premature ex |
| it: no more cells alive! |
| "                        |
|       exit $NONE_ALIVE   |
|       #  No point in con |
| tinuing                  |
|     fi                   |
|       #+ if no live cell |
| s.                       |
|                          |
|     }                    |
|                          |
|                          |
|     # ================== |
| ======================== |
| ===============          |
|                          |
|     # main ()            |
|     # {                  |
|                          |
|     # Load initial array |
|  with contents of startu |
| p file.                  |
|     initial=( `cat "$sta |
| rtfile" | sed -e '/#/d'  |
| | tr -d '\n' |\          |
|     # Delete lines conta |
| ining '#' comment charac |
| ter.                     |
|                sed -e 's |
| /\./\. /g' -e 's/_/_ /g' |
| ` )                      |
|     # Remove linefeeds a |
| nd insert space between  |
| elements.                |
|                          |
|     clear          # Cle |
| ar screen.               |
|                          |
|     echo #         Title |
|     setterm -reverse on  |
|     echo "============== |
| ========="               |
|     setterm -reverse off |
|     echo "    $GENERATIO |
| NS generations"          |
|     echo "           of" |
|     echo "\"Life in the  |
| Slow Lane\""             |
|     setterm -reverse on  |
|     echo "============== |
| ========="               |
|     setterm -reverse off |
|                          |
|     sleep $DELAY   # Dis |
| play "splash screen" for |
|  2 seconds.              |
|                          |
|                          |
|     # -------- Display f |
| irst generation. ------- |
| -                        |
|     Gen0=`echo ${initial |
| [@]}`                    |
|     display "$Gen0"      |
|       # Display only.    |
|     echo; echo           |
|     echo "Generation $ge |
| neration  -  $alive aliv |
| e"                       |
|     sleep $DELAY         |
|     # ------------------ |
| ------------------------ |
| -                        |
|                          |
|                          |
|     let "generation += 1 |
| "     # Bump generation  |
| count.                   |
|     echo                 |
|                          |
|     # ------- Display se |
| cond generation. ------- |
|     Cur=`echo ${initial[ |
| @]}`                     |
|     next_gen "$Cur"      |
|      # Update & display. |
|     sleep $DELAY         |
|     # ------------------ |
| ------------------------ |
|                          |
|     let "generation += 1 |
| "     # Increment genera |
| tion count.              |
|                          |
|     # ------ Main loop f |
| or displaying subsequent |
|  generations ------      |
|     while [ "$generation |
| " -le "$GENERATIONS" ]   |
|     do                   |
|       Cur="$avar"        |
|       next_gen "$Cur"    |
|       let "generation += |
|  1"                      |
|       sleep $DELAY       |
|     done                 |
|     # ================== |
| ======================== |
| ====================     |
|                          |
|     echo                 |
|     # }                  |
|                          |
|     exit 0   # CEOF:EOF  |
|                          |
|                          |
|                          |
|     # The grid in this s |
| cript has a "boundary pr |
| oblem."                  |
|     # The the top, botto |
| m, and sides border on a |
|  void of dead cells.     |
|     # Exercise: Change t |
| he script to have the gr |
| id wrap around,          |
|     # +         so that  |
| the left and right sides |
|  will "touch,"           |
|     # +         as will  |
| the top and bottom.      |
|     #                    |
|     # Exercise: Create a |
|  new "gen0" file to seed |
|  this script.            |
|     #           Use a 12 |
|  x 16 grid, instead of t |
| he original 10 x 10 one. |
|     #           Make the |
|  necessary changes to th |
| e script,                |
|     #+          so it wi |
| ll run with the altered  |
| file.                    |
|     #                    |
|     # Exercise: Modify t |
| his script so that it ca |
| n determine the grid siz |
| e                        |
|     #+          from the |
|  "gen0" file, and set an |
| y variables necessary    |
|     #+          for the  |
| script to run.           |
|     #           This wou |
| ld make unnecessary any  |
| changes to variables     |
|     #+          in the s |
| cript for an altered gri |
| d size.                  |
|     #                    |
|     # Exercise: Optimize |
|  this script.            |
|     #           It has r |
| edundant code.           |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-11. Data file for *Game of Life***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # gen0               |
|     #                    |
|     # This is an example |
|  "generation 0" start-up |
|  file for "life.sh".     |
|     # ------------------ |
| ------------------------ |
| --------------------     |
|     #  The "gen0" file i |
| s a 10 x 10 grid using a |
|  period (.) for live cel |
| ls,                      |
|     #+ and an underscore |
|  (_) for dead ones. We c |
| annot simply use spaces  |
|     #+ for dead cells in |
|  this file because of a  |
| peculiarity in Bash arra |
| ys.                      |
|     #  [Exercise for the |
|  reader: explain this.]  |
|     #                    |
|     # Lines beginning wi |
| th a '#' are comments, a |
| nd the script ignores th |
| em.                      |
|     __.__..___           |
|     __.._.____           |
|     ____.___..           |
|     _._______.           |
|     ____._____           |
|     ..__...___           |
|     ____._____           |
|     ___...____           |
|     __.._..___           |
|     _..___..__           |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

+++

The following script is by Mark Moraes of the University of Toronto. See
the file ``      Moraes-COPYRIGHT     `` for permissions and
restrictions. This file is included in the combined `HTML/source
tarball <mirrorsites.html#WHERE_TARBALL>`__ of the *ABS Guide* .

.. raw:: html

   <div class="EXAMPLE">

**Example A-12. *behead* : Removing mail and news message headers**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/sh           |
|     #  Strips off the he |
| ader from a mail/News me |
| ssage i.e. till the firs |
| t                        |
|     #+ empty line.       |
|     #  Author: Mark Mora |
| es, University of Toront |
| o                        |
|                          |
|     # ==> These comments |
|  added by author of this |
|  document.               |
|                          |
|     if [ $# -eq 0 ]; the |
| n                        |
|     # ==> If no command- |
| line args present, then  |
| works on file redirected |
|  to stdin.               |
|         sed -e '1,/^$/d' |
|  -e '/^[    ]*$/d'       |
|         # --> Delete emp |
| ty lines and all lines u |
| ntil                     |
|         # --> first one  |
| beginning with white spa |
| ce.                      |
|     else                 |
|     # ==> If command-lin |
| e args present, then wor |
| k on files named.        |
|         for i do         |
|             sed -e '1,/^ |
| $/d' -e '/^[    ]*$/d' $ |
| i                        |
|             # --> Ditto, |
|  as above.               |
|         done             |
|     fi                   |
|                          |
|     exit                 |
|                          |
|     # ==> Exercise: Add  |
| error checking and other |
|  options.                |
|     # ==>                |
|     # ==> Note that the  |
| small sed script repeats |
| , except for the arg pas |
| sed.                     |
|     # ==> Does it make s |
| ense to embed it in a fu |
| nction? Why or why not?  |
|                          |
|                          |
|     /*                   |
|      * Copyright Univers |
| ity of Toronto 1988, 198 |
| 9.                       |
|      * Written by Mark M |
| oraes                    |
|      *                   |
|      * Permission is gra |
| nted to anyone to use th |
| is software for any purp |
| ose on                   |
|      * any computer syst |
| em, and to alter it and  |
| redistribute it freely,  |
| subject                  |
|      * to the following  |
| restrictions:            |
|      *                   |
|      * 1. The author and |
|  the University of Toron |
| to are not responsible   |
|      *    for the conseq |
| uences of use of this so |
| ftware, no matter how aw |
| ful,                     |
|      *    even if they a |
| rise from flaws in it.   |
|      *                   |
|      * 2. The origin of  |
| this software must not b |
| e misrepresented, either |
|  by                      |
|      *    explicit claim |
|  or by omission.  Since  |
| few users ever read sour |
| ces,                     |
|      *    credits must a |
| ppear in the documentati |
| on.                      |
|      *                   |
|      * 3. Altered versio |
| ns must be plainly marke |
| d as such, and must not  |
| be                       |
|      *    misrepresented |
|  as being the original s |
| oftware.  Since few user |
| s                        |
|      *    ever read sour |
| ces, credits must appear |
|  in the documentation.   |
|      *                   |
|      * 4. This notice ma |
| y not be removed or alte |
| red.                     |
|      */                  |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

+

Antek Sawicki contributed the following script, which makes very clever
use of the parameter substitution operators discussed in `Section
10.2 <parameter-substitution.html>`__ .

.. raw:: html

   <div class="EXAMPLE">

**Example A-13. *password* : Generating random 8-character passwords**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     #                    |
|     #                    |
|     #  Random password g |
| enerator for Bash 2.x +  |
|     #+ by Antek Sawicki  |
| <tenox@tenox.tc>,        |
|     #+ who generously ga |
| ve usage permission to t |
| he ABS Guide author.     |
|     #                    |
|     # ==> Comments added |
|  by document author ==>  |
|                          |
|                          |
|     MATRIX="0123456789AB |
| CDEFGHIJKLMNOPQRSTUVWXYZ |
| abcdefghijklmnopqrstuvwx |
| yz"                      |
|     # ==> Password will  |
| consist of alphanumeric  |
| characters.              |
|     LENGTH="8"           |
|     # ==> May change 'LE |
| NGTH' for longer passwor |
| d.                       |
|                          |
|                          |
|     while [ "${n:=1}" -l |
| e "$LENGTH" ]            |
|     # ==> Recall that := |
|  is "default substitutio |
| n" operator.             |
|     # ==> So, if 'n' has |
|  not been initialized, s |
| et it to 1.              |
|     do                   |
|         PASS="$PASS${MAT |
| RIX:$(($RANDOM%${#MATRIX |
| })):1}"                  |
|         # ==> Very cleve |
| r, but tricky.           |
|                          |
|         # ==> Starting f |
| rom the innermost nestin |
| g...                     |
|         # ==> ${#MATRIX} |
|  returns length of array |
|  MATRIX.                 |
|                          |
|         # ==> $RANDOM%${ |
| #MATRIX} returns random  |
| number between 1         |
|         # ==> and [lengt |
| h of MATRIX] - 1.        |
|                          |
|         # ==> ${MATRIX:$ |
| (($RANDOM%${#MATRIX})):1 |
| }                        |
|         # ==> returns ex |
| pansion of MATRIX at ran |
| dom position, by length  |
| 1.                       |
|         # ==> See {var:p |
| os:len} parameter substi |
| tution in Chapter 9.     |
|         # ==> and the as |
| sociated examples.       |
|                          |
|         # ==> PASS=... s |
| imply pastes this result |
|  onto previous PASS (con |
| catenation).             |
|                          |
|         # ==> To visuali |
| ze this more clearly, un |
| comment the following li |
| ne                       |
|         #                |
|   echo "$PASS"           |
|         # ==> to see PAS |
| S being built up,        |
|         # ==> one charac |
| ter at a time, each iter |
| ation of the loop.       |
|                          |
|         let n+=1         |
|         # ==> Increment  |
| 'n' for next pass.       |
|     done                 |
|                          |
|     echo "$PASS"      #  |
| ==> Or, redirect to a fi |
| le, as desired.          |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

+

 James R. Van Zandt contributed this script which uses named pipes and,
in his words, "really exercises quoting and escaping."

.. raw:: html

   <div class="EXAMPLE">

**Example A-14. *fifo* : Making daily backups, using named pipes**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ==> Script by Jame |
| s R. Van Zandt, and used |
|  here with his permissio |
| n.                       |
|                          |
|     # ==> Comments added |
|  by author of this docum |
| ent.                     |
|                          |
|                          |
|       HERE=`uname -n`    |
|  # ==> hostname          |
|       THERE=bilbo        |
|       echo "starting rem |
| ote backup to $THERE at  |
| `date +%r`"              |
|       # ==> `date +%r` r |
| eturns time in 12-hour f |
| ormat, i.e. "08:08:34 PM |
| ".                       |
|                          |
|       # make sure /pipe  |
| really is a pipe and not |
|  a plain file            |
|       rm -rf /pipe       |
|       mkfifo /pipe       |
|  # ==> Create a "named p |
| ipe", named "/pipe" ...  |
|                          |
|       # ==> 'su xyz' run |
| s commands as user "xyz" |
| .                        |
|       # ==> 'ssh' invoke |
| s secure shell (remote l |
| ogin client).            |
|       su xyz -c "ssh $TH |
| ERE \"cat > /home/xyz/ba |
| ckup/${HERE}-daily.tar.g |
| z\" < /pipe"&            |
|       cd /               |
|       tar -czf - bin boo |
| t dev etc home info lib  |
| man root sbin share usr  |
| var > /pipe              |
|       # ==> Uses named p |
| ipe, /pipe, to communica |
| te between processes:    |
|       # ==> 'tar/gzip' w |
| rites to /pipe and 'ssh' |
|  reads from /pipe.       |
|                          |
|       # ==> The end resu |
| lt is this backs up the  |
| main directories, from / |
|  on down.                |
|                          |
|       # ==>  What are th |
| e advantages of a "named |
|  pipe" in this situation |
| ,                        |
|       # ==>+ as opposed  |
| to an "anonymous pipe",  |
| with |?                  |
|       # ==>  Will an ano |
| nymous pipe even work he |
| re?                      |
|                          |
|       # ==>  Is it neces |
| sary to delete the pipe  |
| before exiting the scrip |
| t?                       |
|       # ==>  How could t |
| hat be done?             |
|                          |
|                          |
|       exit 0             |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

+

Stéphane Chazelas used the following script to demonstrate generating
prime numbers without arrays.

.. raw:: html

   <div class="EXAMPLE">

**Example A-15. Generating prime numbers using the modulo operator**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # primes.sh: Generat |
| e prime numbers, without |
|  using arrays.           |
|     # Script contributed |
|  by Stephane Chazelas.   |
|                          |
|     #  This does *not* u |
| se the classic "Sieve of |
|  Eratosthenes" algorithm |
| ,                        |
|     #+ but instead the m |
| ore intuitive method of  |
| testing each candidate n |
| umber                    |
|     #+ for factors (divi |
| sors), using the "%" mod |
| ulo operator.            |
|                          |
|                          |
|     LIMIT=1000           |
|           # Primes, 2 .. |
| . 1000.                  |
|                          |
|     Primes()             |
|     {                    |
|      (( n = $1 + 1 ))    |
|           # Bump to next |
|  integer.                |
|      shift               |
|           # Next paramet |
| er in list.              |
|     #  echo "_n=$n i=$i_ |
| "                        |
|                          |
|      if (( n == LIMIT )) |
|      then echo $*        |
|      return              |
|      fi                  |
|                          |
|      for i; do           |
|           # "i" set to " |
| @", previous values of $ |
| n.                       |
|     #   echo "-n=$n i=$i |
| -"                       |
|        (( i * i > n )) & |
| & break   # Optimization |
| .                        |
|        (( n % i )) && co |
| ntinue    # Sift out non |
| -primes using modulo ope |
| rator.                   |
|        Primes $n $@      |
|           # Recursion in |
| side loop.               |
|        return            |
|        done              |
|                          |
|        Primes $n $@ $n   |
|           #  Recursion o |
| utside loop.             |
|                          |
|           #  Successivel |
| y accumulate             |
|                       #+ |
|  positional parameters.  |
|                          |
|           #  "$@" is the |
|  accumulating list of pr |
| imes.                    |
|     }                    |
|                          |
|     Primes 1             |
|                          |
|     exit $?              |
|                          |
|     # Pipe output of the |
|  script to 'fmt' for pre |
| ttier printing.          |
|                          |
|     #  Uncomment lines 1 |
| 6 and 24 to help figure  |
| out what is going on.    |
|                          |
|     #  Compare the speed |
|  of this algorithm for g |
| enerating primes         |
|     #+ with the Sieve of |
|  Eratosthenes (ex68.sh). |
|                          |
|                          |
|     #  Exercise: Rewrite |
|  this script without rec |
| ursion.                  |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

+

Rick Boivie's revision of Jordi Sanfeliu's *tree* script.

.. raw:: html

   <div class="EXAMPLE">

**Example A-16. *tree* : Displaying a directory tree**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # tree.sh            |
|                          |
|     #  Written by Rick B |
| oivie.                   |
|     #  Used with permiss |
| ion.                     |
|     #  This is a revised |
|  and simplified version  |
| of a script              |
|     #+ by Jordi Sanfeliu |
|  (the original author),  |
| and patched by Ian Kjos. |
|     #  This script repla |
| ces the earlier version  |
| used in                  |
|     #+ previous releases |
|  of the Advanced Bash Sc |
| ripting Guide.           |
|     #  Copyright (c) 200 |
| 2, by Jordi Sanfeliu, Ri |
| ck Boivie, and Ian Kjos. |
|                          |
|     # ==> Comments added |
|  by the author of this d |
| ocument.                 |
|                          |
|                          |
|     search () {          |
|     for dir in `echo *`  |
|     #  ==> `echo *` list |
| s all the files in curre |
| nt working directory,    |
|     #+ ==> without line  |
| breaks.                  |
|     #  ==> Similar effec |
| t to for dir in *        |
|     #  ==> but "dir in ` |
| echo *`" will not handle |
|  filenames with blanks.  |
|     do                   |
|       if [ -d "$dir" ] ; |
|  then # ==> If it is a d |
| irectory (-d)...         |
|       zz=0               |
|       # ==> Temp variabl |
| e, keeping track of      |
|                          |
|       #     directory le |
| vel.                     |
|       while [ $zz != $1  |
| ]     # Keep track of in |
| ner nested loop.         |
|         do               |
|           echo -n "| "   |
|       # ==> Display vert |
| ical connector symbol,   |
|                          |
|       # ==> with 2 space |
| s & no line feed         |
|                          |
|       #     in order to  |
| indent.                  |
|           zz=`expr $zz + |
|  1`   # ==> Increment zz |
| .                        |
|         done             |
|                          |
|         if [ -L "$dir" ] |
|  ; then # ==> If directo |
| ry is a symbolic link... |
|           echo "+---$dir |
| " `ls -l $dir | sed 's/^ |
| .*'$dir' //'`            |
|           # ==> Display  |
| horiz. connector and lis |
| t directory name, but... |
|           # ==> delete d |
| ate/time part of long li |
| sting.                   |
|         else             |
|           echo "+---$dir |
| "       # ==> Display ho |
| rizontal connector symbo |
| l...                     |
|           # ==> and prin |
| t directory name.        |
|           numdirs=`expr  |
| $numdirs + 1` # ==> Incr |
| ement directory count.   |
|           if cd "$dir" ; |
|  then         # ==> If c |
| an move to subdirectory. |
| ..                       |
|             search `expr |
|  $1 + 1`      # with rec |
| ursion ;-)               |
|             # ==> Functi |
| on calls itself.         |
|             cd ..        |
|           fi             |
|         fi               |
|       fi                 |
|     done                 |
|     }                    |
|                          |
|     if [ $# != 0 ] ; the |
| n                        |
|       cd $1   # Move to  |
| indicated directory.     |
|       #else   # stay in  |
| current directory        |
|     fi                   |
|                          |
|     echo "Initial direct |
| ory = `pwd`"             |
|     numdirs=0            |
|                          |
|     search 0             |
|     echo "Total director |
| ies = $numdirs"          |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Patsie's version of a directory *tree* script.

.. raw:: html

   <div class="EXAMPLE">

**Example A-17. *tree2* : Alternate directory tree script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # tree2.sh           |
|                          |
|     # Lightly modified/r |
| eformatted by ABS Guide  |
| author.                  |
|     # Included in ABS Gu |
| ide with permission of s |
| cript author (thanks!).  |
|                          |
|     ## Recursive file/di |
| rsize checking script, b |
| y Patsie                 |
|     ##                   |
|     ## This script build |
| s a list of files/direct |
| ories and their size (du |
|  -akx)                   |
|     ## and processes thi |
| s list to a human readab |
| le tree shape            |
|     ## The 'du -akx' is  |
| only as good as the perm |
| issions the owner has.   |
|     ## So preferably run |
|  as root* to get the bes |
| t results, or use only o |
| n                        |
|     ## directories for w |
| hich you have read permi |
| ssions. Anything you can |
| 't                       |
|     ## read is not in th |
| e list.                  |
|                          |
|     #* ABS Guide author  |
| advises caution when run |
| ning scripts as root!    |
|                          |
|                          |
|     ##########  THIS IS  |
| CONFIGURABLE  ########## |
|                          |
|     TOP=5                |
|     # Top 5 biggest (sub |
| )directories.            |
|     MAXRECURS=5          |
|     # Max 5 subdirectori |
| es/recursions deep.      |
|     E_BL=80              |
|     # Blank line already |
|  returned.               |
|     E_DIR=81             |
|     # Directory not spec |
| ified.                   |
|                          |
|                          |
|     ##########  DON'T CH |
| ANGE ANYTHING BELOW THIS |
|  LINE  ##########        |
|                          |
|     PID=$$               |
|               # Our own  |
| process ID.              |
|     SELF=`basename $0`   |
|               # Our own  |
| program name.            |
|     TMP="/tmp/${SELF}.${ |
| PID}.tmp"     # Temporar |
| y 'du' result.           |
|                          |
|     # Convert number to  |
| dotted thousand.         |
|     function dot { echo  |
| "            $*" |       |
|                    sed - |
| e :a -e 's/\(.*[0-9]\)\( |
| [0-9]\{3\}\)/\1,\2/;ta'  |
| |                        |
|                    tail  |
| -c 12; }                 |
|                          |
|     # Usage: tree <recur |
| sion> <indent prefix> <m |
| in size> <directory>     |
|     function tree {      |
|       recurs="$1"        |
|     # How deep nested ar |
| e we?                    |
|       prefix="$2"        |
|     # What do we display |
|  before file/dirname?    |
|       minsize="$3"       |
|     # What is the minumu |
| m file/dirsize?          |
|       dirname="$4"       |
|     # Which directory ar |
| e we checking?           |
|                          |
|     # Get ($TOP) biggest |
|  subdirs/subfiles from T |
| MP file.                 |
|       LIST=`egrep "[[:sp |
| ace:]]${dirname}/[^/]*$" |
|  "$TMP" |                |
|             awk '{if($1> |
| '$minsize') print;}' | s |
| ort -nr | head -$TOP`    |
|       [ -z "$LIST" ] &&  |
| return        # Empty li |
| st, then go back.        |
|                          |
|       cnt=0              |
|       num=`echo "$LIST"  |
| | wc -l`      # How many |
|  entries in the list.    |
|                          |
|       ## Main loop       |
|       echo "$LIST" | whi |
| le read size name; do    |
|         ((cnt+=1))       |
|           # Count entry  |
| number.                  |
|         bname=`basename  |
| "$name"`      # We only  |
| need a basename of the e |
| ntry.                    |
|         [ -d "$name" ] & |
| & bname="$bname/"        |
|                          |
|               # If it's  |
| a directory, append a sl |
| ash.                     |
|         echo "`dot $size |
| `$prefix +-$bname"       |
|                          |
|               # Display  |
| the result.              |
|         #  Call ourself  |
| recursively if it's a di |
| rectory                  |
|         #+ and we're not |
|  nested too deep ($MAXRE |
| CURS).                   |
|         #  The recursion |
|  goes up: $((recurs+1))  |
|         #  The prefix ge |
| ts a space if it's the l |
| ast entry,               |
|         #+ or a pipe if  |
| there are more entries.  |
|         #  The minimum f |
| ile/dirsize becomes      |
|         #+ a tenth of hi |
| s parent: $((size/10)).  |
|         # Last argument  |
| is the full directory na |
| me to check.             |
|         if [ -d "$name"  |
| -a $recurs -lt $MAXRECUR |
| S ]; then                |
|           [ $cnt -lt $nu |
| m ] \                    |
|             || (tree $(( |
| recurs+1)) "$prefix  " $ |
| ((size/10)) "$name") \   |
|             && (tree $(( |
| recurs+1)) "$prefix |" $ |
| ((size/10)) "$name")     |
|         fi               |
|       done               |
|                          |
|       [ $? -eq 0 ] && ec |
| ho "           $prefix"  |
|       # Every time we ju |
| mp back add a 'blank' li |
| ne.                      |
|       return $E_BL       |
|       # We return 80 to  |
| tell we added a blank li |
| ne already.              |
|     }                    |
|                          |
|     ###                # |
| ##                       |
|     ###  main program  # |
| ##                       |
|     ###                # |
| ##                       |
|                          |
|     rootdir="$@"         |
|     [ -d "$rootdir" ] || |
|       { echo "$SELF: Usa |
| ge: $SELF <directory>" > |
| &2; exit $E_DIR; }       |
|       # We should be cal |
| led with a directory nam |
| e.                       |
|                          |
|     echo "Building inven |
| tory list, please wait . |
| .."                      |
|          # Show "please  |
| wait" message.           |
|     du -akx "$rootdir" 1 |
| >"$TMP" 2>/dev/null      |
|          # Build a tempo |
| rary list of all files/d |
| irs and their size.      |
|     size=`tail -1 "$TMP" |
|  | awk '{print $1}'`     |
|          # What is our r |
| ootdirectory's size?     |
|     echo "`dot $size` $r |
| ootdir"                  |
|          # Display rootd |
| irectory's entry.        |
|     tree 0 "" 0 "$rootdi |
| r"                       |
|          # Display the t |
| ree below our rootdirect |
| ory.                     |
|                          |
|     rm "$TMP" 2>/dev/nul |
| l                        |
|          # Clean up TMP  |
| file.                    |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Noah Friedman permitted use of his *string function* script. It
essentially reproduces some of the *C* -library string manipulation
functions.

.. raw:: html

   <div class="EXAMPLE">

**Example A-18. *string functions* : C-style string functions**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # string.bash --- ba |
| sh emulation of string(3 |
| ) library routines       |
|     # Author: Noah Fried |
| man <friedman@prep.ai.mi |
| t.edu>                   |
|     # ==>     Used with  |
| his kind permission in t |
| his document.            |
|     # Created: 1992-07-0 |
| 1                        |
|     # Last modified: 199 |
| 3-09-29                  |
|     # Public domain      |
|                          |
|     # Conversion to bash |
|  v2 syntax done by Chet  |
| Ramey                    |
|                          |
|     # Commentary:        |
|     # Code:              |
|                          |
|     #:docstring strcat:  |
|     # Usage: strcat s1 s |
| 2                        |
|     #                    |
|     # Strcat appends the |
|  value of variable s2 to |
|  variable s1.            |
|     #                    |
|     # Example:           |
|     #    a="foo"         |
|     #    b="bar"         |
|     #    strcat a b      |
|     #    echo $a         |
|     #    => foobar       |
|     #                    |
|     #:end docstring:     |
|                          |
|     ###;;;autoload   ==> |
|  Autoloading of function |
|  commented out.          |
|     function strcat ()   |
|     {                    |
|         local s1_val s2_ |
| val                      |
|                          |
|         s1_val=${!1}     |
|                     # in |
| direct variable expansio |
| n                        |
|         s2_val=${!2}     |
|         eval "$1"=\'"${s |
| 1_val}${s2_val}"\'       |
|         # ==> eval $1='$ |
| {s1_val}${s2_val}' avoid |
| s problems,              |
|         # ==> if one of  |
| the variables contains a |
|  single quote.           |
|     }                    |
|                          |
|     #:docstring strncat: |
|     # Usage: strncat s1  |
| s2 $n                    |
|     #                    |
|     # Line strcat, but s |
| trncat appends a maximum |
|  of n characters from th |
| e value                  |
|     # of variable s2.  I |
| t copies fewer if the va |
| lue of variabl s2 is sho |
| rter                     |
|     # than n characters. |
|   Echoes result on stdou |
| t.                       |
|     #                    |
|     # Example:           |
|     #    a=foo           |
|     #    b=barbaz        |
|     #    strncat a b 3   |
|     #    echo $a         |
|     #    => foobar       |
|     #                    |
|     #:end docstring:     |
|                          |
|     ###;;;autoload       |
|     function strncat ()  |
|     {                    |
|         local s1="$1"    |
|         local s2="$2"    |
|         local -i n="$3"  |
|         local s1_val s2_ |
| val                      |
|                          |
|         s1_val=${!s1}    |
|                     # == |
| > indirect variable expa |
| nsion                    |
|         s2_val=${!s2}    |
|                          |
|         if [ ${#s2_val}  |
| -gt ${n} ]; then         |
|            s2_val=${s2_v |
| al:0:$n}            # == |
| > substring extraction   |
|         fi               |
|                          |
|         eval "$s1"=\'"${ |
| s1_val}${s2_val}"\'      |
|         # ==> eval $1='$ |
| {s1_val}${s2_val}' avoid |
| s problems,              |
|         # ==> if one of  |
| the variables contains a |
|  single quote.           |
|     }                    |
|                          |
|     #:docstring strcmp:  |
|     # Usage: strcmp $s1  |
| $s2                      |
|     #                    |
|     # Strcmp compares it |
| s arguments and returns  |
| an integer less than, eq |
| ual to,                  |
|     # or greater than ze |
| ro, depending on whether |
|  string s1 is lexicograp |
| hically                  |
|     # less than, equal t |
| o, or greater than strin |
| g s2.                    |
|     #:end docstring:     |
|                          |
|     ###;;;autoload       |
|     function strcmp ()   |
|     {                    |
|         [ "$1" = "$2" ]  |
| && return 0              |
|                          |
|         [ "${1}" '<' "${ |
| 2}" ] > /dev/null && ret |
| urn -1                   |
|                          |
|         return 1         |
|     }                    |
|                          |
|     #:docstring strncmp: |
|     # Usage: strncmp $s1 |
|  $s2 $n                  |
|     #                    |
|     # Like strcmp, but m |
| akes the comparison by e |
| xamining a maximum of n  |
|     # characters (n less |
|  than or equal to zero y |
| ields equality).         |
|     #:end docstring:     |
|                          |
|     ###;;;autoload       |
|     function strncmp ()  |
|     {                    |
|         if [ -z "${3}" - |
| o "${3}" -le "0" ]; then |
|            return 0      |
|         fi               |
|                          |
|         if [ ${3} -ge ${ |
| #1} -a ${3} -ge ${#2} ]; |
|  then                    |
|            strcmp "$1" " |
| $2"                      |
|            return $?     |
|         else             |
|            s1=${1:0:$3}  |
|            s2=${2:0:$3}  |
|            strcmp $s1 $s |
| 2                        |
|            return $?     |
|         fi               |
|     }                    |
|                          |
|     #:docstring strlen:  |
|     # Usage: strlen s    |
|     #                    |
|     # Strlen returns the |
|  number of characters in |
|  string literal s.       |
|     #:end docstring:     |
|                          |
|     ###;;;autoload       |
|     function strlen ()   |
|     {                    |
|         eval echo "\${#$ |
| {1}}"                    |
|         # ==> Returns th |
| e length of the value of |
|  the variable            |
|         # ==> whose name |
|  is passed as an argumen |
| t.                       |
|     }                    |
|                          |
|     #:docstring strspn:  |
|     # Usage: strspn $s1  |
| $s2                      |
|     #                    |
|     # Strspn returns the |
|  length of the maximum i |
| nitial segment of string |
|  s1,                     |
|     # which consists ent |
| irely of characters from |
|  string s2.              |
|     #:end docstring:     |
|                          |
|     ###;;;autoload       |
|     function strspn ()   |
|     {                    |
|         # Unsetting IFS  |
| allows whitespace to be  |
| handled as normal chars. |
|                          |
|         local IFS=       |
|         local result="${ |
| 1%%[!${2}]*}"            |
|                          |
|         echo ${#result}  |
|     }                    |
|                          |
|     #:docstring strcspn: |
|     # Usage: strcspn $s1 |
|  $s2                     |
|     #                    |
|     # Strcspn returns th |
| e length of the maximum  |
| initial segment of strin |
| g s1,                    |
|     # which consists ent |
| irely of characters not  |
| from string s2.          |
|     #:end docstring:     |
|                          |
|     ###;;;autoload       |
|     function strcspn ()  |
|     {                    |
|         # Unsetting IFS  |
| allows whitspace to be h |
| andled as normal chars.  |
|         local IFS=       |
|         local result="${ |
| 1%%[${2}]*}"             |
|                          |
|         echo ${#result}  |
|     }                    |
|                          |
|     #:docstring strstr:  |
|     # Usage: strstr s1 s |
| 2                        |
|     #                    |
|     # Strstr echoes a su |
| bstring starting at the  |
| first occurrence of stri |
| ng s2 in                 |
|     # string s1, or noth |
| ing if s2 does not occur |
|  in the string.  If s2 p |
| oints to                 |
|     # a string of zero l |
| ength, strstr echoes s1. |
|     #:end docstring:     |
|                          |
|     ###;;;autoload       |
|     function strstr ()   |
|     {                    |
|         # if s2 points t |
| o a string of zero lengt |
| h, strstr echoes s1      |
|         [ ${#2} -eq 0 ]  |
| && { echo "$1" ; return  |
| 0; }                     |
|                          |
|         # strstr echoes  |
| nothing if s2 does not o |
| ccur in s1               |
|         case "$1" in     |
|         *$2*) ;;         |
|         *) return 1;;    |
|         esac             |
|                          |
|         # use the patter |
| n matching code to strip |
|  off the match and every |
| thing                    |
|         # following it   |
|         first=${1/$2*/}  |
|                          |
|         # then strip off |
|  the first unmatched por |
| tion of the string       |
|         echo "${1##$firs |
| t}"                      |
|     }                    |
|                          |
|     #:docstring strtok:  |
|     # Usage: strtok s1 s |
| 2                        |
|     #                    |
|     # Strtok considers t |
| he string s1 to consist  |
| of a sequence of zero or |
|  more                    |
|     # text tokens separa |
| ted by spans of one or m |
| ore characters from the  |
|     # separator string s |
| 2.  The first call (with |
|  a non-empty string s1   |
|     # specified) echoes  |
| a string consisting of t |
| he first token on stdout |
| . The                    |
|     # function keeps tra |
| ck of its position in th |
| e string s1 between sepa |
| rate                     |
|     # calls, so that sub |
| sequent calls made with  |
| the first argument an em |
| pty                      |
|     # string will work t |
| hrough the string immedi |
| ately following that tok |
| en.  In                  |
|     # this way subsequen |
| t calls will work throug |
| h the string s1 until no |
|  tokens                  |
|     # remain.  The separ |
| ator string s2 may be di |
| fferent from call to cal |
| l.                       |
|     # When no token rema |
| ins in s1, an empty valu |
| e is echoed on stdout.   |
|     #:end docstring:     |
|                          |
|     ###;;;autoload       |
|     function strtok ()   |
|     {                    |
|      :                   |
|     }                    |
|                          |
|     #:docstring strtrunc |
| :                        |
|     # Usage: strtrunc $n |
|  $s1 {$s2} {$...}        |
|     #                    |
|     # Used by many funct |
| ions like strncmp to tru |
| ncate arguments for comp |
| arison.                  |
|     # Echoes the first n |
|  characters of each stri |
| ng s1 s2 ... on stdout.  |
|     #:end docstring:     |
|                          |
|     ###;;;autoload       |
|     function strtrunc () |
|     {                    |
|         n=$1 ; shift     |
|         for z; do        |
|             echo "${z:0: |
| $n}"                     |
|         done             |
|     }                    |
|                          |
|     # provide string     |
|                          |
|     # string.bash ends h |
| ere                      |
|                          |
|                          |
|     # ================== |
| ======================== |
| ======================== |
| ======== #               |
|     # ==> Everything bel |
| ow here added by the doc |
| ument author.            |
|                          |
|     # ==> Suggested use  |
| of this script is to del |
| ete everything below her |
| e,                       |
|     # ==> and "source" t |
| his file into your own s |
| cripts.                  |
|                          |
|     # strcat             |
|     string0=one          |
|     string1=two          |
|     echo                 |
|     echo "Testing \"strc |
| at\" function:"          |
|     echo "Original \"str |
| ing0\" = $string0"       |
|     echo "\"string1\" =  |
| $string1"                |
|     strcat string0 strin |
| g1                       |
|     echo "New \"string0\ |
| " = $string0"            |
|     echo                 |
|                          |
|     # strlen             |
|     echo                 |
|     echo "Testing \"strl |
| en\" function:"          |
|     str=123456789        |
|     echo "\"str\" = $str |
| "                        |
|     echo -n "Length of \ |
| "str\" = "               |
|     strlen str           |
|     echo                 |
|                          |
|                          |
|                          |
|     # Exercise:          |
|     # --------           |
|     # Add code to test a |
| ll the other string func |
| tions above.             |
|                          |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Michael Zick's complex array example uses the
`md5sum <filearchiv.html#MD5SUMREF>`__ check sum command to encode
directory information.

.. raw:: html

   <div class="EXAMPLE">

**Example A-19. Directory information**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # directory-info.sh  |
|     # Parses and lists d |
| irectory information.    |
|                          |
|     # NOTE: Change lines |
|  273 and 353 per "README |
| " file.                  |
|                          |
|     # Michael Zick is th |
| e author of this script. |
|     # Used here with his |
|  permission.             |
|                          |
|     # Controls           |
|     # If overridden by c |
| ommand arguments, they m |
| ust be in the order:     |
|     #   Arg1: "Descripto |
| r Directory"             |
|     #   Arg2: "Exclude P |
| aths"                    |
|     #   Arg3: "Exclude D |
| irectories"              |
|     #                    |
|     # Environment Settin |
| gs override Defaults.    |
|     # Command arguments  |
| override Environment Set |
| tings.                   |
|                          |
|     # Default location f |
| or content addressed fil |
| e descriptors.           |
|     MD5UCFS=${1:-${MD5UC |
| FS:-'/tmpfs/ucfs'}}      |
|                          |
|     # Directory paths ne |
| ver to list or enter     |
|     declare -a \         |
|       EXCLUDE_PATHS=${2: |
| -${EXCLUDE_PATHS:-'(/pro |
| c /dev /devfs /tmpfs)'}} |
|                          |
|     # Directories never  |
| to list or enter         |
|     declare -a \         |
|       EXCLUDE_DIRS=${3:- |
| ${EXCLUDE_DIRS:-'(ucfs l |
| ost+found tmp wtmp)'}}   |
|                          |
|     # Files never to lis |
| t or enter               |
|     declare -a \         |
|       EXCLUDE_FILES=${3: |
| -${EXCLUDE_FILES:-'(core |
|  "Name with Spaces")'}}  |
|                          |
|                          |
|     # Here document used |
|  as a comment block.     |
|     : <<LSfieldsDoc      |
|     # # # # # List Files |
| ystem Directory Informat |
| ion # # # # #            |
|     #                    |
|     #   ListDirectory "F |
| ileGlob" "Field-Array-Na |
| me"                      |
|     # or                 |
|     #   ListDirectory -o |
| f "FileGlob" "Field-Arra |
| y-Filename"              |
|     #   '-of' meaning 'o |
| utput to filename'       |
|     # # # # #            |
|                          |
|     String format descri |
| ption based on: ls (GNU  |
| fileutils) version 4.0.3 |
| 6                        |
|                          |
|     Produces a line (or  |
| more) formatted:         |
|     inode permissions ha |
| rd-links owner group ... |
|     32736 -rw-------     |
| 1 mszick   mszick        |
|                          |
|     size    day month da |
| te hh:mm:ss year path    |
|     2756608 Sun Apr 20 0 |
| 8:53:06 2003 /home/mszic |
| k/core                   |
|                          |
|     Unless it is formatt |
| ed:                      |
|     inode permissions ha |
| rd-links owner group ... |
|     266705 crw-rw----    |
|  1    root  uucp         |
|                          |
|     major minor day mont |
| h date hh:mm:ss year pat |
| h                        |
|     4,  68 Sun Apr 20 09 |
| :27:33 2003 /dev/ttyS4   |
|     NOTE: that pesky com |
| ma after the major numbe |
| r                        |
|                          |
|     NOTE: the 'path' may |
|  be multiple fields:     |
|     /home/mszick/core    |
|     /proc/982/fd/0 -> /d |
| ev/null                  |
|     /proc/982/fd/1 -> /h |
| ome/mszick/.xsession-err |
| ors                      |
|     /proc/982/fd/13 -> / |
| tmp/tmpfZVVOCs (deleted) |
|     /proc/982/fd/7 -> /t |
| mp/kde-mszick/ksycoca    |
|     /proc/982/fd/8 -> so |
| cket:[11586]             |
|     /proc/982/fd/9 -> pi |
| pe:[11588]               |
|                          |
|     If that isn't enough |
|  to keep your parser gue |
| ssing,                   |
|     either or both of th |
| e path components may be |
|  relative:               |
|     ../Built-Shared -> B |
| uilt-Static              |
|     ../linux-2.4.20.tar. |
| bz2 -> ../../../SRCS/lin |
| ux-2.4.20.tar.bz2        |
|                          |
|     The first character  |
| of the 11 (10?) characte |
| r permissions field:     |
|     's' Socket           |
|     'd' Directory        |
|     'b' Block device     |
|     'c' Character device |
|     'l' Symbolic link    |
|     NOTE: Hard links not |
|  marked - test for ident |
| ical inode numbers       |
|     on identical filesys |
| tems.                    |
|     All information abou |
| t hard linked files are  |
| shared, except           |
|     for the names and th |
| e name's location in the |
|  directory system.       |
|     NOTE: A "Hard link"  |
| is known as a "File Alia |
| s" on some systems.      |
|     '-' An undistingushe |
| d file                   |
|                          |
|     Followed by three gr |
| oups of letters for: Use |
| r, Group, Others         |
|     Character 1: '-' Not |
|  readable; 'r' Readable  |
|     Character 2: '-' Not |
|  writable; 'w' Writable  |
|     Character 3, User an |
| d Group: Combined execut |
| e and special            |
|     '-' Not Executable,  |
| Not Special              |
|     'x' Executable, Not  |
| Special                  |
|     's' Executable, Spec |
| ial                      |
|     'S' Not Executable,  |
| Special                  |
|     Character 3, Others: |
|  Combined execute and st |
| icky (tacky?)            |
|     '-' Not Executable,  |
| Not Tacky                |
|     'x' Executable, Not  |
| Tacky                    |
|     't' Executable, Tack |
| y                        |
|     'T' Not Executable,  |
| Tacky                    |
|                          |
|     Followed by an acces |
| s indicator              |
|     Haven't tested this  |
| one, it may be the eleve |
| nth character            |
|     or it may generate a |
| nother field             |
|     ' ' No alternate acc |
| ess                      |
|     '+' Alternate access |
|     LSfieldsDoc          |
|                          |
|                          |
|     ListDirectory()      |
|     {                    |
|         local -a T       |
|         local -i of=0    |
|     # Default return in  |
| variable                 |
|     #   OLD_IFS=$IFS     |
|     # Using BASH default |
|  ' \t\n'                 |
|                          |
|         case "$#" in     |
|         3)  case "$1" in |
|             -of)    of=1 |
|  ; shift ;;              |
|              * )    retu |
| rn 1 ;;                  |
|             esac ;;      |
|         2)  : ;;         |
| # Poor man's "continue"  |
|         *)  return 1 ;;  |
|         esac             |
|                          |
|         # NOTE: the (ls) |
|  command is NOT quoted ( |
| ")                       |
|         T=( $(ls --inode |
|  --ignore-backups --almo |
| st-all --directory \     |
|         --full-time --co |
| lor=none --time=status - |
| -sort=none \             |
|         --format=long $1 |
| ) )                      |
|                          |
|         case $of in      |
|         # Assign T back  |
| to the array whose name  |
| was passed as $2         |
|             0) eval $2=\ |
| ( \"\$\{T\[@\]\}\" \) ;; |
|         # Write T into f |
| ilename passed as $2     |
|             1) echo "${T |
| [@]}" > "$2" ;;          |
|         esac             |
|         return 0         |
|        }                 |
|                          |
|     # # # # # Is that st |
| ring a legal number? # # |
|  # # #                   |
|     #                    |
|     #   IsNumber "Var"   |
|     # # # # # There has  |
| to be a better way, sigh |
| ...                      |
|                          |
|     IsNumber()           |
|     {                    |
|         local -i int     |
|         if [ $# -eq 0 ]  |
|         then             |
|             return 1     |
|         else             |
|             (let int=$1) |
|   2>/dev/null            |
|             return $?    |
| # Exit status of the let |
|  thread                  |
|         fi               |
|     }                    |
|                          |
|     # # # # # Index File |
| system Directory Informa |
| tion # # # # #           |
|     #                    |
|     #   IndexList "Field |
| -Array-Name" "Index-Arra |
| y-Name"                  |
|     # or                 |
|     #   IndexList -if Fi |
| eld-Array-Filename Index |
| -Array-Name              |
|     #   IndexList -of Fi |
| eld-Array-Name Index-Arr |
| ay-Filename              |
|     #   IndexList -if -o |
| f Field-Array-Filename I |
| ndex-Array-Filename      |
|     # # # # #            |
|                          |
|     : <<IndexListDoc     |
|     Walk an array of dir |
| ectory fields produced b |
| y ListDirectory          |
|                          |
|     Having suppressed th |
| e line breaks in an othe |
| rwise line oriented      |
|     report, build an ind |
| ex to the array element  |
| which starts each line.  |
|                          |
|     Each line gets two i |
| ndex entries, the first  |
| element of each line     |
|     (inode) and the elem |
| ent that holds the pathn |
| ame of the file.         |
|                          |
|     The first index entr |
| y pair (Line-Number==0)  |
| are informational:       |
|     Index-Array-Name[0]  |
| : Number of "Lines" inde |
| xed                      |
|     Index-Array-Name[1]  |
| : "Current Line" pointer |
|  into Index-Array-Name   |
|                          |
|     The following index  |
| pairs (if any) hold elem |
| ent indexes into         |
|     the Field-Array-Name |
|  per:                    |
|     Index-Array-Name[Lin |
| e-Number * 2] : The "ino |
| de" field element.       |
|     NOTE: This distance  |
| may be either +11 or +12 |
|  elements.               |
|     Index-Array-Name[(Li |
| ne-Number * 2) + 1] : Th |
| e "pathname" element.    |
|     NOTE: This distance  |
| may be a variable number |
|  of elements.            |
|     Next line index pair |
|  for Line-Number+1.      |
|     IndexListDoc         |
|                          |
|                          |
|                          |
|     IndexList()          |
|     {                    |
|         local -a LIST    |
|         # Local of listn |
| ame passed               |
|         local -a -i INDE |
| X=( 0 0 )   # Local of i |
| ndex to return           |
|         local -i Lidx Lc |
| nt                       |
|         local -i if=0 of |
| =0      # Default to var |
| iable names              |
|                          |
|         case "$#" in     |
|         # Simplistic opt |
| ion testing              |
|             0) return 1  |
| ;;                       |
|             1) return 1  |
| ;;                       |
|             2) : ;;      |
|     # Poor man's continu |
| e                        |
|             3) case "$1" |
|  in                      |
|                 -if) if= |
| 1 ;;                     |
|                 -of) of= |
| 1 ;;                     |
|                  * ) ret |
| urn 1 ;;                 |
|                esac ; sh |
| ift ;;                   |
|             4) if=1 ; of |
| =1 ; shift ; shift ;;    |
|             *) return 1  |
|         esac             |
|                          |
|         # Make local cop |
| y of list                |
|         case "$if" in    |
|             0) eval LIST |
| =\( \"\$\{$1\[@\]\}\" \) |
|  ;;                      |
|             1) LIST=( $( |
| cat $1) ) ;;             |
|         esac             |
|                          |
|         # Grok (grope?)  |
| the array                |
|         Lcnt=${#LIST[@]} |
|         Lidx=0           |
|         until (( Lidx >= |
|  Lcnt ))                 |
|         do               |
|         if IsNumber ${LI |
| ST[$Lidx]}               |
|         then             |
|             local -i ino |
| de name                  |
|             local ft     |
|             inode=Lidx   |
|             local m=${LI |
| ST[$Lidx+2]}    # Hard L |
| inks field               |
|             ft=${LIST[$L |
| idx+1]:0:1}     # Fast-S |
| tat                      |
|             case $ft in  |
|             b)  ((Lidx+= |
| 12)) ;;     # Block devi |
| ce                       |
|             c)  ((Lidx+= |
| 12)) ;;     # Character  |
| device                   |
|             *)  ((Lidx+= |
| 11)) ;;     # Anything e |
| lse                      |
|             esac         |
|             name=Lidx    |
|             case $ft in  |
|             -)  ((Lidx+= |
| 1)) ;;      # The easy o |
| ne                       |
|             b)  ((Lidx+= |
| 1)) ;;      # Block devi |
| ce                       |
|             c)  ((Lidx+= |
| 1)) ;;      # Character  |
| device                   |
|             d)  ((Lidx+= |
| 1)) ;;      # The other  |
| easy one                 |
|             l)  ((Lidx+= |
| 3)) ;;      # At LEAST t |
| wo more fields           |
|     #  A little more ele |
| gance here would handle  |
| pipes,                   |
|     #+ sockets, deleted  |
| files - later.           |
|             *)  until Is |
| Number ${LIST[$Lidx]} || |
|  ((Lidx >= Lcnt))        |
|                 do       |
|                     ((Li |
| dx+=1))                  |
|                 done     |
|                 ;;       |
|     # Not required       |
|             esac         |
|             INDEX[${#IND |
| EX[*]}]=$inode           |
|             INDEX[${#IND |
| EX[*]}]=$name            |
|             INDEX[0]=${I |
| NDEX[0]}+1      # One mo |
| re "line" found          |
|     # echo "Line: ${INDE |
| X[0]} Type: $ft Links: $ |
| m Inode: \               |
|     # ${LIST[$inode]} Na |
| me: ${LIST[$name]}"      |
|                          |
|         else             |
|             ((Lidx+=1))  |
|         fi               |
|         done             |
|         case "$of" in    |
|             0) eval $2=\ |
| ( \"\$\{INDEX\[@\]\}\" \ |
| ) ;;                     |
|             1) echo "${I |
| NDEX[@]}" > "$2" ;;      |
|         esac             |
|         return 0         |
|         # What could go  |
| wrong?                   |
|     }                    |
|                          |
|     # # # # # Content Id |
| entify File # # # # #    |
|     #                    |
|     #   DigestFile Input |
| -Array-Name Digest-Array |
| -Name                    |
|     # or                 |
|     #   DigestFile -if I |
| nput-FileName Digest-Arr |
| ay-Name                  |
|     # # # # #            |
|                          |
|     # Here document used |
|  as a comment block.     |
|     : <<DigestFilesDoc   |
|                          |
|     The key (no pun inte |
| nded) to a Unified Conte |
| nt File System (UCFS)    |
|     is to distinguish th |
| e files in the system ba |
| sed on their content.    |
|     Distinguishing files |
|  by their name is just s |
| o 20th Century.          |
|                          |
|     The content is disti |
| nguished by computing a  |
| checksum of that content |
| .                        |
|     This version uses th |
| e md5sum program to gene |
| rate a 128 bit checksum  |
|     representative of th |
| e file's contents.       |
|     There is a chance th |
| at two files having diff |
| erent content might      |
|     generate the same ch |
| ecksum using md5sum (or  |
| any checksum).  Should   |
|     that become a proble |
| m, then the use of md5su |
| m can be replace by a    |
|     cyrptographic signat |
| ure.  But until then...  |
|                          |
|     The md5sum program i |
| s documented as outputti |
| ng three fields (and it  |
|     does), but when read |
|  it appears as two field |
| s (array elements).  Thi |
| s                        |
|     is caused by the lac |
| k of whitespace between  |
| the second and third fie |
| ld.                      |
|     So this function gro |
| pes the md5sum output an |
| d returns:               |
|         [0] 32 character |
|  checksum in hexidecimal |
|  (UCFS filename)         |
|         [1] Single chara |
| cter: ' ' text file, '*' |
|  binary file             |
|         [2] Filesystem ( |
| 20th Century Style) name |
|         Note: That name  |
| may be the character '-' |
|  indicating STDIN read.  |
|                          |
|     DigestFilesDoc       |
|                          |
|                          |
|                          |
|     DigestFile()         |
|     {                    |
|         local if=0       |
| # Default, variable name |
|         local -a T1 T2   |
|                          |
|         case "$#" in     |
|         3)  case "$1" in |
|             -if)    if=1 |
|  ; shift ;;              |
|              * )    retu |
| rn 1 ;;                  |
|             esac ;;      |
|         2)  : ;;         |
| # Poor man's "continue"  |
|         *)  return 1 ;;  |
|         esac             |
|                          |
|         case $if in      |
|         0) eval T1=\( \" |
| \$\{$1\[@\]\}\" \)       |
|            T2=( $(echo $ |
| {T1[@]} | md5sum -) )    |
|            ;;            |
|         1) T2=( $(md5sum |
|  $1) )                   |
|            ;;            |
|         esac             |
|                          |
|         case ${#T2[@]} i |
| n                        |
|         0) return 1 ;;   |
|         1) return 1 ;;   |
|         2) case ${T2[1]: |
| 0:1} in     # SanScrit-2 |
| .0.5                     |
|            \*) T2[${#T2[ |
| @]}]=${T2[1]:1}          |
|                T2[1]=\*  |
|                ;;        |
|             *) T2[${#T2[ |
| @]}]=${T2[1]}            |
|                T2[1]=" " |
|                ;;        |
|            esac          |
|            ;;            |
|         3) : ;; # Assume |
|  it worked               |
|         *) return 1 ;;   |
|         esac             |
|                          |
|         local -i len=${# |
| T2[0]}                   |
|         if [ $len -ne 32 |
|  ] ; then return 1 ; fi  |
|         eval $2=\( \"\$\ |
| {T2\[@\]\}\" \)          |
|     }                    |
|                          |
|     # # # # # Locate Fil |
| e # # # # #              |
|     #                    |
|     #   LocateFile [-l]  |
| FileName Location-Array- |
| Name                     |
|     # or                 |
|     #   LocateFile [-l]  |
| -of FileName Location-Ar |
| ray-FileName             |
|     # # # # #            |
|                          |
|     # A file location is |
|  Filesystem-id and inode |
| -number                  |
|                          |
|     # Here document used |
|  as a comment block.     |
|     : <<StatFieldsDoc    |
|         Based on stat, v |
| ersion 2.2               |
|         stat -t and stat |
|  -lt fields              |
|         [0] name         |
|         [1] Total size   |
|             File - numbe |
| r of bytes               |
|             Symbolic lin |
| k - string length of pat |
| hname                    |
|         [2] Number of (5 |
| 12 byte) blocks allocate |
| d                        |
|         [3] File type an |
| d Access rights (hex)    |
|         [4] User ID of o |
| wner                     |
|         [5] Group ID of  |
| owner                    |
|         [6] Device numbe |
| r                        |
|         [7] Inode number |
|         [8] Number of ha |
| rd links                 |
|         [9] Device type  |
| (if inode device) Major  |
|         [10]    Device t |
| ype (if inode device) Mi |
| nor                      |
|         [11]    Time of  |
| last access              |
|             May be disab |
| led in 'mount' with noat |
| ime                      |
|             atime of fil |
| es changed by exec, read |
| , pipe, utime, mknod (mm |
| ap?)                     |
|             atime of dir |
| ectories changed by addi |
| tion/deletion of files   |
|         [12]    Time of  |
| last modification        |
|             mtime of fil |
| es changed by write, tru |
| ncate, utime, mknod      |
|             mtime of dir |
| ectories changed by addt |
| ition/deletion of files  |
|         [13]    Time of  |
| last change              |
|             ctime reflec |
| ts time of changed inode |
|  information (owner, gro |
| up                       |
|             permissions, |
|  link count              |
|     -*-*- Per:           |
|         Return code: 0   |
|         Size of array: 1 |
| 4                        |
|         Contents of arra |
| y                        |
|         Element 0: /home |
| /mszick                  |
|         Element 1: 4096  |
|         Element 2: 8     |
|         Element 3: 41e8  |
|         Element 4: 500   |
|         Element 5: 500   |
|         Element 6: 303   |
|         Element 7: 32385 |
|         Element 8: 22    |
|         Element 9: 0     |
|         Element 10: 0    |
|         Element 11: 1051 |
| 221030                   |
|         Element 12: 1051 |
| 214068                   |
|         Element 13: 1051 |
| 214068                   |
|                          |
|         For a link in th |
| e form of linkname -> re |
| alname                   |
|         stat -t  linknam |
| e returns the linkname ( |
| link) information        |
|         stat -lt linknam |
| e returns the realname i |
| nformation               |
|                          |
|         stat -tf and sta |
| t -ltf fields            |
|         [0] name         |
|         [1] ID-0?        |
| # Maybe someday, but Lin |
| ux stat structure        |
|         [2] ID-0?        |
| # does not have either L |
| ABEL nor UUID            |
|                     # fi |
| elds, currently informat |
| ion must come            |
|                     # fr |
| om file-system specific  |
| utilities                |
|         These will be mu |
| nged into:               |
|         [1] UUID if poss |
| ible                     |
|         [2] Volume Label |
|  if possible             |
|         Note: 'mount -l' |
|  does return the label a |
| nd could return the UUID |
|                          |
|         [3] Maximum leng |
| th of filenames          |
|         [4] Filesystem t |
| ype                      |
|         [5] Total blocks |
|  in the filesystem       |
|         [6] Free blocks  |
|         [7] Free blocks  |
| for non-root user(s)     |
|         [8] Block size o |
| f the filesystem         |
|         [9] Total inodes |
|         [10]    Free ino |
| des                      |
|                          |
|     -*-*- Per:           |
|         Return code: 0   |
|         Size of array: 1 |
| 1                        |
|         Contents of arra |
| y                        |
|         Element 0: /home |
| /mszick                  |
|         Element 1: 0     |
|         Element 2: 0     |
|         Element 3: 255   |
|         Element 4: ef53  |
|         Element 5: 25814 |
| 45                       |
|         Element 6: 22771 |
| 80                       |
|         Element 7: 21460 |
| 50                       |
|         Element 8: 4096  |
|         Element 9: 13115 |
| 52                       |
|         Element 10: 1276 |
| 425                      |
|                          |
|     StatFieldsDoc        |
|                          |
|                          |
|     #   LocateFile [-l]  |
| FileName Location-Array- |
| Name                     |
|     #   LocateFile [-l]  |
| -of FileName Location-Ar |
| ray-FileName             |
|                          |
|     LocateFile()         |
|     {                    |
|         local -a LOC LOC |
| 1 LOC2                   |
|         local lk="" of=0 |
|                          |
|         case "$#" in     |
|         0) return 1 ;;   |
|         1) return 1 ;;   |
|         2) : ;;          |
|         *) while (( "$#" |
|  > 2 ))                  |
|            do            |
|               case "$1"  |
| in                       |
|                -l) lk=-1 |
|  ;;                      |
|               -of) of=1  |
| ;;                       |
|                 *) retur |
| n 1 ;;                   |
|               esac       |
|            shift         |
|                done ;;   |
|         esac             |
|                          |
|     # More Sanscrit-2.0. |
| 5                        |
|           # LOC1=( $(sta |
| t -t $lk $1) )           |
|           # LOC2=( $(sta |
| t -tf $lk $1) )          |
|           # Uncomment ab |
| ove two lines if system  |
| has "stat" command insta |
| lled.                    |
|         LOC=( ${LOC1[@]: |
| 0:1} ${LOC1[@]:3:11}     |
|               ${LOC2[@]: |
| 1:2} ${LOC2[@]:4:1} )    |
|                          |
|         case "$of" in    |
|             0) eval $2=\ |
| ( \"\$\{LOC\[@\]\}\" \)  |
| ;;                       |
|             1) echo "${L |
| OC[@]}" > "$2" ;;        |
|         esac             |
|         return 0         |
|     # Which yields (if y |
| ou are lucky, and have " |
| stat" installed)         |
|     # -*-*- Location Dis |
| criptor -*-*-            |
|     #   Return code: 0   |
|     #   Size of array: 1 |
| 5                        |
|     #   Contents of arra |
| y                        |
|     #   Element 0: /home |
| /mszick     20th Century |
|  name                    |
|     #   Element 1: 41e8  |
|         Type and Permiss |
| ions                     |
|     #   Element 2: 500   |
|         User             |
|     #   Element 3: 500   |
|         Group            |
|     #   Element 4: 303   |
|         Device           |
|     #   Element 5: 32385 |
|         inode            |
|     #   Element 6: 22    |
|         Link count       |
|     #   Element 7: 0     |
|         Device Major     |
|     #   Element 8: 0     |
|         Device Minor     |
|     #   Element 9: 10512 |
| 24608       Last Access  |
|     #   Element 10: 1051 |
| 214068      Last Modify  |
|     #   Element 11: 1051 |
| 214068      Last Status  |
|     #   Element 12: 0    |
|         UUID (to be)     |
|     #   Element 13: 0    |
|         Volume Label (to |
|  be)                     |
|     #   Element 14: ef53 |
|         Filesystem type  |
|     }                    |
|                          |
|                          |
|                          |
|     # And then there was |
|  some test code          |
|                          |
|     ListArray() # ListAr |
| ray Name                 |
|     {                    |
|         local -a Ta      |
|                          |
|         eval Ta=\( \"\$\ |
| {$1\[@\]\}\" \)          |
|         echo             |
|         echo "-*-*- List |
|  of Array -*-*-"         |
|         echo "Size of ar |
| ray $1: ${#Ta[*]}"       |
|         echo "Contents o |
| f array $1:"             |
|         for (( i=0 ; i<$ |
| {#Ta[*]} ; i++ ))        |
|         do               |
|             echo -e "\tE |
| lement $i: ${Ta[$i]}"    |
|         done             |
|         return 0         |
|     }                    |
|                          |
|     declare -a CUR_DIR   |
|     # For small arrays   |
|     ListDirectory "${PWD |
| }" CUR_DIR               |
|     ListArray CUR_DIR    |
|                          |
|     declare -a DIR_DIG   |
|     DigestFile CUR_DIR D |
| IR_DIG                   |
|     echo "The new \"name |
| \" (checksum) for ${CUR_ |
| DIR[9]} is ${DIR_DIG[0]} |
| "                        |
|                          |
|     declare -a DIR_ENT   |
|     # BIG_DIR # For real |
| ly big arrays - use a te |
| mporary file in ramdisk  |
|     # BIG-DIR # ListDire |
| ctory -of "${CUR_DIR[11] |
| }/*" "/tmpfs/junk2"      |
|     ListDirectory "${CUR |
| _DIR[11]}/*" DIR_ENT     |
|                          |
|     declare -a DIR_IDX   |
|     # BIG-DIR # IndexLis |
| t -if "/tmpfs/junk2" DIR |
| _IDX                     |
|     IndexList DIR_ENT DI |
| R_IDX                    |
|                          |
|     declare -a IDX_DIG   |
|     # BIG-DIR # DIR_ENT= |
| ( $(cat /tmpfs/junk2) )  |
|     # BIG-DIR # DigestFi |
| le -if /tmpfs/junk2 IDX_ |
| DIG                      |
|     DigestFile DIR_ENT I |
| DX_DIG                   |
|     # Small (should) be  |
| able to parallize IndexL |
| ist & DigestFile         |
|     # Large (should) be  |
| able to parallize IndexL |
| ist & DigestFile & the a |
| ssignment                |
|     echo "The \"name\" ( |
| checksum) for the conten |
| ts of ${PWD} is ${IDX_DI |
| G[0]}"                   |
|                          |
|     declare -a FILE_LOC  |
|     LocateFile ${PWD} FI |
| LE_LOC                   |
|     ListArray FILE_LOC   |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Stéphane Chazelas demonstrates object-oriented programming in a Bash
script.

Mariusz Gniazdowski contributed a `hash <internal.html#HASHREF>`__
library for use in scripts.

.. raw:: html

   <div class="EXAMPLE">

**Example A-20. Library of hash functions**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # Hash:              |
|     # Hash function libr |
| ary                      |
|     # Author: Mariusz Gn |
| iazdowski <mariusz.gn-at |
| -gmail.com>              |
|     # Date: 2005-04-07   |
|                          |
|     # Functions making e |
| mulating hashes in Bash  |
| a little less painful.   |
|                          |
|                          |
|     #    Limitations:    |
|     #  * Only global var |
| iables are supported.    |
|     #  * Each hash insta |
| nce generates one global |
|  variable per value.     |
|     #  * Variable names  |
| collisions are possible  |
|     #+   if you define v |
| ariable like __hash__has |
| hname_key                |
|     #  * Keys must use c |
| hars that can be part of |
|  a Bash variable name    |
|     #+   (no dashes, per |
| iods, etc.).             |
|     #  * The hash is cre |
| ated as a variable:      |
|     #    ... hashname_ke |
| yname                    |
|     #    So if somone wi |
| ll create hashes like:   |
|     #      myhash_ + myk |
| ey = myhash__mykey       |
|     #      myhash + _myk |
| ey = myhash__mykey       |
|     #    Then there will |
|  be a collision.         |
|     #    (This should no |
| t pose a major problem.) |
|                          |
|                          |
|     Hash_config_varname_ |
| prefix=__hash__          |
|                          |
|                          |
|     # Emulates:  hash[ke |
| y]=value                 |
|     #                    |
|     # Params:            |
|     # 1 - hash           |
|     # 2 - key            |
|     # 3 - value          |
|     function hash_set {  |
|         eval "${Hash_con |
| fig_varname_prefix}${1}_ |
| ${2}=\"${3}\""           |
|     }                    |
|                          |
|                          |
|     # Emulates:  value=h |
| ash[key]                 |
|     #                    |
|     # Params:            |
|     # 1 - hash           |
|     # 2 - key            |
|     # 3 - value (name of |
|  global variable to set) |
|     function hash_get_in |
| to {                     |
|         eval "$3=\"\$${H |
| ash_config_varname_prefi |
| x}${1}_${2}\""           |
|     }                    |
|                          |
|                          |
|     # Emulates:  echo ha |
| sh[key]                  |
|     #                    |
|     # Params:            |
|     # 1 - hash           |
|     # 2 - key            |
|     # 3 - echo params (l |
| ike -n, for example)     |
|     function hash_echo { |
|         eval "echo $3 \" |
| \$${Hash_config_varname_ |
| prefix}${1}_${2}\""      |
|     }                    |
|                          |
|                          |
|     # Emulates:  hash1[k |
| ey1]=hash2[key2]         |
|     #                    |
|     # Params:            |
|     # 1 - hash1          |
|     # 2 - key1           |
|     # 3 - hash2          |
|     # 4 - key2           |
|     function hash_copy { |
|     eval "${Hash_config_ |
| varname_prefix}${1}_${2} |
| \                        |
|     =\"\$${Hash_config_v |
| arname_prefix}${3}_${4}\ |
| ""                       |
|     }                    |
|                          |
|                          |
|     # Emulates:  hash[ke |
| yN-1]=hash[key2]=...hash |
| [key1]                   |
|     #                    |
|     # Copies first key t |
| o rest of keys.          |
|     #                    |
|     # Params:            |
|     # 1 - hash1          |
|     # 2 - key1           |
|     # 3 - key2           |
|     # . . .              |
|     # N - keyN           |
|     function hash_dup {  |
|       local hashName="$1 |
| " keyName="$2"           |
|       shift 2            |
|       until [ ${#} -le 0 |
|  ]; do                   |
|         eval "${Hash_con |
| fig_varname_prefix}${has |
| hName}_${1}\             |
|     =\"\$${Hash_config_v |
| arname_prefix}${hashName |
| }_${keyName}\""          |
|       shift;             |
|       done;              |
|     }                    |
|                          |
|                          |
|     # Emulates:  unset h |
| ash[key]                 |
|     #                    |
|     # Params:            |
|     # 1 - hash           |
|     # 2 - key            |
|     function hash_unset  |
| {                        |
|         eval "unset ${Ha |
| sh_config_varname_prefix |
| }${1}_${2}"              |
|     }                    |
|                          |
|                          |
|     # Emulates something |
|  similar to:  ref=&hash[ |
| key]                     |
|     #                    |
|     # The reference is n |
| ame of the variable in w |
| hich value is held.      |
|     #                    |
|     # Params:            |
|     # 1 - hash           |
|     # 2 - key            |
|     # 3 - ref - Name of  |
| global variable to set.  |
|     function hash_get_re |
| f_into {                 |
|         eval "$3=\"${Has |
| h_config_varname_prefix} |
| ${1}_${2}\""             |
|     }                    |
|                          |
|                          |
|     # Emulates something |
|  similar to:  echo &hash |
| [key]                    |
|     #                    |
|     # That reference is  |
| name of variable in whic |
| h value is held.         |
|     #                    |
|     # Params:            |
|     # 1 - hash           |
|     # 2 - key            |
|     # 3 - echo params (l |
| ike -n for example)      |
|     function hash_echo_r |
| ef {                     |
|         eval "echo $3 \" |
| ${Hash_config_varname_pr |
| efix}${1}_${2}\""        |
|     }                    |
|                          |
|                          |
|                          |
|     # Emulates something |
|  similar to:  $$hash[key |
| ](param1, param2, ...)   |
|     #                    |
|     # Params:            |
|     # 1 - hash           |
|     # 2 - key            |
|     # 3,4, ... - Functio |
| n parameters             |
|     function hash_call { |
|       local hash key     |
|       hash=$1            |
|       key=$2             |
|       shift 2            |
|       eval "eval \"\$${H |
| ash_config_varname_prefi |
| x}${hash}_${key} \\\"\\\ |
| $@\\\"\""                |
|     }                    |
|                          |
|                          |
|     # Emulates something |
|  similar to:  isset(hash |
| [key]) or hash[key]==NUL |
| L                        |
|     #                    |
|     # Params:            |
|     # 1 - hash           |
|     # 2 - key            |
|     # Returns:           |
|     # 0 - there is such  |
| key                      |
|     # 1 - there is no su |
| ch key                   |
|     function hash_is_set |
|  {                       |
|       eval "if [[ \"\${$ |
| {Hash_config_varname_pre |
| fix}${1}_${2}-a}\" = \"a |
| \" &&                    |
|       \"\${${Hash_config |
| _varname_prefix}${1}_${2 |
| }-b}\" = \"b\" ]]        |
|         then return 1; e |
| lse return 0; fi"        |
|     }                    |
|                          |
|                          |
|     # Emulates something |
|  similar to:             |
|     #   foreach($hash as |
|  $key => $value) { fun($ |
| key,$value); }           |
|     #                    |
|     # It is possible to  |
| write different variatio |
| ns of this function.     |
|     # Here we use a func |
| tion call to make it as  |
| "generic" as possible.   |
|     #                    |
|     # Params:            |
|     # 1 - hash           |
|     # 2 - function name  |
|     function hash_foreac |
| h {                      |
|       local keyname oldI |
| FS="$IFS"                |
|       IFS=' '            |
|       for i in $(eval "e |
| cho \${!${Hash_config_va |
| rname_prefix}${1}_*}");  |
| do                       |
|         keyname=$(eval " |
| echo \${i##${Hash_config |
| _varname_prefix}${1}_}") |
|         eval "$2 $keynam |
| e \"\$$i\""              |
|       done               |
|     IFS="$oldIFS"        |
|     }                    |
|                          |
|     #  NOTE: In lines 10 |
| 3 and 116, ampersand cha |
| nged.                    |
|     #  But, it doesn't m |
| atter, because these are |
|  comment lines anyhow.   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Here is an example script using the foregoing hash library.

.. raw:: html

   <div class="EXAMPLE">

**Example A-21. Colorizing text using hash functions**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # hash-example.sh: C |
| olorizing text.          |
|     # Author: Mariusz Gn |
| iazdowski <mariusz.gn-at |
| -gmail.com>              |
|                          |
|     . Hash.lib      # Lo |
| ad the library of functi |
| ons.                     |
|                          |
|     hash_set colors red  |
|          "\033[0;31m"    |
|     hash_set colors blue |
|          "\033[0;34m"    |
|     hash_set colors ligh |
| t_blue   "\033[1;34m"    |
|     hash_set colors ligh |
| t_red    "\033[1;31m"    |
|     hash_set colors cyan |
|          "\033[0;36m"    |
|     hash_set colors ligh |
| t_green  "\033[1;32m"    |
|     hash_set colors ligh |
| t_gray   "\033[0;37m"    |
|     hash_set colors gree |
| n        "\033[0;32m"    |
|     hash_set colors yell |
| ow       "\033[1;33m"    |
|     hash_set colors ligh |
| t_purple "\033[1;35m"    |
|     hash_set colors purp |
| le       "\033[0;35m"    |
|     hash_set colors rese |
| t_color  "\033[0;00m"    |
|                          |
|                          |
|     # $1 - keyname       |
|     # $2 - value         |
|     try_colors() {       |
|         echo -en "$2"    |
|         echo "This line  |
| is $1."                  |
|     }                    |
|     hash_foreach colors  |
| try_colors               |
|     hash_echo colors res |
| et_color -en             |
|                          |
|     echo -e '\nLet us ov |
| erwrite some colors with |
|  yellow.\n'              |
|     # It's hard to read  |
| yellow text on some term |
| inals.                   |
|     hash_dup colors yell |
| ow   red light_green blu |
| e green light_gray cyan  |
|     hash_foreach colors  |
| try_colors               |
|     hash_echo colors res |
| et_color -en             |
|                          |
|     echo -e '\nLet us de |
| lete them and try colors |
|  once more . . .\n'      |
|                          |
|     for i in red light_g |
| reen blue green light_gr |
| ay cyan; do              |
|         hash_unset color |
| s $i                     |
|     done                 |
|     hash_foreach colors  |
| try_colors               |
|     hash_echo colors res |
| et_color -en             |
|                          |
|     hash_set other txt " |
| Other examples . . ."    |
|     hash_echo other txt  |
|     hash_get_into other  |
| txt text                 |
|     echo $text           |
|                          |
|     hash_set other my_fu |
| n try_colors             |
|     hash_call other my_f |
| un   purple "`hash_echo  |
| colors purple`"          |
|     hash_echo colors res |
| et_color -en             |
|                          |
|     echo; echo "Back to  |
| normal?"; echo           |
|                          |
|     exit $?              |
|                          |
|     #  On some terminals |
| , the "light" colors pri |
| nt in bold,              |
|     #  and end up lookin |
| g darker than the normal |
|  ones.                   |
|     #  Why is this?      |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

 An example illustrating the mechanics of hashing, but from a different
point of view.

.. raw:: html

   <div class="EXAMPLE">

**Example A-22. More on hash functions**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # $Id: ha.sh,v 1.2 2 |
| 005/04/21 23:24:26 olive |
| r Exp $                  |
|     # Copyright 2005 Oli |
| ver Beckstein            |
|     # Released under the |
|  GNU Public License      |
|     # Author of script g |
| ranted permission for in |
| clusion in ABS Guide.    |
|     # (Thank you!)       |
|                          |
|     #------------------- |
| ------------------------ |
| ---------------------    |
|     # pseudo hash based  |
| on indirect parameter ex |
| pansion                  |
|     # API: access throug |
| h functions:             |
|     #                    |
|     # create the hash:   |
|     #                    |
|     #      newhash Lover |
| s                        |
|     #                    |
|     # add entries (note  |
| single quotes for spaces |
| )                        |
|     #                    |
|     #      addhash Lover |
| s Tristan Isolde         |
|     #      addhash Lover |
| s 'Romeo Montague' 'Juli |
| et Capulet'              |
|     #                    |
|     # access value by ke |
| y                        |
|     #                    |
|     #      gethash Lover |
| s Tristan   ---->  Isold |
| e                        |
|     #                    |
|     # show all keys      |
|     #                    |
|     #      keyshash Love |
| rs         ----> 'Trista |
| n'  'Romeo Montague'     |
|     #                    |
|     #                    |
|     # Convention: instea |
| d of perls' foo{bar} = b |
| oing' syntax,            |
|     # use                |
|     #       '_foo_bar=bo |
| ing' (two underscores, n |
| o spaces)                |
|     #                    |
|     # 1) store key   in  |
| _NAME_keys[]             |
|     # 2) store value in  |
| _NAME_values[] using the |
|  same integer index      |
|     # The integer index  |
| for the last entry is _N |
| AME_ptr                  |
|     #                    |
|     # NOTE: No error or  |
| sanity checks, just bare |
|  bones.                  |
|                          |
|                          |
|     function _inihash () |
|  {                       |
|         # private functi |
| on                       |
|         # call at the be |
| ginning of each procedur |
| e                        |
|         # defines: _keys |
|  _values _ptr            |
|         #                |
|         # Usage: _inihas |
| h NAME                   |
|         local name=$1    |
|         _keys=_${name}_k |
| eys                      |
|         _values=_${name} |
| _values                  |
|         _ptr=_${name}_pt |
| r                        |
|     }                    |
|                          |
|     function newhash ()  |
| {                        |
|         # Usage: newhash |
|  NAME                    |
|         #        NAME sh |
| ould not contain spaces  |
| or dots.                 |
|         #        Actuall |
| y: it must be a legal na |
| me for a Bash variable.  |
|         # We rely on Bas |
| h automatically recognis |
| ing arrays.              |
|         local name=$1    |
|         local _keys _val |
| ues _ptr                 |
|         _inihash ${name} |
|         eval ${_ptr}=0   |
|     }                    |
|                          |
|                          |
|     function addhash ()  |
| {                        |
|         # Usage: addhash |
|  NAME KEY 'VALUE with sp |
| aces'                    |
|         #        argumen |
| ts with spaces need to b |
| e quoted with single quo |
| tes ''                   |
|         local name=$1 k= |
| "$2" v="$3"              |
|         local _keys _val |
| ues _ptr                 |
|         _inihash ${name} |
|                          |
|         #echo "DEBUG(add |
| hash): ${_ptr}=${!_ptr}" |
|                          |
|         eval let ${_ptr} |
| =${_ptr}+1               |
|         eval "$_keys[${! |
| _ptr}]=\"${k}\""         |
|         eval "$_values[$ |
| {!_ptr}]=\"${v}\""       |
|     }                    |
|                          |
|     function gethash ()  |
| {                        |
|         #  Usage: gethas |
| h NAME KEY               |
|         #         Return |
| s boing                  |
|         #         ERR=0  |
| if entry found, 1 otherw |
| ise                      |
|         #  That's not a  |
| proper hash --           |
|         #+ we simply lin |
| early search through the |
|  keys.                   |
|         local name=$1 ke |
| y="$2"                   |
|         local _keys _val |
| ues _ptr                 |
|         local k v i foun |
| d h                      |
|         _inihash ${name} |
|                          |
|         # _ptr holds the |
|  highest index in the ha |
| sh                       |
|         found=0          |
|                          |
|         for i in $(seq 1 |
|  ${!_ptr}); do           |
|         h="\${${_keys}[$ |
| {i}]}"  #  Safer to do i |
| t in two steps,          |
|         eval k=${h}      |
|         #+ especially wh |
| en quoting for spaces.   |
|         if [ "${k}" = "$ |
| {key}" ]; then found=1;  |
| break; fi                |
|         done;            |
|                          |
|         [ ${found} = 0 ] |
|  && return 1;            |
|         # else: i is the |
|  index that matches the  |
| key                      |
|         h="\${${_values} |
| [${i}]}"                 |
|         eval echo "${h}" |
|         return 0;        |
|     }                    |
|                          |
|     function keyshash () |
|  {                       |
|         # Usage: keyshas |
| h NAME                   |
|         # Returns list o |
| f all keys defined for h |
| ash name.                |
|         local name=$1 ke |
| y="$2"                   |
|         local _keys _val |
| ues _ptr                 |
|         local k i h      |
|         _inihash ${name} |
|                          |
|         # _ptr holds the |
|  highest index in the ha |
| sh                       |
|         for i in $(seq 1 |
|  ${!_ptr}); do           |
|         h="\${${_keys}[$ |
| {i}]}"   #  Safer to do  |
| it in two steps,         |
|         eval k=${h}      |
|          #+ especially w |
| hen quoting for spaces.  |
|         echo -n "'${k}'  |
| "                        |
|         done;            |
|     }                    |
|                          |
|                          |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| -----                    |
|                          |
|     # Now, let's test it |
| .                        |
|     # (Per comments at t |
| he beginning of the scri |
| pt.)                     |
|     newhash Lovers       |
|     addhash Lovers Trist |
| an Isolde                |
|     addhash Lovers 'Rome |
| o Montague' 'Juliet Capu |
| let'                     |
|                          |
|     # Output results.    |
|     echo                 |
|     gethash Lovers Trist |
| an      # Isolde         |
|     echo                 |
|     keyshash Lovers      |
|         # 'Tristan' 'Rom |
| eo Montague'             |
|     echo; echo           |
|                          |
|                          |
|     exit 0               |
|                          |
|     # Exercise:          |
|     # --------           |
|                          |
|     # Add error checks t |
| o the functions.         |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Now for a script that installs and mounts those cute USB keychain
solid-state "hard drives."

.. raw:: html

   <div class="EXAMPLE">

**Example A-23. Mounting USB keychain storage devices**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ==> usb.sh         |
|     # ==> Script for mou |
| nting and installing pen |
| /keychain USB storage de |
| vices.                   |
|     # ==> Runs as root a |
| t system startup (see be |
| low).                    |
|     # ==>                |
|     # ==> Newer Linux di |
| stros (2004 or later) au |
| todetect                 |
|     # ==> and install US |
| B pen drives, and theref |
| ore don't need this scri |
| pt.                      |
|     # ==> But, it's stil |
| l instructive.           |
|                          |
|     #  This code is free |
|  software covered by GNU |
|  GPL license version 2 o |
| r above.                 |
|     #  Please refer to h |
| ttp://www.gnu.org/ for t |
| he full license text.    |
|     #                    |
|     #  Some code lifted  |
| from usb-mount by Michae |
| l Hamilton's usb-mount ( |
| LGPL)                    |
|     #+ see http://users. |
| actrix.co.nz/michael/usb |
| mount.html               |
|     #                    |
|     #  INSTALL           |
|     #  -------           |
|     #  Put this in /etc/ |
| hotplug/usb/diskonkey.   |
|     #  Then look in /etc |
| /hotplug/usb.distmap, an |
| d copy all usb-storage e |
| ntries                   |
|     #+ into /etc/hotplug |
| /usb.usermap, substituti |
| ng "usb-storage" for "di |
| skonkey".                |
|     #  Otherwise this co |
| de is only run during th |
| e kernel module invocati |
| on/removal               |
|     #+ (at least in my t |
| ests), which defeats the |
|  purpose.                |
|     #                    |
|     #  TODO              |
|     #  ----              |
|     #  Handle more than  |
| one diskonkey device at  |
| one time (e.g. /dev/disk |
| onkey1                   |
|     #+ and /mnt/diskonke |
| y1), etc. The biggest pr |
| oblem here is the handli |
| ng in                    |
|     #+ devlabel, which I |
|  haven't yet tried.      |
|     #                    |
|     #  AUTHOR and SUPPOR |
| T                        |
|     #  ----------------- |
| -                        |
|     #  Konstantin Riabit |
| sev, <icon linux duke ed |
| u>.                      |
|     #  Send any problem  |
| reports to my email addr |
| ess at the moment.       |
|     #                    |
|     # ==> Comments added |
|  by ABS Guide author.    |
|                          |
|                          |
|                          |
|     SYMLINKDEV=/dev/disk |
| onkey                    |
|     MOUNTPOINT=/mnt/disk |
| onkey                    |
|     DEVLABEL=/sbin/devla |
| bel                      |
|     DEVLABELCONFIG=/etc/ |
| sysconfig/devlabel       |
|     IAM=$0               |
|                          |
|     ##                   |
|     # Functions lifted n |
| ear-verbatim from usb-mo |
| unt code.                |
|     #                    |
|     function allAttached |
| ScsiUsb {                |
|       find /proc/scsi/ - |
| path '/proc/scsi/usb-sto |
| rage*' -type f |         |
|       xargs grep -l 'Att |
| ached: Yes'              |
|     }                    |
|     function scsiDevFrom |
| ScsiUsb {                |
|       echo $1 | awk -F"[ |
| -/]" '{ n=$(NF-1);       |
|       print "/dev/sd" su |
| bstr("abcdefghijklmnopqr |
| stuvwxyz", n+1, 1) }'    |
|     }                    |
|                          |
|     if [ "${ACTION}" = " |
| add" ] && [ -f "${DEVICE |
| }" ]; then               |
|         ##               |
|         # lifted from us |
| bcam code.               |
|         #                |
|         if [ -f /var/run |
| /console.lock ]; then    |
|             CONSOLEOWNER |
| =`cat /var/run/console.l |
| ock`                     |
|         elif [ -f /var/l |
| ock/console.lock ]; then |
|             CONSOLEOWNER |
| =`cat /var/lock/console. |
| lock`                    |
|         else             |
|             CONSOLEOWNER |
| =                        |
|         fi               |
|         for procEntry in |
|  $(allAttachedScsiUsb);  |
| do                       |
|             scsiDev=$(sc |
| siDevFromScsiUsb $procEn |
| try)                     |
|             #  Some bug  |
| with usb-storage?        |
|             #  Partition |
| s are not in /proc/parti |
| tions until they are acc |
| essed                    |
|             #+ somehow.  |
|             /sbin/fdisk  |
| -l $scsiDev >/dev/null   |
|             ##           |
|             #  Most devi |
| ces have partitioning in |
| fo, so the data would be |
|  on                      |
|             #+ /dev/sd?1 |
| . However, some stupider |
|  ones don't have any par |
| titioning                |
|             #+ and use t |
| he entire device for dat |
| a storage. This tries to |
|             #+ guess sem |
| i-intelligently if we ha |
| ve a /dev/sd?1 and if no |
| t, then                  |
|             #+ it uses t |
| he entire device and hop |
| es for the better.       |
|             #            |
|             if grep -q ` |
| basename $scsiDev`1 /pro |
| c/partitions; then       |
|                 part="$s |
| csiDev""1"               |
|             else         |
|                 part=$sc |
| siDev                    |
|             fi           |
|             ##           |
|             #  Change ow |
| nership of the partition |
|  to the console user so  |
| they can                 |
|             #+ mount it. |
|             #            |
|             if [ ! -z "$ |
| CONSOLEOWNER" ]; then    |
|                 chown $C |
| ONSOLEOWNER:disk $part   |
|             fi           |
|             ##           |
|             # This check |
| s if we already have thi |
| s UUID defined with devl |
| abel.                    |
|             # If not, it |
|  then adds the device to |
|  the list.               |
|             #            |
|             prodid=`$DEV |
| LABEL printid -d $part`  |
|             if ! grep -q |
|  $prodid $DEVLABELCONFIG |
| ; then                   |
|                 # cross  |
| our fingers and hope it  |
| works                    |
|                 $DEVLABE |
| L add -d $part -s $SYMLI |
| NKDEV 2>/dev/null        |
|             fi           |
|             ##           |
|             # Check if t |
| he mount point exists an |
| d create if it doesn't.  |
|             #            |
|             if [ ! -e $M |
| OUNTPOINT ]; then        |
|                 mkdir -p |
|  $MOUNTPOINT             |
|             fi           |
|             ##           |
|             # Take care  |
| of /etc/fstab so mountin |
| g is easy.               |
|             #            |
|             if ! grep -q |
|  "^$SYMLINKDEV" /etc/fst |
| ab; then                 |
|                 # Add an |
|  fstab entry             |
|                 echo -e  |
| \                        |
|                     "$SY |
| MLINKDEV\t\t$MOUNTPOINT\ |
| t\tauto\tnoauto,owner,ku |
| dzu 0 0" \               |
|                     >> / |
| etc/fstab                |
|             fi           |
|         done             |
|         if [ ! -z "$REMO |
| VER" ]; then             |
|             ##           |
|             # Make sure  |
| this script is triggered |
|  on device removal.      |
|             #            |
|             mkdir -p `di |
| rname $REMOVER`          |
|             ln -s $IAM $ |
| REMOVER                  |
|         fi               |
|     elif [ "${ACTION}" = |
|  "remove" ]; then        |
|         ##               |
|         # If the device  |
| is mounted, unmount it c |
| leanly.                  |
|         #                |
|         if grep -q "$MOU |
| NTPOINT" /etc/mtab; then |
|             # unmount cl |
| eanly                    |
|             umount -l $M |
| OUNTPOINT                |
|         fi               |
|         ##               |
|         # Remove it from |
|  /etc/fstab if it's ther |
| e.                       |
|         #                |
|         if grep -q "^$SY |
| MLINKDEV" /etc/fstab; th |
| en                       |
|             grep -v "^$S |
| YMLINKDEV" /etc/fstab >  |
| /etc/.fstab.new          |
|             mv -f /etc/. |
| fstab.new /etc/fstab     |
|         fi               |
|     fi                   |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Converting a text file to HTML format.

.. raw:: html

   <div class="EXAMPLE">

**Example A-24. Converting to HTML**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # tohtml.sh [v. 0.2. |
| 01, reldate: 04/13/12, a |
|  teeny bit less buggy]   |
|                          |
|     # Convert a text fil |
| e to HTML format.        |
|     # Author: Mendel Coo |
| per                      |
|     # License: GPL3      |
|     # Usage: sh tohtml.s |
| h < textfile > htmlfile  |
|     # Script can easily  |
| be modified to accept so |
| urce and target filename |
| s.                       |
|                          |
|     #    Assumptions:    |
|     # 1) Paragraphs in ( |
| target) text file are se |
| parated by a blank line. |
|     # 2) Jpeg images (*. |
| jpg) are located in "ima |
| ges" subdirectory.       |
|     #    In the target f |
| ile, the image names are |
|  enclosed in square brac |
| kets,                    |
|     #    for example, [i |
| mage01.jpg].             |
|     # 3) Emphasized (ita |
| lic) phrases begin with  |
| a space+underscore       |
|     #+   or the first ch |
| aracter on the line is a |
| n underscore,            |
|     #+   and end with an |
|  underscore+space or und |
| erscore+end-of-line.     |
|                          |
|                          |
|     # Settings           |
|     FNTSIZE=2        # S |
| mall-medium font size    |
|     IMGDIR="images"  # I |
| mage directory           |
|     # Headers            |
|     HDR01='<!DOCTYPE HTM |
| L PUBLIC "-//W3C//DTD HT |
| ML 4.01 Transitional//EN |
| ">'                      |
|     HDR02='<!-- Converte |
| d to HTML by ***tohtml.s |
| h*** script -->'         |
|     HDR03='<!-- script a |
| uthor: M. Leo Cooper <th |
| egrendel.abs@gmail.com>  |
| -->'                     |
|     HDR10='<html>'       |
|     HDR11='<head>'       |
|     HDR11a='</head>'     |
|     HDR12a='<title>'     |
|     HDR12b='</title>'    |
|     HDR121='<META NAME=" |
| GENERATOR" CONTENT="toht |
| ml.sh script">'          |
|     HDR13='<body bgcolor |
| ="#dddddd">'   # Change  |
| background color to suit |
| .                        |
|     HDR14a='<font size=' |
|     HDR14b='>'           |
|     # Footers            |
|     FTR10='</body>'      |
|     FTR11='</html>'      |
|     # Tags               |
|     BOLD="<b>"           |
|     CENTER="<center>"    |
|     END_CENTER="</center |
| >"                       |
|     LF="<br>"            |
|                          |
|                          |
|     write_headers ()     |
|       {                  |
|       echo "$HDR01"      |
|       echo               |
|       echo "$HDR02"      |
|       echo "$HDR03"      |
|       echo               |
|       echo               |
|       echo "$HDR10"      |
|       echo "$HDR11"      |
|       echo "$HDR121"     |
|       echo "$HDR11a"     |
|       echo "$HDR13"      |
|       echo               |
|       echo -n "$HDR14a"  |
|       echo -n "$FNTSIZE" |
|       echo "$HDR14b"     |
|       echo               |
|       echo "$BOLD"       |
|   # Everything in bold ( |
| more easily readable).   |
|       }                  |
|                          |
|                          |
|     process_text ()      |
|       {                  |
|       while read line    |
|   # Read one line at a t |
| ime.                     |
|       do                 |
|         {                |
|         if [ ! "$line" ] |
|   # Blank line?          |
|         then             |
|   # Then new paragraph m |
| ust follow.              |
|           echo           |
|           echo "$LF"     |
|   # Insert two <br> tags |
| .                        |
|           echo "$LF"     |
|           echo           |
|           continue       |
|   # Skip the underscore  |
| test.                    |
|         else             |
|   # Otherwise . . .      |
|                          |
|           if [[ "$line"  |
| =~ \[*jpg\] ]]    # Is a |
|  graphic?                |
|           then           |
|                   # Stri |
| p away brackets.         |
|             temp=$( echo |
|  "$line" | sed -e 's/\[/ |
| /' -e 's/\]//' )         |
|             line=""$CENT |
| ER" <img src="\"$IMGDIR" |
| /$temp\"> "$END_CENTER"  |
| "                        |
|                          |
|                   # Add  |
| image tag.               |
|                          |
|                   # And, |
|  center it.              |
|           fi             |
|                          |
|         fi               |
|                          |
|                          |
|         echo "$line" | g |
| rep -q _                 |
|         if [ "$?" -eq 0  |
| ]    # If line contains  |
| underscore ...           |
|         then             |
|           # ============ |
| ======================== |
| ===============          |
|           # Convert unde |
| rscored phrase to italic |
| s.                       |
|           temp=$( echo " |
| $line" |                 |
|                   sed -e |
|  's/ _/ <i>/' -e 's/_/<\ |
| /i> /' |                 |
|                   sed -e |
|  's/^_/<i>/'  -e 's/_/<\ |
| /i>/' )                  |
|           #  Process onl |
| y underscores prefixed b |
| y space,                 |
|           #+ or at begin |
| ning or end of line.     |
|           #  Do not conv |
| ert underscores embedded |
|  within a word!          |
|           line="$temp"   |
|           # Slows script |
|  execution. Can be optim |
| ized?                    |
|           # ============ |
| ======================== |
| ===============          |
|         fi               |
|                          |
|                          |
|                          |
|     #   echo             |
|         echo "$line"     |
|     #   echo             |
|     #   Don't want extra |
|  blank lines in generate |
| d text!                  |
|         } # End while    |
|       done               |
|       }   # End process_ |
| text ()                  |
|                          |
|                          |
|     write_footers ()  #  |
| Termination tags.        |
|       {                  |
|       echo "$FTR10"      |
|       echo "$FTR11"      |
|       }                  |
|                          |
|                          |
|     # main () {          |
|     # =========          |
|     write_headers        |
|     process_text         |
|     write_footers        |
|     # =========          |
|     #         }          |
|                          |
|     exit $?              |
|                          |
|     #  Exercises:        |
|     #  ---------         |
|     #  1) Fixup: Check f |
| or closing underscore be |
| fore a comma or period.  |
|     #  2) Add a test for |
|  the presence of a closi |
| ng underscore            |
|     #+    in phrases to  |
| be italicized.           |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Here is something to warm the hearts of webmasters and mistresses: a
script that saves weblogs.

.. raw:: html

   <div class="EXAMPLE">

**Example A-25. Preserving weblogs**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # archiveweblogs.sh  |
| v1.0                     |
|                          |
|     # Troy Engel <tengel |
| @fluid.com>              |
|     # Slightly modified  |
| by document author.      |
|     # Used with permissi |
| on.                      |
|     #                    |
|     #  This script will  |
| preserve the normally ro |
| tated and                |
|     #+ thrown away weblo |
| gs from a default RedHat |
| /Apache installation.    |
|     #  It will save the  |
| files with a date/time s |
| tamp in the filename,    |
|     #+ bzipped, to a giv |
| en directory.            |
|     #                    |
|     #  Run this from cro |
| ntab nightly at an off h |
| our,                     |
|     #+ as bzip2 can suck |
|  up some serious CPU on  |
| huge logs:               |
|     #  0 2 * * * /opt/sb |
| in/archiveweblogs.sh     |
|                          |
|                          |
|     PROBLEM=66           |
|                          |
|     # Set this to your b |
| ackup dir.               |
|     BKP_DIR=/opt/backups |
| /weblogs                 |
|                          |
|     # Default Apache/Red |
| Hat stuff                |
|     LOG_DAYS="4 3 2 1"   |
|     LOG_DIR=/var/log/htt |
| pd                       |
|     LOG_FILES="access_lo |
| g error_log"             |
|                          |
|     # Default RedHat pro |
| gram locations           |
|     LS=/bin/ls           |
|     MV=/bin/mv           |
|     ID=/usr/bin/id       |
|     CUT=/bin/cut         |
|     COL=/usr/bin/column  |
|     BZ2=/usr/bin/bzip2   |
|                          |
|     # Are we root?       |
|     USER=`$ID -u`        |
|     if [ "X$USER" != "X0 |
| " ]; then                |
|       echo "PANIC: Only  |
| root can run this script |
| !"                       |
|       exit $PROBLEM      |
|     fi                   |
|                          |
|     # Backup dir exists/ |
| writable?                |
|     if [ ! -x $BKP_DIR ] |
| ; then                   |
|       echo "PANIC: $BKP_ |
| DIR doesn't exist or isn |
| 't writable!"            |
|       exit $PROBLEM      |
|     fi                   |
|                          |
|     # Move, rename and b |
| zip2 the logs            |
|     for logday in $LOG_D |
| AYS; do                  |
|       for logfile in $LO |
| G_FILES; do              |
|         MYFILE="$LOG_DIR |
| /$logfile.$logday"       |
|         if [ -w $MYFILE  |
| ]; then                  |
|           DTS=`$LS -lgo  |
| --time-style=+%Y%m%d $MY |
| FILE | $COL -t | $CUT -d |
|  ' ' -f7`                |
|           $MV $MYFILE $B |
| KP_DIR/$logfile.$DTS     |
|           $BZ2 $BKP_DIR/ |
| $logfile.$DTS            |
|         else             |
|           # Only spew an |
|  error if the file exits |
|  (ergo non-writable).    |
|           if [ -f $MYFIL |
| E ]; then                |
|             echo "ERROR: |
|  $MYFILE not writable. S |
| kipping."                |
|           fi             |
|         fi               |
|       done               |
|     done                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

 How to keep the shell from expanding and reinterpreting text strings.

.. raw:: html

   <div class="EXAMPLE">

**Example A-26. Protecting literal strings**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # protect_literal.sh |
|                          |
|     # set -vx            |
|                          |
|     :<<-'_Protect_Litera |
| l_String_Doc'            |
|                          |
|         Copyright (c) Mi |
| chael S. Zick, 2003; All |
|  Rights Reserved         |
|         License: Unrestr |
| icted reuse in any form, |
|  for any purpose.        |
|         Warranty: None   |
|         Revision: $ID$   |
|                          |
|         Documentation re |
| directed to the Bash no- |
| operation.               |
|         Bash will '/dev/ |
| null' this block when th |
| e script is first read.  |
|         (Uncomment the a |
| bove set command to see  |
| this action.)            |
|                          |
|         Remove the first |
|  (Sha-Bang) line when so |
| urcing this as a library |
|         procedure.  Also |
|  comment out the example |
|  use code in the two     |
|         places where sho |
| wn.                      |
|                          |
|                          |
|         Usage:           |
|             _protect_lit |
| eral_str 'Whatever strin |
| g meets your ${fancy}'   |
|             Just echos t |
| he argument to standard  |
| out, hard quotes         |
|             restored.    |
|                          |
|             $(_protect_l |
| iteral_str 'Whatever str |
| ing meets your ${fancy}' |
| )                        |
|             as the right |
| -hand-side of an assignm |
| ent statement.           |
|                          |
|         Does:            |
|             As the right |
| -hand-side of an assignm |
| ent, preserves the       |
|             hard quotes  |
| protecting the contents  |
| of the literal during    |
|             assignment.  |
|                          |
|         Notes:           |
|             The strange  |
| names (_*) are used to a |
| void trampling on        |
|             the user's c |
| hosen names when this is |
|  sourced as a            |
|             library.     |
|                          |
|     _Protect_Literal_Str |
| ing_Doc                  |
|                          |
|     # The 'for illustrat |
| ion' function form       |
|                          |
|     _protect_literal_str |
| () {                     |
|                          |
|     # Pick an un-used, n |
| on-printing character as |
|  local IFS.              |
|     # Not required, but  |
| shows that we are ignori |
| ng it.                   |
|         local IFS=$'\x1B |
| '               # \ESC c |
| haracter                 |
|                          |
|     # Enclose the All-El |
| ements-Of in hard quotes |
|  during assignment.      |
|         local tmp=$'\x27 |
| '$@$'\x27'               |
|     #    local tmp=$'\'' |
| $@$'\''         # Even u |
| glier.                   |
|                          |
|         local len=${#tmp |
| }               # Info o |
| nly.                     |
|         echo $tmp is $le |
| n long.         # Output |
|  AND information.        |
|     }                    |
|                          |
|     # This is the short- |
| named version.           |
|     _pls() {             |
|         local IFS=$'x1B' |
|                 # \ESC c |
| haracter (not required)  |
|         echo $'\x27'$@$' |
| \x27'           # Hard q |
| uoted parameter glob     |
|     }                    |
|                          |
|     # :<<-'_Protect_Lite |
| ral_String_Test'         |
|     # # # Remove the abo |
| ve "# " to disable this  |
| code. # # #              |
|                          |
|     # See how that looks |
|  when printed.           |
|     echo                 |
|     echo "- - Test One - |
|  -"                      |
|     _protect_literal_str |
|  'Hello $user'           |
|     _protect_literal_str |
|  'Hello "${username}"'   |
|     echo                 |
|                          |
|     # Which yields:      |
|     # - - Test One - -   |
|     # 'Hello $user' is 1 |
| 3 long.                  |
|     # 'Hello "${username |
| }"' is 21 long.          |
|                          |
|     #  Looks as expected |
| , but why all of the tro |
| uble?                    |
|     #  The difference is |
|  hidden inside the Bash  |
| internal order           |
|     #+ of operations.    |
|     #  Which shows when  |
| you use it on the RHS of |
|  an assignment.          |
|                          |
|     # Declare an array f |
| or test values.          |
|     declare -a arrayZ    |
|                          |
|     # Assign elements wi |
| th various types of quot |
| es and escapes.          |
|     arrayZ=( zero "$(_pl |
| s 'Hello ${Me}')" 'Hello |
|  ${You}' "\'Pass: ${pw}\ |
| '" )                     |
|                          |
|     # Now list that arra |
| y and see what is there. |
|     echo "- - Test Two - |
|  -"                      |
|     for (( i=0 ; i<${#ar |
| rayZ[*]} ; i++ ))        |
|     do                   |
|         echo  Element $i |
| : ${arrayZ[$i]} is: ${#a |
| rrayZ[$i]} long.         |
|     done                 |
|     echo                 |
|                          |
|     # Which yields:      |
|     # - - Test Two - -   |
|     # Element 0: zero is |
| : 4 long.           # Ou |
| r marker element         |
|     # Element 1: 'Hello  |
| ${Me}' is: 13 long. # Ou |
| r "$(_pls '...' )"       |
|     # Element 2: Hello $ |
| {You} is: 12 long.  # Qu |
| otes are missing         |
|     # Element 3: \'Pass: |
|  \' is: 10 long.    # ${ |
| pw} expanded to nothing  |
|                          |
|     # Now make an assign |
| ment with that result.   |
|     declare -a array2=(  |
| ${arrayZ[@]} )           |
|                          |
|     # And print what hap |
| pened.                   |
|     echo "- - Test Three |
|  - -"                    |
|     for (( i=0 ; i<${#ar |
| ray2[*]} ; i++ ))        |
|     do                   |
|         echo  Element $i |
| : ${array2[$i]} is: ${#a |
| rray2[$i]} long.         |
|     done                 |
|     echo                 |
|                          |
|     # Which yields:      |
|     # - - Test Three - - |
|     # Element 0: zero is |
| : 4 long.           # Ou |
| r marker element.        |
|     # Element 1: Hello $ |
| {Me} is: 11 long.   # In |
| tended result.           |
|     # Element 2: Hello i |
| s: 5 long.          # ${ |
| You} expanded to nothing |
| .                        |
|     # Element 3: 'Pass:  |
| is: 6 long.         # Sp |
| lit on the whitespace.   |
|     # Element 4: ' is: 1 |
|  long.              # Th |
| e end quote is here now. |
|                          |
|     #  Our Element 1 has |
|  had its leading and tra |
| iling hard quotes stripp |
| ed.                      |
|     #  Although not show |
| n, leading and trailing  |
| whitespace is also strip |
| ped.                     |
|     #  Now that the stri |
| ng contents are set, Bas |
| h will always, internall |
| y,                       |
|     #+ hard quote the co |
| ntents as required durin |
| g its operations.        |
|                          |
|     #  Why?              |
|     #  Considering our " |
| $(_pls 'Hello ${Me}')" c |
| onstruction:             |
|     #  " ... " -> Expans |
| ion required, strip the  |
| quotes.                  |
|     #  $( ... ) -> Repla |
| ce with the result of... |
| , strip this.            |
|     #  _pls ' ... ' -> c |
| alled with literal argum |
| ents, strip the quotes.  |
|     #  The result return |
| ed includes hard quotes; |
|  BUT the above processin |
| g                        |
|     #+ has already been  |
| done, so they become par |
| t of the value assigned. |
|     #                    |
|     #  Similarly, during |
|  further usage of the st |
| ring variable, the ${Me} |
|     #+ is part of the co |
| ntents (result) and surv |
| ives any operations      |
|     #  (Until explicitly |
|  told to evaluate the st |
| ring).                   |
|                          |
|     #  Hint: See what ha |
| ppens when the hard quot |
| es ($'\x27') are replace |
| d                        |
|     #+ with soft quotes  |
| ($'\x22') in the above p |
| rocedures.               |
|     #  Interesting also  |
| is to remove the additio |
| n of any quoting.        |
|                          |
|     # _Protect_Literal_S |
| tring_Test               |
|     # # # Remove the abo |
| ve "# " to disable this  |
| code. # # #              |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

 But, what if you *want* the shell to expand and reinterpret strings?

.. raw:: html

   <div class="EXAMPLE">

**Example A-27. Unprotecting literal strings**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # unprotect_literal. |
| sh                       |
|                          |
|     # set -vx            |
|                          |
|     :<<-'_UnProtect_Lite |
| ral_String_Doc'          |
|                          |
|         Copyright (c) Mi |
| chael S. Zick, 2003; All |
|  Rights Reserved         |
|         License: Unrestr |
| icted reuse in any form, |
|  for any purpose.        |
|         Warranty: None   |
|         Revision: $ID$   |
|                          |
|         Documentation re |
| directed to the Bash no- |
| operation. Bash will     |
|         '/dev/null' this |
|  block when the script i |
| s first read.            |
|         (Uncomment the a |
| bove set command to see  |
| this action.)            |
|                          |
|         Remove the first |
|  (Sha-Bang) line when so |
| urcing this as a library |
|         procedure.  Also |
|  comment out the example |
|  use code in the two     |
|         places where sho |
| wn.                      |
|                          |
|                          |
|         Usage:           |
|             Complement o |
| f the "$(_pls 'Literal S |
| tring')" function.       |
|             (See the pro |
| tect_literal.sh example. |
| )                        |
|                          |
|             StringVar=$( |
| _upls ProtectedSringVari |
| able)                    |
|                          |
|         Does:            |
|             When used on |
|  the right-hand-side of  |
| an assignment statement; |
|             makes the su |
| bstitions embedded in th |
| e protected string.      |
|                          |
|         Notes:           |
|             The strange  |
| names (_*) are used to a |
| void trampling on        |
|             the user's c |
| hosen names when this is |
|  sourced as a            |
|             library.     |
|                          |
|                          |
|     _UnProtect_Literal_S |
| tring_Doc                |
|                          |
|     _upls() {            |
|         local IFS=$'x1B' |
|                 # \ESC c |
| haracter (not required)  |
|         eval echo $@     |
|                 # Substi |
| tution on the glob.      |
|     }                    |
|                          |
|     # :<<-'_UnProtect_Li |
| teral_String_Test'       |
|     # # # Remove the abo |
| ve "# " to disable this  |
| code. # # #              |
|                          |
|                          |
|     _pls() {             |
|         local IFS=$'x1B' |
|                 # \ESC c |
| haracter (not required)  |
|         echo $'\x27'$@$' |
| \x27'           # Hard q |
| uoted parameter glob     |
|     }                    |
|                          |
|     # Declare an array f |
| or test values.          |
|     declare -a arrayZ    |
|                          |
|     # Assign elements wi |
| th various types of quot |
| es and escapes.          |
|     arrayZ=( zero "$(_pl |
| s 'Hello ${Me}')" 'Hello |
|  ${You}' "\'Pass: ${pw}\ |
| '" )                     |
|                          |
|     # Now make an assign |
| ment with that result.   |
|     declare -a array2=(  |
| ${arrayZ[@]} )           |
|                          |
|     # Which yielded:     |
|     # - - Test Three - - |
|     # Element 0: zero is |
| : 4 long            # Ou |
| r marker element.        |
|     # Element 1: Hello $ |
| {Me} is: 11 long    # In |
| tended result.           |
|     # Element 2: Hello i |
| s: 5 long           # ${ |
| You} expanded to nothing |
| .                        |
|     # Element 3: 'Pass:  |
| is: 6 long          # Sp |
| lit on the whitespace.   |
|     # Element 4: ' is: 1 |
|  long               # Th |
| e end quote is here now. |
|                          |
|     # set -vx            |
|                          |
|     #  Initialize 'Me' t |
| o something for the embe |
| dded ${Me} substitution. |
|     #  This needs to be  |
| done ONLY just prior to  |
| evaluating the           |
|     #+ protected string. |
|     #  (This is why it w |
| as protected to begin wi |
| th.)                     |
|                          |
|     Me="to the array guy |
| ."                       |
|                          |
|     # Set a string varia |
| ble destination to the r |
| esult.                   |
|     newVar=$(_upls ${arr |
| ay2[1]})                 |
|                          |
|     # Show what the cont |
| ents are.                |
|     echo $newVar         |
|                          |
|     # Do we really need  |
| a function to do this?   |
|     newerVar=$(eval echo |
|  ${array2[1]})           |
|     echo $newerVar       |
|                          |
|     #  I guess not, but  |
| the _upls function gives |
|  us a place to hang      |
|     #+ the documentation |
|  on.                     |
|     #  This helps when w |
| e forget what a # constr |
| uction like:             |
|     #+ $(eval echo ... ) |
|  means.                  |
|                          |
|     # What if Me isn't s |
| et when the protected st |
| ring is evaluated?       |
|     unset Me             |
|     newestVar=$(_upls ${ |
| array2[1]})              |
|     echo $newestVar      |
|                          |
|     # Just gone, no hint |
| s, no runs, no errors.   |
|                          |
|     #  Why in the world? |
|     #  Setting the conte |
| nts of a string variable |
|  containing character    |
|     #+ sequences that ha |
| ve a meaning in Bash is  |
| a general problem in     |
|     #+ script programmin |
| g.                       |
|     #                    |
|     #  This problem is n |
| ow solved in eight lines |
|  of code                 |
|     #+ (and four pages o |
| f description).          |
|                          |
|     #  Where is all this |
|  going?                  |
|     #  Dynamic content W |
| eb pages as an array of  |
| Bash strings.            |
|     #  Content set per r |
| equest by a Bash 'eval'  |
| command                  |
|     #+ on the stored pag |
| e template.              |
|     #  Not intended to r |
| eplace PHP, just an inte |
| resting thing to do.     |
|     ###                  |
|     #  Don't have a webs |
| erver application?       |
|     #  No problem, check |
|  the example directory o |
| f the Bash source;       |
|     #+ there is a Bash s |
| cript for that also.     |
|                          |
|     # _UnProtect_Literal |
| _String_Test             |
|     # # # Remove the abo |
| ve "# " to disable this  |
| code. # # #              |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

This interesting script helps hunt down spammers.

.. raw:: html

   <div class="EXAMPLE">

**Example A-28. Spammer Identification**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # $Id: is_spammer.ba |
| sh,v 1.12.2.11 2004/10/0 |
| 1 21:42:33 mszick Exp $  |
|     # Above line is RCS  |
| info.                    |
|                          |
|     # The latest version |
|  of this script is avail |
| able from http://www.mor |
| ethan.org.               |
|     #                    |
|     # Spammer-identifica |
| tion                     |
|     # by Michael S. Zick |
|     # Used in the ABS Gu |
| ide with permission.     |
|                          |
|                          |
|                          |
|     #################### |
| ######################## |
| ###########              |
|     # Documentation      |
|     # See also "Quicksta |
| rt" at end of script.    |
|     #################### |
| ######################## |
| ###########              |
|                          |
|     :<<-'__is_spammer_Do |
| c_'                      |
|                          |
|         Copyright (c) Mi |
| chael S. Zick, 2004      |
|         License: Unrestr |
| icted reuse in any form, |
|  for any purpose.        |
|         Warranty: None - |
| {Its a script; the user  |
| is on their own.}-       |
|                          |
|     Impatient?           |
|         Application code |
| : goto "# # # Hunt the S |
| pammer' program code # # |
|  #"                      |
|         Example output:  |
| ":<<-'_is_spammer_output |
| s_'"                     |
|         How to use: Ente |
| r script name without ar |
| guments.                 |
|                     Or g |
| oto "Quickstart" at end  |
| of script.               |
|                          |
|     Provides             |
|         Given a domain n |
| ame or IP(v4) address as |
|  input:                  |
|                          |
|         Does an exhausti |
| ve set of queries to fin |
| d the associated         |
|         network resource |
| s (short of recursing in |
| to TLDs).                |
|                          |
|         Checks the IP(v4 |
| ) addresses found agains |
| t Blacklist              |
|         nameservers.     |
|                          |
|         If found to be a |
|  blacklisted IP(v4) addr |
| ess,                     |
|         reports the blac |
| klist text records.      |
|         (Usually hyper-l |
| inks to the specific rep |
| ort.)                    |
|                          |
|     Requires             |
|         A working Intern |
| et connection.           |
|         (Exercise: Add c |
| heck and/or abort if not |
|  on-line when running sc |
| ript.)                   |
|         Bash with arrays |
|  (2.05b+).               |
|                          |
|         The external pro |
| gram 'dig' --            |
|         a utility progra |
| m provided with the 'bin |
| d' set of programs.      |
|         Specifically, th |
| e version which is part  |
| of Bind series 9.x       |
|         See: http://www. |
| isc.org                  |
|                          |
|         All usages of 'd |
| ig' are limited to wrapp |
| er functions,            |
|         which may be rew |
| ritten as required.      |
|         See: dig_wrapper |
| s.bash for details.      |
|              ("Additiona |
| l documentation" -- belo |
| w)                       |
|                          |
|     Usage                |
|         Script requires  |
| a single argument, which |
|  may be:                 |
|         1) A domain name |
| ;                        |
|         2) An IP(v4) add |
| ress;                    |
|         3) A filename, w |
| ith one name or address  |
| per line.                |
|                          |
|         Script accepts a |
| n optional second argume |
| nt, which may be:        |
|         1) A Blacklist s |
| erver name;              |
|         2) A filename, w |
| ith one Blacklist server |
|  name per line.          |
|                          |
|         If the second ar |
| gument is not provided,  |
| the script uses          |
|         a built-in set o |
| f (free) Blacklist serve |
| rs.                      |
|                          |
|         See also, the Qu |
| ickstart at the end of t |
| his script (after 'exit' |
| ).                       |
|                          |
|     Return Codes         |
|         0 - All OK       |
|         1 - Script failu |
| re                       |
|         2 - Something is |
|  Blacklisted             |
|                          |
|     Optional environment |
|  variables               |
|         SPAMMER_TRACE    |
|             If set to a  |
| writable file,           |
|             script will  |
| log an execution flow tr |
| ace.                     |
|                          |
|         SPAMMER_DATA     |
|             If set to a  |
| writable file, script wi |
| ll dump its              |
|             discovered d |
| ata in the form of Graph |
| Viz file.                |
|             See: http:// |
| www.research.att.com/sw/ |
| tools/graphviz           |
|                          |
|         SPAMMER_LIMIT    |
|             Limits the d |
| epth of resource tracing |
| .                        |
|                          |
|             Default is 2 |
|  levels.                 |
|                          |
|             A setting of |
|  0 (zero) means 'unlimit |
| ed' . . .                |
|               Caution: s |
| cript might recurse the  |
| whole Internet!          |
|                          |
|             A limit of 1 |
|  or 2 is most useful whe |
| n processing             |
|             a file of do |
| main names and addresses |
| .                        |
|             A higher lim |
| it can be useful when hu |
| nting spam gangs.        |
|                          |
|                          |
|     Additional documenta |
| tion                     |
|         Download the arc |
| hived set of scripts     |
|         explaining and i |
| llustrating the function |
|  contained within this s |
| cript.                   |
|         http://bash.deta |
| .in/mszick_clf.tar.bz2   |
|                          |
|                          |
|     Study notes          |
|         This script uses |
|  a large number of funct |
| ions.                    |
|         Nearly all gener |
| al functions have their  |
| own example script.      |
|         Each of the exam |
| ple scripts have tutoria |
| l level comments.        |
|                          |
|     Scripting project    |
|         Add support for  |
| IP(v6) addresses.        |
|         IP(v6) addresses |
|  are recognized but not  |
| processed.               |
|                          |
|     Advanced project     |
|         Add the reverse  |
| lookup detail to the dis |
| covered information.     |
|                          |
|         Report the deleg |
| ation chain and abuse co |
| ntacts.                  |
|                          |
|         Modify the Graph |
| Viz file output to inclu |
| de the                   |
|         newly discovered |
|  information.            |
|                          |
|     __is_spammer_Doc_    |
|                          |
|     #################### |
| ######################## |
| ###########              |
|                          |
|                          |
|                          |
|                          |
|     #### Special IFS set |
| tings used for string pa |
| rsing. ####              |
|                          |
|     # Whitespace == :Spa |
| ce:Tab:Line Feed:Carriag |
| e Return:                |
|     WSP_IFS=$'\x20'$'\x0 |
| 9'$'\x0A'$'\x0D'         |
|                          |
|     # No Whitespace == L |
| ine Feed:Carriage Return |
|     NO_WSP=$'\x0A'$'\x0D |
| '                        |
|                          |
|     # Field separator fo |
| r dotted decimal IP addr |
| esses                    |
|     ADR_IFS=${NO_WSP}'.' |
|                          |
|     # Array to dotted st |
| ring conversions         |
|     DOT_IFS='.'${WSP_IFS |
| }                        |
|                          |
|     # # # Pending operat |
| ions stack machine # # # |
|     # This set of functi |
| ons described in func_st |
| ack.bash.                |
|     # (See "Additional d |
| ocumentation" above.)    |
|     # # #                |
|                          |
|     # Global stack of pe |
| nding operations.        |
|     declare -f -a _pendi |
| ng_                      |
|     # Global sentinel fo |
| r stack runners          |
|     declare -i _p_ctrl_  |
|     # Global holder for  |
| currently executing func |
| tion                     |
|     declare -f _pend_cur |
| rent_                    |
|                          |
|     # # # Debug version  |
| only - remove for regula |
| r use # # #              |
|     #                    |
|     # The function store |
| d in _pend_hook_ is call |
| ed                       |
|     # immediately before |
|  each pending function i |
| s                        |
|     # evaluated.  Stack  |
| clean, _pend_current_ se |
| t.                       |
|     #                    |
|     # This thingy demons |
| trated in pend_hook.bash |
| .                        |
|     declare -f _pend_hoo |
| k_                       |
|     # # #                |
|                          |
|     # The do nothing fun |
| ction                    |
|     pend_dummy() { : ; } |
|                          |
|     # Clear and initiali |
| ze the function stack.   |
|     pend_init() {        |
|         unset _pending_[ |
| @]                       |
|         pend_func pend_s |
| top_mark                 |
|         _pend_hook_='pen |
| d_dummy'  # Debug only.  |
|     }                    |
|                          |
|     # Discard the top fu |
| nction on the stack.     |
|     pend_pop() {         |
|         if [ ${#_pending |
| _[@]} -gt 0 ]            |
|         then             |
|             local -i _to |
| p_                       |
|             _top_=${#_pe |
| nding_[@]}-1             |
|             unset _pendi |
| ng_[$_top_]              |
|         fi               |
|     }                    |
|                          |
|     # pend_func function |
| _name [$(printf '%q\n' a |
| rguments)]               |
|     pend_func() {        |
|         local IFS=${NO_W |
| SP}                      |
|         set -f           |
|         _pending_[${#_pe |
| nding_[@]}]=$@           |
|         set +f           |
|     }                    |
|                          |
|     # The function which |
|  stops the release:      |
|     pend_stop_mark() {   |
|         _p_ctrl_=0       |
|     }                    |
|                          |
|     pend_mark() {        |
|         pend_func pend_s |
| top_mark                 |
|     }                    |
|                          |
|     # Execute functions  |
| until 'pend_stop_mark' . |
|  . .                     |
|     pend_release() {     |
|         local -i _top_   |
|            # Declare _to |
| p_ as integer.           |
|         _p_ctrl_=${#_pen |
| ding_[@]}                |
|         while [ ${_p_ctr |
| l_} -gt 0 ]              |
|         do               |
|            _top_=${#_pen |
| ding_[@]}-1              |
|            _pend_current |
| _=${_pending_[$_top_]}   |
|            unset _pendin |
| g_[$_top_]               |
|            $_pend_hook_  |
|            # Debug only. |
|            eval $_pend_c |
| urrent_                  |
|         done             |
|     }                    |
|                          |
|     # Drop functions unt |
| il 'pend_stop_mark' . .  |
| .                        |
|     pend_drop() {        |
|         local -i _top_   |
|         local _pd_ctrl_= |
| ${#_pending_[@]}         |
|         while [ ${_pd_ct |
| rl_} -gt 0 ]             |
|         do               |
|            _top_=$_pd_ct |
| rl_-1                    |
|            if [ "${_pend |
| ing_[$_top_]}" == 'pend_ |
| stop_mark' ]             |
|            then          |
|                unset _pe |
| nding_[$_top_]           |
|                break     |
|            else          |
|                unset _pe |
| nding_[$_top_]           |
|                _pd_ctrl_ |
| =$_top_                  |
|            fi            |
|         done             |
|         if [ ${#_pending |
| _[@]} -eq 0 ]            |
|         then             |
|             pend_func pe |
| nd_stop_mark             |
|         fi               |
|     }                    |
|                          |
|     #### Array editors # |
| ###                      |
|                          |
|     # This function desc |
| ribed in edit_exact.bash |
| .                        |
|     # (See "Additional d |
| ocumentation," above.)   |
|     # edit_exact <exclud |
| es_array_name> <target_a |
| rray_name>               |
|     edit_exact() {       |
|         [ $# -eq 2 ] ||  |
|         [ $# -eq 3 ] ||  |
| return 1                 |
|         local -a _ee_Exc |
| ludes                    |
|         local -a _ee_Tar |
| get                      |
|         local _ee_x      |
|         local _ee_t      |
|         local IFS=${NO_W |
| SP}                      |
|         set -f           |
|         eval _ee_Exclude |
| s=\( \$\{$1\[@\]\} \)    |
|         eval _ee_Target= |
| \( \$\{$2\[@\]\} \)      |
|         local _ee_len=${ |
| #_ee_Target[@]}     # Or |
| iginal length.           |
|         local _ee_cnt=${ |
| #_ee_Excludes[@]}   # Ex |
| clude list length.       |
|         [ ${_ee_len} -ne |
|  0 ] || return 0    # Ca |
| n't edit zero length.    |
|         [ ${_ee_cnt} -ne |
|  0 ] || return 0    # Ca |
| n't edit zero length.    |
|         for (( x = 0; x  |
| < ${_ee_cnt} ; x++ ))    |
|         do               |
|             _ee_x=${_ee_ |
| Excludes[$x]}            |
|             for (( n = 0 |
|  ; n < ${_ee_len} ; n++  |
| ))                       |
|             do           |
|                 _ee_t=${ |
| _ee_Target[$n]}          |
|                 if [ x"$ |
| {_ee_t}" == x"${_ee_x}"  |
| ]                        |
|                 then     |
|                     unse |
| t _ee_Target[$n]     # D |
| iscard match.            |
|                     [ $# |
|  -eq 2 ] && break    # I |
| f 2 arguments, then done |
| .                        |
|                 fi       |
|             done         |
|         done             |
|         eval $2=\( \$\{_ |
| ee_Target\[@\]\} \)      |
|         set +f           |
|         return 0         |
|     }                    |
|                          |
|     # This function desc |
| ribed in edit_by_glob.ba |
| sh.                      |
|     # edit_by_glob <excl |
| udes_array_name> <target |
| _array_name>             |
|     edit_by_glob() {     |
|         [ $# -eq 2 ] ||  |
|         [ $# -eq 3 ] ||  |
| return 1                 |
|         local -a _ebg_Ex |
| cludes                   |
|         local -a _ebg_Ta |
| rget                     |
|         local _ebg_x     |
|         local _ebg_t     |
|         local IFS=${NO_W |
| SP}                      |
|         set -f           |
|         eval _ebg_Exclud |
| es=\( \$\{$1\[@\]\} \)   |
|         eval _ebg_Target |
| =\( \$\{$2\[@\]\} \)     |
|         local _ebg_len=$ |
| {#_ebg_Target[@]}        |
|         local _ebg_cnt=$ |
| {#_ebg_Excludes[@]}      |
|         [ ${_ebg_len} -n |
| e 0 ] || return 0        |
|         [ ${_ebg_cnt} -n |
| e 0 ] || return 0        |
|         for (( x = 0; x  |
| < ${_ebg_cnt} ; x++ ))   |
|         do               |
|             _ebg_x=${_eb |
| g_Excludes[$x]}          |
|             for (( n = 0 |
|  ; n < ${_ebg_len} ; n++ |
|  ))                      |
|             do           |
|                 [ $# -eq |
|  3 ] && _ebg_x=${_ebg_x} |
| '*'  #  Do prefix edit   |
|                 if [ ${_ |
| ebg_Target[$n]:=} ]      |
|      #+ if defined & set |
| .                        |
|                 then     |
|                     _ebg |
| _t=${_ebg_Target[$n]/#${ |
| _ebg_x}/}                |
|                     [ ${ |
| #_ebg_t} -eq 0 ] && unse |
| t _ebg_Target[$n]        |
|                 fi       |
|             done         |
|         done             |
|         eval $2=\( \$\{_ |
| ebg_Target\[@\]\} \)     |
|         set +f           |
|         return 0         |
|     }                    |
|                          |
|     # This function desc |
| ribed in unique_lines.ba |
| sh.                      |
|     # unique_lines <in_n |
| ame> <out_name>          |
|     unique_lines() {     |
|         [ $# -eq 2 ] ||  |
| return 1                 |
|         local -a _ul_in  |
|         local -a _ul_out |
|         local -i _ul_cnt |
|         local -i _ul_pos |
|         local _ul_tmp    |
|         local IFS=${NO_W |
| SP}                      |
|         set -f           |
|         eval _ul_in=\( \ |
| $\{$1\[@\]\} \)          |
|         _ul_cnt=${#_ul_i |
| n[@]}                    |
|         for (( _ul_pos = |
|  0 ; _ul_pos < ${_ul_cnt |
| } ; _ul_pos++ ))         |
|         do               |
|             if [ ${_ul_i |
| n[${_ul_pos}]:=} ]       |
| # If defined & not empty |
|             then         |
|                 _ul_tmp= |
| ${_ul_in[${_ul_pos}]}    |
|                 _ul_out[ |
| ${#_ul_out[@]}]=${_ul_tm |
| p}                       |
|                 for (( z |
| ap = _ul_pos ; zap < ${_ |
| ul_cnt} ; zap++ ))       |
|                 do       |
|                     [ ${ |
| _ul_in[${zap}]:=} ] &&   |
|                     [ 'x |
| '${_ul_in[${zap}]} == 'x |
| '${_ul_tmp} ] &&         |
|                          |
| unset _ul_in[${zap}]     |
|                 done     |
|             fi           |
|         done             |
|         eval $2=\( \$\{_ |
| ul_out\[@\]\} \)         |
|         set +f           |
|         return 0         |
|     }                    |
|                          |
|     # This function desc |
| ribed in char_convert.ba |
| sh.                      |
|     # to_lower <string>  |
|     to_lower() {         |
|         [ $# -eq 1 ] ||  |
| return 1                 |
|         local _tl_out    |
|         _tl_out=${1//A/a |
| }                        |
|         _tl_out=${_tl_ou |
| t//B/b}                  |
|         _tl_out=${_tl_ou |
| t//C/c}                  |
|         _tl_out=${_tl_ou |
| t//D/d}                  |
|         _tl_out=${_tl_ou |
| t//E/e}                  |
|         _tl_out=${_tl_ou |
| t//F/f}                  |
|         _tl_out=${_tl_ou |
| t//G/g}                  |
|         _tl_out=${_tl_ou |
| t//H/h}                  |
|         _tl_out=${_tl_ou |
| t//I/i}                  |
|         _tl_out=${_tl_ou |
| t//J/j}                  |
|         _tl_out=${_tl_ou |
| t//K/k}                  |
|         _tl_out=${_tl_ou |
| t//L/l}                  |
|         _tl_out=${_tl_ou |
| t//M/m}                  |
|         _tl_out=${_tl_ou |
| t//N/n}                  |
|         _tl_out=${_tl_ou |
| t//O/o}                  |
|         _tl_out=${_tl_ou |
| t//P/p}                  |
|         _tl_out=${_tl_ou |
| t//Q/q}                  |
|         _tl_out=${_tl_ou |
| t//R/r}                  |
|         _tl_out=${_tl_ou |
| t//S/s}                  |
|         _tl_out=${_tl_ou |
| t//T/t}                  |
|         _tl_out=${_tl_ou |
| t//U/u}                  |
|         _tl_out=${_tl_ou |
| t//V/v}                  |
|         _tl_out=${_tl_ou |
| t//W/w}                  |
|         _tl_out=${_tl_ou |
| t//X/x}                  |
|         _tl_out=${_tl_ou |
| t//Y/y}                  |
|         _tl_out=${_tl_ou |
| t//Z/z}                  |
|         echo ${_tl_out}  |
|         return 0         |
|     }                    |
|                          |
|     #### Application hel |
| per functions ####       |
|                          |
|     # Not everybody uses |
|  dots as separators (APN |
| IC, for example).        |
|     # This function desc |
| ribed in to_dot.bash     |
|     # to_dot <string>    |
|     to_dot() {           |
|         [ $# -eq 1 ] ||  |
| return 1                 |
|         echo ${1//[#|@|% |
| ]/.}                     |
|         return 0         |
|     }                    |
|                          |
|     # This function desc |
| ribed in is_number.bash. |
|     # is_number <input>  |
|     is_number() {        |
|         [ "$#" -eq 1 ]   |
|   || return 1  # is blan |
| k?                       |
|         [ x"$1" == 'x0'  |
| ] && return 0  # is zero |
| ?                        |
|         local -i tst     |
|         let tst=$1 2>/de |
| v/null         # else is |
|  numeric!                |
|         return $?        |
|     }                    |
|                          |
|     # This function desc |
| ribed in is_address.bash |
| .                        |
|     # is_address <input> |
|     is_address() {       |
|         [ $# -eq 1 ] ||  |
| return 1    # Blank ==>  |
| false                    |
|         local -a _ia_inp |
| ut                       |
|         local IFS=${ADR_ |
| IFS}                     |
|         _ia_input=( $1 ) |
|         if  [ ${#_ia_inp |
| ut[@]} -eq 4 ]  &&       |
|             is_number ${ |
| _ia_input[0]}   &&       |
|             is_number ${ |
| _ia_input[1]}   &&       |
|             is_number ${ |
| _ia_input[2]}   &&       |
|             is_number ${ |
| _ia_input[3]}   &&       |
|             [ ${_ia_inpu |
| t[0]} -lt 256 ] &&       |
|             [ ${_ia_inpu |
| t[1]} -lt 256 ] &&       |
|             [ ${_ia_inpu |
| t[2]} -lt 256 ] &&       |
|             [ ${_ia_inpu |
| t[3]} -lt 256 ]          |
|         then             |
|             return 0     |
|         else             |
|             return 1     |
|         fi               |
|     }                    |
|                          |
|     #  This function des |
| cribed in split_ip.bash. |
|     #  split_ip <IP_addr |
| ess>                     |
|     #+ <array_name_norm> |
|  [<array_name_rev>]      |
|     split_ip() {         |
|         [ $# -eq 3 ] ||  |
|              #  Either t |
| hree                     |
|         [ $# -eq 2 ] ||  |
| return 1     #+ or two a |
| rguments                 |
|         local -a _si_inp |
| ut                       |
|         local IFS=${ADR_ |
| IFS}                     |
|         _si_input=( $1 ) |
|         IFS=${WSP_IFS}   |
|         eval $2=\(\ \$\{ |
| _si_input\[@\]\}\ \)     |
|         if [ $# -eq 3 ]  |
|         then             |
|             # Build quer |
| y order array.           |
|             local -a _dn |
| s_ip                     |
|             _dns_ip[0]=$ |
| {_si_input[3]}           |
|             _dns_ip[1]=$ |
| {_si_input[2]}           |
|             _dns_ip[2]=$ |
| {_si_input[1]}           |
|             _dns_ip[3]=$ |
| {_si_input[0]}           |
|             eval $3=\(\  |
| \$\{_dns_ip\[@\]\}\ \)   |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # This function desc |
| ribed in dot_array.bash. |
|     # dot_array <array_n |
| ame>                     |
|     dot_array() {        |
|         [ $# -eq 1 ] ||  |
| return 1     # Single ar |
| gument required.         |
|         local -a _da_inp |
| ut                       |
|         eval _da_input=\ |
| (\ \$\{$1\[@\]\}\ \)     |
|         local IFS=${DOT_ |
| IFS}                     |
|         local _da_output |
| =${_da_input[@]}         |
|         IFS=${WSP_IFS}   |
|         echo ${_da_outpu |
| t}                       |
|         return 0         |
|     }                    |
|                          |
|     # This function desc |
| ribed in file_to_array.b |
| ash                      |
|     # file_to_array <fil |
| e_name> <line_array_name |
| >                        |
|     file_to_array() {    |
|         [ $# -eq 2 ] ||  |
| return 1  # Two argument |
| s required.              |
|         local IFS=${NO_W |
| SP}                      |
|         local -a _fta_tm |
| p_                       |
|         _fta_tmp_=( $(ca |
| t $1) )                  |
|         eval $2=\( \$\{_ |
| fta_tmp_\[@\]\} \)       |
|         return 0         |
|     }                    |
|                          |
|     #  Columnized print  |
| of an array of multi-fie |
| ld strings.              |
|     #  col_print <array_ |
| name> <min_space> <      |
|     #+ tab_stop [tab_sto |
| ps]>                     |
|     col_print() {        |
|         [ $# -gt 2 ] ||  |
| return 0                 |
|         local -a _cp_inp |
|         local -a _cp_spc |
|         local -a _cp_lin |
| e                        |
|         local _cp_min    |
|         local _cp_mcnt   |
|         local _cp_pos    |
|         local _cp_cnt    |
|         local _cp_tab    |
|         local -i _cp     |
|         local -i _cpf    |
|         local _cp_fld    |
|         # WARNING: FOLLO |
| WING LINE NOT BLANK -- I |
| T IS QUOTED SPACES.      |
|         local _cp_max='  |
|                          |
|                          |
|            '             |
|         set -f           |
|         local IFS=${NO_W |
| SP}                      |
|         eval _cp_inp=\(\ |
|  \$\{$1\[@\]\}\ \)       |
|         [ ${#_cp_inp[@]} |
|  -gt 0 ] || return 0 # E |
| mpty is easy.            |
|         _cp_mcnt=$2      |
|         _cp_min=${_cp_ma |
| x:1:${_cp_mcnt}}         |
|         shift            |
|         shift            |
|         _cp_cnt=$#       |
|         for (( _cp = 0 ; |
|  _cp < _cp_cnt ; _cp++ ) |
| )                        |
|         do               |
|             _cp_spc[${#_ |
| cp_spc[@]}]="${_cp_max:2 |
| :$1}" #"                 |
|             shift        |
|         done             |
|         _cp_cnt=${#_cp_i |
| np[@]}                   |
|         for (( _cp = 0 ; |
|  _cp < _cp_cnt ; _cp++ ) |
| )                        |
|         do               |
|             _cp_pos=1    |
|             IFS=${NO_WSP |
| }$'\x20'                 |
|             _cp_line=( $ |
| {_cp_inp[${_cp}]} )      |
|             IFS=${NO_WSP |
| }                        |
|             for (( _cpf  |
| = 0 ; _cpf < ${#_cp_line |
| [@]} ; _cpf++ ))         |
|             do           |
|                 _cp_tab= |
| ${_cp_spc[${_cpf}]:${_cp |
| _pos}}                   |
|                 if [ ${# |
| _cp_tab} -lt ${_cp_mcnt} |
|  ]                       |
|                 then     |
|                     _cp_ |
| tab="${_cp_min}"         |
|                 fi       |
|                 echo -n  |
| "${_cp_tab}"             |
|                 (( _cp_p |
| os = ${_cp_pos} + ${#_cp |
| _tab} ))                 |
|                 _cp_fld= |
| "${_cp_line[${_cpf}]}"   |
|                 echo -n  |
| ${_cp_fld}               |
|                 (( _cp_p |
| os = ${_cp_pos} + ${#_cp |
| _fld} ))                 |
|             done         |
|             echo         |
|         done             |
|         set +f           |
|         return 0         |
|     }                    |
|                          |
|     # # # # 'Hunt the Sp |
| ammer' data flow # # # # |
|                          |
|     # Application return |
|  code                    |
|     declare -i _hs_RC    |
|                          |
|     # Original input, fr |
| om which IP addresses ar |
| e removed                |
|     # After which, domai |
| n names to check         |
|     declare -a uc_name   |
|                          |
|     # Original input IP  |
| addresses are moved here |
|     # After which, IP ad |
| dresses to check         |
|     declare -a uc_addres |
| s                        |
|                          |
|     # Names against whic |
| h address expansion run  |
|     # Ready for name det |
| ail lookup               |
|     declare -a chk_name  |
|                          |
|     # Addresses against  |
| which name expansion run |
|     # Ready for address  |
| detail lookup            |
|     declare -a chk_addre |
| ss                       |
|                          |
|     #  Recursion is dept |
| h-first-by-name.         |
|     #  The expand_input_ |
| address maintains this l |
| ist                      |
|     #+ to prohibit looki |
| ng up addresses twice du |
| ring                     |
|     #+ domain name recur |
| sion.                    |
|     declare -a been_ther |
| e_addr                   |
|     been_there_addr=( '1 |
| 27.0.0.1' ) # Whitelist  |
| localhost                |
|                          |
|     # Names which we hav |
| e checked (or given up o |
| n)                       |
|     declare -a known_nam |
| e                        |
|                          |
|     # Addresses which we |
|  have checked (or given  |
| up on)                   |
|     declare -a known_add |
| ress                     |
|                          |
|     #  List of zero or m |
| ore Blacklist servers to |
|  check.                  |
|     #  Each 'known_addre |
| ss' will be checked agai |
| nst each server,         |
|     #+ with negative rep |
| lies and failures suppre |
| ssed.                    |
|     declare -a list_serv |
| er                       |
|                          |
|     # Indirection limit  |
| - set to zero == no limi |
| t                        |
|     indirect=${SPAMMER_L |
| IMIT:=2}                 |
|                          |
|     # # # # 'Hunt the Sp |
| ammer' information outpu |
| t data # # # #           |
|                          |
|     # Any domain name ma |
| y have multiple IP addre |
| sses.                    |
|     # Any IP address may |
|  have multiple domain na |
| mes.                     |
|     # Therefore, track u |
| nique address-name pairs |
| .                        |
|     declare -a known_pai |
| r                        |
|     declare -a reverse_p |
| air                      |
|                          |
|     #  In addition to th |
| e data flow variables; k |
| nown_address             |
|     #+ known_name and li |
| st_server, the following |
|  are output to the       |
|     #+ external graphics |
|  interface file.         |
|                          |
|     # Authority chain, p |
| arent -> SOA fields.     |
|     declare -a auth_chai |
| n                        |
|                          |
|     # Reference chain, p |
| arent name -> child name |
|     declare -a ref_chain |
|                          |
|     # DNS chain - domain |
|  name -> address         |
|     declare -a name_addr |
| ess                      |
|                          |
|     # Name and service p |
| airs - domain name -> se |
| rvice                    |
|     declare -a name_srvc |
|                          |
|     # Name and resource  |
| pairs - domain name -> R |
| esource Record           |
|     declare -a name_reso |
| urce                     |
|                          |
|     # Parent and Child p |
| airs - parent name -> ch |
| ild name                 |
|     # This MAY NOT be th |
| e same as the ref_chain  |
| followed!                |
|     declare -a parent_ch |
| ild                      |
|                          |
|     # Address and Blackl |
| ist hit pairs - address- |
| >server                  |
|     declare -a address_h |
| its                      |
|                          |
|     # Dump interface fil |
| e data                   |
|     declare -f _dot_dump |
|     _dot_dump=pend_dummy |
|    # Initially a no-op   |
|                          |
|     #  Data dump is enab |
| led by setting the envir |
| onment variable SPAMMER_ |
| DATA                     |
|     #+ to the name of a  |
| writable file.           |
|     declare _dot_file    |
|                          |
|     # Helper function fo |
| r the dump-to-dot-file f |
| unction                  |
|     # dump_to_dot <array |
| _name> <prefix>          |
|     dump_to_dot() {      |
|         local -a _dda_tm |
| p                        |
|         local -i _dda_cn |
| t                        |
|         local _dda_form= |
| '    '${2}'%04u %s\n'    |
|         local IFS=${NO_W |
| SP}                      |
|         eval _dda_tmp=\( |
| \ \$\{$1\[@\]\}\ \)      |
|         _dda_cnt=${#_dda |
| _tmp[@]}                 |
|         if [ ${_dda_cnt} |
|  -gt 0 ]                 |
|         then             |
|             for (( _dda  |
| = 0 ; _dda < _dda_cnt ;  |
| _dda++ ))                |
|             do           |
|                 printf " |
| ${_dda_form}" \          |
|                        " |
| ${_dda}" "${_dda_tmp[${_ |
| dda}]}" >>${_dot_file}   |
|             done         |
|         fi               |
|     }                    |
|                          |
|     # Which will also se |
| t _dot_dump to this func |
| tion . . .               |
|     dump_dot() {         |
|         local -i _dd_cnt |
|         echo '# Data vin |
| tage: '$(date -R) >${_do |
| t_file}                  |
|         echo '# ABS Guid |
| e: is_spammer.bash; v2,  |
| 2004-msz' >>${_dot_file} |
|         echo >>${_dot_fi |
| le}                      |
|         echo 'digraph G  |
| {' >>${_dot_file}        |
|                          |
|         if [ ${#known_na |
| me[@]} -gt 0 ]           |
|         then             |
|             echo >>${_do |
| t_file}                  |
|             echo '# Know |
| n domain name nodes' >>$ |
| {_dot_file}              |
|             _dd_cnt=${#k |
| nown_name[@]}            |
|             for (( _dd = |
|  0 ; _dd < _dd_cnt ; _dd |
| ++ ))                    |
|             do           |
|                 printf ' |
|     N%04u [label="%s"] ; |
| \n' \                    |
|                        " |
| ${_dd}" "${known_name[${ |
| _dd}]}" >>${_dot_file}   |
|             done         |
|         fi               |
|                          |
|         if [ ${#known_ad |
| dress[@]} -gt 0 ]        |
|         then             |
|             echo >>${_do |
| t_file}                  |
|             echo '# Know |
| n address nodes' >>${_do |
| t_file}                  |
|             _dd_cnt=${#k |
| nown_address[@]}         |
|             for (( _dd = |
|  0 ; _dd < _dd_cnt ; _dd |
| ++ ))                    |
|             do           |
|                 printf ' |
|     A%04u [label="%s"] ; |
| \n' \                    |
|                        " |
| ${_dd}" "${known_address |
| [${_dd}]}" >>${_dot_file |
| }                        |
|             done         |
|         fi               |
|                          |
|         echo             |
|                        > |
| >${_dot_file}            |
|         echo '/*'        |
|                        > |
| >${_dot_file}            |
|         echo ' * Known r |
| elationships :: User con |
| version to'  >>${_dot_fi |
| le}                      |
|         echo ' * graphic |
|  form by hand or program |
|  required.'  >>${_dot_fi |
| le}                      |
|         echo ' *'        |
|                        > |
| >${_dot_file}            |
|                          |
|         if [ ${#auth_cha |
| in[@]} -gt 0 ]           |
|         then             |
|           echo >>${_dot_ |
| file}                    |
|           echo '# Author |
| ity ref. edges followed  |
| & field source.' >>${_do |
| t_file}                  |
|             dump_to_dot  |
| auth_chain AC            |
|         fi               |
|                          |
|         if [ ${#ref_chai |
| n[@]} -gt 0 ]            |
|         then             |
|             echo >>${_do |
| t_file}                  |
|             echo '# Name |
|  ref. edges followed and |
|  field source.' >>${_dot |
| _file}                   |
|             dump_to_dot  |
| ref_chain RC             |
|         fi               |
|                          |
|         if [ ${#name_add |
| ress[@]} -gt 0 ]         |
|         then             |
|             echo >>${_do |
| t_file}                  |
|             echo '# Know |
| n name->address edges' > |
| >${_dot_file}            |
|             dump_to_dot  |
| name_address NA          |
|         fi               |
|                          |
|         if [ ${#name_srv |
| c[@]} -gt 0 ]            |
|         then             |
|             echo >>${_do |
| t_file}                  |
|             echo '# Know |
| n name->service edges' > |
| >${_dot_file}            |
|             dump_to_dot  |
| name_srvc NS             |
|         fi               |
|                          |
|         if [ ${#name_res |
| ource[@]} -gt 0 ]        |
|         then             |
|             echo >>${_do |
| t_file}                  |
|             echo '# Know |
| n name->resource edges'  |
| >>${_dot_file}           |
|             dump_to_dot  |
| name_resource NR         |
|         fi               |
|                          |
|         if [ ${#parent_c |
| hild[@]} -gt 0 ]         |
|         then             |
|             echo >>${_do |
| t_file}                  |
|             echo '# Know |
| n parent->child edges' > |
| >${_dot_file}            |
|             dump_to_dot  |
| parent_child PC          |
|         fi               |
|                          |
|         if [ ${#list_ser |
| ver[@]} -gt 0 ]          |
|         then             |
|             echo >>${_do |
| t_file}                  |
|             echo '# Know |
| n Blacklist nodes' >>${_ |
| dot_file}                |
|             _dd_cnt=${#l |
| ist_server[@]}           |
|             for (( _dd = |
|  0 ; _dd < _dd_cnt ; _dd |
| ++ ))                    |
|             do           |
|                 printf ' |
|     LS%04u [label="%s"]  |
| ;\n' \                   |
|                        " |
| ${_dd}" "${list_server[$ |
| {_dd}]}" >>${_dot_file}  |
|             done         |
|         fi               |
|                          |
|         unique_lines add |
| ress_hits address_hits   |
|         if [ ${#address_ |
| hits[@]} -gt 0 ]         |
|         then             |
|           echo >>${_dot_ |
| file}                    |
|           echo '# Known  |
| address->Blacklist_hit e |
| dges' >>${_dot_file}     |
|           echo '# CAUTIO |
| N: dig warnings can trig |
| ger false hits.' >>${_do |
| t_file}                  |
|            dump_to_dot a |
| ddress_hits AH           |
|         fi               |
|         echo          >> |
| ${_dot_file}             |
|         echo ' *'     >> |
| ${_dot_file}             |
|         echo ' * That is |
|  a lot of relationships. |
|  Happy graphing.' >>${_d |
| ot_file}                 |
|         echo ' */'    >> |
| ${_dot_file}             |
|         echo '}'      >> |
| ${_dot_file}             |
|         return 0         |
|     }                    |
|                          |
|     # # # # 'Hunt the Sp |
| ammer' execution flow #  |
| # # #                    |
|                          |
|     #  Execution trace i |
| s enabled by setting the |
|     #+ environment varia |
| ble SPAMMER_TRACE to the |
|  name of a writable file |
| .                        |
|     declare -a _trace_lo |
| g                        |
|     declare _log_file    |
|                          |
|     # Function to fill t |
| he trace log             |
|     trace_logger() {     |
|         _trace_log[${#_t |
| race_log[@]}]=${_pend_cu |
| rrent_}                  |
|     }                    |
|                          |
|     # Dump trace log to  |
| file function variable.  |
|     declare -f _log_dump |
|     _log_dump=pend_dummy |
|    # Initially a no-op.  |
|                          |
|     # Dump the trace log |
|  to a file.              |
|     dump_log() {         |
|         local -i _dl_cnt |
|         _dl_cnt=${#_trac |
| e_log[@]}                |
|         for (( _dl = 0 ; |
|  _dl < _dl_cnt ; _dl++ ) |
| )                        |
|         do               |
|             echo ${_trac |
| e_log[${_dl}]} >> ${_log |
| _file}                   |
|         done             |
|         _dl_cnt=${#_pend |
| ing_[@]}                 |
|         if [ ${_dl_cnt}  |
| -gt 0 ]                  |
|         then             |
|             _dl_cnt=${_d |
| l_cnt}-1                 |
|             echo '# # #  |
| Operations stack not emp |
| ty # # #' >> ${_log_file |
| }                        |
|             for (( _dl = |
|  ${_dl_cnt} ; _dl >= 0 ; |
|  _dl-- ))                |
|             do           |
|                 echo ${_ |
| pending_[${_dl}]} >> ${_ |
| log_file}                |
|             done         |
|         fi               |
|     }                    |
|                          |
|     # # # Utility progra |
| m 'dig' wrappers # # #   |
|     #                    |
|     #  These wrappers ar |
| e derived from the       |
|     #+ examples shown in |
|  dig_wrappers.bash.      |
|     #                    |
|     #  The major differe |
| nce is these return      |
|     #+ their results as  |
| a list in an array.      |
|     #                    |
|     #  See dig_wrappers. |
| bash for details and     |
|     #+ use that script t |
| o develop any changes.   |
|     #                    |
|     # # #                |
|                          |
|     # Short form answer: |
|  'dig' parses answer.    |
|                          |
|     # Forward lookup ::  |
| Name -> Address          |
|     # short_fwd <domain_ |
| name> <array_name>       |
|     short_fwd() {        |
|         local -a _sf_rep |
| ly                       |
|         local -i _sf_rc  |
|         local -i _sf_cnt |
|         IFS=${NO_WSP}    |
|     echo -n '.'          |
|     # echo 'sfwd: '${1}  |
|       _sf_reply=( $(dig  |
| +short ${1} -c in -t a 2 |
| >/dev/null) )            |
|       _sf_rc=$?          |
|       if [ ${_sf_rc} -ne |
|  0 ]                     |
|       then               |
|         _trace_log[${#_t |
| race_log[@]}]='## Lookup |
|  error '${_sf_rc}' on '$ |
| {1}' ##'                 |
|     # [ ${_sf_rc} -ne 9  |
| ] && pend_drop           |
|             return ${_sf |
| _rc}                     |
|         else             |
|             # Some versi |
| ons of 'dig' return warn |
| ings on stdout.          |
|             _sf_cnt=${#_ |
| sf_reply[@]}             |
|             for (( _sf = |
|  0 ; _sf < ${_sf_cnt} ;  |
| _sf++ ))                 |
|             do           |
|                 [ 'x'${_ |
| sf_reply[${_sf}]:0:2} == |
|  'x;;' ] &&              |
|                     unse |
| t _sf_reply[${_sf}]      |
|             done         |
|             eval $2=\( \ |
| $\{_sf_reply\[@\]\} \)   |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # Reverse lookup ::  |
| Address -> Name          |
|     # short_rev <ip_addr |
| ess> <array_name>        |
|     short_rev() {        |
|         local -a _sr_rep |
| ly                       |
|         local -i _sr_rc  |
|         local -i _sr_cnt |
|         IFS=${NO_WSP}    |
|     echo -n '.'          |
|     # echo 'srev: '${1}  |
|       _sr_reply=( $(dig  |
| +short -x ${1} 2>/dev/nu |
| ll) )                    |
|       _sr_rc=$?          |
|       if [ ${_sr_rc} -ne |
|  0 ]                     |
|       then               |
|         _trace_log[${#_t |
| race_log[@]}]='## Lookup |
|  error '${_sr_rc}' on '$ |
| {1}' ##'                 |
|     # [ ${_sr_rc} -ne 9  |
| ] && pend_drop           |
|             return ${_sr |
| _rc}                     |
|         else             |
|             # Some versi |
| ons of 'dig' return warn |
| ings on stdout.          |
|             _sr_cnt=${#_ |
| sr_reply[@]}             |
|             for (( _sr = |
|  0 ; _sr < ${_sr_cnt} ;  |
| _sr++ ))                 |
|             do           |
|                 [ 'x'${_ |
| sr_reply[${_sr}]:0:2} == |
|  'x;;' ] &&              |
|                     unse |
| t _sr_reply[${_sr}]      |
|             done         |
|             eval $2=\( \ |
| $\{_sr_reply\[@\]\} \)   |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # Special format loo |
| kup used to query blackl |
| ist servers.             |
|     # short_text <ip_add |
| ress> <array_name>       |
|     short_text() {       |
|         local -a _st_rep |
| ly                       |
|         local -i _st_rc  |
|         local -i _st_cnt |
|         IFS=${NO_WSP}    |
|     # echo 'stxt: '${1}  |
|       _st_reply=( $(dig  |
| +short ${1} -c in -t txt |
|  2>/dev/null) )          |
|       _st_rc=$?          |
|       if [ ${_st_rc} -ne |
|  0 ]                     |
|       then               |
|         _trace_log[${#_t |
| race_log[@]}]='##Text lo |
| okup error '${_st_rc}' o |
| n '${1}'##'              |
|     # [ ${_st_rc} -ne 9  |
| ] && pend_drop           |
|             return ${_st |
| _rc}                     |
|         else             |
|             # Some versi |
| ons of 'dig' return warn |
| ings on stdout.          |
|             _st_cnt=${#_ |
| st_reply[@]}             |
|             for (( _st = |
|  0 ; _st < ${#_st_cnt} ; |
|  _st++ ))                |
|             do           |
|                 [ 'x'${_ |
| st_reply[${_st}]:0:2} == |
|  'x;;' ] &&              |
|                     unse |
| t _st_reply[${_st}]      |
|             done         |
|             eval $2=\( \ |
| $\{_st_reply\[@\]\} \)   |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # The long forms, a. |
| k.a., the parse it yours |
| elf versions             |
|                          |
|     # RFC 2782   Service |
|  lookups                 |
|     # dig +noall +nofail |
|  +answer _ldap._tcp.open |
| ldap.org -t srv          |
|     # _<service>._<proto |
| col>.<domain_name>       |
|     # _ldap._tcp.openlda |
| p.org. 3600   IN     SRV |
|     0 0 389 ldap.openlda |
| p.org.                   |
|     # domain TTL Class S |
| RV Priority Weight Port  |
| Target                   |
|                          |
|     # Forward lookup ::  |
| Name -> poor man's zone  |
| transfer                 |
|     # long_fwd <domain_n |
| ame> <array_name>        |
|     long_fwd() {         |
|         local -a _lf_rep |
| ly                       |
|         local -i _lf_rc  |
|         local -i _lf_cnt |
|         IFS=${NO_WSP}    |
|     echo -n ':'          |
|     # echo 'lfwd: '${1}  |
|       _lf_reply=( $(     |
|          dig +noall +nof |
| ail +answer +authority + |
| additional \             |
|              ${1} -t soa |
|  ${1} -t mx ${1} -t any  |
| 2>/dev/null) )           |
|       _lf_rc=$?          |
|       if [ ${_lf_rc} -ne |
|  0 ]                     |
|       then               |
|         _trace_log[${#_t |
| race_log[@]}]='# Zone lo |
| okup err '${_lf_rc}' on  |
| '${1}' #'                |
|     # [ ${_lf_rc} -ne 9  |
| ] && pend_drop           |
|             return ${_lf |
| _rc}                     |
|         else             |
|             # Some versi |
| ons of 'dig' return warn |
| ings on stdout.          |
|             _lf_cnt=${#_ |
| lf_reply[@]}             |
|             for (( _lf = |
|  0 ; _lf < ${_lf_cnt} ;  |
| _lf++ ))                 |
|             do           |
|                 [ 'x'${_ |
| lf_reply[${_lf}]:0:2} == |
|  'x;;' ] &&              |
|                     unse |
| t _lf_reply[${_lf}]      |
|             done         |
|             eval $2=\( \ |
| $\{_lf_reply\[@\]\} \)   |
|         fi               |
|         return 0         |
|     }                    |
|     #  The reverse looku |
| p domain name correspond |
| ing to the IPv6 address: |
|     #      4321:0:1:2:3: |
| 4:567:89ab               |
|     #  would be (nibble, |
|  I.E: Hexdigit) reversed |
| :                        |
|     #  b.a.9.8.7.6.5.0.4 |
| .0.0.0.3.0.0.0.2.0.0.0.1 |
| .0.0.0.0.0.0.0.1.2.3.4.I |
| P6.ARPA.                 |
|                          |
|     # Reverse lookup ::  |
| Address -> poor man's de |
| legation chain           |
|     # long_rev <rev_ip_a |
| ddress> <array_name>     |
|     long_rev() {         |
|         local -a _lr_rep |
| ly                       |
|         local -i _lr_rc  |
|         local -i _lr_cnt |
|         local _lr_dns    |
|         _lr_dns=${1}'.in |
| -addr.arpa.'             |
|         IFS=${NO_WSP}    |
|     echo -n ':'          |
|     # echo 'lrev: '${1}  |
|       _lr_reply=( $(     |
|            dig +noall +n |
| ofail +answer +authority |
|  +additional \           |
|                ${_lr_dns |
| } -t soa ${_lr_dns} -t a |
| ny 2>/dev/null) )        |
|       _lr_rc=$?          |
|       if [ ${_lr_rc} -ne |
|  0 ]                     |
|       then               |
|         _trace_log[${#_t |
| race_log[@]}]='# Deleg l |
| kp error '${_lr_rc}' on  |
| '${1}' #'                |
|     # [ ${_lr_rc} -ne 9  |
| ] && pend_drop           |
|             return ${_lr |
| _rc}                     |
|         else             |
|             # Some versi |
| ons of 'dig' return warn |
| ings on stdout.          |
|             _lr_cnt=${#_ |
| lr_reply[@]}             |
|             for (( _lr = |
|  0 ; _lr < ${_lr_cnt} ;  |
| _lr++ ))                 |
|             do           |
|                 [ 'x'${_ |
| lr_reply[${_lr}]:0:2} == |
|  'x;;' ] &&              |
|                     unse |
| t _lr_reply[${_lr}]      |
|             done         |
|             eval $2=\( \ |
| $\{_lr_reply\[@\]\} \)   |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # # # Application sp |
| ecific functions # # #   |
|                          |
|     # Mung a possible na |
| me; suppresses root and  |
| TLDs.                    |
|     # name_fixup <string |
| >                        |
|     name_fixup(){        |
|         local -a _nf_tmp |
|         local -i _nf_end |
|         local _nf_str    |
|         local IFS        |
|         _nf_str=$(to_low |
| er ${1})                 |
|         _nf_str=$(to_dot |
|  ${_nf_str})             |
|         _nf_end=${#_nf_s |
| tr}-1                    |
|         [ ${_nf_str:${_n |
| f_end}} != '.' ] &&      |
|             _nf_str=${_n |
| f_str}'.'                |
|         IFS=${ADR_IFS}   |
|         _nf_tmp=( ${_nf_ |
| str} )                   |
|         IFS=${WSP_IFS}   |
|         _nf_end=${#_nf_t |
| mp[@]}                   |
|         case ${_nf_end}  |
| in                       |
|         0) # No dots, on |
| ly dots.                 |
|             echo         |
|             return 1     |
|         ;;               |
|         1) # Only a TLD. |
|             echo         |
|             return 1     |
|         ;;               |
|         2) # Maybe okay. |
|            echo ${_nf_st |
| r}                       |
|            return 0      |
|            # Needs a loo |
| kup table?               |
|            if [ ${#_nf_t |
| mp[1]} -eq 2 ]           |
|            then # Countr |
| y coded TLD.             |
|                echo      |
|                return 1  |
|            else          |
|                echo ${_n |
| f_str}                   |
|                return 0  |
|            fi            |
|         ;;               |
|         esac             |
|         echo ${_nf_str}  |
|         return 0         |
|     }                    |
|                          |
|     # Grope and mung ori |
| ginal input(s).          |
|     split_input() {      |
|         [ ${#uc_name[@]} |
|  -gt 0 ] || return 0     |
|         local -i _si_cnt |
|         local -i _si_len |
|         local _si_str    |
|         unique_lines uc_ |
| name uc_name             |
|         _si_cnt=${#uc_na |
| me[@]}                   |
|         for (( _si = 0 ; |
|  _si < _si_cnt ; _si++ ) |
| )                        |
|         do               |
|             _si_str=${uc |
| _name[$_si]}             |
|             if is_addres |
| s ${_si_str}             |
|             then         |
|                 uc_addre |
| ss[${#uc_address[@]}]=${ |
| _si_str}                 |
|                 unset uc |
| _name[$_si]              |
|             else         |
|                 if ! uc_ |
| name[$_si]=$(name_fixup  |
| ${_si_str})              |
|                 then     |
|                     unse |
| t ucname[$_si]           |
|                 fi       |
|             fi           |
|         done             |
|       uc_name=( ${uc_nam |
| e[@]} )                  |
|       _si_cnt=${#uc_name |
| [@]}                     |
|       _trace_log[${#_tra |
| ce_log[@]}]='#Input '${_ |
| si_cnt}' unchkd name inp |
| ut(s).#'                 |
|       _si_cnt=${#uc_addr |
| ess[@]}                  |
|       _trace_log[${#_tra |
| ce_log[@]}]='#Input '${_ |
| si_cnt}' unchkd addr inp |
| ut(s).#'                 |
|         return 0         |
|     }                    |
|                          |
|     # # # Discovery func |
| tions -- recursively int |
| erlocked by external dat |
| a # # #                  |
|     # # # The leading 'i |
| f list is empty; return  |
| 0' in each is required.  |
| # # #                    |
|                          |
|     # Recursion limiter  |
|     # limit_chk() <next_ |
| level>                   |
|     limit_chk() {        |
|         local -i _lc_lmt |
|         # Check indirect |
| ion limit.               |
|         if [ ${indirect} |
|  -eq 0 ] || [ $# -eq 0 ] |
|         then             |
|             # The 'do-fo |
| rever' choice            |
|             echo 1       |
|            # Any value w |
| ill do.                  |
|             return 0     |
|            # OK to conti |
| nue.                     |
|         else             |
|             # Limiting i |
| s in effect.             |
|             if [ ${indir |
| ect} -lt ${1} ]          |
|             then         |
|                 echo ${1 |
| }          # Whatever.   |
|                 return 1 |
|            # Stop here.  |
|             else         |
|                 _lc_lmt= |
| ${1}+1     # Bump the gi |
| ven limit.               |
|                 echo ${_ |
| lc_lmt}    # Echo it.    |
|                 return 0 |
|            # OK to conti |
| nue.                     |
|             fi           |
|         fi               |
|     }                    |
|                          |
|     # For each name in u |
| c_name:                  |
|     #     Move name to c |
| hk_name.                 |
|     #     Add addresses  |
| to uc_address.           |
|     #     Pend expand_in |
| put_address.             |
|     #     Repeat until n |
| othing new found.        |
|     # expand_input_name  |
| <indirection_limit>      |
|     expand_input_name()  |
| {                        |
|         [ ${#uc_name[@]} |
|  -gt 0 ] || return 0     |
|         local -a _ein_ad |
| dr                       |
|         local -a _ein_ne |
| w                        |
|         local -i _ucn_cn |
| t                        |
|         local -i _ein_cn |
| t                        |
|         local _ein_tst   |
|         _ucn_cnt=${#uc_n |
| ame[@]}                  |
|                          |
|         if  ! _ein_cnt=$ |
| (limit_chk ${1})         |
|         then             |
|             return 0     |
|         fi               |
|                          |
|         for (( _ein = 0  |
| ; _ein < _ucn_cnt ; _ein |
| ++ ))                    |
|         do               |
|             if short_fwd |
|  ${uc_name[${_ein}]} _ei |
| n_new                    |
|             then         |
|               for (( _ei |
| n_cnt = 0 ; _ein_cnt < $ |
| {#_ein_new[@]}; _ein_cnt |
| ++ ))                    |
|               do         |
|                   _ein_t |
| st=${_ein_new[${_ein_cnt |
| }]}                      |
|                   if is_ |
| address ${_ein_tst}      |
|                   then   |
|                       _e |
| in_addr[${#_ein_addr[@]} |
| ]=${_ein_tst}            |
|                   fi     |
|         done             |
|             fi           |
|         done             |
|         unique_lines _ei |
| n_addr _ein_addr     # S |
| crub duplicates.         |
|         edit_exact chk_a |
| ddress _ein_addr     # S |
| crub pending detail.     |
|         edit_exact known |
| _address _ein_addr   # S |
| crub already detailed.   |
|      if [ ${#_ein_addr[@ |
| ]} -gt 0 ]        # Anyt |
| hing new?                |
|      then                |
|        uc_address=( ${uc |
| _address[@]} ${_ein_addr |
| [@]} )                   |
|        pend_func expand_ |
| input_address ${1}       |
|        _trace_log[${#_tr |
| ace_log[@]}]='#Add '${#_ |
| ein_addr[@]}' unchkd add |
| r inp.#'                 |
|         fi               |
|         edit_exact chk_n |
| ame uc_name          # S |
| crub pending detail.     |
|         edit_exact known |
| _name uc_name        # S |
| crub already detailed.   |
|         if [ ${#uc_name[ |
| @]} -gt 0 ]              |
|         then             |
|             chk_name=( $ |
| {chk_name[@]} ${uc_name[ |
| @]}  )                   |
|             pend_func de |
| tail_each_name ${1}      |
|         fi               |
|         unset uc_name[@] |
|         return 0         |
|     }                    |
|                          |
|     # For each address i |
| n uc_address:            |
|     #     Move address t |
| o chk_address.           |
|     #     Add names to u |
| c_name.                  |
|     #     Pend expand_in |
| put_name.                |
|     #     Repeat until n |
| othing new found.        |
|     # expand_input_addre |
| ss <indirection_limit>   |
|     expand_input_address |
| () {                     |
|         [ ${#uc_address[ |
| @]} -gt 0 ] || return 0  |
|         local -a _eia_ad |
| dr                       |
|         local -a _eia_na |
| me                       |
|         local -a _eia_ne |
| w                        |
|         local -i _uca_cn |
| t                        |
|         local -i _eia_cn |
| t                        |
|         local _eia_tst   |
|         unique_lines uc_ |
| address _eia_addr        |
|         unset uc_address |
| [@]                      |
|         edit_exact been_ |
| there_addr _eia_addr     |
|         _uca_cnt=${#_eia |
| _addr[@]}                |
|         [ ${_uca_cnt} -g |
| t 0 ] &&                 |
|             been_there_a |
| ddr=( ${been_there_addr[ |
| @]} ${_eia_addr[@]} )    |
|                          |
|         for (( _eia = 0  |
| ; _eia < _uca_cnt ; _eia |
| ++ ))                    |
|          do              |
|            if short_rev  |
| ${_eia_addr[${_eia}]} _e |
| ia_new                   |
|            then          |
|              for (( _eia |
| _cnt = 0 ; _eia_cnt < ${ |
| #_eia_new[@]} ; _eia_cnt |
| ++ ))                    |
|              do          |
|                _eia_tst= |
| ${_eia_new[${_eia_cnt}]} |
|                if _eia_t |
| st=$(name_fixup ${_eia_t |
| st})                     |
|                then      |
|                  _eia_na |
| me[${#_eia_name[@]}]=${_ |
| eia_tst}                 |
|            fi            |
|          done            |
|                fi        |
|         done             |
|         unique_lines _ei |
| a_name _eia_name     # S |
| crub duplicates.         |
|         edit_exact chk_n |
| ame _eia_name        # S |
| crub pending detail.     |
|         edit_exact known |
| _name _eia_name      # S |
| crub already detailed.   |
|      if [ ${#_eia_name[@ |
| ]} -gt 0 ]        # Anyt |
| hing new?                |
|      then                |
|        uc_name=( ${uc_na |
| me[@]} ${_eia_name[@]} ) |
|        pend_func expand_ |
| input_name ${1}          |
|        _trace_log[${#_tr |
| ace_log[@]}]='#Add '${#_ |
| eia_name[@]}' unchkd nam |
| e inp.#'                 |
|         fi               |
|         edit_exact chk_a |
| ddress _eia_addr     # S |
| crub pending detail.     |
|         edit_exact known |
| _address _eia_addr   # S |
| crub already detailed.   |
|         if [ ${#_eia_add |
| r[@]} -gt 0 ]        # A |
| nything new?             |
|         then             |
|             chk_address= |
| ( ${chk_address[@]} ${_e |
| ia_addr[@]} )            |
|             pend_func de |
| tail_each_address ${1}   |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # The parse-it-yours |
| elf zone reply.          |
|     # The input is the c |
| hk_name list.            |
|     # detail_each_name < |
| indirection_limit>       |
|     detail_each_name() { |
|         [ ${#chk_name[@] |
| } -gt 0 ] || return 0    |
|         local -a _den_ch |
| k       # Names to check |
|         local -a _den_na |
| me      # Names found he |
| re                       |
|         local -a _den_ad |
| dress   # Addresses foun |
| d here                   |
|         local -a _den_pa |
| ir      # Pairs found he |
| re                       |
|         local -a _den_re |
| v       # Reverse pairs  |
| found here               |
|         local -a _den_tm |
| p       # Line being par |
| sed                      |
|         local -a _den_au |
| th      # SOA contact be |
| ing parsed               |
|         local -a _den_ne |
| w       # The zone reply |
|         local -a _den_pc |
|         # Parent-Child g |
| ets big fast             |
|         local -a _den_re |
| f       # So does refere |
| nce chain                |
|         local -a _den_nr |
|         # Name-Resource  |
| can be big               |
|         local -a _den_na |
|         # Name-Address   |
|         local -a _den_ns |
|         # Name-Service   |
|         local -a _den_ac |
| hn      # Chain of Autho |
| rity                     |
|         local -i _den_cn |
| t       # Count of names |
|  to detail               |
|         local -i _den_lm |
| t       # Indirection li |
| mit                      |
|         local _den_who   |
|         # Named being pr |
| ocessed                  |
|         local _den_rec   |
|         # Record type be |
| ing processed            |
|         local _den_cont  |
|         # Contact domain |
|         local _den_str   |
|         # Fixed up name  |
| string                   |
|         local _den_str2  |
|         # Fixed up rever |
| se                       |
|         local IFS=${WSP_ |
| IFS}                     |
|                          |
|         # Local, unique  |
| copy of names to check   |
|         unique_lines chk |
| _name _den_chk           |
|         unset chk_name[@ |
| ]       # Done with glob |
| als.                     |
|                          |
|         # Less any names |
|  already known           |
|         edit_exact known |
| _name _den_chk           |
|         _den_cnt=${#_den |
| _chk[@]}                 |
|                          |
|         # If anything le |
| ft, add to known_name.   |
|         [ ${_den_cnt} -g |
| t 0 ] &&                 |
|             known_name=( |
|  ${known_name[@]} ${_den |
| _chk[@]} )               |
|                          |
|         # for the list o |
| f (previously) unknown n |
| ames . . .               |
|         for (( _den = 0  |
| ; _den < _den_cnt ; _den |
| ++ ))                    |
|         do               |
|             _den_who=${_ |
| den_chk[${_den}]}        |
|             if long_fwd  |
| ${_den_who} _den_new     |
|             then         |
|                 unique_l |
| ines _den_new _den_new   |
|                 if [ ${# |
| _den_new[@]} -eq 0 ]     |
|                 then     |
|                     _den |
| _pair[${#_den_pair[@]}]= |
| '0.0.0.0 '${_den_who}    |
|                 fi       |
|                          |
|                 # Parse  |
| each line in the reply.  |
|                 for (( _ |
| line = 0 ; _line < ${#_d |
| en_new[@]} ; _line++ ))  |
|                 do       |
|                     IFS= |
| ${NO_WSP}$'\x09'$'\x20'  |
|                     _den |
| _tmp=( ${_den_new[${_lin |
| e}]} )                   |
|                     IFS= |
| ${WSP_IFS}               |
|                   # If u |
| sable record and not a w |
| arning message . . .     |
|                   if [ $ |
| {#_den_tmp[@]} -gt 4 ] & |
| & [ 'x'${_den_tmp[0]} != |
|  'x;;' ]                 |
|                   then   |
|                          |
| _den_rec=${_den_tmp[3]}  |
|                          |
| _den_nr[${#_den_nr[@]}]= |
| ${_den_who}' '${_den_rec |
| }                        |
|                          |
| # Begin at RFC1033 (+++) |
|                          |
| case ${_den_rec} in      |
|                          |
|     #<name> [<ttl>]  [<c |
| lass>] SOA <origin> <per |
| son>                     |
|                          |
| SOA) # Start Of Authorit |
| y                        |
|         if _den_str=$(na |
| me_fixup ${_den_tmp[0]}) |
|         then             |
|           _den_name[${#_ |
| den_name[@]}]=${_den_str |
| }                        |
|           _den_achn[${#_ |
| den_achn[@]}]=${_den_who |
| }' '${_den_str}' SOA'    |
|           # SOA origin - |
| - domain name of master  |
| zone record              |
|           if _den_str2=$ |
| (name_fixup ${_den_tmp[4 |
| ]})                      |
|           then           |
|             _den_name[${ |
| #_den_name[@]}]=${_den_s |
| tr2}                     |
|             _den_achn[${ |
| #_den_achn[@]}]=${_den_w |
| ho}' '${_den_str2}' SOA. |
| O'                       |
|           fi             |
|           # Responsible  |
| party e-mail address (po |
| ssibly bogus).           |
|           # Possibility  |
| of first.last@domain.nam |
| e ignored.               |
|           set -f         |
|           if _den_str2=$ |
| (name_fixup ${_den_tmp[5 |
| ]})                      |
|           then           |
|             IFS=${ADR_IF |
| S}                       |
|             _den_auth=(  |
| ${_den_str2} )           |
|             IFS=${WSP_IF |
| S}                       |
|             if [ ${#_den |
| _auth[@]} -gt 2 ]        |
|             then         |
|               _den_cont= |
| ${_den_auth[1]}          |
|               for (( _au |
| th = 2 ; _auth < ${#_den |
| _auth[@]} ; _auth++ ))   |
|               do         |
|                 _den_con |
| t=${_den_cont}'.'${_den_ |
| auth[${_auth}]}          |
|               done       |
|               _den_name[ |
| ${#_den_name[@]}]=${_den |
| _cont}'.'                |
|               _den_achn[ |
| ${#_den_achn[@]}]=${_den |
| _who}' '${_den_cont}'. S |
| OA.C'                    |
|                          |
|             fi           |
|             fi           |
|             set +f       |
|                          |
|     fi                   |
|                          |
| ;;                       |
|                          |
|                          |
|           A) # IP(v4) Ad |
| dress Record             |
|           if _den_str=$( |
| name_fixup ${_den_tmp[0] |
| })                       |
|           then           |
|             _den_name[${ |
| #_den_name[@]}]=${_den_s |
| tr}                      |
|             _den_pair[${ |
| #_den_pair[@]}]=${_den_t |
| mp[4]}' '${_den_str}     |
|             _den_na[${#_ |
| den_na[@]}]=${_den_str}' |
|  '${_den_tmp[4]}         |
|             _den_ref[${# |
| _den_ref[@]}]=${_den_who |
| }' '${_den_str}' A'      |
|           else           |
|             _den_pair[${ |
| #_den_pair[@]}]=${_den_t |
| mp[4]}' unknown.domain'  |
|             _den_na[${#_ |
| den_na[@]}]='unknown.dom |
| ain '${_den_tmp[4]}      |
|             _den_ref[${# |
| _den_ref[@]}]=${_den_who |
| }' unknown.domain A'     |
|           fi             |
|           _den_address[$ |
| {#_den_address[@]}]=${_d |
| en_tmp[4]}               |
|           _den_pc[${#_de |
| n_pc[@]}]=${_den_who}' ' |
| ${_den_tmp[4]}           |
|                  ;;      |
|                          |
|                  NS) # N |
| ame Server Record        |
|                  # Domai |
| n name being serviced (m |
| ay be other than current |
| )                        |
|                    if _d |
| en_str=$(name_fixup ${_d |
| en_tmp[0]})              |
|                      the |
| n                        |
|                        _ |
| den_name[${#_den_name[@] |
| }]=${_den_str}           |
|                        _ |
| den_ref[${#_den_ref[@]}] |
| =${_den_who}' '${_den_st |
| r}' NS'                  |
|                          |
|                  # Domai |
| n name of service provid |
| er                       |
|                  if _den |
| _str2=$(name_fixup ${_de |
| n_tmp[4]})               |
|                  then    |
|                    _den_ |
| name[${#_den_name[@]}]=$ |
| {_den_str2}              |
|                    _den_ |
| ref[${#_den_ref[@]}]=${_ |
| den_who}' '${_den_str2}' |
|  NSH'                    |
|                    _den_ |
| ns[${#_den_ns[@]}]=${_de |
| n_str2}' NS'             |
|                    _den_ |
| pc[${#_den_pc[@]}]=${_de |
| n_str}' '${_den_str2}    |
|                   fi     |
|                    fi    |
|                          |
| ;;                       |
|                          |
|                  MX) # M |
| ail Server Record        |
|                      # D |
| omain name being service |
| d (wildcards not handled |
|  here)                   |
|                  if _den |
| _str=$(name_fixup ${_den |
| _tmp[0]})                |
|                  then    |
|                    _den_ |
| name[${#_den_name[@]}]=$ |
| {_den_str}               |
|                    _den_ |
| ref[${#_den_ref[@]}]=${_ |
| den_who}' '${_den_str}'  |
| MX'                      |
|                  fi      |
|                  # Domai |
| n name of service provid |
| er                       |
|                  if _den |
| _str=$(name_fixup ${_den |
| _tmp[5]})                |
|                  then    |
|                    _den_ |
| name[${#_den_name[@]}]=$ |
| {_den_str}               |
|                    _den_ |
| ref[${#_den_ref[@]}]=${_ |
| den_who}' '${_den_str}'  |
| MXH'                     |
|                    _den_ |
| ns[${#_den_ns[@]}]=${_de |
| n_str}' MX'              |
|                    _den_ |
| pc[${#_den_pc[@]}]=${_de |
| n_who}' '${_den_str}     |
|                  fi      |
|                          |
| ;;                       |
|                          |
|                  PTR) #  |
| Reverse address record   |
|                       #  |
| Special name             |
|                  if _den |
| _str=$(name_fixup ${_den |
| _tmp[0]})                |
|                  then    |
|                    _den_ |
| ref[${#_den_ref[@]}]=${_ |
| den_who}' '${_den_str}'  |
| PTR'                     |
|                    # Hos |
| t name (not a CNAME)     |
|                    if _d |
| en_str2=$(name_fixup ${_ |
| den_tmp[4]})             |
|                    then  |
|                      _de |
| n_rev[${#_den_rev[@]}]=$ |
| {_den_str}' '${_den_str2 |
| }                        |
|                      _de |
| n_ref[${#_den_ref[@]}]=$ |
| {_den_who}' '${_den_str2 |
| }' PTRH'                 |
|                      _de |
| n_pc[${#_den_pc[@]}]=${_ |
| den_who}' '${_den_str}   |
|                    fi    |
|                  fi      |
|                          |
| ;;                       |
|                          |
|                  AAAA) # |
|  IP(v6) Address Record   |
|                  if _den |
| _str=$(name_fixup ${_den |
| _tmp[0]})                |
|                  then    |
|                    _den_ |
| name[${#_den_name[@]}]=$ |
| {_den_str}               |
|                    _den_ |
| pair[${#_den_pair[@]}]=$ |
| {_den_tmp[4]}' '${_den_s |
| tr}                      |
|                    _den_ |
| na[${#_den_na[@]}]=${_de |
| n_str}' '${_den_tmp[4]}  |
|                    _den_ |
| ref[${#_den_ref[@]}]=${_ |
| den_who}' '${_den_str}'  |
| AAAA'                    |
|                    else  |
|                      _de |
| n_pair[${#_den_pair[@]}] |
| =${_den_tmp[4]}' unknown |
| .domain'                 |
|                      _de |
| n_na[${#_den_na[@]}]='un |
| known.domain '${_den_tmp |
| [4]}                     |
|                      _de |
| n_ref[${#_den_ref[@]}]=$ |
| {_den_who}' unknown.doma |
| in'                      |
|                    fi    |
|                    # No  |
| processing for IPv6 addr |
| esses                    |
|                    _den_ |
| pc[${#_den_pc[@]}]=${_de |
| n_who}' '${_den_tmp[4]}  |
|                          |
| ;;                       |
|                          |
|                  CNAME)  |
| # Alias name record      |
|                          |
| # Nickname               |
|                  if _den |
| _str=$(name_fixup ${_den |
| _tmp[0]})                |
|                  then    |
|                    _den_ |
| name[${#_den_name[@]}]=$ |
| {_den_str}               |
|                    _den_ |
| ref[${#_den_ref[@]}]=${_ |
| den_who}' '${_den_str}'  |
| CNAME'                   |
|                    _den_ |
| pc[${#_den_pc[@]}]=${_de |
| n_who}' '${_den_str}     |
|                  fi      |
|                          |
| # Hostname               |
|                  if _den |
| _str=$(name_fixup ${_den |
| _tmp[4]})                |
|                  then    |
|                    _den_ |
| name[${#_den_name[@]}]=$ |
| {_den_str}               |
|                    _den_ |
| ref[${#_den_ref[@]}]=${_ |
| den_who}' '${_den_str}'  |
| CHOST'                   |
|                    _den_ |
| pc[${#_den_pc[@]}]=${_de |
| n_who}' '${_den_str}     |
|                  fi      |
|                          |
| ;;                       |
|     #            TXT)    |
|     #            ;;      |
|                          |
| esac                     |
|                     fi   |
|                 done     |
|             else # Looku |
| p error == 'A' record 'u |
| nknown address'          |
|                 _den_pai |
| r[${#_den_pair[@]}]='0.0 |
| .0.0 '${_den_who}        |
|             fi           |
|         done             |
|                          |
|         # Control dot ar |
| ray growth.              |
|         unique_lines _de |
| n_achn _den_achn      #  |
| Works best, all the same |
| .                        |
|         edit_exact auth_ |
| chain _den_achn       #  |
| Works best, unique items |
| .                        |
|         if [ ${#_den_ach |
| n[@]} -gt 0 ]            |
|         then             |
|             IFS=${NO_WSP |
| }                        |
|             auth_chain=( |
|  ${auth_chain[@]} ${_den |
| _achn[@]} )              |
|             IFS=${WSP_IF |
| S}                       |
|         fi               |
|                          |
|         unique_lines _de |
| n_ref _den_ref      # Wo |
| rks best, all the same.  |
|         edit_exact ref_c |
| hain _den_ref       # Wo |
| rks best, unique items.  |
|         if [ ${#_den_ref |
| [@]} -gt 0 ]             |
|         then             |
|             IFS=${NO_WSP |
| }                        |
|             ref_chain=(  |
| ${ref_chain[@]} ${_den_r |
| ef[@]} )                 |
|             IFS=${WSP_IF |
| S}                       |
|         fi               |
|                          |
|         unique_lines _de |
| n_na _den_na             |
|         edit_exact name_ |
| address _den_na          |
|         if [ ${#_den_na[ |
| @]} -gt 0 ]              |
|         then             |
|             IFS=${NO_WSP |
| }                        |
|             name_address |
| =( ${name_address[@]} ${ |
| _den_na[@]} )            |
|             IFS=${WSP_IF |
| S}                       |
|         fi               |
|                          |
|         unique_lines _de |
| n_ns _den_ns             |
|         edit_exact name_ |
| srvc _den_ns             |
|         if [ ${#_den_ns[ |
| @]} -gt 0 ]              |
|         then             |
|             IFS=${NO_WSP |
| }                        |
|             name_srvc=(  |
| ${name_srvc[@]} ${_den_n |
| s[@]} )                  |
|             IFS=${WSP_IF |
| S}                       |
|         fi               |
|                          |
|         unique_lines _de |
| n_nr _den_nr             |
|         edit_exact name_ |
| resource _den_nr         |
|         if [ ${#_den_nr[ |
| @]} -gt 0 ]              |
|         then             |
|             IFS=${NO_WSP |
| }                        |
|             name_resourc |
| e=( ${name_resource[@]}  |
| ${_den_nr[@]} )          |
|             IFS=${WSP_IF |
| S}                       |
|         fi               |
|                          |
|         unique_lines _de |
| n_pc _den_pc             |
|         edit_exact paren |
| t_child _den_pc          |
|         if [ ${#_den_pc[ |
| @]} -gt 0 ]              |
|         then             |
|             IFS=${NO_WSP |
| }                        |
|             parent_child |
| =( ${parent_child[@]} ${ |
| _den_pc[@]} )            |
|             IFS=${WSP_IF |
| S}                       |
|         fi               |
|                          |
|         # Update list kn |
| own_pair (Address and Na |
| me).                     |
|         unique_lines _de |
| n_pair _den_pair         |
|         edit_exact known |
| _pair _den_pair          |
|         if [ ${#_den_pai |
| r[@]} -gt 0 ]  # Anythin |
| g new?                   |
|         then             |
|             IFS=${NO_WSP |
| }                        |
|             known_pair=( |
|  ${known_pair[@]} ${_den |
| _pair[@]} )              |
|             IFS=${WSP_IF |
| S}                       |
|         fi               |
|                          |
|         # Update list of |
|  reverse pairs.          |
|         unique_lines _de |
| n_rev _den_rev           |
|         edit_exact rever |
| se_pair _den_rev         |
|         if [ ${#_den_rev |
| [@]} -gt 0 ]   # Anythin |
| g new?                   |
|         then             |
|             IFS=${NO_WSP |
| }                        |
|             reverse_pair |
| =( ${reverse_pair[@]} ${ |
| _den_rev[@]} )           |
|             IFS=${WSP_IF |
| S}                       |
|         fi               |
|                          |
|         # Check indirect |
| ion limit -- give up if  |
| reached.                 |
|         if ! _den_lmt=$( |
| limit_chk ${1})          |
|         then             |
|             return 0     |
|         fi               |
|                          |
|     # Execution engine i |
| s LIFO. Order of pend op |
| erations is important.   |
|     # Did we define any  |
| new addresses?           |
|     unique_lines _den_ad |
| dress _den_address    #  |
| Scrub duplicates.        |
|     edit_exact known_add |
| ress _den_address     #  |
| Scrub already processed. |
|     edit_exact un_addres |
| s _den_address        #  |
| Scrub already waiting.   |
|     if [ ${#_den_address |
| [@]} -gt 0 ]          #  |
| Anything new?            |
|     then                 |
|       uc_address=( ${uc_ |
| address[@]} ${_den_addre |
| ss[@]} )                 |
|       pend_func expand_i |
| nput_address ${_den_lmt} |
|       _trace_log[${#_tra |
| ce_log[@]}]='# Add '${#_ |
| den_address[@]}' unchkd  |
| addr. #'                 |
|         fi               |
|                          |
|     # Did we find any ne |
| w names?                 |
|     unique_lines _den_na |
| me _den_name          #  |
| Scrub duplicates.        |
|     edit_exact known_nam |
| e _den_name           #  |
| Scrub already processed. |
|     edit_exact uc_name _ |
| den_name              #  |
| Scrub already waiting.   |
|     if [ ${#_den_name[@] |
| } -gt 0 ]             #  |
| Anything new?            |
|     then                 |
|       uc_name=( ${uc_nam |
| e[@]} ${_den_name[@]} )  |
|       pend_func expand_i |
| nput_name ${_den_lmt}    |
|       _trace_log[${#_tra |
| ce_log[@]}]='#Added '${# |
| _den_name[@]}' unchkd na |
| me#'                     |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # The parse-it-yours |
| elf delegation reply     |
|     # Input is the chk_a |
| ddress list.             |
|     # detail_each_addres |
| s <indirection_limit>    |
|     detail_each_address( |
| ) {                      |
|         [ ${#chk_address |
| [@]} -gt 0 ] || return 0 |
|         unique_lines chk |
| _address chk_address     |
|         edit_exact known |
| _address chk_address     |
|         if [ ${#chk_addr |
| ess[@]} -gt 0 ]          |
|         then             |
|             known_addres |
| s=( ${known_address[@]}  |
| ${chk_address[@]} )      |
|             unset chk_ad |
| dress[@]                 |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # # # Application sp |
| ecific output functions  |
| # # #                    |
|                          |
|     # Pretty print the k |
| nown pairs.              |
|     report_pairs() {     |
|         echo             |
|         echo 'Known netw |
| ork pairs.'              |
|         col_print known_ |
| pair 2 5 30              |
|                          |
|         if [ ${#auth_cha |
| in[@]} -gt 0 ]           |
|         then             |
|             echo         |
|             echo 'Known  |
| chain of authority.'     |
|             col_print au |
| th_chain 2 5 30 55       |
|         fi               |
|                          |
|         if [ ${#reverse_ |
| pair[@]} -gt 0 ]         |
|         then             |
|             echo         |
|             echo 'Known  |
| reverse pairs.'          |
|             col_print re |
| verse_pair 2 5 55        |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # Check an address a |
| gainst the list of black |
| list servers.            |
|     # A good place to ca |
| pture for GraphViz: addr |
| ess->status(server(repor |
| ts))                     |
|     # check_lists <ip_ad |
| dress>                   |
|     check_lists() {      |
|         [ $# -eq 1 ] ||  |
| return 1                 |
|         local -a _cl_fwd |
| _addr                    |
|         local -a _cl_rev |
| _addr                    |
|         local -a _cl_rep |
| ly                       |
|         local -i _cl_rc  |
|         local -i _ls_cnt |
|         local _cl_dns_ad |
| dr                       |
|         local _cl_lkup   |
|                          |
|         split_ip ${1} _c |
| l_fwd_addr _cl_rev_addr  |
|         _cl_dns_addr=$(d |
| ot_array _cl_rev_addr)'. |
| '                        |
|         _ls_cnt=${#list_ |
| server[@]}               |
|         echo '    Checki |
| ng address '${1}         |
|         for (( _cl = 0 ; |
|  _cl < _ls_cnt ; _cl++ ) |
| )                        |
|         do               |
|           _cl_lkup=${_cl |
| _dns_addr}${list_server[ |
| ${_cl}]}                 |
|           if short_text  |
| ${_cl_lkup} _cl_reply    |
|           then           |
|             if [ ${#_cl_ |
| reply[@]} -gt 0 ]        |
|             then         |
|               echo '     |
|     Records from '${list |
| _server[${_cl}]}         |
|               address_hi |
| ts[${#address_hits[@]}]= |
| ${1}' '${list_server[${_ |
| cl}]}                    |
|               _hs_RC=2   |
|               for (( _cl |
| r = 0 ; _clr < ${#_cl_re |
| ply[@]} ; _clr++ ))      |
|               do         |
|                 echo '   |
|           '${_cl_reply[$ |
| {_clr}]}                 |
|               done       |
|             fi           |
|           fi             |
|         done             |
|         return 0         |
|     }                    |
|                          |
|     # # # The usual appl |
| ication glue # # #       |
|                          |
|     # Who did it?        |
|     credits() {          |
|        echo              |
|        echo 'Advanced Ba |
| sh Scripting Guide: is_s |
| pammer.bash, v2, 2004-ms |
| z'                       |
|     }                    |
|                          |
|     # How to use it?     |
|     # (See also, "Quicks |
| tart" at end of script.) |
|     usage() {            |
|         cat <<-'_usage_s |
| tatement_'               |
|         The script is_sp |
| ammer.bash requires eith |
| er one or two arguments. |
|                          |
|         arg 1) May be on |
| e of:                    |
|             a) A domain  |
| name                     |
|             b) An IPv4 a |
| ddress                   |
|             c) The name  |
| of a file with any mix o |
| f names                  |
|                and addre |
| sses, one per line.      |
|                          |
|         arg 2) May be on |
| e of:                    |
|             a) A Blackli |
| st server domain name    |
|             b) The name  |
| of a file with Blacklist |
|  server                  |
|                domain na |
| mes, one per line.       |
|             c) If not pr |
| esent, a default list of |
|  (free)                  |
|                Blacklist |
|  servers is used.        |
|             d) If a file |
| name of an empty, readab |
| le, file                 |
|                is given, |
|                Blacklist |
|  server lookup is disabl |
| ed.                      |
|                          |
|         All script outpu |
| t is written to stdout.  |
|                          |
|         Return codes: 0  |
| -> All OK, 1 -> Script f |
| ailure,                  |
|                       2  |
| -> Something is Blacklis |
| ted.                     |
|                          |
|         Requires the ext |
| ernal program 'dig' from |
|  the 'bind-9'            |
|         set of DNS progr |
| ams.  See: http://www.is |
| c.org                    |
|                          |
|         The domain name  |
| lookup depth limit defau |
| lts to 2 levels.         |
|         Set the environm |
| ent variable SPAMMER_LIM |
| IT to change.            |
|         SPAMMER_LIMIT=0  |
| means 'unlimited'        |
|                          |
|         Limit may also b |
| e set on the command-lin |
| e.                       |
|         If arg#1 is an i |
| nteger, the limit is set |
|  to that value           |
|         and then the abo |
| ve argument rules are ap |
| plied.                   |
|                          |
|         Setting the envi |
| ronment variable 'SPAMME |
| R_DATA' to a filename    |
|         will cause the s |
| cript to write a GraphVi |
| z graphic file.          |
|                          |
|         For the developm |
| ent version;             |
|         Setting the envi |
| ronment variable 'SPAMME |
| R_TRACE' to a filename   |
|         will cause the e |
| xecution engine to log a |
|  function call trace.    |
|                          |
|     _usage_statement_    |
|     }                    |
|                          |
|     # The default list o |
| f Blacklist servers:     |
|     # Many choices, see: |
|  http://www.spews.org/li |
| sts.html                 |
|                          |
|     declare -a default_s |
| ervers                   |
|     # See: http://www.sp |
| amhaus.org (Conservative |
| , well maintained)       |
|     default_servers[0]=' |
| sbl-xbl.spamhaus.org'    |
|     # See: http://ordb.o |
| rg (Open mail relays)    |
|     default_servers[1]=' |
| relays.ordb.org'         |
|     # See: http://www.sp |
| amcop.net/ (You can repo |
| rt spammers here)        |
|     default_servers[2]=' |
| bl.spamcop.net'          |
|     # See: http://www.sp |
| ews.org (An 'early detec |
| t' system)               |
|     default_servers[3]=' |
| l2.spews.dnsbl.sorbs.net |
| '                        |
|     # See: http://www.dn |
| sbl.us.sorbs.net/using.s |
| html                     |
|     default_servers[4]=' |
| dnsbl.sorbs.net'         |
|     # See: http://dsbl.o |
| rg/usage (Various mail r |
| elay lists)              |
|     default_servers[5]=' |
| list.dsbl.org'           |
|     default_servers[6]=' |
| multihop.dsbl.org'       |
|     default_servers[7]=' |
| unconfirmed.dsbl.org'    |
|                          |
|     # User input argumen |
| t #1                     |
|     setup_input() {      |
|         if [ -e ${1} ] & |
| & [ -r ${1} ]  # Name of |
|  readable file           |
|         then             |
|             file_to_arra |
| y ${1} uc_name           |
|             echo 'Using  |
| filename >'${1}'< as inp |
| ut.'                     |
|         else             |
|             if is_addres |
| s ${1}          # IP add |
| ress?                    |
|             then         |
|                 uc_addre |
| ss=( ${1} )              |
|                 echo 'St |
| arting with address >'${ |
| 1}'<'                    |
|             else         |
|                # Must be |
|  a name.                 |
|                 uc_name= |
| ( ${1} )                 |
|                 echo 'St |
| arting with domain name  |
| >'${1}'<'                |
|             fi           |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # User input argumen |
| t #2                     |
|     setup_servers() {    |
|         if [ -e ${1} ] & |
| & [ -r ${1} ]  # Name of |
|  a readable file         |
|         then             |
|             file_to_arra |
| y ${1} list_server       |
|             echo 'Using  |
| filename >'${1}'< as bla |
| cklist server list.'     |
|         else             |
|             list_server= |
| ( ${1} )                 |
|             echo 'Using  |
| blacklist server >'${1}' |
| <'                       |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # User environment v |
| ariable SPAMMER_TRACE    |
|     live_log_die() {     |
|         if [ ${SPAMMER_T |
| RACE:=} ]    # Wants tra |
| ce log?                  |
|         then             |
|             if [ ! -e ${ |
| SPAMMER_TRACE} ]         |
|             then         |
|                 if ! tou |
| ch ${SPAMMER_TRACE} 2>/d |
| ev/null                  |
|                 then     |
|                     pend |
| _func echo $(printf '%q\ |
| n' \                     |
|                     'Una |
| ble to create log file > |
| '${SPAMMER_TRACE}'<')    |
|                     pend |
| _release                 |
|                     exit |
|  1                       |
|                 fi       |
|                 _log_fil |
| e=${SPAMMER_TRACE}       |
|                 _pend_ho |
| ok_=trace_logger         |
|                 _log_dum |
| p=dump_log               |
|             else         |
|                 if [ ! - |
| w ${SPAMMER_TRACE} ]     |
|                 then     |
|                     pend |
| _func echo $(printf '%q\ |
| n' \                     |
|                     'Una |
| ble to write log file >' |
| ${SPAMMER_TRACE}'<')     |
|                     pend |
| _release                 |
|                     exit |
|  1                       |
|                 fi       |
|                 _log_fil |
| e=${SPAMMER_TRACE}       |
|                 echo ''  |
| > ${_log_file}           |
|                 _pend_ho |
| ok_=trace_logger         |
|                 _log_dum |
| p=dump_log               |
|             fi           |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # User environment v |
| ariable SPAMMER_DATA     |
|     data_capture() {     |
|         if [ ${SPAMMER_D |
| ATA:=} ]    # Wants a da |
| ta dump?                 |
|         then             |
|             if [ ! -e ${ |
| SPAMMER_DATA} ]          |
|             then         |
|                 if ! tou |
| ch ${SPAMMER_DATA} 2>/de |
| v/null                   |
|                 then     |
|                     pend |
| _func echo $(printf '%q] |
| n' \                     |
|                     'Una |
| ble to create data outpu |
| t file >'${SPAMMER_DATA} |
| '<')                     |
|                     pend |
| _release                 |
|                     exit |
|  1                       |
|                 fi       |
|                 _dot_fil |
| e=${SPAMMER_DATA}        |
|                 _dot_dum |
| p=dump_dot               |
|             else         |
|                 if [ ! - |
| w ${SPAMMER_DATA} ]      |
|                 then     |
|                     pend |
| _func echo $(printf '%q\ |
| n' \                     |
|                     'Una |
| ble to write data output |
|  file >'${SPAMMER_DATA}' |
| <')                      |
|                     pend |
| _release                 |
|                     exit |
|  1                       |
|                 fi       |
|                 _dot_fil |
| e=${SPAMMER_DATA}        |
|                 _dot_dum |
| p=dump_dot               |
|             fi           |
|         fi               |
|         return 0         |
|     }                    |
|                          |
|     # Grope user specifi |
| ed arguments.            |
|     do_user_args() {     |
|         if [ $# -gt 0 ]  |
| && is_number $1          |
|         then             |
|             indirect=$1  |
|             shift        |
|         fi               |
|                          |
|         case $# in       |
|                # Did use |
| r treat us well?         |
|             1)           |
|                 if ! set |
| up_input $1    # Needs e |
| rror checking.           |
|                 then     |
|                     pend |
| _release                 |
|                     $_lo |
| g_dump                   |
|                     exit |
|  1                       |
|                 fi       |
|                 list_ser |
| ver=( ${default_servers[ |
| @]} )                    |
|                 _list_cn |
| t=${#list_server[@]}     |
|                 echo 'Us |
| ing default blacklist se |
| rver list.'              |
|                 echo 'Se |
| arch depth limit: '${ind |
| irect}                   |
|                 ;;       |
|             2)           |
|                 if ! set |
| up_input $1    # Needs e |
| rror checking.           |
|                 then     |
|                     pend |
| _release                 |
|                     $_lo |
| g_dump                   |
|                     exit |
|  1                       |
|                 fi       |
|                 if ! set |
| up_servers $2  # Needs e |
| rror checking.           |
|                 then     |
|                     pend |
| _release                 |
|                     $_lo |
| g_dump                   |
|                     exit |
|  1                       |
|                 fi       |
|                 echo 'Se |
| arch depth limit: '${ind |
| irect}                   |
|                 ;;       |
|             *)           |
|                 pend_fun |
| c usage                  |
|                 pend_rel |
| ease                     |
|                 $_log_du |
| mp                       |
|                 exit 1   |
|                 ;;       |
|         esac             |
|         return 0         |
|     }                    |
|                          |
|     # A general purpose  |
| debug tool.              |
|     # list_array <array_ |
| name>                    |
|     list_array() {       |
|         [ $# -eq 1 ] ||  |
| return 1  # One argument |
|  required.               |
|                          |
|         local -a _la_lin |
| es                       |
|         set -f           |
|         local IFS=${NO_W |
| SP}                      |
|         eval _la_lines=\ |
| (\ \$\{$1\[@\]\}\ \)     |
|         echo             |
|         echo "Element co |
| unt "${#_la_lines[@]}" a |
| rray "${1}               |
|         local _ln_cnt=${ |
| #_la_lines[@]}           |
|                          |
|         for (( _i = 0; _ |
| i < ${_ln_cnt}; _i++ ))  |
|         do               |
|             echo 'Elemen |
| t '$_i' >'${_la_lines[$_ |
| i]}'<'                   |
|         done             |
|         set +f           |
|         return 0         |
|     }                    |
|                          |
|     # # # 'Hunt the Spam |
| mer' program code # # #  |
|     pend_init            |
|                     # Re |
| ady stack engine.        |
|     pend_func credits    |
|                     # La |
| st thing to print.       |
|                          |
|     # # # Deal with user |
|  # # #                   |
|     live_log_die         |
|                     # Se |
| tup debug trace log.     |
|     data_capture         |
|                     # Se |
| tup data capture file.   |
|     echo                 |
|     do_user_args $@      |
|                          |
|     # # # Haven't exited |
|  yet - There is some hop |
| e # # #                  |
|     # Discovery group -  |
| Execution engine is LIFO |
|  - pend                  |
|     # in reverse order o |
| f execution.             |
|     _hs_RC=0             |
|                     # Hu |
| nt the Spammer return co |
| de                       |
|     pend_mark            |
|         pend_func report |
| _pairs              # Re |
| port name-address pairs. |
|                          |
|         # The two detail |
| _* are mutually recursiv |
| e functions.             |
|         # They also pend |
|  expand_* functions as r |
| equired.                 |
|         # These two (the |
|  last of ???) exit the r |
| ecursion.                |
|         pend_func detail |
| _each_address       # Ge |
| t all resources of addre |
| sses.                    |
|         pend_func detail |
| _each_name          # Ge |
| t all resources of names |
| .                        |
|                          |
|         #  The two expan |
| d_* are mutually recursi |
| ve functions,            |
|         #+ which pend ad |
| ditional detail_* functi |
| ons as required.         |
|         pend_func expand |
| _input_address 1    # Ex |
| pand input names by addr |
| ess.                     |
|         pend_func expand |
| _input_name 1       # #x |
| pand input addresses by  |
| name.                    |
|                          |
|         # Start with a u |
| nique set of names and a |
| ddresses.                |
|         pend_func unique |
| _lines uc_address uc_add |
| ress                     |
|         pend_func unique |
| _lines uc_name uc_name   |
|                          |
|         # Separate mixed |
|  input of names and addr |
| esses.                   |
|         pend_func split_ |
| input                    |
|     pend_release         |
|                          |
|     # # # Pairs reported |
|  -- Unique list of IP ad |
| dresses found            |
|     echo                 |
|     _ip_cnt=${#known_add |
| ress[@]}                 |
|     if [ ${#list_server[ |
| @]} -eq 0 ]              |
|     then                 |
|         echo 'Blacklist  |
| server list empty, none  |
| checked.'                |
|     else                 |
|         if [ ${_ip_cnt}  |
| -eq 0 ]                  |
|         then             |
|             echo 'Known  |
| address list empty, none |
|  checked.'               |
|         else             |
|             _ip_cnt=${_i |
| p_cnt}-1   # Start at to |
| p.                       |
|             echo 'Checki |
| ng Blacklist servers.'   |
|             for (( _ip = |
|  _ip_cnt ; _ip >= 0 ; _i |
| p-- ))                   |
|             do           |
|               pend_func  |
| check_lists $( printf '% |
| q\n' ${known_address[$_i |
| p]} )                    |
|             done         |
|         fi               |
|     fi                   |
|     pend_release         |
|     $_dot_dump           |
|          # Graphics file |
|  dump                    |
|     $_log_dump           |
|          # Execution tra |
| ce                       |
|     echo                 |
|                          |
|                          |
|     #################### |
| ##########               |
|     # Example output fro |
| m script #               |
|     #################### |
| ##########               |
|     :<<-'_is_spammer_out |
| puts_'                   |
|                          |
|     ./is_spammer.bash 0  |
| web4.alojamentos7.com    |
|                          |
|     Starting with domain |
|  name >web4.alojamentos7 |
| .com<                    |
|     Using default blackl |
| ist server list.         |
|     Search depth limit:  |
| 0                        |
|     .:....::::...:::...: |
| ::.......::..::...:::... |
| ....::                   |
|     Known network pairs. |
|         66.98.208.97     |
|          web4.alojamento |
| s7.com.                  |
|         66.98.208.97     |
|          ns1.alojamentos |
| 7.com.                   |
|         69.56.202.147    |
|          ns2.alojamentos |
| .ws.                     |
|         66.98.208.97     |
|          alojamentos7.co |
| m.                       |
|         66.98.208.97     |
|          web.alojamentos |
| 7.com.                   |
|         69.56.202.146    |
|          ns1.alojamentos |
| .ws.                     |
|         69.56.202.146    |
|          alojamentos.ws. |
|         66.235.180.113   |
|          ns1.alojamentos |
| .org.                    |
|         66.235.181.192   |
|          ns2.alojamentos |
| .org.                    |
|         66.235.180.113   |
|          alojamentos.org |
| .                        |
|         66.235.180.113   |
|          web6.alojamento |
| s.org.                   |
|         216.234.234.30   |
|          ns1.theplanet.c |
| om.                      |
|         12.96.160.115    |
|          ns2.theplanet.c |
| om.                      |
|         216.185.111.52   |
|          mail1.theplanet |
| .com.                    |
|         69.56.141.4      |
|          spooling.thepla |
| net.com.                 |
|         216.185.111.40   |
|          theplanet.com.  |
|         216.185.111.40   |
|          www.theplanet.c |
| om.                      |
|         216.185.111.52   |
|          mail.theplanet. |
| com.                     |
|                          |
|     Checking Blacklist s |
| ervers.                  |
|       Checking address 6 |
| 6.98.208.97              |
|           Records from d |
| nsbl.sorbs.net           |
|       "Spam Received See |
| : http://www.dnsbl.sorbs |
| .net/lookup.shtml?66.98. |
| 208.97"                  |
|         Checking address |
|  69.56.202.147           |
|         Checking address |
|  69.56.202.146           |
|         Checking address |
|  66.235.180.113          |
|         Checking address |
|  66.235.181.192          |
|         Checking address |
|  216.185.111.40          |
|         Checking address |
|  216.234.234.30          |
|         Checking address |
|  12.96.160.115           |
|         Checking address |
|  216.185.111.52          |
|         Checking address |
|  69.56.141.4             |
|                          |
|     Advanced Bash Script |
| ing Guide: is_spammer.ba |
| sh, v2, 2004-msz         |
|                          |
|     _is_spammer_outputs_ |
|                          |
|     exit ${_hs_RC}       |
|                          |
|     #################### |
| ######################## |
| ########                 |
|     #  The script ignore |
| s everything from here o |
| n down #                 |
|     #+ because of the 'e |
| xit' command, just above |
| .      #                 |
|     #################### |
| ######################## |
| ########                 |
|                          |
|                          |
|                          |
|     Quickstart           |
|     ==========           |
|                          |
|      Prerequisites       |
|                          |
|       Bash version 2.05b |
|  or 3.00 (bash --version |
| )                        |
|       A version of Bash  |
| which supports arrays. A |
| rray                     |
|       support is include |
| d by default Bash config |
| urations.                |
|                          |
|       'dig,' version 9.x |
| .x (dig $HOSTNAME, see f |
| irst line of output)     |
|       A version of dig w |
| hich supports the +short |
|  options.                |
|       See: dig_wrappers. |
| bash for details.        |
|                          |
|                          |
|      Optional Prerequisi |
| tes                      |
|                          |
|       'named,' a local D |
| NS caching program. Any  |
| flavor will do.          |
|       Do twice: dig $HOS |
| TNAME                    |
|       Check near bottom  |
| of output for: SERVER: 1 |
| 27.0.0.1#53              |
|       That means you hav |
| e one running.           |
|                          |
|                          |
|      Optional Graphics S |
| upport                   |
|                          |
|       'date,' a standard |
|  *nix thing. (date -R)   |
|                          |
|       dot Program to con |
| vert graphic description |
|  file to a               |
|       diagram. (dot -V)  |
|       A part of the Grap |
| h-Viz set of programs.   |
|       See: [http://www.r |
| esearch.att.com/sw/tools |
| /graphviz||GraphViz]     |
|                          |
|       'dotty,' a visual  |
| editor for graphic descr |
| iption files.            |
|       Also a part of the |
|  Graph-Viz set of progra |
| ms.                      |
|                          |
|                          |
|                          |
|                          |
|      Quick Start         |
|                          |
|     In the same director |
| y as the is_spammer.bash |
|  script;                 |
|     Do: ./is_spammer.bas |
| h                        |
|                          |
|      Usage Details       |
|                          |
|     1. Blacklist server  |
| choices.                 |
|                          |
|       (a) To use default |
| , built-in list: Do noth |
| ing.                     |
|                          |
|       (b) To use your ow |
| n list:                  |
|                          |
|         i. Create a file |
|  with a single Blacklist |
|  server                  |
|            domain name p |
| er line.                 |
|                          |
|         ii. Provide that |
|  filename as the last ar |
| gument to                |
|             the script.  |
|                          |
|       (c) To use a singl |
| e Blacklist server: Last |
|  argument                |
|           to the script. |
|                          |
|       (d) To disable Bla |
| cklist lookups:          |
|                          |
|         i. Create an emp |
| ty file (touch spammer.n |
| ul)                      |
|            Your choice o |
| f filename.              |
|                          |
|         ii. Provide the  |
| filename of that empty f |
| ile as the               |
|             last argumen |
| t to the script.         |
|                          |
|     2. Search depth limi |
| t.                       |
|                          |
|       (a) To use the def |
| ault value of 2: Do noth |
| ing.                     |
|                          |
|       (b) To set a diffe |
| rent limit:              |
|           A limit of 0 m |
| eans: no limit.          |
|                          |
|         i. export SPAMME |
| R_LIMIT=1                |
|            or whatever l |
| imit you want.           |
|                          |
|         ii. OR provide t |
| he desired limit as the  |
| first                    |
|            argument to t |
| he script.               |
|                          |
|     3. Optional executio |
| n trace log.             |
|                          |
|       (a) To use the def |
| ault setting of no log o |
| utput: Do nothing.       |
|                          |
|       (b) To write an ex |
| ecution trace log:       |
|           export SPAMMER |
| _TRACE=spammer.log       |
|           or whatever fi |
| lename you want.         |
|                          |
|     4. Optional graphic  |
| description file.        |
|                          |
|       (a) To use the def |
| ault setting of no graph |
| ic file: Do nothing.     |
|                          |
|       (b) To write a Gra |
| ph-Viz graphic descripti |
| on file:                 |
|           export SPAMMER |
| _DATA=spammer.dot        |
|           or whatever fi |
| lename you want.         |
|                          |
|     5. Where to start th |
| e search.                |
|                          |
|       (a) Starting with  |
| a single domain name:    |
|                          |
|         i. Without a com |
| mand-line search limit:  |
| First                    |
|            argument to s |
| cript.                   |
|                          |
|         ii. With a comma |
| nd-line search limit: Se |
| cond                     |
|             argument to  |
| script.                  |
|                          |
|       (b) Starting with  |
| a single IP address:     |
|                          |
|         i. Without a com |
| mand-line search limit:  |
| First                    |
|            argument to s |
| cript.                   |
|                          |
|         ii. With a comma |
| nd-line search limit: Se |
| cond                     |
|             argument to  |
| script.                  |
|                          |
|       (c) Starting with  |
| (mixed) multiple name(s) |
|  and/or address(es):     |
|           Create a file  |
| with one name or address |
|  per line.               |
|           Your choice of |
|  filename.               |
|                          |
|         i. Without a com |
| mand-line search limit:  |
| Filename as              |
|            first argumen |
| t to script.             |
|                          |
|         ii. With a comma |
| nd-line search limit: Fi |
| lename as                |
|             second argum |
| ent to script.           |
|                          |
|     6. What to do with t |
| he display output.       |
|                          |
|       (a) To view displa |
| y output on screen: Do n |
| othing.                  |
|                          |
|       (b) To save displa |
| y output to a file: Redi |
| rect stdout to a filenam |
| e.                       |
|                          |
|       (c) To discard dis |
| play output: Redirect st |
| dout to /dev/null.       |
|                          |
|     7. Temporary end of  |
| decision making.         |
|        press RETURN      |
|        wait (optionally, |
|  watch the dots and colo |
| ns).                     |
|                          |
|     8. Optionally check  |
| the return code.         |
|                          |
|       (a) Return code 0: |
|  All OK                  |
|                          |
|       (b) Return code 1: |
|  Script setup failure    |
|                          |
|       (c) Return code 2: |
|  Something was blacklist |
| ed.                      |
|                          |
|     9. Where is my graph |
|  (diagram)?              |
|                          |
|     The script does not  |
| directly produce a graph |
|  (diagram).              |
|     It only produces a g |
| raphic description file. |
|  You can                 |
|     process the graphic  |
| descriptor file that was |
|  output                  |
|     with the 'dot' progr |
| am.                      |
|                          |
|     Until you edit that  |
| descriptor file, to desc |
| ribe the                 |
|     relationships you wa |
| nt shown, all that you w |
| ill get is               |
|     a bunch of labeled n |
| ame and address nodes.   |
|                          |
|     All of the script's  |
| discovered relationships |
|  are within              |
|     a comment block in t |
| he graphic descriptor fi |
| le, each                 |
|     with a descriptive h |
| eading.                  |
|                          |
|     The editing required |
|  to draw a line between  |
| a pair of                |
|     nodes from the infor |
| mation in the descriptor |
|  file may                |
|     be done with a text  |
| editor.                  |
|                          |
|     Given these lines so |
| mewhere in the descripto |
| r file:                  |
|                          |
|     # Known domain name  |
| nodes                    |
|                          |
|     N0000 [label="guardp |
| roof.info."] ;           |
|                          |
|     N0002 [label="third. |
| guardproof.info."] ;     |
|                          |
|                          |
|                          |
|     # Known address node |
| s                        |
|                          |
|     A0000 [label="61.141 |
| .32.197"] ;              |
|                          |
|                          |
|                          |
|     /*                   |
|                          |
|     # Known name->addres |
| s edges                  |
|                          |
|     NA0000 third.guardpr |
| oof.info. 61.141.32.197  |
|                          |
|                          |
|                          |
|     # Known parent->chil |
| d edges                  |
|                          |
|     PC0000 guardproof.in |
| fo. third.guardproof.inf |
| o.                       |
|                          |
|      */                  |
|                          |
|     Turn that into the f |
| ollowing lines by substi |
| tuting node              |
|     identifiers into the |
|  relationships:          |
|                          |
|     # Known domain name  |
| nodes                    |
|                          |
|     N0000 [label="guardp |
| roof.info."] ;           |
|                          |
|     N0002 [label="third. |
| guardproof.info."] ;     |
|                          |
|                          |
|                          |
|     # Known address node |
| s                        |
|                          |
|     A0000 [label="61.141 |
| .32.197"] ;              |
|                          |
|                          |
|                          |
|     # PC0000 guardproof. |
| info. third.guardproof.i |
| nfo.                     |
|                          |
|     N0000->N0002 ;       |
|                          |
|                          |
|                          |
|     # NA0000 third.guard |
| proof.info. 61.141.32.19 |
| 7                        |
|                          |
|     N0002->A0000 ;       |
|                          |
|                          |
|                          |
|     /*                   |
|                          |
|     # Known name->addres |
| s edges                  |
|                          |
|     NA0000 third.guardpr |
| oof.info. 61.141.32.197  |
|                          |
|                          |
|                          |
|     # Known parent->chil |
| d edges                  |
|                          |
|     PC0000 guardproof.in |
| fo. third.guardproof.inf |
| o.                       |
|                          |
|      */                  |
|                          |
|     Process that with th |
| e 'dot' program, and you |
|  have your               |
|     first network diagra |
| m.                       |
|                          |
|     In addition to the c |
| onventional graphic edge |
| s, the                   |
|     descriptor file incl |
| udes similar format pair |
| -data that               |
|     describes services,  |
| zone records (sub-graphs |
| ?),                      |
|     blacklisted addresse |
| s, and other things whic |
| h might be               |
|     interesting to inclu |
| de in your graph. This a |
| dditional                |
|     information could be |
|  displayed as different  |
| node                     |
|     shapes, colors, line |
|  sizes, etc.             |
|                          |
|     The descriptor file  |
| can also be read and edi |
| ted by a                 |
|     Bash script (of cour |
| se). You should be able  |
| to find                  |
|     most of the function |
| s required within the    |
|     "is_spammer.bash" sc |
| ript.                    |
|                          |
|     # End Quickstart.    |
|                          |
|                          |
|                          |
|     Additional Note      |
|     ========== ====      |
|                          |
|     Michael Zick points  |
| out that there is a "mak |
| eviz.bash" interactive   |
|     Web site at rediris. |
| es. Can't give the full  |
| URL, since this is not   |
|     a publically accessi |
| ble site.                |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Another anti-spam script.

.. raw:: html

   <div class="EXAMPLE">

**Example A-29. Spammer Hunt**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # whx.sh: "whois" sp |
| ammer lookup             |
|     # Author: Walter Dne |
| s                        |
|     # Slight revisions ( |
| first section) by ABS Gu |
| ide author.              |
|     # Used in ABS Guide  |
| with permission.         |
|                          |
|     # Needs version 3.x  |
| or greater of Bash to ru |
| n (because of =~ operato |
| r).                      |
|     # Commented by scrip |
| t author and ABS Guide a |
| uthor.                   |
|                          |
|                          |
|                          |
|     E_BADARGS=85         |
| # Missing command-line a |
| rg.                      |
|     E_NOHOST=86          |
| # Host not found.        |
|     E_TIMEOUT=87         |
| # Host lookup timed out. |
|     E_UNDEF=88           |
| # Some other (undefined) |
|  error.                  |
|                          |
|     HOSTWAIT=10          |
| # Specify up to 10 secon |
| ds for host query reply. |
|                          |
| # The actual wait may be |
|  a bit longer.           |
|     OUTFILE=whois.txt    |
| # Output file.           |
|     PORT=4321            |
|                          |
|                          |
|     if [ -z "$1" ]       |
| # Check for (required) c |
| ommand-line arg.         |
|     then                 |
|       echo "Usage: $0 do |
| main name or IP address" |
|       exit $E_BADARGS    |
|     fi                   |
|                          |
|                          |
|     if [[ "$1" =~ [a-zA- |
| Z][a-zA-Z]$ ]]  #  Ends  |
| in two alpha chars?      |
|     then                 |
|                   #  It' |
| s a domain name &&       |
|                          |
|                   #+ mus |
| t do host lookup.        |
|       IPADDR=$(host -W $ |
| HOSTWAIT $1 | awk '{prin |
| t $4}')                  |
|                          |
|                   #  Doi |
| ng host lookup           |
|                          |
|                   #+ to  |
| get IP address.          |
|                          |
|   #  Extract final field |
| .                        |
|     else                 |
|       IPADDR="$1"        |
|                   #  Com |
| mand-line arg was IP add |
| ress.                    |
|     fi                   |
|                          |
|     echo; echo "IP Addre |
| ss is: "$IPADDR""; echo  |
|                          |
|     if [ -e "$OUTFILE" ] |
|     then                 |
|       rm -f "$OUTFILE"   |
|       echo "Stale output |
|  file \"$OUTFILE\" remov |
| ed."; echo               |
|     fi                   |
|                          |
|                          |
|     #  Sanity checks.    |
|     #  (This section nee |
| ds more work.)           |
|     #  ================= |
| ==============           |
|     if [ -z "$IPADDR" ]  |
|     # No response.       |
|     then                 |
|       echo "Host not fou |
| nd!"                     |
|       exit $E_NOHOST     |
| # Bail out.              |
|     fi                   |
|                          |
|     if [[ "$IPADDR" =~ ^ |
| [;;] ]]                  |
|     #  ;; Connection tim |
| ed out; no servers could |
|  be reached.             |
|     then                 |
|       echo "Host lookup  |
| timed out!"              |
|       exit $E_TIMEOUT    |
| # Bail out.              |
|     fi                   |
|                          |
|     if [[ "$IPADDR" =~ [ |
| (NXDOMAIN)]$ ]]          |
|     #  Host xxxxxxxxx.xx |
| x not found: 3(NXDOMAIN) |
|     then                 |
|       echo "Host not fou |
| nd!"                     |
|       exit $E_NOHOST     |
| # Bail out.              |
|     fi                   |
|                          |
|     if [[ "$IPADDR" =~ [ |
| (SERVFAIL)]$ ]]          |
|     #  Host xxxxxxxxx.xx |
| x not found: 2(SERVFAIL) |
|     then                 |
|       echo "Host not fou |
| nd!"                     |
|       exit $E_NOHOST     |
| # Bail out.              |
|     fi                   |
|                          |
|                          |
|                          |
|                          |
|     # ================== |
| ====== Main body of scri |
| pt ===================== |
| ===                      |
|                          |
|     AFRINICquery() {     |
|     #  Define the functi |
| on that queries AFRINIC. |
|  Echo a notification to  |
| the                      |
|     #+ screen, and then  |
| run the actual query, re |
| directing output to $OUT |
| FILE.                    |
|                          |
|       echo "Searching fo |
| r $IPADDR in whois.afrin |
| ic.net"                  |
|       whois -h whois.afr |
| inic.net "$IPADDR" > $OU |
| TFILE                    |
|                          |
|     #  Check for presenc |
| e of reference to an rwh |
| ois.                     |
|     #  Warn about non-fu |
| nctional rwhois.infosat. |
| net server               |
|     #+ and attempt rwhoi |
| s query.                 |
|       if grep -e "^remar |
| ks: .*rwhois\.[^ ]\+" "$ |
| OUTFILE"                 |
|       then               |
|         echo " " >> $OUT |
| FILE                     |
|         echo "***" >> $O |
| UTFILE                   |
|         echo "***" >> $O |
| UTFILE                   |
|         echo "Warning: r |
| whois.infosat.net was no |
| t working \              |
|           as of 2005/02/ |
| 02" >> $OUTFILE          |
|         echo "         w |
| hen this script was writ |
| ten." >> $OUTFILE        |
|         echo "***" >> $O |
| UTFILE                   |
|         echo "***" >> $O |
| UTFILE                   |
|         echo " " >> $OUT |
| FILE                     |
|         RWHOIS=`grep "^r |
| emarks: .*rwhois\.[^ ]\+ |
| " "$OUTFILE" | tail -n 1 |
|  |\                      |
|         sed "s/\(^.*\)\( |
| rwhois\..*\)\(:4.*\)/\2/ |
| "`                       |
|         whois -h ${RWHOI |
| S}:${PORT} "$IPADDR" >>  |
| $OUTFILE                 |
|       fi                 |
|     }                    |
|                          |
|     APNICquery() {       |
|       echo "Searching fo |
| r $IPADDR in whois.apnic |
| .net"                    |
|       whois -h whois.apn |
| ic.net "$IPADDR" > $OUTF |
| ILE                      |
|                          |
|     #  Just  about  ever |
| y  country has its own i |
| nternet registrar.       |
|     #  I don't normally  |
| bother consulting them,  |
| because the regional reg |
| istry                    |
|     #+ usually supplies  |
| sufficient information.  |
|     #  There are a few e |
| xceptions, where the reg |
| ional registry simply    |
|     #+ refers to the nat |
| ional registry for direc |
| t data.                  |
|     #  These are Japan a |
| nd South Korea in APNIC, |
|  and Brasil in LACNIC.   |
|     #  The following if  |
| statement checks $OUTFIL |
| E (whois.txt) for the pr |
| esence                   |
|     #+ of "KR" (South Ko |
| rea) or "JP" (Japan) in  |
| the country field.       |
|     #  If either is foun |
| d, the query is re-run a |
| gainst the appropriate   |
|     #+ national registry |
| .                        |
|                          |
|       if grep -E "^count |
| ry:[ ]+KR$" "$OUTFILE"   |
|       then               |
|         echo "Searching  |
| for $IPADDR in whois.krn |
| ic.net"                  |
|         whois -h whois.k |
| rnic.net "$IPADDR" >> $O |
| UTFILE                   |
|       elif grep -E "^cou |
| ntry:[ ]+JP$" "$OUTFILE" |
|       then               |
|         echo "Searching  |
| for $IPADDR in whois.nic |
| .ad.jp"                  |
|         whois -h whois.n |
| ic.ad.jp "$IPADDR"/e >>  |
| $OUTFILE                 |
|       fi                 |
|     }                    |
|                          |
|     ARINquery() {        |
|       echo "Searching fo |
| r $IPADDR in whois.arin. |
| net"                     |
|       whois -h whois.ari |
| n.net "$IPADDR" > $OUTFI |
| LE                       |
|                          |
|     #  Several large int |
| ernet providers listed b |
| y ARIN have their own    |
|     #+ internal whois se |
| rvice, referred to as "r |
| whois".                  |
|     #  A large block of  |
| IP addresses is listed w |
| ith the provider         |
|     #+ under the ARIN re |
| gistry.                  |
|     #  To get the IP add |
| resses of 2nd-level ISPs |
|  or other large customer |
| s,                       |
|     #+ one has to refer  |
| to the rwhois server on  |
| port 4321.               |
|     #  I originally star |
| ted with a bunch of "if" |
|  statements checking for |
|     #+ the larger provid |
| ers.                     |
|     #  This approach is  |
| unwieldy, and there's al |
| ways another rwhois serv |
| er                       |
|     #+ that I didn't kno |
| w about.                 |
|     #  A more elegant ap |
| proach is to check $OUTF |
| ILE for a reference      |
|     #+ to a whois server |
| , parse that server name |
|  out of the comment sect |
| ion,                     |
|     #+ and re-run the qu |
| ery against the appropri |
| ate rwhois server.       |
|     #  The parsing looks |
|  a bit ugly, with a long |
|  continued line inside   |
|     #+ backticks.        |
|     #  But it only has t |
| o be done once, and will |
|  work as new servers are |
|  added.                  |
|     #@   ABS Guide autho |
| r comment: it isn't all  |
| that ugly, and is, in fa |
| ct,                      |
|     #@+  an instructive  |
| use of Regular Expressio |
| ns.                      |
|                          |
|       if grep -E "^Comme |
| nt: .*rwhois.[^ ]+" "$OU |
| TFILE"                   |
|       then               |
|         RWHOIS=`grep -e  |
| "^Comment:.*rwhois\.[^ ] |
| \+" "$OUTFILE" | tail -n |
|  1 |\                    |
|         sed "s/^\(.*\)\( |
| rwhois\.[^ ]\+\)\(.*$\)/ |
| \2/"`                    |
|         echo "Searching  |
| for $IPADDR in ${RWHOIS} |
| "                        |
|         whois -h ${RWHOI |
| S}:${PORT} "$IPADDR" >>  |
| $OUTFILE                 |
|       fi                 |
|     }                    |
|                          |
|     LACNICquery() {      |
|       echo "Searching fo |
| r $IPADDR in whois.lacni |
| c.net"                   |
|       whois -h whois.lac |
| nic.net "$IPADDR" > $OUT |
| FILE                     |
|                          |
|     #  The  following if |
|  statement checks $OUTFI |
| LE (whois.txt) for       |
|     #+ the presence of " |
| BR" (Brasil) in the coun |
| try field.               |
|     #  If it is found, t |
| he query is re-run again |
| st whois.registro.br.    |
|                          |
|       if grep -E "^count |
| ry:[ ]+BR$" "$OUTFILE"   |
|       then               |
|         echo "Searching  |
| for $IPADDR in whois.reg |
| istro.br"                |
|         whois -h whois.r |
| egistro.br "$IPADDR" >>  |
| $OUTFILE                 |
|       fi                 |
|     }                    |
|                          |
|     RIPEquery() {        |
|       echo "Searching fo |
| r $IPADDR in whois.ripe. |
| net"                     |
|       whois -h whois.rip |
| e.net "$IPADDR" > $OUTFI |
| LE                       |
|     }                    |
|                          |
|     #  Initialize a few  |
| variables.               |
|     #  * slash8 is the m |
| ost significant octet    |
|     #  * slash16 consist |
| s of the two most signif |
| icant octets             |
|     #  * octet2 is the s |
| econd most significant o |
| ctet                     |
|                          |
|                          |
|                          |
|                          |
|     slash8=`echo $IPADDR |
|  | cut -d. -f 1`         |
|       if [ -z "$slash8"  |
| ]  # Yet another sanity  |
| check.                   |
|       then               |
|         echo "Undefined  |
| error!"                  |
|         exit $E_UNDEF    |
|       fi                 |
|     slash16=`echo $IPADD |
| R | cut -d. -f 1-2`      |
|     #                    |
|           ^ Period speci |
| fied as 'cut" delimiter. |
|       if [ -z "$slash16" |
|  ]                       |
|       then               |
|         echo "Undefined  |
| error!"                  |
|         exit $E_UNDEF    |
|       fi                 |
|     octet2=`echo $slash1 |
| 6 | cut -d. -f 2`        |
|       if [ -z "$octet2"  |
| ]                        |
|       then               |
|         echo "Undefined  |
| error!"                  |
|         exit $E_UNDEF    |
|       fi                 |
|                          |
|                          |
|     #  Check for various |
|  odds and ends of reserv |
| ed space.                |
|     #  There is no point |
|  in querying for those a |
| ddresses.                |
|                          |
|     if [ $slash8 == 0 ]; |
|  then                    |
|       echo $IPADDR is '" |
| This Network"' space\; N |
| ot querying              |
|     elif [ $slash8 == 10 |
|  ]; then                 |
|       echo $IPADDR is RF |
| C1918 space\; Not queryi |
| ng                       |
|     elif [ $slash8 == 14 |
|  ]; then                 |
|       echo $IPADDR is '" |
| Public Data Network"' sp |
| ace\; Not querying       |
|     elif [ $slash8 == 12 |
| 7 ]; then                |
|       echo $IPADDR is lo |
| opback space\; Not query |
| ing                      |
|     elif [ $slash16 == 1 |
| 69.254 ]; then           |
|       echo $IPADDR is li |
| nk-local space\; Not que |
| rying                    |
|     elif [ $slash8 == 17 |
| 2 ] && [ $octet2 -ge 16  |
| ] && [ $octet2 -le 31 ]; |
| then                     |
|       echo $IPADDR is RF |
| C1918 space\; Not queryi |
| ng                       |
|     elif [ $slash16 == 1 |
| 92.168 ]; then           |
|       echo $IPADDR is RF |
| C1918 space\; Not queryi |
| ng                       |
|     elif [ $slash8 -ge 2 |
| 24 ]; then               |
|       echo $IPADDR is ei |
| ther Multicast or reserv |
| ed space\; Not querying  |
|     elif [ $slash8 -ge 2 |
| 00 ] && [ $slash8 -le 20 |
| 1 ]; then LACNICquery "$ |
| IPADDR"                  |
|     elif [ $slash8 -ge 2 |
| 02 ] && [ $slash8 -le 20 |
| 3 ]; then APNICquery "$I |
| PADDR"                   |
|     elif [ $slash8 -ge 2 |
| 10 ] && [ $slash8 -le 21 |
| 1 ]; then APNICquery "$I |
| PADDR"                   |
|     elif [ $slash8 -ge 2 |
| 18 ] && [ $slash8 -le 22 |
| 3 ]; then APNICquery "$I |
| PADDR"                   |
|                          |
|     #  If we got this fa |
| r without making a decis |
| ion, query ARIN.         |
|     #  If a reference is |
|  found in $OUTFILE to AP |
| NIC, AFRINIC, LACNIC, or |
|  RIPE,                   |
|     #+ query the appropr |
| iate whois server.       |
|                          |
|     else                 |
|       ARINquery "$IPADDR |
| "                        |
|       if grep "whois.afr |
| inic.net" "$OUTFILE"; th |
| en                       |
|         AFRINICquery "$I |
| PADDR"                   |
|       elif grep -E "^Org |
| ID:[ ]+RIPE$" "$OUTFILE" |
| ; then                   |
|         RIPEquery "$IPAD |
| DR"                      |
|       elif grep -E "^Org |
| ID:[ ]+APNIC$" "$OUTFILE |
| "; then                  |
|         APNICquery "$IPA |
| DDR"                     |
|       elif grep -E "^Org |
| ID:[ ]+LACNIC$" "$OUTFIL |
| E"; then                 |
|         LACNICquery "$IP |
| ADDR"                    |
|       fi                 |
|     fi                   |
|                          |
|     #@  ---------------- |
| ------------------------ |
| -----------------------  |
|     #   Try also:        |
|     #   wget http://logi |
| .cc/nw/whois.php3?ACTION |
| =doQuery&DOMAIN=$IPADDR  |
|     #@  ---------------- |
| ------------------------ |
| -----------------------  |
|                          |
|     #  We've  now  finis |
| hed  the querying.       |
|     #  Echo a copy of th |
| e final result to the sc |
| reen.                    |
|                          |
|     cat $OUTFILE         |
|     # Or "less $OUTFILE" |
|  . . .                   |
|                          |
|                          |
|     exit 0               |
|                          |
|     #@  ABS Guide author |
|  comments:               |
|     #@  Nothing fancy he |
| re, but still a very use |
| ful tool for hunting spa |
| mmers.                   |
|     #@  Sure, the script |
|  can be cleaned up some, |
|  and it's still a bit bu |
| ggy,                     |
|     #@+ (exercise for re |
| ader), but all the same, |
|  it's a nice piece of co |
| ding                     |
|     #@+ by Walter Dnes.  |
|     #@  Thank you!       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

 "Little Monster's" front end to `wget <communications.html#WGETREF>`__
.

.. raw:: html

   <div class="EXAMPLE">

**Example A-30. Making *wget* easier to use**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # wgetter2.bash      |
|                          |
|     # Author: Little Mon |
| ster [monster@monstruum. |
| co.uk]                   |
|     # ==> Used in ABS Gu |
| ide with permission of s |
| cript author.            |
|     # ==> This script st |
| ill needs debugging and  |
| fixups (exercise for rea |
| der).                    |
|     # ==> It could also  |
| use some additional edit |
| ing in the comments.     |
|                          |
|                          |
|     #  This is wgetter2  |
| --                       |
|     #+ a Bash script to  |
| make wget a bit more fri |
| endly, and save typing.  |
|                          |
|     #  Carefully crafted |
|  by Little Monster.      |
|     #  More or less comp |
| lete on 02/02/2005.      |
|     #  If you think this |
|  script can be improved, |
|     #+ email me at: mons |
| ter@monstruum.co.uk      |
|     # ==> and cc: to the |
|  author of the ABS Guide |
| , please.                |
|     #  This script is li |
| cenced under the GPL.    |
|     #  You are free to c |
| opy, alter and re-use it |
| ,                        |
|     #+ but please don't  |
| try to claim you wrote i |
| t.                       |
|     #  Log your changes  |
| here instead.            |
|                          |
|     # ================== |
| ======================== |
| ======================== |
| =====                    |
|     # changelog:         |
|                          |
|     # 07/02/2005.  Fixup |
| s by Little Monster.     |
|     # 02/02/2005.  Minor |
|  additions by Little Mon |
| ster.                    |
|     #              (See  |
| after # +++++++++++ )    |
|     # 29/01/2005.  Minor |
|  stylistic edits and cle |
| anups by author of ABS G |
| uide.                    |
|     #              Added |
|  exit error codes.       |
|     # 22/11/2004.  Finis |
| hed initial version of s |
| econd version of wgetter |
| :                        |
|     #              wgett |
| er2 is born.             |
|     # 01/12/2004.  Chang |
| ed 'runn' function so it |
|  can be run 2 ways --    |
|     #              eithe |
| r ask for a file name or |
|  have one input on the C |
| L.                       |
|     # 01/12/2004.  Made  |
| sensible handling of no  |
| URL's given.             |
|     # 01/12/2004.  Made  |
| loop of main options, so |
|  you don't               |
|     #              have  |
| to keep calling wgetter  |
| 2 all the time.          |
|     #              Runs  |
| as a session instead.    |
|     # 01/12/2004.  Added |
|  looping to 'runn' funct |
| ion.                     |
|     #              Simpl |
| ified and improved.      |
|     # 01/12/2004.  Added |
|  state to recursion sett |
| ing.                     |
|     #              Enabl |
| es re-use of previous va |
| lue.                     |
|     # 05/12/2004.  Modif |
| ied the file detection r |
| outine in the 'runn' fun |
| ction                    |
|     #              so it |
| 's not fooled by empty v |
| alues, and is cleaner.   |
|     # 01/02/2004.  Added |
|  cookie finding routine  |
| from later version (whic |
| h                        |
|     #              isn't |
|  ready yet), so as not t |
| o have hard-coded paths. |
|     # ================== |
| ======================== |
| ======================== |
| =====                    |
|                          |
|     # Error codes for ab |
| normal exit.             |
|     E_USAGE=67        #  |
| Usage message, then quit |
| .                        |
|     E_NO_OPTS=68      #  |
| No command-line args ent |
| ered.                    |
|     E_NO_URLS=69      #  |
| No URLs passed to script |
| .                        |
|     E_NO_SAVEFILE=70  #  |
| No save filename passed  |
| to script.               |
|     E_USER_EXIT=71    #  |
| User decides to quit.    |
|                          |
|                          |
|     #  Basic default wge |
| t command we want to use |
| .                        |
|     #  This is the place |
|  to change it, if requir |
| ed.                      |
|     #  NB: if using a pr |
| oxy, set http_proxy = yo |
| urproxy in .wgetrc.      |
|     #  Otherwise delete  |
| --proxy=on, below.       |
|     # ================== |
| ======================== |
| ======================== |
| ==                       |
|     CommandA="wget -nc - |
| c -t 5 --progress=bar -- |
| random-wait --proxy=on - |
| r"                       |
|     # ================== |
| ======================== |
| ======================== |
| ==                       |
|                          |
|                          |
|                          |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| --                       |
|     # Set some other var |
| iables and explain them. |
|                          |
|     pattern=" -A .jpg,.J |
| PG,.jpeg,.JPEG,.gif,.GIF |
| ,.htm,.html,.shtml,.php" |
|                          |
| # wget's option to only  |
| get certain types of fil |
| e.                       |
|                          |
| # comment out if not usi |
| ng                       |
|     today=`date +%F`     |
| # Used for a filename.   |
|     home=$HOME           |
| # Set HOME to an interna |
| l variable.              |
|                          |
| # In case some other pat |
| h is used, change it her |
| e.                       |
|     depthDefault=3       |
| # Set a sensible default |
|  recursion.              |
|     Depth=$depthDefault  |
| # Otherwise user feedbac |
| k doesn't tie in properl |
| y.                       |
|     RefA=""              |
| # Set blank referring pa |
| ge.                      |
|     Flag=""              |
| #  Default to not saving |
|  anything,               |
|                          |
| #+ or whatever else migh |
| t be wanted in future.   |
|     lister=""            |
| # Used for passing a lis |
| t of urls directly to wg |
| et.                      |
|     Woptions=""          |
| # Used for passing wget  |
| some options for itself. |
|     inFile=""            |
| # Used for the run funct |
| ion.                     |
|     newFile=""           |
| # Used for the run funct |
| ion.                     |
|     savePath="$home/w-sa |
| ve"                      |
|     Config="$home/.wgett |
| er2rc"                   |
|                          |
| #  This is where some va |
| riables can be stored,   |
|                          |
| #+ if permanently change |
| d from within the script |
| .                        |
|     Cookie_List="$home/. |
| cookielist"              |
|                          |
| # So we know where the c |
| ookies are kept . . .    |
|     cFlag=""             |
| # Part of the cookie fil |
| e selection routine.     |
|                          |
|     # Define the options |
|  available. Easy to chan |
| ge letters here if neede |
| d.                       |
|     # These are the opti |
| onal options; you don't  |
| just wait to be asked.   |
|                          |
|     save=s   # Save comm |
| and instead of executing |
|  it.                     |
|     cook=c   # Change co |
| okie file for this sessi |
| on.                      |
|     help=h   # Usage gui |
| de.                      |
|     list=l   # Pass wget |
|  the -i option and URL l |
| ist.                     |
|     runn=r   # Run saved |
|  commands as an argument |
|  to the option.          |
|     inpu=i   # Run saved |
|  commands interactively. |
|     wopt=w   # Allow to  |
| enter options to pass di |
| rectly to wget.          |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| --                       |
|                          |
|                          |
|     if [ -z "$1" ]; then |
|    # Make sure we get so |
| mething for wget to eat. |
|        echo "You must at |
|  least enter a URL or op |
| tion!"                   |
|        echo "-$help for  |
| usage."                  |
|        exit $E_NO_OPTS   |
|     fi                   |
|                          |
|                          |
|                          |
|     # ++++++++++++++++++ |
| ++++++++++++++++++++++++ |
| ++++++++++++++++++++++++ |
| +++++                    |
|     # added added added  |
| added added added added  |
| added added added added  |
| added                    |
|                          |
|     if [ ! -e "$Config"  |
| ]; then   # See if confi |
| guration file exists.    |
|        echo "Creating co |
| nfiguration file, $Confi |
| g"                       |
|        echo "# This is t |
| he configuration file fo |
| r wgetter2" > "$Config"  |
|        echo "# Your cust |
| omised settings will be  |
| saved in this file" >> " |
| $Config"                 |
|     else                 |
|        source $Config    |
|           # Import varia |
| bles we set outside the  |
| script.                  |
|     fi                   |
|                          |
|     if [ ! -e "$Cookie_L |
| ist" ]; then             |
|        # Set up a list o |
| f cookie files, if there |
|  isn't one.              |
|        echo "Hunting for |
|  cookies . . ."          |
|        find -name cookie |
| s.txt >> $Cookie_List #  |
| Create the list of cooki |
| e files.                 |
|     fi #  Isolate this i |
| n its own 'if' statement |
| ,                        |
|        #+ in case we got |
|  interrupted while searc |
| hing.                    |
|                          |
|     if [ -z "$cFlag" ];  |
| then # If we haven't alr |
| eady done this . . .     |
|        echo              |
|      # Make a nice space |
|  after the command promp |
| t.                       |
|        echo "Looks like  |
| you haven't set up your  |
| source of cookies yet."  |
|        n=0               |
|      #  Make sure the co |
| unter                    |
|                          |
|      #+ doesn't contain  |
| random values.           |
|        while read; do    |
|           Cookies[$n]=$R |
| EPLY # Put the cookie fi |
| les we found into an arr |
| ay.                      |
|           echo "$n) ${Co |
| okies[$n]}"  # Create a  |
| menu.                    |
|           n=$(( n + 1 )) |
|      # Increment the cou |
| nter.                    |
|        done < $Cookie_Li |
| st   # Feed the read sta |
| tement.                  |
|        echo "Enter the n |
| umber of the cookie file |
|  you want to use."       |
|        echo "If you won' |
| t be using cookies, just |
|  press RETURN."          |
|        echo              |
|        echo "I won't be  |
| asking this again. Edit  |
| $Config"                 |
|        echo "If you deci |
| de to change at a later  |
| date"                    |
|        echo "or use the  |
| -${cook} option for per  |
| session changes."        |
|        read              |
|        if [ ! -z $REPLY  |
| ]; then   # User didn't  |
| just press return.       |
|           Cookie=" --loa |
| d-cookies ${Cookies[$REP |
| LY]}"                    |
|           # Set the vari |
| able here as well as in  |
| the config file.         |
|                          |
|           echo "Cookie=\ |
| " --load-cookies ${Cooki |
| es[$REPLY]}\"" >> $Confi |
| g                        |
|        fi                |
|        echo "cFlag=1" >> |
|  $Config  # So we know n |
| ot to ask again.         |
|     fi                   |
|                          |
|     # end added section  |
| end added section end ad |
| ded section end added se |
| ction                    |
|     # ++++++++++++++++++ |
| ++++++++++++++++++++++++ |
| ++++++++++++++++++++++++ |
| +++++                    |
|                          |
|                          |
|                          |
|     # Another variable.  |
|     # This one may or ma |
| y not be subject to vari |
| ation.                   |
|     # A bit like the sma |
| ll print.                |
|     CookiesON=$Cookie    |
|     # echo "cookie file  |
| is $CookiesON" # For deb |
| ugging.                  |
|     # echo "home is ${ho |
| me}"           # For deb |
| ugging.                  |
|                          |
|                # Got cau |
| ght with this one!       |
|                          |
|                          |
|     wopts()              |
|     {                    |
|     echo "Enter options  |
| to pass to wget."        |
|     echo "It is assumed  |
| you know what you're doi |
| ng."                     |
|     echo                 |
|     echo "You can pass t |
| heir arguments here too. |
| "                        |
|     # That is to say, ev |
| erything passed here is  |
| passed to wget.          |
|                          |
|     read Wopts           |
|     # Read in the option |
| s to be passed to wget.  |
|                          |
|     Woptions=" $Wopts"   |
|     #         ^  Why the |
|  leading space?          |
|     # Assign to another  |
| variable.                |
|     # Just for fun, or s |
| omething . . .           |
|                          |
|     echo "passing option |
| s ${Wopts} to wget"      |
|     # Mainly for debuggi |
| ng.                      |
|     # Is cute.           |
|                          |
|     return               |
|     }                    |
|                          |
|                          |
|     save_func()          |
|     {                    |
|     echo "Settings will  |
| be saved."               |
|     if [ ! -d $savePath  |
| ]; then  #  See if direc |
| tory exists.             |
|        mkdir $savePath   |
|          #  Create the d |
| irectory to save things  |
| in                       |
|                          |
|          #+ if it isn't  |
| already there.           |
|     fi                   |
|                          |
|     Flag=S               |
|     # Tell the final bit |
|  of code what to do.     |
|     # Set a flag since s |
| tuff is done in main.    |
|                          |
|     return               |
|     }                    |
|                          |
|                          |
|     usage() # Tell them  |
| how it works.            |
|     {                    |
|         echo "Welcome to |
|  wgetter.  This is a fro |
| nt end to wget."         |
|         echo "It will al |
| ways run wget with these |
|  options:"               |
|         echo "$CommandA" |
|         echo "and the pa |
| ttern to match: $pattern |
|  \                       |
|     (which you can chang |
| e at the top of this scr |
| ipt)."                   |
|         echo "It will al |
| so ask you for recursion |
|  depth, \                |
|     and if you want to u |
| se a referring page."    |
|         echo "Wgetter ac |
| cepts the following opti |
| ons:"                    |
|         echo ""          |
|         echo "-$help : D |
| isplay this help."       |
|         echo "-$save : S |
| ave the command to a fil |
| e $savePath/wget-($today |
| ) \                      |
|     instead of running i |
| t."                      |
|         echo "-$runn : R |
| un saved wget commands i |
| nstead of starting a new |
|  one -"                  |
|         echo "Enter file |
| name as argument to this |
|  option."                |
|         echo "-$inpu : R |
| un saved wget commands i |
| nteractively --"         |
|         echo "The script |
|  will ask you for the fi |
| lename."                 |
|         echo "-$cook : C |
| hange the cookies file f |
| or this session."        |
|         echo "-$list : T |
| ell wget to use URL's fr |
| om a list instead of \   |
|     from the command-lin |
| e."                      |
|         echo "-$wopt : P |
| ass any other options di |
| rect to wget."           |
|         echo ""          |
|         echo "See the wg |
| et man page for addition |
| al options \             |
|     you can pass to wget |
| ."                       |
|         echo ""          |
|                          |
|         exit $E_USAGE  # |
|  End here. Don't process |
|  anything else.          |
|     }                    |
|                          |
|                          |
|                          |
|     list_func() #  Gives |
|  the user the option to  |
| use the -i option to wge |
| t,                       |
|                 #+ and a |
|  list of URLs.           |
|     {                    |
|     while [ 1 ]; do      |
|        echo "Enter the n |
| ame of the file containi |
| ng URL's (press q to cha |
| nge                      |
|     your mind)."         |
|        read urlfile      |
|        if [ ! -e "$urlfi |
| le" ] && [ "$urlfile" != |
|  q ]; then               |
|            # Look for a  |
| file, or the quit option |
| .                        |
|            echo "That fi |
| le does not exist!"      |
|        elif [ "$urlfile" |
|  = q ]; then # Check qui |
| t option.                |
|            echo "Not usi |
| ng a url list."          |
|            return        |
|        else              |
|           echo "using $u |
| rlfile."                 |
|           echo "If you g |
| ave url's on the command |
| -line, I'll use those fi |
| rst."                    |
|                          |
|         # Report wget st |
| andard behaviour to the  |
| user.                    |
|           lister=" -i $u |
| rlfile" # This is what w |
| e want to pass to wget.  |
|           return         |
|        fi                |
|     done                 |
|     }                    |
|                          |
|                          |
|     cookie_func() # Give |
|  the user the option to  |
| use a different cookie f |
| ile.                     |
|     {                    |
|     while [ 1 ]; do      |
|        echo "Change the  |
| cookies file. Press retu |
| rn if you don't want to  |
| change                   |
|     it."                 |
|        read Cookies      |
|        # NB: this is not |
|  the same as Cookie, ear |
| lier.                    |
|        # There is an 's' |
|  on the end.             |
|        # Bit like chocol |
| ate chips.               |
|        if [ -z "$Cookies |
| " ]; then                |
|   # Escape clause for wu |
| sses.                    |
|           return         |
|        elif [ ! -e "$Coo |
| kies" ]; then            |
|           echo "File doe |
| s not exist.  Try again. |
| " # Keep em going . . .  |
|        else              |
|            CookiesON=" - |
| -load-cookies $Cookies"  |
|   # File is good -- use  |
| it!                      |
|            return        |
|        fi                |
|     done                 |
|     }                    |
|                          |
|                          |
|                          |
|     run_func()           |
|     {                    |
|     if [ -z "$OPTARG" ]; |
|  then                    |
|     # Test to see if we  |
| used the in-line option  |
| or the query one.        |
|        if [ ! -d "$saveP |
| ath" ]; then      # If d |
| irectory doesn't exist . |
|  . .                     |
|           echo "$savePat |
| h does not appear to exi |
| st."                     |
|           echo "Please s |
| upply path and filename  |
| of saved wget commands:" |
|           read newFile   |
|              until [ -f  |
| "$newFile" ]; do  # Keep |
|  going till we get somet |
| hing.                    |
|                 echo "So |
| rry, that file does not  |
| exist.  Please try again |
| ."                       |
|                 # Try re |
| ally hard to get somethi |
| ng.                      |
|                 read new |
| File                     |
|              done        |
|                          |
|                          |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| -----                    |
|     #       if [ -z ( gr |
| ep wget ${newfile} ) ];  |
| then                     |
|             # Assume the |
| y haven't got the right  |
| file and bail out.       |
|     #       echo "Sorry, |
|  that file does not cont |
| ain wget commands.  Abor |
| ting."                   |
|     #       exit         |
|     #       fi           |
|     #                    |
|     # This is bogus code |
| .                        |
|     # It doesn't actuall |
| y work.                  |
|     # If anyone wants to |
|  fix it, feel free!      |
|     # ------------------ |
| ------------------------ |
| ------------------------ |
| -----                    |
|                          |
|                          |
|           filePath="${ne |
| wFile}"                  |
|        else              |
|        echo "Save path i |
| s $savePath"             |
|          echo "Please en |
| ter name of the file whi |
| ch you want to use."     |
|          echo "You have  |
| a choice of:"            |
|          ls $savePath    |
|                          |
|          # Give them a c |
| hoice.                   |
|          read inFile     |
|            until [ -f "$ |
| savePath/$inFile" ]; do  |
|         #  Keep going ti |
| ll                       |
|                          |
|                          |
|         #+ we get someth |
| ing.                     |
|               if [ ! -f  |
| "${savePath}/${inFile}"  |
| ]; then # If file doesn' |
| t exist.                 |
|                  echo "S |
| orry, that file does not |
|  exist.  Please choose f |
| rom:"                    |
|                  ls $sav |
| ePath                    |
|         # If a mistake i |
| s made.                  |
|                  read in |
| File                     |
|               fi         |
|              done        |
|           filePath="${sa |
| vePath}/${inFile}"  # Ma |
| ke one variable . . .    |
|        fi                |
|     else filePath="${sav |
| ePath}/${OPTARG}"   # Wh |
| ich can be many things . |
|  . .                     |
|     fi                   |
|                          |
|     if [ ! -f "$filePath |
| " ]; then           # If |
|  a bogus file got throug |
| h.                       |
|        echo "You did not |
|  specify a suitable file |
| ."                       |
|        echo "Run this sc |
| ript with the -${save} o |
| ption first."            |
|        echo "Aborting."  |
|        exit $E_NO_SAVEFI |
| LE                       |
|     fi                   |
|     echo "Using: $filePa |
| th"                      |
|     while read; do       |
|         eval $REPLY      |
|         echo "Completed: |
|  $REPLY"                 |
|     done < $filePath  #  |
| Feed the actual file we  |
| are using into a 'while' |
|  loop.                   |
|                          |
|     exit                 |
|     }                    |
|                          |
|                          |
|                          |
|     # Fish out any optio |
| ns we are using for the  |
| script.                  |
|     # This is based on t |
| he demo in "Learning The |
|  Bash Shell" (O'Reilly). |
|     while getopts ":$sav |
| e$cook$help$list$runn:$i |
| npu$wopt" opt            |
|     do                   |
|       case $opt in       |
|          $save) save_fun |
| c;;   #  Save some wgett |
| er sessions for later.   |
|          $cook) cookie_f |
| unc;; #  Change cookie f |
| ile.                     |
|          $help) usage;;  |
|       #  Get help.       |
|          $list) list_fun |
| c;;   #  Allow wget to u |
| se a list of URLs.       |
|          $runn) run_func |
| ;;    #  Useful if you a |
| re calling wgetter from, |
|                          |
|       #+ for example, a  |
| cron script.             |
|          $inpu) run_func |
| ;;    #  When you don't  |
| know what your files are |
|  named.                  |
|          $wopt) wopts;;  |
|       #  Pass options di |
| rectly to wget.          |
|             \?) echo "No |
| t a valid option."       |
|                 echo "Us |
| e -${wopt} to pass optio |
| ns directly to wget,"    |
|                 echo "or |
|  -${help} for help";;    |
|    # Catch anything else |
| .                        |
|       esac               |
|     done                 |
|     shift $((OPTIND - 1) |
| )     # Do funky magic s |
| tuff with $#.            |
|                          |
|                          |
|     if [ -z "$1" ] && [  |
| -z "$lister" ]; then     |
|                          |
|       #  We should be le |
| ft with at least one URL |
|                          |
|       #+ on the command- |
| line, unless a list is   |
|                   #+ bei |
| ng used -- catch empty C |
| L's.                     |
|        echo "No URL's gi |
| ven! You must enter them |
|  on the same line as wge |
| tter2."                  |
|        echo "E.g.,  wget |
| ter2 http://somesite htt |
| p://anothersite."        |
|        echo "Use $help o |
| ption for more informati |
| on."                     |
|        exit $E_NO_URLS   |
|       # Bail out, with a |
| ppropriate error code.   |
|     fi                   |
|                          |
|     URLS=" $@"           |
|     # Use this so that U |
| RL list can be changed i |
| f we stay in the option  |
| loop.                    |
|                          |
|     while [ 1 ]; do      |
|        # This is where w |
| e ask for the most used  |
| options.                 |
|        # (Mostly unchang |
| ed from version 1 of wge |
| tter)                    |
|        if [ -z $curDepth |
|  ]; then                 |
|           Current=""     |
|        else Current=" Cu |
| rrent value is $curDepth |
| "                        |
|        fi                |
|            echo "How dee |
| p should I go? \         |
|     (integer: Default is |
|  $depthDefault.$Current) |
| "                        |
|            read Depth    |
| # Recursion -- how far s |
| hould we go?             |
|            inputB=""     |
| # Reset this to blank on |
|  each pass of the loop.  |
|            echo "Enter t |
| he name of the referring |
|  page (default is none). |
| "                        |
|            read inputB   |
| # Need this for some sit |
| es.                      |
|                          |
|            echo "Do you  |
| want to have the output  |
| logged to the terminal"  |
|            echo "(y/n, d |
| efault is yes)?"         |
|            read noHide   |
| # Otherwise wget will ju |
| st log it to a file.     |
|                          |
|            case $noHide  |
| in    # Now you see me,  |
| now you don't.           |
|               y|Y ) hide |
| ="";;                    |
|               n|N ) hide |
| =" -b";;                 |
|                 * ) hide |
| ="";;                    |
|            esac          |
|                          |
|            if [ -z ${Dep |
| th} ]; then              |
|            #  User accep |
| ted either default or cu |
| rrent depth,             |
|            #+ in which c |
| ase Depth is now empty.  |
|               if [ -z ${ |
| curDepth} ]; then        |
|               #  See if  |
| a depth was set on a pre |
| vious iteration.         |
|                  Depth=" |
| $depthDefault"           |
|                  #  Set  |
| the default recursion de |
| pth if nothing           |
|                  #+ else |
|  to use.                 |
|               else Depth |
| ="$curDepth" #  Otherwis |
| e, set the one we used b |
| efore.                   |
|               fi         |
|            fi            |
|        Recurse=" -l $Dep |
| th"          # Set how d |
| eep we want to go.       |
|        curDepth=$Depth   |
|              # Remember  |
| setting for next time.   |
|                          |
|            if [ ! -z $in |
| putB ]; then             |
|               RefA=" --r |
| eferer=$inputB"   # Opti |
| on to use referring page |
| .                        |
|            fi            |
|                          |
|        WGETTER="${Comman |
| dA}${pattern}${hide}${Re |
| fA}${Recurse}\           |
|     ${CookiesON}${lister |
| }${Woptions}${URLS}"     |
|        #  Just string th |
| e whole lot together . . |
|  .                       |
|        #  NB: no embedde |
| d spaces.                |
|        #  They are in th |
| e individual elements so |
|  that if any are empty,  |
|        #+ we don't get a |
| n extra space.           |
|                          |
|        if [ -z "${Cookie |
| sON}" ] && [ "$cFlag" =  |
| "1" ] ; then             |
|            echo "Warning |
|  -- can't find cookie fi |
| le"                      |
|            #  This shoul |
| d be changed,            |
|            #+ in case th |
| e user has opted to not  |
| use cookies.             |
|        fi                |
|                          |
|        if [ "$Flag" = "S |
| " ]; then                |
|           echo "$WGETTER |
| " >> $savePath/wget-${to |
| day}                     |
|           #  Create a un |
| ique filename for today, |
|  or append to it if it e |
| xists.                   |
|           echo "$inputB" |
|  >> $savePath/site-list- |
| ${today}                 |
|           #  Make a list |
| , so it's easy to refer  |
| back to,                 |
|           #+ since the w |
| hole command is a bit co |
| nfusing to look at.      |
|           echo "Command  |
| saved to the file $saveP |
| ath/wget-${today}"       |
|                # Tell th |
| e user.                  |
|           echo "Referrin |
| g page URL saved to the  |
| file$ \                  |
|     savePath/site-list-$ |
| {today}"                 |
|                # Tell th |
| e user.                  |
|           Saver=" with s |
| ave option"              |
|           # Stick this s |
| omewhere, so it appears  |
| in the loop if set.      |
|        else              |
|            echo "******* |
| **********"              |
|            echo "*****Ge |
| tting*****"              |
|            echo "******* |
| **********"              |
|            echo ""       |
|            echo "$WGETTE |
| R"                       |
|            echo ""       |
|            echo "******* |
| **********"              |
|            eval "$WGETTE |
| R"                       |
|        fi                |
|                          |
|            echo ""       |
|            echo "Startin |
| g over$Saver."           |
|            echo "If you  |
| want to stop, press q."  |
|            echo "Otherwi |
| se, enter some URL's:"   |
|            # Let them go |
|  again. Tell about save  |
| option being set.        |
|                          |
|            read          |
|            case $REPLY i |
| n                        |
|            # Need to cha |
| nge this to a 'trap' cla |
| use.                     |
|               q|Q ) exit |
|  $E_USER_EXIT;;  # Exerc |
| ise for the reader?      |
|                 * ) URLS |
| =" $REPLY";;             |
|            esac          |
|                          |
|            echo ""       |
|     done                 |
|                          |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-31. A *podcasting* script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #  bashpodder.sh:    |
|     #  By Linc 10/1/2004 |
|     #  Find the latest s |
| cript at                 |
|     #+ http://linc.homeu |
| nix.org:8080/scripts/bas |
| hpodder                  |
|     #  Last revision 12/ |
| 14/2004 - Many Contribut |
| ors!                     |
|     #  If you use this a |
| nd have made improvement |
| s or have comments       |
|     #+ drop me an email  |
| at linc dot fessenden at |
|  gmail dot com           |
|     #  I'd appreciate it |
| !                        |
|                          |
|     # ==>  ABS Guide ext |
| ra comments.             |
|                          |
|     # ==>  Author of thi |
| s script has kindly gran |
| ted permission           |
|     # ==>+ for inclusion |
|  in ABS Guide.           |
|                          |
|                          |
|     # ==> ############## |
| ######################## |
| ######################## |
| ##                       |
|     #                    |
|     # ==> What is "podca |
| sting"?                  |
|                          |
|     # ==> It's broadcast |
| ing "radio shows" over t |
| he Internet.             |
|     # ==> These shows ca |
| n be played on iPods and |
|  other music file player |
| s.                       |
|                          |
|     # ==> This script ma |
| kes it possible.         |
|     # ==> See documentat |
| ion at the script author |
| 's site, above.          |
|                          |
|     # ==> ############## |
| ######################## |
| ######################## |
| ##                       |
|                          |
|                          |
|     # Make script cronta |
| b friendly:              |
|     cd $(dirname $0)     |
|     # ==> Change to dire |
| ctory where this script  |
| lives.                   |
|                          |
|     # datadir is the dir |
| ectory you want podcasts |
|  saved to:               |
|     datadir=$(date +%Y-% |
| m-%d)                    |
|     # ==> Will create a  |
| date-labeled directory,  |
| named: YYYY-MM-DD        |
|                          |
|     # Check for and crea |
| te datadir if necessary: |
|     if test ! -d $datadi |
| r                        |
|             then         |
|             mkdir $datad |
| ir                       |
|     fi                   |
|                          |
|     # Delete any temp fi |
| le:                      |
|     rm -f temp.log       |
|                          |
|     #  Read the bp.conf  |
| file and wget any url no |
| t already                |
|     #+ in the podcast.lo |
| g file:                  |
|     while read podcast   |
|       do # ==> Main acti |
| on follows.              |
|       file=$(wget -q $po |
| dcast -O - | tr '\r' '\n |
| ' | tr \' \" | \         |
|     sed -n 's/.*url="\([ |
| ^"]*\)".*/\1/p')         |
|       for url in $file   |
|                     do   |
|                     echo |
|  $url >> temp.log        |
|                     if ! |
|  grep "$url" podcast.log |
|  > /dev/null             |
|                          |
|     then                 |
|                          |
|     wget -q -P $datadir  |
| "$url"                   |
|                     fi   |
|                     done |
|         done < bp.conf   |
|                          |
|     # Move dynamically c |
| reated log file to perma |
| nent log file:           |
|     cat podcast.log >> t |
| emp.log                  |
|     sort temp.log | uniq |
|  > podcast.log           |
|     rm temp.log          |
|     # Create an m3u play |
| list:                    |
|     ls $datadir | grep - |
| v m3u > $datadir/podcast |
| .m3u                     |
|                          |
|                          |
|     exit 0               |
|                          |
|     #################### |
| ######################## |
| #####                    |
|     For a different scri |
| pting approach to Podcas |
| ting,                    |
|     see Phil Salkie's ar |
| ticle,                   |
|     "Internet Radio to P |
| odcast with Shell Tools" |
|     in the September, 20 |
| 05 issue of LINUX JOURNA |
| L,                       |
|     http://www.linuxjour |
| nal.com/article/8171     |
|     #################### |
| ######################## |
| #####                    |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-32. Nightly backup to a firewire HD**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # nightly-backup.sh  |
|     # http://www.richard |
| neill.org/source.php#nig |
| htly-backup-rsync        |
|     # Copyright (c) 2005 |
|  Richard Neill <backup@r |
| ichardneill.org>.        |
|     # This is Free Softw |
| are licensed under the G |
| NU GPL.                  |
|     # ==> Included in AB |
| S Guide with script auth |
| or's kind permission.    |
|     # ==> (Thanks!)      |
|                          |
|     #  This does a backu |
| p from the host computer |
|  to a locally connected  |
|     #+ firewire HDD usin |
| g rsync and ssh.         |
|     #  (Script should wo |
| rk with USB-connected de |
| vice (see lines 40-43).  |
|     #  It then rotates t |
| he backups.              |
|     #  Run it via cron e |
| very night at 5am.       |
|     #  This only backs u |
| p the home directory.    |
|     #  If ownerships (ot |
| her than the user's) sho |
| uld be preserved,        |
|     #+ then run the rsyn |
| c process as root (and r |
| e-instate the -o).       |
|     #  We save every day |
|  for 7 days, then every  |
| week for 4 weeks,        |
|     #+ then every month  |
| for 3 months.            |
|                          |
|     #  See: http://www.m |
| ikerubel.org/computers/r |
| sync_snapshots/          |
|     #+ for more explanat |
| ion of the theory.       |
|     #  Save as: $HOME/bi |
| n/nightly-backup_firewir |
| e-hdd.sh                 |
|                          |
|     #  Known bugs:       |
|     #  ----------        |
|     #  i)  Ideally, we w |
| ant to exclude ~/.tmp an |
| d the browser caches.    |
|                          |
|     #  ii) If the user i |
| s sitting at the compute |
| r at 5am,                |
|     #+     and files are |
|  modified while the rsyn |
| c is occurring,          |
|     #+     then the BACK |
| UP_JUSTINCASE branch get |
| s triggered.             |
|     #      To some exten |
| t, this is a             |
|     #+     feature, but  |
| it also causes a "disk-s |
| pace leak".              |
|                          |
|                          |
|                          |
|                          |
|                          |
|     ##### BEGIN CONFIGUR |
| ATION SECTION ########## |
| ######################## |
| ##########               |
|     LOCAL_USER=rjn       |
|           # User whose h |
| ome directory should be  |
| backed up.               |
|     MOUNT_POINT=/backup  |
|           # Mountpoint o |
| f backup drive.          |
|                          |
|           # NO trailing  |
| slash!                   |
|                          |
|           # This must be |
|  unique (eg using a udev |
|  symlink)                |
|     # MOUNT_POINT=/media |
| /disk     # For USB-conn |
| ected device.            |
|     SOURCE_DIR=/home/$LO |
| CAL_USER  # NO trailing  |
| slash - it DOES matter t |
| o rsync.                 |
|     BACKUP_DEST_DIR=$MOU |
| NT_POINT/backup/`hostnam |
| e -s`.${LOCAL_USER}.nigh |
| tly_backup               |
|     DRY_RUN=false        |
|           #If true, invo |
| ke rsync with -n, to do  |
| a dry run.               |
|                          |
|           # Comment out  |
| or set to false for norm |
| al use.                  |
|     VERBOSE=false        |
|           # If true, mak |
| e rsync verbose.         |
|                          |
|           # Comment out  |
| or set to false otherwis |
| e.                       |
|     COMPRESS=false       |
|           # If true, com |
| press.                   |
|                          |
|           # Good for int |
| ernet, bad on LAN.       |
|                          |
|           # Comment out  |
| or set to false otherwis |
| e.                       |
|                          |
|     ### Exit Codes ###   |
|     E_VARS_NOT_SET=64    |
|     E_COMMANDLINE=65     |
|     E_MOUNT_FAIL=70      |
|     E_NOSOURCEDIR=71     |
|     E_UNMOUNTED=72       |
|     E_BACKUP=73          |
|     ##### END CONFIGURAT |
| ION SECTION ############ |
| ######################## |
| ##########               |
|                          |
|                          |
|     # Check that all the |
|  important variables hav |
| e been set:              |
|     if [ -z "$LOCAL_USER |
| " ] ||                   |
|        [ -z "$SOURCE_DIR |
| " ] ||                   |
|        [ -z "$MOUNT_POIN |
| T" ]  ||                 |
|        [ -z "$BACKUP_DES |
| T_DIR" ]                 |
|     then                 |
|        echo 'One of the  |
| variables is not set! Ed |
| it the file: $0. BACKUP  |
| FAILED.'                 |
|        exit $E_VARS_NOT_ |
| SET                      |
|     fi                   |
|                          |
|     if [ "$#" != 0 ]  #  |
| If command-line param(s) |
|  . . .                   |
|     then              #  |
| Here document(ation).    |
|       cat <<-ENDOFTEXT   |
|         Automatic Nightl |
| y backup run from cron.  |
|         Read the source  |
| for more details: $0     |
|         The backup direc |
| tory is $BACKUP_DEST_DIR |
|  .                       |
|         It will be creat |
| ed if necessary; initial |
| isation is no longer req |
| uired.                   |
|                          |
|         WARNING: Content |
| s of $BACKUP_DEST_DIR ar |
| e rotated.               |
|         Directories name |
| d 'backup.\$i' will even |
| tually be DELETED.       |
|         We keep backups  |
| from every day for 7 day |
| s (1-8),                 |
|         then every week  |
| for 4 weeks (9-12),      |
|         then every month |
|  for 3 months (13-15).   |
|                          |
|         You may wish to  |
| add this to your crontab |
|  using 'crontab -e'      |
|         #  Back up files |
| : $SOURCE_DIR to $BACKUP |
| _DEST_DIR                |
|         #+ every night a |
| t 3:15 am                |
|              15 03 * * * |
|  /home/$LOCAL_USER/bin/n |
| ightly-backup_firewire-h |
| dd.sh                    |
|                          |
|         Don't forget to  |
| verify the backups are w |
| orking,                  |
|         especially if yo |
| u don't read cron's mail |
| !"                       |
|         ENDOFTEXT        |
|        exit $E_COMMANDLI |
| NE                       |
|     fi                   |
|                          |
|                          |
|     # Parse the options. |
|     # ================== |
|                          |
|     if [ "$DRY_RUN" == " |
| true" ]; then            |
|       DRY_RUN="-n"       |
|       echo "WARNING:"    |
|       echo "THIS IS A 'D |
| RY RUN'!"                |
|       echo "No data will |
|  actually be transferred |
| !"                       |
|     else                 |
|       DRY_RUN=""         |
|     fi                   |
|                          |
|     if [ "$VERBOSE" == " |
| true" ]; then            |
|       VERBOSE="-v"       |
|     else                 |
|       VERBOSE=""         |
|     fi                   |
|                          |
|     if [ "$COMPRESS" ==  |
| "true" ]; then           |
|       COMPRESS="-z"      |
|     else                 |
|       COMPRESS=""        |
|     fi                   |
|                          |
|                          |
|     #  Every week (actua |
| lly of 8 days) and every |
|  month,                  |
|     #+ extra backups are |
|  preserved.              |
|     DAY_OF_MONTH=`date + |
| %d`            # Day of  |
| month (01..31).          |
|     if [ $DAY_OF_MONTH = |
|  01 ]; then    # First o |
| f month.                 |
|       MONTHSTART=true    |
|     elif [ $DAY_OF_MONTH |
|  = 08 \                  |
|         -o $DAY_OF_MONTH |
|  = 16 \                  |
|         -o $DAY_OF_MONTH |
|  = 24 ]; then            |
|         # Day 8,16,24  ( |
| use 8, not 7 to better h |
| andle 31-day months)     |
|           WEEKSTART=true |
|     fi                   |
|                          |
|                          |
|                          |
|     #  Check that the HD |
| D is mounted.            |
|     #  At least, check t |
| hat *something* is mount |
| ed here!                 |
|     #  We can use someth |
| ing unique to the device |
| , rather than just guess |
| ing                      |
|     #+ the scsi-id by ha |
| ving an appropriate udev |
|  rule in                 |
|     #+ /etc/udev/rules.d |
| /10-rules.local          |
|     #+ and by putting a  |
| relevant entry in /etc/f |
| stab.                    |
|     #  Eg: this udev rul |
| e:                       |
|     # BUS="scsi", KERNEL |
| ="sd*", SYSFS{vendor}="W |
| DC WD16",                |
|     # SYSFS{model}="00JB |
| -00GVA0     ", NAME="%k" |
| , SYMLINK="lacie_1394d%n |
| "                        |
|                          |
|     if mount | grep $MOU |
| NT_POINT >/dev/null; the |
| n                        |
|       echo "Mount point  |
| $MOUNT_POINT is indeed m |
| ounted. OK"              |
|     else                 |
|       echo -n "Attemptin |
| g to mount $MOUNT_POINT. |
| .."                      |
|                # If it i |
| sn't mounted, try to mou |
| nt it.                   |
|       sudo mount $MOUNT_ |
| POINT 2>/dev/null        |
|                          |
|       if mount | grep $M |
| OUNT_POINT >/dev/null; t |
| hen                      |
|         UNMOUNT_LATER=TR |
| UE                       |
|         echo "OK"        |
|         #  Note: Ensure  |
| that this is also unmoun |
| ted                      |
|         #+ if we exit pr |
| ematurely with failure.  |
|       else               |
|         echo "FAILED"    |
|         echo -e "Nothing |
|  is mounted at $MOUNT_PO |
| INT. BACKUP FAILED!"     |
|         exit $E_MOUNT_FA |
| IL                       |
|       fi                 |
|     fi                   |
|                          |
|                          |
|     # Check that source  |
| dir exists and is readab |
| le.                      |
|     if [ ! -r  $SOURCE_D |
| IR ] ; then              |
|       echo "$SOURCE_DIR  |
| does not exist, or canno |
| t be read. BACKUP FAILED |
| ."                       |
|       exit $E_NOSOURCEDI |
| R                        |
|     fi                   |
|                          |
|                          |
|     # Check that the bac |
| kup directory structure  |
| is as it should be.      |
|     # If not, create it. |
|     # Create the subdire |
| ctories.                 |
|     # Note that backup.0 |
|  will be created as need |
| ed by rsync.             |
|                          |
|     for ((i=1;i<=15;i++) |
| ); do                    |
|       if [ ! -d $BACKUP_ |
| DEST_DIR/backup.$i ]; th |
| en                       |
|         if /bin/mkdir -p |
|  $BACKUP_DEST_DIR/backup |
| .$i ; then               |
|         #  ^^^^^^^^^^^^^ |
| ^^^^^^^^^^^^^^^^^^^^^^^^ |
| ^^^  No [ ] test bracket |
| s. Why?                  |
|           echo "Warning: |
|  directory $BACKUP_DEST_ |
| DIR/backup.$i is missing |
| ,"                       |
|           echo "or was n |
| ot initialised. (Re-)cre |
| ating it."               |
|         else             |
|           echo "ERROR: d |
| irectory $BACKUP_DEST_DI |
| R/backup.$i"             |
|           echo "is missi |
| ng and could not be crea |
| ted."                    |
|         if  [ "$UNMOUNT_ |
| LATER" == "TRUE" ]; then |
|             # Before we  |
| exit, unmount the mount  |
| point if necessary.      |
|             cd           |
|         sudo umount $MOU |
| NT_POINT &&              |
|         echo "Unmounted  |
| $MOUNT_POINT again. Givi |
| ng up."                  |
|         fi               |
|           exit $E_UNMOUN |
| TED                      |
|       fi                 |
|     fi                   |
|     done                 |
|                          |
|                          |
|     #  Set the permissio |
| n to 700 for security    |
|     #+ on an otherwise p |
| ermissive multi-user sys |
| tem.                     |
|     if ! /bin/chmod 700  |
| $BACKUP_DEST_DIR ; then  |
|       echo "ERROR: Could |
|  not set permissions on  |
| $BACKUP_DEST_DIR to 700. |
| "                        |
|                          |
|       if  [ "$UNMOUNT_LA |
| TER" == "TRUE" ]; then   |
|       # Before we exit,  |
| unmount the mount point  |
| if necessary.            |
|          cd ; sudo umoun |
| t $MOUNT_POINT \         |
|          && echo "Unmoun |
| ted $MOUNT_POINT again.  |
| Giving up."              |
|       fi                 |
|                          |
|       exit $E_UNMOUNTED  |
|     fi                   |
|                          |
|     # Create the symlink |
| : current -> backup.1 if |
|  required.               |
|     # A failure here is  |
| not critical.            |
|     cd $BACKUP_DEST_DIR  |
|     if [ ! -h current ]  |
| ; then                   |
|       if ! /bin/ln -s ba |
| ckup.1 current ; then    |
|         echo "WARNING: c |
| ould not create symlink  |
| current -> backup.1"     |
|       fi                 |
|     fi                   |
|                          |
|                          |
|     # Now, do the rsync. |
|     echo "Now doing back |
| up with rsync..."        |
|     echo "Source dir: $S |
| OURCE_DIR"               |
|     echo -e "Backup dest |
| ination dir: $BACKUP_DES |
| T_DIR\n"                 |
|                          |
|                          |
|     /usr/bin/rsync $DRY_ |
| RUN $VERBOSE -a -S --del |
| ete --modify-window=60 \ |
|     --link-dest=../backu |
| p.1 $SOURCE_DIR $BACKUP_ |
| DEST_DIR/backup.0/       |
|                          |
|     #  Only warn, rather |
|  than exit if the rsync  |
| failed,                  |
|     #+ since it may only |
|  be a minor problem.     |
|     #  E.g., if one file |
|  is not readable, rsync  |
| will fail.               |
|     #  This shouldn't pr |
| event the rotation.      |
|     #  Not using, e.g.,  |
| `date +%a`  since these  |
| directories              |
|     #+ are just full of  |
| links and don't consume  |
| *that much* space.       |
|                          |
|     if [ $? != 0 ]; then |
|       BACKUP_JUSTINCASE= |
| backup.`date +%F_%T`.jus |
| tincase                  |
|       echo "WARNING: the |
|  rsync process did not e |
| ntirely succeed."        |
|       echo "Something mi |
| ght be wrong."           |
|       echo "Saving an ex |
| tra copy at: $BACKUP_JUS |
| TINCASE"                 |
|       echo "WARNING: if  |
| this occurs regularly, a |
|  LOT of space will be co |
| nsumed,"                 |
|       echo "even though  |
| these are just hard-link |
| s!"                      |
|     fi                   |
|                          |
|     # Save a readme in t |
| he backup parent directo |
| ry.                      |
|     # Save another one i |
| n the recent subdirector |
| y.                       |
|     echo "Backup of $SOU |
| RCE_DIR on `hostname` wa |
| s last run on \          |
|     `date`" > $BACKUP_DE |
| ST_DIR/README.txt        |
|     echo "This backup of |
|  $SOURCE_DIR on `hostnam |
| e` was created on \      |
|     `date`" > $BACKUP_DE |
| ST_DIR/backup.0/README.t |
| xt                       |
|                          |
|     # If we are not in a |
|  dry run, rotate the bac |
| kups.                    |
|     [ -z "$DRY_RUN" ] && |
|                          |
|       #  Check how full  |
| the backup disk is.      |
|       #  Warn if 90%. if |
|  98% or more, we'll prob |
| ably fail, so give up.   |
|       #  (Note: df can o |
| utput to more than one l |
| ine.)                    |
|       #  We test this he |
| re, rather than before   |
|       #+ so that rsync m |
| ay possibly have a chanc |
| e.                       |
|       DISK_FULL_PERCENT= |
| `/bin/df $BACKUP_DEST_DI |
| R |                      |
|       tr "\n" ' ' | awk  |
| '{print $12}' | grep -oE |
|  [0-9]+ `                |
|       echo "Disk space c |
| heck on backup partition |
|  \                       |
|       $MOUNT_POINT $DISK |
| _FULL_PERCENT% full."    |
|       if [ $DISK_FULL_PE |
| RCENT -gt 90 ]; then     |
|         echo "Warning: D |
| isk is greater than 90%  |
| full."                   |
|       fi                 |
|       if [ $DISK_FULL_PE |
| RCENT -gt 98 ]; then     |
|         echo "Error: Dis |
| k is full! Giving up."   |
|           if  [ "$UNMOUN |
| T_LATER" == "TRUE" ]; th |
| en                       |
|             # Before we  |
| exit, unmount the mount  |
| point if necessary.      |
|             cd; sudo umo |
| unt $MOUNT_POINT &&      |
|             echo "Unmoun |
| ted $MOUNT_POINT again.  |
| Giving up."              |
|           fi             |
|         exit $E_UNMOUNTE |
| D                        |
|       fi                 |
|                          |
|                          |
|      # Create an extra b |
| ackup.                   |
|      # If this copy fail |
| s, give up.              |
|      if [ -n "$BACKUP_JU |
| STINCASE" ]; then        |
|        if ! /bin/cp -al  |
| $BACKUP_DEST_DIR/backup. |
| 0 \                      |
|           $BACKUP_DEST_D |
| IR/$BACKUP_JUSTINCASE    |
|        then              |
|          echo "ERROR: Fa |
| iled to create extra cop |
| y \                      |
|          $BACKUP_DEST_DI |
| R/$BACKUP_JUSTINCASE"    |
|          if  [ "$UNMOUNT |
| _LATER" == "TRUE" ]; the |
| n                        |
|            # Before we e |
| xit, unmount the mount p |
| oint if necessary.       |
|            cd ;sudo umou |
| nt $MOUNT_POINT &&       |
|            echo "Unmount |
| ed $MOUNT_POINT again. G |
| iving up."               |
|          fi              |
|          exit $E_UNMOUNT |
| ED                       |
|        fi                |
|      fi                  |
|                          |
|                          |
|      # At start of month |
| , rotate the oldest 8.   |
|      if [ "$MONTHSTART"  |
| == "true" ]; then        |
|        echo -e "\nStart  |
| of month. \              |
|        Removing oldest b |
| ackup: $BACKUP_DEST_DIR/ |
| backup.15"  &&           |
|        /bin/rm -rf  $BAC |
| KUP_DEST_DIR/backup.15   |
| &&                       |
|        echo "Rotating mo |
| nthly,weekly backups: \  |
|        $BACKUP_DEST_DIR/ |
| backup.[8-14] -> $BACKUP |
| _DEST_DIR/backup.[9-15]" |
|   &&                     |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.14 $BAC |
| KUP_DEST_DIR/backup.15   |
| &&                       |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.13 $BAC |
| KUP_DEST_DIR/backup.14   |
| &&                       |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.12 $BAC |
| KUP_DEST_DIR/backup.13   |
| &&                       |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.11 $BAC |
| KUP_DEST_DIR/backup.12   |
| &&                       |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.10 $BAC |
| KUP_DEST_DIR/backup.11   |
| &&                       |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.9 $BACK |
| UP_DEST_DIR/backup.10  & |
| &                        |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.8 $BACK |
| UP_DEST_DIR/backup.9     |
|                          |
|      # At start of week, |
|  rotate the second-oldes |
| t 4.                     |
|      elif [ "$WEEKSTART" |
|  == "true" ]; then       |
|        echo -e "\nStart  |
| of week. \               |
|        Removing oldest w |
| eekly backup: $BACKUP_DE |
| ST_DIR/backup.12"  &&    |
|        /bin/rm -rf  $BAC |
| KUP_DEST_DIR/backup.12   |
| &&                       |
|                          |
|        echo "Rotating we |
| ekly backups: \          |
|        $BACKUP_DEST_DIR/ |
| backup.[8-11] -> $BACKUP |
| _DEST_DIR/backup.[9-12]" |
|   &&                     |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.11 $BAC |
| KUP_DEST_DIR/backup.12   |
| &&                       |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.10 $BAC |
| KUP_DEST_DIR/backup.11   |
| &&                       |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.9 $BACK |
| UP_DEST_DIR/backup.10  & |
| &                        |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.8 $BACK |
| UP_DEST_DIR/backup.9     |
|                          |
|      else                |
|        echo -e "\nRemovi |
| ng oldest daily backup:  |
| $BACKUP_DEST_DIR/backup. |
| 8"  &&                   |
|          /bin/rm -rf  $B |
| ACKUP_DEST_DIR/backup.8  |
|                          |
|      fi  &&              |
|                          |
|      # Every day, rotate |
|  the newest 8.           |
|      echo "Rotating dail |
| y backups: \             |
|      $BACKUP_DEST_DIR/ba |
| ckup.[1-7] -> $BACKUP_DE |
| ST_DIR/backup.[2-8]"  && |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.7 $BACK |
| UP_DEST_DIR/backup.8  && |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.6 $BACK |
| UP_DEST_DIR/backup.7  && |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.5 $BACK |
| UP_DEST_DIR/backup.6  && |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.4 $BACK |
| UP_DEST_DIR/backup.5  && |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.3 $BACK |
| UP_DEST_DIR/backup.4  && |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.2 $BACK |
| UP_DEST_DIR/backup.3  && |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.1 $BACK |
| UP_DEST_DIR/backup.2  && |
|          /bin/mv $BACKUP |
| _DEST_DIR/backup.0 $BACK |
| UP_DEST_DIR/backup.1  && |
|                          |
|      SUCCESS=true        |
|                          |
|                          |
|     if  [ "$UNMOUNT_LATE |
| R" == "TRUE" ]; then     |
|       # Unmount the moun |
| t point if it wasn't mou |
| nted to begin with.      |
|       cd ; sudo umount $ |
| MOUNT_POINT && echo "Unm |
| ounted $MOUNT_POINT agai |
| n."                      |
|     fi                   |
|                          |
|                          |
|     if [ "$SUCCESS" == " |
| true" ]; then            |
|       echo 'SUCCESS!'    |
|       exit 0             |
|     fi                   |
|                          |
|     # Should have alread |
| y exited if backup worke |
| d.                       |
|     echo 'BACKUP FAILED! |
|  Is this just a dry run? |
|  Is the disk full?) '    |
|     exit $E_BACKUP       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-33. An expanded *cd* command**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #################### |
| ######################## |
| ######################## |
| #######                  |
|     #                    |
|     #       cdll         |
|     #       by Phil Brah |
| am                       |
|     #                    |
|     #       ############ |
| ######################## |
| ########                 |
|     #       Latest versi |
| on of this script availa |
| ble from                 |
|     #       http://fresh |
| meat.net/projects/cd/    |
|     #       ############ |
| ######################## |
| ########                 |
|     #                    |
|     #       .cd_new      |
|     #                    |
|     #       An enhanceme |
| nt of the Unix cd comman |
| d                        |
|     #                    |
|     #       There are un |
| limited stack entries an |
| d special entries. The s |
| tack                     |
|     #       entries keep |
|  the last cd_maxhistory  |
|     #       directories  |
| that have been used. The |
|  special entries can be  |
|     #       assigned to  |
| commonly used directorie |
| s.                       |
|     #                    |
|     #       The special  |
| entries may be pre-assig |
| ned by setting the envir |
| onment                   |
|     #       variables CD |
| Sn or by using the -u or |
|  -U command.             |
|     #                    |
|     #       The followin |
| g is a suggestion for th |
| e .profile file:         |
|     #                    |
|     #               . cd |
| ll              #  Set u |
| p the cd command         |
|     #       alias cd='cd |
| _new'           #  Repla |
| ce the cd command        |
|     #               cd - |
| U               #  Uploa |
| d pre-assigned entries f |
| or                       |
|     #                    |
|                 #+ the s |
| tack and special entries |
|     #               cd - |
| D               #  Set n |
| on-default mode          |
|     #               alia |
| s @="cd_new @"  #  Allow |
|  @ to be used to get his |
| tory                     |
|     #                    |
|     #       For help typ |
| e:                       |
|     #                    |
|     #               cd - |
| h or                     |
|     #               cd - |
| H                        |
|     #                    |
|     #                    |
|     #################### |
| ######################## |
| ######################## |
| #######                  |
|     #                    |
|     #       Version 1.2. |
| 1                        |
|     #                    |
|     #       Written by P |
| hil Braham - Realtime So |
| ftware Pty Ltd           |
|     #       (realtime@mp |
| x.com.au)                |
|     #       Please send  |
| any suggestions or enhan |
| cements to the author (a |
| lso at                   |
|     #       phil@braham. |
| net)                     |
|     #                    |
|     #################### |
| ######################## |
| ######################## |
| ########                 |
|                          |
|     cd_hm ()             |
|     {                    |
|             ${PRINTF} "% |
| s" "cd [dir] [0-9] [@[s| |
| h] [-g [<dir>]] [-d] \   |
|     [-D] [-r<n>] [dir|0- |
| 9] [-R<n>] [<dir>|0-9]   |
|        [-s<n>] [-S<n>] [ |
| -u] [-U] [-f] [-F] [-h]  |
| [-H] [-v]                |
|         <dir> Go to dire |
| ctory                    |
|         0-n         Go t |
| o previous directory (0  |
| is previous, 1 is last b |
| ut 1 etc)                |
|                     n is |
|  up to max history (defa |
| ult is 50)               |
|         @           List |
|  history and special ent |
| ries                     |
|         @h          List |
|  history entries         |
|         @s          List |
|  special entries         |
|         -g [<dir>]  Go t |
| o literal name (bypass s |
| pecial names)            |
|                     This |
|  is to allow access to d |
| irs called '0','1','-h'  |
| etc                      |
|         -d          Chan |
| ge default action - verb |
| ose. (See note)          |
|         -D          Chan |
| ge default action - sile |
| nt. (See note)           |
|         -s<n> Go to the  |
| special entry <n>*       |
|         -S<n> Go to the  |
| special entry <n>        |
|                     and  |
| replace it with the curr |
| ent dir*                 |
|         -r<n> [<dir>] Go |
|  to directory <dir>      |
|                          |
|           and then put i |
| t on special entry <n>*  |
|         -R<n> [<dir>] Go |
|  to directory <dir>      |
|                          |
|           and put curren |
| t dir on special entry < |
| n>*                      |
|         -a<n>       Alte |
| rnative suggested direct |
| ory. See note below.     |
|         -f [<file>] File |
|  entries to <file>.      |
|         -u [<file>] Upda |
| te entries from <file>.  |
|                     If n |
| o filename supplied then |
|  default file            |
|                     (${C |
| DPath}${2:-"$CDFile"}) i |
| s used                   |
|                     -F a |
| nd -U are silent version |
| s                        |
|         -v          Prin |
| t version number         |
|         -h          Help |
|         -H          Deta |
| iled help                |
|                          |
|         *The special ent |
| ries (0 - 9) are held un |
| til log off, replaced by |
|  another                 |
|          entry or update |
| d with the -u command    |
|                          |
|         Alternative sugg |
| ested directories:       |
|         If a directory i |
| s not found then CD will |
|  suggest any             |
|         possibilities. T |
| hese are directories sta |
| rting with the same lett |
| ers                      |
|         and if any are f |
| ound they are listed pre |
| fixed with -a<n>         |
|         where <n> is a n |
| umber.                   |
|         It's possible to |
|  go to the directory by  |
| entering cd -a<n>        |
|         on the command l |
| ine.                     |
|                          |
|         The directory fo |
| r -r<n> or -R<n> may be  |
| a number.                |
|         For example:     |
|             $ cd -r3 4   |
| Go to history entry 4 an |
| d put it on special entr |
| y 3                      |
|             $ cd -R3 4   |
| Put current dir on the s |
| pecial entry 3           |
|                          |
| and go to history entry  |
| 4                        |
|             $ cd -s3     |
| Go to special entry 3    |
|                          |
|         Note that comman |
| ds R,r,S and s may be us |
| ed without a number      |
|         and refer to 0:  |
|             $ cd -s      |
| Go to special entry 0    |
|             $ cd -S      |
| Go to special entry 0 an |
| d make special           |
|                          |
| entry 0 current dir      |
|             $ cd -r 1    |
| Go to history entry 1 an |
| d put it on special entr |
| y 0                      |
|             $ cd -r      |
| Go to history entry 0 an |
| d put it on special entr |
| y 0                      |
|         "                |
|             if ${TEST} " |
| $CD_MODE" = "PREV"       |
|             then         |
|                     ${PR |
| INTF} "$cd_mnset"        |
|             else         |
|                     ${PR |
| INTF} "$cd_mset"         |
|             fi           |
|     }                    |
|                          |
|     cd_Hm ()             |
|     {                    |
|             cd_hm        |
|             ${PRINTF} "% |
| s" "                     |
|             The previous |
|  directories (0-$cd_maxh |
| istory) are stored in th |
| e                        |
|             environment  |
| variables CD[0] - CD[$cd |
| _maxhistory]             |
|             Similarly th |
| e special directories S0 |
|  - $cd_maxspecial are in |
|             the environm |
| ent variable CDS[0] - CD |
| S[$cd_maxspecial]        |
|             and may be a |
| ccessed from the command |
|  line                    |
|                          |
|             The default  |
| pathname for the -f and  |
| -u commands is $CDPath   |
|             The default  |
| filename for the -f and  |
| -u commands is $CDFile   |
|                          |
|             Set the foll |
| owing environment variab |
| les:                     |
|                 CDL_PROM |
| PTLEN  - Set to the leng |
| th of prompt you require |
| .                        |
|                     Prom |
| pt string is set to the  |
| right characters of the  |
|                     curr |
| ent directory.           |
|                     If n |
| ot set then prompt is le |
| ft unchanged             |
|                 CDL_PROM |
| PT_PRE - Set to the stri |
| ng to prefix the prompt. |
|                     Defa |
| ult is:                  |
|                          |
| non-root:  \"\\[\\e[01;3 |
| 4m\\]\"  (sets colour to |
|  blue).                  |
|                          |
| root:      \"\\[\\e[01;3 |
| 1m\\]\"  (sets colour to |
|  red).                   |
|                 CDL_PROM |
| PT_POST    - Set to the  |
| string to suffix the pro |
| mpt.                     |
|                     Defa |
| ult is:                  |
|                          |
| non-root:  \"\\[\\e[00m\ |
| \]$\"                    |
|                          |
|             (resets colo |
| ur and displays $).      |
|                          |
| root:      \"\\[\\e[00m\ |
| \]#\"                    |
|                          |
|             (resets colo |
| ur and displays #).      |
|                 CDPath - |
|  Set the default path fo |
| r the -f & -u options.   |
|                          |
|  Default is home directo |
| ry                       |
|                 CDFile - |
|  Set the default filenam |
| e for the -f & -u option |
| s.                       |
|                          |
|  Default is cdfile       |
|                          |
|     "                    |
|         cd_version       |
|                          |
|     }                    |
|                          |
|     cd_version ()        |
|     {                    |
|      printf "Version: ${ |
| VERSION_MAJOR}.${VERSION |
| _MINOR} Date: ${VERSION_ |
| DATE}\n"                 |
|     }                    |
|                          |
|     #                    |
|     # Truncate right.    |
|     #                    |
|     # params:            |
|     #   p1 - string      |
|     #   p2 - length to t |
| runcate to               |
|     #                    |
|     # returns string in  |
| tcd                      |
|     #                    |
|     cd_right_trunc ()    |
|     {                    |
|         local tlen=${2}  |
|         local plen=${#1} |
|         local str="${1}" |
|         local diff       |
|         local filler="<- |
| -"                       |
|         if ${TEST} ${ple |
| n} -le ${tlen}           |
|         then             |
|             tcd="${str}" |
|         else             |
|             let diff=${p |
| len}-${tlen}             |
|             elen=3       |
|             if ${TEST} $ |
| {diff} -le 2             |
|             then         |
|                 let elen |
| =${diff}                 |
|             fi           |
|             tlen=-${tlen |
| }                        |
|             let tlen=${t |
| len}+${elen}             |
|             tcd=${filler |
| :0:elen}${str:tlen}      |
|         fi               |
|     }                    |
|                          |
|     #                    |
|     # Three versions of  |
| do history:              |
|     #    cd_dohistory  - |
|  packs history and speci |
| als side by side         |
|     #    cd_dohistoryH - |
|  Shows only hstory       |
|     #    cd_dohistoryS - |
|  Shows only specials     |
|     #                    |
|     cd_dohistory ()      |
|     {                    |
|         cd_getrc         |
|             ${PRINTF} "H |
| istory:\n"               |
|         local -i count=$ |
| {cd_histcount}           |
|         while ${TEST} ${ |
| count} -ge 0             |
|         do               |
|             cd_right_tru |
| nc "${CD[count]}" ${cd_l |
| char}                    |
|                 ${PRINTF |
| } "%2d %-${cd_lchar}.${c |
| d_lchar}s " ${count} "${ |
| tcd}"                    |
|                          |
|             cd_right_tru |
| nc "${CDS[count]}" ${cd_ |
| rchar}                   |
|                 ${PRINTF |
| } "S%d %-${cd_rchar}.${c |
| d_rchar}s\n" ${count} "$ |
| {tcd}"                   |
|             count=${coun |
| t}-1                     |
|         done             |
|     }                    |
|                          |
|     cd_dohistoryH ()     |
|     {                    |
|         cd_getrc         |
|             ${PRINTF} "H |
| istory:\n"               |
|             local -i cou |
| nt=${cd_maxhistory}      |
|             while ${TEST |
| } ${count} -ge 0         |
|             do           |
|               ${PRINTF}  |
| "${count} %-${cd_flchar} |
| .${cd_flchar}s\n" ${CD[$ |
| count]}                  |
|               count=${co |
| unt}-1                   |
|             done         |
|     }                    |
|                          |
|     cd_dohistoryS ()     |
|     {                    |
|         cd_getrc         |
|             ${PRINTF} "S |
| pecials:\n"              |
|             local -i cou |
| nt=${cd_maxspecial}      |
|             while ${TEST |
| } ${count} -ge 0         |
|             do           |
|               ${PRINTF}  |
| "S${count} %-${cd_flchar |
| }.${cd_flchar}s\n" ${CDS |
| [$count]}                |
|               count=${co |
| unt}-1                   |
|             done         |
|     }                    |
|                          |
|     cd_getrc ()          |
|     {                    |
|         cd_flchar=$(stty |
|  -a | awk -F \;          |
|         '/rows/ { print  |
| $2 $3 }' | awk -F \  '{  |
| print $4 }')             |
|         if ${TEST} ${cd_ |
| flchar} -ne 0            |
|         then             |
|             cd_lchar=${c |
| d_flchar}/2-5            |
|             cd_rchar=${c |
| d_flchar}/2-5            |
|                 cd_flcha |
| r=${cd_flchar}-5         |
|         else             |
|                 cd_flcha |
| r=${FLCHAR:=75}          |
|             # cd_flchar  |
| is used for for the @s & |
|  @h history              |
|                 cd_lchar |
| =${LCHAR:=35}            |
|                 cd_rchar |
| =${RCHAR:=35}            |
|         fi               |
|     }                    |
|                          |
|     cd_doselection ()    |
|     {                    |
|             local -i nm= |
| 0                        |
|             cd_doflag="T |
| RUE"                     |
|             if ${TEST} " |
| ${CD_MODE}" = "PREV"     |
|             then         |
|                     if $ |
| {TEST} -z "$cd_npwd"     |
|                     then |
|                          |
|     cd_npwd=0            |
|                     fi   |
|             fi           |
|             tm=$(echo "$ |
| {cd_npwd}" | cut -b 1)   |
|         if ${TEST} "${tm |
| }" = "-"                 |
|         then             |
|             pm=$(echo "$ |
| {cd_npwd}" | cut -b 2)   |
|             nm=$(echo "$ |
| {cd_npwd}" | cut -d $pm  |
| -f2)                     |
|             case "${pm}" |
|  in                      |
|                  a) cd_n |
| pwd=${cd_sugg[$nm]} ;;   |
|                  s) cd_n |
| pwd="${CDS[$nm]}" ;;     |
|                  S) cd_n |
| pwd="${CDS[$nm]}" ; CDS[ |
| $nm]=`pwd` ;;            |
|                  r) cd_n |
| pwd="$2" ; cd_specDir=$n |
| m ; cd_doselection "$1"  |
| "$2";;                   |
|                  R) cd_n |
| pwd="$2" ; CDS[$nm]=`pwd |
| ` ; cd_doselection "$1"  |
| "$2";;                   |
|             esac         |
|         fi               |
|                          |
|         if ${TEST} "${cd |
| _npwd}" != "." -a "${cd_ |
| npwd}" \                 |
|     != ".." -a "${cd_npw |
| d}" -le ${cd_maxhistory} |
|  >>/dev/null 2>&1        |
|         then             |
|           cd_npwd=${CD[$ |
| cd_npwd]}                |
|          else            |
|            case "$cd_npw |
| d" in                    |
|                     @)   |
| cd_dohistory ; cd_doflag |
| ="FALSE" ;;              |
|                    @h) c |
| d_dohistoryH ; cd_doflag |
| ="FALSE" ;;              |
|                    @s) c |
| d_dohistoryS ; cd_doflag |
| ="FALSE" ;;              |
|                    -h) c |
| d_hm ; cd_doflag="FALSE" |
|  ;;                      |
|                    -H) c |
| d_Hm ; cd_doflag="FALSE" |
|  ;;                      |
|                    -f) c |
| d_fsave "SHOW" $2 ; cd_d |
| oflag="FALSE" ;;         |
|                    -u) c |
| d_upload "SHOW" $2 ; cd_ |
| doflag="FALSE" ;;        |
|                    -F) c |
| d_fsave "NOSHOW" $2 ; cd |
| _doflag="FALSE" ;;       |
|                    -U) c |
| d_upload "NOSHOW" $2 ; c |
| d_doflag="FALSE" ;;      |
|                    -g) c |
| d_npwd="$2" ;;           |
|                    -d) c |
| d_chdefm 1; cd_doflag="F |
| ALSE" ;;                 |
|                    -D) c |
| d_chdefm 0; cd_doflag="F |
| ALSE" ;;                 |
|                    -r) c |
| d_npwd="$2" ; cd_specDir |
| =0 ; cd_doselection "$1" |
|  "$2";;                  |
|                    -R) c |
| d_npwd="$2" ; CDS[0]=`pw |
| d` ; cd_doselection "$1" |
|  "$2";;                  |
|                    -s) c |
| d_npwd="${CDS[0]}" ;;    |
|                    -S) c |
| d_npwd="${CDS[0]}"  ; CD |
| S[0]=`pwd` ;;            |
|                    -v) c |
| d_version ; cd_doflag="F |
| ALSE";;                  |
|            esac          |
|         fi               |
|     }                    |
|                          |
|     cd_chdefm ()         |
|     {                    |
|             if ${TEST} " |
| ${CD_MODE}" = "PREV"     |
|             then         |
|                     CD_M |
| ODE=""                   |
|                     if $ |
| {TEST} $1 -eq 1          |
|                     then |
|                          |
|     ${PRINTF} "${cd_mset |
| }"                       |
|                     fi   |
|             else         |
|                     CD_M |
| ODE="PREV"               |
|                     if $ |
| {TEST} $1 -eq 1          |
|                     then |
|                          |
|     ${PRINTF} "${cd_mnse |
| t}"                      |
|                     fi   |
|             fi           |
|     }                    |
|                          |
|     cd_fsave ()          |
|     {                    |
|             local sfile= |
| ${CDPath}${2:-"$CDFile"} |
|             if ${TEST} " |
| $1" = "SHOW"             |
|             then         |
|                     ${PR |
| INTF} "Saved to %s\n" $s |
| file                     |
|             fi           |
|             ${RM} -f ${s |
| file}                    |
|             local -i cou |
| nt=0                     |
|             while ${TEST |
| } ${count} -le ${cd_maxh |
| istory}                  |
|             do           |
|                     echo |
|  "CD[$count]=\"${CD[$cou |
| nt]}\"" >> ${sfile}      |
|                     coun |
| t=${count}+1             |
|             done         |
|             count=0      |
|             while ${TEST |
| } ${count} -le ${cd_maxs |
| pecial}                  |
|             do           |
|                     echo |
|  "CDS[$count]=\"${CDS[$c |
| ount]}\"" >> ${sfile}    |
|                     coun |
| t=${count}+1             |
|             done         |
|     }                    |
|                          |
|     cd_upload ()         |
|     {                    |
|             local sfile= |
| ${CDPath}${2:-"$CDFile"} |
|             if ${TEST} " |
| ${1}" = "SHOW"           |
|             then         |
|                     ${PR |
| INTF} "Loading from %s\n |
| " ${sfile}               |
|             fi           |
|             . ${sfile}   |
|     }                    |
|                          |
|     cd_new ()            |
|     {                    |
|         local -i count   |
|         local -i choose= |
| 0                        |
|                          |
|             cd_npwd="${1 |
| }"                       |
|             cd_specDir=- |
| 1                        |
|             cd_doselecti |
| on "${1}" "${2}"         |
|                          |
|             if ${TEST} $ |
| {cd_doflag} = "TRUE"     |
|             then         |
|                     if $ |
| {TEST} "${CD[0]}" != "`p |
| wd`"                     |
|                     then |
|                          |
|     count=$cd_maxhistory |
|                          |
|     while ${TEST} $count |
|  -gt 0                   |
|                          |
|     do                   |
|                          |
|             CD[$count]=$ |
| {CD[$count-1]}           |
|                          |
|             count=${coun |
| t}-1                     |
|                          |
|     done                 |
|                          |
|     CD[0]=`pwd`          |
|                     fi   |
|                     comm |
| and cd "${cd_npwd}" 2>/d |
| ev/null                  |
|             if ${TEST} $ |
| ? -eq 1                  |
|             then         |
|                 ${PRINTF |
| } "Unknown dir: %s\n" "$ |
| {cd_npwd}"               |
|                 local -i |
|  ftflag=0                |
|                 for i in |
|  "${cd_npwd}"*           |
|                 do       |
|                     if $ |
| {TEST} -d "${i}"         |
|                     then |
|                          |
| if ${TEST} ${ftflag} -eq |
|  0                       |
|                          |
| then                     |
|                          |
|     ${PRINTF} "Suggest:\ |
| n"                       |
|                          |
|     ftflag=1             |
|                     fi   |
|                          |
| ${PRINTF} "\t-a${choose} |
|  %s\n" "$i"              |
|                          |
|                     cd_s |
| ugg[$choose]="${i}"      |
|                          |
| choose=${choose}+1       |
|             fi           |
|                 done     |
|             fi           |
|             fi           |
|                          |
|             if ${TEST} $ |
| {cd_specDir} -ne -1      |
|             then         |
|                     CDS[ |
| ${cd_specDir}]=`pwd`     |
|             fi           |
|                          |
|             if ${TEST} ! |
|  -z "${CDL_PROMPTLEN}"   |
|             then         |
|             cd_right_tru |
| nc "${PWD}" ${CDL_PROMPT |
| LEN}                     |
|                 cd_rp=${ |
| CDL_PROMPT_PRE}${tcd}${C |
| DL_PROMPT_POST}          |
|                     expo |
| rt PS1="$(echo -ne ${cd_ |
| rp})"                    |
|             fi           |
|     }                    |
|     #################### |
| ######################## |
| ######################## |
| #####                    |
|     #                    |
|                          |
|                          |
|     #                    |
|     #                    |
|      Initialisation here |
|                          |
|     #                    |
|     #                    |
|                          |
|                          |
|     #                    |
|     #################### |
| ######################## |
| ######################## |
| #####                    |
|     #                    |
|     VERSION_MAJOR="1"    |
|     VERSION_MINOR="2.1"  |
|     VERSION_DATE="24-MAY |
| -2003"                   |
|     #                    |
|     alias cd=cd_new      |
|     #                    |
|     # Set up commands    |
|     RM=/bin/rm           |
|     TEST=test            |
|     PRINTF=printf        |
|        # Use builtin pri |
| ntf                      |
|                          |
|     #################### |
| ######################## |
| ######################## |
| #####                    |
|     #                    |
|                          |
|                          |
|     #                    |
|     # Change this to mod |
| ify the default pre- and |
|  post prompt strings.    |
|     #                    |
|     # These only come in |
| to effect if CDL_PROMPTL |
| EN is set.               |
|     #                    |
|     #                    |
|                          |
|                          |
|     #                    |
|     #################### |
| ######################## |
| ######################## |
| #####                    |
|     if ${TEST} ${EUID} - |
| eq 0                     |
|     then                 |
|     #   CDL_PROMPT_PRE=$ |
| {CDL_PROMPT_PRE:="$HOSTN |
| AME@"}                   |
|         CDL_PROMPT_PRE=$ |
| {CDL_PROMPT_PRE:="\\[\\e |
| [01;31m\\]"}  # Root is  |
| in red                   |
|         CDL_PROMPT_POST= |
| ${CDL_PROMPT_POST:="\\[\ |
| \e[00m\\]#"}             |
|     else                 |
|         CDL_PROMPT_PRE=$ |
| {CDL_PROMPT_PRE:="\\[\\e |
| [01;34m\\]"}  # Users in |
|  blue                    |
|         CDL_PROMPT_POST= |
| ${CDL_PROMPT_POST:="\\[\ |
| \e[00m\\]$"}             |
|     fi                   |
|     #################### |
| ######################## |
| ######################## |
| #####                    |
|     #                    |
|     # cd_maxhistory defi |
| nes the max number of hi |
| story entries allowed.   |
|     typeset -i cd_maxhis |
| tory=50                  |
|                          |
|     #################### |
| ######################## |
| ######################## |
| #####                    |
|     #                    |
|     # cd_maxspecial defi |
| nes the number of specia |
| l entries.               |
|     typeset -i cd_maxspe |
| cial=9                   |
|     #                    |
|     #                    |
|     #################### |
| ######################## |
| ######################## |
| #####                    |
|     #                    |
|     #  cd_histcount defi |
| nes the number of entrie |
| s displayed in           |
|     #+ the history comma |
| nd.                      |
|     typeset -i cd_histco |
| unt=9                    |
|     #                    |
|     #################### |
| ######################## |
| ######################## |
| #####                    |
|     export CDPath=${HOME |
| }/                       |
|     #  Change these to u |
| se a different           |
|                          |
|     #                    |
|     #+ default path and  |
| filename                 |
|                          |
|     #                    |
|     export CDFile=${CDFI |
| LE:=cdfile}           #  |
| for the -u and -f comman |
| ds  #                    |
|     #                    |
|     #################### |
| ######################## |
| ######################## |
| #####                    |
|                          |
|                          |
|                          |
|     #                    |
|     typeset -i cd_lchar  |
| cd_rchar cd_flchar       |
|                          |
|     #  This is the numbe |
| r of chars to allow for  |
| the #                    |
|     cd_flchar=${FLCHAR:= |
| 75} #+ cd_flchar is used |
|  for for the @s & @h his |
| tory#                    |
|                          |
|     typeset -ax CD CDS   |
|     #                    |
|     cd_mset="\n\tDefault |
|  mode is now set - enter |
| ing cd with no parameter |
| s \                      |
|     has the default acti |
| on\n\tUse cd -d or -D fo |
| r cd to go to \          |
|     previous directory w |
| ith no parameters\n"     |
|     cd_mnset="\n\tNon-de |
| fault mode is now set -  |
| entering cd with no \    |
|     parameters is the sa |
| me as entering cd 0\n\tU |
| se cd -d or \            |
|     -D to change default |
|  cd action\n"            |
|                          |
|     # ================== |
| ======================== |
| ======================== |
| == #                     |
|                          |
|                          |
|                          |
|     : <<DOCUMENTATION    |
|                          |
|     Written by Phil Brah |
| am. Realtime Software Pt |
| y Ltd.                   |
|     Released under GNU l |
| icense. Free to use. Ple |
| ase pass any modificatio |
| ns                       |
|     or comments to the a |
| uthor Phil Braham:       |
|                          |
|     realtime@mpx.com.au  |
|     ==================== |
| ======================== |
| ======================== |
| ===                      |
|                          |
|     cdll is a replacemen |
| t for cd and incorporate |
| s similar functionality  |
| to                       |
|     the bash pushd and p |
| opd commands but is inde |
| pendent of them.         |
|                          |
|     This version of cdll |
|  has been tested on Linu |
| x using Bash. It will wo |
| rk                       |
|     on most Linux versio |
| ns but will probably not |
|  work on other shells wi |
| thout                    |
|     modification.        |
|                          |
|     Introduction         |
|     ============         |
|                          |
|     cdll allows easy mov |
| ing about between direct |
| ories. When changing to  |
| a new                    |
|     directory the curren |
| t one is automatically p |
| ut onto a stack. By defa |
| ult                      |
|     50 entries are kept, |
|  but this is configurabl |
| e. Special directories c |
| an be                    |
|     kept for easy access |
|  - by default up to 10,  |
| but this is configurable |
| . The                    |
|     most recent stack en |
| tries and the special en |
| tries can be easily view |
| ed.                      |
|                          |
|     The directory stack  |
| and special entries can  |
| be saved to, and loaded  |
| from,                    |
|     a file. This allows  |
| them to be set up on log |
| in, saved before logging |
|  out                     |
|     or changed when movi |
| ng project to project.   |
|                          |
|     In addition, cdll pr |
| ovides a flexible comman |
| d prompt facility that a |
| llows,                   |
|     for example, a direc |
| tory name in colour that |
|  is truncated from the l |
| eft                      |
|     if it gets too long. |
|                          |
|                          |
|     Setting up cdll      |
|     ===============      |
|                          |
|     Copy cdll to either  |
| your local home director |
| y or a central directory |
|     such as /usr/bin (th |
| is will require root acc |
| ess).                    |
|                          |
|     Copy the file cdfile |
|  to your home directory. |
|  It will require read an |
| d                        |
|     write access. This a |
|  default file that conta |
| ins a directory stack an |
| d                        |
|     special entries.     |
|                          |
|     To replace the cd co |
| mmand you must add comma |
| nds to your login script |
| .                        |
|     The login script is  |
| one or more of:          |
|                          |
|         /etc/profile     |
|         ~/.bash_profile  |
|         ~/.bash_login    |
|         ~/.profile       |
|         ~/.bashrc        |
|         /etc/bash.bashrc |
| .local                   |
|                          |
|     To setup your login, |
|  ~/.bashrc is recommende |
| d, for global (and root) |
|  setup                   |
|     add the commands to  |
| /etc/bash.bashrc.local   |
|                          |
|     To set up on login,  |
| add the command:         |
|         . <dir>/cdll     |
|     For example if cdll  |
| is in your local home di |
| rectory:                 |
|         . ~/cdll         |
|     If in /usr/bin then: |
|         . /usr/bin/cdll  |
|                          |
|     If you want to use t |
| his instead of the buiti |
| n cd command then add:   |
|         alias cd='cd_new |
| '                        |
|     We would also recomm |
| end the following comman |
| ds:                      |
|         alias @='cd_new  |
| @'                       |
|         cd -U            |
|         cd -D            |
|                          |
|     If you want to use c |
| dll's prompt facilty the |
| n add the following:     |
|         CDL_PROMPTLEN=nn |
|     Where nn is a number |
|  described below. Initia |
| lly 99 would be suitable |
|     number.              |
|                          |
|     Thus the script look |
| s something like this:   |
|                          |
|         ################ |
| ######################## |
| ######################## |
| ######                   |
|         # CD Setup       |
|         ################ |
| ######################## |
| ######################## |
| ######                   |
|         CDL_PROMPTLEN=21 |
|         # Allow a prompt |
|  length of up to 21 char |
| acters                   |
|         . /usr/bin/cdll  |
|         # Initialise cdl |
| l                        |
|         alias cd='cd_new |
| '       # Replace the bu |
| ilt in cd command        |
|         alias @='cd_new  |
| @'      # Allow @ at the |
|  prompt to display histo |
| ry                       |
|         cd -U            |
|         # Upload directo |
| ries                     |
|         cd -D            |
|         # Set default ac |
| tion to non-posix        |
|         ################ |
| ######################## |
| ######################## |
| ######                   |
|                          |
|     The full meaning of  |
| these commands will beco |
| me clear later.          |
|                          |
|     There are a couple o |
| f caveats. If another pr |
| ogram changes the direct |
| ory                      |
|     without calling cdll |
| , then the directory won |
| 't be put on the stack a |
| nd                       |
|     also if the prompt f |
| acility is used then thi |
| s will not be updated. T |
| wo                       |
|     programs that can do |
|  this are pushd and popd |
| . To update the prompt a |
| nd                       |
|     stack simply enter:  |
|                          |
|         cd .             |
|                          |
|     Note that if the pre |
| vious entry on the stack |
|  is the current director |
| y                        |
|     then the stack is no |
| t updated.               |
|                          |
|     Usage                |
|     =====                |
|     cd [dir] [0-9] [@[s| |
| h] [-g <dir>] [-d] [-D]  |
| [-r<n>]                  |
|        [dir|0-9] [-R<n>] |
|  [<dir>|0-9] [-s<n>] [-S |
| <n>]                     |
|        [-u] [-U] [-f] [- |
| F] [-h] [-H] [-v]        |
|                          |
|         <dir>       Go t |
| o directory              |
|         0-n         Goto |
|  previous directory (0 i |
| s previous,              |
|                     1 is |
|  last but 1, etc.)       |
|                     n is |
|  up to max history (defa |
| ult is 50)               |
|         @           List |
|  history and special ent |
| ries (Usually available  |
| as $ @)                  |
|         @h          List |
|  history entries         |
|         @s          List |
|  special entries         |
|         -g [<dir>]  Go t |
| o literal name (bypass s |
| pecial names)            |
|                     This |
|  is to allow access to d |
| irs called '0','1','-h'  |
| etc                      |
|         -d          Chan |
| ge default action - verb |
| ose. (See note)          |
|         -D          Chan |
| ge default action - sile |
| nt. (See note)           |
|         -s<n>       Go t |
| o the special entry <n>  |
|         -S<n>       Go t |
| o the special entry <n>  |
|                          |
|   and replace it with th |
| e current dir            |
|         -r<n> [<dir>] Go |
|  to directory <dir>      |
|                          |
|           and then put i |
| t on special entry <n>   |
|         -R<n> [<dir>] Go |
|  to directory <dir>      |
|                          |
|           and put curren |
| t dir on special entry < |
| n>                       |
|         -a<n>       Alte |
| rnative suggested direct |
| ory. See note below.     |
|         -f [<file>] File |
|  entries to <file>.      |
|         -u [<file>] Upda |
| te entries from <file>.  |
|                     If n |
| o filename supplied then |
|  default file (~/cdfile) |
|  is used                 |
|                     -F a |
| nd -U are silent version |
| s                        |
|         -v          Prin |
| t version number         |
|         -h          Help |
|         -H          Deta |
| iled help                |
|                          |
|                          |
|                          |
|     Examples             |
|     ========             |
|                          |
|     These examples assum |
| e non-default mode is se |
| t (that is, cd with no   |
|     parameters will go t |
| o the most recent stack  |
| directory), that aliases |
|     have been set up for |
|  cd and @ as described a |
| bove and that cd's promp |
| t                        |
|     facility is active a |
| nd the prompt length is  |
| 21 characters.           |
|                          |
|         /home/phil$ @    |
|         # List the entri |
| es with the @            |
|         History:         |
|         # Output of the  |
| @ command                |
|         .....            |
|         # Skipped these  |
| entries for brevity      |
|         1 /home/phil/umm |
| dev               S1 /ho |
| me/phil/perl             |
|         # Most recent tw |
| o history entries        |
|         0 /home/phil/per |
| l/eg              S0 /ho |
| me/phil/umm/ummdev       |
|         # and two specia |
| l entries are shown      |
|                          |
|         /home/phil$ cd / |
| home/phil/utils/Cdll     |
|         # Now change dir |
| ectories                 |
|         /home/phil/utils |
| /Cdll$ @                 |
|         # Prompt reflect |
| s the directory.         |
|         History:         |
|         # New history    |
|         .....            |
|         1 /home/phil/per |
| l/eg              S1 /ho |
| me/phil/perl             |
|         # History entry  |
| 0 has moved to 1         |
|         0 /home/phil     |
|                   S0 /ho |
| me/phil/umm/ummdev       |
|         # and the most r |
| ecent has entered        |
|                          |
|     To go to a history e |
| ntry:                    |
|                          |
|         /home/phil/utils |
| /Cdll$ cd 1              |
|         # Go to history  |
| entry 1.                 |
|         /home/phil/perl/ |
| eg$                      |
|         # Current direct |
| ory is now what was 1    |
|                          |
|     To go to a special e |
| ntry:                    |
|                          |
|         /home/phil/perl/ |
| eg$ cd -s1               |
|         # Go to special  |
| entry 1                  |
|         /home/phil/umm/u |
| mmdev$                   |
|         # Current direct |
| ory is S1                |
|                          |
|     To go to a directory |
|  called, for example, 1: |
|                          |
|         /home/phil$ cd - |
| g 1                      |
|         # -g ignores the |
|  special meaning of 1    |
|         /home/phil/1$    |
|                          |
|     To put current direc |
| tory on the special list |
|  as S1:                  |
|         cd -r1 .         |
| #  OR                    |
|         cd -R1 .         |
| #  These have the same e |
| ffect if the directory i |
| s                        |
|                          |
| #+ . (the current direct |
| ory)                     |
|                          |
|     To go to a directory |
|  and add it as a special |
|                          |
|       The directory for  |
| -r<n> or -R<n> may be a  |
| number.                  |
|       For example:       |
|             $ cd -r3 4   |
| Go to history entry 4 an |
| d put it on special entr |
| y 3                      |
|             $ cd -R3 4   |
| Put current dir on the s |
| pecial entry 3 and go to |
|                          |
| history entry 4          |
|             $ cd -s3     |
| Go to special entry 3    |
|                          |
|         Note that comman |
| ds R,r,S and s may be us |
| ed without a number and  |
|         refer to 0:      |
|             $ cd -s      |
| Go to special entry 0    |
|             $ cd -S      |
| Go to special entry 0 an |
| d make special entry 0   |
|                          |
| current dir              |
|             $ cd -r 1    |
| Go to history entry 1 an |
| d put it on special entr |
| y 0                      |
|             $ cd -r      |
| Go to history entry 0 an |
| d put it on special entr |
| y 0                      |
|                          |
|                          |
|         Alternative sugg |
| ested directories:       |
|                          |
|         If a directory i |
| s not found, then CD wil |
| l suggest any            |
|         possibilities. T |
| hese are directories sta |
| rting with the same lett |
| ers                      |
|         and if any are f |
| ound they are listed pre |
| fixed with -a<n>         |
|         where <n> is a n |
| umber. It's possible to  |
| go to the directory      |
|         by entering cd - |
| a<n> on the command line |
| .                        |
|                          |
|             Use cd -d or |
|  -D to change default cd |
|  action. cd -H will show |
|             current acti |
| on.                      |
|                          |
|             The history  |
| entries (0-n) are stored |
|  in the environment vari |
| ables                    |
|             CD[0] - CD[n |
| ]                        |
|             Similarly th |
| e special directories S0 |
|  - 9 are in the environm |
| ent                      |
|             variable CDS |
| [0] - CDS[9]             |
|             and may be a |
| ccessed from the command |
|  line, for example:      |
|                          |
|                 ls -l ${ |
| CDS[3]}                  |
|                 cat ${CD |
| [8]}/file.txt            |
|                          |
|             The default  |
| pathname for the -f and  |
| -u commands is ~         |
|             The default  |
| filename for the -f and  |
| -u commands is cdfile    |
|                          |
|                          |
|     Configuration        |
|     =============        |
|                          |
|         The following en |
| vironment variables can  |
| be set:                  |
|                          |
|             CDL_PROMPTLE |
| N  - Set to the length o |
| f prompt you require.    |
|                 Prompt s |
| tring is set to the righ |
| t characters of the curr |
| ent                      |
|                 director |
| y. If not set, then prom |
| pt is left unchanged. No |
| te                       |
|                 that thi |
| s is the number of chara |
| cters that the directory |
|  is                      |
|                 shortene |
| d to, not the total char |
| acters in the prompt.    |
|                          |
|                 CDL_PROM |
| PT_PRE - Set to the stri |
| ng to prefix the prompt. |
|                     Defa |
| ult is:                  |
|                          |
| non-root:  "\\[\\e[01;34 |
| m\\]"  (sets colour to b |
| lue).                    |
|                          |
| root:      "\\[\\e[01;31 |
| m\\]"  (sets colour to r |
| ed).                     |
|                          |
|                 CDL_PROM |
| PT_POST    - Set to the  |
| string to suffix the pro |
| mpt.                     |
|                     Defa |
| ult is:                  |
|                          |
| non-root:  "\\[\\e[00m\\ |
| ]$"                      |
|                          |
|            (resets colou |
| r and displays $).       |
|                          |
| root:      "\\[\\e[00m\\ |
| ]#"                      |
|                          |
|            (resets colou |
| r and displays #).       |
|                          |
|             Note:        |
|                 CDL_PROM |
| PT_PRE & _POST only t    |
|                          |
|             CDPath - Set |
|  the default path for th |
| e -f & -u options.       |
|                      Def |
| ault is home directory   |
|             CDFile - Set |
|  the default filename fo |
| r the -f & -u options.   |
|                      Def |
| ault is cdfile           |
|                          |
|                          |
|         There are three  |
| variables defined in the |
|  file cdll which control |
|  the                     |
|         number of entrie |
| s stored or displayed. T |
| hey are in the section l |
| abeled                   |
|         'Initialisation  |
| here' towards the end of |
|  the file.               |
|                          |
|             cd_maxhistor |
| y       - The number of  |
| history entries stored.  |
|                          |
|           Default is 50. |
|             cd_maxspecia |
| l       - The number of  |
| special entries allowed. |
|                          |
|           Default is 9.  |
|             cd_histcount |
|         - The number of  |
| history and special entr |
| ies                      |
|                          |
|           displayed. Def |
| ault is 9.               |
|                          |
|         Note that cd_max |
| special should be >= cd_ |
| histcount to avoid displ |
| aying                    |
|         special entries  |
| that can't be set.       |
|                          |
|                          |
|     Version: 1.2.1 Date: |
|  24-MAY-2003             |
|                          |
|     DOCUMENTATION        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-34. A soundcard setup script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # soundcard-on.sh    |
|                          |
|     #  Script author: Mk |
| archer                   |
|     #  http://www.thinkw |
| iki.org/wiki  ...        |
|     #  /Script_for_confi |
| guring_the_CS4239_sound_ |
| chip_in_PnP_mode         |
|     #  ABS Guide author  |
| made minor changes and a |
| dded comments.           |
|     #  Couldn't contact  |
| script author to ask for |
|  permission to use, but  |
| ...                      |
|     #+ the script was re |
| leased under the FDL,    |
|     #+ so its use here s |
| hould be both legal and  |
| ethical.                 |
|                          |
|     #  Sound-via-pnp-scr |
| ipt for Thinkpad 600E    |
|     #+ and possibly othe |
| r computers with onboard |
|  CS4239/CS4610           |
|     #+ that do not work  |
| with the PCI driver      |
|     #+ and are not recog |
| nized by the PnP code of |
|  snd-cs4236.             |
|     #  Also for some 770 |
| -series Thinkpads, such  |
| as the 770x.             |
|     #  Run as root user, |
|  of course.              |
|     #                    |
|     #  These are old and |
|  very obsolete laptop co |
| mputers,                 |
|     #+ but this particul |
| ar script is very instru |
| ctive,                   |
|     #+ as it shows how t |
| o set up and hack device |
|  files.                  |
|                          |
|                          |
|                          |
|     #  Search for sound  |
| card pnp device:         |
|                          |
|     for dev in /sys/bus/ |
| pnp/devices/*            |
|     do                   |
|       grep CSC0100 $dev/ |
| id > /dev/null && WSSDEV |
| =$dev                    |
|       grep CSC0110 $dev/ |
| id > /dev/null && CTLDEV |
| =$dev                    |
|     done                 |
|     # On 770x:           |
|     # WSSDEV = /sys/bus/ |
| pnp/devices/00:07        |
|     # CTLDEV = /sys/bus/ |
| pnp/devices/00:06        |
|     # These are symbolic |
|  links to /sys/devices/p |
| np0/ ...                 |
|                          |
|                          |
|     #  Activate devices: |
|     #  Thinkpad boots wi |
| th devices disabled unle |
| ss "fast boot" is turned |
|  off                     |
|     #+ (in BIOS).        |
|                          |
|     echo activate > $WSS |
| DEV/resources            |
|     echo activate > $CTL |
| DEV/resources            |
|                          |
|                          |
|     # Parse resource set |
| tings.                   |
|                          |
|     { read # Discard "st |
| ate = active" (see below |
| ).                       |
|       read bla port1     |
|       read bla port2     |
|       read bla port3     |
|       read bla irq       |
|       read bla dma1      |
|       read bla dma2      |
|      # The "bla's" are l |
| abels in the first field |
| : "io," "state," etc.    |
|      # These are discard |
| ed.                      |
|                          |
|      #  Hack: with PnPBI |
| OS: ports are: port1: WS |
| S, port2:                |
|      #+ OPL, port3: sb ( |
| unneeded)                |
|      #       with ACPI-P |
| nP:ports are: port1: OPL |
| , port2: sb, port3: WSS  |
|      #  (ACPI bios seems |
|  to be wrong here, the P |
| nP-card-code in snd-cs42 |
| 36.c                     |
|      #+  uses the PnPBIO |
| S port order)            |
|      #  Detect port orde |
| r using the fixed OPL po |
| rt as reference.         |
|       if [ ${port2%%-*}  |
| = 0x388 ]                |
|      #            ^^^^   |
| Strip out everything fol |
| lowing hyphen in port ad |
| dress.                   |
|      #                   |
| So, if port1 is 0x530-0x |
| 537                      |
|      #+                  |
| we're left with 0x530 -- |
|  the start address of th |
| e port.                  |
|      then                |
|        # PnPBIOS: usual  |
| order                    |
|        port=${port1%%-*} |
|        oplport=${port2%% |
| -*}                      |
|      else                |
|        # ACPI: mixed-up  |
| order                    |
|        port=${port3%%-*} |
|        oplport=${port1%% |
| -*}                      |
|      fi                  |
|      } < $WSSDEV/resourc |
| es                       |
|     # To see what's goin |
| g on here:               |
|     # ------------------ |
| ---------                |
|     #   cat /sys/devices |
| /pnp0/00:07/resources    |
|     #                    |
|     #   state = active   |
|     #   io 0x530-0x537   |
|     #   io 0x388-0x38b   |
|     #   io 0x220-0x233   |
|     #   irq 5            |
|     #   dma 1            |
|     #   dma 0            |
|     #   ^^^   "bla" labe |
| ls in first field (disca |
| rded).                   |
|                          |
|                          |
|     { read # Discard fir |
| st line, as above.       |
|       read bla port1     |
|       cport=${port1%%-*} |
|       #            ^^^^  |
|       # Just want _start |
| _ address of port.       |
|     } < $CTLDEV/resource |
| s                        |
|                          |
|                          |
|     # Load the module:   |
|                          |
|     modprobe --ignore-in |
| stall snd-cs4236 port=$p |
| ort cport=$cport\        |
|     fm_port=$oplport irq |
| =$irq dma1=$dma1 dma2=$d |
| ma2 isapnp=0 index=0     |
|     # See the modprobe m |
| anpage.                  |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-35. Locating split paragraphs in a text file**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # find-splitpara.sh  |
|     #  Finds split parag |
| raphs in a text file,    |
|     #+ and tags the line |
|  numbers.                |
|                          |
|                          |
|     ARGCOUNT=1       # E |
| xpect one arg.           |
|     OFF=0            # F |
| lag states.              |
|     ON=1                 |
|     E_WRONGARGS=85       |
|                          |
|     file="$1"        # T |
| arget filename.          |
|     lineno=1         # L |
| ine number. Start at 1.  |
|     Flag=$OFF        # B |
| lank line flag.          |
|                          |
|     if [ $# -ne "$ARGCOU |
| NT" ]                    |
|     then                 |
|       echo "Usage: `base |
| name $0` FILENAME"       |
|       exit $E_WRONGARGS  |
|     fi                   |
|                          |
|     file_read ()     # S |
| can file for pattern, th |
| en print line.           |
|     {                    |
|     while read line      |
|     do                   |
|                          |
|       if [[ "$line" =~ ^ |
| [a-z] && $Flag -eq $ON ] |
| ]                        |
|          then  # Line be |
| gins with lowercase char |
| acter, following blank l |
| ine.                     |
|          echo -n "$linen |
| o::   "                  |
|          echo "$line"    |
|       fi                 |
|                          |
|                          |
|       if [[ "$line" =~ ^ |
| $ ]]                     |
|          then       #  I |
| f blank line,            |
|          Flag=$ON   #+ s |
| et flag.                 |
|       else               |
|          Flag=$OFF       |
|       fi                 |
|                          |
|       ((lineno++))       |
|                          |
|     done                 |
|     } < $file  # Redirec |
| t file into function's s |
| tdin.                    |
|                          |
|     file_read            |
|                          |
|                          |
|     exit $?              |
|                          |
|                          |
|     # ------------------ |
| ------------------------ |
| ----------------------   |
|     This is line one of  |
| an example paragraph, bl |
| a, bla, bla.             |
|     This is line two, an |
| d line three should foll |
| ow on next line, but     |
|                          |
|     there is a blank lin |
| e separating the two par |
| ts of the paragraph.     |
|     # ------------------ |
| ------------------------ |
| ----------------------   |
|                          |
|     Running this script  |
| on a file containing the |
|  above paragraph         |
|     yields:              |
|                          |
|     4::   there is a bla |
| nk line separating the t |
| wo parts of the paragrap |
| h.                       |
|                          |
|                          |
|     There will be additi |
| onal output for all the  |
| other split paragraphs   |
|     in the target file.  |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-36. Insertion sort**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # insertion-sort.bas |
| h: Insertion sort implem |
| entation in Bash         |
|     #                    |
|    Heavy use of Bash arr |
| ay features:             |
|     #+                   |
|    (string) slicing, mer |
| ging, etc                |
|     # URL: http://www.lu |
| gmen.org.ar/~jjo/jjotip/ |
| insertion-sort.bash.d    |
|     #+          /inserti |
| on-sort.bash.sh          |
|     #                    |
|     # Author: JuanJo Cia |
| rlante <jjo@irrigacion.g |
| ov.ar>                   |
|     # Lightly reformatte |
| d by ABS Guide author.   |
|     # License: GPLv2     |
|     # Used in ABS Guide  |
| with author's permission |
|  (thanks!).              |
|     #                    |
|     # Test with:   ./ins |
| ertion-sort.bash -t      |
|     # Or:          bash  |
| insertion-sort.bash -t   |
|     # The following *doe |
| sn't* work:              |
|     #              sh in |
| sertion-sort.bash -t     |
|     #  Why not? Hint: wh |
| ich Bash-specific featur |
| es are disabled          |
|     #+ when running a sc |
| ript by 'sh script.sh'?  |
|     #                    |
|     : ${DEBUG:=0}  # Deb |
| ug, override with:  DEBU |
| G=1 ./scriptname . . .   |
|     # Parameter substitu |
| tion -- set DEBUG to 0 i |
| f not previously set.    |
|                          |
|     # Global array: "lis |
| t"                       |
|     typeset -a list      |
|     # Load whitespace-se |
| parated numbers from std |
| in.                      |
|     if [ "$1" = "-t" ];  |
| then                     |
|     DEBUG=1              |
|             read -a list |
|  < <( od -Ad -w24 -t u2  |
| /dev/urandom ) # Random  |
| list.                    |
|     #                    |
|  ^ ^  process substition |
|     else                 |
|             read -a list |
|     fi                   |
|     numelem=${#list[*]}  |
|                          |
|     #  Shows the list, m |
| arking the element whose |
|  index is $1             |
|     #+ by surrounding it |
|  with the two chars pass |
| ed as $2.                |
|     #  Whole line prefix |
| ed with $3.              |
|     showlist()           |
|       {                  |
|       echo "$3"${list[@] |
| :0:$1} ${2:0:1}${list[$1 |
| ]}${2:1:1} ${list[@]:$1+ |
| 1};                      |
|       }                  |
|                          |
|     # Loop _pivot_ -- fr |
| om second element to end |
|  of list.                |
|     for(( i=1; i<numelem |
| ; i++ )) do              |
|             ((DEBUG))&&s |
| howlist i "[]" " "       |
|             # From curre |
| nt _pivot_, back to firs |
| t element.               |
|             for(( j=i; j |
| ; j-- )) do              |
|                     # Se |
| arch for the 1st elem. l |
| ess than current "pivot" |
|  . . .                   |
|                     [[ " |
| ${list[j-1]}" -le "${lis |
| t[i]}" ]] && break       |
|             done         |
|         (( i==j )) && co |
| ntinue ## No insertion w |
| as needed for this eleme |
| nt.                      |
|         # . . . Move lis |
| t[i] (pivot) to the left |
|  of list[j]:             |
|             list=(${list |
| [@]:0:j} ${list[i]} ${li |
| st[j]}\                  |
|         #         {0,j-1 |
| }        {i}       {j}   |
|                   ${list |
| [@]:j+1:i-(j+1)} ${list[ |
| @]:i+1})                 |
|         #         {j+1,i |
| -1}              {i+1,la |
| st}                      |
|         ((DEBUG))&&showl |
| ist j "<>" "*"           |
|     done                 |
|                          |
|                          |
|     echo                 |
|     echo  "------"       |
|     echo $'Result:\n'${l |
| ist[@]}                  |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-37. Standard Deviation**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # sd.sh: Standard De |
| viation                  |
|                          |
|     #  The Standard Devi |
| ation indicates how cons |
| istent a set of data is. |
|     #  It shows to what  |
| extent the individual da |
| ta points deviate from t |
| he                       |
|     #+ arithmetic mean,  |
| i.e., how much they "bou |
| nce around" (or cluster) |
| .                        |
|     #  It is essentially |
|  the average deviation-d |
| istance of the           |
|     #+ data points from  |
| the mean.                |
|                          |
|     # ================== |
| ======================== |
| ================= #      |
|     #    To calculate th |
| e Standard Deviation:    |
|     #                    |
|     # 1  Find the arithm |
| etic mean (average) of a |
| ll the data points.      |
|     # 2  Subtract each d |
| ata point from the arith |
| metic mean,              |
|     #    and square that |
|  difference.             |
|     # 3  Add all of the  |
| individual difference-sq |
| uares in # 2.            |
|     # 4  Divide the sum  |
| in # 3 by the number of  |
| data points.             |
|     #    This is known a |
| s the "variance."        |
|     # 5  The square root |
|  of # 4 gives the Standa |
| rd Deviation.            |
|     # ================== |
| ======================== |
| ================= #      |
|                          |
|     count=0         # Nu |
| mber of data points; glo |
| bal.                     |
|     SC=9            # Sc |
| ale to be used by bc. Ni |
| ne decimal places.       |
|     E_DATAFILE=90   # Da |
| ta file error.           |
|                          |
|     # -----------------  |
| Set data file ---------- |
| -----------              |
|     if [ ! -z "$1" ]  #  |
| Specify filename as cmd- |
| line arg?                |
|     then                 |
|       datafile="$1" #  A |
| SCII text file,          |
|     else            #+ o |
| ne (numerical) data poin |
| t per line!              |
|       datafile=sample.da |
| t                        |
|     fi              #  S |
| ee example data file, be |
| low.                     |
|                          |
|     if [ ! -e "$datafile |
| " ]                      |
|     then                 |
|       echo "\""$datafile |
| "\" does not exist!"     |
|       exit $E_DATAFILE   |
|     fi                   |
|     # ------------------ |
| ------------------------ |
| -----------              |
|                          |
|                          |
|     arith_mean ()        |
|     {                    |
|       local rt=0         |
|  # Running total.        |
|       local am=0         |
|  # Arithmetic mean.      |
|       local ct=0         |
|  # Number of data points |
| .                        |
|                          |
|       while read value   |
|  # Read one data point a |
| t a time.                |
|       do                 |
|         rt=$(echo "scale |
| =$SC; $rt + $value" | bc |
| )                        |
|         (( ct++ ))       |
|       done               |
|                          |
|       am=$(echo "scale=$ |
| SC; $rt / $ct" | bc)     |
|                          |
|       echo $am; return $ |
| ct   # This function "re |
| turns" TWO values!       |
|       #  Caution: This l |
| ittle trick will not wor |
| k if $ct > 255!          |
|       #  To handle a lar |
| ger number of data point |
| s,                       |
|       #+ simply comment  |
| out the "return $ct" abo |
| ve.                      |
|     } <"$datafile"   # F |
| eed in data file.        |
|                          |
|     sd ()                |
|     {                    |
|       mean1=$1  # Arithm |
| etic mean (passed to fun |
| ction).                  |
|       n=$2      # How ma |
| ny data points.          |
|       sum2=0    # Sum of |
|  squared differences ("v |
| ariance").               |
|       avg2=0    # Averag |
| e of $sum2.              |
|       sdev=0    # Standa |
| rd Deviation.            |
|                          |
|       while read value   |
|  # Read one line at a ti |
| me.                      |
|       do                 |
|         diff=$(echo "sca |
| le=$SC; $mean1 - $value" |
|  | bc)                   |
|         # Difference bet |
| ween arith. mean and dat |
| a point.                 |
|         dif2=$(echo "sca |
| le=$SC; $diff * $diff" | |
|  bc) # Squared.          |
|         sum2=$(echo "sca |
| le=$SC; $sum2 + $dif2" | |
|  bc) # Sum of squares.   |
|       done               |
|                          |
|         avg2=$(echo "sca |
| le=$SC; $sum2 / $n" | bc |
| )  # Avg. of sum of squa |
| res.                     |
|         sdev=$(echo "sca |
| le=$SC; sqrt($avg2)" | b |
| c) # Square root =       |
|         echo $sdev       |
|                          |
|    # Standard Deviation. |
|                          |
|     } <"$datafile"   # R |
| ewinds data file.        |
|                          |
|                          |
|     # ================== |
| ======================== |
| ============= #          |
|     mean=$(arith_mean);  |
| count=$?   # Two returns |
|  from function!          |
|     std_dev=$(sd $mean $ |
| count)                   |
|                          |
|     echo                 |
|     echo "Number of data |
|  points in \""$datafile" |
| \" = $count"             |
|     echo "Arithmetic mea |
| n (average) = $mean"     |
|     echo "Standard Devia |
| tion = $std_dev"         |
|     echo                 |
|     # ================== |
| ======================== |
| ============= #          |
|                          |
|     exit                 |
|                          |
|     #  This script could |
|  stand some drastic stre |
| amlining,                |
|     #+ but not at the co |
| st of reduced legibility |
| , please.                |
|                          |
|                          |
|     # ++++++++++++++++++ |
| ++++++++++++++++++++++ # |
|     # A sample data file |
|  (sample1.dat):          |
|                          |
|     # 18.35              |
|     # 19.0               |
|     # 18.88              |
|     # 18.91              |
|     # 18.64              |
|                          |
|                          |
|     # $ sh sd.sh sample1 |
| .dat                     |
|                          |
|     # Number of data poi |
| nts in "sample1.dat" = 5 |
|     # Arithmetic mean (a |
| verage) = 18.756000000   |
|     # Standard Deviation |
|  = .235338054            |
|     # ++++++++++++++++++ |
| ++++++++++++++++++++++ # |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-38. A *pad* file generator for shareware authors**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # pad.sh             |
|                          |
|     #################### |
| ######################## |
| ###########              |
|     #               PAD  |
| (xml) file creator       |
|     #+ Written by Mendel |
|  Cooper <thegrendel.abs@ |
| gmail.com>.              |
|     #+ Released to the P |
| ublic Domain.            |
|     #                    |
|     #  Generates a "PAD" |
|  descriptor file for sha |
| reware                   |
|     #+ packages, accordi |
| ng to the specifications |
|     #+ of the ASP.       |
|     #  http://www.asp-sh |
| areware.org/pad          |
|     #################### |
| ######################## |
| ###########              |
|                          |
|                          |
|     # Accepts (optional) |
|  save filename as a comm |
| and-line argument.       |
|     if [ -n "$1" ]       |
|     then                 |
|       savefile=$1        |
|     else                 |
|       savefile=save_file |
| .xml               # Def |
| ault save_file name.     |
|     fi                   |
|                          |
|                          |
|     # ===== PAD file hea |
| ders =====               |
|     HDR1="<?xml version= |
| \"1.0\" encoding=\"Windo |
| ws-1252\" ?>"            |
|     HDR2="<XML_DIZ_INFO> |
| "                        |
|     HDR3="<MASTER_PAD_VE |
| RSION_INFO>"             |
|     HDR4="\t<MASTER_PAD_ |
| VERSION>1.15</MASTER_PAD |
| _VERSION>"               |
|     HDR5="\t<MASTER_PAD_ |
| INFO>Portable Applicatio |
| n Description, or PAD    |
|     for short, is a data |
|  set that is used by sha |
| reware authors to        |
|     disseminate informat |
| ion to anyone interested |
|  in their software produ |
| cts.                     |
|     To find out more go  |
| to http://www.asp-sharew |
| are.org/pad</MASTER_PAD_ |
| INFO>"                   |
|     HDR6="</MASTER_PAD_V |
| ERSION_INFO>"            |
|     # ================== |
| ==========               |
|                          |
|                          |
|     fill_in ()           |
|     {                    |
|       if [ -z "$2" ]     |
|       then               |
|         echo -n "$1? "   |
|    # Get user input.     |
|       else               |
|         echo -n "$1 $2?  |
| "  # Additional query?   |
|       fi                 |
|                          |
|       read var           |
|    # May paste to fill i |
| n field.                 |
|                          |
|    # This shows how flex |
| ible "read" can be.      |
|                          |
|       if [ -z "$var" ]   |
|       then               |
|         echo -e "\t\t<$1 |
|  />" >>$savefile    # In |
| dent with 2 tabs.        |
|         return           |
|       else               |
|         echo -e "\t\t<$1 |
| >$var</$1>" >>$savefile  |
|         return ${#var}   |
|    # Return length of in |
| put string.              |
|       fi                 |
|     }                    |
|                          |
|     check_field_length ( |
| )  # Check length of pro |
| gram description fields. |
|     {                    |
|       # $1 = maximum fie |
| ld length                |
|       # $2 = actual fiel |
| d length                 |
|       if [ "$2" -gt "$1" |
|  ]                       |
|       then               |
|         echo "Warning: M |
| aximum field length of $ |
| 1 characters exceeded!"  |
|       fi                 |
|     }                    |
|                          |
|     clear                |
|    # Clear screen.       |
|     echo "PAD File Creat |
| or"                      |
|     echo "--- ---- ----- |
| --"                      |
|     echo                 |
|                          |
|     # Write File Headers |
|  to file.                |
|     echo $HDR1 >$savefil |
| e                        |
|     echo $HDR2 >>$savefi |
| le                       |
|     echo $HDR3 >>$savefi |
| le                       |
|     echo -e $HDR4 >>$sav |
| efile                    |
|     echo -e $HDR5 >>$sav |
| efile                    |
|     echo $HDR6 >>$savefi |
| le                       |
|                          |
|                          |
|     # Company_Info       |
|     echo "COMPANY INFO"  |
|     CO_HDR="Company_Info |
| "                        |
|     echo "<$CO_HDR>" >>$ |
| savefile                 |
|                          |
|     fill_in Company_Name |
|     fill_in Address_1    |
|     fill_in Address_2    |
|     fill_in City_Town    |
|     fill_in State_Provin |
| ce                       |
|     fill_in Zip_Postal_C |
| ode                      |
|     fill_in Country      |
|                          |
|     # If applicable:     |
|     # fill_in ASP_Member |
|  "[Y/N]"                 |
|     # fill_in ASP_Member |
| _Number                  |
|     # fill_in ESC_Member |
|  "[Y/N]"                 |
|                          |
|     fill_in Company_WebS |
| ite_URL                  |
|                          |
|     clear   # Clear scre |
| en between sections.     |
|                          |
|        # Contact_Info    |
|     echo "CONTACT INFO"  |
|     CONTACT_HDR="Contact |
| _Info"                   |
|     echo "<$CONTACT_HDR> |
| " >>$savefile            |
|     fill_in Author_First |
| _Name                    |
|     fill_in Author_Last_ |
| Name                     |
|     fill_in Author_Email |
|     fill_in Contact_Firs |
| t_Name                   |
|     fill_in Contact_Last |
| _Name                    |
|     fill_in Contact_Emai |
| l                        |
|     echo -e "\t</$CONTAC |
| T_HDR>" >>$savefile      |
|        # END Contact_Inf |
| o                        |
|                          |
|     clear                |
|                          |
|        # Support_Info    |
|     echo "SUPPORT INFO"  |
|     SUPPORT_HDR="Support |
| _Info"                   |
|     echo "<$SUPPORT_HDR> |
| " >>$savefile            |
|     fill_in Sales_Email  |
|     fill_in Support_Emai |
| l                        |
|     fill_in General_Emai |
| l                        |
|     fill_in Sales_Phone  |
|     fill_in Support_Phon |
| e                        |
|     fill_in General_Phon |
| e                        |
|     fill_in Fax_Phone    |
|     echo -e "\t</$SUPPOR |
| T_HDR>" >>$savefile      |
|        # END Support_Inf |
| o                        |
|                          |
|     echo "</$CO_HDR>" >> |
| $savefile                |
|     # END Company_Info   |
|                          |
|     clear                |
|                          |
|     # Program_Info       |
|     echo "PROGRAM INFO"  |
|     PROGRAM_HDR="Program |
| _Info"                   |
|     echo "<$PROGRAM_HDR> |
| " >>$savefile            |
|     fill_in Program_Name |
|     fill_in Program_Vers |
| ion                      |
|     fill_in Program_Rele |
| ase_Month                |
|     fill_in Program_Rele |
| ase_Day                  |
|     fill_in Program_Rele |
| ase_Year                 |
|     fill_in Program_Cost |
| _Dollars                 |
|     fill_in Program_Cost |
| _Other                   |
|     fill_in Program_Type |
|  "[Shareware/Freeware/GP |
| L]"                      |
|     fill_in Program_Rele |
| ase_Status "[Beta, Major |
|  Upgrade, etc.]"         |
|     fill_in Program_Inst |
| all_Support              |
|     fill_in Program_OS_S |
| upport "[Win9x/Win2k/Lin |
| ux/etc.]"                |
|     fill_in Program_Lang |
| uage "[English/Spanish/e |
| tc.]"                    |
|                          |
|     echo; echo           |
|                          |
|       # File_Info        |
|     echo "FILE INFO"     |
|     FILEINFO_HDR="File_I |
| nfo"                     |
|     echo "<$FILEINFO_HDR |
| >" >>$savefile           |
|     fill_in Filename_Ver |
| sioned                   |
|     fill_in Filename_Pre |
| vious                    |
|     fill_in Filename_Gen |
| eric                     |
|     fill_in Filename_Lon |
| g                        |
|     fill_in File_Size_By |
| tes                      |
|     fill_in File_Size_K  |
|     fill_in File_Size_MB |
|     echo -e "\t</$FILEIN |
| FO_HDR>" >>$savefile     |
|       # END File_Info    |
|                          |
|     clear                |
|                          |
|       # Expire_Info      |
|     echo "EXPIRE INFO"   |
|     EXPIRE_HDR="Expire_I |
| nfo"                     |
|     echo "<$EXPIRE_HDR>" |
|  >>$savefile             |
|     fill_in Has_Expire_I |
| nfo "Y/N"                |
|     fill_in Expire_Count |
|     fill_in Expire_Based |
| _On                      |
|     fill_in Expire_Other |
| _Info                    |
|     fill_in Expire_Month |
|     fill_in Expire_Day   |
|     fill_in Expire_Year  |
|     echo -e "\t</$EXPIRE |
| _HDR>" >>$savefile       |
|       # END Expire_Info  |
|                          |
|     clear                |
|                          |
|       # More Program_Inf |
| o                        |
|     echo "ADDITIONAL PRO |
| GRAM INFO"               |
|     fill_in Program_Chan |
| ge_Info                  |
|     fill_in Program_Spec |
| ific_Category            |
|     fill_in Program_Cate |
| gories                   |
|     fill_in Includes_JAV |
| A_VM "[Y/N]"             |
|     fill_in Includes_VB_ |
| Runtime "[Y/N]"          |
|     fill_in Includes_Dir |
| ectX "[Y/N]"             |
|       # END More Program |
| _Info                    |
|                          |
|     echo "</$PROGRAM_HDR |
| >" >>$savefile           |
|     # END Program_Info   |
|                          |
|     clear                |
|                          |
|     # Program Descriptio |
| n                        |
|     echo "PROGRAM DESCRI |
| PTIONS"                  |
|     PROGDESC_HDR="Progra |
| m_Descriptions"          |
|     echo "<$PROGDESC_HDR |
| >" >>$savefile           |
|                          |
|     LANG="English"       |
|     echo "<$LANG>" >>$sa |
| vefile                   |
|                          |
|     fill_in Keywords "[c |
| omma + space separated]" |
|     echo                 |
|     echo "45, 80, 250, 4 |
| 50, 2000 word program de |
| scriptions"              |
|     echo "(may cut and p |
| aste into field)"        |
|     #  It would be highl |
| y appropriate to compose |
|  the following           |
|     #+ "Char_Desc" field |
| s with a text editor,    |
|     #+ then cut-and-past |
| e the text into the answ |
| er fields.               |
|     echo                 |
|     echo "               |
| |---------------45 chara |
| cters---------------|"   |
|     fill_in Char_Desc_45 |
|     check_field_length 4 |
| 5 "$?"                   |
|     echo                 |
|     fill_in Char_Desc_80 |
|     check_field_length 8 |
| 0 "$?"                   |
|                          |
|     fill_in Char_Desc_25 |
| 0                        |
|     check_field_length 2 |
| 50 "$?"                  |
|                          |
|     fill_in Char_Desc_45 |
| 0                        |
|     fill_in Char_Desc_20 |
| 00                       |
|                          |
|     echo "</$LANG>" >>$s |
| avefile                  |
|     echo "</$PROGDESC_HD |
| R>" >>$savefile          |
|     # END Program Descri |
| ption                    |
|                          |
|     clear                |
|     echo "Done."; echo;  |
| echo                     |
|     echo "Save file is:  |
|  \""$savefile"\""        |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-39. A *man page* editor**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # maned.sh           |
|     # A rudimentary man  |
| page editor              |
|                          |
|     # Version: 0.1 (Alph |
| a, probably buggy)       |
|     # Author: Mendel Coo |
| per <thegrendel.abs@gmai |
| l.com>                   |
|     # Reldate: 16 June 2 |
| 008                      |
|     # License: GPL3      |
|                          |
|                          |
|     savefile=      # Glo |
| bal, used in multiple fu |
| nctions.                 |
|     E_NOINPUT=90   # Use |
| r input missing (error). |
|  May or may not be criti |
| cal.                     |
|                          |
|     # =========== Markup |
|  Tags ============ #     |
|     TopHeader=".TH"      |
|     NameHeader=".SH NAME |
| "                        |
|     SyntaxHeader=".SH SY |
| NTAX"                    |
|     SynopsisHeader=".SH  |
| SYNOPSIS"                |
|     InstallationHeader=" |
| .SH INSTALLATION"        |
|     DescHeader=".SH DESC |
| RIPTION"                 |
|     OptHeader=".SH OPTIO |
| NS"                      |
|     FilesHeader=".SH FIL |
| ES"                      |
|     EnvHeader=".SH ENVIR |
| ONMENT"                  |
|     AuthHeader=".SH AUTH |
| OR"                      |
|     BugsHeader=".SH BUGS |
| "                        |
|     SeeAlsoHeader=".SH S |
| EE ALSO"                 |
|     BOLD=".B"            |
|     # Add more tags, as  |
| needed.                  |
|     # See groff docs for |
|  markup meanings.        |
|     # ================== |
| ================== #     |
|                          |
|     start ()             |
|     {                    |
|     clear                |
|    # Clear screen.       |
|     echo "ManEd"         |
|     echo "-----"         |
|     echo                 |
|     echo "Simple man pag |
| e creator"               |
|     echo "Author: Mendel |
|  Cooper"                 |
|     echo "License: GPL3" |
|     echo; echo; echo     |
|     }                    |
|                          |
|     progname ()          |
|     {                    |
|       echo -n "Program n |
| ame? "                   |
|       read name          |
|                          |
|       echo -n "Manpage s |
| ection? [Hit RETURN for  |
| default (\"1\") ]  "     |
|       read section       |
|       if [ -z "$section" |
|  ]                       |
|       then               |
|         section=1   # Mo |
| st man pages are in sect |
| ion 1.                   |
|       fi                 |
|                          |
|       if [ -n "$name" ]  |
|       then               |
|         savefile=""$name |
| "."$section""       #  F |
| ilename suffix = section |
| .                        |
|         echo -n "$1 " >> |
| $savefile                |
|         name1=$(echo "$n |
| ame" | tr a-z A-Z)  #  C |
| hange to uppercase,      |
|                          |
|                     #+ p |
| er man page convention.  |
|         echo -n "$name1" |
|  >>$savefile             |
|       else               |
|         echo "Error! No  |
| input."             # Ma |
| ndatory input.           |
|         exit $E_NOINPUT  |
|                     # Cr |
| itical!                  |
|         #  Exercise: The |
|  script-abort if no file |
| name input is a bit clum |
| sy.                      |
|         #            Rew |
| rite this section so a d |
| efault filename is used  |
|         #+           if  |
| no input.                |
|       fi                 |
|                          |
|       echo -n "  \"$sect |
| ion\"">>$savefile   # Ap |
| pend, always append.     |
|                          |
|       echo -n "Version?  |
| "                        |
|       read ver           |
|       echo -n " \"Versio |
| n $ver \"">>$savefile    |
|       echo >>$savefile   |
|                          |
|       echo -n "Short des |
| cription [0 - 5 words]?  |
| "                        |
|       read sdesc         |
|       echo "$NameHeader" |
| >>$savefile              |
|       echo ""$BOLD" "$na |
| me"">>$savefile          |
|       echo "\- "$sdesc"" |
| >>$savefile              |
|                          |
|     }                    |
|                          |
|     fill_in ()           |
|     { # This function mo |
| re or less copied from " |
| pad.sh" script.          |
|       echo -n "$2? "     |
|    # Get user input.     |
|       read var           |
|    # May paste (a single |
|  line only!) to fill in  |
| field.                   |
|                          |
|       if [ -n "$var" ]   |
|       then               |
|         echo "$1 " >>$sa |
| vefile                   |
|         echo -n "$var" > |
| >$savefile               |
|       else               |
|    # Don't append empty  |
| field to file.           |
|         return $E_NOINPU |
| T  # Not critical here.  |
|       fi                 |
|                          |
|       echo >>$savefile   |
|                          |
|     }                    |
|                          |
|                          |
|     end ()               |
|     {                    |
|     clear                |
|     echo -n "Would you l |
| ike to view the saved ma |
| n page (y/n)? "          |
|     read ans             |
|     if [ "$ans" = "n" -o |
|  "$ans" = "N" ]; then ex |
| it; fi                   |
|     exec less "$savefile |
| "  #  Exit script and ha |
| nd off control to "less" |
|  ...                     |
|                          |
|    #+ ... which formats  |
| for viewing man page sou |
| rce.                     |
|     }                    |
|                          |
|                          |
|     # ------------------ |
| ---------------------- # |
|     start                |
|     progname "$TopHeader |
| "                        |
|     fill_in "$SynopsisHe |
| ader" "Synopsis"         |
|     fill_in "$DescHeader |
| " "Long description"     |
|     # May paste in *sing |
| le line* of text.        |
|     fill_in "$OptHeader" |
|  "Options"               |
|     fill_in "$FilesHeade |
| r" "Files"               |
|     fill_in "$AuthHeader |
| " "Author"               |
|     fill_in "$BugsHeader |
| " "Bugs"                 |
|     fill_in "$SeeAlsoHea |
| der" "See also"          |
|     # fill_in "$OtherHea |
| der" ... as necessary.   |
|     end    # ... exit no |
| t needed.                |
|     # ------------------ |
| ---------------------- # |
|                          |
|     #  Note that the gen |
| erated man page will usu |
| ally                     |
|     #+ require manual fi |
| ne-tuning with a text ed |
| itor.                    |
|     #  However, it's a d |
| istinct improvement upon |
|     #+ writing man sourc |
| e from scratch           |
|     #+ or even editing a |
|  blank man page template |
| .                        |
|                          |
|     #  The main deficien |
| cy of the script is that |
|  it permits              |
|     #+ pasting only a si |
| ngle text line into the  |
| input fields.            |
|     #  This may be a lon |
| g, cobbled-together line |
| , which groff            |
|     #  will automaticall |
| y wrap and hyphenate.    |
|     #  However, if you w |
| ant multiple (newline-se |
| parated) paragraphs,     |
|     #+ these must be ins |
| erted by manual text edi |
| ting on the              |
|     #+ script-generated  |
| man page.                |
|     #  Exercise (difficu |
| lt): Fix this!           |
|                          |
|     #  This script is no |
| t nearly as elaborate as |
|  the                     |
|     #+ full-featured "ma |
| nedit" package           |
|     #+ http://freshmeat. |
| net/projects/manedit/    |
|     #+ but it's much eas |
| ier to use.              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-40. Petals Around the Rose**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash -i       |
|     # petals.sh          |
|                          |
|     #################### |
| ######################## |
| ######################## |
| #####                    |
|     # Petals Around the  |
| Rose                     |
|                          |
|     #                    |
|     #                    |
|                          |
|                          |
|     #                    |
|     # Version 0.1 Create |
| d by Serghey Rodin       |
|                          |
|     #                    |
|     # Version 0.2 Modded |
|  by ABS Guide Author     |
|                          |
|     #                    |
|     #                    |
|                          |
|                          |
|     #                    |
|     # License: GPL3      |
|                          |
|                          |
|     #                    |
|     # Used in ABS Guide  |
| with permission.         |
|                          |
|     #                    |
|     # ################## |
| ######################## |
| ######################## |
| ### #                    |
|                          |
|     hits=0      # Correc |
| t guesses.               |
|     WIN=6       # Master |
| ed the game.             |
|     ALMOST=5    # One sh |
| ort of mastery.          |
|     EXIT=exit   # Give u |
| p early?                 |
|                          |
|     RANDOM=$$   # Seeds  |
| the random number genera |
| tor from PID of script.  |
|                          |
|                          |
|     # Bones (ASCII graph |
| ics for dice)            |
|     bone1[1]="|          |
| |"                       |
|     bone1[2]="|       o  |
| |"                       |
|     bone1[3]="|       o  |
| |"                       |
|     bone1[4]="| o     o  |
| |"                       |
|     bone1[5]="| o     o  |
| |"                       |
|     bone1[6]="| o     o  |
| |"                       |
|     bone2[1]="|    o     |
| |"                       |
|     bone2[2]="|          |
| |"                       |
|     bone2[3]="|    o     |
| |"                       |
|     bone2[4]="|          |
| |"                       |
|     bone2[5]="|    o     |
| |"                       |
|     bone2[6]="| o     o  |
| |"                       |
|     bone3[1]="|          |
| |"                       |
|     bone3[2]="| o        |
| |"                       |
|     bone3[3]="| o        |
| |"                       |
|     bone3[4]="| o     o  |
| |"                       |
|     bone3[5]="| o     o  |
| |"                       |
|     bone3[6]="| o     o  |
| |"                       |
|     bone="+---------+"   |
|                          |
|                          |
|                          |
|     # Functions          |
|                          |
|     instructions () {    |
|                          |
|       clear              |
|       echo -n "Do you ne |
| ed instructions? (y/n) " |
| ; read ans               |
|       if [ "$ans" = "y"  |
| -o "$ans" = "Y" ]; then  |
|         clear            |
|         echo -e '\E[34;4 |
| 7m'  # Blue type.        |
|                          |
|     #  "cat document"    |
|         cat <<INSTRUCTIO |
| NSZZZ                    |
|     The name of the game |
|  is Petals Around the Ro |
| se,                      |
|     and that name is sig |
| nificant.                |
|     Five dice will roll  |
| and you must guess the " |
| answer" for each roll.   |
|     It will be zero or a |
| n even number.           |
|     After your guess, yo |
| u will be told the answe |
| r for the roll, but . .  |
| .                        |
|     that's ALL the infor |
| mation you will get.     |
|                          |
|     Six consecutive corr |
| ect guesses admits you t |
| o the                    |
|     Fellowship of the Ro |
| se.                      |
|     INSTRUCTIONSZZZ      |
|                          |
|         echo -e "\033[0m |
| "    # Turn off blue.    |
|         else clear       |
|       fi                 |
|                          |
|     }                    |
|                          |
|                          |
|     fortune ()           |
|     {                    |
|       RANGE=7            |
|       FLOOR=0            |
|       number=0           |
|       while [ "$number"  |
| -le $FLOOR ]             |
|       do                 |
|         number=$RANDOM   |
|         let "number %= $ |
| RANGE"   # 1 - 6.        |
|       done               |
|                          |
|       return $number     |
|     }                    |
|                          |
|                          |
|                          |
|     throw () { # Calcula |
| te each individual die.  |
|       fortune; B1=$?     |
|       fortune; B2=$?     |
|       fortune; B3=$?     |
|       fortune; B4=$?     |
|       fortune; B5=$?     |
|                          |
|       calc () { # Functi |
| on embedded within a fun |
| ction!                   |
|         case "$1" in     |
|            3   ) rose=2; |
| ;                        |
|            5   ) rose=4; |
| ;                        |
|            *   ) rose=0; |
| ;                        |
|         esac    # Simpli |
| fied algorithm.          |
|                 # Doesn' |
| t really get to the hear |
| t of the matter.         |
|         return $rose     |
|       }                  |
|                          |
|       answer=0           |
|       calc "$B1"; answer |
| =$(expr $answer + $(echo |
|  $?))                    |
|       calc "$B2"; answer |
| =$(expr $answer + $(echo |
|  $?))                    |
|       calc "$B3"; answer |
| =$(expr $answer + $(echo |
|  $?))                    |
|       calc "$B4"; answer |
| =$(expr $answer + $(echo |
|  $?))                    |
|       calc "$B5"; answer |
| =$(expr $answer + $(echo |
|  $?))                    |
|     }                    |
|                          |
|                          |
|                          |
|     game ()              |
|     { # Generate graphic |
|  display of dice throw.  |
|       throw              |
|         echo -e "\033[1m |
| "    # Bold.             |
|       echo -e "\n"       |
|       echo -e "$bone\t$b |
| one\t$bone\t$bone\t$bone |
| "                        |
|       echo -e \          |
|      "${bone1[$B1]}\t${b |
| one1[$B2]}\t${bone1[$B3] |
| }\t${bone1[$B4]}\t${bone |
| 1[$B5]}"                 |
|       echo -e \          |
|      "${bone2[$B1]}\t${b |
| one2[$B2]}\t${bone2[$B3] |
| }\t${bone2[$B4]}\t${bone |
| 2[$B5]}"                 |
|       echo -e \          |
|      "${bone3[$B1]}\t${b |
| one3[$B2]}\t${bone3[$B3] |
| }\t${bone3[$B4]}\t${bone |
| 3[$B5]}"                 |
|       echo -e "$bone\t$b |
| one\t$bone\t$bone\t$bone |
| "                        |
|       echo -e "\n\n\t\t" |
|         echo -e "\033[0m |
| "    # Turn off bold.    |
|       echo -n "There are |
|  how many petals around  |
| the rose? "              |
|     }                    |
|                          |
|                          |
|                          |
|     # ================== |
| ======================== |
| ==================== #   |
|                          |
|     instructions         |
|                          |
|     while [ "$petal" !=  |
| "$EXIT" ]    # Main loop |
| .                        |
|     do                   |
|       game               |
|       read petal         |
|       echo "$petal" | gr |
| ep [0-9] >/dev/null  # F |
| ilter response for digit |
| .                        |
|                          |
|                      # O |
| therwise just roll dice  |
| again.                   |
|       if [ "$?" -eq 0 ]  |
|   # If-loop #1.          |
|       then               |
|         if [ "$petal" == |
|  "$answer" ]; then    #  |
| If-loop #2.              |
|             echo -e "\nC |
| orrect. There are $petal |
|  petals around the rose. |
| \n"                      |
|             (( hits++ )) |
|                          |
|             if [ "$hits" |
|  -eq "$WIN" ]; then   #  |
| If-loop #3.              |
|               echo -e '\ |
| E[31;47m'  # Red type.   |
|               echo -e "\ |
| 033[1m"    # Bold.       |
|               echo "You  |
| have unraveled the myste |
| ry of the Rose Petals!"  |
|               echo "Welc |
| ome to the Fellowship of |
|  the Rose!!!"            |
|               echo "(You |
|  are herewith sworn to s |
| ecrecy.)"; echo          |
|               echo -e "\ |
| 033[0m"    # Turn off re |
| d & bold.                |
|               break      |
|            # Exit!       |
|             else echo "Y |
| ou have $hits correct so |
|  far."; echo             |
|                          |
|             if [ "$hits" |
|  -eq "$ALMOST" ]; then   |
|               echo "Just |
|  one more gets you to th |
| e heart of the mystery!" |
| ; echo                   |
|             fi           |
|                          |
|           fi             |
|                       #  |
| Close if-loop #3.        |
|                          |
|         else             |
|           echo -e "\nWro |
| ng. There are $answer pe |
| tals around the rose.\n" |
|           hits=0   # Res |
| et number of correct gue |
| sses.                    |
|         fi               |
|                       #  |
| Close if-loop #2.        |
|                          |
|         echo -n "Hit ENT |
| ER for the next roll, or |
|  type \"exit\" to end. " |
|         read             |
|         if [ "$REPLY" =  |
| "$EXIT" ]; then exit     |
|         fi               |
|                          |
|       fi                 |
|   # Close if-loop #1.    |
|                          |
|       clear              |
|     done                 |
|   # End of main (while)  |
| loop.                    |
|                          |
|     ###                  |
|                          |
|     exit $?              |
|                          |
|     # Resources:         |
|     # ---------          |
|     # 1) http://en.wikip |
| edia.org/wiki/Petals_Aro |
| und_the_Rose             |
|     #    (Wikipedia entr |
| y.)                      |
|     # 2) http://www.borr |
| ett.id.au/computing/peta |
| ls-bg.htm                |
|     #    (How Bill Gates |
|  coped with the Petals A |
| round the Rose challenge |
| .)                       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-41. Quacky: a Perquackey-type word game**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # qky.sh             |
|                          |
|     #################### |
| ######################## |
| ##################       |
|     # QUACKEY: a somewha |
| t simplified version of  |
| Perquackey [TM]. #       |
|     #                    |
|                          |
|                  #       |
|     # Author: Mendel Coo |
| per  <thegrendel.abs@gma |
| il.com>          #       |
|     # version 0.1.02     |
|   03 May, 2008           |
|                  #       |
|     # License: GPL3      |
|                          |
|                  #       |
|     #################### |
| ######################## |
| ##################       |
|                          |
|     WLIST=/usr/share/dic |
| t/word.lst               |
|     #                    |
|   ^^^^^^^^  Word list fi |
| le found here.           |
|     #  ASCII word list,  |
| one word per line, UNIX  |
| format.                  |
|     #  A suggested list  |
| is the script author's " |
| yawl" word list package. |
|     #  http://bash.deta. |
| in/yawl-0.3.2.tar.gz     |
|     #    or              |
|     #  http://ibiblio.or |
| g/pub/Linux/libs/yawl-0. |
| 3.2.tar.gz               |
|                          |
|     NONCONS=0     # Word |
|  not constructable from  |
| letter set.              |
|     CONS=1        # Cons |
| tructable.               |
|     SUCCESS=0            |
|     NG=1                 |
|     FAILURE=''           |
|     NULL=0        # Zero |
|  out value of letter (if |
|  found).                 |
|     MINWLEN=3     # Mini |
| mum word length.         |
|     MAXCAT=5      # Maxi |
| mum number of words in a |
|  given category.         |
|     PENALTY=200   # Gene |
| ral-purpose penalty for  |
| unacceptable words.      |
|     total=               |
|     E_DUP=70      # Dupl |
| icate word error.        |
|                          |
|     TIMEOUT=10    # Time |
|  for word input.         |
|                          |
|     NVLET=10      # 10 l |
| etters for non-vulnerabl |
| e.                       |
|     VULET=13      # 13 l |
| etters for vulnerable (n |
| ot yet implemented!).    |
|                          |
|     declare -a Words     |
|     declare -a Status    |
|     declare -a Score=( 0 |
|  0 0 0 0 0 0 0 0 0 0 )   |
|                          |
|                          |
|     letters=( a n s r t  |
| m l k p r b c i d s i d  |
| z e w u e t f            |
|     e y e r e f e g t g  |
| h h i t r s c i t i d i  |
| j a t a o l a            |
|     m n a n o v n w o s  |
| e l n o s p a q e e r a  |
| b r s a o d s            |
|     t g t i t l u e u v  |
| n e o x y m r k )        |
|     #  Letter distributi |
| on table shamelessly bor |
| rowed from "Wordy" game, |
|     #+ ca. 1992, written |
|  by a certain fine fello |
| w named Mendel Cooper.   |
|                          |
|     declare -a LS        |
|                          |
|     numelements=${#lette |
| rs[@]}                   |
|     randseed="$1"        |
|                          |
|     instructions ()      |
|     {                    |
|       clear              |
|       echo "Welcome to Q |
| UACKEY, the anagramming  |
| word construction game." |
| ; echo                   |
|       echo -n "Do you ne |
| ed instructions? (y/n) " |
| ; read ans               |
|                          |
|        if [ "$ans" = "y" |
|  -o "$ans" = "Y" ]; then |
|          clear           |
|          echo -e '\E[31; |
| 47m'  # Red foreground.  |
| '\E[34;47m' for blue.    |
|          cat <<INSTRUCTI |
| ON1                      |
|                          |
|     QUACKEY is a variant |
|  of Perquackey [TM].     |
|     The rules are the sa |
| me, but the scoring is s |
| implified                |
|     and plurals of previ |
| ously played words are a |
| llowed.                  |
|     "Vulnerable" play is |
|  not yet implemented,    |
|     but it is otherwise  |
| feature-complete.        |
|                          |
|     As the game begins,  |
| the player gets 10 lette |
| rs.                      |
|     The object is to con |
| struct valid dictionary  |
| words                    |
|     of at least 3-letter |
|  length from the letters |
| et.                      |
|     Each word-length cat |
| egory                    |
|     -- 3-letter, 4-lette |
| r, 5-letter, ... --      |
|     fills up with the fi |
| fth word entered,        |
|     and no further words |
|  in that category are ac |
| cepted.                  |
|                          |
|     The penalty for too- |
| short (two-letter), dupl |
| icate, unconstructable,  |
|     and invalid (not in  |
| dictionary) words is -20 |
| 0. The same penalty appl |
| ies                      |
|     to attempts to enter |
|  a word in a filled-up c |
| ategory.                 |
|                          |
|     INSTRUCTION1         |
|                          |
|       echo -n "Hit ENTER |
|  for next page of instru |
| ctions. "; read az1      |
|                          |
|          cat <<INSTRUCTI |
| ON2                      |
|                          |
|     The scoring mostly c |
| orresponds to classic Pe |
| rquackey:                |
|     The first 3-letter w |
| ord scores    60, plus   |
|  10 for each additional  |
| one.                     |
|     The first 4-letter w |
| ord scores   120, plus   |
|  20 for each additional  |
| one.                     |
|     The first 5-letter w |
| ord scores   200, plus   |
|  50 for each additional  |
| one.                     |
|     The first 6-letter w |
| ord scores   300, plus   |
| 100 for each additional  |
| one.                     |
|     The first 7-letter w |
| ord scores   500, plus   |
| 150 for each additional  |
| one.                     |
|     The first 8-letter w |
| ord scores   750, plus   |
| 250 for each additional  |
| one.                     |
|     The first 9-letter w |
| ord scores  1000, plus   |
| 500 for each additional  |
| one.                     |
|     The first 10-letter  |
| word scores 2000, plus 2 |
| 000 for each additional  |
| one.                     |
|                          |
|     Category completion  |
| bonuses are:             |
|     3-letter words   100 |
|     4-letter words   200 |
|     5-letter words   400 |
|     6-letter words   800 |
|     7-letter words  2000 |
|     8-letter words 10000 |
|     This is a simplifica |
| tion of the absurdly bar |
| oque Perquackey bonus    |
|     scoring system.      |
|                          |
|     INSTRUCTION2         |
|                          |
|       echo -n "Hit ENTER |
|  for final page of instr |
| uctions. "; read az1     |
|                          |
|          cat <<INSTRUCTI |
| ON3                      |
|                          |
|                          |
|     Hitting just ENTER f |
| or a word entry ends the |
|  game.                   |
|                          |
|     Individual word entr |
| y is timed to a maximum  |
| of 10 seconds.           |
|     *** Timing out on an |
|  entry ends the game. ** |
| *                        |
|     Aside from that, the |
|  game is untimed.        |
|                          |
|     -------------------- |
| ------------------------ |
| ------                   |
|     Game statistics are  |
| automatically saved to a |
|  file.                   |
|     -------------------- |
| ------------------------ |
| ------                   |
|                          |
|     For competitive ("du |
| plicate") play, a previo |
| us letterset             |
|     may be duplicated by |
|  repeating the script's  |
| random seed,             |
|     command-line paramet |
| er \$1.                  |
|     For example, "qky 76 |
| 33" specifies the letter |
| set                      |
|     c a d i f r h u s k  |
| ...                      |
|     INSTRUCTION3         |
|                          |
|       echo; echo -n "Hit |
|  ENTER to begin game. "; |
|  read az1                |
|                          |
|            echo -e "\033 |
| [0m"    # Turn off red.  |
|          else clear      |
|       fi                 |
|                          |
|       clear              |
|                          |
|     }                    |
|                          |
|                          |
|                          |
|     seed_random ()       |
|     {                    |
|       #  Seed random num |
| ber generator.           |
|       if [ -n "$randseed |
| " ]   #  Can specify ran |
| dom seed.                |
|       then               |
|       #+ for play in com |
| petitive mode.           |
|     #   RANDOM="$randsee |
| d"                       |
|         echo "RANDOM see |
| d set to "$randseed""    |
|       else               |
|         randseed="$$"    |
|       # Or get random se |
| ed from process ID.      |
|         echo "RANDOM see |
| d not specified, set to  |
| Process ID of script ($$ |
| )."                      |
|       fi                 |
|                          |
|       RANDOM="$randseed" |
|                          |
|       echo               |
|     }                    |
|                          |
|                          |
|     get_letset ()        |
|     {                    |
|       element=0          |
|       echo -n "Letterset |
| :"                       |
|                          |
|       for lset in $(seq  |
| $NVLET)                  |
|       do  # Pick random  |
| letters to fill out lett |
| erset.                   |
|         LS[element]="${l |
| etters[$((RANDOM%numelem |
| ents))]}"                |
|         ((element++))    |
|       done               |
|                          |
|       echo               |
|       echo "${LS[@]}"    |
|                          |
|     }                    |
|                          |
|                          |
|     add_word ()          |
|     {                    |
|       wrd="$1"           |
|       local idx=0        |
|                          |
|       Status[0]=""       |
|       Status[3]=""       |
|       Status[4]=""       |
|                          |
|       while [ "${Words[i |
| dx]}" != '' ]            |
|       do                 |
|         if [ "${Words[id |
| x]}" = "$wrd" ]          |
|         then             |
|           Status[3]="Dup |
| licate-word-PENALTY"     |
|           let "Score[0]= |
|  0 - $PENALTY"           |
|           let "Score[1]- |
| =$PENALTY"               |
|           return $E_DUP  |
|         fi               |
|                          |
|         ((idx++))        |
|       done               |
|                          |
|       Words[idx]="$wrd"  |
|       get_score          |
|                          |
|     }                    |
|                          |
|     get_score()          |
|     {                    |
|       local wlen=0       |
|       local score=0      |
|       local bonus=0      |
|       local first_word=0 |
|       local add_word=0   |
|       local numwords=0   |
|                          |
|       wlen=${#wrd}       |
|       numwords=${Score[w |
| len]}                    |
|       Score[2]=0         |
|       Status[4]=""   # I |
| nitialize "bonus" to 0.  |
|                          |
|       case "$wlen" in    |
|         3) first_word=60 |
|            add_word=10;; |
|         4) first_word=12 |
| 0                        |
|            add_word=20;; |
|         5) first_word=20 |
| 0                        |
|            add_word=50;; |
|         6) first_word=30 |
| 0                        |
|            add_word=100; |
| ;                        |
|         7) first_word=50 |
| 0                        |
|            add_word=150; |
| ;                        |
|         8) first_word=75 |
| 0                        |
|            add_word=250; |
| ;                        |
|         9) first_word=10 |
| 00                       |
|            add_word=500; |
| ;                        |
|        10) first_word=20 |
| 00                       |
|            add_word=2000 |
| ;;   # This category mod |
| ified from original rule |
| s!                       |
|           esac           |
|                          |
|       ((Score[wlen]++))  |
|       if [ ${Score[wlen] |
| } -eq $MAXCAT ]          |
|       then   # Category  |
| completion bonus scoring |
|  simplified!             |
|         case $wlen in    |
|           3 ) bonus=100; |
| ;                        |
|           4 ) bonus=200; |
| ;                        |
|           5 ) bonus=400; |
| ;                        |
|           6 ) bonus=800; |
| ;                        |
|           7 ) bonus=2000 |
| ;;                       |
|           8 ) bonus=1000 |
| 0;;                      |
|         esac  # Needn't  |
| worry about 9's and 10's |
| .                        |
|         Status[4]="Categ |
| ory-$wlen-completion***B |
| ONUS***"                 |
|         Score[2]=$bonus  |
|       else               |
|         Status[4]=""   # |
|  Erase it.               |
|       fi                 |
|                          |
|                          |
|         let "score =  $f |
| irst_word +   $add_word  |
| * $numwords"             |
|         if [ "$numwords" |
|  -eq 0 ]                 |
|         then             |
|           Score[0]=$scor |
| e                        |
|         else             |
|           Score[0]=$add_ |
| word                     |
|         fi   #  All this |
|  to distinguish last-wor |
| d score                  |
|              #+ from tot |
| al running score.        |
|       let "Score[1] += $ |
| {Score[0]}"              |
|       let "Score[1] += $ |
| {Score[2]}"              |
|                          |
|     }                    |
|                          |
|                          |
|                          |
|     get_word ()          |
|     {                    |
|       local wrd=''       |
|       read -t $TIMEOUT w |
| rd   # Timed read.       |
|       echo $wrd          |
|     }                    |
|                          |
|     is_constructable ()  |
|     { # This is the most |
|  complex and difficult-t |
| o-write function.        |
|       local -a local_LS= |
| ( "${LS[@]}" )  # Local  |
| copy of letter set.      |
|       local is_found=0   |
|       local idx=0        |
|       local pos          |
|       local strlen       |
|       local local_word=( |
|  "$1" )                  |
|       strlen=${#local_wo |
| rd}                      |
|                          |
|       while [ "$idx" -lt |
|  "$strlen" ]             |
|       do                 |
|         is_found=$(expr  |
| index "${local_LS[*]}" " |
| ${local_word:idx:1}")    |
|         if [ "$is_found" |
|  -eq "$NONCONS" ] # Not  |
| constructable!           |
|         then             |
|           echo "$FAILURE |
| "; return                |
|         else             |
|           ((pos = ($is_f |
| ound - 1) / 2))   # Comp |
| ensate for spaces betw.  |
| letters!                 |
|           local_LS[pos]= |
| $NULL             # Zero |
|  out used letters.       |
|           ((idx++))      |
|                   # Bump |
|  index.                  |
|         fi               |
|       done               |
|                          |
|       echo "$SUCCESS"    |
|       return             |
|     }                    |
|                          |
|     is_valid ()          |
|     { # Surprisingly eas |
| y to check if word in di |
| ctionary ...             |
|       fgrep -qw "$1" "$W |
| LIST"   # ... courtesy o |
| f 'grep' ...             |
|       echo $?            |
|     }                    |
|                          |
|     check_word ()        |
|     {                    |
|       if [ -z "$1" ]     |
|       then               |
|         return           |
|       fi                 |
|                          |
|       Status[1]=""       |
|       Status[2]=""       |
|       Status[3]=""       |
|       Status[4]=""       |
|                          |
|       iscons=$(is_constr |
| uctable "$1")            |
|       if [ "$iscons" ]   |
|       then               |
|         Status[1]="const |
| ructable"                |
|         v=$(is_valid "$1 |
| ")                       |
|         if [ "$v" -eq "$ |
| SUCCESS" ]               |
|         then             |
|           Status[2]="val |
| id"                      |
|           strlen=${#1}   |
|                          |
|           if [ ${Score[s |
| trlen]} -eq "$MAXCAT" ]  |
|   # Category full!       |
|           then           |
|             Status[3]="C |
| ategory-$strlen-overflow |
| -PENALTY"                |
|             return $NG   |
|           fi             |
|                          |
|           case "$strlen" |
|  in                      |
|             1 | 2 )      |
|             Status[3]="T |
| wo-letter-word-PENALTY"  |
|             return $NG;; |
|             * )          |
|         Status[3]=""     |
|         return $SUCCESS; |
| ;                        |
|           esac           |
|         else             |
|           Status[3]="Not |
| -valid-PENALTY"          |
|           return $NG     |
|         fi               |
|       else               |
|         Status[3]="Not-c |
| onstructable-PENALTY"    |
|           return $NG     |
|       fi                 |
|                          |
|       ### FIXME: Streaml |
| ine the above code block |
| .                        |
|                          |
|     }                    |
|                          |
|                          |
|     display_words ()     |
|     {                    |
|       local idx=0        |
|       local wlen0        |
|                          |
|       clear              |
|       echo "Letterset:   |
|  ${LS[@]}"               |
|       echo "Threes:    F |
| ours:    Fives:     Sixe |
| s:    Sevens:    Eights: |
| "                        |
|       echo "------------ |
| ------------------------ |
| ------------------------ |
| "                        |
|                          |
|                          |
|                          |
|       while [ "${Words[i |
| dx]}" != '' ]            |
|       do                 |
|        wlen0=${#Words[id |
| x]}                      |
|        case "$wlen0" in  |
|          3) ;;           |
|          4) echo -n "    |
|         " ;;             |
|          5) echo -n "    |
|                   " ;;   |
|          6) echo -n "    |
|                          |
|      " ;;                |
|          7) echo -n "    |
|                          |
|                " ;;      |
|          8) echo -n "    |
|                          |
|                          |
|   " ;;                   |
|        esac              |
|        echo "${Words[idx |
| ]}"                      |
|        ((idx++))         |
|       done               |
|                          |
|       ### FIXME: The wor |
| d display is pretty crud |
| e.                       |
|     }                    |
|                          |
|                          |
|     play ()              |
|     {                    |
|       word="Start game"  |
|   # Dummy word, to start |
|  ...                     |
|                          |
|       while [ "$word" ]  |
|   #  If player just hits |
|  return (null word),     |
|       do                 |
|   #+ then game ends.     |
|         echo "$word: "${ |
| Status[@]}""             |
|         echo -n "Last sc |
| ore: [${Score[0]}]   TOT |
| AL score: [${Score[1]}]: |
|      Next word: "        |
|         total=${Score[1] |
| }                        |
|         word=$(get_word) |
|         check_word "$wor |
| d"                       |
|                          |
|         if [ "$?" -eq "$ |
| SUCCESS" ]               |
|         then             |
|           add_word "$wor |
| d"                       |
|         else             |
|           let "Score[0]= |
|  0 - $PENALTY"           |
|           let "Score[1]- |
| =$PENALTY"               |
|         fi               |
|                          |
|       display_words      |
|       done   # Exit game |
| .                        |
|                          |
|       ### FIXME: The pla |
| y () function calls too  |
| many other functions.    |
|       ### This verges on |
|  "spaghetti code" !!!    |
|     }                    |
|                          |
|     end_of_game ()       |
|     { # Save and display |
|  stats.                  |
|                          |
|       ################## |
| #####Autosave########### |
| ###############          |
|       savefile=qky.save. |
| $$                       |
|       #                  |
| ^^ PID of script         |
|       echo `date` >> $sa |
| vefile                   |
|       echo "Letterset #  |
| $randseed  (random seed) |
|  ">> $savefile           |
|       echo -n "Letterset |
| : " >> $savefile         |
|       echo "${LS[@]}" >> |
|  $savefile               |
|       echo "---------" > |
| > $savefile              |
|       echo "Words constr |
| ucted:" >> $savefile     |
|       echo "${Words[@]}" |
|  >> $savefile            |
|       echo >> $savefile  |
|       echo "Score: $tota |
| l" >> $savefile          |
|                          |
|       echo "Statistics f |
| or this round saved in \ |
| ""$savefile"\""          |
|       ################## |
| ######################## |
| ###############          |
|                          |
|       echo "Score for th |
| is round: $total"        |
|       echo "Words:  ${Wo |
| rds[@]}"                 |
|     }                    |
|                          |
|     # ---------#         |
|     instructions         |
|     seed_random          |
|     get_letset           |
|     play                 |
|     end_of_game          |
|     # ---------#         |
|                          |
|     exit $?              |
|                          |
|     # TODO:              |
|     #                    |
|     # 1) Clean up code!  |
|     # 2) Prettify the di |
| splay_words () function  |
| (maybe with widgets?).   |
|     # 3) Improve the tim |
| e-out ... maybe change t |
| o untimed entry,         |
|     #+   but with a time |
|  limit for the overall r |
| ound.                    |
|     # 4) An on-screen co |
| untdown timer would be n |
| ice.                     |
|     # 5) Implement "vuln |
| erable" mode of play for |
|  compatibility with clas |
| sic                      |
|     #+   version of the  |
| game.                    |
|     # 6) Improve save-to |
| -file capability (and ma |
| ybe make it optional).   |
|     # 7) Fix bugs!!!     |
|                          |
|     # For more info, ref |
| erence:                  |
|     # http://bash.deta.i |
| n/qky.README.html        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-42. Nim**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # nim.sh: Game of Ni |
| m                        |
|                          |
|     # Author: Mendel Coo |
| per                      |
|     # Reldate: 15 July 2 |
| 008                      |
|     # License: GPL3      |
|                          |
|     ROWS=5     # Five ro |
| ws of pegs (or matchstic |
| ks).                     |
|     WON=91     # Exit co |
| des to keep track of win |
| s/losses.                |
|     LOST=92    # Possibl |
| y useful if running in b |
| atch mode.               |
|     QUIT=99              |
|     peg_msg=   # Peg/Peg |
| s?                       |
|     Rows=( 0 5 4 3 2 1 ) |
|    # Array holding play  |
| info.                    |
|     # ${Rows[0]} holds t |
| otal number of pegs, upd |
| ated after each turn.    |
|     # Other array elemen |
| ts hold number of pegs i |
| n corresponding row.     |
|                          |
|     instructions ()      |
|     {                    |
|       clear              |
|       tput bold          |
|       echo "Welcome to t |
| he game of Nim."; echo   |
|       echo -n "Do you ne |
| ed instructions? (y/n) " |
| ; read ans               |
|                          |
|        if [ "$ans" = "y" |
|  -o "$ans" = "Y" ]; then |
|          clear           |
|          echo -e '\E[33; |
| 41m'  # Yellow fg., over |
|  red bg.; bold.          |
|          cat <<INSTRUCTI |
| ONS                      |
|                          |
|     Nim is a game with r |
| oots in the distant past |
| .                        |
|     This particular vari |
| ant starts with five row |
| s of pegs.               |
|                          |
|     1:    | | | | |      |
|     2:     | | | |       |
|     3:      | | |        |
|     4:       | |         |
|     5:        |          |
|                          |
|     The number at the le |
| ft identifies the row.   |
|                          |
|     The human player mov |
| es first, and alternates |
|  turns with the bot.     |
|     A turn consists of r |
| emoving at least one peg |
|  from a single row.      |
|     It is permissable to |
|  remove ALL the pegs fro |
| m a row.                 |
|     For example, in row  |
| 2, above, the player can |
|  remove 1, 2, 3, or 4 pe |
| gs.                      |
|     The player who remov |
| es the last peg loses.   |
|                          |
|     The strategy consist |
| s of trying to be the on |
| e who removes            |
|     the next-to-last peg |
| (s), leaving the loser w |
| ith the final peg.       |
|                          |
|     To exit the game ear |
| ly, hit ENTER during you |
| r turn.                  |
|     INSTRUCTIONS         |
|                          |
|     echo; echo -n "Hit E |
| NTER to begin game. "; r |
| ead azx                  |
|                          |
|           echo -e "\033[ |
| 0m"    # Restore display |
| .                        |
|           else tput sgr0 |
| ; clear                  |
|       fi                 |
|                          |
|     clear                |
|                          |
|     }                    |
|                          |
|                          |
|     tally_up ()          |
|     {                    |
|       let "Rows[0] = ${R |
| ows[1]} + ${Rows[2]} + $ |
| {Rows[3]} + ${Rows[4]} + |
|  \                       |
|       ${Rows[5]}"    # A |
| dd up how many pegs rema |
| ining.                   |
|     }                    |
|                          |
|                          |
|     display ()           |
|     {                    |
|       index=1   # Start  |
| with top row.            |
|       echo               |
|                          |
|       while [ "$index" - |
| le "$ROWS" ]             |
|       do                 |
|         p=${Rows[index]} |
|         echo -n "$index: |
|    "          # Show row |
|  number.                 |
|                          |
|       # ---------------- |
| ------------------------ |
| --------                 |
|       # Two concurrent i |
| nner loops.              |
|                          |
|           indent=$index  |
|           while [ "$inde |
| nt" -gt 0 ]              |
|           do             |
|             echo -n " "  |
|               # Staggere |
| d rows.                  |
|             ((indent--)) |
|               # Spacing  |
| between pegs.            |
|           done           |
|                          |
|         while [ "$p" -gt |
|  0 ]                     |
|         do               |
|           echo -n "| "   |
|           ((p--))        |
|         done             |
|       # ---------------- |
| ------------------------ |
| -------                  |
|                          |
|       echo               |
|       ((index++))        |
|       done               |
|                          |
|       tally_up           |
|                          |
|       rp=${Rows[0]}      |
|                          |
|       if [ "$rp" -eq 1 ] |
|       then               |
|         peg_msg=peg      |
|         final_msg="Game  |
| over."                   |
|       else             # |
|  Game not yet over . . . |
|         peg_msg=pegs     |
|         final_msg=""   # |
|  . . . So "final message |
| " is blank.              |
|       fi                 |
|                          |
|       echo "      $rp $p |
| eg_msg remaining."       |
|       echo "      "$fina |
| l_msg""                  |
|                          |
|                          |
|       echo               |
|     }                    |
|                          |
|     player_move ()       |
|     {                    |
|                          |
|       echo "Your move:"  |
|                          |
|       echo -n "Which row |
| ? "                      |
|       while read idx     |
|       do                 |
|    # Validity check, etc |
| .                        |
|                          |
|         if [ -z "$idx" ] |
|    # Hitting return quit |
| s.                       |
|         then             |
|             echo "Premat |
| ure exit."; echo         |
|             tput sgr0    |
|    # Restore display.    |
|             exit $QUIT   |
|         fi               |
|                          |
|         if [ "$idx" -gt  |
| "$ROWS" -o "$idx" -lt 1  |
| ]   # Bounds check.      |
|         then             |
|           echo "Invalid  |
| row number!"             |
|           echo -n "Which |
|  row? "                  |
|         else             |
|           break          |
|         fi               |
|         # TODO:          |
|         # Add check for  |
| non-numeric input.       |
|         # Also, script c |
| rashes on input outside  |
| of range of long double. |
|         # Fix this.      |
|                          |
|       done               |
|                          |
|       echo -n "Remove ho |
| w many? "                |
|       while read num     |
|       do                 |
|    # Validity check.     |
|                          |
|       if [ -z "$num" ]   |
|       then               |
|         echo "Premature  |
| exit."; echo             |
|         tput sgr0        |
|    # Restore display.    |
|         exit $QUIT       |
|       fi                 |
|                          |
|         if [ "$num" -gt  |
| ${Rows[idx]} -o "$num" - |
| lt 1 ]                   |
|         then             |
|           echo "Cannot r |
| emove $num!"             |
|           echo -n "Remov |
| e how many? "            |
|         else             |
|           break          |
|         fi               |
|       done               |
|       # TODO:            |
|       # Add check for no |
| n-numeric input.         |
|       # Also, script cra |
| shes on input outside of |
|  range of long double.   |
|       # Fix this.        |
|                          |
|       let "Rows[idx] -=  |
| $num"                    |
|                          |
|       display            |
|       tally_up           |
|                          |
|       if [ ${Rows[0]} -e |
| q 1 ]                    |
|       then               |
|        echo "      Human |
|  wins!"                  |
|        echo "      Congr |
| atulations!"             |
|        tput sgr0   # Res |
| tore display.            |
|        echo              |
|        exit $WON         |
|       fi                 |
|                          |
|       if [ ${Rows[0]} -e |
| q 0 ]                    |
|       then          # Sn |
| atching defeat from the  |
| jaws of victory . . .    |
|         echo "      Fool |
| !"                       |
|         echo "      You  |
| just removed the last pe |
| g!"                      |
|         echo "      Bot  |
| wins!"                   |
|         tput sgr0   # Re |
| store display.           |
|         echo             |
|         exit $LOST       |
|       fi                 |
|     }                    |
|                          |
|                          |
|     bot_move ()          |
|     {                    |
|                          |
|       row_b=0            |
|       while [[ $row_b -e |
| q 0 || ${Rows[row_b]} -e |
| q 0 ]]                   |
|       do                 |
|         row_b=$RANDOM    |
|        # Choose random r |
| ow.                      |
|         let "row_b %= $R |
| OWS"                     |
|       done               |
|                          |
|                          |
|       num_b=0            |
|       r0=${Rows[row_b]}  |
|                          |
|       if [ "$r0" -eq 1 ] |
|       then               |
|         num_b=1          |
|       else               |
|         let "num_b = $r0 |
|  - 1"                    |
|              #  Leave on |
| ly a single peg in the r |
| ow.                      |
|       fi     #  Not a ve |
| ry strong strategy,      |
|              #+ but prob |
| ably a bit better than t |
| otally random.           |
|                          |
|       let "Rows[row_b] - |
| = $num_b"                |
|       echo -n "Bot:  "   |
|       echo "Removing fro |
| m row $row_b ... "       |
|                          |
|       if [ "$num_b" -eq  |
| 1 ]                      |
|       then               |
|         peg_msg=peg      |
|       else               |
|         peg_msg=pegs     |
|       fi                 |
|                          |
|       echo "      $num_b |
|  $peg_msg."              |
|                          |
|       display            |
|       tally_up           |
|                          |
|       if [ ${Rows[0]} -e |
| q 1 ]                    |
|       then               |
|        echo "      Bot w |
| ins!"                    |
|        tput sgr0   # Res |
| tore display.            |
|        exit $WON         |
|       fi                 |
|                          |
|     }                    |
|                          |
|                          |
|     # ================== |
| ======================== |
| ======== #               |
|     instructions     # I |
| f human player needs the |
| m . . .                  |
|     tput bold        # B |
| old characters for easie |
| r viewing.               |
|     display          # S |
| how game board.          |
|                          |
|     while [ true ]   # M |
| ain loop.                |
|     do               # A |
| lternate human and bot t |
| urns.                    |
|       player_move        |
|       bot_move           |
|     done                 |
|     # ================== |
| ======================== |
| ======== #               |
|                          |
|     # Exercise:          |
|     # --------           |
|     # Improve the bot's  |
| strategy.                |
|     # There is, in fact, |
|  a Nim strategy that can |
|  force a win.            |
|     # See the Wikipedia  |
| article on Nim:  http:// |
| en.wikipedia.org/wiki/Ni |
| m                        |
|     # Recode the bot to  |
| use this strategy (rathe |
| r difficult).            |
|                          |
|     #  Curiosities:      |
|     #  -----------       |
|     #  Nim played a prom |
| inent role in Alain Resn |
| ais' 1961 New Wave film, |
|     #+ Last Year at Mari |
| enbad.                   |
|     #                    |
|     #  In 1978, Leo Chri |
| stopherson wrote an anim |
| ated version of Nim,     |
|     #+ Android Nim, for  |
| the TRS-80 Model I.      |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-43. A command-line stopwatch**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/sh            |
|     # sw.sh              |
|     # A command-line Sto |
| pwatch                   |
|                          |
|     # Author: Pádraig Br |
| ady                      |
|     #    http://www.pixe |
| lbeat.org/scripts/sw     |
|     #    (Minor reformat |
| ting by ABS Guide author |
| .)                       |
|     #    Used in ABS Gui |
| de with script author's  |
| permission.              |
|     # Notes:             |
|     #    This script sta |
| rts a few processes per  |
| lap, in addition to      |
|     #    the shell loop  |
| processing, so the assum |
| ption is made that       |
|     #    this takes an i |
| nsignificant amount of t |
| ime compared to          |
|     #    the response ti |
| me of humans (~.1s) (or  |
| the keyboard             |
|     #    interrupt rate  |
| (~.05s)).                |
|     #    '?' for splits  |
| must be entered twice if |
|  characters              |
|     #    (erroneously) e |
| ntered before it (on the |
|  same line).             |
|     #    '?' since not g |
| enerating a signal may b |
| e slightly delayed       |
|     #    on heavily load |
| ed systems.              |
|     #    Lap timings on  |
| ubuntu may be slightly d |
| elayed due to:           |
|     #    https://bugs.la |
| unchpad.net/bugs/62511   |
|     # Changes:           |
|     #    V1.0, 23 Aug 20 |
| 05, Initial release      |
|     #    V1.1, 26 Jul 20 |
| 07, Allow both splits an |
| d laps from single invoc |
| ation.                   |
|     #                    |
|     Only start timer aft |
| er a key is pressed.     |
|     #                    |
|     Indicate lap number  |
|     #                    |
|     Cache programs at st |
| artup so there is less e |
| rror                     |
|     #                    |
|     due to startup delay |
| s.                       |
|     #    V1.2, 01 Aug 20 |
| 07, Work around `date` c |
| ommands that don't have  |
|     #                    |
|     nanoseconds.         |
|     #                    |
|     Use stty to change i |
| nterrupt keys to space f |
| or                       |
|     #                    |
|     laps etc.            |
|     #                    |
|     Ignore other input a |
| s it causes problems.    |
|     #    V1.3, 01 Aug 20 |
| 07, Testing release.     |
|     #    V1.4, 02 Aug 20 |
| 07, Various tweaks to ge |
| t working under ubuntu   |
|     #                    |
|     and Mac OS X.        |
|     #    V1.5, 27 Jun 20 |
| 08, set LANG=C as got va |
| gue bug report about it. |
|                          |
|     export LANG=C        |
|                          |
|     ulimit -c 0   # No c |
| oredumps from SIGQUIT.   |
|     trap '' TSTP  # Igno |
| re Ctrl-Z just in case.  |
|     save_tty=`stty -g` & |
| & trap "stty $save_tty"  |
| EXIT  # Restore tty on e |
| xit.                     |
|     stty quit ' ' # Spac |
| e for laps rather than C |
| trl-\.                   |
|     stty eof  '?' # ? fo |
| r splits rather than Ctr |
| l-D.                     |
|     stty -echo    # Don' |
| t echo input.            |
|                          |
|     cache_progs() {      |
|         stty > /dev/null |
|         date > /dev/null |
|         grep . < /dev/nu |
| ll                       |
|         (echo "import ti |
| me" | python) 2> /dev/nu |
| ll                       |
|         bc < /dev/null   |
|         sed '' < /dev/nu |
| ll                       |
|         printf '1' > /de |
| v/null                   |
|         /usr/bin/time fa |
| lse 2> /dev/null         |
|         cat < /dev/null  |
|     }                    |
|     cache_progs   # To m |
| inimise startup delay.   |
|                          |
|     date +%s.%N | grep - |
| qF 'N' && use_python=1 # |
|  If `date` lacks nanosec |
| onds.                    |
|     now() {              |
|         if [ "$use_pytho |
| n" ]; then               |
|             echo "import |
|  time; print time.time() |
| " 2>/dev/null | python   |
|         else             |
|             printf "%.2f |
| " `date +%s.%N`          |
|         fi               |
|     }                    |
|                          |
|     fmt_seconds() {      |
|         seconds=$1       |
|         mins=`echo $seco |
| nds/60 | bc`             |
|         if [ "$mins" !=  |
| "0" ]; then              |
|             seconds=`ech |
| o "$seconds - ($mins*60) |
| " | bc`                  |
|             echo "$mins: |
| $seconds"                |
|         else             |
|             echo "$secon |
| ds"                      |
|         fi               |
|     }                    |
|                          |
|     total() {            |
|         end=`now`        |
|         total=`echo "$en |
| d - $start" | bc`        |
|         fmt_seconds $tot |
| al                       |
|     }                    |
|                          |
|     stop() {             |
|         [ "$lapped" ] && |
|  lap "$laptime" "display |
| "                        |
|         total            |
|         exit             |
|     }                    |
|                          |
|     lap() {              |
|         laptime=`echo "$ |
| 1" | sed -n 's/.*real[^0 |
| -9.]*\(.*\)/\1/p'`       |
|         [ ! "$laptime" - |
| o "$laptime" = "0.00" ]  |
| && return                |
|         # Signals too fr |
| equent.                  |
|         laptotal=`echo $ |
| laptime+0$laptotal | bc` |
|         if [ "$2" = "dis |
| play" ]; then            |
|             lapcount=`ec |
| ho 0$lapcount+1 | bc`    |
|             laptime=`fmt |
| _seconds $laptotal`      |
|             echo $laptim |
| e "($lapcount)"          |
|             lapped="true |
| "                        |
|             laptotal="0" |
|         fi               |
|     }                    |
|                          |
|     echo -n "Space for l |
| ap | ? for split | Ctrl- |
| C to stop | Space to sta |
| rt...">&2                |
|                          |
|     while true; do       |
|         trap true INT QU |
| IT  # Set signal handler |
| s.                       |
|         laptime=`/usr/bi |
| n/time -p 2>&1 cat >/dev |
| /null`                   |
|         ret=$?           |
|         trap '' INT QUIT |
|     # Ignore signals wit |
| hin this script.         |
|         if [ $ret -eq 1  |
| -o $ret -eq 2 -o $ret -e |
| q 130 ]; then # SIGINT = |
|  stop                    |
|             [ ! "$start" |
|  ] && { echo >&2; exit;  |
| }                        |
|             stop         |
|         elif [ $ret -eq  |
| 3 -o $ret -eq 131 ]; the |
| n             # SIGQUIT  |
| = lap                    |
|             if [ ! "$sta |
| rt" ]; then              |
|                 start=`n |
| ow` || exit 1            |
|                 echo >&2 |
|                 continue |
|             fi           |
|             lap "$laptim |
| e" "display"             |
|         else             |
|     # eof = split        |
|             [ ! "$start" |
|  ] && continue           |
|             total        |
|             lap "$laptim |
| e"  # Update laptotal.   |
|         fi               |
|     done                 |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-44. An all-purpose shell scripting homework assignment
solution**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     #  homework.sh: All- |
| purpose homework assignm |
| ent solution.            |
|     #  Author: M. Leo Co |
| oper                     |
|     #  If you substitute |
|  your own name as author |
| , then it is plagiarism, |
|     #+ possibly a lesser |
|  sin than cheating on yo |
| ur homework!             |
|     #  License: Public D |
| omain                    |
|                          |
|     #  This script may b |
| e turned in to your inst |
| ructor                   |
|     #+ in fulfillment of |
|  ALL shell scripting hom |
| ework assignments.       |
|     #  It's sparsely com |
| mented, but you, the stu |
| dent, can easily remedy  |
| that.                    |
|     #  The script author |
|  repudiates all responsi |
| bility!                  |
|                          |
|     DLA=1                |
|     P1=2                 |
|     P2=4                 |
|     P3=7                 |
|     PP1=0                |
|     PP2=8                |
|     MAXL=9               |
|     E_LZY=99             |
|                          |
|     declare -a L         |
|     L[0]="3 4 0 17 29 8  |
| 13 18 19 17 20 2 19 14 1 |
| 7 28"                    |
|     L[1]="8 29 12 14 18  |
| 19 29 4 12 15 7 0 19 8 2 |
|  0 11 11 24 29 17 4 6 17 |
|  4 19"                   |
|     L[2]="29 19 7 0 19 2 |
| 9 8 29 7 0 21 4 29 13 4  |
| 6 11 4 2 19 4 3"         |
|     L[3]="19 14 29 2 14  |
| 12 15 11 4 19 4 29 19 7  |
| 8 18 29"                 |
|     L[4]="18 2 7 14 14 1 |
| 1 22 14 17 10 29 0 18 18 |
|  8 6 13 12 4 13 19 26"   |
|     L[5]="15 11 4 0 18 4 |
|  29 0 2 2 4 15 19 29 12  |
| 24 29 7 20 12 1 11 4 29" |
|     L[6]="4 23 2 20 18 4 |
|  29 14 5 29 4 6 17 4 6 8 |
|  14 20 18 29"            |
|     L[7]="11 0 25 8 13 4 |
|  18 18 27"               |
|     L[8]="0 13 3 29 6 17 |
|  0 3 4 29 12 4 29 0 2 2  |
| 14 17 3 8 13 6 11 24 26" |
|     L[9]="19 7 0 13 10 2 |
| 9 24 14 20 26"           |
|                          |
|     declare -a \         |
|     alph=( A B C D E F G |
|  H I J K L M N O P Q R S |
|  T U V W X Y Z . , : ' ' |
|  )                       |
|                          |
|                          |
|     pt_lt ()             |
|     {                    |
|       echo -n "${alph[$1 |
| ]}"                      |
|       echo -n -e "\a"    |
|       sleep $DLA         |
|     }                    |
|                          |
|     b_r ()               |
|     {                    |
|      echo -e '\E[31;48m\ |
| 033[1m'                  |
|     }                    |
|                          |
|     cr ()                |
|     {                    |
|      echo -e "\a"        |
|      sleep $DLA          |
|     }                    |
|                          |
|     restore ()           |
|     {                    |
|       echo -e '\033[0m'  |
|            # Bold off.   |
|       tput sgr0          |
|            # Normal.     |
|     }                    |
|                          |
|                          |
|     p_l ()               |
|     {                    |
|       for ltr in $1      |
|       do                 |
|         pt_lt "$ltr"     |
|       done               |
|     }                    |
|                          |
|     # ------------------ |
| ----                     |
|     b_r                  |
|                          |
|     for i in $(seq 0 $MA |
| XL)                      |
|     do                   |
|       p_l "${L[i]}"      |
|       if [[ "$i" -eq "$P |
| 1" || "$i" -eq "$P2" ||  |
| "$i" -eq "$P3" ]]        |
|       then               |
|         cr               |
|       elif [[ "$i" -eq " |
| $PP1" || "$i" -eq "$PP2" |
|  ]]                      |
|       then               |
|         cr; cr           |
|       fi                 |
|     done                 |
|                          |
|     restore              |
|     # ------------------ |
| ----                     |
|                          |
|     echo                 |
|                          |
|     exit $E_LZY          |
|                          |
|     #  A typical example |
|  of an obfuscated script |
|  that is difficult       |
|     #+ to understand, an |
| d frustrating to maintai |
| n.                       |
|     #  In your career as |
|  a sysadmin, you'll run  |
| into these critters      |
|     #+ all too often.    |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-45. The Knight's Tour**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ktour.sh           |
|                          |
|     # author: mendel coo |
| per                      |
|     # reldate: 12 Jan 20 |
| 09                       |
|     # license: public do |
| main                     |
|     # (Not much sense GP |
| Ling something that's pr |
| etty much in the common  |
|     #+ domain anyhow.)   |
|                          |
|     #################### |
| ######################## |
| #######################  |
|     #             The Kn |
| ight's Tour, a classic p |
| roblem.               #  |
|     #             ====== |
| ======================== |
| =======               #  |
|     #  The knight must m |
| ove onto every square of |
|  the chess board,     #  |
|     #  but cannot revisi |
| t any square he has alre |
| ady visited.          #  |
|     #                    |
|                          |
|                       #  |
|     #  And just why is S |
| ir Knight unwelcome for  |
| a return visit?       #  |
|     #  Could it be that  |
| he has a habit of partyi |
| ng into the wee hours #  |
|     #+ of the morning?   |
|                          |
|                       #  |
|     #  Possibly he leave |
| s pizza crusts in the be |
| d, empty beer bottles #  |
|     #+ all over the floo |
| r, and clogs the plumbin |
| g. . . .              #  |
|     #                    |
|                          |
|                       #  |
|     #  ----------------- |
| ------------------------ |
| --------------------  #  |
|     #                    |
|                          |
|                       #  |
|     #  Usage: ktour.sh [ |
| start-square] [stupid]   |
|                       #  |
|     #                    |
|                          |
|                       #  |
|     #  Note that start-s |
| quare can be a square nu |
| mber                  #  |
|     #+ in the range 0 -  |
| 63 ... or                |
|                       #  |
|     #  a square designat |
| or in conventional chess |
|  notation,            #  |
|     #  such as a1, f5, h |
| 3, etc.                  |
|                       #  |
|     #                    |
|                          |
|                       #  |
|     #  If start-square-n |
| umber not supplied,      |
|                       #  |
|     #+ then starts on a  |
| random square somewhere  |
| on the board.         #  |
|     #                    |
|                          |
|                       #  |
|     # "stupid" as second |
|  parameter sets the stup |
| id strategy.          #  |
|     #                    |
|                          |
|                       #  |
|     #  Examples:         |
|                          |
|                       #  |
|     #  ktour.sh 23       |
|     starts on square #23 |
|  (h3)                 #  |
|     #  ktour.sh g6 stupi |
| d   starts on square #46 |
| ,                     #  |
|     #                    |
|     using "stupid" (non- |
| Warnsdorff) strategy. #  |
|     #################### |
| ######################## |
| #######################  |
|                          |
|     DEBUG=      # Set th |
| is to echo debugging inf |
| o to stdout.             |
|     SUCCESS=0            |
|     FAIL=99              |
|     BADMOVE=-999         |
|     FAILURE=1            |
|     LINELEN=21  # How ma |
| ny moves to display per  |
| line.                    |
|     # ------------------ |
| ---------------------- # |
|     # Board array params |
|     ROWS=8   # 8 x 8 boa |
| rd.                      |
|     COLS=8               |
|     let "SQUARES = $ROWS |
|  * $COLS"                |
|     let "MAX = $SQUARES  |
| - 1"                     |
|     MIN=0                |
|     # 64 squares on boar |
| d, indexed from 0 to 63. |
|                          |
|     VISITED=1            |
|     UNVISITED=-1         |
|     UNVSYM="##"          |
|     # ------------------ |
| ---------------------- # |
|     # Global variables.  |
|     startpos=    # Start |
| ing position (square #,  |
| 0 - 63).                 |
|     currpos=     # Curre |
| nt position.             |
|     movenum=     # Move  |
| number.                  |
|     CRITPOS=37   # Have  |
| to patch for f5 starting |
|  position!               |
|                          |
|     declare -i board     |
|     # Use a one-dimensio |
| nal array to simulate a  |
| two-dimensional one.     |
|     # This can make life |
|  difficult and result in |
|  ugly kludges; see below |
| .                        |
|     declare -i moves  #  |
| Offsets from current kni |
| ght position.            |
|                          |
|                          |
|     initialize_board ()  |
|     {                    |
|       local idx          |
|                          |
|       for idx in {0..63} |
|       do                 |
|         board[$idx]=$UNV |
| ISITED                   |
|       done               |
|     }                    |
|                          |
|                          |
|                          |
|     print_board ()       |
|     {                    |
|       local idx          |
|                          |
|       echo "    ________ |
| ________________________ |
| _____"                   |
|       for row in {7..0}  |
|               #  Reverse |
|  order of rows ...       |
|       do                 |
|               #+ so it p |
| rints in chessboard orde |
| r.                       |
|         let "rownum = $r |
| ow + 1"       #  Start n |
| umbering rows at 1.      |
|         echo -n "$rownum |
|   |"          #  Mark bo |
| ard edge with border and |
|         for column in {0 |
| ..7}          #+ "algebr |
| aic notation."           |
|         do               |
|           let "idx = $RO |
| WS*$row + $column"       |
|           if [ ${board[i |
| dx]} -eq $UNVISITED ]    |
|           then           |
|             echo -n "$UN |
| VSYM   "      ##         |
|           else           |
|               # Mark squ |
| are with move number.    |
|             printf "%02d |
|  " "${board[idx]}"; echo |
|  -n "  "                 |
|           fi             |
|         done             |
|         echo -e -n "\b\b |
| \b|"  # \b is a backspac |
| e.                       |
|         echo             |
|       # -e enables echoi |
| ng escaped chars.        |
|       done               |
|                          |
|       echo "    -------- |
| ------------------------ |
| -----"                   |
|       echo "     a    b  |
|    c    d    e    f    g |
|     h"                   |
|     }                    |
|                          |
|                          |
|                          |
|     failure()            |
|     { # Whine, then bail |
|  out.                    |
|       echo               |
|       print_board        |
|       echo               |
|       echo    "   Waah!! |
| ! Ran out of squares to  |
| move to!"                |
|       echo -n "   Knight |
| 's Tour attempt ended"   |
|       echo    " on $(to_ |
| algebraic $currpos) [squ |
| are #$currpos]"          |
|       echo    "   after  |
| just $movenum moves!"    |
|       echo               |
|       exit $FAIL         |
|     }                    |
|                          |
|                          |
|                          |
|     xlat_coords ()   #   |
| Translate x/y coordinate |
| s to board position      |
|     {                #+  |
| (board-array element #). |
|       #  For user input  |
| of starting board positi |
| on as x/y coords.        |
|       #  This function n |
| ot used in initial relea |
| se of ktour.sh.          |
|       #  May be used in  |
| an updated version, for  |
| compatibility with       |
|       #+ standard implem |
| entation of the Knight's |
|  Tour in C, Python, etc. |
|       if [ -z "$1" -o -z |
|  "$2" ]                  |
|       then               |
|         return $FAIL     |
|       fi                 |
|                          |
|       local xc=$1        |
|       local yc=$2        |
|                          |
|       let "board_index = |
|  $xc * $ROWS + yc"       |
|                          |
|       if [ $board_index  |
| -lt $MIN -o $board_index |
|  -gt $MAX ]              |
|       then               |
|         return $FAIL     |
| # Strayed off the board! |
|       else               |
|         return $board_in |
| dex                      |
|       fi                 |
|     }                    |
|                          |
|                          |
|                          |
|     to_algebraic ()   #  |
|  Translate board positio |
| n (board-array element # |
| )                        |
|     {                 #+ |
|  to standard algebraic n |
| otation used by chess pl |
| ayers.                   |
|       if [ -z "$1" ]     |
|       then               |
|         return $FAIL     |
|       fi                 |
|                          |
|       local element_no=$ |
| 1   # Numerical board po |
| sition.                  |
|       local col_arr=( a  |
| b c d e f g h )          |
|       local row_arr=( 1  |
| 2 3 4 5 6 7 8 )          |
|                          |
|       let "row_no = $ele |
| ment_no / $ROWS"         |
|       let "col_no = $ele |
| ment_no % $ROWS"         |
|       t1=${col_arr[col_n |
| o]}; t2=${row_arr[row_no |
| ]}                       |
|       local apos=$t1$t2  |
|   # Concatenate.         |
|       echo $apos         |
|     }                    |
|                          |
|                          |
|                          |
|     from_algebraic ()    |
| #  Translate standard al |
| gebraic chess notation   |
|     {                    |
| #+ to numerical board po |
| sition (board-array elem |
| ent #).                  |
|                          |
| #  Or recognize numerica |
| l input & return it unch |
| anged.                   |
|       if [ -z "$1" ]     |
|       then               |
|         return $FAIL     |
|       fi   # If no comma |
| nd-line arg, then will d |
| efault to random start p |
| os.                      |
|                          |
|       local ix           |
|       local ix_count=0   |
|       local b_index      |
| # Board index [0-63]     |
|       local alpos="$1"   |
|                          |
|       arow=${alpos:0:1}  |
| # position = 0, length = |
|  1                       |
|       acol=${alpos:1:1}  |
|                          |
|       if [[ $arow =~ [[: |
| digit:]] ]]   #  Numeric |
| al input?                |
|       then       #  POSI |
| X char class             |
|         if [[ $acol =~ [ |
| [:alpha:]] ]] # Number f |
| ollowed by a letter? Ill |
| egal!                    |
|           then return $F |
| AIL                      |
|         else if [ $alpos |
|  -gt $MAX ]   # Off boar |
| d?                       |
|           then return $F |
| AIL                      |
|         else return $alp |
| os            #  Return  |
| digit(s) unchanged . . . |
|           fi             |
|               #+ if with |
| in range.                |
|         fi               |
|       fi                 |
|                          |
|       if [[ $acol -eq $M |
| IN || $acol -gt $ROWS ]] |
|       then        # Outs |
| ide of range 1 - 8?      |
|         return $FAIL     |
|       fi                 |
|                          |
|       for ix in a b c d  |
| e f g h                  |
|       do  # Convert colu |
| mn letter to column numb |
| er.                      |
|        if [ "$arow" = "$ |
| ix" ]                    |
|        then              |
|          break           |
|        fi                |
|       ((ix_count++))     |
| # Find index count.      |
|       done               |
|                          |
|       ((acol--))         |
| # Decrementing converts  |
| to zero-based array.     |
|       let "b_index = $ix |
| _count + $acol * $ROWS"  |
|                          |
|       if [ $b_index -gt  |
| $MAX ]   # Off board?    |
|       then               |
|         return $FAIL     |
|       fi                 |
|                          |
|       return $b_index    |
|                          |
|     }                    |
|                          |
|                          |
|     generate_moves ()    |
| #  Calculate all valid k |
| night moves,             |
|     {                    |
| #+ relative to current p |
| osition ($1),            |
|                          |
| #+ and store in ${moves} |
|  array.                  |
|       local kt_hop=1     |
| #  One square  :: short  |
| leg of knight move.      |
|       local kt_skip=2    |
| #  Two squares :: long l |
| eg  of knight move.      |
|       local valmov=0     |
| #  Valid moves.          |
|       local row_pos; let |
|  "row_pos = $1 % $COLS"  |
|                          |
|                          |
|       let "move1 = -$kt_ |
| skip + $ROWS"            |
| # 2 sideways to-the-left |
| ,  1 up                  |
|         if [[ `expr $row |
| _pos - $kt_skip` -lt $MI |
| N ]]   # An ugly, ugly k |
| ludge!                   |
|         then             |
|                          |
|        # Can't move off  |
| board.                   |
|           move1=$BADMOVE |
|                          |
|        # Not even tempor |
| arily.                   |
|         else             |
|           ((valmov++))   |
|         fi               |
|       let "move2 = -$kt_ |
| hop + $kt_skip * $ROWS"  |
| # 1 sideways to-the-left |
| ,  2 up                  |
|         if [[ `expr $row |
| _pos - $kt_hop` -lt $MIN |
|  ]]    # Kludge continue |
| d ...                    |
|         then             |
|           move2=$BADMOVE |
|         else             |
|           ((valmov++))   |
|         fi               |
|       let "move3 =  $kt_ |
| hop + $kt_skip * $ROWS"  |
| # 1 sideways to-the-righ |
| t, 2 up                  |
|         if [[ `expr $row |
| _pos + $kt_hop` -ge $COL |
| S ]]                     |
|         then             |
|           move3=$BADMOVE |
|         else             |
|           ((valmov++))   |
|         fi               |
|       let "move4 =  $kt_ |
| skip + $ROWS"            |
| # 2 sideways to-the-righ |
| t, 1 up                  |
|         if [[ `expr $row |
| _pos + $kt_skip` -ge $CO |
| LS ]]                    |
|         then             |
|           move4=$BADMOVE |
|         else             |
|           ((valmov++))   |
|         fi               |
|       let "move5 =  $kt_ |
| skip - $ROWS"            |
| # 2 sideways to-the-righ |
| t, 1 dn                  |
|         if [[ `expr $row |
| _pos + $kt_skip` -ge $CO |
| LS ]]                    |
|         then             |
|           move5=$BADMOVE |
|         else             |
|           ((valmov++))   |
|         fi               |
|       let "move6 =  $kt_ |
| hop - $kt_skip * $ROWS"  |
| # 1 sideways to-the-righ |
| t, 2 dn                  |
|         if [[ `expr $row |
| _pos + $kt_hop` -ge $COL |
| S ]]                     |
|         then             |
|           move6=$BADMOVE |
|         else             |
|           ((valmov++))   |
|         fi               |
|       let "move7 = -$kt_ |
| hop - $kt_skip * $ROWS"  |
| # 1 sideways to-the-left |
| ,  2 dn                  |
|         if [[ `expr $row |
| _pos - $kt_hop` -lt $MIN |
|  ]]                      |
|         then             |
|           move7=$BADMOVE |
|         else             |
|           ((valmov++))   |
|         fi               |
|       let "move8 = -$kt_ |
| skip - $ROWS"            |
| # 2 sideways to-the-left |
| ,  1 dn                  |
|         if [[ `expr $row |
| _pos - $kt_skip` -lt $MI |
| N ]]                     |
|         then             |
|           move8=$BADMOVE |
|         else             |
|           ((valmov++))   |
|         fi   # There mus |
| t be a better way to do  |
| this.                    |
|                          |
|       local m=( $valmov  |
| $move1 $move2 $move3 $mo |
| ve4 $move5 $move6 $move7 |
|  $move8 )                |
|       # ${moves[0]} = nu |
| mber of valid moves.     |
|       # ${moves[1]} ...  |
| ${moves[8]} = possible m |
| oves.                    |
|       echo "${m[*]}"     |
| # Elements of array to s |
| tdout for capture in a v |
| ar.                      |
|                          |
|     }                    |
|                          |
|                          |
|                          |
|     is_on_board ()  # Is |
|  position actually on th |
| e board?                 |
|     {                    |
|       if [[ "$1" -lt "$M |
| IN" || "$1" -gt "$MAX" ] |
| ]                        |
|       then               |
|         return $FAILURE  |
|       else               |
|         return $SUCCESS  |
|       fi                 |
|     }                    |
|                          |
|                          |
|                          |
|     do_move ()      # Mo |
| ve the knight!           |
|     {                    |
|       local valid_moves= |
| 0                        |
|       local aapos        |
|       currposl="$1"      |
|       lmin=$ROWS         |
|       iex=0              |
|       squarel=           |
|       mpm=               |
|       mov=               |
|       declare -a p_moves |
|                          |
|       ################## |
| ######## DECIDE-MOVE ### |
| ######################## |
| ##                       |
|       if [ $startpos -ne |
|  $CRITPOS ]              |
|       then   # CRITPOS = |
|  square #37              |
|         decide_move      |
|       else               |
|        # Needs a special |
|  patch for startpos=37 ! |
| !!                       |
|         decide_move_patc |
| hed    # Why this partic |
| ular move and no other ? |
| ??                       |
|       fi                 |
|       ################## |
| ######################## |
| ######################## |
| ##                       |
|                          |
|       (( ++movenum ))    |
|        # Increment move  |
| count.                   |
|       let "square = $cur |
| rposl + ${moves[iex]}"   |
|                          |
|       ################## |
|     DEBUG    ########### |
| ####                     |
|       if [ "$DEBUG" ]    |
|         then debug   # E |
| cho debugging informatio |
| n.                       |
|       fi                 |
|       ################## |
| ######################## |
| ####                     |
|                          |
|       if [[ "$square" -g |
| t $MAX || "$square" -lt  |
| $MIN ||                  |
|             ${board[squa |
| re]} -ne $UNVISITED ]]   |
|       then               |
|         (( --movenum ))  |
|              #  Decremen |
| t move count,            |
|         echo "RAN OUT OF |
|  SQUARES!!!" #+ since pr |
| evious one was invalid.  |
|         return $FAIL     |
|       fi                 |
|                          |
|       board[square]=$mov |
| enum                     |
|       currpos=$square    |
|     # Update current pos |
| ition.                   |
|       ((valid_moves++)); |
|     # moves[0]=$valid_mo |
| ves                      |
|       aapos=$(to_algebra |
| ic $square)              |
|       echo -n "$aapos "  |
|       test $(( $Moves %  |
| $LINELEN )) -eq 0 && ech |
| o                        |
|       # Print LINELEN=21 |
|  moves per line. A valid |
|  tour shows 3 complete l |
| ines.                    |
|       return $valid_move |
| s   # Found a square to  |
| move to!                 |
|     }                    |
|                          |
|                          |
|                          |
|     do_move_stupid()   # |
|   Dingbat algorithm,     |
|     {                  # |
| + courtesy of script aut |
| hor, *not* Warnsdorff.   |
|       local valid_moves= |
| 0                        |
|       local movloc       |
|       local squareloc    |
|       local aapos        |
|       local cposloc="$1" |
|                          |
|       for movloc in {1.. |
| 8}                       |
|       do       # Move to |
|  first-found unvisited s |
| quare.                   |
|         let "squareloc = |
|  $cposloc + ${moves[movl |
| oc]}"                    |
|         is_on_board $squ |
| areloc                   |
|         if [ $? -eq $SUC |
| CESS ] && [ ${board[squa |
| reloc]} -eq $UNVISITED ] |
|         then   # Add con |
| ditions to above if-test |
|  to improve algorithm.   |
|           (( ++movenum ) |
| )                        |
|           board[squarelo |
| c]=$movenum              |
|           currpos=$squar |
| eloc     # Update curren |
| t position.              |
|           ((valid_moves+ |
| +));     # moves[0]=$val |
| id_moves                 |
|           aapos=$(to_alg |
| ebraic $squareloc)       |
|           echo -n "$aapo |
| s "                      |
|           test $(( $Move |
| s % $LINELEN )) -eq 0 && |
|  echo   # Print 21 moves |
| /line.                   |
|           return $valid_ |
| moves    # Found a squar |
| e to move to!            |
|         fi               |
|       done               |
|                          |
|       return $FAIL       |
|       #  If no square fo |
| und in all 8 loop iterat |
| ions,                    |
|       #+ then Knight's T |
| our attempt ends in fail |
| ure.                     |
|                          |
|       #  Dingbat algorit |
| hm will typically fail a |
| fter about 30 - 40 moves |
| ,                        |
|       #+ but executes _m |
| uch_ faster than Warnsdo |
| rff's in do_move() funct |
| ion.                     |
|     }                    |
|                          |
|                          |
|                          |
|     decide_move ()       |
|    #  Which move will we |
|  make?                   |
|     {                    |
|    #  But, fails on star |
| tpos=37 !!!              |
|       for mov in {1..8}  |
|       do                 |
|         let "squarel = $ |
| currposl + ${moves[mov]} |
| "                        |
|         is_on_board $squ |
| arel                     |
|         if [[ $? -eq $SU |
| CCESS && ${board[squarel |
| ]} -eq $UNVISITED ]]     |
|         then   #  Find a |
| ccessible square with le |
| ast possible future move |
| s.                       |
|                #  This i |
| s Warnsdorff's algorithm |
| .                        |
|                #  What h |
| appens is that the knigh |
| t wanders toward the out |
| er edge                  |
|                #+ of the |
|  board, then pretty much |
|  spirals inward.         |
|                #  Given  |
| two or more possible mov |
| es with same value of    |
|                #+ least- |
| possible-future-moves, t |
| his implementation choos |
| es                       |
|                #+ the _f |
| irst_ of those moves.    |
|                #  This m |
| eans that there is not n |
| ecessarily a unique solu |
| tion                     |
|                #+ for an |
| y given starting positio |
| n.                       |
|                          |
|           possible_moves |
|  $squarel                |
|           mpm=$?         |
|           p_moves[mov]=$ |
| mpm                      |
|                          |
|           if [ $mpm -lt  |
| $lmin ]  # If less than  |
| previous minimum ...     |
|           then #     ^^  |
|             lmin=$mpm    |
|          # Update minimu |
| m.                       |
|             iex=$mov     |
|          # Save index.   |
|           fi             |
|                          |
|         fi               |
|       done               |
|     }                    |
|                          |
|                          |
|                          |
|     decide_move_patched  |
| ()         #  Decide whi |
| ch move to make,         |
|     {  #        ^^^^^^^  |
|            #+ but only i |
| f startpos=37 !!!        |
|       for mov in {1..8}  |
|       do                 |
|         let "squarel = $ |
| currposl + ${moves[mov]} |
| "                        |
|         is_on_board $squ |
| arel                     |
|         if [[ $? -eq $SU |
| CCESS && ${board[squarel |
| ]} -eq $UNVISITED ]]     |
|         then             |
|           possible_moves |
|  $squarel                |
|           mpm=$?         |
|           p_moves[mov]=$ |
| mpm                      |
|                          |
|           if [ $mpm -le  |
| $lmin ]  # If less-than- |
| or equal to prev. minimu |
| m!                       |
|           then #     ^^  |
|             lmin=$mpm    |
|             iex=$mov     |
|           fi             |
|                          |
|         fi               |
|       done               |
|          # There has to  |
| be a better way to do th |
| is.                      |
|     }                    |
|                          |
|                          |
|                          |
|     possible_moves ()    |
|          #  Calculate nu |
| mber of possible moves,  |
|     {                    |
|          #+ given the cu |
| rrent position.          |
|                          |
|       if [ -z "$1" ]     |
|       then               |
|         return $FAIL     |
|       fi                 |
|                          |
|       local curr_pos=$1  |
|       local valid_movl=0 |
|       local icx=0        |
|       local movl         |
|       local sq           |
|       declare -a moveslo |
| c                        |
|                          |
|       movesloc=( $(gener |
| ate_moves $curr_pos) )   |
|                          |
|       for movl in {1..8} |
|       do                 |
|         let "sq = $curr_ |
| pos + ${movesloc[movl]}" |
|         is_on_board $sq  |
|         if [ $? -eq $SUC |
| CESS ] && [ ${board[sq]} |
|  -eq $UNVISITED ]        |
|         then             |
|           ((valid_movl++ |
| ));                      |
|         fi               |
|       done               |
|                          |
|       return $valid_movl |
|          # Found a squar |
| e to move to!            |
|     }                    |
|                          |
|                          |
|     strategy ()          |
|     {                    |
|       echo               |
|                          |
|       if [ -n "$STUPID"  |
| ]                        |
|       then               |
|         for Moves in {1. |
| .63}                     |
|         do               |
|           cposl=$1       |
|           moves=( $(gene |
| rate_moves $currpos) )   |
|           do_move_stupid |
|  "$currpos"              |
|           if [ $? -eq $F |
| AIL ]                    |
|           then           |
|             failure      |
|           fi             |
|           done           |
|       fi                 |
|                          |
|       #  Don't need an " |
| else" clause here,       |
|       #+ because Stupid  |
| Strategy will always fai |
| l and exit!              |
|       for Moves in {1..6 |
| 3}                       |
|       do                 |
|         cposl=$1         |
|         moves=( $(genera |
| te_moves $currpos) )     |
|         do_move "$currpo |
| s"                       |
|         if [ $? -eq $FAI |
| L ]                      |
|         then             |
|           failure        |
|         fi               |
|                          |
|       done               |
|             #  Could hav |
| e condensed above two do |
| -loops into a single one |
| ,                        |
|       echo  #+ but this  |
| would have slowed execut |
| ion.                     |
|                          |
|       print_board        |
|       echo               |
|       echo "Knight's Tou |
| r ends on $(to_algebraic |
|  $currpos) [square #$cur |
| rpos]."                  |
|       return $SUCCESS    |
|     }                    |
|                          |
|     debug ()             |
|     {       # Enable thi |
| s by setting DEBUG=1 nea |
| r beginning of script.   |
|       local n            |
|                          |
|       echo "============ |
| ====================="   |
|       echo "  At move nu |
| mber  $movenum:"         |
|       echo " *** possibl |
| e moves = $mpm ***"      |
|     # echo "### square = |
|  $square ###"            |
|       echo "lmin = $lmin |
| "                        |
|       echo "${moves[@]}" |
|                          |
|       for n in {1..8}    |
|       do                 |
|         echo -n "($n):${ |
| p_moves[n]} "            |
|       done               |
|                          |
|       echo               |
|       echo "iex = $iex : |
| : moves[iex] = ${moves[i |
| ex]}"                    |
|       echo "square = $sq |
| uare"                    |
|       echo "============ |
| ====================="   |
|       echo               |
|     } # Gives pretty com |
| plete status after ea. m |
| ove.                     |
|                          |
|                          |
|                          |
|     # ================== |
| ======================== |
| ===================== #  |
|     # int main () {      |
|     from_algebraic "$1"  |
|     startpos=$?          |
|     if [ "$startpos" -eq |
|  "$FAIL" ]          # Ok |
| ay even if no $1.        |
|     then   #         ^^^ |
| ^^^^^^^^              Ok |
| ay even if input -lt 0.  |
|       echo "No starting  |
| square specified (or ill |
| egal input)."            |
|       let "startpos = $R |
| ANDOM % $SQUARES"   # 0  |
| - 63 permissable range.  |
|     fi                   |
|                          |
|                          |
|     if [ "$2" = "stupid" |
|  ]                       |
|     then                 |
|       STUPID=1           |
|       echo -n "     ###  |
| Stupid Strategy ###"     |
|     else                 |
|       STUPID=''          |
|       echo -n "  *** War |
| nsdorff's Algorithm ***" |
|     fi                   |
|                          |
|                          |
|     initialize_board     |
|                          |
|     movenum=0            |
|     board[startpos]=$mov |
| enum   # Mark each board |
|  square with move number |
| .                        |
|     currpos=$startpos    |
|     algpos=$(to_algebrai |
| c $startpos)             |
|                          |
|     echo; echo "Starting |
|  from $algpos [square #$ |
| startpos] ..."; echo     |
|     echo -n "Moves:"     |
|                          |
|     strategy "$currpos"  |
|                          |
|     echo                 |
|                          |
|     exit 0   # return 0; |
|                          |
|     # }      # End of ma |
| in() pseudo-function.    |
|     # ================== |
| ======================== |
| ===================== #  |
|                          |
|                          |
|     # Exercises:         |
|     # ---------          |
|     #                    |
|     # 1) Extend this exa |
| mple to a 10 x 10 board  |
| or larger.               |
|     # 2) Improve the "st |
| upid strategy" by modify |
| ing the                  |
|     #    do_move_stupid  |
| function.                |
|     #    Hint: Prevent s |
| traying into corner squa |
| res in early moves       |
|     #          (the exac |
| t opposite of Warnsdorff |
| 's algorithm!).          |
|     # 3) This script cou |
| ld stand considerable im |
| provement and            |
|     #    streamlining, e |
| specially in the poorly- |
| written                  |
|     #    generate_moves( |
| ) function               |
|     #    and in the DECI |
| DE-MOVE patch in the do_ |
| move() function.         |
|     #    Must figure out |
|  why standard algorithm  |
| fails for startpos=37 .. |
| .                        |
|     #+   but _not_ on an |
| y other, including symme |
| trical startpos=26.      |
|     #    Possibly, when  |
| calculating possible mov |
| es, counts the move back |
|     #+   to the originat |
| ing square. If so, it mi |
| ght be a relatively easy |
|  fix.                    |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-46. Magic Squares**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # msquare.sh         |
|     # Magic Square gener |
| ator (odd-order squares  |
| only!)                   |
|                          |
|     # Author: mendel coo |
| per                      |
|     # reldate: 19 Jan. 2 |
| 009                      |
|     # License: Public Do |
| main                     |
|     # A C-program by the |
|  very talented Kwon Youn |
| g Shin inspired this scr |
| ipt.                     |
|     #     http://user.ch |
| ollian.net/~brainstm/Mag |
| icSquare.htm             |
|                          |
|     # Definition: A "mag |
| ic square" is a two-dime |
| nsional array            |
|     #             of int |
| egers in which all the r |
| ows, columns,            |
|     #             and *l |
| ong* diagonals add up to |
|  the same number.        |
|     #             Being  |
| "square," the array has  |
| the same number          |
|     #             of row |
| s and columns. That numb |
| er is the "order."       |
|     # An example of a ma |
| gic square of order 3 is |
| :                        |
|     #   8  1  6          |
|     #   3  5  7          |
|     #   4  9  2          |
|     # All the rows, colu |
| mns, and the two long di |
| agonals add up to 15.    |
|                          |
|                          |
|     # Globals            |
|     EVEN=2               |
|     MAXSIZE=31   # 31 ro |
| ws x 31 cols.            |
|     E_usage=90   # Invoc |
| ation error.             |
|     dimension=           |
|     declare -i square    |
|                          |
|     usage_message ()     |
|     {                    |
|       echo "Usage: $0 or |
| der"                     |
|       echo "   ... where |
|  \"order\" (square size) |
|  is an ODD integer"      |
|       echo "       in th |
| e range 3 - 31."         |
|       #  Actually works  |
| for squares up to order  |
| 159,                     |
|       #+ but large squar |
| es will not display pret |
| ty-printed in a term win |
| dow.                     |
|       #  Try increasing  |
| MAXSIZE, above.          |
|       exit $E_usage      |
|     }                    |
|                          |
|                          |
|     calculate ()       # |
|  Here's where the actual |
|  work gets done.         |
|     {                    |
|       local row col inde |
| x dimadj j k cell_val=1  |
|       dimension=$1       |
|                          |
|       let "dimadj = $dim |
| ension * 3"; let "dimadj |
|  /= 2"   # x 1.5, then t |
| runcate.                 |
|                          |
|       for ((j=0; j < dim |
| ension; j++))            |
|       do                 |
|         for ((k=0; k < d |
| imension; k++))          |
|         do  # Calculate  |
| indices, then convert to |
|  1-dim. array index.     |
|             # Bash doesn |
| 't support multidimensio |
| nal arrays. Pity.        |
|           let "col = $k  |
| - $j + $dimadj"; let "co |
| l %= $dimension"         |
|           let "row = $j  |
| * 2 - $k + $dimension";  |
| let "row %= $dimension"  |
|           let "index = $ |
| row*($dimension) + $col" |
|           square[$index] |
| =cell_val; ((cell_val++) |
| )                        |
|         done             |
|       done               |
|     }     # Plain math,  |
| visualization not requir |
| ed.                      |
|                          |
|                          |
|     print_square ()      |
|           # Output squar |
| e, one row at a time.    |
|     {                    |
|       local row col idx  |
| d1                       |
|       let "d1 = $dimensi |
| on - 1"   # Adjust for z |
| ero-indexed array.       |
|                          |
|       for row in $(seq 0 |
|  $d1)                    |
|       do                 |
|                          |
|         for col in $(seq |
|  0 $d1)                  |
|         do               |
|           let "idx = $ro |
| w * $dimension + $col"   |
|           printf "%3d "  |
| "${square[idx]}"; echo - |
| n "  "                   |
|         done   # Display |
| s up to 13th order neatl |
| y in 80-column term wind |
| ow.                      |
|                          |
|         echo   # Newline |
|  after each row.         |
|       done               |
|     }                    |
|                          |
|                          |
|     #################### |
| ######################## |
| #####                    |
|     if [[ -z "$1" ]] ||  |
| [[ "$1" -gt $MAXSIZE ]]  |
|     then                 |
|       usage_message      |
|     fi                   |
|                          |
|     let "test_even = $1  |
| % $EVEN"                 |
|     if [ $test_even -eq  |
| 0 ]                      |
|     then           # Can |
| 't handle even-order squ |
| ares.                    |
|       usage_message      |
|     fi                   |
|                          |
|     calculate $1         |
|     print_square   # ech |
| o "${square[@]}"   # DEB |
| UG                       |
|                          |
|     exit $?              |
|     #################### |
| ######################## |
| #####                    |
|                          |
|                          |
|     # Exercises:         |
|     # ---------          |
|     # 1) Add a function  |
| to calculate the sum of  |
| each row, column,        |
|     #    and *long* diag |
| onal. The sums must matc |
| h.                       |
|     #    This is the "ma |
| gic constant" of that pa |
| rticular order square.   |
|     # 2) Have the print_ |
| square function auto-cal |
| culate how much space    |
|     #    to allot betwee |
| n square elements for op |
| timized display.         |
|     #    This might requ |
| ire parameterizing the " |
| printf" line.            |
|     # 3) Add appropriate |
|  functions for generatin |
| g magic squares          |
|     #    with an *even*  |
| number of rows/columns.  |
|     #    This is non-tri |
| vial(!).                 |
|     #    See the URL for |
|  Kwon Young Shin, above, |
|  for help.               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-47. Fifteen Puzzle**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # fifteen.sh         |
|                          |
|     # Classic "Fifteen P |
| uzzle"                   |
|     # Author: Antonio Ma |
| cchi                     |
|     # Lightly edited and |
|  commented by ABS Guide  |
| author.                  |
|     # Used in ABS Guide  |
| with permission. (Thanks |
| !)                       |
|                          |
|     #  The invention of  |
| the Fifteen Puzzle is at |
| tributed to either       |
|     #+ Sam Loyd or Noyes |
|  Palmer Chapman.         |
|     #  The puzzle was wi |
| ldly popular in the late |
|  19th-century.           |
|                          |
|     #  Object: Rearrange |
|  the numbers so they rea |
| d in order,              |
|     #+ from 1 - 15:   __ |
| ______________           |
|     #                |   |
| 1   2   3   4 |          |
|     #                |   |
| 5   6   7   8 |          |
|     #                |   |
| 9  10  11  12 |          |
|     #                | 1 |
| 3  14  15     |          |
|     #                 -- |
| --------------           |
|                          |
|                          |
|     #################### |
| ###                      |
|     # Constants          |
|   #                      |
|       SQUARES=16         |
|   #                      |
|       FAIL=70            |
|   #                      |
|       E_PREMATURE_EXIT=8 |
| 0 #                      |
|     #################### |
| ###                      |
|                          |
|                          |
|     ########             |
|     # Data #             |
|     ########             |
|                          |
|     Puzzle=( 1 2 3 4 5 6 |
|  7 8 9 10 11 12 13 14 15 |
|  " " )                   |
|                          |
|                          |
|     #############        |
|     # Functions #        |
|     #############        |
|                          |
|     function swap        |
|     {                    |
|       local tmp          |
|                          |
|       tmp=${Puzzle[$1]}  |
|       Puzzle[$1]=${Puzzl |
| e[$2]}                   |
|       Puzzle[$2]=$tmp    |
|     }                    |
|                          |
|                          |
|     function Jumble      |
|     { # Scramble the pie |
| ces at beginning of roun |
| d.                       |
|       local i pos1 pos2  |
|                          |
|       for i in {1..100}  |
|       do                 |
|         pos1=$(( $RANDOM |
|  % $SQUARES))            |
|         pos2=$(( $RANDOM |
|  % $SQUARES ))           |
|         swap $pos1 $pos2 |
|       done               |
|     }                    |
|                          |
|                          |
|     function PrintPuzzle |
|     {                    |
|       local i1 i2 puzpos |
|       puzpos=0           |
|                          |
|       clear              |
|       echo "Enter  quit  |
|  to exit."; echo   # Bet |
| ter that than Ctl-C.     |
|                          |
|       echo ",----.----.- |
| ---.----."   # Top borde |
| r.                       |
|       for i1 in {1..4}   |
|       do                 |
|         for i2 in {1..4} |
|                          |
|         do               |
|           printf "| %2s  |
| " "${Puzzle[$puzpos]}"   |
|           (( puzpos++ )) |
|         done             |
|         echo "|"         |
|              # Right-sid |
| e border.                |
|         test $i1 = 4 ||  |
| echo "+----+----+----+-- |
| --+"                     |
|       done               |
|       echo "'----'----'- |
| ---'----'"   # Bottom bo |
| rder.                    |
|     }                    |
|                          |
|                          |
|     function GetNum      |
|     { # Test for valid i |
| nput.                    |
|       local puznum garba |
| ge                       |
|                          |
|       while true         |
|       do                 |
|           echo "Moves: $ |
| moves" # Also counts inv |
| alid moves.              |
|         read -p "Number  |
| to move: " puznum garbag |
| e                        |
|           if [ "$puznum" |
|  = "quit" ]; then echo;  |
| exit $E_PREMATURE_EXIT;  |
| fi                       |
|         test -z "$puznum |
| " -o -n "${puznum//[0-9] |
| /}" && continue          |
|         test $puznum -gt |
|  0 -a $puznum -lt $SQUAR |
| ES && break              |
|       done               |
|       return $puznum     |
|     }                    |
|                          |
|                          |
|     function GetPosFromN |
| um                       |
|     { # $1 = puzzle-numb |
| er                       |
|       local puzpos       |
|                          |
|       for puzpos in {0.. |
| 15}                      |
|       do                 |
|         test "${Puzzle[$ |
| puzpos]}" = "$1" && brea |
| k                        |
|       done               |
|       return $puzpos     |
|     }                    |
|                          |
|                          |
|     function Move        |
|     { # $1=Puzzle-pos    |
|       test $1 -gt 3 && t |
| est "${Puzzle[$(( $1 - 4 |
|  ))]}" = " "\            |
|            && swap $1 $( |
| ( $1 - 4 )) && return 0  |
|       test $(( $1%4 )) - |
| ne 3 && test "${Puzzle[$ |
| (( $1 + 1 ))]}" = " "\   |
|            && swap $1 $( |
| ( $1 + 1 )) && return 0  |
|       test $1 -lt 12 &&  |
| test "${Puzzle[$(( $1 +  |
| 4 ))]}" = " "\           |
|            && swap $1 $( |
| ( $1 + 4 )) && return 0  |
|       test $(( $1%4 )) - |
| ne 0 && test "${Puzzle[$ |
| (( $1 - 1 ))]}" = " " && |
| \                        |
|            swap $1 $(( $ |
| 1 - 1 )) && return 0     |
|       return 1           |
|     }                    |
|                          |
|                          |
|     function Solved      |
|     {                    |
|       local pos          |
|                          |
|       for pos in {0..14} |
|       do                 |
|         test "${Puzzle[$ |
| pos]}" = $(( $pos + 1 )) |
|  || return $FAIL         |
|         # Check whether  |
| number in each square =  |
| square number.           |
|       done               |
|       return 0   # Succe |
| ssful solution.          |
|     }                    |
|                          |
|                          |
|     ###################  |
| MAIN () ################ |
| #######{                 |
|     moves=0              |
|     Jumble               |
|                          |
|     while true   # Loop  |
| continuously until puzzl |
| e solved.                |
|     do                   |
|       echo; echo         |
|       PrintPuzzle        |
|       echo               |
|       while true         |
|       do                 |
|         GetNum           |
|         puznum=$?        |
|         GetPosFromNum $p |
| uznum                    |
|         puzpos=$?        |
|         ((moves++))      |
|         Move $puzpos &&  |
| break                    |
|       done               |
|       Solved && break    |
|     done                 |
|                          |
|     echo;echo            |
|     PrintPuzzle          |
|     echo; echo "BRAVO!"; |
|  echo                    |
|                          |
|     exit 0               |
|     #################### |
| ######################## |
| #######}                 |
|                          |
|     #  Exercise:         |
|     #  --------          |
|     #  Rewrite the scrip |
| t to display the letters |
|  A - O,                  |
|     #+ rather than the n |
| umbers 1 - 15.           |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-48. *The Towers of Hanoi, graphic version***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # The Towers Of Hano |
| i                        |
|     # Original script (h |
| anoi.bash) copyright (C) |
|  2000 Amit Singh.        |
|     # All Rights Reserve |
| d.                       |
|     # http://hanoi.kerne |
| lthread.com              |
|                          |
|     #  hanoi2.bash       |
|     #  Version 2.00: mod |
| ded for ASCII-graphic di |
| splay.                   |
|     #  Version 2.01: fix |
| ed no command-line param |
|  bug.                    |
|     #  Uses code contrib |
| uted by Antonio Macchi,  |
|     #+ with heavy editin |
| g by ABS Guide author.   |
|     #  This variant fall |
| s under the original cop |
| yright, see above.       |
|     #  Used in ABS Guide |
|  with Amit Singh's permi |
| ssion (thanks!).         |
|                          |
|                          |
|     ###   Variables && s |
| anity check   ###        |
|                          |
|     E_NOPARAM=86         |
|     E_BADPARAM=87        |
|      # Illegal no. of di |
| sks passed to script.    |
|     E_NOEXIT=88          |
|                          |
|     DISKS=${1:-$E_NOPARA |
| M}   # Must specify how  |
| many disks.              |
|     Moves=0              |
|                          |
|     MWIDTH=7             |
|     MARGIN=2             |
|     # Arbitrary "magic"  |
| constants; work okay for |
|  relatively small # of d |
| isks.                    |
|     # BASEWIDTH=51   # O |
| riginal code.            |
|     let "basewidth = $MW |
| IDTH * $DISKS + $MARGIN" |
|        # "Base" beneath  |
| rods.                    |
|     # Above "algorithm"  |
| could likely stand impro |
| vement.                  |
|                          |
|     ###   Display variab |
| les   ###                |
|     let "disks1 = $DISKS |
|  - 1"                    |
|     let "spaces1 = $DISK |
| S"                       |
|     let "spaces2 = 2 * $ |
| DISKS"                   |
|                          |
|     let "lastmove_t = $D |
| ISKS - 1"                |
|        # Final move?     |
|                          |
|                          |
|     declare -a Rod1 Rod2 |
|  Rod3                    |
|                          |
|     ###   ############## |
| ###########   ###        |
|                          |
|                          |
|     function repeat  {   |
| # $1=char $2=number of r |
| epetitions               |
|       local n            |
| # Repeat-print a charact |
| er.                      |
|                          |
|       for (( n=0; n<$2;  |
| n++ )); do               |
|         echo -n "$1"     |
|       done               |
|     }                    |
|                          |
|     function FromRod  {  |
|       local rod summit w |
| eight sequence           |
|                          |
|       while true; do     |
|         rod=$1           |
|         test ${rod/[^123 |
| ]/} || continue          |
|                          |
|         sequence=$(echo  |
| $(seq 0 $disks1 | tac))  |
|         for summit in $s |
| equence; do              |
|           eval weight=\$ |
| {Rod${rod}[$summit]}     |
|           test $weight - |
| ne 0 &&                  |
|                { echo "$ |
| rod $summit $weight"; re |
| turn; }                  |
|         done             |
|       done               |
|     }                    |
|                          |
|                          |
|     function ToRod  { #  |
| $1=previous (FromRod) we |
| ight                     |
|       local rod firstfre |
| e weight sequence        |
|                          |
|       while true; do     |
|         rod=$2           |
|         test ${rod/[^123 |
| ]} || continue           |
|                          |
|         sequence=$(echo  |
| $(seq 0 $disks1 | tac))  |
|         for firstfree in |
|  $sequence; do           |
|           eval weight=\$ |
| {Rod${rod}[$firstfree]}  |
|           test $weight - |
| gt 0 && { (( firstfree++ |
|  )); break; }            |
|         done             |
|         test $weight -gt |
|  $1 -o $firstfree = 0 && |
|              { echo "$ro |
| d $firstfree"; return; } |
|       done               |
|     }                    |
|                          |
|                          |
|     function PrintRods   |
| {                        |
|       local disk rod emp |
| ty fill sp sequence      |
|                          |
|                          |
|       repeat " " $spaces |
| 1                        |
|       echo -n "|"        |
|       repeat " " $spaces |
| 2                        |
|       echo -n "|"        |
|       repeat " " $spaces |
| 2                        |
|       echo "|"           |
|                          |
|       sequence=$(echo $( |
| seq 0 $disks1 | tac))    |
|       for disk in $seque |
| nce; do                  |
|         for rod in {1..3 |
| }; do                    |
|           eval empty=$(( |
|  $DISKS - (Rod${rod}[$di |
| sk] / 2) ))              |
|           eval fill=\${R |
| od${rod}[$disk]}         |
|           repeat " " $em |
| pty                      |
|           test $fill -gt |
|  0 && repeat "*" $fill | |
| | echo -n "|"            |
|           repeat " " $em |
| pty                      |
|         done             |
|         echo             |
|       done               |
|       repeat "=" $basewi |
| dth   # Print "base" ben |
| eath rods.               |
|       echo               |
|     }                    |
|                          |
|                          |
|     display ()           |
|     {                    |
|       echo               |
|       PrintRods          |
|                          |
|       # Get rod-number,  |
| summit and weight        |
|       first=( `FromRod $ |
| 1` )                     |
|       eval Rod${first[0] |
| }[${first[1]}]=0         |
|                          |
|       # Get rod-number a |
| nd first-free position   |
|       second=( `ToRod ${ |
| first[2]} $2` )          |
|       eval Rod${second[0 |
| ]}[${second[1]}]=${first |
| [2]}                     |
|                          |
|                          |
|     echo; echo; echo     |
|     if [ "${Rod3[lastmov |
| e_t]}" = 1 ]             |
|     then   # Last move?  |
| If yes, then display fin |
| al position.             |
|         echo "+  Final P |
| osition: $Moves moves";  |
| echo                     |
|         PrintRods        |
|       fi                 |
|     }                    |
|                          |
|                          |
|     # From here down, al |
| most the same as origina |
| l (hanoi.bash) script.   |
|                          |
|     dohanoi() {   # Recu |
| rsive function.          |
|         case $1 in       |
|         0)               |
|             ;;           |
|         *)               |
|             dohanoi "$(( |
| $1-1))" $2 $4 $3         |
|         if [ "$Moves" -n |
| e 0 ]                    |
|             then         |
|           echo "+  Posit |
| ion after move $Moves"   |
|             fi           |
|             ((Moves++))  |
|             echo -n "    |
| Next move will be:  "    |
|             echo $2 "--> |
| " $3                     |
|               display $2 |
|  $3                      |
|             dohanoi "$(( |
| $1-1))" $4 $3 $2         |
|             ;;           |
|         esac             |
|     }                    |
|                          |
|                          |
|     setup_arrays ()      |
|     {                    |
|       local dim n elem   |
|                          |
|       let "dim1 = $1 - 1 |
| "                        |
|       elem=$dim1         |
|                          |
|       for n in $(seq 0 $ |
| dim1)                    |
|       do                 |
|        let "Rod1[$elem]  |
| = 2 * $n + 1"            |
|        Rod2[$n]=0        |
|        Rod3[$n]=0        |
|        ((elem--))        |
|       done               |
|     }                    |
|                          |
|                          |
|     ###   Main   ###     |
|                          |
|     setup_arrays $DISKS  |
|     echo; echo "+  Start |
|  Position"               |
|                          |
|     case $# in           |
|         1) case $(($1>0) |
| ) in     # Must have at  |
| least one disk.          |
|            1)            |
|                disks=$1  |
|                dohanoi $ |
| 1 1 3 2                  |
|     #          Total mov |
| es = 2^n - 1, where n =  |
| number of disks.         |
|            echo          |
|                exit 0;   |
|                ;;        |
|            *)            |
|                echo "$0: |
|  Illegal value for numbe |
| r of disks";             |
|                exit $E_B |
| ADPARAM;                 |
|                ;;        |
|            esac          |
|         ;;               |
|         *)               |
|            clear         |
|            echo "usage:  |
| $0 N"                    |
|            echo "        |
| Where \"N\" is the numbe |
| r of disks."             |
|            exit $E_NOPAR |
| AM;                      |
|            ;;            |
|     esac                 |
|                          |
|     exit $E_NOEXIT   # S |
| houldn't exit here.      |
|                          |
|     # Note:              |
|     # Redirect script ou |
| tput to a file, otherwis |
| e it scrolls off display |
| .                        |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-49. *The Towers of Hanoi, alternate graphic version***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #! /bin/bash         |
|     # The Towers Of Hano |
| i                        |
|     # Original script (h |
| anoi.bash) copyright (C) |
|  2000 Amit Singh.        |
|     # All Rights Reserve |
| d.                       |
|     # http://hanoi.kerne |
| lthread.com              |
|                          |
|     #  hanoi2.bash       |
|     #  Version 2: modded |
|  for ASCII-graphic displ |
| ay.                      |
|     #  Uses code contrib |
| uted by Antonio Macchi,  |
|     #+ with heavy editin |
| g by ABS Guide author.   |
|     #  This variant also |
|  falls under the origina |
| l copyright, see above.  |
|     #  Used in ABS Guide |
|  with Amit Singh's permi |
| ssion (thanks!).         |
|                          |
|                          |
|     #   Variables   #    |
|     E_NOPARAM=86         |
|     E_BADPARAM=87   # Il |
| legal no. of disks passe |
| d to script.             |
|     E_NOEXIT=88          |
|     DELAY=2         # In |
| terval, in seconds, betw |
| een moves. Change, if de |
| sired.                   |
|     DISKS=$1             |
|     Moves=0              |
|                          |
|     MWIDTH=7             |
|     MARGIN=2             |
|     # Arbitrary "magic"  |
| constants, work okay for |
|  relatively small # of d |
| isks.                    |
|     # BASEWIDTH=51   # O |
| riginal code.            |
|     let "basewidth = $MW |
| IDTH * $DISKS + $MARGIN" |
|  # "Base" beneath rods.  |
|     # Above "algorithm"  |
| could likely stand impro |
| vement.                  |
|                          |
|     # Display variables. |
|     let "disks1 = $DISKS |
|  - 1"                    |
|     let "spaces1 = $DISK |
| S"                       |
|     let "spaces2 = 2 * $ |
| DISKS"                   |
|                          |
|     let "lastmove_t = $D |
| ISKS - 1"                |
|  # Final move?           |
|                          |
|                          |
|     declare -a Rod1 Rod2 |
|  Rod3                    |
|                          |
|     #################    |
|                          |
|                          |
|     function repeat  {   |
| # $1=char $2=number of r |
| epetitions               |
|       local n            |
| # Repeat-print a charact |
| er.                      |
|                          |
|       for (( n=0; n<$2;  |
| n++ )); do               |
|         echo -n "$1"     |
|       done               |
|     }                    |
|                          |
|     function FromRod  {  |
|       local rod summit w |
| eight sequence           |
|                          |
|       while true; do     |
|         rod=$1           |
|         test ${rod/[^123 |
| ]/} || continue          |
|                          |
|         sequence=$(echo  |
| $(seq 0 $disks1 | tac))  |
|         for summit in $s |
| equence; do              |
|           eval weight=\$ |
| {Rod${rod}[$summit]}     |
|           test $weight - |
| ne 0 &&                  |
|                { echo "$ |
| rod $summit $weight"; re |
| turn; }                  |
|         done             |
|       done               |
|     }                    |
|                          |
|                          |
|     function ToRod  { #  |
| $1=previous (FromRod) we |
| ight                     |
|       local rod firstfre |
| e weight sequence        |
|                          |
|       while true; do     |
|         rod=$2           |
|         test ${rod/[^123 |
| ]} || continue           |
|                          |
|         sequence=$(echo  |
| $(seq 0 $disks1 | tac))  |
|         for firstfree in |
|  $sequence; do           |
|           eval weight=\$ |
| {Rod${rod}[$firstfree]}  |
|           test $weight - |
| gt 0 && { (( firstfree++ |
|  )); break; }            |
|         done             |
|         test $weight -gt |
|  $1 -o $firstfree = 0 && |
|              { echo "$ro |
| d $firstfree"; return; } |
|       done               |
|     }                    |
|                          |
|                          |
|     function PrintRods   |
| {                        |
|       local disk rod emp |
| ty fill sp sequence      |
|                          |
|       tput cup 5 0       |
|                          |
|       repeat " " $spaces |
| 1                        |
|       echo -n "|"        |
|       repeat " " $spaces |
| 2                        |
|       echo -n "|"        |
|       repeat " " $spaces |
| 2                        |
|       echo "|"           |
|                          |
|       sequence=$(echo $( |
| seq 0 $disks1 | tac))    |
|       for disk in $seque |
| nce; do                  |
|         for rod in {1..3 |
| }; do                    |
|           eval empty=$(( |
|  $DISKS - (Rod${rod}[$di |
| sk] / 2) ))              |
|           eval fill=\${R |
| od${rod}[$disk]}         |
|           repeat " " $em |
| pty                      |
|           test $fill -gt |
|  0 && repeat "*" $fill | |
| | echo -n "|"            |
|           repeat " " $em |
| pty                      |
|         done             |
|         echo             |
|       done               |
|       repeat "=" $basewi |
| dth   # Print "base" ben |
| eath rods.               |
|       echo               |
|     }                    |
|                          |
|                          |
|     display ()           |
|     {                    |
|       echo               |
|       PrintRods          |
|                          |
|       # Get rod-number,  |
| summit and weight        |
|       first=( `FromRod $ |
| 1` )                     |
|       eval Rod${first[0] |
| }[${first[1]}]=0         |
|                          |
|       # Get rod-number a |
| nd first-free position   |
|       second=( `ToRod ${ |
| first[2]} $2` )          |
|       eval Rod${second[0 |
| ]}[${second[1]}]=${first |
| [2]}                     |
|                          |
|                          |
|       if [ "${Rod3[lastm |
| ove_t]}" = 1 ]           |
|       then   # Last move |
| ? If yes, then display f |
| inal position.           |
|         tput cup 0 0     |
|         echo; echo "+  F |
| inal Position: $Moves mo |
| ves"                     |
|         PrintRods        |
|       fi                 |
|                          |
|       sleep $DELAY       |
|     }                    |
|                          |
|     # From here down, al |
| most the same as origina |
| l (hanoi.bash) script.   |
|                          |
|     dohanoi() {   # Recu |
| rsive function.          |
|         case $1 in       |
|         0)               |
|             ;;           |
|         *)               |
|             dohanoi "$(( |
| $1-1))" $2 $4 $3         |
|         if [ "$Moves" -n |
| e 0 ]                    |
|             then         |
|           tput cup 0 0   |
|           echo; echo "+  |
|  Position after move $Mo |
| ves"                     |
|             fi           |
|             ((Moves++))  |
|             echo -n "    |
| Next move will be:  "    |
|             echo $2 "--> |
| " $3                     |
|             display $2 $ |
| 3                        |
|             dohanoi "$(( |
| $1-1))" $4 $3 $2         |
|             ;;           |
|         esac             |
|     }                    |
|                          |
|     setup_arrays ()      |
|     {                    |
|       local dim n elem   |
|                          |
|       let "dim1 = $1 - 1 |
| "                        |
|       elem=$dim1         |
|                          |
|       for n in $(seq 0 $ |
| dim1)                    |
|       do                 |
|        let "Rod1[$elem]  |
| = 2 * $n + 1"            |
|        Rod2[$n]=0        |
|        Rod3[$n]=0        |
|        ((elem--))        |
|       done               |
|     }                    |
|                          |
|                          |
|     ###   Main   ###     |
|                          |
|     trap "tput cnorm" 0  |
|     tput civis           |
|     clear                |
|                          |
|     setup_arrays $DISKS  |
|                          |
|     tput cup 0 0         |
|     echo; echo "+  Start |
|  Position"               |
|                          |
|     case $# in           |
|         1) case $(($1>0) |
| ) in     # Must have at  |
| least one disk.          |
|            1)            |
|                disks=$1  |
|                dohanoi $ |
| 1 1 3 2                  |
|     #          Total mov |
| es = 2^n - 1, where n =  |
| # of disks.              |
|            echo          |
|                exit 0;   |
|                ;;        |
|            *)            |
|                echo "$0: |
|  Illegal value for numbe |
| r of disks";             |
|                exit $E_B |
| ADPARAM;                 |
|                ;;        |
|            esac          |
|         ;;               |
|         *)               |
|            echo "usage:  |
| $0 N"                    |
|            echo "        |
| Where \"N\" is the numbe |
| r of disks."             |
|            exit $E_NOPAR |
| AM;                      |
|            ;;            |
|     esac                 |
|                          |
|     exit $E_NOEXIT   # S |
| houldn't exit here.      |
|                          |
|     #  Exercise:         |
|     #  --------          |
|     #  There is a minor  |
| bug in the script that c |
| auses the display of     |
|     #+ the next-to-last  |
| move to be skipped.      |
|     #+ Fix this.         |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-50. An alternate version of the
`getopt-simple.sh <string-manipulation.html#GETOPTSIMPLE>`__ script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # UseGetOpt.sh       |
|                          |
|     # Author: Peggy Russ |
| ell <prusselltechgroup@g |
| mail.com>                |
|                          |
|     UseGetOpt () {       |
|       declare inputOptio |
| ns                       |
|       declare -r E_OPTER |
| R=85                     |
|       declare -r ScriptN |
| ame=${0##*/}             |
|       declare -r ShortOp |
| ts="adf:hlt"             |
|       declare -r LongOpt |
| s="aoption,debug,file:,h |
| elp,log,test"            |
|                          |
|     DoSomething () {     |
|         echo "The functi |
| on name is '${FUNCNAME}' |
| "                        |
|         #  Recall that $ |
| FUNCNAME is an internal  |
| variable                 |
|         #+ holding the n |
| ame of the function it i |
| s in.                    |
|       }                  |
|                          |
|       inputOptions=$(get |
| opt -o "${ShortOpts}" -- |
| long \                   |
|                   "${Lon |
| gOpts}" --name "${Script |
| Name}" -- "${@}")        |
|                          |
|       if [[ ($? -ne 0) | |
| | ($# -eq 0) ]]; then    |
|         echo "Usage: ${S |
| criptName} [-dhlt] {OPTI |
| ON...}"                  |
|         exit $E_OPTERR   |
|       fi                 |
|                          |
|       eval set -- "${inp |
| utOptions}"              |
|                          |
|       # Only for educati |
| onal purposes. Can be re |
| moved.                   |
|       #----------------- |
| ------------------------ |
| ------                   |
|       echo "++ Test: Num |
| ber of arguments: [$#]"  |
|       echo '++ Test: Loo |
| ping through "$@"'       |
|       for a in "$@"; do  |
|         echo "  ++ [$a]" |
|       done               |
|       #----------------- |
| ------------------------ |
| ------                   |
|                          |
|       while true; do     |
|         case "${1}" in   |
|           --aoption | -a |
| )  # Argument found.     |
|             echo "Option |
|  [$1]"                   |
|             ;;           |
|                          |
|           --debug | -d)  |
|    # Enable informationa |
| l messages.              |
|             echo "Option |
|  [$1] Debugging enabled" |
|             ;;           |
|                          |
|           --file | -f)   |
|    #  Check for optional |
|  argument.               |
|             case "$2" in |
|    #+ Double colon is op |
| tional argument.         |
|               "")        |
|    #  Not there.         |
|                   echo " |
| Option [$1] Use default" |
|                   shift  |
|                   ;;     |
|                          |
|               *) # Got i |
| t                        |
|                  echo "O |
| ption [$1] Using input [ |
| $2]"                     |
|                  shift   |
|                  ;;      |
|                          |
|             esac         |
|             DoSomething  |
|             ;;           |
|                          |
|           --log | -l) #  |
| Enable Logging.          |
|             echo "Option |
|  [$1] Logging enabled"   |
|             ;;           |
|                          |
|           --test | -t) # |
|  Enable testing.         |
|             echo "Option |
|  [$1] Testing enabled"   |
|             ;;           |
|                          |
|           --help | -h)   |
|             echo "Option |
|  [$1] Display help"      |
|             break        |
|             ;;           |
|                          |
|           --)   # Done!  |
| $# is argument number fo |
| r "--", $@ is "--"       |
|             echo "Option |
|  [$1] Dash Dash"         |
|             break        |
|             ;;           |
|                          |
|            *)            |
|             echo "Major  |
| internal error!"         |
|             exit 8       |
|             ;;           |
|                          |
|         esac             |
|         echo "Number of  |
| arguments: [$#]"         |
|         shift            |
|       done               |
|                          |
|       shift              |
|       # Only for educati |
| onal purposes. Can be re |
| moved.                   |
|       #----------------- |
| ------------------------ |
| ------------------------ |
| -----                    |
|       echo "++ Test: Num |
| ber of arguments after \ |
| "--\" is [$#] They are:  |
| [$@]"                    |
|       echo '++ Test: Loo |
| ping through "$@"'       |
|       for a in "$@"; do  |
|         echo "  ++ [$a]" |
|       done               |
|       #----------------- |
| ------------------------ |
| ------------------------ |
| -----                    |
|                          |
|     }                    |
|                          |
|     #################### |
| ############### M A I N  |
| ######################## |
|     #  If you remove "fu |
| nction UseGetOpt () {" a |
| nd corresponding "}",    |
|     #+ you can uncomment |
|  the "exit 0" line below |
| , and invoke this script |
|     #+ with the various  |
| options from the command |
| -line.                   |
|     #------------------- |
| ------------------------ |
| ------------------------ |
|     # exit 0             |
|                          |
|     echo "Test 1"        |
|     UseGetOpt -f myfile  |
| one "two three" four     |
|                          |
|     echo;echo "Test 2"   |
|     UseGetOpt -h         |
|                          |
|     echo;echo "Test 3 -  |
| Short Options"           |
|     UseGetOpt -adltf myf |
| ile  anotherfile         |
|                          |
|     echo;echo "Test 4 -  |
| Long Options"            |
|     UseGetOpt --aoption  |
| --debug --log --test --f |
| ile myfile anotherfile   |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-51. The version of the *UseGetOpt.sh* example used in the
`Tab Expansion appendix <tabexpansion.html>`__**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     #  UseGetOpt-2.sh    |
|     #  Modified version  |
| of the script for illust |
| rating tab-expansion     |
|     #+ of command-line o |
| ptions.                  |
|     #  See the "Introduc |
| tion to Tab Expansion" a |
| ppendix.                 |
|                          |
|     #  Possible options: |
|  -a -d -f -l -t -h       |
|     #+                   |
|  --aoption, --debug --fi |
| le --log --test -- help  |
| --                       |
|                          |
|     #  Author of origina |
| l script: Peggy Russell  |
| <prusselltechgroup@gmail |
| .com>                    |
|                          |
|                          |
|     # UseGetOpt () {     |
|       declare inputOptio |
| ns                       |
|       declare -r E_OPTER |
| R=85                     |
|       declare -r ScriptN |
| ame=${0##*/}             |
|       declare -r ShortOp |
| ts="adf:hlt"             |
|       declare -r LongOpt |
| s="aoption,debug,file:,h |
| elp,log,test"            |
|                          |
|     DoSomething () {     |
|         echo "The functi |
| on name is '${FUNCNAME}' |
| "                        |
|       }                  |
|                          |
|       inputOptions=$(get |
| opt -o "${ShortOpts}" -- |
| long \                   |
|                   "${Lon |
| gOpts}" --name "${Script |
| Name}" -- "${@}")        |
|                          |
|       if [[ ($? -ne 0) | |
| | ($# -eq 0) ]]; then    |
|         echo "Usage: ${S |
| criptName} [-dhlt] {OPTI |
| ON...}"                  |
|         exit $E_OPTERR   |
|       fi                 |
|                          |
|       eval set -- "${inp |
| utOptions}"              |
|                          |
|                          |
|       while true; do     |
|         case "${1}" in   |
|           --aoption | -a |
| )  # Argument found.     |
|             echo "Option |
|  [$1]"                   |
|             ;;           |
|                          |
|           --debug | -d)  |
|    # Enable informationa |
| l messages.              |
|             echo "Option |
|  [$1] Debugging enabled" |
|             ;;           |
|                          |
|           --file | -f)   |
|    #  Check for optional |
|  argument.               |
|             case "$2" in |
|    #+ Double colon is op |
| tional argument.         |
|               "")        |
|    #  Not there.         |
|                   echo " |
| Option [$1] Use default" |
|                   shift  |
|                   ;;     |
|                          |
|               *) # Got i |
| t                        |
|                  echo "O |
| ption [$1] Using input [ |
| $2]"                     |
|                  shift   |
|                  ;;      |
|                          |
|             esac         |
|             DoSomething  |
|             ;;           |
|                          |
|           --log | -l) #  |
| Enable Logging.          |
|             echo "Option |
|  [$1] Logging enabled"   |
|             ;;           |
|                          |
|           --test | -t) # |
|  Enable testing.         |
|             echo "Option |
|  [$1] Testing enabled"   |
|             ;;           |
|                          |
|           --help | -h)   |
|             echo "Option |
|  [$1] Display help"      |
|             break        |
|             ;;           |
|                          |
|           --)   # Done!  |
| $# is argument number fo |
| r "--", $@ is "--"       |
|             echo "Option |
|  [$1] Dash Dash"         |
|             break        |
|             ;;           |
|                          |
|            *)            |
|             echo "Major  |
| internal error!"         |
|             exit 8       |
|             ;;           |
|                          |
|         esac             |
|         echo "Number of  |
| arguments: [$#]"         |
|         shift            |
|       done               |
|                          |
|       shift              |
|                          |
|     #  }                 |
|                          |
|     exit                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-52. Cycling through all the possible color backgrounds**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|                          |
|     # show-all-colors.sh |
|     # Displays all 256 p |
| ossible background color |
| s, using ANSI escape seq |
| uences.                  |
|     # Author: Chetankuma |
| r Phulpagare             |
|     # Used in ABS Guide  |
| with permission.         |
|                          |
|     T1=8                 |
|     T2=6                 |
|     T3=36                |
|     offset=0             |
|                          |
|     for num1 in {0..7}   |
|     do {                 |
|        for num2 in {0,1} |
|            do {          |
|               shownum=`e |
| cho "$offset + $T1 * ${n |
| um2} + $num1" | bc`      |
|               echo -en " |
| \E[0;48;5;${shownum}m co |
| lor ${shownum} \E[0m"    |
|               }          |
|            done          |
|        echo              |
|        }                 |
|     done                 |
|                          |
|     offset=16            |
|     for num1 in {0..5}   |
|     do {                 |
|        for num2 in {0..5 |
| }                        |
|            do {          |
|               for num3 i |
| n {0..5}                 |
|                   do {   |
|                      sho |
| wnum=`echo "$offset + $T |
| 2 * ${num3} \            |
|                      + $ |
| num2 + $T3 * ${num1}" |  |
| bc`                      |
|                      ech |
| o -en "\E[0;48;5;${shown |
| um}m color ${shownum} \E |
| [0m"                     |
|                      }   |
|                    done  |
|               echo       |
|               }          |
|            done          |
|     }                    |
|     done                 |
|                          |
|     offset=232           |
|     for num1 in {0..23}  |
|     do {                 |
|        shownum=`expr $of |
| fset + $num1`            |
|        echo -en "\E[0;48 |
| ;5;${shownum}m ${shownum |
| }\E[0m"                  |
|     }                    |
|     done                 |
|                          |
|     echo                 |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-53. Morse Code Practice**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # sam.sh, v. .01a    |
|     # Still Another Mors |
| e (code training script) |
|     # With profuse apolo |
| gies to Sam (F.B.) Morse |
| .                        |
|     # Author: Mendel Coo |
| per                      |
|     # License: GPL3      |
|     # Reldate: 05/25/11  |
|                          |
|     # Morse code trainin |
| g script.                |
|     # Converts arguments |
|  to audible dots and das |
| hes.                     |
|     # Note: lowercase in |
| put only at this time.   |
|                          |
|                          |
|                          |
|     # Get the wav files  |
| from the source tarball: |
|     # http://bash.deta.i |
| n/abs-guide-latest.tar.b |
| z2                       |
|     DOT='soundfiles/dot. |
| wav'                     |
|     DASH='soundfiles/das |
| h.wav'                   |
|     # Maybe move soundfi |
| les to /usr/local/sounds |
| ?                        |
|                          |
|     LETTERSPACE=300000   |
| # Microseconds.          |
|     WORDSPACE=980000     |
|     # Nice and slow, for |
|  beginners. Maybe 5 wpm? |
|                          |
|     EXIT_MSG="May the Mo |
| rse be with you!"        |
|     E_NOARGS=75          |
| # No command-line args?  |
|                          |
|                          |
|                          |
|     declare -A morse     |
| # Associative array!     |
|     # ================== |
| ===================== #  |
|     morse[a]="dot; dash" |
|     morse[b]="dash; dot; |
|  dot; dot"               |
|     morse[c]="dash; dot; |
|  dash; dot"              |
|     morse[d]="dash; dot; |
|  dot"                    |
|     morse[e]="dot"       |
|     morse[f]="dot; dot;  |
| dash; dot"               |
|     morse[g]="dash; dash |
| ; dot"                   |
|     morse[h]="dot; dot;  |
| dot; dot"                |
|     morse[i]="dot; dot;" |
|     morse[j]="dot; dash; |
|  dash; dash"             |
|     morse[k]="dash; dot; |
|  dash"                   |
|     morse[l]="dot; dash; |
|  dot; dot"               |
|     morse[m]="dash; dash |
| "                        |
|     morse[n]="dash; dot" |
|     morse[o]="dash; dash |
| ; dash"                  |
|     morse[p]="dot; dash; |
|  dash; dot"              |
|     morse[q]="dash; dash |
| ; dot; dash"             |
|     morse[r]="dot; dash; |
|  dot"                    |
|     morse[s]="dot; dot;  |
| dot"                     |
|     morse[t]="dash"      |
|     morse[u]="dot; dot;  |
| dash"                    |
|     morse[v]="dot; dot;  |
| dot; dash"               |
|     morse[w]="dot; dash; |
|  dash"                   |
|     morse[x]="dash; dot; |
|  dot; dash"              |
|     morse[y]="dash; dot; |
|  dash; dash"             |
|     morse[z]="dash; dash |
| ; dot; dot"              |
|     morse[0]="dash; dash |
| ; dash; dash; dash"      |
|     morse[1]="dot; dash; |
|  dash; dash; dash"       |
|     morse[2]="dot; dot;  |
| dash; dash; dash"        |
|     morse[3]="dot; dot;  |
| dot; dash; dash"         |
|     morse[4]="dot; dot;  |
| dot; dot; dash"          |
|     morse[5]="dot; dot;  |
| dot; dot; dot"           |
|     morse[6]="dash; dot; |
|  dot; dot; dot"          |
|     morse[7]="dash; dash |
| ; dot; dot; dot"         |
|     morse[8]="dash; dash |
| ; dash; dot; dot"        |
|     morse[9]="dash; dash |
| ; dash; dash; dot"       |
|     # The following must |
|  be escaped or quoted.   |
|     morse[?]="dot; dot;  |
| dash; dash; dot; dot"    |
|     morse[.]="dot; dash; |
|  dot; dash; dot; dash"   |
|     morse[,]="dash; dash |
| ; dot; dot; dash; dash"  |
|     morse[/]="dash; dot; |
|  dot; dash; dot"         |
|     morse[\@]="dot; dash |
| ; dash; dot; dash; dot"  |
|     # ================== |
| ===================== #  |
|                          |
|     play_letter ()       |
|     {                    |
|       eval ${morse[$1]}  |
|   # Play dots, dashes fr |
| om appropriate sound fil |
| es.                      |
|       # Why is 'eval' ne |
| cessary here?            |
|       usleep $LETTERSPAC |
| E # Pause in between let |
| ters.                    |
|     }                    |
|                          |
|     extract_letters ()   |
|     {                    |
|   # Slice string apart,  |
| letter by letter.        |
|       local pos=0        |
|   # Starting at left end |
|  of string.              |
|       local len=1        |
|   # One letter at a time |
| .                        |
|       strlen=${#1}       |
|                          |
|       while [ $pos -lt $ |
| strlen ]                 |
|       do                 |
|         letter=${1:pos:l |
| en}                      |
|         #      ^^^^^^^^^ |
| ^^^    See Chapter 10.1. |
|         play_letter $let |
| ter                      |
|         echo -n "*"      |
|   #    Mark letter just  |
| played.                  |
|         ((pos++))        |
|       done               |
|     }                    |
|                          |
|     ######### Play the s |
| ounds ############       |
|     dot()  { aplay "$DOT |
| " 2&>/dev/null;  }       |
|     dash() { aplay "$DAS |
| H" 2&>/dev/null; }       |
|     #################### |
| ##################       |
|                          |
|     no_args ()           |
|     {                    |
|         declare -a usage |
|         usage=( $0 word1 |
|  word2 ... )             |
|                          |
|         echo "Usage:"; e |
| cho                      |
|         echo ${usage[*]} |
|         for index in 0 1 |
|  2 3                     |
|         do               |
|           extract_letter |
| s ${usage[index]}        |
|           usleep $WORDSP |
| ACE                      |
|           echo -n " "    |
|   # Print space between  |
| words.                   |
|         done             |
|     #   echo "Usage: $0  |
| word1 word2 ... "        |
|         echo; echo       |
|     }                    |
|                          |
|                          |
|     # int main()         |
|     # {                  |
|                          |
|     clear                |
|   # Clear the terminal s |
| creen.                   |
|     echo "            SA |
| M"                       |
|     echo "Still Another  |
| Morse code trainer"      |
|     echo "    Author: Me |
| ndel Cooper"             |
|     echo; echo;          |
|                          |
|     if [ -z "$1" ]       |
|     then                 |
|       no_args            |
|       echo; echo; echo " |
| $EXIT_MSG"; echo         |
|       exit $E_NOARGS     |
|     fi                   |
|                          |
|     echo; echo "$*"      |
|   # Print text that will |
|  be played.              |
|                          |
|     until [ -z "$1" ]    |
|     do                   |
|       extract_letters $1 |
|       shift           #  |
| On to next word.         |
|       usleep $WORDSPACE  |
|       echo -n " "     #  |
| Print space between word |
| s.                       |
|     done                 |
|                          |
|     echo; echo; echo "$E |
| XIT_MSG"; echo           |
|                          |
|     exit 0               |
|     # }                  |
|                          |
|     #  Exercises:        |
|     #  ---------         |
|     #  1) Have the scrip |
| t accept either lowercas |
| e or uppercase words     |
|     #+    as arguments.  |
| Hint: Use 'tr' . . .     |
|     #  2) Have the scrip |
| t optionally accept inpu |
| t from a text file.      |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-54. Base64 encoding/decoding**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # base64.sh: Bash im |
| plementation of Base64 e |
| ncoding and decoding.    |
|     #                    |
|     # Copyright (c) 2011 |
|  vladz <vladz@devzero.fr |
| >                        |
|     # Used in ABSG with  |
| permission (thanks!).    |
|     #                    |
|     #  Encode or decode  |
| original Base64 (and als |
| o Base64url)             |
|     #+ from STDIN to STD |
| OUT.                     |
|     #                    |
|     #    Usage:          |
|     #                    |
|     #    Encode          |
|     #    $ ./base64.sh < |
|  binary-file > binary-fi |
| le.base64                |
|     #    Decode          |
|     #    $ ./base64.sh - |
| d < binary-file.base64 > |
|  binary-file             |
|     #                    |
|     # Reference:         |
|     #                    |
|     #    [1]  RFC4648 -  |
| "The Base16, Base32, and |
|  Base64 Data Encodings"  |
|     #         http://too |
| ls.ietf.org/html/rfc4648 |
| #section-5               |
|                          |
|                          |
|     # The base64_charset |
| [] array contains entire |
|  base64 charset,         |
|     # and additionally t |
| he character "=" ...     |
|     base64_charset=( {A. |
| .Z} {a..z} {0..9} + / =  |
| )                        |
|                     # Ni |
| ce illustration of brace |
|  expansion.              |
|                          |
|     #  Uncomment the ### |
|  line below to use base6 |
| 4url encoding instead of |
|     #+ original base64.  |
|     ### base64_charset=( |
|  {A..Z} {a..z} {0..9} -  |
| _ = )                    |
|                          |
|     #  Output text width |
|  when encoding           |
|     #+ (64 characters, j |
| ust like openssl output) |
| .                        |
|     text_width=64        |
|                          |
|     function display_bas |
| e64_char {               |
|     #  Convert a 6-bit n |
| umber (between 0 and 63) |
|  into its corresponding  |
| values                   |
|     #+ in Base64, then d |
| isplay the result with t |
| he specified text width. |
|       printf "${base64_c |
| harset[$1]}"; (( width++ |
|  ))                      |
|       (( width % text_wi |
| dth == 0 )) && printf "\ |
| n"                       |
|     }                    |
|                          |
|     function encode_base |
| 64 {                     |
|     # Encode three 8-bit |
|  hexadecimal codes into  |
| four 6-bit numbers.      |
|       #    We need two l |
| ocal int array variables |
| :                        |
|       #    c8[]: to stor |
| e the codes of the 8-bit |
|  characters to encode    |
|       #    c6[]: to stor |
| e the corresponding enco |
| ded values on 6-bit      |
|       declare -a -i c8 c |
| 6                        |
|                          |
|       #  Convert hexadec |
| imal to decimal.         |
|       c8=( $(printf "iba |
| se=16; ${1:0:2}\n${1:2:2 |
| }\n${1:4:2}\n" | bc) )   |
|                          |
|       #  Let's play with |
|  bitwise operators       |
|       #+ (3x8-bit into 4 |
| x6-bits conversion).     |
|       (( c6[0] = c8[0] > |
| > 2 ))                   |
|       (( c6[1] = ((c8[0] |
|  &  3) << 4) | (c8[1] >> |
|  4) ))                   |
|                          |
|       # The following op |
| erations depend on the c |
| 8 element number.        |
|       case ${#c8[*]} in  |
|         3) (( c6[2] = (( |
| c8[1] & 15) << 2) | (c8[ |
| 2] >> 6) ))              |
|            (( c6[3] = c8 |
| [2] & 63 )) ;;           |
|         2) (( c6[2] = (c |
| 8[1] & 15) << 2 ))       |
|            (( c6[3] = 64 |
|  )) ;;                   |
|         1) (( c6[2] = c6 |
| [3] = 64 )) ;;           |
|       esac               |
|                          |
|       for char in ${c6[@ |
| ]}; do                   |
|         display_base64_c |
| har ${char}              |
|       done               |
|     }                    |
|                          |
|     function decode_base |
| 64 {                     |
|     # Decode four base64 |
|  characters into three h |
| exadecimal ASCII charact |
| ers.                     |
|       #  c8[]: to store  |
| the codes of the 8-bit c |
| haracters                |
|       #  c6[]: to store  |
| the corresponding Base64 |
|  values on 6-bit         |
|       declare -a -i c8 c |
| 6                        |
|                          |
|       # Find decimal val |
| ue corresponding to the  |
| current base64 character |
| .                        |
|       for current_char i |
| n ${1:0:1} ${1:1:1} ${1: |
| 2:1} ${1:3:1}; do        |
|          [ "${current_ch |
| ar}" = "=" ] && break    |
|                          |
|          position=0      |
|          while [ "${curr |
| ent_char}" != "${base64_ |
| charset[${position}]}" ] |
| ; do                     |
|             (( position+ |
| + ))                     |
|          done            |
|                          |
|          c6=( ${c6[*]} $ |
| {position} )             |
|       done               |
|                          |
|       #  Let's play with |
|  bitwise operators       |
|       #+ (4x8-bit into 3 |
| x6-bits conversion).     |
|       (( c8[0] = (c6[0]  |
| << 2) | (c6[1] >> 4) ))  |
|                          |
|       # The next operati |
| ons depends on the c6 el |
| ements number.           |
|       case ${#c6[*]} in  |
|         3) (( c8[1] = (  |
| (c6[1] & 15) << 4) | (c6 |
| [2] >> 2) ))             |
|            (( c8[2] = (c |
| 6[2] & 3) << 6 )); unset |
|  c8[2] ;;                |
|         4) (( c8[1] = (  |
| (c6[1] & 15) << 4) | (c6 |
| [2] >> 2) ))             |
|            (( c8[2] = (  |
| (c6[2] &  3) << 6) |  c6 |
| [3] )) ;;                |
|       esac               |
|                          |
|       for char in ${c8[* |
| ]}; do                   |
|          printf "\x$(pri |
| ntf "%x" ${char})"       |
|       done               |
|     }                    |
|                          |
|                          |
|     # main ()            |
|                          |
|     if [ "$1" = "-d" ];  |
| then   # decode          |
|                          |
|       # Reformat STDIN i |
| n pseudo 4x6-bit groups. |
|       content=$(cat - |  |
| tr -d "\n" | sed -r "s/( |
| .{4})/\1 /g")            |
|                          |
|       for chars in ${con |
| tent}; do decode_base64  |
| ${chars}; done           |
|                          |
|     else                 |
|       # Make a hexdump o |
| f stdin and reformat in  |
| 3-byte groups.           |
|       content=$(cat - |  |
| xxd -ps -u | sed -r "s/( |
| \w{6})/\1 /g" |          |
|                 tr -d "\ |
| n")                      |
|                          |
|       for chars in ${con |
| tent}; do encode_base64  |
| ${chars}; done           |
|                          |
|       echo               |
|                          |
|     fi                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-55. Inserting text in a file using *sed***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     #  Prepends a string |
|  at a specified line     |
|     #+ in files with nam |
| es ending in "sample"    |
|     #+ in the current wo |
| rking directory.         |
|     #  00000000000000000 |
| 0000000000000000000      |
|     #  This script overw |
| rites files!             |
|     #  Be careful runnin |
| g it in a directory      |
|     #+ where you have im |
| portant files!!!         |
|     #  00000000000000000 |
| 0000000000000000000      |
|                          |
|     #  Create a couple o |
| f files to operate on .. |
| .                        |
|     #  01sample          |
|     #  02sample          |
|     #  ... etc.          |
|     #  These files must  |
| not be empty, else the p |
| repend will not work.    |
|                          |
|     lineno=1             |
| # Append at line 1 (prep |
| end).                    |
|     filespec="*sample"   |
| # Filename pattern to op |
| erate on.                |
|                          |
|     string=$(whoami)     |
| # Will set your username |
|  as string to insert.    |
|                          |
| # It could just as easil |
| y be any other string.   |
|                          |
|     for file in $filespe |
| c # Specify which files  |
| to alter.                |
|     do #        ^^^^^^^^ |
| ^                        |
|      sed -i ""$lineno"i  |
| "$string"" $file         |
|     #    ^^ -i option ed |
| its files in-place.      |
|     #                 ^  |
| Insert (i) command.      |
|      echo ""$file" alter |
| ed!"                     |
|     done                 |
|                          |
|     echo "Warning: files |
|  possibly clobbered!"    |
|                          |
|     exit 0               |
|                          |
|     # Exercise:          |
|     # Add error checking |
|  to this script.         |
|     # It needs it badly. |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-56. The Gronsfeld Cipher**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # gronsfeld.bash     |
|                          |
|     # License: GPL3      |
|     # Reldate 06/23/11   |
|                          |
|     #  This is an implem |
| entation of the Gronsfel |
| d Cipher.                |
|     #  It's essentially  |
| a stripped-down variant  |
| of the                   |
|     #+ polyalphabetic Vi |
| genère Tableau, but with |
|  only 10 alphabets.      |
|     #  The classic Grons |
| feld has a numeric seque |
| nce as the key word,     |
|     #+ but here we subst |
| itute a letter string, f |
| or ease of use.          |
|     #  Allegedly, this c |
| ipher was invented by th |
| e eponymous Count Gronsf |
| eld                      |
|     #+ in the 17th Centu |
| ry. It was at one time c |
| onsidered to be unbreaka |
| ble.                     |
|     #  Note that this is |
|  ###not### a secure ciph |
| er by modern standards.  |
|                          |
|     #  Global Variables  |
|  #                       |
|     Enc_suffix="29379"   |
|  #  Encrypted text outpu |
| t with this 5-digit suff |
| ix.                      |
|                          |
|  #  This functions as a  |
| decryption flag,         |
|                          |
|  #+ and when used to gen |
| erate passwords adds sec |
| urity.                   |
|     Default_key="gronsfe |
| ldk"                     |
|                          |
|  #  The script uses this |
|  if key not entered belo |
| w                        |
|                          |
|  #  (at "Keychain").     |
|                          |
|  #  Change the above two |
|  values frequently       |
|                          |
|  #+ for added security.  |
|                          |
|     GROUPLEN=5           |
|  #  Output in groups of  |
| 5 letters, per tradition |
| .                        |
|     alpha1=( abcdefghijk |
| lmnopqrstuvwxyz )        |
|     alpha2=( {A..Z} )    |
|  #  Output in all caps,  |
| per tradition.           |
|                          |
|  #  Use   alpha2=( {a..z |
| } )   for password gener |
| ator.                    |
|     wraplen=26           |
|  #  Wrap around if past  |
| end of alphabet.         |
|     dflag=               |
|  #  Decrypt flag (set if |
|  $Enc_suffix present).   |
|     E_NOARGS=76          |
|  #  Missing command-line |
|  args?                   |
|     DEBUG=77             |
|  #  Debugging flag.      |
|     declare -a offsets   |
|  #  This array holds the |
|  numeric shift values fo |
| r                        |
|                          |
|  #+ encryption/decryptio |
| n.                       |
|                          |
|     ########Keychain#### |
| #####                    |
|     key=  ### Put key he |
| re!!!                    |
|           # 10 character |
| s!                       |
|     #################### |
| #####                    |
|                          |
|                          |
|                          |
|     # Function           |
|     : ()                 |
|     { # Encrypt or decry |
| pt, depending on whether |
|  $dflag is set.          |
|       # Why ": ()" as a  |
| function name? Just to p |
| rove that it can be done |
| .                        |
|                          |
|       local idx keydx ml |
| en off1 shft             |
|       local plaintext="$ |
| 1"                       |
|       local mlen=${#plai |
| ntext}                   |
|                          |
|     for (( idx=0; idx<$m |
| len; idx++ ))            |
|     do                   |
|       let "keydx = $idx  |
| % $keylen"               |
|       shft=${offsets[key |
| dx]}                     |
|                          |
|       if [ -n "$dflag" ] |
|       then               |
|     # Decrypt!           |
|         let "off1 = $(ex |
| pr index "${alpha1[*]}"  |
| ${plaintext:idx:1}) - $s |
| hft"                     |
|         # Shift backward |
|  to decrypt.             |
|       else               |
|     # Encrypt!           |
|         let "off1 = $(ex |
| pr index "${alpha1[*]}"  |
| ${plaintext:idx:1}) + $s |
| hft"                     |
|         # Shift forward  |
| to encrypt.              |
|         test $(( $idx %  |
| $GROUPLEN)) = 0 && echo  |
| -n " "  # Groups of 5 le |
| tters.                   |
|         #  Comment out a |
| bove line for output as  |
| a string without whitesp |
| ace,                     |
|         #+ for example,  |
| if using the script as a |
|  password generator.     |
|       fi                 |
|                          |
|       ((off1--))   # Nor |
| malize. Why is this nece |
| ssary?                   |
|                          |
|           if [ $off1 -lt |
|  0 ]                     |
|           then     # Cat |
| ch negative indices.     |
|             let "off1 += |
|  $wraplen"               |
|           fi             |
|                          |
|       ((off1 %= $wraplen |
| ))   # Wrap around if pa |
| st end of alphabet.      |
|                          |
|       echo -n "${alpha2[ |
| off1]}"                  |
|                          |
|     done                 |
|                          |
|       if [ -z "$dflag" ] |
|       then               |
|         echo " $Enc_suff |
| ix"                      |
|     #   echo "$Enc_suffi |
| x"  # For password gener |
| ator.                    |
|       else               |
|         echo             |
|       fi                 |
|     } # End encrypt/decr |
| ypt function.            |
|                          |
|                          |
|                          |
|     # int main () {      |
|                          |
|     # Check for command- |
| line args.               |
|     if [ -z "$1" ]       |
|     then                 |
|        echo "Usage: $0 T |
| EXT TO ENCODE/DECODE"    |
|        exit $E_NOARGS    |
|     fi                   |
|                          |
|     if [ ${!#} == "$Enc_ |
| suffix" ]                |
|     #    ^^^^^ Final com |
| mand-line arg.           |
|     then                 |
|       dflag=ON           |
|       echo -n "+"        |
|     # Flag decrypted tex |
| t with a "+" for easy ID |
| .                        |
|     fi                   |
|                          |
|     if [ -z "$key" ]     |
|     then                 |
|       key="$Default_key" |
|     # "gronsfeldk" per a |
| bove.                    |
|     fi                   |
|                          |
|     keylen=${#key}       |
|                          |
|     for (( idx=0; idx<$k |
| eylen; idx++ ))          |
|     do  # Calculate shif |
| t values for encryption/ |
| decryption.              |
|       offsets[idx]=$(exp |
| r index "${alpha1[*]}" $ |
| {key:idx:1})   # Normali |
| ze.                      |
|       ((offsets[idx]--)) |
|   #  Necessary because " |
| expr index" starts at 1, |
|                          |
|   #+ whereas array count |
|  starts at 0.            |
|       # Generate array o |
| f numerical offsets corr |
| esponding to the key.    |
|       # There are simple |
| r ways to accomplish thi |
| s.                       |
|     done                 |
|                          |
|     args=$(echo "$*" | s |
| ed -e 's/ //g' | tr A-Z  |
| a-z | sed -e 's/[0-9]//g |
| ')                       |
|     # Remove whitespace  |
| and digits from command- |
| line args.               |
|     # Can modify to also |
|  remove punctuation char |
| acters, if desired.      |
|                          |
|              # Debug:    |
|              # echo "$ar |
| gs"; exit $DEBUG         |
|                          |
|     : "$args"            |
|     # Call the function  |
| named ":".               |
|     # : is a null operat |
| or, except . . . when it |
| 's a function name!      |
|                          |
|     exit $?    # } End-o |
| f-script                 |
|                          |
|                          |
|     #   **************** |
| ************************ |
| **********************   |
|  #                       |
|     #   This script can  |
| function as a  password  |
| generator,               |
|     #+  with several min |
| or mods, see above.      |
|     #   That would allow |
|  an easy-to-remember pas |
| sword, even the word     |
|     #+ "password" itself |
| , which encrypts to vrgf |
| otvo29379                |
|     #+  a fairly secure  |
| password not susceptible |
|  to a dictionary attack. |
|     #   Or, you could us |
| e your own name (surely  |
| that's easy to remember! |
| ).                       |
|     #   For example, Boz |
| o Bozeman encrypts to hf |
| nbttdppkt29379.          |
|     #   **************** |
| ************************ |
| **********************   |
|  #                       |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-57. Bingo Number Generator**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # bingo.sh           |
|     # Bingo number gener |
| ator                     |
|     # Reldate 20Aug12, L |
| icense: Public Domain    |
|                          |
|     #################### |
| ######################## |
| ######################## |
| ###                      |
|     # This script genera |
| tes bingo numbers.       |
|     # Hitting a key gene |
| rates a new number.      |
|     # Hitting 'q' termin |
| ates the script.         |
|     # In a given run of  |
| the script, there will b |
| e no duplicate numbers.  |
|     # When the script te |
| rminates, it prints a lo |
| g of the numbers generat |
| ed.                      |
|     #################### |
| ######################## |
| ######################## |
| ###                      |
|                          |
|     MIN=1       # Lowest |
|  allowable bingo number. |
|     MAX=75      # Highes |
| t allowable bingo number |
| .                        |
|     COLS=15     # Number |
| s in each column (B I N  |
| G O).                    |
|     SINGLE_DIGIT_MAX=9   |
|                          |
|     declare -a Numbers   |
|     Prefix=(B I N G O)   |
|                          |
|     initialize_Numbers ( |
| )                        |
|     {  # Zero them out t |
| o start.                 |
|        # They'll be incr |
| emented if chosen.       |
|        local index=0     |
|        until [ "$index"  |
| -gt $MAX ]               |
|        do                |
|          Numbers[index]= |
| 0                        |
|          ((index++))     |
|        done              |
|                          |
|        Numbers[0]=1   #  |
| Flag zero, so it won't b |
| e selected.              |
|     }                    |
|                          |
|                          |
|     generate_number ()   |
|     {                    |
|        local number      |
|                          |
|        while [ 1 ]       |
|        do                |
|          let "number = $ |
| (expr $RANDOM % $MAX)"   |
|          if [ ${Numbers[ |
| number]} -eq 0 ]    # Nu |
| mber not yet called.     |
|          then            |
|            let "Numbers[ |
| number]+=1"         # Fl |
| ag it in the array.      |
|            break         |
|                     # An |
| d terminate loop.        |
|          fi   # Else if  |
| already called, loop and |
|  generate another number |
| .                        |
|        done              |
|        # Exercise: Rewri |
| te this more elegantly a |
| s an until-loop.         |
|                          |
|        return $number    |
|     }                    |
|                          |
|                          |
|     print_numbers_called |
|  ()                      |
|     {   # Print out the  |
| called number log in nea |
| t columns.               |
|         # echo ${Numbers |
| [@]}                     |
|                          |
|     local pre2=0         |
|         #  Prefix a zero |
| , so columns will align  |
|                          |
|         #+ on single-dig |
| it numbers.              |
|                          |
|     echo "Number Stats"  |
|                          |
|     for (( index=1; inde |
| x<=MAX; index++))        |
|     do                   |
|       count=${Numbers[in |
| dex]}                    |
|       let "t = $index -  |
| 1"      # Normalize, sin |
| ce array begins with ind |
| ex 0.                    |
|       let "column = $(ex |
| pr $t / $COLS)"          |
|       pre=${Prefix[colum |
| n]}                      |
|     # echo -n "${Prefix[ |
| column]} "               |
|                          |
|     if [ $(expr $t % $CO |
| LS) -eq 0 ]              |
|     then                 |
|       echo   # Newline a |
| t end of row.            |
|     fi                   |
|                          |
|       if [ "$index" -gt  |
| $SINGLE_DIGIT_MAX ]  # C |
| heck for single-digit nu |
| mber.                    |
|       then               |
|         echo -n "$pre$in |
| dex#$count "             |
|       else    # Prefix a |
|  zero.                   |
|         echo -n "$pre$pr |
| e2$index#$count "        |
|       fi                 |
|                          |
|     done                 |
|     }                    |
|                          |
|                          |
|                          |
|     # main () {          |
|     RANDOM=$$   # Seed r |
| andom number generator.  |
|                          |
|     initialize_Numbers   |
|  # Zero out the number t |
| racking array.           |
|                          |
|     clear                |
|     echo "Bingo Number C |
| aller"; echo             |
|                          |
|     while [[ "$key" != " |
| q" ]]   # Main loop.     |
|     do                   |
|       read -s -n1 -p "Hi |
| t a key for the next num |
| ber [q to exit] " key    |
|       # Usually 'q' exit |
| s, but not always.       |
|       # Can always hit C |
| tl-C if q fails.         |
|       echo               |
|                          |
|       generate_number; n |
| ew_number=$?             |
|                          |
|       let "column = $(ex |
| pr $new_number / $COLS)" |
|       echo -n "${Prefix[ |
| column]} "   # B-I-N-G-O |
|                          |
|       echo $new_number   |
|     done                 |
|                          |
|     echo; echo           |
|                          |
|     # Game over ...      |
|     print_numbers_called |
|     echo; echo "[#0 = no |
| t called . . . #1 = call |
| ed]"                     |
|                          |
|     echo                 |
|                          |
|     exit 0               |
|     # }                  |
|                          |
|                          |
|     # Certainly, this sc |
| ript could stand some im |
| provement.               |
|     #See also the author |
| 's Instructable:         |
|     #www.instructables.c |
| om/id/Binguino-An-Arduin |
| o-based-Bingo-Number-Gen |
| erato/                   |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

 To end this section, a review of the basics . . . and more.

.. raw:: html

   <div class="EXAMPLE">

**Example A-58. Basics Reviewed**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # basics-reviewed.ba |
| sh                       |
|                          |
|     # File extension ==  |
| *.bash == specific to Ba |
| sh                       |
|                          |
|     #   Copyright (c) Mi |
| chael S. Zick, 2003; All |
|  rights reserved.        |
|     #   License: Use in  |
| any form, for any purpos |
| e.                       |
|     #   Revision: $ID$   |
|     #                    |
|     #              Edite |
| d for layout by M.C.     |
|     #   (author of the " |
| Advanced Bash Scripting  |
| Guide")                  |
|     #   Fixes and update |
| s (04/08) by Cliff Bamfo |
| rd.                      |
|                          |
|                          |
|     #  This script teste |
| d under Bash versions 2. |
| 04, 2.05a and 2.05b.     |
|     #  It may not work w |
| ith earlier versions.    |
|     #  This demonstratio |
| n script generates one - |
| -intentional--           |
|     #+ "command not foun |
| d" error message. See li |
| ne 436.                  |
|                          |
|     #  The current Bash  |
| maintainer, Chet Ramey,  |
| has fixed the items note |
| d                        |
|     #+ for later version |
| s of Bash.               |
|                          |
|                          |
|                          |
|             ###--------- |
| ------------------------ |
| ----------###            |
|             ###  Pipe th |
| e output of this script  |
| to 'more' ###            |
|             ###+ else it |
|  will scroll off the pag |
| e.        ###            |
|             ###          |
|                          |
|           ###            |
|             ###  You may |
|  also redirect its outpu |
| t         ###            |
|             ###+ to a fi |
| le for examination.      |
|           ###            |
|             ###--------- |
| ------------------------ |
| ----------###            |
|                          |
|                          |
|                          |
|     #  Most of the follo |
| wing points are describe |
| d at length in           |
|     #+ the text of the f |
| oregoing "Advanced Bash  |
| Scripting Guide."        |
|     #  This demonstratio |
| n script is mostly just  |
| a reorganized presentati |
| on.                      |
|     #      -- msz        |
|                          |
|     # Variables are not  |
| typed unless otherwise s |
| pecified.                |
|                          |
|     #  Variables are nam |
| ed. Names must contain a |
|  non-digit.              |
|     #  File descriptor n |
| ames (as in, for example |
| : 2>&1)                  |
|     #+ contain ONLY digi |
| ts.                      |
|                          |
|     # Parameters and Bas |
| h array elements are num |
| bered.                   |
|     # (Parameters are ve |
| ry similar to Bash array |
| s.)                      |
|                          |
|     # A variable name ma |
| y be undefined (null ref |
| erence).                 |
|     unset VarNull        |
|                          |
|     # A variable name ma |
| y be defined but empty ( |
| null contents).          |
|     VarEmpty=''          |
|                 # Two, a |
| djacent, single quotes.  |
|                          |
|     # A variable name ma |
| y be defined and non-emp |
| ty.                      |
|     VarSomething='Litera |
| l'                       |
|                          |
|     # A variable may con |
| tain:                    |
|     #   * A whole number |
|  as a signed 32-bit (or  |
| larger) integer          |
|     #   * A string       |
|     # A variable may als |
| o be an array.           |
|                          |
|     #  A string may cont |
| ain embedded blanks and  |
| may be treated           |
|     #+ as if it where a  |
| function name with optio |
| nal arguments.           |
|                          |
|     #  The names of vari |
| ables and the names of f |
| unctions                 |
|     #+ are in different  |
| namespaces.              |
|                          |
|                          |
|     #  A variable may be |
|  defined as a Bash array |
|  either explicitly or    |
|     #+ implicitly by the |
|  syntax of the assignmen |
| t statement.             |
|     #  Explicit:         |
|     declare -a ArrayVar  |
|                          |
|                          |
|                          |
|     # The echo command i |
| s a builtin.             |
|     echo $VarSomething   |
|                          |
|     # The printf command |
|  is a builtin.           |
|     # Translate %s as: S |
| tring-Format             |
|     printf %s $VarSometh |
| ing         # No linebre |
| ak specified, none outpu |
| t.                       |
|     echo                 |
|             # Default, o |
| nly linebreak output.    |
|                          |
|                          |
|                          |
|                          |
|     # The Bash parser wo |
| rd breaks on whitespace. |
|     # Whitespace, or the |
|  lack of it is significa |
| nt.                      |
|     # (This holds true i |
| n general; there are, of |
|  course, exceptions.)    |
|                          |
|                          |
|                          |
|                          |
|     # Translate the DOLL |
| AR_SIGN character as: Co |
| ntent-Of.                |
|                          |
|     # Extended-Syntax wa |
| y of writing Content-Of: |
|     echo ${VarSomething} |
|                          |
|     #  The ${ ... } Exte |
| nded-Syntax allows more  |
| than just the variable   |
|     #+ name to be specif |
| ied.                     |
|     #  In general, $VarS |
| omething can always be w |
| ritten as: ${VarSomethin |
| g}.                      |
|                          |
|     # Call this script w |
| ith arguments to see the |
|  following in action.    |
|                          |
|                          |
|                          |
|     #  Outside of double |
| -quotes, the special cha |
| racters @ and *          |
|     #+ specify identical |
|  behavior.               |
|     #  May be pronounced |
|  as: All-Elements-Of.    |
|                          |
|     #  Without specifica |
| tion of a name, they ref |
| er to the                |
|     #+ pre-defined param |
| eter Bash-Array.         |
|                          |
|                          |
|                          |
|     # Glob-Pattern refer |
| ences                    |
|     echo $*              |
|             # All parame |
| ters to script or functi |
| on                       |
|     echo ${*}            |
|             # Same       |
|                          |
|     # Bash disables file |
| name expansion for Glob- |
| Patterns.                |
|     # Only character mat |
| ching is active.         |
|                          |
|                          |
|     # All-Elements-Of re |
| ferences                 |
|     echo $@              |
|             # Same as ab |
| ove                      |
|     echo ${@}            |
|             # Same as ab |
| ove                      |
|                          |
|                          |
|                          |
|                          |
|     #  Within double-quo |
| tes, the behavior of Glo |
| b-Pattern references     |
|     #+ depends on the se |
| tting of IFS (Input Fiel |
| d Separator).            |
|     #  Within double-quo |
| tes, All-Elements-Of ref |
| erences behave the same. |
|                          |
|                          |
|     #  Specifying only t |
| he name of a variable ho |
| lding a string refers    |
|     #+ to all elements ( |
| characters) of a string. |
|                          |
|                          |
|     #  To specify an ele |
| ment (character) of a st |
| ring,                    |
|     #+ the Extended-Synt |
| ax reference notation (s |
| ee below) MAY be used.   |
|                          |
|                          |
|                          |
|                          |
|     #  Specifying only t |
| he name of a Bash array  |
| references               |
|     #+ the subscript zer |
| o element,               |
|     #+ NOT the FIRST DEF |
| INED nor the FIRST WITH  |
| CONTENTS element.        |
|                          |
|     #  Additional qualif |
| ication is needed to ref |
| erence other elements,   |
|     #+ which means that  |
| the reference MUST be wr |
| itten in Extended-Syntax |
| .                        |
|     #  The general form  |
| is: ${name[subscript]}.  |
|                          |
|     #  The string forms  |
| may also be used: ${name |
| :subscript}              |
|     #+ for Bash-Arrays w |
| hen referencing the subs |
| cript zero element.      |
|                          |
|                          |
|     # Bash-Arrays are im |
| plemented internally as  |
| linked lists,            |
|     #+ not as a fixed ar |
| ea of storage as in some |
|  programming languages.  |
|                          |
|                          |
|     #   Characteristics  |
| of Bash arrays (Bash-Arr |
| ays):                    |
|     #   ---------------- |
| ------------------------ |
| ----                     |
|                          |
|     #   If not otherwise |
|  specified, Bash-Array s |
| ubscripts begin with     |
|     #+  subscript number |
|  zero. Literally: [0]    |
|     #   This is called z |
| ero-based indexing.      |
|     ###                  |
|     #   If not otherwise |
|  specified, Bash-Arrays  |
| are subscript packed     |
|     #+  (sequential subs |
| cripts without subscript |
|  gaps).                  |
|     ###                  |
|     #   Negative subscri |
| pts are not allowed.     |
|     ###                  |
|     #   Elements of a Ba |
| sh-Array need not all be |
|  of the same type.       |
|     ###                  |
|     #   Elements of a Ba |
| sh-Array may be undefine |
| d (null reference).      |
|     #       That is, a B |
| ash-Array may be "subscr |
| ipt sparse."             |
|     ###                  |
|     #   Elements of a Ba |
| sh-Array may be defined  |
| and empty (null contents |
| ).                       |
|     ###                  |
|     #   Elements of a Ba |
| sh-Array may contain:    |
|     #     * A whole numb |
| er as a signed 32-bit (o |
| r larger) integer        |
|     #     * A string     |
|     #     * A string for |
| mated so that it appears |
|  to be a function name   |
|     #     + with optiona |
| l arguments              |
|     ###                  |
|     #   Defined elements |
|  of a Bash-Array may be  |
| undefined (unset).       |
|     #       That is, a s |
| ubscript packed Bash-Arr |
| ay may be changed        |
|     #   +   into a subsc |
| ript sparse Bash-Array.  |
|     ###                  |
|     #   Elements may be  |
| added to a Bash-Array by |
|  defining an element     |
|     #+  not previously d |
| efined.                  |
|     ###                  |
|     # For these reasons, |
|  I have been calling the |
| m "Bash-Arrays".         |
|     # I'll return to the |
|  generic term "array" fr |
| om now on.               |
|     #     -- msz         |
|                          |
|                          |
|     echo "============== |
| ======================== |
| ==================="     |
|                          |
|     #  Lines 202 - 334 s |
| upplied by Cliff Bamford |
| . (Thanks!)              |
|     #  Demo --- Interact |
| ion with Arrays, quoting |
| , IFS, echo, * and @   - |
| --                       |
|     #+ all affect how th |
| ings work                |
|                          |
|     ArrayVar[0]='zero'   |
|                   # 0 no |
| rmal                     |
|     ArrayVar[1]=one      |
|                   # 1 un |
| quoted literal           |
|     ArrayVar[2]='two'    |
|                   # 2 no |
| rmal                     |
|     ArrayVar[3]='three'  |
|                   # 3 no |
| rmal                     |
|     ArrayVar[4]='I am fo |
| ur'               # 4 no |
| rmal with spaces         |
|     ArrayVar[5]='five'   |
|                   # 5 no |
| rmal                     |
|     unset ArrayVar[6]    |
|                   # 6 un |
| defined                  |
|     ArrayValue[7]='seven |
| '                 # 7 no |
| rmal                     |
|     ArrayValue[8]=''     |
|                   # 8 de |
| fined but empty          |
|     ArrayValue[9]='nine' |
|                   # 9 no |
| rmal                     |
|                          |
|                          |
|     echo '--- Here is th |
| e array we are using for |
|  this test'              |
|     echo                 |
|     echo "ArrayVar[0]='z |
| ero'             # 0 nor |
| mal"                     |
|     echo "ArrayVar[1]=on |
| e                # 1 unq |
| uoted literal"           |
|     echo "ArrayVar[2]='t |
| wo'              # 2 nor |
| mal"                     |
|     echo "ArrayVar[3]='t |
| hree'            # 3 nor |
| mal"                     |
|     echo "ArrayVar[4]='I |
|  am four'        # 4 nor |
| mal with spaces"         |
|     echo "ArrayVar[5]='f |
| ive'             # 5 nor |
| mal"                     |
|     echo "unset ArrayVar |
| [6]              # 6 und |
| efined"                  |
|     echo "ArrayValue[7]= |
| 'seven'          # 7 nor |
| mal"                     |
|     echo "ArrayValue[8]= |
| ''               # 8 def |
| ined but empty"          |
|     echo "ArrayValue[9]= |
| 'nine'           # 9 nor |
| mal"                     |
|     echo                 |
|                          |
|                          |
|     echo                 |
|     echo '---Case0: No d |
| ouble-quotes, Default IF |
| S of space,tab,newline - |
| --'                      |
|     IFS=$'\x20'$'\x09'$' |
| \x0A'            # In ex |
| actly this order.        |
|     echo 'Here is: print |
| f %q {${ArrayVar[*]}'    |
|     printf %q ${ArrayVar |
| [*]}                     |
|     echo                 |
|     echo 'Here is: print |
| f %q {${ArrayVar[@]}'    |
|     printf %q ${ArrayVar |
| [@]}                     |
|     echo                 |
|     echo 'Here is: echo  |
| ${ArrayVar[*]}'          |
|     echo  ${ArrayVar[@]} |
|     echo 'Here is: echo  |
| {${ArrayVar[@]}'         |
|     echo ${ArrayVar[@]}  |
|                          |
|     echo                 |
|     echo '---Case1: With |
| in double-quotes - Defau |
| lt IFS of space-tab-     |
|     newline ---'         |
|     IFS=$'\x20'$'\x09'$' |
| \x0A'       #  These thr |
| ee bytes,                |
|     echo 'Here is: print |
| f %q "{${ArrayVar[*]}"'  |
|     printf %q "${ArrayVa |
| r[*]}"                   |
|     echo                 |
|     echo 'Here is: print |
| f %q "{${ArrayVar[@]}"'  |
|     printf %q "${ArrayVa |
| r[@]}"                   |
|     echo                 |
|     echo 'Here is: echo  |
| "${ArrayVar[*]}"'        |
|     echo  "${ArrayVar[@] |
| }"                       |
|     echo 'Here is: echo  |
| "{${ArrayVar[@]}"'       |
|     echo "${ArrayVar[@]} |
| "                        |
|                          |
|     echo                 |
|     echo '---Case2: With |
| in double-quotes - IFS i |
| s q'                     |
|     IFS='q'              |
|     echo 'Here is: print |
| f %q "{${ArrayVar[*]}"'  |
|     printf %q "${ArrayVa |
| r[*]}"                   |
|     echo                 |
|     echo 'Here is: print |
| f %q "{${ArrayVar[@]}"'  |
|     printf %q "${ArrayVa |
| r[@]}"                   |
|     echo                 |
|     echo 'Here is: echo  |
| "${ArrayVar[*]}"'        |
|     echo  "${ArrayVar[@] |
| }"                       |
|     echo 'Here is: echo  |
| "{${ArrayVar[@]}"'       |
|     echo "${ArrayVar[@]} |
| "                        |
|                          |
|     echo                 |
|     echo '---Case3: With |
| in double-quotes - IFS i |
| s ^'                     |
|     IFS='^'              |
|     echo 'Here is: print |
| f %q "{${ArrayVar[*]}"'  |
|     printf %q "${ArrayVa |
| r[*]}"                   |
|     echo                 |
|     echo 'Here is: print |
| f %q "{${ArrayVar[@]}"'  |
|     printf %q "${ArrayVa |
| r[@]}"                   |
|     echo                 |
|     echo 'Here is: echo  |
| "${ArrayVar[*]}"'        |
|     echo  "${ArrayVar[@] |
| }"                       |
|     echo 'Here is: echo  |
| "{${ArrayVar[@]}"'       |
|     echo "${ArrayVar[@]} |
| "                        |
|                          |
|     echo                 |
|     echo '---Case4: With |
| in double-quotes - IFS i |
| s ^ followed by          |
|     space,tab,newline'   |
|     IFS=$'^'$'\x20'$'\x0 |
| 9'$'\x0A'       # ^ + sp |
| ace tab newline          |
|     echo 'Here is: print |
| f %q "{${ArrayVar[*]}"'  |
|     printf %q "${ArrayVa |
| r[*]}"                   |
|     echo                 |
|     echo 'Here is: print |
| f %q "{${ArrayVar[@]}"'  |
|     printf %q "${ArrayVa |
| r[@]}"                   |
|     echo                 |
|     echo 'Here is: echo  |
| "${ArrayVar[*]}"'        |
|     echo  "${ArrayVar[@] |
| }"                       |
|     echo 'Here is: echo  |
| "{${ArrayVar[@]}"'       |
|     echo "${ArrayVar[@]} |
| "                        |
|                          |
|     echo                 |
|     echo '---Case6: With |
| in double-quotes - IFS s |
| et and empty '           |
|     IFS=''               |
|     echo 'Here is: print |
| f %q "{${ArrayVar[*]}"'  |
|     printf %q "${ArrayVa |
| r[*]}"                   |
|     echo                 |
|     echo 'Here is: print |
| f %q "{${ArrayVar[@]}"'  |
|     printf %q "${ArrayVa |
| r[@]}"                   |
|     echo                 |
|     echo 'Here is: echo  |
| "${ArrayVar[*]}"'        |
|     echo  "${ArrayVar[@] |
| }"                       |
|     echo 'Here is: echo  |
| "{${ArrayVar[@]}"'       |
|     echo "${ArrayVar[@]} |
| "                        |
|                          |
|     echo                 |
|     echo '---Case7: With |
| in double-quotes - IFS i |
| s unset'                 |
|     unset IFS            |
|     echo 'Here is: print |
| f %q "{${ArrayVar[*]}"'  |
|     printf %q "${ArrayVa |
| r[*]}"                   |
|     echo                 |
|     echo 'Here is: print |
| f %q "{${ArrayVar[@]}"'  |
|     printf %q "${ArrayVa |
| r[@]}"                   |
|     echo                 |
|     echo 'Here is: echo  |
| "${ArrayVar[*]}"'        |
|     echo  "${ArrayVar[@] |
| }"                       |
|     echo 'Here is: echo  |
| "{${ArrayVar[@]}"'       |
|     echo "${ArrayVar[@]} |
| "                        |
|                          |
|     echo                 |
|     echo '---End of Case |
| s---'                    |
|     echo "============== |
| ======================== |
| ==================="; ec |
| ho                       |
|                          |
|                          |
|                          |
|     # Put IFS back to th |
| e default.               |
|     # Default is exactly |
|  these three bytes.      |
|     IFS=$'\x20'$'\x09'$' |
| \x0A'           # In exa |
| ctly this order.         |
|                          |
|     # Interpretation of  |
| the above outputs:       |
|     #   A Glob-Pattern i |
| s I/O; the setting of IF |
| S matters.               |
|     ###                  |
|     #   An All-Elements- |
| Of does not consider IFS |
|  settings.               |
|     ###                  |
|     #   Note the differe |
| nt output using the echo |
|  command and the         |
|     #+  quoted format op |
| erator of the printf com |
| mand.                    |
|                          |
|                          |
|     #  Recall:           |
|     #   Parameters are s |
| imilar to arrays and hav |
| e the similar behaviors. |
|     ###                  |
|     #  The above example |
| s demonstrate the possib |
| le variations.           |
|     #  To retain the sha |
| pe of a sparse array, ad |
| ditional script          |
|     #+ programming is re |
| quired.                  |
|     ###                  |
|     #  The source code o |
| f Bash has a routine to  |
| output the               |
|     #+ [subscript]=value |
|    array assignment form |
| at.                      |
|     #  As of version 2.0 |
| 5b, that routine is not  |
| used,                    |
|     #+ but that might ch |
| ange in future releases. |
|                          |
|                          |
|                          |
|     # The length of a st |
| ring, measured in non-nu |
| ll elements (characters) |
| :                        |
|     echo                 |
|     echo '- - Non-quoted |
|  references - -'         |
|     echo 'Non-Null chara |
| cter count: '${#VarSomet |
| hing}' characters.'      |
|                          |
|     # test='Lit'$'\x00'' |
| eral'           # $'\x00 |
| ' is a null character.   |
|     # echo ${#test}      |
|                 # See th |
| at?                      |
|                          |
|                          |
|                          |
|     #  The length of an  |
| array, measured in defin |
| ed elements,             |
|     #+ including null co |
| ntent elements.          |
|     echo                 |
|     echo 'Defined conten |
| t count: '${#ArrayVar[@] |
| }' elements.'            |
|     # That is NOT the ma |
| ximum subscript (4).     |
|     # That is NOT the ra |
| nge of the subscripts (1 |
|  . . 4 inclusive).       |
|     # It IS the length o |
| f the linked list.       |
|     ###                  |
|     #  Both the maximum  |
| subscript and the range  |
| of the subscripts may    |
|     #+ be found with add |
| itional script programmi |
| ng.                      |
|                          |
|     # The length of a st |
| ring, measured in non-nu |
| ll elements (characters) |
| :                        |
|     echo                 |
|     echo '- - Quoted, Gl |
| ob-Pattern references -  |
| -'                       |
|     echo 'Non-Null chara |
| cter count: '"${#VarSome |
| thing}"' characters.'    |
|                          |
|     #  The length of an  |
| array, measured in defin |
| ed elements,             |
|     #+ including null-co |
| ntent elements.          |
|     echo                 |
|     echo 'Defined elemen |
| t count: '"${#ArrayVar[* |
| ]}"' elements.'          |
|                          |
|     #  Interpretation: S |
| ubstitution does not eff |
| ect the ${# ... } operat |
| ion.                     |
|     #  Suggestion:       |
|     #  Always use the Al |
| l-Elements-Of character  |
|     #+ if that is what i |
| s intended (independence |
|  from IFS).              |
|                          |
|                          |
|                          |
|     #  Define a simple f |
| unction.                 |
|     #  I include an unde |
| rscore in the name       |
|     #+ to make it distin |
| ctive in the examples be |
| low.                     |
|     ###                  |
|     #  Bash separates va |
| riable names and functio |
| n names                  |
|     #+ in different name |
| spaces.                  |
|     #  The Mark-One eyeb |
| all isn't that advanced. |
|     ###                  |
|     _simple() {          |
|         echo -n 'SimpleF |
| unc'$@          #  Newli |
| nes are swallowed in     |
|     }                    |
|                 #+ resul |
| t returned in any case.  |
|                          |
|                          |
|     # The ( ... ) notati |
| on invokes a command or  |
| function.                |
|     # The $( ... ) notat |
| ion is pronounced: Resul |
| t-Of.                    |
|                          |
|                          |
|     # Invoke the functio |
| n _simple                |
|     echo                 |
|     echo '- - Output of  |
| function _simple - -'    |
|     _simple              |
|                 # Try pa |
| ssing arguments.         |
|     echo                 |
|     # or                 |
|     (_simple)            |
|                 # Try pa |
| ssing arguments.         |
|     echo                 |
|                          |
|     echo '- Is there a v |
| ariable of that name? -' |
|     echo $_simple not de |
| fined           # No var |
| iable by that name.      |
|                          |
|     # Invoke the result  |
| of function _simple (Err |
| or msg intended)         |
|                          |
|     ###                  |
|     $(_simple)           |
|                 # Gives  |
| an error message:        |
|     #                    |
|        line 436: SimpleF |
| unc: command not found   |
|     #                    |
|        ----------------- |
| ----------------------   |
|                          |
|     echo                 |
|     ###                  |
|                          |
|     #  The first word of |
|  the result of function  |
| _simple                  |
|     #+ is neither a vali |
| d Bash command nor the n |
| ame of a defined functio |
| n.                       |
|     ###                  |
|     # This demonstrates  |
| that the output of _simp |
| le is subject to evaluat |
| ion.                     |
|     ###                  |
|     # Interpretation:    |
|     #   A function can b |
| e used to generate in-li |
| ne Bash commands.        |
|                          |
|                          |
|     # A simple function  |
| where the first word of  |
| result IS a bash command |
| :                        |
|     ###                  |
|     _print() {           |
|         echo -n 'printf  |
| %q '$@                   |
|     }                    |
|                          |
|     echo '- - Outputs of |
|  function _print - -'    |
|     _print parm1 parm2   |
|                 # An Out |
| put NOT A Command.       |
|     echo                 |
|                          |
|     $(_print parm1 parm2 |
| )               #  Execu |
| tes: printf %q parm1 par |
| m2                       |
|                          |
|                 #  See a |
| bove IFS examples for th |
| e                        |
|                          |
|                 #+ vario |
| us possibilities.        |
|     echo                 |
|                          |
|     $(_print $VarSomethi |
| ng)             # The pr |
| edictable result.        |
|     echo                 |
|                          |
|                          |
|                          |
|     # Function variables |
|     # ------------------ |
|                          |
|     echo                 |
|     echo '- - Function v |
| ariables - -'            |
|     # A variable may rep |
| resent a signed integer, |
|  a string or an array.   |
|     # A string may be us |
| ed like a function name  |
| with optional arguments. |
|                          |
|     # set -vx            |
|                 #  Enabl |
| e if desired             |
|     declare -f funcVar   |
|                 #+ in na |
| mespace of functions     |
|                          |
|     funcVar=_print       |
|                 # Contai |
| ns name of function.     |
|     $funcVar parm1       |
|                 # Same a |
| s _print at this point.  |
|     echo                 |
|                          |
|     funcVar=$(_print )   |
|                 # Contai |
| ns result of function.   |
|     $funcVar             |
|                 # No inp |
| ut, No output.           |
|     $funcVar $VarSomethi |
| ng              # The pr |
| edictable result.        |
|     echo                 |
|                          |
|     funcVar=$(_print $Va |
| rSomething)     #  $VarS |
| omething replaced HERE.  |
|     $funcVar             |
|                 #  The e |
| xpansion is part of the  |
|     echo                 |
|                 #+ varia |
| ble contents.            |
|                          |
|     funcVar="$(_print $V |
| arSomething)"   #  $VarS |
| omething replaced HERE.  |
|     $funcVar             |
|                 #  The e |
| xpansion is part of the  |
|     echo                 |
|                 #+ varia |
| ble contents.            |
|                          |
|     #  The difference be |
| tween the unquoted and t |
| he double-quoted version |
| s                        |
|     #+ above can be seen |
|  in the "protect_literal |
| .sh" example.            |
|     #  The first case ab |
| ove is processed as two, |
|  unquoted, Bash-Words.   |
|     #  The second case a |
| bove is processed as one |
| , quoted, Bash-Word.     |
|                          |
|                          |
|                          |
|                          |
|     # Delayed replacemen |
| t                        |
|     # ------------------ |
| -                        |
|                          |
|     echo                 |
|     echo '- - Delayed re |
| placement - -'           |
|     funcVar="$(_print '$ |
| VarSomething')" # No rep |
| lacement, single Bash-Wo |
| rd.                      |
|     eval $funcVar        |
|                 # $VarSo |
| mething replaced HERE.   |
|     echo                 |
|                          |
|     VarSomething='NewThi |
| ng'                      |
|     eval $funcVar        |
|                 # $VarSo |
| mething replaced HERE.   |
|     echo                 |
|                          |
|     # Restore the origin |
| al setting trashed above |
| .                        |
|     VarSomething=Literal |
|                          |
|     #  There are a pair  |
| of functions demonstrate |
| d in the                 |
|     #+ "protect_literal. |
| sh" and "unprotect_liter |
| al.sh" examples.         |
|     #  These are general |
|  purpose functions for d |
| elayed replacement liter |
| als                      |
|     #+ containing variab |
| les.                     |
|                          |
|                          |
|                          |
|                          |
|                          |
|     # REVIEW:            |
|     # ------             |
|                          |
|     #  A string can be c |
| onsidered a Classic-Arra |
| y of elements (character |
| s).                      |
|     #  A string operatio |
| n applies to all element |
| s (characters) of the st |
| ring                     |
|     #+ (in concept, anyw |
| ay).                     |
|     ###                  |
|     #  The notation: ${a |
| rray_name[@]} represents |
|  all elements of the     |
|     #+ Bash-Array: array |
| _name.                   |
|     ###                  |
|     #  The Extended-Synt |
| ax string operations can |
|  be applied to all       |
|     #+ elements of an ar |
| ray.                     |
|     ###                  |
|     #  This may be thoug |
| ht of as a For-Each oper |
| ation on a vector of str |
| ings.                    |
|     ###                  |
|     #  Parameters are si |
| milar to an array.       |
|     #  The initializatio |
| n of a parameter array f |
| or a script              |
|     #+ and a parameter a |
| rray for a function only |
|  differ                  |
|     #+ in the initializa |
| tion of ${0}, which neve |
| r changes its setting.   |
|     ###                  |
|     #  Subscript zero of |
|  the script's parameter  |
| array contains           |
|     #+ the name of the s |
| cript.                   |
|     ###                  |
|     #  Subscript zero of |
|  a function's parameter  |
| array DOES NOT contain   |
|     #+ the name of the f |
| unction.                 |
|     #  The name of the c |
| urrent function is acces |
| sed by the $FUNCNAME var |
| iable.                   |
|     ###                  |
|     #  A quick, review l |
| ist follows (quick, not  |
| short).                  |
|                          |
|     echo                 |
|     echo '- - Test (but  |
| not change) - -'         |
|     echo '- null referen |
| ce -'                    |
|     echo -n ${VarNull-'N |
| otSet'}' '          # No |
| tSet                     |
|     echo ${VarNull}      |
|                     # Ne |
| wLine only               |
|     echo -n ${VarNull:-' |
| NotSet'}' '         # No |
| tSet                     |
|     echo ${VarNull}      |
|                     # Ne |
| wline only               |
|                          |
|     echo '- null content |
| s -'                     |
|     echo -n ${VarEmpty-' |
| Empty'}' '          # On |
| ly the space             |
|     echo ${VarEmpty}     |
|                     # Ne |
| wline only               |
|     echo -n ${VarEmpty:- |
| 'Empty'}' '         # Em |
| pty                      |
|     echo ${VarEmpty}     |
|                     # Ne |
| wline only               |
|                          |
|     echo '- contents -'  |
|     echo ${VarSomething- |
| 'Content'}          # Li |
| teral                    |
|     echo ${VarSomething: |
| -'Content'}         # Li |
| teral                    |
|                          |
|     echo '- Sparse Array |
|  -'                      |
|     echo ${ArrayVar[@]-' |
| not set'}                |
|                          |
|     # ASCII-Art time     |
|     # State     Y==yes,  |
| N==no                    |
|     #           -        |
| :-                       |
|     # Unset     Y        |
| Y       ${# ... } == 0   |
|     # Empty     N        |
| Y       ${# ... } == 0   |
|     # Contents  N        |
| N       ${# ... } > 0    |
|                          |
|     #  Either the first  |
| and/or the second part o |
| f the tests              |
|     #+ may be a command  |
| or a function invocation |
|  string.                 |
|     echo                 |
|     echo '- - Test 1 for |
|  undefined - -'          |
|     declare -i t         |
|     _decT() {            |
|         t=$t-1           |
|     }                    |
|                          |
|     # Null reference, se |
| t: t == -1               |
|     t=${#VarNull}        |
|                     # Re |
| sults in zero.           |
|     ${VarNull- _decT }   |
|                     # Fu |
| nction executes, t now - |
| 1.                       |
|     echo $t              |
|                          |
|     # Null contents, set |
| : t == 0                 |
|     t=${#VarEmpty}       |
|                     # Re |
| sults in zero.           |
|     ${VarEmpty- _decT }  |
|                     # _d |
| ecT function NOT execute |
| d.                       |
|     echo $t              |
|                          |
|     # Contents, set: t = |
| = number of non-null cha |
| racters                  |
|     VarSomething='_simpl |
| e'                  # Se |
| t to valid function name |
| .                        |
|     t=${#VarSomething}   |
|                     # no |
| n-zero length            |
|     ${VarSomething- _dec |
| T }                 # Fu |
| nction _simple executed. |
|     echo $t              |
|                     # No |
| te the Append-To action. |
|                          |
|     # Exercise: clean up |
|  that example.           |
|     unset t              |
|     unset _decT          |
|     VarSomething=Literal |
|                          |
|     echo                 |
|     echo '- - Test and C |
| hange - -'               |
|     echo '- Assignment i |
| f null reference -'      |
|     echo -n ${VarNull='N |
| otSet'}' '          # No |
| tSet NotSet              |
|     echo ${VarNull}      |
|     unset VarNull        |
|                          |
|     echo '- Assignment i |
| f null reference -'      |
|     echo -n ${VarNull:=' |
| NotSet'}' '         # No |
| tSet NotSet              |
|     echo ${VarNull}      |
|     unset VarNull        |
|                          |
|     echo '- No assignmen |
| t if null contents -'    |
|     echo -n ${VarEmpty=' |
| Empty'}' '          # Sp |
| ace only                 |
|     echo ${VarEmpty}     |
|     VarEmpty=''          |
|                          |
|     echo '- Assignment i |
| f null contents -'       |
|     echo -n ${VarEmpty:= |
| 'Empty'}' '         # Em |
| pty Empty                |
|     echo ${VarEmpty}     |
|     VarEmpty=''          |
|                          |
|     echo '- No change if |
|  already has contents -' |
|     echo ${VarSomething= |
| 'Content'}          # Li |
| teral                    |
|     echo ${VarSomething: |
| ='Content'}         # Li |
| teral                    |
|                          |
|                          |
|     # "Subscript sparse" |
|  Bash-Arrays             |
|     ###                  |
|     #  Bash-Arrays are s |
| ubscript packed, beginni |
| ng with                  |
|     #+ subscript zero un |
| less otherwise specified |
| .                        |
|     ###                  |
|     #  The initializatio |
| n of ArrayVar was one wa |
| y                        |
|     #+ to "otherwise spe |
| cify".  Here is the othe |
| r way:                   |
|     ###                  |
|     echo                 |
|     declare -a ArraySpar |
| se                       |
|     ArraySparse=( [1]=on |
| e [2]='' [4]='four' )    |
|     # [0]=null reference |
| , [2]=null content, [3]= |
| null reference           |
|                          |
|     echo '- - Array-Spar |
| se List - -'             |
|     # Within double-quot |
| es, default IFS, Glob-Pa |
| ttern                    |
|                          |
|     IFS=$'\x20'$'\x09'$' |
| \x0A'                    |
|     printf %q "${ArraySp |
| arse[*]}"                |
|     echo                 |
|                          |
|     #  Note that the out |
| put does not distinguish |
|  between "null content"  |
|     #+ and "null referen |
| ce".                     |
|     #  Both print as esc |
| aped whitespace.         |
|     ###                  |
|     #  Note also that th |
| e output does NOT contai |
| n escaped whitespace     |
|     #+ for the "null ref |
| erence(s)" prior to the  |
| first defined element.   |
|     ###                  |
|     # This behavior of 2 |
| .04, 2.05a and 2.05b has |
|  been reported           |
|     #+ and may change in |
|  a future version of Bas |
| h.                       |
|                          |
|     #  To output a spars |
| e array and maintain the |
|  [subscript]=value       |
|     #+ relationship with |
| out change requires a bi |
| t of programming.        |
|     #  One possible code |
|  fragment:               |
|     ###                  |
|     # local l=${#ArraySp |
| arse[@]}        # Count  |
| of defined elements      |
|     # local f=0          |
|                 # Count  |
| of found subscripts      |
|     # local i=0          |
|                 # Subscr |
| ipt to test              |
|     (                    |
|                 # Anonym |
| ous in-line function     |
|         for (( l=${#Arra |
| ySparse[@]}, f = 0, i =  |
| 0 ; f < l ; i++ ))       |
|         do               |
|             # 'if define |
| d then...'               |
|             ${ArraySpars |
| e[$i]+ eval echo '\ ['$i |
| ']='${ArraySparse[$i]} ; |
|  (( f++ )) }             |
|         done             |
|     )                    |
|                          |
|     # The reader coming  |
| upon the above code frag |
| ment cold                |
|     #+ might want to rev |
| iew "command lists" and  |
| "multiple commands on a  |
| line"                    |
|     #+ in the text of th |
| e foregoing "Advanced Ba |
| sh Scripting Guide."     |
|     ###                  |
|     #  Note:             |
|     #  The "read -a arra |
| y_name" version of the " |
| read" command            |
|     #+ begins filling ar |
| ray_name at subscript ze |
| ro.                      |
|     #  ArraySparse does  |
| not define a value at su |
| bscript zero.            |
|     ###                  |
|     #  The user needing  |
| to read/write a sparse a |
| rray to either           |
|     #+ external storage  |
| or a communications sock |
| et must invent           |
|     #+ a read/write code |
|  pair suitable for their |
|  purpose.                |
|     ###                  |
|     # Exercise: clean it |
|  up.                     |
|                          |
|     unset ArraySparse    |
|                          |
|     echo                 |
|     echo '- - Conditiona |
| l alternate (But not cha |
| nge)- -'                 |
|     echo '- No alternate |
|  if null reference -'    |
|     echo -n ${VarNull+'N |
| otSet'}' '               |
|     echo ${VarNull}      |
|     unset VarNull        |
|                          |
|     echo '- No alternate |
|  if null reference -'    |
|     echo -n ${VarNull:+' |
| NotSet'}' '              |
|     echo ${VarNull}      |
|     unset VarNull        |
|                          |
|     echo '- Alternate if |
|  null contents -'        |
|     echo -n ${VarEmpty+' |
| Empty'}' '               |
| # Empty                  |
|     echo ${VarEmpty}     |
|     VarEmpty=''          |
|                          |
|     echo '- No alternate |
|  if null contents -'     |
|     echo -n ${VarEmpty:+ |
| 'Empty'}' '              |
| # Space only             |
|     echo ${VarEmpty}     |
|     VarEmpty=''          |
|                          |
|     echo '- Alternate if |
|  already has contents -' |
|                          |
|     # Alternate literal  |
|     echo -n ${VarSomethi |
| ng+'Content'}' '         |
| # Content Literal        |
|     echo ${VarSomething} |
|                          |
|     # Invoke function    |
|     echo -n ${VarSomethi |
| ng:+ $(_simple) }' '     |
| # SimpleFunc Literal     |
|     echo ${VarSomething} |
|     echo                 |
|                          |
|     echo '- - Sparse Arr |
| ay - -'                  |
|     echo ${ArrayVar[@]+' |
| Empty'}                  |
| # An array of 'Empty'(ie |
| s)                       |
|     echo                 |
|                          |
|     echo '- - Test 2 for |
|  undefined - -'          |
|                          |
|     declare -i t         |
|     _incT() {            |
|         t=$t+1           |
|     }                    |
|                          |
|     #  Note:             |
|     #  This is the same  |
| test used in the sparse  |
| array                    |
|     #+ listing code frag |
| ment.                    |
|                          |
|     # Null reference, se |
| t: t == -1               |
|     t=${#VarNull}-1      |
|                 # Result |
| s in minus-one.          |
|     ${VarNull+ _incT }   |
|                 # Does n |
| ot execute.              |
|     echo $t' Null refere |
| nce'                     |
|                          |
|     # Null contents, set |
| : t == 0                 |
|     t=${#VarEmpty}-1     |
|                 # Result |
| s in minus-one.          |
|     ${VarEmpty+ _incT }  |
|                 # Execut |
| es.                      |
|     echo $t'  Null conte |
| nt'                      |
|                          |
|     # Contents, set: t = |
| = (number of non-null ch |
| aracters)                |
|     t=${#VarSomething}-1 |
|                 # non-nu |
| ll length minus-one      |
|     ${VarSomething+ _inc |
| T }             # Execut |
| es.                      |
|     echo $t'  Contents'  |
|                          |
|     # Exercise: clean up |
|  that example.           |
|     unset t              |
|     unset _incT          |
|                          |
|     # ${name?err_msg} ${ |
| name:?err_msg}           |
|     #  These follow the  |
| same rules but always ex |
| it afterwards            |
|     #+ if an action is s |
| pecified following the q |
| uestion mark.            |
|     #  The action follow |
| ing the question mark ma |
| y be a literal           |
|     #+ or a function res |
| ult.                     |
|     ###                  |
|     #  ${name?} ${name:? |
| } are test-only, the ret |
| urn can be tested.       |
|                          |
|                          |
|                          |
|                          |
|     # Element operations |
|     # ------------------ |
|                          |
|     echo                 |
|     echo '- - Trailing s |
| ub-element selection - - |
| '                        |
|                          |
|     #  Strings, Arrays a |
| nd Positional parameters |
|                          |
|     #  Call this script  |
| with multiple arguments  |
|     #+ to see the parame |
| ter selections.          |
|                          |
|     echo '- All -'       |
|     echo ${VarSomething: |
| 0}              # all no |
| n-null characters        |
|     echo ${ArrayVar[@]:0 |
| }               # all el |
| ements with content      |
|     echo ${@:0}          |
|                 # all pa |
| rameters with content;   |
|                          |
|                 # ignori |
| ng parameter[0]          |
|                          |
|     echo                 |
|     echo '- All after -' |
|     echo ${VarSomething: |
| 1}              # all no |
| n-null after character[0 |
| ]                        |
|     echo ${ArrayVar[@]:1 |
| }               # all af |
| ter element[0] with cont |
| ent                      |
|     echo ${@:2}          |
|                 # all af |
| ter param[1] with conten |
| t                        |
|                          |
|     echo                 |
|     echo '- Range after  |
| -'                       |
|     echo ${VarSomething: |
| 4:3}            # ral    |
|                          |
|                 # Three  |
| characters after         |
|                          |
|                 # charac |
| ter[3]                   |
|                          |
|     echo '- Sparse array |
|  gotch -'                |
|     echo ${ArrayVar[@]:1 |
| :2}     #  four - The on |
| ly element with content. |
|                          |
|         #  Two elements  |
| after (if that many exis |
| t).                      |
|                          |
|         #  the FIRST WIT |
| H CONTENTS               |
|                          |
|         #+ (the FIRST WI |
| TH  CONTENTS is being    |
|                          |
|         #+ considered as |
|  if it                   |
|                          |
|         #+ were subscrip |
| t zero).                 |
|     #  Executed as if Ba |
| sh considers ONLY array  |
| elements with CONTENT    |
|     #  printf %q "${Arra |
| yVar[@]:0:3}"    # Try t |
| his one                  |
|                          |
|     #  In versions 2.04, |
|  2.05a and 2.05b,        |
|     #+ Bash does not han |
| dle sparse arrays as exp |
| ected using this notatio |
| n.                       |
|     #                    |
|     #  The current Bash  |
| maintainer, Chet Ramey,  |
| has corrected this.      |
|                          |
|                          |
|     echo '- Non-sparse a |
| rray -'                  |
|     echo ${@:2:2}        |
|         # Two parameters |
|  following parameter[1]  |
|                          |
|     # New victims for st |
| ring vector examples:    |
|     stringZ=abcABC123ABC |
| abc                      |
|     arrayZ=( abcabc ABCA |
| BC 123123 ABCABC abcabc  |
| )                        |
|     sparseZ=( [1]='abcab |
| c' [3]='ABCABC' [4]='' [ |
| 5]='123123' )            |
|                          |
|     echo                 |
|     echo ' - - Victim st |
| ring - -'$stringZ'- - '  |
|     echo ' - - Victim ar |
| ray - -'${arrayZ[@]}'- - |
|  '                       |
|     echo ' - - Sparse ar |
| ray - -'${sparseZ[@]}'-  |
| - '                      |
|     echo ' - [0]==null r |
| ef, [2]==null ref, [4]== |
| null content - '         |
|     echo ' - [1]=abcabc  |
| [3]=ABCABC [5]=123123 -  |
| '                        |
|     echo ' - non-null-re |
| ference count: '${#spars |
| eZ[@]}' elements'        |
|                          |
|     echo                 |
|     echo '- - Prefix sub |
| -element removal - -'    |
|     echo '- - Glob-Patte |
| rn match must include th |
| e first character. - -'  |
|     echo '- - Glob-Patte |
| rn may be a literal or a |
|  function result. - -'   |
|     echo                 |
|                          |
|                          |
|     # Function returning |
|  a simple, Literal, Glob |
| -Pattern                 |
|     _abc() {             |
|         echo -n 'abc'    |
|     }                    |
|                          |
|     echo '- Shortest pre |
| fix -'                   |
|     echo ${stringZ#123}  |
|                 # Unchan |
| ged (not a prefix).      |
|     echo ${stringZ#$(_ab |
| c)}             # ABC123 |
| ABCabc                   |
|     echo ${arrayZ[@]#abc |
| }               # Applie |
| d to each element.       |
|                          |
|     # echo ${sparseZ[@]# |
| abc}            # Versio |
| n-2.05b core dumps.      |
|     # Has since been fix |
| ed by Chet Ramey.        |
|                          |
|     # The -it would be n |
| ice- First-Subscript-Of  |
|     # echo ${#sparseZ[@] |
| #*}             # This i |
| s NOT valid Bash.        |
|                          |
|     echo                 |
|     echo '- Longest pref |
| ix -'                    |
|     echo ${stringZ##1*3} |
|                 # Unchan |
| ged (not a prefix)       |
|     echo ${stringZ##a*C} |
|                 # abc    |
|     echo ${arrayZ[@]##a* |
| c}              # ABCABC |
|  123123 ABCABC           |
|                          |
|     # echo ${sparseZ[@]# |
| #a*c}           # Versio |
| n-2.05b core dumps.      |
|     # Has since been fix |
| ed by Chet Ramey.        |
|                          |
|     echo                 |
|     echo '- - Suffix sub |
| -element removal - -'    |
|     echo '- - Glob-Patte |
| rn match must include th |
| e last character. - -'   |
|     echo '- - Glob-Patte |
| rn may be a literal or a |
|  function result. - -'   |
|     echo                 |
|     echo '- Shortest suf |
| fix -'                   |
|     echo ${stringZ%1*3}  |
|                 # Unchan |
| ged (not a suffix).      |
|     echo ${stringZ%$(_ab |
| c)}             # abcABC |
| 123ABC                   |
|     echo ${arrayZ[@]%abc |
| }               # Applie |
| d to each element.       |
|                          |
|     # echo ${sparseZ[@]% |
| abc}            # Versio |
| n-2.05b core dumps.      |
|     # Has since been fix |
| ed by Chet Ramey.        |
|                          |
|     # The -it would be n |
| ice- Last-Subscript-Of   |
|     # echo ${#sparseZ[@] |
| %*}             # This i |
| s NOT valid Bash.        |
|                          |
|     echo                 |
|     echo '- Longest suff |
| ix -'                    |
|     echo ${stringZ%%1*3} |
|                 # Unchan |
| ged (not a suffix)       |
|     echo ${stringZ%%b*c} |
|                 # a      |
|     echo ${arrayZ[@]%%b* |
| c}              # a ABCA |
| BC 123123 ABCABC a       |
|                          |
|     # echo ${sparseZ[@]% |
| %b*c}           # Versio |
| n-2.05b core dumps.      |
|     # Has since been fix |
| ed by Chet Ramey.        |
|                          |
|     echo                 |
|     echo '- - Sub-elemen |
| t replacement - -'       |
|     echo '- - Sub-elemen |
| t at any location in str |
| ing. - -'                |
|     echo '- - First spec |
| ification is a Glob-Patt |
| ern - -'                 |
|     echo '- - Glob-Patte |
| rn may be a literal or G |
| lob-Pattern function res |
| ult. - -'                |
|     echo '- - Second spe |
| cification may be a lite |
| ral or function result.  |
| - -'                     |
|     echo '- - Second spe |
| cification may be unspec |
| ified. Pronounce that'   |
|     echo '    as: Replac |
| e-With-Nothing (Delete)  |
| - -'                     |
|     echo                 |
|                          |
|                          |
|                          |
|     # Function returning |
|  a simple, Literal, Glob |
| -Pattern                 |
|     _123() {             |
|         echo -n '123'    |
|     }                    |
|                          |
|     echo '- Replace firs |
| t occurrence -'          |
|     echo ${stringZ/$(_12 |
| 3)/999}         # Change |
| d (123 is a component).  |
|     echo ${stringZ/ABC/x |
| yz}             # xyzABC |
| 123ABCabc                |
|     echo ${arrayZ[@]/ABC |
| /xyz}           # Applie |
| d to each element.       |
|     echo ${sparseZ[@]/AB |
| C/xyz}          # Works  |
| as expected.             |
|                          |
|     echo                 |
|     echo '- Delete first |
|  occurrence -'           |
|     echo ${stringZ/$(_12 |
| 3)/}                     |
|     echo ${stringZ/ABC/} |
|     echo ${arrayZ[@]/ABC |
| /}                       |
|     echo ${sparseZ[@]/AB |
| C/}                      |
|                          |
|     #  The replacement n |
| eed not be a literal,    |
|     #+ since the result  |
| of a function invocation |
|  is allowed.             |
|     #  This is general t |
| o all forms of replaceme |
| nt.                      |
|     echo                 |
|     echo '- Replace firs |
| t occurrence with Result |
| -Of -'                   |
|     echo ${stringZ/$(_12 |
| 3)/$(_simple)}  # Works  |
| as expected.             |
|     echo ${arrayZ[@]/ca/ |
| $(_simple)}     # Applie |
| d to each element.       |
|     echo ${sparseZ[@]/ca |
| /$(_simple)}    # Works  |
| as expected.             |
|                          |
|     echo                 |
|     echo '- Replace all  |
| occurrences -'           |
|     echo ${stringZ//[b2] |
| /X}             # X-out  |
| b's and 2's              |
|     echo ${stringZ//abc/ |
| xyz}            # xyzABC |
| 123ABCxyz                |
|     echo ${arrayZ[@]//ab |
| c/xyz}          # Applie |
| d to each element.       |
|     echo ${sparseZ[@]//a |
| bc/xyz}         # Works  |
| as expected.             |
|                          |
|     echo                 |
|     echo '- Delete all o |
| ccurrences -'            |
|     echo ${stringZ//[b2] |
| /}                       |
|     echo ${stringZ//abc/ |
| }                        |
|     echo ${arrayZ[@]//ab |
| c/}                      |
|     echo ${sparseZ[@]//a |
| bc/}                     |
|                          |
|     echo                 |
|     echo '- - Prefix sub |
| -element replacement - - |
| '                        |
|     echo '- - Match must |
|  include the first chara |
| cter. - -'               |
|     echo                 |
|                          |
|     echo '- Replace pref |
| ix occurrences -'        |
|     echo ${stringZ/#[b2] |
| /X}             # Unchan |
| ged (neither is a prefix |
| ).                       |
|     echo ${stringZ/#$(_a |
| bc)/XYZ}        # XYZABC |
| 123ABCabc                |
|     echo ${arrayZ[@]/#ab |
| c/XYZ}          # Applie |
| d to each element.       |
|     echo ${sparseZ[@]/#a |
| bc/XYZ}         # Works  |
| as expected.             |
|                          |
|     echo                 |
|     echo '- Delete prefi |
| x occurrences -'         |
|     echo ${stringZ/#[b2] |
| /}                       |
|     echo ${stringZ/#$(_a |
| bc)/}                    |
|     echo ${arrayZ[@]/#ab |
| c/}                      |
|     echo ${sparseZ[@]/#a |
| bc/}                     |
|                          |
|     echo                 |
|     echo '- - Suffix sub |
| -element replacement - - |
| '                        |
|     echo '- - Match must |
|  include the last charac |
| ter. - -'                |
|     echo                 |
|                          |
|     echo '- Replace suff |
| ix occurrences -'        |
|     echo ${stringZ/%[b2] |
| /X}             # Unchan |
| ged (neither is a suffix |
| ).                       |
|     echo ${stringZ/%$(_a |
| bc)/XYZ}        # abcABC |
| 123ABCXYZ                |
|     echo ${arrayZ[@]/%ab |
| c/XYZ}          # Applie |
| d to each element.       |
|     echo ${sparseZ[@]/%a |
| bc/XYZ}         # Works  |
| as expected.             |
|                          |
|     echo                 |
|     echo '- Delete suffi |
| x occurrences -'         |
|     echo ${stringZ/%[b2] |
| /}                       |
|     echo ${stringZ/%$(_a |
| bc)/}                    |
|     echo ${arrayZ[@]/%ab |
| c/}                      |
|     echo ${sparseZ[@]/%a |
| bc/}                     |
|                          |
|     echo                 |
|     echo '- - Special ca |
| ses of null Glob-Pattern |
|  - -'                    |
|     echo                 |
|                          |
|     echo '- Prefix all - |
| '                        |
|     # null substring pat |
| tern means 'prefix'      |
|     echo ${stringZ/#/NEW |
| }               # NEWabc |
| ABC123ABCabc             |
|     echo ${arrayZ[@]/#/N |
| EW}             # Applie |
| d to each element.       |
|     echo ${sparseZ[@]/#/ |
| NEW}            # Applie |
| d to null-content also.  |
|                          |
|                 # That s |
| eems reasonable.         |
|                          |
|     echo                 |
|     echo '- Suffix all - |
| '                        |
|     # null substring pat |
| tern means 'suffix'      |
|     echo ${stringZ/%/NEW |
| }               # abcABC |
| 123ABCabcNEW             |
|     echo ${arrayZ[@]/%/N |
| EW}             # Applie |
| d to each element.       |
|     echo ${sparseZ[@]/%/ |
| NEW}            # Applie |
| d to null-content also.  |
|                          |
|                 # That s |
| eems reasonable.         |
|                          |
|     echo                 |
|     echo '- - Special ca |
| se For-Each Glob-Pattern |
|  - -'                    |
|     echo '- - - - This i |
| s a nice-to-have dream - |
|  - - -'                  |
|     echo                 |
|                          |
|     _GenFunc() {         |
|         echo -n ${0}     |
|                 # Illust |
| ration only.             |
|         # Actually, that |
|  would be an arbitrary c |
| omputation.              |
|     }                    |
|                          |
|     # All occurrences, m |
| atching the AnyThing pat |
| tern.                    |
|     # Currently //*/ doe |
| s not match null-content |
|  nor null-reference.     |
|     # /#/ and /%/ does m |
| atch null-content but no |
| t null-reference.        |
|     echo ${sparseZ[@]//* |
| /$(_GenFunc)}            |
|                          |
|                          |
|     #  A possible syntax |
|  would be to make        |
|     #+ the parameter not |
| ation used within this c |
| onstruct mean:           |
|     #   ${1} - The full  |
| element                  |
|     #   ${2} - The prefi |
| x, if any, to the matche |
| d sub-element            |
|     #   ${3} - The match |
| ed sub-element           |
|     #   ${4} - The suffi |
| x, if any, to the matche |
| d sub-element            |
|     #                    |
|     # echo ${sparseZ[@]/ |
| /*/$(_GenFunc ${3})}   # |
|  Same as ${1} here.      |
|     # Perhaps it will be |
|  implemented in a future |
|  version of Bash.        |
|                          |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-59. Testing execution times of various commands**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     #  test-execution-ti |
| me.sh                    |
|     #  Example by Erik B |
| randsberg, for testing e |
| xecution time            |
|     #+ of certain operat |
| ions.                    |
|     #  Referenced in the |
|  "Optimizations" section |
|  of "Miscellany" chapter |
| .                        |
|                          |
|     count=50000          |
|     echo "Math tests"    |
|     echo "Math via \$((  |
| ))"                      |
|     time for (( i=0; i<  |
| $count; i++))            |
|     do                   |
|       result=$(( $i%2 )) |
|     done                 |
|                          |
|     echo "Math via *expr |
| *:"                      |
|     time for (( i=0; i<  |
| $count; i++))            |
|     do                   |
|       result=`expr "$i%2 |
| "`                       |
|     done                 |
|                          |
|     echo "Math via *let* |
| :"                       |
|     time for (( i=0; i<  |
| $count; i++))            |
|     do                   |
|       let result=$i%2    |
|     done                 |
|                          |
|     echo                 |
|     echo "Conditional te |
| sting tests"             |
|                          |
|     echo "Test via case: |
| "                        |
|     time for (( i=0; i<  |
| $count; i++))            |
|     do                   |
|       case $(( $i%2 )) i |
| n                        |
|         0) : ;;          |
|         1) : ;;          |
|       esac               |
|     done                 |
|                          |
|     echo "Test with if [ |
| ], no quotes:"           |
|     time for (( i=0; i<  |
| $count; i++))            |
|     do                   |
|       if [ $(( $i%2 )) = |
|  0 ]; then               |
|          :               |
|       else               |
|          :               |
|       fi                 |
|     done                 |
|                          |
|     echo "Test with if [ |
| ], quotes:"              |
|     time for (( i=0; i<  |
| $count; i++))            |
|     do                   |
|       if [ "$(( $i%2 ))" |
|  = "0" ]; then           |
|          :               |
|       else               |
|          :               |
|       fi                 |
|     done                 |
|                          |
|     echo "Test with if [ |
| ], using -eq:"           |
|     time for (( i=0; i<  |
| $count; i++))            |
|     do                   |
|       if [ $(( $i%2 )) - |
| eq 0 ]; then             |
|          :               |
|       else               |
|          :               |
|       fi                 |
|     done                 |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example A-60. Associative arrays vs. conventional arrays (execution
times)**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     #  assoc-arr-test.sh |
|     #  Benchmark test sc |
| ript to compare executio |
| n times of               |
|     #  numeric-indexed a |
| rray vs. associative arr |
| ay.                      |
|     #     Thank you, Eri |
| k Brandsberg.            |
|                          |
|     count=100000       # |
|  May take a while for so |
| me of the tests below.   |
|     declare simple     # |
|  Can change to 20000, if |
|  desired.                |
|     declare -a array1    |
|     declare -A array2    |
|     declare -a array3    |
|     declare -A array4    |
|                          |
|     echo "===Assignment  |
| tests==="                |
|     echo                 |
|                          |
|     echo "Assigning a si |
| mple variable:"          |
|     # References $i twic |
| e to equalize lookup tim |
| es.                      |
|     time for (( i=0; i<  |
| $count; i++)); do        |
|             simple=$i$i  |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Assigning a nu |
| meric index array entry: |
| "                        |
|     time for (( i=0; i<  |
| $count; i++)); do        |
|             array1[$i]=$ |
| i                        |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Overwriting a  |
| numeric index array entr |
| y:"                      |
|     time for (( i=0; i<  |
| $count; i++)); do        |
|             array1[$i]=$ |
| i                        |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Linear reading |
|  of numeric index array: |
| "                        |
|     time for (( i=0; i<  |
| $count; i++)); do        |
|             simple=array |
| 1[$i]                    |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Assigning an a |
| ssociative array entry:" |
|     time for (( i=0; i<  |
| $count; i++)); do        |
|             array2[$i]=$ |
| i                        |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Overwriting an |
|  associative array entry |
| :"                       |
|     time for (( i=0; i<  |
| $count; i++)); do        |
|             array2[$i]=$ |
| i                        |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Linear reading |
|  an associative array en |
| try:"                    |
|     time for (( i=0; i<  |
| $count; i++)); do        |
|             simple=array |
| 2[$i]                    |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Assigning a ra |
| ndom number to a simple  |
| variable:"               |
|     time for (( i=0; i<  |
| $count; i++)); do        |
|             simple=$RAND |
| OM                       |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Assign a spars |
| e numeric index array en |
| try randomly into 64k ce |
| lls:"                    |
|     time for (( i=0; i<  |
| $count; i++)); do        |
|             array3[$RAND |
| OM]=$i                   |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Reading sparse |
|  numeric index array ent |
| ry:"                     |
|     time for value in "$ |
| {array3[@]}"i; do        |
|             simple=$valu |
| e                        |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Assigning a sp |
| arse associative array e |
| ntry randomly into 64k c |
| ells:"                   |
|     time for (( i=0; i<  |
| $count; i++)); do        |
|             array4[$RAND |
| OM]=$i                   |
|     done                 |
|                          |
|     echo "---"           |
|                          |
|     echo "Reading sparse |
|  associative index array |
|  entry:"                 |
|     time for value in "$ |
| {array4[@]}"; do         |
|             simple=$valu |
| e                        |
|     done                 |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

.. raw:: html

   <table border="0" cellpadding="0" cellspacing="0" summary="Footer navigation table" width="100%">

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

`Prev <biblio.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

`Home <index.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

`Next <refcards.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

Bibliography

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

Reference Cards

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   </div>

