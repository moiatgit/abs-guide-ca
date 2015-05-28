###############################
Guia avançada de Bash-Scripting
###############################

*********************************************************
Una exploració en profunditat de l'art dels shell-scripts
*********************************************************

Per *Mendel Cooper*

``<thegrendel.abs@gmail.com>``

Versió 6.5 del 05 d'abril de 2012

----------

Aquest turorial no pressuposa cap coneixement previ de programació o
*scripting* però progressa ràpidament cap a un nivell
intermedi/avançat, a l'hora que juga amb les petites meravelles de
UNIX®. Està pensat per poder fer-se servir tant com a llibre de text,
com a manual d'autoaprenentatge, i també com a referència i font de
coneixement de les tècniques de shell-script. Els exercicis, així com
els exemples comentats amb profusió, inviten al lector actiu a
participar, sota la premissa de que *l'única manera d'aprendre
realment shell-script és escrivint shell-scripts*.

Aquest llibre és apte per l'ús a classe i com a introducció general
als conceptes de programació.

--------------

Dedicatòria
-----------

A Anita, la font de tota la màgia.

Taula de continguts
-------------------

Part 1. `Introduction <part1.ca.html>`_

1. `Shell Programming! <why-shell.ca.html>`_

2. `Starting Off With a Sha-Bang <sha-bang.ca.html>`_

Part 2. `Basics <part2.ca.html>`_

3. `Special Characters <special-chars.ca.html>`_

4. `Introduction to Variables and Parameters <variables.ca.html>`_

5. `Quoting <quoting.ca.html>`_

6. `Exit and Exit Status <exit-status.ca.html>`_

7. `Tests <tests.ca.html>`_

8. `Operations and Related Topics <operations.ca.html>`_

Part 3. `Beyond the Basics <part3.ca.html>`_

9. `Another Look at Variables <variables2.ca.html>`_

10. `Manipulating Variables <manipulatingvars.ca.html>`_

11. `Loops and Branches <loops.ca.html>`_

12. `Command Substitution <commandsub.ca.html>`_

13. `Arithmetic Expansion <arithexp.ca.html>`_

14. `Recess Time <recess-time.ca.html>`_

Part 4. `Commands <part4.ca.html>`_

15. `Internal Commands and Builtins <internal.ca.html>`_

16. `Filtres externs, programes i comandes <external.ca.html>`_

17. `System and Administrative Commands <system.ca.html>`_

Part 5. `Advanced Topics <part5.ca.html>`_

18. `Regular Expressions <regexp.ca.html>`_

19. `Here Documents <here-docs.ca.html>`_

20. `I/O Redirection <io-redirection.ca.html>`_

21. `Subshells <subshells.ca.html>`_

22. `Restricted Shells <restricted-sh.ca.html>`_

23. `Process Substitution <process-sub.ca.html>`_

24. `Functions <functions.ca.html>`_

25. `Aliases <aliases.ca.html>`_

26. `List Constructs <list-cons.ca.html>`_

27. `Arrays <arrays.ca.html>`_

28. `Indirect References <ivr.ca.html>`_

29. ```/dev`` and ``/proc`` <devproc.ca.html>`_

30. `Network Programming <networkprogramming.ca.html>`_

31. `Of Zeros and Nulls <zeros.ca.html>`_

32. `Debugging <debugging.ca.html>`_

33. `Options <options.ca.html>`_

34. `Gotchas <gotchas.ca.html>`_

35. `Scripting With Style <scrstyle.ca.html>`_

36. `Miscellany <miscellany.ca.html>`_

37. `Bash, versions 2, 3, and 4 <bash2.ca.html>`_

38. `Endnotes <endnotes.ca.html>`_

38.1. `Author's Note <authorsnote.ca.html>`_

38.2. `About the Author <aboutauthor.ca.html>`_

38.3. `Where to Go For Help <wherehelp.ca.html>`_

38.4. `Tools Used to Produce This Book <toolsused.ca.html>`_

38.5. `Credits <credits.ca.html>`_

38.6. `Disclaimer <disclaimer.ca.html>`_

`Bibliography <biblio.ca.html>`_

A. `Contributed Scripts <contributed-scripts.ca.html>`_

B. `Reference Cards <refcards.ca.html>`_

C. `A Sed and Awk Micro-Primer <sedawk.ca.html>`_

C.1. `Sed <x22929.ca.html>`_

C.2. `Awk <awk.ca.html>`_

D. `Exit Codes With Special Meanings <exitcodes.ca.html>`_

E. `A Detailed Introduction to I/O and I/O
Redirection <ioredirintro.ca.html>`_

F. `Command-Line Options <command-line-options.ca.html>`_

F.1. `Standard Command-Line Options <standard-options.ca.html>`_

F.2. `Bash Command-Line Options <bash-options.ca.html>`_

G. `Important Files <files.ca.html>`_

H. `Important System Directories <systemdirs.ca.html>`_

I. `An Introduction to Programmable Completion <tabexpansion.ca.html>`_

J. `Localization <localization.ca.html>`_

K. `History Commands <histcommands.ca.html>`_

L. `Sample ``.bashrc`` and ``.bash_profile``
Files <sample-bashrc.ca.html>`_

M. `Converting DOS Batch Files to Shell Scripts <dosbatch.ca.html>`_

N. `Exercises <exercises.ca.html>`_

N.1. `Analyzing Scripts <scriptanalysis.ca.html>`_

N.2. `Writing Scripts <writingscripts.ca.html>`_

O. `Revision History <revisionhistory.ca.html>`_

