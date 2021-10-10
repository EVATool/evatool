docker-compose down

# Restore from backend database docker volume clone.
docker container run --rm -it \
           -v evatool_backend_database_backup:/from \
           -v evatool_backend_database:/to \
           alpine ash -c "cd /from ; cp -av . /to"

# Restore from database docker volume clone.
docker container run --rm -it \
           -v evatool_keycloak_database_backup:/from \
           -v evatool_keycloak_database:/to \
           alpine ash -c "cd /from ; cp -av . /to"

# Start docker-compose with EVATOOL_VERSION overwritten to backend.
docker-compose up -e EVATOOL_VERSION=backup
