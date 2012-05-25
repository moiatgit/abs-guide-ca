+----------------------------------+----+---------------------------+
| Advanced Bash-Scripting Guide:   |
+==================================+====+===========================+
| `Prev <recess-time.html>`_       |    | `Next <internal.html>`_   |
+----------------------------------+----+---------------------------+

--------------

Part 4. Commands
================

Mastering the commands on your Linux machine is an indispensable prelude
to writing effective shell scripts.

This section covers the following commands:

-  `. <special-chars.html#DOTREF>`_ (See also
   `source <internal.html#SOURCEREF>`_)

-  `ac <system.html#ACREF>`_

-  `adduser <system.html#USERADDREF>`_

-  `agetty <system.html#AGETTYREF>`_

-  `agrep <textproc.html#AGREPREF>`_

-  `ar <filearchiv.html#ARREF>`_

-  `arch <system.html#ARCHREF>`_

-  `at <timedate.html#ATREF>`_

-  `autoload <x9585.html#AUTOLOADREF>`_

-  `awk <awk.html#AWKREF>`_ (See also `Using **awk** for math
   operations <mathc.html#AWKMATH>`_)

-  `badblocks <system.html#BADBLOCKSREF>`_

-  `banner <extmisc.html#BANNERREF>`_

-  `basename <filearchiv.html#BASENAMEREF>`_

-  `batch <timedate.html#BATCHREF>`_

-  `bc <mathc.html#BCREF>`_

-  `bg <x9585.html#BGREF>`_

-  `bind <internal.html#BINDREF>`_

-  `bison <textproc.html#BISONREF>`_

-  `builtin <x9585.html#BLTREF>`_

-  `bzgrep <textproc.html#BZGREPREF>`_

-  `bzip2 <filearchiv.html#BZIPREF>`_

-  `cal <timedate.html#CALREF>`_

-  `caller <internal.html#CALLERREF>`_

-  `cat <basic.html#CATREF>`_

-  `cd <internal.html#CDREF>`_

-  `chattr <basic.html#CHATTRREF>`_

-  `chfn <communications.html#CHFNREF>`_

-  `chgrp <system.html#CHGRPREF>`_

-  `chkconfig <system.html#CHKCONFIGREF>`_

-  `chmod <basic.html#CHMODREF>`_

-  `chown <system.html#CHOWNREF>`_

-  `chroot <system.html#CHROOTREF>`_

-  `cksum <filearchiv.html#CKSUMREF>`_

-  `clear <terminalccmds.html#CLEARREF>`_

-  `clock <timedate.html#CLOCKREF>`_

-  `cmp <filearchiv.html#CMPREF>`_

-  `col <textproc.html#COLREF>`_

-  `colrm <textproc.html#COLRMREF>`_

-  `column <textproc.html#COLUMNREF>`_

-  `comm <filearchiv.html#COMMREF>`_

-  `command <x9585.html#COMMANDREF>`_

-  `compgen <tabexpansion.html#COMPGENREF>`_

-  `complete <tabexpansion.html#COMPLETEREF>`_

-  `compress <filearchiv.html#COMPRESSREF>`_

-  `coproc <bashver4.html#COPROCREF>`_

-  `cp <basic.html#CPREF>`_

-  `cpio <filearchiv.html#CPIOREF>`_

-  `cron <system.html#CRONREF>`_

-  `crypt <filearchiv.html#CRYPTREF>`_

-  `csplit <filearchiv.html#CSPLITREF>`_

-  `cu <communications.html#CUREF>`_

-  `cut <textproc.html#CUTREF>`_

-  `date <timedate.html#DATEREF>`_

-  `dc <mathc.html#DCREF>`_

-  `dd <extmisc.html#DDREF>`_

-  `debugfs <system.html#DEBUGFSREF>`_

-  `declare <declareref.html>`_

-  `depmod <system.html#DEPMODREF>`_

-  `df <system.html#DFREF>`_

-  `dialog <assortedtips.html#DIALOGREF>`_

