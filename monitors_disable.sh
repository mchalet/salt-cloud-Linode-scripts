#!/bin/bash
# Disables all monitors.

curl -sH "Authorization: Bearer $TOKEN" \
  https://api.linode.com/v4/managed/services | jq '.data[] | select(.status|test("disabled")|not) | .id' | 
  while read line; do 
    echo "Disabling monitor for $line"
    curl -sH "Content-Type: application/json" \
      -H "Authorization: Bearer $TOKEN" \
      -X POST \
      https://api.linode.com/v4/managed/services/$line/disable | jq '"\(.label): \(.status)"' 
  done