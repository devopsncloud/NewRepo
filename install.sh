#!/bin/bash
#

user=${id -u}

if [ $user -eq 0 ]
then
	echo "You are allowed install"
else
	echo "Please run with root previliges"
fi
