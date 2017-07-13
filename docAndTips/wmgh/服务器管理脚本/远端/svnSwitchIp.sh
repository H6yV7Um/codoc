#!/bin/bash


new_ip=`cat /alidata/www_cnf/svnIp`


#########################################################
cd /alidata/www/authenticator
tmp=`svn info | grep '^Repository Root: svn://'`
sub='Repository Root: svn://'
old_ip=${tmp/$sub}

if [ "$old_ip" != "$new_ip" ]
then
  svn switch --relocate svn://$old_ip/authenticator  svn://$new_ip/authenticator
fi


##########################################################
cd /alidata/www/iwmgh.com
tmp=`svn info | grep '^Repository Root: svn://'`
sub='Repository Root: svn://'
old_ip=${tmp/$sub}

if [ "$old_ip" != "$new_ip" ]
then
  svn switch --relocate svn://$old_ip/branch/words_tool_release/website_advanced  svn://$new_ip/branch/words_tool_release/website_advanced 
fi


##########################################################
cd /alidata/www/studymate
tmp=`svn info | grep '^Repository Root: svn://'`
sub='Repository Root: svn://'
old_ip=${tmp/$sub}

if [ "$old_ip" != "$new_ip" ]
then
  svn switch --relocate svn://$old_ip/trunk/words_tool/server_studymate  svn://$new_ip/trunk/words_tool/server_studymate
fi


##########################################################
cd /alidata/www/super_memory
tmp=`svn info | grep '^Repository Root: svn://'`
sub='Repository Root: svn://'
old_ip=${tmp/$sub}

if [ "$old_ip" != "$new_ip" ]
then
  svn switch --relocate svn://$old_ip/SuperMemory/programme/server  svn://$new_ip/SuperMemory/programme/server
fi


##########################################################
cd /alidata/www/team_tools
tmp=`svn info | grep '^Repository Root: svn://'`
sub='Repository Root: svn://'
old_ip=${tmp/$sub}

if [ "$old_ip" != "$new_ip" ]  
then
  svn switch --relocate svn://$old_ip/team_tools  svn://$new_ip/team_tools 
fi





##########################################################
cd /alidata/www/poker
tmp=`svn info | grep '^Repository Root: svn://'`
sub='Repository Root: svn://'
old_ip=${tmp/$sub}

if [ "$old_ip" != "$new_ip" ]
then
  svn switch --relocate svn://$old_ip/Poker/programme/server  svn://$new_ip/Poker/programme/server
fi




















cd  >/dev/null







