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

`Prev <tabexpansion.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <histcommands.html>`__

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

  Appendix K. Localization
=========================

Localization is an undocumented Bash feature.

 A localized shell script echoes its text output in the language defined
as the system's locale. A Linux user in Berlin, Germany, would get
script output in German, whereas his cousin in Berlin, Maryland, would
get output from the same script in English.

To create a localized script, use the following template to write all
messages to the user (error messages, prompts, etc.).

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # localized.sh       |
|     #  Script by Stéphan |
| e Chazelas,              |
|     #+ modified by Bruno |
|  Haible, bugfixed by Alf |
| redo Pironti.            |
|                          |
|     . gettext.sh         |
|                          |
|     E_CDERROR=65         |
|                          |
|     error()              |
|     {                    |
|       printf "$@" >&2    |
|       exit $E_CDERROR    |
|     }                    |
|                          |
|     cd $var || error "`e |
| val_gettext \"Can\'t cd  |
| to \\\$var.\"`"          |
|     #  The triple backsl |
| ashes (escapes) in front |
|  of $var needed          |
|     #+ "because eval_get |
| text expects a string    |
|     #+ where the variabl |
| e values have not yet be |
| en substituted."         |
|     #    -- per Bruno Ha |
| ible                     |
|     read -p "`gettext \" |
| Enter the value: \"`" va |
| r                        |
|     #  ...               |
|                          |
|                          |
|     #  ----------------- |
| ------------------------ |
| ------------------------ |
| -                        |
|     #  Alfredo Pironti c |
| omments:                 |
|                          |
|     #  This script has b |
| een modified to not use  |
| the $"..." syntax in     |
|     #+ favor of the "`ge |
| ttext \"...\"`" syntax.  |
|     #  This is ok, but w |
| ith the new localized.sh |
|  program, the commands   |
|     #+ "bash -D filename |
| " and "bash --dump-po-st |
| ring filename"           |
|     #+ will produce no o |
| utput                    |
|     #+ (because those co |
| mmand are only searching |
|  for the $"..." strings) |
| !                        |
|     #  The ONLY way to e |
| xtract strings from the  |
| new file is to use the   |
|     # 'xgettext' program |
| . However, the xgettext  |
| program is buggy.        |
|                          |
|     # Note that 'xgettex |
| t' has another bug.      |
|     #                    |
|     # The shell fragment |
| :                        |
|     #    gettext -s "I l |
| ike Bash"                |
|     # will be correctly  |
| extracted, but . . .     |
|     #    xgettext -s "I  |
| like Bash"               |
|     # . . . fails!       |
|     #  'xgettext' will e |
| xtract "-s" because      |
|     #+ the command only  |
| extracts the             |
|     #+ very first argume |
| nt after the 'gettext' w |
| ord.                     |
|                          |
|                          |
|     #  Escape characters |
| :                        |
|     #                    |
|     #  To localize a sen |
| tence like               |
|     #     echo -e "Hello |
| \tworld!"                |
|     #+ you must use      |
|     #     echo -e "`gett |
| ext \"Hello\\tworld\"`"  |
|     #  The "double escap |
| e character" before the  |
| `t' is needed because    |
|     #+ 'gettext' will se |
| arch for a string like:  |
| 'Hello\tworld'           |
|     #  This is because g |
| ettext will read one lit |
| eral `\')                |
|     #+ and will output a |
|  string like "Bonjour\tm |
| onde",                   |
|     #+ so the 'echo' com |
| mand will display the me |
| ssage correctly.         |
|     #                    |
|     #  You may not use   |
|     #     echo "`gettext |
|  -e \"Hello\tworld\"`"   |
|     #+ due to the xgette |
| xt bug explained above.  |
|                          |
|                          |
|                          |
|     # Let's localize the |
|  following shell fragmen |
| t:                       |
|     #     echo "-h displ |
| ay help and exit"        |
|     #                    |
|     # First, one could d |
| o this:                  |
|     #     echo "`gettext |
|  \"-h display help and e |
| xit\"`"                  |
|     #  This way 'xgettex |
| t' will work ok,         |
|     #+ but the 'gettext' |
|  program will read "-h"  |
| as an option!            |
|     #                    |
|     # One solution could |
|  be                      |
|     #     echo "`gettext |
|  -- \"-h display help an |
| d exit\"`"               |
|     #  This way 'gettext |
| ' will work,             |
|     #+ but 'xgettext' wi |
| ll extract "--", as refe |
| rred to above.           |
|     #                    |
|     # The workaround you |
|  may use to get this str |
| ing localized is         |
|     #     echo -e "`gett |
| ext \"\\0-h display help |
|  and exit\"`"            |
|     #  We have added a \ |
| 0 (NULL) at the beginnin |
| g of the sentence.       |
|     #  This way 'gettext |
| ' works correctly, as do |
| es 'xgettext.'           |
|     #  Moreover, the NUL |
| L character won't change |
|  the behavior            |
|     #+ of the 'echo' com |
| mand.                    |
|     #  ----------------- |
| ------------------------ |
| ------------------------ |
| -                        |
                          
+--------------------------+--------------------------+--------------------------+

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ bash -D locali |
| zed.sh                   |
|     "Can't cd to %s."    |
|      "Enter the value: " |
                          
+--------------------------+--------------------------+--------------------------+

This lists all the localized text. (The ``     -D    `` option lists
double-quoted strings prefixed by a $ , without executing the script.)

