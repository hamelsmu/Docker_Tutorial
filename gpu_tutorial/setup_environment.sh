#! /bin/bash

### MAKE SURE YOU HAVE LATEST TESLA NVIDA DRIVER http://www.nvidia.com/Download/Find.aspx?lang=en-us
### You might have to look in beta and old drivers
DRIVER_URL="http://us.download.nvidia.com/tesla/384.81/NVIDIA-Linux-x86_64-384.81.run"

### Find latest NVIDIA Docker here: https://github.com/NVIDIA/nvidia-docker
NVIDIA_DOCKER_URL="https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb"

### Clone Repo
if [ ! -d ~/Docker_Tutorial/ ]; then
  cd ~
  git clone git@github.com:hamelsmu/Docker_Tutorial.git
  cd ~/Docker_Tutorial/gpu_tutorial
fi

if [ -d ~/Docker_Tutorial/ ]; then
  echo '** Docker Tutorial repo already cloned.  Refresh if something changed.'
  cd ~/Docker_Tutorial/gpu_tutorial
fi

### Install Nvidia Drivers
DRIVER_FILENAME=$(basename "$DRIVER_URL")
wget -P /tmp/$DRIVER_URL
chmod 755 /tmp/$DRIVER_FILENAME
INSTALL_CMD="sudo /tmp/$DRIVER_FILENAME -s"
echo 'Installing Nvidia driver with command: '$INSTALL_CMD
eval $INSTALL_CMD
rm /tmp/$DRIVER_FILENAME

### Install Nvidia-Docker
sudo nvidia-modprobe -u -c=0
wget -P /tmp $NVIDIA_DOCKER_URL
sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

### Restart Nvidia Driver
sudo systemctl restart nvidia-docker
nvidia-docker run --rm nvidia/cuda nvidia-smi

#setup folder
if [ ! -d ~/docker_files ]; then
  sudo mkdir -p ~/docker_files/data
  sudo mkdir -p ~/docker_files/notebooks
  sudo mkdir -p ~/docker_files/modules
fi
sudo cp ~/Docker_Tutorial/gpu_tutorial/run_jupyter.sh ~/docker_files/

# build container
bash ~/Docker_Tutorial/gpu_tutorial/build_image.sh
