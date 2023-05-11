sudo docker image pull rustdesk/rustdesk-server
sudo docker run --name hbbs -p 21115:21115 -p 21116:21116 -p 21116:21116/udp -p 21118:21118 -v `pwd`:/root -td rustdesk/rustdesk-server hbbs -r <IP>:21117
sudo docker run --name hbbr -p 21117:21117 -p 21119:21119 -v `pwd`:/root -td rustdesk/rustdesk-server hbbr 
