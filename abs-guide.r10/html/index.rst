Advanced Bash-Scripting Guide
=============================

An in-depth exploration of the art of shell scripting
-----------------------------------------------------

Mendel Cooper
~~~~~~~~~~~~~

| 

``<thegrendel.abs@gmail.com>``

| 10

| 10 Mar 2014

**Revision History**

Revision 6.5

05 Apr 2012

Revised by: mc

'TUNGSTENBERRY' release

Revision 6.6

27 Nov 2012

Revised by: mc

'YTTERBIUMBERRY' release

Revision 10

10 Mar 2014

Revised by: mc

'PUBLICDOMAIN' release

This tutorial assumes no previous knowledge of scripting or programming,
yet progresses rapidly toward an intermediate/advanced level of
instruction *. . . all the while sneaking in little nuggets of UNIX®
wisdom and lore*. It serves as a textbook, a manual for self-study, and
as a reference and source of knowledge on shell scripting techniques.
The exercises and heavily-commented examples invite active reader
participation, under the premise that
``the only way to really learn     scripting is to write scripts``.

This book is suitable for classroom use as a general introduction to
programming concepts.

This document is herewith granted to the Public Domain.
``No copyright!``

--------------

Dedication
==========

For Anita, the source of all the magic

**Table of Contents**

Part 1. `Introduction <part1.html>`__

1. `Shell Programming! <why-shell.html>`__

2. `Starting Off With a Sha-Bang <sha-bang.html>`__

Part 2. `Basics <part2.html>`__

3. `Special Characters <special-chars.html>`__

4. `Introduction to Variables and Parameters <variables.html>`__

5. `Quoting <quoting.html>`__

6. `Exit and Exit Status <exit-status.html>`__

7. `Tests <tests.html>`__

8. `Operations and Related Topics <operations.html>`__

Part 3. `Beyond the Basics <part3.html>`__

9. `Another Look at Variables <variables2.html>`__

10. `Manipulating Variables <manipulatingvars.html>`__

11. `Loops and Branches <loops.html>`__

12. `Command Substitution <commandsub.html>`__

13. `Arithmetic Expansion <arithexp.html>`__

14. `Recess Time <recess-time.html>`__

Part 4. `Commands <part4.html>`__

15. `Internal Commands and Builtins <internal.html>`__

16. `External Filters, Programs and Commands <external.html>`__

17. `System and Administrative Commands <system.html>`__

Part 5. `Advanced Topics <part5.html>`__

18. `Regular Expressions <regexp.html>`__

19. `Here Documents <here-docs.html>`__

20. `I/O Redirection <io-redirection.html>`__

21. `Subshells <subshells.html>`__

22. `Restricted Shells <restricted-sh.html>`__

23. `Process Substitution <process-sub.html>`__

24. `Functions <functions.html>`__

25. `Aliases <aliases.html>`__

26. `List Constructs <list-cons.html>`__

27. `Arrays <arrays.html>`__

28. `Indirect References <ivr.html>`__

29. ```/dev`` and ``/proc`` <devproc.html>`__

30. `Network Programming <networkprogramming.html>`__

31. `Of Zeros and Nulls <zeros.html>`__

32. `Debugging <debugging.html>`__

33. `Options <options.html>`__

34. `Gotchas <gotchas.html>`__

35. `Scripting With Style <scrstyle.html>`__

36. `Miscellany <miscellany.html>`__

37. `Bash, versions 2, 3, and 4 <bash2.html>`__

38. `Endnotes <endnotes.html>`__

38.1. `Author's Note <authorsnote.html>`__

38.2. `About the Author <aboutauthor.html>`__

38.3. `Where to Go For Help <wherehelp.html>`__

38.4. `Tools Used to Produce This Book <toolsused.html>`__

38.5. `Credits <credits.html>`__

38.6. `Disclaimer <disclaimer.html>`__

`Bibliography <biblio.html>`__

A. `Contributed Scripts <contributed-scripts.html>`__

B. `Reference Cards <refcards.html>`__

C. `A Sed and Awk Micro-Primer <sedawk.html>`__

C.1. `Sed <x23170.html>`__

C.2. `Awk <awk.html>`__

D. `Parsing and Managing Pathnames <pathmanagement.html>`__

E. `Exit Codes With Special Meanings <exitcodes.html>`__

F. `A Detailed Introduction to I/O and I/O
Redirection <ioredirintro.html>`__

G. `Command-Line Options <command-line-options.html>`__

G.1. `Standard Command-Line Options <standard-options.html>`__

G.2. `Bash Command-Line Options <bash-options.html>`__

H. `Important Files <files.html>`__

I. `Important System Directories <systemdirs.html>`__

J. `An Introduction to Programmable Completion <tabexpansion.html>`__

K. `Localization <localization.html>`__

L. `History Commands <histcommands.html>`__

M. `Sample ``.bashrc`` and ``.bash_profile``
Files <sample-bashrc.html>`__

N. `Converting DOS Batch Files to Shell Scripts <dosbatch.html>`__

O. `Exercises <exercises.html>`__

O.1. `Analyzing Scripts <scriptanalysis.html>`__

O.2. `Writing Scripts <writingscripts.html>`__

P. `Revision History <revisionhistory.html>`__

Q. `Download and Mirror Sites <mirrorsites.html>`__

