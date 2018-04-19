#!/bin/bash

valid_tag=false
tag=''
if [ $# -gt 0 ]; then
    tag=`git tag | grep $1`
fi

if [[ $tag == '' ]]; then
        echo "Error: Invalid tag_label $1"
        exit
fi

echo ""
echo "************************************************************************"
echo "********************* Release based on $tag  ***************************"
echo "************************************************************************"
echo ""

pwd=`pwd`

prj_name=`basename $pwd`

release_dir=$pwd/releaser/diff/$prj_name


if [ ! -d $release_dir ]; then
        mkdir -p $release_dir
fi

git pull

git diff --name-only $tag | while read file
do
        dir=`dirname $release_dir/$file`

        if [ ! -d $dir ];then
                mkdir -p $dir
        fi

        cp -f $file $release_dir/$file
        echo "Copy $pwd/$file  ----->  $release_dir/$file"
done



