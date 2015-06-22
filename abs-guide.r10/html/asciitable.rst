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

`Prev <copyright.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <xrefindex.html>`__

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

Appendix T. ASCII Table
=======================

Traditionally, a book of this sort has an
`ASCII <special-chars.html#ASCIIDEF>`__ Table appendix. This book does
not. Instead, here are several short scripts, each of which generates a
complete ASCII table.

.. raw:: html

   <div class="EXAMPLE">

**Example T-1. A script that generates an ASCII table**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ascii.sh           |
|     # ver. 0.2, reldate  |
| 26 Aug 2008              |
|     # Patched by ABS Gui |
| de author.               |
|                          |
|     # Original script by |
|  Sebastian Arming.       |
|     # Used with permissi |
| on (thanks!).            |
|                          |
|     exec >ASCII.txt      |
|     #  Save stdout to fi |
| le,                      |
|                          |
|     #+ as in the example |
|  scripts                 |
|                          |
|     #+ reassign-stdout.s |
| h and upperconv.sh.      |
|                          |
|     MAXNUM=256           |
|     COLUMNS=5            |
|     OCT=8                |
|     OCTSQU=64            |
|     LITTLESPACE=-3       |
|     BIGSPACE=-5          |
|                          |
|     i=1 # Decimal counte |
| r                        |
|     o=1 # Octal counter  |
|                          |
|     while [ "$i" -lt "$M |
| AXNUM" ]; do  # We don't |
|  have to count past 400  |
| octal.                   |
|             paddi="    $ |
| i"                       |
|             echo -n "${p |
| addi: $BIGSPACE}  "      |
|   # Column spacing.      |
|             paddo="00$o" |
|     #       echo -ne "\\ |
| ${paddo: $LITTLESPACE}"  |
|   # Original.            |
|             echo -ne "\\ |
| 0${paddo: $LITTLESPACE}" |
|   # Fixup.               |
|     #                    |
| ^                        |
|             echo -n "    |
|   "                      |
|             if (( i % $C |
| OLUMNS == 0)); then      |
|   # New line.            |
|                echo      |
|             fi           |
|             ((i++, o++)) |
|             # The octal  |
| notation for 8 is 10, an |
| d 64 decimal is 100 octa |
| l.                       |
|             (( i % $OCT  |
| == 0))    && ((o+=2))    |
|             (( i % $OCTS |
| QU == 0)) && ((o+=20))   |
|     done                 |
|                          |
|     exit $?              |
|                          |
|     # Compare this scrip |
| t with the "pr-asc.sh" e |
| xample.                  |
|     # This one handles " |
| unprintable" characters. |
|                          |
|     # Exercise:          |
|     # Rewrite this scrip |
| t to use decimal numbers |
| , rather than octal.     |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example T-2. Another ASCII table script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # Script author: Jos |
| eph Steinhauser          |
|     # Lightly edited by  |
| ABS Guide author, but no |
| t commented.             |
|     # Used in ABS Guide  |
| with permission.         |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------------ |
| ------                   |
|     #-- File:  ascii.sh  |
|    Print ASCII chart, ba |
| se 10/8/16         (JETS |
| -2012)                   |
|     #------------------- |
| ------------------------ |
| ------------------------ |
| ------                   |
|     #-- Usage: ascii [oc |
| t|dec|hex|help|8|10|16]  |
|     #--                  |
|     #-- This script prin |
| ts out a summary of ASCI |
| I char codes from Zero t |
| o 127.                   |
|     #-- Numeric values m |
| ay be printed in Base10, |
|  Octal, or Hex.          |
|     #--                  |
|     #-- Format Based on: |
|  /usr/share/lib/pub/asci |
| i with base-10 as defaul |
| t.                       |
|     #-- For more detail, |
|  man ascii . . .         |
|     #------------------- |
| ------------------------ |
| ------------------------ |
| ------                   |
|                          |
|     [ -n "$BASH_VERSION" |
|  ] && shopt -s extglob   |
|                          |
|     case "$1" in         |
|        oct|[Oo]?([Cc][Tt |
| ])|8)       Obase=Octal; |
|   Numy=3o;;              |
|        hex|[Hh]?([Ee][Xx |
| ])|16|[Xx]) Obase=Hex;   |
|   Numy=2X;;              |
|        help|?(-)[h?])    |
|      sed -n '2,/^[ ]*$/p |
| ' $0;exit;;              |
|        code|[Cc][Oo][Dd] |
| [Ee])sed -n '/case/,$p'  |
|   $0;exit;;              |
|        *) Obase=Decimal  |
|     esac # CODE is actua |
| lly shorter than the cha |
| rt!                      |
|                          |
|     printf "\t\t## $Obas |
| e ASCII Chart ##\n\n"; F |
| M1="|%0${Numy:-3d}"; LD= |
| -1                       |
|                          |
|     AB="nul soh stx etx  |
| eot enq ack bel bs tab n |
| l vt np cr so si dle"    |
|     AD="dc1 dc2 dc3 dc4  |
| nak syn etb can em sub e |
| sc fs gs rs us sp"       |
|                          |
|     for TOK in $AB $AD;  |
| do ABR[$((LD+=1))]=$TOK; |
|  done;                   |
|     ABR[127]=del         |
|                          |
|     IDX=0                |
|     while [ $IDX -le 127 |
|  ] && CHR="${ABR[$IDX]}" |
|        do ((${#CHR}))&&  |
| FM2='%-3s'|| FM2=`printf |
|  '\\\\%o  ' $IDX`        |
|           printf "$FM1 $ |
| FM2" "$IDX" $CHR; (( (ID |
| X+=1)%8))||echo '|'      |
|        done              |
|                          |
|     exit $?              |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   <div class="EXAMPLE">