R. `To Do List <todolist.html>`__

S. `Copyright <copyright.html>`__

T. `ASCII Table <asciitable.html>`__

`Index <xrefindex.html>`__

**List of Tables**

8-1. `Operator Precedence <opprecedence.html#AEN4294>`__

15-1. `Job identifiers <x9644.html#JOBIDTABLE>`__

33-1. `Bash options <options.html#AEN19601>`__

36-1. `Numbers representing colors in Escape
Sequences <colorizing.html#AEN20327>`__

B-1. `Special Shell Variables <refcards.html#AEN22402>`__

B-2. `TEST Operators: Binary Comparison <refcards.html#AEN22473>`__

B-3. `TEST Operators: Files <refcards.html#AEN22593>`__

B-4. `Parameter Substitution and Expansion <refcards.html#AEN22728>`__

B-5. `String Operations <refcards.html#AEN22828>`__

B-6. `Miscellaneous Constructs <refcards.html#AEN22979>`__

C-1. `Basic sed operators <x23170.html#AEN23200>`__

C-2. `Examples of sed operators <x23170.html#AEN23271>`__

E-1. `*Reserved* Exit Codes <exitcodes.html#AEN23549>`__

N-1. `Batch file keywords / variables / operators, and their shell
equivalents <dosbatch.html#AEN24336>`__

N-2. `DOS commands and their UNIX
equivalents <dosbatch.html#AEN24545>`__

P-1. `Revision History <revisionhistory.html#AEN25364>`__

**List of Examples**

2-1. `*cleanup*: A script to clean up log files in
/var/log <sha-bang.html#EX1>`__

2-2. `*cleanup*: An improved clean-up script <sha-bang.html#EX1A>`__

2-3. `*cleanup*: An enhanced and generalized version of above
scripts. <sha-bang.html#EX2>`__

3-1. `Code blocks and I/O redirection <special-chars.html#EX8>`__

3-2. `Saving the output of a code block to a
file <special-chars.html#RPMCHECK>`__

3-3. `Running a loop in the background <special-chars.html#BGLOOP>`__

3-4. `Backup of all files changed in last
day <special-chars.html#EX58>`__

4-1. `Variable assignment and substitution <varsubn.html#EX9>`__

4-2. `Plain Variable Assignment <varassignment.html#EX15>`__

4-3. `Variable Assignment, plain and fancy <varassignment.html#EX16>`__

4-4. `Integer or string? <untyped.html#INTORSTRING>`__

4-5. `Positional Parameters <othertypesv.html#EX17>`__

4-6. `*wh*, *whois* domain name lookup <othertypesv.html#EX18>`__

4-7. `Using *shift* <othertypesv.html#EX19>`__

5-1. `Echoing Weird Variables <quotingvar.html#WEIRDVARS>`__

5-2. `Escaped Characters <escapingsection.html#ESCAPED>`__

5-3. `Detecting key-presses <escapingsection.html#BASHEK>`__

6-1. `exit / exit status <exit-status.html#EX5>`__

6-2. `Negating a condition using ! <exit-status.html#NEGCOND>`__

7-1. `What is truth? <testconstructs.html#EX10>`__

7-2. `Equivalence of *test*, ``/usr/bin/test``, [ ], and
``/usr/bin/[`` <testconstructs.html#EX11>`__

7-3. `Arithmetic Tests using (( )) <testconstructs.html#ARITHTESTS>`__

7-4. `Testing for broken links <fto.html#BROKENLINK>`__

7-5. `Arithmetic and string comparisons <comparison-ops.html#EX13>`__

7-6. `Testing whether a string is
*null* <comparison-ops.html#STRTEST>`__

7-7. `*zmore* <comparison-ops.html#EX14>`__

8-1. `Greatest common divisor <ops.html#GCD>`__

8-2. `Using Arithmetic Operations <ops.html#ARITHOPS>`__

8-3. `Compound Condition Tests Using && and \|\| <ops.html#ANDOR>`__

8-4. `Representation of numerical
constants <numerical-constants.html#NUMBERS>`__

8-5. `C-style manipulation of variables <dblparens.html#CVARS>`__

9-1. `$IFS and whitespace <internalvariables.html#IFSH>`__

9-2. `Timed Input <internalvariables.html#TMDIN>`__

9-3. `Once more, timed input <internalvariables.html#TIMEOUT>`__

9-4. `Timed *read* <internalvariables.html#TOUT>`__

9-5. `Am I root? <internalvariables.html#AMIROOT>`__

9-6. `*arglist*: Listing arguments with $\* and
$@ <internalvariables.html#ARGLIST>`__

9-7. `Inconsistent ``$*`` and ``$@``
behavior <internalvariables.html#INCOMPAT>`__

9-8. ```$*`` and ``$@`` when ``$IFS`` is
empty <internalvariables.html#IFSEMPTY>`__

9-9. `Underscore variable <internalvariables.html#USCREF>`__

9-10. `Using *declare* to type variables <declareref.html#EX20>`__

9-11. `Generating random numbers <randomvar.html#EX21>`__

9-12. `Picking a random card from a deck <randomvar.html#PICKCARD>`__

9-13. `Brownian Motion Simulation <randomvar.html#BROWNIAN>`__

