#!/bin/bash
# Sets body to an empty string for all active monitors

curl -sH "Authorization: Bearer $TOKEN" \
  https://api.linode.com/v4/managed/services | jq '.data[] | select(.status|test("disabled")|not) | .id' | 
  while read line; do 
    echo "Editing monitor for $line"
    curl -sH "Content-Type: application/json" \
      -H "Authorization: Bearer $TOKEN" \
      -X PUT -d '{
          "body": ""
      }' \
    https://api.linode.com/v4/managed/services/$line 
  done;