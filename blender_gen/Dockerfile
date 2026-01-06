ARG BASE_OS=ubuntu:latest
FROM ${BASE_OS}
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl git dbus-x11 lxqt-core tigervnc-standalone-server openssh-server vim python3-pip blender
RUN git clone https://gitlab.univ-st-etienne.fr/labhc/dep-isi/image/blendgen.git
RUN sed -i 's/#PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "root:docker"|chpasswd
RUN echo "alias c='clear'" >> ~/.bashrc
EXPOSE 22
ENTRYPOINT service ssh restart && bash
