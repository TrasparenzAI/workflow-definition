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

TOKEN=$(curl $1/protocol/openid-connect/token \
  -H 'accept: application/json, text/plain, */*' \
  --data 'grant_type=client_credentials&client_id='$2'&client_secret='$3''| jq -r '.access_token')

printf "\n"

curl -X POST $4/api/workflow -H 'Content-type:application/json' \
-H "Authorization: Bearer $TOKEN" \
-H 'Content-type:application/json' \
--data '{
  "name": "crawler_amministrazione_trasparente",
  "correlationId": "crawler_amministrazione_trasparente",  
  "version": 1,
  "input": {
    "page_size": 2000,
    "codice_categoria": "",
    "codice_ipa": "",
    "id_ipa_from": 0,
    "parent_workflow_id": "",
    "execute_child": true,
    "crawling_mode": "httpStream",
    "crawler_save_object": false,
    "crawler_save_screenshot": false,
    "root_rule": "AT_TO-BE_23-12-2024",
    "rule_name": "amministrazione-trasparente",
    "force_jsoup": "true",
    "connection_timeout": 30000,
    "read_timeout": 30000,
    "connection_timeout_max": 60000,
    "read_timeout_max": 60000,
    "crawler_child_type": "START_WORKFLOW",
    "result_base_url": "https://dica33.ba.cnr.it/result-service",
    "crawler_uri": "http://150.145.95.77:8080/crawl",
    "rule_base_url": "https://monitorai.ba.cnr.it/rule-service",
    "public_company_base_url": "https://dica33.ba.cnr.it/public-sites-service",
    "result_aggregator_base_url": "https://dica33.ba.cnr.it/result-aggregator-service"
  }
}'
