
  Index
======

This index / glossary / quick-reference lists many of the important
topics covered in the text. Terms are arranged in *approximate* ASCII
sorting order, *modified as necessary* for enhanced clarity.

Note that *commands* are indexed in `Part 4 <part4.html#PART4A>`__ .

\* \* \*

**^** (caret)

-  `Beginning-of-line <special-chars.html#BEGLINEREF>`__ , in a `Regular
   Expression <regexp.html#REGEXREF>`__

-  **^**

   **^^**

   `Uppercase conversion <bashver4.html#CASEMODPARAMSUB>`__ in
   *parameter substitution*

**~** *Tilde*

-  **~** `home directory <special-chars.html#TILDEREF>`__ , corresponds
   to ```         $HOME        `` <internalvariables.html#HOMEDIRREF>`__

-  **~/** `*Current user's* home
   directory <special-chars.html#TILDEREF>`__

-  **~+** `*Current* working
   directory <special-chars.html#WORKINGDIRREF>`__

-  **~-** `*Previous* working
   directory <special-chars.html#PREVWORKINGDIR>`__

**=** *Equals* sign

-  **=** `Variable assignment <varassignment.html#EQREF>`__ operator

-  **=** `String comparison <comparison-ops.html#SCOMPARISON1>`__
   operator

   **==** `String comparison <comparison-ops.html#SCOMPARISON2>`__
   operator

-  **=~** *Regular Expression* `match <bashver3.html#REGEXMATCHREF>`__
   operator

   `*Example script* <contributed-scripts.html#FINDSPLIT0>`__

**<** Left angle bracket

-  Is-less-than

   `String comparison <comparison-ops.html#LTREF>`__

   `Integer comparison <comparison-ops.html#INTLT>`__ within `double
   parentheses <dblparens.html>`__

-  Redirection

   **<**
   ```         stdin        `` <io-redirection.html#IOREDIRECTIONREF2>`__

   **<<** `*Here document* <special-chars.html#HEREDOCRRREF>`__

   **<<<** `*Here string* <special-chars.html#HERESTRINGREF>`__

   **<>** `Opening a file <special-chars.html#REDIRRW>`__ for *both*
   reading and writing

**>** Right angle bracket

-  Is-greater-than

   `String comparison <comparison-ops.html#GTREF>`__

   `Integer comparison <comparison-ops.html#INTGT>`__ , within *double
   parentheses*

-  Redirection

   **>** `Redirect
   ``         stdout        `` <io-redirection.html#IOREDIRECTIONREF>`__
   to a file

   **>>** `Redirect
   ``         stdout        `` <io-redirection.html#IOREDIRECTIONREF>`__
   to a file, but *append*

   **i>&j** `Redirect *file descriptor*
   ``         i        `` <io-redirection.html#IOREDIRECTIONREF1>`__ to
   *file descriptor* ``        j       ``

   **>&j** `Redirect
   ``         stdout        `` <io-redirection.html#IOREDIRECTIONREF1>`__
   to *file descriptor* ``        j       ``

   **>&2** `Redirect
   ``         stdout        `` <special-chars.html#REDIROUTERROR2>`__ of
   a command to ``        stderr       ``

   **2>&1** `Redirect
   ``         stderr        `` <io-redirection.html#IOREDIRECTIONREF1>`__
   to ``        stdout       ``

   **&>** `Redirect *both* ``         stdout        `` and
   ``         stderr        `` <special-chars.html#REDIROUTERROR>`__ of
   a command to a file

   **:> ``         file        ``** `Truncate
   file <io-redirection.html#IOREDIRECTIONREF>`__ to zero length

**\|** `Pipe <special-chars.html#PIPEREF>`__ , a device for passing the
output of a command to another command or to the shell

**\|\|** `Logical OR test operator <ops.html#ORREF>`__

**-** (dash)

-  `Prefix to *default
   parameter* <parameter-substitution.html#DEFPARAM1>`__ , in *parameter
   substitution*

-  `Prefix to *option flag* <special-chars.html#DASHREF>`__

-  `Indicating *redirection* <special-chars.html#DASHREF2>`__ from
   ``        stdin       `` or ``        stdout       ``

-  **--** (double-dash)

   `Prefix to *long* command
   options <special-chars.html#DOUBLEDASHREF>`__

   `*C-style* variable decrement <dblparens.html#PLUSPLUSREF>`__ within
   `double parentheses <dblparens.html#DBLPARENSREF>`__

**;** (semicolon)

-  `As command separator <special-chars.html#SEMICOLONREF>`__

-  **\\;** `*Escaped* semicolon <moreadv.html#FINDREF0>`__ , terminates
   a `find <moreadv.html#FINDREF>`__ command

-  **;;** `Double-semicolon <special-chars.html#DOUBLESEMICOLON>`__ ,
   terminator in a `case <testbranch.html#CASEESAC1>`__ option

   Required when ...

   `*do* keyword is on the first line of
   *loop* <loops1.html#NEEDSEMICOLON>`__

   `terminating *curly-bracketed* code
   block <gotchas.html#OMITSEMICOLON>`__

-  **;;&** **;&** `Terminators <bashver4.html#NCTERM>`__ in a *case*
   option ( `version 4+ <bashver4.html#BASH4REF>`__ of Bash).

**:** Colon

-  **:> ``         filename        ``** `Truncate
   file <io-redirection.html#IOREDIRECTIONREF>`__ to zero length

-  `*null* command <special-chars.html#NULLREF>`__ , equivalent to the
   `true <internal.html#TRUEREF>`__ Bash builtin

-  Used in an `anonymous here document <here-docs.html#ANONHEREDOC0>`__

-  Used in an `otherwise empty
   function <special-chars.html#COLONINFUNCTION>`__

-  Used as a `function name <functions.html#FSTRANGEREF>`__

**!** `Negation operator <special-chars.html#NOTREF>`__ , inverts `exit
status <exit-status.html#NEGCOND>`__ of a test or command

-  **!=** `not-equal-to <comparison-ops.html#NOTEQUAL>`__ String
   comparison operator

**?** (question mark)

-  `Match zero or one characters <x17129.html#QUEXREGEX>`__ , in an
   `Extended Regular Expression <x17129.html#EXTREGEX>`__

-  `Single-character *wild card* <special-chars.html#QUEXWC>`__ , in
   `globbing <globbingref.html>`__

-  In a `*C* -style Trinary operator <special-chars.html#CSTRINARY>`__

**//** `Double forward slash <internal.html#DOUBLESLASHREF>`__ ,
behavior of `cd <internal.html#CDREF>`__ command toward

**.** (dot / period)

-  **.** `Load a file <special-chars.html#DOTREF>`__ (into a script),
   equivalent to `source <internal.html#SOURCEREF>`__ command

-  **.** `Match single character <x17129.html#REGEXDOT>`__ , in a
   `Regular Expression <regexp.html#REGEXREF>`__

-  **.** `Current working directory <special-chars.html#DOTDIRECTORY>`__

   **./** `Current working
   directory <internalvariables.html#CURRENTWDREF>`__

-  **..** `*Parent* directory <special-chars.html#DOTDIRECTORY>`__

**' ... '** (single quotes) `*strong* quoting <varsubn.html#SNGLQUO>`__

**" ... "** (double quotes) `*weak* quoting <varsubn.html#DBLQUO>`__

-  `*Double-quoting* the *backslash* ( **\\** )
   character <quotingvar.html#QUOTINGBSL>`__

**,**

-  `Comma operator <ops.html#COMMAOP>`__

-  **,**

   **,,**

   `Lowercase conversion <bashver4.html#CASEMODPARAMSUB>`__ in
   *parameter substitution*

**()** Parentheses

-  **( ... )** `Command group <special-chars.html#PARENSREF>`__ ; starts
   a `subshell <subshells.html#SUBSHELLSREF>`__

-  **( ... )** `Enclose group <x17129.html#PARENGRPS>`__ of *Extended
   Regular Expressions*

-  **>( ... )**

   **<( ... )** `Process
   substitution <process-sub.html#PROCESSSUBREF>`__

-  **... )** `Terminates test-condition <testbranch.html#CASEPAREN>`__
   in *case* construct

-  **(( ... ))** `Double parentheses <dblparens.html#DBLPARENSREF>`__ ,
   in arithmetic expansion

**[** `Left bracket <special-chars.html#LEFTBRACKET>`__ , *test*
construct

**[ ]** Brackets

-  `*Array* element <arrays.html#BRACKARRAY>`__

-  `Enclose character set to match <x17129.html#BRACKETSREF>`__ in a
   *Regular Expression*

-  `*Test* construct <special-chars.html#BRACKTEST>`__

**[[ ... ]]** `Double brackets <testconstructs.html#DBLBRACKETS>`__ ,
extended *test* construct

**$** `*Anchor* <x17129.html#DOLLARSIGNREF>`__ , in a `Regular
Expression <regexp.html#REGEXREF>`__

**$** `Prefix to a variable name <varsubn.html>`__

**$( ... )** `Command
substitution <varassignment.html#COMMANDSUBREF0>`__ , setting a variable
with output of a command, using parentheses notation

**\` ... \`** `Command substitution <commandsub.html#BACKQUOTESREF>`__ ,
using `backquotes <special-chars.html#BACKTICKSREF>`__ notation

**$[ ... ]** `Integer expansion <special-chars.html#BRACKETARITH>`__
(deprecated)

**${ ... }** Variable manipulation / evaluation

-  **${var}** `Value of a
   variable <parameter-substitution.html#PSSUB1>`__

-  **${#var}** `Length of a
   variable <parameter-substitution.html#PSOREX1>`__

-  **${#@}**

   **${#\*}** `Number of *positional
   parameters* <parameter-substitution.html#NUMPOSPARAM>`__

-  **${parameter?err\_msg}** `Parameter-unset
   message <parameter-substitution.html#QERRMSG>`__

-  **${parameter-default}**

   **${parameter:-default}**

   **${parameter=default}**

   **${parameter:=default}** `Set default
   parameter <parameter-substitution.html#DEFPARAM1>`__

-  **${parameter+alt\_value}**

   **${parameter:+alt\_value}**

   `Alternate value <parameter-substitution.html#PARAMALTV>`__ of
   parameter, if set

-  **${!var}**

   `Indirect referencing of a variable <ivr.html#IVR2>`__ , new notation

-  **${!#}**

   `Final *positional parameter* <othertypesv.html#LASTARGREF>`__ .
   (This is an *indirect reference* to
   `$# <internalvariables.html#CLACOUNTREF>`__ .)

-  **${!varprefix\*}**

   **${!varprefix@}**

   `Match *names* <parameter-substitution.html#VARPREFIXM>`__ of all
   previously declared variables beginning with
   ``        varprefix       ``

-  **${string:position}**

   **${string:position:length}** `Substring
   extraction <string-manipulation.html#SUBSTREXTR01>`__

-  **${var#Pattern}**

   **${var##Pattern}** `Substring
   removal <parameter-substitution.html#PSOREX2>`__

-  **${var%Pattern}**

   **${var%%Pattern}** `Substring
   removal <parameter-substitution.html#PCTPATREF>`__

-  **${string/substring/replacement}**

   **${string//substring/replacement}**

   **${string/#substring/replacement}**

   **${string/%substring/replacement}** `Substring
   replacement <string-manipulation.html#SUBSTRREPL00>`__

**$' ... '** `String expansion <escapingsection.html#STRQ>`__ , using
*escaped* characters.

**\\** `Escape <escapingsection.html#ESCP>`__ the character following

-  **\\< ... \\>** `Angle brackets <x17129.html#ANGLEBRAC>`__ ,
   *escaped* , word boundary in a `Regular
   Expression <regexp.html#REGEXREF>`__

-  **\\{ N \\}** ` "Curly" brackets <x17129.html#ESCPCB>`__ , *escaped*
   , number of character sets to match in an `Extended
   RE <x17129.html#EXTREGEX>`__

-  **\\;** `*Semicolon* <moreadv.html#FINDREF0>`__ , *escaped* ,
   terminates a `find <moreadv.html#FINDREF>`__ command

-  **\\$$** `Indirect reverencing of a variable <ivr.html#IVRREF>`__ ,
   old-style notation

-  `Escaping a *newline* <escapingsection.html#ESCNEWLINE>`__ , to write
   a multi-line command

**&**

-  **&>** `Redirect *both* ``         stdout        `` and
   ``         stderr        `` <special-chars.html#REDIROUTERROR>`__ of
   a command to a file

-  **>&j** `Redirect
   ``         stdout        `` <io-redirection.html#IOREDIRECTIONREF1>`__
   to *file descriptor* *j*

   **>&2** `Redirect
   ``         stdout        `` <special-chars.html#REDIROUTERROR2>`__ of
   a command to ``        stderr       ``

-  **i>&j** `Redirect *file
   descriptor* <io-redirection.html#IOREDIRECTIONREF1>`__ *i* to *file
   descriptor* *j*

   **2>&1** `Redirect
   ``         stderr        `` <io-redirection.html#IOREDIRECTIONREF1>`__
   to ``        stdout       ``

-  `Closing *file descriptors* <io-redirection.html#CFD>`__

   **n<&-** Close input file descriptor *n*

   **0<&-** , **<&-** Close ``        stdin       ``

   **n>&-** Close output file descriptor *n*

   **1>&-** , **>&-** Close ``        stdout       ``

-  **&&** `Logical AND test operator <special-chars.html#LOGICALAND>`__

-  **Command &** `Run job in *background* <special-chars.html#BGJOB>`__

**#** `Hashmark <special-chars.html#HASHMARKREF>`__ , special symbol
beginning a script *comment*

**#!** `Sha-bang <sha-bang.html#SHABANGREF>`__ , special string starting
a `shell script <part1.html#WHATSASCRIPT>`__

**\*** Asterisk

-  `*Wild card* <special-chars.html#ASTERISKREF>`__ , in
   `globbing <globbingref.html>`__

-  `Any number of characters <special-chars.html#ASTERISKREF2>`__ in a
   `Regular Expression <regexp.html#REGEXREF>`__

-  **\*\*** `Exponentiation <ops.html#EXPONENTIATIONREF>`__ , arithmetic
   operator

-  **\*\*** Extended *globbing* `file-match
   operator <bashver4.html#GLOBSTARREF>`__

**%** Percent sign

-  `Modulo <ops.html#MODULOREF>`__ , division-remainder arithmetic
   operation

-  `Substring removal <parameter-substitution.html#PCTPATREF>`__
   (pattern matching) operator

**+** Plus sign

-  `*Character match* <x17129.html#PLUSREF>`__ , in an `extended Regular
   Expression <x17129.html#EXTREGEX>`__

-  `Prefix to *alternate
   parameter* <parameter-substitution.html#PARAMALTV>`__ , in *parameter
   substitution*

-  **++** `*C-style* variable increment <dblparens.html#PLUSPLUSREF>`__
   , within `double parentheses <dblparens.html#DBLPARENSREF>`__

\* \* \*

*Shell Variables*

**$\_** `Last argument to previous
command <internalvariables.html#UNDERSCOREREF>`__

**$-** `Flags passed to script <internalvariables.html#FLPREF>`__ ,
using `set <internal.html#SETREF>`__

**$!** `*Process ID* of last background
job <internalvariables.html#PIDVARREF>`__

**$?** `*Exit status* of a command <exit-status.html#EXSREF>`__

**$@** All the *positional parameters* , `as *separate*
words <internalvariables.html#APPREF2>`__

**$\*** All the *positional parameters* , `as a *single*
word <internalvariables.html#APPREF>`__

**$$** `Process ID <special-chars.html#PROCESSIDREF>`__ of the script

**$#** `Number of arguments
passed <internalvariables.html#CLACOUNTREF>`__ to a
`function <functions.html#FUNCTIONREF>`__ , or to the script itself

**$0** `Filename of the script <othertypesv.html#SCRNAMEPARAM>`__

**$1** `First argument passed to
script <othertypesv.html#POSPARAMREF1>`__

**$9** `Ninth argument passed to
script <othertypesv.html#POSPARAMREF1>`__

`**Table** <refcards.html#SPECSHVARTAB>`__ of *shell variables*

\* \* \* \* \* \*

**-a** `Logical AND <comparison-ops.html#COMPOUNDAND>`__ compound
comparison test

Address database, `script example <testbranch.html#EX30>`__

*Advanced Bash Scripting Guide* , `where to
download <mirrorsites.html#WHERE_TARBALL>`__

`Alias <aliases.html#ALIASREF>`__

-  `Removing an *alias* <aliases.html#UNALIASREF>`__ , using *unalias*

`Anagramming <commandsub.html#AGRAM2>`__

`*And* list <list-cons.html#LCONS1>`__

-  `To supply default command-line
   argument <list-cons.html#ANDDEFAULT>`__

`*And* logical operator <ops.html#LOGOPS1>`__ **&&**

`Angle brackets <x17129.html#ANGLEBRAC>`__ , *escaped* , **\\< . . .
\\>** word boundary in a `Regular Expression <regexp.html#REGEXREF>`__

`Anonymous *here document* <here-docs.html#ANONHEREDOC0>`__ , using
**:**

`Archiving <filearchiv.html#FAARCHIVING1>`__

-  `rpm <filearchiv.html#RPMREF>`__

-  `tar <filearchiv.html#TARREF>`__

`Arithmetic expansion <arithexp.html#ARITHEXPREF>`__

-  `*exit status* of <testconstructs.html#ARXS>`__

-  `variations of <arithexp.html#ARITHEXPVAR1>`__

`Arithmetic operators <ops.html#AROPS1>`__

-  `combination operators <ops.html#ARITHOPSCOMB>`__ , *C* -style

   **+=** **-=** **\*=** **/=** **%=**



   |Note|

   `In certain contexts <bashver3.html#PLUSEQSTR>`__ , **+=** can also
   function as a *string concatenation* operator.




