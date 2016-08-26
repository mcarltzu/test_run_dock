#!/bin/sh

set -eu

#if [ ${#} -ne 1 ]; then
#        echo "runTalendJob: usage: job_name"
#        exit 2
#fi
arguments="$@"
talendjob=${1}

#delete talendjob from the argumentsstring
talendarguments=${arguments#${talendjob}}

echo "`date`: Starting Job ${1} with params ${talendarguments}" 
bash /etc/talend/Jobs/${1}/${1}_run.sh ${talendarguments}
echo "`date`: Finished Job ${1}" 

