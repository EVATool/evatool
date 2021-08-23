# EVATool (Ethical Value Assessment Tool)

TODO: Use scripts in scripts folder to do stuff

## I Want to Test EVATool (Public version)

Public version available at evatool.org

You can technically us it, but it is not recommended...

## I Want to use EVATool in my Company

Note: if you want to update EVATool, you have to stop the container first with... and pull the newest version of this repo instead of cloning it

### First Time EVATool Installation

You need a few things to use EVATool:

- A server or machine you want to run it on
- The server must have enough ports exposed
- The server must have an SSL certificate (if any kind of authorization is used)
- The server needs to have [git](https://git-scm.com/) and [docker](https://www.docker.com/) installed

First, clone this repository on your server.

```
git clone https://github.com/EVATool/evatool
```

Navigate to the docker folder.

```
cd evatool/docker
```

There you will find the file .env. It contains various parameters. The most important parameters are:

- BACKEND_URL: The url or ip of the server EVATool is being installed on
- BACKEND_PORT: The port used by the REST backend
- FRONTEND_PORT: The port used by the frontend UI
- KEYCLOAK_PORT: The port used by the keycloak UI

After configuring the parameters you can start EVATool.

```
docker-compose up
```

EVATool is now running.

TODO: check for invalid combinations of env vars
TODO: conditionally disable containers based on env vars
Note: keycloak master realm set WebOrigins to *
Note: if registration is enabled, you should delete the predefined users of evatool-realm.
Note: It is highly recommended to change the user passwords of the default realm "evatool-realm" in the keycloak admin console.

### Update EVATool

If you already have EVATool running on your server and want to update it follow these steps. First navigate to the directory where the repository was cloned to. Pull the repo again to ensure the newest docker compose and settings.

```
git pull https://github.com/EVATool/evatool
```

Navigate to the docker folder.

```
cd docker
```

Stop the docker compose.

```
docker-compose down
```

Remove unused images in order to ensure newest version is pulled (this deletes all unused images on your system).

```
docker image prune -f -a
```

Restart the docker compose.

```
docker-compose up
```

### Specific version

Clone the specific version you want to install by tag.

```
git clone --depth 1 --branch <version> https://github.com/EVATool/evatool
```

Then change version in the .env file too. The available versions can be seen under releases.

## EVATool Crash Course

Link to wiki (not yet done) (wiki explains in detail)

### Login and users


### Administration (keycloak and mysql database)

Renaming realms is not supported
Deleting a realm will not delete the data
The default realm "evatool-realm" should not be deleted

## Known Issues

- Starting the docker compose on windows 10 when using Docker Desktop leads to the database container being extremely slow. It is so slow that the backend container tries to access the booting database and runs into an unhandled exception leading to the backend container stopping. The database container needs 2-5 minutes. The backend container can be manually restarted after that and the EVATool should run.
- The keycloak container cannot be restarted (the keycloak image is not designed to do that). It has to be deleted and re-created. This is automatically done with docker-compose down.
