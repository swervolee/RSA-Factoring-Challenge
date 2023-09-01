#!/bin/bash

check_factor() {
    local result
    local num1
    local num2
    local numcp

    if [ $# -ne 1 ]; then
        args=("$@")
        count=0
        num2=1

        for a in "${args[@]}"; do
            if [ $count -gt 1 ]; then
                num2=$(echo "$a * $num2" | bc)
            fi
            count=$((count + 1))
        done
    else
        num2=$1
    fi

    num1=$2
    first=$(echo "$1" | tr ':' '=')
    num=$(echo "$num2 > $num1" | bc)

    if ((num == 1)); then
        numcp=$num1
        num1=$num2
        num2=$numcp
    fi

    echo "$first=$num1*$num2"
}

if [ $# -ne 1 ]; then
    echo 'Usage: rsa <file>'
    exit 1
else
    while read -r i; do
        result=$(factor "$i")
        check_factor $result
    done < "$1"
fi
