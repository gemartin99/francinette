#! /bin/bash

S1="================================================================================"
S2="--------------------------------------------------------------------------------"
GREEN="\033[38;2;57;181;74m"
RED="\033[38;2;222;56;43m"
BLUE="\033[38;2;34;183;235m"
YELLOW="\033[38;2;255;176;0m"
PURPLE="\033[38;2;255;105;180m"
RESET="\033[0m"

INPUT=(basic error concurrency multiple_command mandatory m bonus b all a)
ARG1=""
ARG2="0"

mkdir -p tmp/

if ! [[ -z $1 ]]; then
    for IN in ${INPUT[@]}; do
        if [[ $1 == $IN ]]; then
            ARG1=$1
        fi
    done
    if [[ -z $ARG1 ]]; then
        echo "Invalid first argument, launch script to know usage."; rm -rf tmp/; exit 1
    fi
fi

if ! [[ -z $2 ]]; then
    re='^[0-9]+$'
    if ! [[ $2 =~ $re ]] ; then
        echo "Invalid second argument, launch script to know usage."; rm -rf tmp/; exit 1
    fi
    ARG2=$2
fi

clang -Wall -Wextra -Werror -fsanitize=address -I ./inc src/{main,test,runTest,utils}.c -o tester
if [[ $? -ne 0 ]]; then
	rm -rf tmp/; exit 1
fi

./tester $ARG1 $ARG2

rm -rf tmp/ tester
