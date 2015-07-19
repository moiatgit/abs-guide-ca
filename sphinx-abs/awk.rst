
#############
XXX  C.2. Awk
#############

*Awk* ` [1]  <awk.html#FTN.AEN23443>`__ is a full-featured text
processing language with a syntax reminiscent of *C* . While it
possesses an extensive set of operators and capabilities, we will cover
only a few of these here - the ones most useful in shell scripts.

Awk breaks each line of input passed to it into
`fields <special-chars.html#FIELDREF>`__ . By default, a field is a
string of consecutive characters delimited by
`whitespace <special-chars.html#WHITESPACEREF>`__ , though there are
options for changing this. Awk parses and operates on each separate
field. This makes it ideal for handling structured text files --
especially tables -- data organized into consistent chunks, such as rows
and columns.

`Strong quoting <varsubn.html#SNGLQUO>`__ and `curly
brackets <special-chars.html#CODEBLOCKREF>`__ enclose blocks of awk code
within a shell script.


.. code-block:: sh

    # $1 is field #1, $2 is field #2, etc.

    echo one twoawk '{print $1}'
    # one

    echo one twoawk '{print $2}'
    # two

    # But what is field #0 ($0)?
    echo one twoawk '{print $0}'
    # one two
    # All the fields!


    awk '{print $3}' $filename
    # Prints field #3 of file $filename to stdout.

    awk '{print $1 $5 $6}' $filename
    # Prints fields #1, #5, and #6 of file $filename.

    awk '{print $0}' $filename
    # Prints the entire file!
    # Same effect as:   cat $filename . . . or . . . sed '' $filename



We have just seen the awk *print* command in action. The only other
feature of awk we need to deal with here is variables. Awk handles
variables similarly to shell scripts, though a bit more flexibly.


.. code-block:: sh

    { total += ${column_number} }



This adds the value of ``           column_number         `` to the
running total of ``           total         `` >. Finally, to print
"total" , there is an **END** command block, executed after the script
has processed all its input.


.. code-block:: sh

    END { print total }



Corresponding to the **END** , there is a **BEGIN** , for a code block
to be performed before awk starts processing its input.

The following example illustrates how **awk** can add text-parsing tools
to a shell script.


**Example C-1. Counting Letter Occurrences**


.. code-block:: sh

    #! /bin/sh
    # letter-count2.sh: Counting letter occurrences in a text file.
    #
    # Script by nyal [nyal@voila.fr].
    # Used in ABS Guide with permission.
    # Recommented and reformatted by ABS Guide author.
    # Version 1.1: Modified to work with gawk 3.1.3.
    #              (Will still work with earlier versions.)


    INIT_TAB_AWK=""
    # Parameter to initialize awk script.
    count_case=0
    FILE_PARSE=$1

    E_PARAMERR=85

    usage()
    {
        echo "Usage: letter-count.sh file letters" 2>&1
        # For example:   ./letter-count2.sh filename.txt a b c
        exit $E_PARAMERR  # Too few arguments passed to script.
    }

    if [ ! -f "$1" ] ; then
        echo "$1: No such file." 2>&1
        usage                 # Print usage message and exit.
    fi

    if [ -z "$2" ] ; then
        echo "$2: No letters specified." 2>&1
        usage
    fi

    shift                      # Letters specified.
    for letter in `echo $@`    # For each one . . .
      do
      INIT_TAB_AWK="$INIT_TAB_AWK tab_search[${count_case}] = \
      \"$letter\"; final_tab[${count_case}] = 0; "
      # Pass as parameter to awk script below.
      count_case=`expr $count_case + 1`
    done

    # DEBUG:
    # echo $INIT_TAB_AWK;

    cat $FILE_PARSE
    # Pipe the target file to the following awk script.

    # ---------------------------------------------------------------------
    # Earlier version of script:
    # awk -v tab_search=0 -v final_tab=0 -v tab=0 -v \
    # nb_letter=0 -v chara=0 -v chara2=0 \

    awk \
    "BEGIN { $INIT_TAB_AWK } \
    { split(\$0, tab, \"\"); \
    for (chara in tab) \
    { for (chara2 in tab_search) \
    { if (tab_search[chara2] == tab[chara]) { final_tab[chara2]++ } } } } \
    END { for (chara in final_tab) \
    { print tab_search[chara] \" => \" final_tab[chara] } }"
    # ---------------------------------------------------------------------
    #  Nothing all that complicated, just . . .
    #+ for-loops, if-tests, and a couple of specialized functions.

    exit $?

    # Compare this script to letter-count.sh.




For simpler examples of awk within shell scripts, see:

#. `Example 15-14 <internal.html#EX44>`__

#. `Example 20-8 <redircb.html#REDIR4>`__

#. `Example 16-32 <filearchiv.html#STRIPC>`__

#. `Example 36-5 <wrapper.html#COLTOTALER>`__

#. `Example 28-2 <ivr.html#COLTOTALER2>`__

#. `Example 15-20 <internal.html#COLTOTALER3>`__

#. `Example 29-3 <procref1.html#PIDID>`__

#. `Example 29-4 <procref1.html#CONSTAT>`__

#. `Example 11-3 <loops1.html#FILEINFO>`__

#. `Example 16-61 <extmisc.html#BLOTOUT>`__

#. `Example 9-16 <randomvar.html#SEEDINGRANDOM>`__

#. `Example 16-4 <moreadv.html#IDELETE>`__

#. `Example 10-6 <string-manipulation.html#SUBSTRINGEX>`__

#. `Example 36-19 <assortedtips.html#SUMPRODUCT>`__

#. `Example 11-9 <loops1.html#USERLIST>`__

#. `Example 36-4 <wrapper.html#PRASC>`__

#. `Example 16-53 <mathc.html#HYPOT>`__

#. `Example T-3 <asciitable.html#ASCII3SH>`__

That's all the awk we'll cover here, folks, but there's lots more to
learn. See the appropriate references in the
`*Bibliography* <biblio.html>`__ .


Notes
~~~~~


` [1]  <awk.html#AEN23443>`__

Its name derives from the initials of its authors, **A** ho, **W**
einberg, and **K** ernighan.



