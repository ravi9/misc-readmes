
Docker-CE Install instructions on Centos
------

Official install instructions: https://docs.docker.com/install/linux/docker-ce/centos/

```
#Uninstall existing installations
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

#Install prereqs
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

#setup yum repo
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

#INSTALL
sudo yum install docker-ce
# Use -E if proxy and env needed for running sudo 
# sudo -E yum install docker-ce

#Start Docker service
sudo systemctl start docker

#Test the docker installation
sudo docker run hello-world

#Run Docker without sudo prefix
sudo groupadd docker
sudo usermod -aG docker $USER

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
