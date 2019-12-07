#! /bin/bash

cat "$1" | \
    sed -e :a -re 's/<!--.*?-->//g;/<!--/N;//ba' | \
    sed -e 's/^\-\{3,\}/[newpage]/g' | \
    sed -e 's/^\*\{3,\}/[newpage]/g'| \
    sed -e 's/^\#.*//g' | \
    sed ':a;N;$!ba;s/\n\{3,\}/\n\n/g' | \
    # https://unix.stackexchange.com/questions/552188/how-to-remove-empty-lines-from-begin-and-end-of-file
    sed -e '/./,$!d' -e :a -e '/^\n*$/{$d;N;ba' -e '}' \
    > "$1.pixiv.txt"

echo "$1:" $(cat "$1.pixiv.txt" | LANG=en_US.UTF-8 wc -m) chars