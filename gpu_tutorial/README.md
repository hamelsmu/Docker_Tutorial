# Background

Need to get started with deep learning but don't know how to setup all of the drivers that you need on a GPU computer?  You have have come to the right place!  In this repo we provide some steps you can follow to setup an NVIDIA-Docker container with the latest Nvidia graphics cards, fully loaded with common machine learning libraries.   Please note that it may be easier to use an AMI if you are on AWS -- However this information will help those that want to use Docker instead.

# Prerequisites

- If you are not familiar with docker, [read this tutorial](https://medium.com/@hamelhusain/how-docker-can-help-you-become-a-more-effective-data-scientist-7fc048ef91d5).

- You have an AWS P3 instance (the drivers in this repo are specifically for the Tesla V100 GPUs in P3s), however if you have a slightly different setup then you can always adapt what is here.

# Nvidia-Docker Setup Notes

### Install Nvidia Drivers
First, ssh into your machine.

clone this repo
```
cd ~
git clone git@github.com:hamelsmu/Docker_Tutorial.git
```

change into `Docker_Tutorial/gpu_tutorial` directory and run [setup script](./build_container.sh)

```
cd ~/Docker_Tutorial/gpu_tutorial
bash setup_environment.sh
```

### Run Docker Container

To create a running container from an image, run the below command supplying the mandatory parameters `container_name` and `image_name`.  Here I have used `fastai` as my container name.  The image created by the associated shell scripts in this repo is `tutorial` so that should be the second argument.  Everytime you run the below command it will create a new container, so you need to supply a unique container name.  Example:

> bash run_container.sh fastai tutorial

**Note:** this command will automatically instantiate a jupyter server on port **7745**

### Rebuild Image

> bash build_image.sh

### Starting a new terminal session in a container

If you don't remember your container name, you can list all running containers

> nvidia-docker ps -a -f status=running

Run terminal attached to a running container.  Example:

> nvidia-docker exec -it fastai bash

### Save the state of a container including all of the data

> nvidia-docker commit <container_id> new_image_name:tag_name(optional)

For example

> nvidia-docker commit fastai

---

# Appendix

- If you get some error about `The package <package name> needs to be reinstalled, but I can’t find an archive for it`  See [this article](http://www.ihaveapc.com/2011/10/fix-annoying-the-package-needs-to-be-reinstalled-but-i-cant-find-an-archive-for-it-error-in-linux-mint-ubuntu/)

- If you suspect there are already Nvidia drivers on the system, remove them first.
```
  sudo apt-get purge -y nvidia*
  sudo apt-get -y autoremove
  sudo apt-get install pkg-config
```

- Helpful [Docker Commands](https://zaiste.net/posts/removing_docker_containers/)
- [More Helpful Docker Commands](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes)
