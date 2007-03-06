#!/bin/sh

if [ -z "$1" ]; then
    echo "Must provide CVS directory."
    exit 1;
fi

cvs=$1

(cd $cvs; cvs update -dAP)

base=`basename $cvs`
label=`date -u +"%Y%m%d.%H%M%S"`

dir="${base}-${label}"

if [ -d ${dir} ]; then
    echo "${dir} already exists."
    exit 1;
fi

mkdir -p /tmp/$dir
(cd /tmp/$dir; (cd $cvs; tar cf - .) | tar xf -)
(cd /tmp/; tar czf $dir.tar.gz $dir)
mv /tmp/$dir.tar.gz .
echo $dir.tar.gz

