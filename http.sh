#!/bin/bash
scriptdir=${0%/*}
uddir="$scriptdir/Userdata"
ck="$uddir/judgeGirlCookies"
URLs="http://judgegirl.csie.org"
#curl="curl -v -A \"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36\" -H \"X-Forwarded-For: ::ffff:140.112.16.155\" --referer \"$URLs\""
curlNC="curl -s -c \"$ck\" -A \"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36\" --referer \"$URLs\""
curl="$curlNC -b \"$ck\" $@"
curlNC="$curlNC $@"

if [ ! -d "$uddir" ]; then
    mkdir $uddir
fi

if [ ! -f $ck ];then
    eval $curlNC
else
    eval $curl
fi

