ARG BASE_OS=nvcr.io/nvidia/cuda:12.6.3-base-ubuntu24.04
FROM ${BASE_OS}

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    locales \
    curl \
    gnupg2 \
    lsb-release \
    software-properties-common \
    git \
    vim \
    python3 \
    python3-pip \
    build-essential \
    libboost-python-dev

RUN locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN add-apt-repository universe
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get update && apt-get install -y \
    ros-jazzy-ros-base \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    ros-jazzy-usb-cam \
    ros-jazzy-nav2-common \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep init && rosdep update

WORKDIR /colcon_ws/src
RUN git clone --recurse-submodules https://github.com/grupo-avispa/depth_anything_v2_ros2.git -b main

RUN pip3 install --break-system-packages -r depth_anything_v2_ros2/requirements.txt requests

WORKDIR /colcon_ws/src/depth_anything_v2_ros2/models
RUN curl -L "https://huggingface.co/depth-anything/Depth-Anything-V2-Base/resolve/main/depth_anything_v2_vitb.pth?download=true" -o model.pth

WORKDIR /colcon_ws
RUN /bin/bash -c "apt update && source /opt/ros/jazzy/setup.bash && \
    rosdep install -i --from-path src --rosdistro jazzy -y && \
    colcon build --symlink-install"
RUN rm -rf /var/lib/apt/lists/*
RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc
RUN echo "source /colcon_ws/install/setup.bash" >> ~/.bashrc
