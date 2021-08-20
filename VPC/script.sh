#!/bin/bash
sudo apt update
sudo apt install nginx -y

cat << EOF > /etc/nginx/sites-available/goweb
server {
    server_name goweb localhost;

    location / {
        proxy_pass http://localhost:8080;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/goweb /etc/nginx/sites-enabled/goweb
sudo nginx -s reload

sudo apt update
sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt update
sudo apt install docker-ce -y

sudo usermod -aG docker ${USER}
sudo chmod 666 /var/run/docker.sock
