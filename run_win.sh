#!/bin/bash

eval "docker container run \
--network host \
-it \
--name my-noetic \
-e DISPLAY=$DISPLAY \
-e PULSE_SERVER=$PULSE_SERVER \
-e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-v $PWD/docker_share:/home/ubuntu/host_files \
--privileged \
-v /dev:/dev \
-v /run/user/1000/:/run/user/1000/ \
-v /mnt/wslg:/mnt/wslg \
--env="XAUTHORITY=$XAUTH" \
-v "$XAUTH:$XAUTH" \
--env="QT_X11_NO_MITSHM=1" \
--ipc=host \
masakifujiwara1/ros1:noetic"
