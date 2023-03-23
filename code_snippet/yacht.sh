# Install Yacht Docker
docker volume create yacht_data
docker run -d -p 8001:8000 --name=yacht --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v yacht_data:/config selfhostedpro/yacht:latest
echo "Do not forget to change default credentials.  Username : admin@yacht.local password : pass"
echo "Yacht installed"