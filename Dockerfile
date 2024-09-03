FROM osrf/ros:noetic-desktop-full

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

# setup timezone
RUN echo 'Asia/Tokyo' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apt-get update && DEBIAN_FRONTEND=noninteractive && \
    apt-get install -q -y --no-install-recommends \
        tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive && \
    apt-get install -q -y --no-install-recommends \
        locales && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US.UTF-8

# install basic packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        x11-apps \
        mesa-utils \
        curl \
        lsb-release \
        less \
        tmux \
        command-not-found \
        git \
        xsel \
        vim \
        wget \
        gnupg \
        build-essential \
        python3-dev \
        python3-pip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ENV setting
ARG USER_NAME=ubuntu
ARG GROUP_NAME=ubuntu
ARG UID=1000
ARG GID=1000
ARG PASSWORD=ubuntu
RUN groupadd -g $GID $GROUP_NAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USER_NAME && \
    echo $USER_NAME:$PASSWORD | chpasswd && \
    echo "$USER_NAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USER_NAME
WORKDIR /home/$USER_NAME
# ENV HOME /home/$USER_NAME
ENV TERM=xterm-256color

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
        ros-noetic-rqt-*  \
        ros-noetic-map-server* \
        ros-noetic-dwa* \
        python3-catkin-tools \
        && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# set catkin workspace
RUN source /opt/ros/noetic/setup.bash && mkdir -p catkin_ws/src && cd ~/catkin_ws && catkin build 

# orne-box install
RUN sudo apt-get update &&\
    cd ~/catkin_ws/src &&\
    git clone -b noetic-devel https://github.com/open-rdc/orne-box &&\
    wstool init &&\
    wstool merge orne-box/orne_box_pkgs.install &&\
    wstool up &&\
    rosdep update &&\
    rosdep install --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y &&\
    cd ~/catkin_ws &&\
    catkin build &&\
    source /opt/ros/noetic/setup.bash &&\
    source ~/catkin_ws/devel/setup.bash &&\
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# config setting
COPY config/.bashrc /home/$USER_NAME/.bashrc
COPY config/.vimrc /home/$USER_NAME/.vimrc
COPY config/.tmux.conf /home/$USER_NAME/.tmux.conf

CMD ["bash"]