#! /bin/sh
#
# This script generates html from rst for all the files in ca
# It compares dates and only performs conversion on files with
# source newer than destination
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
