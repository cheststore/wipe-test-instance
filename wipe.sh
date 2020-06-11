#!/usr/bin/sh

echo "PostgreSQL container $POSTGRES_CONTAINER";
echo "redis container $REDIS_CONTAINER";
echo "chest.store container $CHESTSTORE_CONTAINER";

sudo docker exec -it $POSTGRES_CONTAINER psql -d postgres -U postgres -c "DROP DATABASE cheststore;";
sudo docker exec -it $POSTGRES_CONTAINER psql -d postgres -U postgres -c "CREATE DATABASE cheststore;";
sudo docker exec -it $REDIS_CONTAINER redis-cli FLUSHDB;
sudo docker exec -it $CHESTSTORE_CONTAINER npm run migrate;
sudo docker exec -it $CHESTSTORE_CONTAINER rm -rf ./tmp/git

sudo docker cp ./cheststore.backup $POSTGRES_CONTAINER:/tmp/cheststore.backup
sudo docker exec -it $POSTGRES_CONTAINER PGPASSWORD=cheststore pg_restore -U postgres -d cheststore -a /tmp/cheststore.backup
