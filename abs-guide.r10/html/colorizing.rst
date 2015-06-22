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

`Prev <recursionsct.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

Chapter 36. Miscellany

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <optimizations.html>`__

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

36.5. "Colorizing" Scripts
==========================

The ANSI `[1] <colorizing.html#FTN.AEN20259>`__ escape sequences set
screen attributes, such as bold text, and color of foreground and
background. `DOS batch files <dosbatch.html#DOSBATCH1>`__ commonly used
ANSI escape codes for *color* output, and so can Bash scripts.

.. raw:: html

   <div class="EXAMPLE">

**Example 36-13. A "colorized" address database**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ex30a.sh: "Coloriz |
| ed" version of ex30.sh.  |
|     #            Crude a |
| ddress database          |
|                          |
|                          |
|     clear                |
|                     # Cl |
| ear the screen.          |
|                          |
|     echo -n "          " |
|     echo -e '\E[37;44m'" |
| \033[1mContact List\033[ |
| 0m"                      |
|                          |
|                     # Wh |
| ite on blue background   |
|     echo; echo           |
|     echo -e "\033[1mChoo |
| se one of the following  |
| persons:\033[0m"         |
|                          |
|                     # Bo |
| ld                       |
|     tput sgr0            |
|                     # Re |
| set attributes.          |
|     echo "(Enter only th |
| e first letter of name.) |
| "                        |
|     echo                 |
|     echo -en '\E[47;34m' |
| "\033[1mE\033[0m"   # Bl |
| ue                       |
|     tput sgr0            |
|                     # Re |
| set colors to "normal."  |
|     echo "vans, Roland"  |
|                     # "[ |
| E]vans, Roland"          |
|     echo -en '\E[47;35m' |
| "\033[1mJ\033[0m"   # Ma |
| genta                    |
|     tput sgr0            |
|     echo "ambalaya, Mild |
| red"                     |
|     echo -en '\E[47;32m' |
| "\033[1mS\033[0m"   # Gr |
| een                      |
|     tput sgr0            |
|     echo "mith, Julie"   |
|     echo -en '\E[47;31m' |
| "\033[1mZ\033[0m"   # Re |
| d                        |
|     tput sgr0            |
|     echo "ane, Morris"   |
|     echo                 |
|                          |
|     read person          |
|                          |
|     case "$person" in    |
|     # Note variable is q |
| uoted.                   |
|                          |
|       "E" | "e" )        |
|       # Accept upper or  |
| lowercase input.         |
|       echo               |
|       echo "Roland Evans |
| "                        |
|       echo "4321 Flash D |
| r."                      |
|       echo "Hardscrabble |
| , CO 80753"              |
|       echo "(303) 734-98 |
| 74"                      |
|       echo "(303) 734-98 |
| 92 fax"                  |
|       echo "revans@zzy.n |
| et"                      |
|       echo "Business par |
| tner & old friend"       |
|       ;;                 |
|                          |
|       "J" | "j" )        |
|       echo               |
|       echo "Mildred Jamb |
| alaya"                   |
|       echo "249 E. 7th S |
| t., Apt. 19"             |
|       echo "New York, NY |
|  10009"                  |
|       echo "(212) 533-28 |
| 14"                      |
|       echo "(212) 533-99 |
| 72 fax"                  |
|       echo "milliej@lois |
| aida.com"                |
|       echo "Girlfriend"  |
|       echo "Birthday: Fe |
| b. 11"                   |
|       ;;                 |
|                          |
|     # Add info for Smith |
|  & Zane later.           |
|                          |
|               * )        |
|        # Default option. |
|                          |
|        # Empty input (hi |
| tting RETURN) fits here, |
|  too.                    |
|        echo              |
|        echo "Not yet in  |
| database."               |
|       ;;                 |
|                          |
|     esac                 |
|                          |
|     tput sgr0            |
|                     # Re |
| set colors to "normal."  |
|                          |
|     echo                 |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 36-14. Drawing a box**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # Draw-box.sh: Drawi |
| ng a box using ASCII cha |
| racters.                 |
|                          |
|     # Script by Stefano  |
| Palmeri, with minor edit |
| ing by document author.  |
|     # Minor edits sugges |
| ted by Jim Angstadt.     |
|     # Used in the ABS Gu |
| ide with permission.     |
|                          |
|                          |
|     #################### |
| ######################## |
| ######################## |
| ##                       |
|     ###  draw_box functi |
| on doc  ###              |
|                          |
|     #  The "draw_box" fu |
| nction lets the user     |
|     #+ draw a box in a t |
| erminal.                 |
|     #                    |
|     #  Usage: draw_box R |
| OW COLUMN HEIGHT WIDTH [ |
| COLOR]                   |
|     #  ROW and COLUMN re |
| present the position     |
|                          |
|     #+ of the upper left |
|  angle of the box you're |
|  going to draw.          |
|     #  ROW and COLUMN mu |
| st be greater than 0     |
|     #+ and less than cur |
| rent terminal dimension. |
|     #  HEIGHT is the num |
| ber of rows of the box,  |
| and must be > 0.         |
|     #  HEIGHT + ROW must |
|  be <= than current term |
| inal height.             |
|     #  WIDTH is the numb |
| er of columns of the box |
|  and must be > 0.        |
|     #  WIDTH + COLUMN mu |
| st be <= than current te |
| rminal width.            |
|     #                    |
|     # E.g.: If your term |
| inal dimension is 20x80, |
|     #  draw_box 2 3 10 4 |
| 5 is good                |
|     #  draw_box 2 3 19 4 |
| 5 has bad HEIGHT value ( |
| 19+2 > 20)               |
|     #  draw_box 2 3 18 7 |
| 8 has bad WIDTH value (7 |
| 8+3 > 80)                |
|     #                    |
|     #  COLOR is the colo |
| r of the box frame.      |
|     #  This is the 5th a |
| rgument and is optional. |
|     #  0=black 1=red 2=g |
| reen 3=tan 4=blue 5=purp |
| le 6=cyan 7=white.       |
|     #  If you pass the f |
| unction bad arguments,   |
|     #+ it will just exit |
|  with code 65,           |
|     #+ and no messages w |
| ill be printed on stderr |
| .                        |
|     #                    |
|     #  Clear the termina |
| l before you start to dr |
| aw a box.                |
|     #  The clear command |
|  is not contained within |
|  the function.           |
|     #  This allows the u |
| ser to draw multiple box |
| es, even overlapping one |
| s.                       |
|                          |
|     ###  end of draw_box |
|  function doc  ###       |
|     #################### |
| ######################## |
| ######################## |
| ##                       |
|                          |
|     draw_box(){          |
|                          |
|     #=============#      |
|     HORZ="-"             |
|     VERT="|"             |
|     CORNER_CHAR="+"      |
|                          |
|     MINARGS=4            |
|     E_BADARGS=65         |
|     #=============#      |
|                          |
|                          |
|     if [ $# -lt "$MINARG |
| S" ]; then          # If |
|  args are less than 4, e |
| xit.                     |
|         exit $E_BADARGS  |
|     fi                   |
|                          |
|     # Looking for non di |
| git chars in arguments.  |
|     # Probably it could  |
| be done better (exercise |
|  for the reader?).       |
|     if echo $@ | tr -d [ |
| :blank:] | tr -d [:digit |
| :] | grep . &> /dev/null |
| ; then                   |
|        exit $E_BADARGS   |
|     fi                   |
|                          |
|     BOX_HEIGHT=`expr $3  |
| - 1`   #  -1 correction  |
| needed because angle cha |
| r "+"                    |
|     BOX_WIDTH=`expr $4 - |
|  1`    #+ is a part of b |
| oth box height and width |
| .                        |
|     T_ROWS=`tput lines`  |
|        #  Define current |
|  terminal dimension      |
|     T_COLS=`tput cols`   |
|        #+ in rows and co |
| lumns.                   |
|                          |
|     if [ $1 -lt 1 ] || [ |
|  $1 -gt $T_ROWS ]; then  |
|    #  Start checking if  |
| arguments                |
|        exit $E_BADARGS   |
|                          |
|    #+ are correct.       |
|     fi                   |
|     if [ $2 -lt 1 ] || [ |
|  $2 -gt $T_COLS ]; then  |
|        exit $E_BADARGS   |
|     fi                   |
|     if [ `expr $1 + $BOX |
| _HEIGHT + 1` -gt $T_ROWS |
|  ]; then                 |
|        exit $E_BADARGS   |
|     fi                   |
|     if [ `expr $2 + $BOX |
| _WIDTH + 1` -gt $T_COLS  |
| ]; then                  |
|        exit $E_BADARGS   |
|     fi                   |
|     if [ $3 -lt 1 ] || [ |
|  $4 -lt 1 ]; then        |
|        exit $E_BADARGS   |
|     fi                   |
|                # End che |
| cking arguments.         |
|                          |
|     plot_char(){         |
|                # Functio |
| n within a function.     |
|        echo -e "\E[${1}; |
| ${2}H"$3                 |
|     }                    |
|                          |
|     echo -ne "\E[3${5}m" |
|                # Set box |
|  frame color, if defined |
| .                        |
|                          |
|     # start drawing the  |
| box                      |
|                          |
|     count=1              |
|                          |
|     #  Draw vertical lin |
| es using                 |
|     for (( r=$1; count<= |
| $BOX_HEIGHT; r++)); do   |
|     #+ plot_char functio |
| n.                       |
|       plot_char $r $2 $V |
| ERT                      |
|       let count=count+1  |
|     done                 |
|                          |
|     count=1              |
|     c=`expr $2 + $BOX_WI |
| DTH`                     |
|     for (( r=$1; count<= |
| $BOX_HEIGHT; r++)); do   |
|       plot_char $r $c $V |
| ERT                      |
|       let count=count+1  |
|     done                 |
|                          |
|     count=1              |
|                          |
|    #  Draw horizontal li |
| nes using                |
|     for (( c=$2; count<= |
| $BOX_WIDTH; c++)); do    |
|    #+ plot_char function |
| .                        |
|       plot_char $1 $c $H |
| ORZ                      |
|       let count=count+1  |
|     done                 |
|                          |
|     count=1              |
|     r=`expr $1 + $BOX_HE |
| IGHT`                    |
|     for (( c=$2; count<= |
| $BOX_WIDTH; c++)); do    |
|       plot_char $r $c $H |
| ORZ                      |
|       let count=count+1  |
|     done                 |
|                          |
|     plot_char $1 $2 $COR |
| NER_CHAR                 |
|    # Draw box angles.    |
|     plot_char $1 `expr $ |
| 2 + $BOX_WIDTH` $CORNER_ |
| CHAR                     |
|     plot_char `expr $1 + |
|  $BOX_HEIGHT` $2 $CORNER |
| _CHAR                    |
|     plot_char `expr $1 + |
|  $BOX_HEIGHT` `expr $2 + |
|  $BOX_WIDTH` $CORNER_CHA |
| R                        |
|                          |
|     echo -ne "\E[0m"     |
|          #  Restore old  |
| colors.                  |
|                          |
|     P_ROWS=`expr $T_ROWS |
|  - 1`    #  Put the prom |
| pt at bottom of the term |
| inal.                    |
|                          |
|     echo -e "\E[${P_ROWS |
| };1H"                    |
|     }                    |
|                          |
|                          |
|     # Now, let's try dra |
| wing a box.              |
|     clear                |
|         # Clear the term |
| inal.                    |
|     R=2      # Row       |
|     C=3      # Column    |
|     H=10     # Height    |
|     W=45     # Width     |
|     col=1    # Color (re |
| d)                       |
|     draw_box $R $C $H $W |
|  $col   # Draw the box.  |
|                          |
|     exit 0               |
|                          |
|     # Exercise:          |
|     # --------           |
|     # Add the option of  |
| printing text within the |
|  drawn box.              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