-  `diff <filearchiv.html#DIFFREF>`_

-  `diff3 <filearchiv.html#DIFF3REF>`_

-  `diffstat <filearchiv.html#DIFFSTATREF>`_

-  `dig <communications.html#DIGREF>`_

-  `dirname <filearchiv.html#DIRNAMEREF>`_

-  `dirs <internal.html#DIRSD>`_

-  `disown <x9585.html#DISOWNREF>`_

-  `dmesg <system.html#DMESGREF>`_

-  `doexec <extmisc.html#DOEXECREF>`_

-  `dos2unix <filearchiv.html#DOS2UNIXREF>`_

-  `du <system.html#DUREF>`_

-  `dump <system.html#DUMPREF>`_

-  `dumpe2fs <system.html#DUMPE2FSREF>`_

-  `e2fsck <system.html#E2FSCKREF>`_

-  `echo <internal.html#ECHOREF>`_

-  `egrep <textproc.html#EGREPREF>`_

-  `enable <x9585.html#ENABLEREF>`_

-  `enscript <textproc.html#ENSCRIPTREF>`_

-  `env <system.html#ENVVREF>`_

-  `eqn <textproc.html#EQNREF>`_

-  `eval <internal.html#EVALREF>`_

-  `exec <internal.html#EXECREF>`_

-  `exit <internal.html#EXITREF>`_ (Related topic: `exit
   status <exit-status.html#EXITSTATUSREF>`_)

-  `expand <textproc.html#EXPANDREF>`_

-  `export <internal.html#EXPORTREF>`_

-  `expr <moreadv.html#EXPRREF>`_

-  `factor <mathc.html#FACTORREF>`_

-  `false <internal.html#FALSEREF>`_

-  `fdformat <system.html#FDFORMATREF>`_

-  `fdisk <system.html#FDISKREF>`_

-  `fg <x9585.html#FGREF>`_

-  `fgrep <textproc.html#FGREPREF>`_

-  `file <filearchiv.html#FILEREF>`_

-  `find <moreadv.html#FINDREF>`_

-  `finger <communications.html#FINGERREF>`_

-  `flex <textproc.html#FLEXREF>`_

-  `flock <system.html#FLOCKREF>`_

-  `fmt <textproc.html#FMTREF>`_

-  `fold <textproc.html#FOLDREF>`_

-  `free <system.html#FREEREF>`_

-  `fsck <system.html#FSCKREF>`_

-  `ftp <communications.html#FTPREF>`_

-  `fuser <system.html#FUSERREF>`_

-  `getfacl <filearchiv.html#GETFACLREF>`_

-  `getopt <extmisc.html#GETOPTY>`_

-  `getopts <internal.html#GETOPTSX>`_

-  `gettext <textproc.html#GETTEXTREF>`_

-  `getty <system.html#GETTYREF>`_

-  `gnome-mount <system.html#GNOMEMOUNTREF>`_

-  `grep <textproc.html#GREPREF>`_

-  `groff <textproc.html#GROFFREF>`_

-  `groupmod <system.html#GROUPMODREF>`_

-  `groups <system.html#GROUPSCMDREF>`_ (Related topic: the
   `$GROUPS <internalvariables.html#GROUPSREF>`_ variable)

-  `gs <textproc.html#GSREF>`_

-  `gzip <filearchiv.html#GZIPREF>`_

-  `halt <system.html#HALTREF>`_

-  `hash <internal.html#HASHCMDREF>`_

-  `hdparm <system.html#HDPARMREF>`_

-  `head <textproc.html#HEADREF>`_

-  `help <internal.html#HELPREF>`_

-  `hexdump <extmisc.html#HEXDUMPREF>`_

-  `host <communications.html#HOSTREF>`_

-  `hostid <system.html#HOSTIDREF>`_

-  `hostname <system.html#HNAMEREF>`_ (Related topic: the
   `$HOSTNAME <internalvariables.html#HOSTNAMEREF>`_ variable)

-  `hwclock <timedate.html#HWCLOCKREF>`_

