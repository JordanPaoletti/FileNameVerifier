#!/bin/bash

hasSubmit=false
hasNames=false


for output in $(ls -a)
do
    if [ "$output" == ".names" ]
    then
        hasNames=true
    fi
    if [ "$output" == "submit" ]
    then
        hasSubmit=true
    fi
done

if [ "$hasSubmit" == "false" ] && [ "$hasNames" == "false" ]
then
    echo "submit folder and .names not found!"
    exit
fi

if [ "$hasSubmit" == "false" ]
then
    echo "submit folder not found!"
    exit
fi

if [ "$hasNames" == "false" ]
then
    echo ".names file not found!"
    exit
fi


names=$(cat .names)
submit=$(ls submit/)
found=""
missing=""
extra=""

for file in $submit
do
    foundFlag=false
    for name in $names
    do
        if [ "$file" == "$name" ]
        then
            found="$found $name"
            foundFlag=true
        fi
    done

    if [ "$foundFlag" == "false" ]
    then
        extra="$extra $file"
    fi
done

for name in $names
do
    foundFlag=false
    for file in $found
    do
        if [ "$name" == "$file" ]
        then
            foundFlag=true
        fi
    done

    if [ "$foundFlag" == "false" ]
    then
        missing="$missing $name"
    fi
done

echo ""
echo "Found Files ============================="

for file in $found
do
    echo "Found $file"
done

echo ""
echo "Missing Files ============================"

for file in $missing
do
    echo "Missing $file!"
done

echo ""
echo "Extra Files =============================="


for file in $extra
do 
    echo "$file"
done

echo ""
