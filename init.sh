#!/bin/bash

if [ -z "$1" ]
  then
    echo "Parameter missing, please enter the URL to get the TOKEN"
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

printf "Try to create or update crawler_amministrazione_trasparente \n"
( echo '['; cat crawler_amministrazione_trasparente.json ; echo ']') | curl -X PUT $4/api/metadata/workflow -H "Authorization: Bearer $TOKEN" -H 'Content-type:application/json' --data @- 
printf "\nTry to create or update crawler_result_failed\n"
( echo '['; cat crawler_result_failed.json ; echo ']') | curl -X PUT $4/api/metadata/workflow -H "Authorization: Bearer $TOKEN" -H 'Content-type:application/json' --data @- 
printf "\nTry to create or update rule_workflow\n"
( echo '['; cat rule_workflow.json ; echo ']') | curl -X PUT $4/api/metadata/workflow -H "Authorization: Bearer $TOKEN" -H 'Content-type:application/json' --data @- 
printf "\nTry to create or update rule_detail_workflow\n"
( echo '['; cat rule_detail_workflow.json ; echo ']') | curl -X PUT $4/api/metadata/workflow -H "Authorization: Bearer $TOKEN" -H 'Content-type:application/json' --data @-
printf "\nTry to create or update rule_detail_child_workflow\n"
( echo '['; cat rule_detail_child_workflow.json ; echo ']') | curl -X PUT $4/api/metadata/workflow -H "Authorization: Bearer $TOKEN" -H 'Content-type:application/json' --data @-
printf "\nTry to create or update rule_detail_html_source_workflow\n"
( echo '['; cat rule_detail_child_html_source_workflow.json ; echo ']') | curl -X PUT $4/api/metadata/workflow -H "Authorization: Bearer $TOKEN" -H 'Content-type:application/json' --data @-
