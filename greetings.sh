#!/bin/bash

PERSON=$1

if [ -z $PERSON ]
then 
    echo " Please pass the argument"
    echo "usage: sh $0 <argument>" 
    exit 1
else 
    echo "Hi $1, Good Morning"
fi