9-14. `Random between values <randomvar.html#RANDOMBETWEEN>`__

9-15. `Rolling a single die with RANDOM <randomvar.html#RANDOMTEST>`__

9-16. `Reseeding RANDOM <randomvar.html#SEEDINGRANDOM>`__

9-17. `Pseudorandom numbers,
using <randomvar.html#RANDOM2>`__\ `awk <awk.html#AWKREF>`__

10-1. `Inserting a blank line between paragraphs in a text
file <string-manipulation.html#PARAGRAPHSPACE>`__

10-2. `Generating an 8-character "random"
string <string-manipulation.html#RANDSTRING>`__

10-3. `Converting graphic file formats, with filename
change <string-manipulation.html#CVT>`__

10-4. `Converting streaming audio files to
*ogg* <string-manipulation.html#RA2OGG>`__

10-5. `Emulating *getopt* <string-manipulation.html#GETOPTSIMPLE>`__

10-6. `Alternate ways of extracting and locating
substrings <string-manipulation.html#SUBSTRINGEX>`__

10-7. `Using parameter substitution and error
messages <parameter-substitution.html#EX6>`__

10-8. `Parameter substitution and "usage"
messages <parameter-substitution.html#USAGEMESSAGE>`__

10-9. `Length of a variable <parameter-substitution.html#LENGTH>`__

10-10. `Pattern matching in parameter
substitution <parameter-substitution.html#PATTMATCHING>`__

10-11. `Renaming file extensions: <parameter-substitution.html#RFE>`__

10-12. `Using pattern matching to parse arbitrary
strings <parameter-substitution.html#EX7>`__

10-13. `Matching patterns at prefix or suffix of
string <parameter-substitution.html#VARMATCH>`__

11-1. `Simple *for* loops <loops1.html#EX22>`__

11-2. `*for* loop with two parameters in each [list]
element <loops1.html#EX22A>`__

11-3. `*Fileinfo:* operating on a file list contained in a
variable <loops1.html#FILEINFO>`__

11-4. `Operating on a parameterized file
list <loops1.html#FILEINFO01>`__

11-5. `Operating on files with a *for* loop <loops1.html#LISTGLOB>`__

11-6. `Missing ``in [list]`` in a *for* loop <loops1.html#EX23>`__

11-7. `Generating the ``[list]`` in a *for* loop with command
substitution <loops1.html#FORLOOPCMD>`__

11-8. `A *grep* replacement for binary files <loops1.html#BINGREP>`__

11-9. `Listing all users on the system <loops1.html#USERLIST>`__

11-10. `Checking all the binaries in a directory for
authorship <loops1.html#FINDSTRING>`__

11-11. `Listing the *symbolic links* in a
directory <loops1.html#SYMLINKS>`__

11-12. `Symbolic links in a directory, saved to a
file <loops1.html#SYMLINKS2>`__

11-13. `A C-style *for* loop <loops1.html#FORLOOPC>`__

11-14. `Using *efax* in batch mode <loops1.html#EX24>`__

11-15. `Simple *while* loop <loops1.html#EX25>`__

11-16. `Another *while* loop <loops1.html#EX26>`__

11-17. `*while* loop with multiple conditions <loops1.html#EX26A>`__

11-18. `C-style syntax in a *while* loop <loops1.html#WHLOOPC>`__

11-19. `*until* loop <loops1.html#EX27>`__

11-20. `Nested Loop <nestedloops.html#NESTEDLOOP>`__

11-21. `Effects of *break* and **continue** in a
loop <loopcontrol.html#EX28>`__

11-22. `Breaking out of multiple loop
levels <loopcontrol.html#BREAKLEVELS>`__

11-23. `Continuing at a higher loop
level <loopcontrol.html#CONTINUELEVELS>`__

11-24. `Using *continue N* in an actual
task <loopcontrol.html#CONTINUENEX>`__

11-25. `Using *case* <testbranch.html#EX29>`__

11-26. `Creating menus using *case* <testbranch.html#EX30>`__

11-27. `Using *command substitution* to generate the *case*
variable <testbranch.html#CASECMD>`__

11-28. `Simple string matching <testbranch.html#MATCHSTRING>`__

11-29. `Checking for alphabetic input <testbranch.html#ISALPHA>`__

11-30. `Creating menus using *select* <testbranch.html#EX31>`__

11-31. `Creating menus using *select* in a
function <testbranch.html#EX32>`__

12-1. `Stupid script tricks <commandsub.html#STUPSCR>`__

12-2. `Generating a variable from a loop <commandsub.html#CSUBLOOP>`__

12-3. `Finding anagrams <commandsub.html#AGRAM2>`__

15-1. `A script that spawns multiple instances of
itself <internal.html#SPAWNSCR>`__

15-2. `*printf* in action <internal.html#EX47>`__

15-3. `Variable assignment, using *read* <internal.html#EX36>`__

15-4. `What happens when *read* has no
variable <internal.html#READNOVAR>`__

15-5. `Multi-line input to *read* <internal.html#READR>`__

15-6. `Detecting the arrow keys <internal.html#ARROWDETECT>`__

15-7. `Using *read* with <internal.html#READREDIR>`__\ `file
redirection <io-redirection.html#IOREDIRREF>`__

15-8. `Problems reading from a pipe <internal.html#READPIPE>`__