P. `Download and Mirror Sites <mirrorsites.ca.html>`_

Q. `To Do List <todolist.ca.html>`_

R. `Copyright <copyright.ca.html>`_

S. `ASCII Table <asciitable.ca.html>`_

`Index <xrefindex.ca.html>`_

**List of Tables**

8-1. `Operator Precedence <opprecedence.ca.html#AEN4266>`_

15-1. `Job identifiers <x9585.ca.html#JOBIDTABLE>`_

33-1. `Bash options <options.ca.html#AEN19464>`_

36-1. `Numbers representing colors in Escape
Sequences <colorizing.ca.html#AEN20169>`_

B-1. `Special Shell Variables <refcards.ca.html#AEN22165>`_

B-2. `TEST Operators: Binary Comparison <refcards.ca.html#AEN22236>`_

B-3. `TEST Operators: Files <refcards.ca.html#AEN22356>`_

B-4. `Parameter Substitution and Expansion <refcards.ca.html#AEN22491>`_

B-5. `String Operations <refcards.ca.html#AEN22587>`_

B-6. `Miscellaneous Constructs <refcards.ca.html#AEN22738>`_

C-1. `Basic sed operators <x22929.ca.html#AEN22959>`_

C-2. `Examples of sed operators <x22929.ca.html#AEN23023>`_

D-1. `*Reserved* Exit Codes <exitcodes.ca.html#AEN23274>`_

M-1. `Batch file keywords / variables / operators, and their shell
equivalents <dosbatch.ca.html#AEN24059>`_

M-2. `DOS commands and their UNIX equivalents <dosbatch.ca.html#AEN24268>`_

O-1. `Revision History <revisionhistory.ca.html#AEN25087>`_

**List of Examples**

2-1. `*cleanup*: A script to clean up log files in
/var/log <sha-bang.ca.html#EX1>`_

2-2. `*cleanup*: An improved clean-up script <sha-bang.ca.html#EX1A>`_

2-3. `*cleanup*: An enhanced and generalized version of above
scripts. <sha-bang.ca.html#EX2>`_

3-1. `Code blocks and I/O redirection <special-chars.ca.html#EX8>`_

3-2. `Saving the output of a code block to a
file <special-chars.ca.html#RPMCHECK>`_

3-3. `Running a loop in the background <special-chars.ca.html#BGLOOP>`_

3-4. `Backup of all files changed in last
day <special-chars.ca.html#EX58>`_

4-1. `Variable assignment and substitution <varsubn.ca.html#EX9>`_

4-2. `Plain Variable Assignment <varassignment.ca.html#EX15>`_

4-3. `Variable Assignment, plain and fancy <varassignment.ca.html#EX16>`_

4-4. `Integer or string? <untyped.ca.html#INTORSTRING>`_

4-5. `Positional Parameters <othertypesv.ca.html#EX17>`_

4-6. `*wh*, *whois* domain name lookup <othertypesv.ca.html#EX18>`_

4-7. `Using *shift* <othertypesv.ca.html#EX19>`_

5-1. `Echoing Weird Variables <quotingvar.ca.html#WEIRDVARS>`_

5-2. `Escaped Characters <escapingsection.ca.html#ESCAPED>`_

5-3. `Detecting key-presses <escapingsection.ca.html#BASHEK>`_

6-1. `exit / exit status <exit-status.ca.html#EX5>`_

6-2. `Negating a condition using ! <exit-status.ca.html#NEGCOND>`_

7-1. `What is truth? <testconstructs.ca.html#EX10>`_

7-2. `Equivalence of *test*, ``/usr/bin/test``, [ ], and
``/usr/bin/[`` <testconstructs.ca.html#EX11>`_

7-3. `Arithmetic Tests using (( )) <testconstructs.ca.html#ARITHTESTS>`_

7-4. `Testing for broken links <fto.ca.html#BROKENLINK>`_

7-5. `Arithmetic and string comparisons <comparison-ops.ca.html#EX13>`_

7-6. `Testing whether a string is *null* <comparison-ops.ca.html#STRTEST>`_

7-7. `*zmore* <comparison-ops.ca.html#EX14>`_

8-1. `Greatest common divisor <ops.ca.html#GCD>`_

8-2. `Using Arithmetic Operations <ops.ca.html#ARITHOPS>`_

8-3. `Compound Condition Tests Using && and \|\| <ops.ca.html#ANDOR>`_

8-4. `Representation of numerical
constants <numerical-constants.ca.html#NUMBERS>`_

8-5. `C-style manipulation of variables <dblparens.ca.html#CVARS>`_

9-1. `$IFS and whitespace <internalvariables.ca.html#IFSH>`_

9-2. `Timed Input <internalvariables.ca.html#TMDIN>`_

9-3. `Once more, timed input <internalvariables.ca.html#TIMEOUT>`_

9-4. `Timed *read* <internalvariables.ca.html#TOUT>`_

9-5. `Am I root? <internalvariables.ca.html#AMIROOT>`_

9-6. `*arglist*: Listing arguments with $\* and
$@ <internalvariables.ca.html#ARGLIST>`_

9-7. `Inconsistent ``$*`` and ``$@``
behavior <internalvariables.ca.html#INCOMPAT>`_

9-8. ```$*`` and ``$@`` when ``$IFS`` is
empty <internalvariables.ca.html#IFSEMPTY>`_

9-9. `Underscore variable <internalvariables.ca.html#USCREF>`_

9-10. `Using *declare* to type variables <declareref.ca.html#EX20>`_

9-11. `Generating random numbers <randomvar.ca.html#EX21>`_

