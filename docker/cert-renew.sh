# Shutdown evatool.
docker-compose down

# Renew certificate with certbot.
docker-compose -f docker-compose-LE.yml up

# Extract SERVER_ADDR and SSL_KEYSTORE_PASSWORD from .env file.
input=".env"
while IFS= read -r line
do
  if [[ $line == SERVER_ADDR* ]] ; then
    addr=${line//SERVER_ADDR=/}
    addr=$(echo $addr | sed -e 's/\r//g')
  fi

  if [[ $line == SSL_KEYSTORE_PASSWORD* ]] ; then
    pw=${line//SSL_KEYSTORE_PASSWORD=/}
    pw=$(echo $pw | sed -e 's/\r//g')
  fi
done < "$input"

# Re-encrypt certificate for keystore (used by spring backend).
cd ./data/certbot/conf/live/$addr
openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out keystore.p12 -name tomcat -CAfile chain.pem -caname root -password pass:$pw
cd ../../../../../

# Restart evatool.
docker-compose up -d
