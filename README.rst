############
abs-guide-ca
############

This is a translation into Catalan of the *ABS-Guide* by Mendel Cooper.

You can find the original document at http://tldp.org/LDP/abs/html/.

Structure of the project
========================

This project is organised with the following structure:

#. abs-guide.r10/ original version in html

   - html/ and images/ html and images

     It is here for reference only

   - prep/ original html files converted into rst format. It is mostly an automated conversion using
     pandoc with some massive adaptations and fixing to adequate the contents to sphinx-doc.

     Unfortunately these contents cannot be used directly to build a sphinx-doc of reasonable
     quality.

#. abs-guide.rXX/ older versions of the book. Just for checking. Generally, you can ignore its contents safely.

#. sphinx-abs/ actual translation and sphinx stuff

   - .rst files with a title prefixed by *XXX* when the file is still to be (completely) translated

   - _scripts/ script files that are included (``literalinclude``) by the .rst files

   - _build/ after ``make html`` the folder _build/html contains the .html files obtained from the
     .rst files.

   - the rest are sphinx related files (slight changes in layout and sphinx elements' translation)


Tech involved
=============

As already stated, I'm using reStructuredText for the sources and Sphinx-doc for the building of the
final documentation.

How to collaborate?
===================

Wow! You're still reading! Well, I see some options, depending on your interest and time:


* fork me, select a file of your interest (preferably with a title prefixed by XXX) and start
  translating. Then pull-request-me so I can merge your work.

* review already translated files and send me issues.

* translate it into another language (say Spanish) We can share ideas.

* improving Sphinx usage (css, layouts, etc)

* adapting English version to Sphinx (there are a lot of not-so-trivial to automate issues)

* others like finding out a nicer name for the translated version and the like.

License
=======

While the original work is *public domain*, I have chosen to license this translation (including
Sphinx adaptations) as `GPL <http://www.gnu.org/licenses/gpl.html>`. Therefore, you can do whatever
you want with these contents under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or any later version (your choice)
