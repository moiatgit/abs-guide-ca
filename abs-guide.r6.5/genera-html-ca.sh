#! /bin/sh
#
# This script generates html from rst for all the rst files in $1
# and leaves output on $2
# If $1 or $2 are not specified, it uses cwd.
# It compares dates and only performs conversion on files with
# source newer than destination
#
srcdir=${1:-"."}
dstdir=${2:-"."}
echo $srcdir $dstdir
exit
#
for fsource in rst-ca/*;
do
    fn=$(basename $fsource)
    name=${fn%.*}
    fdest=html-ca/$name.html
    if [ $fsource -nt $fdest ]
    then
        rst2html $fsource $fdest
    fi
done
