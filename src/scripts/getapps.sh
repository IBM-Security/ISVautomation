#!/bin/bash
#set -xv
. env.sh

echo "Starting getapps"
echo "Creating Directories"
mkdir -p ${D}/apps

echo "Getting the applications"
# get all apps and find app id.
curl -s -X GET https://${TENANT}/v1.0/applications -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/scim+json'  | jq > "${D}/apps/applications.json"
declare -a AID=( `jq -r "._embedded.applications[] | ._links.self.href" ${D}/apps/applications.json` )

for A in "${AID[@]}"; do
    AN=`basename $A`
    echo "Processing $A with $AN"
    curl -s -X GET https://${TENANT}${A} -H "Authorization: Bearer $TOKEN" -H 'Content-Type: application/scim+json'  | jq  > "${D}/apps/${AN}.application.json"
    echo "Creating a load-able version."
    res=`jq -f createApp.jq "${D}/apps/${AN}.application.json" > "${D}/apps/${AN}.new.application.json"`
done

echo "Completed getapps"