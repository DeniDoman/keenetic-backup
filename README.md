## Keenetic config backup

Modified version of the original script:

- configuration via Docker env variables
- ansible encryption removed
- elk logs export removed

### Requirements

- Keenetic router (all models having ssh-server)
- ssh-server installed on the router
- ssh access to the router
- docker

### Running the image

````
docker run \
    -d \
    -e ROUTER_HOST="192.168.1.1" \
    -e USER_NAME="admin" \
    -e PASSWORD="admin" \
    -v /path/to/local/backup/folder:/opt \
    ghcr.io/denidoman/keenetic-backup:main
````

Environment variables list:

| Name              | Default      | Description                                    |
|-------------------|--------------|------------------------------------------------|
| ROUTER_HOST       | \<required\> | Your Keenetic router IP address or a host name |
| USER_NAME         | \<required\> | Router admin user name                         |
| PASSWORD          | \<required\> | Router admin password                          |
| SSH_PORT          | 22           | Router SSH port                                |
| NUMBER_OF_BACKUPS | 30           | Number of backups stored in the folder         |
| CRON              | @daily       | Cron rule                                      |

### Hint

Works best with [offen / docker-volume-backup](https://github.com/offen/docker-volume-backup). Just use a named volume
created externally instead of local folder and share this volume with the properly configured `docker-volume-backup`
container. This allows you to backup settings in a cloud too in a very simple way.

### Why?

A router often has many settings, network, users, accesses, routing rules, and more. If one unfortunate day the router
dies, or it is accidentally (specially) reset to factory settings. You may be in a lot of pain. If you have a server (
nat/virtual machine/cloud/raspberry pi) you can run a backup script that will add once a day (cron expression) the
script of your entire configuration to the folder you need. Additionally, it is possible to send logs to the elc stack,
or you can add the necessary notifications to monitor the progress of backups. You can also configure the total number
of backups in the configuration

### License MIT



