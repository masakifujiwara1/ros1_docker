#!/bin/bash

eval "docker container run \
--network host \
-it \
--gpus all \
--name my-noetic \
-e DISPLAY=$DISPLAY \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-v $PWD/docker_share:/home/ubuntu/host_files \
--privileged \
-v /dev:/dev \
-v /run/user/1000/:/run/user/1000/ \
--env="XAUTHORITY=$XAUTH" \
-v "$XAUTH:$XAUTH" \
--env="QT_X11_NO_MITSHM=1" \
--ipc=host \
masakifujiwara1/ros1:noetic"
