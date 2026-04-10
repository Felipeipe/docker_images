ARG BASE_OS=jax_brax_mjx:latest
FROM ${BASE_OS}
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y ffmpeg
RUN . ~/dev_env/bin/activate && pip install noisereduce numpy scipy

