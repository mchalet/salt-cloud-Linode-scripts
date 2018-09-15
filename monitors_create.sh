#!/bin/bash
# Creates and enables monitors for all '-lamp' minions.
# Defaults to URL and http://${ipv4_address}
# Warning: You cannot create a second monitor with the same label.

curl -sH "Authorization: Bearer $TOKEN" \
  https://api.linode.com/v4/linode/instances | jq -r '.data[] | select(.label|test("-lamp")) | "\(.ipv4[0]) \(.label)"' | 
  while read line; do 
    echo "Editing ${line##* }"
    curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -X POST -d '{
      "service_type": "url",
      "label": "'"${line##* }"'",
      "address": "'"http://${line%% *}"'",
      "timeout": 30
    }' \
    https://api.linode.com/v4/managed/services
  done