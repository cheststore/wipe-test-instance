# Wipe chest.store test instance

This repo provides a script to wipe the DB and reset it
back to the defaults.

## Assumptions

1. Instance is installed on Ubuntu LTS OS
2. chest.store is installed and running via [docker-compose](https://github.com/cheststore/chest.store/blob/master/README.md#docker-compose)

## Execute

```sh
$ sudo CHESTSTORE_CONTAINER=$CHESTSTORE_DOCKER_PS_HASH POSTGRES_CONTAINER=$POSTGRES_DOCKER_PS_HASH sh wipe-test.sh
```