ARG BASE_OS=nvidia/cuda:12.5.1-cudnn-devel-ubuntu22.04

FROM ${BASE_OS}

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git \
    dbus-x11 \
    lxqt-core \
    tigervnc-standalone-server \
    openssh-server \
    vim \
    python3-pip \
    python3-venv \
    libx11-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev \
    mesa-common-dev

RUN python3 -m venv ~/dev_env

RUN . ~/dev_env/bin/activate && \
    pip install \
        "cmake>=3.31.0" \
        "jax[cuda12]<0.6.0" \
        "mujoco>=3.2.7" \
        "mujoco_mjx>=3.2.7" \
        warp-lang && \
    git clone https://github.com/shacklettbp/madrona_mjx.git && \
    cd madrona_mjx && \
    git submodule update --init --recursive && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j && \
    cd .. && \
    pip install -e .



RUN sed -i 's/#PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "root:docker"|chpasswd
RUN echo "alias c='clear'" >> ~/.bashrc

EXPOSE 22

ENTRYPOINT service ssh restart && bash
