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

`Prev <procref1.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <zeros.html>`__

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

  Chapter 30. Network Programming
================================

+--------------------------+--------------------------+--------------------------+
| **                       |
| *The Net's a cross       |
| between an elephant and  |
| a white elephant sale:   |
| it never forgets, and    |
| it's always crap.*       |
|                          |
| *--Nemo*                 |
+--------------------------+--------------------------+--------------------------+

A Linux system has quite a number of tools for accessing, manipulating,
and troubleshooting network connections. We can incorporate some of
these tools into scripts -- scripts that expand our knowledge of
networking, useful scripts that can facilitate the administration of a
network.

 Here is a simple CGI script that demonstrates connecting to a remote
server.

.. raw:: html

   <div class="EXAMPLE">

**Example 30-1. Print the server environment**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # test-cgi.sh        |
|     # by Michael Zick    |
|     # Used with permissi |
| on                       |
|                          |
|     # May have to change |
|  the location for your s |
| ite.                     |
|     # (At the ISP's serv |
| ers, Bash may not be in  |
| the usual place.)        |
|     # Other places: /usr |
| /bin or /usr/local/bin   |
|     # Might even try it  |
| without any path in sha- |
| bang.                    |
|                          |
|     # Disable filename g |
| lobbing.                 |
|     set -f               |
|                          |
|     # Header tells brows |
| er what to expect.       |
|     echo Content-type: t |
| ext/plain                |
|     echo                 |
|                          |
|     echo CGI/1.0 test sc |
| ript report:             |
|     echo                 |
|                          |
|     echo environment set |
| tings:                   |
|     set                  |
|     echo                 |
|                          |
|     echo whereis bash?   |
|     whereis bash         |
|     echo                 |
|                          |
|                          |
|     echo who are we?     |
|     echo ${BASH_VERSINFO |
| [*]}                     |
|     echo                 |
|                          |
|     echo argc is $#. arg |
| v is "$*".               |
|     echo                 |
|                          |
|     # CGI/1.0 expected e |
| nvironment variables.    |
|                          |
|     echo SERVER_SOFTWARE |
|  = $SERVER_SOFTWARE      |
|     echo SERVER_NAME = $ |
| SERVER_NAME              |
|     echo GATEWAY_INTERFA |
| CE = $GATEWAY_INTERFACE  |
|     echo SERVER_PROTOCOL |
|  = $SERVER_PROTOCOL      |
|     echo SERVER_PORT = $ |
| SERVER_PORT              |
|     echo REQUEST_METHOD  |
| = $REQUEST_METHOD        |
|     echo HTTP_ACCEPT = " |
| $HTTP_ACCEPT"            |
|     echo PATH_INFO = "$P |
| ATH_INFO"                |
|     echo PATH_TRANSLATED |
|  = "$PATH_TRANSLATED"    |
|     echo SCRIPT_NAME = " |
| $SCRIPT_NAME"            |
|     echo QUERY_STRING =  |
| "$QUERY_STRING"          |
|     echo REMOTE_HOST = $ |
| REMOTE_HOST              |
|     echo REMOTE_ADDR = $ |
| REMOTE_ADDR              |
|     echo REMOTE_USER = $ |
| REMOTE_USER              |
|     echo AUTH_TYPE = $AU |
| TH_TYPE                  |
|     echo CONTENT_TYPE =  |
| $CONTENT_TYPE            |
|     echo CONTENT_LENGTH  |
| = $CONTENT_LENGTH        |
|                          |
|     exit 0               |
|                          |
|     # Here document to g |
| ive short instructions.  |
|     :<<-'_test_CGI_'     |
|                          |
|     1) Drop this in your |
|  http://domain.name/cgi- |
| bin directory.           |
|     2) Then, open http:/ |
| /domain.name/cgi-bin/tes |
| t-cgi.sh.                |
|                          |
|     _test_CGI_           |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

For security purposes, it may be helpful to identify the IP addresses a
computer is accessing.

.. raw:: html

   <div class="EXAMPLE">

**Example 30-2. IP addresses**

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     #!/bin/bash          |
|     # ip-addresses.sh    |
|     # List the IP addres |
| ses your computer is con |
| nected to.               |
|                          |
|     #  Inspired by Greg  |
| Bledsoe's ddos.sh script |
| ,                        |
|     #  Linux Journal, 09 |
|  March 2011.             |
|     #    URL:            |
|     #  http://www.linuxj |
| ournal.com/content/back- |
| dead-simple-bash-complex |
| -ddos                    |
|     #  Greg licensed his |
|  script under the GPL2,  |
|     #+ and as a derivati |
| ve, this script is likew |
| ise GPL2.                |
|                          |
|     connection_type=TCP  |
|      # Also try UDP.     |
|     field=2           #  |
| Which field of the outpu |
| t we're interested in.   |
|     no_match=LISTEN   #  |
| Filter out records conta |
| ining this. Why?         |
|     lsof_args=-ni     #  |
| -i lists Internet-associ |
| ated files.              |
|                       #  |
| -n preserves numerical I |
| P addresses.             |
|               # What hap |
| pens without the -n opti |
| on? Try it.              |
|     router="[0-9][0-9][0 |
| -9][0-9][0-9]->"         |
|     #       Delete the r |
| outer info.              |
|                          |
|     lsof "$lsof_args" |  |
| grep $connection_type |  |
| grep -v "$no_match" |    |
|           awk '{print $9 |
| }' | cut -d : -f $field  |
| | sort | uniq |          |
|           sed s/"^$route |
| r"//                     |
|                          |
|     #  Bledsoe's script  |
| assigns the output of a  |
| filtered IP list,        |
|     #  (similar to lines |
|  19-22, above) to a vari |
| able.                    |
|     #  He checks for mul |
| tiple connections to a s |
| ingle IP address,        |
|     #  then uses:        |
|     #                    |
|     #    iptables -I INP |
| UT -s $ip -p tcp -j REJE |
| CT --reject-with tcp-res |
| et                       |
|     #                    |
|     #  ... within a 60-s |
| econd delay loop to boun |
| ce packets from DDOS att |
| acks.                    |
|                          |
|                          |
|     #  Exercise:         |
|     #  --------          |
|     #  Use the 'iptables |
| ' command to extend this |
|  script                  |
|     #+ to reject connect |
| ion attempts from well-k |
| nown spammer IP domains. |
                          
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

More examples of network programming:

#. `Getting the time from *nist.gov* <devref1.html#NPREF>`__

#. `Downloading a URL <devref1.html#NW001>`__

#. `A GRE tunnel <system.html#IPSCRIPT0>`__

#. `Checking if an Internet server is up <communications.html#PING0>`__

#. `Example 16-41 <communications.html#ISSPAMMER>`__

#. `Example A-28 <contributed-scripts.html#ISSPAMMER2>`__

#. `Example A-29 <contributed-scripts.html#WHX>`__

#. `Example 29-1 <devref1.html#DEVTCP>`__

See also the `networking commands <system.html#NETWORKSYS1>`__ in the
`System and Administrative Commands <system.html>`__ chapter and the
`communications commands <communications.html>`__ in the `External
Filters, Programs and Commands <external.html>`__ chapter.

.. raw:: html

   </div>

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <procref1.html>`__ | ``        /proc       `` |
| `Home <index.html>`__    | `Up <part5.html>`__      |
| `Next <zeros.html>`__    | Of Zeros and Nulls       |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

