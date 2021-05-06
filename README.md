# evatool

## I Want to use EVATool in my Company

Note: if you want to update EVATool, you have to stop the container first with... and pull the newest version of this repo instead of cloning it

### First Time EVATool Installation

You need a few things to use EVATool:

- A server or machine you want to run it on
- The server needs to have [git](https://git-scm.com/) and [docker](https://www.docker.com/) installed

First, clone this repository on your server.

```
git clone https://github.com/EVATool/evatool
```

Navigate to this folder.

```
cd evatool/docker
```

There you will find the file .env. It contains various parameters:

- HOST_URL: The url or ip of the server EVATool is being installed on
- BACKEND_PORT: The port used by the backend
- FRONTEND_PORT: The port used by the frontend
- DATABASE_PORT: The port used by the database
- DATABASE_PASSWORD: The password used to access the database

After configuring the parameters you can start EVATool.

```
docker-compose -p evatool up
```

EVATool is now running.

### Update EVATool

If you already have EVATool running on your server and want to update it follow these steps. First navigate to the directory where the repository was cloned to. Pull the repo again to ensure the newest docker compose and settings.

```
git pull https://github.com/EVATool/evatool
```

Stop the docker compose.

```
docker-compose down
```

Restart the docker compose.

```
docker-compose -p evatool up
```

## EVATool Crash Course

Link to wiki (not yet done) (wiki explains in detail)

### Login and users


### Administration (keycloak and mysql database)


## Known Issues

- Starting the docker compose on docker desktop leads to the database container being extremely slow. It is so slow that the backend container tries to access the booting database and runs into an unhandled exception leading to the backend container stopping. The database container needs 2-5 minutes. The backend container can be manually restarted after that and the EVATool should run.

## TODO

- Rename GitHub Actions and their steps
- (DONE) Get env vars into frontend
- (DONE) Get env vars into backend
- (NOT REALLY A PROBLEM?) Get mysql to start in not 5 minutes (!) and backend must wait for healthy database (only slow on windows docker!! Deployment on internal linux server was SUPER FAST)
- (DONE) Get docker-compose to work
- (DONE) Make how to install and wiki stuff in evatool repo
- Add keycloak to docker compose
- (Wait for GP presentation) Deploy to UID server in both main deploy GitHub Actions
- (Wait for GP presentation) Use UID server as public demo? (add easy login, registration, forgot password + add keycloak!)
- Add Flyway

Docker save new tag:
docker pull org/name:latest
docker tag org/name:latest org/name:newtag
docker login
docker push org/name:newtag
