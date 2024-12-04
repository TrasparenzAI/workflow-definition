#!/bin/bash

curl -X POST http://localhost:8080/api/metadata/workflow -H 'Content-type:application/json' --data @crawler_amministrazione_trasparente.json 
curl -X POST http://localhost:8080/api/metadata/workflow -H 'Content-type:application/json' --data @crawler_result_failed.json 
curl -X POST http://localhost:8080/api/metadata/workflow -H 'Content-type:application/json' --data @rule_workflow.json 
curl -X POST http://localhost:8080/api/metadata/workflow -H 'Content-type:application/json' --data @rule_detail_workflow.json 
curl -X POST http://localhost:8080/api/metadata/workflow -H 'Content-type:application/json' --data @rule_detail_child_workflow.json

curl -X POST http://localhost:8080/api/workflow -H 'Content-type:application/json' --data @start_amm_trasparente.json
