#!/bin/bash

# Name of the project: Base_Converter.sh
#
# Start of the project: 22 / 02 / 2024
#
# Motive of creation: Creating a base converter for terminal use.

# ver. Fri/23/Feb/2024
#
# Made by: CyberCoral
# ------------------------------------------------
# Github:
# https://www.github.com/CyberCoral
#

# Default value and alphabet lists.
default_alph=('0' '1' '2' '3' '4' '5' '6' '7' '8' '9' 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '_' ' ')
default_val=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63)

declare -A default_dict=( [${default_alph[0]}]=${default_val[0]} )

# A way of creating a dictionary.
for ((i=1;i<${#default_val[@]};i++));do
    default_dict["${default_alph[i]}"]=${default_val[$i]}
done

final_num=0

# This program's purpose is to check if
# an element is contained in a group.

contain(){
    
    local n=$#
    local value=${!n}
    for (( i=0;i < $#;i++ )); do
        if [ "${!i}" = "${value}" ]; then
            #echo "${!i}" = "${value}"
            echo "y"
        fi
    done
    echo "n"
}

# This function converts numbers
# from a base to decimal.
# Use the characters in default_alph.

from_base_to_decimal(){
    num=$1
    base=$2

    declare -A default_dict_1=(  [${default_alph[0]}]=${default_val[0]} )

    for ((i=1;i<$base;i++));do
        default_dict_1["${default_alph[i]}"]=${default_val[$i]}
    done

    final_num=0
    index=0

    if [ "$num" = "" ];then
        printf "There has to be a number to convert."
        return 1
        
    # This can be optional, if you want to adapt the program to negative numbers.
    elif (( $num<0 ));then
        printf "The number has to be positive or zero."
        return 1
    fi

    if [ "$base" = "" ];then
        printf "There must be a base of the number."
        return 1
    elif (( $base < 2 ));then
        printf "The base has to be greater or equal than 2."
        return 1
    fi
    
    # Reverse the number
    num=$(echo $num | awk '{ for(i=length;i!=0;i--)x=x substr($0,i,1);}END{print x}')

    # Here, the base conversion 

    if [ "$(contain "${!default_dict_1[@]}" "${num:0:1}")" = "n" ];then
        printf "FIRST CASE ERROR.\nThe character ${num:0:1} is not in the $base base form of default_dict."
        return 1
    fi

    key=${default_dict_1["${num:0:1}"]}

    index=$(($base**0))
    key=$(($key*$index))

    final_num=$(($final_num+$key))

    for ((i=1;i < ${#num};i++));do
    
        if [ "$(contain "${!default_dict_1[@]}" "${num:$i:1}")" = "n" ];then
            printf "GENERAL CASE ERROR.\nThe character ${num:$i:1} is not in $base base form of default_dict."
            return 1
        fi

        key=${default_dict_1["${num:$i:1}"]}

        index=$(($base**$i))
        key=$(($key*$index))

        final_num=$(($final_num+$key))

    done
}

convert_decimal_to_base(){
    num=$1
    final_base=$2

    final_num=0
    module=0

    rev=""
    copy=0

    declare -A default_conversion=(  [${default_val[0]}]=${default_alph[0]} )
    for ((i=1;i<$final_base;i++));do
        default_conversion["${default_val[i]}"]=${default_alph[$i]}
    done

    if [ "$num" = "" ];then
        printf "There has to be a number to convert."
        return 1

    # This can be optional, if you want to adapt the program to negative numbers.
    elif (( $num<0 ));then
        printf "The number has to be positive or zero."
        return 1
    fi

    if [ "$final_base" = "" ];then
        printf "There must be a base of the number."
        return 1
    elif (( $final_base<2 ));then
        printf "The base has to be greater or equal than 2."
        return 1
    fi

    module=$(($num%$final_base))
    final_num=${default_conversion[$module]}

    num=$(($num/$final_base))

    if [ $num -ne 0 ];then

        while [ $num -ne 0 ];do
            module=$(($num%$final_base))
            final_num+=${default_conversion[$module]}
            num=$(($num/$final_base))
        done

    fi

    copy=${final_num}


    # Another method of reversing a string

    for((i=${#copy}-1;i>=0;i--)); do rev="$rev${copy:$i:1}"; done
    final_num=${rev}

    copy=""

    if [ "${final_num:0:1}" = ${default_conversion[0]} ];then
        for ((i=1;i < ${#final_num};i++));do
            copy=$copy${final_num:$i:1}
        done
        final_num=${copy}
    fi

    # You must obtain the result by doing echo $final_num, since that variable stores the result.
}

from_base_to_decimal $1 $2
convert_decimal_to_base $final_num $3
echo "'$final_num'"