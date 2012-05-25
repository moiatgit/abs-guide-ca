+----------------------------------+----+----+
| Advanced Bash-Scripting Guide:   |
+==================================+====+====+
| `Prev <asciitable.html>`_        |    |    |
+----------------------------------+----+----+

--------------

Index
=====

This index / glossary / quick-reference lists many of the important
topics covered in the text. Terms are arranged in *approximate* ASCII
sorting order, *modified as necessary* for enhanced clarity.

Note that *commands* are indexed in `Part 4 <part4.html#PART4A>`_.

\* \* \*

**^** (caret)

-  `Beginning-of-line <special-chars.html#BEGLINEREF>`_, in a `Regular
   Expression <regexp.html#REGEXREF>`_

-  **^**

   **^^**

   `Uppercase conversion <bashver4.html#CASEMODPARAMSUB>`_ in *parameter
   substitution*

**~** *Tilde*

-  **~** `home directory <special-chars.html#TILDEREF>`_, corresponds to
   ```$HOME`` <internalvariables.html#HOMEDIRREF>`_

-  **~/** `*Current user's* home
   directory <special-chars.html#TILDEREF>`_

-  **~+** `*Current* working
   directory <special-chars.html#WORKINGDIRREF>`_

-  **~-** `*Previous* working
   directory <special-chars.html#PREVWORKINGDIR>`_

**=** *Equals* sign

-  **=** `Variable assignment <varassignment.html#EQREF>`_ operator

-  **=** `String comparison <comparison-ops.html#SCOMPARISON1>`_
   operator

   **==** `String comparison <comparison-ops.html#SCOMPARISON2>`_
   operator

-  **=~** *Regular Expression* `match <bashver3.html#REGEXMATCHREF>`_
   operator

   `*Example script* <contributed-scripts.html#FINDSPLIT0>`_

**<** Left angle bracket

-  Is-less-than

   `String comparison <comparison-ops.html#LTREF>`_

   `Integer comparison <comparison-ops.html#INTLT>`_ within `double
   parentheses <dblparens.html>`_

-  Redirection

   **<** ```stdin`` <io-redirection.html#IOREDIRECTIONREF2>`_

   **<<** `*Here document* <special-chars.html#HEREDOCRRREF>`_

   **<<<** `*Here string* <special-chars.html#HERESTRINGREF>`_

   **<>** `Opening a file <special-chars.html#REDIRRW>`_ for *both*
   reading and writing

**>** Right angle bracket

-  Is-greater-than

   `String comparison <comparison-ops.html#GTREF>`_

   `Integer comparison <comparison-ops.html#INTGT>`_, within *double
   parentheses*

-  Redirection

   **>** `Redirect ``stdout`` <io-redirection.html#IOREDIRECTIONREF>`_
   to a file

   **>>** `Redirect ``stdout`` <io-redirection.html#IOREDIRECTIONREF>`_
   to a file, but *append*

   **i>&j** `Redirect *file descriptor*
   ``i`` <io-redirection.html#IOREDIRECTIONREF1>`_ to *file descriptor*
   ``j``

   **>&j** `Redirect
   ``stdout`` <io-redirection.html#IOREDIRECTIONREF1>`_ to *file
   descriptor* ``j``

   **>&2** `Redirect ``stdout`` <special-chars.html#REDIROUTERROR2>`_ of
   a command to ``stderr``

   **2>&1** `Redirect
   ``stderr`` <io-redirection.html#IOREDIRECTIONREF1>`_ to ``stdout``

   **&>** `Redirect *both* ``stdout`` and
   ``stderr`` <special-chars.html#REDIROUTERROR>`_ of a command to a
   file

   **:> ``file``** `Truncate
   file <io-redirection.html#IOREDIRECTIONREF>`_ to zero length

**\|** `Pipe <special-chars.html#PIPEREF>`_, a device for passing the
output of a command to another command or to the shell

**\|\|** `Logical OR test operator <ops.html#ORREF>`_

**-** (dash)

-  `Prefix to *default
   parameter* <parameter-substitution.html#DEFPARAM1>`_, in *parameter
   substitution*

-  `Prefix to *option flag* <special-chars.html#DASHREF>`_

-  `Indicating *redirection* <special-chars.html#DASHREF2>`_ from
   ``stdin`` or ``stdout``

-  **--** (double-dash)

   `Prefix to *long* command
   options <special-chars.html#DOUBLEDASHREF>`_

   `*C-style* variable decrement <dblparens.html#PLUSPLUSREF>`_ within
   `double parentheses <dblparens.html#DBLPARENSREF>`_

**;** (semicolon)

-  `As command separator <special-chars.html#SEMICOLONREF>`_

-  **\\;** `*Escaped* semicolon <moreadv.html#FINDREF0>`_, terminates a
   `find <moreadv.html#FINDREF>`_ command

-  **;;** `Double-semicolon <special-chars.html#DOUBLESEMICOLON>`_,
   terminator in a `case <testbranch.html#CASEESAC1>`_ option

   Required when ...

   `*do* keyword is on the first line of
   *loop* <loops1.html#NEEDSEMICOLON>`_

   `terminating *curly-bracketed* code
   block <gotchas.html#OMITSEMICOLON>`_

-  **;;&** **;&** `Terminators <bashver4.html#NCTERM>`_ in a *case*
   option (`version 4+ <bashver4.html#BASH4REF>`_ of Bash).

**:** Colon

-  **:> ``filename``** `Truncate
   file <io-redirection.html#IOREDIRECTIONREF>`_ to zero length

-  `*null* command <special-chars.html#NULLREF>`_, equivalent to the
   `true <internal.html#TRUEREF>`_ Bash builtin

-  Used in an `anonymous here document <here-docs.html#ANONHEREDOC0>`_

-  Used as a `function name <functions.html#FSTRANGEREF>`_

**!** `Negation operator <special-chars.html#NOTREF>`_, inverts `exit
status <exit-status.html#NEGCOND>`_ of a test or command

-  **!=** `not-equal-to <comparison-ops.html#NOTEQUAL>`_ String
   comparison operator

**?** (question mark)

-  `Match zero or one characters <x17000.html#QUEXREGEX>`_, in an
   `Extended Regular Expression <x17000.html#EXTREGEX>`_

-  `Single-character *wild card* <special-chars.html#QUEXWC>`_, in
   `globbing <globbingref.html>`_

-  In a `*C*-style Trinary operator <special-chars.html#CSTRINARY>`_

**//** `Double forward slash <internal.html#DOUBLESLASHREF>`_, behavior
of `cd <internal.html#CDREF>`_ command toward

**.** (dot / period)

-  **.** `Load a file <special-chars.html#DOTREF>`_ (into a script),
   equivalent to `source <internal.html#SOURCEREF>`_ command

-  **.** `Match single character <x17000.html#REGEXDOT>`_, in a `Regular
   Expression <regexp.html#REGEXREF>`_

-  **.** `Current working directory <special-chars.html#DOTDIRECTORY>`_

   **./** `Current working
   directory <internalvariables.html#CURRENTWDREF>`_

-  **..** `*Parent* directory <special-chars.html#DOTDIRECTORY>`_

**' ... '** (single quotes) `*strong* quoting <varsubn.html#SNGLQUO>`_

**" ... "** (double quotes) `*weak* quoting <varsubn.html#DBLQUO>`_

-  `*Double-quoting* the *backslash* (**\\**)
   character <quotingvar.html#QUOTINGBSL>`_

**,**

-  `Comma operator <ops.html#COMMAOP>`_

-  **,**

   **,,**

   `Lowercase conversion <bashver4.html#CASEMODPARAMSUB>`_ in *parameter
   substitution*

**()** Parentheses

-  **( ... )** `Command group <special-chars.html#PARENSREF>`_; starts a
   `subshell <subshells.html#SUBSHELLSREF>`_

-  **( ... )** `Enclose group <x17000.html#PARENGRPS>`_ of *Extended
   Regular Expressions*

-  **>( ... )**

   **<( ... )** `Process substitution <process-sub.html#PROCESSSUBREF>`_

-  **... )** `Terminates test-condition <testbranch.html#CASEPAREN>`_ in
   *case* construct

-  **(( ... ))** `Double parentheses <dblparens.html#DBLPARENSREF>`_, in
   arithmetic expansion

**[** `Left bracket <special-chars.html#LEFTBRACKET>`_, *test* construct

**[ ]**Brackets

-  `*Array* element <arrays.html#BRACKARRAY>`_

-  `Enclose character set to match <x17000.html#BRACKETSREF>`_ in a
   *Regular Expression*

-  `*Test* construct <special-chars.html#BRACKTEST>`_

**[[ ... ]]** `Double brackets <testconstructs.html#DBLBRACKETS>`_,
extended *test* construct

**$** `*Anchor* <x17000.html#DOLLARSIGNREF>`_, in a `Regular
Expression <regexp.html#REGEXREF>`_

**$** `Prefix to a variable name <varsubn.html>`_

**$( ... )** `Command
substitution <varassignment.html#COMMANDSUBREF0>`_, setting a variable
with output of a command, using parentheses notation

**\` ... \`** `Command substitution <commandsub.html#BACKQUOTESREF>`_,
using `backquotes <special-chars.html#BACKTICKSREF>`_ notation

**$[ ... ]** `Integer expansion <special-chars.html#BRACKETARITH>`_
(deprecated)

**${ ... }** Variable manipulation / evaluation

-  **${var}** `Value of a
   variable <parameter-substitution.html#PSSUB1>`_

-  **${#var}** `Length of a
   variable <parameter-substitution.html#PSOREX1>`_

-  **${#@}**

   **${#\*}** `Number of *positional
   parameters* <parameter-substitution.html#NUMPOSPARAM>`_

-  **${parameter?err\_msg}** `Parameter-unset
   message <parameter-substitution.html#QERRMSG>`_

-  **${parameter-default}**

   **${parameter:-default}**

   **${parameter=default}**

   **${parameter:=default}** `Set default
   parameter <parameter-substitution.html#DEFPARAM1>`_

-  **${parameter+alt\_value}**

   **${parameter:+alt\_value}**

   `Alternate value <parameter-substitution.html#PARAMALTV>`_ of
   parameter, if set

-  **${!var}**

   `Indirect referencing of a variable <ivr.html#IVR2>`_, new notation

-  **${!#}**

   `Final *positional parameter* <othertypesv.html#LASTARGREF>`_. (This
   is an *indirect reference* to
   `$# <internalvariables.html#CLACOUNTREF>`_.)

-  **${!varprefix\*}**

   **${!varprefix@}**

   `Match *names* <parameter-substitution.html#VARPREFIXM>`_ of all
   previously declared variables beginning with ``varprefix``

-  **${string:position}**

   **${string:position:length}** `Substring
   extraction <string-manipulation.html#SUBSTREXTR01>`_

-  **${var#Pattern}**

   **${var##Pattern}** `Substring
   removal <parameter-substitution.html#PSOREX2>`_

-  **${var%Pattern}**

   **${var%%Pattern}** `Substring
   removal <parameter-substitution.html#PCTPATREF>`_

-  **${string/substring/replacement}**

   **${string//substring/replacement}**

   **${string/#substring/replacement}**

   **${string/%substring/replacement}** `Substring
   replacement <string-manipulation.html#SUBSTRREPL00>`_

**$' ... '** `String expansion <escapingsection.html#STRQ>`_, using
*escaped* characters.

**\\** `Escape <escapingsection.html#ESCP>`_ the character following

-  **\\< ... \\>** `Angle brackets <x17000.html#ANGLEBRAC>`_, *escaped*,
   word boundary in a `Regular Expression <regexp.html#REGEXREF>`_

-  **\\{ N \\}** `"Curly" brackets <x17000.html#ESCPCB>`_, *escaped*,
   number of character sets to match in an `Extended
   RE <x17000.html#EXTREGEX>`_

-  **\\;** `*Semicolon* <moreadv.html#FINDREF0>`_, *escaped*, terminates
   a `find <moreadv.html#FINDREF>`_ command

-  **\\$$** `Indirect reverencing of a variable <ivr.html#IVRREF>`_,
   old-style notation

-  `Escaping a *newline* <escapingsection.html#ESCNEWLINE>`_, to write a
   multi-line command

**&**

-  **&>** `Redirect *both* ``stdout`` and
   ``stderr`` <special-chars.html#REDIROUTERROR>`_ of a command to a
   file

-  **>&j** `Redirect
   ``stdout`` <io-redirection.html#IOREDIRECTIONREF1>`_ to *file
   descriptor* *j*

   **>&2** `Redirect ``stdout`` <special-chars.html#REDIROUTERROR2>`_ of
   a command to ``stderr``

-  **i>&j** `Redirect *file
   descriptor* <io-redirection.html#IOREDIRECTIONREF1>`_ *i* to *file
   descriptor* *j*

   **2>&1** `Redirect
   ``stderr`` <io-redirection.html#IOREDIRECTIONREF1>`_ to ``stdout``

-  `Closing *file descriptors* <io-redirection.html#CFD>`_

   **n<&-** Close input file descriptor *n*

   **0<&-**, **<&-** Close ``stdin``

   **n>&-** Close output file descriptor *n*

   **1>&-**, **>&-** Close ``stdout``

-  **&&** `Logical AND test operator <special-chars.html#LOGICALAND>`_

-  **Command &** `Run job in *background* <special-chars.html#BGJOB>`_

**#** `Hashmark <special-chars.html#HASHMARKREF>`_, special symbol
beginning a script *comment*

**#!** `Sha-bang <sha-bang.html#SHABANGREF>`_, special string starting a
`shell script <part1.html#WHATSASCRIPT>`_

**\*** Asterisk

-  `*Wild card* <special-chars.html#ASTERISKREF>`_, in
   `globbing <globbingref.html>`_

-  `Any number of characters <special-chars.html#ASTERISKREF2>`_ in a
   `Regular Expression <regexp.html#REGEXREF>`_

-  **\*\*** `Exponentiation <ops.html#EXPONENTIATIONREF>`_, arithmetic
   operator

-  **\*\*** Extended *globbing* `file-match
   operator <bashver4.html#GLOBSTARREF>`_

**%** Percent sign

-  `Modulo <ops.html#MODULOREF>`_, division-remainder arithmetic
   operation

-  `Substring removal <parameter-substitution.html#PCTPATREF>`_ (pattern
   matching) operator

**+** Plus sign

-  `*Character match* <x17000.html#PLUSREF>`_, in an `extended Regular
   Expression <x17000.html#EXTREGEX>`_

-  `Prefix to *alternate
   parameter* <parameter-substitution.html#PARAMALTV>`_, in *parameter
   substitution*

-  **++** `*C-style* variable increment <dblparens.html#PLUSPLUSREF>`_,
   within `double parentheses <dblparens.html#DBLPARENSREF>`_

\* \* \*

*Shell Variables*

**$\_** `Last argument to previous
command <internalvariables.html#UNDERSCOREREF>`_

**$-** `Flags passed to script <internalvariables.html#FLPREF>`_, using
`set <internal.html#SETREF>`_

**$!** `*Process ID* of last background
job <internalvariables.html#PIDVARREF>`_

**$?** `*Exit status* of a command <exit-status.html#EXSREF>`_

**$@** All the *positional parameters*, `as *separate*
words <internalvariables.html#APPREF2>`_

**$\*** All the *positional parameters*, `as a *single*
word <internalvariables.html#APPREF>`_

**$$** `Process ID <special-chars.html#PROCESSIDREF>`_ of the script

**$#** `Number of arguments
passed <internalvariables.html#CLACOUNTREF>`_ to a
`function <functions.html#FUNCTIONREF>`_, or to the script itself

**$0** `Filename of the script <othertypesv.html#SCRNAMEPARAM>`_

**$1** `First argument passed to
script <othertypesv.html#POSPARAMREF1>`_

**$9** `Ninth argument passed to
script <othertypesv.html#POSPARAMREF1>`_

`**Table** <refcards.html#SPECSHVARTAB>`_ of *shell variables*

\* \* \* \* \* \*

**-a** `Logical AND <comparison-ops.html#COMPOUNDAND>`_ compound
comparison test

Address database, `script example <testbranch.html#EX30>`_

*Advanced Bash Scripting Guide*, `where to
download <mirrorsites.html#WHERE_TARBALL>`_

`Alias <aliases.html#ALIASREF>`_

-  `Removing an *alias* <aliases.html#UNALIASREF>`_, using *unalias*

`Anagramming <commandsub.html#AGRAM2>`_

`*And* list <list-cons.html#LCONS1>`_

-  `To supply default command-line
   argument <list-cons.html#ANDDEFAULT>`_

`*And* logical operator <ops.html#LOGOPS1>`_ **&&**

`Angle brackets <x17000.html#ANGLEBRAC>`_, *escaped*, **\\< . . . \\>**
word boundary in a `Regular Expression <regexp.html#REGEXREF>`_

`Anonymous *here document* <here-docs.html#ANONHEREDOC0>`_, using **:**

`Archiving <filearchiv.html#FAARCHIVING1>`_

-  `rpm <filearchiv.html#RPMREF>`_

-  `tar <filearchiv.html#TARREF>`_

`Arithmetic expansion <arithexp.html#ARITHEXPREF>`_

-  `*exit status* of <testconstructs.html#ARXS>`_

-  `variations of <arithexp.html#ARITHEXPVAR1>`_

`Arithmetic operators <ops.html#AROPS1>`_

-  `combination operators <ops.html#ARITHOPSCOMB>`_, *C*-style

   **+=** **-=** **\*=** **/=** **%=**

   .. figure:: http://tldp.org/LDP/abs/images/note.gif
      :align: center
      :alt: Note

      Note
   `In certain contexts <bashver3.html#PLUSEQSTR>`_, **+=** can also
   function as a *string concatenation* operator.

