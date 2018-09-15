#!/bin/bash
# Here, we pull in a list of names from 'trainee.list' to dynamically deploy servers.
# 'ubuntu_xenial' references a salt config in `/etc/salt/cloud.profiles.d`

while read user; do 
  echo "making $user-lamp…" 
  salt-cloud -p ubuntu_xenial $user-lamp 
done < ~/trainee.list