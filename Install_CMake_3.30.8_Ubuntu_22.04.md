# Install CMake 3.30.8 on Ubuntu 22.04

```bash
sudo apt update
sudo apt upgrade -y

sudo apt install -y apt-transport-https ca-certificates gnupg software-properties-common wget

# Add Kitware APT Repository
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null

sudo apt update

# Remove Existing CMake Versions
sudo apt purge --auto-remove cmake cmake-data
sudo apt clean

# You can also check other available cmake versions using: apt-cache madison cmake

# Install CMake 3.30.8 and its data package
sudo apt install -y cmake=3.30.8-0kitware1ubuntu22.04.1 cmake-data=3.30.8-0kitware1ubuntu22.04.1
```
