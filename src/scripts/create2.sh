#!/bin/bash
#set -xv
. env.sh

echo "Step 2 - creating the application"

curl -s -X POST https://${TENANT}/v1.0/applications -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/json'  -d "@${D}/apps/new.application.json" | jq > "${D}/apps/new.out.application.json"

echo "Completed"