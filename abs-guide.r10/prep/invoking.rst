
#############################
XXX  2.1. Invoking the script
#############################

Having written the script, you can invoke it by
``             sh     scriptname           `` , ` [1]
 <invoking.html#FTN.AEN300>`__ or alternatively
``             bash scriptname           `` . (Not recommended is using
``             sh <scriptname           `` , since this effectively
disables reading from
```       stdin      `` <ioredirintro.html#STDINOUTDEF>`__ within the
script.) Much more convenient is to make the script itself directly
executable with a `chmod <basic.html#CHMODREF>`__ .


 Either:
    ``                   chmod 555 scriptname                 `` (gives
    everyone read/execute permission) ` [2]
     <invoking.html#FTN.AEN315>`__

 or
    ``                   chmod +rx scriptname                 `` (gives
    everyone read/execute permission)

    ``                   chmod           u+rx scriptname                 ``
    (gives only the script owner read/execute permission)


Having made the script executable, you may now test it by
``             ./scriptname           `` . ` [3]
 <invoking.html#FTN.AEN327>`__ If it begins with a "sha-bang" line,
invoking the script calls the correct command interpreter to run it.

As a final step, after testing and debugging, you would likely want to
move it to ``      /usr/local/bin     `` (as *root* , of course), to
make the script available to yourself and all other users as a
systemwide executable. The script could then be invoked by simply typing
**scriptname** **[ENTER]** from the command-line.


Notes
~~~~~


` [1]  <invoking.html#AEN300>`__

Caution: invoking a *Bash* script by
``               sh scriptname             `` turns off Bash-specific
extensions, and the script may therefore fail to execute.


` [2]  <invoking.html#AEN315>`__

A script needs *read* , as well as execute permission for it to run,
since the shell needs to be able to read it.


` [3]  <invoking.html#AEN327>`__

Why not simply invoke the script with
``               scriptname             `` ? If the directory you are in
( `$PWD <internalvariables.html#PWDREF>`__ ) is where
``       scriptname      `` is located, why doesn't this work? This
fails because, for security reasons, the current directory (
``       ./      `` ) is not by default included in a user's
`$PATH <internalvariables.html#PATHREF>`__ . It is therefore necessary
to explicitly invoke the script in the current directory with a
``               ./scriptname             `` .