15-9. `Changing the current working directory <internal.html#EX37>`__

15-10. `Letting *let* do arithmetic. <internal.html#EX46>`__

15-11. `Showing the effect of *eval* <internal.html#EX43>`__

15-12. `Using *eval* to select among
variables <internal.html#ARRCHOICE>`__

15-13. `*Echoing* the *command-line
parameters* <internal.html#ECHOPARAMS>`__

15-14. `Forcing a log-off <internal.html#EX44>`__

15-15. `A version of *rot13* <internal.html#ROT14>`__

15-16. `Using *set* with positional parameters <internal.html#EX34>`__

15-17. `Reversing the positional
parameters <internal.html#REVPOSPARAMS>`__

15-18. `Reassigning the positional parameters <internal.html#SETPOS>`__

15-19. `"Unsetting" a variable <internal.html#UNS>`__

15-20. `Using *export* to pass a variable to an embedded *awk*
script <internal.html#COLTOTALER3>`__

15-21. `Using *getopts* to read the options/arguments passed to a
script <internal.html#EX33>`__

15-22. `"Including" a data file <internal.html#EX38>`__

15-23. `A (useless) script that sources
itself <internal.html#SELFSOURCE>`__

15-24. `Effects of *exec* <internal.html#EX54>`__

15-25. `A script that *exec's* itself <internal.html#SELFEXEC>`__

15-26. `Waiting for a process to finish before
proceeding <x9644.html#EX39>`__

15-27. `A script that kills itself <x9644.html#SELFDESTRUCT>`__

16-1. `Using *ls* to create a table of contents for burning a CDR
disk <basic.html#EX40>`__

16-2. `Hello or Good-bye <basic.html#HELLOL>`__

16-3. `*Badname*, eliminate file names in current directory containing
bad characters
and <moreadv.html#EX57>`__\ `whitespace <special-chars.html#WHITESPACEREF>`__.

16-4. `Deleting a file by its *inode* number <moreadv.html#IDELETE>`__

16-5. `Logfile: Using *xargs* to monitor system
log <moreadv.html#EX41>`__

16-6. `Copying files in current directory to
another <moreadv.html#EX42>`__

16-7. `Killing processes by name <moreadv.html#KILLBYNAME>`__

16-8. `Word frequency analysis using *xargs* <moreadv.html#WF2>`__

16-9. `Using *expr* <moreadv.html#EX45>`__

16-10. `Using *date* <timedate.html#EX51>`__

16-11. `*Date* calculations <timedate.html#DATECALC>`__

16-12. `Word Frequency Analysis <textproc.html#WF>`__

16-13. `Which files are scripts? <textproc.html#SCRIPTDETECTOR>`__

16-14. `Generating 10-digit random numbers <textproc.html#RND>`__

16-15. `Using *tail* to monitor the system log <textproc.html#EX12>`__

16-16. `Printing out the *From* lines in stored e-mail
messages <textproc.html#FROMSH>`__

16-17. `Emulating *grep* in a script <textproc.html#GRP>`__

16-18. `Crossword puzzle solver <textproc.html#CWSOLVER>`__

16-19. `Looking up definitions in Webster's 1913
Dictionary <textproc.html#DICTLOOKUP>`__

16-20. `Checking words in a list for validity <textproc.html#LOOKUP>`__

16-21. `*toupper*: Transforms a file to all
uppercase. <textproc.html#EX49>`__

16-22. `*lowercase*: Changes all filenames in working directory to
lowercase. <textproc.html#LOWERCASE>`__

16-23. `*du*: DOS to UNIX text file conversion. <textproc.html#DU>`__

16-24. `*rot13*: ultra-weak encryption. <textproc.html#ROT13>`__

16-25. `Generating "Crypto-Quote" Puzzles <textproc.html#CRYPTOQUOTE>`__

16-26. `Formatted file listing. <textproc.html#EX50>`__

16-27. `Using *column* to format a directory
listing <textproc.html#COL>`__

16-28. `*nl*: A self-numbering script. <textproc.html#LNUM>`__

16-29. `*manview*: Viewing formatted manpages <textproc.html#MANVIEW>`__

16-30. `Using *cpio* to move a directory tree <filearchiv.html#EX48>`__

16-31. `Unpacking an *rpm* archive <filearchiv.html#DERPM>`__

16-32. `Stripping comments from C program
files <filearchiv.html#STRIPC>`__

16-33. `Exploring ``/usr/X11R6/bin`` <filearchiv.html#WHAT>`__

16-34. `An "improved" *strings* command <filearchiv.html#WSTRINGS>`__

16-35. `Using *cmp* to compare two files within a
script. <filearchiv.html#FILECOMP>`__

16-36. `*basename* and *dirname* <filearchiv.html#EX35>`__

16-37. `A script that copies itself in
sections <filearchiv.html#SPLITCOPY>`__

16-38. `Checking file integrity <filearchiv.html#FILEINTEGRITY>`__

16-39. `Uudecoding encoded files <filearchiv.html#EX52>`__

16-40. `Finding out where to report a
spammer <communications.html#SPAMLOOKUP>`__

16-41. `Analyzing a spam domain <communications.html#ISSPAMMER>`__

16-42. `Getting a stock quote <communications.html#QUOTEFETCH>`__

