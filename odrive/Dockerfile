FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG BOARD_VERSION=v3.6-56V
ENV LANG=en_US.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        wget \
        curl \
        make \
        cmake \
        ninja-build \
        python3 \
        python3-pip \
        python-is-python3 \
        gcc-arm-none-eabi \
        binutils-arm-none-eabi \
        libnewlib-arm-none-eabi \
        libstdc++-arm-none-eabi-newlib \
        libusb-1.0-0-dev \
        openocd \
        tup \
        fuse3 \
        git-lfs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Ya no instalamos cantools
RUN pip install --break-system-packages \
        jinja2 \
        pyyaml \
        jsonschema \
        matplotlib \
        odrive==0.5.4

RUN git clone https://github.com/odriverobotics/ODrive.git

WORKDIR /ODrive/Firmware

# === AQUÍ ESTÁ LA MAGIA ===
# Borramos la línea del Makefile que intenta ejecutar el script de CAN
RUN sed -i '/create_can_dbc/d' Makefile
# ==========================

# Solo preparamos config, la compilación va al CMD
RUN cp tup.config.default tup.config && \
    sed -i '/^CONFIG_BOARD_VERSION=/d' tup.config && \
    echo "CONFIG_BOARD_VERSION=${BOARD_VERSION}" >> tup.config
    # Se ejecuta al hacer docker run, no docker build

# CMD ["bash", "-c", "tup init && make -j$(nproc)"]
