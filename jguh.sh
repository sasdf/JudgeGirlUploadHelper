#!/bin/bash
scriptdir=${0%/*}
ck=$scriptdir/judgeGirlCookies
cidfile=$scriptdir/judgeGirlCid
pidfile=$scriptdir/judgeGirlPid

function user(){
    local HTML=$(curl -s -b "$ck" "http://judgegirl.csie.org/" | grep 'fa-user')
    local usernamee=${HTML#*</i>\ }
    local username=${usernamee%\ <i*}
    echo "$username"
}

function login(){
    read -p "Enter Your Username: " username
    read -s -p "Enter Your Password: " password
    echo ""
    echo -n "Login to JudgeGirl..."
    echo ""
    curl -s -c $ck --data lgn=$username --data pwd=$password --referer "http://judgegirl.csie.org/" "http://judgegirl.csie.org/login" > /dev/null
    local username=$(user)
    if [ "$username" == "" ]; then
        echo "Failed."
    else
        echo "Success."
    fi
}

read -p "Test Code?(Y/n):" tc
if [ "${tc}" == "Y" ] || [ "${tc}" == "y" ] || [ "${tc}" == "" ]; then
    echo "Compiling..."
    gcc -O2 -Wall -std=c99 $1 -o ./${1%.*}
    echo "Done."
    echo "---Program Start---"
    ./${1%.*}
    echo "---Program End---"
    echo ""
fi

read -p "Upload?(Y/n):" up
if [ "${up}" == "Y" ] || [ "${up}" == "y" ] || [ "${up}" == "" ]; then
    while true; do
        if [ ! -f $ck ];then
            echo "Cookies Not Found!"
            login
            echo ""
            continue
        fi
        username=$(user)
        if [ "$username" != "" ]; then
            break
        fi
        login
    done
    echo "Username: $username"
    if [ -f $cidfile ]; then
        lastcid=$(cat $cidfile)
        read -p "Enter CID($lastcid): " cid
        if [ "$cid" == "" ]; then
            cid=$lastcid
        elif [ "$cid" != "$lastcid" ]; then
            echo "$cid" > $cidfile
        fi
    else
        read -p "Enter CID: " cid
        echo "$cid" > $cidfile
    fi
    if [ -f $pidfile ]; then
        lastpid=$(cat $pidfile)
        read -p "Enter PID($lastpid): " pid
        if [ "$pid" == "" ]; then
            pid=$lastpid
        elif [ "$pid" != "$lastpid" ]; then
            echo "$pid" > $pidfile
        fi
    else
        read -p "Enter PID: " pid
        echo "$pid" > $pidfile
    fi
    echo ""
    echo "Username: $username, CID: $cid, PID: $pid"
    read -p "Sure?(Y/n):" up2
    if [ "${up2}" == "Y" ] || [ "${up2}" == "y" ] || [ "${up2}" == "" ]; then
        echo "Uploading..."
        curl -s -b "$ck" -F cid=$cid -F pid=$pid -F lng=1 -F code=@$1 --referer "http://judgegirl.csie.org/" "http://judgegirl.csie.org/submit" > /dev/null
    fi
fi
