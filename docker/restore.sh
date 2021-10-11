docker-compose down

# Restore from backend database docker volume clone.
docker volume rm evatool_backend_database_volume
docker volume create --name evatool_backend_database_volume
docker container run --rm \
           -v evatool_backend_database_volume_backup:/from \
           -v evatool_backend_database_volume:/to \
           alpine ash -c "cd /from ; cp -arv . /to"

# Restore from database docker volume clone.
docker volume rm evatool_keycloak_database_volume
docker volume create --name evatool_keycloak_database_volume
docker container run --rm \
           -v evatool_keycloak_database_volume_backup:/from \
           -v evatool_keycloak_database_volume:/to \
           alpine ash -c "cd /from ; cp -arv . /to"

 echo "Set EVATOOL_VERSION in the .env file to 'backend' and run docker-compose up -d"
