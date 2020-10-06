#!/bin/bash
#set -xv
. env.sh

echo "Starting"
echo "Creating Directories"

mkdir -p ${D}/password

echo "Getting password policy"
curl -s -X GET https://${TENANT}/v2.0/PasswordPolicies -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/scim+json'  | jq  > "${D}/password/policy.json"

# Calling other scripts as needed
./getagents.sh
./getapps.sh

echo "Completed getdata!"