`Arrays <arrays.html#ARRAYREF>`_

-  `Associative arrays <bashver4.html#ASSOCARR>`_

-  `Bracket notation <arrays.html#ARRAYREF>`_

-  `Concatenating <arrays.html#ARRAYAPPEND0>`_, *example script*

-  `Copying <arrays.html#COPYARRAY0>`_

-  `Declaring <declareref.html#ARRAYDECLARE>`_

   ``declare -a          array_name``

-  `Embedded arrays <arrays.html#ARRAYINDIR>`_

-  `Empty arrays, empty elements <arrays.html#EMPTYARRAY0>`_, *example
   script*

-  `Indirect references <arrays.html#ARRAYINDIR>`_

-  `Initialization <arrays.html#ARRAYINIT0>`_

   ``array=( element1 element2 ... elementN)``

   `*Example script* <arrays.html#ARRAYASSIGN0>`_

   Using `command substitution <arrays.html#ARRAYINITCS>`_

-  `Loading a file <arrays.html#ARRAYINITCS>`_ into an array

-  `Multidimensional <arrays.html#ARRAYMULTIDIM>`_, simulating

-  `Nesting and embedding <arrays.html#ARRAYNEST>`_

-  `Notation and usage <arrays.html#ARRAYNOTATION>`_

-  `Number of elements in <arrays.html#ARRAYNUMELEMENTS>`_

   ``${#array_name[@]}``

   ``${#array_name[*]}``

-  `Operations <arrays.html#ARRAYSYNTAX>`_

-  `Passing an *array* <assortedtips.html#PASSARRAY>`_ to a function

-  As `*return value* from a function <assortedtips.html#RETARRAY>`_

-  Special properties, `example script <arrays.html#ARRAYSPECIALPROPS>`_

-  String operations, `example script <arrays.html#ARRAYSTRINGOPS>`_

-  `*unset* deletes array elements <arrays.html#ARRAYUNSET>`_

`Arrow keys <internal.html#READARROW>`_, detecting

ASCII

-  `Definition <special-chars.html#ASCIIDEF>`_

-  `Script to generate ASCII table <asciitable.html>`_

`awk <awk.html>`_ field-oriented text processing language

-  ```rand()`` <randomvar.html#AWKRANDOMREF>`_, random function

-  `String manipulation <string-manipulation.html#AWKSTRINGMANIP2>`_

-  `Using *export* <internal.html#EXPORTAWK>`_ to pass a variable to an
   embedded *awk* script

\* \* \*

Backlight, `setting the brightness <system.html#BACKLIGHT>`_

`Backquotes <special-chars.html#BACKTICKSREF>`_, used in `command
substitution <commandsub.html#BACKQUOTESREF>`_

`Base conversion <mathc.html#BASE0>`_, *example script*

`Bash <why-shell.html#BASHDEF>`_

-  `Bad scripting practices <gotchas.html#BASH3GOTCHA>`_

-  `Basics reviewed <contributed-scripts.html#BASICSREV0>`_, *script
   example*

-  `Command-line options <bash-options.html#CLOPTS>`_

   `**Table** <options.html#OPTIONSTABLE>`_

-  `Features that classic *Bourne* shell
   lacks <portabilityissues.html#BASHCOMPAT>`_

-  `Internal variables <internalvariables.html>`_

-  `Version 2 <bashver2.html#BASH2REF>`_

-  `Version 3 <bashver3.html#BASH3REF>`_

-  `Version 4 <bashver4.html#BASH4REF>`_

   `Version 4.1 <bashver4.html#BASH41>`_

   `Version 4.2 <bashver4.html#BASH42>`_

`.bashrc <sample-bashrc.html>`_

```$BASH_SUBSHELL`` <internalvariables.html#BASHSUBSHELLREF>`_

`Basic commands <basic.html#BASICCOMMANDS1>`_, external

`Batch files <dosbatch.html#DOSBATCH1>`_, *DOS*

`Batch processing <timedate.html#BATCHPROCREF>`_

`bc <mathc.html#BCREF>`_, calculator utility

-  `In a *here document* <mathc.html#BCHEREDOC>`_

-  `Template <mathc.html#BCTEMPLATE>`_ for calculating a script variable

`Bibliography <biblio.html>`_

`Bison <textproc.html#BISONREF>`_ utility

`Bitwise operators <ops.html#BITWSOPS1>`_

-  `Example script <contributed-scripts.html#BASE64>`_

`Block devices <devref1.html#BLOCKDEVREF>`_

-  `testing for <fto.html#BLOCKDEVTEST>`_

`Blocks of code <special-chars.html#CODEBLOCKREF>`_

-  `Redirection <special-chars.html#BLOCKIO>`_

   `*Script example* <special-chars.html#BLOCKIO2>`_: redirecting output
   of a a code block

`Bootable flash drives <extmisc.html#BFS>`_, creating

`Brace expansion <special-chars.html#BRACEEXPREF>`_

-  `Extended <special-chars.html#BRACEEXPREF33>`_, ``{a..z}``

-  `Parameterizing <bashver3.html#BRACEEXPREF3>`_

-  With `increment and zero-padding <bashver4.html#BRACEEXPREF4>`_ (new
   feature in Bash, `version 4 <bashver4.html#BASH4REF>`_)

Brackets, **[ ]**

-  `*Array* element <arrays.html#BRACKARRAY>`_

-  `Enclose character set to match <x17000.html#BRACKETSREF>`_ in a
   *Regular Expression*

-  `*Test* construct <special-chars.html#BRACKTEST>`_

Brackets, *curly*, **{}**, used in

-  `Code block <special-chars.html#CODEBLOCKREF>`_

-  `*find* <moreadv.html#CURLYBRACKETSREF>`_

-  `*Extended Regular Expressions* <x17000.html#ESCPCB>`_

-  `*Positional parameters* <othertypesv.html#BRACKETNOTATION>`_

-  `*xargs* <moreadv.html#XARGSCURLYREF>`_

`break <loopcontrol.html#BRKCONT1>`_ *loop* control command

-  `Parameter <loopcontrol.html#BREAKPARAM>`_ (optional)

`Builtins <internal.html#BUILTINREF>`_ in *Bash*

-  `Do not fork a subprocess <internal.html#BLTINFRK>`_

\* \* \*

`*case* construct <testbranch.html#CASEESAC1>`_

-  `Command-line parameters <testbranch.html#CASECL>`_, handling

-  `Globbing <testbranch.html#CSGLOB>`_, filtering strings with

`cat <basic.html#CATREF>`_, con*cat*entate file(s)

-  `Abuse of <optimizations.html#CATABUSE>`_

-  `*cat* scripts <here-docs.html#CATSCRIPTREF>`_

-  `Less efficient than redirecting ``stdin`` <basic.html#CATLESSEFF>`_

-  `Piping the output of <internal.html#READPIPEREF>`_, to a
   `read <internal.html#READREF>`_

-  `Uses of <basic.html#CATUSES>`_

`Character devices <devref1.html#CHARDEVREF>`_

-  `testing for <fto.html#CHARDEVTEST>`_

`Checksum <filearchiv.html#CHECKSUMREF>`_

`Child processes <othertypesv.html#CHILDREF>`_

`Colon <special-chars.html#NULLREF>`_, **:**, equivalent to the
`true <internal.html#TRUEREF>`_ Bash builtin

`Colorizing scripts <colorizing.html#COLORIZINGREF>`_

-  Cycling through the background colors, `example
   script <contributed-scripts.html#SHOWALLC>`_

-  `**Table** <colorizing.html#COLORIZTABLE>`_ of color escape sequences

-  `Template <colorizing.html#COLORIZTEMPL>`_, colored text on colored
   background

`Comma operator <ops.html#COMMAOP>`_, linking commands or operations

`Command-line options <bash-options.html>`_

`command\_not\_found\_handle () <bashver4.html#CNFH>`_ *builtin*
error-handling function (`version 4+ <bashver4.html#BASH4REF>`_ of Bash)

`Command substitution <commandsub.html#COMMANDSUBREF>`_

-  `**$( ... )** <commandsub.html#CSPARENS>`_, preferred notation

-  `*Backquotes* <commandsub.html#BACKQUOTESREF>`_

-  `Extending the *Bash* toolset <commandsub.html#CSTOOLSET>`_

-  `Invokes a *subshell* <commandsub.html#CSSUBSH>`_

-  `Nesting <commandsub.html#CSNEST>`_

-  `Removes trailing newlines <commandsub.html#CSTRNL>`_

-  `Setting variable from loop output <commandsub.html#CSVL>`_

-  `Word splitting <commandsub.html#CSWS>`_

`Comment headers <assortedtips.html#COMMENTH>`_, special purpose

Commenting out blocks of code

-  Using an `*anonymous* here document <here-docs.html#CBLOCK1>`_

-  Using an `*if-then* construct <assortedtips.html#COMOUTBL>`_

`Communications and hosts <communications.html>`_

`Compound comparison <comparison-ops.html#CCOMPARISON1>`_ operators

`Compression utilities <filearchiv.html#FACOMPRESSION1>`_

-  `bzip2 <filearchiv.html#BZIPREF>`_

-  `compress <filearchiv.html#COMPRESSREF>`_

-  `gzip <filearchiv.html#GZIPREF>`_

-  `zip <filearchiv.html#ZIPREF>`_

`continue <loopcontrol.html#BRKCONT1>`_ loop control command

`Control characters <special-chars.html#CONTROLCHARREF>`_

-  `Control-C <special-chars.html#CTLCREF>`_, *break*

-  `Control-D <special-chars.html#CTLDREF>`_, terminate / log out /
   erase

-  `Control-G <special-chars.html#CTLGREF>`_, ``BEL`` (*beep*)

-  `Control-H <special-chars.html#CTLHREF>`_, *rubout*

-  `Control-J <special-chars.html#CTLJREF>`_, *newline*

-  `Control-M <special-chars.html#CTLMREF>`_, carriage return

`Coprocesses <bashver4.html#COPROCREF>`_

`cron <system.html#CRONREF>`_, scheduling *daemon*

`*C*-style syntax <assortedtips.html#CSTYLE>`_, for handling variables

`Crossword puzzle solver <textproc.html#CWSOLVER>`_

`Cryptography <contributed-scripts.html#GRONSFELD>`_

Curly brackets {}

-  `in *find* command <moreadv.html#CURLYBRACKETSREF>`_

-  `in an *Extended Regular Expression* <x17000.html#ESCPCB>`_

-  `in *xargs* <moreadv.html#XARGSCURLYREF>`_

\* \* \*

`Daemons <communications.html#DAEMONREF>`_, in UNIX-type OS

`date <timedate.html#DATEREF>`_

`dc <mathc.html#DCREF>`_, calculator utility

`dd <extmisc.html#DDREF>`_, *data duplicator* command

-  `Conversions <extmisc.html#DDCONVERSIONS>`_

-  `Copying raw data <extmisc.html#DDCOPY>`_ to/from devices

-  `File deletion <extmisc.html#DDFDEL>`_, *secure*

-  `Keystrokes <extmisc.html#DDKEYSTROKES>`_, capturing

-  `Options <extmisc.html#DDOPTIONS>`_

-  `Random access <extmisc.html#DDRANDOM>`_ on a data stream

-  `Swapfiles <extmisc.html#DDSWAP>`_, initializing

-  `Thread on *www.linuxquestions.org* <biblio.html#DDLINK>`_

`Debugging scripts <debugging.html>`_

-  `Tools <debugging.html#DEBUGTOOLS>`_

-  `*Trapping* at exit <debugging.html#DEBUGTRAP>`_

-  `*Trapping* signals <debugging.html#TRAPREF1>`_

`Decimal number <numerical-constants.html#NUMCONSTANTS>`_, Bash
interprets numbers as

`declare <declareref.html#DECLARE1REF>`_ builtin

-  `options <declareref.html#DECLAREOPSREF1>`_

   `case-modification <bashver4.html#DECLARECASEMOD>`_ options (`version
   4+ <bashver4.html#BASH4REF>`_ of Bash)

`Default parameters <parameter-substitution.html#DEFPARAM>`_

```/dev`` <devproc.html#DEVPROCREF>`_ directory

-  ```/dev/null`` <zeros.html#DEVNULLREF>`_ pseudo-device file

-  ```/dev/urandom`` <randomvar.html#URANDOMREF>`_ pseudo-device file,
   generating pseudorandom numbers with

-  ```/dev/zero`` <zeros.html#ZEROSREF1>`_, pseudo-device file

`Device file <devref1.html#DEVFILEREF>`_

`*dialog* <assortedtips.html#DIALOGREF>`_, utility for generating
*dialog* boxes in a script

```$DIRSTACK`` <internalvariables.html#DIRSTACKREF>`_ *directory stack*

`Disabled commands <restricted-sh.html#DISABLEDCOMMREF>`_, in
*restricted shells*

`do <loops1.html#DOINREF>`_ keyword, begins execution of commands within
a `loop <loops.html#LOOPREF00>`_

`done <loops1.html#DOINREF>`_ keyword, terminates a loop

`*DOS* batch files <dosbatch.html#DOSBATCH1>`_, converting to shell
scripts

`*DOS* commands <dosbatch.html#DOSUNIXEQUIV>`_, UNIX equivalents of
(**table**)

`*dot files* <basic.html#DOTFILESREF>`_, "hidden" setup and
configuration files

`Double brackets <testconstructs.html#DBLBRACKETS>`_ **[[ ... ]]**
`test <tests.html#IFTHEN>`_ construct

-  and `evaluation of *octal/hex*
   constants <testconstructs.html#DBLBRAEV>`_

`Double parentheses <dblparens.html#DBLPARENSREF>`_ **(( ... ))**
arithmetic expansion/evaluation construct

`Double quotes <varsubn.html#DBLQUO>`_ **" ... "** *weak* quoting

-  `*Double-quoting* the *backslash* (**\\**)
   character <quotingvar.html#QUOTINGBSL>`_

`Double-spacing a text file <x22929.html#DOUBLESPACE>`_, using
`sed <sedawk.html#SEDREF>`_

\* \* \*

**-e** `File exists <fto.html#RTIF>`_ test

`echo <internal.html#ECHOREF>`_

-  `Feeding commands down a *pipe* <internal.html#ECHOGREPREF>`_

-  `Setting a variable <internal.html#ECHOCS>`_ using `command
   substitution <commandsub.html#COMMANDSUBREF>`_

-  ```/bin/echo`` <internal.html#BINECHO>`_, external *echo* command

`elif <testconstructs.html#ELIFREF1>`_, Contraction of *else* and
`if <tests.html#IFTHEN>`_

`else <testconstructs.html#ELSEREF>`_

Encrypting files, using `openssl <filearchiv.html#OPENSSLREF>`_

`esac <testbranch.html#CASEESAC1>`_, keyword terminating *case*
construct

`*Environmental* variables <othertypesv.html#ENVREF>`_

`-eq <comparison-ops.html#EQUALREF>`_, *is-equal-to* `integer
comparison <comparison-ops.html#ICOMPARISON1>`_ test

`Eratosthenes, Sieve of <arrays.html#PRIMES0>`_, algorithm for
generating prime numbers

`Escaped characters <escapingsection.html#SPM>`_, special meanings of

-  Within `$' ... ' <escapingsection.html#STRQ>`_ string expansion

-  `Used with *Unicode* characters <bashver4.html#UNICODEREF2>`_

```/etc/fstab`` <system.html#FSTABREF>`_ (filesystem mount) file

```/etc/passwd`` <files.html#DATAFILESREF1>`_ (user account) file

```$EUID`` <internalvariables.html#EUIDREF>`_, *Effective user ID*

`eval <internal.html#EVALREF>`_, Combine and *evaluate* expression(s),
with variable expansion

-  `Effects of <internal.html#EVALEFF>`_, *Example script*

-  `Forces *reevaluation* <internal.html#EVALFORCED>`_ of arguments

-  And `indirect references <ivr.html#EVALINDREF>`_

-  `Risk of using <internal.html#EVALRISK>`_

-  `Using *eval* to convert *array* elements into a command
   list <contributed-scripts.html#SAMORSE>`_

-  `Using *eval* to select among variables <internal.html#ARRCHOICE0>`_

`Evaluation of *octal/hex* constants within [[ ...
]] <testconstructs.html#DBLBRAEV>`_

`exec <x17837.html#USINGEXECREF>`_ command, using in
`redirection <io-redirection.html#IOREDIRREF>`_

`Exercises <exercises.html>`_

Exit and Exit status

-  `exit <exit-status.html#EXITCOMMANDREF>`_ command

-  `Exit status <exit-status.html#EXITSTATUSREF>`_ (*exit code*,
   *return* status of a command)

   `**Table** <exitcodes.html#EXITCODESREF>`_, *Exit codes* with special
   meanings

   `Anomalous <gotchas.html#GOTCHAEXITVALANAMALIES>`_

   `Out of range <exitcodes.html#EXCOOR>`_

   `*Pipe* <exit-status.html#PIPEEX>`_ exit status

   `Specified by a *function return* <complexfunct.html#EXITRETURN1>`_

   `*Successful* <exit-status.html#EXITSUCCESS>`_, **0**

   ```/usr/include/sysexits.h`` <exitcodes.html#SYSEXITSREF>`_, system
   file listing C/C++ standard exit codes

`Export <internal.html#EXPORTREF2>`_, to make available variables to
`child processes <othertypesv.html#CHILDREF>`_

-  `Passing a variable to an embedded *awk*
   script <internal.html#EXPORTAWK>`_

`expr <moreadv.html#EXPRREF>`_, *Expression* evaluator

-  `Substring extraction <moreadv.html#EXPEXTRSUB>`_

-  `Substring *index* (numerical position in
   string) <string-manipulation.html#SUBSTRINGINDEX2>`_

-  `Substring matching <string-manipulation.html#EXPRMATCH>`_

`Extended *Regular Expressions* <x17000.html#EXTREGEX>`_

-  **?** (question mark) `Match zero / one
   characters <x17000.html#QUEXREGEX>`_

-  **( ... )** `Group of expressions <x17000.html#PARENGRPS>`_

-  **\\{ N \\}** `"Curly" brackets <x17000.html#ESCPCB>`_, *escaped*,
   number of character sets to match

-  **+** `*Character match* <x17000.html#PLUSREF>`_

\* \* \*

`factor <mathc.html#FACTORREF>`_, decomposes an integer into its prime
factors

-  Application: `Generating prime numbers <mathc.html#PRIMES2>`_

`false <internal.html#FALSEREF>`_, returns *unsuccessful* (1) `exit
status <exit-status.html#EXITSTATUSREF>`_

`Field <special-chars.html#FIELDREF>`_, a group of characters that
comprises an item of data

`Files / Archiving <filearchiv.html>`_

`File descriptors <io-redirection.html#FDREF>`_

-  `Closing <io-redirection.html#CFD>`_

   **n<&-** Close input file descriptor *n*

   **0<&-**, **<&-** Close ``stdin``

   **n>&-** Close output file descriptor *n*

   **1>&-**, **>&-** Close ``stdout``

-  `File handles in *C* <io-redirection.html#FDREF1>`_, similarity to

`File encryption <filearchiv.html#OPENSSLREF>`_

`find <moreadv.html#FINDREF>`_

-  **{}** `Curly brackets <moreadv.html#CURLYBRACKETSREF>`_

-  **\\;** `*Escaped* semicolon <moreadv.html#FINDREF0>`_

`Filter <special-chars.html#FILTERDEF>`_

-  `Using - with file-processing utility as a
   filter <special-chars.html#FILTERDASH>`_

-  `Feeding output of a filter back to *same*
   filter <assortedtips.html#FILTEROUTP>`_

`Floating point numbers <ops.html#NOFLOATINGPOINT>`_, Bash does not
recognize

`fold <textproc.html#FOLDREF>`_, a filter to wrap lines of text

`Forking <internal.html#FORKREF>`_ a *child* process

`*for* loops <loops1.html#FORLOOPREF1>`_

`Functions <functions.html#FUNCTIONREF>`_

-  `Arguments passed <complexfunct.html#PASSEDARGS>`_ referred to by
   position

-  `Capturing the return value <complexfunct.html#CAPTURERETVAL>`_ of a
   function using `echo <internal.html#ECHOREF>`_

-  `*Colon* <special-chars.html#COLONFNAME>`_ as function name

-  `Definition must precede <functions.html#FUNCTDEFMUST>`_ first call
   to function

-  `Exit status <complexfunct.html#EXITRETURN1>`_

-  `Local variables <localvar.html#LOCALREF1>`_

   and `recursion <localvar.html#LOCVARRECUR>`_

-  `Passing an *array* <assortedtips.html#PASSARRAY>`_ to a function

-  `Passing pointers <complexfunct.html#FUNCPOINTERS>`_ to a function

-  `Positional parameters <complexfunct.html#PASSEDARGS>`_

-  `Recursion <localvar.html#RECURSIONREF0>`_

-  `Redirecting ``stdin`` <complexfunct.html#REDSTDINFUNC1>`_ of a
   function

-  `return <complexfunct.html#RETURNREF>`_

   Multiple *return values* from a function, `example
   script <contributed-scripts.html#STDDEV>`_

   `Returning an *array* <assortedtips.html#RETARRAY>`_ from a function

   `*Return* range limits <assortedtips.html#RVT>`_, workarounds

-  `*Shift* arguments passed <complexfunct.html#FSHIFTREF>`_ to a
   function

-  `Unusual function names <functions.html#FSTRANGEREF>`_

\* \* \*

Games and amusements

-  `Anagrams <assortedtips.html#AGRAM>`_

-  `Anagrams <commandsub.html#AGRAM2>`_, again

-  `Crossword puzzle solver <textproc.html#CWSOLVER>`_

-  `Crypto-Quotes <textproc.html#CRYPTOQUOTE>`_

-  `Dealing a deck of cards <bashver2.html#CARDS>`_

-  `Fifteen Puzzle <contributed-scripts.html#FIFTEEN>`_

-  `Horse race <colorizing.html#HORSERACE>`_

-  `Knight's Tour <contributed-scripts.html#KTOUR>`_

-  `"Life" game <contributed-scripts.html#LIFESLOW>`_

-  `Magic Squares <contributed-scripts.html#MSQUARE>`_

-  `Music-playing script <devref1.html#MUSICSCR>`_

-  `Nim <contributed-scripts.html#NIM>`_

-  `Pachinko <randomvar.html#BROWNIAN>`_

-  `Perquackey <contributed-scripts.html#QKY>`_

-  `Petals Around the Rose <contributed-scripts.html#PETALS>`_

-  `Podcasting <contributed-scripts.html#BASHPODDER>`_

-  `Poem <arrays.html#POEM>`_

-  `Towers of Hanoi <recurnolocvar.html#HANOI>`_

   `Graphic version <contributed-scripts.html#HANOI2>`_

   `Alternate graphic version <contributed-scripts.html#HANOI2A>`_

`getopt <extmisc.html#GETOPTY>`_, *external* command for parsing script
*command-line* arguments

-  `Emulated in a script <string-manipulation.html#GETOPTSIMPLE1>`_

`getopts <internal.html#GETOPTSX>`_, Bash *builtin* for parsing script
*command-line* arguments

-  ```$OPTIND`` / ``$OPTARG`` <internal.html#GETOPTSOPT>`_

`Global <subshells.html#SCOPEREF>`_ variable

`Globbing <globbingref.html#GLOBBINGREF2>`_, filename expansion

-  `*Wild cards* <special-chars.html#ASTERISKREF>`_

-  `Will not match ``dot files`` <globbingref.html#WDOTFILEWC>`_

`Golden Ratio <mathc.html#GOLDENRATIO>`_ (*Phi*)

`-ge <comparison-ops.html#GE0REF>`_, *greater-than or equal* `integer
comparison <comparison-ops.html#ICOMPARISON1>`_ test

`-gt <comparison-ops.html#GT0REF>`_, *greater-than* `integer
comparison <comparison-ops.html#ICOMPARISON1>`_ test

`*groff* <textproc.html#GROFFREF>`_, text markup and formatting language

`Gronsfeld cipher <contributed-scripts.html#GRONSFELD>`_

```$GROUPS`` <internalvariables.html#GROUPSREF>`_, *Groups* user belongs
to

`gzip <filearchiv.html#GZIPREF>`_, compression utility

\* \* \*

`Hashing <internal.html#HASHREF>`_, creating lookup keys in a table

-  `*Example script* <contributed-scripts.html#HASHEX2_0>`_

`head <textproc.html#HEADREF>`_, *echo* to ``stdout`` lines at the
beginning of a text file

`help <internal.html#HELPREF>`_, gives usage summary of a Bash
`builtin <internal.html#BUILTINREF>`_

`*Here* documents <here-docs.html#HEREDOCREF>`_

-  `*Anonymous* here documents <here-docs.html#ANONHEREDOC0>`_, using
   **:**

   `Commenting out <here-docs.html#CBLOCK1>`_ blocks of code

   `Self-documenting <here-docs.html#HSELFDOC>`_ scripts

-  `*bc* in a *here document* <mathc.html#BCHEREDOC>`_

-  `*cat* scripts <here-docs.html#CATSCRIPTREF>`_

-  `Command substitution <here-docs.html#HERECS>`_

-  `*ex* scripts <here-docs.html#EXSCRIPTREF>`_

-  `*Function* <here-docs.html#HEREFUNC>`_, supplying input to

-  `*Here* strings <x17700.html#HERESTRINGSREF>`_

   Calculating the `Golden Ratio <mathc.html#GOLDENRATIO>`_

   `Prepending text <x17700.html#HSPRE>`_

   `As the ``stdin`` of a *loop* <x17700.html#HSLOOP>`_

   `Using *read* <x17700.html#HSREAD>`_

-  `*Limit* string <here-docs.html#LIMITSTRINGREF>`_

   `! as a *limit string* <here-docs.html#EXCLLS>`_

   `Closing *limit string* <here-docs.html#INDENTEDLS>`_ may not be
   indented

   `Dash option <here-docs.html#LIMITSTRDASH>`_ to limit string,
   ``<<-LimitString``

-  `Literal text output <here-docs.html#HERELIT>`_, for generating
   program code

-  `Parameter substitution <here-docs.html#HEREPARAMSUB>`_

   `Disabling <here-docs.html#HEREESC>`_ *parameter substitution*

-  `Passing parameters <here-docs.html#HEREPASSP>`_

-  `Temporary files <here-docs.html#HERETEMP>`_

-  `Using *vi* non-interactively <here-docs.html#VIHERE>`_

`History commands <histcommands.html>`_

```$HOME`` <internalvariables.html#HOMEDIRREF>`_, *user's home
directory*

`Homework assignment solver <contributed-scripts.html#HOMEWORK>`_

```$HOSTNAME`` <internalvariables.html#HOSTNAMEREF>`_, system *host
name*

\* \* \*

```$Id`` parameter <assortedtips.html#RCSREF>`_, in *rcs* (Revision
Control System)

`if [ condition ]; then ... <tests.html#IFTHEN>`_ *test* construct

-  `if-grep <testconstructs.html#IFGREPREF>`_, *if* and
   `grep <textproc.html#GREPREF>`_ in combination

   `Fixup <assortedtips.html#IFGREPFIX>`_ for *if-grep* test

```$IFS`` <internalvariables.html#IFSREF>`_, *Internal field separator*
variable

-  `Defaults to *whitespace* <internalvariables.html#IFSWS>`_

`Integer comparison operators <comparison-ops.html#ICOMPARISON1>`_

`in <loops1.html#DOINREF>`_, *keyword* preceding ``[list]`` in a *for*
loop

`Initialization table <system.html#INITTABREF>`_, ``/etc/inittab``

`Inline group <special-chars.html#CODEBLOCKREF>`_, i.e., code block

`Interactive script <intandnonint.html#IITEST>`_, test for

`I/O redirection <io-redirection.html#IOREDIRREF>`_

`Indirect referencing of variables <ivr.html#IVRREF>`_

-  `New notation <ivr.html#IVR2>`_, introduced in `version
   2 <bashver2.html#BASH2REF>`_ of Bash (`example
   script <bashver2.html#VARREFNEW>`_)

`iptables <system.html#IPTABLESREF>`_, packet filtering and firewall
utility

-  `Usage example <system.html#IPTABLES01>`_

-  `Example script <networkprogramming.html#IPTABLES02>`_

`Iteration <loops1.html#ITERATIONREF>`_

\* \* \*

`Job IDs <x9585.html#JOBIDTABLE0>`_, table

`jot <extmisc.html#JOTREF>`_, Emit a sequence of integers. Equivalent to
`seq <extmisc.html#SEQREF>`_.

-  `Random sequence generation <extmisc.html#JOTRANDOM>`_

`Just another Bash hacker! <textproc.html#JABH>`_

\* \* \*

`Keywords <internal.html#KEYWORDREF>`_

-  `error <debugging.html#MISSINGKEYWORD>`_, if missing

`kill <x9585.html#KILLREF>`_, terminate a process by `process
ID <special-chars.html#PROCESSIDDEF>`_

-  `Options <x9585.html#ZOMBIEREF>`_ (``-l``, ``-9``)

`killall <x9585.html#KILLALLREF>`_, terminate a process *by name*

`*killall script* <sysscripts.html#KILLALL2REF>`_ in
``/etc/rc.d/init.d``

\* \* \*

`lastpipe <bashver4.html#LASTPIPEREF>`_ shell option

`-le <comparison-ops.html#LE0REF>`_, *less-than or equal* `integer
comparison <comparison-ops.html#ICOMPARISON1>`_ test

`let <internal.html#LETREF>`_, setting and carrying out arithmetic
operations on variables

-  *C-style* `increment and decrement operators <internal.html#EX46>`_

`Limit string <here-docs.html#LIMITSTRINGREF>`_, in a `here
document <here-docs.html#HEREDOCREF>`_

```$LINENO`` <internalvariables.html#LINENOREF>`_, variable indicating
the *line number* where it appears in a script

`Link <basic.html#LINKREF>`_, file (using *ln* command)

-  `Invoking script with multiple names <basic.html#LINKMINVOK>`_, using
   *ln*

-  `*symbolic* links <basic.html#SYMLINKREF>`_, *ln -s*

`List constructs <list-cons.html#LISTCONSREF>`_

-  `*And* list <list-cons.html#LCONS1>`_

-  `*Or* list <list-cons.html#ORLISTREF>`_

`Local variables <localvar.html#LOCALREF1>`_

-  and `recursion <localvar.html#LOCVARRECUR>`_

`Localization <localization.html>`_

`Logical operators <ops.html#LOGOPS1>`_ (``&&``, ``||``, etc.)

`Logout file <files.html#LOGOUTFILEREF1>`_, the ``~/.bash_logout`` file

`Loopback device <system.html#ISOMOUNTREF0>`_, mounting a file on a
`block device <devref1.html#BLOCKDEVREF>`_

`Loops <loops1.html>`_

-  `break <loopcontrol.html#BRKCONT1>`_ loop control command

-  `continue <loopcontrol.html#BRKCONT1>`_ loop control command

-  *C*-style loop within `double
   parentheses <dblparens.html#DBLPARENSREF>`_

   `*for* loop <loops1.html#LOOPCSTYLE>`_

   `*while* loop <loops1.html#WLOOPCSTYLE>`_

-  `do <loops1.html#DOINREF>`_ (keyword), begins execution of commands
   within a loop

-  `done <loops1.html#DOINREF>`_ (keyword), terminates a loop

-  `*for* loops <loops1.html#FORLOOPREF1>`_

   ``for`` ``arg`` ``in`` ``[list]``; ``do``

   `*Command substitution* to generate ``[list]`` <loops1.html#LOOPCS>`_

   `Filename expansion in ``[list]`` <loops1.html#LIGLOB>`_

   `Multiple parameters in each ``[list]``
   element <loops1.html#MULTPARAML>`_

   `Omitting ``[list]`` <loops1.html#OMITLIST>`_, defaults to
   `positional parameters <internalvariables.html#POSPARAMREF>`_

   `Parameterizing ``[list]`` <loops1.html#PARAMLI>`_

   `Redirection <loops1.html#LOOPREDIR>`_

-  `in <loops1.html#DOINREF>`_, (keyword) preceding [list] in a *for*
   loop

-  `Nested loops <nestedloops.html>`_

-  `Running a loop *in the background* <special-chars.html#BGLOOP0>`_,
   *script example*

-  Semicolon required, when *do* is on first line of loop

   `*for* loop <loops1.html#NEEDSEMICOLON>`_

   `*while* loop <loops1.html#WHILENEEDSEMI>`_

-  `until <loops1.html#UNTILLOOPREF>`_ loop

   ``until [ condition-is-true ]; do``

-  `while <loops1.html#WHILELOOPREF>`_ loop

   ``while [ condition ]; do``

   `Function call <loops1.html#WHILEFUNC>`_ inside test brackets

   `Multiple conditions <loops1.html#WHMULTCOND>`_

   `Omitting *test brackets* <loops1.html#WHILENOBRACKETS>`_

   `Redirection <loops1.html#WHREDIR>`_

   `*while read* <loops1.html#WHILEREADREF2>`_ construct

-  `Which type of loop to use <loops1.html#CHOOSELOOP>`_

Loopback devices

-  `In ``/dev`` directory <devref1.html#LOOPBACKREF>`_

-  `Mounting an ISO image <system.html#ISOMOUNTREF0>`_

`-lt <comparison-ops.html#LT0REF>`_, *less-than* `integer
comparison <comparison-ops.html#ICOMPARISON1>`_ test

\* \* \*

`m4 <extmisc.html#M4REF>`_, macro processing language

```$MACHTYPE`` <internalvariables.html#MACHTYPEREF>`_, *Machine type*

`Magic number <sha-bang.html#MAGNUMREF>`_, marker at the head of a file
indicating the file type

```Makefile`` <filearchiv.html#MAKEFILEREF>`_, file containing the list
of dependencies used by `make <filearchiv.html#MAKEREF>`_ command

`man <basic.html#MANREF>`_, *manual page* (lookup)

-  `*Man page* editor <contributed-scripts.html#MANED>`_ (script)

`mapfile <bashver4.html#MAPFILEREF>`_ builtin, loads an array with a
text file

`Math commands <mathc.html>`_

`Meta-meaning <x17000.html#METAMEANINGREF>`_

`Morse code training <contributed-scripts.html#SAMORSE>`_ script

`Modulo <ops.html#MODULOREF>`_, arithmetic *remainder* operator

-  Application: `Generating prime
   numbers <contributed-scripts.html#PRIMES1>`_

`Mortgage calculations <mathc.html#MONTHLYPMT0>`_, *example script*

\* \* \*

**-n** `String not *null* <comparison-ops.html#STRINGNOTNULL>`_ test

`Named pipe <extmisc.html#NAMEDPIPEREF>`_, a temporary FIFO buffer

-  `*Example script* <contributed-scripts.html#ZFIFO>`_

`nc <system.html#NCREF>`_, *netcat*, a network toolkit for TCP and UDP
ports

`-ne <comparison-ops.html#NEQUALREF>`_, *not-equal-to* `integer
comparison <comparison-ops.html#ICOMPARISON1>`_ test

`Negation operator <special-chars.html#NOTREF>`_, **!**, reverses the
sense of a `test <tests.html#IFTHEN>`_

`netstat <system.html#NETSTATREF>`_, Network statistics

`Network programming <networkprogramming.html>`_

`nl <textproc.html#NLREF>`_, a filter to number lines of text

`*Noclobber* <options.html#NOCLOBBERREF>`_, ``-C`` option to Bash to
prevent overwriting of files

`*NOT* logical operator <ops.html#LOGOPS1>`_, **!**

`*null* variable assignment <othertypesv.html#NULLVAR>`_, avoiding

\* \* \*

**-o** `Logical OR <comparison-ops.html#COMPOUNDOR>`_ compound
comparison test

Obfuscation

-  `*Colon* <special-chars.html#COLONFNAME>`_ as function name

-  `Homework assignment <contributed-scripts.html#HOMEWORK>`_

-  `Just another Bash hacker! <textproc.html#JABH>`_

`octal <escapingsection.html#OCTALREF>`_, base-8 numbers

`od <extmisc.html#ODREF>`_, *octal dump*

```$OLDPWD`` <internalvariables.html#OLDPWD>`_ Previous working
directory

`openssl <filearchiv.html#OPENSSLREF>`_ encryption utility

Operator

-  `Definition of <special-chars.html#OPERATORDEF>`_

-  `Precedence <opprecedence.html#OPPRECEDENCE1>`_

`Options <options.html#OPTIONSREF>`_, passed to shell or script on
command line or by `set <internal.html#SETREF>`_ command

`*Or* list <list-cons.html#ORLISTREF>`_

`*Or* logical operator <ops.html#ORREF>`_, **\|\|**

\* \* \*

`Parameter substitution <parameter-substitution.html#PARAMSUBREF>`_

-  *${parameter+alt\_value}*

   *${parameter:+alt\_value}*

   `Alternate value <parameter-substitution.html#PARAMALTV>`_ of
   parameter, if set

-  *${parameter-default}*

   *${parameter:-default}*

   *${parameter=default}*

   *${parameter:=default}*

   `Default parameters <parameter-substitution.html#DEFPARAM1>`_

-  *${!varprefix\*}*

   *${!varprefix@}*

   `Parameter *name* match <parameter-substitution.html#VARPREFIXM>`_

-  *${parameter?err\_msg}*

   `Parameter-unset message <parameter-substitution.html#QERRMSG>`_

-  *${parameter}*

   `Value of *parameter* <parameter-substitution.html#PSSUB1>`_

-  `*Case modification* <bashver4.html#CASEMODPARAMSUB>`_ (`version
   4+ <bashver4.html#BASH4REF>`_ of Bash).

-  `*Script example* <contributed-scripts.html#PW0>`_

-  `**Table** <refcards.html#PARSUBTAB>`_ of *parameter substitution*

`Parent / child process problem <gotchas.html#PARCHILDPROBREF>`_, a
*child* process cannot `export <internal.html#EXPORTREF>`_ variables to
a `parent process <internal.html#FORKREF>`_

Parentheses

-  `Command group <special-chars.html#PARENSREF>`_

-  `Enclose group <x17000.html#PARENGRPS>`_ of *Extended Regular
   Expressions*

-  `Double parentheses <dblparens.html#DBLPARENSREF>`_, in arithmetic
   expansion

```$PATH`` <internalvariables.html#PATHREF>`_, the *path* (location of
system binaries)

-  Appending directories to ``$PATH`` `using the ``+=``
   operator <bashver3.html#PATHAPPEND>`_.

`Perl <wrapper.html#PERLREF>`_, programming language

-  `Combined <wrapper.html#BASHANDPERL0>`_ in the same file with a
   *Bash* script

-  `Embedded <wrapper.html#PERLEMB>`_ in a *Bash* script

`*Perquackey*-type anagramming game <contributed-scripts.html#QKY>`_
(*Quackey* script)

`*Petals Around the Rose* <contributed-scripts.html#PETALS>`_

`PID <special-chars.html#PROCESSIDDEF>`_, *Process ID*, an
identification number assigned to a running process.

`Pipe <special-chars.html#PIPEREF>`_, **\|**, a device for passing the
output of a command to another command or to the shell

-  `Avoiding unnecessary commands <optimizations.html#CATABUSE>`_ in a
   *pipe*

-  `*Comments* embedded within <special-chars.html#COMMINPIPE>`_

-  `Exit status <exit-status.html#PIPEEX>`_ of a pipe

-  `Pipefail <bashver3.html#PIPEFAILREF>`_, *set -o pipefail* option to
   indicate `exit status <exit-status.html#EXITSTATUSREF>`_ within a
   *pipe*

-  ```$PIPESTATUS`` <internalvariables.html#PIPESTATUSREF>`_, *exit
   status* of last executed pipe

-  `Piping output of a command <special-chars.html#UCREF>`_ to a script

-  `Redirecting ``stdin`` <basic.html#CATLESSEFF>`_, rather than using
   `cat <basic.html#CATREF>`_ in a *pipe*

`Pitfalls <gotchas.html>`_

-  `**-** (dash) is *not* redirection
   operator <gotchas.html#DASHNREDR>`_

-  `**//** (double forward slash) <internal.html#DOUBLESLASHREF>`_,
   behavior of `cd <internal.html#CDREF>`_ command toward

-  `#!/bin/sh <gotchas.html#BINSH>`_ script header disables `extended
   *Bash* features <portabilityissues.html#BASHCOMPAT>`_

-  `Abuse of *cat* <optimizations.html#CATABUSE>`_

-  `*CGI* programming <gotchas.html#CGIREF>`_, using scripts for

-  Closing *limit string* in a *here document*,
   `indenting <here-docs.html#INDENTEDLS>`_

-  `DOS-type newlines (\\r\\n) <gotchas.html#DOSNEWLINES>`_ crash a
   script

-  `*Double-quoting* the *backslash* (**\\**)
   character <quotingvar.html#QUOTINGBSL>`_

-  `eval <internal.html#EVALRISK>`_, risk of using

-  `Execute permission lacking <gotchas.html#EXECPERM>`_ for commands
   within a script

-  *Exit status*, `anomalous <gotchas.html#GOTCHAEXITVALANAMALIES>`_

-  *Exit status* `of arithmetic expression *not* equivalent to an *error
   code* <gotchas.html#ARXS1>`_

-  `*Export* problem <gotchas.html#PARCHILDPROBREF>`_, *child* process
   to *parent* process

-  `Extended *Bash* features <gotchas.html#LATEVERF>`_ not available

-  `Failing to *quote* variables <gotchas.html#FAILQUOTE>`_ within
   *test* brackets

-  `*GNU* command set <gotchas.html#GNUREF>`_, in cross-platform scripts

-  *let* misuse: `attempting to set string
   variables <gotchas.html#LETBAD>`_

-  `Multiple echo statements <gotchas.html#RVTCAUTION2>`_ in a `function
   whose output is captured <assortedtips.html#RVT>`_

-  `*null* variable assignment <othertypesv.html#NULLVAR>`_

-  `Numerical and string comparison
   operators <gotchas.html#NUMSTRCOMPNE>`_ *not* equivalent

   `**=** and **-eq** <gotchas.html#EQDIF>`_ *not* interchangeable

-  `Omitting terminal *semicolon* <gotchas.html#OMITSEMICOLON>`_, in a
   *curly-bracketed* `code block <special-chars.html#CODEBLOCKREF>`_

-  Piping

   `*echo* to a loop <gotchas.html#PIPELOOP>`_

   `*echo* to *read* <gotchas.html#BADREAD0>`_ (however, this problem
   `can be circumvented <process-sub.html#GOODREAD0>`_)

   `*tail* ``-f`` to *grep* <gotchas.html#PTAILGREP>`_

-  Preserving *whitespace* within a variable, `unintended
   consequences <quotingvar.html#VARSPLITTING>`_

-  `*suid* commands inside a script <gotchas.html#SUIDSCR>`_

-  `Undocumented *Bash* features <gotchas.html#UNDOCF>`_, danger of

-  `Uninitialized variables <gotchas.html#UNINITVAR>`_

-  `Variable names <gotchas.html#INAPPVN>`_, inappropriate

-  `Variables in a *subshell* <gotchas.html#VARSUBSH>`_, *scope* limited

-  `Subshell in *while-read* loop <gotchas.html#BADREAD0>`_

-  `Whitespace <gotchas.html#WSBAD>`_, misuse of

Pointers

-  `and file descriptors <io-redirection.html#FDREF1>`_

-  `and functions <complexfunct.html#FUNCPOINTERS>`_

-  `and *indirect references* <ivr.html#IRRREF>`_

-  `and *variables* <varsubn.html#POINTERREF>`_

`Portability issues <portabilityissues.html>`_ in shell scripting

-  `Setting *path* and *umask* <assortedtips.html#SETPUM>`_

-  `A *test suite* script <portabilityissues.html#TESTSUITE0>`_ (Bash
   versus classic Bourne shell)

-  `Using *whatis* <assortedtips.html#WHATISREF3>`_

`Positional parameters <othertypesv.html#POSPARAMREF1>`_

-  ```$@`` <internalvariables.html#APPREF2>`_, as *separate* words

-  ```$*`` <internalvariables.html#APPREF>`_, as a *single* word

-  `in functions <complexfunct.html#PASSEDARGS>`_

`POSIX <sha-bang.html#POSIX2REF>`_, *Portable Operating System Interface
/ UNIX*

-  ```--posix`` option <portabilityissues.html#POSIX3REF>`_

-  `1003.2 standard <portabilityissues.html#POSIX3REF>`_

-  `Character classes <x17000.html#POSIXREF>`_

```$PPID`` <internalvariables.html#PPIDREF>`_, *process ID* of parent
process

`Precedence <opprecedence.html#OPPRECEDENCE1>`_, operator

`*Prepending* <assortedtips.html#PREPENDREF>`_ lines at head of a file,
*script example*

Prime numbers

-  Generating primes `using the *factor* command <mathc.html#PRIMES2>`_

-  Generating primes `using the *modulo*
   operator <contributed-scripts.html#PRIMES1>`_

-  Sieve of Eratosthenes, `example script <arrays.html#PRIMES0>`_

`printf <internal.html#PRINTFREF>`_, *formatted print* command

```/proc`` <procref1.html#PROCREF2>`_ directory

-  `Running processes <procref1.html#PROCRUNNING>`_, files describing

-  `Writing to files in ``/proc`` <procref1.html#PROCWARNING>`_,
   *warning*

`Process <special-chars.html#PROCESSREF>`_

-  `Child process <othertypesv.html#CHILDREF2>`_

-  `Parent process <internal.html#PARENTREF>`_

-  `Process ID <special-chars.html#PROCESSIDDEF>`_ (PID)

`Process substitution <process-sub.html#PROCESSSUBREF>`_

-  `To compare contents of directories <process-sub.html#PCC2DIR>`_

-  `To supply ``stdin`` of a command <process-sub.html#PSFDSTDIN>`_

-  `Template <process-sub.html#COMMANDSPARENS1>`_

-  `*while-read* loop without a
   *subshell* <process-sub.html#GOODREAD0>`_

`Programmable completion <tabexpansion.html>`_ (tab expansion)

Prompt

-  ```$PS1`` <internalvariables.html#PS1REF>`_, *Main prompt*, seen at
   command line

-  ```$PS2`` <internalvariables.html#SECPROMPTREF>`_, Secondary prompt

`Pseudo-code <assortedtips.html#PSEUDOCODEREF>`_, as problem-solving
method

```$PWD`` <internalvariables.html#PWDREF>`_, Current working directory

\* \* \*

`Quackey <contributed-scripts.html#QKY>`_, a *Perquackey*-type
anagramming game (script)

Question mark, **?**

-  `Character match <x17000.html#QUEXREGEX>`_ in an Extended *Regular
   Expression*

-  `Single-character *wild card* <special-chars.html#QUEXWC>`_, in
   `globbing <globbingref.html>`_

-  In a `*C*-style Trinary (ternary)
   operator <special-chars.html#CSTRINARY>`_

`Quoting <quoting.html#QUOTINGDEF>`_

-  `Character string <quoting.html#QUOTINGREF>`_

-  `Variables <quotingvar.html>`_

   `within *test* brackets <gotchas.html#FAILQUOTE>`_

-  `*Whitespace* <quotingvar.html#WSQUO>`_, using *quoting* to preserve

\* \* \*

Random numbers

-  ```/dev/urandom`` <randomvar.html#URANDOMREF>`_

-  ```rand()`` <randomvar.html#AWKRANDOMREF>`_, random function in
   `awk <awk.html#AWKREF>`_

-  ```$RANDOM`` <randomvar.html#RANDOMVAR01>`_, Bash function that
   returns a pseudorandom integer

-  `Random sequence generation <timedate.html#DATERANDREF>`_, using
   `date <timedate.html#DATEREF>`_ command

-  `Random sequence generation <extmisc.html#JOTRANDOM>`_, using
   `jot <extmisc.html#JOTREF>`_

-  `Random string <string-manipulation.html#RANDSTRING0>`_, generating

`rcs <assortedtips.html#RCSREF>`_

`read <internal.html#READREF>`_, set value of a variable from
```stdin`` <ioredirintro.html#STDINOUTDEF>`_

-  `Detecting *arrow* keys <internal.html#READARROW>`_

-  `Options <internal.html#READOPTIONS>`_

-  `Piping output of *cat* <internal.html#READPIPEREF>`_ to *read*

-  `"Prepending" text <x17700.html#HSREAD>`_

-  `Problems piping *echo* <gotchas.html#BADREAD0>`_ to *read*

-  `Redirection from a file <internal.html#READREDIR0>`_ to *read*

-  ```$REPLY`` <internalvariables.html#REPLYREF>`_, default *read*
   variable

-  `Timed input <internal.html#READTIMED>`_

-  `*while read* <loops1.html#WHILEREADREF2>`_ construct

`readline <internal.html#READLINEREF>`_ library

`Recursion <localvar.html#RECURSIONREF>`_

-  `Demonstration of <localvar.html#RECURSIONDEMO0>`_

-  `Factorial <localvar.html#FACTORIALREF>`_

-  `Fibonacci sequence <recurnolocvar.html#FIBOREF>`_

-  `Local variables <localvar.html#LOCVARRECUR>`_

-  `Script calling itself
   recursively <recursionsct.html#SCRIPTRECURSION>`_

-  `Towers of Hanoi <recurnolocvar.html#HANOIREF>`_

Redirection

-  `Code blocks <redircb.html#REDIRREF>`_

-  `exec <``filename`` <x17837.html#USINGEXECREF>`_,

   to reassign `file descriptors <io-redirection.html#FDREF>`_

-  `Introductory-level explanation <ioredirintro.html>`_ of *I/O
   redirection*

-  `Open a file <io-redirection.html#IOREDIRECTIONREF2>`_ for *both*
   reading and writing

   ``<>filename``

-  `*read* input redirected <internal.html#READREDIR0>`_ from a file

-  ```stderr`` to ``stdout`` <io-redirection.html#IOREDIRECTIONREF1>`_

   ``2>&1 ``

-  ```stdin`` / ``stdout`` <special-chars.html#COXEX>`_, using **-**

-  ```stdin``of a *function* <complexfunct.html#REDSTDINFUNC1>`_

-  ```stdout`` to a file <io-redirection.html#IOREDIRECTIONREF>`_

   ``>`` ... ``>>``

-  ```stdout`` to *file
   descriptor* <io-redirection.html#IOREDIRECTIONREF1>`_ *j*

   ``>&j ``

-  `file descriptor``i`` to *file
   descriptor* <io-redirection.html#IOREDIRECTIONREF1>`_ *j*

   ``i>&j ``

-  ```stdout`` of a command <special-chars.html#REDIROUTERROR2>`_ to
   ``stderr``

   ``>&2``

-  ```stdout`` *and* ``stderr`` of a
   command <special-chars.html#REDIROUTERROR>`_ to a file

   ``&> ``

-  `tee <extmisc.html#TEEREF>`_, redirect to a file output of command(s)
   partway through a `pipe <special-chars.html#PIPEREF>`_

`Reference Cards <refcards.html>`_

-  `Miscellaneous constructs <refcards.html#MISCTAB>`_

-  `Parameter substitution/expansion <refcards.html#PARSUBTAB>`_

-  `Special shell variables <refcards.html#SPECSHVARTAB>`_

-  `String operations <refcards.html#STRINGOPSTAB>`_

-  Test operators

   `Binary comparison <refcards.html#BINCOMPTAB>`_

   `Files <refcards.html#FILESTAB>`_

`*Regular Expressions* <regexp.html#REGEXREF>`_

-  **^** (caret) `Beginning-of-line <special-chars.html#BEGLINEREF>`_

-  **$** (dollar sign) `*Anchor* <x17000.html#DOLLARSIGNREF>`_

-  **.** (dot) `Match single character <x17000.html#REGEXDOT>`_

-  **\*** (asterisk) `Any number of
   characters <special-chars.html#ASTERISKREF2>`_

-  **[ ]** (brackets) `Enclose character set to
   match <x17000.html#BRACKETSREF>`_

-  **\\** (backslash) `Escape <x17000.html#REGEXBS>`_, interpret
   following character literally

-  **\\< ... \\>** (angle brackets, *escaped*) `Word
   boundary <x17000.html#ANGLEBRAC>`_

-  `Extended <x17000.html#EXTREGEX>`_ REs

   **+** `*Character match* <x17000.html#PLUSREF>`_

   **\\{ \\}** `Escaped "curly" brackets <x17000.html#ESCPCB>`_

   **[: :]** `POSIX character classes <x17000.html#POSIXREF>`_

```$REPLY`` <internalvariables.html#REPLYREF>`_, Default value
associated with `read <internal.html#READREF>`_ command

`Restricted shell <restricted-sh.html#RESTRICTEDSHREF>`_, shell (or
script) with certain commands disabled

`return <complexfunct.html#RETURNREF>`_, command that terminates a
`function <functions.html#FUNCTIONREF>`_

`run-parts <extmisc.html#RUNPARTSREF>`_

-  `Running scripts in sequence <assortedtips.html#RUNPARTSREF2>`_,
   without user intervention

\* \* \*

`Scope <subshells.html#SCOPEREF>`_ of a variable, definition

`Script options <options.html#INVOCATIONOPTIONSREF>`_, set at command
line

`Scripting routines <assortedtips.html#LIBROUTINES>`_, library of useful
definitions and `functions <functions.html#FUNCTIONREF>`_

`Secondary prompt <internalvariables.html#SECPROMPTREF>`_, **``$PS2``**

`Security issues <securityissues.html>`_

-  `nmap <system.html#NMAPREF>`_, *network mapper* / port scanner

-  `sudo <system.html#SUDOREF>`_

-  `*suid* commands inside a script <gotchas.html#SUIDSCR>`_

-  `Viruses, trojans, and worms <securityissues.html#INFECTEDSCRIPTS1>`_
   in scripts

-  `Writing secure scripts <securityissues.html#SECURITYTIPS1>`_

`sed <sedawk.html#SEDREF>`_, pattern-based programming language

-  `**Table** <x22929.html#SEDBASICTABLE>`_, basic operators

-  `**Table** <x22929.html#SEDOPTABLE>`_, examples of operators

`select <testbranch.html#SELECTREF>`_, construct for menu building

-  ```in          list`` omitted <testbranch.html#INLISTOMIT>`_

`Semaphore <system.html#SEMAPHOREREF>`_

`Semicolon required <loops1.html#NEEDSEMICOLON>`_, when
`do <loops1.html#DOINREF>`_ *keyword* is on first line of
`loop <loops1.html#FORLOOPREF1>`_

-  `When terminating *curly-bracketed* code
   block <gotchas.html#OMITSEMICOLON>`_

`seq <extmisc.html#SEQREF>`_, Emit a sequence of integers. Equivalent to
`jot <extmisc.html#JOTREF>`_.

`set <internal.html#SETREF>`_, Change value of internal script variables

-  `set -u <debugging.html#UNDVARERR>`_, Abort script with error message
   if attempting to use an *undeclared* variable.

`Shell script <part1.html#WHATSASCRIPT>`_, definition of

`Shell wrapper <wrapper.html#SHWRAPPER>`_, script embedding a command or
utility

`shift <othertypesv.html#SHIFTREF>`_, reassigning *positional
parameters*

```$SHLVL`` <internalvariables.html#SHLVLREF>`_, *shell level*, depth to
which the shell (or script) is nested

`shopt <internal.html#SHOPTREF>`_, change *shell options*

`Signal <debugging.html#SIGNALD>`_, a message sent to a process

Simulations

-  `Brownian motion <randomvar.html#BROWNIANREF>`_

-  `Galton board <randomvar.html#BROWNIANREF>`_

-  `Horserace <colorizing.html#HORSERACEREF>`_

-  `*Life* <contributed-scripts.html#LIFEREF>`_, game of

-  `PI <mathc.html#CANNONREF>`_, approximating by firing cannonballs

-  `Pushdown *stack* <arrays.html#STACKEX0>`_

`Single quotes <varsubn.html#SNGLQUO>`_ (**' ... '**) *strong*
`quoting <quoting.html#QUOTINGREF>`_

`Socket <devref1.html#SOCKETREF>`_, a communication node associated with
an I/O port

Sorting

-  `Bubble sort <arrays.html#BUBBLESORT>`_

-  `Insertion sort <contributed-scripts.html#INSERTIONSORT0>`_

`source <internal.html#SOURCEREF>`_, execute a script or, within a
script, import a file

-  `Passing positional parameters <internal.html#SOURCEPARAMS>`_

*Spam*, dealing with

-  `*Example script* <communications.html#SPAMLOOKUP_0>`_

-  `*Example script* <communications.html#ISSPAMMER_0>`_

-  `*Example script* <contributed-scripts.html#ISSPAMMER2_0>`_

-  `*Example script* <contributed-scripts.html#WHX0>`_

`Special characters <special-chars.html#SCHARLIST1>`_

Stack

-  `Definition <internalvariables.html#STACKDEFREF>`_

-  Emulating a *push-down stack*, `example
   script <arrays.html#STACKEX0>`_

Standard Deviation, `example script <contributed-scripts.html#STDDEV>`_

`Startup files <files.html#FILESREF1>`_, Bash

```stdin`` and ``stdout`` <ioredirintro.html#STDINOUTDEF>`_

`Stopwatch <contributed-scripts.html#STOPWATCH>`_, example script

Strings

-  **=~** `String match operator <bashver3.html#REGEXMATCHREF>`_

-  `Comparison <comparison-ops.html#SCOMPARISON1>`_

-  `Length <parameter-substitution.html#PSOREX1>`_

   ``${#string}``

-  `Manipulation <string-manipulation.html#STRINGMANIP>`_

-  `Manipulation <string-manipulation.html#AWKSTRINGMANIP2>`_, using
   `awk <awk.html#AWKREF>`_

-  `*Null* string <comparison-ops.html#STRINGNOTNULL>`_, testing for

-  `Protecting strings <contributed-scripts.html#PROTECTLITERAL0>`_ from
   expansion and/or reinterpretation, *script example*

   `*Unprotecting*
   strings <contributed-scripts.html#UNPROTECTLITERAL0>`_, *script
   example*

-  *strchr()*, `equivalent
   of <string-manipulation.html#SUBSTRINGINDEX2>`_

-  *strlen()*, `equivalent of <string-manipulation.html#STRLEN>`_

-  `strings <filearchiv.html#STRINGSREF>`_ command, find printable
   strings in a binary or data file

-  Substring extraction

   `${string:position} <string-manipulation.html#SUBSTREXTR01>`_

   `${string:position:length} <string-manipulation.html#SUBSTREXTR02>`_

   `Using *expr* <moreadv.html#EXPEXTRSUB>`_

-  `Substring *index* <string-manipulation.html#SUBSTRINGINDEX2>`_
   (numerical position in string)

-  `Substring *matching* <string-manipulation.html#EXPRPAREN>`_, using
   `expr <moreadv.html#EXPRREF>`_

-  `Substring *removal* <parameter-substitution.html#PSOREX1>`_

   `${var#Pattern} <parameter-substitution.html#PSOREXSH>`_

   `${var##Pattern} <parameter-substitution.html#PSOREXLO>`_

   `${var%Pattern} <parameter-substitution.html#PCTREP1>`_

   `${var%%Pattern} <parameter-substitution.html#PCTREP2>`_

-  Substring replacement

   `${string/substring/replacement} <string-manipulation.html#SUBSTRREPL00>`_

   `${string//substring/replacement} <string-manipulation.html#SUBSTRREPL01>`_

   `${string/#substring/replacement} <string-manipulation.html#SUBSTRREPL02>`_

   `${string/%substring/replacement} <string-manipulation.html#SUBSTRREPL03>`_

   `*Script example* <contributed-scripts.html#DAYSBETWEEN0>`_

-  `**Table** <refcards.html#STRINGOPSTAB>`_ of *string/substring*
   manipulation and extraction operators

`*Strong* quoting <varsubn.html#SNGLQUO>`_ **' ... '**

`Stylesheet <scrstyle.html>`_ for writing scripts

`Subshell <subshells.html#SUBSHELLSREF>`_

-  `Command list within parentheses <subshells.html#SUBSHELLPARENS1>`_

-  `Variables <subshells.html#SUBSHNLEVREF>`_, ``$BASH_SUBSHELL`` and
   ``$SHLVL``

-  Variables in a *subshell*

   `*scope* limited <gotchas.html#VARSUBSH>`_, but ...

   ... `can be accessed outside the
   subshell? <assortedtips.html#SUBSHTMP>`_

`su <system.html#SUREF>`_ *Substitute user*, log on as a different user
or as *root*

`suid <fto.html#SUIDREF>`_ (*set user id*) file flag

-  `*suid* commands inside a script <gotchas.html#SUIDSCR>`_, not
   advisable

`Symbolic links <basic.html#SYMLINKREF>`_

`Swapfiles <zeros.html#SWAPFILEREF>`_

\* \* \*

`Tab completion <tabexpansion.html>`_

Table lookup, `script example <bashver2.html#RESISTOR>`_

`tail <textproc.html#TAILREF>`_, *echo* to ``stdout`` lines at the
(tail) end of a text file

`tar <filearchiv.html#TARREF>`_, archiving utility

`tee <extmisc.html#TEEREF>`_, redirect to a file output of command(s)
partway through a `pipe <special-chars.html#PIPEREF>`_

`Terminals <system.html#TERMINALSSYS1>`_

-  `setserial <system.html#SETSERIALREF>`_

-  `setterm <system.html#SETTERMREF>`_

-  `stty <system.html#STTYREF>`_

-  `tput <terminalccmds.html#TPUTREF>`_

-  `wall <system.html#WALLREF>`_

*test* command

-  `Bash *builtin* <testconstructs.html#TTESTREF>`_

-  `external command <testconstructs.html#USRBINTEST>`_,
   ``/usr/bin/test`` (equivalent to ``/usr/bin/[``)

`Test constructs <testconstructs.html#TESTCONSTRUCTS1>`_

Test operators

-  **-a** `Logical AND <comparison-ops.html#COMPOUNDAND>`_ compound
   comparison

-  **-e** `File exists <fto.html#RTIF>`_

-  **-eq** `is-equal-to <comparison-ops.html#EQUALREF>`_ (integer
   comparison)

-  **-f** `File is a *regular* file <fto.html#REGULARFILE>`_

-  **-ge** `greater-than or equal <comparison-ops.html#GE0REF>`_
   (integer comparison)

-  **-gt** `greater-than <comparison-ops.html#GT0REF>`_ (integer
   comparison)

-  **-le** `less-than or equal <comparison-ops.html#LE0REF>`_ (integer
   comparison)

-  **-lt** `less-than <comparison-ops.html#LT0REF>`_ (integer
   comparison)

-  **-n** `not-zero-length <comparison-ops.html#STRINGNOTNULL>`_ (string
   comparison)

-  **-ne** `not-equal-to <comparison-ops.html#NEQUALREF>`_ (integer
   comparison)

-  **-o** `Logical OR <comparison-ops.html#COMPOUNDOR>`_ compound
   comparison

-  **-u** `*suid* flag set <fto.html#SUIDREF>`_, file test

-  **-z** `is-zero-length <comparison-ops.html#STRINGNULL>`_ (string
   comparison)

-  **=** `is-equal-to <comparison-ops.html#SCOMPARISON1>`_ (string
   comparison)

   **==** `is-equal-to <comparison-ops.html#SCOMPARISON2>`_ (string
   comparison)

-  **<** `less-than <comparison-ops.html#LTREF>`_ (string comparison)

-  **<** `less-than <comparison-ops.html#INTLT>`_, (integer comparison,
   within `double parentheses <dblparens.html>`_)

-  **<=** `less-than-or-equal <comparison-ops.html#LTEQ>`_, (integer
   comparison, within *double parentheses*)

-  **>** `greater-than <comparison-ops.html#GTREF>`_ (string comparison)

-  **>** `greater-than <comparison-ops.html#INTGT>`_, (integer
   comparison, within *double parentheses*)

-  **>=** `greater-than-or-equal <comparison-ops.html#GTEQ>`_, (integer
   comparison, within *double parentheses*)

-  **\|\|** `Logical OR <ops.html#ORREF>`_

-  **&&** `Logical AND <special-chars.html#LOGICALAND>`_

-  **!** `Negation operator <special-chars.html#NOTREF>`_, inverts `exit
   status <exit-status.html#EXITSTATUSREF>`_ of a test

   **!=** `not-equal-to <comparison-ops.html#NOTEQUAL>`_ (string
   comparison)

-  **Tables** of *test* operators

   `Binary comparison <refcards.html#BINCOMPTAB>`_

   `File <refcards.html#FILESTAB>`_

`Text and text file processing <textproc.html>`_

`Time / Date <timedate.html>`_

Timed input

-  `Using *read -t* <internal.html#READTIMED>`_

-  `Using *stty* <internalvariables.html#STTYTO>`_

-  `Using timing loop <internalvariables.html#TIMINGLOOP>`_

-  `Using ``$TMOUT`` <internalvariables.html#TMOUTREF>`_

`Tips and hints <assortedtips.html>`_ for Bash scripts

-  Array, `as *return value* from a
   function <assortedtips.html#RETARRAY>`_

-  `Capturing the return value <complexfunct.html#CAPTURERETVAL>`_ of a
   function, using *echo*

-  `*CGI* programming <networkprogramming.html#CGISCRIPT>`_, using
   scripts for

-  Comment blocks

   Using `*anonymous here documents* <here-docs.html#CBLOCK1>`_

   Using `*if-then* constructs <assortedtips.html#COMOUTBL>`_

-  `Comment headers <assortedtips.html#COMMENTH>`_, special purpose

-  `*C*-style syntax <assortedtips.html#CSTYLE>`_, for manipulating
   variables

-  `Double-spacing a text file <x22929.html#DOUBLESPACE>`_

-  Filenames prefixed with a dash, `removing <basic.html#DASHREM>`_

-  `Filter <assortedtips.html#FILTEROUTP>`_, feeding output back to
   *same* filter

-  Function`*return* value workarounds <assortedtips.html#RVT>`_

-  `*if-grep* test fixup <assortedtips.html#IFGREPFIX>`_

-  `Library <assortedtips.html#LIBROUTINES>`_ of useful definitions and
   *functions*

-  `*null* variable assignment <othertypesv.html#NULLVAR>`_, avoiding

-  `Passing an *array* <assortedtips.html#PASSARRAY>`_ to a function

-  ``$PATH``, appending to, `using the ``+=``
   operator <bashver3.html#PATHAPPEND>`_.

-  `*Prepending* <assortedtips.html#PREPENDREF>`_ lines at head of a
   file

-  `Progress bar <assortedtips.html#PROGRESSBAR>`_ template

-  `Pseudo-code <assortedtips.html#PSEUDOCODEREF>`_

-  `rcs <assortedtips.html#RCSREF>`_

-  `Redirecting a *test* to
   ``/dev/null`` <special-chars.html#DEVNULLREDIRECT>`_ to suppress
   output

-  `Running scripts in sequence <assortedtips.html#RUNPARTSREF2>`_
   without user intervention, using
   `run-parts <extmisc.html#RUNPARTSREF>`_

-  Script`as embedded command <assortedtips.html#SCRIPTASEMB>`_

-  Script *portability*

   `Setting *path* and *umask* <assortedtips.html#SETPUM>`_

   `Using *whatis* <assortedtips.html#WHATISREF3>`_

-  `Setting script variable <assortedtips.html#SETVAREMB>`_ to a block
   of embedded *sed* or *awk* code

-  Subshell variable, `accessing outside the
   subshell <assortedtips.html#SUBSHTMP>`_

-  `Testing a variable <assortedtips.html#INTPARAM>`_ to see if it
   contains only digits

-  `Testing whether a command
   exists <special-chars.html#DEVNULLREDIRECT>`_, using
   `type <internal.html#TYPEREF>`_

-  `Tracking script usage <assortedtips.html#TRACKINGSCR>`_

-  `*while-read* loop without a
   *subshell* <process-sub.html#GOODREAD0>`_

-  `Widgets <assortedtips.html#WIDGETREF>`_, invoking from a script

```$TMOUT`` <internalvariables.html#TMOUTREF>`_, Timeout interval

`Token <testconstructs.html#TOKENREF>`_, a symbol that may expand to a
`keyword <internal.html#KEYWORDREF>`_ or command

`tput <terminalccmds.html#TPUTREF>`_, terminal-control command

`tr <textproc.html#TRREF>`_, character translation filter

-  `DOS to Unix text file conversion <textproc.html#TRD2U>`_

-  `Options <textproc.html#TROPTIONS>`_

-  `Soundex <contributed-scripts.html#SOUNDEX0>`_, *example script*

-  `Variants <textproc.html#TRVARIANTS>`_

`*Trap* <debugging.html#TRAPREF1>`_, specifying an action upon receipt
of a `signal <debugging.html#SIGNALD>`_

*Trinary (ternary)* operator, *C*-style, ``var>10?88:99``

-  `in *double-parentheses* construct <special-chars.html#CSTRINARY>`_

-  `in *let* construct <internal.html#EX46>`_

`true <internal.html#TRUEREF>`_, returns *successful* (0) `exit
status <exit-status.html#EXITSTATUSREF>`_

`typeset <declareref.html#DECLARE1REF>`_ builtin

-  `options <declareref.html#DECLAREOPSREF1>`_

\* \* \*

```$UID`` <internalvariables.html#UIDREF>`_, User ID number

`unalias <aliases.html#UNALIASREF>`_, to remove an
`alias <aliases.html#ALIASREF>`_

`uname <system.html#UNAMEREF>`_, output system information

`Unicode <bashver4.html#UNICODEREF>`_, encoding standard for
representing letters and symbols

`Uninitialized variables <gotchas.html#UNINITVAR>`_

`uniq <textproc.html#UNIQREF>`_, filter to remove duplicate lines from a
sorted file

`unset <internal.html#UNSETREF>`_, delete a shell variable

`until <loops1.html#UNTILLOOPREF>`_ loop

*until [ condition-is-true ]; do*

\* \* \*

*Variables*

-  `Array operations on <arrays.html#ARRAYOPSVARS>`_

-  `Assignment <ops.html#ASNOP1>`_

   `*Script example* <varassignment.html#EX15_0>`_

   `*Script example* <varassignment.html#EX16_0>`_

   `*Script example* <varsubn.html#VARUNSETTING>`_

-  `*Bash* internal variables <internalvariables.html>`_

-  `Block of *sed* or *awk* code <assortedtips.html#SETVAREMB>`_,
   setting a variable to

-  *C-style* `increment/decrement/trinary
   operations <dblparens.html#PLUSPLUSREF>`_

-  `Change value of internal script variables <internal.html#SETREF>`_
   using *set*

-  `declare <declareref.html#DECLARE1REF>`_, to modify the properties of
   variables

-  `Deleting a shell variable <internal.html#UNSETREF>`_ using *unset*

-  `Environmental <othertypesv.html#ENVREF>`_

-  `Expansion / Substring
   replacement <parameter-substitution.html#EXPREPL1>`_ operators

-  `Indirect referencing <ivr.html#IVRREF>`_

   ``eval variable1=\$$variable2``

   `Newer notation <ivr.html#IVR2>`_

   ``${!variable}``

-  `Integer <ops.html#INTVARREF>`_

-  `Integer / string <untyped.html#BVUNTYPED>`_ (variables are untyped)

-  `Length <parameter-substitution.html#PSOREX1>`_

   ``${#var}``

-  `Lvalue <varsubn.html#LVALUEREF>`_

-  `Manipulating and expanding <parameter-substitution.html#PSSUB1>`_

-  `*Name* and *value* of a variable <varsubn.html#VARNAMEVAL>`_,
   distinguishing between

-  `*Null* string <comparison-ops.html#STRINGNOTNULL>`_, testing for

-  `*Null* variable assignment <othertypesv.html#NULLVAR>`_, avoiding

-  `Quoting <quotingvar.html>`_

   `within *test* brackets <gotchas.html#FAILQUOTE>`_

   `to preserve *whitespace* <quotingvar.html#WSQUO>`_

-  `rvalue <varsubn.html#LVALUEREF>`_

-  `Setting to *null* value <varsubn.html#VARUNSETTING>`_

-  `In *subshell* <subshells.html#PARVIS>`_ not visible to parent shell

-  Testing a variable `if it contains only
   digits <assortedtips.html#INTPARAM>`_

-  `Typing <declareref.html#TYPINGREF>`_, restricting the properties of
   a variable

-  `Undeclared <debugging.html#UNDVARERR>`_, error message

-  `Uninitialized <varsubn.html#UNINITVAR1>`_

-  `Unquoted variable <quotingvar.html#VARSPLITTING>`_, *splitting*

-  `Unsetting <internal.html#UNSETREF>`_

-  `Untyped <untyped.html#BVUNTYPED>`_

\* \* \*

`wait <x9585.html#WAITREF>`_, suspend script execution

-  `To remedy script hang <x9585.html#WAITHANG>`_

`*Weak* quoting <varsubn.html#DBLQUO>`_ **" ... "**

`while <loops1.html#WHILELOOPREF>`_ loop

*while [ condition ]; do*

-  `C-style syntax <loops1.html#WHLOOPC>`_

-  `Calling a *function* within *test*
   brackets <loops1.html#WHILEFUNC>`_

-  `Multiple conditions <loops1.html#WHMULTCOND>`_

-  `Omitting *test* brackets <loops1.html#WHILENOBRACKETS>`_

-  `*while read* <loops1.html#WHILEREADREF2>`_ construct

   `Avoiding a *subshell* <process-sub.html#GOODREAD0>`_

`Whitespace <special-chars.html#WHITESPACEREF>`_, spaces, tabs, and
newline characters

-  ```$IFS`` defaults to <internalvariables.html#IFSWS>`_

-  `Inappropriate use of <gotchas.html#WSBAD>`_

-  `Preceding closing *limit string* <here-docs.html#INDENTEDLS>`_ in a
   *here document*, error

-  `Preceding script comments <special-chars.html#WSBCOMM>`_

-  `*Quoting* <quotingvar.html#WSQUO>`_, to preserve *whitespace* within
   strings or variables

-  `[:space:] <x17000.html#WSPOSIX>`_, *POSIX* character class

`who <system.html#WHOREF>`_, information about logged on users

-  `w <system.html#WREF>`_

-  `whoami <system.html#WHOAMIREF>`_

-  `logname <system.html#LOGNAMEREF>`_

`Widgets <assortedtips.html#WIDGETREF>`_

`Wild card <globbingref.html#WILDCARDDEF>`_ characters

-  `Asterisk \* <special-chars.html#ASTERISKREF>`_

-  In ```[list]`` constructs <loops1.html#LIGLOB>`_

-  `Question mark ? <special-chars.html#WILDCARDQU>`_

-  `Will not match ``dot files`` <globbingref.html#WDOTFILEWC>`_

Word splitting

-  `Definition <quotingvar.html#WSPLITREF>`_

-  `Resulting from *command substitution* <commandsub.html#CSWS>`_

`Wrapper <wrapper.html#SHWRAPPER>`_, shell

\* \* \*

`xargs <moreadv.html#XARGSREF>`_, Filter for grouping arguments

-  `Curly brackets <moreadv.html#XARGSCURLYREF>`_

-  `Limiting arguments passed <moreadv.html#XARGSLIMARGS>`_

-  `Options <moreadv.html#XARGSLIMARGS>`_

-  Processes arguments `one at a time <moreadv.html#XARGSONEATATIME>`_

-  `Whitespace <moreadv.html#XARGSWS>`_, handling

\* \* \*

`yes <extmisc.html#YESREF>`_

-  `Emulation <extmisc.html#YESEMU>`_

\* \* \*

**-z** `String is *null* <comparison-ops.html#STRINGNULL>`_

`*Zombie* <x9585.html#ZOMBIEREF>`_, a process that has terminated, but
not yet been `killed <x9585.html#KILLREF>`_ by its
`parent <internal.html#PARENTREF>`_

--------------

+-----------------------------+------------------------+----+
| `Prev <asciitable.html>`_   | `Home <index.html>`_   |    |
+-----------------------------+------------------------+----+
| ASCII Table                 |                        |    |
+-----------------------------+------------------------+----+

