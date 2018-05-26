#!/bin/bash
# Managed by Ansible

if [[ -f /etc/pacman.d/mirrorlist.pacnew ]]; then
  TMP=/tmp/mirrorlist.tmp
  echo "Updating pacman mirrorlist"

  rm -f /etc/pacman.d/mirrorlist.bak
  cp /etc/pacman.d/mirrorlist{,.bak}
  touch "$TMP"

  {
  awk '/^## Denmark$/{f=1}f==0{next}/^$/{exit}{print substr($0, 2)}' /etc/pacman.d/mirrorlist.pacnew;
  awk '/^## Sweden$/{f=1}f==0{next}/^$/{exit}{print substr($0, 2)}' /etc/pacman.d/mirrorlist.pacnew;
  awk '/^## Norway$/{f=1}f==0{next}/^$/{exit}{print substr($0, 2)}' /etc/pacman.d/mirrorlist.pacnew;
  awk '/^## Netherlands$/{f=1}f==0{next}/^$/{exit}{print substr($0, 2)}' /etc/pacman.d/mirrorlist.pacnew;
  awk '/^## Germany$/{f=1}f==0{next}/^$/{exit}{print substr($0, 2)}' /etc/pacman.d/mirrorlist.pacnew
  } >> "$TMP"

  rankmirrors "$TMP" > /etc/pacman.d/mirrorlist

  rm "$TMP"
  rm /etc/pacman.d/mirrorlist.pacnew
else
  exit 0
fi
