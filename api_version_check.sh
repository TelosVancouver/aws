#!/bin/bash

# usage: requires list of nodes "api-urls.txt" 
# to execute, run: bash api_version_check.sh api-urls.txt

URLS_FILE=$1
CURL_TIMOUT=5

for url in $(cat ${URLS_FILE})
do
    if [ "${url: -1}" == "/" ] 
    then
        url=${url::-1}
    fi
    return=$(curl -s -m ${CURL_TIMOUT} ${url}/v1/chain/get_info)
    if test $? -eq 0
    then
        version=$(echo $return | jq .server_version_string)
    else
        version="[ERROR]"
    fi
    
    echo "${url}: ${version}"
done