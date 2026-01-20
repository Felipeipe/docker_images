ARG BASE_OS=ubuntu:latest
FROM ${BASE_OS}
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl git dbus-x11 lxqt-core tigervnc-standalone-server openssh-server vim python3-pip

RUN curl https://mirrors.ocf.berkeley.edu/blender/release/Blender5.0/blender-5.0.1-linux-x64.tar.xz -o blender.tar.xz && \
    mkdir -p /opt/blender && \
    tar -Jxf blender.tar.xz -C /opt/blender

RUN /opt/blender/blender-5.0.1-linux-x64/5.0/python/bin/python3.11 -m pip install pyyaml numpy --break-system-packages
RUN sed -i 's/#PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "root:docker"|chpasswd
RUN echo "alias c='clear'" >> ~/.bashrc
RUN echo "alias blender='/opt/blender/blender-5.0.1-linux-x64/blender'" >> ~/.bashrc
EXPOSE 22
ENTRYPOINT service ssh restart && bash
