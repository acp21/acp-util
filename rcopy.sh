#!/bin/bash

# Script to run copy command to rclone remote based on passed folder argument

remote=drive # Intended remote to use
folder=$1 # Select folder as first positional argument

if [ $# -lt 1 ]; then
    echo "Invalid number of arguments"
    exit 1
fi

while getopts p flag;
do
    case "${flag}" in
       p) pull='true';;
    esac
done

if [ $pull ]; then
    
    if [ $# -lt 2 ]; then
        echo "Invalid number of arguments for pull mode"
        exit 1
    fi

    echo -en "Pull mode will download information onto your local machine, Are you sure?\n y/n:"
    read answer
    if [ $answer = 'y' ]; then
	folder=$2 # Reselect folder variable since -p is technically first argument now
        rclone copy $remote:$folder ~/$folder -P
    fi
    exit 1
fi

rclone copy ~/$folder $remote:$folder -P
