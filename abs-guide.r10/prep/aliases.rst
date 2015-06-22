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

`Prev <recurnolocvar.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <list-cons.html>`__

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

   <div class="CHAPTER">

  Chapter 25. Aliases
====================

A Bash *alias* is essentially nothing more than a keyboard shortcut, an
abbreviation, a means of avoiding typing a long command sequence. If,
for example, we include **alias lm="ls -l \| more"** in the
```       ~/.bashrc      `` file <sample-bashrc.html>`__ , then each
``             lm           `` ` [1]  <aliases.html#FTN.AEN18669>`__
typed at the command-line will automatically be replaced by a **ls -l \|
more** . This can save a great deal of typing at the command-line and
avoid having to remember complex combinations of commands and options.
Setting **alias rm="rm -i"** (interactive mode delete) may save a good
deal of grief, since it can prevent inadvertently deleting important
files.

In a script, aliases have very limited usefulness. It would be nice if
aliases could assume some of the functionality of the **C**
preprocessor, such as macro expansion, but unfortunately Bash does not
expand arguments within the alias body. ` [2]
 <aliases.html#FTN.AEN18676>`__ Moreover, a script fails to expand an
alias itself within "compound constructs," such as
`if/then <tests.html#IFTHEN>`__ statements, loops, and functions. An
added limitation is that an alias will not expand recursively. Almost
invariably, whatever we would like an alias to do could be accomplished
much more effectively with a `function <functions.html#FUNCTIONREF>`__ .

.. raw:: html

   <div class="EXAMPLE">

**Example 25-1. Aliases within a script**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # alias.sh           |
|                          |
|     shopt -s expand_alia |
| ses                      |
|     # Must set this opti |
| on, else script will not |
|  expand aliases.         |
|                          |
|                          |
|     # First, some fun.   |
|     alias Jesse_James='e |
| cho "\"Alias Jesse James |
| \" was a 1959 comedy sta |
| rring Bob Hope."'        |
|     Jesse_James          |
|                          |
|     echo; echo; echo;    |
|                          |
|     alias ll="ls -l"     |
|     # May use either sin |
| gle (') or double (") qu |
| otes to define an alias. |
|                          |
|     echo "Trying aliased |
|  \"ll\":"                |
|     ll /usr/X11R6/bin/mk |
| *   #* Alias works.      |
|                          |
|     echo                 |
|                          |
|     directory=/usr/X11R6 |
| /bin/                    |
|     prefix=mk*  # See if |
|  wild card causes proble |
| ms.                      |
|     echo "Variables \"di |
| rectory\" + \"prefix\" = |
|  $directory$prefix"      |
|     echo                 |
|                          |
|     alias lll="ls -l $di |
| rectory$prefix"          |
|                          |
|     echo "Trying aliased |
|  \"lll\":"               |
|     lll         # Long l |
| isting of all files in / |
| usr/X11R6/bin stating wi |
| th mk.                   |
|     # An alias can handl |
| e concatenated variables |
|  -- including wild card  |
| -- o.k.                  |
|                          |
|                          |
|                          |
|                          |
|     TRUE=1               |
|                          |
|     echo                 |
|                          |
|     if [ TRUE ]          |
|     then                 |
|       alias rr="ls -l"   |
|       echo "Trying alias |
| ed \"rr\" within if/then |
|  statement:"             |
|       rr /usr/X11R6/bin/ |
| mk*   #* Error message r |
| esults!                  |
|       # Aliases not expa |
| nded within compound sta |
| tements.                 |
|       echo "However, pre |
| viously expanded alias s |
| till recognized:"        |
|       ll /usr/X11R6/bin/ |
| mk*                      |
|     fi                   |
|                          |
|     echo                 |
|                          |
|     count=0              |
|     while [ $count -lt 3 |
|  ]                       |
|     do                   |
|       alias rrr="ls -l"  |
|       echo "Trying alias |
| ed \"rrr\" within \"whil |
| e\" loop:"               |
|       rrr /usr/X11R6/bin |
| /mk*   #* Alias will not |
|  expand here either.     |
|                          |
|        #  alias.sh: line |
|  57: rrr: command not fo |
| und                      |
|       let count+=1       |
|     done                 |
|                          |
|     echo; echo           |
|                          |
|     alias xyz='cat $0'   |
|  # Script lists itself.  |
|                          |
|  # Note strong quotes.   |
|     xyz                  |
|     #  This seems to wor |
| k,                       |
|     #+ although the Bash |
|  documentation suggests  |
| that it shouldn't.       |
|     #                    |
|     #  However, as Steve |
|  Jacobson points out,    |
|     #+ the "$0" paramete |
| r expands immediately up |
| on declaration of the al |
| ias.                     |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

The **unalias** command removes a previously set *alias* .

.. raw:: html

   <div class="EXAMPLE">

**Example 25-2. *unalias* : Setting and unsetting an alias**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # unalias.sh         |
|                          |
|     shopt -s expand_alia |
| ses  # Enables alias exp |
| ansion.                  |
|                          |
|     alias llm='ls -al |  |
| more'                    |
|     llm                  |
|                          |
|     echo                 |
|                          |
|     unalias llm          |
|      # Unset alias.      |
|     llm                  |
|     # Error message resu |
| lts, since 'llm' no long |
| er recognized.           |
|                          |
|     exit 0               |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ ./unalias.sh   |
|     total 6              |
|     drwxrwxr-x    2 bozo |
|      bozo         3072 F |
| eb  6 14:04 .            |
|     drwxr-xr-x   40 bozo |
|      bozo         2048 F |
| eb  6 14:04 ..           |
|     -rwxr-xr-x    1 bozo |
|      bozo          199 F |
| eb  6 14:04 unalias.sh   |
|                          |
|     ./unalias.sh: llm: c |
| ommand not found         |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| ` [1]  <aliases.html#AEN18669>`__    | ` [2]  <aliases.html#AEN18676>`__    |
| ... as the first word of a command   | However, aliases do seem to expand   |
| string. Obviously, an alias is only  | positional parameters.               |
| meaningful at the *beginning* of a   |                                      |
| command.                             |                                      |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <recurnolocvar.htm | Recursion Without Local  |
| l>`__                    | Variables                |
| `Home <index.html>`__    | `Up <part5.html>`__      |
| `Next <list-cons.html>`_ | List Constructs          |
| _                        |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

