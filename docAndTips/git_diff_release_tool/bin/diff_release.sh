#!/bin/bash




if [ $# -gt 0 ]; then
        tag=$1
else
        tag=`git tag --sort=-taggerdate | head -1`
fi



echo ""
echo "************************************************************************"
echo "********************* Release based on $tag  ***************************"
echo "************************************************************************"
echo ""



pwd=`pwd`

prj_name=`basename $pwd`

basedir=`dirname $pwd`

release_dir=$basedir/release/$prj_name


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

	echo "Copy $file  ----->  release/$file"
done






