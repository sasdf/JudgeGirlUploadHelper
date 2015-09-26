#!/bin/bash
scriptdir=${0%/*}
httpsh="$scriptdir/http.sh"
uddir="$scriptdir/Userdata"
psdir="$scriptdir/perlScript"
URLs="http://judgegirl.csie.org"

echo -n "Loading Problems..."

if [ ! -d "$uddir" ]; then
    mkdir $uddir
fi

$scriptdir/login.sh

CMD1="perl $psdir/listParse.pl $@"
eval $CMD1 > "$uddir/list"
echo "Done"
