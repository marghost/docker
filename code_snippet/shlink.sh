# Create the volume for shlink
docker volume create shlink-volume

# Install shlink and associated database

docker run -p 127.0.0.1:8888:8080 -e TZ="America/New_York" -e DEFAULT_DOMAIN=<DOMAIN> -e IS_HTTPS_ENABLED=true -e GEOLITE_LICENSE_KEY=<GEOLITE_LICENSE_KEY> -e DB_DRIVER=maria -e DB_USER=shlink -e DB_NAME=shlink -e DB_PASSWORD=<DB_PASSWORD> -e DB_HOST=database shlinkio/shlink:stable 
docker run -v shlink-volume:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=<MARIADB_ROOT_PASSWORD> -e MARIADB_DATABASE=shlink -e MARIADB_USER=shlink -e MARIADB_PASSWORD=<DB_PASSWORD> mariadb:10.8 

echo "Shlink & associated DB Installed"
