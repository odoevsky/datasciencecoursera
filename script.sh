#!/bin/bash

DIRNAME=$1
ALGORITHM=$2
OUTPUT=$3
PASSWORD='pass'
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
log=$dir/error.log
if [[ ! -e $log ]]; then
	touch $log
fi

exec 2> $log

if [[ $2 = 'gzip' ]]

then 
	file=$3.tgz
	tar czfP $file $1
elif [[ $2 = 'bzip' ]]
then
	file=$3.tbz
	tar cjfP $file  $1  
else
	file=$3.tar	
	tar cfP $file $1
fi

openssl enc -pass pass:$PASSWORD -aes-256-cbc -in $file -out $file.enc -pbkdf2
rm $file
