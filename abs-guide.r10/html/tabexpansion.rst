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

`Prev <systemdirs.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <localization.html>`__

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

Appendix J. An Introduction to Programmable Completion
======================================================

The *programmable completion* feature in Bash permits typing a partial
command, then pressing the **[Tab]** key to auto-complete the command
sequence. `[1] <tabexpansion.html#FTN.AEN24082>`__ If multiple
completions are possible, then **[Tab]** lists them all. Let's see how
it works.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ xtra[Tab]      |
|     xtraceroute       xt |
| rapin           xtrappro |
| to                       |
|      xtraceroute.real  x |
| trapinfo         xtrapre |
| set                      |
|      xtrapchar         x |
| trapout          xtrapst |
| ats                      |
|                          |
|                          |
|     bash$ xtrac[Tab]     |
|     xtraceroute       xt |
| raceroute.real           |
|                          |
|                          |
|     bash$ xtraceroute.r[ |
| Tab]                     |
|     xtraceroute.real     |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

Tab completion also works for variables and path names.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ echo $BASH[Tab |
| ]                        |
|     $BASH                |
|   $BASH_COMPLETION       |
| $BASH_SUBSHELL           |
|      $BASH_ARGC          |
|    $BASH_COMPLETION_DIR  |
|  $BASH_VERSINFO          |
|      $BASH_ARGV          |
|    $BASH_LINENO          |
|  $BASH_VERSION           |
|      $BASH_COMMAND       |
|    $BASH_SOURCE          |
|                          |
|                          |
|     bash$ echo /usr/loca |
| l/[Tab]                  |
|     bin/     etc/     in |
| clude/ libexec/ sbin/    |
|  src/                    |
|      doc/     games/   l |
| ib/     man/     share/  |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </p>

The Bash **complete** and **compgen**
`builtins <internal.html#BUILTINREF>`__ make it possible for *tab
completion* to recognize partial *parameters* and *options* to commands.
In a very simple case, we can use **complete** from the command-line to
specify a short list of acceptable parameters.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ touch sample_c |
| ommand                   |
|     bash$ touch file1.tx |
| t file2.txt file2.doc fi |
| le30.txt file4.zzz       |
|     bash$ chmod +x sampl |
| e_command                |
|     bash$ complete -f -X |
|  '!*.txt' sample_command |
|                          |
|                          |
|     bash$ ./sample[Tab][ |
| Tab]                     |
|     sample_command       |
|     file1.txt   file2.tx |
| t   file30.txt           |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

The ``-f`` option to *complete* specifies filenames, and ``-X`` the
filter pattern.

For anything more complex, we could write a script that specifies a list
of acceptable command-line parameters. The **compgen** builtin expands a
list of *arguments* to *generate* completion matches.

Let us take a `modified version <contributed-scripts.html#USEGETOPT2>`__
of the *UseGetOpt.sh* script as an example command. This script accepts
a number of command-line parameters, preceded by either a single or
double dash. And here is the corresponding *completion script*, by
convention given a filename corresponding to its associated command.

.. raw:: html

   <div class="EXAMPLE">

**Example J-1. Completion script for *UseGetOpt.sh***

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     # file: UseGetOpt-2  |
|     # UseGetOpt-2.sh par |
| ameter-completion        |
|                          |
|     _UseGetOpt-2 ()   #  |
|  By convention, the func |
| tion name                |
|     {                 #+ |
|  starts with an undersco |
| re.                      |
|       local cur          |
|       # Pointer to curre |
| nt completion word.      |
|       # By convention, i |
| t's named "cur" but this |
|  isn't strictly necessar |
| y.                       |
|                          |
|       COMPREPLY=()   # A |
| rray variable storing th |
| e possible completions.  |
|       cur=${COMP_WORDS[C |
| OMP_CWORD]}              |
|                          |
|       case "$cur" in     |
|         -*)              |
|         COMPREPLY=( $( c |
| ompgen -W '-a -d -f -l - |
| t -h --aoption --debug \ |
|                          |
|            --file --log  |
| --test --help --' -- $cu |
| r ) );;                  |
|     #   Generate the com |
| pletion matches and load |
|  them into $COMPREPLY ar |
| ray.                     |
|     #   xx) May add more |
|  cases here.             |
|     #   yy)              |
|     #   zz)              |
|       esac               |
|                          |
|       return 0           |
|     }                    |
|                          |
|     complete -F _UseGetO |
| pt-2 -o filenames ./UseG |
| etOpt-2.sh               |
|     #        ^^ ^^^^^^^^ |
| ^^^^  Invokes the functi |
| on _UseGetOpt-2.         |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

Now, let's try it.

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ source UseGetO |
| pt-2                     |
|                          |
|     bash$ ./UseGetOpt-2. |
| sh -[Tab]                |
|     --         --aoption |
|   --debug    --file      |
| --help     --log     --t |
| est                      |
|      -a         -d       |
|    -f         -h         |
|  -l         -t           |
|                          |
|                          |
|     bash$ ./UseGetOpt-2. |
| sh --[Tab]               |
|     --         --aoption |
|   --debug    --file      |
| --help     --log     --t |
| est                      |
|                          |
                          
+--------------------------+--------------------------+--------------------------+

We begin by `sourcing <internal.html#SOURCEREF>`__ the "completion
script." This sets the command-line parameters.
`[2] <tabexpansion.html#FTN.AEN24160>`__

In the first instance, hitting **[Tab]** after a single dash, the output
is all the possible parameters preceded by *one or more* dashes. Hitting
**[Tab]** after *two* dashes gives the possible parameters preceded by
*two or more* dashes.

Now, just what is the point of having to jump through flaming hoops to
enable command-line tab completion? *It saves keystrokes.*
`[3] <tabexpansion.html#FTN.AEN24173>`__

--

*Resources:*

Bash `programmable
completion <http://freshmeat.net/projects/bashcompletion>`__ project

Mitch Frazier's `*Linux Journal* <http://www.linuxjournal.com>`__
article, `*More on Using the Bash Complete
Command* <http://www.linuxjournal.com/content/more-using-bash-complete-command>`__

Steve's excellent two-part article, "An Introduction to Bash
Completion": `Part
1 <http://www.debian-administration.org/article/An_introduction_to_bash_completion_part_1>`__
and `Part
2 <http://www.debian-administration.org/article/An_introduction_to_bash_completion_part_2>`__

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <tabexpansion.html#AEN24082>`__ | `[2] <tabexpansion.html#AEN24160>`__ |
| This works only from the *command    | Normally the default parameter       |
| line*, of course, and not within a   | completion files reside in either    |
| script.                              | the ``/etc/profile.d`` directory or  |
|                                      | in ``/etc/bash_completion``. These   |
|                                      | autoload on system startup. So,      |
|                                      | after writing a useful completion    |
|                                      | script, you might wish to move it    |
|                                      | (as *root*, of course) to one of     |
|                                      | these directories.                   |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <systemdirs.html>` | Important System         |
| __                       | Directories              |
| `Home <index.html>`__    |                          |
| `Next <localization.html | Localization             |
| >`__                     |                          |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

