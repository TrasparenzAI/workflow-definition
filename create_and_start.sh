#!/bin/bash

curl -X POST http://as4dock.test.si.cnr.it:9080/conductor-server/api/metadata/workflow -H 'Content-type:application/json' --data @crawler_amministrazione_trasparente.json 
curl -X POST http://as4dock.test.si.cnr.it:9080/conductor-server/api/metadata/workflow -H 'Content-type:application/json' --data @crawler_result_failed.json 
curl -X POST http://as4dock.test.si.cnr.it:9080/conductor-server/api/metadata/workflow -H 'Content-type:application/json' --data @rule_workflow.json 
curl -X POST http://as4dock.test.si.cnr.it:9080/conductor-server/api/metadata/workflow -H 'Content-type:application/json' --data @rule_detail_workflow.json 
curl -X POST http://as4dock.test.si.cnr.it:9080/conductor-server/api/metadata/workflow -H 'Content-type:application/json' --data @rule_detail_child_workflow.json

curl -X POST http://as4dock.test.si.cnr.it:9080/conductor-server/api/workflow -H 'Content-type:application/json' --data @start_amm_trasparente.json
