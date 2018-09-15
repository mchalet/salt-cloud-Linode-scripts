#!/bin/bash
# Here, we pull in a list of names from 'trainee.list' to dynamically delete servers.

while read user; do 
  echo “removing $user-lamp…” 
  salt-cloud -d -y $user-lamp 
done < trainee.list