#!/bin/bash
# set -xv
. env.sh

echo "Step 1 - setting password policy and creating Agent"

ret=`curl -s -X PUT https://${TENANT}/v2.0/PasswordPolicies -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/scim+json' -d @${D}/password/policy.json` 

curl -s -X POST https://${TENANT}/config/v1.0/onpremagents/ -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/json' -d @${D}/agents/new.agent.json | jq > ${D}/agents/new.out.agent.json

# get the api client id
ACID=`jq -r '.apiClients[0]' ${D}/agents/new.out.agent.json`
curl -s -X GET https://${TENANT}/v1.0/apiclients/${ACID} -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/scim+json'  | jq  > ${D}/agents/new.apiclient.json

# Get the ID for the created agent is needed later:
AID=`jq -r '.id' ${D}/agents/new.out.agent.json`
echo "You will need the agent ID for later use: ${AID}"

echo "Completed"