FROM masakifujiwara1/ros1:noetic-cartographer-official

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /home
ENV HOME /home

# config setting
COPY config/.bashrc /home/.bashrc
COPY config/.vimrc /home/.vimrc
COPY config/.tmux.conf /home/.tmux.conf

CMD ["bash"]