`Arrays <arrays.html#ARRAYREF>`__

-  `Associative arrays <bashver4.html#ASSOCARR>`__

   `more efficient <optimizations.html#ASSOCARRTST>`__ than conventional
   arrays

-  `Bracket notation <arrays.html#ARRAYREF>`__

-  `Concatenating <arrays.html#ARRAYAPPEND0>`__ , *example script*

-  `Copying <arrays.html#COPYARRAY0>`__

-  `Declaring <declareref.html#ARRAYDECLARE>`__

   ``        declare -a          array_name       ``

-  `Embedded arrays <arrays.html#ARRAYINDIR>`__

-  `Empty arrays, empty elements <arrays.html#EMPTYARRAY0>`__ , *example
   script*

-  `Indirect references <arrays.html#ARRAYINDIR>`__

-  `Initialization <arrays.html#ARRAYINIT0>`__

   ``        array=( element1 element2 ... elementN)       ``

   `*Example script* <arrays.html#ARRAYASSIGN0>`__

   Using `command substitution <arrays.html#ARRAYINITCS>`__

-  `Loading a file <arrays.html#ARRAYINITCS>`__ into an array

-  `Multidimensional <arrays.html#ARRAYMULTIDIM>`__ , simulating

-  `Nesting and embedding <arrays.html#ARRAYNEST>`__

-  `Notation and usage <arrays.html#ARRAYNOTATION>`__

