#!/bin/bash

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

if [ -z "$5" ]
  then
    echo "Parameter missing, please enter the HTTP code ex (400,407)"
    exit 1
fi

if [ -z "$6" ]
  then
    echo "Parameter missing, please enter the workflow ID"
    exit 1
fi

TOKEN=$(curl $1/protocol/openid-connect/token \
  -H 'accept: application/json, text/plain, */*' \
  --data 'grant_type=client_credentials&client_id='$2'&client_secret='$3''| jq -r '.access_token')

printf "\n"

curl -X POST $4/api/workflow -H 'Content-type:application/json' \
-H "Authorization: Bearer $TOKEN" \
-H 'Content-type:application/json' \
--data '{
  "name": "crawler_result_failed",
  "correlationId": "crawler_result_failed",  
  "version": 2,
  "input": {
    "status": "'$5'",
    "codice_ipa": "%",
    "workflowId": "'$6'",
    "crawler_save_object": "true",
    "crawler_save_screenshot": "true",
    "root_rule": "AT_TO-BE_23-12-2024",
    "rule_name": "amministrazione-trasparente",
    "execute_child": true,
    "connection_timeout": 60000,
    "read_timeout": 60000,
    "connection_timeout_max": 120000,
    "read_timeout_max": 180000,
    "crawling_mode": "htmlSource",
    "result_base_url": "https://dica33.ba.cnr.it/result-service",
    "crawler_child_type": "START_WORKFLOW",
    "crawler_uri": "http://150.145.95.77:8080/crawl",
    "rule_base_url": "https://monitorai.ba.cnr.it/rule-service",
    "force_jsoup": "true",
    "filter_by_rule": "false"
  }
}'