9-12. `Picking a random card from a deck <randomvar.ca.html#PICKCARD>`_

9-13. `Brownian Motion Simulation <randomvar.ca.html#BROWNIAN>`_

9-14. `Random between values <randomvar.ca.html#RANDOMBETWEEN>`_

9-15. `Rolling a single die with RANDOM <randomvar.ca.html#RANDOMTEST>`_

9-16. `Reseeding RANDOM <randomvar.ca.html#SEEDINGRANDOM>`_

9-17. `Pseudorandom numbers,
using <randomvar.ca.html#RANDOM2>`_`awk <awk.html#AWKREF>`_

10-1. `Inserting a blank line between paragraphs in a text
file <string-manipulation.ca.html#PARAGRAPHSPACE>`_

10-2. `Generating an 8-character "random"
string <string-manipulation.ca.html#RANDSTRING>`_

10-3. `Converting graphic file formats, with filename
change <string-manipulation.ca.html#CVT>`_

10-4. `Converting streaming audio files to
*ogg* <string-manipulation.ca.html#RA2OGG>`_

10-5. `Emulating *getopt* <string-manipulation.ca.html#GETOPTSIMPLE>`_

10-6. `Alternate ways of extracting and locating
substrings <string-manipulation.ca.html#SUBSTRINGEX>`_

10-7. `Using parameter substitution and error
messages <parameter-substitution.ca.html#EX6>`_

10-8. `Parameter substitution and "usage"
messages <parameter-substitution.ca.html#USAGEMESSAGE>`_

10-9. `Length of a variable <parameter-substitution.ca.html#LENGTH>`_

10-10. `Pattern matching in parameter
substitution <parameter-substitution.ca.html#PATTMATCHING>`_

10-11. `Renaming file extensions: <parameter-substitution.ca.html#RFE>`_

10-12. `Using pattern matching to parse arbitrary
strings <parameter-substitution.ca.html#EX7>`_

10-13. `Matching patterns at prefix or suffix of
string <parameter-substitution.ca.html#VARMATCH>`_

11-1. `Simple *for* loops <loops1.ca.html#EX22>`_

11-2. `*for* loop with two parameters in each [list]
element <loops1.ca.html#EX22A>`_

11-3. `*Fileinfo:* operating on a file list contained in a
variable <loops1.ca.html#FILEINFO>`_

11-4. `Operating on files with a *for* loop <loops1.ca.html#LISTGLOB>`_

11-5. `Missing ``in [list]`` in a *for* loop <loops1.ca.html#EX23>`_

11-6. `Generating the ``[list]`` in a *for* loop with command
substitution <loops1.ca.html#FORLOOPCMD>`_

11-7. `A *grep* replacement for binary files <loops1.ca.html#BINGREP>`_

11-8. `Listing all users on the system <loops1.ca.html#USERLIST>`_

11-9. `Checking all the binaries in a directory for
authorship <loops1.ca.html#FINDSTRING>`_

11-10. `Listing the *symbolic links* in a
directory <loops1.ca.html#SYMLINKS>`_

11-11. `Symbolic links in a directory, saved to a
file <loops1.ca.html#SYMLINKS2>`_

11-12. `A C-style *for* loop <loops1.ca.html#FORLOOPC>`_

11-13. `Using *efax* in batch mode <loops1.ca.html#EX24>`_

11-14. `Simple *while* loop <loops1.ca.html#EX25>`_

11-15. `Another *while* loop <loops1.ca.html#EX26>`_

11-16. `*while* loop with multiple conditions <loops1.ca.html#EX26A>`_

11-17. `C-style syntax in a *while* loop <loops1.ca.html#WHLOOPC>`_

11-18. `*until* loop <loops1.ca.html#EX27>`_

11-19. `Nested Loop <nestedloops.ca.html#NESTEDLOOP>`_

11-20. `Effects of *break* and **continue** in a
loop <loopcontrol.ca.html#EX28>`_

11-21. `Breaking out of multiple loop
levels <loopcontrol.ca.html#BREAKLEVELS>`_

11-22. `Continuing at a higher loop
level <loopcontrol.ca.html#CONTINUELEVELS>`_

11-23. `Using *continue N* in an actual
task <loopcontrol.ca.html#CONTINUENEX>`_

11-24. `Using *case* <testbranch.ca.html#EX29>`_

11-25. `Creating menus using *case* <testbranch.ca.html#EX30>`_

11-26. `Using *command substitution* to generate the *case*
variable <testbranch.ca.html#CASECMD>`_

11-27. `Simple string matching <testbranch.ca.html#MATCHSTRING>`_

11-28. `Checking for alphabetic input <testbranch.ca.html#ISALPHA>`_

11-29. `Creating menus using *select* <testbranch.ca.html#EX31>`_

11-30. `Creating menus using *select* in a
function <testbranch.ca.html#EX32>`_

12-1. `Stupid script tricks <commandsub.ca.html#STUPSCR>`_

12-2. `Generating a variable from a loop <commandsub.ca.html#CSUBLOOP>`_

12-3. `Finding anagrams <commandsub.ca.html#AGRAM2>`_

15-1. `A script that spawns multiple instances of
itself <internal.ca.html#SPAWNSCR>`_

15-2. `*printf* in action <internal.ca.html#EX47>`_

15-3. `Variable assignment, using *read* <internal.ca.html#EX36>`_

15-4. `What happens when *read* has no
variable <internal.ca.html#READNOVAR>`_

15-5. `Multi-line input to *read* <internal.ca.html#READR>`_

