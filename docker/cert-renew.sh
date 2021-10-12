#docker-compose down



input=".env"
while IFS= read -r line
do
  if [[ $line == SERVER_ADDR* ]] ; then
    addr=$line
    echo $addr
  fi
done < "$input"






# Re-encrypt certificate for keystore (used by spring backend).
# TODO
#cd? /data/certbot/conf/live/$0
#openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out keystore.p12 -name tomcat -CAfile chain.pem -caname root -password $1
# TODO how to pass passphrase into command above?



#docker-compose up -d
