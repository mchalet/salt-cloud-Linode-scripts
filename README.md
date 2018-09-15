# salt-cloud Linode scripts
A collection of scripts and configurations for automated deployment of Linode servers with monitors. 

## Getting Started
##### Dependencies
1. A server installed with [salt-master](https://docs.saltstack.com/en/latest/topics/tutorials/salt_bootstrap.html#salt-bootstrap).
2. [jq](https://stedolan.github.io/jq/download/) for JSON filtering.
3. A Linode [personal access token](https://developers.linode.com/api/v4#section/Personal-Access-Token) aliased to `$TOKEN`.

## Commands and important files

#### `trainee.list`
This file contains a list of handles for those participating in training. It is a dependency for other scripts.
#### `/etc/salt/cloud.profiles.d` (todo)
#### `/etc/salt/master` (todo)
#### `/srv/salt/formulas` (todo)
#### `/srv/salt/top.sls` (todo)
#### `training_setup.sh`
Automates the deployment of Linodes, adds Managed pub key, sets a lamp-stack state, and enables monitors.
#### `training_cleanup.sh`
Automates the deletion of monitors and Linodes.
#### `linodes_create.sh`
Loops over `trainee.list` to deploy Linodes.
#### `linodes_destroy.sh`
Loops over `trainee.list` to destroy Linodes.
#### `monitors_clear_body.sh`
Sets monitor "body" to equal an empty string.
#### `monitors_create.sh`
Creates monitors for all Linodes deployed with `linodes_create.sh`. Default "service_type" is `URL` and default "address" is `http://${ipv4}`.
#### `monitors_destroy.sh`
Destroys all monitors deployed with `monitors_create.sh`.
#### `monitors_disable.sh`
Disables all active monitors.
#### `monitors_status.sh`
Displays the status of all enabled monitors.

## Send Commands to Break Minions (todo)
#### Examples:
###### Break path to site files:
```bash
salt '$minion' cmd.run 'mv /var/www /var/wwww'
```
###### Stop Apache:
```bash
salt '*-WP' cmd.run 'systemctl stop apache2'
```
###### Use all available storage:
```bash
salt '*-WP'  cmd.run 'mkdir -p /var/lib/specialfiles/ && dd if=/dev/zero of=/var/lib/specialfiles/biglogs count=25934272 bs=1024 && systemctl restart mysql'
# You might need to restart mysql a few times to break it.
systemctl restart mysql
```

## Troubleshooting
### Things that have gone wrong in the past...
* Linode plan renaming for Gen 6 Linodes broke the ability to create minions. 
Changes to Linode plan details can be edited in `/etc/salt/cloudprofiles.d/managed.conf`.

* Salt Master becomes out of date. To upgrade:
    ```
    apt-get update
    apt-get upgrade salt-master
    ```
