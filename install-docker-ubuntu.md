
Docker-CE Install instructions on Ubuntu
------

Official install instructions: https://docs.docker.com/install/linux/docker-ce/ubuntu/

Asciinema: https://asciinema.org/a/225444

| Installation | Proxy Config | Troubleshooting |
|--------------|---------------|-----------------|
| [Snap](#option-1-the-snap-way) | [SNAP](#if-installed-via-snap) | [Timeout](#clienttimeout-exceeded-error) |
| [Script](#option-2-the-scripted-way) | [APT](#if-installed-via-apt) | [Permissions](#got-permission-denied-error) |
| [Traditional](#option-3-the-traditional-way) | [Alternative](#alternatively-if-your-proxy-and-other-environment-settings-are-already-in-another-file) | |

#### Option 1: The [snap way](https://snapcraft.io/install/docker/ubuntu):
```bash
sudo apt update
sudo snap install docker

sudo groupadd docker &&
sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock

# The service name is different as it is installed with snap
systemctl restart snap.docker.dockerd.service

systemctl status snap.docker.dockerd.service
```

#### Option 2: The scripted way:
```bash
curl -fsSL https://get.docker.com -o get-docker.sh &&
sudo sh get-docker.sh &&
sudo groupadd docker &&
sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock
sudo systemctl restart docker
```

#### Option 3: The traditional way:
```bash
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

#### If installed via "APT"
```bash
#Create a systemd drop-in directory for the docker service and add conf files:
sudo mkdir -p /etc/systemd/system/docker.service.d

vi /etc/systemd/system/docker.service.d/http-proxy.conf
# ADD THE Following lines
[Service]
Environment="HTTP_PROXY=http://proxy.example.com:80/"
Environment="HTTPS_PROXY=http://proxy.example.com:443/"
Environment="NO_PROXY=localhost,127.0.0.1,::1"

#Flush changes and restart docker
sudo systemctl daemon-reload
sudo systemctl restart docker

#Verify settings
systemctl show --property=Environment docker

#Test docker installation
docker run hello-world
```

#### If installed via "SNAP"
```bash
#Create a systemd drop-in directory for the docker service and add conf files:
sudo mkdir -p /etc/systemd/system/snap.docker.dockerd.service.d

sudo vi /etc/systemd/system/snap.docker.dockerd.service.d/http-proxy.conf
# ADD THE Following lines
[Service]
Environment="HTTP_PROXY=http://proxy.example.com:80/"
Environment="HTTPS_PROXY=http://proxy.example.com:443/"
Environment="NO_PROXY=localhost,127.0.0.1,::1"

#Flush changes and restart docker
sudo systemctl daemon-reload
systemctl restart snap.docker.dockerd.service

# If needed to run docker without sudo
sudo chmod 666 /var/run/docker.sock

#Verify settings
systemctl show --property=Environment snap.docker.dockerd.service

#Test docker installation
docker run hello-world
```

#### Alternatively, if your proxy and other environment settings are already in another file:
```bash
#Create a systemd drop-in directory for the docker service and add conf files:
sudo mkdir -p /etc/systemd/system/docker.service.d

sudo vi /etc/systemd/system/snap.docker.dockerd.service.d/http-proxy.conf
# ADD THE Following lines
[Service]
EnvironmentFile=/etc/environment

#Flush changes and restart docker
sudo systemctl daemon-reload
sudo systemctl restart docker

#Test docker installation
docker run hello-world

```

## Troubleshooting

#### Client.Timeout exceeded Error
If you get the following error, you maybe behind a proxy, so setup Proxy as explained above.
```bash
docker pull hello-world
Using default tag: latest
Error response from daemon: Get "https://registry-1.docker.io/v2/": net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

#### Got permission denied Error
If you get the following error, set sudo permissions properly as described above.
```bash
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json: dial unix /var/run/docker.sock: connect: permission denied

```
Fix:
```
sudo groupadd docker
sudo usermod -aG docker ${USER}
sudo chmod 666 /var/run/docker.sock # If needed.
sudo systemctl restart docker
# If installed via SNAP
sudo systemctl restart snap.docker.dockerd.service 
```