-  `iconv <textproc.html#ICONVREF>`_

-  `id <system.html#IDREF>`_ (Related topic: the
   `$UID <internalvariables.html#UIDREF>`_ variable)

-  `ifconfig <system.html#IFCONFIGREF>`_

-  `info <basic.html#INFOREF>`_

-  `infocmp <terminalccmds.html#INFOCMPREF>`_

-  `init <system.html#INITREF>`_

-  `insmod <system.html#INSMODREF>`_

-  `install <filearchiv.html#INSTALLREF>`_

-  `ip <system.html#IPREF>`_

-  `ipcalc <communications.html#IPCALCREF>`_

-  `iptables <system.html#IPTABLESREF>`_

-  `iwconfig <system.html#IWCONFIGREF>`_

-  `jobs <x9585.html#JOBSREF>`_

-  `join <textproc.html#JOINREF>`_

-  `jot <extmisc.html#JOTREF>`_

-  `kill <x9585.html#KILLREF>`_

-  `killall <x9585.html#KILLALLREF>`_

-  `last <system.html#LASTREF>`_

-  `lastcomm <system.html#LASTCOMMREF>`_

-  `lastlog <system.html#LASTLOGREF>`_

-  `ldd <system.html#LDDREF>`_

-  `less <filearchiv.html#LESSREF>`_

-  `let <internal.html#LETREF>`_

-  `lex <textproc.html#LEXREF>`_

-  `lid <system.html#LIDREF>`_

-  `ln <basic.html#LINKREF>`_

-  `locate <filearchiv.html#LOCATEREF>`_

-  `lockfile <system.html#LOCKFILEREF>`_

-  `logger <system.html#LOGGERREF>`_

-  `logname <system.html#LOGNAMEREF>`_

-  `logout <x9585.html#LOGOUTREF>`_

-  `logrotate <system.html#LOGROTATEREF>`_

-  `look <textproc.html#LOOKREF>`_

-  `losetup <system.html#LOSETUPREF>`_

-  `lp <extmisc.html#LPREF>`_

-  `ls <basic.html#LSREF>`_

-  `lsdev <system.html#LSDEVREF>`_

-  `lsmod <system.html#LSMODREF>`_

-  `lsof <system.html#LSOFREF>`_

-  `lspci <system.html#LSPCIREF>`_

-  `lsusb <system.html#LSUSBREF>`_

-  `ltrace <system.html#LTRACEREF>`_

-  `lynx <communications.html#LYNXREF>`_

-  `lzcat <filearchiv.html#LZMAREF>`_

-  `lzma <filearchiv.html#LZMAREF>`_

-  `m4 <extmisc.html#M4REF>`_

-  `mail <communications.html#COMMMAIL1>`_

-  `mailstats <communications.html#MAILSTATSREF>`_

-  `mailto <communications.html#MAILTOREF>`_

-  `make <filearchiv.html#MAKEREF>`_

-  `MAKEDEV <system.html#MAKEDEVREF>`_

-  `man <basic.html#MANREF>`_

-  `mapfile <bashver4.html#MAPFILEREF>`_

-  `mcookie <extmisc.html#MCOOKIEREF>`_

-  `md5sum <filearchiv.html#MD5SUMREF>`_

-  `merge <filearchiv.html#MERGEREF>`_

-  `mesg <system.html#MESGREF>`_

-  `mimencode <filearchiv.html#MIMENCODEREF>`_

-  `mkbootdisk <system.html#MKBOOTDISKREF>`_

-  `mkdir <basic.html#MKDIRREF>`_

-  `mkdosfs <system.html#MKDOSFSREF>`_

-  `mke2fs <system.html#MKE2FSREF>`_

-  `mkfifo <extmisc.html#MKFIFOREF>`_

-  `mkisofs <system.html#MKISOFSREF>`_

-  `mknod <system.html#MKNODREF>`_

-  `mkswap <system.html#MKSWAPREF>`_

-  `mktemp <filearchiv.html#MKTEMPREF>`_