**Example T-3. A third ASCII table script, using *awk***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ASCII table script |
| , using awk.             |
|     # Author: Joseph Ste |
| inhauser                 |
|     # Used in ABS Guide  |
| with permission.         |
|                          |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------------ |
| ------                   |
|     #-- File:  ascii     |
|  Print ASCII chart, base |
|  10/8/16         (JETS-2 |
| 010)                     |
|     #------------------- |
| ------------------------ |
| ------------------------ |
| ------                   |
|     #-- Usage: ascii [oc |
| t|dec|hex|help|8|10|16]  |
|     #--                  |
|     #-- This script prin |
| ts a summary of ASCII ch |
| ar codes from Zero to 12 |
| 7.                       |
|     #-- Numeric values m |
| ay be printed in Base10, |
|  Octal, or Hex (Base16). |
|     #--                  |
|     #-- Format Based on: |
|  /usr/share/lib/pub/asci |
| i with base-10 as defaul |
| t.                       |
|     #-- For more detail, |
|  man ascii               |
|     #------------------- |
| ------------------------ |
| ------------------------ |
| ------                   |
|                          |
|     [ -n "$BASH_VERSION" |
|  ] && shopt -s extglob   |
|                          |
|     case "$1" in         |
|        oct|[Oo]?([Cc][Tt |
| ])|8)       Obase=Octal; |
|   Numy=3o;;              |
|        hex|[Hh]?([Ee][Xx |
| ])|16|[Xx]) Obase=Hex;   |
|   Numy=2X;;              |
|        help|?(-)[h?])    |
|      sed -n '2,/^[ ]*$/p |
| ' $0;exit;;              |
|        code|[Cc][Oo][Dd] |
| [Ee])sed -n '/case/,$p'  |
|   $0;exit;;              |
|        *) Obase=Decimal  |
|     esac                 |
|     export Obase   # COD |
| E is actually shorter th |
| an the chart!            |
|                          |
|     awk 'BEGIN{print "\n |
| \t\t## "ENVIRON["Obase"] |
| " ASCII Chart ##\n"      |
|                ab="soh,s |
| tx,etx,eot,enq,ack,bel,b |
| s,tab,nl,vt,np,cr,so,si, |
| dle,"                    |
|                ad="dc1,d |
| c2,dc3,dc4,nak,syn,etb,c |
| an,em,sub,esc,fs,gs,rs,u |
| s,sp"                    |
|                split(ab  |
| ad,abr,",");abr[0]="nul" |
| ;abr[127]="del";         |
|                fm1="|%0' |
| "${Numy:- 4d}"' %-3s"    |
|                for(idx=0 |
| ;idx<128;idx++){fmt=fm1  |
| (++colz%8?"":"|\n")      |
|                printf(fm |
| t,idx,(idx in abr)?abr[i |
| dx]:sprintf("%c",idx))}  |
| }'                       |
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

+--------------------------+--------------------------+--------------------------+
| `Prev <copyright.html>`_ | Copyright                |
| _                        |                          |
| `Home <index.html>`__    | Index                    |
| `Next <xrefindex.html>`_ |                          |
| _                        |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

