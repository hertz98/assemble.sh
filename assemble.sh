#!/bin/bash

source=$1

if ! [ -f "$source" ]; then
    echo "Path invalid"
    exit
fi

if [ $(file -b --mime-type "$source" | sed 's|/.*||') == "application" ]; then
    echo "The file is an executable"
    exit
fi

dir=$(dirname "$source")
name=$(basename "$source" | cut -d"." -f1 )

gcc -m32 -o "$dir/$name" -Wa,-a -Wa,--defsym,LINUX=1 > "$dir/$name.lst" -g ./files/main.c $source

if [ $? != 0 ]; then
        echo "Assembler error"
fi