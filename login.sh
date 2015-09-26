#!/bin/bash
scriptdir=${0%/*}
httpsh="$scriptdir/http.sh"
username=""
uid=0
URLs="http://judgegirl.csie.org"

function getCurrentUser(){
    local CMD1="$httpsh \"$URLs\""
    local HTML=`eval $CMD1`
    local usernameee=$(echo """$HTML""" | grep 'fa-user')
    local usernamee=${usernameee#*</i>\ }
    username=${usernamee%\ <i*}
    local uiddd=$(echo """$HTML""" | grep '/user')
    local uidd=${uiddd#*/user/}
    uid=${uidd%\"><i*}
}

function login(){
    read -p "Enter Your Username: " username
    read -s -p "Enter Your Password: " password
    echo ""
    echo -n "Login to JudgeGirl..."
    echo ""
    local CMD1="$httpsh --data lgn=$username --data pwd=$password \"$URLs/login\""
    eval $CMD1 > /dev/null
    getCurrentUser
    if [ "$username" == "" ]; then
        echo "Failed."
    else
        echo "Success."
    fi
}

while true; do
    if [ ! -f $ck ];then
        echo "Cookies Not Found!"
        login
        echo ""
        continue
    fi
    getCurrentUser
    if [ "$username" != "" ]; then
        break
    fi
    login
done

