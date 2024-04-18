
Docker-CE Install instructions on Ubuntu
------

Official install instructions: https://docs.docker.com/install/linux/docker-ce/ubuntu/

Asciinema: https://asciinema.org/a/225444

#### Option 1: The [snap way](https://snapcraft.io/install/docker/ubuntu):
```
sudo apt update
sudo snap install docker

sudo groupadd docker &&
sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock

# The service name is different as it is installed with snap
systemctl status snap.docker.dockerd.service

```

#### Option 2: The scripted way:
```
curl -fsSL https://get.docker.com -o get-docker.sh &&
sudo sh get-docker.sh &&
sudo groupadd docker &&
sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock
sudo systemctl restart docker
```

#### Option 3: The traditional way:
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

#Setup docker to be used as a non-root user, to run docker commands without sudo.
#Exit and restart your SSH session so that your username is in effect in the docker group.
sudo usermod -aG docker `whoami`

#After exiting and restarting your SSH session, you should be able to run docker commands without sudo.
docker run hello-world

```

## Configure proxy for Docker, If you are behind a proxy
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
