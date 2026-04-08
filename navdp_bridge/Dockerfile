ARG BASE_OS=nvcr.io/nvidia/cuda:11.8.0-base-ubuntu24.04
FROM ${BASE_OS}

ARG DEBIAN_FRONTEND=noninteractive

# 1. Instalar dependencias básicas, herramientas y configurar el locale (requerido por ROS 2)
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
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

# 2. Configurar el repositorio de ROS 2 Jazzy
RUN add-apt-repository universe
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# 3. Instalar ROS 2 (versión base) y herramientas de desarrollo (colcon, rosdep)
RUN apt-get update && apt-get install -y \
    ros-jazzy-ros-base \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# 4. Inicializar y actualizar rosdep
RUN rosdep init && rosdep update

# 5. Clonar el repositorio e instalar dependencias de Python
WORKDIR /colcon_ws/src
RUN git clone --recurse-submodules https://github.com/grupo-avispa/depth_anything_v2_ros2.git -b main

# En Ubuntu 24.04 (Python 3.12+), pip bloquea instalaciones globales por defecto (PEP 668).
# Se añade --break-system-packages en contenedores de Docker para permitirlo, y se apunta al directorio clonado.
RUN pip3 install --break-system-packages -r depth_anything_v2_ros2/requirements.txt

# 6. Instalar dependencias de ROS (rosdep) y compilar el workspace
WORKDIR /colcon_ws
# Es necesario cargar el entorno de ROS 2 (source) antes de usar rosdep y colcon
RUN /bin/bash -c "source /opt/ros/jazzy/setup.bash && \
    rosdep install -i --from-path src --rosdistro jazzy -y && \
    colcon build --symlink-install"

# 7. Cargar el entorno automáticamente al entrar al contenedor
RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc
RUN echo "source /colcon_ws/install/setup.bash" >> ~/.bashrc