15-6. `Detecting the arrow keys <internal.ca.html#ARROWDETECT>`_

15-7. `Using *read* with <internal.ca.html#READREDIR>`_`file
redirection <io-redirection.ca.html#IOREDIRREF>`_

15-8. `Problems reading from a pipe <internal.ca.html#READPIPE>`_

15-9. `Changing the current working directory <internal.ca.html#EX37>`_

15-10. `Letting *let* do arithmetic. <internal.ca.html#EX46>`_

15-11. `Showing the effect of *eval* <internal.ca.html#EX43>`_

15-12. `Using *eval* to select among
variables <internal.ca.html#ARRCHOICE>`_

15-13. `*Echoing* the *command-line
parameters* <internal.ca.html#ECHOPARAMS>`_

15-14. `Forcing a log-off <internal.ca.html#EX44>`_

15-15. `A version of *rot13* <internal.ca.html#ROT14>`_

15-16. `Using *set* with positional parameters <internal.ca.html#EX34>`_

15-17. `Reversing the positional
parameters <internal.ca.html#REVPOSPARAMS>`_

15-18. `Reassigning the positional parameters <internal.ca.html#SETPOS>`_

15-19. `"Unsetting" a variable <internal.ca.html#UNS>`_

15-20. `Using *export* to pass a variable to an embedded *awk*
script <internal.ca.html#COLTOTALER3>`_

15-21. `Using *getopts* to read the options/arguments passed to a
script <internal.ca.html#EX33>`_

15-22. `"Including" a data file <internal.ca.html#EX38>`_

15-23. `A (useless) script that sources
itself <internal.ca.html#SELFSOURCE>`_

15-24. `Effects of *exec* <internal.ca.html#EX54>`_

15-25. `A script that *exec's* itself <internal.ca.html#SELFEXEC>`_

15-26. `Waiting for a process to finish before
proceeding <x9585.ca.html#EX39>`_

15-27. `A script that kills itself <x9585.ca.html#SELFDESTRUCT>`_

16-1. `Using *ls* to create a table of contents for burning a CDR
disk <basic.ca.html#EX40>`_

16-2. `Hello or Good-bye <basic.ca.html#HELLOL>`_

16-3. `*Badname*, eliminate file names in current directory containing
bad characters
and <moreadv.ca.html#EX57>`_`whitespace <special-chars.html#WHITESPACEREF>`_.

16-4. `Deleting a file by its *inode* number <moreadv.ca.html#IDELETE>`_

16-5. `Logfile: Using *xargs* to monitor system
log <moreadv.ca.html#EX41>`_

16-6. `Copying files in current directory to
another <moreadv.ca.html#EX42>`_

16-7. `Killing processes by name <moreadv.ca.html#KILLBYNAME>`_

16-8. `Word frequency analysis using *xargs* <moreadv.ca.html#WF2>`_

16-9. `Using *expr* <moreadv.ca.html#EX45>`_

16-10. `Using *date* <timedate.ca.html#EX51>`_

16-11. `*Date* calculations <timedate.ca.html#DATECALC>`_

16-12. `Word Frequency Analysis <textproc.ca.html#WF>`_

16-13. `Which files are scripts? <textproc.ca.html#SCRIPTDETECTOR>`_

16-14. `Generating 10-digit random numbers <textproc.ca.html#RND>`_

16-15. `Using *tail* to monitor the system log <textproc.ca.html#EX12>`_

16-16. `Printing out the *From* lines in stored e-mail
messages <textproc.ca.html#FROMSH>`_

16-17. `Emulating *grep* in a script <textproc.ca.html#GRP>`_

16-18. `Crossword puzzle solver <textproc.ca.html#CWSOLVER>`_

16-19. `Looking up definitions in Webster's 1913
Dictionary <textproc.ca.html#DICTLOOKUP>`_

16-20. `Checking words in a list for validity <textproc.ca.html#LOOKUP>`_

16-21. `*toupper*: Transforms a file to all
uppercase. <textproc.ca.html#EX49>`_

16-22. `*lowercase*: Changes all filenames in working directory to
lowercase. <textproc.ca.html#LOWERCASE>`_

16-23. `*du*: DOS to UNIX text file conversion. <textproc.ca.html#DU>`_

16-24. `*rot13*: ultra-weak encryption. <textproc.ca.html#ROT13>`_

16-25. `Generating "Crypto-Quote" Puzzles <textproc.ca.html#CRYPTOQUOTE>`_

16-26. `Formatted file listing. <textproc.ca.html#EX50>`_

16-27. `Using *column* to format a directory
listing <textproc.ca.html#COL>`_

16-28. `*nl*: A self-numbering script. <textproc.ca.html#LNUM>`_

16-29. `*manview*: Viewing formatted manpages <textproc.ca.html#MANVIEW>`_

16-30. `Using *cpio* to move a directory tree <filearchiv.ca.html#EX48>`_

16-31. `Unpacking an *rpm* archive <filearchiv.ca.html#DERPM>`_

16-32. `Stripping comments from C program
files <filearchiv.ca.html#STRIPC>`_

16-33. `Exploring ``/usr/X11R6/bin`` <filearchiv.ca.html#WHAT>`_

16-34. `An "improved" *strings* command <filearchiv.ca.html#WSTRINGS>`_

16-35. `Using *cmp* to compare two files within a
script. <filearchiv.ca.html#FILECOMP>`_

16-36. `*basename* and *dirname* <filearchiv.ca.html#EX35>`_

16-37. `A script that copies itself in
sections <filearchiv.ca.html#SPLITCOPY>`_