-  `mmencode <filearchiv.html#MMENCODEREF>`_

-  `modinfo <system.html#MODINFOREF>`_

-  `modprobe <system.html#MODPROBEREF>`_

-  `more <filearchiv.html#MOREREF>`_

-  `mount <system.html#MOUNTREF>`_

-  `msgfmt <textproc.html#MSGFMTREF>`_

-  `mv <basic.html#MVREF>`_

-  `nc <system.html#NCREF>`_

-  `netconfig <communications.html#NETCONFIGREF>`_

-  `netstat <system.html#NETSTATREF>`_

-  `newgrp <system.html#NEWGRPREF>`_

-  `nice <system.html#NICEREF>`_

-  `nl <textproc.html#NLREF>`_

-  `nm <system.html#NMREF>`_

-  `nmap <system.html#NMAPREF>`_

-  `nohup <system.html#NOHUPREF>`_

-  `nslookup <communications.html#NSLOOKUPREF>`_

-  `objdump <extmisc.html#OBJDUMPREF>`_

-  `od <extmisc.html#ODREF>`_

-  `openssl <filearchiv.html#OPENSSLREF>`_

-  `passwd <system.html#PASSWDREF>`_

-  `paste <textproc.html#PASTEREF>`_

-  `patch <filearchiv.html#PATCHREF>`_ (Related topic:
   `diff <filearchiv.html#DIFFREF>`_)

-  `pathchk <extmisc.html#PATHCHKREF>`_

-  `pax <filearchiv.html#PAXREF>`_

-  `pgrep <system.html#PGREPREF>`_

-  `pidof <system.html#PIDOFREF>`_

-  `ping <communications.html#PINGREF>`_

-  `pkill <system.html#PKILLREF>`_

-  `popd <internal.html#DIRSD>`_

-  `pr <textproc.html#PRREF>`_

-  `printenv <extmisc.html#PRINTENVREF>`_

-  `printf <internal.html#PRINTFREF>`_

-  `procinfo <system.html#PROCINFOREF>`_

-  `ps <system.html#PPSSREF>`_

-  `pstree <system.html#PSTREEREF>`_

-  `ptx <filearchiv.html#PTXREF>`_

-  `pushd <internal.html#DIRSD>`_

-  `pwd <internal.html#PWD2REF>`_ (Related topic: the
   `$PWD <internalvariables.html#PWDREF>`_ variable)

-  `quota <system.html#QUOTAREF>`_

-  `rcp <communications.html#RCPREF>`_

-  `rdev <system.html#RDEVREF>`_

-  `rdist <system.html#RDISTREF>`_

-  `read <internal.html#READREF>`_

-  `readelf <system.html#READELFREF>`_

-  `readlink <filearchiv.html#READLINKREF>`_

-  `readonly <internal.html#READONLYREF>`_

-  `reboot <system.html#REBOOTREF>`_

-  `recode <textproc.html#RECODEREF>`_

-  `renice <system.html#NICE2REF>`_

-  `reset <terminalccmds.html#RESETREF>`_

-  `resize <terminalccmds.html#RESIZEREF>`_

-  `restore <system.html#RESTOREREF>`_

-  `rev <basic.html#REVREF>`_

-  `rlogin <communications.html#RLOGINREF>`_

-  `rm <basic.html#RMREF>`_

-  `rmdir <basic.html#RMDIRREF>`_

-  `rmmod <system.html#RMMODREF>`_

-  `route <system.html#ROUTEREF>`_

-  `rpm <filearchiv.html#RPMREF>`_

-  `rpm2cpio <filearchiv.html#RPM2CPIOREF>`_

-  `rsh <communications.html#RSHREF>`_

-  `rsync <communications.html#RSYNCREF>`_

-  `runlevel <system.html#RUNLEVELREF>`_

-  `run-parts <extmisc.html#RUNPARTSREF>`_

-  `rx <communications.html#RXREF>`_

-  `rz <communications.html#RZREF>`_

