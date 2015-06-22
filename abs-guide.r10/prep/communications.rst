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

`Prev <filearchiv.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

Chapter 16. External Filters, Programs and Commands

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <terminalccmds.html>`__

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

   <div class="SECT1">

  16.6. Communications Commands
==============================

Certain of the following commands find use in network data transfer and
analysis, as well as in `chasing
spammers <writingscripts.html#CSPAMMERS>`__ .

.. raw:: html

   <div class="VARIABLELIST">

** Information and Statistics**

 **host**
    Searches for information about an Internet host by name or IP
    address, using DNS.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ host surfacema |
    | il.com                   |
    |     surfacemail.com. has |
    |  address 202.92.42.236   |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **ipcalc**
    Displays IP information for a host. With the ``         -h        ``
    option, **ipcalc** does a reverse DNS lookup, finding the name of
    the host (server) from the IP address.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ipcalc -h 202. |
    | 92.42.236                |
    |     HOSTNAME=surfacemail |
    | .com                     |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **nslookup**
    Do an Internet "name server lookup" on a host by IP address. This is
    essentially equivalent to **ipcalc -h** or **dig -x** . The command
    may be run either interactively or noninteractively, i.e., from
    within a script.

    The **nslookup** command has allegedly been "deprecated," but it is
    still useful.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ nslookup -sil  |
    | 66.97.104.180            |
    |     nslookup kuhleerspar |
    | nis.ch                   |
    |      Server:         135 |
    | .116.137.2               |
    |      Address:        135 |
    | .116.137.2#53            |
    |                          |
    |      Non-authoritative a |
    | nswer:                   |
    |      Name:   kuhleerspar |
    | nis.ch                   |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **dig**
    **D** omain **I** nformation **G** roper. Similar to **nslookup** ,
    *dig* does an Internet *name server lookup* on a host. May be run
    from the command-line or from within a script.

    Some interesting options to *dig* are ``         +time=N        ``
    for setting a query timeout to
    ``                   N                 `` seconds,
    ``         +nofail        `` for continuing to query servers until a
    reply is received, and ``         -x        `` for doing a reverse
    address lookup.

    Compare the output of **dig -x** with **ipcalc -h** and **nslookup**
    .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ dig -x 81.9.6. |
    | 2                        |
    |     ;; Got answer:       |
    |      ;; ->>HEADER<<- opc |
    | ode: QUERY, status: NXDO |
    | MAIN, id: 11649          |
    |      ;; flags: qr rd ra; |
    |  QUERY: 1, ANSWER: 0, AU |
    | THORITY: 1, ADDITIONAL:  |
    | 0                        |
    |                          |
    |      ;; QUESTION SECTION |
    | :                        |
    |      ;2.6.9.81.in-addr.a |
    | rpa.         IN      PTR |
    |                          |
    |      ;; AUTHORITY SECTIO |
    | N:                       |
    |      6.9.81.in-addr.arpa |
    | .    3600    IN      SOA |
    |      ns.eltel.net. noc.e |
    | ltel.net.                |
    |      2002031705 900 600  |
    | 86400 3600               |
    |                          |
    |      ;; Query time: 537  |
    | msec                     |
    |      ;; SERVER: 135.116. |
    | 137.2#53(135.116.137.2)  |
    |      ;; WHEN: Wed Jun 26 |
    |  08:35:24 2002           |
    |      ;; MSG SIZE  rcvd:  |
    | 91                       |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-40. Finding out where to report a spammer**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # spam-lookup.sh: Lo |
    | ok up abuse contact to r |
    | eport a spammer.         |
    |     # Thanks, Michael Zi |
    | ck.                      |
    |                          |
    |     # Check for command- |
    | line arg.                |
    |     ARGCOUNT=1           |
    |     E_WRONGARGS=85       |
    |     if [ $# -ne "$ARGCOU |
    | NT" ]                    |
    |     then                 |
    |       echo "Usage: `base |
    | name $0` domain-name"    |
    |       exit $E_WRONGARGS  |
    |     fi                   |
    |                          |
    |                          |
    |     dig +short $1.contac |
    | ts.abuse.net -c in -t tx |
    | t                        |
    |     # Also try:          |
    |     #     dig +nssearch  |
    | $1                       |
    |     #     Tries to find  |
    | "authoritative name serv |
    | ers" and display SOA rec |
    | ords.                    |
    |                          |
    |     # The following also |
    |  works:                  |
    |     #     whois -h whois |
    | .abuse.net $1            |
    |     #           ^^ ^^^^^ |
    | ^^^^^^^^^^  Specify host |
    | .                        |
    |     #     Can even looku |
    | p multiple spammers with |
    |  this, i.e."             |
    |     #     whois -h whois |
    | .abuse.net $spamdomain1  |
    | $spamdomain2 . . .       |
    |                          |
    |                          |
    |     #  Exercise:         |
    |     #  --------          |
    |     #  Expand the functi |
    | onality of this script   |
    |     #+ so that it automa |
    | tically e-mails a notifi |
    | cation                   |
    |     #+ to the responsibl |
    | e ISP's contact address( |
    | es).                     |
    |     #  Hint: use the "ma |
    | il" command.             |
    |                          |
    |     exit $?              |
    |                          |
    |     # spam-lookup.sh chi |
    | natietong.com            |
    |     #                A k |
    | nown spam domain.        |
    |                          |
    |     # "crnet_mgr@chinati |
    | etong.com"               |
    |     # "crnet_tec@chinati |
    | etong.com"               |
    |     # "postmaster@chinat |
    | ietong.com"              |
    |                          |
    |                          |
    |     #  For a more elabor |
    | ate version of this scri |
    | pt,                      |
    |     #+ see the SpamViz h |
    | ome page, http://www.spa |
    | mviz.net/index.html.     |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-41. Analyzing a spam domain**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #! /bin/bash         |
    |     # is-spammer.sh: Ide |
    | ntifying spam domains    |
    |                          |
    |     # $Id: is-spammer, v |
    |  1.4 2004/09/01 19:37:52 |
    |  mszick Exp $            |
    |     # Above line is RCS  |
    | ID info.                 |
    |     #                    |
    |     #  This is a simplif |
    | ied version of the "is_s |
    | pammer.bash              |
    |     #+ script in the Con |
    | tributed Scripts appendi |
    | x.                       |
    |                          |
    |     # is-spammer <domain |
    | .name>                   |
    |                          |
    |     # Uses an external p |
    | rogram: 'dig'            |
    |     # Tested with versio |
    | n: 9.2.4rc5              |
    |                          |
    |     # Uses functions.    |
    |     # Uses IFS to parse  |
    | strings by assignment in |
    | to arrays.               |
    |     # And even does some |
    | thing useful: checks e-m |
    | ail blacklists.          |
    |                          |
    |     # Use the domain.nam |
    | e(s) from the text body: |
    |     # http://www.good_st |
    | uff.spammer.biz/just_ign |
    | ore_everything_else      |
    |     #                    |
    |     ^^^^^^^^^^^          |
    |     # Or the domain.name |
    | (s) from any e-mail addr |
    | ess:                     |
    |     # Really_Good_Offer@ |
    | spammer.biz              |
    |     #                    |
    |     # as the only argume |
    | nt to this script.       |
    |     #(PS: have your Inet |
    |  connection running)     |
    |     #                    |
    |     # So, to invoke this |
    |  script in the above two |
    |  instances:              |
    |     #       is-spammer.s |
    | h spammer.biz            |
    |                          |
    |                          |
    |     # Whitespace == :Spa |
    | ce:Tab:Line Feed:Carriag |
    | e Return:                |
    |     WSP_IFS=$'\x20'$'\x0 |
    | 9'$'\x0A'$'\x0D'         |
    |                          |
    |     # No Whitespace == L |
    | ine Feed:Carriage Return |
    |     No_WSP=$'\x0A'$'\x0D |
    | '                        |
    |                          |
    |     # Field separator fo |
    | r dotted decimal ip addr |
    | esses                    |
    |     ADR_IFS=${No_WSP}'.' |
    |                          |
    |     # Get the dns text r |
    | esource record.          |
    |     # get_txt <error_cod |
    | e> <list_query>          |
    |     get_txt() {          |
    |                          |
    |         # Parse $1 by as |
    | signment at the dots.    |
    |         local -a dns     |
    |         IFS=$ADR_IFS     |
    |         dns=( $1 )       |
    |         IFS=$WSP_IFS     |
    |         if [ "${dns[0]}" |
    |  == '127' ]              |
    |         then             |
    |             # See if the |
    | re is a reason.          |
    |             echo $(dig + |
    | short $2 -t txt)         |
    |         fi               |
    |     }                    |
    |                          |
    |     # Get the dns addres |
    | s resource record.       |
    |     # chk_adr <rev_dns>  |
    | <list_server>            |
    |     chk_adr() {          |
    |         local reply      |
    |         local server     |
    |         local reason     |
    |                          |
    |         server=${1}${2}  |
    |         reply=$( dig +sh |
    | ort ${server} )          |
    |                          |
    |         # If reply might |
    |  be an error code . . .  |
    |         if [ ${#reply} - |
    | gt 6 ]                   |
    |         then             |
    |             reason=$(get |
    | _txt ${reply} ${server}  |
    | )                        |
    |             reason=${rea |
    | son:-${reply}}           |
    |         fi               |
    |         echo ${reason:-' |
    |  not blacklisted.'}      |
    |     }                    |
    |                          |
    |     # Need to get the IP |
    |  address from the name.  |
    |     echo 'Get address of |
    | : '$1                    |
    |     ip_adr=$(dig +short  |
    | $1)                      |
    |     dns_reply=${ip_adr:- |
    | ' no answer '}           |
    |     echo ' Found address |
    | : '${dns_reply}          |
    |                          |
    |     # A valid reply is a |
    | t least 4 digits plus 3  |
    | dots.                    |
    |     if [ ${#ip_adr} -gt  |
    | 6 ]                      |
    |     then                 |
    |         echo             |
    |         declare query    |
    |                          |
    |         # Parse by assig |
    | nment at the dots.       |
    |         declare -a dns   |
    |         IFS=$ADR_IFS     |
    |         dns=( ${ip_adr}  |
    | )                        |
    |         IFS=$WSP_IFS     |
    |                          |
    |         # Reorder octets |
    |  into dns query order.   |
    |         rev_dns="${dns[3 |
    | ]}"'.'"${dns[2]}"'.'"${d |
    | ns[1]}"'.'"${dns[0]}"'.' |
    |                          |
    |     # See: http://www.sp |
    | amhaus.org (Conservative |
    | , well maintained)       |
    |         echo -n 'spamhau |
    | s.org says: '            |
    |         echo $(chk_adr $ |
    | {rev_dns} 'sbl-xbl.spamh |
    | aus.org')                |
    |                          |
    |     # See: http://ordb.o |
    | rg (Open mail relays)    |
    |         echo -n '   ordb |
    | .org  says: '            |
    |         echo $(chk_adr $ |
    | {rev_dns} 'relays.ordb.o |
    | rg')                     |
    |                          |
    |     # See: http://www.sp |
    | amcop.net/ (You can repo |
    | rt spammers here)        |
    |         echo -n ' spamco |
    | p.net says: '            |
    |         echo $(chk_adr $ |
    | {rev_dns} 'bl.spamcop.ne |
    | t')                      |
    |                          |
    |     # # # other blacklis |
    | t operations # # #       |
    |                          |
    |     # See: http://cbl.ab |
    | useat.org.               |
    |         echo -n ' abusea |
    | t.org says: '            |
    |         echo $(chk_adr $ |
    | {rev_dns} 'cbl.abuseat.o |
    | rg')                     |
    |                          |
    |     # See: http://dsbl.o |
    | rg/usage (Various mail r |
    | elays)                   |
    |         echo             |
    |         echo 'Distribute |
    | d Server Listings'       |
    |         echo -n '        |
    | list.dsbl.org says: '    |
    |         echo $(chk_adr $ |
    | {rev_dns} 'list.dsbl.org |
    | ')                       |
    |                          |
    |         echo -n '   mult |
    | ihop.dsbl.org says: '    |
    |         echo $(chk_adr $ |
    | {rev_dns} 'multihop.dsbl |
    | .org')                   |
    |                          |
    |         echo -n 'unconfi |
    | rmed.dsbl.org says: '    |
    |         echo $(chk_adr $ |
    | {rev_dns} 'unconfirmed.d |
    | sbl.org')                |
    |                          |
    |     else                 |
    |         echo             |
    |         echo 'Could not  |
    | use that address.'       |
    |     fi                   |
    |                          |
    |     exit 0               |
    |                          |
    |     # Exercises:         |
    |     # --------           |
    |                          |
    |     # 1) Check arguments |
    |  to script,              |
    |     #    and exit with a |
    | ppropriate error message |
    |  if necessary.           |
    |                          |
    |     # 2) Check if on-lin |
    | e at invocation of scrip |
    | t,                       |
    |     #    and exit with a |
    | ppropriate error message |
    |  if necessary.           |
    |                          |
    |     # 3) Substitute gene |
    | ric variables for "hard- |
    | coded" BHL domains.      |
    |                          |
    |     # 4) Set a time-out  |
    | for the script using the |
    |  "+time=" option         |
    |          to the 'dig' co |
    | mmand.                   |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    For a much more elaborate version of the above script, see `Example
    A-28 <contributed-scripts.html#ISSPAMMER2>`__ .

 **traceroute**
    Trace the route taken by packets sent to a remote host. This command
    works within a LAN, WAN, or over the Internet. The remote host may
    be specified by an IP address. The output of this command may be
    filtered by `grep <textproc.html#GREPREF>`__ or
    `sed <sedawk.html#SEDREF>`__ in a pipe.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ traceroute 81. |
    | 9.6.2                    |
    |     traceroute to 81.9.6 |
    | .2 (81.9.6.2), 30 hops m |
    | ax, 38 byte packets      |
    |      1  tc43.xjbnnbrb.co |
    | m (136.30.178.8)  191.30 |
    | 3 ms  179.400 ms  179.76 |
    | 7 ms                     |
    |      2  or0.xjbnnbrb.com |
    |  (136.30.178.1)  179.536 |
    |  ms  179.534 ms  169.685 |
    |  ms                      |
    |      3  192.168.11.101 ( |
    | 192.168.11.101)  189.471 |
    |  ms  189.556 ms *        |
    |      ...                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **ping**
    Broadcast an
    ``                   ICMP           ECHO_REQUEST                 ``
    packet to another machine, either on a local or remote network. This
    is a diagnostic tool for testing network connections, and it should
    be used with caution.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ ping localhost |
    |     PING localhost.local |
    | domain (127.0.0.1) from  |
    | 127.0.0.1 : 56(84) bytes |
    |  of data.                |
    |      64 bytes from local |
    | host.localdomain (127.0. |
    | 0.1): icmp_seq=0 ttl=255 |
    |  time=709 usec           |
    |      64 bytes from local |
    | host.localdomain (127.0. |
    | 0.1): icmp_seq=1 ttl=255 |
    |  time=286 usec           |
    |                          |
    |      --- localhost.local |
    | domain ping statistics - |
    | --                       |
    |      2 packets transmitt |
    | ed, 2 packets received,  |
    | 0% packet loss           |
    |      round-trip min/avg/ |
    | max/mdev = 0.286/0.497/0 |
    | .709/0.212 ms            |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    A successful *ping* returns an `exit
    status <exit-status.html#EXITSTATUSREF>`__ of 0 . This can be tested
    for in a script.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |       HNAME=news-15.net  |
    |  # Notorious spammer.    |
    |     # HNAME=$HOST     #  |
    | Debug: test for localhos |
    | t.                       |
    |       count=2  # Send on |
    | ly two pings.            |
    |                          |
    |     if [[ `ping -c $coun |
    | t "$HNAME"` ]]           |
    |     then                 |
    |       echo ""$HNAME" sti |
    | ll up and broadcasting s |
    | pam your way."           |
    |     else                 |
    |       echo ""$HNAME" see |
    | ms to be down. Pity."    |
    |     fi                   |
                              
    +--------------------------+--------------------------+--------------------------+

 **whois**
    Perform a DNS (Domain Name System) lookup. The
    ``         -h        `` option permits specifying which particular
    *whois* server to query. See `Example 4-6 <othertypesv.html#EX18>`__
    and `Example 16-40 <communications.html#SPAMLOOKUP>`__ .

 **finger**
    Retrieve information about users on a network. Optionally, this
    command can display a user's ``         ~/.plan        `` ,
    ``         ~/.project        `` , and
    ``         ~/.forward        `` files, if present.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ finger         |
    |     Login  Name          |
    |   Tty      Idle  Login T |
    | ime   Office     Office  |
    | Phone                    |
    |      bozo   Bozo Bozeman |
    |    tty1        8  Jun 25 |
    |  16:59                (: |
    | 0)                       |
    |      bozo   Bozo Bozeman |
    |    ttyp0          Jun 25 |
    |  16:59                (: |
    | 0.0)                     |
    |      bozo   Bozo Bozeman |
    |    ttyp1          Jun 25 |
    |  17:07                (: |
    | 0.0)                     |
    |                          |
    |                          |
    |                          |
    |     bash$ finger bozo    |
    |     Login: bozo          |
    |                     Name |
    | : Bozo Bozeman           |
    |      Directory: /home/bo |
    | zo                   She |
    | ll: /bin/bash            |
    |      Office: 2355 Clown  |
    | St., 543-1234            |
    |      On since Fri Aug 31 |
    |  20:13 (MST) on tty1     |
    | 1 hour 38 minutes idle   |
    |      On since Fri Aug 31 |
    |  20:13 (MST) on pts/0    |
    | 12 seconds idle          |
    |      On since Fri Aug 31 |
    |  20:13 (MST) on pts/1    |
    |      On since Fri Aug 31 |
    |  20:31 (MST) on pts/2    |
    | 1 hour 16 minutes idle   |
    |      Mail last read Tue  |
    | Jul  3 10:08 2007 (MST)  |
    |      No Plan.            |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    Out of security considerations, many networks disable **finger** and
    its associated daemon. ` [1]  <communications.html#FTN.AEN13320>`__

 **chfn**
    Change information disclosed by the **finger** command.

 **vrfy**
    Verify an Internet e-mail address.

    This command seems to be missing from newer Linux distros.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Remote Host Access**

 **sx** , **rx**
    The **sx** and **rx** command set serves to transfer files to and
    from a remote host using the *xmodem* protocol. These are generally
    part of a communications package, such as **minicom** .

 **sz** , **rz**
    The **sz** and **rz** command set serves to transfer files to and
    from a remote host using the *zmodem* protocol. *Zmodem* has certain
    advantages over *xmodem* , such as faster transmission rate and
    resumption of interrupted file transfers. Like **sx** and **rx** ,
    these are generally part of a communications package.

 **ftp**
    Utility and protocol for uploading / downloading files to or from a
    remote host. An ftp session can be automated in a script (see
    `Example 19-6 <here-docs.html#EX72>`__ and `Example
    A-4 <contributed-scripts.html#ENCRYPTEDPW>`__ ).

 **uucp** , **uux** , **cu**
    **uucp** : *UNIX to UNIX copy* . This is a communications package
    for transferring files between UNIX servers. A shell script is an
    effective way to handle a **uucp** command sequence.

    Since the advent of the Internet and e-mail, **uucp** seems to have
    faded into obscurity, but it still exists and remains perfectly
    workable in situations where an Internet connection is not available
    or appropriate. The advantage of **uucp** is that it is
    fault-tolerant, so even if there is a service interruption the copy
    operation will resume where it left off when the connection is
    restored.

    ---

    **uux** : *UNIX to UNIX execute* . Execute a command on a remote
    system. This command is part of the **uucp** package.

    ---

    **cu** : **C** all **U** p a remote system and connect as a simple
    terminal. It is a sort of dumbed-down version of
    `telnet <communications.html#TELNETREF>`__ . This command is part of
    the **uucp** package.

 **telnet**
    Utility and protocol for connecting to a remote host.

    .. raw:: html

       <div class="CAUTION">

    +--------------------------------------+--------------------------------------+
    | |Caution|                            |
    | The *telnet* protocol contains       |
    | security holes and should therefore  |
    | probably be avoided. Its use within  |
    | a shell script is *not* recommended. |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **wget**
    The **wget** utility *noninteractively* retrieves or downloads files
    from a Web or ftp site. It works well in a script.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     wget -p http://www.x |
    | yz23.com/file01.html     |
    |     #  The -p or --page- |
    | requisite option causes  |
    | wget to fetch all files  |
    |     #+ required to displ |
    | ay the specified page.   |
    |                          |
    |     wget -r ftp://ftp.xy |
    | z24.net/~bozo/project_fi |
    | les/ -O $SAVEFILE        |
    |     #  The -r option rec |
    | ursively follows and ret |
    | rieves all links         |
    |     #+ on the specified  |
    | site.                    |
    |                          |
    |     wget -c ftp://ftp.xy |
    | z25.net/bozofiles/filena |
    | me.tar.bz2               |
    |     #  The -c option let |
    | s wget resume an interru |
    | pted download.           |
    |     #  This works with f |
    | tp servers and many HTTP |
    |  sites.                  |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-42. Getting a stock quote**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # quote-fetch.sh: Do |
    | wnload a stock quote.    |
    |                          |
    |                          |
    |     E_NOPARAMS=86        |
    |                          |
    |     if [ -z "$1" ]  # Mu |
    | st specify a stock (symb |
    | ol) to fetch.            |
    |       then echo "Usage:  |
    | `basename $0` stock-symb |
    | ol"                      |
    |       exit $E_NOPARAMS   |
    |     fi                   |
    |                          |
    |     stock_symbol=$1      |
    |                          |
    |     file_suffix=.html    |
    |     # Fetches an HTML fi |
    | le, so name it appropria |
    | tely.                    |
    |     URL='http://finance. |
    | yahoo.com/q?s='          |
    |     # Yahoo finance boar |
    | d, with stock query suff |
    | ix.                      |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | -----------------        |
    |     wget -O ${stock_symb |
    | ol}${file_suffix} "${URL |
    | }${stock_symbol}"        |
    |     # ------------------ |
    | ------------------------ |
    | -----------------        |
    |                          |
    |                          |
    |     # To look up stuff o |
    | n http://search.yahoo.co |
    | m:                       |
    |     # ------------------ |
    | ------------------------ |
    | -----------------        |
    |     # URL="http://search |
    | .yahoo.com/search?fr=ush |
    | -news&p=${query}"        |
    |     # wget -O "$savefile |
    | name" "${URL}"           |
    |     # ------------------ |
    | ------------------------ |
    | -----------------        |
    |     # Saves a list of re |
    | levant URLs.             |
    |                          |
    |     exit $?              |
    |                          |
    |     # Exercises:         |
    |     # ---------          |
    |     #                    |
    |     # 1) Add a test to e |
    | nsure the user running t |
    | he script is on-line.    |
    |     #    (Hint: parse th |
    | e output of 'ps -ax' for |
    |  "ppp" or "connect."     |
    |     #                    |
    |     # 2) Modify this scr |
    | ipt to fetch the local w |
    | eather report,           |
    |     #+   taking the user |
    | 's zip code as an argume |
    | nt.                      |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example A-30 <contributed-scripts.html#WGETTER2>`__ and
    `Example A-31 <contributed-scripts.html#BASHPODDER>`__ .

 **lynx**
    The **lynx** Web and file browser can be used inside a script (with
    the ``         -dump        `` option) to retrieve a file from a Web
    or ftp site noninteractively.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     lynx -dump http://ww |
    | w.xyz23.com/file01.html  |
    | >$SAVEFILE               |
                              
    +--------------------------+--------------------------+--------------------------+

    With the ``         -traversal        `` option, **lynx** starts at
    the HTTP URL specified as an argument, then "crawls" through all
    links located on that particular server. Used together with the
    ``         -crawl        `` option, outputs page text to a log file.

 **rlogin**
    ``                   Remote login                 `` , initates a
    session on a remote host. This command has security issues, so use
    `ssh <communications.html#SSHREF>`__ instead.

 **rsh**
    ``                   Remote shell                 `` , executes
    command(s) on a remote host. This has security issues, so use
    **ssh** instead.

 **rcp**
    ``                   Remote copy                 `` , copies files
    between two different networked machines.

 **rsync**
    ``                   Remote synchronize                 `` , updates
    (synchronizes) files between two different networked machines.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ rsync -a ~/sou |
    | rcedir/*txt /node1/subdi |
    | rectory/                 |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-43. Updating FC4**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # fc4upd.sh          |
    |                          |
    |     # Script author: Fra |
    | nk Wang.                 |
    |     # Slight stylistic m |
    | odifications by ABS Guid |
    | e author.                |
    |     # Used in ABS Guide  |
    | with permission.         |
    |                          |
    |                          |
    |     #  Download Fedora C |
    | ore 4 update from mirror |
    |  site using rsync.       |
    |     #  Should also work  |
    | for newer Fedora Cores - |
    | - 5, 6, . . .            |
    |     #  Only download lat |
    | est package if multiple  |
    | versions exist,          |
    |     #+ to save space.    |
    |                          |
    |     URL=rsync://distro.i |
    | biblio.org/fedora-linux- |
    | core/updates/            |
    |     # URL=rsync://ftp.kd |
    | dilabs.jp/fedora/core/up |
    | dates/                   |
    |     # URL=rsync://rsync. |
    | planetmirror.com/fedora- |
    | linux-core/updates/      |
    |                          |
    |     DEST=${1:-/var/www/h |
    | tml/fedora/updates/}     |
    |     LOG=/tmp/repo-update |
    | -$(/bin/date +%Y-%m-%d). |
    | txt                      |
    |     PID_FILE=/var/run/${ |
    | 0##*/}.pid               |
    |                          |
    |     E_RETURN=85        # |
    |  Something unexpected ha |
    | ppened.                  |
    |                          |
    |                          |
    |     # General rsync opti |
    | ons                      |
    |     # -r: recursive down |
    | load                     |
    |     # -t: reserve time   |
    |     # -v: verbose        |
    |                          |
    |     OPTS="-rtv --delete- |
    | excluded --delete-after  |
    | --partial"               |
    |                          |
    |     # rsync include patt |
    | ern                      |
    |     # Leading slash caus |
    | es absolute path name ma |
    | tch.                     |
    |     INCLUDE=(            |
    |         "/4/i386/kde-i18 |
    | n-Chinese*"              |
    |     #   ^                |
    |           ^              |
    |     # Quoting is necessa |
    | ry to prevent globbing.  |
    |     )                    |
    |                          |
    |                          |
    |     # rsync exclude patt |
    | ern                      |
    |     # Temporarily commen |
    | t out unwanted pkgs usin |
    | g "#" . . .              |
    |     EXCLUDE=(            |
    |         /1               |
    |         /2               |
    |         /3               |
    |         /testing         |
    |         /4/SRPMS         |
    |         /4/ppc           |
    |         /4/x86_64        |
    |         /4/i386/debug    |
    |        "/4/i386/kde-i18n |
    | -*"                      |
    |        "/4/i386/openoffi |
    | ce.org-langpack-*"       |
    |        "/4/i386/*i586.rp |
    | m"                       |
    |        "/4/i386/GFS-*"   |
    |        "/4/i386/cman-*"  |
    |        "/4/i386/dlm-*"   |
    |        "/4/i386/gnbd-*"  |
    |        "/4/i386/kernel-s |
    | mp*"                     |
    |     #  "/4/i386/kernel-x |
    | en*"                     |
    |     #  "/4/i386/xen-*"   |
    |     )                    |
    |                          |
    |                          |
    |     init () {            |
    |         # Let pipe comma |
    | nd return possible rsync |
    |  error, e.g., stalled ne |
    | twork.                   |
    |         set -o pipefail  |
    |                  # Newly |
    |  introduced in Bash, ver |
    | sion 3.                  |
    |                          |
    |         TMP=${TMPDIR:-/t |
    | mp}/${0##*/}.$$  # Store |
    |  refined download list.  |
    |         trap "{          |
    |             rm -f $TMP 2 |
    | >/dev/null               |
    |         }" EXIT          |
    |                  # Clear |
    |  temporary file on exit. |
    |     }                    |
    |                          |
    |                          |
    |     check_pid () {       |
    |     # Check if process e |
    | xists.                   |
    |         if [ -s "$PID_FI |
    | LE" ]; then              |
    |             echo "PID fi |
    | le exists. Checking ..." |
    |             PID=$(/bin/e |
    | grep -o "^[[:digit:]]+"  |
    | $PID_FILE)               |
    |             if /bin/ps - |
    | -pid $PID &>/dev/null; t |
    | hen                      |
    |                 echo "Pr |
    | ocess $PID found. ${0##* |
    | /} seems to be running!" |
    |                /usr/bin/ |
    | logger -t ${0##*/} \     |
    |                      "Pr |
    | ocess $PID found. ${0##* |
    | /} seems to be running!" |
    |                 exit $E_ |
    | RETURN                   |
    |             fi           |
    |             echo "Proces |
    | s $PID not found. Start  |
    | new process . . ."       |
    |         fi               |
    |     }                    |
    |                          |
    |                          |
    |     #  Set overall file  |
    | update range starting fr |
    | om root or $URL,         |
    |     #+ according to abov |
    | e patterns.              |
    |     set_range () {       |
    |         include=         |
    |         exclude=         |
    |         for p in "${INCL |
    | UDE[@]}"; do             |
    |             include="$in |
    | clude --include \"$p\""  |
    |         done             |
    |                          |
    |         for p in "${EXCL |
    | UDE[@]}"; do             |
    |             exclude="$ex |
    | clude --exclude \"$p\""  |
    |         done             |
    |     }                    |
    |                          |
    |                          |
    |     # Retrieve and refin |
    | e rsync update list.     |
    |     get_list () {        |
    |         echo $$ > $PID_F |
    | ILE || {                 |
    |             echo "Can't  |
    | write to pid file $PID_F |
    | ILE"                     |
    |             exit $E_RETU |
    | RN                       |
    |         }                |
    |                          |
    |         echo -n "Retriev |
    | ing and refining update  |
    | list . . ."              |
    |                          |
    |         # Retrieve list  |
    | -- 'eval' is needed to r |
    | un rsync as a single com |
    | mand.                    |
    |         # $3 and $4 is t |
    | he date and time of file |
    |  creation.               |
    |         # $5 is the full |
    |  package name.           |
    |         previous=        |
    |         pre_file=        |
    |         pre_date=0       |
    |         eval /bin/nice / |
    | usr/bin/rsync \          |
    |             -r $include  |
    | $exclude $URL | \        |
    |             egrep '^dr.x |
    | |^-r' | \                |
    |             awk '{print  |
    | $3, $4, $5}' | \         |
    |             sort -k3 | \ |
    |             { while read |
    |  line; do                |
    |                 # Get se |
    | conds since epoch, to fi |
    | lter out obsolete pkgs.  |
    |                 cur_date |
    | =$(date -d "$(echo $line |
    |  | awk '{print $1, $2}') |
    | " +%s)                   |
    |                 #  echo  |
    | $cur_date                |
    |                          |
    |                 # Get fi |
    | le name.                 |
    |                 cur_file |
    | =$(echo $line | awk '{pr |
    | int $3}')                |
    |                 #  echo  |
    | $cur_file                |
    |                          |
    |                 # Get rp |
    | m pkg name from file nam |
    | e, if possible.          |
    |                 if [[ $c |
    | ur_file == *rpm ]]; then |
    |                     pkg_ |
    | name=$(echo $cur_file |  |
    | sed -r -e \              |
    |                          |
    | 's/(^([^_-]+[_-])+)[[:di |
    | git:]]+\..*[_-].*$/\1/') |
    |                 else     |
    |                     pkg_ |
    | name=                    |
    |                 fi       |
    |                 # echo $ |
    | pkg_name                 |
    |                          |
    |                 if [ -z  |
    | "$pkg_name" ]; then   #  |
    |  If not a rpm file,      |
    |                     echo |
    |  $cur_file >> $TMP    #+ |
    |  then append to download |
    |  list.                   |
    |                 elif [ " |
    | $pkg_name" != "$previous |
    | " ]; then   # A new pkg  |
    | found.                   |
    |                     echo |
    |  $pre_file >> $TMP       |
    |             # Output lat |
    | est file.                |
    |                     prev |
    | ious=$pkg_name           |
    |             # Save curre |
    | nt.                      |
    |                     pre_ |
    | date=$cur_date           |
    |                     pre_ |
    | file=$cur_file           |
    |                 elif [ " |
    | $cur_date" -gt "$pre_dat |
    | e" ]; then               |
    |                          |
    |                          |
    |     #  If same pkg, but  |
    | newer,                   |
    |                     pre_ |
    | date=$cur_date           |
    |     #+ then update lates |
    | t pointer.               |
    |                     pre_ |
    | file=$cur_file           |
    |                 fi       |
    |                 done     |
    |                 echo $pr |
    | e_file >> $TMP           |
    |     #  TMP contains ALL  |
    |                          |
    |                          |
    |     #+ of refined list n |
    | ow.                      |
    |                 # echo " |
    | subshell=$BASH_SUBSHELL" |
    |                          |
    |         }       # Bracke |
    | t required here to let f |
    | inal "echo $pre_file >>  |
    | $TMP"                    |
    |                 # Remain |
    | ed in the same subshell  |
    | ( 1 ) with the entire lo |
    | op.                      |
    |                          |
    |         RET=$?  # Get re |
    | turn code of the pipe co |
    | mmand.                   |
    |                          |
    |         [ "$RET" -ne 0 ] |
    |  && {                    |
    |             echo "List r |
    | etrieving failed with co |
    | de $RET"                 |
    |             exit $E_RETU |
    | RN                       |
    |         }                |
    |                          |
    |         echo "done"; ech |
    | o                        |
    |     }                    |
    |                          |
    |     # Real rsync downloa |
    | d part.                  |
    |     get_file () {        |
    |                          |
    |         echo "Downloadin |
    | g..."                    |
    |         /bin/nice /usr/b |
    | in/rsync \               |
    |             $OPTS \      |
    |             --filter "me |
    | rge,+/ $TMP" \           |
    |             --exclude '* |
    | '  \                     |
    |             $URL $DEST   |
    |    \                     |
    |             | /usr/bin/t |
    | ee $LOG                  |
    |                          |
    |         RET=$?           |
    |                          |
    |        #  --filter merge |
    | ,+/ is crucial for the i |
    | ntention.                |
    |        #  + modifier mea |
    | ns include and / means a |
    | bsolute path.            |
    |        #  Then sorted li |
    | st in $TMP will contain  |
    | ascending dir name and   |
    |        #+ prevent the fo |
    | llowing --exclude '*' fr |
    | om "shortcutting the cir |
    | cuit."                   |
    |                          |
    |         echo "Done"      |
    |                          |
    |         rm -f $PID_FILE  |
    | 2>/dev/null              |
    |                          |
    |         return $RET      |
    |     }                    |
    |                          |
    |     # -------            |
    |     # Main               |
    |     init                 |
    |     check_pid            |
    |     set_range            |
    |     get_list             |
    |     get_file             |
    |     RET=$?               |
    |     # -------            |
    |                          |
    |     if [ "$RET" -eq 0 ]; |
    |  then                    |
    |         /usr/bin/logger  |
    | -t ${0##*/} "Fedora upda |
    | te mirrored successfully |
    | ."                       |
    |     else                 |
    |         /usr/bin/logger  |
    | -t ${0##*/} \            |
    |         "Fedora update m |
    | irrored with failure cod |
    | e: $RET"                 |
    |     fi                   |
    |                          |
    |     exit $RET            |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    See also `Example A-32 <contributed-scripts.html#NIGHTLYBACKUP>`__ .

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | Using                                |
    | `rcp <communications.html#RCPREF>`__ |
    | ,                                    |
    | `rsync <communications.html#RSYNCREF |
    | >`__                                 |
    | , and similar utilities with         |
    | security implications in a shell     |
    | script may not be advisable.         |
    | Consider, instead, using **ssh** ,   |
    | `scp <communications.html#SCPREF>`__ |
    | , or an **expect** script.           |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

 **ssh**
    ``                   Secure shell                 `` , logs onto a
    remote host and executes commands there. This secure replacement for
    **telnet** , **rlogin** , **rcp** , and **rsh** uses identity
    authentication and encryption. See its
    `manpage <basic.html#MANREF>`__ for details.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-44. Using *ssh***

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/bash          |
    |     # remote.bash: Using |
    |  ssh.                    |
    |                          |
    |     # This example by Mi |
    | chael Zick.              |
    |     # Used with permissi |
    | on.                      |
    |                          |
    |                          |
    |     #   Presumptions:    |
    |     #   ------------     |
    |     #   fd-2 isn't being |
    |  captured ( '2>/dev/null |
    | ' ).                     |
    |     #   ssh/sshd presume |
    | s stderr ('2') will disp |
    | lay to user.             |
    |     #                    |
    |     #   sshd is running  |
    | on your machine.         |
    |     #   For any 'standar |
    | d' distribution, it prob |
    | ably is,                 |
    |     #+  and without any  |
    | funky ssh-keygen having  |
    | been done.               |
    |                          |
    |     # Try ssh to your ma |
    | chine from the command-l |
    | ine:                     |
    |     #                    |
    |     # $ ssh $HOSTNAME    |
    |     # Without extra set- |
    | up you'll be asked for y |
    | our password.            |
    |     #   enter password   |
    |     #   when done,  $ ex |
    | it                       |
    |     #                    |
    |     # Did that work? If  |
    | so, you're ready for mor |
    | e fun.                   |
    |                          |
    |     # Try ssh to your ma |
    | chine as 'root':         |
    |     #                    |
    |     #   $  ssh -l root $ |
    | HOSTNAME                 |
    |     #   When asked for p |
    | assword, enter root's, n |
    | ot yours.                |
    |     #          Last logi |
    | n: Tue Aug 10 20:25:49 2 |
    | 004 from localhost.local |
    | domain                   |
    |     #   Enter 'exit' whe |
    | n done.                  |
    |                          |
    |     #  The above gives y |
    | ou an interactive shell. |
    |     #  It is possible fo |
    | r sshd to be set up in a |
    |  'single command' mode,  |
    |     #+ but that is beyon |
    | d the scope of this exam |
    | ple.                     |
    |     #  The only thing to |
    |  note is that the follow |
    | ing will work in         |
    |     #+ 'single command'  |
    | mode.                    |
    |                          |
    |                          |
    |     # A basic, write std |
    | out (local) command.     |
    |                          |
    |     ls -l                |
    |                          |
    |     # Now the same basic |
    |  command on a remote mac |
    | hine.                    |
    |     # Pass a different ' |
    | USERNAME' 'HOSTNAME' if  |
    | desired:                 |
    |     USER=${USERNAME:-$(w |
    | hoami)}                  |
    |     HOST=${HOSTNAME:-$(h |
    | ostname)}                |
    |                          |
    |     #  Now excute the ab |
    | ove command-line on the  |
    | remote host,             |
    |     #+ with all transmis |
    | sions encrypted.         |
    |                          |
    |     ssh -l ${USER} ${HOS |
    | T} " ls -l "             |
    |                          |
    |     #  The expected resu |
    | lt is a listing of your  |
    | username's home          |
    |     #+ directory on the  |
    | remote machine.          |
    |     #  To see any differ |
    | ence, run this script fr |
    | om somewhere             |
    |     #+ other than your h |
    | ome directory.           |
    |                          |
    |     #  In other words, t |
    | he Bash command is passe |
    | d as a quoted line       |
    |     #+ to the remote she |
    | ll, which executes it on |
    |  the remote machine.     |
    |     #  In this case, ssh |
    | d does  ' bash -c "ls -l |
    | " '   on your behalf.    |
    |                          |
    |     #  For information o |
    | n topics such as not hav |
    | ing to enter a           |
    |     #+ password/passphra |
    | se for every command-lin |
    | e, see                   |
    |     #+    man ssh        |
    |     #+    man ssh-keygen |
    |     #+    man sshd_confi |
    | g.                       |
    |                          |
    |     exit 0               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

    .. raw:: html

       <div class="CAUTION">

    +--------------------------+--------------------------+--------------------------+
    | |Caution|                |
    | Within a loop, **ssh**   |
    | may cause unexpected     |
    | behavior. According to a |
    | `Usenet                  |
    | post <http://groups-beta |
    | .google.com/group/comp.u |
    | nix.shell/msg/dcb446b5ff |
    | f7d230>`__               |
    | in the comp.unix shell   |
    | archives, **ssh**        |
    | inherits the loop's      |
    | ``             stdin     |
    |         ``               |
    | . To remedy this, pass   |
    | **ssh** either the       |
    | ``             -n        |
    |      ``                  |
    | or                       |
    | ``             -f        |
    |      ``                  |
    | option.                  |
    |                          |
    | Thanks, Jason Bechtel,   |
    | for pointing this out.   |
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **scp**
    ``                   Secure copy                 `` , similar in
    function to **rcp** , copies files between two different networked
    machines, but does so using authentication, and with a security
    level similar to **ssh** .

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Local Network**

 **write**
    This is a utility for terminal-to-terminal communication. It allows
    sending lines from your terminal (console or *xterm* ) to that of
    another user. The `mesg <system.html#MESGREF>`__ command may, of
    course, be used to disable write access to a terminal

    Since **write** is interactive, it would not normally find use in a
    script.

 **netconfig**
    A command-line utility for configuring a network adapter (using
    *DHCP* ). This command is native to Red Hat centric Linux distros.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

** Mail**

 **mail**
    Send or read e-mail messages.

    This stripped-down command-line mail client works fine as a command
    embedded in a script.

    .. raw:: html

       <div class="EXAMPLE">

    **Example 16-45. A script that mails itself**

    +--------------------------+--------------------------+--------------------------+
    | .. code:: PROGRAMLISTING |
    |                          |
    |     #!/bin/sh            |
    |     # self-mailer.sh: Se |
    | lf-mailing script        |
    |                          |
    |     adr=${1:-`whoami`}   |
    |    # Default to current  |
    | user, if not specified.  |
    |     #  Typing 'self-mail |
    | er.sh wiseguy@superduper |
    | genius.com'              |
    |     #+ sends this script |
    |  to that addressee.      |
    |     #  Just 'self-mailer |
    | .sh' (no argument) sends |
    |  the script              |
    |     #+ to the person inv |
    | oking it, for example, b |
    | ozo@localhost.localdomai |
    | n.                       |
    |     #                    |
    |     #  For more on the $ |
    | {parameter:-default} con |
    | struct,                  |
    |     #+ see the "Paramete |
    | r Substitution" section  |
    |     #+ of the "Variables |
    |  Revisited" chapter.     |
    |                          |
    |     # ================== |
    | ======================== |
    | ======================== |
    | ==========               |
    |       cat $0 | mail -s " |
    | Script \"`basename $0`\" |
    |  has mailed itself to yo |
    | u." "$adr"               |
    |     # ================== |
    | ======================== |
    | ======================== |
    | ==========               |
    |                          |
    |     # ------------------ |
    | ------------------------ |
    | --                       |
    |     #  Greetings from th |
    | e self-mailing script.   |
    |     #  A mischievous per |
    | son has run this script, |
    |     #+ which has caused  |
    | it to mail itself to you |
    | .                        |
    |     #  Apparently, some  |
    | people have nothing bett |
    | er                       |
    |     #+ to do with their  |
    | time.                    |
    |     # ------------------ |
    | ------------------------ |
    | --                       |
    |                          |
    |     echo "At `date`, scr |
    | ipt \"`basename $0`\" ma |
    | iled to "$adr"."         |
    |                          |
    |     exit 0               |
    |                          |
    |     #  Note that the "ma |
    | ilx" command (in "send"  |
    | mode) may be substituted |
    |     #+ for "mail" ... bu |
    | t with somewhat differen |
    | t options.               |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </div>

 **mailto**
    Similar to the **mail** command, **mailto** sends e-mail messages
    from the command-line or in a script. However, **mailto** also
    permits sending MIME (multimedia) messages.

 **mailstats**
    Show *mail statistics* . This command may be invoked only by *root*
    .

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     root# mailstats      |
    |     Statistics from Tue  |
    | Jan  1 20:32:08 2008     |
    |       M   msgsfr  bytes_ |
    | from   msgsto    bytes_t |
    | o  msgsrej msgsdis msgsq |
    | ur  Mailer               |
    |       4     1682      24 |
    | 118K        0          0 |
    | K        0       0       |
    |  0  esmtp                |
    |       9      212         |
    | 640K     1894      25131 |
    | K        0       0       |
    |  0  local                |
    |      =================== |
    | ======================== |
    | ======================== |
    | ==                       |
    |       T     1894      24 |
    | 758K     1894      25131 |
    | K        0       0       |
    |  0                       |
    |       C      414         |
    |             0            |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

 **vacation**
    This utility automatically replies to e-mails that the intended
    recipient is on vacation and temporarily unavailable. It runs on a
    network, in conjunction with **sendmail** , and is not applicable to
    a dial-up POPmail account.

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------+--------------------+--------------------+--------------------+
| ` [1]              |
|  <communications.h |
| tml#AEN13320>`__   |
|                    |
| A *daemon* is a    |
| background process |
| not attached to a  |
| terminal session.  |
| Daemons perform    |
| designated         |
| services either at |
| specified times or |
| explicitly         |
| triggered by       |
| certain events.    |
|                    |
| The word "daemon"  |
| means ghost in     |
| Greek, and there   |
| is certainly       |
| something          |
| mysterious, almost |
| supernatural,      |
| about the way UNIX |
| daemons wander     |
| about behind the   |
| scenes, silently   |
| carrying out their |
| appointed tasks.   |
+--------------------+--------------------+--------------------+--------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <filearchiv.html>` | File and Archiving       |
| __                       | Commands                 |
| `Home <index.html>`__    | `Up <external.html>`__   |
| `Next <terminalccmds.htm | Terminal Control         |
| l>`__                    | Commands                 |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Caution| image:: ../images/caution.gif
.. |Note| image:: ../images/note.gif