+--------------------------+--------------------------+--------------------------+
| .. code:: SCREEN         |
|                          |
|     bash$ bash --dump-po |
| -strings localized.sh    |
|     #: a:6               |
|      msgid "Can't cd to  |
| %s."                     |
|      msgstr ""           |
|      #: a:7              |
|      msgid "Enter the va |
| lue: "                   |
|      msgstr ""           |
                          
+--------------------------+--------------------------+--------------------------+

The ``     --dump-po-strings    `` option to Bash resembles the
``     -D    `` option, but uses `gettext <textproc.html#GETTEXTREF>`__
"po" format.

.. raw:: html

   <div class="NOTE">

+--------------+--------------+--------------+--------------+--------------+--------------+
| |Note|       |
| Bruno Haible |
| points out:  |
|              |
| Starting     |
| with         |
| gettext-0.12 |
| .2,          |
| **xgettext   |
| -o -         |
| localized.sh |
| **           |
| is           |
| recommended  |
| instead of   |
| **bash       |
| --dump-po-st |
| rings        |
| localized.sh |
| **           |
| , because    |
| **xgettext** |
| . . .        |
|              |
| 1.           |
| understands  |
| the gettext  |
| and          |
| eval\_gettex |
| t            |
| commands     |
| (whereas     |
| bash         |
| --dump-po-st |
| rings        |
| understands  |
| only its     |
| deprecated   |
| $"..."       |
| syntax)      |
|              |
| 2. can       |
| extract      |
| comments     |
| placed by    |
| the          |
| programmer,  |
| intended to  |
| be read by   |
| the          |
| translator.  |
|              |
| This shell   |
| code is then |
| not specific |
| to Bash any  |
| more; it     |
| works the    |
| same way     |
| with Bash    |
| 1.x and      |
| other        |
| /bin/sh      |
| implementati |
| ons.         |
+--------------+--------------+--------------+--------------+--------------+--------------+

.. raw:: html

   </div>

Now, build a ``      language.po     `` file for each language that the
script will be translated into, specifying the
``             msgstr           `` . Alfredo Pironti gives the following
example:

fr.po:

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #: a:6               |
|     msgid "Can't cd to $ |
| var."                    |
|     msgstr "Impossible d |
| e se positionner dans le |
|  repertoire $var."       |
|     #: a:7               |
|     msgid "Enter the val |
| ue: "                    |
|     msgstr "Entrez la va |
| leur : "                 |
|                          |
|     #  The string are du |
| mped with the variable n |
| ames, not with the %s sy |
| ntax,                    |
|     #+ similar to C prog |
| rams.                    |
|     #+ This is a very co |
| ol feature if the progra |
| mmer uses                |
|     #+ variable names th |
| at make sense!           |
                          
+--------------------------+--------------------------+--------------------------+

Then, run `msgfmt <textproc.html#MSGFMTREF>`__ .

``             msgfmt -o localized.sh.mo fr.po           ``

Place the resulting ``      localized.sh.mo     `` file in the
``      /usr/local/share/locale/fr/LC_MESSAGES     `` directory, and at
the beginning of the script, insert the lines:

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     TEXTDOMAINDIR=/usr/l |
| ocal/share/locale        |
|     TEXTDOMAIN=localized |
| .sh                      |
                          
+--------------------------+--------------------------+--------------------------+

If a user on a French system runs the script, she will get French
messages.

.. raw:: html

   <div class="NOTE">

+--------------------+--------------------+--------------------+--------------------+
| |Note|             |
| With older         |
| versions of Bash   |
| or other shells,   |
| localization       |
| requires           |
| `gettext <textproc |
| .html#GETTEXTREF>` |
| __                 |
| , using the        |
| ``          -s     |
|      ``            |
| option. In this    |
| case, the script   |
| becomes:           |
|                    |
| +----------------- |
| ---------+-------- |
| ------------------ |
| +----------------- |
| ---------+         |
| | .. code:: PROGRA |
| MLISTING |         |
| |                  |
|          |         |
| |     #!/bin/bash  |
|          |         |
| |     # localized. |
| sh       |         |
| |                  |
|          |         |
| |     E_CDERROR=65 |
|          |         |
| |                  |
|          |         |
| |     error() {    |
|          |         |
| |       local form |
| at=$1    |         |
| |       shift      |
|          |         |
| |       printf "$( |
| gettext  |         |
| | -s "$format")" " |
| $@" >&2  |         |
| |       exit $E_CD |
| ERROR    |         |
| |     }            |
|          |         |
| |     cd $var || e |
| rror "Ca |         |
| | n't cd to %s." " |
| $var"    |         |
| |     read -p "$(g |
| ettext - |         |
| | s "Enter the val |
| ue: ")"  |         |
| | var              |
|          |         |
| |     # ...        |
|          |         |
|                    |
|                    |
| +----------------- |
| ---------+-------- |
| ------------------ |
| +----------------- |
| ---------+         |
                    
+--------------------+--------------------+--------------------+--------------------+

.. raw:: html

   </div>

The ``      TEXTDOMAIN     `` and ``      TEXTDOMAINDIR     `` variables
need to be set and exported to the environment. This should be done
within the script itself.

---

This appendix written by Stéphane Chazelas, with modifications suggested
by Alfredo Pironti, and by Bruno Haible, maintainer of GNU
`gettext <textproc.html#GETTEXTREF>`__ .

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

`Prev <tabexpansion.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

`Home <index.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

`Next <histcommands.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

An Introduction to Programmable Completion

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

History Commands

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
