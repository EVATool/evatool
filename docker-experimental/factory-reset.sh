docker-compose down
docker volume rm evatool_backend_database_volume
docker volume rm evatool_keycloak_database_volume
docker-compose up -d
