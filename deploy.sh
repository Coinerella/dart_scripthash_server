docker-compose down
git pull
docker-compose build --no-cache scripthash_server
docker-compose up -d