#!/bin/bash
# Distributed by Ansible

Cnt="Denmark";
awk -v GG="$Cnt" '{if(match($0,GG) != "0")AA="1";if(AA == "1"){if( length($2) != "0"  )print substr($0,2) ;else AA="0"} }' /etc/pacman.d/mirrorlist.pacnew > /tmp/mirrors.tmp

rankmirrors /tmp/mirrors.tmp > /etc/pacman.d/mirrorlist

rm /tmp/mirrors.tmp