16-38. `Checking file integrity <filearchiv.ca.html#FILEINTEGRITY>`_

16-39. `Uudecoding encoded files <filearchiv.ca.html#EX52>`_

16-40. `Finding out where to report a
spammer <communications.ca.html#SPAMLOOKUP>`_

16-41. `Analyzing a spam domain <communications.ca.html#ISSPAMMER>`_

16-42. `Getting a stock quote <communications.ca.html#QUOTEFETCH>`_

16-43. `Updating FC4 <communications.ca.html#FC4UPD>`_

16-44. `Using *ssh* <communications.ca.html#REMOTE>`_

16-45. `A script that mails itself <communications.ca.html#SELFMAILER>`_

16-46. `Generating prime numbers <mathc.ca.html#PRIMES2>`_

16-47. `Monthly Payment on a Mortgage <mathc.ca.html#MONTHLYPMT>`_

16-48. `Base Conversion <mathc.ca.html#BASE>`_

16-49. `Invoking *bc* using a *here document* <mathc.ca.html#ALTBC>`_

16-50. `Calculating PI <mathc.ca.html#CANNON>`_

16-51. `Converting a decimal number to
hexadecimal <mathc.ca.html#HEXCONVERT>`_

16-52. `Factoring <mathc.ca.html#FACTR>`_

16-53. `Calculating the hypotenuse of a triangle <mathc.ca.html#HYPOT>`_

16-54. `Using *seq* to generate loop arguments <extmisc.ca.html#EX53>`_

16-55. `Letter Count" <extmisc.ca.html#LETTERCOUNT>`_

16-56. `Using *getopt* to parse command-line
options <extmisc.ca.html#EX33A>`_

16-57. `A script that copies itself <extmisc.ca.html#SELFCOPY>`_

16-58. `Exercising *dd* <extmisc.ca.html#EXERCISINGDD>`_

16-59. `Capturing Keystrokes <extmisc.ca.html#DDKEYPRESS>`_

16-60. `Securely deleting a file <extmisc.ca.html#BLOTOUT>`_

16-61. `Filename generator <extmisc.ca.html#TEMPFILENAME>`_

16-62. `Converting meters to miles <extmisc.ca.html#UNITCONVERSION>`_

16-63. `Using *m4* <extmisc.ca.html#M4>`_

17-1. `Setting a new password <system.ca.html#SETNEWPW>`_

17-2. `Setting an *erase* character <system.ca.html#ERASE>`_

17-3. `*secret password*: Turning off terminal
echoing <system.ca.html#SECRETPW>`_

17-4. `Keypress detection <system.ca.html#KEYPRESS>`_

17-5. `Checking a remote server for *identd* <system.ca.html#ISCAN>`_

17-6. `*pidof* helps kill a process <system.ca.html#KILLPROCESS>`_

17-7. `Checking a CD image <system.ca.html#ISOMOUNTREF>`_

17-8. `Creating a filesystem in a file <system.ca.html#CREATEFS>`_

17-9. `Adding a new hard drive <system.ca.html#ADDDRV>`_

17-10. `Using *umask* to hide an output file from prying
eyes <system.ca.html#ROT13A>`_

17-11. `*Backlight*: changes the brightness of the (laptop) screen
backlight <system.ca.html#BACKLIGHT>`_

17-12. `*killall*, from ``/etc/rc.d/init.d`` <sysscripts.ca.html#EX55>`_

19-1. `*broadcast*: Sends message to everyone logged
in <here-docs.ca.html#EX70>`_

19-2. `*dummyfile*: Creates a 2-line dummy file <here-docs.ca.html#EX69>`_

19-3. `Multi-line message using *cat* <here-docs.ca.html#EX71>`_

19-4. `Multi-line message, with tabs suppressed <here-docs.ca.html#EX71A>`_

19-5. `Here document with replaceable
parameters <here-docs.ca.html#EX71B>`_

19-6. `Upload a file pair to *Sunsite* incoming
directory <here-docs.ca.html#EX72>`_

19-7. `Parameter substitution turned off <here-docs.ca.html#EX71C>`_

19-8. `A script that generates another
script <here-docs.ca.html#GENERATESCRIPT>`_

19-9. `Here documents and functions <here-docs.ca.html#HF>`_

19-10. `"Anonymous" Here Document <here-docs.ca.html#ANONHEREDOC>`_

19-11. `Commenting out a block of code <here-docs.ca.html#COMMENTBLOCK>`_

19-12. `A self-documenting script <here-docs.ca.html#SELFDOCUMENT>`_

19-13. `Prepending a line to a file <x17700.ca.html#PREPENDEX>`_

19-14. `Parsing a mailbox <x17700.ca.html#MAILBOXGREP>`_

20-1. `Redirecting ``stdin`` using *exec* <x17837.ca.html#REDIR1>`_

20-2. `Redirecting ``stdout`` using
*exec* <x17837.ca.html#REASSIGNSTDOUT>`_

20-3. `Redirecting both ``stdin`` and ``stdout`` in the same script with
*exec* <x17837.ca.html#UPPERCONV>`_

20-4. `Avoiding a subshell <x17837.ca.html#AVOIDSUBSHELL>`_

20-5. `Redirected *while* loop <redircb.ca.html#REDIR2>`_

20-6. `Alternate form of redirected *while*
loop <redircb.ca.html#REDIR2A>`_

20-7. `Redirected *until* loop <redircb.ca.html#REDIR3>`_

20-8. `Redirected *for* loop <redircb.ca.html#REDIR4>`_

