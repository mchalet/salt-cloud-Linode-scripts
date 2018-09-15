#!/bin/bash
# Displays the current status of non-disabled monitors.

curl -sH "Authorization: Bearer $TOKEN" \
    https://api.linode.com/v4/managed/services | 
      jq '.data[] | select(.status|test("disabled")|not) | "\(.label): \(.status)"'