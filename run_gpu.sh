#!/bin/bash

eval "docker container run --network host --gpus all -it --name my-noetic-cartographer-rdc -e DISPLAY=$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v $PWD/docker_share:/home/host_files --privileged -v /dev:/dev masakifujiwara1/ros1:noetic-cartographer-rdc"
