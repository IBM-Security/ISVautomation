#!/bin/bash
#set -xv
# Script specific to each target environment
# Sets a variable called token to be used on other calls.

# echo "Setting variables and getting token"

TENANT="mytenant.ice.ibmcloud.com"
CID="5e184b19-xxxx-yyyyy-zzzzzz"
CS="1234567890"

D="./out"

RET=$(curl -s -X POST https://${TENANT}/v1.0/endpoint/default/token -H 'Content-Type: application/x-www-form-urlencoded' \
-d "grant_type=client_credentials&client_id=$CID&client_secret=$CS&scope=openid")


TOKEN=$(echo $RET  | jq -r .access_token)