20-9. `Redirected *for* loop (both ``stdin`` and ``stdout``
redirected) <redircb.ca.html#REDIR4A>`_

20-10. `Redirected *if/then* test <redircb.ca.html#REDIR5>`_

20-11. `Data file *names.data* for above
examples <redircb.ca.html#NAMESDATA>`_

20-12. `Logging events <redirapps.ca.html#LOGEVENTS>`_

21-1. `Variable scope in a subshell <subshells.ca.html#SUBSHELL>`_

21-2. `List User Profiles <subshells.ca.html#ALLPROFS>`_

21-3. `Running parallel processes in
subshells <subshells.ca.html#PARALLEL-PROCESSES>`_

22-1. `Running a script in restricted
mode <restricted-sh.ca.html#RESTRICTED>`_

23-1. `Code block redirection without forking <process-sub.ca.html#WRPS>`_

23-2. `Redirecting the output of *process substitution* into a
loop. <process-sub.ca.html#PSUBP>`_

24-1. `Simple functions <functions.ca.html#EX59>`_

24-2. `Function Taking Parameters <complexfunct.ca.html#EX60>`_

24-3. `Functions and command-line args passed to the
script <complexfunct.ca.html#FUNCCMDLINEARG>`_

24-4. `Passing an indirect reference to a
function <complexfunct.ca.html#INDFUNC>`_

24-5. `Dereferencing a parameter passed to a
function <complexfunct.ca.html#DEREFERENCECL>`_

24-6. `Again, dereferencing a parameter passed to a
function <complexfunct.ca.html#REFPARAMS>`_

24-7. `Maximum of two numbers <complexfunct.ca.html#MAX>`_

24-8. `Converting numbers to Roman numerals <complexfunct.ca.html#EX61>`_

24-9. `Testing large return values in a
function <complexfunct.ca.html#RETURNTEST>`_

24-10. `Comparing two large integers <complexfunct.ca.html#MAX2>`_

24-11. `Real name from username <complexfunct.ca.html#REALNAME>`_

24-12. `Local variable visibility <localvar.ca.html#EX62>`_

24-13. `Demonstration of a simple recursive
function <localvar.ca.html#RECURSIONDEMO>`_

24-14. `Another simple demonstration <localvar.ca.html#RECURSIONDEMO2>`_

24-15. `Recursion, using a local variable <localvar.ca.html#EX63>`_

24-16. `*The Fibonacci Sequence* <recurnolocvar.ca.html#FIBO>`_

24-17. `*The Towers of Hanoi* <recurnolocvar.ca.html#HANOI>`_

25-1. `Aliases within a script <aliases.ca.html#AL>`_

25-2. `*unalias*: Setting and unsetting an alias <aliases.ca.html#UNAL>`_

26-1. `Using an *and list* to test for command-line
arguments <list-cons.ca.html#EX64>`_

26-2. `Another command-line arg test using an *and
list* <list-cons.ca.html#ANDLIST2>`_

26-3. `Using *or lists* in combination with an *and
list* <list-cons.ca.html#EX65>`_

27-1. `Simple array usage <arrays.ca.html#EX66>`_

27-2. `Formatting a poem <arrays.ca.html#POEM>`_

27-3. `Various array operations <arrays.ca.html#ARRAYOPS>`_

27-4. `String operations on arrays <arrays.ca.html#ARRAYSTROPS>`_

27-5. `Loading the contents of a script into an
array <arrays.ca.html#SCRIPTARRAY>`_

27-6. `Some special properties of arrays <arrays.ca.html#EX67>`_

27-7. `Of empty arrays and empty elements <arrays.ca.html#EMPTYARRAY>`_

27-8. `Initializing arrays <arrays.ca.html#ARRAYASSIGN>`_

27-9. `Copying and concatenating arrays <arrays.ca.html#COPYARRAY>`_

27-10. `More on concatenating arrays <arrays.ca.html#ARRAYAPPEND>`_

27-11. `The Bubble Sort <arrays.ca.html#BUBBLE>`_

27-12. `Embedded arrays and indirect references <arrays.ca.html#EMBARR>`_

27-13. `The Sieve of Eratosthenes <arrays.ca.html#EX68>`_

27-14. `The Sieve of Eratosthenes, Optimized <arrays.ca.html#EX68A>`_

27-15. `Emulating a push-down stack <arrays.ca.html#STACKEX>`_

27-16. `Complex array application: *Exploring a weird mathematical
series* <arrays.ca.html#QFUNCTION>`_

27-17. `Simulating a two-dimensional array, then tilting
it <arrays.ca.html#TWODIM>`_

28-1. `Indirect Variable References <ivr.ca.html#INDREF>`_

28-2. `Passing an indirect reference to *awk* <ivr.ca.html#COLTOTALER2>`_

29-1. `Using ``/dev/tcp`` for troubleshooting <devref1.ca.html#DEVTCP>`_

29-2. `Playing music <devref1.ca.html#MUSICSCR>`_

29-3. `Finding the process associated with a PID <procref1.ca.html#PIDID>`_

29-4. `On-line connect status <procref1.ca.html#CONSTAT>`_

30-1. `Print the server environment <networkprogramming.ca.html#TESTCGI>`_

30-2. `IP addresses <networkprogramming.ca.html#IPADDRESSES>`_

31-1. `Hiding the cookie jar <zeros.ca.html#COOKIES>`_

31-2. `Setting up a swapfile using ``/dev/zero`` <zeros.ca.html#EX73>`_

31-3. `Creating a ramdisk <zeros.ca.html#RAMDISK>`_

