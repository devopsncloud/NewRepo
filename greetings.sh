#!/bin/bash

PERSON=$1

if [ -z $PERSON ]
then 
    echo " Please pass the argument"
    exit 1
else 
    echo "Hi $1, Good Morning"
fi