16-43. `Updating FC4 <communications.html#FC4UPD>`__

16-44. `Using *ssh* <communications.html#REMOTE>`__

16-45. `A script that mails itself <communications.html#SELFMAILER>`__

16-46. `Generating prime numbers <mathc.html#PRIMES2>`__

16-47. `Monthly Payment on a Mortgage <mathc.html#MONTHLYPMT>`__

16-48. `Base Conversion <mathc.html#BASE>`__

16-49. `Invoking *bc* using a *here document* <mathc.html#ALTBC>`__

16-50. `Calculating PI <mathc.html#CANNON>`__

16-51. `Converting a decimal number to
hexadecimal <mathc.html#HEXCONVERT>`__

16-52. `Factoring <mathc.html#FACTR>`__

16-53. `Calculating the hypotenuse of a triangle <mathc.html#HYPOT>`__

16-54. `Using *seq* to generate loop arguments <extmisc.html#EX53>`__

16-55. `Letter Count" <extmisc.html#LETTERCOUNT>`__

16-56. `Using *getopt* to parse command-line
options <extmisc.html#EX33A>`__

16-57. `A script that copies itself <extmisc.html#SELFCOPY>`__

16-58. `Exercising *dd* <extmisc.html#EXERCISINGDD>`__

16-59. `Capturing Keystrokes <extmisc.html#DDKEYPRESS>`__

16-60. `Preparing a bootable SD card for the *Raspberry
Pi* <extmisc.html#RPSDCARD>`__

16-61. `Securely deleting a file <extmisc.html#BLOTOUT>`__

16-62. `Filename generator <extmisc.html#TEMPFILENAME>`__

16-63. `Converting meters to miles <extmisc.html#UNITCONVERSION>`__

16-64. `Using *m4* <extmisc.html#M4>`__

17-1. `Setting a new password <system.html#SETNEWPW>`__

17-2. `Setting an *erase* character <system.html#ERASE>`__

17-3. `*secret password*: Turning off terminal
echoing <system.html#SECRETPW>`__

17-4. `Keypress detection <system.html#KEYPRESS>`__

17-5. `Checking a remote server for *identd* <system.html#ISCAN>`__

17-6. `*pidof* helps kill a process <system.html#KILLPROCESS>`__

17-7. `Checking a CD image <system.html#ISOMOUNTREF>`__

17-8. `Creating a filesystem in a file <system.html#CREATEFS>`__

17-9. `Adding a new hard drive <system.html#ADDDRV>`__

17-10. `Using *umask* to hide an output file from prying
eyes <system.html#ROT13A>`__

17-11. `*Backlight*: changes the brightness of the (laptop) screen
backlight <system.html#BACKLIGHT>`__

17-12. `*killall*, from ``/etc/rc.d/init.d`` <sysscripts.html#EX55>`__

19-1. `*broadcast*: Sends message to everyone logged
in <here-docs.html#EX70>`__

19-2. `*dummyfile*: Creates a 2-line dummy file <here-docs.html#EX69>`__

19-3. `Multi-line message using *cat* <here-docs.html#EX71>`__

19-4. `Multi-line message, with tabs
suppressed <here-docs.html#EX71A>`__

19-5. `Here document with replaceable
parameters <here-docs.html#EX71B>`__

19-6. `Upload a file pair to *Sunsite* incoming
directory <here-docs.html#EX72>`__

19-7. `Parameter substitution turned off <here-docs.html#EX71C>`__

19-8. `A script that generates another
script <here-docs.html#GENERATESCRIPT>`__

19-9. `Here documents and functions <here-docs.html#HF>`__

19-10. `"Anonymous" Here Document <here-docs.html#ANONHEREDOC>`__

19-11. `Commenting out a block of code <here-docs.html#COMMENTBLOCK>`__

19-12. `A self-documenting script <here-docs.html#SELFDOCUMENT>`__

19-13. `Prepending a line to a file <x17837.html#PREPENDEX>`__

19-14. `Parsing a mailbox <x17837.html#MAILBOXGREP>`__

20-1. `Redirecting ``stdin`` using *exec* <x17974.html#REDIR1>`__

20-2. `Redirecting ``stdout`` using
*exec* <x17974.html#REASSIGNSTDOUT>`__

20-3. `Redirecting both ``stdin`` and ``stdout`` in the same script with
*exec* <x17974.html#UPPERCONV>`__

20-4. `Avoiding a subshell <x17974.html#AVOIDSUBSHELL>`__

20-5. `Redirected *while* loop <redircb.html#REDIR2>`__

20-6. `Alternate form of redirected *while*
loop <redircb.html#REDIR2A>`__

20-7. `Redirected *until* loop <redircb.html#REDIR3>`__

20-8. `Redirected *for* loop <redircb.html#REDIR4>`__

20-9. `Redirected *for* loop (both ``stdin`` and ``stdout``
redirected) <redircb.html#REDIR4A>`__

20-10. `Redirected *if/then* test <redircb.html#REDIR5>`__

20-11. `Data file *names.data* for above
examples <redircb.html#NAMESDATA>`__

20-12. `Logging events <redirapps.html#LOGEVENTS>`__

21-1. `Variable scope in a subshell <subshells.html#SUBSHELL>`__

