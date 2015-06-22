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

`Prev <histcommands.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <dosbatch.html>`__

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

Appendix M. Sample ``.bashrc`` and ``.bash_profile`` Files
==========================================================

The ``~/.bashrc`` file determines the behavior of interactive shells. A
good look at this file can lead to a better understanding of Bash.

`Emmanuel Rouat <mailto:emmanuel.rouat@wanadoo.fr>`__ contributed the
following very elaborate ``.bashrc`` file, written for a Linux system.
He welcomes reader feedback on it.

Study the file carefully, and feel free to reuse code snippets and
functions from it in your own ``.bashrc`` file or even in your scripts.

.. raw:: html

   <div class="EXAMPLE">

**Example M-1. Sample ``.bashrc`` file**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # ================== |
| ======================== |
| ===================== #  |
|     #                    |
|     # PERSONAL $HOME/.ba |
| shrc FILE for bash-3.0 ( |
| or later)                |
|     # By Emmanuel Rouat  |
| [no-email]               |
|     #                    |
|     # Last modified: Tue |
|  Nov 20 22:04:47 CET 201 |
| 2                        |
|                          |
|     #  This file is norm |
| ally read by interactive |
|  shells only.            |
|     #+ Here is the place |
|  to define your aliases, |
|  functions and           |
|     #+ other interactive |
|  features like your prom |
| pt.                      |
|     #                    |
|     #  The majority of t |
| he code here assumes you |
|  are on a GNU            |
|     #+ system (most like |
| ly a Linux box) and is o |
| ften based on code       |
|     #+ found on Usenet o |
| r Internet.              |
|     #                    |
|     #  See for instance: |
|     #  http://tldp.org/L |
| DP/abs/html/index.html   |
|     #  http://www.caliba |
| n.org/bash               |
|     #  http://www.shelld |
| orado.com/scripts/catego |
| ries.html                |
|     #  http://www.dotfil |
| es.org                   |
|     #                    |
|     #  The choice of col |
| ors was done for a shell |
|  with a dark background  |
|     #+ (white on black), |
|  and this is usually als |
| o suited for pure text-m |
| ode                      |
|     #+ consoles (no X se |
| rver available). If you  |
| use a white background,  |
|     #+ you'll have to do |
|  some other choices for  |
| readability.             |
|     #                    |
|     #  This bashrc file  |
| is a bit overcrowded.    |
|     #  Remember, it is j |
| ust just an example.     |
|     #  Tailor it to your |
|  needs.                  |
|     #                    |
|     # ================== |
| ======================== |
| ===================== #  |
|                          |
|     # --> Comments added |
|  by HOWTO author.        |
|                          |
|     # If not running int |
| eractively, don't do any |
| thing                    |
|     [ -z "$PS1" ] && ret |
| urn                      |
|                          |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Source global defi |
| nitions (if any)         |
|     #------------------- |
| ------------------------ |
| ------------------       |
|                          |
|                          |
|     if [ -f /etc/bashrc  |
| ]; then                  |
|           . /etc/bashrc  |
|   # --> Read /etc/bashrc |
| , if present.            |
|     fi                   |
|                          |
|                          |
|     #------------------- |
| ------------------------ |
| -------------------      |
|     #  Automatic setting |
|  of $DISPLAY (if not set |
|  already).               |
|     #  This works for me |
|  - your mileage may vary |
| . . . .                  |
|     #  The problem is th |
| at different types of te |
| rminals give             |
|     #+ different answers |
|  to 'who am i' (rxvt in  |
| particular can be        |
|     #+ troublesome) - ho |
| wever this code seems to |
|  work in a majority      |
|     #+ of cases.         |
|     #------------------- |
| ------------------------ |
| -------------------      |
|                          |
|     function get_xserver |
|  ()                      |
|     {                    |
|         case $TERM in    |
|             xterm )      |
|                 XSERVER= |
| $(who am i | awk '{print |
|  $NF}' | tr -d ')''(' )  |
|                 # Ane-Pi |
| eter Wieringa suggests t |
| he following alternative |
| :                        |
|                 #  I_AM= |
| $(who am i)              |
|                 #  SERVE |
| R=${I_AM#*(}             |
|                 #  SERVE |
| R=${SERVER%*)}           |
|                 XSERVER= |
| ${XSERVER%%:*}           |
|                 ;;       |
|                 aterm |  |
| rxvt)                    |
|                 # Find s |
| ome code that works here |
| . ...                    |
|                 ;;       |
|         esac             |
|     }                    |
|                          |
|     if [ -z ${DISPLAY:=" |
| "} ]; then               |
|         get_xserver      |
|         if [[ -z ${XSERV |
| ER}  || ${XSERVER} == $( |
| hostname) ||             |
|            ${XSERVER} == |
|  "unix" ]]; then         |
|               DISPLAY=": |
| 0.0"          # Display  |
| on local host.           |
|         else             |
|            DISPLAY=${XSE |
| RVER}:0.0     # Display  |
| on remote host.          |
|         fi               |
|     fi                   |
|                          |
|     export DISPLAY       |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Some settings      |
|     #------------------- |
| ------------------------ |
| ------------------       |
|                          |
|     #set -o nounset      |
| # These  two options are |
|  useful for debugging.   |
|     #set -o xtrace       |
|     alias debug="set -o  |
| nounset; set -o xtrace"  |
|                          |
|     ulimit -S -c 0       |
| # Don't want coredumps.  |
|     set -o notify        |
|     set -o noclobber     |
|     set -o ignoreeof     |
|                          |
|                          |
|     # Enable options:    |
|     shopt -s cdspell     |
|     shopt -s cdable_vars |
|     shopt -s checkhash   |
|     shopt -s checkwinsiz |
| e                        |
|     shopt -s sourcepath  |
|     shopt -s no_empty_cm |
| d_completion             |
|     shopt -s cmdhist     |
|     shopt -s histappend  |
| histreedit histverify    |
|     shopt -s extglob     |
|    # Necessary for progr |
| ammable completion.      |
|                          |
|     # Disable options:   |
|     shopt -u mailwarn    |
|     unset MAILCHECK      |
|    # Don't want my shell |
|  to warn me of incoming  |
| mail.                    |
|                          |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Greeting, motd etc |
| . ...                    |
|     #------------------- |
| ------------------------ |
| ------------------       |
|                          |
|     # Color definitions  |
| (taken from Color Bash P |
| rompt HowTo).            |
|     # Some colors might  |
| look different of some t |
| erminals.                |
|     # For example, I see |
|  'Bold Red' as 'orange'  |
| on my screen,            |
|     # hence the 'Green'  |
| 'BRed' 'Red' sequence I  |
| often use in my prompt.  |
|                          |
|                          |
|     # Normal Colors      |
|     Black='\e[0;30m'     |
|     # Black              |
|     Red='\e[0;31m'       |
|     # Red                |
|     Green='\e[0;32m'     |
|     # Green              |
|     Yellow='\e[0;33m'    |
|     # Yellow             |
|     Blue='\e[0;34m'      |
|     # Blue               |
|     Purple='\e[0;35m'    |
|     # Purple             |
|     Cyan='\e[0;36m'      |
|     # Cyan               |
|     White='\e[0;37m'     |
|     # White              |
|                          |
|     # Bold               |
|     BBlack='\e[1;30m'    |
|     # Black              |
|     BRed='\e[1;31m'      |
|     # Red                |
|     BGreen='\e[1;32m'    |
|     # Green              |
|     BYellow='\e[1;33m'   |
|     # Yellow             |
|     BBlue='\e[1;34m'     |
|     # Blue               |
|     BPurple='\e[1;35m'   |
|     # Purple             |
|     BCyan='\e[1;36m'     |
|     # Cyan               |
|     BWhite='\e[1;37m'    |
|     # White              |
|                          |
|     # Background         |
|     On_Black='\e[40m'    |
|     # Black              |
|     On_Red='\e[41m'      |
|     # Red                |
|     On_Green='\e[42m'    |
|     # Green              |
|     On_Yellow='\e[43m'   |
|     # Yellow             |
|     On_Blue='\e[44m'     |
|     # Blue               |
|     On_Purple='\e[45m'   |
|     # Purple             |
|     On_Cyan='\e[46m'     |
|     # Cyan               |
|     On_White='\e[47m'    |
|     # White              |
|                          |
|     NC="\e[m"            |
|     # Color Reset        |
|                          |
|                          |
|     ALERT=${BWhite}${On_ |
| Red} # Bold White on red |
|  background              |
|                          |
|                          |
|                          |
|     echo -e "${BCyan}Thi |
| s is BASH ${BRed}${BASH_ |
| VERSION%.*}${BCyan}\     |
|     - DISPLAY on ${BRed} |
| $DISPLAY${NC}\n"         |
|     date                 |
|     if [ -x /usr/games/f |
| ortune ]; then           |
|         /usr/games/fortu |
| ne -s     # Makes our da |
| y a bit more fun.... :-) |
|     fi                   |
|                          |
|     function _exit()     |
|           # Function to  |
| run upon exit of shell.  |
|     {                    |
|         echo -e "${BRed} |
| Hasta la vista, baby${NC |
| }"                       |
|     }                    |
|     trap _exit EXIT      |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Shell Prompt - for |
|  many examples, see:     |
|     #       http://www.d |
| ebian-administration.org |
| /articles/205            |
|     #       http://www.a |
| skapache.com/linux/bash- |
| power-prompt.html        |
|     #       http://tldp. |
| org/HOWTO/Bash-Prompt-HO |
| WTO                      |
|     #       https://gith |
| ub.com/nojhan/liquidprom |
| pt                       |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Current Format: [T |
| IME USER@HOST PWD] >     |
|     # TIME:              |
|     #    Green     == ma |
| chine load is low        |
|     #    Orange    == ma |
| chine load is medium     |
|     #    Red       == ma |
| chine load is high       |
|     #    ALERT     == ma |
| chine load is very high  |
|     # USER:              |
|     #    Cyan      == no |
| rmal user                |
|     #    Orange    == SU |
|  to user                 |
|     #    Red       == ro |
| ot                       |
|     # HOST:              |
|     #    Cyan      == lo |
| cal session              |
|     #    Green     == se |
| cured remote connection  |
| (via ssh)                |
|     #    Red       == un |
| secured remote connectio |
| n                        |
|     # PWD:               |
|     #    Green     == mo |
| re than 10% free disk sp |
| ace                      |
|     #    Orange    == le |
| ss than 10% free disk sp |
| ace                      |
|     #    ALERT     == le |
| ss than 5% free disk spa |
| ce                       |
|     #    Red       == cu |
| rrent user does not have |
|  write privileges        |
|     #    Cyan      == cu |
| rrent filesystem is size |
|  zero (like /proc)       |
|     # >:                 |
|     #    White     == no |
|  background or suspended |
|  jobs in this shell      |
|     #    Cyan      == at |
|  least one background jo |
| b in this shell          |
|     #    Orange    == at |
|  least one suspended job |
|  in this shell           |
|     #                    |
|     #    Command is adde |
| d to the history file ea |
| ch time you hit enter,   |
|     #    so it's availab |
| le to all shells (using  |
| 'history -a').           |
|                          |
|                          |
|     # Test connection ty |
| pe:                      |
|     if [ -n "${SSH_CONNE |
| CTION}" ]; then          |
|         CNX=${Green}     |
|     # Connected on remot |
| e machine, via ssh (good |
| ).                       |
|     elif [[ "${DISPLAY%% |
| :0*}" != "" ]]; then     |
|         CNX=${ALERT}     |
|     # Connected on remot |
| e machine, not via ssh ( |
| bad).                    |
|     else                 |
|         CNX=${BCyan}     |
|     # Connected on local |
|  machine.                |
|     fi                   |
|                          |
|     # Test user type:    |
|     if [[ ${USER} == "ro |
| ot" ]]; then             |
|         SU=${Red}        |
|     # User is root.      |
|     elif [[ ${USER} != $ |
| (logname) ]]; then       |
|         SU=${BRed}       |
|     # User is not login  |
| user.                    |
|     else                 |
|         SU=${BCyan}      |
|     # User is normal (we |
| ll ... most of us are).  |
|     fi                   |
|                          |
|                          |
|                          |
|     NCPU=$(grep -c 'proc |
| essor' /proc/cpuinfo)    |
|  # Number of CPUs        |
|     SLOAD=$(( 100*${NCPU |
| } ))        # Small load |
|     MLOAD=$(( 200*${NCPU |
| } ))        # Medium loa |
| d                        |
|     XLOAD=$(( 400*${NCPU |
| } ))        # Xlarge loa |
| d                        |
|                          |
|     # Returns system loa |
| d as percentage, i.e., ' |
| 40' rather than '0.40)'. |
|     function load()      |
|     {                    |
|         local SYSLOAD=$( |
| cut -d " " -f1 /proc/loa |
| davg | tr -d '.')        |
|         # System load of |
|  the current host.       |
|         echo $((10#$SYSL |
| OAD))       # Convert to |
|  decimal.                |
|     }                    |
|                          |
|     # Returns a color in |
| dicating system load.    |
|     function load_color( |
| )                        |
|     {                    |
|         local SYSLOAD=$( |
| load)                    |
|         if [ ${SYSLOAD}  |
| -gt ${XLOAD} ]; then     |
|             echo -en ${A |
| LERT}                    |
|         elif [ ${SYSLOAD |
| } -gt ${MLOAD} ]; then   |
|             echo -en ${R |
| ed}                      |
|         elif [ ${SYSLOAD |
| } -gt ${SLOAD} ]; then   |
|             echo -en ${B |
| Red}                     |
|         else             |
|             echo -en ${G |
| reen}                    |
|         fi               |
|     }                    |
|                          |
|     # Returns a color ac |
| cording to free disk spa |
| ce in $PWD.              |
|     function disk_color( |
| )                        |
|     {                    |
|         if [ ! -w "${PWD |
| }" ] ; then              |
|             echo -en ${R |
| ed}                      |
|             # No 'write' |
|  privilege in the curren |
| t directory.             |
|         elif [ -s "${PWD |
| }" ] ; then              |
|             local used=$ |
| (command df -P "$PWD" |  |
|                        a |
| wk 'END {print $5} {sub( |
| /%/,"")}')               |
|             if [ ${used} |
|  -gt 95 ]; then          |
|                 echo -en |
|  ${ALERT}           # Di |
| sk almost full (>95%).   |
|             elif [ ${use |
| d} -gt 90 ]; then        |
|                 echo -en |
|  ${BRed}            # Fr |
| ee disk space almost gon |
| e.                       |
|             else         |
|                 echo -en |
|  ${Green}           # Fr |
| ee disk space is ok.     |
|             fi           |
|         else             |
|             echo -en ${C |
| yan}                     |
|             # Current di |
| rectory is size '0' (lik |
| e /proc, /sys etc).      |
|         fi               |
|     }                    |
|                          |
|     # Returns a color ac |
| cording to running/suspe |
| nded jobs.               |
|     function job_color() |
|     {                    |
|         if [ $(jobs -s | |
|  wc -l) -gt "0" ]; then  |
|             echo -en ${B |
| Red}                     |
|         elif [ $(jobs -r |
|  | wc -l) -gt "0" ] ; th |
| en                       |
|             echo -en ${B |
| Cyan}                    |
|         fi               |
|     }                    |
|                          |
|     # Adds some text in  |
| the terminal frame (if a |
| pplicable).              |
|                          |
|                          |
|     # Now we construct t |
| he prompt.               |
|     PROMPT_COMMAND="hist |
| ory -a"                  |
|     case ${TERM} in      |
|       *term | rxvt | lin |
| ux)                      |
|             PS1="\[\$(lo |
| ad_color)\][\A\[${NC}\]  |
| "                        |
|             # Time of da |
| y (with load info):      |
|             PS1="\[\$(lo |
| ad_color)\][\A\[${NC}\]  |
| "                        |
|             # User@Host  |
| (with connection type in |
| fo):                     |
|             PS1=${PS1}"\ |
| [${SU}\]\u\[${NC}\]@\[${ |
| CNX}\]\h\[${NC}\] "      |
|             # PWD (with  |
| 'disk space' info):      |
|             PS1=${PS1}"\ |
| [\$(disk_color)\]\W]\[${ |
| NC}\] "                  |
|             # Prompt (wi |
| th 'job' info):          |
|             PS1=${PS1}"\ |
| [\$(job_color)\]>\[${NC} |
| \] "                     |
|             # Set title  |
| of current xterm:        |
|             PS1=${PS1}"\ |
| [\e]0;[\u@\h] \w\a\]"    |
|             ;;           |
|         *)               |
|             PS1="(\A \u@ |
| \h \W) > " # --> PS1="(\ |
| A \u@\h \w) > "          |
|                          |
|            # --> Shows f |
| ull pathname of current  |
| dir.                     |
|             ;;           |
|     esac                 |
|                          |
|                          |
|                          |
|     export TIMEFORMAT=$' |
| \nreal %3R\tuser %3U\tsy |
| s %3S\tpcpu %P\n'        |
|     export HISTIGNORE="& |
| :bg:fg:ll:h"             |
|     export HISTTIMEFORMA |
| T="$(echo -e ${BCyan})[% |
| d/%m %H:%M:%S]$(echo -e  |
| ${NC}) "                 |
|     export HISTCONTROL=i |
| gnoredups                |
|     export HOSTFILE=$HOM |
| E/.hosts    # Put a list |
|  of remote hosts in ~/.h |
| osts                     |
|                          |
|                          |
|     #=================== |
| ======================== |
| =================        |
|     #                    |
|     #  ALIASES AND FUNCT |
| IONS                     |
|     #                    |
|     #  Arguably, some fu |
| nctions defined here are |
|  quite big.              |
|     #  If you want to ma |
| ke this file smaller, th |
| ese functions can        |
|     #+ be converted into |
|  scripts and removed fro |
| m here.                  |
|     #                    |
|     #=================== |
| ======================== |
| =================        |
|                          |
|     #------------------- |
|     # Personnal Aliases  |
|     #------------------- |
|                          |
|     alias rm='rm -i'     |
|     alias cp='cp -i'     |
|     alias mv='mv -i'     |
|     # -> Prevents accide |
| ntally clobbering files. |
|     alias mkdir='mkdir - |
| p'                       |
|                          |
|     alias h='history'    |
|     alias j='jobs -l'    |
|     alias which='type -a |
| '                        |
|     alias ..='cd ..'     |
|                          |
|     # Pretty-print of so |
| me PATH variables:       |
|     alias path='echo -e  |
| ${PATH//:/\\n}'          |
|     alias libpath='echo  |
| -e ${LD_LIBRARY_PATH//:/ |
| \\n}'                    |
|                          |
|                          |
|     alias du='du -kh'    |
|  # Makes a more readable |
|  output.                 |
|     alias df='df -kTh'   |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # The 'ls' family (t |
| his assumes you use a re |
| cent GNU ls).            |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Add colors for fil |
| etype and  human-readabl |
| e sizes by default on 'l |
| s':                      |
|     alias ls='ls -h --co |
| lor'                     |
|     alias lx='ls -lXB'   |
|        #  Sort by extens |
| ion.                     |
|     alias lk='ls -lSr'   |
|        #  Sort by size,  |
| biggest last.            |
|     alias lt='ls -ltr'   |
|        #  Sort by date,  |
| most recent last.        |
|     alias lc='ls -ltcr'  |
|        #  Sort by/show c |
| hange time,most recent l |
| ast.                     |
|     alias lu='ls -ltur'  |
|        #  Sort by/show a |
| ccess time,most recent l |
| ast.                     |
|                          |
|     # The ubiquitous 'll |
| ': directories first, wi |
| th alphanumeric sorting: |
|     alias ll="ls -lv --g |
| roup-directories-first"  |
|     alias lm='ll |more'  |
|        #  Pipe through ' |
| more'                    |
|     alias lr='ll -R'     |
|        #  Recursive ls.  |
|     alias la='ll -A'     |
|        #  Show hidden fi |
| les.                     |
|     alias tree='tree -Cs |
| uh'    #  Nice alternati |
| ve to 'recursive ls' ... |
|                          |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Tailoring 'less'   |
|     #------------------- |
| ------------------------ |
| ------------------       |
|                          |
|     alias more='less'    |
|     export PAGER=less    |
|     export LESSCHARSET=' |
| latin1'                  |
|     export LESSOPEN='|/u |
| sr/bin/lesspipe.sh %s 2> |
| &-'                      |
|                     # Us |
| e this if lesspipe.sh ex |
| ists.                    |
|     export LESS='-i -N - |
| w  -z-4 -g -e -M -X -F - |
| R -P%t?f%f \             |
|     :stdin .?pb%pb\%:?lb |
| Line %lb:?bbByte %bb:-.. |
| .'                       |
|                          |
|     # LESS man page colo |
| rs (makes Man pages more |
|  readable).              |
|     export LESS_TERMCAP_ |
| mb=$'\E[01;31m'          |
|     export LESS_TERMCAP_ |
| md=$'\E[01;31m'          |
|     export LESS_TERMCAP_ |
| me=$'\E[0m'              |
|     export LESS_TERMCAP_ |
| se=$'\E[0m'              |
|     export LESS_TERMCAP_ |
| so=$'\E[01;44;33m'       |
|     export LESS_TERMCAP_ |
| ue=$'\E[0m'              |
|     export LESS_TERMCAP_ |
| us=$'\E[01;32m'          |
|                          |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Spelling typos - h |
| ighly personnal and keyb |
| oard-dependent :-)       |
|     #------------------- |
| ------------------------ |
| ------------------       |
|                          |
|     alias xs='cd'        |
|     alias vf='cd'        |
|     alias moer='more'    |
|     alias moew='more'    |
|     alias kk='ll'        |
|                          |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # A few fun ones     |
|     #------------------- |
| ------------------------ |
| ------------------       |
|                          |
|     # Adds some text in  |
| the terminal frame (if a |
| pplicable).              |
|                          |
|     function xtitle()    |
|     {                    |
|         case "$TERM" in  |
|         *term* | rxvt)   |
|             echo -en  "\ |
| e]0;$*\a" ;;             |
|         *)  ;;           |
|         esac             |
|     }                    |
|                          |
|                          |
|     # Aliases that use x |
| title                    |
|     alias top='xtitle Pr |
| ocesses on $HOST && top' |
|     alias make='xtitle M |
| aking $(basename $PWD) ; |
|  make'                   |
|                          |
|     # .. and functions   |
|     function man()       |
|     {                    |
|         for i ; do       |
|             xtitle The $ |
| (basename $1|tr -d .[:di |
| git:]) manual            |
|             command man  |
| -a "$i"                  |
|         done             |
|     }                    |
|                          |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Make the following |
|  commands run in backgro |
| und automatically:       |
|     #------------------- |
| ------------------------ |
| ------------------       |
|                          |
|     function te()  # wra |
| pper around xemacs/gnuse |
| rv                       |
|     {                    |
|         if [ "$(gnuclien |
| t -batch -eval t 2>&-)"  |
| == "t" ]; then           |
|            gnuclient -q  |
| "$@";                    |
|         else             |
|            ( xemacs "$@" |
|  &);                     |
|         fi               |
|     }                    |
|                          |
|     function soffice() { |
|  command soffice "$@" &  |
| }                        |
|     function firefox() { |
|  command firefox "$@" &  |
| }                        |
|     function xpdf() { co |
| mmand xpdf "$@" & }      |
|                          |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # File & strings rel |
| ated functions:          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|                          |
|                          |
|     # Find a file with a |
|  pattern in name:        |
|     function ff() { find |
|  . -type f -iname '*'"$* |
| "'*' -ls ; }             |
|                          |
|     # Find a file with p |
| attern $1 in name and Ex |
| ecute $2 on it:          |
|     function fe() { find |
|  . -type f -iname '*'"${ |
| 1:-}"'*' \               |
|     -exec ${2:-file} {}  |
| \;  ; }                  |
|                          |
|     #  Find a pattern in |
|  a set of files and high |
| light them:              |
|     #+ (needs a recent v |
| ersion of egrep).        |
|     function fstr()      |
|     {                    |
|         OPTIND=1         |
|         local mycase=""  |
|         local usage="fst |
| r: find string in files. |
|     Usage: fstr [-i] \"p |
| attern\" [\"filename pat |
| tern\"] "                |
|         while getopts :i |
| t opt                    |
|         do               |
|             case "$opt"  |
| in                       |
|                i) mycase |
| ="-i " ;;                |
|                *) echo " |
| $usage"; return ;;       |
|             esac         |
|         done             |
|         shift $(( $OPTIN |
| D - 1 ))                 |
|         if [ "$#" -lt 1  |
| ]; then                  |
|             echo "$usage |
| "                        |
|             return;      |
|         fi               |
|         find . -type f - |
| name "${2:-*}" -print0 | |
|  \                       |
|     xargs -0 egrep --col |
| or=always -sn ${case} "$ |
| 1" 2>&- | more           |
|                          |
|     }                    |
|                          |
|                          |
|     function swap()      |
|     { # Swap 2 filenames |
|  around, if they exist ( |
| from Uzi's bashrc).      |
|         local TMPFILE=tm |
| p.$$                     |
|                          |
|         [ $# -ne 2 ] &&  |
| echo "swap: 2 arguments  |
| needed" && return 1      |
|         [ ! -e $1 ] && e |
| cho "swap: $1 does not e |
| xist" && return 1        |
|         [ ! -e $2 ] && e |
| cho "swap: $2 does not e |
| xist" && return 1        |
|                          |
|         mv "$1" $TMPFILE |
|         mv "$2" "$1"     |
|         mv $TMPFILE "$2" |
|     }                    |
|                          |
|     function extract()   |
|     # Handy Extract Prog |
| ram                      |
|     {                    |
|         if [ -f $1 ] ; t |
| hen                      |
|             case $1 in   |
|                 *.tar.bz |
| 2)   tar xvjf $1     ;;  |
|                 *.tar.gz |
| )    tar xvzf $1     ;;  |
|                 *.bz2)   |
|      bunzip2 $1      ;;  |
|                 *.rar)   |
|      unrar x $1      ;;  |
|                 *.gz)    |
|      gunzip $1       ;;  |
|                 *.tar)   |
|      tar xvf $1      ;;  |
|                 *.tbz2)  |
|      tar xvjf $1     ;;  |
|                 *.tgz)   |
|      tar xvzf $1     ;;  |
|                 *.zip)   |
|      unzip $1        ;;  |
|                 *.Z)     |
|      uncompress $1   ;;  |
|                 *.7z)    |
|      7z x $1         ;;  |
|                 *)       |
|      echo "'$1' cannot b |
| e extracted via >extract |
| <" ;;                    |
|             esac         |
|         else             |
|             echo "'$1' i |
| s not a valid file!"     |
|         fi               |
|     }                    |
|                          |
|                          |
|     # Creates an archive |
|  (*.tar.gz) from given d |
| irectory.                |
|     function maketar() { |
|  tar cvzf "${1%%/}.tar.g |
| z"  "${1%%/}/"; }        |
|                          |
|     # Create a ZIP archi |
| ve of a file or folder.  |
|     function makezip() { |
|  zip -r "${1%%/}.zip" "$ |
| 1" ; }                   |
|                          |
|     # Make your director |
| ies and files access rig |
| hts sane.                |
|     function sanitize()  |
| { chmod -R u=rwX,g=rX,o= |
|  "$@" ;}                 |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Process/system rel |
| ated functions:          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|                          |
|                          |
|     function my_ps() { p |
| s $@ -u $USER -o pid,%cp |
| u,%mem,bsdtime,command ; |
|  }                       |
|     function pp() { my_p |
| s f | awk '!/awk/ && $0~ |
| var' var=${1:-".*"} ; }  |
|                          |
|                          |
|     function killps()    |
| # kill by process name   |
|     {                    |
|         local pid pname  |
| sig="-TERM"   # default  |
| signal                   |
|         if [ "$#" -lt 1  |
| ] || [ "$#" -gt 2 ]; the |
| n                        |
|             echo "Usage: |
|  killps [-SIGNAL] patter |
| n"                       |
|             return;      |
|         fi               |
|         if [ $# = 2 ]; t |
| hen sig=$1 ; fi          |
|         for pid in $(my_ |
| ps| awk '!/awk/ && $0~pa |
| t { print $1 }' pat=${!# |
| } )                      |
|         do               |
|             pname=$(my_p |
| s | awk '$1~var { print  |
| $5 }' var=$pid )         |
|             if ask "Kill |
|  process $pid <$pname> w |
| ith signal $sig?"        |
|                 then kil |
| l $sig $pid              |
|             fi           |
|         done             |
|     }                    |
|                          |
|     function mydf()      |
|     # Pretty-print of 'd |
| f' output.               |
|     {                    |
|     # Inspired by 'dfc'  |
| utility.                 |
|         for fs ; do      |
|                          |
|             if [ ! -d $f |
| s ]                      |
|             then         |
|               echo -e $f |
| s" :No such file or dire |
| ctory" ; continue        |
|             fi           |
|                          |
|             local info=( |
|  $(command df -P $fs | a |
| wk 'END{ print $2,$3,$5  |
| }') )                    |
|             local free=( |
|  $(command df -Pkh $fs | |
|  awk 'END{ print $4 }')  |
| )                        |
|             local nbstar |
| s=$(( 20 * ${info[1]} /  |
| ${info[0]} ))            |
|             local out="[ |
| "                        |
|             for ((j=0;j< |
| 20;j++)); do             |
|                 if [ ${j |
| } -lt ${nbstars} ]; then |
|                    out=$ |
| out"*"                   |
|                 else     |
|                    out=$ |
| out"-"                   |
|                 fi       |
|             done         |
|             out=${info[2 |
| ]}" "$out"] ("$free" fre |
| e on "$fs")"             |
|             echo -e $out |
|         done             |
|     }                    |
|                          |
|                          |
|     function my_ip() # G |
| et IP adress on ethernet |
| .                        |
|     {                    |
|         MY_IP=$(/sbin/if |
| config eth0 | awk '/inet |
| / { print $2 } ' |       |
|           sed -e s/addr: |
| //)                      |
|         echo ${MY_IP:-"N |
| ot connected"}           |
|     }                    |
|                          |
|     function ii()   # Ge |
| t current host related i |
| nfo.                     |
|     {                    |
|         echo -e "\nYou a |
| re logged on ${BRed}$HOS |
| T"                       |
|         echo -e "\n${BRe |
| d}Additionnal informatio |
| n:$NC " ; uname -a       |
|         echo -e "\n${BRe |
| d}Users logged on:$NC "  |
| ; w -hs |                |
|                  cut -d  |
| " " -f1 | sort | uniq    |
|         echo -e "\n${BRe |
| d}Current date :$NC " ;  |
| date                     |
|         echo -e "\n${BRe |
| d}Machine stats :$NC " ; |
|  uptime                  |
|         echo -e "\n${BRe |
| d}Memory stats :$NC " ;  |
| free                     |
|         echo -e "\n${BRe |
| d}Diskspace :$NC " ; myd |
| f / $HOME                |
|         echo -e "\n${BRe |
| d}Local IP Address :$NC" |
|  ; my_ip                 |
|         echo -e "\n${BRe |
| d}Open connections :$NC  |
| "; netstat -pan --inet;  |
|         echo             |
|     }                    |
|                          |
|     #------------------- |
| ------------------------ |
| ------------------       |
|     # Misc utilities:    |
|     #------------------- |
| ------------------------ |
| ------------------       |
|                          |
|     function repeat()    |
|     # Repeat n times com |
| mand.                    |
|     {                    |
|         local i max      |
|         max=$1; shift;   |
|         for ((i=1; i <=  |
| max ; i++)); do  # --> C |
| -like syntax             |
|             eval "$@";   |
|         done             |
|     }                    |
|                          |
|                          |
|     function ask()       |
|     # See 'killps' for e |
| xample of use.           |
|     {                    |
|         echo -n "$@" '[y |
| /n] ' ; read ans         |
|         case "$ans" in   |
|             y*|Y*) retur |
| n 0 ;;                   |
|             *) return 1  |
| ;;                       |
|         esac             |
|     }                    |
|                          |
|     function corename()  |
|   # Get name of app that |
|  created a corefile.     |
|     {                    |
|         for file ; do    |
|             echo -n $fil |
| e : ; gdb --core=$file - |
| -batch | head -1         |
|         done             |
|     }                    |
|                          |
|                          |
|                          |
|     #=================== |
| ======================== |
| ======================== |
| ======                   |
|     #                    |
|     #  PROGRAMMABLE COMP |
| LETION SECTION           |
|     #  Most are taken fr |
| om the bash 2.05 documen |
| tation and from Ian McDo |
| nald's                   |
|     # 'Bash completion'  |
| package (http://www.cali |
| ban.org/bash/#completion |
| )                        |
|     #  You will in fact  |
| need bash more recent th |
| en 3.0 for some features |
| .                        |
|     #                    |
|     #  Note that most li |
| nux distributions now pr |
| ovide many completions   |
|     # 'out of the box' - |
|  however, you might need |
|  to make your own one da |
| y,                       |
|     #  so I kept those h |
| ere as examples.         |
|     #=================== |
| ======================== |
| ======================== |
| ======                   |
|                          |
|     if [ "${BASH_VERSION |
| %.*}" \< "3.0" ]; then   |
|         echo "You will n |
| eed to upgrade to versio |
| n 3.0 for full \         |
|               programmab |
| le completion features"  |
|         return           |
|     fi                   |
|                          |
|     shopt -s extglob     |
|     # Necessary.         |
|                          |
|     complete -A hostname |
|    rsh rcp telnet rlogin |
|  ftp ping disk           |
|     complete -A export   |
|    printenv              |
|     complete -A variable |
|    export local readonly |
|  unset                   |
|     complete -A enabled  |
|    builtin               |
|     complete -A alias    |
|    alias unalias         |
|     complete -A function |
|    function              |
|     complete -A user     |
|    su mail finger        |
|                          |
|     complete -A helptopi |
| c  help     # Currently  |
| same as builtins.        |
|     complete -A shopt    |
|    shopt                 |
|     complete -A stopped  |
| -P '%' bg                |
|     complete -A job -P ' |
| %'     fg jobs disown    |
|                          |
|     complete -A director |
| y  mkdir rmdir           |
|     complete -A director |
| y   -o default cd        |
|                          |
|     # Compression        |
|     complete -f -o defau |
| lt -X '*.+(zip|ZIP)'  zi |
| p                        |
|     complete -f -o defau |
| lt -X '!*.+(zip|ZIP)' un |
| zip                      |
|     complete -f -o defau |
| lt -X '*.+(z|Z)'      co |
| mpress                   |
|     complete -f -o defau |
| lt -X '!*.+(z|Z)'     un |
| compress                 |
|     complete -f -o defau |
| lt -X '*.+(gz|GZ)'    gz |
| ip                       |
|     complete -f -o defau |
| lt -X '!*.+(gz|GZ)'   gu |
| nzip                     |
|     complete -f -o defau |
| lt -X '*.+(bz2|BZ2)'  bz |
| ip2                      |
|     complete -f -o defau |
| lt -X '!*.+(bz2|BZ2)' bu |
| nzip2                    |
|     complete -f -o defau |
| lt -X '!*.+(zip|ZIP|z|Z| |
| gz|GZ|bz2|BZ2)' extract  |
|                          |
|                          |
|     # Documents - Postsc |
| ript,pdf,dvi.....        |
|     complete -f -o defau |
| lt -X '!*.+(ps|PS)'  gs  |
| ghostview ps2pdf ps2asci |
| i                        |
|     complete -f -o defau |
| lt -X \                  |
|     '!*.+(dvi|DVI)' dvip |
| s dvipdf xdvi dviselect  |
| dvitype                  |
|     complete -f -o defau |
| lt -X '!*.+(pdf|PDF)' ac |
| roread pdf2ps            |
|     complete -f -o defau |
| lt -X '!*.@(@(?(e)ps|?(E |
| )PS|pdf|PDF)?\           |
|     (.gz|.GZ|.bz2|.BZ2|. |
| Z))' gv ggv              |
|     complete -f -o defau |
| lt -X '!*.texi*' makeinf |
| o texi2dvi texi2html tex |
| i2pdf                    |
|     complete -f -o defau |
| lt -X '!*.tex' tex latex |
|  slitex                  |
|     complete -f -o defau |
| lt -X '!*.lyx' lyx       |
|     complete -f -o defau |
| lt -X '!*.+(htm*|HTM*)'  |
| lynx html2ps             |
|     complete -f -o defau |
| lt -X \                  |
|     '!*.+(doc|DOC|xls|XL |
| S|ppt|PPT|sx?|SX?|csv|CS |
| V|od?|OD?|ott|OTT)' soff |
| ice                      |
|                          |
|     # Multimedia         |
|     complete -f -o defau |
| lt -X \                  |
|     '!*.+(gif|GIF|jp*g|J |
| P*G|bmp|BMP|xpm|XPM|png| |
| PNG)' xv gimp ee gqview  |
|     complete -f -o defau |
| lt -X '!*.+(mp3|MP3)' mp |
| g123 mpg321              |
|     complete -f -o defau |
| lt -X '!*.+(ogg|OGG)' og |
| g123                     |
|     complete -f -o defau |
| lt -X \                  |
|     '!*.@(mp[23]|MP[23]| |
| ogg|OGG|wav|WAV|pls|\    |
|     m3u|xm|mod|s[3t]m|it |
| |mtm|ult|flac)' xmms     |
|     complete -f -o defau |
| lt -X '!*.@(mp?(e)g|MP?( |
| E)G|wma|avi|AVI|\        |
|     asf|vob|VOB|bin|dat| |
| vcd|ps|pes|fli|viv|rm|ra |
| m|yuv|mov|MOV|qt|\       |
|     QT|wmv|mp3|MP3|ogg|O |
| GG|ogm|OGM|mp4|MP4|wav|W |
| AV|asx|ASX)' xine        |
|                          |
|                          |
|                          |
|     complete -f -o defau |
| lt -X '!*.pl'  perl perl |
| 5                        |
|                          |
|                          |
|     #  This is a 'univer |
| sal' completion function |
|  - it works when command |
| s have                   |
|     #+ a so-called 'long |
|  options' mode , ie: 'ls |
|  --all' instead of 'ls - |
| a'                       |
|     #  Needs the '-o' op |
| tion of grep             |
|     #+ (try the commente |
| d-out version if not ava |
| ilable).                 |
|                          |
|     #  First, remove '=' |
|  from completion word se |
| parators                 |
|     #+ (this will allow  |
| completions like 'ls --c |
| olor=auto' to work corre |
| ctly).                   |
|                          |
|     COMP_WORDBREAKS=${CO |
| MP_WORDBREAKS/=/}        |
|                          |
|                          |
|     _get_longopts()      |
|     {                    |
|       #$1 --help | sed   |
| -e '/--/!d' -e 's/.*--\( |
| [^[:space:].,]*\).*/--\1 |
| /'| \                    |
|       #grep ^"$2" |sort  |
| -u ;                     |
|         $1 --help | grep |
|  -o -e "--[^[:space:].,] |
| *" | grep -e "$2" |sort  |
| -u                       |
|     }                    |
|                          |
|     _longopts()          |
|     {                    |
|         local cur        |
|         cur=${COMP_WORDS |
| [COMP_CWORD]}            |
|                          |
|         case "${cur:-*}" |
|  in                      |
|            -*)      ;;   |
|             *)      retu |
| rn ;;                    |
|         esac             |
|                          |
|         case "$1" in     |
|            \~*)     eval |
|  cmd="$1" ;;             |
|              *)     cmd= |
| "$1" ;;                  |
|         esac             |
|         COMPREPLY=( $(_g |
| et_longopts ${1} ${cur}  |
| ) )                      |
|     }                    |
|     complete  -o default |
|  -F _longopts configure  |
| bash                     |
|     complete  -o default |
|  -F _longopts wget id in |
| fo a2ps ls recode        |
|                          |
|     _tar()               |
|     {                    |
|         local cur ext re |
| gex tar untar            |
|                          |
|         COMPREPLY=()     |
|         cur=${COMP_WORDS |
| [COMP_CWORD]}            |
|                          |
|         # If we want an  |
| option, return the possi |
| ble long options.        |
|         case "$cur" in   |
|             -*)     COMP |
| REPLY=( $(_get_longopts  |
| $1 $cur ) ); return 0;;  |
|         esac             |
|                          |
|         if [ $COMP_CWORD |
|  -eq 1 ]; then           |
|             COMPREPLY=(  |
| $( compgen -W 'c t x u r |
|  d A' -- $cur ) )        |
|             return 0     |
|         fi               |
|                          |
|         case "${COMP_WOR |
| DS[1]}" in               |
|             ?(-)c*f)     |
|                 COMPREPL |
| Y=( $( compgen -f $cur ) |
|  )                       |
|                 return 0 |
|                 ;;       |
|             +([^Izjy])f) |
|                 ext='tar |
| '                        |
|                 regex=$e |
| xt                       |
|                 ;;       |
|             *z*f)        |
|                 ext='tar |
| .gz'                     |
|                 regex='t |
| \(ar\.\)\(gz\|Z\)'       |
|                 ;;       |
|             *[Ijy]*f)    |
|                 ext='t?( |
| ar.)bz?(2)'              |
|                 regex='t |
| \(ar\.\)bz2\?'           |
|                 ;;       |
|             *)           |
|                 COMPREPL |
| Y=( $( compgen -f $cur ) |
|  )                       |
|                 return 0 |
|                 ;;       |
|                          |
|         esac             |
|                          |
|         if [[ "$COMP_LIN |
| E" == tar*.$ext' '* ]];  |
| then                     |
|             # Complete o |
| n files in tar file.     |
|             #            |
|             # Get name o |
| f tar file from command  |
| line.                    |
|             tar=$( echo  |
| "$COMP_LINE" | \         |
|                          |
|     sed -e 's|^.* \([^ ] |
| *'$regex'\) .*$|\1|' )   |
|             # Devise how |
|  to untar and list it.   |
|             untar=t${COM |
| P_WORDS[1]//[^Izjyf]/}   |
|                          |
|             COMPREPLY=(  |
| $( compgen -W "$( echo $ |
| ( tar $untar $tar \      |
|                          |
|             2>/dev/null  |
| ) )" -- "$cur" ) )       |
|             return 0     |
|                          |
|         else             |
|             # File compl |
| etion on relevant files. |
|             COMPREPLY=(  |
| $( compgen -G $cur\*.$ex |
| t ) )                    |
|                          |
|         fi               |
|                          |
|         return 0         |
|                          |
|     }                    |
|                          |
|     complete -F _tar -o  |
| default tar              |
|                          |
|     _make()              |
|     {                    |
|         local mdef makef |
|  makef_dir="." makef_inc |
|  gcmd cur prev i;        |
|         COMPREPLY=();    |
|         cur=${COMP_WORDS |
| [COMP_CWORD]};           |
|         prev=${COMP_WORD |
| S[COMP_CWORD-1]};        |
|         case "$prev" in  |
|             -*f)         |
|                 COMPREPL |
| Y=($(compgen -f $cur )); |
|                 return 0 |
|                 ;;       |
|         esac;            |
|         case "$cur" in   |
|             -*)          |
|                 COMPREPL |
| Y=($(_get_longopts $1 $c |
| ur ));                   |
|                 return 0 |
|                 ;;       |
|         esac;            |
|                          |
|         # ... make reads |
|         #          GNUma |
| kefile,                  |
|         #     then makef |
| ile                      |
|         #     then Makef |
| ile ...                  |
|         if [ -f ${makef_ |
| dir}/GNUmakefile ]; then |
|             makef=${make |
| f_dir}/GNUmakefile       |
|         elif [ -f ${make |
| f_dir}/makefile ]; then  |
|             makef=${make |
| f_dir}/makefile          |
|         elif [ -f ${make |
| f_dir}/Makefile ]; then  |
|             makef=${make |
| f_dir}/Makefile          |
|         else             |
|            makef=${makef |
| _dir}/*.mk         # Loc |
| al convention.           |
|         fi               |
|                          |
|                          |
|         #  Before we sca |
| n for targets, see if a  |
| Makefile name was        |
|         #+ specified wit |
| h -f.                    |
|         for (( i=0; i <  |
| ${#COMP_WORDS[@]}; i++ ) |
| ); do                    |
|             if [[ ${COMP |
| _WORDS[i]} == -f ]]; the |
| n                        |
|                 # eval f |
| or tilde expansion       |
|                 eval mak |
| ef=${COMP_WORDS[i+1]}    |
|                 break    |
|             fi           |
|         done             |
|         [ ! -f $makef ]  |
| && return 0              |
|                          |
|         # Deal with incl |
| uded Makefiles.          |
|         makef_inc=$( gre |
| p -E '^-?include' $makef |
|  |                       |
|                      sed |
|  -e "s,^.* ,"$makef_dir" |
| /," )                    |
|         for file in $mak |
| ef_inc; do               |
|             [ -f $file ] |
|  && makef="$makef $file" |
|         done             |
|                          |
|                          |
|         #  If we have a  |
| partial word to complete |
| , restrict completions   |
|         #+ to matches of |
|  that word.              |
|         if [ -n "$cur" ] |
| ; then gcmd='grep "^$cur |
| "' ; else gcmd=cat ; fi  |
|                          |
|         COMPREPLY=( $( a |
| wk -F':' '/^[a-zA-Z0-9][ |
| ^$#\/\t=]*:([^=]|$)/ \   |
|                          |
|            {split($1,A,/ |
|  /);for(i in A)print A[i |
| ]}' \                    |
|                          |
|             $makef 2>/de |
| v/null | eval $gcmd  ))  |
|                          |
|     }                    |
|                          |
|     complete -F _make -X |
|  '+($*|*.[cho])' make gm |
| ake pmake                |
|                          |
|                          |
|                          |
|                          |
|     _killall()           |
|     {                    |
|         local cur prev   |
|         COMPREPLY=()     |
|         cur=${COMP_WORDS |
| [COMP_CWORD]}            |
|                          |
|         #  Get a list of |
|  processes               |
|         #+ (the first se |
| d evaluation             |
|         #+ takes care of |
|  swapped out processes,  |
| the second               |
|         #+ takes care of |
|  getting the basename of |
|  the process).           |
|         COMPREPLY=( $( p |
| s -u $USER -o comm  | \  |
|             sed -e '1,1d |
| ' -e 's#[]\[]##g' -e 's# |
| ^.*/##'| \               |
|             awk '{if ($0 |
|  ~ /^'$cur'/) print $0}' |
|  ))                      |
|                          |
|         return 0         |
|     }                    |
|                          |
|     complete -F _killall |
|  killall killps          |
|                          |
|                          |
|                          |
|     # Local Variables:   |
|     # mode:shell-script  |
|     # sh-shell:bash      |
|     # End:               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

