#!/bin/sh

minilims=$1
execution_name=$2
destfolder=$3 

echo "minilims="$minilims
echo "execution_name="$execution_name
echo "destfolder"=$destfolder

exID=`sqlite3 ${minilims} "select id from execution where description='${execution_name}';"|tail -n1` 
echo ${exID}
sqlite3 ${minilims} "select repository_name,description from file where origin_value=$exID"|awk -v srcfolder=${minilims}".files" -v destfolder=${destfolder} '{split($0,a,"|"); split(a[2],b,"[");cmd_copy="cp "srcfolder"/"a[1]" "destfolder"/"b[1]; print cmd_copy; system(cmd_copy)}'

