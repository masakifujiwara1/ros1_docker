FROM osrf/ros:noetic-desktop-full

WORKDIR /home
ENV HOME /home

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# install vim
RUN apt-get update -qq
RUN apt-get install -y tzdata
RUN apt-get update && apt-get install -y vim git lsb-release sudo gnupg tmux curl

# install python3
# RUN apt-get install -y python3 python3-pip
# RUN python3 -m pip install --upgrade pip

# # install pytorch v1.12.1
# RUN pip3 install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113

RUN apt-get install -y ros-noetic-rqt-* 
RUN apt-get install -y python3-catkin-tools

# set catkin workspace
COPY config/git_clone.sh /home/git_clone.sh
RUN source /opt/ros/noetic/setup.bash && mkdir -p catkin_ws/src && cd ~/catkin_ws && catkin build 
# RUN cd /root/catkin_ws/src && . /home/git_clone.sh

COPY config/.bashrc /home/.bashrc
COPY config/.vimrc /home/.vimrc

# clean workspace
RUN rm -rf git_clone.sh
