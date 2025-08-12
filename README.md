# Docker Files

This repository contains all the Dockerfiles I use.  
Each folder includes its own `Dockerfile` along with a matching `docker-compose.yml`.

## Building and Running an Image

To build and run any Docker image from this repository, open a terminal and run:

```bash
cd <directory_name>
sudo docker compose up -d --build --remove-orphans
sudo docker exec -it <container_name> bash
```
Note: The <container_name> is the same as the folder name containing the Dockerfile and compose file.

## Example: Ros Noetic image

```bash
cd ros_noetic
sudo docker compose up -d --build --remove-orphans
xhost +local:docker # enabling X11 use for the container
sudo docker exec -it ros_noetic bash
```
