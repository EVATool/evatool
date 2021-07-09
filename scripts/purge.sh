docker-compose down
docker image prune -f -a
docker volume prune -f
docker-compose up -d