-  `sar <system.html#SARREF>`_

-  `scp <communications.html#SCPREF>`_

-  `script <terminalccmds.html#SCRIPTREF>`_

-  `sdiff <filearchiv.html#SDIFFREF>`_

-  `sed <sedawk.html#SEDREF>`_

-  `seq <extmisc.html#SEQREF>`_

-  `service <system.html#SERVICEREF>`_

-  `set <internal.html#SETREF>`_

-  `setfacl <filearchiv.html#SETFACLREF>`_

-  `setquota <system.html#SETQUOTAREF>`_

-  `setserial <system.html#SETSERIALREF>`_

-  `setterm <system.html#SETTERMREF>`_

-  `sha1sum <filearchiv.html#SHA1SUMREF>`_

-  `shar <filearchiv.html#SHARREF>`_

-  `shopt <internal.html#SHOPTREF>`_

-  `shred <filearchiv.html#SHREDREF>`_

-  `shutdown <system.html#SHUTDOWNREF>`_

-  `size <system.html#SIZEREF>`_

-  `skill <system.html#NICE2REF>`_

-  `sleep <timedate.html#SLEEPREF>`_

-  `slocate <filearchiv.html#SLOCATEREF>`_

-  `snice <system.html#NICE2REF>`_

-  `sort <textproc.html#SORTREF>`_

-  `source <internal.html#SOURCEREF>`_

-  `sox <extmisc.html#SOXREF>`_

-  `split <filearchiv.html#SPLITREF>`_

-  `sq <filearchiv.html#SQREF>`_

-  `ssh <communications.html#SSHREF>`_

-  `stat <system.html#STATREF>`_

-  `strace <system.html#STRACEREF>`_

-  `strings <filearchiv.html#STRINGSREF>`_

-  `strip <system.html#STRIPREF>`_

-  `stty <system.html#STTYREF>`_

-  `su <system.html#SUREF>`_

-  `sudo <system.html#SUDOREF>`_

-  `sum <filearchiv.html#SUMREF>`_

-  `suspend <x9585.html#SUSPENDREF>`_

-  `swapoff <system.html#SWAPONREF>`_

-  `swapon <system.html#SWAPONREF>`_

-  `sx <communications.html#RXREF>`_

-  `sync <system.html#SYNCREF>`_

-  `sz <communications.html#RZREF>`_

-  `tac <basic.html#CATREF>`_

-  `tail <textproc.html#TAILREF>`_

-  `tar <filearchiv.html#TARREF>`_

-  `tbl <textproc.html#TBLREF>`_

-  `tcpdump <system.html#TCPDUMPREF>`_

-  `tee <extmisc.html#TEEREF>`_

-  `telinit <system.html#TELINITREF>`_

-  `telnet <communications.html#TELNETREF>`_

-  `Tex <textproc.html#TEXREF>`_

-  `texexec <textproc.html#TEXEXECREF>`_

-  `time <timedate.html#TIMREF>`_

-  `times <x9585.html#TIMESREF>`_

-  `tmpwatch <system.html#TMPWATCHREF>`_

-  `top <system.html#TOPREF>`_

-  `touch <timedate.html#TOUCHREF>`_

-  `tput <terminalccmds.html#TPUTREF>`_

-  `tr <textproc.html#TRREF>`_

-  `traceroute <communications.html#TRACEROUTEREF>`_

-  `true <internal.html#TRUEREF>`_

-  `tset <system.html#TSETREF>`_

-  `tsort <textproc.html#TSORTREF>`_

-  `tty <system.html#TTYREF>`_

-  `tune2fs <system.html#TUNE2FSREF>`_

-  `type <internal.html#TYPEREF>`_

-  `typeset <declareref.html>`_

-  `ulimit <system.html#ULIMITREF>`_

-  `umask <system.html#UMASKREF>`_

-  `umount <system.html#UMOUNTREF>`_

-  `uname <system.html#UNAMEREF>`_

-  `unarc <filearchiv.html#UNARCREF>`_

