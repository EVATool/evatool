docker-compose down

# Create backend database docker volume clone.
docker volume rm evatool_backend_database_volume_backup
docker volume create --name evatool_backend_database_volume_backup
docker container run --rm \
           -v evatool_backend_database_volume:/from \
           -v evatool_backend_database_volume_backup:/to \
           alpine ash -c "cd /from ; cp -arv . /to"

# Create keycloak database docker volume clone.
docker volume rm evatool_keycloak_database_volume_backup
docker volume create --name evatool_keycloak_database_volume_backup
docker container run --rm \
           -v evatool_keycloak_database_volume:/from \
           -v evatool_keycloak_database_volume_backup:/to \
           alpine ash -c "cd /from ; cp -arv . /to"

# Create local backend docker image clone.
docker tag evatool/evatool-backend:latest evatool/evatool-backend:backup

# Create local frontend docker image clone.
docker tag evatool/evatool-frontend:latest evatool/evatool-frontend:backup

docker-compose up -d
