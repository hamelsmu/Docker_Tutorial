#! /bin/bash

docker run -it --name container1 --net=host -v ~/docker_files/:/ds tutorial
