#!/bin/bash
#set -xv
. env.sh

echo "Starting getagents"
echo "Creating Directories"
mkdir -p ${D}/agents

echo "Getting on prem agent list and api client info."
# get all agents to find agent ID
curl -s -X GET https://${TENANT}/config/v1.0/onpremagents/ -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/scim+json'  | jq  > "${D}/agents/on.prem.agents.json"
# agent ID list and get the agent information
declare -a AID=( `jq -r ".[] | .id" ${D}/agents/on.prem.agents.json` )

for A in "${AID[@]}"; do
    echo "Processing $A"
    curl -s -X GET https://${TENANT}/config/v1.0/onpremagents/${A} -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/scim+json'  | jq  > "${D}/agents/${A}.agent.json"
    # get the api client id
    ACID=`jq -r '.apiClients[0]' ${D}/agents/${A}.agent.json`
    curl -s -X GET https://${TENANT}/v1.0/apiclients/${ACID} -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/scim+json'  | jq  > "${D}/agents/${A}.apiclient.json"
done

echo "Completed getagents!"