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

There you will find the file .env. It contains various parameters. You should change all usernames and passwords to differ from the the default values!

After configuring the parameters you can start EVATool.

```
docker-compose up
```

EVATool is now running.

TODO: check for invalid combinations of env vars
TODO: conditionally disable containers based on env vars

Note: keycloak master realm set WebOrigins to *
    -> TODO new steps with enabled CSRF and disabled CORS
    Dont forget: master realm -> admin-cli -> WebOrigins set to * (is this necessary in prod environment? What are the settings on evatool.org?)
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

## How to Enable SSL in Evatool

... when inside the docker folder

1. configure .env file to enable SSL (SSL_ENABLED, SSL_SERVER_CONF_TARGET, SERVER_PROTOCOL)
2. configure init-letsencrypt.sh (enter an email and replace evatool.org with YOURDOMAIN)
3. configure nginx/app.conf (replace evatool.org with YOURDOMAIN)

ADD USER GROUP WITH PERMISSIONS?

4. Run init-letsencrypt.sh (if the script fails, it is advised to always delete the data folder to ensure a fresh run the next time you run it)
5. Transform files in /data/certbot/conf/live/YOURDOMAIN with
   openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out keystore.p12 -name tomcat -CAfile chain.pem -caname root
     (You will be prompted to enter a password after executing the above command)
   Set the environment variable SSL_KEYSTORE_PASSWORD in the .env file to the password you used for conversion.
6. Start EvaTool docker-compose
7. Adjust the cd command in cert-renew.sh to the absolute directory that contains the script.
8. Add the following line to the crontab job list (open with crontab -e)
   0 2 * * * ABSOLUTE_PATH_TO_cert-renew.sh
   The path to the script must be absolute for cron to work properly.
   This job will renew the certificate every day at 2am (if it will expire soon) and restart the docker-compose to pass the new certificate to all containers.

Notes:
- IMPORTANT: staging MUST be 0 (NOT 1) in init-letsencrypt.sh)

## Known Issues

- Starting the docker compose on windows 10 when using Docker Desktop leads to the database container being extremely slow. It is so slow that the backend container tries to access the booting database and runs into an unhandled exception leading to the backend container stopping. The database container needs 2-5 minutes. The backend container can be manually restarted after that and the EVATool should run.
- Even on linux, the database containers are sometimes too slow and make the containers relying on them fail. This will only happend once. Restart with docker-compose down and docker-compose up once the database containers are initialized and it won't happen again once the volumes are initialized.
- The keycloak container cannot be restarted (the keycloak image is not designed to do that). It has to be deleted and re-created. This is automatically done with docker-compose down.
