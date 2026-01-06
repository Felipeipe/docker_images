ARG BASE_OS=ubuntu:latest

FROM ${BASE_OS}

ARG DEBIAN_FRONTEND=noninteractive


# base dependencies
RUN apt-get update && apt-get install -y curl git dbus-x11 lxqt-core tigervnc-standalone-server openssh-server vim python3-pip 
RUN curl -L https://mirrors.ocf.berkeley.edu/blender/release/Blender5.0/blender-5.0.1-linux-x64.tar.xz -o /tmp/blender.tar.xz && \
    tar -xvf /tmp/blender.tar.xz -C /usr/local/ && \
    mv /usr/local/blender-5.0.1-linux-x64 /usr/local/blender && \
    rm /tmp/blender.tar.xz

ENV PATH="/usr/local/blender:$PATH"

RUN git clone https://gitlab.univ-st-etienne.fr/labhc/dep-isi/image/blendgen.git
# RUN pip install numpy --break-system-packages

RUN sed -i 's/#PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo "root:docker"|chpasswd
RUN echo "alias c='clear'" >> ~/.bashrc

EXPOSE 22

ENTRYPOINT service ssh restart && bash