21-2. `List User Profiles <subshells.html#ALLPROFS>`__

21-3. `Running parallel processes in
subshells <subshells.html#PARALLEL-PROCESSES>`__

22-1. `Running a script in restricted
mode <restricted-sh.html#RESTRICTED>`__

23-1. `Code block redirection without forking <process-sub.html#WRPS>`__

23-2. `Redirecting the output of *process substitution* into a
loop. <process-sub.html#PSUBP>`__

24-1. `Simple functions <functions.html#EX59>`__

24-2. `Function Taking Parameters <complexfunct.html#EX60>`__

24-3. `Functions and command-line args passed to the
script <complexfunct.html#FUNCCMDLINEARG>`__

24-4. `Passing an indirect reference to a
function <complexfunct.html#INDFUNC>`__

24-5. `Dereferencing a parameter passed to a
function <complexfunct.html#DEREFERENCECL>`__

24-6. `Again, dereferencing a parameter passed to a
function <complexfunct.html#REFPARAMS>`__

24-7. `Maximum of two numbers <complexfunct.html#MAX>`__

24-8. `Converting numbers to Roman numerals <complexfunct.html#EX61>`__

24-9. `Testing large return values in a
function <complexfunct.html#RETURNTEST>`__

24-10. `Comparing two large integers <complexfunct.html#MAX2>`__

24-11. `Real name from username <complexfunct.html#REALNAME>`__

24-12. `Local variable visibility <localvar.html#EX62>`__

24-13. `Demonstration of a simple recursive
function <localvar.html#RECURSIONDEMO>`__

24-14. `Another simple demonstration <localvar.html#RECURSIONDEMO2>`__

24-15. `Recursion, using a local variable <localvar.html#EX63>`__

24-16. `*The Fibonacci Sequence* <recurnolocvar.html#FIBO>`__

24-17. `*The Towers of Hanoi* <recurnolocvar.html#HANOI>`__

25-1. `Aliases within a script <aliases.html#AL>`__

25-2. `*unalias*: Setting and unsetting an alias <aliases.html#UNAL>`__

26-1. `Using an *and list* to test for command-line
arguments <list-cons.html#EX64>`__

26-2. `Another command-line arg test using an *and
list* <list-cons.html#ANDLIST2>`__

26-3. `Using *or lists* in combination with an *and
list* <list-cons.html#EX65>`__

27-1. `Simple array usage <arrays.html#EX66>`__

27-2. `Formatting a poem <arrays.html#POEM>`__

27-3. `Various array operations <arrays.html#ARRAYOPS>`__

27-4. `String operations on arrays <arrays.html#ARRAYSTROPS>`__

27-5. `Loading the contents of a script into an
array <arrays.html#SCRIPTARRAY>`__

27-6. `Some special properties of arrays <arrays.html#EX67>`__

27-7. `Of empty arrays and empty elements <arrays.html#EMPTYARRAY>`__

27-8. `Initializing arrays <arrays.html#ARRAYASSIGN>`__

27-9. `Copying and concatenating arrays <arrays.html#COPYARRAY>`__

27-10. `More on concatenating arrays <arrays.html#ARRAYAPPEND>`__

27-11. `The Bubble Sort <arrays.html#BUBBLE>`__

27-12. `Embedded arrays and indirect references <arrays.html#EMBARR>`__

27-13. `The Sieve of Eratosthenes <arrays.html#EX68>`__

27-14. `The Sieve of Eratosthenes, Optimized <arrays.html#EX68A>`__

27-15. `Emulating a push-down stack <arrays.html#STACKEX>`__

27-16. `Complex array application: *Exploring a weird mathematical
series* <arrays.html#QFUNCTION>`__

27-17. `Simulating a two-dimensional array, then tilting
it <arrays.html#TWODIM>`__

28-1. `Indirect Variable References <ivr.html#INDREF>`__

28-2. `Passing an indirect reference to *awk* <ivr.html#COLTOTALER2>`__

29-1. `Using ``/dev/tcp`` for troubleshooting <devref1.html#DEVTCP>`__

29-2. `Playing music <devref1.html#MUSICSCR>`__

29-3. `Finding the process associated with a
PID <procref1.html#PIDID>`__

29-4. `On-line connect status <procref1.html#CONSTAT>`__

30-1. `Print the server environment <networkprogramming.html#TESTCGI>`__

30-2. `IP addresses <networkprogramming.html#IPADDRESSES>`__

31-1. `Hiding the cookie jar <zeros.html#COOKIES>`__

31-2. `Setting up a swapfile using ``/dev/zero`` <zeros.html#EX73>`__

31-3. `Creating a ramdisk <zeros.html#RAMDISK>`__

32-1. `A buggy script <debugging.html#EX74>`__

32-2.
`Missing <debugging.html#MISSINGKEYWORD>`__\ `keyword <internal.html#KEYWORDREF>`__

32-3. `*test24*: another buggy script <debugging.html#EX75>`__

32-4. `Testing a condition with an *assert* <debugging.html#ASSERT>`__

32-5. `Trapping at exit <debugging.html#EX76>`__

32-6. `Cleaning up after **Control-C** <debugging.html#ONLINE>`__

32-7. `A Simple Implementation of a Progress
Bar <debugging.html#PROGRESSBAR2>`__

