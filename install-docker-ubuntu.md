
Docker-CE Install instructions on Ubuntu
------

Official install instructions: https://docs.docker.com/install/linux/docker-ce/ubuntu/

```
#Uninstall existing installations
sudo apt-get remove docker docker-engine docker.io

#setup  repo and Add Docker’s official GPG key
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -   

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

#INSTALL
sudo apt-get install docker-ce
# Use -E if proxy and env needed for running sudo 
# sudo -E yum install docker-ce


#Test the docker installation
sudo docker run hello-world
```

Configure proxy for Docker, If you are behind a proxy
------
Official docker doc for proxy-setup: https://docs.docker.com/engine/admin/systemd/#http-proxy

```
#Create a systemd drop-in directory for the docker service and add conf files:
sudo mkdir -p /etc/systemd/system/docker.service.d

vi /etc/systemd/system/docker.service.d/http-proxy.conf
# ADD THE Following lines
[Service]
Environment="HTTP_PROXY=http://proxy.example.com:80/"

vi /etc/systemd/system/docker.service.d/https-proxy.conf
# ADD THE Following lines
[Service]
Environment="HTTPS_PROXY=https://proxy.example.com:443/"

#Flush changes and restart docker
sudo systemctl daemon-reload
sudo systemctl restart docker

#Verify settings
systemctl show --property=Environment docker

#Test docker installation
sudo docker run hello-world
```
