ARG BASE_OS=ros:jazzy-ros-base
FROM ${BASE_OS}

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
RUN apt-get update && apt-get full-upgrade -y && \
    apt-get install -y --no-install-recommends \
        git wget openssh-server vim curl nano python3-pip \
        software-properties-common \
        doxygen \
        libboost-dev \
        ros-jazzy-rmw-cyclonedds-cpp \
        ros-jazzy-navigation2 \
        ros-jazzy-twist-mux \
        ros-jazzy-tf-transformations \
        ros-dev-tools \
        ros-jazzy-teleop-twist-joy \
        ros-jazzy-joy \
        ros-jazzy-joy-linux \
        ros-jazzy-v4l2-camera \
        v4l-utils \
	python3-catkin-pkg \
        ros-jazzy-vision-msgs \
        python3.12-venv
	

WORKDIR /home/bender_ws/src
RUN git clone https://github.com/reedhedges/AriaCoda.git && \
    git clone https://github.com/ruipaulorocha/rosaria2.git && \
    # Uchile dependencies
    git clone https://github.com/Felipeipe/proyecto_el5206.git

WORKDIR /home/bender_ws/src/AriaCoda
RUN make && make install && cd .. && rm -rf AriaCoda


WORKDIR /home/bender_ws/src
RUN rosdep install -i --from-paths . --rosdistro=jazzy -y


WORKDIR /home/bender_ws
RUN /bin/bash -c "source /opt/ros/jazzy/setup.bash && colcon build --symlink-install"

RUN echo "source /opt/ros/jazzy/setup.bash" >> /root/.bashrc && \
    echo "source /home/bender_ws/install/setup.bash" >> /root/.bashrc && \
    echo "alias c='clear'" >> /root/.bashrc && \
    apt clean && rm -rf /var/lib/apt/lists/*

COPY config/cyclonedds.xml /
RUN pip install ultralytics "numpy<2" --break-system-packages --ignore-installed


RUN sed -i 's/#PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "root:docker"|chpasswd

EXPOSE 22
ENTRYPOINT ["bash", "-c", "service ssh restart && exec bash"]
