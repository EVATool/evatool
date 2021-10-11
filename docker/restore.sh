docker-compose down

# Restore from backend database docker volume clone.
docker volume rm evatool_backend_database_volume
docker volume create --name evatool_backend_database_volume
docker container run --rm -it \
           -v evatool_backend_database_volume_backup:/from \
           -v evatool_backend_database_volume:/to \
           alpine ash -c "cd /from ; cp -av . /to"

# Restore from database docker volume clone.
docker volume rm evatool_keycloak_database_volume
docker volume create --name evatool_keycloak_database_volume
docker container run --rm -it \
           -v evatool_keycloak_database_volume_backup:/from \
           -v evatool_keycloak_database_volume:/to \
           alpine ash -c "cd /from ; cp -av . /to"

# Start docker-compose with EVATOOL_VERSION overwritten to backend.
docker-compose up -d
