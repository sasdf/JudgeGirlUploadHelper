#!/bin/bash
scriptdir=${0%/*}
httpsh="$scriptdir/http.sh"
uddir="$scriptdir/Userdata"
cidfile="$uddir/judgeGirlCid"
pidfile="$uddir/judgeGirlPid"
username=""
uid=0
URLs="http://judgegirl.csie.org"

if [ ! -d "$uddir" ]; then
    mkdir $uddir
fi

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

function getAnswerStatus_HTTP(){
    local CMD1="$httpsh \"$URLs/api/submission?limit=1&uid=$uid&cid=$cid&pid=$pid\""
    local HTML=`eval $CMD1`
    asres=$(echo """$HTML""" | sed 's/.*\"res\"\:\([0-9]\)\,.*/\1/g')
    asscr=$(echo """$HTML""" | sed 's/.*\"scr\"\:\([0-9]*\)\,.*/\1/g')
}

function getAnswerStatus(){
    local lastres=
    while true; do
        getAnswerStatus_HTTP
        case "$asres" in
            0)
                if [ "$lastres" != "$asres" ]; then
                    echo ""
                    echo -n "Waiting"
                else
                    echo -n "."
                fi
                ;;
            8)
                if [ "$lastres" != "$asres" ]; then
                    echo ""
                    echo -n "Uploading"
                else
                    echo -n "."
                fi
                ;;
            1)
                echo ""
                echo "Compilation Error. score: $asscr"
                break
                ;;
            2)
                echo ""
                echo "Output Limit Exceeded. score: $asscr"
                break
                ;;
            3)
                echo ""
                echo "Memory Limit Exceeded. score: $asscr"
                break
                ;;
            4)
                echo ""
                echo "Runtime Error. score: $asscr"
                break
                ;;
            5)
                echo ""
                echo "Time Limit Exceeded. score: $asscr"
                break
                ;;
            6)
                echo ""
                echo "Wrong Answer. score: $asscr"
                break
                ;;
            7)
                echo ""
                echo "Accepted. score: $asscr"
                break
                ;;
        esac
        lastres=$asres
        sleep 1
    done
}

    #['Waiting', 'Compilation Error', 'Output Limit Exceeded', 'Memory Limit Exceeded', 'Runtime Error', 'Time Limit Exceeded', 'Wrong Answer', 'Accepted', 'Uploading...']
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
    $scriptdir/login.sh
    getCurrentUser
    echo "Username: $username, uid: $uid"
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
        CMD1="$httpsh -F cid=$cid -F pid=$pid -F lng=1 -F code=@$1 \"$URLs/submit\""
        eval $CMD1 > /dev/null
        getAnswerStatus
    fi
fi
