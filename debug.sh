#!/bin/bash

script_dir=$(dirname -- "$0")
source=$(realpath "$1")

cd $script_dir

if ! [ -f "$source" ]; then
    echo "Path invalid"
    exit
fi

if [ $(file -b --mime-type "$source" | sed 's|/.*||') != "application" ]; then
    echo "The file is not an executable"
    exit
fi

gdb -x "./files/gdb_startup" "$source"