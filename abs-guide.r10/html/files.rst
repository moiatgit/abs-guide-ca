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

`Prev <bash-options.html>`__

.. raw:: html

   </td>

.. raw:: html

   <td width="80%" align="center" valign="bottom">

.. raw:: html

   </td>

.. raw:: html

   <td width="10%" align="right" valign="bottom">

`Next <systemdirs.html>`__

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

Appendix H. Important Files
===========================

.. raw:: html

   <div class="VARIABLELIST">

**startup files**

    These files contain the aliases and `environmental
    variables <othertypesv.html#ENVREF>`__ made available to Bash
    running as a user shell and to all Bash scripts invoked after system
    initialization.

``/etc/profile``
    Systemwide defaults, mostly setting the environment (all Bourne-type
    shells, not just Bash `[1] <files.html#FTN.AEN23892>`__)

``/etc/bashrc``
    systemwide functions and `aliases <aliases.html#ALIASREF>`__ for
    Bash

``$HOME``/.bash\_profile
    user-specific Bash environmental default settings, found in each
    user's home directory (the local counterpart to ``/etc/profile``)

``$HOME``/.bashrc
    user-specific Bash init file, found in each user's home directory
    (the local counterpart to ``/etc/bashrc``). Only interactive shells
    and user scripts read this file. See `Appendix
    M <sample-bashrc.html>`__ for a sample ``.bashrc`` file.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**logout file**

``$HOME``/.bash\_logout
    user-specific instruction file, found in each user's home directory.
    Upon exit from a login (Bash) shell, the commands in this file
    execute.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**data files**

``/etc/passwd``
    A listing of all the user accounts on the system, their identities,
    their home directories, the groups they belong to, and their default
    shell. Note that the user passwords are *not* stored in this file,
    `[2] <files.html#FTN.AEN23937>`__ but in ``/etc/shadow`` in
    encrypted form.

.. raw:: html

   </div>

.. raw:: html

   <div class="VARIABLELIST">

**system configuration files**

``/etc/sysconfig/hwconf``
    Listing and description of attached hardware devices. This
    information is in text form and can be extracted and parsed.

    +--------------------------+--------------------------+--------------------------+
    | .. code:: SCREEN         |
    |                          |
    |     bash$ grep -A 5 AUDI |
    | O /etc/sysconfig/hwconf  |
    |                          |
    |     class: AUDIO         |
    |      bus: PCI            |
    |      detached: 0         |
    |      driver: snd-intel8x |
    | 0                        |
    |      desc: "Intel Corpor |
    | ation 82801CA/CAM AC'97  |
    | Audio Controller"        |
    |      vendorId: 8086      |
    |                          |
                              
    +--------------------------+--------------------------+--------------------------+

    .. raw:: html

       </p>

    .. raw:: html

       <div class="NOTE">

    +--------------------------------------+--------------------------------------+
    | |Note|                               |
    | This file is present on Red Hat and  |
    | Fedora Core installations, but may   |
    | be missing from other distros.       |
    +--------------------------------------+--------------------------------------+

    .. raw:: html

       </div>

.. raw:: html

   </div>

.. raw:: html

   </div>

Notes
~~~~~

+--------------------------------------+--------------------------------------+
| `[1] <files.html#AEN23892>`__        | `[2] <files.html#AEN23937>`__        |
| This does not apply to **csh**,      | In older versions of UNIX, passwords |
| **tcsh**, and other shells not       | *were* stored in ``/etc/passwd``,    |
| related to or descended from the     | and that explains the name of the    |
| classic Bourne shell (**sh**).       | file.                                |
+--------------------------------------+--------------------------------------+

.. raw:: html

   <div class="NAVFOOTER">

--------------

+--------------------------+--------------------------+--------------------------+
| `Prev <bash-options.html | Bash Command-Line        |
| >`__                     | Options                  |
| `Home <index.html>`__    |                          |
| `Next <systemdirs.html>` | Important System         |
| __                       | Directories              |
+--------------------------+--------------------------+--------------------------+

.. raw:: html

   </div>

.. |Note| image:: ../images/note.gif
