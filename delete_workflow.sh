#!/bin/bash
declare -a arr=("42d35abd-153a-4ea9-8f7b-b8c2fdca99b8")

if [ -z "$1" ]
  then
    echo "Paramete missing, please enter the URL to get the TOKEN"
    exit 1
fi

if [ -z "$2" ]
  then
    echo "Parameter missing, please enter the client id to get the TOKEN"
    exit 1
fi

if [ -z "$3" ]
  then
    echo "Parameter missing, please enter the client secret to get the TOKEN"
    exit 1
fi


if [ -z "$4" ]
  then
    echo "Parameter missing, please enter the BASE URL to conductor"
    exit 1
fi

TOKEN=$(curl $1/protocol/openid-connect/token \
	-H 'accept: application/json, text/plain, */*' \
	--data 'grant_type=client_credentials&client_id='$2'&client_secret='$3''| jq -r '.access_token')


## now loop through the above array
for i in "${arr[@]}"
do

printf "\n deleted $i"
curl -X 'DELETE' ''$4'/api/workflow/'$i'/remove?archiveWorkflow=false' -H "Authorization: Bearer $TOKEN" \
-H 'accept: */*' &

done