And, here is a snippet from Andrzej Szelachowski's instructive
``.bash_profile`` file.

.. raw:: html

   <div class="EXAMPLE">

**Example M-2. ``.bash_profile`` file**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # From Andrzej Szela |
| chowski's ~/.bash_profil |
| e:                       |
|                          |
|                          |
|     #  Note that a varia |
| ble may require special  |
| treatment                |
|     #+ if it will be exp |
| orted.                   |
|                          |
|     DARKGRAY='\e[1;30m'  |
|     LIGHTRED='\e[1;31m'  |
|     GREEN='\e[32m'       |
|     YELLOW='\e[1;33m'    |
|     LIGHTBLUE='\e[1;34m' |
|     NC='\e[m'            |
|                          |
|     PCT="\`if [[ \$EUID  |
| -eq 0 ]]; then T='$LIGHT |
| RED' ; else T='$LIGHTBLU |
| E'; fi;                  |
|     echo \$T \`"         |
|                          |
|     #  For "literal" com |
| mand substitution to be  |
| assigned to a variable,  |
|     #+ use escapes and d |
| ouble quotes:            |
|     #+       PCT="\` ... |
|  \`" . . .               |
|     #  Otherwise, the va |
| lue of PCT variable is a |
| ssigned only once,       |
|     #+ when the variable |
|  is exported/read from . |
| bash_profile,            |
|     #+ and it will not c |
| hange afterwards even if |
|  the user ID changes.    |
|                          |
|                          |
|     PS1="\n$GREEN[\w] \n |
| $DARKGRAY($PCT\t$DARKGRA |
| Y)-($PCT\u$DARKGRAY)-($P |
| CT\!                     |
|     $DARKGRAY)$YELLOW->  |
| $NC"                     |
|                          |
|     #  Escape a variable |
| s whose value changes:   |
|     #        if [[ \$EUI |
| D -eq 0 ]],              |
|     #  Otherwise the val |
| ue of the EUID variable  |
| will be assigned only on |
| ce,                      |
|     #+ as above.         |
|                          |
|     #  When a variable i |
| s assigned, it should be |
|  called escaped:         |
|     #+       echo \$T,   |
|     #  Otherwise the val |
| ue of the T variable is  |
| taken from the moment th |
| e PCT                    |
|     #+ variable is expor |
| ted/read from .bash_prof |
| ile.                     |
|     #  So, in this examp |
| le it would be null.     |
|                          |
|     #  When a variable's |
|  value contains a semico |
| lon it should be strong  |
| quoted:                  |
|     #        T='$LIGHTRE |
| D',                      |
|     #  Otherwise, the se |
| micolon will be interpre |
| ted as a command separat |
| or.                      |
|                          |
|                          |
|     #  Variables PCT and |
|  PS1 can be merged into  |
| a new PS1 variable:      |
|                          |
|     PS1="\`if [[ \$EUID  |
| -eq 0 ]]; then PCT='$LIG |
| HTRED';                  |
|     else PCT='$LIGHTBLUE |
| '; fi;                   |
|     echo '\n$GREEN[\w] \ |
| n$DARKGRAY('\$PCT'\t$DAR |
| KGRAY)-\                 |
|     ('\$PCT'\u$DARKGRAY) |
| -('\$PCT'\!$DARKGRAY)$YE |
| LLOW-> $NC'\`"           |
|                          |
|     # The trick is to us |
| e strong quoting for par |
| ts of old PS1 variable.  |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <histcommands.html | History Commands         |
| >`__                     |                          |
| `Home <index.html>`__    | Converting DOS Batch     |
| `Next <dosbatch.html>`__ | Files to Shell Scripts   |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

