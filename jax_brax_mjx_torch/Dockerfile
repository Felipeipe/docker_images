ARG BASE_OS=nvcr.io/nvidia/cuda:12.6.3-base-ubuntu24.04

FROM ${BASE_OS}

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y full-upgrade

# base dependencies
RUN apt-get update && apt-get install -y git dbus-x11 lxqt-core tigervnc-standalone-server openssh-server vim python3-pip python3-venv

# Virtual environment
RUN python3 -m venv ~/dev_env
RUN . ~/dev_env/bin/activate && pip3 install -U jax brax torch torchvision torchaudio mujoco tensorboard pytorch-kinematics pyyaml

# authorize SSH connection with root account
RUN sed -i 's/#PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo "root:docker"|chpasswd

EXPOSE 22

ENTRYPOINT service ssh restart && bash
