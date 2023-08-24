FROM masakifujiwara1/noetic-cartographer:latest

WORKDIR /home
ENV HOME /home

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# set catkin workspace
# COPY config/git_clone.sh /home/git_clone.sh
# RUN source /opt/ros/noetic/setup.bash && mkdir -p catkin_ws/src && cd ~/catkin_ws && catkin build 
# RUN cd ~/catkin_ws/src && . /home/git_clone.sh

COPY config/.bashrc /home/.bashrc
COPY config/.vimrc /home/.vimrc

# clean workspace
# RUN rm -rf git_clone.sh
