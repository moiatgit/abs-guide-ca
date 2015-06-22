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

`Prev <todolist.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <asciitable.html>`__

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

  Appendix S. Copyright
======================

The *Advanced Bash Scripting Guide* is herewith granted to the PUBLIC
DOMAIN. This has the following implications and consequences.

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     A.  All previous rel |
| eases of the Advanced Ba |
| sh Scripting Guide       |
|         are as well gran |
| ted to the Public Domain |
| .                        |
|                          |
|     A1. All printed edit |
| ions, whether authorized |
|  by the author or not,   |
|         are as well gran |
| ted to the Public Domain |
| . This legally overrides |
|         any stated inten |
| tion or wishes of the pu |
| blishers. Any statement  |
|         of copyright is  |
| void and invalid.        |
|         THERE ARE NO EXC |
| EPTIONS TO THIS.         |
|                          |
|     A2. Any release of t |
| he Advanced Bash Scripti |
| ng Guide, whether in     |
|         electronic or pr |
| int form is granted to t |
| he Public Domain by the  |
|         express directiv |
| e of the author and prev |
| ious copyright holder, M |
| endel                    |
|         Cooper. No other |
|  person(s) or entities h |
| ave ever held a valid co |
| pyright.                 |
|                          |
|     B.  As a Public Doma |
| in document, unlimited c |
| opying and distribution  |
| rights                   |
|         are granted. The |
| re can be NO restriction |
| s. If anyone has publish |
| ed or will               |
|         in the future pu |
| blish an original or mod |
| ified version of this do |
| cument,                  |
|         then only additi |
| onal original material m |
| ay be copyrighted. The c |
| ore                      |
|         work will remain |
|  in the Public Domain.   |
                          
+--------------------------+--------------------------+--------------------------+

By law, distributors and publishers (including on-line publishers) are
prohibited from imposing any conditions, strictures, or provisions on
this document, any previous versions, or any derivative versions. The
author asserts that he has *not* entered into any contractual
obligations that would alter the foregoing declarations.

Essentially, you may freely distribute this book or any derivative
thereof in electronic or printed form. If you have previously purchased
or are in possession of a printed copy of a current or previous edition,
you have the LEGAL RIGHT to copy and/or redistribute it, regardless of
any copyright notice. Any copyright notice is void.

*Additionally, the author wishes to state his intention that:*

+--------------------------+--------------------------+--------------------------+
| .. code:: PROGRAMLISTING |
|                          |
|     If you copy or distr |
| ibute this book, kindly  |
| DO NOT                   |
|     use the materials wi |
| thin, or any portion the |
| reof, in a patent or cop |
| yright                   |
|     lawsuit against the  |
| Open Source community, i |
| ts developers, its       |
|     distributors, or aga |
| inst any of its associat |
| ed software or documenta |
| tion                     |
|     including, but not l |
| imited to, the Linux ker |
| nel, Open Office, Samba, |
|     and Wine. Kindly DO  |
| NOT use any of the mater |
| ials within              |
|     this book in testimo |
| ny or depositions as a p |
| laintiff's "expert witne |
| ss" in                   |
|     any lawsuit against  |
| the Open Source communit |
| y, any of its developers |
| , its                    |
|     distributors, or any |
|  of its associated softw |
| are or documentation.    |
                          
+--------------------------+--------------------------+--------------------------+

A Public Domain license essentially does not restrict ANY legitimate
distribution or use of this book. The author especially encourages its
(royalty-free!) use for classroom and instructional purposes.

To date, limited print rights (Lulu edition) have been granted to one
individual and to *no one else* . Neither that individual nor Lulu holds
or ever has held a valid copyright.

.. raw:: html

   <div class="WARNING">

+--------------------------------------+--------------------------------------+
| |Warning|                            |
| It has come to the attention of the  |
| author that *unauthorized*           |
| electronic and print editions of     |
| this book are being sold             |
| commercially on itunes ®,            |
| *amazon.com* and elsewhere. These    |
| are illegal and pirated editions     |
| produced without the author's        |
| permission, and readers of this book |
| are strongly urged not to purchase   |
| them. In fact, these pirated         |
| editions are now legal, but          |
| necessarily fall into the Public     |
| Domain, and any copyright notices    |
| contained within them are invalid    |
| and void.                            |
+--------------------------------------+--------------------------------------+

.. raw:: html

   </div>

The author produced this book in a manner consistent with the spirit of
the `LDP Manifesto <http://www.tldp.org/manifesto.html>`__ .

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| Linux is a trademark registered to Linus Torvalds.                       |
|                                                                          |
| Fedora is a trademark registered to Red Hat.                             |
|                                                                          |
| Unix and UNIX are trademarks registered to the Open Group.               |
|                                                                          |
| MS Windows is a trademark registered to the Microsoft Corp.              |
|                                                                          |
| Solaris is a trademark registered to Oracle, Inc.                        |
|                                                                          |
| OSX is a trademark registered to Apple, Inc.                             |
|                                                                          |
| Yahoo is a trademark registered to Yahoo, Inc.                           |
|                                                                          |
| Pentium is a trademark registered to Intel, Inc.                         |
|                                                                          |
| Thinkpad is a trademark registered to Lenovo, Inc.                       |
|                                                                          |
| Scrabble is a trademark registered to Hasbro, Inc.                       |
|                                                                          |
| Librie, PRS-500, and PRS-505 are trademarks registered to Sony, Inc.     |
|                                                                          |
| All other commercial trademarks mentioned in the body of this work are   |
| registered to their respective owners.                                   |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

Hyun Jin Cha has done a `Korean
translation <http://kldp.org/HOWTO/html/Adv-Bash-Scr-HOWTO/index.html>`__
of version 1.0.11 of this book. Spanish, Portuguese,
`French <http://abs.traduc.org/>`__ , German,
`Italian <http://it.tldp.org/guide/abs/index.html>`__ ,
`Russian <http://gazette.linux.ru.net/rus/articles/index-abs-guide.html>`__
, `Czech <http://premekvihan.net/bash>`__ ,
`Chinese <http://www.linuxsir.org/bbs/showthread.php?t=256887>`__ ,
Indonesian, Dutch, Romanian, Bulgarian, and Turkish translations are
also available or in progress. If you wish to translate this document
into another language, please feel free to do so, subject to the terms
stated above. The author wishes to be notified of such efforts.

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div class="SIDEBAR">                                                 |
|                                                                          |
| Those generous readers desiring to make a donation to the author may     |
| contribute a small amount via Paypal to my e-mail address,               |
| ``          <                     thegrendel.abs@gmail.com               |
|       >         ``                                                       |
| . (An                                                                    |
| ``                     Honor Roll of Supporters                   `` is  |
| given at the beginning of the `Change                                    |
| Log <http://bash.deta.in/Change.log>`__ .) This is *not* a requirement.  |
| The *ABS Guide* is a free and freely distributed document for the use    |
| and enjoyment of the Linux community. However, in these difficult times, |
| showing support for voluntary projects and especially to authors of      |
| limited means is more critically important than ever.                    |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
                                                                          
+--------------------------------------------------------------------------+

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

`Prev <todolist.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

`Home <index.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

`Next <asciitable.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

To Do List

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

ASCII Table

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   </div>

.. |Warning| image:: ../images/warning.gif
