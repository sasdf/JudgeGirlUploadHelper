#!/bin/bash
scriptdir=${0%/*}
httpsh="$scriptdir/http.sh"
uddir="$scriptdir/Userdata"
psdir="$scriptdir/perlScript"
probdir="$uddir/Problems"
cidfile="$uddir/judgeGirlCid"
pidfile="$uddir/judgeGirlPid"
URLs="http://judgegirl.csie.org"

echo -n "Downloading Problem Description..."

if [ ! -d "$uddir" ]; then
    mkdir $uddir
fi
if [ ! -d "$probdir" ]; then
    mkdir $probdir
fi

$scriptdir/login.sh

if [ "$#" -lt 2 ]; then
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
else
    cid="$1"
    pid="$2"
fi
#if [ ! -f "$scriptdir/$cid-$pid" ]; then
if [ "1"=="1" ]; then
    CMD1="$httpsh \"$URLs/problem/$cid/$pid\" | perl $psdir/problemParse.pl"
    eval $CMD1 > "$probdir/$cid-$pid"
fi

echo "Done"