The simplest, and perhaps most useful ANSI escape sequence is bold text,
**\\033[1m ... \\033[0m**. The \\033 represents an
`escape <escapingsection.html#ESCP>`__, the "[1" turns on the bold
attribute, while the "[0" switches it off. The "m" terminates each term
of the escape sequence.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ echo -e "\033[ |
| 1mThis is bold text.\033 |
| [0m"                     |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

A similar escape sequence switches on the underline attribute (on an
*rxvt* and an *aterm*).

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ echo -e "\033[ |
| 4mThis is underlined tex |
| t.\033[0m"               |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| With an **echo**, the ``-e`` option  |
| enables the escape sequences.        |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

Other escape sequences change the text and/or background color.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ echo -e '\E[34 |
| ;47mThis prints in blue. |
| '; tput sgr0             |
|                          |
|                          |
|     bash$ echo -e '\E[33 |
| ;44m'"yellow text on blu |
| e background"; tput sgr0 |
|                          |
|                          |
|     bash$ echo -e '\E[1; |
| 33;44m'"BOLD yellow text |
|  on blue background"; tp |
| ut sgr0                  |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| It's usually advisable to set the    |
| *bold* attribute for light-colored   |
| foreground text.                     |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

The **tput sgr0** restores the terminal settings to normal. Omitting
this lets all subsequent output from that particular terminal remain
blue.

.. raw:: html

   <div class="NOTE">

+--------------------------------------+--------------------------------------+
| |Note|                               |
| Since **tput sgr0** fails to restore |
| terminal settings under certain      |
| circumstances, **echo -ne \\E[0m**   |
| may be a better choice.              |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| Use the following template for writing colored text on a colored         |
| background.                                                              |
|                                                                          |
| ``echo -e '\E[COLOR1;COLOR2mSome text goes here.'``                      |
|                                                                          |
| The "\\E[" begins the escape sequence. The semicolon-separated numbers   |
| "COLOR1" and "COLOR2" specify a foreground and a background color,       |
| according to the table below. (The order of the numbers does not matter, |
| since the foreground and background numbers fall in non-overlapping      |
| ranges.) The "m" terminates the escape sequence, and the text begins     |
| immediately after that.                                                  |
|                                                                          |
| Note also that `single quotes <varsubn.html#SNGLQUO>`__ enclose the      |
| remainder of the command sequence following the **echo -e**.             |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

The numbers in the following table work for an *rxvt* terminal. Results
may vary for other terminal emulators.

.. raw:: html

   <div class="TABLE">

**Table 36-1. Numbers representing colors in Escape Sequences**

+--------------------------+--------------------------+--------------------------+
| Color                    |
| Foreground               |
| Background               |
+==========================+==========================+==========================+
| ``black``                | ``red``                  | ``green``                |
| 30                       | 31                       | 32                       |
| 40                       | 41                       | 42                       |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 36-15. Echoing colored text**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # color-echo.sh: Ech |
| oing text messages in co |
| lor.                     |
|                          |
|     # Modify this script |
|  for your own purposes.  |
|     # It's easier than h |
| and-coding color.        |
|                          |
|     black='\E[30;47m'    |
|     red='\E[31;47m'      |
|     green='\E[32;47m'    |
|     yellow='\E[33;47m'   |
|     blue='\E[34;47m'     |
|     magenta='\E[35;47m'  |
|     cyan='\E[36;47m'     |
|     white='\E[37;47m'    |
|                          |
|                          |
|     alias Reset="tput sg |
| r0"      #  Reset text a |
| ttributes to normal      |
|                          |
|          #+ without clea |
| ring screen.             |
|                          |
|                          |
|     cecho ()             |
|          # Color-echo.   |
|                          |
|          # Argument $1 = |
|  message                 |
|                          |
|          # Argument $2 = |
|  color                   |
|     {                    |
|     local default_msg="N |
| o message passed."       |
|                          |
|          # Doesn't reall |
| y need to be a local var |
| iable.                   |
|                          |
|     message=${1:-$defaul |
| t_msg}   # Defaults to d |
| efault message.          |
|     color=${2:-$black}   |
|          # Defaults to b |
| lack, if not specified.  |
|                          |
|       echo -e "$color"   |
|       echo "$message"    |
|       Reset              |
|          # Reset to norm |
| al.                      |
|                          |
|       return             |
|     }                    |
|                          |
|                          |
|     # Now, let's try it  |
| out.                     |
|     # ------------------ |
| ------------------------ |
| ----------               |
|     cecho "Feeling blue. |
| .." $blue                |
|     cecho "Magenta looks |
|  more like purple." $mag |
| enta                     |
|     cecho "Green with en |
| vy." $green              |
|     cecho "Seeing red?"  |
| $red                     |
|     cecho "Cyan, more fa |
| miliarly known as aqua." |
|  $cyan                   |
|     cecho "No color pass |
| ed (defaults to black)." |
|            # Missing $co |
| lor argument.            |
|     cecho "\"Empty\" col |
| or passed (defaults to b |
| lack)." ""               |
|            # Empty $colo |
| r argument.              |
|     cecho                |
|            # Missing $me |
| ssage and $color argumen |
| ts.                      |
|     cecho "" ""          |
|            # Empty $mess |
| age and $color arguments |
| .                        |
|     # ------------------ |
| ------------------------ |
| ----------               |
|                          |
|     echo                 |
|                          |
|     exit 0               |
|                          |
|     # Exercises:         |
|     # ---------          |
|     # 1) Add the "bold"  |
| attribute to the 'cecho  |
| ()' function.            |
|     # 2) Add options for |
|  colored backgrounds.    |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example 36-16. A "horserace" game**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # horserace.sh: Very |
|  simple horserace simula |
| tion.                    |
|     # Author: Stefano Pa |
| lmeri                    |
|     # Used with permissi |
| on.                      |
|                          |
|     #################### |
| ######################## |
| ####################     |
|     #  Goals of the scri |
| pt:                      |
|     #  playing with esca |
| pe sequences and termina |
| l colors.                |
|     #                    |
|     #  Exercise:         |
|     #  Edit the script t |
| o make it run less rando |
| mly,                     |
|     #+ set up a fake bet |
| ting shop . . .          |
|     #  Um . . . um . . . |
|  it's starting to remind |
|  me of a movie . . .     |
|     #                    |
|     #  The script gives  |
| each horse a random hand |
| icap.                    |
|     #  The odds are calc |
| ulated upon horse handic |
| ap                       |
|     #+ and are expressed |
|  in European(?) style.   |
|     #  E.g., odds=3.75 m |
| eans that if you bet $1  |
| and win,                 |
|     #+ you receive $3.75 |
| .                        |
|     #                    |
|     #  The script has be |
| en tested with a GNU/Lin |
| ux OS,                   |
|     #+ using xterm and r |
| xvt, and konsole.        |
|     #  On a machine with |
|  an AMD 900 MHz processo |
| r,                       |
|     #+ the average race  |
| time is 75 seconds.      |
|     #  On faster compute |
| rs the race time would b |
| e lower.                 |
|     #  So, if you want m |
| ore suspense, reset the  |
| USLEEP_ARG variable.     |
|     #                    |
|     #  Script by Stefano |
|  Palmeri.                |
|     #################### |
| ######################## |
| ####################     |
|                          |
|     E_RUNERR=65          |
|                          |
|     # Check if md5sum an |
| d bc are installed.      |
|     if ! which bc &> /de |
| v/null; then             |
|        echo bc is not in |
| stalled.                 |
|        echo "Can\'t run  |
| . . . "                  |
|        exit $E_RUNERR    |
|     fi                   |
|     if ! which md5sum &> |
|  /dev/null; then         |
|        echo md5sum is no |
| t installed.             |
|        echo "Can\'t run  |
| . . . "                  |
|        exit $E_RUNERR    |
|     fi                   |
|                          |
|     #  Set the following |
|  variable to slow down s |
| cript execution.         |
|     #  It will be passed |
|  as the argument for usl |
| eep (man usleep)         |
|     #+ and is expressed  |
| in microseconds (500000  |
| = half a second).        |
|     USLEEP_ARG=0         |
|                          |
|     #  Clean up the temp |
|  directory, restore term |
| inal cursor and          |
|     #+ terminal colors - |
| - if script interrupted  |
| by Ctl-C.                |
|     trap 'echo -en "\E[? |
| 25h"; echo -en "\E[0m";  |
| stty echo;\              |
|     tput cup 20 0; rm -f |
| r  $HORSE_RACE_TMP_DIR'  |
|  TERM EXIT               |
|     #  See the chapter o |
| n debugging for an expla |
| nation of 'trap.'        |
|                          |
|     # Set a unique (para |
| noid) name for the temp  |
| directory the script nee |
| ds.                      |
|     HORSE_RACE_TMP_DIR=$ |
| HOME/.horserace-`date +% |
| s`-`head -c10 /dev/urand |
| om \                     |
|     | md5sum | head -c30 |
| `                        |
|                          |
|     # Create the temp di |
| rectory and move right i |
| n.                       |
|     mkdir $HORSE_RACE_TM |
| P_DIR                    |
|     cd $HORSE_RACE_TMP_D |
| IR                       |
|                          |
|                          |
|     #  This function mov |
| es the cursor to line $1 |
|  column $2 and then prin |
| ts $3.                   |
|     #  E.g.: "move_and_e |
| cho 5 10 linux" is equiv |
| alent to                 |
|     #+ "tput cup 4 9; ec |
| ho linux", but with one  |
| command instead of two.  |
|     #  Note: "tput cup"  |
| defines 0 0 the upper le |
| ft angle of the terminal |
| ,                        |
|     #+ echo defines 1 1  |
| the upper left angle of  |
| the terminal.            |
|     move_and_echo() {    |
|               echo -ne " |
| \E[${1};${2}H""$3"       |
|     }                    |
|                          |
|     # Function to genera |
| te a pseudo-random numbe |
| r between 1 and 9.       |
|     random_1_9 ()        |
|     {                    |
|         head -c10 /dev/u |
| random | md5sum | tr -d  |
| [a-z] | tr -d 0 | cut -c |
| 1                        |
|     }                    |
|                          |
|     #  Two functions tha |
| t simulate "movement," w |
| hen drawing the horses.  |
|     draw_horse_one() {   |
|                    echo  |
| -n " "//$MOVE_HORSE//    |
|     }                    |
|     draw_horse_two(){    |
|                   echo - |
| n " "\\\\$MOVE_HORSE\\\\ |
|                          |
|     }                    |
|                          |
|                          |
|     # Define current ter |
| minal dimension.         |
|     N_COLS=`tput cols`   |
|     N_LINES=`tput lines` |
|                          |
|     # Need at least a 20 |
| -LINES X 80-COLUMNS term |
| inal. Check it.          |
|     if [ $N_COLS -lt 80  |
| ] || [ $N_LINES -lt 20 ] |
| ; then                   |
|        echo "`basename $ |
| 0` needs a 80-cols X 20- |
| lines terminal."         |
|        echo "Your termin |
| al is ${N_COLS}-cols X $ |
| {N_LINES}-lines."        |
|        exit $E_RUNERR    |
|     fi                   |
|                          |
|                          |
|     # Start drawing the  |
| race field.              |
|                          |
|     # Need a string of 8 |
| 0 chars. See below.      |
|     BLANK80=`seq -s "" 1 |
| 00 | head -c80`          |
|                          |
|     clear                |
|                          |
|     # Set foreground and |
|  background colors to wh |
| ite.                     |
|     echo -ne '\E[37;47m' |
|                          |
|     # Move the cursor on |
|  the upper left angle of |
|  the terminal.           |
|     tput cup 0 0         |
|                          |
|     # Draw six white lin |
| es.                      |
|     for n in `seq 5`; do |
|           echo $BLANK80  |
|   # Use the 80 chars str |
| ing to colorize the term |
| inal.                    |
|     done                 |
|                          |
|     # Sets foreground co |
| lor to black.            |
|     echo -ne '\E[30m'    |
|                          |
|     move_and_echo 3 1 "S |
| TART  1"                 |
|     move_and_echo 3 75 F |
| INISH                    |
|     move_and_echo 1 5 "| |
| "                        |
|     move_and_echo 1 80 " |
| |"                       |
|     move_and_echo 2 5 "| |
| "                        |
|     move_and_echo 2 80 " |
| |"                       |
|     move_and_echo 4 5 "| |
|   2"                     |
|     move_and_echo 4 80 " |
| |"                       |
|     move_and_echo 5 5 "V |
|   3"                     |
|     move_and_echo 5 80 " |
| V"                       |
|                          |
|     # Set foreground col |
| or to red.               |
|     echo -ne '\E[31m'    |
|                          |
|     # Some ASCII art.    |
|     move_and_echo 1 8 ". |
| .@@@..@@@@@...@@@@@.@... |
| @..@@@@..."              |
|     move_and_echo 2 8 ". |
| @...@...@.......@...@... |
| @.@......."              |
|     move_and_echo 3 8 ". |
| @@@@@...@.......@...@@@@ |
| @.@@@@...."              |
|     move_and_echo 4 8 ". |
| @...@...@.......@...@... |
| @.@......."              |
|     move_and_echo 5 8 ". |
| @...@...@.......@...@... |
| @..@@@@..."              |
|     move_and_echo 1 43 " |
| @@@@...@@@...@@@@..@@@@. |
| .@@@@."                  |
|     move_and_echo 2 43 " |
| @...@.@...@.@.....@..... |
| @....."                  |
|     move_and_echo 3 43 " |
| @@@@..@@@@@.@.....@@@@.. |
| .@@@.."                  |
|     move_and_echo 4 43 " |
| @..@..@...@.@.....@..... |
| ....@."                  |
|     move_and_echo 5 43 " |
| @...@.@...@..@@@@..@@@@. |
| @@@@.."                  |
|                          |
|                          |
|     # Set foreground and |
|  background colors to gr |
| een.                     |
|     echo -ne '\E[32;42m' |
|                          |
|     # Draw  eleven green |
|  lines.                  |
|     tput cup 5 0         |
|     for n in `seq 11`; d |
| o                        |
|           echo $BLANK80  |
|     done                 |
|                          |
|     # Set foreground col |
| or to black.             |
|     echo -ne '\E[30m'    |
|     tput cup 5 0         |
|                          |
|     # Draw the fences.   |
|     echo "++++++++++++++ |
| ++++++++++++++++++++++++ |
| \                        |
|     ++++++++++++++++++++ |
| ++++++++++++++++++++++"  |
|                          |
|     tput cup 15 0        |
|     echo "++++++++++++++ |
| ++++++++++++++++++++++++ |
| \                        |
|     ++++++++++++++++++++ |
| ++++++++++++++++++++++"  |
|                          |
|     # Set foreground and |
|  background colors to wh |
| ite.                     |
|     echo -ne '\E[37;47m' |
|                          |
|     # Draw three white l |
| ines.                    |
|     for n in `seq 3`; do |
|           echo $BLANK80  |
|     done                 |
|                          |
|     # Set foreground col |
| or to black.             |
|     echo -ne '\E[30m'    |
|                          |
|     # Create 9 files to  |
| stores handicaps.        |
|     for n in `seq 10 7 6 |
| 8`; do                   |
|           touch $n       |
|     done                 |
|                          |
|     # Set the first type |
|  of "horse" the script w |
| ill draw.                |
|     HORSE_TYPE=2         |
|                          |
|     #  Create position-f |
| ile and odds-file for ev |
| ery "horse".             |
|     #+ In these files, s |
| tore the current positio |
| n of the horse,          |
|     #+ the type and the  |
| odds.                    |
|     for HN in `seq 9`; d |
| o                        |
|           touch horse_${ |
| HN}_position             |
|           touch odds_${H |
| N}                       |
|           echo \-1 > hor |
| se_${HN}_position        |
|           echo $HORSE_TY |
| PE >>  horse_${HN}_posit |
| ion                      |
|           # Define a ran |
| dom handicap for horse.  |
|            HANDICAP=`ran |
| dom_1_9`                 |
|           # Check if the |
|  random_1_9 function ret |
| urned a good value.      |
|           while ! echo $ |
| HANDICAP | grep [1-9] &> |
|  /dev/null; do           |
|                     HAND |
| ICAP=`random_1_9`        |
|           done           |
|           # Define last  |
| handicap position for ho |
| rse.                     |
|           LHP=`expr $HAN |
| DICAP \* 7 + 3`          |
|           for FILE in `s |
| eq 10 7 $LHP`; do        |
|                 echo $HN |
|  >> $FILE                |
|           done           |
|                          |
|           # Calculate od |
| ds.                      |
|           case $HANDICAP |
|  in                      |
|                   1) ODD |
| S=`echo $HANDICAP \* 0.2 |
| 5 + 1.25 | bc`           |
|                          |
|              echo $ODDS  |
| > odds_${HN}             |
|                   ;;     |
|                   2 | 3) |
|  ODDS=`echo $HANDICAP \* |
|  0.40 + 1.25 | bc`       |
|                          |
|                    echo  |
| $ODDS > odds_${HN}       |
|                   ;;     |
|                   4 | 5  |
| | 6) ODDS=`echo $HANDICA |
| P \* 0.55 + 1.25 | bc`   |
|                          |
|                          |
|  echo $ODDS > odds_${HN} |
|                   ;;     |
|                   7 | 8) |
|  ODDS=`echo $HANDICAP \* |
|  0.75 + 1.25 | bc`       |
|                          |
|                    echo  |
| $ODDS > odds_${HN}       |
|                   ;;     |
|                   9) ODD |
| S=`echo $HANDICAP \* 0.9 |
| 0 + 1.25 | bc`           |
|                          |
|               echo $ODDS |
|  > odds_${HN}            |
|           esac           |
|                          |
|                          |
|     done                 |
|                          |
|                          |
|     # Print odds.        |
|     print_odds() {       |
|     tput cup 6 0         |
|     echo -ne '\E[30;42m' |
|     for HN in `seq 9`; d |
| o                        |
|           echo "#$HN odd |
| s->" `cat odds_${HN}`    |
|     done                 |
|     }                    |
|                          |
|     # Draw the horses at |
|  starting line.          |
|     draw_horses() {      |
|     tput cup 6 0         |
|     echo -ne '\E[30;42m' |
|     for HN in `seq 9`; d |
| o                        |
|           echo /\\$HN/\\ |
| "                        |
|         "                |
|     done                 |
|     }                    |
|                          |
|     print_odds           |
|                          |
|     echo -ne '\E[47m'    |
|     # Wait for a enter k |
| ey press to start the ra |
| ce.                      |
|     # The escape sequenc |
| e '\E[?25l' disables the |
|  cursor.                 |
|     tput cup 17 0        |
|     echo -e '\E[?25l'Pre |
| ss [enter] key to start  |
| the race...              |
|     read -s              |
|                          |
|     #  Disable normal ec |
| hoing in the terminal.   |
|     #  This avoids key p |
| resses that might "conta |
| minate" the screen       |
|     #+ during the race.  |
|                          |
|     stty -echo           |
|                          |
|     # ------------------ |
| ------------------------ |
| --------------           |
|     # Start the race.    |
|                          |
|     draw_horses          |
|     echo -ne '\E[37;47m' |
|     move_and_echo 18 1 $ |
| BLANK80                  |
|     echo -ne '\E[30m'    |
|     move_and_echo 18 1 S |
| tarting...               |
|     sleep 1              |
|                          |
|     # Set the column of  |
| the finish line.         |
|     WINNING_POS=74       |
|                          |
|     # Define the time th |
| e race started.          |
|     START_TIME=`date +%s |
| `                        |
|                          |
|     # COL variable neede |
| d by following "while" c |
| onstruct.                |
|     COL=0                |
|                          |
|     while [ $COL -lt $WI |
| NNING_POS ]; do          |
|                          |
|               MOVE_HORSE |
| =0                       |
|                          |
|               # Check if |
|  the random_1_9 function |
|  has returned a good val |
| ue.                      |
|               while ! ec |
| ho $MOVE_HORSE | grep [1 |
| -9] &> /dev/null; do     |
|                     MOVE |
| _HORSE=`random_1_9`      |
|               done       |
|                          |
|               # Define o |
| ld type and position of  |
| the "randomized horse".  |
|               HORSE_TYPE |
| =`cat  horse_${MOVE_HORS |
| E}_position | tail -n 1` |
|               COL=$(expr |
|  `cat  horse_${MOVE_HORS |
| E}_position | head -n 1` |
| )                        |
|                          |
|               ADD_POS=1  |
|               # Check if |
|  the current position is |
|  an handicap position.   |
|               if seq 10  |
| 7 68 | grep -w $COL &> / |
| dev/null; then           |
|                     if g |
| rep -w $MOVE_HORSE $COL  |
| &> /dev/null; then       |
|                          |
|   ADD_POS=0              |
|                          |
|   grep -v -w  $MOVE_HORS |
| E $COL > ${COL}_new      |
|                          |
|   rm -f $COL             |
|                          |
|   mv -f ${COL}_new $COL  |
|                          |
|   else ADD_POS=1         |
|                     fi   |
|               else ADD_P |
| OS=1                     |
|               fi         |
|               COL=`expr  |
| $COL + $ADD_POS`         |
|               echo $COL  |
| >  horse_${MOVE_HORSE}_p |
| osition  # Store new pos |
| ition.                   |
|                          |
|                          |
|              # Choose th |
| e type of horse to draw. |
|                          |
|               case $HORS |
| E_TYPE in                |
|                     1) H |
| ORSE_TYPE=2; DRAW_HORSE= |
| draw_horse_two           |
|                     ;;   |
|                     2) H |
| ORSE_TYPE=1; DRAW_HORSE= |
| draw_horse_one           |
|               esac       |
|                          |
|               echo $HORS |
| E_TYPE >>  horse_${MOVE_ |
| HORSE}_position          |
|               # Store cu |
| rrent type.              |
|                          |
|               # Set fore |
| ground color to black an |
| d background to green.   |
|               echo -ne ' |
| \E[30;42m'               |
|                          |
|               # Move the |
|  cursor to new horse pos |
| ition.                   |
|               tput cup ` |
| expr $MOVE_HORSE + 5` \  |
|           `cat  horse_${ |
| MOVE_HORSE}_position | h |
| ead -n 1`                |
|                          |
|               # Draw the |
|  horse.                  |
|               $DRAW_HORS |
| E                        |
|                usleep $U |
| SLEEP_ARG                |
|                          |
|                # When al |
| l horses have gone beyon |
| d field line 15, reprint |
|  odds.                   |
|                touch fie |
| ldline15                 |
|                if [ $COL |
|  = 15 ]; then            |
|                  echo $M |
| OVE_HORSE >> fieldline15 |
|                          |
|                fi        |
|                if [ `wc  |
| -l fieldline15 | cut -f1 |
|  -d " "` = 9 ]; then     |
|                    print |
| _odds                    |
|                    : > f |
| ieldline15               |
|                fi        |
|                          |
|                          |
|               # Define t |
| he leading horse.        |
|               HIGHEST_PO |
| S=`cat *position | sort  |
| -n | tail -1`            |
|                          |
|               # Set back |
| ground color to white.   |
|               echo -ne ' |
| \E[47m'                  |
|               tput cup 1 |
| 7 0                      |
|               echo -n Cu |
| rrent leader: `grep -w $ |
| HIGHEST_POS *position |  |
| cut -c7`\                |
|           "              |
|                  "       |
|                          |
|     done                 |
|                          |
|     # Define the time th |
| e race finished.         |
|     FINISH_TIME=`date +% |
| s`                       |
|                          |
|     # Set background col |
| or to green and enable b |
| linking text.            |
|     echo -ne '\E[30;42m' |
|     echo -en '\E[5m'     |
|                          |
|     # Make the winning h |
| orse blink.              |
|     tput cup `expr $MOVE |
| _HORSE + 5` \            |
|     `cat  horse_${MOVE_H |
| ORSE}_position | head -n |
|  1`                      |
|     $DRAW_HORSE          |
|                          |
|     # Disable blinking t |
| ext.                     |
|     echo -en '\E[25m'    |
|                          |
|     # Set foreground and |
|  background color to whi |
| te.                      |
|     echo -ne '\E[37;47m' |
|     move_and_echo 18 1 $ |
| BLANK80                  |
|                          |
|     # Set foreground col |
| or to black.             |
|     echo -ne '\E[30m'    |
|                          |
|     # Make winner blink. |
|     tput cup 17 0        |
|     echo -e "\E[5mWINNER |
| : $MOVE_HORSE\E[25m""  O |
| dds: `cat odds_${MOVE_HO |
| RSE}`"\                  |
|     "  Race time: `expr  |
| $FINISH_TIME - $START_TI |
| ME` secs"                |
|                          |
|     # Restore cursor and |
|  old colors.             |
|     echo -en "\E[?25h"   |
|     echo -en "\E[0m"     |
|                          |
|     # Restore echoing.   |
|     stty echo            |
|                          |
|     # Remove race temp d |
| irectory.                |
|     rm -rf $HORSE_RACE_T |
| MP_DIR                   |
|                          |
|     tput cup 19 0        |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

See also `Example A-21 <contributed-scripts.html#HASHEXAMPLE>`__,
`Example A-44 <contributed-scripts.html#HOMEWORK>`__, `Example
A-52 <contributed-scripts.html#SHOWALLC>`__, and `Example
A-40 <contributed-scripts.html#PETALS>`__.

.. raw:: html

   <div class="CAUTION">

+--------------------------------------+--------------------------------------+
| |Caution|                            |
| There is, however, a major problem   |
| with all this. *ANSI escape          |
| sequences are emphatically           |
| `non-portable <portabilityissues.htm |
| l>`__.*                              |
| What works fine on some terminal     |
| emulators (or the console) may work  |
| differently, or not at all, on       |
| others. A "colorized" script that    |
| looks stunning on the script         |
| author's machine may produce         |
| unreadable output on someone else's. |
| This somewhat compromises the        |
| usefulness of colorizing scripts,    |
| and possibly relegates this          |
| technique to the status of a         |
| gimmick. Colorized scripts are       |
| probably inappropriate in a          |
| commercial setting, i.e., your       |
| supervisor might disapprove.         |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

Alister's `ansi-color <http://code.google.com/p/ansi-color/>`__ utility
(based on `Moshe Jacobson's color
utility <http://bash.deta.in/color-1.1.tar.gz>`__ considerably
simplifies using ANSI escape sequences. It substitutes a clean and
logical syntax for the clumsy constructs just discussed.

Henry/teikedvl has likewise created a utility
(http://scriptechocolor.sourceforge.net/) to simplify creation of
colorized scripts.

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <colorizing.html#AEN20259>`__   |
| ANSI is, of course, the acronym for  |
| the American National Standards      |
| Institute. This august body          |
| establishes and maintains various    |
| technical and industrial standards.  |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <recursionsct.html | Recursion: a script      |
| >`__                     | calling itself           |
| `Home <index.html>`__    | `Up <miscellany.html>`__ |
| `Next <optimizations.htm | Optimizations            |
| l>`__                    |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
.. |Caution| image:: ../images/caution.gif
