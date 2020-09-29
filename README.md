# ISVautomation
Scripts to automate operations in IBM Security Verify

## Requirements

The scripts require bash, jq, and curl.

## Setup

Create an API client and secret with all permissions except the "Enable external agent runtime functions".

All configuration for the connection to the tenant is in a single file called env.sh.

```
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
'''


# License

Copyright 2018 International Business Machines

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