-  `Number of elements in <arrays.html#ARRAYNUMELEMENTS>`__

   ``        ${#array_name[@]}       ``

   ``        ${#array_name[*]}       ``

-  `Operations <arrays.html#ARRAYSYNTAX>`__

-  `Passing an *array* <assortedtips.html#PASSARRAY>`__ to a function

-  As `*return value* from a function <assortedtips.html#RETARRAY>`__

-  Special properties, `example
   script <arrays.html#ARRAYSPECIALPROPS>`__

-  String operations, `example script <arrays.html#ARRAYSTRINGOPS>`__

-  `*unset* deletes array elements <arrays.html#ARRAYUNSET>`__

`Arrow keys <internal.html#READARROW>`__ , detecting

ASCII

-  `Definition <special-chars.html#ASCIIDEF>`__

-  `Scripts for generating ASCII table <asciitable.html>`__

`awk <awk.html>`__ field-oriented text processing language

-  ```         rand()        `` <randomvar.html#AWKRANDOMREF>`__ ,
   random function

-  `String manipulation <string-manipulation.html#AWKSTRINGMANIP2>`__

-  `Using *export* <internal.html#EXPORTAWK>`__ to pass a variable to an
   embedded *awk* script

\* \* \*

Backlight, `setting the brightness <system.html#BACKLIGHT>`__

`Backquotes <special-chars.html#BACKTICKSREF>`__ , used in `command
substitution <commandsub.html#BACKQUOTESREF>`__

`Base conversion <mathc.html#BASE0>`__ , *example script*

`Bash <why-shell.html#BASHDEF>`__

-  `Bad scripting practices <gotchas.html#BASH3GOTCHA>`__

-  `Basics reviewed <contributed-scripts.html#BASICSREV0>`__ , *script
   example*

-  `Command-line options <bash-options.html#CLOPTS>`__

   `**Table** <options.html#OPTIONSTABLE>`__

-  `Features that classic *Bourne* shell
   lacks <portabilityissues.html#BASHCOMPAT>`__

-  `Internal variables <internalvariables.html>`__

-  `Version 2 <bashver2.html#BASH2REF>`__

-  `Version 3 <bashver3.html#BASH3REF>`__

-  `Version 4 <bashver4.html#BASH4REF>`__

   `Version 4.1 <bashver4.html#BASH41>`__

   `Version 4.2 <bashver4.html#BASH42>`__

`.bashrc <sample-bashrc.html>`__

```       $BASH_SUBSHELL      `` <internalvariables.html#BASHSUBSHELLREF>`__

`Basic commands <basic.html#BASICCOMMANDS1>`__ , external

`Batch files <dosbatch.html#DOSBATCH1>`__ , *DOS*

`Batch processing <timedate.html#BATCHPROCREF>`__

`bc <mathc.html#BCREF>`__ , calculator utility

-  `In a *here document* <mathc.html#BCHEREDOC>`__

-  `Template <mathc.html#BCTEMPLATE>`__ for calculating a script
   variable

`Bibliography <biblio.html>`__

`Bison <textproc.html#BISONREF>`__ utility

`Bitwise operators <ops.html#BITWSOPS1>`__

-  `Example script <contributed-scripts.html#BASE64>`__

`Block devices <devref1.html#BLOCKDEVREF>`__

-  `testing for <fto.html#BLOCKDEVTEST>`__

`Blocks of code <special-chars.html#CODEBLOCKREF>`__

-  `Iterating / looping <loops1.html#NODODONE>`__

-  `Redirection <special-chars.html#BLOCKIO>`__

   *Script example* : `Redirecting output of a a code
   block <special-chars.html#BLOCKIO2>`__

`Bootable flash drives <extmisc.html#BFS>`__ , creating

`Brace expansion <special-chars.html#BRACEEXPREF>`__

-  `Extended <special-chars.html#BRACEEXPREF33>`__ ,
   ``                 {a..z}               ``

-  `Parameterizing <bashver3.html#BRACEEXPREF3>`__

-  With `increment and zero-padding <bashver4.html#BRACEEXPREF4>`__ (new
   feature in Bash, `version 4 <bashver4.html#BASH4REF>`__ )

Brackets, **[ ]**

-  `*Array* element <arrays.html#BRACKARRAY>`__

-  `Enclose character set to match <x17129.html#BRACKETSREF>`__ in a
   *Regular Expression*

-  `*Test* construct <special-chars.html#BRACKTEST>`__

Brackets, *curly* , **{}** , used in

-  `Code block <special-chars.html#CODEBLOCKREF>`__

-  `*find* <moreadv.html#CURLYBRACKETSREF>`__

-  `*Extended Regular Expressions* <x17129.html#ESCPCB>`__

-  `*Positional parameters* <othertypesv.html#BRACKETNOTATION>`__

-  `*xargs* <moreadv.html#XARGSCURLYREF>`__

`break <loopcontrol.html#BRKCONT1>`__ *loop* control command

-  `Parameter <loopcontrol.html#BREAKPARAM>`__ (optional)

`Builtins <internal.html#BUILTINREF>`__ in *Bash*

-  `Do not fork a subprocess <internal.html#BLTINFRK>`__

\* \* \*

`*case* construct <testbranch.html#CASEESAC1>`__

-  `Command-line parameters <testbranch.html#CASECL>`__ , handling

-  `Globbing <testbranch.html#CSGLOB>`__ , filtering strings with

`cat <basic.html#CATREF>`__ , con *cat* entate file(s)

-  `Abuse of <optimizations.html#CATABUSE>`__

-  `*cat* scripts <here-docs.html#CATSCRIPTREF>`__

-  `Less efficient than redirecting
   ``         stdin        `` <basic.html#CATLESSEFF>`__

-  `Piping the output of <internal.html#READPIPEREF>`__ , to a
   `read <internal.html#READREF>`__

-  `Uses of <basic.html#CATUSES>`__

`Character devices <devref1.html#CHARDEVREF>`__

-  `testing for <fto.html#CHARDEVTEST>`__

`Checksum <filearchiv.html#CHECKSUMREF>`__

`Child processes <othertypesv.html#CHILDREF>`__

`Colon <special-chars.html#NULLREF>`__ , **:** , equivalent to the
`true <internal.html#TRUEREF>`__ Bash builtin

`Colorizing scripts <colorizing.html#COLORIZINGREF>`__

-  Cycling through the background colors, `example
   script <contributed-scripts.html#SHOWALLC>`__

-  `**Table** <colorizing.html#COLORIZTABLE>`__ of color escape
   sequences

-  `Template <colorizing.html#COLORIZTEMPL>`__ , colored text on colored
   background

`Comma operator <ops.html#COMMAOP>`__ , linking commands or operations

`Command-line options <bash-options.html>`__

`command\_not\_found\_handle () <bashver4.html#CNFH>`__ *builtin*
error-handling function ( `version 4+ <bashver4.html#BASH4REF>`__ of
Bash)

`Command substitution <commandsub.html#COMMANDSUBREF>`__

-  `**$( ... )** <commandsub.html#CSPARENS>`__ , preferred notation

-  `*Backquotes* <commandsub.html#BACKQUOTESREF>`__

-  `Extending the *Bash* toolset <commandsub.html#CSTOOLSET>`__

-  `Invokes a *subshell* <commandsub.html#CSSUBSH>`__

-  `Nesting <commandsub.html#CSNEST>`__

-  `Removes trailing newlines <commandsub.html#CSTRNL>`__

-  `Setting variable from loop output <commandsub.html#CSVL>`__

-  `Word splitting <commandsub.html#CSWS>`__

`Comment headers <assortedtips.html#COMMENTH>`__ , special purpose

Commenting out blocks of code

-  Using an `*anonymous* here document <here-docs.html#CBLOCK1>`__

-  Using an `*if-then* construct <assortedtips.html#COMOUTBL>`__

`Communications and hosts <communications.html>`__

`Compound comparison <comparison-ops.html#CCOMPARISON1>`__ operators

`Compression utilities <filearchiv.html#FACOMPRESSION1>`__

-  `bzip2 <filearchiv.html#BZIPREF>`__

-  `compress <filearchiv.html#COMPRESSREF>`__

-  `gzip <filearchiv.html#GZIPREF>`__

-  `zip <filearchiv.html#ZIPREF>`__

`continue <loopcontrol.html#BRKCONT1>`__ loop control command

`Control characters <special-chars.html#CONTROLCHARREF>`__

-  `Control-C <special-chars.html#CTLCREF>`__ , *break*

-  `Control-D <special-chars.html#CTLDREF>`__ , terminate / log out /
   erase

-  `Control-G <special-chars.html#CTLGREF>`__ ,
   ``                 BEL               `` ( *beep* )

-  `Control-H <special-chars.html#CTLHREF>`__ , *rubout*

-  `Control-J <special-chars.html#CTLJREF>`__ , *newline*

-  `Control-M <special-chars.html#CTLMREF>`__ , carriage return

`Coprocesses <bashver4.html#COPROCREF>`__

`cron <system.html#CRONREF>`__ , scheduling *daemon*

`*C* -style syntax <assortedtips.html#CSTYLE>`__ , for handling
variables

`Crossword puzzle solver <textproc.html#CWSOLVER>`__

`Cryptography <contributed-scripts.html#GRONSFELD>`__

Curly brackets {}

-  `in *find* command <moreadv.html#CURLYBRACKETSREF>`__

-  `in an *Extended Regular Expression* <x17129.html#ESCPCB>`__

-  `in *xargs* <moreadv.html#XARGSCURLYREF>`__

\* \* \*

`Daemons <communications.html#DAEMONREF>`__ , in UNIX-type OS

`date <timedate.html#DATEREF>`__

`dc <mathc.html#DCREF>`__ , calculator utility

`dd <extmisc.html#DDREF>`__ , *data duplicator* command

-  `Conversions <extmisc.html#DDCONVERSIONS>`__

-  `Copying raw data <extmisc.html#DDCOPY>`__ to/from devices

-  `File deletion <extmisc.html#DDFDEL>`__ , *secure*

-  `Keystrokes <extmisc.html#DDKEYSTROKES>`__ , capturing

-  `Options <extmisc.html#DDOPTIONS>`__

-  `Random access <extmisc.html#DDRANDOM>`__ on a data stream

-  *Raspberry Pi* , `script for preparing a bootable SD
   card <extmisc.html#RPSDCARD01>`__

-  `Swapfiles <extmisc.html#DDSWAP>`__ , initializing

-  `Thread on *www.linuxquestions.org* <biblio.html#DDLINK>`__

`Debugging scripts <debugging.html>`__

-  `Tools <debugging.html#DEBUGTOOLS>`__

-  `*Trapping* at exit <debugging.html#DEBUGTRAP>`__

-  `*Trapping* signals <debugging.html#TRAPREF1>`__

`Decimal number <numerical-constants.html#NUMCONSTANTS>`__ , Bash
interprets numbers as

`declare <declareref.html#DECLARE1REF>`__ builtin

-  `options <declareref.html#DECLAREOPSREF1>`__

   `case-modification <bashver4.html#DECLARECASEMOD>`__ options (
   `version 4+ <bashver4.html#BASH4REF>`__ of Bash)

`Default parameters <parameter-substitution.html#DEFPARAM>`__

```       /dev      `` <devproc.html#DEVPROCREF>`__ directory

-  ```         /dev/null        `` <zeros.html#DEVNULLREF>`__
   pseudo-device file

-  ```         /dev/urandom        `` <randomvar.html#URANDOMREF>`__
   pseudo-device file, generating pseudorandom numbers with

-  ```         /dev/zero        `` <zeros.html#ZEROSREF1>`__ ,
   pseudo-device file

`Device file <devref1.html#DEVFILEREF>`__

`*dialog* <assortedtips.html#DIALOGREF>`__ , utility for generating
*dialog* boxes in a script

```       $DIRSTACK      `` <internalvariables.html#DIRSTACKREF>`__
*directory stack*

`Disabled commands <restricted-sh.html#DISABLEDCOMMREF>`__ , in
*restricted shells*

`do <loops1.html#DOINREF>`__ keyword, begins execution of commands
within a `loop <loops.html#LOOPREF00>`__

`done <loops1.html#DOINREF>`__ keyword, terminates a loop

`*DOS* batch files <dosbatch.html#DOSBATCH1>`__ , converting to shell
scripts

`*DOS* commands <dosbatch.html#DOSUNIXEQUIV>`__ , UNIX equivalents of (
**table** )

`*dot files* <basic.html#DOTFILESREF>`__ , "hidden" setup and
configuration files

`Double brackets <testconstructs.html#DBLBRACKETS>`__ **[[ ... ]]**
`test <tests.html#IFTHEN>`__ construct

-  and `evaluation of *octal/hex*
   constants <testconstructs.html#DBLBRAEV>`__

`Double parentheses <dblparens.html#DBLPARENSREF>`__ **(( ... ))**
arithmetic expansion/evaluation construct

`Double quotes <varsubn.html#DBLQUO>`__ **" ... "** *weak* quoting

-  `*Double-quoting* the *backslash* ( **\\** )
   character <quotingvar.html#QUOTINGBSL>`__

`Double-spacing a text file <x23170.html#DOUBLESPACE>`__ , using
`sed <sedawk.html#SEDREF>`__

\* \* \*

**-e** `File exists <fto.html#RTIF>`__ test

`echo <internal.html#ECHOREF>`__

-  `Feeding commands down a *pipe* <internal.html#ECHOGREPREF>`__

-  `Setting a variable <internal.html#ECHOCS>`__ using `command
   substitution <commandsub.html#COMMANDSUBREF>`__

-  ```         /bin/echo        `` <internal.html#BINECHO>`__ , external
   *echo* command

`elif <testconstructs.html#ELIFREF1>`__ , Contraction of *else* and
`if <tests.html#IFTHEN>`__

`else <testconstructs.html#ELSEREF>`__

Encrypting files, using `openssl <filearchiv.html#OPENSSLREF>`__

`esac <testbranch.html#CASEESAC1>`__ , keyword terminating *case*
construct

`*Environmental* variables <othertypesv.html#ENVREF>`__

`-eq <comparison-ops.html#EQUALREF>`__ , *is-equal-to* `integer
comparison <comparison-ops.html#ICOMPARISON1>`__ test

`Eratosthenes, Sieve of <arrays.html#PRIMES0>`__ , algorithm for
generating prime numbers

`Escaped characters <escapingsection.html#SPM>`__ , special meanings of

-  Within `$' ... ' <escapingsection.html#STRQ>`__ string expansion

-  `Used with *Unicode* characters <bashver4.html#UNICODEREF2>`__

```       /etc/fstab      `` <system.html#FSTABREF>`__ (filesystem
mount) file

```       /etc/passwd      `` <files.html#DATAFILESREF1>`__ (user
account) file

```       $EUID      `` <internalvariables.html#EUIDREF>`__ , *Effective
user ID*

`eval <internal.html#EVALREF>`__ , Combine and *evaluate* expression(s),
with variable expansion

-  `Effects of <internal.html#EVALEFF>`__ , *Example script*

-  `Forces *reevaluation* <internal.html#EVALFORCED>`__ of arguments

-  And `indirect references <ivr.html#EVALINDREF>`__

-  `Risk of using <internal.html#EVALRISK>`__

-  `Using *eval* to convert *array* elements into a command
   list <contributed-scripts.html#SAMORSE>`__

-  `Using *eval* to select among variables <internal.html#ARRCHOICE0>`__

`Evaluation of *octal/hex* constants within [[ ...
]] <testconstructs.html#DBLBRAEV>`__

`exec <x17974.html#USINGEXECREF>`__ command, using in
`redirection <io-redirection.html#IOREDIRREF>`__

`Exercises <exercises.html>`__

Exit and Exit status

-  `exit <exit-status.html#EXITCOMMANDREF>`__ command

-  `Exit status <exit-status.html#EXITSTATUSREF>`__ ( *exit code* ,
   *return* status of a command)

   `**Table** <exitcodes.html#EXITCODESREF>`__ , *Exit codes* with
   special meanings

   `Anomalous <gotchas.html#GOTCHAEXITVALANAMALIES>`__

   `Out of range <exitcodes.html#EXCOOR>`__

   `*Pipe* <exit-status.html#PIPEEX>`__ exit status

   `Specified by a *function return* <complexfunct.html#EXITRETURN1>`__

   `*Successful* <exit-status.html#EXITSUCCESS>`__ , **0**

   ```         /usr/include/sysexits.h        `` <exitcodes.html#SYSEXITSREF>`__
   , system file listing C/C++ standard exit codes

`Export <internal.html#EXPORTREF2>`__ , to make available variables to
`child processes <othertypesv.html#CHILDREF>`__

-  `Passing a variable to an embedded *awk*
   script <internal.html#EXPORTAWK>`__

`expr <moreadv.html#EXPRREF>`__ , *Expression* evaluator

-  `Substring extraction <moreadv.html#EXPEXTRSUB>`__

-  `Substring *index* (numerical position in
   string) <string-manipulation.html#SUBSTRINGINDEX2>`__

-  `Substring matching <string-manipulation.html#EXPRMATCH>`__

`Extended *Regular Expressions* <x17129.html#EXTREGEX>`__

-  **?** (question mark) `Match zero / one
   characters <x17129.html#QUEXREGEX>`__

-  **( ... )** `Group of expressions <x17129.html#PARENGRPS>`__

-  **\\{ N \\}** ` "Curly" brackets <x17129.html#ESCPCB>`__ , *escaped*
   , number of character sets to match

-  **+** `*Character match* <x17129.html#PLUSREF>`__

\* \* \*

`factor <mathc.html#FACTORREF>`__ , decomposes an integer into its prime
factors

-  Application: `Generating prime numbers <mathc.html#PRIMES2>`__

`false <internal.html#FALSEREF>`__ , returns *unsuccessful* (1) `exit
status <exit-status.html#EXITSTATUSREF>`__

`Field <special-chars.html#FIELDREF>`__ , a group of characters that
comprises an item of data

`Files / Archiving <filearchiv.html>`__

`File descriptors <io-redirection.html#FDREF>`__

-  `Closing <io-redirection.html#CFD>`__

   **n<&-** Close input file descriptor *n*

   **0<&-** , **<&-** Close ``        stdin       ``

   **n>&-** Close output file descriptor *n*

   **1>&-** , **>&-** Close ``        stdout       ``

-  `File handles in *C* <io-redirection.html#FDREF1>`__ , similarity to

`File encryption <filearchiv.html#OPENSSLREF>`__

`find <moreadv.html#FINDREF>`__

-  **{}** `Curly brackets <moreadv.html#CURLYBRACKETSREF>`__

-  **\\;** `*Escaped* semicolon <moreadv.html#FINDREF0>`__

`Filter <special-chars.html#FILTERDEF>`__

-  `Using - with file-processing utility as a
   filter <special-chars.html#FILTERDASH>`__

-  `Feeding output of a filter back to *same*
   filter <assortedtips.html#FILTEROUTP>`__

`Floating point numbers <ops.html#NOFLOATINGPOINT>`__ , Bash does not
recognize

`fold <textproc.html#FOLDREF>`__ , a filter to wrap lines of text

`Forking <internal.html#FORKREF>`__ a *child* process

`*for* loops <loops1.html#FORLOOPREF1>`__

`Functions <functions.html#FUNCTIONREF>`__

-  `Arguments passed <complexfunct.html#PASSEDARGS>`__ referred to by
   position

-  `Capturing the return value <complexfunct.html#CAPTURERETVAL>`__ of a
   function using `echo <internal.html#ECHOREF>`__

-  `*Colon* <special-chars.html#COLONFNAME>`__ as function name

-  `Definition must precede <functions.html#FUNCTDEFMUST>`__ first call
   to function

-  `Exit status <complexfunct.html#EXITRETURN1>`__

-  `Local variables <localvar.html#LOCALREF1>`__

   and `recursion <localvar.html#LOCVARRECUR>`__

-  `Passing an *array* <assortedtips.html#PASSARRAY>`__ to a function

-  `Passing pointers <complexfunct.html#FUNCPOINTERS>`__ to a function

-  `Positional parameters <complexfunct.html#PASSEDARGS>`__

-  `Recursion <localvar.html#RECURSIONREF0>`__

-  `Redirecting
   ``         stdin        `` <complexfunct.html#REDSTDINFUNC1>`__ of a
   function

-  `return <complexfunct.html#RETURNREF>`__

   Multiple *return values* from a function, `example
   script <contributed-scripts.html#STDDEV>`__

   `Returning an *array* <assortedtips.html#RETARRAY>`__ from a function

   `*Return* range limits <assortedtips.html#RVT>`__ , workarounds

-  `*Shift* arguments passed <complexfunct.html#FSHIFTREF>`__ to a
   function

-  `Unusual function names <functions.html#FSTRANGEREF>`__

\* \* \*

Games and amusements

-  `Anagrams <assortedtips.html#AGRAM>`__

-  `Anagrams <commandsub.html#AGRAM2>`__ , again

-  `Bingo Number Generator <contributed-scripts.html#BINGO>`__

-  `Crossword puzzle solver <textproc.html#CWSOLVER>`__

-  `Crypto-Quotes <textproc.html#CRYPTOQUOTE>`__

-  `Dealing a deck of cards <bashver2.html#CARDS>`__

-  `Fifteen Puzzle <contributed-scripts.html#FIFTEEN>`__

-  `Horse race <colorizing.html#HORSERACE>`__

-  `Knight's Tour <contributed-scripts.html#KTOUR>`__

-  ` "Life" game <contributed-scripts.html#LIFESLOW>`__

-  `Magic Squares <contributed-scripts.html#MSQUARE>`__

-  `Music-playing script <devref1.html#MUSICSCR>`__

-  `Nim <contributed-scripts.html#NIM>`__

-  `Pachinko <randomvar.html#BROWNIAN>`__

-  `Perquackey <contributed-scripts.html#QKY>`__

-  `Petals Around the Rose <contributed-scripts.html#PETALS>`__

-  `Podcasting <contributed-scripts.html#BASHPODDER>`__

-  `Poem <arrays.html#POEM>`__

-  `Speech generation <wrapper.html#SPEECH00>`__

-  `Towers of Hanoi <recurnolocvar.html#HANOI>`__

   `Graphic version <contributed-scripts.html#HANOI2>`__

   `Alternate graphic version <contributed-scripts.html#HANOI2A>`__

`getopt <extmisc.html#GETOPTY>`__ , *external* command for parsing
script *command-line* arguments

-  `Emulated in a script <string-manipulation.html#GETOPTSIMPLE1>`__

`getopts <internal.html#GETOPTSX>`__ , Bash *builtin* for parsing script
*command-line* arguments

-  ```         $OPTIND        `` /
   ``         $OPTARG        `` <internal.html#GETOPTSOPT>`__

`Global <subshells.html#SCOPEREF>`__ variable

`Globbing <globbingref.html#GLOBBINGREF2>`__ , filename expansion

-  `Handling filenames correctly <globbingref.html#HANDLINGFNAMES>`__

-  `*Wild cards* <special-chars.html#ASTERISKREF>`__

-  `Will not match
   ``         dot files        `` <globbingref.html#WDOTFILEWC>`__

`Golden Ratio <mathc.html#GOLDENRATIO>`__ ( *Phi* )

`-ge <comparison-ops.html#GE0REF>`__ , *greater-than or equal* `integer
comparison <comparison-ops.html#ICOMPARISON1>`__ test

`-gt <comparison-ops.html#GT0REF>`__ , *greater-than* `integer
comparison <comparison-ops.html#ICOMPARISON1>`__ test

`*groff* <textproc.html#GROFFREF>`__ , text markup and formatting
language

`Gronsfeld cipher <contributed-scripts.html#GRONSFELD>`__

```       $GROUPS      `` <internalvariables.html#GROUPSREF>`__ ,
*Groups* user belongs to

`gzip <filearchiv.html#GZIPREF>`__ , compression utility

\* \* \*

`Hashing <internal.html#HASHREF>`__ , creating lookup keys in a table

-  `*Example script* <contributed-scripts.html#HASHEX2_0>`__

`head <textproc.html#HEADREF>`__ , *echo* to ``      stdout     `` lines
at the beginning of a text file

`help <internal.html#HELPREF>`__ , gives usage summary of a Bash
`builtin <internal.html#BUILTINREF>`__

`*Here* documents <here-docs.html#HEREDOCREF>`__

-  `*Anonymous* here documents <here-docs.html#ANONHEREDOC0>`__ , using
   **:**

   `Commenting out <here-docs.html#CBLOCK1>`__ blocks of code

   `Self-documenting <here-docs.html#HSELFDOC>`__ scripts

-  `*bc* in a *here document* <mathc.html#BCHEREDOC>`__

-  `*cat* scripts <here-docs.html#CATSCRIPTREF>`__

-  `Command substitution <here-docs.html#HERECS>`__

-  `*ex* scripts <here-docs.html#EXSCRIPTREF>`__

-  `*Function* <here-docs.html#HEREFUNC>`__ , supplying input to

-  `*Here* strings <x17837.html#HERESTRINGSREF>`__

   Calculating the `Golden Ratio <mathc.html#GOLDENRATIO>`__

   `Prepending text <x17837.html#HSPRE>`__

   `As the ``         stdin        `` of a
   *loop* <x17837.html#HSLOOP>`__

   `Using *read* <x17837.html#HSREAD>`__

-  `*Limit* string <here-docs.html#LIMITSTRINGREF>`__

   ` ! as a *limit string* <here-docs.html#EXCLLS>`__

   `Closing *limit string* <here-docs.html#INDENTEDLS>`__ may not be
   indented

   `Dash option <here-docs.html#LIMITSTRDASH>`__ to limit string,
   ``        <<-LimitString       ``

-  `Literal text output <here-docs.html#HERELIT>`__ , for generating
   program code

-  `Parameter substitution <here-docs.html#HEREPARAMSUB>`__

   `Disabling <here-docs.html#HEREESC>`__ *parameter substitution*

-  `Passing parameters <here-docs.html#HEREPASSP>`__

-  `Temporary files <here-docs.html#HERETEMP>`__

-  `Using *vi* non-interactively <here-docs.html#VIHERE>`__

`History commands <histcommands.html>`__

```       $HOME      `` <internalvariables.html#HOMEDIRREF>`__ , *user's
home directory*

`Homework assignment solver <contributed-scripts.html#HOMEWORK>`__

```       $HOSTNAME      `` <internalvariables.html#HOSTNAMEREF>`__ ,
system *host name*

\* \* \*

```       $Id      `` parameter <assortedtips.html#RCSREF>`__ , in *rcs*
(Revision Control System)

`if [ condition ]; then ... <tests.html#IFTHEN>`__ *test* construct

-  `if-grep <testconstructs.html#IFGREPREF>`__ , *if* and
   `grep <textproc.html#GREPREF>`__ in combination

   `Fixup <assortedtips.html#IFGREPFIX>`__ for *if-grep* test

```       $IFS      `` <internalvariables.html#IFSREF>`__ , *Internal
field separator* variable

-  `Defaults to *whitespace* <internalvariables.html#IFSWS>`__

`Integer comparison operators <comparison-ops.html#ICOMPARISON1>`__

`in <loops1.html#DOINREF>`__ , *keyword* preceding ``      [list]     ``
in a *for* loop

`Initialization table <system.html#INITTABREF>`__ ,
``      /etc/inittab     ``

`Inline group <special-chars.html#CODEBLOCKREF>`__ , i.e., code block

`Interactive script <intandnonint.html#IITEST>`__ , test for

`I/O redirection <io-redirection.html#IOREDIRREF>`__

`Indirect referencing of variables <ivr.html#IVRREF>`__

-  `New notation <ivr.html#IVR2>`__ , introduced in `version
   2 <bashver2.html#BASH2REF>`__ of Bash ( `example
   script <bashver2.html#VARREFNEW>`__ )

`iptables <system.html#IPTABLESREF>`__ , packet filtering and firewall
utility

-  `Usage example <system.html#IPTABLES01>`__

-  `Example script <networkprogramming.html#IPTABLES02>`__

`Iteration <loops1.html#ITERATIONREF>`__

\* \* \*

`Job IDs <x9644.html#JOBIDTABLE0>`__ , table

`jot <extmisc.html#JOTREF>`__ , Emit a sequence of integers. Equivalent
to `seq <extmisc.html#SEQREF>`__ .

-  `Random sequence generation <extmisc.html#JOTRANDOM>`__

`Just another Bash hacker! <textproc.html#JABH>`__

\* \* \*

`Keywords <internal.html#KEYWORDREF>`__

-  `error <debugging.html#MISSINGKEYWORD>`__ , if missing

`kill <x9644.html#KILLREF>`__ , terminate a process by `process
ID <special-chars.html#PROCESSIDDEF>`__

-  `Options <x9644.html#ZOMBIEREF>`__ ( ``        -l       `` ,
   ``        -9       `` )

`killall <x9644.html#KILLALLREF>`__ , terminate a process *by name*

`*killall script* <sysscripts.html#KILLALL2REF>`__ in
``      /etc/rc.d/init.d     ``

\* \* \*

`lastpipe <bashver4.html#LASTPIPEREF>`__ shell option

`-le <comparison-ops.html#LE0REF>`__ , *less-than or equal* `integer
comparison <comparison-ops.html#ICOMPARISON1>`__ test

`let <internal.html#LETREF>`__ , setting and carrying out arithmetic
operations on variables

-  *C-style* `increment and decrement operators <internal.html#EX46>`__

`Limit string <here-docs.html#LIMITSTRINGREF>`__ , in a `here
document <here-docs.html#HEREDOCREF>`__

```       $LINENO      `` <internalvariables.html#LINENOREF>`__ ,
variable indicating the *line number* where it appears in a script

`Link <basic.html#LINKREF>`__ , file (using *ln* command)

-  `Invoking script with multiple names <basic.html#LINKMINVOK>`__ ,
   using *ln*

-  `*symbolic* links <basic.html#SYMLINKREF>`__ , *ln -s*

`List constructs <list-cons.html#LISTCONSREF>`__

-  `*And* list <list-cons.html#LCONS1>`__

-  `*Or* list <list-cons.html#ORLISTREF>`__

`Local variables <localvar.html#LOCALREF1>`__

-  and `recursion <localvar.html#LOCVARRECUR>`__

`Localization <localization.html>`__

`Logical operators <ops.html#LOGOPS1>`__ ( ``      &&     `` ,
``      ||     `` , etc.)

`Logout file <files.html#LOGOUTFILEREF1>`__ , the
``      ~/.bash_logout     `` file

`Loopback device <system.html#ISOMOUNTREF0>`__ , mounting a file on a
`block device <devref1.html#BLOCKDEVREF>`__

`Loops <loops1.html>`__

-  `break <loopcontrol.html#BRKCONT1>`__ loop control command

-  `continue <loopcontrol.html#BRKCONT1>`__ loop control command

-  *C* -style loop within `double
   parentheses <dblparens.html#DBLPARENSREF>`__

   `*for* loop <loops1.html#LOOPCSTYLE>`__

   `*while* loop <loops1.html#WLOOPCSTYLE>`__

-  `do <loops1.html#DOINREF>`__ (keyword), begins execution of commands
   within a loop

-  `done <loops1.html#DOINREF>`__ (keyword), terminates a loop

-  `*for* loops <loops1.html#FORLOOPREF1>`__

   ``                 for               `` ``        arg       ``
   ``                 in               `` ``        [list]       `` ;
   ``                 do               ``

   `*Command substitution* to generate
   ``         [list]        `` <loops1.html#LOOPCS>`__

   `Filename expansion in
   ``         [list]        `` <loops1.html#LIGLOB>`__

   `Multiple parameters in each ``         [list]        ``
   element <loops1.html#MULTPARAML>`__

   `Omitting ``         [list]        `` <loops1.html#OMITLIST>`__ ,
   defaults to `positional
   parameters <internalvariables.html#POSPARAMREF>`__

   `Parameterizing ``         [list]        `` <loops1.html#PARAMLI>`__

   `Redirection <loops1.html#LOOPREDIR>`__

-  `in <loops1.html#DOINREF>`__ , (keyword) preceding [list] in a *for*
   loop

-  `Nested loops <nestedloops.html>`__

-  `Running a loop *in the background* <special-chars.html#BGLOOP0>`__ ,
   *script example*

-  Semicolon required, when *do* is on first line of loop

   `*for* loop <loops1.html#NEEDSEMICOLON>`__

   `*while* loop <loops1.html#WHILENEEDSEMI>`__

-  `until <loops1.html#UNTILLOOPREF>`__ loop

   ``                 until [ condition-is-true ]; do               ``

-  `while <loops1.html#WHILELOOPREF>`__ loop

   ``                 while [ condition ]; do               ``

   `Function call <loops1.html#WHILEFUNC>`__ inside test brackets

   `Multiple conditions <loops1.html#WHMULTCOND>`__

   `Omitting *test brackets* <loops1.html#WHILENOBRACKETS>`__

   `Redirection <loops1.html#WHREDIR>`__

   `*while read* <loops1.html#WHILEREADREF2>`__ construct

-  `Which type of loop to use <loops1.html#CHOOSELOOP>`__

Loopback devices

-  `In ``         /dev        `` directory <devref1.html#LOOPBACKREF>`__

-  `Mounting an ISO image <system.html#ISOMOUNTREF0>`__

`-lt <comparison-ops.html#LT0REF>`__ , *less-than* `integer
comparison <comparison-ops.html#ICOMPARISON1>`__ test

\* \* \*

`m4 <extmisc.html#M4REF>`__ , macro processing language

```       $MACHTYPE      `` <internalvariables.html#MACHTYPEREF>`__ ,
*Machine type*

`Magic number <sha-bang.html#MAGNUMREF>`__ , marker at the head of a
file indicating the file type

```       Makefile      `` <filearchiv.html#MAKEFILEREF>`__ , file
containing the list of dependencies used by
`make <filearchiv.html#MAKEREF>`__ command

`man <basic.html#MANREF>`__ , *manual page* (lookup)

-  `*Man page* editor <contributed-scripts.html#MANED>`__ (script)

`mapfile <bashver4.html#MAPFILEREF>`__ builtin, loads an array with a
text file

`Math commands <mathc.html>`__

`Meta-meaning <x17129.html#METAMEANINGREF>`__

`Morse code training <contributed-scripts.html#SAMORSE>`__ script

`Modulo <ops.html#MODULOREF>`__ , arithmetic *remainder* operator

-  Application: `Generating prime
   numbers <contributed-scripts.html#PRIMES1>`__

`Mortgage calculations <mathc.html#MONTHLYPMT0>`__ , *example script*

\* \* \*

**-n** `String not *null* <comparison-ops.html#STRINGNOTNULL>`__ test

`Named pipe <extmisc.html#NAMEDPIPEREF>`__ , a temporary FIFO buffer

-  `*Example script* <contributed-scripts.html#ZFIFO>`__

`nc <system.html#NCREF>`__ , *netcat* , a network toolkit for TCP and
UDP ports

`-ne <comparison-ops.html#NEQUALREF>`__ , *not-equal-to* `integer
comparison <comparison-ops.html#ICOMPARISON1>`__ test

`Negation operator <special-chars.html#NOTREF>`__ , **!** , reverses the
sense of a `test <tests.html#IFTHEN>`__

`netstat <system.html#NETSTATREF>`__ , Network statistics

`Network programming <networkprogramming.html>`__

`nl <textproc.html#NLREF>`__ , a filter to number lines of text

`*Noclobber* <options.html#NOCLOBBERREF>`__ , ``      -C     `` option
to Bash to prevent overwriting of files

`*NOT* logical operator <ops.html#LOGOPS1>`__ , **!**

`*null* variable assignment <othertypesv.html#NULLVAR>`__ , avoiding

\* \* \*

**-o** `Logical OR <comparison-ops.html#COMPOUNDOR>`__ compound
comparison test

Obfuscation

-  `*Colon* <special-chars.html#COLONFNAME>`__ as function name

-  `Homework assignment <contributed-scripts.html#HOMEWORK>`__

-  `Just another Bash hacker! <textproc.html#JABH>`__

`octal <escapingsection.html#OCTALREF>`__ , base-8 numbers

`od <extmisc.html#ODREF>`__ , *octal dump*

```       $OLDPWD      `` <internalvariables.html#OLDPWD>`__ Previous
working directory

`openssl <filearchiv.html#OPENSSLREF>`__ encryption utility

Operator

-  `Definition of <special-chars.html#OPERATORDEF>`__

-  `Precedence <opprecedence.html#OPPRECEDENCE1>`__

`Options <options.html#OPTIONSREF>`__ , passed to shell or script on
command line or by `set <internal.html#SETREF>`__ command

`*Or* list <list-cons.html#ORLISTREF>`__

`*Or* logical operator <ops.html#ORREF>`__ , **\|\|**

\* \* \*

`Parameter substitution <parameter-substitution.html#PARAMSUBREF>`__

-  *${parameter+alt\_value}*

   *${parameter:+alt\_value}*

   `Alternate value <parameter-substitution.html#PARAMALTV>`__ of
   parameter, if set

-  *${parameter-default}*

   *${parameter:-default}*

   *${parameter=default}*

   *${parameter:=default}*

   `Default parameters <parameter-substitution.html#DEFPARAM1>`__

-  *${!varprefix\*}*

   *${!varprefix@}*

   `Parameter *name* match <parameter-substitution.html#VARPREFIXM>`__

-  *${parameter?err\_msg}*

   `Parameter-unset message <parameter-substitution.html#QERRMSG>`__

-  *${parameter}*

   `Value of *parameter* <parameter-substitution.html#PSSUB1>`__

-  `*Case modification* <bashver4.html#CASEMODPARAMSUB>`__ ( `version
   4+ <bashver4.html#BASH4REF>`__ of Bash).

-  `*Script example* <contributed-scripts.html#PW0>`__

-  `**Table** <refcards.html#PARSUBTAB>`__ of *parameter substitution*

`Parent / child process problem <gotchas.html#PARCHILDPROBREF>`__ , a
*child* process cannot `export <internal.html#EXPORTREF>`__ variables to
a `parent process <internal.html#FORKREF>`__

Parentheses

-  `Command group <special-chars.html#PARENSREF>`__

-  `Enclose group <x17129.html#PARENGRPS>`__ of *Extended Regular
   Expressions*

-  `Double parentheses <dblparens.html#DBLPARENSREF>`__ , in arithmetic
   expansion

```       $PATH      `` <internalvariables.html#PATHREF>`__ , the *path*
(location of system binaries)

-  Appending directories to ``        $PATH       `` `using the
   ``         +=        `` operator <bashver3.html#PATHAPPEND>`__ .

`Pathname <special-chars.html#PATHNAMEREF>`__ , a
``      filename     `` that incorporates the complete *path* of a given
file.

-  `Parsing *pathnames* <pathmanagement.html>`__

`Perl <wrapper.html#PERLREF>`__ , programming language

-  `Combined <wrapper.html#BASHANDPERL0>`__ in the same file with a
   *Bash* script

-  `Embedded <wrapper.html#PERLEMB>`__ in a *Bash* script

`*Perquackey* -type anagramming game <contributed-scripts.html#QKY>`__ (
*Quackey* script)

`*Petals Around the Rose* <contributed-scripts.html#PETALS>`__

`PID <special-chars.html#PROCESSIDDEF>`__ , *Process ID* , an
identification number assigned to a running process.

`Pipe <special-chars.html#PIPEREF>`__ , **\|** , a device for passing
the output of a command to another command or to the shell

-  `Avoiding unnecessary commands <optimizations.html#CATABUSE>`__ in a
   *pipe*

-  `*Comments* embedded within <special-chars.html#COMMINPIPE>`__

-  `Exit status <exit-status.html#PIPEEX>`__ of a pipe

-  `Pipefail <bashver3.html#PIPEFAILREF>`__ , *set -o pipefail* option
   to indicate `exit status <exit-status.html#EXITSTATUSREF>`__ within a
   *pipe*

-  ```         $PIPESTATUS        `` <internalvariables.html#PIPESTATUSREF>`__
   , *exit status* of last executed pipe

-  `Piping output of a command <special-chars.html#UCREF>`__ to a script

-  `Redirecting ``         stdin        `` <basic.html#CATLESSEFF>`__ ,
   rather than using `cat <basic.html#CATREF>`__ in a *pipe*

`Pitfalls <gotchas.html>`__

-  `**-** (dash) is *not* redirection
   operator <gotchas.html#DASHNREDR>`__

-  `**//** (double forward slash) <internal.html#DOUBLESLASHREF>`__ ,
   behavior of `cd <internal.html#CDREF>`__ command toward

-  ` #!/bin/sh  <gotchas.html#BINSH>`__ script header disables `extended
   *Bash* features <portabilityissues.html#BASHCOMPAT>`__

-  `Abuse of *cat* <optimizations.html#CATABUSE>`__

-  `*CGI* programming <gotchas.html#CGIREF>`__ , using scripts for

-  Closing *limit string* in a *here document* ,
   `indenting <here-docs.html#INDENTEDLS>`__

-  `DOS-type newlines ( \\r\\n ) <gotchas.html#DOSNEWLINES>`__ crash a
   script

-  `*Double-quoting* the *backslash* ( **\\** )
   character <quotingvar.html#QUOTINGBSL>`__

-  `eval <internal.html#EVALRISK>`__ , risk of using

-  `Execute permission lacking <gotchas.html#EXECPERM>`__ for commands
   within a script

-  *Exit status* , `anomalous <gotchas.html#GOTCHAEXITVALANAMALIES>`__

-  *Exit status* `of arithmetic expression *not* equivalent to an *error
   code* <gotchas.html#ARXS1>`__

-  `*Export* problem <gotchas.html#PARCHILDPROBREF>`__ , *child* process
   to *parent* process

-  `Extended *Bash* features <gotchas.html#LATEVERF>`__ not available

-  `Failing to *quote* variables <gotchas.html#FAILQUOTE>`__ within
   *test* brackets

-  `*GNU* command set <gotchas.html#GNUREF>`__ , in cross-platform
   scripts

-  *let* misuse: `attempting to set string
   variables <gotchas.html#LETBAD>`__

-  `Multiple echo statements <gotchas.html#RVTCAUTION2>`__ in a
   `function whose output is captured <assortedtips.html#RVT>`__

-  `*null* variable assignment <othertypesv.html#NULLVAR>`__

-  `Numerical and string comparison
   operators <gotchas.html#NUMSTRCOMPNE>`__ *not* equivalent

   `**=** and **-eq** <gotchas.html#EQDIF>`__ *not* interchangeable

-  `Omitting terminal *semicolon* <gotchas.html#OMITSEMICOLON>`__ , in a
   *curly-bracketed* `code block <special-chars.html#CODEBLOCKREF>`__

-  Piping

   `*echo* to a loop <gotchas.html#PIPELOOP>`__

   `*echo* to *read* <gotchas.html#BADREAD0>`__ (however, this problem
   `can be circumvented <process-sub.html#GOODREAD0>`__ )

   `*tail* ``         -f        `` to *grep* <gotchas.html#PTAILGREP>`__

-  Preserving *whitespace* within a variable, `unintended
   consequences <quotingvar.html#VARSPLITTING>`__

-  `*suid* commands inside a script <gotchas.html#SUIDSCR>`__

-  `Undocumented *Bash* features <gotchas.html#UNDOCF>`__ , danger of

-  Updates to *Bash* `breaking older
   scripts <gotchas.html#UPDATEBREAKS>`__

-  `Uninitialized variables <gotchas.html#UNINITVAR>`__

-  `Variable names <gotchas.html#INAPPVN>`__ , inappropriate

-  `Variables in a *subshell* <gotchas.html#VARSUBSH>`__ , *scope*
   limited

-  `Subshell in *while-read* loop <gotchas.html#BADREAD0>`__

-  `Whitespace <gotchas.html#WSBAD>`__ , misuse of

Pointers

-  `and file descriptors <io-redirection.html#FDREF1>`__

-  `and functions <complexfunct.html#FUNCPOINTERS>`__

-  `and *indirect references* <ivr.html#IRRREF>`__

-  `and *variables* <varsubn.html#POINTERREF>`__

`Portability issues <portabilityissues.html>`__ in shell scripting

-  `Setting *path* and *umask* <assortedtips.html#SETPUM>`__

-  `A *test suite* script <portabilityissues.html#TESTSUITE0>`__ (Bash
   versus classic Bourne shell)

-  `Using *whatis* <assortedtips.html#WHATISREF3>`__

`Positional parameters <othertypesv.html#POSPARAMREF1>`__

-  ```         $@        `` <internalvariables.html#APPREF2>`__ , as
   *separate* words

-  ```         $*        `` <internalvariables.html#APPREF>`__ , as a
   *single* word

-  `in functions <complexfunct.html#PASSEDARGS>`__

` POSIX  <sha-bang.html#POSIX2REF>`__ , *Portable Operating System
Interface / UNIX*

-  ```         --posix        ``
   option <portabilityissues.html#POSIX3REF>`__

-  `1003.2 standard <portabilityissues.html#POSIX3REF>`__

-  `Character classes <x17129.html#POSIXREF>`__

```       $PPID      `` <internalvariables.html#PPIDREF>`__ , *process
ID* of parent process

`Precedence <opprecedence.html#OPPRECEDENCE1>`__ , operator

`*Prepending* <assortedtips.html#PREPENDREF>`__ lines at head of a file,
*script example*

Prime numbers

-  Generating primes `using the *factor* command <mathc.html#PRIMES2>`__

-  Generating primes `using the *modulo*
   operator <contributed-scripts.html#PRIMES1>`__

-  Sieve of Eratosthenes, `example script <arrays.html#PRIMES0>`__

`printf <internal.html#PRINTFREF>`__ , *formatted print* command

```       /proc      `` <procref1.html#PROCREF2>`__ directory

-  `Running processes <procref1.html#PROCRUNNING>`__ , files describing

-  `Writing to files in
   ``         /proc        `` <procref1.html#PROCWARNING>`__ , *warning*

`Process <special-chars.html#PROCESSREF>`__

-  `Child process <othertypesv.html#CHILDREF2>`__

-  `Parent process <internal.html#PARENTREF>`__

-  `Process ID <special-chars.html#PROCESSIDDEF>`__ (PID)

`Process substitution <process-sub.html#PROCESSSUBREF>`__

-  `To compare contents of directories <process-sub.html#PCC2DIR>`__

-  `To supply ``         stdin        `` of a
   command <process-sub.html#PSFDSTDIN>`__

-  `Template <process-sub.html#COMMANDSPARENS1>`__

-  `*while-read* loop without a
   *subshell* <process-sub.html#GOODREAD0>`__

`Programmable completion <tabexpansion.html>`__ (tab expansion)

Prompt

-  ```         $PS1        `` <internalvariables.html#PS1REF>`__ , *Main
   prompt* , seen at command line

-  ```         $PS2        `` <internalvariables.html#SECPROMPTREF>`__ ,
   Secondary prompt

`Pseudo-code <assortedtips.html#PSEUDOCODEREF>`__ , as problem-solving
method

```       $PWD      `` <internalvariables.html#PWDREF>`__ , Current
working directory

\* \* \*

`Quackey <contributed-scripts.html#QKY>`__ , a *Perquackey* -type
anagramming game (script)

Question mark, **?**

-  `Character match <x17129.html#QUEXREGEX>`__ in an Extended *Regular
   Expression*

-  `Single-character *wild card* <special-chars.html#QUEXWC>`__ , in
   `globbing <globbingref.html>`__

-  In a `*C* -style Trinary (ternary)
   operator <special-chars.html#CSTRINARY>`__

`Quoting <quoting.html#QUOTINGDEF>`__

-  `Character string <quoting.html#QUOTINGREF>`__

-  `Variables <quotingvar.html>`__

   `within *test* brackets <gotchas.html#FAILQUOTE>`__

-  `*Whitespace* <quotingvar.html#WSQUO>`__ , using *quoting* to
   preserve

\* \* \*

Random numbers

-  ```         /dev/urandom        `` <randomvar.html#URANDOMREF>`__

-  ```         rand()        `` <randomvar.html#AWKRANDOMREF>`__ ,
   random function in `awk <awk.html#AWKREF>`__

-  ```         $RANDOM        `` <randomvar.html#RANDOMVAR01>`__ , Bash
   function that returns a pseudorandom integer

-  `Random sequence generation <timedate.html#DATERANDREF>`__ , using
   `date <timedate.html#DATEREF>`__ command

-  `Random sequence generation <extmisc.html#JOTRANDOM>`__ , using
   `jot <extmisc.html#JOTREF>`__

-  `Random string <string-manipulation.html#RANDSTRING0>`__ , generating

Raspberry Pi (single-board computer)

-  `Script for preparing a bootable SD card <extmisc.html#RPSDCARD01>`__

`rcs <assortedtips.html#RCSREF>`__

`read <internal.html#READREF>`__ , set value of a variable from
```       stdin      `` <ioredirintro.html#STDINOUTDEF>`__

-  `Detecting *arrow* keys <internal.html#READARROW>`__

-  `Options <internal.html#READOPTIONS>`__

-  `Piping output of *cat* <internal.html#READPIPEREF>`__ to *read*

-  ` "Prepending" text <x17837.html#HSREAD>`__

-  `Problems piping *echo* <gotchas.html#BADREAD0>`__ to *read*

-  `Redirection from a file <internal.html#READREDIR0>`__ to *read*

-  ```         $REPLY        `` <internalvariables.html#REPLYREF>`__ ,
   default *read* variable

-  `Timed input <internal.html#READTIMED>`__

-  `*while read* <loops1.html#WHILEREADREF2>`__ construct

`readline <internal.html#READLINEREF>`__ library

`Recursion <localvar.html#RECURSIONREF>`__

-  `Demonstration of <localvar.html#RECURSIONDEMO0>`__

-  `Factorial <localvar.html#FACTORIALREF>`__

-  `Fibonacci sequence <recurnolocvar.html#FIBOREF>`__

-  `Local variables <localvar.html#LOCVARRECUR>`__

-  `Script calling itself
   recursively <recursionsct.html#SCRIPTRECURSION>`__

-  `Towers of Hanoi <recurnolocvar.html#HANOIREF>`__

Redirection

-  `Code blocks <redircb.html#REDIRREF>`__

-  `exec < ``         filename        `` <x17974.html#USINGEXECREF>`__ ,

   to reassign `file descriptors <io-redirection.html#FDREF>`__

-  `Introductory-level explanation <ioredirintro.html>`__ of *I/O
   redirection*

-  `Open a file <io-redirection.html#IOREDIRECTIONREF2>`__ for *both*
   reading and writing

   ``        <>filename       ``

-  `*read* input redirected <internal.html#READREDIR0>`__ from a file

-  ```         stderr        `` to
   ``         stdout        `` <io-redirection.html#IOREDIRECTIONREF1>`__

   ``        2>&1       ``

-  ```         stdin        `` /
   ``         stdout        `` <special-chars.html#COXEX>`__ , using
   **-**

-  ```         stdin        `` of a
   *function* <complexfunct.html#REDSTDINFUNC1>`__

-  ```         stdout        `` to a
   file <io-redirection.html#IOREDIRECTIONREF>`__

   ``                 >               `` ...
   ``                 >>               ``

-  ```         stdout        `` to *file
   descriptor* <io-redirection.html#IOREDIRECTIONREF1>`__ *j*

   ``        >&j       ``

-  `file descriptor ``         i        `` to *file
   descriptor* <io-redirection.html#IOREDIRECTIONREF1>`__ *j*

   ``        i>&j       ``

-  ```         stdout        `` of a
   command <special-chars.html#REDIROUTERROR2>`__ to
   ``        stderr       ``

   ``        >&2       ``

-  ```         stdout        `` *and* ``         stderr        `` of a
   command <special-chars.html#REDIROUTERROR>`__ to a file

   ``        &>       ``

-  `tee <extmisc.html#TEEREF>`__ , redirect to a file output of
   command(s) partway through a `pipe <special-chars.html#PIPEREF>`__

`Reference Cards <refcards.html>`__

-  `Miscellaneous constructs <refcards.html#MISCTAB>`__

-  `Parameter substitution/expansion <refcards.html#PARSUBTAB>`__

-  `Special shell variables <refcards.html#SPECSHVARTAB>`__

-  `String operations <refcards.html#STRINGOPSTAB>`__

-  Test operators

   `Binary comparison <refcards.html#BINCOMPTAB>`__

   `Files <refcards.html#FILESTAB>`__

`*Regular Expressions* <regexp.html#REGEXREF>`__

-  **^** (caret) `Beginning-of-line <special-chars.html#BEGLINEREF>`__

-  **$** (dollar sign) `*Anchor* <x17129.html#DOLLARSIGNREF>`__

-  **.** (dot) `Match single character <x17129.html#REGEXDOT>`__

-  **\*** (asterisk) `Any number of
   characters <special-chars.html#ASTERISKREF2>`__

-  **[ ]** (brackets) `Enclose character set to
   match <x17129.html#BRACKETSREF>`__

-  **\\** (backslash) `Escape <x17129.html#REGEXBS>`__ , interpret
   following character literally

-  **\\< ... \\>** (angle brackets, *escaped* ) `Word
   boundary <x17129.html#ANGLEBRAC>`__

-  `Extended <x17129.html#EXTREGEX>`__ REs

   **+** `*Character match* <x17129.html#PLUSREF>`__

   **\\{ \\}** `Escaped "curly" brackets <x17129.html#ESCPCB>`__

   **[: :]** `POSIX character classes <x17129.html#POSIXREF>`__

```       $REPLY      `` <internalvariables.html#REPLYREF>`__ , Default
value associated with `read <internal.html#READREF>`__ command

`Restricted shell <restricted-sh.html#RESTRICTEDSHREF>`__ , shell (or
script) with certain commands disabled

`return <complexfunct.html#RETURNREF>`__ , command that terminates a
`function <functions.html#FUNCTIONREF>`__

`run-parts <extmisc.html#RUNPARTSREF>`__

-  `Running scripts in sequence <assortedtips.html#RUNPARTSREF2>`__ ,
   without user intervention

\* \* \*

`Scope <subshells.html#SCOPEREF>`__ of a variable, definition

`Script options <options.html#INVOCATIONOPTIONSREF>`__ , set at command
line

`Scripting routines <assortedtips.html#LIBROUTINES>`__ , library of
useful definitions and `functions <functions.html#FUNCTIONREF>`__

`Secondary prompt <internalvariables.html#SECPROMPTREF>`__ ,
**``       $PS2      ``**

`Security issues <securityissues.html>`__

-  `nmap <system.html#NMAPREF>`__ , *network mapper* / port scanner

-  `sudo <system.html#SUDOREF>`__

-  `*suid* commands inside a script <gotchas.html#SUIDSCR>`__

-  `Viruses, trojans, and
   worms <securityissues.html#INFECTEDSCRIPTS1>`__ in scripts

-  `Writing secure scripts <securityissues.html#SECURITYTIPS1>`__

`sed <sedawk.html#SEDREF>`__ , pattern-based programming language

-  `**Table** <x23170.html#SEDBASICTABLE>`__ , basic operators

-  `**Table** <x23170.html#SEDOPTABLE>`__ , examples of operators

`select <testbranch.html#SELECTREF>`__ , construct for menu building

-  ```                   in                                 list                     ``
   omitted <testbranch.html#INLISTOMIT>`__

`Semaphore <system.html#SEMAPHOREREF>`__

`Semicolon required <loops1.html#NEEDSEMICOLON>`__ , when
`do <loops1.html#DOINREF>`__ *keyword* is on first line of
`loop <loops1.html#FORLOOPREF1>`__

-  `When terminating *curly-bracketed* code
   block <gotchas.html#OMITSEMICOLON>`__

`seq <extmisc.html#SEQREF>`__ , Emit a sequence of integers. Equivalent
to `jot <extmisc.html#JOTREF>`__ .

`set <internal.html#SETREF>`__ , Change value of internal script
variables

-  `set -u <debugging.html#UNDVARERR>`__ , Abort script with error
   message if attempting to use an *undeclared* variable.

`Shell script <part1.html#WHATSASCRIPT>`__ , definition of

`Shell wrapper <wrapper.html#SHWRAPPER>`__ , script embedding a command
or utility

`shift <othertypesv.html#SHIFTREF>`__ , reassigning *positional
parameters*

```       $SHLVL      `` <internalvariables.html#SHLVLREF>`__ , *shell
level* , depth to which the shell (or script) is nested

`shopt <internal.html#SHOPTREF>`__ , change *shell options*

`Signal <debugging.html#SIGNALD>`__ , a message sent to a process

Simulations

-  `Brownian motion <randomvar.html#BROWNIANREF>`__

-  `Galton board <randomvar.html#BROWNIANREF>`__

-  `Horserace <colorizing.html#HORSERACEREF>`__

-  `*Life* <contributed-scripts.html#LIFEREF>`__ , game of

-  `PI <mathc.html#CANNONREF>`__ , approximating by firing cannonballs

-  `Pushdown *stack* <arrays.html#STACKEX0>`__

`Single quotes <varsubn.html#SNGLQUO>`__ ( **' ... '** ) *strong*
`quoting <quoting.html#QUOTINGREF>`__

`Socket <devref1.html#SOCKETREF>`__ , a communication node associated
with an I/O port

Sorting

-  `Bubble sort <arrays.html#BUBBLESORT>`__

-  `Insertion sort <contributed-scripts.html#INSERTIONSORT0>`__

`source <internal.html#SOURCEREF>`__ , execute a script or, within a
script, import a file

-  `Passing positional parameters <internal.html#SOURCEPARAMS>`__

*Spam* , dealing with

-  `*Example script* <communications.html#SPAMLOOKUP_0>`__

-  `*Example script* <communications.html#ISSPAMMER_0>`__

-  `*Example script* <contributed-scripts.html#ISSPAMMER2_0>`__

-  `*Example script* <contributed-scripts.html#WHX0>`__

`Special characters <special-chars.html#SCHARLIST1>`__

Stack

-  `Definition <internalvariables.html#STACKDEFREF>`__

-  Emulating a *push-down stack* , `example
   script <arrays.html#STACKEX0>`__

Standard Deviation, `example script <contributed-scripts.html#STDDEV>`__

`Startup files <files.html#FILESREF1>`__ , Bash

```       stdin      `` and
``       stdout      `` <ioredirintro.html#STDINOUTDEF>`__

`Stopwatch <contributed-scripts.html#STOPWATCH>`__ , example script

Strings

-  **=~** `String match operator <bashver3.html#REGEXMATCHREF>`__

-  `Comparison <comparison-ops.html#SCOMPARISON1>`__

-  `Length <parameter-substitution.html#PSOREX1>`__

   ``                 ${#string}               ``

-  `Manipulation <string-manipulation.html#STRINGMANIP>`__

-  `Manipulation <string-manipulation.html#AWKSTRINGMANIP2>`__ , using
   `awk <awk.html#AWKREF>`__

-  `*Null* string <comparison-ops.html#STRINGNOTNULL>`__ , testing for

-  `Protecting strings <contributed-scripts.html#PROTECTLITERAL0>`__
   from expansion and/or reinterpretation, *script example*

   `*Unprotecting*
   strings <contributed-scripts.html#UNPROTECTLITERAL0>`__ , *script
   example*

-  *strchr()* , `equivalent
   of <string-manipulation.html#SUBSTRINGINDEX2>`__

-  *strlen()* , `equivalent of <string-manipulation.html#STRLEN>`__

-  `strings <filearchiv.html#STRINGSREF>`__ command, find printable
   strings in a binary or data file

-  Substring extraction

   `${string:position} <string-manipulation.html#SUBSTREXTR01>`__

   `${string:position:length} <string-manipulation.html#SUBSTREXTR02>`__

   `Using *expr* <moreadv.html#EXPEXTRSUB>`__

-  `Substring *index* <string-manipulation.html#SUBSTRINGINDEX2>`__
   (numerical position in string)

-  `Substring *matching* <string-manipulation.html#EXPRPAREN>`__ , using
   `expr <moreadv.html#EXPRREF>`__

-  `Substring *removal* <parameter-substitution.html#PSOREX1>`__

   `${var#Pattern} <parameter-substitution.html#PSOREXSH>`__

   `${var##Pattern} <parameter-substitution.html#PSOREXLO>`__

   `${var%Pattern} <parameter-substitution.html#PCTREP1>`__

   `${var%%Pattern} <parameter-substitution.html#PCTREP2>`__

-  Substring replacement

   `${string/substring/replacement} <string-manipulation.html#SUBSTRREPL00>`__

   `${string//substring/replacement} <string-manipulation.html#SUBSTRREPL01>`__

   `${string/#substring/replacement} <string-manipulation.html#SUBSTRREPL02>`__

   `${string/%substring/replacement} <string-manipulation.html#SUBSTRREPL03>`__

   `*Script example* <contributed-scripts.html#DAYSBETWEEN0>`__

-  `**Table** <refcards.html#STRINGOPSTAB>`__ of *string/substring*
   manipulation and extraction operators

`*Strong* quoting <varsubn.html#SNGLQUO>`__ **' ... '**

`Stylesheet <scrstyle.html>`__ for writing scripts

`Subshell <subshells.html#SUBSHELLSREF>`__

-  `Command list within parentheses <subshells.html#SUBSHELLPARENS1>`__

-  `Variables <subshells.html#SUBSHNLEVREF>`__ ,
   ``        $BASH_SUBSHELL       `` and ``        $SHLVL       ``

-  Variables in a *subshell*

   `*scope* limited <gotchas.html#VARSUBSH>`__ , but ...

   ... `can be accessed outside the
   subshell? <assortedtips.html#SUBSHTMP>`__

`su <system.html#SUREF>`__ *Substitute user* , log on as a different
user or as *root*

`suid <fto.html#SUIDREF>`__ ( *set user id* ) file flag

-  `*suid* commands inside a script <gotchas.html#SUIDSCR>`__ , not
   advisable

`Symbolic links <basic.html#SYMLINKREF>`__

`Swapfiles <zeros.html#SWAPFILEREF>`__

\* \* \*

`Tab completion <tabexpansion.html>`__

Table lookup, `script example <bashver2.html#RESISTOR>`__

`tail <textproc.html#TAILREF>`__ , *echo* to ``      stdout     `` lines
at the (tail) end of a text file

`tar <filearchiv.html#TARREF>`__ , archiving utility

`tee <extmisc.html#TEEREF>`__ , redirect to a file output of command(s)
partway through a `pipe <special-chars.html#PIPEREF>`__

`Terminals <system.html#TERMINALSSYS1>`__

-  `setserial <system.html#SETSERIALREF>`__

-  `setterm <system.html#SETTERMREF>`__

-  `stty <system.html#STTYREF>`__

-  `tput <terminalccmds.html#TPUTREF>`__

-  `wall <system.html#WALLREF>`__

*test* command

-  `Bash *builtin* <testconstructs.html#TTESTREF>`__

-  `external command <testconstructs.html#USRBINTEST>`__ ,
   ``        /usr/bin/test       `` (equivalent to
   ``        /usr/bin/[       `` )

`Test constructs <testconstructs.html#TESTCONSTRUCTS1>`__

Test operators

-  **-a** `Logical AND <comparison-ops.html#COMPOUNDAND>`__ compound
   comparison

-  **-e** `File exists <fto.html#RTIF>`__

-  **-eq** `is-equal-to <comparison-ops.html#EQUALREF>`__ (integer
   comparison)

-  **-f** `File is a *regular* file <fto.html#REGULARFILE>`__

-  **-ge** `greater-than or equal <comparison-ops.html#GE0REF>`__
   (integer comparison)

-  **-gt** `greater-than <comparison-ops.html#GT0REF>`__ (integer
   comparison)

-  **-le** `less-than or equal <comparison-ops.html#LE0REF>`__ (integer
   comparison)

-  **-lt** `less-than <comparison-ops.html#LT0REF>`__ (integer
   comparison)

-  **-n** `not-zero-length <comparison-ops.html#STRINGNOTNULL>`__
   (string comparison)

-  **-ne** `not-equal-to <comparison-ops.html#NEQUALREF>`__ (integer
   comparison)

-  **-o** `Logical OR <comparison-ops.html#COMPOUNDOR>`__ compound
   comparison

-  **-u** `*suid* flag set <fto.html#SUIDREF>`__ , file test

-  **-z** `is-zero-length <comparison-ops.html#STRINGNULL>`__ (string
   comparison)

-  **=** `is-equal-to <comparison-ops.html#SCOMPARISON1>`__ (string
   comparison)

   **==** `is-equal-to <comparison-ops.html#SCOMPARISON2>`__ (string
   comparison)

-  **<** `less-than <comparison-ops.html#LTREF>`__ (string comparison)

-  **<** `less-than <comparison-ops.html#INTLT>`__ , (integer
   comparison, within `double parentheses <dblparens.html>`__ )

-  **<=** `less-than-or-equal <comparison-ops.html#LTEQ>`__ , (integer
   comparison, within *double parentheses* )

-  **>** `greater-than <comparison-ops.html#GTREF>`__ (string
   comparison)

-  **>** `greater-than <comparison-ops.html#INTGT>`__ , (integer
   comparison, within *double parentheses* )

-  **>=** `greater-than-or-equal <comparison-ops.html#GTEQ>`__ ,
   (integer comparison, within *double parentheses* )

-  **\|\|** `Logical OR <ops.html#ORREF>`__

-  **&&** `Logical AND <special-chars.html#LOGICALAND>`__

-  **!** `Negation operator <special-chars.html#NOTREF>`__ , inverts
   `exit status <exit-status.html#EXITSTATUSREF>`__ of a test

   **!=** `not-equal-to <comparison-ops.html#NOTEQUAL>`__ (string
   comparison)

-  **Tables** of *test* operators

   `Binary comparison <refcards.html#BINCOMPTAB>`__

   `File <refcards.html#FILESTAB>`__

`Text and text file processing <textproc.html>`__

`Time / Date <timedate.html>`__

Timed input

-  `Using *read -t* <internal.html#READTIMED>`__

-  `Using *stty* <internalvariables.html#STTYTO>`__

-  `Using timing loop <internalvariables.html#TIMINGLOOP>`__

-  `Using
   ``         $TMOUT        `` <internalvariables.html#TMOUTREF>`__

`Tips and hints <assortedtips.html>`__ for Bash scripts

-  Array, `as *return value* from a
   function <assortedtips.html#RETARRAY>`__

   *Associative* array `more
   efficient <optimizations.html#ASSOCARRTST>`__ than a
   numerically-indexed array

-  `Capturing the return value <complexfunct.html#CAPTURERETVAL>`__ of a
   function, using *echo*

-  `*CGI* programming <networkprogramming.html#CGISCRIPT>`__ , using
   scripts for

-  Comment blocks

   Using `*anonymous here documents* <here-docs.html#CBLOCK1>`__

   Using `*if-then* constructs <assortedtips.html#COMOUTBL>`__

-  `Comment headers <assortedtips.html#COMMENTH>`__ , special purpose

-  `*C* -style syntax <assortedtips.html#CSTYLE>`__ , for manipulating
   variables

-  `Double-spacing a text file <x23170.html#DOUBLESPACE>`__

-  Filenames prefixed with a dash, `removing <basic.html#DASHREM>`__

-  `Filter <assortedtips.html#FILTEROUTP>`__ , feeding output back to
   *same* filter

-  Function `*return* value workarounds <assortedtips.html#RVT>`__

-  `*if-grep* test fixup <assortedtips.html#IFGREPFIX>`__

-  `Library <assortedtips.html#LIBROUTINES>`__ of useful definitions and
   *functions*

-  `*null* variable assignment <othertypesv.html#NULLVAR>`__ , avoiding

-  `Passing an *array* <assortedtips.html#PASSARRAY>`__ to a function

-  ``        $PATH       `` , appending to, `using the
   ``         +=        `` operator <bashver3.html#PATHAPPEND>`__ .

-  `*Prepending* <assortedtips.html#PREPENDREF>`__ lines at head of a
   file

-  `Progress bar <assortedtips.html#PROGRESSBAR>`__ template

-  `Pseudo-code <assortedtips.html#PSEUDOCODEREF>`__

-  `rcs <assortedtips.html#RCSREF>`__

-  `Redirecting a *test* to
   ``         /dev/null        `` <special-chars.html#DEVNULLREDIRECT>`__
   to suppress output

-  `Running scripts in sequence <assortedtips.html#RUNPARTSREF2>`__
   without user intervention, using
   `run-parts <extmisc.html#RUNPARTSREF>`__

-  Script `as embedded command <assortedtips.html#SCRIPTASEMB>`__

-  Script *portability*

   `Setting *path* and *umask* <assortedtips.html#SETPUM>`__

   `Using *whatis* <assortedtips.html#WHATISREF3>`__

-  `Setting script variable <assortedtips.html#SETVAREMB>`__ to a block
   of embedded *sed* or *awk* code

-  Speeding up script execution by `disabling
   *unicode* <optimizations.html#LCALL>`__

-  Subshell variable, `accessing outside the
   subshell <assortedtips.html#SUBSHTMP>`__

-  `Testing a variable <assortedtips.html#INTPARAM>`__ to see if it
   contains only digits

-  `Testing whether a command
   exists <special-chars.html#DEVNULLREDIRECT>`__ , using
   `type <internal.html#TYPEREF>`__

-  `Tracking script usage <assortedtips.html#TRACKINGSCR>`__

-  `*while-read* loop without a
   *subshell* <process-sub.html#GOODREAD0>`__

-  `Widgets <assortedtips.html#WIDGETREF>`__ , invoking from a script

```       $TMOUT      `` <internalvariables.html#TMOUTREF>`__ , Timeout
interval

`Token <testconstructs.html#TOKENREF>`__ , a symbol that may expand to a
`keyword <internal.html#KEYWORDREF>`__ or command

`tput <terminalccmds.html#TPUTREF>`__ , terminal-control command

`tr <textproc.html#TRREF>`__ , character translation filter

-  `DOS to Unix text file conversion <textproc.html#TRD2U>`__

-  `Options <textproc.html#TROPTIONS>`__

-  `Soundex <contributed-scripts.html#SOUNDEX0>`__ , *example script*

-  `Variants <textproc.html#TRVARIANTS>`__

`*Trap* <debugging.html#TRAPREF1>`__ , specifying an action upon receipt
of a `signal <debugging.html#SIGNALD>`__

*Trinary (ternary)* operator, *C* -style,
``             var>10?88:99           ``

-  `in *double-parentheses* construct <special-chars.html#CSTRINARY>`__

-  `in *let* construct <internal.html#EX46>`__

`true <internal.html#TRUEREF>`__ , returns *successful* (0) `exit
status <exit-status.html#EXITSTATUSREF>`__

`typeset <declareref.html#DECLARE1REF>`__ builtin

-  `options <declareref.html#DECLAREOPSREF1>`__

\* \* \*

```       $UID      `` <internalvariables.html#UIDREF>`__ , User ID
number

`unalias <aliases.html#UNALIASREF>`__ , to remove an
`alias <aliases.html#ALIASREF>`__

`uname <system.html#UNAMEREF>`__ , output system information

`Unicode <bashver4.html#UNICODEREF>`__ , encoding standard for
representing letters and symbols

-  `Disabling *unicode* <optimizations.html#LCALL>`__ to optimize script

`Uninitialized variables <gotchas.html#UNINITVAR>`__

`uniq <textproc.html#UNIQREF>`__ , filter to remove duplicate lines from
a sorted file

`unset <internal.html#UNSETREF>`__ , delete a shell variable

`until <loops1.html#UNTILLOOPREF>`__ loop

*until [ condition-is-true ]; do*

\* \* \*

*Variables*

-  `Array operations on <arrays.html#ARRAYOPSVARS>`__

-  `Assignment <ops.html#ASNOP1>`__

   `*Script example* <varassignment.html#EX15_0>`__

   `*Script example* <varassignment.html#EX16_0>`__

   `*Script example* <varsubn.html#VARUNSETTING>`__

-  `*Bash* internal variables <internalvariables.html>`__

-  `Block of *sed* or *awk* code <assortedtips.html#SETVAREMB>`__ ,
   setting a variable to

-  *C-style* `increment/decrement/trinary
   operations <dblparens.html#PLUSPLUSREF>`__

-  `Change value of internal script variables <internal.html#SETREF>`__
   using *set*

-  `declare <declareref.html#DECLARE1REF>`__ , to modify the properties
   of variables

-  `Deleting a shell variable <internal.html#UNSETREF>`__ using *unset*

-  `Environmental <othertypesv.html#ENVREF>`__

-  `Expansion / Substring
   replacement <parameter-substitution.html#EXPREPL1>`__ operators

-  `Indirect referencing <ivr.html#IVRREF>`__

   ``                 eval variable1=\$$variable2               ``

   `Newer notation <ivr.html#IVR2>`__

   ``                 ${!variable}               ``

-  `Integer <ops.html#INTVARREF>`__

-  `Integer / string <untyped.html#BVUNTYPED>`__ (variables are untyped)

-  `Length <parameter-substitution.html#PSOREX1>`__

   ``                 ${#var}               ``

-  `Lvalue <varsubn.html#LVALUEREF>`__

-  `Manipulating and expanding <parameter-substitution.html#PSSUB1>`__

-  `*Name* and *value* of a variable <varsubn.html#VARNAMEVAL>`__ ,
   distinguishing between

-  `*Null* string <comparison-ops.html#STRINGNOTNULL>`__ , testing for

-  `*Null* variable assignment <othertypesv.html#NULLVAR>`__ , avoiding

-  `Quoting <quotingvar.html>`__

   `within *test* brackets <gotchas.html#FAILQUOTE>`__

   `to preserve *whitespace* <quotingvar.html#WSQUO>`__

-  `rvalue <varsubn.html#LVALUEREF>`__

-  `Setting to *null* value <varsubn.html#VARUNSETTING>`__

-  `In *subshell* <subshells.html#PARVIS>`__ not visible to parent shell

-  Testing a variable `if it contains only
   digits <assortedtips.html#INTPARAM>`__

-  `Typing <declareref.html#TYPINGREF>`__ , restricting the properties
   of a variable

-  `Undeclared <debugging.html#UNDVARERR>`__ , error message

-  `Uninitialized <varsubn.html#UNINITVAR1>`__

-  `Unquoted variable <quotingvar.html#VARSPLITTING>`__ , *splitting*

-  `Unsetting <internal.html#UNSETREF>`__

-  `Untyped <untyped.html#BVUNTYPED>`__

\* \* \*

`wait <x9644.html#WAITREF>`__ , suspend script execution

-  `To remedy script hang <x9644.html#WAITHANG>`__

`*Weak* quoting <varsubn.html#DBLQUO>`__ **" ... "**

`while <loops1.html#WHILELOOPREF>`__ loop

*while [ condition ]; do*

-  `C-style syntax <loops1.html#WHLOOPC>`__

-  `Calling a *function* within *test*
   brackets <loops1.html#WHILEFUNC>`__

-  `Multiple conditions <loops1.html#WHMULTCOND>`__

-  `Omitting *test* brackets <loops1.html#WHILENOBRACKETS>`__

-  `*while read* <loops1.html#WHILEREADREF2>`__ construct

   `Avoiding a *subshell* <process-sub.html#GOODREAD0>`__

`Whitespace <special-chars.html#WHITESPACEREF>`__ , spaces, tabs, and
newline characters

-  ```         $IFS        `` defaults
   to <internalvariables.html#IFSWS>`__

-  `Inappropriate use of <gotchas.html#WSBAD>`__

-  `Preceding closing *limit string* <here-docs.html#INDENTEDLS>`__ in a
   *here document* , error

-  `Preceding script comments <special-chars.html#WSBCOMM>`__

-  `*Quoting* <quotingvar.html#WSQUO>`__ , to preserve *whitespace*
   within strings or variables

-  `[:space:] <x17129.html#WSPOSIX>`__ , *POSIX* character class

`who <system.html#WHOREF>`__ , information about logged on users

-  `w <system.html#WREF>`__

-  `whoami <system.html#WHOAMIREF>`__

-  `logname <system.html#LOGNAMEREF>`__

`Widgets <assortedtips.html#WIDGETREF>`__

`Wild card <globbingref.html#WILDCARDDEF>`__ characters

-  `Asterisk \* <special-chars.html#ASTERISKREF>`__

-  In ```                   [list]                 ``
   constructs <loops1.html#LIGLOB>`__

-  `Question mark ? <special-chars.html#WILDCARDQU>`__

-  `Will not match
   ``         dot files        `` <globbingref.html#WDOTFILEWC>`__

Word splitting

-  `Definition <quotingvar.html#WSPLITREF>`__

-  `Resulting from *command substitution* <commandsub.html#CSWS>`__

`Wrapper <wrapper.html#SHWRAPPER>`__ , shell

\* \* \*

`xargs <moreadv.html#XARGSREF>`__ , Filter for grouping arguments

-  `Curly brackets <moreadv.html#XARGSCURLYREF>`__

-  `Limiting arguments passed <moreadv.html#XARGSLIMARGS>`__

-  `Options <moreadv.html#XARGSLIMARGS>`__

-  Processes arguments `one at a time <moreadv.html#XARGSONEATATIME>`__

-  `Whitespace <moreadv.html#XARGSWS>`__ , handling

\* \* \*

`yes <extmisc.html#YESREF>`__

-  `Emulation <extmisc.html#YESEMU>`__

\* \* \*

**-z** `String is *null* <comparison-ops.html#STRINGNULL>`__

`*Zombie* <x9644.html#ZOMBIEREF>`__ , a process that has terminated, but
not yet been `killed <x9644.html#KILLREF>`__ by its
`parent <internal.html#PARENTREF>`__


.. |Note| image:: ../images/note.gif
