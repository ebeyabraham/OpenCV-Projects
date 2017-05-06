#!/bin/bash

#########################################################################################################
## OpenCV Uninstallation Script
##
## Code by	: Dimas Toha Pramawitra (Lonehack)
##		  <dms.pram@gmail.com>
## Created	: 20 Mar 2016
## Modified	: 16 Apr 2016
##
## This code is released to the public domain.
## You can use, modify, or distribute this code as you need without any restriction.
#########################################################################################################

#################################################################################
## Distribution check
#################################################################################

if [ -f /etc/debian_version ];then
	DIST="debian"
	PKG=$(which dpkg)
	PKGMGR=$(which apt-get)
	PKGLIST=" --get-selections"
elif [ -f /etc/redhat-release ];then
	DIST="redhat"
	PKG=$(which rpm)
	PKGMGR=$(which dnf)
	if [ -z "$PKGMGR" ];then
		PKGMGR=$(which yum)
	fi
	PKGLIST="--all"
else
	echo "Your Linux Distribution not yet supported by this script"
	echo "Uninstall manualy or edit this script for your need"
	exit 0
fi

#################################################################################
## Initialization
#################################################################################

LIST=$($PKG $PKGLIST | grep opencv | awk '{print $1}')
VERSION=$(pkg-config --modversion opencv)
PYT=$(pkg-config --modversion python)
PFX="/usr/local/"

trap ctrl_c INT
function ctrl_c() {
        echo "Terminated by User!"
        exit 0
}

#################################################################################
## Uninstallation
#################################################################################

if [ -z "$VERSION" ];then
	echo "OpenCV not found in pkg-config"
	echo "If OpenCV was installed,"
	echo "please uninstall remaining OpenCV manually"
else
	echo "Uninstall OpenCV : "$VERSION
fi
read -rsp $'Are you sure? <y/N>\n' -n 1 key
if [[ "$key" =~ ^[Yy]$ ]]; then
	# y pressed
	echo "Uninstalling..."
	if [ ! -z "$LIST" ];then
		sudo $PKMGR remove $LIST
	else
		echo "OpenCV not found in dpkg"
		echo "If OpenCV was installed,"
		echo "please uninstall remaining OpenCV manually"
	fi
	#sudo find / -name "*opencv*" -exec rm {} \;
	sudo rm -rf "$PFX"{include/opencv2,include/opencv,share/OpenCV}
	sudo find "$PFX"lib -maxdepth 1 -name "libopencv*" -exec rm -f {} \;
	sudo find "$PFX"bin/ -maxdepth 1 -name "opencv*" -exec rm -f {} \;
	sudo find "$PFX"lib/pkgconfig -maxdepth 1 -name "opencv*" -exec rm -f {} \;
	if [ ! -z "$PYT" ];then
		sudo find "$PFX"lib/python$PYT/dist-packages/ -maxdepth 1 -name "cv*" -exec rm -f {} \;
	fi
	echo "Uninstall OpenCV done!"
else
	echo "Uninstall OpenCV aborted.."
	exit 0
fi
