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

`Prev <sysscripts.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="bottom" width="80%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="bottom" width="10%">

`Next <regexp.html>`__

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

   <div class="PART">

.. raw:: html

   <div class="TITLEPAGE">

Part 5. Advanced Topics
=======================

.. raw:: html

   <div class="PARTINTRO">

At this point, we are ready to delve into certain of the difficult and
unusual aspects of scripting. Along the way, we will attempt to "push
the envelope" in various ways and examine *boundary conditions* (what
happens when we move into uncharted territory?).

.. raw:: html

   </div>

.. raw:: html

   <div class="TOC">

.. raw:: html

   <dl>

.. raw:: html

   <dt>

**Table of Contents**

.. raw:: html

   </dt>

.. raw:: html

   <dt>

18. `Regular Expressions <regexp.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dd>

.. raw:: html

   <dl>

.. raw:: html

   <dt>

18.1. `A Brief Introduction to Regular Expressions <x17129.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

18.2. `Globbing <globbingref.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </dd>

.. raw:: html

   <dt>

19. `Here Documents <here-docs.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dd>

.. raw:: html

   <dl>

.. raw:: html

   <dt>

19.1. `Here Strings <x17837.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </dd>

.. raw:: html

   <dt>

20. `I/O Redirection <io-redirection.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dd>

.. raw:: html

   <dl>

.. raw:: html

   <dt>

20.1. `Using *exec* <x17974.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

20.2. `Redirecting Code Blocks <redircb.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

20.3. `Applications <redirapps.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </dd>

.. raw:: html

   <dt>

21. `Subshells <subshells.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

22. `Restricted Shells <restricted-sh.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

23. `Process Substitution <process-sub.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

24. `Functions <functions.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dd>

.. raw:: html

   <dl>

.. raw:: html

   <dt>

24.1. `Complex Functions and Function
Complexities <complexfunct.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

24.2. `Local Variables <localvar.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

24.3. `Recursion Without Local Variables <recurnolocvar.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </dd>

.. raw:: html

   <dt>

25. `Aliases <aliases.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

26. `List Constructs <list-cons.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

27. `Arrays <arrays.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

28. `Indirect References <ivr.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

29. ```          /dev         `` and
``          /proc         `` <devproc.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dd>

.. raw:: html

   <dl>

.. raw:: html

   <dt>

29.1. ```            /dev           `` <devref1.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

29.2. ```            /proc           `` <procref1.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </dd>

.. raw:: html

   <dt>

30. `Network Programming <networkprogramming.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

31. `Of Zeros and Nulls <zeros.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

32. `Debugging <debugging.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

33. `Options <options.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

34. `Gotchas <gotchas.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

35. `Scripting With Style <scrstyle.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dd>

.. raw:: html

   <dl>

.. raw:: html

   <dt>

35.1. `Unofficial Shell Scripting Stylesheet <unofficialst.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </dd>

.. raw:: html

   <dt>

36. `Miscellany <miscellany.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dd>

.. raw:: html

   <dl>

.. raw:: html

   <dt>

36.1. `Interactive and non-interactive shells and
scripts <intandnonint.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

36.2. `Shell Wrappers <wrapper.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

36.3. `Tests and Comparisons: Alternatives <testsandcomparisons.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

36.4. `Recursion: a script calling itself <recursionsct.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

36.5. ` "Colorizing" Scripts <colorizing.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

36.6. `Optimizations <optimizations.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

36.7. `Assorted Tips <assortedtips.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

36.8. `Security Issues <securityissues.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

36.9. `Portability Issues <portabilityissues.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

36.10. `Shell Scripting Under Windows <winscript.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </dd>

.. raw:: html

   <dt>

37. `Bash, versions 2, 3, and 4 <bash2.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dd>

.. raw:: html

   <dl>

.. raw:: html

   <dt>

37.1. `Bash, version 2 <bashver2.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

37.2. `Bash, version 3 <bashver3.html>`__

.. raw:: html

   </dt>

.. raw:: html

   <dt>

37.3. `Bash, version 4 <bashver4.html>`__

.. raw:: html

   </dt>

.. raw:: html

   </dl>

.. raw:: html

   </dd>

.. raw:: html

   </dl>

.. raw:: html

   </div>

.. raw:: html

   </div>

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

`Prev <sysscripts.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

`Home <index.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

`Next <regexp.html>`__

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td align="left" valign="top" width="33%">

Analyzing a System Script

.. raw:: html

   </td>

.. raw:: html

   <td align="center" valign="top" width="34%">

.. raw:: html

   </td>

.. raw:: html

   <td align="right" valign="top" width="33%">

Regular Expressions

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

.. raw:: html

   </div>

