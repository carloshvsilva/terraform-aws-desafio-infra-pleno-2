#!/bin/bash
rm -Rf /etc/localtime
ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
### INSTALAÇÃO DOCKER + DOCKER COMPOSE UBUNTU ###
sudo apt-get update -y
sudo apt-get install -y\
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
### Instalando 
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
#################################

### INSTALAÇÂO GIT ##############
sudo apt install git -y
#################################

### CLONE DO REPOSITÓRIO DA APLICAÇÃO ###
sudo git clone https://github.com/carloshvsilva/desafio-infra-pleno-2.git /home/ubuntu/desafio-infra-pleno-2
#########################################

### EXECUÇÃO DO DOCKER COMPOSE ##########
sudo docker compose -f /home/ubuntu/desafio-infra-pleno-2/docker-compose.yml up -d
#########################################


