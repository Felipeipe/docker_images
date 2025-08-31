FROM pytorch/pytorch:2.8.0-cuda12.9-cudnn9-runtime

ARG DEBIAN_FRONTEND=noninteractive

# Dependencias de sistema mínimas
RUN apt update && apt install -y python3-pip && rm -rf /var/lib/apt/lists/*

# Instalar scikit-learn (y lo que necesites)
RUN pip install --no-cache-dir scikit-learn matplotlib seaborn numpy

# Alias opcional
RUN echo "alias c='clear'" >> ~/.bashrc
