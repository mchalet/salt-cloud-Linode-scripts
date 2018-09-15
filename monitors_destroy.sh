#!/bin/bash
# Deletes all non-disabled monitors.

curl -sH "Authorization: Bearer $TOKEN" \
  https://api.linode.com/v4/managed/services | jq '.data[] | select(.status|test("disabled")|not) | .id' | 
  while read line; do 
    echo "Deleting monitor for $line"
    curl -sH "Authorization: Bearer $TOKEN" \
      -X DELETE \
      https://api.linode.com/v4/managed/services/$line 
  done