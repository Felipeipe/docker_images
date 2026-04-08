ARG BASE_OS=nvcr.io/nvidia/cuda:11.8.0-base-ubuntu22.04
FROM ${BASE_OS}

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y full-upgrade && \
    apt-get install -y \
        git \
        vim \
        python3 \
        python3-pip \
	libgl1 \
	libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/InternRobotics/NavDP
WORKDIR /NavDP/baselines/navdp

RUN pip3 install --upgrade pip gdown && pip3 install -r requirements.txt
RUN gdown 1n4c8UYvryHizy_22e1Z1ABUKrZVVxk7H