32-1. `A buggy script <debugging.ca.html#EX74>`_

32-2.
`Missing <debugging.ca.html#MISSINGKEYWORD>`_`keyword <internal.html#KEYWORDREF>`_

32-3. `*test24*: another buggy script <debugging.ca.html#EX75>`_

32-4. `Testing a condition with an *assert* <debugging.ca.html#ASSERT>`_

32-5. `Trapping at exit <debugging.ca.html#EX76>`_

32-6. `Cleaning up after **Control-C** <debugging.ca.html#ONLINE>`_

32-7. `A Simple Implementation of a Progress
Bar <debugging.ca.html#PROGRESSBAR2>`_

32-8. `Tracing a variable <debugging.ca.html#VARTRACE>`_

32-9. `Running multiple processes (on an SMP
box) <debugging.ca.html#MULTIPLEPROC>`_

34-1. `Numerical and string comparison are not
equivalent <gotchas.ca.html#BADOP>`_

34-2. `Subshell Pitfalls <gotchas.ca.html#SUBPIT>`_

34-3. `Piping the output of *echo* to a *read* <gotchas.ca.html#BADREAD>`_

36-1. `*shell wrapper* <wrapper.ca.html#EX3>`_

36-2. `A slightly more complex *shell wrapper* <wrapper.ca.html#EX4>`_

36-3. `A generic *shell wrapper* that writes to a
logfile <wrapper.ca.html#LOGGINGWRAPPER>`_

36-4. `A *shell wrapper* around an awk script <wrapper.ca.html#PRASC>`_

36-5. `A *shell wrapper* around another awk
script <wrapper.ca.html#COLTOTALER>`_

36-6. `Perl embedded in a *Bash* script <wrapper.ca.html#EX56>`_

36-7. `Bash and Perl scripts combined <wrapper.ca.html#BASHANDPERL>`_

36-8. `A (useless) script that recursively calls
itself <recursionsct.ca.html#RECURSE>`_

36-9. `A (useful) script that recursively calls
itself <recursionsct.ca.html#PBOOK>`_

36-10. `Another (useful) script that recursively calls
itself <recursionsct.ca.html#USRMNT>`_

36-11. `A "colorized" address database <colorizing.ca.html#EX30A>`_

36-12. `Drawing a box <colorizing.ca.html#DRAW-BOX>`_

36-13. `Echoing colored text <colorizing.ca.html#COLORECHO>`_

36-14. `A "horserace" game <colorizing.ca.html#HORSERACE>`_

36-15. `A Progress Bar <assortedtips.ca.html#PROGRESSBAR>`_

36-16. `Return value trickery <assortedtips.ca.html#MULTIPLICATION>`_

36-17. `Even more return value trickery <assortedtips.ca.html#SUMPRODUCT>`_

36-18. `Passing and returning arrays <assortedtips.ca.html#ARRFUNC>`_

36-19. `Fun with anagrams <assortedtips.ca.html#AGRAM>`_

36-20. `Widgets invoked from a shell script <assortedtips.ca.html#DIALOG>`_

36-21. `Test Suite <portabilityissues.ca.html#TESTSUITE>`_

37-1. `String expansion <bashver2.ca.html#EX77>`_

37-2. `Indirect variable references - the new way <bashver2.ca.html#EX78>`_

37-3. `Simple database application, using indirect variable
referencing <bashver2.ca.html#RESISTOR>`_

37-4. `Using arrays and other miscellaneous trickery to deal four random
hands from a deck of cards <bashver2.ca.html#CARDS>`_

37-5. `A simple address database <bashver4.ca.html#FETCHADDRESS>`_

37-6. `A somewhat more elaborate address
database <bashver4.ca.html#FETCHADDRESS2>`_

37-7. `Testing characters <bashver4.ca.html#CASE4>`_

37-8. `Reading N characters <bashver4.ca.html#READN>`_

37-9. `Using a *here document* to set a
variable <bashver4.ca.html#HERECOMMSUB>`_

37-10. `Piping input to
a <bashver4.ca.html#LASTPIPEOPT>`_`read <internal.html#READREF>`_

37-11. `Negative array indices <bashver4.ca.html#NEGARRAY>`_

37-12. `Negative parameter in string-extraction
construct <bashver4.ca.html#NEGOFFSET>`_

A-1. `*mailformat*: Formatting an e-mail
message <contributed-scripts.ca.html#MAILFORMAT>`_

A-2. `*rn*: A simple-minded file renaming
utility <contributed-scripts.ca.html#RN>`_

A-3. `*blank-rename*: Renames filenames containing
blanks <contributed-scripts.ca.html#BLANKRENAME>`_

A-4. `*encryptedpw*: Uploading to an ftp site, using a locally encrypted
password <contributed-scripts.ca.html#ENCRYPTEDPW>`_

A-5. `*copy-cd*: Copying a data CD <contributed-scripts.ca.html#COPYCD>`_

A-6. `Collatz series <contributed-scripts.ca.html#COLLATZ>`_

A-7. `*days-between*: Days between two
dates <contributed-scripts.ca.html#DAYSBETWEEN>`_

A-8. `Making a *dictionary* <contributed-scripts.ca.html#MAKEDICT>`_

A-9. `Soundex conversion <contributed-scripts.ca.html#SOUNDEX>`_

A-10. `*Game of Life* <contributed-scripts.ca.html#LIFESLOW>`_

A-11. `Data file for *Game of
Life* <contributed-scripts.ca.html#GEN0DATA>`_

