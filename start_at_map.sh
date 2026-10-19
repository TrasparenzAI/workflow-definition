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

if [ -z "$5" ]
then
  echo "Parameter missing, please enter the codice IPA (es. cnr)"
  exit 1
fi

if [ -z "$6" ]
then
  echo "Parameter missing, please enter the sito istituzionale (es. https://www.cnr.it)"
  exit 1
fi

if [ -z "$7" ]
then
  echo "Parameter missing, please enter the parent workflow id"
  exit 1
fi

TOKEN=$(curl $1/protocol/openid-connect/token \
  -H 'accept: application/json, text/plain, */*' \
  --data 'grant_type=client_credentials&client_id='$2'&client_secret='$3''| jq -r '.access_token')

printf "\n"
curl -X POST $4/api/workflow -H 'Content-type:application/json' \
  -H "Authorization: Bearer $TOKEN" \
  --data '{
    "name": "at_map_workflow",
    "correlationId": "'$5'",
    "version": 2,
    "input": {
      "ipa": {
        "codiceIpa": "'$5'",
        "sitoIstituzionale": "'$6'"
      },
      "parent_workflow_id": "'$7'",
      "connection_timeout": 30000,
      "read_timeout": 60000,
      "result_base_url": "https://dica33.ba.cnr.it/result-service",
      "crawler_uri": "http://dica33crawler.ba.cnr.it:8080/crawl"
    }
  }'
printf "\n"