32-8. `Tracing a variable <debugging.html#VARTRACE>`__

32-9. `Running multiple processes (on an SMP
box) <debugging.html#MULTIPLEPROC>`__

34-1. `Numerical and string comparison are not
equivalent <gotchas.html#BADOP>`__

34-2. `Subshell Pitfalls <gotchas.html#SUBPIT>`__

34-3. `Piping the output of *echo* to a *read* <gotchas.html#BADREAD>`__

36-1. `*shell wrapper* <wrapper.html#EX3>`__

36-2. `A slightly more complex *shell wrapper* <wrapper.html#EX4>`__

36-3. `A generic *shell wrapper* that writes to a
logfile <wrapper.html#LOGGINGWRAPPER>`__

36-4. `A *shell wrapper* around an awk script <wrapper.html#PRASC>`__

36-5. `A *shell wrapper* around another awk
script <wrapper.html#COLTOTALER>`__

36-6. `Perl embedded in a *Bash* script <wrapper.html#EX56>`__

36-7. `Bash and Perl scripts combined <wrapper.html#BASHANDPERL>`__

36-8. `Python embedded in a *Bash* script <wrapper.html#EX56PY>`__

36-9. `A script that speaks <wrapper.html#SPEECH0>`__

36-10. `A (useless) script that recursively calls
itself <recursionsct.html#RECURSE>`__

36-11. `A (useful) script that recursively calls
itself <recursionsct.html#PBOOK>`__

36-12. `Another (useful) script that recursively calls
itself <recursionsct.html#USRMNT>`__

36-13. `A "colorized" address database <colorizing.html#EX30A>`__

36-14. `Drawing a box <colorizing.html#DRAW-BOX>`__

36-15. `Echoing colored text <colorizing.html#COLORECHO>`__

36-16. `A "horserace" game <colorizing.html#HORSERACE>`__

36-17. `A Progress Bar <assortedtips.html#PROGRESSBAR>`__

36-18. `Return value trickery <assortedtips.html#MULTIPLICATION>`__

36-19. `Even more return value
trickery <assortedtips.html#SUMPRODUCT>`__

36-20. `Passing and returning arrays <assortedtips.html#ARRFUNC>`__

36-21. `Fun with anagrams <assortedtips.html#AGRAM>`__

36-22. `Widgets invoked from a shell
script <assortedtips.html#DIALOG>`__

36-23. `Test Suite <portabilityissues.html#TESTSUITE>`__

37-1. `String expansion <bashver2.html#EX77>`__

37-2. `Indirect variable references - the new
way <bashver2.html#EX78>`__

37-3. `Simple database application, using indirect variable
referencing <bashver2.html#RESISTOR>`__

37-4. `Using arrays and other miscellaneous trickery to deal four random
hands from a deck of cards <bashver2.html#CARDS>`__

37-5. `A simple address database <bashver4.html#FETCHADDRESS>`__

37-6. `A somewhat more elaborate address
database <bashver4.html#FETCHADDRESS2>`__

37-7. `Testing characters <bashver4.html#CASE4>`__

37-8. `Reading N characters <bashver4.html#READN>`__

37-9. `Using a *here document* to set a
variable <bashver4.html#HERECOMMSUB>`__

37-10. `Piping input to
a <bashver4.html#LASTPIPEOPT>`__\ `read <internal.html#READREF>`__

37-11. `Negative array indices <bashver4.html#NEGARRAY>`__

37-12. `Negative parameter in string-extraction
construct <bashver4.html#NEGOFFSET>`__

A-1. `*mailformat*: Formatting an e-mail
message <contributed-scripts.html#MAILFORMAT>`__

A-2. `*rn*: A simple-minded file renaming
utility <contributed-scripts.html#RN>`__

A-3. `*blank-rename*: Renames filenames containing
blanks <contributed-scripts.html#BLANKRENAME>`__

A-4. `*encryptedpw*: Uploading to an ftp site, using a locally encrypted
password <contributed-scripts.html#ENCRYPTEDPW>`__

A-5. `*copy-cd*: Copying a data CD <contributed-scripts.html#COPYCD>`__

A-6. `Collatz series <contributed-scripts.html#COLLATZ>`__

A-7. `*days-between*: Days between two
dates <contributed-scripts.html#DAYSBETWEEN>`__

A-8. `Making a *dictionary* <contributed-scripts.html#MAKEDICT>`__

A-9. `Soundex conversion <contributed-scripts.html#SOUNDEX>`__

A-10. `*Game of Life* <contributed-scripts.html#LIFESLOW>`__

A-11. `Data file for *Game of
Life* <contributed-scripts.html#GEN0DATA>`__

A-12. `*behead*: Removing mail and news message
headers <contributed-scripts.html#BEHEAD>`__

A-13. `*password*: Generating random 8-character
passwords <contributed-scripts.html#PW>`__

A-14. `*fifo*: Making daily backups, using named
pipes <contributed-scripts.html#FIFO>`__

A-15. `Generating prime numbers using the modulo
operator <contributed-scripts.html#PRIMES>`__

A-16. `*tree*: Displaying a directory
tree <contributed-scripts.html#TREE>`__

A-17. `*tree2*: Alternate directory tree
script <contributed-scripts.html#TREE2>`__

A-18. `*string functions*: C-style string
functions <contributed-scripts.html#STRING>`__

