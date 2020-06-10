#!/usr/bin/sh

echo "PostgreSQL container $POSTGRES_CONTAINER";
echo "chest.store container $CHESTSTORE_CONTAINER";

sudo docker exec -it $POSTGRES_CONTAINER psql -d postgres -U postgres -c "DROP DATABASE cheststore;";
sudo docker exec -it $POSTGRES_CONTAINER psql -d postgres -U postgres -c "CREATE DATABASE cheststore;";
sudo docker exec -it $CHESTSTORE_CONTAINER npm run migrate;