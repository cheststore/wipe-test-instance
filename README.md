# Wipe chest.store test instance

This repo provides a script to wipe the DB and reset it
back to the defaults.

## Assumptions

1. Instance is installed on Ubuntu LTS OS
2. chest.store is installed and running via [docker-compose](https://github.com/cheststore/chest.store/blob/master/README.md#docker-compose)

## Execute

```sh
$ # update environment variables in wipe.sh to correspond to docker process hashes
$ sudo sh wipe.sh
```

### Add to crontab

The following will execute the job hourly at the top of the hour.

```sh
$ sudo crontab -e
# ...
# ...
# m h  dom mon dow   command
0 * * * * sh /home/ubuntu/wipe-test-instance/wipe.sh
```
