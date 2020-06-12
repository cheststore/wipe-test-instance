#!/usr/bin/sh

echo "PostgreSQL container $POSTGRES_CONTAINER";
echo "redis container $REDIS_CONTAINER";
echo "chest.store container $CHESTSTORE_CONTAINER";

sudo docker exec -it $POSTGRES_CONTAINER psql -d postgres -U postgres -c "DROP DATABASE cheststore;";
sudo docker exec -it $POSTGRES_CONTAINER psql -d postgres -U postgres -c "CREATE DATABASE cheststore;";
sudo docker exec -it $REDIS_CONTAINER redis-cli FLUSHDB;
sudo docker exec -it $CHESTSTORE_CONTAINER npm run migrate;
sudo docker exec -it $CHESTSTORE_CONTAINER rm -rf ./tmp/git

sudo docker cp $0/cheststore.backup $POSTGRES_CONTAINER:/tmp/cheststore.backup
sudo docker exec -e PGPASSWORD="cheststore" -it $POSTGRES_CONTAINER pg_restore -U postgres -d cheststore -a /tmp/cheststore.backup

# assumes the instance is getting reset every hour, so make sure
# crontab is setup appropriately for hourly execution
NEXT_REFRESH=$(date -d '+1 hour' '+%F %T')
sudo docker exec -it $POSTGRES_CONTAINER psql -d cheststore -U postgres -c "INSERT INTO app_banners (banner_html) values ('This instance will be reset at <strong>$NEXT_REFRESH UTC</strong>.')"