A-19. `Directory information <contributed-scripts.html#DIRECTORYINFO>`__

A-20. `Library of hash functions <contributed-scripts.html#HASHLIB>`__

A-21. `Colorizing text using hash
functions <contributed-scripts.html#HASHEXAMPLE>`__

A-22. `More on hash functions <contributed-scripts.html#HASHEX2>`__

A-23. `Mounting USB keychain storage
devices <contributed-scripts.html#USBINST>`__

A-24. `Converting to HTML <contributed-scripts.html#TOHTML>`__

A-25. `Preserving weblogs <contributed-scripts.html#ARCHIVWEBLOGS>`__

A-26. `Protecting literal
strings <contributed-scripts.html#PROTECTLITERAL>`__

A-27. `Unprotecting literal
strings <contributed-scripts.html#UNPROTECTLITERAL>`__

A-28. `Spammer Identification <contributed-scripts.html#ISSPAMMER2>`__

A-29. `Spammer Hunt <contributed-scripts.html#WHX>`__

A-30. `Making *wget* easier to
use <contributed-scripts.html#WGETTER2>`__

A-31. `A *podcasting* script <contributed-scripts.html#BASHPODDER>`__

A-32. `Nightly backup to a firewire
HD <contributed-scripts.html#NIGHTLYBACKUP>`__

A-33. `An expanded *cd* command <contributed-scripts.html#CDLL>`__

A-34. `A soundcard setup
script <contributed-scripts.html#SOUNDCARDON>`__

A-35. `Locating split paragraphs in a text
file <contributed-scripts.html#FINDSPLIT>`__

A-36. `Insertion sort <contributed-scripts.html#INSERTIONSORT>`__

A-37. `Standard Deviation <contributed-scripts.html#STDDEV>`__

A-38. `A *pad* file generator for shareware
authors <contributed-scripts.html#PADSW>`__

A-39. `A *man page* editor <contributed-scripts.html#MANED>`__

A-40. `Petals Around the Rose <contributed-scripts.html#PETALS>`__

A-41. `Quacky: a Perquackey-type word
game <contributed-scripts.html#QKY>`__

A-42. `Nim <contributed-scripts.html#NIM>`__

A-43. `A command-line stopwatch <contributed-scripts.html#STOPWATCH>`__

A-44. `An all-purpose shell scripting homework assignment
solution <contributed-scripts.html#HOMEWORK>`__

A-45. `The Knight's Tour <contributed-scripts.html#KTOUR>`__

A-46. `Magic Squares <contributed-scripts.html#MSQUARE>`__

A-47. `Fifteen Puzzle <contributed-scripts.html#FIFTEEN>`__

A-48. `*The Towers of Hanoi, graphic
version* <contributed-scripts.html#HANOI2>`__

A-49. `*The Towers of Hanoi, alternate graphic
version* <contributed-scripts.html#HANOI2A>`__

A-50. `An alternate version of
the <contributed-scripts.html#USEGETOPT>`__\ `getopt-simple.sh <string-manipulation.html#GETOPTSIMPLE>`__
script

A-51. `The version of the *UseGetOpt.sh* example used in
the <contributed-scripts.html#USEGETOPT2>`__\ `Tab Expansion
appendix <tabexpansion.html>`__

A-52. `Cycling through all the possible color
backgrounds <contributed-scripts.html#SHOWALLC>`__

A-53. `Morse Code Practice <contributed-scripts.html#SAMORSE>`__

A-54. `Base64 encoding/decoding <contributed-scripts.html#BASE64>`__

A-55. `Inserting text in a file using
*sed* <contributed-scripts.html#SEDAPPEND>`__

A-56. `The Gronsfeld Cipher <contributed-scripts.html#GRONSFELD>`__

A-57. `Bingo Number Generator <contributed-scripts.html#BINGO>`__

A-58. `Basics Reviewed <contributed-scripts.html#BASICSREVIEWED>`__

A-59. `Testing execution times of various
commands <contributed-scripts.html#TESTEXECTIME>`__

A-60. `Associative arrays vs. conventional arrays (execution
times) <contributed-scripts.html#ASSOCARRTEST>`__

C-1. `Counting Letter Occurrences <awk.html#LETTERCOUNT2>`__

J-1. `Completion script for
*UseGetOpt.sh* <tabexpansion.html#USEGETOPTEX>`__

M-1. `Sample ``.bashrc`` file <sample-bashrc.html#BASHRC>`__

M-2. ```.bash_profile`` file <sample-bashrc.html#BASHPROF>`__

N-1. `VIEWDATA.BAT: DOS Batch File <dosbatch.html#VIEWDAT>`__

N-2. `*viewdata.sh*: Shell Script Conversion of
VIEWDATA.BAT <dosbatch.html#VIEWDATA>`__

T-1. `A script that generates an ASCII
table <asciitable.html#ASCIISH>`__

T-2. `Another ASCII table script <asciitable.html#ASCII2SH>`__

T-3. `A third ASCII table script, using
*awk* <asciitable.html#ASCII3SH>`__

--------------

+--------------------------+--------------------------+--------------------------+
|                          |                          |
|                          |                          |
| `Next <part1.html>`__    | Introduction             |
+--------------------------+--------------------------+--------------------------+