A-12. `*behead*: Removing mail and news message
headers <contributed-scripts.ca.html#BEHEAD>`_

A-13. `*password*: Generating random 8-character
passwords <contributed-scripts.ca.html#PW>`_

A-14. `*fifo*: Making daily backups, using named
pipes <contributed-scripts.ca.html#FIFO>`_

A-15. `Generating prime numbers using the modulo
operator <contributed-scripts.ca.html#PRIMES>`_

A-16. `*tree*: Displaying a directory
tree <contributed-scripts.ca.html#TREE>`_

A-17. `*tree2*: Alternate directory tree
script <contributed-scripts.ca.html#TREE2>`_

A-18. `*string functions*: C-style string
functions <contributed-scripts.ca.html#STRING>`_

A-19. `Directory information <contributed-scripts.ca.html#DIRECTORYINFO>`_

A-20. `Library of hash functions <contributed-scripts.ca.html#HASHLIB>`_

A-21. `Colorizing text using hash
functions <contributed-scripts.ca.html#HASHEXAMPLE>`_

A-22. `More on hash functions <contributed-scripts.ca.html#HASHEX2>`_

A-23. `Mounting USB keychain storage
devices <contributed-scripts.ca.html#USBINST>`_

A-24. `Converting to HTML <contributed-scripts.ca.html#TOHTML>`_

A-25. `Preserving weblogs <contributed-scripts.ca.html#ARCHIVWEBLOGS>`_

A-26. `Protecting literal
strings <contributed-scripts.ca.html#PROTECTLITERAL>`_

A-27. `Unprotecting literal
strings <contributed-scripts.ca.html#UNPROTECTLITERAL>`_

A-28. `Spammer Identification <contributed-scripts.ca.html#ISSPAMMER2>`_

A-29. `Spammer Hunt <contributed-scripts.ca.html#WHX>`_

A-30. `Making *wget* easier to use <contributed-scripts.ca.html#WGETTER2>`_

A-31. `A *podcasting* script <contributed-scripts.ca.html#BASHPODDER>`_

A-32. `Nightly backup to a firewire
HD <contributed-scripts.ca.html#NIGHTLYBACKUP>`_

A-33. `An expanded *cd* command <contributed-scripts.ca.html#CDLL>`_

A-34. `A soundcard setup script <contributed-scripts.ca.html#SOUNDCARDON>`_

A-35. `Locating split paragraphs in a text
file <contributed-scripts.ca.html#FINDSPLIT>`_

A-36. `Insertion sort <contributed-scripts.ca.html#INSERTIONSORT>`_

A-37. `Standard Deviation <contributed-scripts.ca.html#STDDEV>`_

A-38. `A *pad* file generator for shareware
authors <contributed-scripts.ca.html#PADSW>`_

A-39. `A *man page* editor <contributed-scripts.ca.html#MANED>`_

A-40. `Petals Around the Rose <contributed-scripts.ca.html#PETALS>`_

A-41. `Quacky: a Perquackey-type word
game <contributed-scripts.ca.html#QKY>`_

A-42. `Nim <contributed-scripts.ca.html#NIM>`_

A-43. `A command-line stopwatch <contributed-scripts.ca.html#STOPWATCH>`_

A-44. `An all-purpose shell scripting homework assignment
solution <contributed-scripts.ca.html#HOMEWORK>`_

A-45. `The Knight's Tour <contributed-scripts.ca.html#KTOUR>`_

A-46. `Magic Squares <contributed-scripts.ca.html#MSQUARE>`_

A-47. `Fifteen Puzzle <contributed-scripts.ca.html#FIFTEEN>`_

A-48. `*The Towers of Hanoi, graphic
version* <contributed-scripts.ca.html#HANOI2>`_

A-49. `*The Towers of Hanoi, alternate graphic
version* <contributed-scripts.ca.html#HANOI2A>`_

A-50. `An alternate version of
the <contributed-scripts.ca.html#USEGETOPT>`_`getopt-simple.sh <string-manipulation.html#GETOPTSIMPLE>`_
script

A-51. `The version of the *UseGetOpt.sh* example used in
the <contributed-scripts.ca.html#USEGETOPT2>`_`Tab Expansion
appendix <tabexpansion.ca.html>`_

A-52. `Cycling through all the possible color
backgrounds <contributed-scripts.ca.html#SHOWALLC>`_

A-53. `Morse Code Practice <contributed-scripts.ca.html#SAMORSE>`_

A-54. `Base64 encoding/decoding <contributed-scripts.ca.html#BASE64>`_

A-55. `The Gronsfeld Cipher <contributed-scripts.ca.html#GRONSFELD>`_

A-56. `Basics Reviewed <contributed-scripts.ca.html#BASICSREVIEWED>`_

C-1. `Counting Letter Occurrences <awk.ca.html#LETTERCOUNT2>`_

I-1. `Completion script for
*UseGetOpt.sh* <tabexpansion.ca.html#USEGETOPTEX>`_

L-1. `Sample ``.bashrc`` file <sample-bashrc.ca.html#BASHRC>`_

L-2. ```.bash_profile`` file <sample-bashrc.ca.html#BASHPROF>`_

M-1. `VIEWDATA.BAT: DOS Batch File <dosbatch.ca.html#VIEWDAT>`_

M-2. `*viewdata.sh*: Shell Script Conversion of
VIEWDATA.BAT <dosbatch.ca.html#VIEWDATA>`_

S-1. `A script that generates an ASCII table <asciitable.ca.html#ASCIISH>`_

----------


`Següent <part1.ca.html>`_ : Comandes de processament de text

