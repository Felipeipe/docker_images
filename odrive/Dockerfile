FROM ubuntu:22.04

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
        libusb-1.0-0-dev \
        openocd \
        tup \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install \
        jinja2 \
        pyyaml \
        jsonschema \
        matplotlib \
        odrive==0.5.4

WORKDIR /odrive

RUN git clone --recursive --branch fw-v0.5.4 \
        https://github.com/odriverobotics/ODrive.git .

WORKDIR /odrive/Firmware

# Solo preparamos config, la compilación va al CMD
RUN cp tup.config.default tup.config && \
    sed -i '/^CONFIG_BOARD_VERSION=/d' tup.config && \
    echo "CONFIG_BOARD_VERSION=${BOARD_VERSION}" >> tup.config
    # Se ejecuta al hacer docker run, no docker build

# CMD ["bash", "-c", "tup init && make -j$(nproc)"]