-  `unarj <filearchiv.html#UNARCREF>`_

-  `uncompress <filearchiv.html#UNCOMPRESSREF>`_

-  `unexpand <textproc.html#EXPANDREF>`_

-  `uniq <textproc.html#UNIQREF>`_

-  `units <extmisc.html#UNITSREF>`_

-  `unlzma <filearchiv.html#LZMAREF>`_

-  `unrar <filearchiv.html#UNARCREF>`_

-  `unset <internal.html#UNSETREF>`_

-  `unsq <filearchiv.html#SQREF>`_

-  `unzip <filearchiv.html#ZIPREF>`_

-  `uptime <system.html#UPTIMEREF>`_

-  `usbmodules <system.html#LSUSBREF>`_

-  `useradd <system.html#USERADDREF>`_

-  `userdel <system.html#USERADDREF>`_

-  `usermod <system.html#USERMODREF>`_

-  `users <system.html#USERSREF>`_

-  `usleep <timedate.html#USLEEPREF>`_

-  `uucp <communications.html#UUCPREF>`_

-  `uudecode <filearchiv.html#UUDECODEREF>`_

-  `uuencode <filearchiv.html#UUENCODEREF>`_

-  `uux <communications.html#UUXREF>`_

-  `vacation <communications.html#VACATIONREF>`_

-  `vdir <filearchiv.html#VDIRREF>`_

-  `vmstat <system.html#VMSTATREF>`_

-  `vrfy <communications.html#VRFYREF>`_

-  `w <system.html#WREF>`_

-  `wait <x9585.html#WAITREF>`_

-  `wall <system.html#WALLREF>`_

-  `watch <system.html#WATCHREF>`_

-  `wc <textproc.html#WCREF>`_

-  `wget <communications.html#WGETREF>`_

-  `whatis <filearchiv.html#WHATISREF>`_

-  `whereis <filearchiv.html#WHEREISREF>`_

-  `which <filearchiv.html#WHICHREF>`_

-  `who <system.html#WHOREF>`_

-  `whoami <system.html#WHOAMIREF>`_

-  `whois <communications.html#WHOISREF>`_

-  `write <communications.html#WRITEREF>`_

-  `xargs <moreadv.html#XARGSREF>`_

-  `xrandr <system.html#XRANDRREF>`_

-  `yacc <textproc.html#YACCREF>`_

-  `yes <extmisc.html#YESREF>`_

-  `zcat <filearchiv.html#ZCATREF>`_

-  `zdiff <filearchiv.html#ZDIFFREF>`_

-  `zdump <timedate.html#ZDUMPREF>`_

-  `zegrep <textproc.html#ZEGREPREF>`_

-  `zfgrep <textproc.html#ZEGREPREF>`_

-  `zgrep <textproc.html#ZEGREPREF>`_

-  `zip <filearchiv.html#ZIPREF>`_

**Table of Contents**

15. `Internal Commands and Builtins <internal.html>`_

15.1. `Job Control Commands <x9585.html>`_

16. `External Filters, Programs and Commands <external.html>`_

16.1. `Basic Commands <basic.html>`_

16.2. `Complex Commands <moreadv.html>`_

16.3. `Time / Date Commands <timedate.html>`_

16.4. `Text Processing Commands <textproc.html>`_

16.5. `File and Archiving Commands <filearchiv.html>`_

16.6. `Communications Commands <communications.html>`_

16.7. `Terminal Control Commands <terminalccmds.html>`_

16.8. `Math Commands <mathc.html>`_

16.9. `Miscellaneous Commands <extmisc.html>`_

17. `System and Administrative Commands <system.html>`_

17.1. `Analyzing a System Script <sysscripts.html>`_

--------------

+------------------------------+------------------------+----------------------------------+
| `Prev <recess-time.html>`_   | `Home <index.html>`_   | `Next <internal.html>`_          |
+------------------------------+------------------------+----------------------------------+
| Recess Time                  |                        | Internal Commands and Builtins   |
+------------------------------+------------------------+----------------------------------+

